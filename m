Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB14C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F802075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhTMwzvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbgAPVQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:16:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388584AbgAPVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579209413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CVLaakfxRzdFH7zrwhN9w61T/zDrE+8CRjo+khT3XY=;
        b=LhTMwzvfy5it6D3fFHgJTeo8zGjz748hnvuegVry+7Lr/ttQFwdcRGAf4UeFaPuxWCyTQw
        OvpzupqCyeQlG97h6ws642J7wrCYojwQb/WjRuwwM93ShINqpGskBr/O9SSKh5+bXWDmwM
        IUVsI/ntNcJlgHPZc8TodTHsUA9/IDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-WUW8PizsPBu4_kQ5fg9ZDw-1; Thu, 16 Jan 2020 16:16:50 -0500
X-MC-Unique: WUW8PizsPBu4_kQ5fg9ZDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 016F463C78;
        Thu, 16 Jan 2020 21:16:48 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A508060C84;
        Thu, 16 Jan 2020 21:16:46 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Perry Yuan <pyuan@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] drm/i915: Assume 100% brightness when not in DPCD control mode
Date:   Thu, 16 Jan 2020 16:16:09 -0500
Message-Id: <20200116211623.53799-3-lyude@redhat.com>
In-Reply-To: <20200116211623.53799-1-lyude@redhat.com>
References: <20200116211623.53799-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we always determine the initial panel brightness level by
simply reading the value from DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB. This
seems wrong though, because if the panel is not currently in DPCD
control mode there's not really any reason why there would be any
brightness value programmed in the first place.

This appears to be the case on the Lenovo ThinkPad X1 Extreme 2nd
Generation, where the default value in these registers is always 0 on
boot despite the fact the panel runs at max brightness by default.
Getting the initial brightness value correct here is important as well,
since the panel on this laptop doesn't behave well if it's ever put into
DPCD control mode while the brightness level is programmed to 0.

So, let's fix this by checking what the current backlight control mode
is before reading the brightness level. If it's in DPCD control mode, we
return the programmed brightness level. Otherwise we assume 100%
brightness and return the highest possible brightness level. This also
prevents us from accidentally programming a brightness level of 0.

This is one of the many fixes that gets backlight controls working on
the ThinkPad X1 Extreme 2nd Generation with optional 4K AMOLED screen.

Changes since v1:
* s/DP_EDP_DISPLAY_CONTROL_REGISTER/DP_EDP_BACKLIGHT_MODE_SET_REGISTER/
  - Jani

Tested-by: AceLan Kao <acelan.kao@canonical.com>
Tested-by: Perry Yuan <pyuan@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 345eed641455..5d4db5f8a165 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -59,8 +59,25 @@ static u32 intel_dp_aux_get_backlight(struct intel_con=
nector *connector)
 {
 	struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder);
 	u8 read_val[2] =3D { 0x0 };
+	u8 mode_reg;
 	u16 level =3D 0;
=20
+	if (drm_dp_dpcd_readb(&intel_dp->aux,
+			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+			      &mode_reg) !=3D 1) {
+		DRM_DEBUG_KMS("Failed to read the DPCD register 0x%x\n",
+			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
+		return 0;
+	}
+
+	/*
+	 * If we're not in DPCD control mode yet, the programmed brightness
+	 * value is meaningless and we should assume max brightness
+	 */
+	if ((mode_reg & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK) !=3D
+	    DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD)
+		return connector->panel.backlight.max;
+
 	if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
 			     &read_val, sizeof(read_val)) < 0) {
 		DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
--=20
2.24.1

