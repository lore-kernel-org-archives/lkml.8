Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FAEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2902520737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlgQ+qq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHZS0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:26:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37685 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgHZSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrQypXsB06I27AWFzq+unFDPT9ULdnzgHHger98409Y=;
        b=IlgQ+qq4Yo5/zGgPJDV88z5bXgxc3b2/+Ai3knU5XqpTh6EQG1KzqfuWDFMB8la7vWRk1c
        VbPoGs3TGgagHBP9N2A1FfXtcocEqc5EFjo3/xaga/gXgF4C//sCk74z8O5maBnMCY36T2
        hPgcKw3FV9IVIyqw3m8SE/FKd01ng/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-EnDZQoIPNm2QBWzx8RTYXg-1; Wed, 26 Aug 2020 14:25:55 -0400
X-MC-Unique: EnDZQoIPNm2QBWzx8RTYXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC8AB1DDFC;
        Wed, 26 Aug 2020 18:25:53 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E07D1002382;
        Wed, 26 Aug 2020 18:25:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 14/20] drm/nouveau/kms/nv50-: Use downstream DP clock limits for mode validation
Date:   Wed, 26 Aug 2020 14:24:50 -0400
Message-Id: <20200826182456.322681-15-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for querying the maximum clock rate of a downstream
port on a DisplayPort connection. Generally, downstream ports refer to
active dongles which can have their own pixel clock limits.

Note as well, we also start marking the connector as disconnected if we
can't read the DPCD, since we wouldn't be able to do anything without
DPCD access anyway.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c   |  3 +++
 drivers/gpu/drm/nouveau/nouveau_dp.c      | 15 +++++++++++----
 drivers/gpu/drm/nouveau/nouveau_encoder.h |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 8e1effb10425d..d2141ca16107b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1258,7 +1258,10 @@ nv50_mstc_detect(struct drm_connector *connector,
 
 	ret = drm_dp_mst_detect_port(connector, ctx, mstc->port->mgr,
 				     mstc->port);
+	if (ret != connector_status_connected)
+		goto out;
 
+out:
 	pm_runtime_mark_last_busy(connector->dev->dev);
 	pm_runtime_put_autosuspend(connector->dev->dev);
 	return ret;
diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 005750aeb6d4f..ad852e572cfec 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -61,6 +61,11 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
 			mstm->can_mst = drm_dp_read_mst_cap(aux, dpcd);
 	}
 
+	ret = drm_dp_read_downstream_info(aux, dpcd,
+					  outp->dp.downstream_ports);
+	if (ret < 0)
+		return connector_status_disconnected;
+
 	return connector_status_connected;
 }
 
@@ -176,8 +181,6 @@ void nouveau_dp_irq(struct nouveau_drm *drm,
 /* TODO:
  * - Use the minimum possible BPC here, once we add support for the max bpc
  *   property.
- * - Validate the mode against downstream port caps (see
- *   drm_dp_downstream_max_clock())
  * - Validate against the DP caps advertised by the GPU (we don't check these
  *   yet)
  */
@@ -188,15 +191,19 @@ nv50_dp_mode_valid(struct drm_connector *connector,
 		   unsigned *out_clock)
 {
 	const unsigned min_clock = 25000;
-	unsigned max_clock, clock;
+	unsigned max_clock, ds_clock, clock;
 	enum drm_mode_status ret;
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
 		return MODE_NO_INTERLACE;
 
 	max_clock = outp->dp.link_nr * outp->dp.link_bw;
-	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
+	ds_clock = drm_dp_downstream_max_clock(outp->dp.dpcd,
+					       outp->dp.downstream_ports);
+	if (ds_clock)
+		max_clock = min(max_clock, ds_clock);
 
+	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
 	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
 					    &clock);
 	if (out_clock)
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index eef4643f5f982..c1924a4529a7b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -72,6 +72,7 @@ struct nouveau_encoder {
 			struct mutex hpd_irq_lock;
 
 			u8 dpcd[DP_RECEIVER_CAP_SIZE];
+			u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
 			struct drm_dp_desc desc;
 		} dp;
 	};
-- 
2.26.2

