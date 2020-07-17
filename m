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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AE5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D0420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pre8xIF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgGQXsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:48:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45376 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgGQXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm8Eo083788;
        Fri, 17 Jul 2020 18:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595029688;
        bh=dBbdibFIdBCx0Mutp6FXFLNYrk/vosrPh9OhpywEkk8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pre8xIF5EnuO+MujSKhNYKgwhIlc69cAjl/+du62Y6ViMHEJaAk8jBvmUvAs45ELh
         LvztcVYEDkTJIPvnqL8u5kY+G74JDC3B45MPfEaOmmRZ7mtiMh/2NvLL/7iB0pTd7T
         ELDJjvX8PWgUd0Y8ZdKAO0XSd0LcsTuSQrXgabVg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HNm8Kb062222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 18:48:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 18:48:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 18:48:07 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm7xu037434;
        Fri, 17 Jul 2020 18:48:07 -0500
Received: from localhost ([10.250.34.57])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 06HNm70N108271;
        Fri, 17 Jul 2020 18:48:07 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v4 2/6] remoteproc: k3: Add TI-SCI processor control helper functions
Date:   Fri, 17 Jul 2020 18:47:56 -0500
Message-ID: <20200717234800.9423-3-s-anna@ti.com>
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

Texas Instruments' K3 generation SoCs have specific modules/register
spaces used for configuring the various aspects of a remote processor.
These include power, reset, boot vector and other configuration features
specific to each compute processor present on the SoC. These registers
are managed by the System Controller such as DMSC on K3 AM65x SoCs.

The Texas Instrument's System Control Interface (TI-SCI) Message Protocol
is used to communicate to the System Controller from various compute
processors to invoke specific services provided by the firmware running
on the System Controller.

Add a common processor control interface header file that can be used by
multiple remoteproc drivers. The helper functions within this header file
abstract the various TI SCI protocol ops for the remoteproc drivers, and
allow them to request the System Controller to be able to program and
manage various remote processors on the SoC. The remoteproc drivers are
expected to manage the life-cycle of their ti_sci_proc_dev local
structures.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v4: Addressed minor comments from Mathieu and picked up his Reviewed-by tag
 - Moved the ti_sci_protocol.h header file from driver to here
 - Replaced http with https
 - Appended my email address after the name
v3: https://patchwork.kernel.org/patch/11602329/

 drivers/remoteproc/ti_sci_proc.h | 104 +++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 drivers/remoteproc/ti_sci_proc.h

diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
new file mode 100644
index 000000000000..778558abcdcc
--- /dev/null
+++ b/drivers/remoteproc/ti_sci_proc.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Texas Instruments TI-SCI Processor Controller Helper Functions
+ *
+ * Copyright (C) 2018-2020 Texas Instruments Incorporated - https://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#ifndef REMOTEPROC_TI_SCI_PROC_H
+#define REMOTEPROC_TI_SCI_PROC_H
+
+#include <linux/soc/ti/ti_sci_protocol.h>
+
+/**
+ * struct ti_sci_proc - structure representing a processor control client
+ * @sci: cached TI-SCI protocol handle
+ * @ops: cached TI-SCI proc ops
+ * @dev: cached client device pointer
+ * @proc_id: processor id for the consumer remoteproc device
+ * @host_id: host id to pass the control over for this consumer remoteproc
+ *	     device
+ */
+struct ti_sci_proc {
+	const struct ti_sci_handle *sci;
+	const struct ti_sci_proc_ops *ops;
+	struct device *dev;
+	u8 proc_id;
+	u8 host_id;
+};
+
+static inline int ti_sci_proc_request(struct ti_sci_proc *tsp)
+{
+	int ret;
+
+	ret = tsp->ops->request(tsp->sci, tsp->proc_id);
+	if (ret)
+		dev_err(tsp->dev, "ti-sci processor request failed: %d\n",
+			ret);
+	return ret;
+}
+
+static inline int ti_sci_proc_release(struct ti_sci_proc *tsp)
+{
+	int ret;
+
+	ret = tsp->ops->release(tsp->sci, tsp->proc_id);
+	if (ret)
+		dev_err(tsp->dev, "ti-sci processor release failed: %d\n",
+			ret);
+	return ret;
+}
+
+static inline int ti_sci_proc_handover(struct ti_sci_proc *tsp)
+{
+	int ret;
+
+	ret = tsp->ops->handover(tsp->sci, tsp->proc_id, tsp->host_id);
+	if (ret)
+		dev_err(tsp->dev, "ti-sci processor handover of %d to %d failed: %d\n",
+			tsp->proc_id, tsp->host_id, ret);
+	return ret;
+}
+
+static inline int ti_sci_proc_set_config(struct ti_sci_proc *tsp,
+					 u64 boot_vector,
+					 u32 cfg_set, u32 cfg_clr)
+{
+	int ret;
+
+	ret = tsp->ops->set_config(tsp->sci, tsp->proc_id, boot_vector,
+				   cfg_set, cfg_clr);
+	if (ret)
+		dev_err(tsp->dev, "ti-sci processor set_config failed: %d\n",
+			ret);
+	return ret;
+}
+
+static inline int ti_sci_proc_set_control(struct ti_sci_proc *tsp,
+					  u32 ctrl_set, u32 ctrl_clr)
+{
+	int ret;
+
+	ret = tsp->ops->set_control(tsp->sci, tsp->proc_id, ctrl_set, ctrl_clr);
+	if (ret)
+		dev_err(tsp->dev, "ti-sci processor set_control failed: %d\n",
+			ret);
+	return ret;
+}
+
+static inline int ti_sci_proc_get_status(struct ti_sci_proc *tsp,
+					 u64 *boot_vector, u32 *cfg_flags,
+					 u32 *ctrl_flags, u32 *status_flags)
+{
+	int ret;
+
+	ret = tsp->ops->get_status(tsp->sci, tsp->proc_id, boot_vector,
+				   cfg_flags, ctrl_flags, status_flags);
+	if (ret)
+		dev_err(tsp->dev, "ti-sci processor get_status failed: %d\n",
+			ret);
+	return ret;
+}
+
+#endif /* REMOTEPROC_TI_SCI_PROC_H */
-- 
2.26.0

