Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C0C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E163620863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCHXZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:25:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCHXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:59 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Ga-00033M-MN; Mon, 09 Mar 2020 00:23:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E755B100292;
        Mon,  9 Mar 2020 00:23:27 +0100 (CET)
Message-Id: <20200308222359.370649591@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:23:59 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 00/13]  x86/entry: Consolidation - Part II (syscalls)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the second version of the syscall entry code consolidation
series. V1 can be found here:

  https://lore.kernel.org/r/20200225220801.571835584@linutronix.de

It applies on top of

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel entry-v2-part2

The changes vs. V1:

  - Addressed the review comments. The main change is the rework of
    preparing the move of interrupt tracing to C-code. The new version
    creates less churn which needs to be mopped up afterwards again.

  - Provide new variants for trace_hardirqs_on() which are not using
    the rcuidle tracepoint mechanism and do not call into lockdep.

    This allows to split up lockdep and tracing in the enter from user and
    exit to user implementation.

    Aside of addressing the rcuidle issue of functions attached to
    tracepoints which are not rcuidle safe, e.g. BPF, this also has a
    performance advantage as it spares the srcu/rcu_irq dance around the
    tracepoint before enter_from_user_mode() which turns RCU back on
    anyway. Same on the way out.

  - Picked up Reviewed-by and Acked-by tags

Thanks,

	tglx
---
 arch/x86/entry/common.c                |  106 +++++++++++++++++++++++++--------
 arch/x86/entry/entry_32.S              |   26 +-------
 arch/x86/entry/entry_64.S              |    6 -
 arch/x86/entry/entry_64_compat.S       |   32 +--------
 arch/x86/include/asm/nospec-branch.h   |    4 -
 include/linux/context_tracking.h       |   14 ++--
 include/linux/context_tracking_state.h |    6 -
 include/linux/irqflags.h               |    4 +
 kernel/context_tracking.c              |    9 +-
 kernel/trace/trace_preemptirq.c        |   23 +++++++
 10 files changed, 136 insertions(+), 94 deletions(-)


