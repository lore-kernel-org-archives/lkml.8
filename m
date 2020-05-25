Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881C8206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Fdz79PEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbgEYEzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgEYEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:55:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF0C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:55:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w15so9748210lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ta+gKITSaDFXbddptw1PycpUmizB8GirSrm5Sv99kI8=;
        b=Fdz79PEvtruLyLOx8oikptAOCD4uLGZYUKf1BFLDTPaj2cCbCMlhFQgMqqfETPXX0x
         AZ9H/1r4wGJy6VRcXJewAODKxPYihv6kv2xeyw6i9VmKCxCJFSVSMu3mSMNlQXWKqPul
         8M8HIvIARh9/Ir9GBQ4dqjSwskZasNX09MdwpC1p6N868SwXgAmqK4Z4AfWvhuYer0w/
         qnZILt634RDRm63MKcOmX2aCh3Ji8myuncnMyir4GjFHUU+GSIAgpt4lBHwLwsv5Jg8J
         /jjH3FDU8tmASZnfRtMi6vBvRRNrvtwuAImxJdLmkJ7wCZhtUIXTqICJTEjyv8mzZ5ep
         ZKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ta+gKITSaDFXbddptw1PycpUmizB8GirSrm5Sv99kI8=;
        b=FFGgseK8TqRF/gGepLBH5LfI6VtHUPNO36un6mzsb0T8R4h2sbkf1we+O/SUzH457n
         XPXDgJjkOq1jozaaw3KNHZknhzhX2RokSFxxwxWstLeIB/nhfDBabnTcjsmkL4JBafzK
         zNUNcXi3Yi26Irk5mZQx0BlSMHqXuNqkurr1k4WQLu+WD/XB+TcqrluOX7j7MoEjysUX
         GrX4hdg4G7c1S4BNrB9ltrzZjljxt0iMbqGn34czp4DmcHpTzbRHARPW5I4/e6+YC17/
         ynL+Qb1GUr3ZjSXrE1vo/31PGIsG4/UkpwnC57N1C3R8qQrSKQfKBZjIyU6B6Ivc/2C6
         wl8g==
X-Gm-Message-State: AOAM533yuq5idBqR7OxB3p7Tb5ReoL/PdR1rVpFrVv/UVDTdowMn6cqE
        Wmvl+e115Rzo+/Wiov0B16RAtA==
X-Google-Smtp-Source: ABdhPJxHYXGYhHPr163MFt0+8DI04wONMTR8geyOar2shTxMyVvgmv7QPrP+pQhnhBRd9z6ng0Fxgg==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr13359691lfb.208.1590382518277;
        Sun, 24 May 2020 21:55:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t27sm3321814ljo.114.2020.05.24.21.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:55:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 558C01012E6; Mon, 25 May 2020 07:55:18 +0300 (+03)
Date:   Mon, 25 May 2020 07:55:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/36] fs: Support THPs in zero_user_segments
Message-ID: <20200525045518.ydro3k2h5ct3pxxj@box>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-12-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:31AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We can only kmap() one subpage of a THP at a time, so loop over all
> relevant subpages, skipping ones which don't need to be zeroed.  This is
> too large to inline when THPs are enabled and we actually need highmem,
> so put it in highmem.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 15 +++++++---
>  mm/highmem.c            | 62 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index ea5cdbd8c2c3..74614903619d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -215,13 +215,18 @@ static inline void clear_highpage(struct page *page)
>  	kunmap_atomic(kaddr);
>  }
>  
> +#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
> +		unsigned start2, unsigned end2);
> +#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
>  static inline void zero_user_segments(struct page *page,
> -	unsigned start1, unsigned end1,
> -	unsigned start2, unsigned end2)
> +		unsigned start1, unsigned end1,
> +		unsigned start2, unsigned end2)
>  {
> +	unsigned long i;
>  	void *kaddr = kmap_atomic(page);
>  
> -	BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
> +	BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
>  
>  	if (end1 > start1)
>  		memset(kaddr + start1, 0, end1 - start1);
> @@ -230,8 +235,10 @@ static inline void zero_user_segments(struct page *page,
>  		memset(kaddr + start2, 0, end2 - start2);
>  
>  	kunmap_atomic(kaddr);
> -	flush_dcache_page(page);
> +	for (i = 0; i < hpage_nr_pages(page); i++)
> +		flush_dcache_page(page + i);

Well, we need to settle on whether flush_dcache_page() has to be aware
about compound pages. There are already architectures that know how to
flush compound page, see ARM.

-- 
 Kirill A. Shutemov
