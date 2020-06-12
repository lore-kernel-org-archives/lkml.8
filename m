Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88F22078A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z0J5WdW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgFLWuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:50:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49210 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgFLWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:49:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnT39103481;
        Fri, 12 Jun 2020 17:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592002169;
        bh=GP4LvDpiiVb2/sG8nBRXMGkNlpoMDKmbI3o4CyswfyQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z0J5WdW3C4QYbSEilG73sOj0fwHpVWVXR7q5t9wRMEzqU7mC1GIWFrEWEX7mqT2Hp
         GgAIIk/XlUmpta5gICaCajK1+hRYLKQG80SD03PluA6hyDMMEXzuD3hg/D6oNMR6R5
         eFPgur8/L6YCGBzAgrzztqJZShkJU+eHNVFk4CUA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CMnTVt058565
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:49:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 17:49:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 17:49:28 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnSlx089805;
        Fri, 12 Jun 2020 17:49:28 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05CMnSlF062169;
        Fri, 12 Jun 2020 17:49:28 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 2/6] remoteproc: k3: Add TI-SCI processor control helper functions
Date:   Fri, 12 Jun 2020 17:49:10 -0500
Message-ID: <20200612224914.7634-3-s-anna@ti.com>
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
---
v3: New to this series, but the patch is identical to the one from the
    K3 R5F series posted previously, with patch title adjusted
    https://patchwork.kernel.org/patch/11456379/

 drivers/remoteproc/ti_sci_proc.h | 102 +++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 drivers/remoteproc/ti_sci_proc.h

diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
new file mode 100644
index 000000000000..e42d8015b8e7
--- /dev/null
+++ b/drivers/remoteproc/ti_sci_proc.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Texas Instruments TI-SCI Processor Controller Helper Functions
+ *
+ * Copyright (C) 2018-2020 Texas Instruments Incorporated - http://www.ti.com/
+ *	Suman Anna
+ */
+
+#ifndef REMOTEPROC_TI_SCI_PROC_H
+#define REMOTEPROC_TI_SCI_PROC_H
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

