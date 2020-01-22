Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C849FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F7424655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579666769;
	bh=epk737smItfyJaeoaZPbpOgtMyNVfwW4iE271OxfH1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Shoe3HK3sycSnNvaGEMaUVDzKgoS9Z2YJT9oQhsixMjDRHTCya//v/EjmOkZfDlQ1
	 c8oAeaxby9F4e7jCfLw1hTseCAvJrcp5KfSMIhBTzJZgK+4FrxQcMwgTWdGUEgG3mC
	 a2HUqM4ipgWfZOUeFgMuwGvngpPcq839BrLmqjqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAVET2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgAVET2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:19:28 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A9D21835;
        Wed, 22 Jan 2020 04:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579666767;
        bh=epk737smItfyJaeoaZPbpOgtMyNVfwW4iE271OxfH1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WXXa0uE2wgs19Ih5i4ui6gBi3Bp576npoZZHfYgZ1zYsM/Z+bm1vy08NzKmCA8Ldn
         5ZVSnd8d4h3CsqjcU6/jbPaBRhxqv0MTYmd8YIM6v13k5CaDHCQ7VadqFbPQC6FPGW
         x2RQaCNNM2YE/9dsT0xkylCQtwBy9GNcVoYrEXXY=
Date:   Wed, 22 Jan 2020 13:19:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/kprobe: remove MAX_KPROBE_CMDLINE_SIZE
Message-Id: <20200122131924.49b01587a8ed5149d44f3a94@kernel.org>
In-Reply-To: <20200121183438.635b0ff7@gandalf.local.home>
References: <1579586075-45132-1-git-send-email-alex.shi@linux.alibaba.com>
        <20200121183438.635b0ff7@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 18:34:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami,
> 
> With your new bootconfig work, will you be utilizing
> MAX_KPROBE_CMDLINE_SIZE, or should it be removed?

Good catch! Yes, please remove it.
I think I have forgot to remove it when I switched
to COMMAND_LINE_SIZE while writing the code.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> -- Steve
> 
> 
> On Tue, 21 Jan 2020 13:54:35 +0800
> Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
> > This limitation are never lunched from introduce commit 970988e19eb0
> > ("tracing/kprobe: Add kprobe_event= boot parameter")
> > 
> > Could we remove it if no intention to implement it?
> > 
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org> 
> > Cc: Ingo Molnar <mingo@redhat.com> 
> > Cc: linux-kernel@vger.kernel.org 
> > ---
> >  kernel/trace/trace_kprobe.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 7f890262c8a3..eafa90d0f760 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -22,7 +22,6 @@
> >  
> >  #define KPROBE_EVENT_SYSTEM "kprobes"
> >  #define KRETPROBE_MAXACTIVE_MAX 4096
> > -#define MAX_KPROBE_CMDLINE_SIZE 1024
> >  
> >  /* Kprobe early definition from command line */
> >  static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
