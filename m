Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB2E2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENLuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:50:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbgENLuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:50:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 13BD5628B3E816D57F4D;
        Thu, 14 May 2020 19:50:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 14 May 2020 19:50:12 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <alex@ghiti.fr>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH v2] riscv: Fix print_vm_layout build error if NOMMU
Date:   Thu, 14 May 2020 19:53:35 +0800
Message-ID: <20200514115335.110603-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511022001.179767-5-wangkefeng.wang@huawei.com>
References: <20200511022001.179767-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/riscv/mm/init.c: In function ‘print_vm_layout’:
arch/riscv/mm/init.c:68:37: error: ‘FIXADDR_START’ undeclared (first use in this function);
arch/riscv/mm/init.c:69:20: error: ‘FIXADDR_TOP’ undeclared
arch/riscv/mm/init.c:70:37: error: ‘PCI_IO_START’ undeclared
arch/riscv/mm/init.c:71:20: error: ‘PCI_IO_END’ undeclared
arch/riscv/mm/init.c:72:38: error: ‘VMEMMAP_START’ undeclared
arch/riscv/mm/init.c:73:20: error: ‘VMEMMAP_END’ undeclared (first use in this function);

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: 
- Should CONFIG_DEBUG_VM instead of DEBUG_VM
- Based on riscv fixes branch

 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 27a334106708..736de6c8739f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -47,7 +47,7 @@ static void setup_zero_page(void)
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 }
 
-#ifdef CONFIG_DEBUG_VM
+#if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
-- 
2.26.2

