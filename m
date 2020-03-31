Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6C4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE13820848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="gPh353fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgCaOIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:08:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33660 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgCaOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:08:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id f20so22151570ljm.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UJGRK7ZFN5FitrI8qpwUlRmkPsdqmfO0vCxnUgHf9Us=;
        b=gPh353fjdbNOkyslZbBShGuAS9zuf6RNoWCsVavFPeWRlLf5S8cyyvrx1Xoi8zPlUx
         40vv3yF1wjVbfQtRZ4wRHXRcVwYjf7MPT64lB3c+cJsu94I936sH2EL4ZH0uZKmt7zze
         nvXK1FdENxapTWOdk2AFet8Kl6ORumizHV/7jtTbQm8GvV11DSDWDzouKQNCdPqF2Tp/
         KRU87KS3fP5KUcWU/BZIfUB9YzVp3DBCEdj4nvJ5wim3NQHhoxtFG26iTx7/9MmhCgwJ
         HSZXBVMqNbM03iapi+UotJv3iqfz9Si0Yc8/0Gd30+1FidxTD03lySB0zVxfTuWOGaD2
         hmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UJGRK7ZFN5FitrI8qpwUlRmkPsdqmfO0vCxnUgHf9Us=;
        b=VNbPL0dtsYyjh10V2vVPCvwFwvxwItL81+ZfJtSxYxrU6VI5fIERXDhW4zdMS9kikW
         UjQCKSPmnT9qvG10P9Gda+x5jEF1D5Y2sLxg3hxA26zovgIabp5SGEVi+1sbQ+QmZfx2
         GIaLgeiEzhh/10XqeK8rBZTTywMpDLsFjrTrEOzzB2JihfjvfjOBxP0j5Q8cmZJc5Ly+
         Zp1FUDRnj7cndg17E1U9ADzLHFYgp78k8soPPVHsMdAmsfOHY6dZAdiadi23cL6COeUE
         yZGpDA/U+PSaLVHwKrPBIkUHh3zvXupAXn6dWXigkIcg+tDyuxOS2btQb6Pcj36s8zX4
         daOQ==
X-Gm-Message-State: AGi0PuYhmzznOedmfalFWyP64PQA2DHnNkyziGybLYpXrdFJXzIE9+ap
        nfJqZEgcxOYbIxqOl7fdS6+NoA==
X-Google-Smtp-Source: APiQypK/nYk+A7I+aJ8g81/pNzv+sP+YhhxFRO8+TFMEwVlcvzLHQFxm8fY00+1+Jc62ylYGAyAUHw==
X-Received: by 2002:a2e:9c9:: with SMTP id 192mr9383780ljj.77.1585663708494;
        Tue, 31 Mar 2020 07:08:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z1sm5509575lfe.49.2020.03.31.07.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:08:27 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 58368101F1E; Tue, 31 Mar 2020 17:08:28 +0300 (+03)
Date:   Tue, 31 Mar 2020 17:08:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200331140828.zv6ssffwys25d2t4@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
 <20200328003920.xvkt3hp65uccsq7b@box>
 <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
 <20200328123336.givyrh5hsscg5cpx@box>
 <CAHbLzkqU1Aoo+SS3H=i6etT9Njfjk017M3vyCLeTptmGGFGRXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqU1Aoo+SS3H=i6etT9Njfjk017M3vyCLeTptmGGFGRXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:50:41AM -0700, Yang Shi wrote:
