Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E875AC4BA2C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE65121D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oQCAJNNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBZWCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45025 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgBZWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754541; x=1614290541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRyds8eoTAAKDT7JLLNlxolFt94lyE19pGg9nDfait4=;
  b=oQCAJNNWwy/4AK5lfsoA8qLxoRzeY2HDbRmJBC3BQ0Di0crZc7gbzViY
   LKtyfuim5f2vGueuE4j8cdgsqg3sc9Oa2oHFhUDI5kdzvly5bOxWAX5wj
   NcloymL9ryKK5LfHvKcJQ+ChjOMGEZY8vMWjoyMfLiDK7ZtiY6jShfPzw
   pcT3DX5wVsR+Q3Xh9vsZGFxxhSpI/oZyzsB9qjmnDpJ8XZYG8eLN8H9JQ
   tQGi5biXiAiwgxqIa9KSOJCwJHJ/aNvhzRosST8MP6zsUJbZSJBexP0F2
   ka6tF+PcaY8/lVhJCDDj5VbMW8znIbKL+egaspPxdQrU+0WyfbTkEuCqX
   A==;
IronPort-SDR: yhNmJ250+f3VBmWGbcwJercconpWicSffDQrwyVCaGyKgAK0wYRiRbjtyAVo1VqIPkDJJygopp
 ypj6yts3WgHQYZQZ+CYC8enmopU3UK018IAjmCzfNv8G+5LR7MCHBEkIy0vQioyUadrdgv/jNX
 /rtqqNr5XExWpCPn0S1lWnbGkafPOHHAYQpHTJaqcrMMgs3vXsJ+pIDkT1/k4/3vn+aGdGNYZp
 9SeiJpDFwCnI6wtp0qQEgN6ocmwfjOe0ihxTbkjgW4lLj0jDE0ilaKMPrnlLYcC7e/NnXrpV7/
 XEw=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290710"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:21 +0800
IronPort-SDR: Ar+zHxtSxY7DYx03+7YjQJ8nTnNQN6loFVHGz88cHA5qllXcyhea315vrkOFQocw5WLPyLwNgy
 i9j2CZRvSnbKsOffZk0hVtCwDbMhvd+7QtSdCNzI+H+VcnhtFj7OVGMQWau1ZA45jcHv/FECLu
 DvLzlveRnKkkfS6y/i0/Z80cWWN1Vv2GXt49iz0bSsH6CGg8BvI/uwVlWNYmXi0Q3Rh7OF/MXv
 Q8uFWvNupT/sfKX68Wczv1wgryCAv4v2do9L8jd+4qF6LvRsGYJswptEGFH/rtvif0omXeNVOu
 SpbhIXBKPoXrLdRMQcViAq+5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:45 -0800
IronPort-SDR: mSlcY6dyF4dBL8ImVFBxA3zdVutQAuezz9OKXsX6CdcMko8fUm2UIoA4teKrnODrnMTChKTJSx
 CgHq/KtB1J9K7/na6uXIxu6dxtO8CfpVhYuW28iXGvq0H63z47EbDP7NELB5CyNFNixnxYOp+b
 PZ05gBEngHdH8FFJ0S0CogK2HmUoCWSzPeZANFjTt+hCwRHfzzmdHXiz09IHa6kaEsTeH8ZhP/
 rlogz0iQi4eQXt0YPrl6+YCRZulGCJbBpOoPhlmphC7iNY/U1kTLOEjloUmOVKmNze2uXtgiGJ
 O4k=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:20 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 01/12] RISC-V: Mark existing SBI as 0.1 SBI.
Date:   Wed, 26 Feb 2020 14:02:02 -0800
Message-Id: <20200226220213.27423-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
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
index 2570c1e683d3..3db30e739c8f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2015 Regents of the University of California
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
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
2.25.0

