Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53412C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3221D43
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgIILoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:44:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729781AbgIILgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:36:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7199ABA412A1C7E37A53;
        Wed,  9 Sep 2020 19:19:59 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 19:19:53 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Pekka Enberg" <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Xu" <peterx@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Michel Lespinasse" <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] riscv/mm/fault: fix old-style-declaration warning
Date:   Wed, 9 Sep 2020 19:29:01 +0800
Message-ID: <20200909112901.5002-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc report build warning as follows:

arch/riscv/mm/fault.c:81:1: warning:
 'inline' is not at beginning of declaration [-Wold-style-declaration]
   81 | static void inline vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
      | ^~~~~~

This commit fix it by moving 'inline' after 'static'.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/riscv/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index a23eaf5ce95c..a173432ccf82 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -78,7 +78,7 @@ static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code
 	no_context(regs, addr);
 }
 
-static void inline vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
+static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
 {
 	pgd_t *pgd, *pgd_k;
 	pud_t *pud, *pud_k;

