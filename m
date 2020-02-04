Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED300C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51802253D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQleXxUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBDT3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:29:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28310 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbgBDT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZq825i0coPwIgxr8swXpBmvjatE/H/TFgDNYkwo1tw=;
        b=iQleXxUXFDip6RBzChFTtyz/zKAuqK1TLpPu+pLVwcAFk5wFDG66axLJQXTmU+6Rsc/tdK
        OOaU5wt64VfjwanJxCc1MeSVezVc3TeGHQ7rqmLo2IT47EhOeoSQMlKgwb5LTVhX78BtwE
        wrp9U9hvaHD/NUTS6I5MIFRR0caCnFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-TeS3TFhVNmqD3iD8BFX3Bg-1; Tue, 04 Feb 2020 14:28:52 -0500
X-MC-Unique: TeS3TFhVNmqD3iD8BFX3Bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA34319057A8;
        Tue,  4 Feb 2020 19:28:49 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F6CB8068E;
        Tue,  4 Feb 2020 19:28:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED panel
Date:   Tue,  4 Feb 2020 14:28:11 -0500
Message-Id: <20200204192823.111404-4-lyude@redhat.com>
In-Reply-To: <20200204192823.111404-1-lyude@redhat.com>
References: <20200204192823.111404-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1 Extreme is one of the systems that lies about which backlight
interface that it uses in its VBIOS as PWM backlight controls don't work
at all on this machine. It's possible that this panel could be one of
the infamous ones that can switch between PWM mode and DPCD backlight
control mode, but we haven't gotten any more details on this from Lenovo
just yet. For the time being though, making sure the backlight 'just
works' is a bit more important.

So, add a quirk to force DPCD backlight controls on for these systems
based on EDID (since this panel doesn't appear to fill in the device ID).
Hopefully in the future we'll figure out a better way of probing this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c               |  4 +++
 .../drm/i915/display/intel_dp_aux_backlight.c | 25 ++++++++++++++++---
 include/drm/drm_dp_helper.h                   | 10 ++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_hel=
per.c
index db23308f4d8b..a39c3cdacb20 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1236,6 +1236,10 @@ struct edid_quirk {
  * DP quirks in such cases.
  */
 static const struct edid_quirk edid_quirk_list[] =3D {
+	/* Optional 4K AMOLED panel in the ThinkPad X1 Extreme 2nd Generation
+	 * only supports DPCD backlight controls
+	 */
+	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
 };
=20
 #undef MFG
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 48276237b362..35a19c0314fa 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -328,15 +328,32 @@ intel_dp_aux_display_control_capable(struct intel_c=
onnector *connector)
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_conn=
ector)
 {
 	struct intel_panel *panel =3D &intel_connector->panel;
-	struct drm_i915_private *dev_priv =3D to_i915(intel_connector->base.dev=
);
+	struct intel_dp *intel_dp =3D enc_to_intel_dp(intel_connector->encoder)=
;
+	struct drm_device *dev =3D intel_connector->base.dev;
+	struct drm_i915_private *dev_priv =3D to_i915(dev);
=20
 	if (i915_modparams.enable_dpcd_backlight =3D=3D 0 ||
-	    (i915_modparams.enable_dpcd_backlight =3D=3D -1 &&
-	    dev_priv->vbt.backlight.type !=3D INTEL_BACKLIGHT_VESA_EDP_AUX_INTE=
RFACE))
+	    !intel_dp_aux_display_control_capable(intel_connector))
 		return -ENODEV;
=20
-	if (!intel_dp_aux_display_control_capable(intel_connector))
+	/*
+	 * There are a lot of machines that don't advertise the backlight
+	 * control interface to use properly in their VBIOS, :\
+	 */
+	if (dev_priv->vbt.backlight.type !=3D
+	    INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
+	    !drm_dp_has_quirk(&intel_dp->desc, intel_dp->edid_quirks,
+			      DP_QUIRK_FORCE_DPCD_BACKLIGHT)) {
+		DRM_DEV_INFO(dev->dev,
+			     "Panel advertises DPCD backlight support, but "
+			     "VBT disagrees. If your backlight controls "
+			     "don't work try booting with "
+			     "i915.enable_dpcd_backlight=3D1. If your machine "
+			     "needs this, please file a _new_ bug report on "
+			     "bugs.freedesktop.org against DRI -> "
+			     "DRM/Intel\n");
 		return -ENODEV;
+	}
=20
 	panel->backlight.setup =3D intel_dp_aux_setup_backlight;
 	panel->backlight.enable =3D intel_dp_aux_enable_backlight;
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 7f5dd2ee4a94..c5580e988826 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1535,6 +1535,16 @@ enum drm_dp_quirk {
 	 * The DSC caps can be read from the physical aux instead.
 	 */
 	DP_DPCD_QUIRK_DSC_WITHOUT_VIRTUAL_DPCD,
+	/**
+	 * @DP_QUIRK_FORCE_DPCD_BACKLIGHT:
+	 *
+	 * The device is telling the truth when it says that it uses DPCD
+	 * backlight controls, even if the system's firmware disagrees. This
+	 * quirk should be checked against both the ident and panel EDID.
+	 * When present, the driver should honor the DPCD backlight
+	 * capabilities advertised.
+	 */
+	DP_QUIRK_FORCE_DPCD_BACKLIGHT,
 };
=20
 /**
--=20
2.24.1

