Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30511C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102312082F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgFRObf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:31:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61598 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgFRObf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:31:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49nkry4Mt8z9tvgt;
        Thu, 18 Jun 2020 16:31:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mAnU4smKTEeg; Thu, 18 Jun 2020 16:31:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49nkry2Kx1z9tvfh;
        Thu, 18 Jun 2020 16:31:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C8A98B84E;
        Thu, 18 Jun 2020 16:31:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8ZcEMSeTZQPn; Thu, 18 Jun 2020 16:31:31 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [10.25.210.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11D948B849;
        Thu, 18 Jun 2020 16:31:29 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0879F65B0A; Thu, 18 Jun 2020 14:31:29 +0000 (UTC)
Message-Id: <6ca8c972e6c920dc4ae0d4affbed9703afa4d010.1592490570.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] mm/debug_vm_pgtable: Fix build failure with powerpc 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Thu, 18 Jun 2020 14:31:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9e343b467c70 ("READ_ONCE: Enforce atomicity for
{READ,WRITE}_ONCE() memory accesses"), READ_ONCE() cannot be used
anymore to read complex page table entries. This leads to:

  CC      mm/debug_vm_pgtable.o
In file included from ./include/asm-generic/bug.h:5,
                 from ./arch/powerpc/include/asm/bug.h:109,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from mm/debug_vm_pgtable.c:13:
In function 'pte_clear_tests',
    inlined from 'debug_vm_pgtable' at mm/debug_vm_pgtable.c:363:2:
./include/linux/compiler.h:392:38: error: call to '__compiletime_assert_210' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro '__compiletime_assert'
  373 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro '_compiletime_assert'
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:405:2: note: in expansion of macro 'compiletime_assert'
  405 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:291:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
  291 |  compiletime_assert_rwonce_type(x);    \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/debug_vm_pgtable.c:249:14: note: in expansion of macro 'READ_ONCE'
  249 |  pte_t pte = READ_ONCE(*ptep);
      |              ^~~~~~~~~
make[2]: *** [mm/debug_vm_pgtable.o] Error 1

Fix it by using the recently added ptep_get() helper.

Fixes: 9e343b467c70 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/debug_vm_pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index e45623016aea..61ab16fb2e36 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -246,13 +246,13 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
 				   unsigned long vaddr)
 {
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = ptep_get(ptep);
 
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
 	set_pte_at(mm, vaddr, ptep, pte);
 	barrier();
 	pte_clear(mm, vaddr, ptep);
-	pte = READ_ONCE(*ptep);
+	pte = ptep_get(ptep);
 	WARN_ON(!pte_none(pte));
 }
 
-- 
2.25.0

