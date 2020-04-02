Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32899C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16B2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585813581;
	bh=aBVpqJG+LFGZoi0fKFFCEhCWw5Y4o90PCQFNuj0LpGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cgtlK69zn+MdiXo2mH3AAr6ONU9pm+pRjLPoVehjYXLsnYygtcmTFnucWeyHSspVm
	 AS3xMXi9tcKoPDO/TOpjxXkx5hJVcAImkjTB5XYIJ4gMjgtYCC3kFsknQgNzZAdJP0
	 IoxNBCzzs51/9x31h4Mo0xp2V4H6Ou3zguk7M8GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgDBHqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:46:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37577 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgDBHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:46:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so2984813wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDCBs32L1KcXkZ7wG0r7SiXyvbQn5EWGQiflqAKz2OE=;
        b=ZAqur54AwdU+p459SPfEgwc1Q9Nq0PeSgIcIiz1t5m8hOUTJPIB+ot7i6OA8JPx38d
         dVzOF0x994bNL5ORJwaL7nYG2MOyxILI3aOauGY6/pz60NoOM2Uqk22LbatVHlrz1LyV
         F0f/O2wo9Il5InXcJRMlcRYCUVawE4xMRo4Dmt4oc03ahH6wQj2PvLoRJIO9Vq9JOeJg
         liWtiH34Bfp3ep0C2Qkwqeu4F7sYsBvWe2x0tSyGxEy9DP8etAU6RD6Qya8CQcziDJca
         9QhIfrqXCGFRNjldf6WAjr8PTTRLitotjnYKnG41P1q+CkJancioKDcm5EGuAM/7VjyP
         L7Kw==
X-Gm-Message-State: AGi0Pua/fiIoCskcBUy1LmJAkhuWtYbfMos98Alc/B5pSYO3v0VIeNmC
        347/Z72tR4HL0tF5O4kuXwM=
X-Google-Smtp-Source: APiQypLDUOaH4PG1oEwOpBo0rvJqszmH5HaUgyIoZbvL77QLnerpzPGsO/LyOynGM3AR+fsBhN1urg==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr2140994wro.68.1585813577515;
        Thu, 02 Apr 2020 00:46:17 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id f3sm6311128wmj.24.2020.04.02.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:46:16 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:46:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org, vbabka@suse.cz
Subject: Re: [PATCH v2 1/2] mm: call touch_nmi_watchdog() on max order
 boundaries in deferred init
Message-ID: <20200402074615.GI22681@dhcp22.suse.cz>
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401225723.14164-2-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have only now noticed that you have reposted.

On Wed 01-04-20 18:57:22, Pavel Tatashin wrote:
> From: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> deferred_init_memmap() disables interrupts the entire time, so it calls
> touch_nmi_watchdog() periodically to avoid soft lockup splats.  Soon it
> will run with interrupts enabled, at which point cond_resched() should
> be used instead.
> 
> deferred_grow_zone() makes the same watchdog calls through code shared
> with deferred init but will continue to run with interrupts disabled, so
> it can't call cond_resched().
> 
> Pull the watchdog calls up to these two places to allow the first to be
> changed later, independently of the second.  The frequency reduces from
> twice per pageblock (init and free) to once per max order block.
> 
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Cc: stable@vger.kernel.org # 4.17+

This patch is not fixing anything, right? It cleans up the code to make
further changes easier which is good.

> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..e8ff6a176164 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1639,7 +1639,6 @@ static void __init deferred_free_pages(unsigned long pfn,
>  		} else if (!(pfn & nr_pgmask)) {
>  			deferred_free_range(pfn - nr_free, nr_free);
>  			nr_free = 1;
> -			touch_nmi_watchdog();
>  		} else {
>  			nr_free++;
>  		}
> @@ -1669,7 +1668,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>  			continue;
>  		} else if (!page || !(pfn & nr_pgmask)) {
>  			page = pfn_to_page(pfn);
> -			touch_nmi_watchdog();
>  		} else {
>  			page++;
>  		}
> @@ -1809,8 +1807,10 @@ static int __init deferred_init_memmap(void *data)
>  	 * that we can avoid introducing any issues with the buddy
>  	 * allocator.
>  	 */
> -	while (spfn < epfn)
> +	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		touch_nmi_watchdog();
> +	}
>  zone_empty:
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> @@ -1894,6 +1894,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  		first_deferred_pfn = spfn;
>  
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		touch_nmi_watchdog();
>  
>  		/* We should only stop along section boundaries */
>  		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
