Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB25C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C1A206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IZ+OBQjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFLWtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:49:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35452 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:49:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnR5N108675;
        Fri, 12 Jun 2020 17:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592002167;
        bh=8Gnvm0Dx2536XFDw8g4fMAwYldxTRJioYlmw6qTiNyU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IZ+OBQjCYEQlRXwwwuQeubiFpoK6lIjs1zyRreTcB9G0cOCphVhz/b7qNHvgboo2b
         i41YmpBI1L6bzM7Jz+3PFuNyo35QoSLjRdbfj0+O/wQllpuptzOCVggK9v36ZQsbRM
         rI6yKV8H6xVa6qlSIHS2EOnQKUrR3c6XVilDeOgg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CMnRE2119604
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:49:27 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 17:49:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 17:49:26 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnRbR071954;
        Fri, 12 Jun 2020 17:49:27 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05CMnQLW062163;
        Fri, 12 Jun 2020 17:49:26 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 1/6] remoteproc: Introduce rproc_of_parse_firmware() helper
Date:   Fri, 12 Jun 2020 17:49:09 -0500
Message-ID: <20200612224914.7634-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200612224914.7634-1-s-anna@ti.com>
References: <20200612224914.7634-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper function rproc_of_parse_firmware() to the remoteproc
core that can be used by various remoteproc drivers to look up the
the "firmware-name" property from a rproc device node. This property
is already being used by multiple drivers, so this helper can avoid
repeating equivalent code in remoteproc drivers.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v3: No changes, picked up review tags
v2: https://patchwork.kernel.org/patch/11561791/

 drivers/remoteproc/remoteproc_core.c     | 23 +++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 9f04c30c4aaf..c458b218d524 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1034,6 +1034,29 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
 }
 EXPORT_SYMBOL(rproc_of_resm_mem_entry_init);
 
+/**
+ * rproc_of_parse_firmware() - parse and return the firmware-name
+ * @dev: pointer on device struct representing a rproc
+ * @index: index to use for the firmware-name retrieval
+ * @fw_name: pointer to a character string, in which the firmware
+ *           name is returned on success and unmodified otherwise.
+ *
+ * This is an OF helper function that parses a device's DT node for
+ * the "firmware-name" property and returns the firmware name pointer
+ * in @fw_name on success.
+ *
+ * Return: 0 on success, or an appropriate failure.
+ */
+int rproc_of_parse_firmware(struct device *dev, int index, const char **fw_name)
+{
+	int ret;
+
+	ret = of_property_read_string_index(dev->of_node, "firmware-name",
+					    index, fw_name);
+	return ret ? ret : 0;
+}
+EXPORT_SYMBOL(rproc_of_parse_firmware);
+
 /*
  * A lookup table for resource handlers. The indices are defined in
  * enum fw_resource_type.
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 4ba7cb59d3e8..e5341e91d2fc 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -28,6 +28,8 @@ struct rproc_debug_trace {
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
 void rproc_vdev_release(struct kref *ref);
+int rproc_of_parse_firmware(struct device *dev, int index,
+			    const char **fw_name);
 
 /* from remoteproc_virtio.c */
 int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
-- 
2.26.0

