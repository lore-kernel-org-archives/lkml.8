Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D38C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796472078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585812977;
	bh=s2TSyU91+ETAfvJPdXYxcQRBKju3g4NGztFiI19hsHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LArbcptJaSEjbmjiJKWJqp37aVDGmZlve0Sz6VEmqcCb1C00fjmfwUVMFjHtGpfQY
	 Sy5yWOHX7mNNpcD1jmCrvMmEyF6/ccbQdixwo3om+IAA7XpLNkNb2fRmKXd6b5a6ob
	 +9Rp1guYxH7SyePkwJoz7sr1cW3xI1JZFqFutNjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgDBHgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:36:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42428 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgDBHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:36:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so2907505wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkG5ET7XWQR6Bs9madxK9IME3VWiyyi7TqIYnv+0quw=;
        b=p2SNCHbDtVcTEQuuXAcga3XoK26jkRndeDsVI9+Iug9L6BToppmJcbdweuMcC6FlMG
         z6Mub/eJSej8khK1pQ1i1N9ZhuclUJ/DasYSG8hC47P9alXtShV9bwhVjgB/+AuxGXfd
         c3/Z5DYl98Y06SY64IjsGuuLdUJnQN/yMxOaP8TdD24/TL2QYNtxnJs2lbHE4HDdzaJ9
         KkNgd4upw4tfIH/iAgVKz10S/PvUu89bNj8RJg6UjMpd+ygT/sgw6vkqdWkLw3TMcIp9
         Gb9wTepY02F81e39jMkvb9Bg+TZI4lWLtZg12PKqMnOoqCz80qEPgc4M+4KR3Dn7Knvb
         k1tg==
X-Gm-Message-State: AGi0PuZz13l8hAdydncgt8ixOd1iPbGZ1T+JYb7sA2AyG7K2+KOb3FdN
        Clyj+ubs9fX3XqgCHuvMp5A=
X-Google-Smtp-Source: APiQypItNRsRHgeptfl803NPYB7zyFU3diPIxZHlh6/l5VgogD6aIbyqMj93jMjBr9VnVLoo9ti4Hw==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr2017736wrt.401.1585812973674;
        Thu, 02 Apr 2020 00:36:13 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a13sm6415179wrt.64.2020.04.02.00.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:36:12 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:36:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, ktkhai@virtuozzo.com,
        david@redhat.com, jmorris@namei.org, sashal@kernel.org
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
Message-ID: <20200402073612.GG22681@dhcp22.suse.cz>
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
 <20200401200027.vsm5roobllewniea@ca-dmjordan1.us.oracle.com>
 <20200401200855.d23xcwznr5cm67p2@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401200855.d23xcwznr5cm67p2@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 16:08:55, Daniel Jordan wrote:
[...]
> From: Daniel Jordan <daniel.m.jordan@oracle.com>
> Date: Fri, 27 Mar 2020 17:29:05 -0400
> Subject: [PATCH] mm: call touch_nmi_watchdog() on max order boundaries in
>  deferred init
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

This makes sense but I am not really sure this is necessary for the
stable backport.

> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 212734c4f8b0..4cf18c534233 100644
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
> @@ -1813,8 +1811,10 @@ static int __init deferred_init_memmap(void *data)
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
> @@ -1908,6 +1908,7 @@ deferred_grow_zone_locked(pg_data_t *pgdat, struct zone *zone,
>  		first_deferred_pfn = spfn;
>  
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		touch_nmi_watchdog();
>  
>  		/* We should only stop along section boundaries */
>  		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
> -- 
> 2.25.0
> 

-- 
Michal Hocko
SUSE Labs
