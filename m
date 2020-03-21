Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5E0C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E147020870
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgCUOdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:33:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgCUOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:33:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFfBm-00045Q-1f; Sat, 21 Mar 2020 15:33:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A57A61C22DA;
        Sat, 21 Mar 2020 15:33:25 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:33:25 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm64: vdso32: Include common headers in the vdso library
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320145351.32292-22-vincenzo.frascino@arm.com>
References: <20200320145351.32292-22-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158480120536.28353.7718322208789745754.tip-bot2@tip-bot2>
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

Commit-ID:     5340e873576ee04186eca3c70844c576d714cc6a
Gitweb:        https://git.kernel.org/tip/5340e873576ee04186eca3c70844c576d714cc6a
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 20 Mar 2020 14:53:46 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:24:02 +01:00

arm64: vdso32: Include common headers in the vdso library

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Refactor the vdso32 implementation to include common headers.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200320145351.32292-22-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 2 +-
 arch/arm64/kernel/vdso32/vgettimeofday.c          | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 401df2b..b6907ae 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -8,7 +8,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/unistd.h>
-#include <uapi/linux/time.h>
+#include <asm/errno.h>
 
 #include <asm/vdso/compat_barrier.h>
 
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index ddbad47..5acff29 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 ARM Limited
  *
  */
-#include <linux/time.h>
-#include <linux/types.h>
 
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
