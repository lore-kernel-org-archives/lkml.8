Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C09EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6509120644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pp3345.net header.i=@pp3345.net header.b="HsTd/R6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbgDMVwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:52:19 -0400
Received: from saul.pp3345.net ([163.172.111.124]:56732 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389263AbgDMVwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:52:10 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id B92179A45E7;
        Mon, 13 Apr 2020 23:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1586814143; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references:openpgp:autocrypt;
        bh=n/IzmO0N6gIET0vwk4U2HeylR4qRjBoUXsC1sg9UhKY=;
        b=HsTd/R6OTqsIVav+boTDP0Q7z2ZZ5SjB31Sa2rIhXLInogSj6FKDNOlq0dbAJFm5lDQMMw
        KN3ECumoH5Luepy191UP6n3STUdSpIXRPtnZ5MZgyb2rShsEdKMW2aQ9VACLgGwrOKT3LH
        mKrf/Jdm4xuwargJQ84+EV8LZ0oK9lyDttUMY18UuNS8Y7XSUJpYEvPBnspaSqSmMjxM7W
        zSxlVtKXiAQcRHVPbzs5V7ZdRtnP21yM7cRVmGNHmR1DpnM4ZppNn0czeh5DBJhez2lkP+
        T15h7aoaIsM7p0lg+2AAqVM0+rX66TVK9PnaMW2S9ZfwQKOoyMiUJz5XicqSzA==
From:   Yussuf Khalil <dev@pp3345.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH 0/5] Improving the situation regarding RGB quantization ranges
Date:   Mon, 13 Apr 2020 23:40:20 +0200
Message-Id: <20200413214024.46500-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CTA-861 specification differentiates between IT and CE modes. For the
latter, it requires sources to send "limited RGB quantization range", i.e.,
allowed RGB values are constrained to 16 - 235 (in the 8 bit case). A sink may
indicate support for full range RGB (0 - 255) in CE modes through its EDID,
allowing the source to override the recommendations set by CTA-861.

For computer screens it is usually desirable to have full range RGB output. In
reality, though, many displays set a CE mode as preferred in their EDID and
leave the "Quantization Range Selectable" bit unset despite having no issues
with full range output. Therefore, it makes sense to provide the user with
a method of overriding the standards-compliant selection.

The current situation in DRM regarding the RGB quantization range is somewhat
messy. We have drivers that
 - behave standards-compliant and provide a custom override property (e.g.,
   i915, gma500)
 - behave standards-compliant and provide no override (e.g., vc4)
 - behave standards-compliant and select full range for CE modes if the screen
   indicates support (e.g., tda998x)
 - probably don't care at all

This series is an effort to fix the situation. It introduces a property for
overriding the RGB quantization range that is defined in the DRM core and can
be attached to connectors by all drivers, providing a driver-independent way of
overriding the defaults to userspace. So far, I've wired up the new property in
i915 only.

Yussuf Khalil (5):
  drm/modes: Indicate CEA-861 CE modes to user-space
  drm: Add "RGB quantization range" connector property
  drm: Add drm_connector_state_select_rgb_quantization_range() helper
  drm/atomic-helper: Consider RGB quantization changes to be mode
    changes
  drm/i915: Replace "Broadcast RGB" with "RGB quantization range"
    property

 drivers/gpu/drm/drm_atomic_helper.c           |  6 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 ++
 drivers/gpu/drm/drm_connector.c               | 66 +++++++++++++++++++
 drivers/gpu/drm/drm_modes.c                   | 14 ++++
 drivers/gpu/drm/i915/display/intel_atomic.c   |  8 ---
 .../gpu/drm/i915/display/intel_connector.c    | 39 ++++-------
 .../gpu/drm/i915/display/intel_connector.h    |  2 +-
 .../drm/i915/display/intel_display_types.h    |  8 ---
 drivers/gpu/drm/i915/display/intel_dp.c       | 24 ++-----
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 19 ++----
 drivers/gpu/drm/i915/display/intel_sdvo.c     | 18 ++---
 drivers/gpu/drm/i915/i915_drv.h               |  1 -
 include/drm/drm_connector.h                   | 27 ++++++++
 include/drm/drm_mode_config.h                 |  7 ++
 include/uapi/drm/drm_mode.h                   |  2 +
 16 files changed, 160 insertions(+), 87 deletions(-)

-- 
2.26.0

