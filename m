Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F01C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9B9207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927746;
	bh=j6E6+JIiRA2NDzuvQbLHoMgItM2Fu7Ye9Fc5ZrEKl08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WulzVWnpghMRjq0g8a6ZOl+UnksE509Gj9mwRmT/k43ZJBE+lRXM5n8+hoLbDVvvP
	 JN6sJpT9uGrykD0cdrFHuhf6PCiq7T/SRthPuvoK4ay86HrslJgLyI5nsfFG8/QUSW
	 8mLJPLI0D0+Zsw5mnPfeVysa1bHv0W2F9VkIXZ98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHTMtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgHTJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE3A22CB3;
        Thu, 20 Aug 2020 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916673;
        bh=j6E6+JIiRA2NDzuvQbLHoMgItM2Fu7Ye9Fc5ZrEKl08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT48EKssXQ7bh4TtYH5CODRfG6FRpHkMliF4Y/3qsc+1bH+DytAGW4uQPwfnHQM1k
         efaHi6kq0RblqUd0o0u96I0gslv92KKgDnn+3ijFQJudh+mCxKA98mSXavvVUrbCR6
         N0rvIr5lFy4ekqzUrD3B0U38IPNInKZZCRCSZedQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>
Subject: [PATCH 5.7 196/204] drm/dp_mst: Fix the DDC I2C device registration of an MST port
Date:   Thu, 20 Aug 2020 11:21:33 +0200
Message-Id: <20200820091615.970343025@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

commit d8bd15b37d328a935a4fc695fed8b19157503950 upstream.

During the initial MST probing an MST port's I2C device will be
registered using the kdev of the DRM device as a parent. Later after MST
Connection Status Notifications this I2C device will be re-registered
with the kdev of the port's connector. This will also move
inconsistently the I2C device's sysfs entry from the DRM device's sysfs
dir to the connector's dir.

Fix the above by keeping the DRM kdev as the parent of the I2C device.

Ideally the connector's kdev would be used as a parent, similarly to
non-MST connectors, however that needs some more refactoring to ensure
the connector's kdev is already available early enough. So keep the
existing (initial) behavior for now.

Cc: <stable@vger.kernel.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200607212522.16935-2-imre.deak@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_mst_topology.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -88,8 +88,8 @@ static int drm_dp_send_enum_path_resourc
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
 				 u8 *guid);
 
-static int drm_dp_mst_register_i2c_bus(struct drm_dp_aux *aux);
-static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_aux *aux);
+static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port);
+static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_mst_port *port);
 static void drm_dp_mst_kick_tx(struct drm_dp_mst_topology_mgr *mgr);
 
 #define DBG_PREFIX "[dp_mst]"
@@ -1981,7 +1981,7 @@ drm_dp_port_set_pdt(struct drm_dp_mst_po
 			}
 
 			/* remove i2c over sideband */
-			drm_dp_mst_unregister_i2c_bus(&port->aux);
+			drm_dp_mst_unregister_i2c_bus(port);
 		} else {
 			mutex_lock(&mgr->lock);
 			drm_dp_mst_topology_put_mstb(port->mstb);
@@ -1996,7 +1996,7 @@ drm_dp_port_set_pdt(struct drm_dp_mst_po
 	if (port->pdt != DP_PEER_DEVICE_NONE) {
 		if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
 			/* add i2c over sideband */
-			ret = drm_dp_mst_register_i2c_bus(&port->aux);
+			ret = drm_dp_mst_register_i2c_bus(port);
 		} else {
 			lct = drm_dp_calculate_rad(port, rad);
 			mstb = drm_dp_add_mst_branch_device(lct, rad);
@@ -5406,22 +5406,26 @@ static const struct i2c_algorithm drm_dp
 
 /**
  * drm_dp_mst_register_i2c_bus() - register an I2C adapter for I2C-over-AUX
- * @aux: DisplayPort AUX channel
+ * @port: The port to add the I2C bus on
  *
  * Returns 0 on success or a negative error code on failure.
  */
-static int drm_dp_mst_register_i2c_bus(struct drm_dp_aux *aux)
+static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
 {
+	struct drm_dp_aux *aux = &port->aux;
+	struct device *parent_dev = port->mgr->dev->dev;
+
 	aux->ddc.algo = &drm_dp_mst_i2c_algo;
 	aux->ddc.algo_data = aux;
 	aux->ddc.retries = 3;
 
 	aux->ddc.class = I2C_CLASS_DDC;
 	aux->ddc.owner = THIS_MODULE;
-	aux->ddc.dev.parent = aux->dev;
-	aux->ddc.dev.of_node = aux->dev->of_node;
+	/* FIXME: set the kdev of the port's connector as parent */
+	aux->ddc.dev.parent = parent_dev;
+	aux->ddc.dev.of_node = parent_dev->of_node;
 
-	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(aux->dev),
+	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(parent_dev),
 		sizeof(aux->ddc.name));
 
 	return i2c_add_adapter(&aux->ddc);
@@ -5429,11 +5433,11 @@ static int drm_dp_mst_register_i2c_bus(s
 
 /**
  * drm_dp_mst_unregister_i2c_bus() - unregister an I2C-over-AUX adapter
- * @aux: DisplayPort AUX channel
+ * @port: The port to remove the I2C bus from
  */
-static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_aux *aux)
+static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_mst_port *port)
 {
-	i2c_del_adapter(&aux->ddc);
+	i2c_del_adapter(&port->aux.ddc);
 }
 
 /**


