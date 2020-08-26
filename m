Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF20C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FA12078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUH5XXUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZOGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHZOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:06:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655AC061386
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:00:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so2498371ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qVfPLSfnWnXJeT5c1RJB7YyrqFBfvnlWvS99GyBiiO0=;
        b=WUH5XXUD4DhJkcZTRzZWzsSQ9iRu2X6W3NSaomGIoBQQJrYsKZ5l0wpwG1C5atHkFv
         VzsbFQJER7wWAqdQMaMnCwJIYh70tkyIpnmFpv7uc/paBrhmrZ9dyoERbKB9uQ9J1hjV
         sOoUbsEOaYC0Brq5/AZLjulJFXE7oWPYjewZam+mypLjL/o2cqU8hmKTRKep4bg8g3A3
         2gqT5J6eomAVU5UYBLKJ+nsL4VGk7+2s8kA1N2lCD2CLMD/DnvLSQERatAwKXlGy9bP3
         yoqHqWgPLMZ8bp5jGkQggZf17IF8FdK4mipv1RNnE++F60vauCcn1AhKJSaw4Ni8Pk3f
         HzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qVfPLSfnWnXJeT5c1RJB7YyrqFBfvnlWvS99GyBiiO0=;
        b=lUAso9Z5eYEgnXtAqKN985jqMSHRF87Rwhr9TwaaoMYZy1uIhMKS867kJ8rbOINjGf
         X2PpMr0oLdsvXANJ4MvIzBq1GMJNvBpcNgKgpyJURRAoHe5iJFJ5zBbaEx2/3W/63RGQ
         gW5Ngciyt7fkRbKSP36wmOF6wV9O4uEzBd4ox6aEPMy3BIUjtFho7q4Up24Ck29PjNnu
         e76AP3/P1nIKHwcpjzLQHO4YkrMWCHg6RjKBHhuUyP447GonhVkDuOwNah8D/OAQhWE8
         wIJaiczgcYpKIRaqeBt/Y/ytip8qaMXkYTCgEB5qpq0xcV6TNbiXAjvqB76Cr9nIGSGz
         NkOA==
X-Gm-Message-State: AOAM532NFhYfhLgsjV1PlPBAiIhrXu8VdBOiTvAnNx7MQDMdZGKTCP18
        MomcZHUUVmGqd7digrkofZ12BIXA4AYHtA==
X-Google-Smtp-Source: ABdhPJwM5AzljUPniiThBGHQK+WTRn7mNG7prfdccV0Yfs0bBoYSebnP3a00SB66u3EnzRRtjEp6IQ==
X-Received: by 2002:a2e:851a:: with SMTP id j26mr6775056lji.251.1598450429491;
        Wed, 26 Aug 2020 07:00:29 -0700 (PDT)
Received: from a2klaptop.epam.com ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id z25sm532604ljz.13.2020.08.26.07.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:00:28 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] drm/xen-front: Add support for EDID based configuration
Date:   Wed, 26 Aug 2020 17:00:27 +0300
Message-Id: <20200826140027.11728-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Version 2 of the Xen displif protocol adds XENDISPL_OP_GET_EDID
request which allows frontends to request EDID structure per
connector. This request is optional and if not supported by the
backend then visible area is still defined by the relevant
XenStore's "resolution" property.
If backend provides EDID with XENDISPL_OP_GET_EDID request then
its values must take precedence over the resolutions defined in
XenStore.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front.c         | 62 ++++++++++++++++
 drivers/gpu/drm/xen/xen_drm_front.h         |  9 ++-
 drivers/gpu/drm/xen/xen_drm_front_cfg.c     | 82 +++++++++++++++++++++
 drivers/gpu/drm/xen/xen_drm_front_cfg.h     |  7 ++
 drivers/gpu/drm/xen/xen_drm_front_conn.c    | 26 ++++++-
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c |  4 +
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h |  3 +
 drivers/gpu/drm/xen/xen_drm_front_kms.c     |  5 ++
 8 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 013c9e0e412c..cc5981bdbfb3 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -381,6 +381,59 @@ void xen_drm_front_on_frame_done(struct xen_drm_front_info *front_info,
 					fb_cookie);
 }
 
