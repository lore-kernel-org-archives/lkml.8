Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD70BC2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E582078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="TLYqu91y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDINeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:34:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36305 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDINeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:34:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id b1so11493630ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Vgk6oCSYvrjAGKLtGVWWkRAQatuTUuM8JMEQf5SJx8=;
        b=TLYqu91yttSM47tfXSXCvp8mRTc65L/D8DOJUGMEQnu1y8K0MpMsczORR6nAwU3JDJ
         A5hT+JM9h2BJ947I3czDycOfQG+bLBbBhOR0sZvzLUimmsq1hW51Hi1FASkh0WhziVg+
         L07IgEmyAepQsUmc5cF2srADXQuzWXx4d3T5FdxTCRb7TUBmcn7EPgc03P+gXiG3kaht
         NBQ3NN9rrA97R6v/X1zodcJ/MReRg8vkVBisOufvjDXmj3b+RFdDkT+Ztx747MMl+40F
         GaTIns4U387kUaH0PRNFMdKpkta/8YdDFaybmqi9p10ejiExU5S73xG4onS/L5MT43+2
         0kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Vgk6oCSYvrjAGKLtGVWWkRAQatuTUuM8JMEQf5SJx8=;
        b=AqKTqW/U3b7CWcCuKBz27UaxmEIp1rnCfcOdMfGuIp1f+u47fFeV7eLpz682WR8S3E
         sh9RDussEJXjiO+/ldisSWsX36xNhO+APJaQUXFAte4GioXCsWw3VtE8XjQpHOilJTDY
         l1SPLJGCyquOB64de5GmBKsjkAwSZH7/AvdOb+7oKggs2Z95HnTmrkG7m8XWthWGviur
         SuZT0n64mFVIfOnRCdpKV0y+tHlPM7PWh/1sBpCDOfevdRxOVh4i/slIEUiTLtflpzR6
         D0+1XSKoC7N5h8UTJXVcvc/2erdW3w67PwZ+C5WH//+KhiaA7m63S0QzsrrijzEsBlIs
         I3jA==
X-Gm-Message-State: AGi0PuZxg3dvBSbIJKcsmyvvyaiW6KBh0NEOjKN7wBXINoGSTWepTxIi
        unNMvCh6bpI4G7TqwJ18kvWCjg==
X-Google-Smtp-Source: APiQypJ6KkyqPWjmiARGJb4GMmD6r6UhhCPaTqqAr9+l4kbL923UwTHb/hvQyUarqQyT4sfaP11c8g==
X-Received: by 2002:a2e:909a:: with SMTP id l26mr5767532ljg.177.1586439256849;
        Thu, 09 Apr 2020 06:34:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s8sm1717523lfd.61.2020.04.09.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 06:34:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DAB8F102132; Thu,  9 Apr 2020 16:34:14 +0300 (+03)
Date:   Thu, 9 Apr 2020 16:34:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 2/8] khugepaged: Do not stop collapse if less than half
 PTEs are referenced
Message-ID: <20200409133414.hcynyxggt24nitd5@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-3-kirill.shutemov@linux.intel.com>
 <7d3af6a4-b0ee-9497-da0b-b93e050c5a4c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3af6a4-b0ee-9497-da0b-b93e050c5a4c@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 12:53:00PM -0700, Ralph Campbell wrote:
> 
> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> > __collapse_huge_page_swapin() check number of referenced PTE to decide
> > if the memory range is hot enough to justify swapin.
> > 
> > The problem is that it stops collapse altogether if there's not enough
> > referenced pages, not only swappingin.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
> > Reviewed-by: Zi Yan <ziy@nvidia.com> ---
> >   mm/khugepaged.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 99bab7e4d05b..14d7afc90786 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
> >   	/* we only decide to swapin, if there is enough young ptes */
> >   	if (referenced < HPAGE_PMD_NR/2) {
> >   		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> 
> The trace point is recording the return value. Shouldn't you s/0/1 to match?

Good catch.

> 
> > -		return false;
> > +		/* Do not block collapse, only skip swapping in */
> > +		return true;
> >   	}
> >   	vmf.pte = pte_offset_map(pmd, address);
> >   	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
> > 
> 
> So "referenced < HPAGE_PMD_NR/2" means swapped out pages aren't faulted back in
> but there could still be no swapped out pages, just "old" pages so collapse could
> succeed. Seems like this check could have been made in khugepaged_scan_pmd() when
> "referenced" is being computed and "unmapped" is available. Just skip setting
> "ret = 1" if unmapped > 0 && referenced < HPAGE_PMD_NR/2.

Good point. I'll change the code to address it.

-- 
 Kirill A. Shutemov
