Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF0C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A022083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAQPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:47:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:12547 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgAQPrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:47:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 07:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="218941387"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 07:47:22 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Use new logging macros in drm/i915
In-Reply-To: <cover.1578560355.git.wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1578560355.git.wambui.karugax@gmail.com>
Date:   Fri, 17 Jan 2020 17:47:20 +0200
Message-ID: <877e1qgk53.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> This patchset continues the conversion to using the new struct
> drm_device based logging macros in drm/i915.

Pushed to drm-intel-next-queued, thanks for the patches.

BR,
Jani.

>
> Wambui Karuga (5):
>   drm/i915: conversion to new logging macros in i915/i915_vgpu.c
>   drm/i915: conversion to new logging macros in i915/intel_csr.c
>   drm/i915: conversion to new logging macros in i915/intel_device_info.c
>   drm/i915: convert to new logging macros in i915/intel_gvt.c
>   drm/i915: convert to new logging macros in i915/intel_memory_region.c
>
>  drivers/gpu/drm/i915/i915_vgpu.c           | 41 +++++++++++++---------
>  drivers/gpu/drm/i915/intel_csr.c           | 24 +++++++------
>  drivers/gpu/drm/i915/intel_device_info.c   | 25 +++++++------
>  drivers/gpu/drm/i915/intel_gvt.c           | 13 ++++---
>  drivers/gpu/drm/i915/intel_memory_region.c |  4 ++-
>  5 files changed, 64 insertions(+), 43 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
