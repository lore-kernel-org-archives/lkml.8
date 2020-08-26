Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42684C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FBD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6fn2RWI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WuYzOB9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgHZQIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:08:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59946 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgHZQI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:08:29 -0400
Date:   Wed, 26 Aug 2020 16:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598458106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijv9GzAiCerjQpg4ic1fvrhS8kVymQ+v2l+nk/G0eWk=;
        b=L6fn2RWIapYwGqNO6kTKCWYuEUW04LiTIck0JiK6u+sOLIBbuvOnxetvLUMhiHaO7JSL1T
        eye/hsYgfT2WPFEITJOFIYh6mVw4QzsUdvF7pz40scnVuXHX/zuB8+35PVUQUnAr0IEI9h
        K1dD9QitGs0Z6BYB779u/OL3IS+ySlUWh9KifAYupKeACrANa81+ViYfydgdoV+Q2S37CF
        Gc/wQvU8QZAPX0B7ud0RmyngOVzD7rrgZzRU1cBz7RtuMSRpf9zKz1+vJP5vTj9zRmbB5I
        IkLx3xTevUe0RBgCE2uGs62bbvtYqnhLLKhA2SaQnbWb7Nj4hzutIY/GShr2LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598458106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijv9GzAiCerjQpg4ic1fvrhS8kVymQ+v2l+nk/G0eWk=;
        b=WuYzOB9loA95U2HoYUARybhuuSXnYHzI/xYpWgbqoSxRS9EcDlNpmwPGhRS7Y4US9QroQN
        005uPTC+cRGBSmBg==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Enumerate per-thread MBA controls
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Babu Moger <babu.moger@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1598296281-127595-2-git-send-email-fenghua.yu@intel.com>
References: <1598296281-127595-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <159845810600.389.10972463639550813040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e48cb1a3fb9165009fe318e1db2fde10d303c1d3
Gitweb:        https://git.kernel.org/tip/e48cb1a3fb9165009fe318e1db2fde10d303c1d3
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 24 Aug 2020 12:11:20 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 26 Aug 2020 17:46:12 +02:00

x86/resctrl: Enumerate per-thread MBA controls

Some systems support per-thread Memory Bandwidth Allocation (MBA) which
applies a throttling delay value to each hardware thread instead of to
a core. Per-thread MBA is enumerated by CPUID.

No feature flag is shown in /proc/cpuinfo. User applications need to
check a resctrl throttling mode info file to know if the feature is
supported.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/1598296281-127595-2-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2901d5d..4a7473a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -288,6 +288,7 @@
 #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
 #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
+#define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3cbe24c..3e30b26 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -69,6 +69,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 62b137c..bccfc9f 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -35,6 +35,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
 	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
+	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3 },
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
