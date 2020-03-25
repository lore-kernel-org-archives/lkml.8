Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDBBC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AF920775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="N1qHxAU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYL00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:26:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46728 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgCYL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:26:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so1961872ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YOfrzNtBD+kaSq3A3o6ofrhotN+4gW4t0TzfIyOGf6g=;
        b=N1qHxAU8daqgzKVA78lW1z8YiWgnyQflNvanwAbaaSbxe+J6qsWIiYobd8fHoKVJAT
         3pzs0pJSa3qhLC4wTSVnZIUW+cr+9Kck5ptl0DQbp7+nJKbKrgIifDJKIkVZOTsI4XJk
         DXEOT8fI2Tj8Xgup8Rp78iA43fQJFXNleB6Tpdt3ASUW2I6QzHbGKAwcYK5Kk2XsqZlO
         z4o94BI4nhziUaiOGhBtPDMV5+Z0k9NycrxFI2GzvhreAbN4Wg70JVSh9QIyh5d/HM17
         aeOaPfErX/ejPcovWvvoX6yB69UZ51xHfKeoQYPfGjJq1XS9Sje7GMcNFSxwjfaNDvc/
         a3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YOfrzNtBD+kaSq3A3o6ofrhotN+4gW4t0TzfIyOGf6g=;
        b=c6KkQTPWOF0HBCkXoA/LrA9IwsCqPZjf8TmlbqBJ4LHrvf+IhaDJ2KzWiprV+r8n1C
         JqCDv0x/NUiN26O5avKuhLWrKGoutRWk+1ZPUWdLBrYI604jUHj2a9D0G9qa2vqjCYuj
         qdLPRIUEidLwQt3e5jPoucFGBn52u17BjLlggPLhp5i3CCRYNu7ZiUvQn3GLRla5wHfG
         28jKWtNPcPykMyWkF1PGVxlLJRO9y9RQxrO+BvY+dODmLJtTjGKzYEjyckM7fbtpJueE
         6a8/9YQNeb6ljjLt4xNhIkdp53ZUNcV7mbSSu9xkGODO76ipnwnisUnwaqJTO5K7DTfC
         Fgow==
X-Gm-Message-State: ANhLgQ3a9L0qckgBWNv8dhwswQ7p59VjUCCrkfO15usQzWWGEgBDCycS
        O5dK+h9uO1Ol/jbZzWS4ivTIRw==
X-Google-Smtp-Source: ADFU+vtoB2CKJ9MUshcTofbsGK5QAiU+q6+TSbvsyySoYsuH66LVFaZ+n2c2xv0jk4QHgC5PAs/71A==
X-Received: by 2002:a2e:b4e9:: with SMTP id s9mr1386148ljm.108.1585135583316;
        Wed, 25 Mar 2020 04:26:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t1sm11416204lji.98.2020.03.25.04.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:26:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E53A61020AF; Wed, 25 Mar 2020 14:26:23 +0300 (+03)
Date:   Wed, 25 Mar 2020 14:26:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
Message-ID: <20200325112623.ur4owwbnow5c5mng@box>
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200319001258.creziw6ffw4jvwl3@box>
 <2cdc734c-c222-4b9d-9114-1762b29dafb4@linux.alibaba.com>
 <db660bef-c927-b793-7a79-a88df197a756@linux.alibaba.com>
 <20200319104938.vphyajoyz6ob6jtl@box>
 <99b78cdb-5a4d-e28b-4464-d34ee39e5501@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b78cdb-5a4d-e28b-4464-d34ee39e5501@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:17:13AM -0700, Yang Shi wrote:
> 
> 
> On 3/19/20 3:49 AM, Kirill A. Shutemov wrote:
> > On Wed, Mar 18, 2020 at 10:39:21PM -0700, Yang Shi wrote:
> > > 
> > > On 3/18/20 5:55 PM, Yang Shi wrote:
> > > > 
> > > > On 3/18/20 5:12 PM, Kirill A. Shutemov wrote:
> > > > > On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
> > > > > > When khugepaged collapses anonymous pages, the base pages would
> > > > > > be freed
> > > > > > via pagevec or free_page_and_swap_cache().  But, the anonymous page may
> > > > > > be added back to LRU, then it might result in the below race:
> > > > > > 
> > > > > >      CPU A                CPU B
> > > > > > khugepaged:
> > > > > >     unlock page
> > > > > >     putback_lru_page
> > > > > >       add to lru
> > > > > >                  page reclaim:
> > > > > >                    isolate this page
> > > > > >                    try_to_unmap
> > > > > >     page_remove_rmap <-- corrupt _mapcount
> > > > > > 
> > > > > > It looks nothing would prevent the pages from isolating by reclaimer.
> > > > > Hm. Why should it?
> > > > > 
> > > > > try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
> > > > > protected by ptl. And this particular _mapcount pin is reachable for
> > > > > reclaim as it's not part of usual page table tree. Basically
> > > > > try_to_unmap() will never succeeds until we give up the _mapcount on
> > > > > khugepaged side.
> > > > I don't quite get. What does "not part of usual page table tree" means?
> > > > 
> > > > How's about try_to_unmap() acquires ptl before khugepaged?
> > The page table we are dealing with was detached from the process' page
> > table tree: see pmdp_collapse_flush(). try_to_unmap() will not see the
> > pte.
> 
> A follow-up question here. pmdp_collapse_flush() clears pmd entry and does
> TLB shootdown on x86. I'm supposed the main purpose is to serialize fast gup
> since it doesn't acquire any lock (mmap_sem, ptl ,etc), but disable
> interrupt so the TLB shootdown IPI would get blocked. This could guarantee
> synchronization on x86, but it looks not all architectures do TLB shootdown
> or implement it via IPI, so how they could serialize with fast gup?

The main purpose of pmdp_collapse_flush() is to block access to pages
under collapse, including access via GUP (and its variants).

It's up to architecture to implement it correctly, including TLB flush vs.
GUP_fast serialization. Genetic way works fine for most architectures.
Notable exceptions are Power and S390.

> In addition it looks acquiring pmd lock is not necessary. Before both write
> mmap_sem and write anon_vma lock are acquired which could serialize page
> fault and rmap walk, so it looks fast gup is the only one which could run
> concurrently, but fast gup doesn't acquire ptl at all. It seems the
> pmd_lock/unlock could be removed.

This is likely true. And we have a comment there. But taking uncontended
lock is check, so why not.

-- 
 Kirill A. Shutemov
