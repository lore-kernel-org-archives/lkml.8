Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C15C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6E120789
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T1CWLk9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390691AbgFXMjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389677AbgFXMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:39:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA42C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:39:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l17so1587905qki.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O/0cdThP5fAQ+/smPXNv+odghzJr2Q1Aqw1IMd91wZA=;
        b=T1CWLk9BQg8bxbXVlDHiZ1HNK9aWUgDyhnwXlvf7G1lp4EM9sfXD7Q96jVRjiz4yrZ
         lY9Rk9EgtMdOZNia1/0n1xS5Mjy1TvArYxGBRmc0xwkGY/PrAUeLiHUHCDzap5ESq+xn
         je4qakoryfYVA737t+MaVGU0Oar7bLHbZmOMAbAm/JXvDJETc6f1D3NY/LWERUg9I2AV
         D2I4p2/CHPScP0wpsmK89qHyw43+Rk+uqjpdjydVUuL3TDulgH9u+cv45WsODs4qD1Mu
         s4aihH09jLgE/IZaZb8127eRoffii0+tGVlAT9cDjZ9XpFo5Gp3mAI/4yPigpo7hbbl/
         WHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/0cdThP5fAQ+/smPXNv+odghzJr2Q1Aqw1IMd91wZA=;
        b=mF5wdK9K+mmhaJ98ClMMSHQE7vGwdlu753i9gNgBSLVmORo84LtKkHDX6bHF82wEqt
         NA5tLeoHKFbeEsj39ZJMNcYjdJiLLULaNjbhRkNekKozDaKS7Rp1kFEp+vvFTsr8Z3rO
         4dirSk/HzQKebjdBw+fuiyXokydV4dP14lNfQ3KeMIEfA9LygW01pb4/7SbjGyO0QsCC
         u9bQtC4K9bKMy5Il8kFqW98Gutnd6Uvaw/SMudjCUilb1XFlnkgND+6hrGanqye808pL
         d6jmo1NuEOnVnkKN/9vY6veLpaTu1s9VwNWLDbJ75JVgcA05RjBI6MMnFISPgF8OsF1/
         TLuQ==
X-Gm-Message-State: AOAM532o2ig6fQcTCdaqIyQqBpbWFFBnJ0pXqrJow85H9DUzFmJCKquH
        yz92choa7RZJYdoRo/PTDBH8aw==
X-Google-Smtp-Source: ABdhPJzsppi/TSTervD1YOTkftKCwoEPTx4uYqETqOWiNzYhzo6xfHzVvPg4ru+tFHHQY6xy8smpbw==
X-Received: by 2002:a37:ef08:: with SMTP id j8mr25034888qkk.442.1593002351998;
        Wed, 24 Jun 2020 05:39:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x19sm3587303qtc.36.2020.06.24.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 05:39:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo4gI-00DKtq-DH; Wed, 24 Jun 2020 09:39:10 -0300
Date:   Wed, 24 Jun 2020 09:39:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with
 MAYFAIL
Message-ID: <20200624123910.GA3178169@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk>
 <20200624121053.GD6578@ziepe.ca>
 <159300126338.4527.3968787379471939056@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159300126338.4527.3968787379471939056@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:21:03PM +0100, Chris Wilson wrote:
> Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> > On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > > reclaim, the calling context is unknown and may include attempts to
> > > unmap one page of a dma object while attempting to allocate more pages
> > > for that object. Pass the information along that we are inside an
> > > opportunistic unmap that can allow that page to remain referenced and
> > > mapped, and let the callback opt in to avoiding a recursive wait.
> > 
> > i915 should already not be holding locks shared with the notifiers
> > across allocations that can trigger reclaim. This is already required
> > to use notifiers correctly anyhow - why do we need something in the
> > notifiers?
> 
> for (n = 0; n < num_pages; n++)
> 	pin_user_page()
> 
> may call try_to_unmap_page from the lru shrinker for [0, n-1].

Yes, of course you can't hold any locks that intersect with notifiers
across pin_user_page()/get_user_page()

It has always been that way.

I consolidated all this tricky locking into interval notifiers, maybe
updating i915 to use them will give it a solution. I looked at it
once, it was straightforward enough until it got to all the #ifdefery

> We're in the middle of allocating the object, how are we best to untangle
> that?

I don't know anything about i915, but this is clearly i915 not using
notifiers properly, it needs proper fixing, not hacking up notifiers.

Jason
