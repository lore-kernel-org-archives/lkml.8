Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41861C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A4120767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgDXPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgDXPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:42:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB46920706;
        Fri, 24 Apr 2020 15:42:26 +0000 (UTC)
Date:   Fri, 24 Apr 2020 11:42:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200424114225.5a3bab7e@gandalf.local.home>
In-Reply-To: <7ec0b0a3-39ae-0f1c-b8c2-e1e9e60f1223@i-love.sakura.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <20200424092816.62a61b1d@gandalf.local.home>
        <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
        <20200424103131.7987f890@gandalf.local.home>
        <7ec0b0a3-39ae-0f1c-b8c2-e1e9e60f1223@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 00:28:53 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2020/04/24 23:31, Steven Rostedt wrote:
> > On Fri, 24 Apr 2020 23:00:01 +0900
> > Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >   
> >> Since KERN_NO_CONSOLES is for -ENOMEM situations (GFP_KERNEL allocation which
> >> can sleep needs to invoke the OOM killer, or GFP_ATOMIC allocation which cannot
> >> sleep has failed), we can't create buffer on demand. For process context, it
> >> would be possible to create buffer upon fork() time. But for atomic context,
> >> it is so difficult to create buffer on demand. We could allocate shared buffer
> >> like logbuf but it means that we have to replicate what printk() is doing (too
> >> much code), for when atomic memory allocation happens resembles when printk()
> >> is called. Borrowing printk()'s logbuf is simpler.  
> > 
> > I would have a buffer allocated for this at start up.  
> 
> Allocating global buffer itself is simple (except that it might waste a lot of
> memory). Difficult part is how to use the buffer.

I agree with Michal that this really should be a user setting (something on
the command line or sysctl - allocation at the time of decision).

> 
> > 
> > What exactly would you be "replicating" in printk?  
> 
> Making it possible to store into global buffer from almost any context (not only
> process context but also softirq/hardirq/NMI context (well, is memory allocation
>  from NMI context not permitted? I don't know... but future KERN_NO_CONSOLES
> users might want to call from NMI context)), notify userspace program of data
> readiness, and manage the buffer.

printk() was not safe in NMI context up until very recently.

You can also use the tracing ring buffer for this, as it has been safe in
all these contexts for a very long time. And that ring buffer is something
that you can use outside of tracing (oprofile uses it).


> 
> KERN_NO_CONSOLES does not need to call call_console_drivers(). But basically
> things what printk() is doing.
> 
> >                                                    The point of printk is
> > to print to a console, not to be a generic ring buffer. This change is
> > breaking printk's most useful feature.  
> 
> For those who analyze log files (instead of console output), the point of
> printk() is to save kernel messages into log files (via userspace syslog
> daemon).
> 
> By the way, I think
> 
>   printk(KERN_NO_CONSOLES "hello\n")
> 
> is almost same with doing
> 
>   saved_loglevel = console_loglevel;
>   console_loglevel = CONSOLE_LOGLEVEL_SILENT;
>   printk("hello\n");
>   console_loglevel = saved_loglevel;
> 
> used by vkdb_printf().

And both shouldn't be done within the kernel. The "CONSOLE_LOGLEVEL_SILENT"
if for user decided policy, not the kernel making that policy for the user.

-- Steve
