Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00672C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C971B2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="s+rIPQDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbgEYNzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403805AbgEYNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:55:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E739C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:55:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so13771475qts.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5qQiY+ZXVw5IFFJYnTIFYyj/ziMbEL19deOcInariiA=;
        b=s+rIPQDib3dWy7Qcs1M3vaRswSUZvO59bqqwm56bvqNnzsd4cGfc/7y1P/ukq2S2M3
         PRgCBF4I5yOX75Y1qMGHQ9N7hpD66Xa2ylF+nsSHZz8eI/+R17sLGS34WG6yB1hnYtTn
         fxgQqHsvaLBcRm1G99YsDEQTL4oizD8LMOq/huB8wT3l24mnRuG0YjrjGeM61fQ7Yxm+
         PxYDwaAhhug9Q3qyQPQNKrd0BIyQJNbC4QQNoLdQPKvIXkt5/9xKXKxiWrU5gmRF6gSm
         MvlWmdS1pugo0AAxExtGgv/BHg7s/CpyKeuTsDu4Txn9GcpG1IiEwgP5o/gSoah3gXe1
         EeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5qQiY+ZXVw5IFFJYnTIFYyj/ziMbEL19deOcInariiA=;
        b=PHaJHh8dnjqVOsNf7Heaqj5wTGJvb9EQNtyNfpJ5A8JVI6vpPiCuj6AOTDGIf16vDM
         rxt+3azMpOA4CPuEseoXtBwnuXDkuLa4K3D1Xp79sIfSRyeGec36Yo0cxfCgqhRPCBI6
         5rxRIt4j39vTUhb/l4G/LRpSrwRl1ZhDQFnlQl48R8RnQLqi+Yt9jzoaIeH2j/gwSXrN
         ippxAoo7csy071gj4umypuVuwut0iiG8pxynXEHxzsNYybeXt/+9bEejYXfRfsK0in3J
         mi3qzBHH7A6+DS5Rtaf0t0H5VvI6VEu6RCAuiCtTXRPzQCBQ5NeJcydTAE4al2fgpfqy
         EnIw==
X-Gm-Message-State: AOAM533pYkShE+/pUmSzBiLOEZ5WVClDlxeKqQiUHqgIPbDZ4DF/wZkb
        yD8+WQx2YzYLpRlXCin4LthDMw==
X-Google-Smtp-Source: ABdhPJx1pZ0HniR8T/jbB4G1WDzMkmj7aTRZoPixQJ2Jm50F2Q986QYmKu3Ld6Mw176pQBYwWMNCPA==
X-Received: by 2002:aed:3f55:: with SMTP id q21mr14482318qtf.190.1590414947129;
        Mon, 25 May 2020 06:55:47 -0700 (PDT)
Received: from ovpn-112-169.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e34sm15059240qtb.21.2020.05.25.06.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:55:46 -0700 (PDT)
Date:   Mon, 25 May 2020 09:55:40 -0400
From:   Qian Cai <cai@lca.pw>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC linux-next PATCH] mm: khugepaged: remove error message when
 checking external pins
Message-ID: <20200525135540.GA18914@ovpn-112-169.phx2.redhat.com>
References: <1589317383-9595-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200521145644.GA6367@ovpn-112-192.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521145644.GA6367@ovpn-112-192.phx2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:56:51AM -0400, Qian Cai wrote:
> On Wed, May 13, 2020 at 05:03:03AM +0800, Yang Shi wrote:
> []
> >  mm/khugepaged.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 1fdd677..048f5d4 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -602,12 +602,6 @@ static bool is_refcount_suitable(struct page *page)
> >  	if (PageSwapCache(page))
> >  		expected_refcount += compound_nr(page);
> >  
> > -	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
> > -		pr_err("expected_refcount (%d) > refcount (%d)\n",
> > -				expected_refcount, refcount);
> > -		dump_page(page, "Unexpected refcount");
> > -	}
> > -
> >  	return page_count(page) == expected_refcount;
> >  }
> 
> mm/khugepaged.c: In function 'is_refcount_suitable':
> mm/khugepaged.c:575:25: warning: variable 'refcount set but not used [-Wunused-but-set-variable]
>   int expected_refcount, refcount;
>                          ^~~~~~~~ 
> 
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -572,9 +572,8 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>  
>  static bool is_refcount_suitable(struct page *page)
>  {
> -	int expected_refcount, refcount;
> +	int expected_refcount;
>  
> -	refcount = page_count(page);
>  	expected_refcount = total_mapcount(page);
>  	if (PageSwapCache(page))
>  		expected_refcount += compound_nr(page); 

Andrew, can you squash this fix?
