Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1B2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dymmndgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390916AbgFXOZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbgFXOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:25:46 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21695C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:25:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id u8so1085855qvj.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4v52LhelGRWHo4E060iGv80Sg40kHoTOkJNdHp0l7w=;
        b=dymmndgStUdd0/3lQSMwLo/eL/Xa3bVbecbtngR0j1pxAmzSD5u+QfdVyDmEO/fuZp
         JXgn1eXUASD81w6G1vkwKVkFQSX/9453QuyJaGmfHKnkwmuol91YRWbAyPJvnfFK2D2X
         QmdM1pPzYdNMSwYTMDoQg+jvYCBbFuorT7eEhlbwU2C1KteUBgPKbe2uvnGvWq9DPbhA
         5/vIBvShOiYPV+UjYaPM+RkV0i3tcd/gXDVeiOjCVR8odXU6mHuoS+W23dXp6pYzL2pH
         BQZL8PsbGAqJcYviefOYG67H27DU3lPtFOkasDcQo5vVcL1n57Ateh7s8DnMFZp5YH/4
         xkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4v52LhelGRWHo4E060iGv80Sg40kHoTOkJNdHp0l7w=;
        b=nqzayZ1lYEgwdYrv6QHfRVlhweZ0/I7iEH20uU0bqltX7RncznY/xH/q+55g4koSZO
         nA1qhjf6SL2BQuw2lBo4JVLMU2CHxjmxUF8dVZU27ZNvu4SB+i+9lE0l9kN1irmmzpQw
         tu0DBvedijxzG2F4QBomRwLvnmb7XwT5EuCnJvVnZxOpBcJlwhhJuLBXIGt34quAUPA7
         U/9xmbcGXFMXiy9mpqMPs60+nvGVCBjU1HbC+6KTIEI/autnH8rBkxCxUkj0dzDNpSYU
         fHo5IooQQ0471pPKGycUYgQpDctGu9Du+kjfj+Vf3G2qsX1z83XTlTzUK8giEbyp/Cph
         XN8w==
X-Gm-Message-State: AOAM533XskkhRUiSRpshqrRPL7fJLwPQTAMBmgKvssqcZ3nbufdQ1OUm
        uhU/UOZDqN2lkXSOqSGv2F/xiMwMsx2Uhw==
X-Google-Smtp-Source: ABdhPJytdlYpgwrNlGYx3gebaoAxruYw79+A/Wp3ekG9B4Rc2tCTzSijdNEjaSUxVqjMevqv+3UZPA==
X-Received: by 2002:a05:6214:b23:: with SMTP id w3mr31814976qvj.63.1593008745274;
        Wed, 24 Jun 2020 07:25:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w28sm1408065qkw.92.2020.06.24.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:25:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo6LQ-00DVtv-C2; Wed, 24 Jun 2020 11:25:44 -0300
Date:   Wed, 24 Jun 2020 11:25:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with
 MAYFAIL
Message-ID: <20200624142544.GI6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk>
 <20200624121053.GD6578@ziepe.ca>
 <159300126338.4527.3968787379471939056@build.alporthouse.com>
 <20200624123910.GA3178169@ziepe.ca>
 <159300796224.4527.2014771396582759689@build.alporthouse.com>
 <20200624141604.GH6578@ziepe.ca>
 <159300850942.4527.8335506003268197914@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159300850942.4527.8335506003268197914@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:21:49PM +0100, Chris Wilson wrote:
> Quoting Jason Gunthorpe (2020-06-24 15:16:04)
> > On Wed, Jun 24, 2020 at 03:12:42PM +0100, Chris Wilson wrote:
> > > Quoting Jason Gunthorpe (2020-06-24 13:39:10)
> > > > On Wed, Jun 24, 2020 at 01:21:03PM +0100, Chris Wilson wrote:
> > > > > Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> > > > > > On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > > > > > > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > > > > > > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > > > > > > reclaim, the calling context is unknown and may include attempts to
> > > > > > > unmap one page of a dma object while attempting to allocate more pages
> > > > > > > for that object. Pass the information along that we are inside an
> > > > > > > opportunistic unmap that can allow that page to remain referenced and
> > > > > > > mapped, and let the callback opt in to avoiding a recursive wait.
> > > > > > 
> > > > > > i915 should already not be holding locks shared with the notifiers
> > > > > > across allocations that can trigger reclaim. This is already required
> > > > > > to use notifiers correctly anyhow - why do we need something in the
> > > > > > notifiers?
> > > > > 
> > > > > for (n = 0; n < num_pages; n++)
> > > > >       pin_user_page()
> > > > > 
> > > > > may call try_to_unmap_page from the lru shrinker for [0, n-1].
> > > > 
> > > > Yes, of course you can't hold any locks that intersect with notifiers
> > > > across pin_user_page()/get_user_page()
> > > 
> > > What lock though? It's just the page refcount, shrinker asks us to drop
> > > it [via mmu], we reply we would like to keep using that page as freeing
> > > it for the current allocation is "robbing Peter to pay Paul".
> > 
> > Maybe I'm unclear what this series is actually trying to fix? 
> > 
> > You said "avoiding a recursive wait" which sounds like some locking
> > deadlock to me.
> 
> It's the shrinker being called while we are allocating for/on behalf of
> the object. As we are actively using the object, we don't want to free
> it -- the partial object allocation being the clearest, if the object
> consists of 2 pages, trying to free page 0 in order to allocate page 1
> has to fail (and the shrinker should find another candidate to reclaim,
> or fail the allocation).

mmu notifiers are not for influencing policy of the mm.

Jason
