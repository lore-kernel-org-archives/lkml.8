Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A1DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BF120771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpTamrUD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEPfn1Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgGHJwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgGHJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:54 -0400
Date:   Wed, 08 Jul 2020 09:51:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGK8qSpIgDcGxBwGC2W7bf2t6+vph84YrY8LKmIcO9M=;
        b=dpTamrUDBtb3ea8hqIiky7gj/rqpc7TTBoKOkosraMz+HkCXpZdaAU4SKoZU5jH/Uj9OQV
        LcebeXjx7g6qaPQy1ezDpwvf6S2ZU++8/UHoijOWlXlDZM7iOBr5VAC6GJnXIM/QiiN+eH
        FxBLlrK7kj2gRMgbdkpNfhqHSa0NcAiogaNdsRJy8xz8oNIAxc+MAkjMRnCyH+HQaf3rw3
        nnx5tW+5uBuL+4YPiRkotc7VRMYN69o2ZMQlBmJObkBcY7lbVnynLcECAbNs5zEGA+v5ms
        5i45MUsdpcBVgP8pmGpAJW5hVdFAeKL64XYLea+/yQidIwAAgJ17j1G4nG9P3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGK8qSpIgDcGxBwGC2W7bf2t6+vph84YrY8LKmIcO9M=;
        b=gEPfn1Ac7oqli9wU/GxBdjK1V1tWFWXwz0Ys1xEueHDuSTnE3agwOLWSTRyqz1CXk+x7KM
        PlhgbDk276v+rMAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/msr-index: Add bunch of MSRs for Arch LBR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-8-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-8-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191229.4006.89063706463703327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d6a162a41bfd2ff9ea4cbb338d3df6a3f9b7e89f
Gitweb:        https://git.kernel.org/tip/d6a162a41bfd2ff9ea4cbb338d3df6a3f9b7e89f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:52 +02:00

x86/msr-index: Add bunch of MSRs for Arch LBR

Add Arch LBR related MSRs and the new LBR INFO bits in MSR-index.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-8-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/msr-index.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e6..bdc07fc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -158,7 +158,23 @@
 #define LBR_INFO_MISPRED		BIT_ULL(63)
 #define LBR_INFO_IN_TX			BIT_ULL(62)
 #define LBR_INFO_ABORT			BIT_ULL(61)
+#define LBR_INFO_CYC_CNT_VALID		BIT_ULL(60)
 #define LBR_INFO_CYCLES			0xffff
+#define LBR_INFO_BR_TYPE_OFFSET		56
+#define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
+
+#define MSR_ARCH_LBR_CTL		0x000014ce
+#define ARCH_LBR_CTL_LBREN		BIT(0)
+#define ARCH_LBR_CTL_CPL_OFFSET		1
+#define ARCH_LBR_CTL_CPL		(0x3ull << ARCH_LBR_CTL_CPL_OFFSET)
+#define ARCH_LBR_CTL_STACK_OFFSET	3
+#define ARCH_LBR_CTL_STACK		(0x1ull << ARCH_LBR_CTL_STACK_OFFSET)
+#define ARCH_LBR_CTL_FILTER_OFFSET	16
+#define ARCH_LBR_CTL_FILTER		(0x7full << ARCH_LBR_CTL_FILTER_OFFSET)
+#define MSR_ARCH_LBR_DEPTH		0x000014cf
+#define MSR_ARCH_LBR_FROM_0		0x00001500
+#define MSR_ARCH_LBR_TO_0		0x00001600
+#define MSR_ARCH_LBR_INFO_0		0x00001200
 
 #define MSR_IA32_PEBS_ENABLE		0x000003f1
 #define MSR_PEBS_DATA_CFG		0x000003f2
