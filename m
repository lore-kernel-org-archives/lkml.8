Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA5CC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853D820716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tH/Wvg7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1Mdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:33:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37107 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgC1Mdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:33:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so10079874lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KQZhDw3BcjfJrwSpFbEwWhvgR0Y2LSUS07rGTSfFYso=;
        b=tH/Wvg7xl9d2CAmy0krh4Fh9fI+oUD/lk+rSkSscKJrhWiZLHn2O0REaooq+ncYAvR
         mg58d4CH0luazTJQZlSUCLHi9Ic6NopdDlM4pGO/Mb0T/JmC1TTdjZVYTYvOxFhw/Hpd
         mpqb0onSPacnGHrl/ELD1TAEG2AdB1kOjVkTDErLWyZ05Eq/OUOYf4eD+PoOjCkxSUVd
         SWRgQ24Vo6ed3DEsxsDGd1GJtBa85F7ihUCTPiwDt82EqUgQhcWF8D2u9cPuxbdiR4ND
         h5Rozs68JxQ2xROcjgEt3DMZr/X0uH2L2av7btqXD5GoB/vHdjNvwZtyBroJUk6EIJ95
         lmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQZhDw3BcjfJrwSpFbEwWhvgR0Y2LSUS07rGTSfFYso=;
        b=LkVfSMh6ycc2zahifJ8beJFw13u35/knDq123/XkeKKKzukRMnxsj6uPvpW3GzKdqd
         B7Ki07I468BndsgEbCJXNKBYrw6UPT5+KtbEmZG4Z9voX0Z4fITUhtS70wLXUcoflPQN
         /CQoStxzAcB3RGJLJM/o5+EBXaDt+TCioXy6FPKWOAtyhPlfEgunDIpx6axZ0VCDUvHA
         2FtNP0WAekGA6PWkUySn7+kDePZDrKUg/E0m/WKUzz/Bl+k/7kUesfBVou4U90zDqAd9
         D3Isqcg6NvNw8jSpMKR8HCu6DUreOEmHKMrDINPxLfeZDt6qpaku3RzeRUKW9U9SONID
         aZ1A==
X-Gm-Message-State: AGi0PuYSQ0C5c4vHlVpdMujKRKcTa/rcLZY4UsD7F7Ay/eI2z9yqcEa+
        40NwMRp0ckxjCfSxZSbD8LUNFg==
X-Google-Smtp-Source: APiQypLHNzvIacsbuhQ6IWlLoIOu+8+JHKy8rIWKCVX/sis41dB17skJXXOzuwoTIuyXNq/EubS2UA==
X-Received: by 2002:a19:4843:: with SMTP id v64mr2488531lfa.171.1585398813399;
        Sat, 28 Mar 2020 05:33:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t1sm3874634ljo.94.2020.03.28.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 05:33:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BAAF5100D25; Sat, 28 Mar 2020 15:33:36 +0300 (+03)
Date:   Sat, 28 Mar 2020 15:33:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200328123336.givyrh5hsscg5cpx@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
 <D5721ED6-774B-4CD3-8533-4BF9BDB2401E@nvidia.com>
 <20200328003920.xvkt3hp65uccsq7b@box>
 <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8EBF52B-BC6A-4778-81AA-DDEFC9BF6157@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:17:00PM -0400, Zi Yan wrote:
> > The compound page may be locked here if the function called for the first
> > time for the page and not locked after that (becouse we've unlocked it we
> > saw it the first time). The same with LRU.
> >
> 
> For the first time, the compound page is locked and not on LRU, so this VM_BUG_ON passes.
> For the second time and so on, the compound page is unlocked and on the LRU,
> so this VM_BUG_ON still passes.
> 
> For base page, VM_BUG_ON passes.
> 
> Other unexpected situation (a compound page is locked and on LRU) triggers the VM_BU_ON,
> but your VM_BUG_ON will not detect this situation, right?

Right. I will rework this code. I've just realized it is racy: after
unlock and putback on LRU the page can be locked by somebody else and this
code can unlock it which completely borken.

I'll pass down compound_pagelist to release_pte_pages() and handle the
situation there.

> >>>     if (likely(writable)) {
> >>>             if (likely(referenced)) {
> >>
> >> Do we need a list here? There should be at most one compound page we will see here, right?
> >
> > Um? It's outside the pte loop. We get here once per PMD range.
> >
> > 'page' argument to trace_mm_collapse_huge_page_isolate() is misleading:
> > it's just the last page handled in the loop.
> >
> 
> Throughout the pte loop, we should only see at most one compound page, right?

No. mremap(2) opens a possibility for HPAGE_PMD_NR compound pages for
single PMD range.


-- 
 Kirill A. Shutemov
