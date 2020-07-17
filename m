Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531EEC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384B0207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGQPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:48:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40576 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgGQPsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:48:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A2ABC1A09CA;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92B921A026D;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 597FF205C8;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] bus: fsl-mc: add missing device types
Date:   Fri, 17 Jul 2020 18:47:58 +0300
Message-Id: <20200717154800.17169-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717154800.17169-1-ioana.ciornei@nxp.com>
References: <20200717154800.17169-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MC bus has different types of devices that can be discovered on the
bus. Add the missing device types.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 30 ++++++++++++++++++++++++++++++
 include/linux/fsl/mc.h          | 30 ++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 40526da5c6a6..ee1873438e97 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -201,6 +201,31 @@ struct device_type fsl_mc_bus_dpseci_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpseci_type);
 
+struct device_type fsl_mc_bus_dpdmux_type = {
+	.name = "fsl_mc_bus_dpdmux"
+};
+EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmux_type);
+
+struct device_type fsl_mc_bus_dpdcei_type = {
+	.name = "fsl_mc_bus_dpdcei"
+};
+EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdcei_type);
+
+struct device_type fsl_mc_bus_dpaiop_type = {
+	.name = "fsl_mc_bus_dpaiop"
+};
+EXPORT_SYMBOL_GPL(fsl_mc_bus_dpaiop_type);
+
+struct device_type fsl_mc_bus_dpci_type = {
+	.name = "fsl_mc_bus_dpci"
+};
+EXPORT_SYMBOL_GPL(fsl_mc_bus_dpci_type);
+
+struct device_type fsl_mc_bus_dpdmai_type = {
+	.name = "fsl_mc_bus_dpdmai"
+};
+EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmai_type);
+
 static struct device_type *fsl_mc_get_device_type(const char *type)
 {
 	static const struct {
@@ -217,6 +242,11 @@ static struct device_type *fsl_mc_get_device_type(const char *type)
 		{ &fsl_mc_bus_dpmac_type, "dpmac" },
 		{ &fsl_mc_bus_dprtc_type, "dprtc" },
 		{ &fsl_mc_bus_dpseci_type, "dpseci" },
+		{ &fsl_mc_bus_dpdmux_type, "dpdmux" },
+		{ &fsl_mc_bus_dpdcei_type, "dpdcei" },
+		{ &fsl_mc_bus_dpaiop_type, "dpaiop" },
+		{ &fsl_mc_bus_dpci_type, "dpci" },
+		{ &fsl_mc_bus_dpdmai_type, "dpdmai" },
 		{ NULL, NULL }
 	};
 	int i;
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 2b5f8366dbe1..cdb03aca2aef 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -433,6 +433,11 @@ extern struct device_type fsl_mc_bus_dpmcp_type;
 extern struct device_type fsl_mc_bus_dpmac_type;
 extern struct device_type fsl_mc_bus_dprtc_type;
 extern struct device_type fsl_mc_bus_dpseci_type;
+extern struct device_type fsl_mc_bus_dpdmux_type;
+extern struct device_type fsl_mc_bus_dpdcei_type;
+extern struct device_type fsl_mc_bus_dpaiop_type;
+extern struct device_type fsl_mc_bus_dpci_type;
+extern struct device_type fsl_mc_bus_dpdmai_type;
 
 static inline bool is_fsl_mc_bus_dprc(const struct fsl_mc_device *mc_dev)
 {
@@ -454,6 +459,11 @@ static inline bool is_fsl_mc_bus_dpsw(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dpsw_type;
 }
 
+static inline bool is_fsl_mc_bus_dpdmux(const struct fsl_mc_device *mc_dev)
+{
+	return mc_dev->dev.type == &fsl_mc_bus_dpdmux_type;
+}
+
 static inline bool is_fsl_mc_bus_dpbp(const struct fsl_mc_device *mc_dev)
 {
 	return mc_dev->dev.type == &fsl_mc_bus_dpbp_type;
@@ -484,6 +494,26 @@ static inline bool is_fsl_mc_bus_dpseci(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dpseci_type;
 }
 
+static inline bool is_fsl_mc_bus_dpdcei(const struct fsl_mc_device *mc_dev)
+{
+	return mc_dev->dev.type == &fsl_mc_bus_dpdcei_type;
+}
+
+static inline bool is_fsl_mc_bus_dpaiop(const struct fsl_mc_device *mc_dev)
+{
+	return mc_dev->dev.type == &fsl_mc_bus_dpaiop_type;
+}
+
+static inline bool is_fsl_mc_bus_dpci(const struct fsl_mc_device *mc_dev)
+{
+	return mc_dev->dev.type == &fsl_mc_bus_dpci_type;
+}
+
+static inline bool is_fsl_mc_bus_dpdmai(const struct fsl_mc_device *mc_dev)
+{
+	return mc_dev->dev.type == &fsl_mc_bus_dpdmai_type;
+}
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.25.1

