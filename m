Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB18C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B51B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCLOEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:04:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:63187 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCLOEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:04:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="232063290"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 12 Mar 2020 07:04:35 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 12 Mar 2020 16:04:34 +0200
Date:   Thu, 12 Mar 2020 16:04:34 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     jani.nikula@linux.intel.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, mripard@kernel.org, mihail.atanassov@arm.com,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: Re: [RFC][PATCH 0/5] Introduce drm scaling filter property
Message-ID: <20200312140434.GG13686@intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:35:40PM +0530, Pankaj Bharadiya wrote:
> Integer scaling (IS) is a nearest-neighbor upscaling technique that
> simply scales up the existing pixels by an integer (i.e., whole
> number) multiplier. Nearest-neighbor (NN) interpolation works by
> filling in the missing color values in the upscaled image with that of
> the coordinate-mapped nearest source pixel value.
> 
> Both IS and NN preserve the clarity of the original image. In
> contrast, traditional upscaling algorithms, such as bilinear or
> bicubic interpolation, result in blurry upscaled images because they
> employ interpolation techniques that smooth out the transition from
> one pixel to another.  Therefore, integer scaling is particularly
> useful for pixel art games that rely on sharp, blocky images to
> deliver their distinctive look.
> 
> Many gaming communities have been asking for integer-mode scaling
> support, some links and background:
> 
> https://software.intel.com/en-us/articles/integer-scaling-support-on-intel-graphics
> http://tanalin.com/en/articles/lossless-scaling/
> https://community.amd.com/thread/209107
> https://www.nvidia.com/en-us/geforce/forums/game-ready-drivers/13/1002/feature-request-nonblurry-upscaling-at-integer-rat/
> 
> This patch series -
>   - Introduces new scaling filter property to allow userspace to
>     select  the driver's default scaling filter or Nearest-neighbor(NN)
>     filter for scaling operations on crtc/plane.
>   - Implements and enable integer scaling for i915
> 
> Userspace patch series link: TBD.

That needs to be done or this will go nowhere.

> 
> Thanks to Shashank for initiating this work. His initial RFC can be
> found here [1]
> 
> [1] https://patchwork.freedesktop.org/patch/337082/
> 
> Modifications done in this series -
>    - refactored code and incorporated initial review comments and
>      added 2 scaling filter types (default and NN) to begin with.
>    - added scaling filter property support for planes and new API
>      helpers for drivers to setup this property.
>    - rewrote code to enable integer scaling and NN filter for i915
> 
> 
> Pankaj Bharadiya (5):
>   drm: Introduce scaling filter property
>   drm/drm-kms.rst: Add Scaling filter property documentation
>   drm/i915: Enable scaling filter for plane and pipe
>   drm/i915: Introduce scaling filter related registers and bit fields.
>   drm/i915/display: Add Nearest-neighbor based integer scaling support
> 
>  Documentation/gpu/drm-kms.rst                |   6 ++
>  drivers/gpu/drm/drm_atomic_uapi.c            |   8 ++
>  drivers/gpu/drm/drm_crtc.c                   |  16 +++
>  drivers/gpu/drm/drm_mode_config.c            |  13 +++
>  drivers/gpu/drm/drm_plane.c                  |  35 +++++++
>  drivers/gpu/drm/i915/display/intel_display.c | 100 ++++++++++++++++++-
>  drivers/gpu/drm/i915/display/intel_display.h |   2 +
>  drivers/gpu/drm/i915/display/intel_sprite.c  |  32 ++++--
>  drivers/gpu/drm/i915/i915_reg.h              |  21 ++++
>  include/drm/drm_crtc.h                       |  10 ++
>  include/drm/drm_mode_config.h                |   6 ++
>  include/drm/drm_plane.h                      |  14 +++
>  12 files changed, 252 insertions(+), 11 deletions(-)
> 
> -- 
> 2.23.0

-- 
Ville Syrjälä
Intel
