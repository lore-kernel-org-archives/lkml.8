Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A0C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F5E206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qsaB9olm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgDVNHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726323AbgDVNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:07:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C1C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:07:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l78so2213744qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/d88ptbHW16yolwYgjYhhzxJpVgAUC7qN1Ke/LGyuQ=;
        b=qsaB9olmzPIZAD6whvSiEFkbwl6xLcgwsnRvannVlmAsxdFLZ/RRfMEjlKmi/6OOgu
         kHYx+tcAXRlSCo/zbrWDhApTqyKO8wuvGNbYSxBaWHI2Ud0Rs082zBJMw1ZunAJesho0
         fckblzPFrqXW7GtRmvi4suci54vNSBw6essdzZyE7g2hkcBXcgzQlweIKFZN3nv2d7Hk
         FGXqOUG57vbo7S1jjGLXCJSvYV/owIdJHJjJM41nlfZS7pDLfdoRPDQx5NNfkj3cp8na
         5sNWxBCG1/yv29Os99j9OCm7iFk016k5Dy3MdH1Oe0xQwj0K7gfEPZlGC10SkI+EAgct
         UJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/d88ptbHW16yolwYgjYhhzxJpVgAUC7qN1Ke/LGyuQ=;
        b=pNXtlE+HRc2/Z5zb4lj7TBshhZqUe2OMVTP0cqVxOFFAbzPNLUfbCyOvbVd+9rqLux
         BZu8H4o48k+00SwPO/CUX2avLwACqJp+QYUOjuXa7oVtf8118rliRTryMmfFT7fo9kZa
         atoGSGn6/cj6G6wONNv/F8ICleUjVRVHYAnPT7O6oP01kZuvNVoIRHoWaRnBIVm2DzL1
         HAJI1CFunLRbd/w9pwmY/qrbeLZQYyFrTpjJKuzxTXIW1l00RsKv2iUmUKdY0PvlpAfX
         m+qaMETAUGtsxAkcdEVPO5LrOH0XTjqZjZnnHXe3gw/I2hRyvl1VPVeLL++QXb0D6idi
         /MfA==
X-Gm-Message-State: AGi0PubEbC5T1QSjDK5q++AmrZbDR4HQp9VI6wR7TiMmkaGpZfmZUFzf
        pwPUuE6/yHzRItIkrpz/BgHz/Q==
X-Google-Smtp-Source: APiQypL1fBcrWfoKQ0nPr8lMaz276Ln1+S7PiOroBrRFY9NDcuKY1pmKurdoqkNaldPVIeTpKzqXRw==
X-Received: by 2002:a37:a9c7:: with SMTP id s190mr27254227qke.435.1587560873513;
        Wed, 22 Apr 2020 06:07:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id t27sm3739061qkg.4.2020.04.22.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:07:52 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:07:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, mgorman@suse.de, m.szyprowski@samsung.com,
        mina86@mina86.com, shli@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com
Subject: Re: [PATCH v2] mm/vmscan: count layzfree pages and fix nr_isolated_*
 mismatch
Message-ID: <20200422130751.GD358439@cmpxchg.org>
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
 <20200422084815.21913-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422084815.21913-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:48:15PM +0900, Jaewon Kim wrote:
> @@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		 */
>  		if (page_mapped(page)) {
>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>  
>  			if (unlikely(PageTransHuge(page)))
>  				flags |= TTU_SPLIT_HUGE_PMD;
> +
>  			if (!try_to_unmap(page, flags)) {
>  				stat->nr_unmap_fail += nr_pages;
> +				if (lazyfree && PageSwapBacked(page))

This looks pretty strange, until you remember that try_to_unmap()
could SetPageSwapbacked again.

This might be more obvious?

			was_swapbacked = PageSwapBacked(page);
			if (!try_to_unmap(page, flags)) {
				stat->nr_unmap_fail += nr_pages;
				if (!was_swapbacked && PageSwapBacked(page))
> +					stat->nr_lazyfree_fail += nr_pages;
>  				goto activate_locked;

Or at least was_lazyfree.

> @@ -1491,8 +1495,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  		.priority = DEF_PRIORITY,
>  		.may_unmap = 1,
>  	};
> -	struct reclaim_stat dummy_stat;
> -	unsigned long ret;
> +	struct reclaim_stat stat;
> +	unsigned long reclaimed;

nr_reclaimed would be better.

I also prefer keeping dummy_stat, since that's still what it is.
