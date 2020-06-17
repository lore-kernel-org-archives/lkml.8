Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9849C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88731208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592376515;
	bh=B+BnaOuLJmPNNEFwTWeRaIgtnMKDskW0aTjkyXFMMUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yaQ0DdQ05wyBQUYl6AYVmUA0himgSzrhb4UQ3zF8zd+MVBcf1lw+0u48PzMAtoG7G
	 g5ulrRdefik4T7UsvtESQQ4J/qg1QFtHkcgmkE7pnghx/uTaojwoKylMDs3XXiic9Z
	 xDkcb+08KoTFNP6UFqnXNNyvisdPy9YZE2R7Dfjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFQGsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:48:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42959 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgFQGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:48:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id x93so1031234ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJ3s/HlOTbYQFOq7uleghPGGvHCAXsQqGed7hYcH7AA=;
        b=DiCiYEKTny59mdnjUjB6qzz6FjfY6xs6/BXqHTO3/L9kC1OUP4WuXfwJip/K8rnj9C
         ZQhEBgVspsIIVeyHsQyOqccbaBLcwgDC/ieqxHwEXqgT7lDNr/iM+A0ogNntVgafsFts
         NNBkdvFoSE/W6f22l2zwDIm87EE1iShEKtPYDHIZETYzpTpjDB9zxpmhMCj7n1rkNic9
         UhtQg17RBG3IyxwQynf0orrSq6jX5l5i7DNfNCQvOlLUh1Js11nledRp+wcD/uVb+pjF
         cckpL0g2BErORNOW/KsritFWSmm5iOI1in2jyAfThfSnkOWsRIiEKG473+kcZGPIjN8R
         kMDw==
X-Gm-Message-State: AOAM530qfLrnCDtxQltNh4jOpFed0fFY7XNeAqi9Q4n6pQD6wkla/wSo
        +FEMYyCmEzXPfiUyi/4iINU=
X-Google-Smtp-Source: ABdhPJz3JWyhEs5CJzo9aqGn8eQwPEdhBSBq1iQhuPOQVrf11C3H2KT08oegvw3aW84ZOPEucDEVRg==
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr6113230edb.152.1592376509342;
        Tue, 16 Jun 2020 23:48:29 -0700 (PDT)
Received: from localhost (ip-37-188-158-19.eurotel.cz. [37.188.158.19])
        by smtp.gmail.com with ESMTPSA id a7sm11381186edx.3.2020.06.16.23.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:48:27 -0700 (PDT)
Date:   Wed, 17 Jun 2020 08:48:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: don't shuffle complete zone
 when onlining memory
Message-ID: <20200617064826.GI9499@dhcp22.suse.cz>
References: <20200616115213.13109-1-david@redhat.com>
 <20200616115213.13109-3-david@redhat.com>
 <20200616125051.GH9499@dhcp22.suse.cz>
 <CAPcyv4hjxyyxVyZbAYoXX2TM3mHF6e4VneVVcmVU+_Q4n9CxzQ@mail.gmail.com>
 <CAPcyv4gTTVaGAKt91DcgW=t3PgWFioZA7XQrCAU_gAXhcxBe1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gTTVaGAKt91DcgW=t3PgWFioZA7XQrCAU_gAXhcxBe1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-06-20 10:03:31, Dan Williams wrote:
> On Tue, Jun 16, 2020 at 10:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 5:51 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 16-06-20 13:52:12, David Hildenbrand wrote:
> > > > Commit e900a918b098 ("mm: shuffle initial free memory to improve
> > > > memory-side-cache utilization") introduced shuffling of free pages
> > > > during system boot and whenever we online memory blocks.
> > > >
> > > > However, whenever we online memory blocks, all pages that will be
> > > > exposed to the buddy end up getting freed via __free_one_page(). In the
> > > > general case, we free these pages in MAX_ORDER - 1 chunks, which
> > > > corresponds to the shuffle order.
> > > >
> > > > Inside __free_one_page(), we will already shuffle the newly onlined pages
> > > > using "to_tail = shuffle_pick_tail();". Drop explicit zone shuffling on
> > > > memory hotplug.
> 
> This was already explained in the initial patch submission. The
> shuffle_pick_tail() shuffling at run time is only sufficient for
> maintaining the shuffle. It's not sufficient for effectively
> randomizing the free list.

Yes, the "randomness" of the added memory will be lower. But is this
observable for hotplug scenarios? Is memory hotplug for the normal
memory really a thing in setups which use RAM as a cache?

While I do agree that the code wise the shuffling per online operation
doesn't really have any overhead really but it would be really great to
know whether it matters at all.
-- 
Michal Hocko
SUSE Labs
