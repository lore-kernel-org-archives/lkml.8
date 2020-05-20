Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECDDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5D207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nr66gr9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgETGBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:01:43 -0400
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:7565
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbgETGBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6ASWrAe/y70+n7BGchIQ5sX6+2/dWS04Q2NU8BdSyhU73j3hRHAC6W8tMuVTiBs2ZKIGj64rfJ5IDn9mBGKAgIKO0ICz/9b6kTCjnmXIhTwBjQybZaSqQuu7RXukOQHZ8hSB7kXvQI8ndCLL1+TyziDN/G8fwVQD+7+OxIpBcxwp2/vbgrIjUWv++6xkTgeCp8hdej/TkIuGh5v+lg9yzZCpBelUcHCIwD9H8h+AabPcpfvYUVzNdY/82vHBbNLZpF2rC0iuFvzcqi1Ee0ERIM6l8CGL3Dd5vPiE8S/X2R0nRtIFV44u9lm3WtWYtagqfXSgwSpztOAQRmJjBgKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMmlLBIO2EW1mEDrbxUCq5DrtctmJuawlVaXE2qzKag=;
 b=hRVbinoVe2k9sRlE5BN5nHjAuEvwRe2zl6vcRx9jtcDSwxa9HN8nNnS0FFaHi2gi4TGLEOeXCs1dg3XvFW/gSArozR5Oxc3I+m1gcvGxQaU7mUx9baCTY+rTodCwI8riJWIYtaRSCQYncKQ4ACWnl1uOuRPTEWSK2jpENi1V7A7WWt/O4o6Gw8aUnrsCy1Eolfab4DXcR2S1+wE52ebVGkJL6IlAI72XnthMob4Bynmb55ovb05wDEhzDQT0+XxjVit9y3u8OVoz/NrRsiAwMW7gNb+GBanGqpBboJ/klnfpoShSve/IcyPb1MTbostpaf38T1EG8jRKMqtRhkuFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMmlLBIO2EW1mEDrbxUCq5DrtctmJuawlVaXE2qzKag=;
 b=Nr66gr9i/HkcMfbxku9kymc67qRfHMpAYksuvLk16Msp0ROaUKRqGVn3z7UrRrJ/6JhEVO88yl7+inRg3pnYKkXCEcQdMq1Zkkodw/XiC0t08HLk61jj0ATjjpQtEp2c8TCzSDfVdqxs6lHU9MWc90PpU1FgrWl5uRqhtzyBsTg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2790.eurprd04.prod.outlook.com (2603:10a6:4:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 06:01:38 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 06:01:38 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, cphealy@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/3] soc: imx: move cpu code to drivers/soc/imx
