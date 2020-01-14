Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954CCC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8752467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgANNDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:03:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgANNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLqD-0004ru-57; Tue, 14 Jan 2020 14:02:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 781CB1C0861;
        Tue, 14 Jan 2020 14:02:24 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:24 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm64: compat: vdso: Expose BUILD_VDSO32
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-2-vincenzo.frascino@arm.com>
References: <20190830135902.20861-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157900694432.396.17035298471043626143.tip-bot2@tip-bot2>
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

Commit-ID:     3b5584afeef05319ade0fbf5f634a64fd3e5772b
Gitweb:        https://git.kernel.org/tip/3b5584afeef05319ade0fbf5f634a64fd3e5772b
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:58:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:43 +01:00

arm64: compat: vdso: Expose BUILD_VDSO32

clock_gettime32 and clock_getres_time32 should be compiled only with the
32 bit vdso library.

Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
indication to the generic library to include these symbols.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20190830135902.20861-2-vincenzo.frascino@arm.com


---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index c50ee1b..fe7afe0 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -17,6 +17,7 @@
 #define VDSO_HAS_CLOCK_GETRES		1
 
 #define VDSO_HAS_32BIT_FALLBACK		1
+#define BUILD_VDSO32			1
 
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
