Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA22C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555CC20714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEKXab convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgEKXab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:30:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FB8206CC;
        Mon, 11 May 2020 23:30:30 +0000 (UTC)
Date:   Mon, 11 May 2020 19:30:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: ftrace: function radeon_init not traceable
Message-ID: <20200511193028.3551d838@oasis.local.home>
In-Reply-To: <d38aacb6-58ef-b1e5-431b-c945380d20cc@molgen.mpg.de>
References: <01e29852-c9db-8181-e4fa-dda50f774cf6@molgen.mpg.de>
        <20200511145812.7206b095@gandalf.local.home>
        <d38aacb6-58ef-b1e5-431b-c945380d20cc@molgen.mpg.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 01:07:44 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> >>
> >>       initcall_debug log_buf_len=32M trace_buf_size=57074K trace_clock=global trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time ftrace=function_graph ftrace_graph_max_depth=1 ftrace_graph_filter=radeon_init
> >>
> >> But ftrace “rejects” that:
> >>
> >>       [    0.075538] ftrace: allocating 30958 entries in 61 pages
> >>       [    0.084542] ftrace: allocated 61 pages with 5 groups
> >>       [    0.094184] ftrace: function radeon_init not traceable
> >>
> >> I believe it worked in the past. Is there a way to trace that init function?  
> > 
> > Did it every work for modules? radeon_init() isn't in the symbol table at
> > boot up.
> > 
> > [   15.066951] systemd-journald[124]: Successfully sent stream file descriptor to service manager.
> > [   15.098265] hub 1-0:1.0: USB hub found
> > [   15.104006] systemd-journald[124]: Successfully sent stream file descriptor to service manager.
> > [   15.112965] hub 1-0:1.0: 2 ports detected
> > [   15.118116] probe of 1-0:1.0 returned 1 after 19873 usecs
> > [   15.124007] calling  radeon_init+0x0/0x1000 [radeon] @ 133
> > 
> > The radeon_init is called after systemd is running, so it is definitely
> > from a module.
> > 
> > Perhaps you had it built in before?  
> 
> You are right. Probably I did. Can you suggest how to set up ftrace to 
> trace a module?

In recent kernels there was a feature to function trace modules before
they are loaded, but that feature isn't yet available on mainline. I
could add it when I get a chance, but that wont be in the near future.

Also, the function graph wont work for that either, as that isn't set
up to preload before functions. But since you have
ftrace_graph_max_depth of one, you don't need the graph, the limiting
of the function (set_ftrace_filter) is good enough. But again, that
only works after boot up.

> > 
> > Probably because the filtering failed, so there is no filter.  
> 
> Is that the intended behavior? Or should nothing be traced?

Well, it's just like writing something not acceptable in the filter
functions. If it fails, it does not filter. So yes, it is expected
behavior.

-- Steve
