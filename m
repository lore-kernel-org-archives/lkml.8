Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5685AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372FD2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jmh+gtf1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+DXDQ9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHNQAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:00:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37650 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgHNQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:00:37 -0400
Date:   Fri, 14 Aug 2020 15:58:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597420836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EMPs/PvYVJgrnmX98HVBLfbY4t2hkcS94MuFWFMelYQ=;
        b=jmh+gtf1BBBuOfMI4PxLvKzeizDVAqEZj8qUHKTv873dPEzhfnv9pZgzaMM1otWhS59P7d
        L+PlqiBEyllD9d1fQ8w7WrftBbMO0F0/a11OKi3hkRQ6e0gZ6WXDpb06UuOr1YTJehjASV
        Atju/VlIa42kndRKuDIrwfhwYZ/mKfOiDGxkoZ9gk/470LCV1GX4yXc64NdL/jrm5U61Lr
        88LHCp7Q05oBvg/JOCI8h5TwtlnH5/NbDfQMDaqyXzH1iFi+FwSK6nTElkn9X3m/AYZ0A7
        0BPA5cxaGIAHyQWZHMduquBH7JFMPEL91a27fZN4K4a28C4JOfh1v1hsZgo0Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597420836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EMPs/PvYVJgrnmX98HVBLfbY4t2hkcS94MuFWFMelYQ=;
        b=L+DXDQ9KZTrqts+sR7wU8na61kyDO4eyzmFKVdLSq6lCe6mbs2wRT7EPjghuaturP+uAnk
        zQJ/hWaa9HuxaSBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.9-rc1
References: <159742071192.30851.2328227964586183297.tglx@nanos>
Message-ID: <159742071312.30851.9658771452402261764.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-08-14

up to:  0099808553ad: x86: Select POSIX_CPU_TIMERS_TASK_WORK

A set of posix CPU timer changes which allows to defer the heavy work of
posix CPU timers into task work context. The tick interrupt is reduced to a
quick check which queues the work which is doing the heavy lifting before
returning to user space or going back to guest mode. Moving this out is
deferring the signal delivery slightly but posix CPU timers are inaccurate
by nature as they depend on the tick so there is no real damage. The
relevant test cases all passed.

This lifts the last offender for RT out of the hard interrupt context tick
handler, but it also has the general benefit that the actual heavy work is
accounted to the task/process and not to the tick interrupt itself.

Further optimizations are possible to break long sighand lock hold and
interrupt disabled (on !RT kernels) times when a massive amount of posix
CPU timers (which are unpriviledged) is armed for a task/process.

This is currently only enabled for x86 because the architecture has to
ensure that task work is handled in KVM before entering a guest, which was
just established for x86 with the new common entry/exit code which got
merged post 5.8 and is not the case for other KVM architectures.

Thanks,

	tglx

------------------>
Thomas Gleixner (3):
      posix-cpu-timers: Split run_posix_cpu_timers()
      posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
      x86: Select POSIX_CPU_TIMERS_TASK_WORK



