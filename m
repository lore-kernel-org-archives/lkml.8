Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC4120575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgENCSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:18:25 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45450 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgENCSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:18:24 -0400
Received: from kvm-dev1.localdomain (unknown [10.2.5.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx79xcqrxeenY0AA--.31S2;
        Thu, 14 May 2020 10:18:06 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        bibo mao <maobibo@loongson.cn>
Subject: [PATCH] MIPS: update tlb even if pte entry has no change
Date:   Thu, 14 May 2020 10:17:57 +0800
Message-Id: <1589422677-11455-1-git-send-email-maobibo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dx79xcqrxeenY0AA--.31S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17tr1fJr48KFy7CryDZFb_yoW8XrWkpF
        Z7CFnagrZrGw1IyrWfJr1vgr15ua95GrZ3KFyxKFn0y3ZIqa15Jrs3G3yFyrW8Xa97Ka18
        WFWFvrs8Wa12vw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbXdbUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: bibo mao <maobibo@loongson.cn>

If there are two threads reading the same memory and tlb miss happens,
one thread fills pte entry, the other reads new pte value during page fault
handling. PTE value may be updated before page faul, so the process need
need update tlb still.

Also this patch define flush_tlb_fix_spurious_fault as empty, since it not
necessary to flush the page for all CPUs

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/mips/include/asm/pgtable.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index aab0ec1..d0a4940 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -635,6 +635,26 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 	return pmd;
 }
 
+#define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+int ptep_set_access_flags(struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep,
+			pte_t entry, int dirty)
+{
+	int changed = !pte_same(*ptep, entry);
+
+	if (changed)
+		set_pte_at(vma->vm_mm, address, ptep, entry);
+	else
+		/* update tlb with latest pte entry still, tlb entry is old
+		 * since there is page fault
+		 */
+		update_mmu_cache(vma, address, ptep);
+
+	return changed;
+}
+
 /*
  * The generic version pmdp_huge_get_and_clear uses a version of pmd_clear() with a
  * different prototype.
-- 
1.8.3.1

