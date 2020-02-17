Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB795C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955B0214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBQPM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:12:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgBQPME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:12:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3i40-0007gn-Rb; Mon, 17 Feb 2020 16:12:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 634841C20AC;
        Mon, 17 Feb 2020 16:12:00 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:12:00 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Mark the TSC clocksource path likely
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124402.328922847@linutronix.de>
References: <20200207124402.328922847@linutronix.de>
MIME-Version: 1.0
Message-ID: <158195232016.13786.8518739445057683116.tip-bot2@tip-bot2>
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

Commit-ID:     50e818715821b89c7abac90a97721f106e893d83
Gitweb:        https://git.kernel.org/tip/50e818715821b89c7abac90a97721f106e893d83
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2020 13:38:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 14:40:19 +01:00

x86/vdso: Mark the TSC clocksource path likely

Jumping out of line for the TSC clcoksource read is creating awful
code. TSC is likely to be the clocksource at least on bare metal and the PV
interfaces are sufficiently more work that the jump over the TSC read is
just in the noise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124402.328922847@linutronix.de

---
 arch/x86/include/asm/vdso/gettimeofday.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 6ee1f7d..264d4fd 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -243,7 +243,7 @@ static u64 vread_hvclock(void)
 
 static inline u64 __arch_get_hw_counter(s32 clock_mode)
 {
-	if (clock_mode == VCLOCK_TSC)
+	if (likely(clock_mode == VCLOCK_TSC))
 		return (u64)rdtsc_ordered();
 	/*
 	 * For any memory-mapped vclock type, we need to make sure that gcc
