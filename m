Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306FC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CE120714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDYOAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:00:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9575820714;
        Sat, 25 Apr 2020 14:00:22 +0000 (UTC)
Date:   Sat, 25 Apr 2020 10:00:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] tracing/boottime: Fix kprobe event API usage
Message-ID: <20200425100020.3ccaa586@oasis.local.home>
In-Reply-To: <158779375766.6082.201939936008972838.stgit@devnote2>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
        <158779375766.6082.201939936008972838.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 14:49:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix boottime kprobe events to use API correctly for
> multiple events.
> 
> For example, when we set a multiprobe kprobe events in
> bootconfig like below,
> 
>   ftrace.event.kprobes.myevent {
>   	probes = "vfs_read $arg1 $arg2", "vfs_write $arg1 $arg2"
>   }
> 
> This cause an error;
> 
>   trace_boot: Failed to add probe: p:kprobes/myevent (null)  vfs_read $arg1 $arg2  vfs_write $arg1 $arg2
> 
> This shows the 1st argument becomes NULL and multiprobes
> are merged to 1 probe.
> 
> Fixes: 29a154810546 ("tracing: Change trace_boot to use kprobe_event interface")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  kernel/trace/trace_boot.c |   20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 06d7feb5255f..9de29bb45a27 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -95,24 +95,20 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
>  	struct xbc_node *anode;
>  	char buf[MAX_BUF_LEN];
>  	const char *val;
> -	int ret;
> +	int ret = 0;
>  
> -	kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
> +	xbc_node_for_each_array_value(node, "probes", anode, val) {
> +		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
>  
> -	ret = kprobe_event_gen_cmd_start(&cmd, event, NULL);
> -	if (ret)
> -		return ret;
> +		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
> +		if (ret)
> +			break;

Should we break here? What about just printing an error message and
continuing to the next probe. If I start up something with a typo in
the first element, I lose all events. But if I have a typo in the last
one, I get all but that one. I rather have it just fail on the ones that
don't parse properly.

-- Steve


>  
> -	xbc_node_for_each_array_value(node, "probes", anode, val) {
> -		ret = kprobe_event_add_field(&cmd, val);
> +		ret = kprobe_event_gen_cmd_end(&cmd);
>  		if (ret)
> -			return ret;
> +			pr_err("Failed to add probe: %s\n", buf);
>  	}
>  
> -	ret = kprobe_event_gen_cmd_end(&cmd);
> -	if (ret)
> -		pr_err("Failed to add probe: %s\n", buf);
> -
>  	return ret;
>  }
>  #else

