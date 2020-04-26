Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2176BC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FD32071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587934531;
	bh=VJHXeugh1nAiRtbmY8jzPcFMwDfoWlm6nzLm9OEyQgY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=moo0/tWmhoaediacybmJ00a/1egH9FJdNJTexwZWfSqTc536xDKEeLgKVV8ifB39h
	 vwD4B/vyhovKOsC1pzyi3K75kyTpBz7tJopEKhxxIIk3ZtMfTiyEi/wNzF7O8Qoply
	 qRdUcR6lRuzD5873ZiWZ4BZed3MINzHeglb4EJl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDZUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDZUz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:55:29 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78212070A;
        Sun, 26 Apr 2020 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587934529;
        bh=VJHXeugh1nAiRtbmY8jzPcFMwDfoWlm6nzLm9OEyQgY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g1AUu5Qyv3diummDl72l9tHEK/TclBhF1s4W+BL0A9qUhVbkicIKKswEgrMXnLdBv
         KcDyPiq62Ovgo5/OyEfHPqib1cUlOCBHKKD+lVFxwwkxUykD9C0etkVB4OyQxNT8Q0
         kaQuJf8jf7D888y/dXTS6pALr53zzCvNCbB/4Sik=
Message-ID: <6346950cfc8eb0a6ca76e3b742f913f6561b0feb.camel@kernel.org>
Subject: Re: [PATCH 2/3] tracing/boottime: Fix kprobe event API usage
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Sun, 26 Apr 2020 15:55:26 -0500
In-Reply-To: <158779375766.6082.201939936008972838.stgit@devnote2>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
         <158779375766.6082.201939936008972838.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sat, 2020-04-25 at 14:49 +0900, Masami Hiramatsu wrote:
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
>   trace_boot: Failed to add probe: p:kprobes/myevent (null)  vfs_read
> $arg1 $arg2  vfs_write $arg1 $arg2
> 
> This shows the 1st argument becomes NULL and multiprobes
> are merged to 1 probe.
> 
> Fixes: 29a154810546 ("tracing: Change trace_boot to use kprobe_event
> interface")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org

Thanks for fixing this!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> ---
>  kernel/trace/trace_boot.c |   20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 06d7feb5255f..9de29bb45a27 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -95,24 +95,20 @@ trace_boot_add_kprobe_event(struct xbc_node
> *node, const char *event)
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
> 

