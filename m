Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0604C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDB8206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NgwSU+sE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgG2GPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2GPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:15:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:15:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so13692072pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFyM8Vx/5op87Dvz+AvxS1fPZAwbt9pRfprMIWb3YTU=;
        b=NgwSU+sEhHjJFh2Cw54BwrU1T27J2CiPVw2SEjfUpcNPBbzyJ0oj4QKISKIAaLyLvy
         r1mgqbbcHbgwXL3gCzG/ltDrdIBqhajO/Ci6Pyf3zLbh0SM4sXpI89B+XpffIFyi2Cvj
         tBZirVrQuvroukfy5muJly3TYrvUM+VvJmieo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFyM8Vx/5op87Dvz+AvxS1fPZAwbt9pRfprMIWb3YTU=;
        b=LJZXkAa8t1m11vu60v7krz0EwCQJrxoWr/kRPL2tmaDe/PRwO4hXuy55/KqJtbRMOr
         tW/9QeUJqPW2uXm5rFdoUU1v7H7/qag8KYMg21lGJw36EUl3Riv3d3bSt6wYqMbUARAE
         SD5huh6oDm09+O8nspNA5liTqLHaAZkiFRZmk03So5S5gYziqlQyHFkajs6i2A9aqpK9
         O51Cv5Zoo5jRIXI4M9h0bwZvynVE+9uLMzubgp31urbwtpsYnz6MWqY7LeTzkeddm0VN
         F7ZuB6qsxJqghL1cSqUkY88g3oJhWVm8YNwp1lxFx06/BGCevL3u6nYE/KH6NLv5CCfr
         4v7g==
X-Gm-Message-State: AOAM5306Us7g0Fsc8u3YXYpOwDEu7fUrwKNjaRcJWL4l3OshikcCrKA1
        LO9n92NA4ChD2O1T9YUk4lF2WMhkE2U=
X-Google-Smtp-Source: ABdhPJz9nsgNNiKNv6uOWtVlB7+pZve0qrQ8QpVeMxYdHqoOpag4NlpS+EpbD63x41HUalOzw8sZJA==
X-Received: by 2002:a63:c603:: with SMTP id w3mr27695619pgg.284.1596003352877;
        Tue, 28 Jul 2020 23:15:52 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id z25sm1003384pfg.150.2020.07.28.23.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 23:15:52 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Imre Deak <imre.deak@intel.com>, Sam McNally <sammc@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/dp_mst: Add ddc i2c device links for DP MST connectors
Date:   Wed, 29 Jul 2020 16:15:28 +1000
Message-Id: <20200729161510.1.Iaa9c3d7c4332cf8717653f3d3ae6f2b955aa3fc6@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit d8bd15b37d32 ("drm/dp_mst: Fix the DDC I2C device
registration of an MST port"), DP MST DDC I2C devices are consistently
parented to the underlying DRM device, making it challenging to
associate the ddc i2c device with its connector from userspace.

Given the need for further refactoring before the i2c devices can be
parented to their connectors, in the meantime follow the pattern of
commit e1a29c6c5955 ("drm: Add ddc link in sysfs created by
drm_connector"), creating sysfs ddc links to the associated i2c device
for MST DP connectors.

If the connector is created and registered before the i2c device, create
the link when registering the i2c device; otherwise, create the link
during late connector registration.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

 drivers/gpu/drm/drm_dp_mst_topology.c | 29 +++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 1ac874e4e7a1..73a2299c2faa 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2161,11 +2161,23 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
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
 
@@ -5490,6 +5502,7 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_aux *aux = &port->aux;
 	struct device *parent_dev = port->mgr->dev->dev;
+	int ret;
 
 	aux->ddc.algo = &drm_dp_mst_i2c_algo;
 	aux->ddc.algo_data = aux;
@@ -5504,7 +5517,17 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
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
@@ -5513,6 +5536,8 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
  */
 static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_mst_port *port)
 {
+	if (port->connector && port->connector->kdev)
+		sysfs_remove_link(&port->connector->kdev->kobj, "ddc");
 	i2c_del_adapter(&port->aux.ddc);
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

