Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A7DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063F320732
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXMckBVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIIHiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:37:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA1C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:37:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s2so918174pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iy/APQd+Om2zvfiNSuBSqVLHET3wSuMQMAbhPYL7p8g=;
        b=RXMckBVOzfWh5lB0NGjYDRdVwoFWX6RIu3D4DLvpoZYEsN2bn7czl8s92gvRXRuvC1
         jkKloomDCmnelqvDVvGV+DDqOaLVv1Ly/uBqYJvYsQY/xzk7+KG7Utpo5zmK7Hirybcp
         w/YLYhv45WVnQ+CS5HsuPUJB1XkxczMgYCUW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iy/APQd+Om2zvfiNSuBSqVLHET3wSuMQMAbhPYL7p8g=;
        b=eQxAGisyu2u79VF4fCKetdJaaiJTLnblei9rui/g4RseCKYeNr+i4UV5OiW+20mUDq
         rv2fzJOfUvm16/lfqPrgg8wqwYN0yLO2cG/NEhXkJIQtI6LH+WMXhzjh5ERpqqT785fv
         74JSb3UDtaVAYrxaNOB/EV4qiQkRpwoVnT9dwSLoZUWHFTdMMkdsdU0+C6X/91EPWcGP
         Kz2J02qgm9fCea6CW//QRViIP5FLrf91dPBz08qRMQ8MrF3cSVsN+TAfSEEFTuADoHCd
         j9G5WGJP2skP2cleggnGiPZBSYzti2SGaMigscYGgnYCLfa5YaArS0obxkYkRLj4AbPb
         bdTg==
X-Gm-Message-State: AOAM533Z6UWm/gZgeXf96SWiTlTzL8iNmP087bbqKkAn0KE+xMnu6A9k
        IA8RYtUisHXOuskHp9RXYUyIBrqymcXT6A==
X-Google-Smtp-Source: ABdhPJymus8agbUoPSDDSSddmS+9FIwgQYcgK1fT6qDpKUASDuNarYsPQQLpgt3Qgn+nsXWqsxaInQ==
X-Received: by 2002:a17:90b:1107:: with SMTP id gi7mr2342742pjb.233.1599637075433;
        Wed, 09 Sep 2020 00:37:55 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id h65sm1693068pfb.210.2020.09.09.00.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 00:37:54 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Imre Deak <imre.deak@intel.com>, Sam McNally <sammc@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/dp_mst: Add ddc i2c device links for DP MST connectors
Date:   Wed,  9 Sep 2020 17:37:38 +1000
Message-Id: <20200909173712.v2.1.Iaa9c3d7c4332cf8717653f3d3ae6f2b955aa3fc6@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP MST DDC I2C devices are not parented to their connectors. This makes
it challenging to associate the ddc i2c device with its connector from
userspace. With further refactoring, this can be changed, but in the
meantime, follow the pattern of commit e1a29c6c5955 ("drm: Add ddc link
in sysfs created by drm_connector"), creating sysfs ddc links to the
associated i2c device for MST DP connectors.

If the connector is created and registered before the i2c device, create
the link when registering the i2c device; otherwise, create the link
after registering the connector.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

Changes in v2:
- Reworded description to avoid accusing an innocent commit of
  responsibility for the problem being addressed

 drivers/gpu/drm/drm_dp_mst_topology.c | 29 +++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 17dbed0a9800..e60a6b8af3c1 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2159,11 +2159,23 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
 int drm_dp_mst_connector_late_register(struct drm_connector *connector,
 				       struct drm_dp_mst_port *port)
 {
+	int ret;
 	DRM_DEBUG_KMS("registering %s remote bus for %s\n",
 		      port->aux.name, connector->kdev->kobj.name);
 
 	port->aux.dev = connector->kdev;
-	return drm_dp_aux_register_devnode(&port->aux);
+	ret = drm_dp_aux_register_devnode(&port->aux);
+	if (ret)
+		return ret;
+
+	if (port->pdt != DP_PEER_DEVICE_NONE &&
+	    drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
+		ret = sysfs_create_link(&port->connector->kdev->kobj,
+					&port->aux.ddc.dev.kobj, "ddc");
+		if (ret)
+			drm_dp_aux_unregister_devnode(&port->aux);
+	}
+	return ret;
 }
 EXPORT_SYMBOL(drm_dp_mst_connector_late_register);
 
@@ -5439,6 +5451,7 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_aux *aux = &port->aux;
 	struct device *parent_dev = port->mgr->dev->dev;
+	int ret;
 
 	aux->ddc.algo = &drm_dp_mst_i2c_algo;
 	aux->ddc.algo_data = aux;
@@ -5453,7 +5466,17 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
 	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(parent_dev),
 		sizeof(aux->ddc.name));
 
-	return i2c_add_adapter(&aux->ddc);
+	ret = i2c_add_adapter(&aux->ddc);
+	if (ret)
+		return ret;
+
+	if (port->connector && port->connector->kdev) {
+		ret = sysfs_create_link(&port->connector->kdev->kobj,
+					&port->aux.ddc.dev.kobj, "ddc");
+		if (ret)
+			i2c_del_adapter(&port->aux.ddc);
+	}
+	return ret;
 }
 
 /**
@@ -5462,6 +5485,8 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
  */
 static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_mst_port *port)
 {
+	if (port->connector && port->connector->kdev)
+		sysfs_remove_link(&port->connector->kdev->kobj, "ddc");
 	i2c_del_adapter(&port->aux.ddc);
 }
 
-- 
2.28.0.526.ge36021eeef-goog

