Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564CF2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696990;
	bh=5mDtRWpyWxKMTePmfeN0asoxKgTNM9ztJLTtTwhGIo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmJtdd6vGZRMs4lIGmXipFvkVkulpvbktSD9EFQSNxNxXV+oXG+HGVDlYQNsIz9hu
	 g80+vmgASfeudYsQAtv2oE4LW/WBdAyAakz9x1XOeRoz3UHhRGbzoeh5uxDvtJU2dp
	 ymjwXtPWOomcvMU60iOv6+V1X783E2iVHl9usqdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407182AbgE1UQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407032AbgE1UOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E03214D8;
        Thu, 28 May 2020 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696871;
        bh=5mDtRWpyWxKMTePmfeN0asoxKgTNM9ztJLTtTwhGIo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnHmM4FTaWsXjCrkbno8k0NCBI6dekbv9unTayikUAyymZ7Zn8WYRT2X4FfRyZhSv
         d+yvasf+KZk184JvcMFbuspsBcIIgwp3KC7aHUGmY1gzlPEmXfeBSl3Zljtp4Bp6Za
         suTB6T4A1SPnLaXrAjqkvg5KrXSq5npb78bLnKS8=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 10/16] x86/entry/64: Introduce the FIND_PERCPU_BASE macro
Date:   Thu, 28 May 2020 16:13:56 -0400
Message-Id: <20200528201402.1708239-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

GSBASE is used to find per-CPU data in the kernel. But when GSBASE is
unknown, the per-CPU base can be found from the per_cpu_offset table with a
CPU NR.  The CPU NR is extracted from the limit field of the CPUNODE entry
in GDT, or by the RDPID instruction. This is a prerequisite for using
FSGSBASE in the low level entry code.

Also, add the GAS-compatible RDPID macro as binutils 2.21 do not support
it. Support is added in version 2.27.

[ tglx: Massaged changelog ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/1557309753-24073-12-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/calling.h    | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h | 15 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 1c7f13bb6728..1b95cdc19b18 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/inst.h>
 
 /*
 
@@ -349,6 +350,39 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
+#ifdef CONFIG_SMP
+
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ */
+.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
+	movq	$__CPUNODE_SEG, \reg
+	lsl	\reg, \reg
+.endm
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+.macro GET_PERCPU_BASE reg:req
+	ALTERNATIVE \
+		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
+		"RDPID	\reg", \
+		X86_FEATURE_RDPID
+	andq	$VDSO_CPUNODE_MASK, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+#else
+
+.macro GET_PERCPU_BASE reg:req
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
+
 /*
  * This does 'call enter_from_user_mode' unless we can avoid it based on
  * kernel config or using the static jump infrastructure.
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index f5a796da07f8..d063841a17e3 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -306,6 +306,21 @@
 	.endif
 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
 	.endm
+
+.macro RDPID opd
+	REG_TYPE rdpid_opd_type \opd
+	.if rdpid_opd_type == REG_TYPE_R64
+	R64_NUM rdpid_opd \opd
+	.else
+	R32_NUM rdpid_opd \opd
+	.endif
+	.byte 0xf3
+	.if rdpid_opd > 7
+	PFX_REX rdpid_opd 0
+	.endif
+	.byte 0x0f, 0xc7
+	MODRM 0xc0 rdpid_opd 0x7
+.endm
 #endif
 
 #endif
-- 
2.25.1

