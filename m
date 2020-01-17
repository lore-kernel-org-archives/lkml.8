Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F219BC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06B02073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQQUb8An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgAQXWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:22:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730075AbgAQXWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579303334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/SHYbTc4mVQlnGSSRKlNXBA4512ItBob86hriSAwCo=;
        b=PQQUb8Anov88HLEqj9Uurmi51e/cPPe+8QtSPPQux6A2J4I2Tjz7Jvnx/OR16wRM7cXJIa
        Oc3UAOR38Seq3iiBIFsAezzWfYtyIkTTKrB5nEYlceD7q1ros9AY2eNfYkLgi3CAD0Jf/d
        LW4UbpJCJelGeU330ImargskCpQcNBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-W9xSDrvmNN6DIb-3p0VLUw-1; Fri, 17 Jan 2020 18:22:11 -0500
X-MC-Unique: W9xSDrvmNN6DIb-3p0VLUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 980228017CC;
        Fri, 17 Jan 2020 23:22:08 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7315A5C1D8;
        Fri, 17 Jan 2020 23:22:03 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>
Cc:     Perry Yuan <pyuan@redhat.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/i915: Don't use VBT for detecting DPCD backlight controls
Date:   Fri, 17 Jan 2020 18:21:54 -0500
Message-Id: <20200117232155.135579-1-lyude@redhat.com>
In-Reply-To: <20200116211623.53799-5-lyude@redhat.com>
References: <20200116211623.53799-5-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite the fact that the VBT appears to have a field for specifying
that a system is equipped with a panel that supports standard VESA
backlight controls over the DP AUX channel, so far every system we've
spotted DPCD backlight control support on doesn't actually set this
field correctly and all have it set to INTEL_BACKLIGHT_DISPLAY_DDI.

While we don't know the exact reason for this VBT misuse, talking with
some vendors indicated that there's a good number of laptop panels out
there that supposedly support both PWM backlight controls and DPCD
backlight controls as a workaround until Intel supports DPCD backlight
controls across platforms universally. This being said, the X1 Extreme
2nd Gen that I have here (note that Lenovo is not the hardware vendor
that informed us of this) PWM backlight controls are advertised, but
only DPCD controls actually function. I'm going to make an educated
guess here and say that on systems like this one, it's likely that PWM
backlight controls might have been intended to work but were never
really tested by QA.

Since we really need backlights to work without any extra module
parameters, let's take the risk here and rely on the standard DPCD caps
to tell us whether AUX backlight controls are supported or not. We still
check the VBT, just so we can print a debugging message on systems that
advertise DPCD backlight support on the panel but not in the VBT.

Changes since v3:
* Print a debugging message if we enable DPCD backlight control on a
  device which doesn't report DPCD backlight controls in it's VBT,
  instead of warning on custom panel backlight interfaces.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D112376
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Perry Yuan <pyuan@redhat.com>
Cc: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 77a759361c5c..0f8edc775375 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -328,15 +328,16 @@ intel_dp_aux_display_control_capable(struct intel_c=
onnector *connector)
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_conn=
ector)
 {
 	struct intel_panel *panel =3D &intel_connector->panel;
-	struct drm_i915_private *dev_priv =3D to_i915(intel_connector->base.dev=
);
+	enum intel_backlight_type type =3D
+		to_i915(intel_connector->base.dev)->vbt.backlight.type;
=20
 	if (i915_modparams.enable_dpcd_backlight =3D=3D 0 ||
 	    (i915_modparams.enable_dpcd_backlight =3D=3D -1 &&
-	    dev_priv->vbt.backlight.type !=3D INTEL_BACKLIGHT_VESA_EDP_AUX_INTE=
RFACE))
+	     !intel_dp_aux_display_control_capable(intel_connector)))
 		return -ENODEV;
=20
-	if (!intel_dp_aux_display_control_capable(intel_connector))
-		return -ENODEV;
+	if (type !=3D INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
+		DRM_DEBUG_DRIVER("Ignoring VBT backlight type\n");
=20
 	panel->backlight.setup =3D intel_dp_aux_setup_backlight;
 	panel->backlight.enable =3D intel_dp_aux_enable_backlight;
--=20
2.24.1

