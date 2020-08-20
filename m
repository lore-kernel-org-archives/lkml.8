Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA611C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9935F206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfNlmHAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHTScC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:32:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727898AbgHTSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597948280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaqW4Gmy6cVcouD31SK1bgkpRdbI1OQBzcDJEb3YKEs=;
        b=OfNlmHAmIVmekahJcMXi52rp4SrU9rfWDomCxUtNacG4sSDVX7gE3s32z0/7qN8BjT3FTD
        Newf6QizZDaC25dTVFKH0IxdQlw49OIGBHnXZE58iVsrF3rkZq1e2drfpjPzjXCSfet7I+
        I8erEkeVbwFdHXsFE92x3FSgXiMEK08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ayu5Fs_AMzyiAirPlpxrKQ-1; Thu, 20 Aug 2020 14:31:18 -0400
X-MC-Unique: ayu5Fs_AMzyiAirPlpxrKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F001DE08;
        Thu, 20 Aug 2020 18:31:17 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-42.rdu2.redhat.com [10.10.120.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A34E5DA74;
        Thu, 20 Aug 2020 18:31:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 18/20] drm/nouveau/kms: Don't change EDID when it hasn't actually changed
Date:   Thu, 20 Aug 2020 14:30:10 -0400
Message-Id: <20200820183012.288794-19-lyude@redhat.com>
In-Reply-To: <20200820183012.288794-1-lyude@redhat.com>
References: <20200820183012.288794-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in nouveau_connector_ddc_detect() and
nouveau_connector_detect_lvds(), we start the connector probing process
by releasing the previous EDID and informing DRM of the change. However,
since commit 5186421cbfe2 ("drm: Introduce epoch counter to
drm_connector") drm_connector_update_edid_property() actually checks
whether the new EDID we've specified is different from the previous one,
and updates the connector's epoch accordingly if it is. But, because we
always set the EDID to NULL first in nouveau_connector_ddc_detect() and
nouveau_connector_detect_lvds() we end up making DRM think that the EDID
changes every single time we do a connector probe - which isn't needed.

So, let's fix this by not clearing the EDID at the start of the
connector probing process, and instead simply changing or removing it
once near the end of the probing process. This will help prevent us from
sending unneeded hotplug events to userspace when nothing has actually
changed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 54 ++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 637e91594fbe8..49dd0cbc332ff 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -528,6 +528,17 @@ nouveau_connector_set_encoder(struct drm_connector *connector,
 	}
 }
 
+static void
+nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
+			   struct edid *edid)
+{
+	struct edid *old_edid = nv_connector->edid;
+
+	drm_connector_update_edid_property(&nv_connector->base, edid);
+	kfree(old_edid);
+	nv_connector->edid = edid;
+}
+
 static enum drm_connector_status
 nouveau_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -541,13 +552,6 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 	int ret;
 	enum drm_connector_status conn_status = connector_status_disconnected;
 
-	/* Cleanup the previous EDID block. */
-	if (nv_connector->edid) {
-		drm_connector_update_edid_property(connector, NULL);
-		kfree(nv_connector->edid);
-		nv_connector->edid = NULL;
-	}
-
 	/* Outputs are only polled while runtime active, so resuming the
 	 * device here is unnecessary (and would deadlock upon runtime suspend
 	 * because it waits for polling to finish). We do however, want to
@@ -560,22 +564,23 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		ret = pm_runtime_get_sync(dev->dev);
 		if (ret < 0 && ret != -EACCES) {
 			pm_runtime_put_autosuspend(dev->dev);
+			nouveau_connector_set_edid(nv_connector, NULL);
 			return conn_status;
 		}
 	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
 	if (nv_encoder && (i2c = nv_encoder->i2c) != NULL) {
+		struct edid *new_edid;
+
 		if ((vga_switcheroo_handler_flags() &
 		     VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
 		    nv_connector->type == DCB_CONNECTOR_LVDS)
-			nv_connector->edid = drm_get_edid_switcheroo(connector,
-								     i2c);
+			new_edid = drm_get_edid_switcheroo(connector, i2c);
 		else
-			nv_connector->edid = drm_get_edid(connector, i2c);
+			new_edid = drm_get_edid(connector, i2c);
 
-		drm_connector_update_edid_property(connector,
-							nv_connector->edid);
+		nouveau_connector_set_edid(nv_connector, new_edid);
 		if (!nv_connector->edid) {
 			NV_ERROR(drm, "DDC responded, but no EDID for %s\n",
 				 connector->name);
@@ -609,6 +614,8 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		conn_status = connector_status_connected;
 		drm_dp_cec_set_edid(&nv_connector->aux, nv_connector->edid);
 		goto out;
+	} else {
+		nouveau_connector_set_edid(nv_connector, NULL);
 	}
 
 	nv_encoder = nouveau_connector_of_detect(connector);
@@ -652,18 +659,12 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder = NULL;
+	struct edid *edid = NULL;
 	enum drm_connector_status status = connector_status_disconnected;
 
-	/* Cleanup the previous EDID block. */
-	if (nv_connector->edid) {
-		drm_connector_update_edid_property(connector, NULL);
-		kfree(nv_connector->edid);
-		nv_connector->edid = NULL;
-	}
-
 	nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
 	if (!nv_encoder)
-		return connector_status_disconnected;
+		goto out;
 
 	/* Try retrieving EDID via DDC */
 	if (!drm->vbios.fp_no_ddc) {
@@ -682,7 +683,8 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * valid - it's not (rh#613284)
 	 */
 	if (nv_encoder->dcb->lvdsconf.use_acpi_for_edid) {
-		if ((nv_connector->edid = nouveau_acpi_edid(dev, connector))) {
+		edid = nouveau_acpi_edid(dev, connector);
+		if (edid) {
 			status = connector_status_connected;
 			goto out;
 		}
@@ -702,12 +704,10 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * stored for the panel stored in them.
 	 */
 	if (!drm->vbios.fp_no_ddc) {
-		struct edid *edid =
-			(struct edid *)nouveau_bios_embedded_edid(dev);
+		edid = (struct edid *)nouveau_bios_embedded_edid(dev);
 		if (edid) {
-			nv_connector->edid =
-					kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
-			if (nv_connector->edid)
+			edid = kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+			if (edid)
 				status = connector_status_connected;
 		}
 	}
@@ -720,7 +720,7 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 		status = connector_status_unknown;
 #endif
 
-	drm_connector_update_edid_property(connector, nv_connector->edid);
+	nouveau_connector_set_edid(nv_connector, edid);
 	nouveau_connector_set_encoder(connector, nv_encoder);
 	return status;
 }
-- 
2.26.2

