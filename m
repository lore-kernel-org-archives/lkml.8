Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF0C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47272076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KXZP6nTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCRBL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:11:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45899 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCRBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493916; x=1616029916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MIh7Er5TSP6bkmcwbyQ0jmFEGwBC9Y1OxPn6vxSmZt8=;
  b=KXZP6nTFY0fJELHSDh8aMMLX+9LS66jqkwRm/NeZKtOpv1It2XB+s4jH
   srxuymo2r+CodcEl9xrK12NAMwA0kFVzWgvIhOgP/uH/2MAUKqhtxnHlB
   xnlkumLBpaAj6ZDuSdDtEuOunZrD+vAIDYvSplR27pAC8od98NLdMM9qf
   6VzsO8qN2QdkPs0JmTPe6adXP4yuq3/5lOOh0FuyTtTfOcC9wihx5Fbm/
   6z53vQE3FGfH38PxJDnAqI6xIUPTG1YAzXy4Dhs7izoBOtJ8Kv4qJ1r1y
   rmpSZFoaKQsx7sB3QmN5Sv8zXuAFMG7Y0TGMjw4gSO+ssQkjmeDjApnKB
   Q==;
IronPort-SDR: zNmXzhu9C/yt0od6doLj+WI2yYu8nOBL7Oj8zvWbfGKKy5uuigFoJxoWrQIATpGaMpjBaQwhIY
 E4m8y8K6hDFZzUZacutoOak8WCZyW1mm5cAnGQrUxyS1XrseKFUXjQlFNOpaTPguYI9aVYNa6Q
 /JWeJEwitrSpRRUsZ//oF0LENsTLYygri4iVCjUqDR9Q7bxVLDrU9SoPKKeUK5TqCx2FN2UvfR
 OWR8zgYmFdbYttWLY+91/EDT63RYdkz9MZiOwJEVPC7xjaNCKAKn1lOhXa294T5k1yi88T0RFa
 6pg=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241495"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:11:56 +0800
IronPort-SDR: Va0IhYdOAfPO5T5hcizPv4q6GINMtr+BFFR96Q9fkPWsRVJMya5YxJXvRm+QDdOLR27Qet5zXx
 WGSwQyjpYFuJiLrIG/GjjWHz1JHQQyA/87cTs5Sucl24b78hYpJjUN+iVUSvyJc8YkU++ji+fF
 54R18vOaSOQObVcMIxGTu1l4tm698pD7h55KZf8FwzPq8MZZGpJCub6fQBRXL2VrjTyrDXfa3S
 pJDG+J7MGDG9fERKEf7JIjdCisUmKxhfZBnBK5hRghQeFK5ds1im7pm0MSqkI4NLUiG7F2ediG
 Fy+hgOnFCUiBQlHbWV6lFE9g
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:46 -0700
IronPort-SDR: +SfGws8zmt5EX9c0tHOlF+E1fwRxychf9aMMraXjH8eQIb0Coebl9PZdHhFmySuEsAZFbK2bFS
 8kZOwTwMPw03pCL1ZH3vzjrTJtG37zbW3V1GlvJP2jIj9Ocf88YrMBrNst9jQSFePrDjP5WP5Q
 gkzR0wWCCtyJYsI64igGFGQ+CFH8AYli3vPRiAza9bcLSNPdt7qzZdvjq+iDdCAEcAxQC2TTvl
 c8t0YJHNeavo6N1gBpF/pXaw/SJsB66uGszK5zYUbTFMKpawSNOUQNDsUWgQ8dsKwQnT66mRRv
 vSg=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:11:56 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v11 01/11] RISC-V: Mark existing SBI as 0.1 SBI.
Date:   Tue, 17 Mar 2020 18:11:34 -0700
Message-Id: <20200318011144.91532-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
References: <20200318011144.91532-1-atish.patra@wdc.com>
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
 arch/riscv/include/asm/sbi.h | 41 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2570c1e683d3..2a637ebd7a22 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2015 Regents of the University of California
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
  */
 
 #ifndef _ASM_RISCV_SBI_H
@@ -9,15 +10,15 @@
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
 
 #define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
@@ -43,48 +44,49 @@
 
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
+		   stime_value >> 32);
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
+	SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask, start, size);
 }
 
 static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
@@ -92,7 +94,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
+	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
+		   start, size, asid);
 }
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
-- 
2.25.1

