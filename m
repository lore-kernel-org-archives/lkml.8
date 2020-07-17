Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF3C433FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CA52074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vCqye4rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgGQXsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:48:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45374 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGQXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm7PJ083783;
        Fri, 17 Jul 2020 18:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595029687;
        bh=jHlH05tXGOLRwWsXUTZTLlAmGKwGHC7r1J05PDf0zoA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vCqye4rHRTzTuGZJU9erSElVcIdYgoIZxjeQ1Lw6yUoAJnA5YoGyPaura7+jnel+M
         lzd1BUwb4u9dygXbEIjQmWvexvNoviAJ/9W8FmYhYABVKPx96tUxmdNt1gPJht3xtD
         INyOV4eyUV+kzZJuBx2gIQyPsSe1YBqeiYXRsdHw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HNm73P042654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 18:48:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 18:48:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 18:48:06 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm662037411;
        Fri, 17 Jul 2020 18:48:06 -0500
Received: from localhost ([10.250.34.57])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 06HNm6ZI108262;
        Fri, 17 Jul 2020 18:48:06 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v4 1/6] remoteproc: Introduce rproc_of_parse_firmware() helper
Date:   Fri, 17 Jul 2020 18:47:55 -0500
Message-ID: <20200717234800.9423-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200717234800.9423-1-s-anna@ti.com>
References: <20200717234800.9423-1-s-anna@ti.com>
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
v4: No changes
v3: https://patchwork.kernel.org/patch/11602327/

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

