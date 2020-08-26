Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08223C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D733320737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GryGWqjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHZSZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:25:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726790AbgHZSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfLxCMnsO7JIC/eaKaw8p9wTENERe+wpNdDpM58At2g=;
        b=GryGWqjDPvtWES1NnbmgvhitOVLMe+vUpxQlFq8AgeXr8UmWKCtAYNqGjWn2KDbqL3hlPk
        8L7c/ygJFFneifWIXDVeZk/XYI2/tOBwU1e458ZkkPVJlCLOvQxV0wOehca2SuB6vaYMUS
        UlyOBmauljfkpjbcgPMxI45dU5QDcAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-wMdAcWRpPBqsC8mWpc-6Vw-1; Wed, 26 Aug 2020 14:25:15 -0400
X-MC-Unique: wMdAcWRpPBqsC8mWpc-6Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BDF580EF9F;
        Wed, 26 Aug 2020 18:25:14 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95F3C1002382;
        Wed, 26 Aug 2020 18:25:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/20] drm/nouveau/kms/nv50-: Remove open-coded drm_dp_read_desc()
Date:   Wed, 26 Aug 2020 14:24:38 -0400
Message-Id: <20200826182456.322681-3-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while going through our DP code - we use an open-coded
version of drm_dp_read_desc() instead of just using the helper, so
change that. This will also let us use quirks in the future if we end up
needing them.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c |  3 ++-
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 30 +++++++--------------
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |  4 ++-
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 7674025a4bfe8..e12957e6faa7c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -435,7 +435,8 @@ nouveau_connector_ddc_detect(struct drm_connector *connector)
 
 		switch (nv_encoder->dcb->type) {
 		case DCB_OUTPUT_DP:
-			ret = nouveau_dp_detect(nv_encoder);
+			ret = nouveau_dp_detect(nouveau_connector(connector),
+						nv_encoder);
 			if (ret == NOUVEAU_DP_MST)
 				return NULL;
 			else if (ret == NOUVEAU_DP_SST)
diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index ee778ddc95fae..c4e9c21d4dd2b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -36,27 +36,9 @@ MODULE_PARM_DESC(mst, "Enable DisplayPort multi-stream (default: enabled)");
 static int nouveau_mst = 1;
 module_param_named(mst, nouveau_mst, int, 0400);
 
-static void
-nouveau_dp_probe_oui(struct drm_device *dev, struct nvkm_i2c_aux *aux, u8 *dpcd)
-{
-	struct nouveau_drm *drm = nouveau_drm(dev);
-	u8 buf[3];
-
-	if (!(dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_OUI_SUPPORT))
-		return;
-
-	if (!nvkm_rdaux(aux, DP_SINK_OUI, buf, 3))
-		NV_DEBUG(drm, "Sink OUI: %02hx%02hx%02hx\n",
-			     buf[0], buf[1], buf[2]);
-
-	if (!nvkm_rdaux(aux, DP_BRANCH_OUI, buf, 3))
-		NV_DEBUG(drm, "Branch OUI: %02hx%02hx%02hx\n",
-			     buf[0], buf[1], buf[2]);
-
-}
-
 int
-nouveau_dp_detect(struct nouveau_encoder *nv_encoder)
+nouveau_dp_detect(struct nouveau_connector *nv_connector,
+		  struct nouveau_encoder *nv_encoder)
 {
 	struct drm_device *dev = nv_encoder->base.base.dev;
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -89,7 +71,13 @@ nouveau_dp_detect(struct nouveau_encoder *nv_encoder)
 	NV_DEBUG(drm, "maximum: %dx%d\n",
 		 nv_encoder->dp.link_nr, nv_encoder->dp.link_bw);
 
-	nouveau_dp_probe_oui(dev, aux, dpcd);
+	ret = drm_dp_read_desc(&nv_connector->aux, &nv_encoder->dp.desc,
+			       drm_dp_is_branch(dpcd));
+	if (ret) {
+		NV_ERROR(drm, "Failed to read DP descriptor on %s: %d\n",
+			 nv_connector->base.name, ret);
+		return ret;
+	}
 
 	ret = nv50_mstm_detect(nv_encoder->dp.mstm, dpcd, nouveau_mst);
 	if (ret == 1)
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index a72c412ac8b14..6424cdcb4913f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -33,6 +33,7 @@
 #include <drm/drm_dp_mst_helper.h>
 #include "dispnv04/disp.h"
 struct nv50_head_atom;
+struct nouveau_connector;
 
 #define NV_DPMS_CLEARED 0x80
 
@@ -64,6 +65,7 @@ struct nouveau_encoder {
 			struct nv50_mstm *mstm;
 			int link_nr;
 			int link_bw;
+			struct drm_dp_desc desc;
 		} dp;
 	};
 
@@ -104,7 +106,7 @@ enum nouveau_dp_status {
 	NOUVEAU_DP_MST,
 };
 
-int nouveau_dp_detect(struct nouveau_encoder *);
+int nouveau_dp_detect(struct nouveau_connector *, struct nouveau_encoder *);
 enum drm_mode_status nv50_dp_mode_valid(struct drm_connector *,
 					struct nouveau_encoder *,
 					const struct drm_display_mode *,
-- 
2.26.2

