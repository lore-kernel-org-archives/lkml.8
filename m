Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6871FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34ECF207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n5JQIU7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgEUAKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:10:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48434 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:10:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04L0ADbv039943;
        Wed, 20 May 2020 19:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590019813;
        bh=ST8Yem8ialn5243k7YW5yffQxZOhgWPUoOpWLgWxyRw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n5JQIU7UxlsY3NiSOI8nNHRycPR0E7RssEID8o8Vlhkzd2RH0zm+qlXm5YU6NxBZ7
         2UrA9QiJU5E0sLHe9XF6/tSveVbY0pZW1kfgFhnaSveg9YBwExPch5wfCTMkKtyG/I
         UGsUQILAlsEY4tjmEseKrk0cYOAm7VeY/wLqhM9o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04L0ADaR053697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 19:10:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 19:10:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 19:10:13 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04L0ADTr065310;
        Wed, 20 May 2020 19:10:13 -0500
Received: from localhost ([10.250.48.148])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 04L0ACKH084879;
        Wed, 20 May 2020 19:10:12 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 1/4] remoteproc: Introduce rproc_of_parse_firmware() helper
Date:   Wed, 20 May 2020 19:10:03 -0500
Message-ID: <20200521001006.2725-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200521001006.2725-1-s-anna@ti.com>
References: <20200521001006.2725-1-s-anna@ti.com>
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
---
v2: New patch

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

