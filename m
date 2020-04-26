Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DFC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467702071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587887950;
	bh=y9FgHTeNdxHCeuBkRz6TWg/qgsYqpnn0Se5wDCZAW+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PM/3ZpUHkk7eImQ+R+UQSnvZDrnmJ01WJHCIVpcEuxYWq1yPi87/0dBXDOS0hr5N8
	 eu/+I/1EIwaIsH09g15rBxlVdHkhPmB4/9lOqj+CA0sk00qGQlLOpwM4tgA4vfjo07
	 xPfkcbbRyIhjzx9fGY5uisHAUVAW3bAB/1GABbeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDZH7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 03:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZH7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:59:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCA420700;
        Sun, 26 Apr 2020 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587887948;
        bh=y9FgHTeNdxHCeuBkRz6TWg/qgsYqpnn0Se5wDCZAW+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gWK8dU/4mGE2822t/uoV80yMr3j8AioCZBkM+Ixm7LrIehz7kgsf5AOYG91EuTV23
         6OmHBqYNGMyYeWSL3ehlWtmB/h7pzM1503c1Sn9ziFFgtsuAekRJHndMe13z6us2Pm
         0S7pGhJ2VKoPG9JKwNpc5fG17BeuVu8ouK0P5ggo=
Date:   Sun, 26 Apr 2020 16:59:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] tracing/boottime: Fix kprobe event API usage
Message-Id: <20200426165904.a54e6942643f01fd9a1950c3@kernel.org>
In-Reply-To: <20200425100020.3ccaa586@oasis.local.home>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
        <158779375766.6082.201939936008972838.stgit@devnote2>
        <20200425100020.3ccaa586@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 10:00:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 25 Apr 2020 14:49:17 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix boottime kprobe events to use API correctly for
> > multiple events.
> > 
> > For example, when we set a multiprobe kprobe events in
> > bootconfig like below,
> > 
> >   ftrace.event.kprobes.myevent {
> >   	probes = "vfs_read $arg1 $arg2", "vfs_write $arg1 $arg2"
> >   }
> > 
> > This cause an error;
> > 
> >   trace_boot: Failed to add probe: p:kprobes/myevent (null)  vfs_read $arg1 $arg2  vfs_write $arg1 $arg2
> > 
> > This shows the 1st argument becomes NULL and multiprobes
> > are merged to 1 probe.
> > 
> > Fixes: 29a154810546 ("tracing: Change trace_boot to use kprobe_event interface")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  kernel/trace/trace_boot.c |   20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> > index 06d7feb5255f..9de29bb45a27 100644
> > --- a/kernel/trace/trace_boot.c
> > +++ b/kernel/trace/trace_boot.c
> > @@ -95,24 +95,20 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
> >  	struct xbc_node *anode;
> >  	char buf[MAX_BUF_LEN];
> >  	const char *val;
> > -	int ret;
> > +	int ret = 0;
> >  
> > -	kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
> > +	xbc_node_for_each_array_value(node, "probes", anode, val) {
> > +		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
> >  
> > -	ret = kprobe_event_gen_cmd_start(&cmd, event, NULL);
> > -	if (ret)
> > -		return ret;
> > +		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
> > +		if (ret)
> > +			break;
> 
> Should we break here? What about just printing an error message and
> continuing to the next probe. If I start up something with a typo in
> the first element, I lose all events. But if I have a typo in the last
> one, I get all but that one. I rather have it just fail on the ones that
> don't parse properly.

This kprobe_event_gen_cmd_start() causes an error only if there is
a program bug or out of memory, because it never evaluate given probe
definition, but kprobe_event_gen_cmd_end() does. Thus I think this is
correct way to handle the error.

IOW, if you typo a probe, it will be handled by
kprobe_event_gen_cmd_end() and it shows an error message and continue
to process other probe definitions. See below,

> > -	xbc_node_for_each_array_value(node, "probes", anode, val) {
> > -		ret = kprobe_event_add_field(&cmd, val);
> > +		ret = kprobe_event_gen_cmd_end(&cmd);
> >  		if (ret)
> > -			return ret;
> > +			pr_err("Failed to add probe: %s\n", buf);
> >  	}

This continues to next probe ;-)

Thank you,

> >  
> > -	ret = kprobe_event_gen_cmd_end(&cmd);
> > -	if (ret)
> > -		pr_err("Failed to add probe: %s\n", buf);
> > -
> >  	return ret;
> >  }
> >  #else
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
