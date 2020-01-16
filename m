Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC4C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541232082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc91MoHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbgAPVQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:16:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388584AbgAPVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579209416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vw6H7ASYVkU51Cq9DruCycaNw/+qQUS/vjyDCwvBhVI=;
        b=Lc91MoHUlBZQPBhx016PGQLNMJSGvpTPor878zp/CjgCWwyPhUOT7NewcCmFY6NL3pBN6L
        yefcPM6icXGiGiwad3d8V1c0s8KIr6WHqobtX6EgDgmnaKW9e5+JShhceYr7i2K562aX5q
        GAsxavgi7unHopIqmLwAzuJUFWQ8ntY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-otu8gQRUPUesT5gx5QpVYA-1; Thu, 16 Jan 2020 16:16:52 -0500
X-MC-Unique: otu8gQRUPUesT5gx5QpVYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD8371854336;
        Thu, 16 Jan 2020 21:16:50 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5723760C84;
        Thu, 16 Jan 2020 21:16:49 +0000 (UTC)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] drm/i915: Fix DPCD register order in intel_dp_aux_enable_backlight()
Date:   Thu, 16 Jan 2020 16:16:10 -0500
Message-Id: <20200116211623.53799-4-lyude@redhat.com>
In-Reply-To: <20200116211623.53799-1-lyude@redhat.com>
References: <20200116211623.53799-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For eDP panels, it appears it's expected that so long as the panel is in
DPCD control mode that the brightness value is never set to 0. Instead,
if the desired effect is to set the panel's backlight to 0 we're
expected to simply turn off the backlight through the
DP_EDP_DISPLAY_CONTROL_REGISTER.

We already do the latter correctly in intel_dp_aux_disable_backlight().
But, we make the mistake of writing the DPCD registers in the wrong
order when enabling the backlight in intel_dp_aux_enable_backlight()
since we currently enable the backlight through
DP_EDP_DISPLAY_CONTROL_REGISTER before writing the brightness level. On
the X1 Extreme 2nd Generation, this appears to have the potential of
confusing the panel in such a way that further attempts to set the
brightness don't actually change the backlight as expected and leave it
off. Presumably, this happens because the incorrect register writing
order briefly leaves the panel with DPCD mode enabled and a 0 brightness
level set.

So, reverse the order we write the DPCD registers when enabling the
panel backlight so that we write the brightness value first, and enable
the backlight second. This fix appears to be the final bit needed to get
the backlight on the ThinkPad X1 Extreme 2nd Generation's AMOLED screen
working.

Tested-by: AceLan Kao <acelan.kao@canonical.com>
Tested-by: Perry Yuan <pyuan@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 5d4db5f8a165..77a759361c5c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -207,8 +207,9 @@ static void intel_dp_aux_enable_backlight(const struc=
t intel_crtc_state *crtc_st
 		}
 	}
=20
+	intel_dp_aux_set_backlight(conn_state,
+				   connector->panel.backlight.level);
 	set_aux_backlight_enable(intel_dp, true);
-	intel_dp_aux_set_backlight(conn_state, connector->panel.backlight.level=
);
 }
=20
 static void intel_dp_aux_disable_backlight(const struct drm_connector_st=
ate *old_conn_state)
--=20
2.24.1

