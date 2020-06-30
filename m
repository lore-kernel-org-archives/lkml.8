Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A5EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B5B207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593499382;
	bh=cvz0DVxbkbit9789lQRtKiSsgSe/9ar/Su8gVXGZ1Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cmlj7x+V+LdRjn/ZU0bC1of9W/TsUX8tneULzV8NxYrx40p7WGYzMW51blSksU2dk
	 vi89A0M+UfQA24xpjQFjj07Ir4TjoNWuO0DKxEQIUQXndI7ohsDSd3f/DNz6sak6Oq
	 Qjqmj1tRsYAgMCQhseT0bc0MocDsr82GDTWp/Vnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgF3GnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:43:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39247 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgF3GnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:43:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id d18so9436384edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T68iAtCbsB3kK12Vx7XZijyxS7QJWskLFeow15TOzcM=;
        b=Bi6o3EFRtSYRn1TN9e83RHGcvMwbO03f1QD7p+YxHHER1E63ZliaKt6X7kF1LuiTqr
         r23MEfHrZL7BYTyBCh6UEl8rS2azEb6Fpza2AnysEpR4qgxECfTxYlvh4qfQjeBMA9wd
         QFVUkIyhH1Z4D82yNXWJbUBNM4FV+CXtbFh3t4JfawUVVXVmjAnxCjyuMl1NkaZTvml4
         s9siVub4Yh3yE5xwBHMv210yJzjEG1u+es0gv2VFB6Mz3htZI56pBCtVeneR2u/2cVqv
         uoaWlrx31q7WFccebUTwJ0tDxyl0JIuFqbkECfqV+f1jWB+b6lAvV4KChwo1xHbmsmlg
         6z0w==
X-Gm-Message-State: AOAM530Zy2tC36EhoI5+6qIvCLb6rd7Bh/1JmswHcTF14ttSXao5vhp7
        1+6fjX4D5ltw8V/0rntJrIg=
X-Google-Smtp-Source: ABdhPJz+FSxFS8S+qi2OPftX4/hQH0ksmkIkftRZWCRq/OCxpS+D7qZ7LW1yMd09KDh9aUsimIrllw==
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr13399059edx.35.1593499378880;
        Mon, 29 Jun 2020 23:42:58 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id m6sm1239903ejq.85.2020.06.29.23.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:42:58 -0700 (PDT)
Date:   Tue, 30 Jun 2020 08:42:56 +0200
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
Message-ID: <20200630064256.GB2369@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
 <20200626072324.GT1320@dhcp22.suse.cz>
 <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
 <20200629075510.GA32461@dhcp22.suse.cz>
 <CAAmzW4PFEEs0FGe+XMHzRdXr0LpdF3TZZG2L3E+opRyZWDZ48A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4PFEEs0FGe+XMHzRdXr0LpdF3TZZG2L3E+opRyZWDZ48A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-06-20 15:30:04, Joonsoo Kim wrote:
> 2020년 6월 29일 (월) 오후 4:55, Michal Hocko <mhocko@kernel.org>님이 작성:
[...]
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 57ece74e3aae..c1595b1d36f3 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1092,10 +1092,14 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
> >  /* Movability of hugepages depends on migration support. */
> >  static inline gfp_t htlb_alloc_mask(struct hstate *h)
> >  {
> > +       gfp_t gfp;
> > +
> >         if (hugepage_movable_supported(h))
> > -               return GFP_HIGHUSER_MOVABLE;
> > +               gfp = GFP_HIGHUSER_MOVABLE;
> >         else
> > -               return GFP_HIGHUSER;
> > +               gfp = GFP_HIGHUSER;
> > +
> > +       return current_gfp_context(gfp);
> >  }
> >
> >  static struct page *dequeue_huge_page_vma(struct hstate *h,
> >
> > If we even fix this general issue for other allocations and allow a
> > better CMA exclusion then it would be implemented consistently for
> > everybody.
> 
> Yes, I have reviewed the memalloc_nocma_{} APIs and found the better way
> for CMA exclusion. I will do it after this patch is finished.
> 
> > Does this make more sense to you are we still not on the same page wrt
> > to the actual problem?
> 
> Yes, but we have different opinions about it. As said above, I will make
> a patch for better CMA exclusion after this patchset. It will make
> code consistent.
> I'd really appreciate it if you wait until then.

As I've said I would _prefer_ simplicity over "correctness" if it is only
partial and hard to reason about from the userspace experience but this
is not something I would _insist_ on. If Mike as a maintainer of the
code is ok with that then I will not stand in the way.

But please note that a missing current_gfp_context inside
htlb_alloc_mask is a subtle bug. I do not think it matters right now but
with a growing use of scoped apis this might actually hit some day so I
believe we want to have it in place.

Thanks!

-- 
Michal Hocko
SUSE Labs