+int xen_drm_front_get_edid(struct xen_drm_front_info *front_info,
+			   int conn_idx, struct page **pages,
+			   u32 buffer_sz, u32 *edid_sz)
+{
+	struct xen_drm_front_evtchnl *evtchnl;
+	struct xen_front_pgdir_shbuf_cfg buf_cfg;
+	struct xen_front_pgdir_shbuf shbuf;
+	struct xendispl_req *req;
+	unsigned long flags;
+	int ret;
+
+	if (unlikely(conn_idx >= front_info->num_evt_pairs))
+		return -EINVAL;
+
+	memset(&buf_cfg, 0, sizeof(buf_cfg));
+	buf_cfg.xb_dev = front_info->xb_dev;
+	buf_cfg.num_pages = DIV_ROUND_UP(buffer_sz, PAGE_SIZE);
+	buf_cfg.pages = pages;
+	buf_cfg.pgdir = &shbuf;
+	buf_cfg.be_alloc = false;
+
+	ret = xen_front_pgdir_shbuf_alloc(&buf_cfg);
+	if (ret < 0)
+		return ret;
+
+	evtchnl = &front_info->evt_pairs[conn_idx].req;
+
+	mutex_lock(&evtchnl->u.req.req_io_lock);
+
+	spin_lock_irqsave(&front_info->io_lock, flags);
+	req = be_prepare_req(evtchnl, XENDISPL_OP_GET_EDID);
+	req->op.get_edid.gref_directory =
+		xen_front_pgdir_shbuf_get_dir_start(&shbuf);
+	req->op.get_edid.buffer_sz = buffer_sz;
+
+	ret = be_stream_do_io(evtchnl, req);
+	spin_unlock_irqrestore(&front_info->io_lock, flags);
+
+	if (ret < 0)
+		goto fail;
+
+	ret = be_stream_wait_io(evtchnl);
+	if (ret < 0)
+		goto fail;
+
+	*edid_sz = evtchnl->u.req.resp.get_edid.edid_sz;
+
+fail:
+	mutex_unlock(&evtchnl->u.req.req_io_lock);
+	xen_front_pgdir_shbuf_free(&shbuf);
+	return ret;
+}
+
 static int xen_drm_drv_dumb_create(struct drm_file *filp,
 				   struct drm_device *dev,
 				   struct drm_mode_create_dumb *args)
@@ -466,6 +519,7 @@ static void xen_drm_drv_release(struct drm_device *dev)
 		xenbus_switch_state(front_info->xb_dev,
 				    XenbusStateInitialising);
 
+	xen_drm_front_cfg_free(front_info, &front_info->cfg);
 	kfree(drm_info);
 }
 
@@ -562,6 +616,7 @@ static int xen_drm_drv_init(struct xen_drm_front_info *front_info)
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev_put(drm_dev);
 fail:
+	xen_drm_front_cfg_free(front_info, &front_info->cfg);
 	kfree(drm_info);
 	return ret;
 }
