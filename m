Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3AF2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594984092;
	bh=hNpCXgiHSZhI24/PTUGRJ+oZyT+uR3fSovwXmDd7Ifg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KS/RCkcdqreON+18z+RYwKSnE1fMF8mM5RK2fWq2IhGuilzMH4wfQXzinbJZmVoJS
	 1LD8PzCyGFsFLASwodb0pCOCRZKQA3XzwBPkAWOw7xx385VuR7nF1Od0Xt5qBW81+s
	 EO43U5+D5HpK0Wvf9CNaqqr4Bev9HUe2pMSOaeFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGQLIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:08:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:08:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 17so16435263wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sW5ATIAUVqe473Xw/kpcZ/C6jQAJpg7NFPCXiZkdips=;
        b=rVwileN4DCzsRHqat1EdQFS3EC1ne9glm64dkrG66Oh8gKGevlb4nB2HaU/a74cynl
         OM5pQsqJGAIvNcEviWODyR84bYbzaHo7XQvT3nmt3sxzd6SSMfKFtxQnn8LAHbMSlHZe
         ATCpZy/c6b04ZcsMbi9QtM03jMC4H3zwWNp3bgy60USpcV65OfiErXRU67RKTTf7TL1P
         8AA3HAA+fa6j6VpN6bU0QGQPPVQwTVhJ0Q8+DvySgxdMWGLBU/5LUd2r0n3bveriMetf
         ie36i4HQZ2zyKgVygSH6W0G//Rtwn4uylZ8FFpF8wDOCNmXJeMTSc2gzXeB9Zvc62TZz
         jlEQ==
X-Gm-Message-State: AOAM531pO6WvQAr73LY+BUAW/a22o3ixe1EZNx+Ac9qRd3rFxnWK3MaT
        LgPbi8pA5VupH4pAhP9umKA=
X-Google-Smtp-Source: ABdhPJxox0SFlm5xLzRoNdhcTImUK1TCwAQbeJsz4XT4q1d/BhaW2glSZ+rF8qALgUyM4jjsatD+7g==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr8569690wmh.134.1594984088723;
        Fri, 17 Jul 2020 04:08:08 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id w14sm13981638wrt.55.2020.07.17.04.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:08:07 -0700 (PDT)
Date:   Fri, 17 Jul 2020 13:08:06 +0200
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 2/4] mm/gup: restrict CMA region by using allocation
 scope API
Message-ID: <20200717110806.GI10655@dhcp22.suse.cz>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20200715082401.GC5451@dhcp22.suse.cz>
 <CAAmzW4P+KXn2e1pU+_+Y6NqDt1-081hCyKNsqbiwfF=FADLzxQ@mail.gmail.com>
 <20200717082643.GC10655@dhcp22.suse.cz>
 <CAAmzW4N6mQ_9jrUN5NUURpxa7tf4nKwsrgiWe79v0vNJO0_6Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4N6mQ_9jrUN5NUURpxa7tf4nKwsrgiWe79v0vNJO0_6Xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-07-20 18:28:16, Joonsoo Kim wrote:
> 2020년 7월 17일 (금) 오후 5:26, Michal Hocko <mhocko@kernel.org>님이 작성:
> >
> > On Fri 17-07-20 16:46:38, Joonsoo Kim wrote:
> > > 2020년 7월 15일 (수) 오후 5:24, Michal Hocko <mhocko@kernel.org>님이 작성:
> > > >
> > > > On Wed 15-07-20 14:05:27, Joonsoo Kim wrote:
> > > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > >
> > > > > We have well defined scope API to exclude CMA region.
> > > > > Use it rather than manipulating gfp_mask manually. With this change,
> > > > > we can now use __GFP_MOVABLE for gfp_mask and the ZONE_MOVABLE is also
> > > > > searched by page allocator. For hugetlb, gfp_mask is redefined since
> > > > > it has a regular allocation mask filter for migration target.
> > > > >
> > > > > Note that this can be considered as a fix for the commit 9a4e9f3b2d73
> > > > > ("mm: update get_user_pages_longterm to migrate pages allocated from
> > > > > CMA region"). However, "Fixes" tag isn't added here since it is just
> > > > > suboptimal but it doesn't cause any problem.
> > > >
> > > > But it is breaking the contract that the longterm pins never end up in a
> > > > cma managed memory. So I think Fixes tag is really due. I am not sure
> > > > about stable backport. If the patch was the trivial move of
> > >
> > > Previous implementation is correct since longterm pins never end up in a CMA
> > > managed memory with that implementation. It's just a different and suboptimal
> > > implementation to exclude the CMA area. This is why I don't add the "Fixes"A
> > > tag on the patch.
> >
> > But the current implementation calls memalloc_nocma_restore too early so
> > __gu_longterm_locked will migrate pages possibly to CMA ranges as there
> > is no GFP_MOVABLE restriction in place. Or am I missing something?
> 
> IIUC, calling memalloc_nocma_restore() too early doesn't cause the
> actual problem.
> 
> Final check is done by check_and_migrate_cma_pages() which is outside of
> scope API. If we find a CMA page in between the gup range here, the page is
> migrated to the migration target page and this target page is allocated by
> new_non_cma_page().
> 
> new_non_cma_page() try to allocate the page without __GFP_MOVABLE so
> returned page will not be CMA area memory. Therefore, even if
> memalloc_nocma_restore() is called early, there is no actual problem.

Right you are! I have misread gfp_t gfp_mask = GFP_USER | __GFP_NOWARN
and didn't realize that it doesn't include MOVABLE flag.

Sorry about the noise! The issue is only formal coding style so Fixes
tag could indeed cause more confusion than it would help.

-- 
Michal Hocko
SUSE Labs
