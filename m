Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EDB21D79
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0wqxVJO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GLIy8nID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgIJJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgIJJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A86C0617BB;
        Thu, 10 Sep 2020 02:22:25 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfGncXV1c7CwOBK+Cn3jrZgIlyKphUHKhWgf/W0dVBs=;
        b=b0wqxVJOgp+JgYL7xeUbr3hv3AoiR8bW7MGny3ixmyPW81I35AVCEKpa9D+mcb6TjFkf8y
        UxD+YIUhgWjc804MQYLFBiqqS56lGPb0rzPuH6tVC6ugQncwX9RseQV1uJRYr82n4FQxlg
        +Aa6guVu2xL+gtF/bil8kRJY4monyvXQiFFQYV2zcpCGPd7mn2IF6Fhm+6K19gZtugsL3h
        RiPOfIHLeF7crARaQuRgAYdV7hzUAEBsCubYVi2XrGJyP4SCaZ5TB4VYD8taTCzmQC6iN9
        5/tcd/2GmBLV+KGaRBd66LEuQ5KBsO0ipnyRAfivW0vfllSEZw9pF65lRYvoPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfGncXV1c7CwOBK+Cn3jrZgIlyKphUHKhWgf/W0dVBs=;
        b=GLIy8nID04gX3iH81OuBauXzHk92YRrRQ5EPWpPSGcwVoLyi8UTSOclKFfH/hDK33Kh/Kc
        PfaRnVqvTATBGRDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/fpu: Move xgetbv()/xsetbv() into a separate header
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-27-joro@8bytes.org>
References: <20200907131613.12703-27-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974174.20229.15810019883316968353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     1b4fb8545f2b00f2844c4b7619d64d98440a477c
Gitweb:        https://git.kernel.org/tip/1b4fb8545f2b00f2844c4b7619d64d98440a477c
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:54:20 +02:00

x86/fpu: Move xgetbv()/xsetbv() into a separate header

The xgetbv() function is needed in the pre-decompression boot code,
but asm/fpu/internal.h can't be included there directly. Doing so
opens the door to include-hell due to various include-magic in
boot/compressed/misc.h.

Avoid that by moving xgetbv()/xsetbv() to a separate header file and
include it instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-27-joro@8bytes.org
---
 arch/x86/include/asm/fpu/internal.h | 30 +-------------------------
 arch/x86/include/asm/fpu/xcr.h      | 34 ++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 arch/x86/include/asm/fpu/xcr.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 21a8b52..ceeba9f 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -19,6 +19,7 @@
 #include <asm/user.h>
 #include <asm/fpu/api.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fpu/xcr.h>
 #include <asm/cpufeature.h>
 #include <asm/trace/fpu.h>
 
@@ -585,33 +586,4 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	__write_pkru(pkru_val);
 }
 
-/*
- * MXCSR and XCR definitions:
- */
-
-static inline void ldmxcsr(u32 mxcsr)
-{
-	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
-}
-
-extern unsigned int mxcsr_feature_mask;
-
-#define XCR_XFEATURE_ENABLED_MASK	0x00000000
-
-static inline u64 xgetbv(u32 index)
-{
-	u32 eax, edx;
-
-	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
-	return eax + ((u64)edx << 32);
-}
-
-static inline void xsetbv(u32 index, u64 value)
-{
-	u32 eax = value;
-	u32 edx = value >> 32;
-
-	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
-}
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
new file mode 100644
index 0000000..1c7ab8d
--- /dev/null
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_FPU_XCR_H
+#define _ASM_X86_FPU_XCR_H
+
+/*
+ * MXCSR and XCR definitions:
+ */
+
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
+extern unsigned int mxcsr_feature_mask;
+
+#define XCR_XFEATURE_ENABLED_MASK	0x00000000
+
+static inline u64 xgetbv(u32 index)
+{
+	u32 eax, edx;
+
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
+	return eax + ((u64)edx << 32);
+}
+
+static inline void xsetbv(u32 index, u64 value)
+{
+	u32 eax = value;
+	u32 edx = value >> 32;
+
+	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
+}
+
+#endif /* _ASM_X86_FPU_XCR_H */
