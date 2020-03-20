Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D61C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F2520732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nFFjlvQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCTLpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:45:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45367 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCTLpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:45:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so573956lfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pWbPjHYC+o2SW9jmTmeqllECnseGArz1efl29XkdYuY=;
        b=nFFjlvQ7pQEp2l9CFv+38pFxZZwmMMuZTaolsXZt4iZiwpWJJkoI0hFQUCj8zuNv6D
         suZ783bs6HKFp3AGVaSz7/wsX8WqMMM8C5RePhwhX/atSbqb64pyD5RNsh5UuwllVx3k
         8N7bztTPxMqls2wtBZT+9htJH0kF6FLzugXlNheJXjQgEqBMkyik0HwbWqt6vC+iMFz6
         jnz7Or8rFFHtd/4ItqK+52y6E9vKLgADOB7xktp6XKfN+op5SzLCnDbpqvOWe8jG+6UW
         i5JI+Zia6qoO3Seka0lUYfqx6kw5nsn3dmHX4FLKSXY+ueVLq55HiGsfqF3m6gX/fAG1
         fKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pWbPjHYC+o2SW9jmTmeqllECnseGArz1efl29XkdYuY=;
        b=Xr3N14IzvaJuoUW0wP0++YxVFnnRxRYg6zi/Ah6LPFEkq1BbEoETBRM4x3fIl/DnSz
         XAO7ucXThTwmDnpSA2bJJdyN3NPSk/qxS8p1T2ROMzLv/dOqP1Mnu6x7M/3SH2fOg4oN
         y/nLSGnP6Y4Cp8ZoPYRWh/YQ7y/SqiLK+Lp3+IsefI+1g0W6jhINpJC22fbCqDBGK07f
         J5AjVqGg7e2Lj2v808TOZrMsQng4EDkaJO9Eq9XSyh53Gy4xCRrFuhP8SVhO/kEV3Mt8
         cwyGRNvYqLZRKwIt3KmcBn/MqdKLzqC45vC/0R6j3iMP/rdgYUZe9upen8bFDeLnztmv
         XJIg==
X-Gm-Message-State: ANhLgQ3SwlsnoiTyNX7q0fwGC+2Ri1XXOtxgAWO47dE7GMQeViH6u1WZ
        Ph0FY0c/097LI4psviE9YlDd8g==
X-Google-Smtp-Source: ADFU+vsVfDBHgLfeD0LZC7cAqByG7wtuUVuzjaAYMXDUbwY/wS+RQ4hVLw2jNExdjkagIYFhP8aN0A==
X-Received: by 2002:ac2:59c6:: with SMTP id x6mr5155659lfn.177.1584704734826;
        Fri, 20 Mar 2020 04:45:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u10sm3211342ljk.56.2020.03.20.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 04:45:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CC2231020EE; Fri, 20 Mar 2020 14:45:36 +0300 (+03)
Date:   Fri, 20 Mar 2020 14:45:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
Message-ID: <20200320114536.brigxjkgjmxyhdu5@box>
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200319001258.creziw6ffw4jvwl3@box>
 <2cdc734c-c222-4b9d-9114-1762b29dafb4@linux.alibaba.com>
 <db660bef-c927-b793-7a79-a88df197a756@linux.alibaba.com>
 <20200319104938.vphyajoyz6ob6jtl@box>
 <e716c8c6-898e-5199-019c-161ea3ec06c3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e716c8c6-898e-5199-019c-161ea3ec06c3@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 09:57:47AM -0700, Yang Shi wrote:
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
> > 
> > try_to_unmap() can only reach the ptl if split ptl is disabled
> > (mm->page_table_lock is used), but it still will not be able to reach pte.
> 
> Aha, got it. Thanks for explaining. I definitely missed this point. Yes,
> pmdp_collapse_flush() would clear the pmd, then others won't see the page
> table.
> 
> However, it looks the vmscan would not stop at try_to_unmap() at all,
> try_to_unmap() would just return true since pmd_present() should return
> false in pvmw. Then it would go all the way down to __remove_mapping(), but
> freezing the page would fail since try_to_unmap() doesn't actually drop the
> refcount from the pte map.

No. try_to_unmap() checks mapcount at the end and only returns true if
it's zero.

> It would not result in any critical problem AFAICT, but suboptimal and it
> may causes some unnecessary I/O due to swap.
> 
> > 
> > > > > I don't see the issue right away.
> > > > > 
> > > > > > The other problem is the page's active or unevictable flag might be
> > > > > > still set when freeing the page via free_page_and_swap_cache().
> > > > > So what?
> > > > The flags may leak to page free path then kernel may complain if
> > > > DEBUG_VM is set.
> > Could you elaborate on what codepath you are talking about?
> 
> __put_page ->
>     __put_single_page ->
>         free_unref_page ->
>             put_unref_page_prepare ->
>                 free_pcp_prepare ->
>                     free_pages_prepare ->
>                         free_pages_check
> 
> This check would just be run when DEBUG_VM is enabled.

I'm not 100% sure, but I belive these flags will ge cleared on adding into
lru:

  release_pte_page()
    putback_lru_page()
      lru_cache_add()
       __lru_cache_add()
         __pagevec_lru_add()
	   __pagevec_lru_add_fn()
	     __pagevec_lru_add_fn()

-- 
 Kirill A. Shutemov
