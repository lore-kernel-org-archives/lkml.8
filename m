Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123392071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BzCIAFKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgIARkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:40:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgIARkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:40:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081HWgbH144338;
        Tue, 1 Sep 2020 13:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=txXV2LkfEo8PniSoj6d8lbzpZ8u5aDLvCN1vaGh0B4M=;
 b=BzCIAFKxUFSDUtMQTJuVqvc40fVbiCKJmU3Ba72s6bjPE8sANS2+agRF5d2zZGDHH4Tw
 pqTA7rlot602p/24340jh7eTXuQ0hCigzrL12kuLKVIxHbtxqSYRnXMMc4JKpJ3l4nVm
 cx0S38MKHqmDTXA8k4JPUhh3SyQtr73ybMurpDfmnz6D0g7IwGeE9EbJ1gKInGosbyeT
 Q8TcHNUkgH7wbR7gouKSNQ1SeG3PGwn+4gY5o/wnYKV6bYsqm4CMuOkDYpDtPVNbI58E
 JZePcqguJ/cB1zDk72Zug0R59zwNoX6yDuPA0wztoX6Qjr+MCmg4aUdLZpAYxtTx9tfV 0w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339smjadvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 13:40:27 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 081Hb8fJ005423;
        Tue, 1 Sep 2020 17:40:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gupwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 17:40:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 081HeM3c11207004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 17:40:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF96411C05B;
        Tue,  1 Sep 2020 17:40:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A7AA11C054;
        Tue,  1 Sep 2020 17:40:21 +0000 (GMT)
Received: from thinkpad (unknown [9.171.39.228])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  1 Sep 2020 17:40:21 +0000 (GMT)
Date:   Tue, 1 Sep 2020 19:40:20 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200901194020.418da486@thinkpad>
In-Reply-To: <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
        <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_10:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 12:15:53 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 31 Aug 2020 13:53:36 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > 
> > 
> > On 28.08.20 16:03, Gerald Schaefer wrote:
> > have some feedback soon if option 1 or option 2 would be acceptable 
> > from a common code perspective. Andrew, who of the mm people would 
> > be the right one to decide?
> 
> Jason and John Hubbard are doing most of the work in there at present,
> 
> Both patches look OK to me from a non-s390 perspective.  Unless we plan
> to implement Jason's more-general approach this time, I'd be inclined
> to defer to the s390 people as to the preferred implementation.

My gut feeling would say that the gup_pXd_addr_end approach makes
us behave more like other archs, at least for gup_fast, which cannot
be so bad.

Regarding generalization, both approaches would introduce some specific
helpers for this "page table walking w/o lock using READ_ONCE", currently
only used by gup_fast. What we initially had in mind wrt generalization
was replacing e.g. the pXd_addr_end() completely, with the new version that
takes the additional pXd value parameter. That would of course be quite
intrusive, also affecting other arch code, so it is probably not what we
want to do in the first step.

To make it a bit more generic and also usable for future paths in
mm/pagewalk.c for example, we could however at least name the new helpers
differently, e.g. pXd_addr_end_folded instead of gup_pXd_addr_end, and
also add some comment on why / where they should be used, like this
(will send again as proper patch with description if agreed):

---
 arch/s390/include/asm/pgtable.h | 49 +++++++++++++++++++++++++++++++++
 include/linux/pgtable.h         | 32 +++++++++++++++++++++
 mm/gup.c                        |  8 +++---
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7eb01a5459cd..d74257f2cb5b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -512,6 +512,55 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
 }
 #define mm_pmd_folded(mm) mm_pmd_folded(mm)
 
+static inline unsigned long rste_addr_end_folded(unsigned long rste,
+						unsigned long addr, unsigned long end)
+{
+	unsigned int type = rste & _REGION_ENTRY_TYPE_MASK;
+	unsigned long size, mask, boundary;
+
+	switch (type) {
+	case _REGION_ENTRY_TYPE_R1:
+		size = PGDIR_SIZE;
+		mask = PGDIR_MASK;
+		break;
+	case _REGION_ENTRY_TYPE_R2:
+		size = P4D_SIZE;
+		mask = P4D_MASK;
+		break;
+	case _REGION_ENTRY_TYPE_R3:
+		size = PUD_SIZE;
+		mask = PUD_MASK;
+		break;
+	default:
+		BUG();
+	};
+
+	boundary = (addr + size) & mask;
+
+	return (boundary - 1) < (end - 1) ? boundary : end;
+}
+
+#define pgd_addr_end_folded pgd_addr_end_folded
+static inline unsigned long pgd_addr_end_folded(pgd_t pgd, unsigned long addr,
+						unsigned long end)
+{
+	return rste_addr_end_folded(pgd_val(pgd), addr, end);
+}
+
+#define p4d_addr_end_folded p4d_addr_end_folded
+static inline unsigned long p4d_addr_end_folded(p4d_t p4d, unsigned long addr,
+						unsigned long end)
+{
+	return rste_addr_end_folded(p4d_val(p4d), addr, end);
+}
+
+#define pud_addr_end_folded pud_addr_end_folded
+static inline unsigned long pud_addr_end_folded(pud_t pud, unsigned long addr,
+						unsigned long end)
+{
+	return rste_addr_end_folded(pud_val(pud), addr, end);
+}
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..43dacbce823f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -681,6 +681,38 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 })
 #endif
 
+/*
+ * With dynamic page table levels on s390, the static pXd_addr_end() functions
+ * will not return corresponding dynamic boundaries. This is no problem as long
+ * as only pXd pointers are passed down during page table walk, because
+ * pXd_offset() will simply return the given pointer for folded levels, and the
+ * pointer iteration over a range simply happens at the correct page table
+ * level.
+ * It is however a problem with gup_fast, or other places walking the page
+ * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
+ * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
+ * a stack variable, which cannot be used for pointer iteration at the correct
+ * level. Instead, the iteration then has to happen by going up to pgd level
+ * again. To allow this, provide pXd_addr_end_folded() functions with an
+ * additional pXd value parameter, which can be used on s390 to determine the
+ * folding level and return the corresponding boundary.
+ */
+#ifndef pgd_addr_end_folded
+#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
+#endif
+
+#ifndef p4d_addr_end_folded
+#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
+#endif
+
+#ifndef pud_addr_end_folded
+#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
+#endif
+
+#ifndef pmd_addr_end_folded
+#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
+#endif
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..3157bc5ede24 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2510,7 +2510,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end_folded(pmd, addr, end);
 		if (!pmd_present(pmd))
 			return 0;
 
@@ -2553,7 +2553,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end_folded(pud, addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
@@ -2581,7 +2581,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end_folded(p4d, addr, end);
 		if (p4d_none(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
@@ -2606,7 +2606,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
 
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end_folded(pgd, addr, end);
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_huge(pgd))) {
