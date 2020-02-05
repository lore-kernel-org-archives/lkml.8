Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608D1C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C89722B48
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBEC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:56:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbgBEC4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:56:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B24BB11F14C5F84986E;
        Wed,  5 Feb 2020 10:56:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 5 Feb 2020
 10:56:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 2/6] powerpc/fsl_booke/64: introduce reloc_kernel_entry() helper
Date:   Wed, 5 Feb 2020 10:55:23 +0800
Message-ID: <20200205025527.28640-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200205025527.28640-1-yanaijie@huawei.com>
References: <20200205025527.28640-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the 32bit code, we introduce reloc_kernel_entry() helper to prepare
for the KASLR 64bit version. And move the C declaration of this function
out of CONFIG_PPC32 and use long instead of int for the parameter 'addr'.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Scott Wood <oss@buserror.net>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/exceptions-64e.S | 13 +++++++++++++
 arch/powerpc/mm/mmu_decl.h           |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index e4076e3c072d..1b9b174bee86 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1679,3 +1679,16 @@ _GLOBAL(setup_ehv_ivors)
 _GLOBAL(setup_lrat_ivor)
 	SET_IVOR(42, 0x340) /* LRAT Error */
 	blr
+
+/*
+ * Return to the start of the relocated kernel and run again
+ * r3 - virtual address of fdt
+ * r4 - entry of the kernel
+ */
+_GLOBAL(reloc_kernel_entry)
+	mfmsr	r7
+	rlwinm	r7, r7, 0, ~(MSR_IS | MSR_DS)
+
+	mtspr	SPRN_SRR0,r4
+	mtspr	SPRN_SRR1,r7
+	rfi
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 8e99649c24fc..3e1c85c7d10b 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -140,9 +140,10 @@ extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 void create_kaslr_tlb_entry(int entry, unsigned long virt, phys_addr_t phys);
-void reloc_kernel_entry(void *fdt, int addr);
 extern int is_second_reloc;
 #endif
+
+void reloc_kernel_entry(void *fdt, long addr);
 extern void loadcam_entry(unsigned int index);
 extern void loadcam_multi(int first_idx, int num, int tmp_idx);
 
-- 
2.17.2

