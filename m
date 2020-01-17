Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BAAC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CE72082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAQNvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:51:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:49828 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQNvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:51:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 05:51:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="218913054"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 05:51:33 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/i915/display: conversion to new logging macros.
In-Reply-To: <20200116130947.15464-1-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200116130947.15464-1-wambui.karugax@gmail.com>
Date:   Fri, 17 Jan 2020 15:51:30 +0200
Message-ID: <87pnfigpi5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> This series converts the printk based logging macros in
> drm/i915/display/intel_display.c to the new struct drm_device based
> logging macros. This change was split into four for manageability and
> due to the size of drm/i915/display/intel_display.c.

Please still write more descriptive commit messages than "part N".

What are your basing your patches on? Our CI uses drm-tip, and it's
failing to apply the patches.

BR,
Jani.



>
> Wambui Karuga (4):
>   drm/i915/display: conversion to new logging macros part 1
>   drm/i915/display: conversion to new logging macros part 2
>   drm/i915/display: conversion to new logging macros part 3
>   drm/i915/display: convert to new logging macros part 4.
>
>  drivers/gpu/drm/i915/display/intel_display.c | 1021 ++++++++++--------
>  1 file changed, 596 insertions(+), 425 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
