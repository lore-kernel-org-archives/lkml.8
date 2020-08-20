Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9073C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6B02080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YI3WGBlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHTINX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgHTIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:12:44 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0CC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:12:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r13so941187iln.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wFUfLu1wjKpBcBk58rANEq0OhljlSviFHmqAjjNj9gA=;
        b=YI3WGBljcqmJjBpWibWaA1B3PdJw1iIoruN9qxmTnnOwEnMPvjd8UrydeCNmL1LGO9
         2CWeQFOt7O5NJgOlte+c26lUQGofhonJ9wgiZZyh22da0Idj1QgvGnPm56HPpKerw8RN
         CbsDUcyZ6DOOYjYKjeLIoOk/W7nwe73sAVTWWNHzypZky90EveXh9IIdse94xbAd9aqs
         AmxjFUZK/1dpqCJNq9aFxv8/fRipPVX0D+iZteyeOAVyj0KL0B1qEKDSkWjSWtf7gttZ
         kjttykSDilJzpT4rHIbLKC28g68kIpugSzXYre7+RF7FeHdVtjLOUXUiO0aJwnvLTrTs
         VAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFUfLu1wjKpBcBk58rANEq0OhljlSviFHmqAjjNj9gA=;
        b=aBHCTgcIQZBgveVaaaB9Vv8HNH1ph85FKmMrcuNGVywRJf6l/WfrYxaPvBJXe6a+mu
         ROFiIQ8XPtQE1/0XiqLnu7twoiljv7GQNOEn20OYz+Ib11WDFheHSaUBYKwii2yAaoK3
         eSX7bagEh1GwOnCxXbqGs8ZzOmtWvgz5uDF0IK4cz+ppKjXucZWp68Lk1U07sDr6syad
         +mtTUtSd7GmIqpwSjqTWO6tk0o4PM4pBVfwl4h0itZ9+lXJqtAoolJqXXvWNFOe3h/h7
         tC7OMpU+JLYnAhOGg2KFd/05o3FYpuQ9pt9D8f3r9Y/tLiSC96ShKVgOPSiSioimcddk
         KF7A==
X-Gm-Message-State: AOAM533EIke4xc1yIcRfb3TfzibVVBvN3Gz6xV0bv9qF9mAKxSoEm2ll
        XBQF2zIKylY82ulglVbADx422Q==
X-Google-Smtp-Source: ABdhPJw2SI8b0KzEmhQCtckhElBztVNQOXgYYM311s7TbnGafxbeEmNS2ZxuwtamEQox7CCHEQAC/A==
X-Received: by 2002:a92:35da:: with SMTP id c87mr1611116ilf.61.1597911163628;
        Thu, 20 Aug 2020 01:12:43 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id c24sm990383iom.46.2020.08.20.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 01:12:42 -0700 (PDT)
Date:   Thu, 20 Aug 2020 02:12:38 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 3/3] mm: remove superfluous __ClearPageWaiters()
Message-ID: <20200820081238.GA2576494@google.com>
References: <20200818184704.3625199-1-yuzhao@google.com>
 <20200818184704.3625199-3-yuzhao@google.com>
 <20200820061652.GX5422@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820061652.GX5422@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 08:18:27AM +0200, Michal Hocko wrote:
> On Tue 18-08-20 12:47:04, Yu Zhao wrote:
> > Presumably __ClearPageWaiters() was added to follow the previously
> > removed __ClearPageActive() pattern.
> 
> I do not think so. Please have a look at 62906027091f ("mm: add
> PageWaiters indicating tasks are waiting for a page bit") and a
> discussion when the patch has been proposed. Sorry I do not have a link
> handy but I do remember that the handling was quite subtle.
>  
> > Only flags that are in PAGE_FLAGS_CHECK_AT_FREE needs to be properly
> > cleared because otherwise we think there may be some kind of leak.
> > PG_waiters is not one of those flags and leaving the clearing to
> > PAGE_FLAGS_CHECK_AT_PREP is more appropriate.
> 
> What is the point of this patch in the first place? Page waiters is
> quite subtle and I wouldn't touch it without having a very good reason.

I appreciate your caution. And I just studied the history [1] (I admit
this is something I should have done beforehand), and didn't find any
discussion on __ClearPageWaiters() specifically. So I would ask why it
was added originally. I was hoping Nicholas could help us.

[1] https://lore.kernel.org/lkml/20161225030030.23219-3-npiggin@gmail.com/

Given its triviality, I can't argue how useful this patch is. So I'll
go with how evident it is: we are removing __ClearPageWaiters() from
paths where pages have no references left -- they can't have any
waiters or be on any wait queues.
