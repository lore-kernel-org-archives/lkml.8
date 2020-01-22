Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67496C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397132465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:54:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:54:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuHP9-0007Pr-Vz; Wed, 22 Jan 2020 15:54:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9BF441C1A46;
        Wed, 22 Jan 2020 15:54:51 +0100 (CET)
Date:   Wed, 22 Jan 2020 14:54:51 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Add missing sparse annotation for __run_timer()
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200120224347.51843-1-jbi.octave@gmail.com>
References: <20200120224347.51843-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Message-ID: <157970489138.396.2731472419371278003.tip-bot2@tip-bot2>
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

Commit-ID:     eb5a4d0a9ee976008d1add75e3d64545399e80a3
Gitweb:        https://git.kernel.org/tip/eb5a4d0a9ee976008d1add75e3d64545399e80a3
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 20 Jan 2020 22:43:47 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jan 2020 15:50:11 +01:00

hrtimer: Add missing sparse annotation for __run_timer()

Sparse reports a warning at __run_hrtimer()
|warning: context imbalance in __run_hrtimer() - unexpected unlock

Add the missing must_hold() annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200120224347.51843-1-jbi.octave@gmail.com

---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d8b62f9..3a609e7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1477,7 +1477,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
 static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  struct hrtimer_clock_base *base,
 			  struct hrtimer *timer, ktime_t *now,
-			  unsigned long flags)
+			  unsigned long flags) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	int restart;
