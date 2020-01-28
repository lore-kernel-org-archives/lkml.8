Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0276DC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA162467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d83N/OyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgA1C2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:28:09 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43151 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA1C2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580178488; x=1611714488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UorqLKP57b6PMCT+1VL4L6XYE1Vd36TEURwukvr+gSY=;
  b=d83N/OyLb9MBUD+kTTOfx/XtGZKosoq0rz7jh9W9IJHxOm5jDlbJTGCN
   7I57Ma87eh/x3DtmjDnjFtqcEp2A6fEbryOvThTfvg763lsM2KoCeAhGb
   mKRkUsjkea0Mq+Wh9hj1cQKwGQhHTxVOlXjz3KYiPJZbotkITjsBMsOmt
   vHpEfmTS7jzH7b3u1AZwQ2lQbnl6Avs+T5yrP5Z7E1rWqEafcLXGLgeIM
   PXO2ymNOTVnE53aPTtrMbvYP2IppqlTpWM6DYWYws/rOC59o+3v3AOAsq
   A1zuDEMb+DYY3HgEnLHEKRnm2xtdI6Yls/Vv23qjUONA08H8Vs/rTovWP
   A==;
IronPort-SDR: a/nYtitZx2SYHASOp9mPcUHecGoKkhmJk9VRLcTzJSuEGezLkxJiTuVHVM2Uic+Le/agcn7d/5
 5+jkh72ydEnjygFoglbE5YaI1Lnijwh4THEYpjN50WPFhpv6u5LmGn6nDbFBumpDw5mCqDSxB1
 o0e5BWgDukHrcnpY85AiWbWYwWa6HDcWIAQ3cuCEj0JiSApdv+TeJRBuFxnY6fgtcUvNLVx7SL
 Kuf98OmWiRJszaHdfF7Mz5j2tvnw78q3knfr9Yb4IbgLmiwTK1B9zZZucJwj/UtdKKftVaBQYE
 qdc=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132899373"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 10:28:08 +0800
IronPort-SDR: bNPfLJmcNP4xdmPl4QhyB8eGthWFphho5COmXWj7mF1+dA1+EBK7e268rrvDH/K2YT9dz5p0xB
 feceGL8frkOmKHjIdjH5uNVOZuEWFs2sZbE3Bt8O8tSNVE8kKmUCWfg3HON7wkm/vzAoT0tVeA
 /Vz3dEj9pJSfW9s0TvbHIw61h/Chmit7ElRAG1IyAWAZUUQxkocleX3SVhHdoahEXCmjNiUFDk
 GAuSWYS5101VE7rIaAt28DyuVz4WeaqC4QtD4l3AhmB33nvmMq53onX83CKPapDImY/BscfZDE
 kRPSMtaLIWILgYlGcZxk7/3x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 18:21:22 -0800
IronPort-SDR: gZweaIFfZbH6bxjhNbxuvU235VwbWSMSVstM5yqZLjd10PZmIGau1fOhJzV/J4YP7bu3UrxibT
 s9x9Gw2nTFmCp9PjioxE7ojb2Z2crQp2591B2iojxoeJq0hiYAEkuLvZi0cxW9wk6OKBKJMw+r
 arOQhZ9SYfeBfnFpoUUUguTNSTo5ha2J88sliAO4PITBaxMkN4a/UmBCple3UIQJgbqPbZH+4z
 nVt9fV0WpGCeD2rLXAWIabVpsp23T6NlDY/4wZqJeTx1J90qt5Q1vR4PHIGP0BSOLytUgNxIbd
 f6g=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 18:28:08 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>, abner.chang@hpe.com,
        clin@suse.com, nickhu@andestech.com
Subject: [PATCH v7 01/10] RISC-V: Mark existing SBI as 0.1 SBI.
Date:   Mon, 27 Jan 2020 18:27:28 -0800
Message-Id: <20200128022737.15371-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128022737.15371-1-atish.patra@wdc.com>
References: <20200128022737.15371-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the new SBI specification, current SBI implementation version
is defined as 0.1 and will be removed/replaced in future. Each of the
function call in 0.1 is defined as a separate extension which makes
easier to replace them one at a time.

Rename existing implementation to reflect that. This patch is just
a preparatory patch for SBI v0.2 and doesn't introduce any functional
changes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/sbi.h | 44 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2570c1e683d3..b38bc36f7429 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2015 Regents of the University of California
+ * Copyright (c) 2019 Western Digital Corporation or its affiliates.
  */
 
 #ifndef _ASM_RISCV_SBI_H
@@ -9,17 +10,17 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_RISCV_SBI
-#define SBI_SET_TIMER 0
-#define SBI_CONSOLE_PUTCHAR 1
-#define SBI_CONSOLE_GETCHAR 2
-#define SBI_CLEAR_IPI 3
-#define SBI_SEND_IPI 4
-#define SBI_REMOTE_FENCE_I 5
-#define SBI_REMOTE_SFENCE_VMA 6
-#define SBI_REMOTE_SFENCE_VMA_ASID 7
-#define SBI_SHUTDOWN 8
+#define SBI_EXT_0_1_SET_TIMER 0x0
+#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
+#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
+#define SBI_EXT_0_1_CLEAR_IPI 0x3
+#define SBI_EXT_0_1_SEND_IPI 0x4
+#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
+#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
+#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
+#define SBI_EXT_0_1_SHUTDOWN 0x8
 
-#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
+#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
 	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
 	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
@@ -43,48 +44,50 @@
 
 static inline void sbi_console_putchar(int ch)
 {
-	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
+	SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
 }
 
 static inline int sbi_console_getchar(void)
 {
-	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
+	return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
 }
 
 static inline void sbi_set_timer(uint64_t stime_value)
 {
 #if __riscv_xlen == 32
-	SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
+	SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
+			  stime_value >> 32);
 #else
-	SBI_CALL_1(SBI_SET_TIMER, stime_value);
+	SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
 #endif
 }
 
 static inline void sbi_shutdown(void)
 {
-	SBI_CALL_0(SBI_SHUTDOWN);
+	SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
 }
 
 static inline void sbi_clear_ipi(void)
 {
-	SBI_CALL_0(SBI_CLEAR_IPI);
+	SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
 }
 
 static inline void sbi_send_ipi(const unsigned long *hart_mask)
 {
-	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
+	SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
 }
 
 static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
+	SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
 }
 
 static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
-	SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
+	SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
+			  start, size);
 }
 
 static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
@@ -92,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
+	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
+			  start, size, asid);
 }
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
-- 
2.24.0

