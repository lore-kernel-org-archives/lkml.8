Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186CF20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJXkGH0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbgDMVo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:44:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388914AbgDMVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586814265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KQIqrFGUphmuFkBfyVpa5uYKSuyV3byu56jJQa16wH8=;
        b=HJXkGH0BNqRMBvKhXJue8gAwXpkYSgeXNCOKSPso4CPa+90xjD+sG6JJuv89g9WBgYKhxB
        z9i1eOkjT2p02ra5m7Gr9qNu8B+NlrRf2XLIJoLM8zxm9JfEHOoOMQq6Od/4DeJvciZS74
        YKdnK5xrUrZKq3mKDH9665de/rLRJqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-zHFU6IkTOpqpXbCPmWIjow-1; Mon, 13 Apr 2020 17:44:22 -0400
X-MC-Unique: zHFU6IkTOpqpXbCPmWIjow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10DB8010F1;
        Mon, 13 Apr 2020 21:44:18 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-134.rdu2.redhat.com [10.10.119.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C43D719C69;
        Mon, 13 Apr 2020 21:44:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Adam Jackson <ajax@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/dpcd_bl: Unbreak enable_dpcd_backlight modparam
Date:   Mon, 13 Apr 2020 17:44:06 -0400
Message-Id: <20200413214407.1851002-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like I accidentally made it so you couldn't force DPCD backlight
support on, whoops. Fix that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 17f5d57915be ("drm/i915: Force DPCD backlight mode on X1 Extreme 2=
nd Gen 4K AMOLED panel")
Cc: Adam Jackson <ajax@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Ville Syrj=C3=A4l=C3=A4" <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 4b916468540f..0722540d64ad 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -358,6 +358,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_co=
nnector *intel_connector)
 	 */
 	if (i915->vbt.backlight.type !=3D
 	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
+	    i915_modparams.enable_dpcd_backlight !=3D 1 &&
 	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
 			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
 		drm_info(&i915->drm,
--=20
2.25.1

