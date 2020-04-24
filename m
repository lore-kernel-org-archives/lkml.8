Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B91C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AC520736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDXN2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXN2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:28:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91E8205C9;
        Fri, 24 Apr 2020 13:28:17 +0000 (UTC)
Date:   Fri, 24 Apr 2020 09:28:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200424092816.62a61b1d@gandalf.local.home>
In-Reply-To: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 11:42:39 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Since dump_tasks() is capable of generating thousands of printk() lines,
> it can significantly delay solving OOM situation by killing a process
> via the OOM killer. There is /proc/sys/vm/oom_dump_tasks which allows
> suppressing dump_tasks(), but those who diagnose the reason of OOM need
> dump_tasks() in order to understand memory usage as of invocation of the
> OOM killer. Therefore, setting /proc/sys/vm/oom_dump_tasks to 0 cannot be
> an option. Also, since userspace syslog daemon is likely configured not
> to save low (e.g. KERN_DEBUG) loglevels, reducing loglevel used by
> dump_tasks() cannot be an option. We want to maintain current loglevels
> in order to allow saving kernel messages to log files while we also want
> to avoid delays caused by printing to consoles due to maintaining current
> loglevels.
> 
> While an attempt to make printk() asynchronous (i.e. defer printing to
> consoles) and an attempt to make printk() to print to only selected
> consoles (i.e. don't print unimportant messages to slow consoles) are
> in progress, there are printk() callers where saving to log files is
> useful for later analysis but printing to consoles for immediate
> notification makes little sense. Two examples of such printk() callers
> will be the OOM killer and memory allocation failure messages. Therefore,
> this patch introduces a loglevel KERN_NO_CONSOLES which prevents all
> consoles from printing such messages.
> 
> Since both KERN_NO_CONSOLES messages and !KERN_NO_CONSOLES messages are
> stored into common printk buffer, KERN_NO_CONSOLES messages will be
> retrievable from the vmcore file even if something bad (e.g. NULL pointer
> dereference) followed. Therefore, as long as a system is configured for
> later analysis, ability to suppress printing to consoles will be useful.
> Since Dmitry Safonov is working on adding loglevel argument to
> show_stack(), we will in near future be able to control whether
> dump_stack() output is important enough to immediately print to consoles,
> by adding loglevel argument to dump_stack().
> 


Please no.

What I would suggest doing is create your own buffer to store the output.
Then use the seq_buf() operations and such to print to that buffer, and
then be able to read that output from something like a debug filesystem, or
some user space daemon that will write to syslog.

I do not want 'silent' writes to the printk buffer. It's bad enough that it
gets blown away by systemd.

-- Steve
