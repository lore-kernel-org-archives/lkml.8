Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E57C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB5320773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fHwgFWQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIBPKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:10:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727907AbgIBPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:10:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082F2gkI099692;
        Wed, 2 Sep 2020 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=idFinTFt53LnBLvBNw1JCHMSrI/TFogzCHjKFuTZk7w=;
 b=fHwgFWQe4VRFJtY3lLw2/Gx3mIZkKhdJ2OAHVHG+OQ/C6YEOLjhjClMXttv5EOPFJx9j
 tZwvyT85dnEgULjJ3YYSSDOy7tzbkJfYHNyOyeMQHdA2jcPXj+eQtsaBKAHfYbUI8xva
 miaUz49cOt5Rr8maAgHW1XQMa7ZuxqTp0MuKGUfPe6rv83mTzoI7mXnzqJko+K+9eILe
 8lVBmfkCG4o7Rkeumgk9cTr504HFUUS9JObkPxBXTZqsHQcHGbUVeOGvdiBxaFC9daMn
 8tYmMLBuu522NrXBabqJTgn4Ba5kFaxV4H4GjxJVaz0NtRxK678lnFQbZtSJxOjiQQXF xQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33adk58h5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 11:10:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082F7M88031536;
        Wed, 2 Sep 2020 15:10:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8cuk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 15:10:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082FA0BO30409090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 15:10:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A18952052;
        Wed,  2 Sep 2020 15:10:00 +0000 (GMT)
Received: from thinkpad (unknown [9.171.44.120])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 284C05204F;
        Wed,  2 Sep 2020 15:10:00 +0000 (GMT)
Date:   Wed, 2 Sep 2020 17:09:58 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200902170958.09be0c3e@thinkpad>
In-Reply-To: <20200902142437.5f39b4bb@thinkpad>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
        <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
        <20200901194020.418da486@thinkpad>
        <91988792-069c-31a6-7840-0122357538c7@nvidia.com>
        <20200902142437.5f39b4bb@thinkpad>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 14:24:37 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Tue, 1 Sep 2020 16:22:22 -0700
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
> > On 9/1/20 10:40 AM, Gerald Schaefer wrote:
> > > On Mon, 31 Aug 2020 12:15:53 -0700
> > > Andrew Morton <akpm@linux-foundation.org> wrote:
> > ...
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index e8cbc2e795d5..43dacbce823f 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -681,6 +681,38 @@ static inline int arch_unmap_one(struct mm_struct *mm,
> > >   })
> > >   #endif
> > >   
> > > +/*
> > > + * With dynamic page table levels on s390, the static pXd_addr_end() functions
> > > + * will not return corresponding dynamic boundaries. This is no problem as long
> > > + * as only pXd pointers are passed down during page table walk, because
> > > + * pXd_offset() will simply return the given pointer for folded levels, and the
> > > + * pointer iteration over a range simply happens at the correct page table
> > > + * level.
> > > + * It is however a problem with gup_fast, or other places walking the page
> > > + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
> > > + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
> > > + * a stack variable, which cannot be used for pointer iteration at the correct
> > > + * level. Instead, the iteration then has to happen by going up to pgd level
> > > + * again. To allow this, provide pXd_addr_end_folded() functions with an
> > > + * additional pXd value parameter, which can be used on s390 to determine the
> > > + * folding level and return the corresponding boundary.
> > 
> > Ah OK, I finally see what you have in mind. And as Jason noted, if we just
> > pass an additional parameter to pXd_addr_end() that's going to be
> > cleaner. And doing so puts this in line with other page table
> > abstractions that also carry more information than some architectures
> > need. For example, on x86, set_pte_at() ignores the first two
> > parameters:
> > 
> > #define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
> > 
> > static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
> > 				     pte_t *ptep , pte_t pte)
> > {
> > 	native_set_pte(ptep, pte);
> > }
> > 
> > This type of abstraction has worked out very well, IMHO.
> 
> Yes, it certainly feels like the right way to do it, and it would
> not affect other archs in a functional way. It would however introduce
> a subtle change for s390 behavior on _all_ page table walkers, not
> just the READ_ONCE gup_fast path, i.e. it changes the level at which
> the pointer iteration is done. Of course, that *should* not have any
> functional issues, or else it would also be broken in gup_fast, but
> in this area we often were wrong with should / could assumptions...

Hmm, not so sure about that "not affect other archs", that might also
be one of those *should*s. Consider this change to mm/mlock.c from
our current internal generalization work, for example:

diff --git a/mm/mlock.c b/mm/mlock.c
index 93ca2bf30b4f..dbde97f317d4 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -374,8 +374,12 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 			struct vm_area_struct *vma, struct zone *zone,
 			unsigned long start, unsigned long end)
 {
-	pte_t *pte;
 	spinlock_t *ptl;
+	pte_t *pte;
+	pmd_t *pmd;
+	pud_t *pud;
+	p4d_t *p4d;
+	pgd_t *pgd;
 
 	/*
 	 * Initialize pte walk starting at the already pinned page where we
@@ -384,10 +388,14 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 	 */
 	pte = get_locked_pte(vma->vm_mm, start,	&ptl);
 	/* Make sure we do not cross the page table boundary */
-	end = pgd_addr_end(start, end);
-	end = p4d_addr_end(start, end);
-	end = pud_addr_end(start, end);
-	end = pmd_addr_end(start, end);
+	pgd = pgd_offset(vma->vm_mm, start);
+	end = pgd_addr_end(*pgd, start, end);
+	p4d = p4d_offset(pgd, start);
+	end = p4d_addr_end(*p4d, start, end);
+	pud = pud_offset(p4d, start);
+	end = pud_addr_end(*pud, start, end);
+	pmd = pmd_offset(pud, start);
+	end = pmd_addr_end(*pmd, start, end);
 
 	/* The page next to the pinned page is the first we will try to get */
 	start += PAGE_SIZE;

I guess we *could* assume that all the extra pXd_offset() calls and
also the de-referencing would be optimized out by the compiler for other
archs, but it is one example where my gut tells me that this might not
be so trivial and w/o unwanted effects after all.

Anyway, stay tuned, we will send a v2 of this RFC with going the
"modify pXd_addr_end" approach, including the minimal gup-specific
patch plus on top the generalization work. Then we might get a better
picture of this.
