Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677D1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484C82075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHBLkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:40:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:63624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHBLku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:40:50 -0400
IronPort-SDR: pIGuwzKufxs2akpL7Yzx78afU0RZauTKHGS6xV/4EoAVUJgZkUGUpM1NZqLberyEXO4v4ACCWR
 v9KyncTaziaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="153201991"
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="153201991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 04:40:50 -0700
IronPort-SDR: zTmAvTqRF5Q/d8MAJQczFCPyOgqePoEIe4gpsyHTg45B1dHmF8LJdjZvJFUotZCyOJbim2Oxxp
 KUn8qpeVMTlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="366035580"
Received: from cahanley-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.10.182])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2020 04:40:45 -0700
Date:   Sun, 2 Aug 2020 14:40:44 +0300
From:   Andi Shyti <andi.shyti@intel.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <chris@chris-wilson.co.uk>, <matthew.auld@intel.com>,
        <tvrtko.ursulin@intel.com>, <mika.kuoppala@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <tianjia.zhang@alibaba.com>
Subject: Re: [PATCH] drm/i915: Fix wrong return value
Message-ID: <20200802114044.GD4705@intel.intel>
References: <20200802111534.5155-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802111534.5155-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianjia,

> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index d960d0be5bd2..cc017e3cc9c5 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -758,7 +758,7 @@ int i915_active_acquire_preallocate_barrier(struct i915_active *ref,
>  	intel_engine_mask_t tmp, mask = engine->mask;
>  	struct llist_node *first = NULL, *last = NULL;
>  	struct intel_gt *gt = engine->gt;
> -	int err;
> +	int err = 0;

you don't need the initialization here.

Thanks,
Andi
