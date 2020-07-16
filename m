Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F638C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC10207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0IJN0M0O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vV2mLSuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgGPUWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD7C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:22:10 -0700 (PDT)
Message-Id: <20200716201923.228696399@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594930929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=B2z75b9EVAFdPiAkFYGJ2QvpOBVmIkm00c1ZqJcTUIw=;
        b=0IJN0M0O1MtNeuRYOJKOp7hDmFApvmvbLSRPfNNXnvX35YYgdy80oqIi19GnepXpbFtmoG
        AnCKcJ508ImoOxQBtR+8Bw6tT11Xjez8f2SvC4QZpKrY4e7vOKbaHSc6yKEUHEjG54MUPB
        R83xbIk4IBHClM228LQ/dHc7hRqQZ4j7I6ncwDZaw1c4IZ4FjnsO9sOkTWuJBK89VgQ1qZ
        VR0vmXH36UvFwt5+zEQljf9/GwIkjSt0RAzPksWz7Io23rdQLTU7b/skMTTtP3C//z4Jnp
        iQuG4TPS7LIX24qOOqX54qkPIR/c8ACSX+rIusqiXV3ykupp5tHpqJXYLsBYCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594930929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=B2z75b9EVAFdPiAkFYGJ2QvpOBVmIkm00c1ZqJcTUIw=;
        b=vV2mLSuWmGOg55yi8Tcdy0CjDVlmui8kVF1dkCDAi4Cy58LsTXaFHTPu/OfmsvBZxzL0G5
        5+MtMJlP17a5/TAw==
Date:   Thu, 16 Jul 2020 22:19:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 0/5] posix-cpu-timers: Move expiry into task work context
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second attempt of moving the posix CPU timer heavy lifting out
of interrupt context. The initial version can be found here:

   https://lore.kernel.org/r/20190801143250.370326052@linutronix.de

Running posix cpu timers in hard interrupt context has a few downsides:

 - For PREEMPT_RT it cannot work as the expiry code needs to take sighand
   lock, which is a 'sleeping spinlock' in RT

 - For fine grained accounting it's just wrong to run this in context of
   the timer interrupt because that way a process specific cpu time is
   accounted to the timer interrupt.

 - Long running timer interrupts caused by a large amount of expiring
   timers which can be created and armed by unpriviledged user space.

There is no real hard requirement to run the expiry code in hard interrupt
context. The posix CPU timers are an approximation anyway, so having them
expired and evaluated in task work context does not really make them worse.

This version is more or less a resend of the posix CPU timer bits of
V1. The back then observed issue that KVM does not handle pending task work
before going into guest mode has been solved differently. The related
patches have been posted here:

  https://lore.kernel.org/r/20200716182208.180916541@linutronix.de

This patch series has no code dependency on the entry/KVM work, but the
functional dependency vs. KVM exists.

It applies on mainline and passes all tests - except when KVM is active and
timers are armed on the KVM threads. This particular issue is solved when
the entry/KVM series is applied as well.

The entry/KVM changes are available from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

and the whole lot (entry/kvm + posix CPU timers) is available from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posixtimer

Thanks,

	tglx

----
 b/arch/x86/Kconfig             |    1 
 include/linux/posix-timers.h   |   33 ++++--
 include/linux/sched/cputime.h  |    2 
 kernel/time/Kconfig            |    5 
 kernel/time/posix-cpu-timers.c |  213 ++++++++++++++++++++++++++++++-----------
 5 files changed, 192 insertions(+), 62 deletions(-)