Date:   Wed, 20 May 2020 13:51:29 +0800
Message-Id: <1589953889-30955-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:3:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.31 via Frontend Transport; Wed, 20 May 2020 06:01:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3bd93cb-7fd0-49f3-fd07-08d7fc83423a
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2790B4B6C7FF1236F696382788B60@DB6PR0402MB2790.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3x6ydBqct7c1+hwaVYwfowpmcpwSuffNBCQkIg5QWbDu7MuvBH65Ni7EFsP2CTfMOrCX+ZA/5YSf21DiK1uk1CLvJBkU6dJ17+IbiqxhZ6RduUt0mnTgP5cDYf7wXxptTvQQd3N5zje0dcUOh7AgYMacioifKgdIEMMwZRAa1NFVxjcgw5h8XSkuLqSKn27o7NkNXFXCqj+UdbinLCk8EL5NHmxpk+UU0rBRPCeHTS+WGzPZRbcc0sjGu6GNMVYovWOBIzMHhBuntbp7gmpBwf++FXTq8oYiRcVdpczfLZgQVIEXP2aD+ogrpDhBhuXbrIz7Z3EDkoUjbOjYXi2mJk69ytzSPbxrWm1RumO7F499gNx3uWsgZtDscj7dJ6sQJ3wXC1eAb+Gy2+5KFD5RPo/B+woGJVKXafqADXl6cQlXl3ZKoylRYHXvUmGNctUyyc6u8owztgGm1BdXvY+vYF0aSkSvMMNsUkqEb9LdTfE2AXDE3SXn7prDjrF5uV4c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(7416002)(2906002)(16526019)(186003)(66556008)(6486002)(86362001)(956004)(66476007)(2616005)(66946007)(69590400007)(6666004)(316002)(26005)(5660300002)(4326008)(8676002)(6512007)(478600001)(9686003)(36756003)(52116002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WfE/0f3PAPMSqJD5wMkC01CUTrQdmvR+Tyzd+eXSEouYBNzo7eaGGRXXW3WxAMnfvt6EmmSiqNG6ggIgEm1q/DOVSngzuQ2Otey2BMhcvENDUBtFzGdNAirYEFQ+wPaAJP3eP7y1lnj5XdS9TyeXWtjd/MSP/noPSspN+GC0+/zIFFMC3v3xeIhzTVqvT77V5oocGB7ByJCpFSjJn41BJW7ocyPaGoh5J2YRgX03pnEby9mb0ES0KofncUhRp6qJqRLeJE4Xc/+MUYff+0XmHLYT1Yv6DrekvvbgldJEoTjXn54XeQudaJFiOF9ajc1SWKtmcdggjKyETfYz4HlMlq2HeLdX4VWM0cJ/iZrNYBS8+FRDUqo7YjlAR3g5KURJjdwBKCAfX9RCe0l4pQ7qIuG25BQ/T2Qv2Z7Uq9NYX2ipP85PRUiSIPCdkkEXzExqH+SYJYcoAnK1FnQl0xwxErqh2jOtgcd3CHHwEs79kypxfOWDbpFF90qNTNjALj1h
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bd93cb-7fd0-49f3-fd07-08d7fc83423a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 06:01:38.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWXfMLW0TgbSlgASKqEEHB+l7WnDrHvjjXfklT1AaDRC5VfEbWF8WzMpsXr49SnEKhfazZ9dXLRqBIocTI1WCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Move the soc device register code to drivers/soc/imx to align with
i.MX8.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/cpu.c   | 182 -------------------------------------------
 drivers/soc/imx/Makefile  |   3 +
 drivers/soc/imx/soc-imx.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 182 deletions(-)
 create mode 100644 drivers/soc/imx/soc-imx.c

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 75ffcba9f878..65c7224f5250 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -1,25 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-#include <linux/sys_soc.h>
 
 #include "hardware.h"
 #include "common.h"
 
-#define OCOTP_UID_H	0x420
-#define OCOTP_UID_L	0x410
-
-#define OCOTP_ULP_UID_1		0x4b0
-#define OCOTP_ULP_UID_2		0x4c0
-#define OCOTP_ULP_UID_3		0x4d0
-#define OCOTP_ULP_UID_4		0x4e0
-
 unsigned int __mxc_cpu_type;
 static unsigned int imx_soc_revision;
 
@@ -82,173 +70,3 @@ void __init imx_aips_allow_unprivileged_access(
 		imx_set_aips(aips_base_addr);
 	}
 }
