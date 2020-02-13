Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11CDC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863AE206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AyV9L8TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgBMEEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:04:48 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:48770
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbgBMEEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:04:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3fLfDyQjS8dt5QFvOSJANnQ5TG5U6U06OzwurvAAXVsujJMXWSHGMpA2GlLzaO+YMBc3syerhD45QUI73zk5X48QRHDg8QVJTMssfWgjvDY+Souq9voEpqwuGQdQsM6xVRntlrR8i1fwxBFY2pJUiR6j1m6lO2HvkB6aNoNQlY2ntn9bdspxmFBzb/Gd3h5m/AkjSR5d9MKQFmKGysDS62dFSj6WbBXyJ2SJg4eyim8t6VJWD1MYdyyHOvrO8WJZFjfEMn8wEA/u52gV70GiSvibgMxjJR7RSosdP3f2Nsx9l4ZkoUZ5NJz6uzXbf4K1bW7v5u/TXMRBpoucff03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XheuyLZGjlSMoeZrbaglHvPZyAbmZyDcXAeelAaIwNc=;
 b=Alir8ZdH+2gB/EKu+cQxz0RP2PzXB7I7gCSwTkz5Md36phebh2tCumhcI2AyqD9WERXEUcCMRqtCJkyC9b1cMiiacj99LHViAOV6aK+eE9q+yX/zU4ko5tOe3KnhF+eP+rUUgvapGKfGNnldLElZupZXabUrfXNoezNx8lKZduZGyynENDUdSWCwAzPCYJM9BF9GweG7gqD80S5G2zg6wjtpXx47yyzuCA19RNJNCm8H4kNAfB2zkY/aFRtfAUY1Ge5zHG2w5ESldL0I7PTCpr4lcvITHOSAUMfu/MfsXEmB9pCfDSgTNQzWZt/Sy9+01N9QcKe2oIxfgyBSXT1JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XheuyLZGjlSMoeZrbaglHvPZyAbmZyDcXAeelAaIwNc=;
 b=AyV9L8THdf7PESYBaoAQ/+jsfgcZ6aWnY2U5v9Quql2JrYFhrIZYYDRvBaU7wcbc1jE3HOQoEvvjS8e3aId+ZXugoLrgjf4oQxi2yDLFfA8ER9pHiHJjdxbse6bJ4RFAHgVSBGnQ2K9KisoFKU1ToCDOO4JzY8/ctcQwBu0dOlo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5220.eurprd04.prod.outlook.com (20.176.215.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 13 Feb 2020 04:04:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 04:04:43 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] firmware: arm_scmi: add smc/hvc transports
Date:   Thu, 13 Feb 2020 11:58:50 +0800
Message-Id: <1581566330-1029-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
References: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.12 via Frontend Transport; Thu, 13 Feb 2020 04:04:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0913ae3-bd4f-4193-a7e0-08d7b039db05
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:|AM0PR04MB5220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52205B216EAF02FB97ECB6B9881A0@AM0PR04MB5220.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(52116002)(4326008)(26005)(186003)(6666004)(36756003)(69590400006)(6486002)(956004)(2616005)(86362001)(8936002)(2906002)(478600001)(66476007)(5660300002)(81156014)(8676002)(81166006)(6506007)(9686003)(6512007)(316002)(66556008)(16526019)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5220;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJOImuDg+HQFxrIQyH2nowDazAuXGJXVF/pKivueM0vKjFIRzJgjHb9IkfV5UntRk3tSw8XvDvZbIwONvhF4Pm35R4ser15+9r0LwzpTLCLj4yQ5g6AmRXAN7MNbF8wZO0gqLtxLZf8EuzPHQizdpLpabAEzG5Qwp8cQg7LKv4hIzB+FMkoWZv8znleepMVfAWsaFvMsWIzA6D9hIn2edpKFkRN3uAOUSnV2BhcJeaeh0WJG7gq5f550hFj98KzUHaCAxJLqxAzhnOnlXeW+yl+zDImJLxJy2gbq3oUCJCSRavgxRuwu+ZDs7z7myBUc/r+jmzvXUQ1wZlGRFeVEUFEQhVxO8Ci84LRC4BVJoPPK+ibkUYCfRFsEylfO6Z2QPNG5l37zAdmAgMzXgPV1D2/vjDDoegRkrF4NtspxBQaj/xzj0VSH8XijH/73ZgxY3irQeBPKH0Tbl6kOT2Mj27TWMR9mwGjXFngfJoG5DuUWyqhv+pYaBkqsLwJR+6nhYVTSNbeZ5X8SjEMj6Nlut0nzOxdOsdjtv7OEYNQzIuk=
X-MS-Exchange-AntiSpam-MessageData: EvJRp7n/UcH0K5CDCyaXRBpw1S+4a3QUmrJgu19AsHnb/87H0N6Zl/9s/tBdME2nTXBRB99tq+ymb/gUviHoC2HQeeiWtfR1Kcy1bQRx0x4wh2nKAGaxd//A+c73NRv5/F2joOsZy8a7hgl44+qQUA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0913ae3-bd4f-4193-a7e0-08d7b039db05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:04:43.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwqa0w60SD8ckQZ+hdSAiLqO+0XJn3dkeyGb1O6VHmdWzypOIv4Rf/UBp3Phf5yzeIgueHVrhftpZfbmSuLsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add SCMI smc/hvc transports support.

