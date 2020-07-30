Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A4CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902C320838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xNpjJZVK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XC80Y8uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgG3MOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgG3MOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:14:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B456C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:14:48 -0700 (PDT)
Message-Id: <20200730101404.956367860@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596111286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=D0Liopx+HkCwUDJQOjOlS1OaTwAKKymChyHeiBxXa2E=;
        b=xNpjJZVKV+sQQI0BHHnY8OiaadYJFiP/3ZE3CrC8lfVkPNnMcS9h1trTpcg10qz3HEF4D7
        Xa5HICJ0JYZvKYKhk+lx/+2FRy66oCALYk4EFXSN7eArMowbOpH5CYNRhVdd8+HPJh+G/8
        Tl+sCcAKLEMgcHh/OG0e90wzDgDXCWeNKcW0gfK2D1SPcnDQDhEoUKWmPjSWi8VWbdkQ46
        CdPSMvCYGbPfugb+CHnUz3Wbw+WdbfrwElkSoKvZ352gXtri8sqD7eQ2YgB5yQ1+bAcKmU
        DA8UpWlQBSgcy7+pSxljoV+S5cWm2ivsvBxGmRC0/7ANNHN/4ydG9uFp/uwiFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596111286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=D0Liopx+HkCwUDJQOjOlS1OaTwAKKymChyHeiBxXa2E=;
        b=XC80Y8uzoi63ZbFiDmwbJHpwXJLJVLJS1uD9XnUj2BzDLIsk14C0W3z7xfKz9NeWPw8wsq
        iw6zOQPEwoIc/DAQ==
Date:   Thu, 30 Jul 2020 12:14:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V3 0/3] posix-cpu-timers: Move expiry into task work context
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd installment of the series to move posix timer expiry heavy
lifting out of hard interrupt context.

Running posix CPU timers in hard interrupt context has a few downsides:

 - For PREEMPT_RT it cannot work as the expiry code needs to take
   sighand lock, which is a 'sleeping spinlock' in RT. The original RT
   approach of offloading the posix CPU timer handling into a high
   priority thread was clumsy and provided no real benefit in general.

 - For fine grained accounting it's just wrong to run this in context of
   the timer interrupt because that way a process specific cpu time is
   accounted to the timer interrupt.

 - Long running timer interrupts caused by a large amount of expiring
   timers which can be created and armed by unpriviledged user space.

There is no hard requirement to expire them in interrupt context.

If the signal is targeted at the task itself then it won't be delivered
before the task returns to user space anyway. If the signal is targeted at
a supervisor process then it might be slightly delayed, but posix CPU
timers are inaccurate anyway due to the fact that they are tied to the
tick.

This series has no code dependency on the entry/KVM work, but a functional
dependency vs. KVM handling task work before going into guest mode exists.
It applies on mainline and passes all tests - except when KVM is active and
timers are armed on the KVM threads. This particular issue is solved when
the entry changes are applied as well. See below.

The previous version can be found here:

    https://lore.kernel.org/r/20200716201923.228696399@linutronix.de

The changes versus V2 are:

    - Address the ordering issues vs. RT (Peter)
    - Move task work head into task struct (Oleg)
    - Drop the last patch which is an optimization and needs more thought
      now with the reworked state handling.

The series is standalone except for the fact that KVM does not handle task
work before entering a guest. The necessary changes for this are in

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

and the whole lot (entry + posix CPU timers) is available from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posixtimer

Thanks,

	tglx

---
 arch/x86/Kconfig               |    1 
 include/linux/posix-timers.h   |   17 +++
 include/linux/sched.h          |    4 
 include/linux/seccomp.h        |    3 
 kernel/entry/common.c          |    4 
 kernel/time/Kconfig            |    9 +
 kernel/time/posix-cpu-timers.c |  216 ++++++++++++++++++++++++++++++++++++-----
 kernel/time/timer.c            |    1 
 8 files changed, 227 insertions(+), 28 deletions(-)
