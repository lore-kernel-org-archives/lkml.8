Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB8EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B780320870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaNc5gLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGAWBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGAWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:01:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D91C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 15:01:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so3863821plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LiKSdomB7SYoSNNtUaN0cjvxW4EegcZYhSh2BV0kHs4=;
        b=TaNc5gLo26aH/EIR7tVKCcDNRJLBctdXo/xzCJGvaYLDPUKDRRBU4MLEjLM/BdYac8
         fC7XEhideABk6sVrDo4/AR5n96UerdZ4sOQx1TOffi+1kg664FfCm/YoJsH6FISUnQDM
         7e+ANL/05vYi/LdyJGNVZCzLrMY8oc3igGrbK1Yvvtp90qHo/GK9jMJfQwsAkHtmP9Nq
         FRqwZs82SziAnAgde3r0BDCZvr+zQG3OVKkBxtUw4Cfhqk81gxQuy9dXIwNPtUsmtqRt
         M2+x8CpF1FL6F8L99DQ9gcuB8kBLwz4sNffvO7LaM9IJORy2y1d20NYYMRj7F3ZYe8on
         I6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LiKSdomB7SYoSNNtUaN0cjvxW4EegcZYhSh2BV0kHs4=;
        b=RcvsDOpMeqVDsg5OGX2AWd38+yH+mcdKwBxe1I9gmlvT1YBBzolh7D/ZlD8TDwdTs6
         Mg8aLejWUTtRWXdk2GhYm4wdKSVs0MB3/xwmtyI1dmQDH1mtYY8J/cjTAT+V9pYMQWq8
         Y3lM/bXcrK8j96+jiVLFvJSs/7d/ysHtuceqRek2h+vHQbfUbGekXhuG7dwgrp+sLm69
         j8XPmxd0RlzWZ1ZNBlvAO0mBNiaJRC/ZhKlJdmSSwAZhip/J7N2ukb1X04Zb7IV77KuF
         bSPuiKzXG3YW2TsgPn4aZpvtXO+/A20jGGpKY88QfS7xWR5IY7GBM4kVrSzMl4dSu0im
         uyIw==
X-Gm-Message-State: AOAM531Uycw0QbiEsTqX1Edu+OYP1bgV+f9waW6KaNXGbyaPKTN2HeCY
        tNvuh3i0my1QlwEptoMxZGskkiCQOlY=
X-Google-Smtp-Source: ABdhPJz8In3fDXWpo9ag7N61J3Dc64PVECUjKJ4bfAdcKZEGlI5+yqvtAF1B235h/YKVwdjy25NVag==
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr29890330pjb.110.1593640876247;
        Wed, 01 Jul 2020 15:01:16 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b8sm6010381pja.54.2020.07.01.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:01:15 -0700 (PDT)
Date:   Wed, 1 Jul 2020 15:01:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [PATCH 3/3] mm/vmscan: replace implicit RECLAIM_ZONE checks with
 explicit checks
In-Reply-To: <0dd57932-44cf-0c2d-e157-07a8d7324006@intel.com>
Message-ID: <alpine.DEB.2.23.453.2007011457250.1942091@chino.kir.corp.google.com>
References: <20200701152621.D520E62B@viggo.jf.intel.com> <20200701152627.8761147E@viggo.jf.intel.com> <alpine.DEB.2.23.453.2007011256280.1908531@chino.kir.corp.google.com> <20200701200446.ki5hdgarcpmo2vuf@intel.com>
 <0dd57932-44cf-0c2d-e157-07a8d7324006@intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Dave Hansen wrote:

> On 7/1/20 1:04 PM, Ben Widawsky wrote:
> >> +static inline bool node_reclaim_enabled(void)
> >> +{
> >> +	/* Is any node_reclaim_mode bit set? */
> >> +	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
> >> +}
> >> +
> >>  extern void check_move_unevictable_pages(struct pagevec *pvec);
> >>  
> >>  extern int kswapd_run(int nid);
> > If a user writes a bit that isn't a RECLAIM_* bit to vm.zone_reclaim_mode 
> > today, it acts as though RECLAIM_ZONE is enabled: we try to reclaim in 
> > zonelist order before falling back to the next zone in the page allocator.  
> > The sysctl doesn't enforce any max value :/  I dont know if there is any 
> > such user, but this would break them if there is.
> > 
> > Should this simply be return !!node_reclaim_mode?
> 
> You're right that there _could_ be a user-visible behavior change here.
>  But, if there were a change it would be for a bit which wasn't even
> mentioned in the documentation.  Somebody would have had to look at the
> doc mentioning 1,2,4 and written an 8.  If they did that, they're asking
> for trouble because we could have defined the '8' bit to do nasty things
> like auto-demote all your memory. :)
> 
> I'll mention it in the changelog, but I still think we should check the
> actual, known bits rather than check for 0.
> 
> BTW, in the hardware, they almost invariably make unused bits "reserved"
> and do mean things like #GP if someone tries to set them.  This is a
> case where the kernel probably should have done the same.  It would have
> saved us the trouble of asking these questions now.  Maybe we should
> even do that going forward.
> 

Maybe enforce it in a sysctl handler so the user catches any errors, which 
would be better than silently accepting some policy that doesn't exist?

RECLAIM_UNMAP and/or RECLAIM_WRITE should likely get -EINVAL if attempted 
to be set without RECLAIM_ZONE as well: they are no-ops without 
RECLAIM_ZONE.  This would likely have caught something wrong with commit 
648b5cf368e0 ("mm/vmscan: remove unused RECLAIM_OFF/RECLAIM_ZONE") if it 
would have already been in place.

I don't feel strongly about this, so feel free to ignore.
