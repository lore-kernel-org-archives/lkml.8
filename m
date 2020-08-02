Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93ED42075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgHBLvt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:51:49 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:51468 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726578AbgHBLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:51:46 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22008785-1500050 
        for multiple; Sun, 02 Aug 2020 12:51:23 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200802114044.GD4705@intel.intel>
References: <20200802111534.5155-1-tianjia.zhang@linux.alibaba.com> <20200802114044.GD4705@intel.intel>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix wrong return value
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     dri-devel@lists.freedesktop.org, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@alibaba.com, matthew.auld@intel.com
To:     Andi Shyti <andi.shyti@intel.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date:   Sun, 02 Aug 2020 12:51:22 +0100
Message-ID: <159636908251.23037.6183292610375916917@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Shyti (2020-08-02 12:40:44)
> Hi Tianjia,
> 
> > diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> > index d960d0be5bd2..cc017e3cc9c5 100644
> > --- a/drivers/gpu/drm/i915/i915_active.c
> > +++ b/drivers/gpu/drm/i915/i915_active.c
> > @@ -758,7 +758,7 @@ int i915_active_acquire_preallocate_barrier(struct i915_active *ref,
> >       intel_engine_mask_t tmp, mask = engine->mask;
> >       struct llist_node *first = NULL, *last = NULL;
> >       struct intel_gt *gt = engine->gt;
> > -     int err;
> > +     int err = 0;
> 
> you don't need the initialization here.

But it's close enough that I can munge the patch inline.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