-
-static int __init imx_soc_device_init(void)
-{
-	struct soc_device_attribute *soc_dev_attr;
-	const char *ocotp_compat = NULL;
-	struct soc_device *soc_dev;
-	struct device_node *root;
-	struct regmap *ocotp = NULL;
-	const char *soc_id;
-	u64 soc_uid = 0;
-	u32 val;
-	int ret;
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
-
-	soc_dev_attr->family = "Freescale i.MX";
-
-	root = of_find_node_by_path("/");
-	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
-	of_node_put(root);
-	if (ret)
-		goto free_soc;
-
-	switch (__mxc_cpu_type) {
-	case MXC_CPU_MX1:
-		soc_id = "i.MX1";
-		break;
-	case MXC_CPU_MX21:
-		soc_id = "i.MX21";
-		break;
-	case MXC_CPU_MX25:
-		soc_id = "i.MX25";
-		break;
-	case MXC_CPU_MX27:
-		soc_id = "i.MX27";
-		break;
-	case MXC_CPU_MX31:
-		soc_id = "i.MX31";
-		break;
-	case MXC_CPU_MX35:
-		soc_id = "i.MX35";
-		break;
-	case MXC_CPU_MX51:
-		soc_id = "i.MX51";
-		break;
-	case MXC_CPU_MX53:
-		soc_id = "i.MX53";
-		break;
-	case MXC_CPU_IMX6SL:
-		ocotp_compat = "fsl,imx6sl-ocotp";
-		soc_id = "i.MX6SL";
-		break;
-	case MXC_CPU_IMX6DL:
-		ocotp_compat = "fsl,imx6q-ocotp";
-		soc_id = "i.MX6DL";
-		break;
-	case MXC_CPU_IMX6SX:
-		ocotp_compat = "fsl,imx6sx-ocotp";
-		soc_id = "i.MX6SX";
-		break;
-	case MXC_CPU_IMX6Q:
-		ocotp_compat = "fsl,imx6q-ocotp";
-		soc_id = "i.MX6Q";
-		break;
-	case MXC_CPU_IMX6UL:
-		ocotp_compat = "fsl,imx6ul-ocotp";
-		soc_id = "i.MX6UL";
-		break;
-	case MXC_CPU_IMX6ULL:
-		ocotp_compat = "fsl,imx6ull-ocotp";
-		soc_id = "i.MX6ULL";
-		break;
-	case MXC_CPU_IMX6ULZ:
-		ocotp_compat = "fsl,imx6ull-ocotp";
-		soc_id = "i.MX6ULZ";
-		break;
-	case MXC_CPU_IMX6SLL:
-		ocotp_compat = "fsl,imx6sll-ocotp";
-		soc_id = "i.MX6SLL";
-		break;
-	case MXC_CPU_IMX7D:
-		ocotp_compat = "fsl,imx7d-ocotp";
-		soc_id = "i.MX7D";
-		break;
-	case MXC_CPU_IMX7ULP:
-		ocotp_compat = "fsl,imx7ulp-ocotp";
-		soc_id = "i.MX7ULP";
-		break;
-	case MXC_CPU_VF500:
-		ocotp_compat = "fsl,vf610-ocotp";
-		soc_id = "VF500";
-		break;
-	case MXC_CPU_VF510:
-		ocotp_compat = "fsl,vf610-ocotp";
-		soc_id = "VF510";
-		break;
-	case MXC_CPU_VF600:
-		ocotp_compat = "fsl,vf610-ocotp";
-		soc_id = "VF600";
-		break;
-	case MXC_CPU_VF610:
-		ocotp_compat = "fsl,vf610-ocotp";
-		soc_id = "VF610";
-		break;
-	default:
-		soc_id = "Unknown";
-	}
-	soc_dev_attr->soc_id = soc_id;
-
-	if (ocotp_compat) {
-		ocotp = syscon_regmap_lookup_by_compatible(ocotp_compat);
-		if (IS_ERR(ocotp))
-			pr_err("%s: failed to find %s regmap!\n", __func__, ocotp_compat);
-	}
-
-	if (!IS_ERR_OR_NULL(ocotp)) {
-		if (__mxc_cpu_type == MXC_CPU_IMX7ULP) {
-			regmap_read(ocotp, OCOTP_ULP_UID_4, &val);
-			soc_uid = val & 0xffff;
-			regmap_read(ocotp, OCOTP_ULP_UID_3, &val);
-			soc_uid <<= 16;
-			soc_uid |= val & 0xffff;
-			regmap_read(ocotp, OCOTP_ULP_UID_2, &val);
-			soc_uid <<= 16;
-			soc_uid |= val & 0xffff;
-			regmap_read(ocotp, OCOTP_ULP_UID_1, &val);
-			soc_uid <<= 16;
-			soc_uid |= val & 0xffff;
-		} else {
-			regmap_read(ocotp, OCOTP_UID_H, &val);
-			soc_uid = val;
-			regmap_read(ocotp, OCOTP_UID_L, &val);
-			soc_uid <<= 32;
-			soc_uid |= val;
-		}
-	}
-
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
-					   (imx_soc_revision >> 4) & 0xf,
-					   imx_soc_revision & 0xf);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
-		goto free_soc;
-	}
-
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
-	if (!soc_dev_attr->serial_number) {
-		ret = -ENOMEM;
-		goto free_rev;
-	}
-
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
-		goto free_serial_number;
-	}
-
-	return 0;
-
-free_serial_number:
-	kfree(soc_dev_attr->serial_number);
-free_rev:
-	kfree(soc_dev_attr->revision);
-free_soc:
-	kfree(soc_dev_attr);
-	return ret;
-}
-device_initcall(imx_soc_device_init);
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 103e2c93c342..446143241fe7 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+ifeq ($(CONFIG_ARM),y)
+obj-$(CONFIG_ARCH_MXC) += soc-imx.o
+endif
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
diff --git a/drivers/soc/imx/soc-imx.c b/drivers/soc/imx/soc-imx.c
new file mode 100644
index 000000000000..fec3d672b606
--- /dev/null
+++ b/drivers/soc/imx/soc-imx.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 NXP
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#include <soc/imx/cpu.h>
+#include <soc/imx/revision.h>
+
+#define OCOTP_UID_H	0x420
+#define OCOTP_UID_L	0x410
+
+#define OCOTP_ULP_UID_1		0x4b0
+#define OCOTP_ULP_UID_2		0x4c0
+#define OCOTP_ULP_UID_3		0x4d0
+#define OCOTP_ULP_UID_4		0x4e0
+
+static int __init imx_soc_device_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const char *ocotp_compat = NULL;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	struct regmap *ocotp = NULL;
+	const char *soc_id;
+	u64 soc_uid = 0;
+	u32 val;
+	int ret;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Freescale i.MX";
+
+	root = of_find_node_by_path("/");
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
+	if (ret)
+		goto free_soc;
+
+	switch (__mxc_cpu_type) {
+	case MXC_CPU_MX1:
+		soc_id = "i.MX1";
+		break;
+	case MXC_CPU_MX21:
+		soc_id = "i.MX21";
+		break;
+	case MXC_CPU_MX25:
+		soc_id = "i.MX25";
+		break;
+	case MXC_CPU_MX27:
+		soc_id = "i.MX27";
+		break;
+	case MXC_CPU_MX31:
+		soc_id = "i.MX31";
+		break;
+	case MXC_CPU_MX35:
+		soc_id = "i.MX35";
+		break;
+	case MXC_CPU_MX51:
+		soc_id = "i.MX51";
+		break;
+	case MXC_CPU_MX53:
+		soc_id = "i.MX53";
+		break;
+	case MXC_CPU_IMX6SL:
+		ocotp_compat = "fsl,imx6sl-ocotp";
+		soc_id = "i.MX6SL";
+		break;
+	case MXC_CPU_IMX6DL:
+		ocotp_compat = "fsl,imx6q-ocotp";
+		soc_id = "i.MX6DL";
+		break;
+	case MXC_CPU_IMX6SX:
+		ocotp_compat = "fsl,imx6sx-ocotp";
+		soc_id = "i.MX6SX";
+		break;
+	case MXC_CPU_IMX6Q:
+		ocotp_compat = "fsl,imx6q-ocotp";
+		soc_id = "i.MX6Q";
+		break;
+	case MXC_CPU_IMX6UL:
+		ocotp_compat = "fsl,imx6ul-ocotp";
+		soc_id = "i.MX6UL";
+		break;
+	case MXC_CPU_IMX6ULL:
+		ocotp_compat = "fsl,imx6ull-ocotp";
+		soc_id = "i.MX6ULL";
+		break;
+	case MXC_CPU_IMX6ULZ:
+		ocotp_compat = "fsl,imx6ull-ocotp";
+		soc_id = "i.MX6ULZ";
+		break;
+	case MXC_CPU_IMX6SLL:
+		ocotp_compat = "fsl,imx6sll-ocotp";
+		soc_id = "i.MX6SLL";
+		break;
+	case MXC_CPU_IMX7D:
+		ocotp_compat = "fsl,imx7d-ocotp";
+		soc_id = "i.MX7D";
+		break;
+	case MXC_CPU_IMX7ULP:
+		ocotp_compat = "fsl,imx7ulp-ocotp";
+		soc_id = "i.MX7ULP";
+		break;
+	case MXC_CPU_VF500:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF500";
+		break;
+	case MXC_CPU_VF510:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF510";
+		break;
+	case MXC_CPU_VF600:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF600";
+		break;
+	case MXC_CPU_VF610:
+		ocotp_compat = "fsl,vf610-ocotp";
+		soc_id = "VF610";
+		break;
+	default:
+		soc_id = "Unknown";
+	}
+	soc_dev_attr->soc_id = soc_id;
+
+	if (ocotp_compat) {
+		ocotp = syscon_regmap_lookup_by_compatible(ocotp_compat);
+		if (IS_ERR(ocotp))
+			pr_err("%s: failed to find %s regmap!\n", __func__, ocotp_compat);
+	}
+
+	if (!IS_ERR_OR_NULL(ocotp)) {
+		if (__mxc_cpu_type == MXC_CPU_IMX7ULP) {
+			regmap_read(ocotp, OCOTP_ULP_UID_4, &val);
+			soc_uid = val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_3, &val);
+			soc_uid <<= 16;
+			soc_uid |= val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_2, &val);
+			soc_uid <<= 16;
+			soc_uid |= val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_1, &val);
+			soc_uid <<= 16;
+			soc_uid |= val & 0xffff;
+		} else {
+			regmap_read(ocotp, OCOTP_UID_H, &val);
+			soc_uid = val;
+			regmap_read(ocotp, OCOTP_UID_L, &val);
+			soc_uid <<= 32;
+			soc_uid |= val;
+		}
+	}
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
+					   (imx_get_soc_revision() >> 4) & 0xf,
+					   imx_get_soc_revision() & 0xf);
+	if (!soc_dev_attr->revision) {
+		ret = -ENOMEM;
+		goto free_soc;
+	}
+
+	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (!soc_dev_attr->serial_number) {
+		ret = -ENOMEM;
+		goto free_rev;
+	}
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		ret = PTR_ERR(soc_dev);
+		goto free_serial_number;
+	}
+
+	return 0;
+
+free_serial_number:
+	kfree(soc_dev_attr->serial_number);
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	return ret;
+}
+device_initcall(imx_soc_device_init);
-- 
2.16.4