@@ -622,7 +677,14 @@ static int displback_initwait(struct xen_drm_front_info *front_info)
 
 static int displback_connect(struct xen_drm_front_info *front_info)
 {
+	int ret;
+
 	xen_drm_front_evtchnl_set_state(front_info, EVTCHNL_STATE_CONNECTED);
+
+	/* We are all set to read additional configuration from the backend. */
+	ret = xen_drm_front_cfg_tail(front_info, &front_info->cfg);
+	if (ret < 0)
+		return ret;
 	return xen_drm_drv_init(front_info);
 }
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
index 54486d89650e..be0c982f4d82 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.h
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -112,9 +112,12 @@ struct xen_drm_front_drm_pipeline {
 	struct drm_simple_display_pipe pipe;
 
 	struct drm_connector conn;
-	/* These are only for connector mode checking */
+	/* These are only for connector mode checking if no EDID present */
 	int width, height;
 
+	/* Is not NULL if EDID is used for connector configuration. */
+	struct edid *edid;
+
 	struct drm_pending_vblank_event *pending_event;
 
 	struct delayed_work pflip_to_worker;
@@ -160,4 +163,8 @@ int xen_drm_front_page_flip(struct xen_drm_front_info *front_info,
 void xen_drm_front_on_frame_done(struct xen_drm_front_info *front_info,
 				 int conn_idx, u64 fb_cookie);
 
+int xen_drm_front_get_edid(struct xen_drm_front_info *front_info,
+			   int conn_idx, struct page **pages,
+			   u32 buffer_sz, u32 *edid_sz);
+
 #endif /* __XEN_DRM_FRONT_H_ */
diff --git a/drivers/gpu/drm/xen/xen_drm_front_cfg.c b/drivers/gpu/drm/xen/xen_drm_front_cfg.c
index ec53b9cc9e0e..f7c45a2fdab3 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_cfg.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_cfg.c
@@ -45,6 +45,64 @@ static int cfg_connector(struct xen_drm_front_info *front_info,
 	return 0;
 }
 
+static void
+cfg_connector_free_edid(struct xen_drm_front_cfg_connector *connector)
+{
+	vfree(connector->edid);
+	connector->edid = NULL;
+}
+
+static void cfg_connector_edid(struct xen_drm_front_info *front_info,
+			       struct xen_drm_front_cfg_connector *connector,
+			       int index)
+{
+	struct page **pages;
+	u32 edid_sz;
+	int i, npages, ret = -ENOMEM;
+
+	connector->edid = vmalloc(XENDISPL_EDID_MAX_SIZE);
+	if (!connector->edid)
+		goto fail;
+
+	npages = DIV_ROUND_UP(XENDISPL_EDID_MAX_SIZE, PAGE_SIZE);
+	pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		goto fail_free_edid;
+
+	for (i = 0; i < npages; i++)
+		pages[i] = vmalloc_to_page((u8 *)connector->edid +
+					   i * PAGE_SIZE);
+
+	ret = xen_drm_front_get_edid(front_info, index, pages,
+				     XENDISPL_EDID_MAX_SIZE, &edid_sz);
+
+	kvfree(pages);
+
+	if (ret < 0)
+		goto fail_free_edid;
+
+	ret = -EINVAL;
+	if (!edid_sz || (edid_sz % EDID_LENGTH))
+		goto fail_free_edid;
+
+	if (!drm_edid_is_valid(connector->edid))
+		goto fail_free_edid;
+
+	DRM_INFO("Connector %s: using EDID for configuration, size %d\n",
+		 connector->xenstore_path, edid_sz);
+	return;
+
+fail_free_edid:
+	cfg_connector_free_edid(connector);
+fail:
+	/*
+	 * If any error this is not critical as we can still read
+	 * connector settings from XenStore, so just warn.
+	 */
+	DRM_WARN("Connector %s: cannot read or wrong EDID: %d\n",
+		 connector->xenstore_path, ret);
+}
+
 int xen_drm_front_cfg_card(struct xen_drm_front_info *front_info,
 			   struct xen_drm_front_cfg *cfg)
 {
@@ -75,3 +133,27 @@ int xen_drm_front_cfg_card(struct xen_drm_front_info *front_info,
 	return 0;
 }
 
+int xen_drm_front_cfg_tail(struct xen_drm_front_info *front_info,
+			   struct xen_drm_front_cfg *cfg)
+{
+	int i;
+
+	/*
+	 * Try reading EDID(s) from the backend: it is not an error
+	 * if backend doesn't support or provides no EDID.
+	 */
+	for (i = 0; i < cfg->num_connectors; i++)
+		cfg_connector_edid(front_info, &cfg->connectors[i], i);
+
+	return 0;
+}
+
+void xen_drm_front_cfg_free(struct xen_drm_front_info *front_info,
+			    struct xen_drm_front_cfg *cfg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cfg->connectors); i++)
+		cfg_connector_free_edid(&cfg->connectors[i]);
+}
+
diff --git a/drivers/gpu/drm/xen/xen_drm_front_cfg.h b/drivers/gpu/drm/xen/xen_drm_front_cfg.h
index aa8490ba9146..57662506eee6 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_cfg.h
+++ b/drivers/gpu/drm/xen/xen_drm_front_cfg.h
@@ -19,6 +19,7 @@ struct xen_drm_front_cfg_connector {
 	int width;
 	int height;
 	char *xenstore_path;
+	struct edid *edid;
 };
 
 struct xen_drm_front_cfg {
@@ -34,4 +35,10 @@ struct xen_drm_front_cfg {
 int xen_drm_front_cfg_card(struct xen_drm_front_info *front_info,
 			   struct xen_drm_front_cfg *cfg);
 
+int xen_drm_front_cfg_tail(struct xen_drm_front_info *front_info,
+			   struct xen_drm_front_cfg *cfg);
+
+void xen_drm_front_cfg_free(struct xen_drm_front_info *front_info,
+			    struct xen_drm_front_cfg *cfg);
+
 #endif /* __XEN_DRM_FRONT_CFG_H_ */
diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index 44f1f70c0aed..c98d989a005f 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -66,6 +66,16 @@ static int connector_get_modes(struct drm_connector *connector)
 	struct videomode videomode;
 	int width, height;
 
+	if (pipeline->edid) {
+		int count;
+
+		drm_connector_update_edid_property(connector,
+						   pipeline->edid);
+		count = drm_add_edid_modes(connector, pipeline->edid);
+		if (count)
+			return count;
+	}
+
 	mode = drm_mode_create(connector->dev);
 	if (!mode)
 		return 0;
@@ -103,6 +113,7 @@ int xen_drm_front_conn_init(struct xen_drm_front_drm_info *drm_info,
 {
 	struct xen_drm_front_drm_pipeline *pipeline =
 			to_xen_drm_pipeline(connector);
+	int ret;
 
 	drm_connector_helper_add(connector, &connector_helper_funcs);
 
@@ -111,6 +122,17 @@ int xen_drm_front_conn_init(struct xen_drm_front_drm_info *drm_info,
 	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
 			DRM_CONNECTOR_POLL_DISCONNECT;
 
-	return drm_connector_init(drm_info->drm_dev, connector,
-				  &connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
+	ret = drm_connector_init(drm_info->drm_dev, connector,
+				 &connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Virtual connectors do not have EDID property, but we do,
+	 * so add it manually if EDID is present.
+	 */
+	if (pipeline->edid)
+		drm_connector_attach_edid_property(connector);
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
index e10d95dddb99..25e512445cb3 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
@@ -44,6 +44,10 @@ static irqreturn_t evtchnl_interrupt_ctrl(int irq, void *dev_id)
 			continue;
 
 		switch (resp->operation) {
+		case XENDISPL_OP_GET_EDID:
+			evtchnl->u.req.resp.get_edid =
+				resp->op.get_edid;
+			fallthrough;
 		case XENDISPL_OP_PG_FLIP:
 		case XENDISPL_OP_FB_ATTACH:
 		case XENDISPL_OP_FB_DETACH:
diff --git a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.h b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
index b0af6994332b..8267f40b6549 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
+++ b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
@@ -53,6 +53,9 @@ struct xen_drm_front_evtchnl {
 			struct completion completion;
 			/* latest response status */
 			int resp_status;
+			union {
+				struct xendispl_get_edid_resp get_edid;
+			} resp;
 			/* serializer for backend IO: request/response */
 			struct mutex req_io_lock;
 		} req;
diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index ef11b1e4de39..d7ff1a656d40 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -288,6 +288,10 @@ display_mode_valid(struct drm_simple_display_pipe *pipe,
 			container_of(pipe, struct xen_drm_front_drm_pipeline,
 				     pipe);
 
+	/* We have nothing to check if EDID is present. */
+	if (pipeline->edid)
+		return MODE_OK;
+
 	if (mode->hdisplay != pipeline->width)
 		return MODE_ERROR;
 
@@ -319,6 +323,7 @@ static int display_pipe_init(struct xen_drm_front_drm_info *drm_info,
 	pipeline->index = index;
 	pipeline->height = cfg->height;
 	pipeline->width = cfg->width;
+	pipeline->edid = cfg->edid;
 
 	INIT_DELAYED_WORK(&pipeline->pflip_to_worker, pflip_to_worker);
 
-- 
2.17.1

