Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A382C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C64220738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HO+B/Vs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgEVNdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgEVNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:33:43 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B80C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:33:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id d1so4696413qvl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OJPtBO5fmTTaWhSyWjmcp4bLb1ODXwI1HZb2MVRuSrs=;
        b=HO+B/Vs0fG0dX2f482MYjKlz50owpKdPJx3oKJmiRRX+4cnEVto2lrMy/dOZhbiifz
         Ao7g28y88lmaF3/S43LJvmmiPs/V1b17YIJ7uKBLEoF8Q0gPtS5v+xEZ4Nztd8GY6HlQ
         19Ikja1eGIQaAf8/uYyCOKFH88kcfrnFCryyBvFr1fzjLjXajckuFD6M0tuKcgu4dssL
         BZZJNPRYqqhncHrvSjZQ3yjW6c6/t1QkAc5du40LrvudCv5WvNbcJQwFs8unz72RcQLU
         NtzfEZJ49+gWO/7myExdDPaxENqNboC2D6+w6j0HEjgvtsC29zkhaz61ihb/Rm/89ZZj
         tVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJPtBO5fmTTaWhSyWjmcp4bLb1ODXwI1HZb2MVRuSrs=;
        b=epHg5tvQ5F8AHnvXTw77KSdW0EszwlPoF74tWFAfHw/qruQhVeEAbEKa/WZIhis0q6
         34Us7Q9sZuwT3Fdpur1J+alsMquejegOnFpBL2AhEfwT8qZVtwUwK7dRM0EIglg32SBJ
         t8oPBLwVt91aO3z2GJxXEvOWxq8VpH03USvQusG5aySjdm+mmk0OFaA4XCkuOdaVpVzB
         AhE2fk2to8WsKMosTbD0M/pgKtMnBQGsrKOWVNZ0mfXCqrMZp3qq1DnIl0mFcuxf/8Qr
         cNwTHQLc+Jm4nUDNbpRyAnE9NqQLp+C8V5lB1z3AMM0Thr6RoUtosViVluuDbMd8UTVx
         34Mw==
X-Gm-Message-State: AOAM5315QOrQsTWaYqMxCRm02/PFjWlR5Q5Ho5mHiGrJla1amlIrQCQQ
        OiVUZVLA/aVyLmmZ4RSnPCjWDw==
X-Google-Smtp-Source: ABdhPJxbewbRX/Ts4Y9fzEt5gZHRZaShxSaLAa1tzmXd0uhUXABvvvQRi4bi1zs4Q57wjfUEIO02sA==
X-Received: by 2002:ad4:4690:: with SMTP id bq16mr3655502qvb.20.1590154422147;
        Fri, 22 May 2020 06:33:42 -0700 (PDT)
Received: from Qians-MacBook-Air.local (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o6sm1325452qtd.59.2020.05.22.06.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 06:33:41 -0700 (PDT)
Date:   Fri, 22 May 2020 09:33:35 -0400
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 09/14] mm: deactivations shouldn't bias the LRU balance
Message-ID: <20200522133335.GA624@Qians-MacBook-Air.local>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-10-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520232525.798933-10-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 07:25:20PM -0400, Johannes Weiner wrote:
> Operations like MADV_FREE, FADV_DONTNEED etc. currently move any
> affected active pages to the inactive list to accelerate their reclaim
> (good) but also steer page reclaim toward that LRU type, or away from
> the other (bad).
> 
> The reason why this is undesirable is that such operations are not
> part of the regular page aging cycle, and rather a fluke that doesn't
> say much about the remaining pages on that list; they might all be in
> heavy use, and once the chunk of easy victims has been purged, the VM
> continues to apply elevated pressure on those remaining hot pages. The
> other LRU, meanwhile, might have easily reclaimable pages, and there
> was never a need to steer away from it in the first place.
> 
> As the previous patch outlined, we should focus on recording actually
> observed cost to steer the balance rather than speculating about the
> potential value of one LRU list over the other. In that spirit, leave
> explicitely deactivated pages to the LRU algorithm to pick up, and let
> rotations decide which list is the easiest to reclaim.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/swap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 5d62c5a0c651..d7912bfb597f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -515,14 +515,12 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  
>  	if (active)
>  		__count_vm_event(PGDEACTIVATE);
> -	lru_note_cost(lruvec, !file, hpage_nr_pages(page));
>  }
>
[]

mm/swap.c: In function 'lru_deactivate_file_fn':
mm/swap.c:504:11: warning: variable 'file' set but not used
[-Wunused-but-set-variable]
  int lru, file;
           ^~~~  

This?

diff --git a/mm/swap.c b/mm/swap.c
index fedf5847dfdb..9c38c1b545af 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -501,7 +501,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
 static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 			      void *arg)
 {
-	int lru, file;
+	int lru;
 	bool active;
 
 	if (!PageLRU(page))
@@ -515,7 +515,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		return;
 
 	active = PageActive(page);
-	file = page_is_file_lru(page);
 	lru = page_lru_base_type(page);
 
 	del_page_from_lru_list(page, lruvec, lru + active);

