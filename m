Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD0FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0E324670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579035741;
	bh=8fbFTVsVS4GidZaEWzOWjrKbrqylVcd/KMLGffuKT5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MF1utUNdgX2zKoTUhyNgtnKVfx6O1BSQsf4S3ddK8jUigSDFyDbtKrsvDPDZkabuv
	 tzeN2lROjUhSEzXsBzh+pPx4IJsNK4HJMmMN6h4GxTruQqMr7DGFCoWesyZJU0ILsq
	 qoXlx0CjOC0pZ8UomGpz/O7Q3jRDgsPus7LIMuJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANVCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:02:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:02:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so13661454wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l77KtsOfNd0cs5BnhlgAfKFicPNamjeiI3/uAn8/oZQ=;
        b=jnF1T9azP+f+rL78bCrJiRgAyfCzbFONcC7ZE0LtQVYYggLSvFHoTG8w2klbJTmkhz
         hUEEw8ENmG5S9WNHwgoWOkEczB+zrqg8Uad4ELCT4OBWNbsZRs4iAtEh1rx0t2qNBQ9T
         XuumS/sRO2kGz60AK4yeXloffGa9EUl0Z3fMg6yk6dTivSmuERP8thT+GtvkFAB+bgW9
         6HqMQfFbKrhQSp7R9vhC4kk7kB/qWgYpm5u1vpJ5vVaHp2RTX97DRCLRHx/uz7RDOjMM
         Hbi3Q/VRaBv2ZL9Y99SZ2zEhrEySVhsmTqHbs5ZLQvR9rBpUahNo4Sir8Lc0vledrpza
         uDcQ==
X-Gm-Message-State: APjAAAXl8gqSicIWMQLdH5dPHxjVj0zsMy2LDfJmLEeiM5WXwZdlBraY
        ODjjsmsxPGI0Bg5lldt7TlI=
X-Google-Smtp-Source: APXvYqwnyT/Am63E6gvJAIngyYQf5/d6L7e4MnF+7XYpoVNdfnRvyYqiJRxaG9v/j0o2j+EBFlgtyw==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr28531469wrv.79.1579035737959;
        Tue, 14 Jan 2020 13:02:17 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id t12sm20925635wrs.96.2020.01.14.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 13:02:16 -0800 (PST)
Date:   Tue, 14 Jan 2020 22:02:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-ID: <20200114210215.GQ19428@dhcp22.suse.cz>
References: <20200114201114.14696-1-cai@lca.pw>
 <6d9d2923-a44c-60fb-5caa-e6228cb8aaf5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9d2923-a44c-60fb-5caa-e6228cb8aaf5@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-01-20 21:20:08, David Hildenbrand wrote:
> On 14.01.20 21:11, Qian Cai wrote:
> > Similar to the recent commit [1] merged into the random and -next trees,
> > it is not a good idea to call printk() with zone->lock held. The
> > standard fix is to use printk_deferred() in those places, but memory
> > offline will call dump_page() which need to defer after the lock. While
> > at it, remove a similar but unnecessary debug printk() as well.
> > 
> > [1] https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  include/linux/page-isolation.h |  2 +-
> >  mm/memory_hotplug.c            |  2 +-
> >  mm/page_alloc.c                | 12 +++++-------
> >  mm/page_isolation.c            | 10 +++++++++-
> >  4 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> > index 148e65a9c606..5d8ba078006f 100644
> > --- a/include/linux/page-isolation.h
> > +++ b/include/linux/page-isolation.h
> > @@ -34,7 +34,7 @@ static inline bool is_migrate_isolate(int migratetype)
> >  #define REPORT_FAILURE	0x2
> >  
> >  bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
> > -			 int flags);
> > +			 int flags, char *dump);
> >  void set_pageblock_migratetype(struct page *page, int migratetype);
> >  int move_freepages_block(struct zone *zone, struct page *page,
> >  				int migratetype, int *num_movable);
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 7a6de9b0dcab..f10928538fa3 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1149,7 +1149,7 @@ static bool is_pageblock_removable_nolock(unsigned long pfn)
> >  		return false;
> >  
> >  	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
> > -				    MEMORY_OFFLINE);
> > +				    MEMORY_OFFLINE, NULL);
> >  }
> >  
> >  /* Checks if this range of memory is likely to be hot-removable. */
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e56cd1f33242..b6bec3925e80 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8204,7 +8204,7 @@ void *__init alloc_large_system_hash(const char *tablename,
> >   * race condition. So you can't expect this function should be exact.
> >   */
> >  bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
> > -			 int flags)
> > +			 int flags, char *dump)
> >  {
> >  	unsigned long iter = 0;
> >  	unsigned long pfn = page_to_pfn(page);
> > @@ -8305,8 +8305,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
> >  	return false;
> >  unmovable:
> >  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> > -	if (flags & REPORT_FAILURE)
> > -		dump_page(pfn_to_page(pfn + iter), reason);
> > +	if (flags & REPORT_FAILURE) {
> > +		page = pfn_to_page(pfn + iter);
> > +		strscpy(dump, reason, 64);
> > +	}
> >  	return true;
> >  }
> >  
> > @@ -8711,10 +8713,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
> >  		BUG_ON(!PageBuddy(page));
> >  		order = page_order(page);
> >  		offlined_pages += 1 << order;
> > -#ifdef CONFIG_DEBUG_VM
> > -		pr_info("remove from free list %lx %d %lx\n",
> > -			pfn, 1 << order, end_pfn);
> > -#endif
> 
> ack to getting rid of this.

Yeah and that should go into it's own patch.

> Regarding the other stuff, I remember Michal had an opinion about the
> previous approach, so it's best if he comments.

Yeah, that was a long discussion with a lot of lockdep false positives.
I believe I have made it clear that the console code shouldn't depend on
memory allocation because that is just too fragile. If that is not
possible for some reason then it has to be mentioned in the changelog.
I really do not want us to add kludges to the MM code just because of
printk deficiencies unless that is absolutely inevitable.
-- 
Michal Hocko
SUSE Labs
