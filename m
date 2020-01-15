Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E66C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C332B2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAOUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:53:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgAOUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:53:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irpfb-0000cw-2s; Wed, 15 Jan 2020 21:53:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 919D71C0879;
        Wed, 15 Jan 2020 21:53:42 +0100 (CET)
Date:   Wed, 15 Jan 2020 20:53:42 -0000
From:   "tip-bot2 for Chunyan Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/common: Touch watchdog in tick_unfreeze() on all CPUs
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110083902.27276-1-chunyan.zhang@unisoc.com>
References: <20200110083902.27276-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Message-ID: <157912162226.396.7446117828577037844.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5167c506d62dd9ffab73eba23c79b0a8845c9fe1
Gitweb:        https://git.kernel.org/tip/5167c506d62dd9ffab73eba23c79b0a8845c9fe1
Author:        Chunyan Zhang <zhang.lyra@gmail.com>
AuthorDate:    Fri, 10 Jan 2020 16:39:02 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2020 21:29:45 +01:00

tick/common: Touch watchdog in tick_unfreeze() on all CPUs

Suspend to IDLE invokes tick_unfreeze() on resume. tick_unfreeze() on the
first resuming CPU resumes timekeeping, which also has the side effect of
resetting the softlockup watchdog on this CPU.

But on the secondary CPUs the watchdog is not reset in the resume /
unfreeze() path, which can result in false softlockup warnings on those
CPUs depending on the time spent in suspend.

Prevent this by clearing the softlock watchdog in the unfreeze path also
on the secondary resuming CPUs.

[ tglx: Massaged changelog ]

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200110083902.27276-1-chunyan.zhang@unisoc.com
---
 kernel/time/tick-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 59225b4..7e5d352 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/sched.h>
@@ -558,6 +559,7 @@ void tick_unfreeze(void)
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
+		touch_softlockup_watchdog();
 		tick_resume_local();
 	}
 
