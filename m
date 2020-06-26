Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F14AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8719207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593156828;
	bh=l7PXwcks1Pxu7Q4TvDpIPXUAuYmoyAkIVks3EMiTIsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jPkPZbOeZRhA2VfRfyuuqb5ZObO1MCal1UrF/+5HzJtSHoqLCCOTxiE4hiVEllU52
	 nU0ent9jMKAuic6RrhSnlMEkNb9CInsv4E4PN09ShjfSLrv5h/qeo9kNVP5SsYNlmx
	 Bm7g/KLBnKZJoBVNGWnivUdlY4TNKgal9MjJXrXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgFZHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:33:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43369 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFZHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:33:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id j4so5991749wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0BsORbavqGPY3g2MRQ6uJFdI1egNxjb5jhEOHzC1dZo=;
        b=hSiyKt+501QPEyjRqy6rjLmnjRQVbgiIUVIucCS9ND0VHNGTkNav+ar0gsV99coCeX
         ivxGMCnoI8IWAZydAYKAuxx9IK144arcwUi6FQuBzE3qXy8rLvkyo0FN7mdtp8pt4c56
         3kGzOotz7NTRMIKOkfw8m+efRTOvuOaTyLmNfRd/qm/y70yvxNY6S42hSfh5bKcLo2Ra
         BsvRszmbZl3Pjb3c8f8aD9vHh3IBHFL0QM6CVe2d4kte+dmkVtx1gpIbys4k9u+RwZed
         C8NvSmVu9Nx9KUsGaK+QkOemp1fmv4rCgSId/6KDBwICZs3g/KGVRNhoMqUHTFQ6k003
         /Qiw==
X-Gm-Message-State: AOAM532d0lZJKGXBM1htDi6w9Rd/TbGsty9ia0q5Eq6pzY5AKQygq4Db
        G3wUgTlZN4c3KzXYQ/gNqVc=
X-Google-Smtp-Source: ABdhPJwHliJaxli5h2H51YeMB/GdPDFC2mGM3N5+8iAvy6Fc/tDyXB47CRZCUVW4oiO5hPZ7wNI8Dw==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr2263115wrt.108.1593156825019;
        Fri, 26 Jun 2020 00:33:45 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id d13sm20607853wrn.61.2020.06.26.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:33:44 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:33:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 5/8] mm/migrate: make a standard migration target
 allocation function
Message-ID: <20200626073342.GU1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625120550.GF1320@dhcp22.suse.cz>
 <CAAmzW4ObN=GAzCLw8betLftTeCEsLs4OihfNXvtg4CaWyWiBCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4ObN=GAzCLw8betLftTeCEsLs4OihfNXvtg4CaWyWiBCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-06-20 14:02:49, Joonsoo Kim wrote:
> 2020년 6월 25일 (목) 오후 9:05, Michal Hocko <mhocko@kernel.org>님이 작성:
> >
> > On Tue 23-06-20 15:13:45, Joonsoo Kim wrote:
[...]
> > > -struct page *new_page_nodemask(struct page *page,
> > > -                             int preferred_nid, nodemask_t *nodemask)
> > > +struct page *alloc_migration_target(struct page *page, unsigned long private)
> > >  {
> > > -     gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> > > +     struct migration_target_control *mtc;
> > > +     gfp_t gfp_mask;
> > >       unsigned int order = 0;
> > >       struct page *new_page = NULL;
> > > +     int zidx;
> > > +
> > > +     mtc = (struct migration_target_control *)private;
> > > +     gfp_mask = mtc->gfp_mask;
> > >
> > >       if (PageHuge(page)) {
> > >               return alloc_huge_page_nodemask(
> > > -                             page_hstate(compound_head(page)),
> > > -                             preferred_nid, nodemask, 0, false);
> > > +                             page_hstate(compound_head(page)), mtc->nid,
> > > +                             mtc->nmask, gfp_mask, false);
> > >       }
> > >
> > >       if (PageTransHuge(page)) {
> > > +             gfp_mask &= ~__GFP_RECLAIM;
> >
> > What's up with this gfp_mask modification?
> 
> THP page allocation uses a standard gfp masks, GFP_TRANSHUGE_LIGHT and
> GFP_TRANHUGE. __GFP_RECLAIM flags is a big part of this standard mask design.
> So, I clear it here so as not to disrupt the THP gfp mask.

Why this wasn't really needed before? I guess I must be missing
something here. This patch should be mostly mechanical convergence of
existing migration callbacks but this change adds a new behavior AFAICS.
It would effectively drop __GFP_RETRY_MAYFAIL and __GFP_KSWAPD_RECLAIM
from the mask so the allocation would "lighter". If that is your
intention then this should be a separate patch with an explanation
rather than hiding it into this patch.
-- 
Michal Hocko
SUSE Labs