> On Sat, Mar 28, 2020 at 5:33 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Fri, Mar 27, 2020 at 09:17:00PM -0400, Zi Yan wrote:
> > > > The compound page may be locked here if the function called for the first
> > > > time for the page and not locked after that (becouse we've unlocked it we
> > > > saw it the first time). The same with LRU.
> > > >
> > >
> > > For the first time, the compound page is locked and not on LRU, so this VM_BUG_ON passes.
> > > For the second time and so on, the compound page is unlocked and on the LRU,
> > > so this VM_BUG_ON still passes.
> > >
> > > For base page, VM_BUG_ON passes.
> > >
> > > Other unexpected situation (a compound page is locked and on LRU) triggers the VM_BU_ON,
> > > but your VM_BUG_ON will not detect this situation, right?
> >
> > Right. I will rework this code. I've just realized it is racy: after
> > unlock and putback on LRU the page can be locked by somebody else and this
> > code can unlock it which completely borken.
> >
> > I'll pass down compound_pagelist to release_pte_pages() and handle the
> > situation there.
> >
> > > >>>     if (likely(writable)) {
> > > >>>             if (likely(referenced)) {
> > > >>
> > > >> Do we need a list here? There should be at most one compound page we will see here, right?
> > > >
> > > > Um? It's outside the pte loop. We get here once per PMD range.
> > > >
> > > > 'page' argument to trace_mm_collapse_huge_page_isolate() is misleading:
> > > > it's just the last page handled in the loop.
> > > >
> > >
> > > Throughout the pte loop, we should only see at most one compound page, right?
> >
> > No. mremap(2) opens a possibility for HPAGE_PMD_NR compound pages for
> > single PMD range.
> 
> Do you mean every PTE in the PMD is mapped by a sub page from different THPs?

Yes.

Well, it was harder to archive than I expected, but below is a test case,
I've come up with. It maps 512 head pages within single PMD range.

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 3a98d5b2d6d8..9ae119234a39 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -703,6 +703,63 @@ static void collapse_full_of_compound(void)
 	munmap(p, hpage_pmd_size);
 }
 
+static void collapse_compound_extreme(void)
+{
+	void *p;
+	int i;
+
+	p = alloc_mapping();
+	for (i = 0; i < hpage_pmd_nr; i++) {
+		printf("\rConstruct PTE page table full of different PTE-mapped compound pages %3d/%d...",
+				i + 1, hpage_pmd_nr);
+
+		madvise(BASE_ADDR, hpage_pmd_size, MADV_HUGEPAGE);
+		fill_memory(BASE_ADDR, 0, hpage_pmd_size);
+		if (!check_huge(BASE_ADDR)) {
+			printf("Failed to allocate huge page\n");
+			exit(EXIT_FAILURE);
+		}
+		madvise(BASE_ADDR, hpage_pmd_size, MADV_NOHUGEPAGE);
+
+		p = mremap(BASE_ADDR - i * page_size,
+				i * page_size + hpage_pmd_size,
+				(i + 1) * page_size,
+				MREMAP_MAYMOVE | MREMAP_FIXED,
+				BASE_ADDR + 2 * hpage_pmd_size);
+		if (p == MAP_FAILED) {
+			perror("mremap+unmap");
+			exit(EXIT_FAILURE);
+		}
+
+		p = mremap(BASE_ADDR + 2 * hpage_pmd_size,
+				(i + 1) * page_size,
+				(i + 1) * page_size + hpage_pmd_size,
+				MREMAP_MAYMOVE | MREMAP_FIXED,
+				BASE_ADDR - (i + 1) * page_size);
+		if (p == MAP_FAILED) {
+			perror("mremap+alloc");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	munmap(BASE_ADDR, hpage_pmd_size);
+	fill_memory(p, 0, hpage_pmd_size);
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	if (wait_for_scan("Collapse PTE table full of different compound pages", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	validate_memory(p, 0, hpage_pmd_size);
+	munmap(p, hpage_pmd_size);
+}
+
 static void collapse_fork(void)
 {
 	int wstatus;
@@ -916,6 +973,7 @@ int main(void)
 	collapse_max_ptes_swap();
 	collapse_signle_pte_entry_compound();
 	collapse_full_of_compound();
+	collapse_compound_extreme();
 	collapse_fork();
 	collapse_fork_compound();
 	collapse_max_ptes_shared();
-- 
 Kirill A. Shutemov
