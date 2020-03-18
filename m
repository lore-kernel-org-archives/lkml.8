Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2CC4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D6C2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="W3My0/kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCRXkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:40:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38675 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:40:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id w1so382346ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXfbgXntHAqJkORLDplPcK3uRdwwGaipj0NNSSNRkKE=;
        b=W3My0/kqe4GSUvBRYSNeCxLRetpxovuA2EubrEcXHvECMKfgV7i1qsI10ajL3n5Spy
         y6mMwH2YLGS4Pc7bfO44lCELTKfi1WfPSaI7gsYtckhtSi55vKtr39eP2KI9XcM8DhTC
         O8S24T245kzt1pBnCugHuGrpmI+d7xi3UzI5/XpTcMXdcRn9NrjfbwjUF6TcFzgn/s0Q
         yS7VaRDStDbaTNS4PmysDhfHjuQjwWpif3MpCAKJKSnKGNI6qf59EeYr+sFVUeUBlILK
         H+IX9FpvI/3u4RTn6kt5SCjsXBXc1XZC+i8Gn5ekFkWDV47VG245c24tBfwExv1rFe5L
         6q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXfbgXntHAqJkORLDplPcK3uRdwwGaipj0NNSSNRkKE=;
        b=s0p8AMakCjBmOr2XAHdTY4L2UWcjbHbogmCuarUSUTLFapZRB2BJvaKv/yAX4ty96P
         +BmNfp6q5+8iAJMHrGCaMO+OVOzfKd/LVhtr4UZE1CXI+20XI6UJ/Ht8QOY6lRe9Mql2
         sSYM+T0av9g1CBh4ipq+BKuSgFljVbbBBfNreIWPaIDXjdbrz4wYy9Az+s75kmSFLUsR
         EmatZARdPejxYDSzLe9SZbhKe2PclCvZr84scaPvICDMMt28YuN6M87v6Jx8Y0QyaV0p
         P0fTddxREfBLJlvbtWPDLJV2R9h73Dul+LagTaXJfZV3JRb3m1MneHqvOGcPZJoZSMdb
         TmoA==
X-Gm-Message-State: ANhLgQ3UWpGN/EeXp1mNlQrTXGpWjl6BVnyW9fybcjJqHPuS5W9W0gy0
        lCDJ1nue4t/i73z3a2uVdc5fUlJp2Fc=
X-Google-Smtp-Source: ADFU+vseHJop6X8zK5vE01ZnCbmWQzXFU7FlKUmuZ1iaSSoHrH+T0fLRmlRNcrgZi/XBGUa5TjbZ3g==
X-Received: by 2002:a2e:2415:: with SMTP id k21mr267028ljk.9.1584574835031;
        Wed, 18 Mar 2020 16:40:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u10sm90760ljj.88.2020.03.18.16.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 16:40:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6855E1025D1; Thu, 19 Mar 2020 02:40:36 +0300 (+03)
Date:   Thu, 19 Mar 2020 02:40:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
Message-ID: <20200318234036.aw3awl25gxrjd2jl@box>
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
> When khugepaged collapses anonymous pages, the base pages would be freed
> via pagevec or free_page_and_swap_cache().  But, the anonymous page may
> be added back to LRU, then it might result in the below race:
> 
> 	CPU A				CPU B
> khugepaged:
>   unlock page
>   putback_lru_page
>     add to lru
> 				page reclaim:
> 				  isolate this page
> 				  try_to_unmap
>   page_remove_rmap <-- corrupt _mapcount
> 
> It looks nothing would prevent the pages from isolating by reclaimer.
> 
> The other problem is the page's active or unevictable flag might be
> still set when freeing the page via free_page_and_swap_cache().  The
> putback_lru_page() would not clear those two flags if the pages are
> released via pagevec, it sounds nothing prevents from isolating active
> or unevictable pages.
> 
> However I didn't really run into these problems, just in theory by visual
> inspection.
> 
> And, it also seems unnecessary to have the pages add back to LRU again since
> they are about to be freed when reaching this point.  So, clearing active
> and unevictable flags, unlocking and dropping refcount from isolate
> instead of calling putback_lru_page() as what page cache collapse does.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/khugepaged.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b679908..f42fa4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -673,7 +673,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  			src_page = pte_page(pteval);
>  			copy_user_highpage(page, src_page, address, vma);
>  			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
> -			release_pte_page(src_page);
>  			/*
>  			 * ptl mostly unnecessary, but preempt has to
>  			 * be disabled to update the per-cpu stats
> @@ -687,6 +686,15 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  			pte_clear(vma->vm_mm, address, _pte);
>  			page_remove_rmap(src_page, false);
>  			spin_unlock(ptl);
> +
> +			dec_node_page_state(src_page,
> +				NR_ISOLATED_ANON + page_is_file_cache(src_page));
> +			ClearPageActive(src_page);
> +			ClearPageUnevictable(src_page);
> +			unlock_page(src_page);
> +			/* Drop refcount from isolate */
> +			put_page(src_page);
> +
>  			free_page_and_swap_cache(src_page);
>  		}
>  	}

I will look at this closer tomorrow, but looks like an easier fix is to
move release_pte_page() under ptl that we take just after it.

-- 
 Kirill A. Shutemov
