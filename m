Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82606C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3012076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594974410;
	bh=QpPHW7ijymF8UPBtkIkhNdR2pBbrJQ9FnztI9PJH3k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TGp8kX6uL2+IcBEd3AxfgK1X6whG17X+xT9GjZcK5kcPE5Nw0nR72sy4GoleBoRKh
	 to7YCCwxRn37ej4SiQiDqtCBojefbWu7CG8o7eFEW8cAs8r7je4svZA7mCpD8zOgtn
	 UvT9ACJuUvCJiTsoqTGpIk555txzdFm/Vj8K4IKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGQI0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:26:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53587 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:26:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id j18so13774313wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iDFlO+GQcqhp+vY+gvgj7kF+MF/l2MV7H3mINPfB+O8=;
        b=ZkxUXPyFPqPFs/KbV9oQd2IRTcH7zaADCBMnTzEotSxqvY/MrawsxbKeHTrNTncnlh
         wWWMIWslrlOQUBpPqg+/KcHt2E0pJLr/unYUYEiKRVV90KfplPl/mcAP1JnMdRsObOXY
         x294PCkebjr3KfIE7QneD4Lg4m84S+jhDRjI08M1eorsACoA+BbGEmVQGkIBrERTZi+s
         WkPqXt+7t4C1d5a2acS7LxOjjf76LZZKRRTyOLgbVQFIZAFdePbG1lydj+7JEmwPwjGz
         98Lrje6GIcbsK6pvHWsH2W0xwDkgZEqlGbQ1DnqWy0twVruF2iBPv3BBLKvAYEZHP5Da
         cAJw==
X-Gm-Message-State: AOAM533GSJJ9xcy4I2JXq9UTT7BlOQL0cQkPd1g7rZYaLD/UpLmgyIPb
        R/7bcyKbdkVsiSMMZ1RBnec=
X-Google-Smtp-Source: ABdhPJyZ2qI3nRV3baByYIs8hnUOISWF5gmXw3Qszj4PHiwtQ9OcDbrrxBVDq6YLJIiE983WiQe3iA==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr7932171wmb.93.1594974405897;
        Fri, 17 Jul 2020 01:26:45 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id t16sm13569982wru.9.2020.07.17.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:26:44 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:26:43 +0200
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
Message-ID: <20200717082643.GC10655@dhcp22.suse.cz>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20200715082401.GC5451@dhcp22.suse.cz>
 <CAAmzW4P+KXn2e1pU+_+Y6NqDt1-081hCyKNsqbiwfF=FADLzxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4P+KXn2e1pU+_+Y6NqDt1-081hCyKNsqbiwfF=FADLzxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-07-20 16:46:38, Joonsoo Kim wrote:
> 2020년 7월 15일 (수) 오후 5:24, Michal Hocko <mhocko@kernel.org>님이 작성:
> >
> > On Wed 15-07-20 14:05:27, Joonsoo Kim wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > We have well defined scope API to exclude CMA region.
> > > Use it rather than manipulating gfp_mask manually. With this change,
> > > we can now use __GFP_MOVABLE for gfp_mask and the ZONE_MOVABLE is also
> > > searched by page allocator. For hugetlb, gfp_mask is redefined since
> > > it has a regular allocation mask filter for migration target.
> > >
> > > Note that this can be considered as a fix for the commit 9a4e9f3b2d73
> > > ("mm: update get_user_pages_longterm to migrate pages allocated from
> > > CMA region"). However, "Fixes" tag isn't added here since it is just
> > > suboptimal but it doesn't cause any problem.
> >
> > But it is breaking the contract that the longterm pins never end up in a
> > cma managed memory. So I think Fixes tag is really due. I am not sure
> > about stable backport. If the patch was the trivial move of
> 
> Previous implementation is correct since longterm pins never end up in a CMA
> managed memory with that implementation. It's just a different and suboptimal
> implementation to exclude the CMA area. This is why I don't add the "Fixes"A
> tag on the patch.

But the current implementation calls memalloc_nocma_restore too early so
__gu_longterm_locked will migrate pages possibly to CMA ranges as there
is no GFP_MOVABLE restriction in place. Or am I missing something?

-- 
Michal Hocko
SUSE Labs
