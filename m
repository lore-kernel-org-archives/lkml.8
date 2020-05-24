Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C653FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD81A2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgEXJQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 05:16:25 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50269 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgEXJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:16:25 -0400
Received: from localhost.localdomain (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B5B91200005;
        Sun, 24 May 2020 09:16:21 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 6/8] riscv: Allow user to downgrade to sv39 when hw supports sv48
Date:   Sun, 24 May 2020 05:10:06 -0400
Message-Id: <20200524091008.25587-7-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200524091008.25587-1-alex@ghiti.fr>
References: <20200524091008.25587-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is made possible by using the mmu-type property of the cpu node of
the device tree.

By default, the kernel will boot with 4-level page table if the hw supports
it but it can be interesting for the user to select 3-level page table as
it is less memory consuming and faster since it requires less memory
accesses in case of a TLB miss.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bad8da099ff6..1776eeb53d61 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -509,11 +509,32 @@ void disable_pgtable_l4(void)
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-asmlinkage __init void set_satp_mode(uintptr_t load_pa)
+asmlinkage __init void set_satp_mode(uintptr_t load_pa, uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	int cpus_node;
 
+	/* 1/ Check if the user asked for sv39 explicitly in the device tree */
+	cpus_node = fdt_path_offset((void *)dtb_pa, "/cpus");
+	if (cpus_node >= 0) {
+		int node;
+
+		fdt_for_each_subnode(node, (void *)dtb_pa, cpus_node) {
+			const char *mmu_type = fdt_getprop((void *)dtb_pa, node,
+							"mmu-type", NULL);
+			if (!mmu_type)
+				continue;
+
+			if (!strcmp(mmu_type, "riscv,sv39")) {
+				disable_pgtable_l4();
+				return;
+			}
+
+			break;
+		}
+	}
+
+	/* 2/ Determine if the HW supports sv48: if not, fallback to sv39 */
 	create_pgd_mapping(early_pg_dir, load_pa, (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 	create_pud_mapping(early_pud, load_pa, (uintptr_t)early_pmd,
@@ -561,7 +582,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	load_sz = (uintptr_t)(&_end) - load_pa;
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_MAXPHYSMEM_2GB)
-	set_satp_mode(load_pa);
+	set_satp_mode(load_pa, dtb_pa);
 #endif
 
 	kernel_virt_addr = KERNEL_VIRT_ADDR;
-- 
2.20.1

