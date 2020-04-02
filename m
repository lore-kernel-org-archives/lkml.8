Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B0C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786862063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585813658;
	bh=1iDhAqB6ss/90J3Wcj4v5WuuloUsVs8OUkcOKEVo6lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YQvTRRMFHpMVhtay9rXqD3PWA91l0G8oBvHsNbNkq/cssbIM2oJP6vP4z/CLecbcL
	 FAgl11xxKAUcvVc/YCj+CxjEfrPgFi5hZWz3ZHMmOV8PS0y5fzwpQbZI7XBJTzvHT3
	 MB6rKOe9+2yi0pNc/YlW8mcnkXbosQQQYW2DsiVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgDBHrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:47:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54917 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgDBHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:47:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so2297132wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVV+XLCtvLiWJ+s+cYYfQ2jchm7WNaKV/wENiGONXA0=;
        b=WnGj7noCfaoVSL6eqYPhnb9y7/sTj4OAtpkw8ogbdxRgpR9ccmKz61k8SAgOdTIzPa
         o0sizmmlZNBcxIwSJy0Vtjyt+I6XdsohRNjGDOaMrr+z1murajk0XGTR0R/eERCtJ7jJ
         ThpvjJ7Lec8ccYndhsgm6uCzkuFaXejgxYSfGZnOZNG/YSx9emJIynh+Ap8i20Dh4Z0E
         BeBIyDYjBntdecpeFDl/+EURUGJHBUCOx3JAkQXHG7tLXNzwmLldkU//ZX/m/x6F6IHI
         mJm9LZDmwPcEuIWWU3q/9zgZ50cu0pVYHnXyuAFOKuoSHOCf/MXXiw89ofr7ttubrr4y
         12vg==
X-Gm-Message-State: AGi0PubcaO5gxbGTcpHTU2FUHRWOmBbhhvETU4/nBCJuaLjSDgDq1m2D
        1JBQ5TyqyWBppvP3M9ik5p4=
X-Google-Smtp-Source: APiQypItsIJNCAbkqCX8//cpVrnP0EVMebPREAvn0zIOAKSRwEPmObDI0Ssbe2gV0A48K5yyAdGTkg==
X-Received: by 2002:a1c:b144:: with SMTP id a65mr2274349wmf.54.1585813654567;
        Thu, 02 Apr 2020 00:47:34 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id c189sm6173913wmd.12.2020.04.02.00.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:47:33 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:47:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, jmorris@namei.org, sashal@kernel.org,
        vbabka@suse.cz
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts
 enabled
Message-ID: <20200402074732.GJ22681@dhcp22.suse.cz>
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com>
 <bd3db378-f5d5-0058-0a42-4ed6033439a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3db378-f5d5-0058-0a42-4ed6033439a8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 09:38:54, David Hildenbrand wrote:
> > +	/*
> > +	 * Once we unlock here, the zone cannot be grown anymore, thus if an
> > +	 * interrupt thread must allocate this early in boot, zone must be
> > +	 * pre-grown prior to start of deferred page initialization.
> > +	 */
> > +	pgdat_resize_unlock(pgdat, &flags);
> > +
> >  	/* Only the highest zone is deferred so find it */
> >  	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> >  		zone = pgdat->node_zones + zid;
> > @@ -1809,11 +1816,9 @@ static int __init deferred_init_memmap(void *data)
> >  	 */
> >  	while (spfn < epfn) {
> >  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> > -		touch_nmi_watchdog();
> > +		cond_resched();
> 
> I do wonder if this change is strictly required in this patch (IOW, if
> we could keep calling touch_nmi_watchdog() also without holding a spinlock)

Exactly. I would go with your patch on top.
 
> Anyhow, it's the right thing to do.
> 
> >  	}
> >  zone_empty:
> > -	pgdat_resize_unlock(pgdat, &flags);
> > -
> >  	/* Sanity check that the next zone really is unpopulated */
> >  	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
> >  
> > @@ -1855,17 +1860,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
> >  
> >  	pgdat_resize_lock(pgdat, &flags);
> >  
> > -	/*
> > -	 * If deferred pages have been initialized while we were waiting for
> > -	 * the lock, return true, as the zone was grown.  The caller will retry
> > -	 * this zone.  We won't return to this function since the caller also
> > -	 * has this static branch.
> > -	 */
> > -	if (!static_branch_unlikely(&deferred_pages)) {
> > -		pgdat_resize_unlock(pgdat, &flags);
> > -		return true;
> > -	}
> > -
> >  	/*
> >  	 * If someone grew this zone while we were waiting for spinlock, return
> >  	 * true, as there might be enough pages already.
> > 
> 
> 
> I think we should also look into cleaning up deferred_grow_zone( next),
> we still have that touch_nmi_watchdog() in there. We should rework
> locking. (I think Michal requested that as well)
> 
> For now, this seems to survive my basic testing (RCU stalls gone)
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Michal Hocko
SUSE Labs
