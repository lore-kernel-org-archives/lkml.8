Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41288C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FD92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgBYHQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:16:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:55875 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbgBYHQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:16:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 23:16:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230068082"
Received: from plaxmina-desktop.iind.intel.com ([10.145.162.62])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 23:16:13 -0800
From:   Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To:     jani.nikula@linux.intel.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ville.syrjala@linux.intel.com, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        mripard@kernel.org, mihail.atanassov@arm.com
Cc:     pankaj.laxminarayan.bharadiya@intel.com,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: [RFC][PATCH 0/5] Introduce drm scaling filter property 
Date:   Tue, 25 Feb 2020 12:35:40 +0530
Message-Id: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integer scaling (IS) is a nearest-neighbor upscaling technique that
simply scales up the existing pixels by an integer (i.e., whole
number) multiplier. Nearest-neighbor (NN) interpolation works by
filling in the missing color values in the upscaled image with that of
the coordinate-mapped nearest source pixel value.

Both IS and NN preserve the clarity of the original image. In
contrast, traditional upscaling algorithms, such as bilinear or
bicubic interpolation, result in blurry upscaled images because they
employ interpolation techniques that smooth out the transition from
one pixel to another.  Therefore, integer scaling is particularly
useful for pixel art games that rely on sharp, blocky images to
deliver their distinctive look.

Many gaming communities have been asking for integer-mode scaling
support, some links and background:

https://software.intel.com/en-us/articles/integer-scaling-support-on-intel-graphics
http://tanalin.com/en/articles/lossless-scaling/
https://community.amd.com/thread/209107
https://www.nvidia.com/en-us/geforce/forums/game-ready-drivers/13/1002/feature-request-nonblurry-upscaling-at-integer-rat/

This patch series -
  - Introduces new scaling filter property to allow userspace to
    select  the driver's default scaling filter or Nearest-neighbor(NN)
    filter for scaling operations on crtc/plane.
  - Implements and enable integer scaling for i915

Userspace patch series link: TBD.

Thanks to Shashank for initiating this work. His initial RFC can be
found here [1]

[1] https://patchwork.freedesktop.org/patch/337082/

Modifications done in this series -
   - refactored code and incorporated initial review comments and
     added 2 scaling filter types (default and NN) to begin with.
   - added scaling filter property support for planes and new API
     helpers for drivers to setup this property.
   - rewrote code to enable integer scaling and NN filter for i915


Pankaj Bharadiya (5):
  drm: Introduce scaling filter property
  drm/drm-kms.rst: Add Scaling filter property documentation
  drm/i915: Enable scaling filter for plane and pipe
  drm/i915: Introduce scaling filter related registers and bit fields.
  drm/i915/display: Add Nearest-neighbor based integer scaling support

 Documentation/gpu/drm-kms.rst                |   6 ++
 drivers/gpu/drm/drm_atomic_uapi.c            |   8 ++
 drivers/gpu/drm/drm_crtc.c                   |  16 +++
 drivers/gpu/drm/drm_mode_config.c            |  13 +++
 drivers/gpu/drm/drm_plane.c                  |  35 +++++++
 drivers/gpu/drm/i915/display/intel_display.c | 100 ++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_display.h |   2 +
 drivers/gpu/drm/i915/display/intel_sprite.c  |  32 ++++--
 drivers/gpu/drm/i915/i915_reg.h              |  21 ++++
 include/drm/drm_crtc.h                       |  10 ++
 include/drm/drm_mode_config.h                |   6 ++
 include/drm/drm_plane.h                      |  14 +++
 12 files changed, 252 insertions(+), 11 deletions(-)

-- 
2.23.0