Take smc-id as the 2nd arg, and protocol id as the 2nd arg when
invokding SMC/HVC. Since we need protocol id, so add this parrameter
to chan_setup, then smc transport driver could directly use it.
There is no Rx, only Tx because of smc/hvc not support Rx.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Makefile  |   2 +-
 drivers/firmware/arm_scmi/common.h  |   4 +-
 drivers/firmware/arm_scmi/driver.c  |  11 +-
 drivers/firmware/arm_scmi/mailbox.c |   2 +-
 drivers/firmware/arm_scmi/smc.c     | 222 ++++++++++++++++++++++++++++++++++++
 5 files changed, 234 insertions(+), 7 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/smc.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6694d0d908d6..6b1b0d6c6d0e 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -2,6 +2,6 @@
 obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o scmi-transport.o
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o
-scmi-transport-y = mailbox.o shmem.o
+scmi-transport-y = mailbox.o shmem.o smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index fd091a4ccbff..b8cd33be8272 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -182,7 +182,8 @@ struct scmi_chan_info {
  */
 struct scmi_transport_ops {
 	bool (*chan_available)(struct device *dev, int idx);
-	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev, bool tx);
+	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
+			  int prot_id, bool tx);
 	int (*chan_free)(int id, void *p, void *data);
 	int (*send_message)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
@@ -207,6 +208,7 @@ struct scmi_desc {
 };
 
 extern const struct scmi_desc scmi_mailbox_desc;
+extern const struct scmi_desc scmi_smc_desc;
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dbec767222e9..65c56328e6d8 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -595,7 +595,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 
 	cinfo->dev = dev;
 
-	ret = info->desc->ops->chan_setup(cinfo, info->dev, tx);
+	ret = info->desc->ops->chan_setup(cinfo, info->dev, prot_id, tx);
 	if (ret)
 		return ret;
 
@@ -687,8 +687,11 @@ static int scmi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 
-	desc = of_device_get_match_data(dev);
-	if (!desc)
+	if (of_get_property(np, "mboxes", NULL))
+		desc = &scmi_mailbox_desc;
+	else if (of_get_property(np, "smc-id", NULL))
+		desc = &scmi_smc_desc;
+	else
 		return -EINVAL;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
@@ -826,7 +829,7 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
-	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
+	{ .compatible = "arm,scmi",  },
 	{ /* Sentinel */ },
 };
 
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 73077bbc4ad9..b06d5d30fe90 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -53,7 +53,7 @@ static bool mailbox_chan_available(struct device *dev, int idx)
 }
 
 static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
