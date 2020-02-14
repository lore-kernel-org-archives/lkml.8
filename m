Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE8AC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0946D20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSLG/wQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBNW7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:59:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726164AbgBNW7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581721183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pGuMWChJi6Xa7DEXY53QXCC5ld+3Dx8o2IOvHbPSiY=;
        b=bSLG/wQz7TkuObhqGSnAvdF6cIB82dVqbr1Aq+CRA4rRliK1wOwUMesPrj9ufHl9TXot0G
        0wTIsJkstPW8uMb21zhmApxmDj5gywZpdkd6G/95RiajDAPXUYMlz2+4dFt01CoxeupJ79
        gsQHMM15YrTEMgtmkInM40BhX+SePVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Fa_9wl4dM6OJSPBD2JeHOw-1; Fri, 14 Feb 2020 17:59:41 -0500
X-MC-Unique: Fa_9wl4dM6OJSPBD2JeHOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD38C13E4;
        Fri, 14 Feb 2020 22:59:39 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6F0860499;
        Fri, 14 Feb 2020 22:59:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] drm/nouveau/kms/nv50-: Share DP SST mode_valid() handling with MST
Date:   Fri, 14 Feb 2020 17:58:56 -0500
Message-Id: <20200214225910.695210-6-lyude@redhat.com>
In-Reply-To: <20200214225910.695210-1-lyude@redhat.com>
References: <20200214225910.695210-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the nv50_mstc_mode_valid() function is happy to take any and
all modes, even the ones we can't actually support sometimes like
interlaced modes.

Luckily, the only difference between the mode validation that needs to
be performed for MST vs. SST is that eventually we'll need to check the
minimum PBN against the MSTB's full PBN capabilities (remember-we don't
care about the current bw state here). Otherwise, all of the other code
can be shared.

So, we move all of the common mode validation in
nouveau_connector_mode_valid() into a separate helper,
nv50_dp_mode_valid(), and use that from both nv50_mstc_mode_valid() and
nouveau_connector_mode_valid(). Note that we allow for returning the
calculated clock that nv50_dp_mode_valid() came up with, since we'll
eventually want to use that for PBN calculation in
nv50_mstc_mode_valid().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  9 ++++-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 41 +++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  5 +++
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 31 ++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |  4 ++
 5 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
index 020058811831..684e2c081ea2 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1051,7 +1051,14 @@ static enum drm_mode_status
 nv50_mstc_mode_valid(struct drm_connector *connector,
 		     struct drm_display_mode *mode)
 {
-	return MODE_OK;
+	struct nv50_mstc *mstc =3D nv50_mstc(connector);
+	struct nouveau_encoder *outp =3D mstc->mstm->outp;
+
+	/* TODO: calculate the PBN from the dotclock and validate against the
+	 * MSTB's max possible PBN
+	 */
+
+	return nv50_dp_mode_valid(connector, outp, mode, NULL);
 }
=20
 static int
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
index 6dae00da5d7e..a82a51661ca1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -38,6 +38,7 @@
 #include "nouveau_reg.h"
 #include "nouveau_drv.h"
 #include "dispnv04/hw.h"
+#include "dispnv50/disp.h"
 #include "nouveau_acpi.h"
=20
 #include "nouveau_display.h"
@@ -1033,6 +1034,24 @@ get_tmds_link_bandwidth(struct drm_connector *conn=
ector)
 		return 112000 * duallink_scale;
 }
=20
+enum drm_mode_status
+nouveau_conn_mode_clock_valid(const struct drm_display_mode *mode,
+			      const unsigned min_clock,
+			      const unsigned max_clock,
+			      unsigned *clock)
+{
+	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) =3D=3D
+	    DRM_MODE_FLAG_3D_FRAME_PACKING)
+		*clock *=3D 2;
+
+	if (*clock < min_clock)
+		return MODE_CLOCK_LOW;
+	if (*clock > max_clock)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static enum drm_mode_status
 nouveau_connector_mode_valid(struct drm_connector *connector,
 			     struct drm_display_mode *mode)
