Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A135C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D6A207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593156211;
	bh=eQSuxiAP2rvXhUaQ+3dfTWngxSmtC6TJfEJoqkOb0fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pexnsn3MBn1J7fE/49dkyC9BAOLuMRRTLi6ervGVRO9WsArveExzyz3fxLM8TnQbE
	 Qae5PA6MEvlnkCBuUC9lpuimWML8dyAiMVywVWR47YzzsqNQARcJjmQFYH+DZm+WUc
	 rr9/ehOhHw/fj6MBQeWO5vzusw/p7BBUsAQx2EXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgFZHX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:23:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39290 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgFZHX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:23:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id d18so483910edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QEbKXP8FUgYuXuT6takZ5c8rrVZ/DcOt9hyzMr4EANc=;
        b=nvVV0MJP64/SG+lyHDgDeWLgI4R/SMNY2NydzDFVtqcQq04DL7LYLVOdOKc7jyfNuj
         IvJuekRKiXLopxNZ5S9nePfpmvufhirKq0xl9vmsAa/eRMZRbfC1UzxRjl3/Ub5G583r
         W7FtBGtskGnebeWLF/0x+PDN9O1yR1uKfWnieFPXfm+2RDat5xNQRwoX9iXYxufe9VWa
         009oztXRnuuWFKcM/3Ejo7G4+Y39FJ/5rd/07jSEHAeXV6tsGiPAtq0sk17SuRqZDsEs
         uzBl2fqAE+H9Wo1ooeF6uzKI6R0E1xH+8cMEnocfHcvyUiFHgdnsOfIVNWPnl7Ojxq2g
         PizQ==
X-Gm-Message-State: AOAM530yo1DvAOKp6pXuHPEx/rI3K+LSjlvAlimKm9NSmzF97g/Uod9o
        EyU48bbtZAmEbQsOyB0/aO8=
X-Google-Smtp-Source: ABdhPJwVwkw4iKVEaU0es39MMKnKwPM9vSwQC0Z4BjvkXK/ajy/GR7r3yl+tcX7xw9YuzXumF7gmMQ==
X-Received: by 2002:a50:e8c8:: with SMTP id l8mr2050076edn.386.1593156207272;
        Fri, 26 Jun 2020 00:23:27 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id a2sm8817292ejg.76.2020.06.26.00.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:23:26 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:23:24 +0200
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
Subject: Re: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200626072324.GT1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-06-20 13:49:15, Joonsoo Kim wrote:
> 2020년 6월 25일 (목) 오후 8:54, Michal Hocko <mhocko@kernel.org>님이 작성:
> >
> > On Tue 23-06-20 15:13:44, Joonsoo Kim wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > new_non_cma_page() in gup.c which try to allocate migration target page
> > > requires to allocate the new page that is not on the CMA area.
> > > new_non_cma_page() implements it by removing __GFP_MOVABLE flag. This way
> > > works well for THP page or normal page but not for hugetlb page.
> >
> > Could you explain why? I mean why cannot you simply remove __GFP_MOVABLE
> > flag when calling alloc_huge_page_nodemask and check for it in dequeue
> > path?
> 
> If we remove __GFP_MOVABLE when calling alloc_huge_page_nodemask, we cannot
> use the page in ZONE_MOVABLE on dequeing.
> 
> __GFP_MOVABLE is not only used for CMA selector but also used for zone
> selector.  If we clear it, we cannot use the page in the ZONE_MOVABLE
> even if it's not CMA pages.  For THP page or normal page allocation,
> there is no way to avoid this weakness without introducing another
> flag or argument. For me, introducing another flag or argument for
> these functions looks over-engineering so I don't change them and
> leave them as they are (removing __GFP_MOVABLE).
> 
> But, for alloc_huge_page_nodemask(), introducing a new argument
> doesn't seem to be a problem since it is not a general function but
> just a migration target allocation function.

I really do not see why hugetlb and only the dequeing part should be
special. This just leads to a confusion. From the code point of view it
makes perfect sense to opt out CMA regions for !__GFP_MOVABLE when
dequeing. So I would rather see a consistent behavior than a special
case deep in the hugetlb allocator layer.
-- 
Michal Hocko
SUSE Labs