-			      bool tx)
+			      int prot_id, bool tx)
 {
 	const char *desc = tx ? "Tx" : "Rx";
 	struct device *cdev = cinfo->dev;
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
new file mode 100644
index 000000000000..67bbf33efb1d
--- /dev/null
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Message SMC/HVC
+ * Transport driver
+ *
+ * Copyright 2020 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "common.h"
+
+/**
+ * struct scmi_smc - Structure representing a SCMI smc transport
+ *
+ * @cinfo: SCMI channel info
+ * @shmem: Transmit/Receive shared memory area
+ * @func_id: smc/hvc call function id
+ * @prot_id: The protocol id
+ */
+
+struct scmi_smc {
+	struct scmi_chan_info *cinfo;
+	struct scmi_shared_mem __iomem *shmem;
+	u32 func_id;
+	int prot_id;
+};
+
+typedef unsigned long (scmi_smc_fn)(unsigned long, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long, unsigned long,
+				    unsigned long, unsigned long);
+static scmi_smc_fn *invoke_scmi_smc_fn;
+
+#define client_to_scmi_smc(c) container_of(c, struct scmi_smc, cl)
+
+static bool smc_chan_available(struct device *dev, int idx)
+{
+	return true;
+}
+
+static unsigned long
+__invoke_scmi_fn_hvc(unsigned long function_id, unsigned long arg0,
+		     unsigned long arg1, unsigned long arg2,
+		     unsigned long arg3, unsigned long arg4,
+		     unsigned long arg5, unsigned long arg6)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, arg5,
+		      arg6, &res);
+
+	return res.a0;
+}
+
+static unsigned long
+__invoke_scmi_fn_smc(unsigned long function_id, unsigned long arg0,
+		     unsigned long arg1, unsigned long arg2,
+		     unsigned long arg3, unsigned long arg4,
+		     unsigned long arg5, unsigned long arg6)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, arg5,
+		      arg6, &res);
+
+	return res.a0;
+}
+
+static int scmi_smc_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (invoke_scmi_smc_fn)
+		return 0;
+
+	if (of_property_read_string(np, "method", &method))
+		return -ENXIO;
+
+	if (!strcmp("hvc", method)) {
+		invoke_scmi_smc_fn = __invoke_scmi_fn_hvc;
+	} else if (!strcmp("smc", method)) {
+		invoke_scmi_smc_fn = __invoke_scmi_fn_smc;
+	} else {
+		pr_warn("invalid \"method\" property: %s\n", method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
+			  int prot_id, bool tx)
+{
+	struct device *cdev = cinfo->dev;
+	struct scmi_smc *scmi_info;
+	struct device_node *np;
+	resource_size_t size;
+	struct resource res;
+	u32 func_id;
+	int ret;
+
+	if (!tx)
+		return -ENODEV;
+
+	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
+	if (!scmi_info)
+		return -ENOMEM;
+
+	np = of_parse_phandle(cdev->of_node, "shmem", 0);
+	if (!np)
+		np = of_parse_phandle(dev->of_node, "shmem", 0);
+	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+	if (ret) {
+		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
+		return ret;
+	}
+
+	size = resource_size(&res);
+	scmi_info->shmem = devm_ioremap(dev, res.start, size);
+	if (!scmi_info->shmem) {
+		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "smc-id", &func_id);
+	if (ret < 0)
+		return ret;
+
+	np = of_find_node_by_path("/psci");
+	if (!np) {
+		dev_err(dev, "Not able to find /psci node\n");
+		return -ENODEV;
+	}
+
+	ret = scmi_smc_conduit_method(np);
+	if (ret)
+		return ret;
+
+	of_node_put(np);
+
+	scmi_info->func_id = func_id;
+	scmi_info->cinfo = cinfo;
+	scmi_info->prot_id = prot_id;
+	cinfo->transport_info = scmi_info;
+
+	return 0;
+}
+
+static int smc_chan_free(int id, void *p, void *data)
+{
+	struct scmi_chan_info *cinfo = p;
+	struct scmi_smc *scmi_info = cinfo->transport_info;
+
+	cinfo->transport_info = NULL;
+	scmi_info->cinfo = NULL;
+
+	scmi_free_channel(cinfo, data, id);
+
+	return 0;
+}
+
+static int smc_send_message(struct scmi_chan_info *cinfo,
+			    struct scmi_xfer *xfer)
+{
+	struct scmi_smc *scmi_info = cinfo->transport_info;
+	int ret;
+
+	shmem_tx_prepare(scmi_info->shmem, xfer);
+
+	ret = invoke_scmi_smc_fn(scmi_info->func_id, scmi_info->prot_id,
+				 0, 0, 0, 0, 0, 0);
+	if (ret > 0)
+		ret = 0;
+
+	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
+
+	return ret;
+}
+
+static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
+{
+}
+
+static void smc_fetch_response(struct scmi_chan_info *cinfo,
+			       struct scmi_xfer *xfer)
+{
+	struct scmi_smc *scmi_info = cinfo->transport_info;
+
+	shmem_fetch_response(scmi_info->shmem, xfer);
+}
+
+static bool
+smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
+{
+	struct scmi_smc *scmi_info = cinfo->transport_info;
+
+	return shmem_poll_done(scmi_info->shmem, xfer);
+}
+
+static struct scmi_transport_ops scmi_smc_ops = {
+	.chan_available = smc_chan_available,
+	.chan_setup = smc_chan_setup,
+	.chan_free = smc_chan_free,
+	.send_message = smc_send_message,
+	.mark_txdone = smc_mark_txdone,
+	.fetch_response = smc_fetch_response,
+	.poll_done = smc_poll_done,
+};
+
+const struct scmi_desc scmi_smc_desc = {
+	.ops = &scmi_smc_ops,
+	.max_rx_timeout_ms = 30,
+	.max_msg = 1,
+	.max_msg_size = 128,
+};
-- 
2.16.4