@@ -1041,7 +1060,6 @@ nouveau_connector_mode_valid(struct drm_connector *=
connector,
 	struct nouveau_encoder *nv_encoder =3D nv_connector->detected_encoder;
 	struct drm_encoder *encoder =3D to_drm_encoder(nv_encoder);
 	unsigned min_clock =3D 25000, max_clock =3D min_clock;
-	unsigned clock =3D mode->clock;
=20
 	switch (nv_encoder->dcb->type) {
 	case DCB_OUTPUT_LVDS:
@@ -1064,29 +1082,14 @@ nouveau_connector_mode_valid(struct drm_connector=
 *connector,
 	case DCB_OUTPUT_TV:
 		return get_slave_funcs(encoder)->mode_valid(encoder, mode);
 	case DCB_OUTPUT_DP:
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
-		    !nv_encoder->caps.dp_interlace)
-			return MODE_NO_INTERLACE;
-
-		max_clock  =3D nv_encoder->dp.link_nr;
-		max_clock *=3D nv_encoder->dp.link_bw;
-		clock =3D clock * (connector->display_info.bpc * 3) / 10;
-		break;
+		return nv50_dp_mode_valid(connector, nv_encoder, mode, NULL);
 	default:
 		BUG();
 		return MODE_BAD;
 	}
=20
-	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) =3D=3D DRM_MODE_FLAG_3D_FRAME=
_PACKING)
-		clock *=3D 2;
-
-	if (clock < min_clock)
-		return MODE_CLOCK_LOW;
-
-	if (clock > max_clock)
-		return MODE_CLOCK_HIGH;
-
-	return MODE_OK;
+	return nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
+					     NULL);
 }
=20
 static struct drm_encoder *
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/dr=
m/nouveau/nouveau_connector.h
index de84fb4708c7..9e062c7adec8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -195,6 +195,11 @@ int nouveau_conn_atomic_get_property(struct drm_conn=
ector *,
 				     const struct drm_connector_state *,
 				     struct drm_property *, u64 *);
 struct drm_display_mode *nouveau_conn_native_mode(struct drm_connector *=
);
+enum drm_mode_status
+nouveau_conn_mode_clock_valid(const struct drm_display_mode *,
+			      const unsigned min_clock,
+			      const unsigned max_clock,
+			      unsigned *clock);
=20
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 extern int nouveau_backlight_init(struct drm_connector *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouve=
au/nouveau_dp.c
index 2674f1587457..8a0f7994e1ae 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -98,3 +98,34 @@ nouveau_dp_detect(struct nouveau_encoder *nv_encoder)
 		return NOUVEAU_DP_SST;
 	return ret;
 }
+
+/* TODO:
+ * - Use the minimum possible BPC here, once we add support for the max =
bpc
+ *   property.
+ * - Validate the mode against downstream port caps (see
+ *   drm_dp_downstream_max_clock())
+ * - Validate against the DP caps advertised by the GPU (we don't check =
these
+ *   yet)
+ */
+enum drm_mode_status
+nv50_dp_mode_valid(struct drm_connector *connector,
+		   struct nouveau_encoder *outp,
+		   const struct drm_display_mode *mode,
+		   unsigned *out_clock)
+{
+	const unsigned min_clock =3D 25000;
+	unsigned max_clock, clock;
+	enum drm_mode_status ret;
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
+		return MODE_NO_INTERLACE;
+
+	max_clock =3D outp->dp.link_nr * outp->dp.link_bw;
+	clock =3D mode->clock * (connector->display_info.bpc * 3) / 10;
+
+	ret =3D nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
+					    &clock);
+	if (out_clock)
+		*out_clock =3D clock;
+	return ret;
+}
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/=
nouveau/nouveau_encoder.h
index 3217f587eceb..de51733b0476 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -104,6 +104,10 @@ enum nouveau_dp_status {
 };
=20
 int nouveau_dp_detect(struct nouveau_encoder *);
+enum drm_mode_status nv50_dp_mode_valid(struct drm_connector *,
+					struct nouveau_encoder *,
+					const struct drm_display_mode *,
+					unsigned *clock);
=20
 struct nouveau_connector *
 nouveau_encoder_connector_get(struct nouveau_encoder *encoder);
--=20
2.24.1

