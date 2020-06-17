Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91CBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1162070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iWxNrTLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFQSON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgFQSOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:14:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7277C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:14:10 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so2763319eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQY6HksWXyPnSxieVR0zNRqNyI+5XGcfQh14panq9So=;
        b=iWxNrTLcZ5NuCxokyvVyI/sbKP383Del10tyI61m8Dtawf4HtcYYyoVtxYTKBgdB2U
         gYHxtP+j6Su9Dp1ILgQmu94lyfxnn7yQt5iVq2ddMN2PnovP/ySRx6F1G2mynliSa4kY
         aoRwnaqEtvxJvGxykH+mcKwpxRQpoOuH/FfFeAK0ezfEOTM6FoWwp4Rcz0xFIOBbT7CD
         oWpwwAu4ugNPcmUEA52WvHibfZc72pk7S8kVFW2SjCrey4VwEQg6VsAPxY/Og9/sHLVG
         Mq1ix+DGdX42YwHDkyG2ZJPThcRTSMTOS/h6RNY6INnr0CgIpcrz5EpSu41ZaKzW4JO9
         pOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQY6HksWXyPnSxieVR0zNRqNyI+5XGcfQh14panq9So=;
        b=KPab9RKgrgjLMKubsfGbCXteV4G5G9wSaYOGBTtSDflts4zuPlxtuSGxqAR78HWUJl
         NTeco7bAqIAiXe4TsF9X/sDsTySzkWL+hxz2mDFgQT1xUkc6b9gCp3vp9gJiRpoalOx6
         nNtbF7xBjNHfoVr3CuX3WS1I734N9/EPPGs8KS43gf/ugQE3KrgXXD8UBUT1hGonHEl0
         vtZrrgoETe7Yp5w2yq5XQ7sgerAnT38najzMM1oE6yD/RTgcIXBkxuykTMvADrVpJIWS
         o2ePW/NR68vg965ROj2zxT32TjlV2rVkaEuTgO6o/BBlGBfImnMhUzc1zXTprG72qRsA
         8dPA==
X-Gm-Message-State: AOAM533JX5FYQyBzGqgzEhgzsZzFw6sG26ClRMRCHYoSesPpGU+ctbno
        L5Dq8x11Hu9n4L6k4UmEPixTP6V6yLrZOCncsMIJ+w==
X-Google-Smtp-Source: ABdhPJyXs0udzRevLqxLaRKeMDT48UObIEYAaHobrX0qdVeC3vY0Sb38EhA6NiDXsCTpZVcGCutct53YS6OZtdfjyZo=
X-Received: by 2002:aa7:c489:: with SMTP id m9mr465271edq.102.1592417649440;
 Wed, 17 Jun 2020 11:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200616115213.13109-1-david@redhat.com> <20200616115213.13109-3-david@redhat.com>
 <20200616125051.GH9499@dhcp22.suse.cz> <CAPcyv4hjxyyxVyZbAYoXX2TM3mHF6e4VneVVcmVU+_Q4n9CxzQ@mail.gmail.com>
 <CAPcyv4gTTVaGAKt91DcgW=t3PgWFioZA7XQrCAU_gAXhcxBe1w@mail.gmail.com> <20200617064826.GI9499@dhcp22.suse.cz>
In-Reply-To: <20200617064826.GI9499@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Jun 2020 11:13:58 -0700
Message-ID: <CAPcyv4gDR-h+KSojYMhQaigNc9Fn-oXYwd5zNR+MrxXo9JdnLQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: don't shuffle complete zone
 when onlining memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:48 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 16-06-20 10:03:31, Dan Williams wrote:
> > On Tue, Jun 16, 2020 at 10:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Tue, Jun 16, 2020 at 5:51 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Tue 16-06-20 13:52:12, David Hildenbrand wrote:
> > > > > Commit e900a918b098 ("mm: shuffle initial free memory to improve
> > > > > memory-side-cache utilization") introduced shuffling of free pages
> > > > > during system boot and whenever we online memory blocks.
> > > > >
> > > > > However, whenever we online memory blocks, all pages that will be
> > > > > exposed to the buddy end up getting freed via __free_one_page(). In the
> > > > > general case, we free these pages in MAX_ORDER - 1 chunks, which
> > > > > corresponds to the shuffle order.
> > > > >
> > > > > Inside __free_one_page(), we will already shuffle the newly onlined pages
> > > > > using "to_tail = shuffle_pick_tail();". Drop explicit zone shuffling on
> > > > > memory hotplug.
> >
> > This was already explained in the initial patch submission. The
> > shuffle_pick_tail() shuffling at run time is only sufficient for
> > maintaining the shuffle. It's not sufficient for effectively
> > randomizing the free list.
>
> Yes, the "randomness" of the added memory will be lower. But is this
> observable for hotplug scenarios?

I'm not sure of the intersection of platforms using memory hotplug and
shuffling in production.

> Is memory hotplug for the normal
> memory really a thing in setups which use RAM as a cache?

I would point out again though that the utility of shuffling goes
beyond RAM-as-cache. I have seen some cost sensitive customer platform
configurations that asymmetrically populate memory controllers. Think
1 DIMM on controller0 and 2 DIMMs on controller1. In that case Linux
can get into pathological situations where an application is bandwidth
limited because it only accesses the single-DIMM backed memory range.
Shuffling balances accesses across all available memory memory
controllers restoring full memory bandwidth for that configuration. So
shuffling is used to solve problems that are otherwise invisible to
Linux, there's no indication from the platform that one memory range
has lower bandwidth than another.

> While I do agree that the code wise the shuffling per online operation
> doesn't really have any overhead really but it would be really great to
> know whether it matters at all.

I agree this is a good test case, especially considering the
"dax_kmem" solution where memory might be reserved from the initial
shuffling and onlined later. I assume there's a cross-over point where
not shuffling hotplugged memory starts to be noticeable. I just don't
have those numbers handy.
