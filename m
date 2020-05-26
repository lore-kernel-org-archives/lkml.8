Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529B4206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iuQzFAyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgEZP4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgEZP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:56:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE545C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:56:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l3so9651867qvo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EUf3sFtG1aKZLccPk3csyFRl/L7Fm5S++ouRqjtAd20=;
        b=iuQzFAyiPd+zAHIv5I+aA5+rNFzp8NkJtKGGlO2/op7F0/4jDCmrAoukvDW5Q+V0cl
         DDF5Uc/HiTXImROTvF+k/tMuNJPwbQGfu0vbVls6b1U3jD5rdyqNzo3nb0ny/LnDWJcX
         r0Lb/NCFI5fQTWYyltkP/vBbCcf6LPn5LVPCvAahhXPFV/JNxYYF4LaeaJ0b9zeyvKAc
         y95veTnYuESyDEYziLtvLjn19pYDq3Fc8QyxfGRr39aoKhh2sZBaI1jn/+0Ls4NU0RL+
         rpEadtuCarQWv0zPV0frCBqZbQO1cUSawMVdcZImBhe0MMp+QRRRQlLa1yHsxOQ98T9l
         LUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUf3sFtG1aKZLccPk3csyFRl/L7Fm5S++ouRqjtAd20=;
        b=t9OgKcNkaF4ev2CWpyzpTEVLF4gwnWbfshOE4Xrs9kVid9rv4iQfT3gFxVjlfpICNp
         gXWgzukv/QaoHoX7UZt8H6sdanMI/VILoMWFTJeprBiOtSpF1XyI+ODZ6Nsjf9nNoKe6
         jpInIr7097zvZgp4GRo7ZnPu5a9Rt21mNuX+x5l3OeMcGcxnnFOHGw9uwsrFYsZrKITn
         zPS2JoJF02rOXKe7v9tIvM9sgeV8TB8lRXywa6V9xITIDBdlo/hCOlEMzqCwi9JfTBFx
         H/GqGkwDA1W26KTOIUtnf17+YxomnZePMv/DY9C9l5uWoC9DatYbiQ0388DtwvYc78RC
         bNVg==
X-Gm-Message-State: AOAM532Z53ZBEL265OLfYYFKepuncSRSfSvkEV+fow9Ta+kP7Ls1rWAh
        D0IeIj8DGJOSRtV+de+WU9smsw==
X-Google-Smtp-Source: ABdhPJyH3g44emP9MQleoe8D8xSlnvtalmliwpMzvo7t/S/m1eVBgBWUtwsZXZ2ODlvswuL4B8PVIw==
X-Received: by 2002:ad4:43cc:: with SMTP id o12mr4920294qvs.62.1590508574205;
        Tue, 26 May 2020 08:56:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8152])
        by smtp.gmail.com with ESMTPSA id u68sm3894qkf.102.2020.05.26.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:56:13 -0700 (PDT)
Date:   Tue, 26 May 2020 11:55:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 09/14] mm: deactivations shouldn't bias the LRU balance
Message-ID: <20200526155549.GB850116@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-10-hannes@cmpxchg.org>
 <20200522133335.GA624@Qians-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522133335.GA624@Qians-MacBook-Air.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:33:35AM -0400, Qian Cai wrote:
> On Wed, May 20, 2020 at 07:25:20PM -0400, Johannes Weiner wrote:
> > Operations like MADV_FREE, FADV_DONTNEED etc. currently move any
> > affected active pages to the inactive list to accelerate their reclaim
> > (good) but also steer page reclaim toward that LRU type, or away from
> > the other (bad).
> > 
> > The reason why this is undesirable is that such operations are not
> > part of the regular page aging cycle, and rather a fluke that doesn't
> > say much about the remaining pages on that list; they might all be in
> > heavy use, and once the chunk of easy victims has been purged, the VM
> > continues to apply elevated pressure on those remaining hot pages. The
> > other LRU, meanwhile, might have easily reclaimable pages, and there
> > was never a need to steer away from it in the first place.
> > 
> > As the previous patch outlined, we should focus on recording actually
> > observed cost to steer the balance rather than speculating about the
> > potential value of one LRU list over the other. In that spirit, leave
> > explicitely deactivated pages to the LRU algorithm to pick up, and let
> > rotations decide which list is the easiest to reclaim.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/swap.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 5d62c5a0c651..d7912bfb597f 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -515,14 +515,12 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> >  
> >  	if (active)
> >  		__count_vm_event(PGDEACTIVATE);
> > -	lru_note_cost(lruvec, !file, hpage_nr_pages(page));
> >  }
> >
> []
> 
> mm/swap.c: In function 'lru_deactivate_file_fn':
> mm/swap.c:504:11: warning: variable 'file' set but not used
> [-Wunused-but-set-variable]
>   int lru, file;
>            ^~~~ 

Oops, my gcc doesn't warn about that, but yes, it's clearly dead code.

$ make mm/swap.o
  GEN     Makefile
  CALL    /home/hannes/src/linux/linux/scripts/checksyscalls.sh
  CALL    /home/hannes/src/linux/linux/scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      mm/swap.o
$
 
> This?
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index fedf5847dfdb..9c38c1b545af 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -501,7 +501,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
>  static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  			      void *arg)
>  {
> -	int lru, file;
> +	int lru;
>  	bool active;
>  
>  	if (!PageLRU(page))
> @@ -515,7 +515,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  		return;
>  
>  	active = PageActive(page);
> -	file = page_is_file_lru(page);
>  	lru = page_lru_base_type(page);
>  
>  	del_page_from_lru_list(page, lruvec, lru + active);

Looks good, and it appears Andrew has already queued it. Would you
mind providing the Signed-off-by: for it?
