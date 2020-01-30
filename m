Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6479C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D552082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgA3QeS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:34:18 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:57333 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727338AbgA3QeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:34:17 -0500
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2020 11:34:16 EST
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20062184-1500050 
        for multiple; Thu, 30 Jan 2020 16:18:00 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wi31OH0Rjv5=0ELTz3ZFUVaARmvq+w-oy+pRpGENd-iEA@mail.gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
 <CAHk-=wi31OH0Rjv5=0ELTz3ZFUVaARmvq+w-oy+pRpGENd-iEA@mail.gmail.com>
Message-ID: <158040107875.18112.5093555261012183633@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [git pull] drm for 5.6-rc1
Date:   Thu, 30 Jan 2020 16:17:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2020-01-30 16:13:24)
> On Wed, Jan 29, 2020 at 9:58 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > It has two known conflicts, one in i915_gem_gtt, where you should juat
> > take what's in the pull (it looks messier than it is),
> 
> That doesn't seem right. If I do that, I lose the added GEM_BUG_ON()'s.
> 
> I think the proper merge resolution does this:
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> index f10b2c41571c..f4fec7eb4064 100644
> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> @@ -131,6 +131,7 @@ static void gen6_ppgtt_insert_entries(struct
> i915_address_space *vm,
> 
>         vaddr = kmap_atomic_px(i915_pt_entry(pd, act_pt));
>         do {
> +               GEM_BUG_ON(iter.sg->length < I915_GTT_PAGE_SIZE);
>                 vaddr[act_pte] = pte_encode | GEN6_PTE_ADDR_ENCODE(iter.dma);
> 
>                 iter.dma += I915_GTT_PAGE_SIZE;
> diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
> b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
> index 077b8f7cf6cb..4d1de2d97d5c 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
> @@ -379,6 +379,7 @@ gen8_ppgtt_insert_pte(struct i915_ppgtt *ppgtt,
>         pd = i915_pd_entry(pdp, gen8_pd_index(idx, 2));
>         vaddr = kmap_atomic_px(i915_pt_entry(pd, gen8_pd_index(idx, 1)));
>         do {
> +               GEM_BUG_ON(iter->sg->length < I915_GTT_PAGE_SIZE);
>                 vaddr[gen8_pd_index(idx, 0)] = pte_encode | iter->dma;
> 
>                 iter->dma += I915_GTT_PAGE_SIZE;

Yes, that matches the code in drm-intel-next-queued.
-Chris
