Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D409BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A612084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5TaUxzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBDT2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:28:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbgBDT2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jN9F1jju3DTsHk55X7khAIcnUVHNVuohHBr9YCstd0=;
        b=h5TaUxzT3cCt5m7/SjSJbqSpL7xhY1jWozBsZs9YQZtnm6CkoCO21vzN0mdfIdlF3j3rJ4
        eYG4TGC+jvQPFeE+HtlEEiVQxcmB05xHDMwTFykR452yMOrjadB0TFd+gAheo8ptsB/UFi
        bPr7Gs0IhkFv/ErxP98Gx+kVWtzcCsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-MB4oF2nKOa63n1nomfd_3Q-1; Tue, 04 Feb 2020 14:28:38 -0500
X-MC-Unique: MB4oF2nKOa63n1nomfd_3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599EB1005F74;
        Tue,  4 Feb 2020 19:28:36 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F371D85750;
        Tue,  4 Feb 2020 19:28:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Revert "drm/i915: Don't use VBT for detecting DPCD backlight controls"
Date:   Tue,  4 Feb 2020 14:28:09 -0500
Message-Id: <20200204192823.111404-2-lyude@redhat.com>
In-Reply-To: <20200204192823.111404-1-lyude@redhat.com>
References: <20200204192823.111404-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d2a4bb6f8bc8cf2d788adf7e59b5b52fe3a3333c.

So, turns out that this ended up just breaking things. While many
laptops incorrectly advertise themselves as supporting PWM backlight
controls, they actually will only work with DPCD backlight controls.
Unfortunately, it also seems there are a number of systems which
advertise DPCD backlight controls in their eDP DPCD but don't actually
support them. Talking with some laptop manufacturers has shown it might
be possible to probe this support via the EDID (!?!?) but I haven't been
able to confirm that this would work on any other manufacturer's
systems.

So in the mean time, we'll just revert this commit for now and go back
to the old way of doing things. Additionally, let's print out an info
message into the kernel log so that it's a little more obvious if a
system needs DPCD backlight controls enabled through a quirk (which
we'll introduce in the next commit).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index e86feebef299..48276237b362 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -328,16 +328,15 @@ intel_dp_aux_display_control_capable(struct intel_c=
onnector *connector)
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_conn=
ector)
 {
 	struct intel_panel *panel =3D &intel_connector->panel;
-	enum intel_backlight_type type =3D
-		to_i915(intel_connector->base.dev)->vbt.backlight.type;
+	struct drm_i915_private *dev_priv =3D to_i915(intel_connector->base.dev=
);
=20
 	if (i915_modparams.enable_dpcd_backlight =3D=3D 0 ||
 	    (i915_modparams.enable_dpcd_backlight =3D=3D -1 &&
-	     !intel_dp_aux_display_control_capable(intel_connector)))
+	    dev_priv->vbt.backlight.type !=3D INTEL_BACKLIGHT_VESA_EDP_AUX_INTE=
RFACE))
 		return -ENODEV;
=20
-	if (type !=3D INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
-		DRM_DEBUG_DRIVER("Ignoring VBT backlight type\n");
+	if (!intel_dp_aux_display_control_capable(intel_connector))
+		return -ENODEV;
=20
 	panel->backlight.setup =3D intel_dp_aux_setup_backlight;
 	panel->backlight.enable =3D intel_dp_aux_enable_backlight;
--=20
2.24.1

