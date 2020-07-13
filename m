Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9ABC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E21A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594625803;
	bh=ds9dL4MgEucsIpY0y4maLR0IcTtDcRqxbPU8RpaEFUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pUQfHWAue/WWx43SxpGGwY88MrgH5Fp9+0Y053T+7DfQF+UjwHQoD7lMve3lEiun8
	 Lpzqeh3FsSkiTBI9F4nTwULWadW7yJFKWOj5M3UyJSp+StMYH+/a3uq7rZ8z3aBjCj
	 jIa9apAvSI9OJTnNz5k42cA2GubYzVcQa8hCY//U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgGMHgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:36:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36026 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:36:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id dg28so12148035edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNlyLtDhTs070oxTSGZLaWp85Uxt5nsU4hq+3vO7k6g=;
        b=bxTcVJM/lli17CIFEmAGsWYbaGF5PnKq20uZwEAy5mYJi4KRhhar7FQUVHA1kN81N9
         I1r3HNCLzaYOnBpFqO/D97xXIRdBpG0inFnp2f4mWh49kxbl2pWcZApLcHCA6c/fhzQL
         e8kQerXlLK4rEz6W/DUFKtLGkmI+Ii//4Yn3eIDYIdfMhJgEMJ3QO2U1BIxE/UJN1HWY
         yRFJIg6cavaddVOFEIiZpthnDoNoGMUuaAyobOGQ8AQtmZKhAI7XmohYjo9UDzzc7Q4O
         bb0922cBEeyP7K9uh+9+hEHR9Ai5CKogQ+cBUJWCn/PWhrgPkixUtrHi92gfBbct6heX
         oDIw==
X-Gm-Message-State: AOAM5310OGaQaqXcULmjTNWZ5bW15FZB8nK/aZ8UA1uZEbyI2ndRGjVd
        78Nu16XxLkR0exKKpLEq7T8=
X-Google-Smtp-Source: ABdhPJwjAhFlCdCjn5HBG5LEiyBMZOyq0K+5Cn3M42gDs1iilObhr+c6UCzNEv2XsXdxpQAMc/ay+w==
X-Received: by 2002:a05:6402:143c:: with SMTP id c28mr5630804edx.54.1594625799916;
        Mon, 13 Jul 2020 00:36:39 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id rv16sm9263187ejb.60.2020.07.13.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:36:39 -0700 (PDT)
Date:   Mon, 13 Jul 2020 09:36:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v5 4/9] mm/migrate: clear __GFP_RECLAIM to make the
 migration callback consistent with regular THP allocations
Message-ID: <20200713073636.GC16783@dhcp22.suse.cz>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594622517-20681-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594622517-20681-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-07-20 15:41:52, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_page_nodemask is a migration callback and it tries to use a common
> gfp flags for the target page allocation whether it is a base page or a
> THP. The later only adds GFP_TRANSHUGE to the given mask. This results
> in the allocation being slightly more aggressive than necessary because
> the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
> allocations usually exclude this flag to reduce over eager background
> reclaim during a high THP allocation load which has been seen during
> large mmaps initialization. There is no indication that this is a
> problem for migration as well but theoretically the same might happen
> when migrating large mappings to a different node. Make the migration
> callback consistent with regular THP allocations.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3b3d918..1cfc965 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
>  	}
>  
>  	if (PageTransHuge(page)) {
> +		/*
> +		 * clear __GFP_RECALIM to make the migration callback
> +		 * consistent with regular THP allocations.
> +		 */
> +		gfp_mask &= ~__GFP_RECLAIM;
>  		gfp_mask |= GFP_TRANSHUGE;
>  		order = HPAGE_PMD_ORDER;
>  	}
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
