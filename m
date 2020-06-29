Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D769C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411EA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593463648;
	bh=uVrYPpEk0IjrH6XuehrsQ7j1MoJZIOKEVBYQ0CHtPn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sNl93oWwf2AZr+/NP5g824/pIsX3J+62qYB7gkZ1Y4DaefTwYoSbwvSPFfyRPM2BE
	 1SmKy9NCkYYR6hPGsl9d7GTVIoO8ATm+FDFnfq3QQWj7jNeRE07kwN/uMlSGOKagEd
	 ok4i1c/ZXLSw1DL4RfGlGluBK37D+CnqxUyxXSj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbgF2Ur0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbgF2TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E292C014AFD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:03:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so2153500edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tU/p6/XQD1UtMhsPATQwXv6wMmo7z9qcgbgQtemfgDk=;
        b=PgAlD3Agd6yrN87LXFvAIhwHZzgLemW5Lyos8HKYyo3w6lbPwBXp+ZxstLHbk7e8Ou
         7Lqy5I7/Z7uJnnkB78xqVCWzbycH0Hn03Gio9iETOiWIbJ/EWfJtqVNVgrx9muvH6TKU
         cCw9lP1xx+5orVSuCvLonCKJGfhRQKiiQ5LpRX+IN4icw2cwhtnP7+iQO2rvXlwMGYWN
         h8O73y2dMPoLCa28rrkiCw+RhJv8JANP/nXr6YYeR4npeEabJd5/MyX0fqhQtC0vmxz+
         gNw7CV8HvMtlrmG7MeUiykiZqLrRwszoQesV6fi3Qaw4yjT2EZH4CMjGvkVk924zTe43
         uuwA==
X-Gm-Message-State: AOAM531c9QD+dHhR5H5nQtti9RSO8iS2+H414zIlxOFHujPld1UpFH5X
        zt+kqG3hUpVGfEiDNOWKazM=
X-Google-Smtp-Source: ABdhPJz4TRSsBtthWM7Gwrj+nINEZzKzoZdqTqYqd/hjV00j8U3cZeGjwf0qOk5kiSsg/aHoLbtMCQ==
X-Received: by 2002:aa7:c98d:: with SMTP id c13mr8016803edt.188.1593417831943;
        Mon, 29 Jun 2020 01:03:51 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id y21sm23452236ejp.32.2020.06.29.01.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:03:51 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:03:50 +0200
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
Message-ID: <20200629080350.GB32461@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625120550.GF1320@dhcp22.suse.cz>
 <CAAmzW4ObN=GAzCLw8betLftTeCEsLs4OihfNXvtg4CaWyWiBCw@mail.gmail.com>
 <20200626073342.GU1320@dhcp22.suse.cz>
 <CAAmzW4PT+M8mUwXMPhQSKLhz9nkPATivL5D-yLyyfC9SOwPnYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4PT+M8mUwXMPhQSKLhz9nkPATivL5D-yLyyfC9SOwPnYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-06-20 15:41:37, Joonsoo Kim wrote:
> 2020년 6월 26일 (금) 오후 4:33, Michal Hocko <mhocko@kernel.org>님이 작성:
> >
> > On Fri 26-06-20 14:02:49, Joonsoo Kim wrote:
> > > 2020년 6월 25일 (목) 오후 9:05, Michal Hocko <mhocko@kernel.org>님이 작성:
> > > >
> > > > On Tue 23-06-20 15:13:45, Joonsoo Kim wrote:
> > [...]
> > > > > -struct page *new_page_nodemask(struct page *page,
> > > > > -                             int preferred_nid, nodemask_t *nodemask)
> > > > > +struct page *alloc_migration_target(struct page *page, unsigned long private)
> > > > >  {
> > > > > -     gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> > > > > +     struct migration_target_control *mtc;
> > > > > +     gfp_t gfp_mask;
> > > > >       unsigned int order = 0;
> > > > >       struct page *new_page = NULL;
> > > > > +     int zidx;
> > > > > +
> > > > > +     mtc = (struct migration_target_control *)private;
> > > > > +     gfp_mask = mtc->gfp_mask;
> > > > >
> > > > >       if (PageHuge(page)) {
> > > > >               return alloc_huge_page_nodemask(
> > > > > -                             page_hstate(compound_head(page)),
> > > > > -                             preferred_nid, nodemask, 0, false);
> > > > > +                             page_hstate(compound_head(page)), mtc->nid,
> > > > > +                             mtc->nmask, gfp_mask, false);
> > > > >       }
> > > > >
> > > > >       if (PageTransHuge(page)) {
> > > > > +             gfp_mask &= ~__GFP_RECLAIM;
> > > >
> > > > What's up with this gfp_mask modification?
> > >
> > > THP page allocation uses a standard gfp masks, GFP_TRANSHUGE_LIGHT and
> > > GFP_TRANHUGE. __GFP_RECLAIM flags is a big part of this standard mask design.
> > > So, I clear it here so as not to disrupt the THP gfp mask.
> >
> > Why this wasn't really needed before? I guess I must be missing
> > something here. This patch should be mostly mechanical convergence of
> > existing migration callbacks but this change adds a new behavior AFAICS.
> 
> Before this patch, a user cannot specify a gfp_mask and THP allocation
> uses GFP_TRANSHUGE
> statically.

Unless I am misreading there are code paths (e.g.new_page_nodemask) which simply use
add GFP_TRANSHUGE to GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL. And
this goes all the way to thp migration introduction.

> After this patch, a user can specify a gfp_mask and it
> could conflict with GFP_TRANSHUGE.
> This code tries to avoid this conflict.
> 
> > It would effectively drop __GFP_RETRY_MAYFAIL and __GFP_KSWAPD_RECLAIM
> 
> __GFP_RETRY_MAYFAIL isn't dropped. __GFP_RECLAIM is
> "___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM".
> So, __GFP_KSWAPD_RECLAIM would be dropped for THP allocation.
> IIUC, THP allocation doesn't use __GFP_KSWAPD_RECLAIM since it's
> overhead is too large and this overhead should be given to the caller
> rather than system thread (kswapd) and so on.

Yes, there is a reason why KSWAPD is excluded from THP allocations in
the page fault path. Maybe we want to extend that behavior to the
migration as well. I do not have a strong opinion on that because I
haven't seen excessive kswapd reclaim due to THP migrations. They are
likely too rare.

But as I've said in my previous email. Make this a separate patch with
an explanation why we want this.
-- 
Michal Hocko
SUSE Labs
