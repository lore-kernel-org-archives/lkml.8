Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F55206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592212960;
	bh=LJWu7suHyYS3LPQHRvBhA04H9UmqMAq3G8wYqGH0MHc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DZxDOMrKBr89c5VtplGyNTFRBP934qJ0c5g4fcbdwdrMkG6Yuu9vX2YJ3njw+lzhY
	 /aD0RfoK3sQ6I0nsNKu4Pg0dUYpug/ZwSQICasqTETG7+ZqLWhEno1V5t88094izza
	 0Su7u0GfbTsD29drnrzWo65pkJD26yXQeAboG+9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgFOJWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbgFOJWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:22:38 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE9C20663;
        Mon, 15 Jun 2020 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592212958;
        bh=LJWu7suHyYS3LPQHRvBhA04H9UmqMAq3G8wYqGH0MHc=;
        h=From:To:Cc:Subject:Date:From;
        b=pGoJELSvq3s9Or8aB+njE9anV3oq0VzFK0WG+4DOlkS1x/6SQoSLbZo1N/cygh7B4
         pR7ASBawiKab3fWsXK7hRS2KA1RyExOvJ0LiqA5KCFL+WRDERAHYeiBrqL5Xi5Bv/z
         AJf4LAmhiEIeOsu9J5dvgJZFT+ekszO7C5hFTSsc=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] powerpc/8xx: use pmd_off() to access a PMD entry in pte_update()
Date:   Mon, 15 Jun 2020 12:22:29 +0300
Message-Id: <20200615092229.23142-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The pte_update() implementation for PPC_8xx unfolds page table from the PGD
level to access a PMD entry. Since 8xx has only 2-level page table this can
be simplified with pmd_off() shortcut.

Replace explicit unfolding with pmd_off() and drop defines of pgd_index()
and pgd_offset() that are no longer needed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

I think it's powerpc material, but I won't mind if Andrew picks it up :)


 arch/powerpc/include/asm/nohash/32/pgtable.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b56f14160ae5..5a590ceaec14 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -205,10 +205,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
-/* to find an entry in a page-table-directory */
-#define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
-#define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
-
 /*
  * PTE updates. This function is called whenever an existing
  * valid PTE is updated. This does -not- include set_pte_at()
@@ -230,6 +226,8 @@ static inline void pmd_clear(pmd_t *pmdp)
  * For other page sizes, we have a single entry in the table.
  */
 #ifdef CONFIG_PPC_8xx
+static pmd_t *pmd_off(struct mm_struct *mm, unsigned long addr);
+
 static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
 				     unsigned long clr, unsigned long set, int huge)
 {
@@ -237,7 +235,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 	pte_basic_t old = pte_val(*p);
 	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
 	int num, i;
-	pmd_t *pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), addr), addr), addr);
+	pmd_t *pmd = pmd_off(mm, addr);
 
 	if (!huge)
 		num = PAGE_SIZE / SZ_4K;
-- 
2.26.2

