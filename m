Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2CCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28B720728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQNp5/Mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbgAPVQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:16:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729991AbgAPVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579209404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XYpBIn2xi7ER9BDGUkOZA9lOy9JYb1E+lxLSXL5KsV0=;
        b=eQNp5/MxMeVDUeh4PkZsLXJsQ7TnSNyj0KwqowD2wNTYzYksJ91edREQJbtsPtcx7ITa9d
        GbknWVIDKBcSBvWZwVK6P0OMMVJCSB36YDq1P3wLZxi4m3Mw+1nY6D9uCgyWrDwS/C/5mQ
        fiXe6gi7Ig3sI5XT9wtiBlmBCm9TmK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-8SE2qs9WOcOQW2T5IJLV-A-1; Thu, 16 Jan 2020 16:16:41 -0500
X-MC-Unique: 8SE2qs9WOcOQW2T5IJLV-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E737184CACF;
        Thu, 16 Jan 2020 21:16:37 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5142D60C63;
        Thu, 16 Jan 2020 21:16:35 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, "Imre Deak" <imre.deak@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Ramalingam C" <ramalingam.c@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Lee Shawn C" <shawn.c.lee@intel.com>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 0/5] drm/i915: eDP DPCD aux backlight fixes
Date:   Thu, 16 Jan 2020 16:16:07 -0500
Message-Id: <20200116211623.53799-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got a ThinkPad X1 Extreme 2nd Generation for fixing some
issues on, and noticed that out of the box the backlight doesn't work.
Along the way of fixing that, I found a few issues with how i915 handles
DPCD AUX backlight control and fixed them. Now I've got working
backlight controls, hooray!

Note that this patch series enables DPCD backlight controls by default.
This time however, we ignore the backlight type advertised in the VBT
(unless it's a custom backlight interface that doesn't use the standard
VESA interface over AUX) and just trust the DPCD.

Lyude Paul (5):
  drm/i915: Fix eDP DPCD aux max backlight calculations
  drm/i915: Assume 100% brightness when not in DPCD control mode
  drm/i915: Fix DPCD register order in intel_dp_aux_enable_backlight()
  drm/i915: Don't use VBT for detecting DPCD backlight controls
  drm/i915: Auto detect DPCD backlight support by default

 .../drm/i915/display/intel_display_types.h    |   3 +
 .../drm/i915/display/intel_dp_aux_backlight.c | 175 ++++++++++++------
 drivers/gpu/drm/i915/i915_params.c            |   2 +-
 drivers/gpu/drm/i915/i915_params.h            |   2 +-
 4 files changed, 126 insertions(+), 56 deletions(-)

--=20
2.24.1

