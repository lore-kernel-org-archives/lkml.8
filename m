Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CDFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A5724692
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgANNCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:02:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgANNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLqB-0004qJ-HH; Tue, 14 Jan 2020 14:02:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D1F21C0857;
        Tue, 14 Jan 2020 14:02:23 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:23 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-7-vincenzo.frascino@arm.com>
References: <20190830135902.20861-7-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157900694315.396.4990000751784203935.tip-bot2@tip-bot2>
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

Commit-ID:     972188f3a2dac07a6f000a4418776f446259fc87
Gitweb:        https://git.kernel.org/tip/972188f3a2dac07a6f000a4418776f446259fc87
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:59:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:45 +01:00

arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

VDSO_HAS_32BIT_FALLBACK has been removed from the core since
the architectures that support the generic vDSO library have
been converted to support the 32 bit fallbacks.

Remove unused VDSO_HAS_32BIT_FALLBACK from arm64 compat vdso.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20190830135902.20861-7-vincenzo.frascino@arm.com


---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index fe7afe0..537b1e6 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -16,7 +16,6 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
-#define VDSO_HAS_32BIT_FALLBACK		1
 #define BUILD_VDSO32			1
 
 static __always_inline
