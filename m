Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F6C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A452074B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 11:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgIEL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:28:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728502AbgIEL1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 07:27:35 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0816BF94880A8F88B017;
        Sat,  5 Sep 2020 19:27:13 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 19:27:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] powerpc/book3s64: fix link error with CONFIG_PPC_RADIX_MMU=n
Date:   Sat, 5 Sep 2020 19:25:48 +0800
Message-ID: <20200905112548.3265530-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link error when CONFIG_PPC_RADIX_MMU is disabled:
powerpc64-linux-gnu-ld: arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference to `mmu_pid_bits'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/powerpc/mm/book3s64/mmu_context.c | 4 ++++
 arch/powerpc/platforms/pseries/lpar.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 0ba30b8b935b..a8e292cd88f0 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -152,6 +152,7 @@ void hash__setup_new_exec(void)
 
 static int radix__init_new_context(struct mm_struct *mm)
 {
+#ifdef CONFIG_PPC_RADIX_MMU
 	unsigned long rts_field;
 	int index, max_id;
 
@@ -177,6 +178,9 @@ static int radix__init_new_context(struct mm_struct *mm)
 	mm->context.hash_context = NULL;
 
 	return index;
+#else
+	return -ENOTSUPP;
+#endif
 }
 
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index baf24eacd268..e454e218dbba 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1726,10 +1726,12 @@ void __init hpte_init_pseries(void)
 
 void radix_init_pseries(void)
 {
+#ifdef CONFIG_PPC_RADIX_MMU
 	pr_info("Using radix MMU under hypervisor\n");
 
 	pseries_lpar_register_process_table(__pa(process_tb),
 						0, PRTB_SIZE_SHIFT - 12);
+#endif
 }
 
 #ifdef CONFIG_PPC_SMLPAR
-- 
2.25.1

