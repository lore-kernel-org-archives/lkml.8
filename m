Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93119C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9A420663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="B/PhvFjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgCPMh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:37:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7673 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbgCPMgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwl615Gbz9v02h;
        Mon, 16 Mar 2020 13:36:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=B/PhvFjR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 48D5OFzLj0p6; Mon, 16 Mar 2020 13:36:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwl602rkz9v02f;
        Mon, 16 Mar 2020 13:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362162; bh=ICMxCBMNGcTfz0cst3VWC9Qy4LnOx0ZwiA0OhAg96c8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=B/PhvFjRA2bt7iIWvGy0579aw2F8jGDilok+ZGqJxG2UjMCjs0wC3YZBwEFJl2PM+
         PIVhaheQfSnzfCVKK//Ew970wImOkdN+EMFeC/kZ09gpLvEcSF92KKAS5VaJoTcemj
         g5JWsspmKirAXXoVsGEuCUCPKJ42jHiym/CM6WhI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F210A8B7D2;
        Mon, 16 Mar 2020 13:36:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NJWxDvuUzYcX; Mon, 16 Mar 2020 13:36:06 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A61CF8B7CB;
        Mon, 16 Mar 2020 13:36:06 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9C2C365595; Mon, 16 Mar 2020 12:36:06 +0000 (UTC)
Message-Id: <8b0e2f8614261e6565f8345341a563aa3f99c270.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 21/46] powerpc/mm: Standardise
 __ptep_test_and_clear_young() params between PPC32 and PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC32, __ptep_test_and_clear_young() takes the mm->context.id

In preparation of standardising pte_update() params between PPC32 and
PPC64, __ptep_test_and_clear_young() need mm instead of mm->context.id

Replace context param by mm.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 7 ++++---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index d1108d25e2e5..8122f0b55d21 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -288,18 +288,19 @@ static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long
  * for our hash-based implementation, we fix that up here.
  */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
 	if (old & _PAGE_HASHPTE) {
 		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(context, addr, ptephys, 1);
+		flush_hash_pages(mm->context.id, addr, ptephys, 1);
 	}
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
-	__ptep_test_and_clear_young((__vma)->vm_mm->context.id, __addr, __ptep)
+	__ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9eaf386a747b..ddf681ceb860 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -256,14 +256,15 @@ static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long
 }
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
-	__ptep_test_and_clear_young((__vma)->vm_mm->context.id, __addr, __ptep)
+	__ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-- 
2.25.0

