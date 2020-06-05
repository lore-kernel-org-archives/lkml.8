Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F31C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611BD207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFEKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:01:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgFEKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:01:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0559Xbkx135857;
        Fri, 5 Jun 2020 06:01:07 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fgkkxq5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 06:01:07 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0559uoBT028507;
        Fri, 5 Jun 2020 10:01:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 31bf47ctxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 10:01:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055A12lq61735254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 10:01:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB337A4055;
        Fri,  5 Jun 2020 10:01:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6D41A4051;
        Fri,  5 Jun 2020 10:01:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.20.147])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  5 Jun 2020 10:01:01 +0000 (GMT)
Date:   Fri, 5 Jun 2020 13:00:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200605100059.GB7524@linux.ibm.com>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605081644.GS6857@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_02:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=5
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:16:44AM +0200, Joerg Roedel wrote:
> On Thu, Jun 04, 2020 at 02:12:14PM -0700, Linus Torvalds wrote:
> > That said, the commentary about "why is p.._alloc_track() in such a
> > core header file, when it's only used by two special cases" is
> > probably still true regardless of the 5-level fixup header.. I assume
> > Mike didn't do those kinds of changes?
> 
> I'll try to move them to a separate header next week. The compile
> testing I set up for this patch-set will certainly be helpful for that
> :)

We already have include/asm-generic/pgalloc.h, so maybe something like
that patch below would fork. This is not even compile tested.

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 73f7421413cb..7aa9c98aff47 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -102,6 +102,66 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 	__free_page(pte_page);
 }
 
+static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
+		unsigned long address)
+{
+	return (unlikely(pgd_none(*pgd)) && __p4d_alloc(mm, pgd, address)) ?
+		NULL : p4d_offset(pgd, address);
+}
+
+static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
+		unsigned long address)
+{
+	return (unlikely(p4d_none(*p4d)) && __pud_alloc(mm, p4d, address)) ?
+		NULL : pud_offset(p4d, address);
+}
+
+static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+
+{
+	if (unlikely(pgd_none(*pgd))) {
+		if (__p4d_alloc(mm, pgd, address))
+			return NULL;
+		*mod_mask |= PGTBL_PGD_MODIFIED;
+	}
+
+	return p4d_offset(pgd, address);
+}
+
+static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+{
+	if (unlikely(p4d_none(*p4d))) {
+		if (__pud_alloc(mm, p4d, address))
+			return NULL;
+		*mod_mask |= PGTBL_P4D_MODIFIED;
+	}
+
+	return pud_offset(p4d, address);
+}
+
+static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
+{
+	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
+		NULL: pmd_offset(pud, address);
+}
+
+static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+{
+	if (unlikely(pud_none(*pud))) {
+		if (__pmd_alloc(mm, pud, address))
+			return NULL;
+		*mod_mask |= PGTBL_PUD_MODIFIED;
+	}
+
+	return pmd_offset(pud, address);
+}
+
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 3f1649a8cf55..36ac65f4744f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -14,7 +14,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
 #include <linux/hugetlb_inline.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 86adc71a972f..29a3d7c492f0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2068,69 +2068,6 @@ static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 int __pte_alloc_kernel(pmd_t *pmd);
 
-#if defined(CONFIG_MMU)
-
-static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
-		unsigned long address)
-{
-	return (unlikely(pgd_none(*pgd)) && __p4d_alloc(mm, pgd, address)) ?
-		NULL : p4d_offset(pgd, address);
-}
-
-static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
-		unsigned long address)
-{
-	return (unlikely(p4d_none(*p4d)) && __pud_alloc(mm, p4d, address)) ?
-		NULL : pud_offset(p4d, address);
-}
-
-static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
-				     unsigned long address,
-				     pgtbl_mod_mask *mod_mask)
-
-{
-	if (unlikely(pgd_none(*pgd))) {
-		if (__p4d_alloc(mm, pgd, address))
-			return NULL;
-		*mod_mask |= PGTBL_PGD_MODIFIED;
-	}
-
-	return p4d_offset(pgd, address);
-}
-
-static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
-				     unsigned long address,
-				     pgtbl_mod_mask *mod_mask)
-{
-	if (unlikely(p4d_none(*p4d))) {
-		if (__pud_alloc(mm, p4d, address))
-			return NULL;
-		*mod_mask |= PGTBL_P4D_MODIFIED;
-	}
-
-	return pud_offset(p4d, address);
-}
-
-static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
-{
-	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
-		NULL: pmd_offset(pud, address);
-}
-
-static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
-				     unsigned long address,
-				     pgtbl_mod_mask *mod_mask)
-{
-	if (unlikely(pud_none(*pud))) {
-		if (__pmd_alloc(mm, pud, address))
-			return NULL;
-		*mod_mask |= PGTBL_PUD_MODIFIED;
-	}
-
-	return pmd_offset(pud, address);
-}
-#endif /* CONFIG_MMU */
-
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
diff --git a/lib/ioremap.c b/lib/ioremap.c
index ad485f08173b..357e5909a364 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static int __read_mostly ioremap_p4d_capable;
diff --git a/mm/mremap.c b/mm/mremap.c
index 7d69e3fe51aa..4a6c4db8747b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -27,6 +27,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 #include "internal.h"
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3091c2ca60df..84a6d08416a2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -39,6 +39,7 @@
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
+#include <asm/pgalloc.h>
 
 #include "internal.h"
 

> 
> 	Joerg
> 

-- 
Sincerely yours,
Mike.
