Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F694C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ED421835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWN2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:28:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:64111 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbgAWN2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:28:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 05:28:32 -0800
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="216257967"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 05:28:28 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drm/i915: conversion to new drm logging macros.
In-Reply-To: <20200121134559.17355-1-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200121134559.17355-1-wambui.karugax@gmail.com>
Date:   Thu, 23 Jan 2020 15:28:25 +0200
Message-ID: <87zheecneu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> This series continues the conversion to the new struct drm_device based
> logging macros in various files in drm/i915. These patches were
> achieved both using coccinelle and manually.
>
> v2: rebase patches onto drm-tip to fix merge conflict in v1 series.

Pushed all to drm-intel-next-queued, many thanks for the patches, and
keep up the good work!

BR,
Jani.


>
> Wambui Karuga (5):
>   drm/i915/atomic: use struct drm_device logging macros for debug
>   drm/i915/bios: convert to struct drm_device based logging macros.
>   drm/i915/audio: convert to new struct drm_device logging macros.
>   drm/i915/bw: convert to new drm_device based logging macros.
>   drm/i915/cdclk: use new struct drm_device logging macros.
>
>  .../gpu/drm/i915/display/intel_atomic_plane.c |   9 +-
>  drivers/gpu/drm/i915/display/intel_audio.c    |  73 ++--
>  drivers/gpu/drm/i915/display/intel_bios.c     | 357 +++++++++++-------
>  drivers/gpu/drm/i915/display/intel_bw.c       |  29 +-
>  drivers/gpu/drm/i915/display/intel_cdclk.c    | 109 +++---
>  5 files changed, 339 insertions(+), 238 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
