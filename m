Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6DA2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgEVQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgEVQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:40:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F037BC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:40:14 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcAiS-0000uq-DY; Fri, 22 May 2020 18:40:12 +0200
Date:   Fri, 22 May 2020 18:40:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200522164012.ynyvrjompv42jtmx@linutronix.de>
References: <87bln7ves7.fsf@gmx.net>
 <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
 <87v9l65d2y.fsf@gmx.net>
 <20200513220428.4nksinis2qs5dtmh@linutronix.de>
 <87mu6aurfn.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mu6aurfn.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.

On 2020-05-14 23:39:40 [+0200], Stephen Berman wrote:
> >> How will I know if that happens, is there a specific message in the tty?
> >
> > On the tty console where you see the "timing out command, waited"
> > message, there should be something starting with
> > |BUG: workqueue lockup - pool
> >
> > following with the pool information that got stuck. That code checks the
> > workqueues every 30secs by default. So if you waited >= 60secs then
> > system is not detecting a stall.
> 
> As you can see in the photo, there was no message about a workqueue
> lockup, only "task halt:5320 blocked for more than <XXX> seconds" every
> two minutes.  I suppose that comes from one of the other options I
> enabled.  Does it reveal anything about the problem?

From the picture, you are on your way to level 0, which would issue the
final shutdown command, but you are not quite there yet.

If you add a printk() to the reboot syscall, then I wouldn't expect you
to see it. (something like that):

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b42..19bc35bc0cda0 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -314,6 +314,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	char buffer[256];
 	int ret = 0;
 
+	pr_err("%s(%d)CMD: %lx\n", __func__, __LINE__, cmd);
 	/* We only trust the superuser with rebooting the system. */
 	if (!ns_capable(pid_ns->user_ns, CAP_SYS_BOOT))
 		return -EPERM;

If you add "ignore_loglevel initcall_debug" to the command line then you
should see the init callbacks of each driver. But there will be nothing
on your shutdown (as I expect it).

The "task X blocked for more than 120 secs" is part of the hung task
detector. With the "ignore_loglevel" above you should be able to see the
callchain of the task. I suspect that the task poked the cd-drive which
isn't answering. So from detector's point of view, the task issued a
system call which appears to hang an makes no progress.

> > Could
> > you please check if the stall-dector says something?
> 
> Is that the message I repeated above or do you mean the workqueue?

The hung message is not workqueue related. It is the task `halt' that
makes no progress. There is not stall of the workqueue as far as the
system can tell. 
The two boot options, I suggested above, may reveal additional
information that are printed but suppressed due to the loglevel.

My guess now is that maybe shutting down wifi also paused the AHCI
controller which makes no progress now. So booting without cdrom/disk
should not cause any problems.

Could you please:
- try booting with "ignore_loglevel initcall_debug" and see if
  additional information is printed on the console.

- Remove cd / ATA-disk to check if anything else causes a stall. As by
  your report you only mentioned those two (and if I see it correctly,
  you rootFS is on nvme so removing the disk might be doable).

- Could you remove the Wifi (just the driver, no the physical hw) to see
  if it makes any difference?

> Steve Berman

Sebastian
