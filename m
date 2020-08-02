Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2582920738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgHBNSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:18:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:3848 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgHBNSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:18:13 -0400
IronPort-SDR: kKa7xpxMSHvfwalvfexwPfAKpw55KsxB5VEA06/uhbbLLm91i27r3IHE2SkV1/9YfI25HiRGEz
 3JtTTLzlX9Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="131561915"
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="131561915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 06:18:13 -0700
IronPort-SDR: D0XnYzrieY4fJFknkIn+xxzWKYgbCdjdSTI2rYUnCxaJcO5PpvCPzo7wH34w0rjIiMQc6QlL9A
 RF1kyDOpmLqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="331622703"
Received: from cahanley-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.10.182])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2020 06:18:09 -0700
Date:   Sun, 2 Aug 2020 16:18:09 +0300
From:   Andi Shyti <andi.shyti@intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        <dri-devel@lists.freedesktop.org>, <airlied@linux.ie>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <tianjia.zhang@alibaba.com>, <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix wrong return value
Message-ID: <20200802131809.GE4705@intel.intel>
References: <20200802111534.5155-1-tianjia.zhang@linux.alibaba.com>
 <20200802114044.GD4705@intel.intel>
 <159636908251.23037.6183292610375916917@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159636908251.23037.6183292610375916917@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> > > index d960d0be5bd2..cc017e3cc9c5 100644
> > > --- a/drivers/gpu/drm/i915/i915_active.c
> > > +++ b/drivers/gpu/drm/i915/i915_active.c
> > > @@ -758,7 +758,7 @@ int i915_active_acquire_preallocate_barrier(struct i915_active *ref,
> > >       intel_engine_mask_t tmp, mask = engine->mask;
> > >       struct llist_node *first = NULL, *last = NULL;
> > >       struct intel_gt *gt = engine->gt;
> > > -     int err;
> > > +     int err = 0;
> > 
> > you don't need the initialization here.
> 
> But it's close enough that I can munge the patch inline.
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

sure... you can also remove it before merging it and it might
also need:

Fixes: d8af05ff38ae7 ("drm/i915: Allow sharing the idle-barrier from other kernel requests)

but, yeah...

Reviewed-by: Andi Shyti <andi.shyti@intel.com>

... as well :)

Andi
