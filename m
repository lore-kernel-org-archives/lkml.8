Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F7C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D42B20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KNG5NhrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD2J0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:26:42 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:29890
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbgD2J0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0JC84hgDombjTHflZJMT37pX9SYpX292/M24IOxmMPxC9Dfh2JnWmw3Ki8+ABVF9WsPUU+D+Y18P6etUvOWPp8teCOqDSBd7Qr1kX8lFh83G5zlRM0owa89BGzs6q0DcksTNyRQiReewWwXJu/haWZKKtZH8LBiiHXbuavne7W6nnKU5WBr/OSc/F7aLc+whuJvrBmnMnoTX6BiICvHbEfjA8kNgGPaglugqqn/iQYBJ5OZ4FRPJgEttj3E25Ja0HXABk85+iPBSm0G1D2FkHDaDsdIM1LPiBjb38IBnh0uW2IB7p/iJKK/bg4VAnnBXJSuPnT2cCwlNZhPgCr93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly5TevOC4Pu3HBOhVV9mLms+U1Iam9gwtmmrw2h2t8g=;
 b=KH19zXhjqOqgEb7kgSEiGP4HzInb29VdsEHT8tcyzRWsyKWquYJGcFZ+T+QZkvaveIxvSkYmgrWTmKpvcG0W1EFCBW1cqIWpcTmRPzXSgal1/5cxvv+BTb8TPiSlyipbldDJn2/wGz0+GKh5DdFJSITybyHrN5qlViL9mLDVBrX/Glr+G9/PzaHtNScvnlHHUxZnHmj+3L0OVawpDWS5H54jB8vJt0uZkm87pnRqBN+NnkfWECQjrex8IQLd8CjNh83QCi2uly4hpdhLXtOH7oOLIqJQh6E+h9x3vv+BcQezdLu5CiBOvrDpg4yhVPNoxXJSZzQIQk1td8h/owJCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly5TevOC4Pu3HBOhVV9mLms+U1Iam9gwtmmrw2h2t8g=;
 b=KNG5NhrIoFeGPZ3glyEu67AaHyjZpbuevquK2CNJZmNCkmD3pn1N56bB2dfx1g2vp6SPypvOFgch0DOU1hj/bZ4xcq8SM7urP8OwZ4ea4kNt7D4MwX+GWQm7Zgt1jUg+g/zwD3wRLCK8f/dDH53gaysJk6RND+/YS2uaU5g7V4o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2694.eurprd04.prod.outlook.com (2603:10a6:4:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 09:26:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 09:26:35 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] soc: imx: move cpu code to drivers/soc/imx
Date:   Wed, 29 Apr 2020 17:17:23 +0800
Message-Id: <1588151843-2133-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588151843-2133-1-git-send-email-peng.fan@nxp.com>
References: <1588151843-2133-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 09:26:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3911fcc-4a9e-4fa8-f9e6-08d7ec1f6901
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2694:|DB6PR0402MB2694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2694BD8BFC8D185A491B3B1B88AD0@DB6PR0402MB2694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(956004)(2616005)(6666004)(8676002)(4326008)(86362001)(6506007)(69590400007)(5660300002)(66556008)(16526019)(66476007)(186003)(36756003)(52116002)(66946007)(9686003)(6486002)(6512007)(8936002)(478600001)(316002)(7416002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiDwJ4f7h5dWjU/VLpChJeMn5trmjL0i5ArO0ADG6/5o7Gf/ohNzMqVZ4FKEj3vSbf01p99LLtEOrA8mpNNi13rwbiyY7TowqaA5LZNRpsDF2264udFzyIEW2fwAokKXIP3QRvQ1MpYBXrGM1HM4uzWfHuGpoo933Zzgy33iUCy4qBq/L3GO0/VDWlfDL87lSCSZwqAmasvdIxirDyE0Y3O3KhH7E+fdKzJ9foSlucgkzBT4FhkjkbWETtGsILekR0tXeuF+uVrH+koJVYNDMg72rkAr1/PeFhOgnPaoClm17dx7yhEtkQDAlQckq2clEJpRA8A8A4OjliNEQGGYaQcErdnYQ63xTJ46dvrMZfS0ASNjMSP2wQQess3pBUjMmq3Ew/a8HtOLrcwAbnx0fabZ0uvVQ0lvTp8Z+P67K+wQVSdC4z1TsdjnZ0mRQ4NeynEUuaBQoI73vVEL18GrLYuigyYK7DkKFFyEXowHPZ4u1cdik9wlMN1gRR9gX69c
X-MS-Exchange-AntiSpam-MessageData: JaUYQcteQpB6QzaZHeJ4pAFB+v28ZEfFRfYCO5olZdz5bzNyRdnKDmaTOLFMWpzzLbhjZnr8b0KxBtcKhmaVgIjbYV0SodjJ+faxVt92Rf7igCNFLHcK6w3FPtfQ15tMxmKQ2EPUTFQEq1QeKXZxZECaTMhcXol/EyBgd4SPfWkRi5iAFur+NPimaNF/1bUZ/lQbFy4Cbx62meYHJwKokbjAUOmxNWWTyvVNO/IQEGBs1VK3zmi4ozCznOiM5RhuAWqyaTRvXT7QfYzQLcx1XlljbqUd4oVKQyKBY6VC9GpfqGd1aRn1pOLk+BXwuY92xJgIry8W3GcnEuXoyeTOaCOWZDWRtHukS7B7wiJ8ECWnpvnA6A1EYdxq4Vkkw2vWWXaibrP3jyGdv4bDJRyRBen6cC9408f4oz10Hye/M1TB3QVboEYm7X8hNp3NyEAVg7yr3du1lgED0/E3XJVSXpRVt7rHRUm0SJp1LQW1NslamhjyrY2EaNRceHNcJjUF5yZwlbOe1uCFbluSMbUGFP0bD1PmC9+l0UrncqSrb8deGzoDS0TO9lha6aod6xtPs/riW2bYjD3XEX9tRQVX6OqKvm2bXfW7bMe5tOrbuIowCf/+R0ixg00ywosm/TPsmUWQiKFgmuIy6+y59Ta8JFSo1OfA5JVV2r0U0+gdIXLh83uAEXes2qT5YEGeW5dmLQoZWgDg1mdSVN/kHC+nmvoBEOyXc+cbSTyx/PXSw1ITs2wsx9R6JuArc/lk7DNatn6YY/bP15DFbvK2+/QifnHq9Pt0aAeuAEXSc2G6F7A=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3911fcc-4a9e-4fa8-f9e6-08d7ec1f6901
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 09:26:34.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sq/RY3+XBxI4zMJu0PL+hvJLuOtBQ6hLXZprVKxmYuqqoXyYwdR3xKcGClrcRGIBo6Dj1jrJ3nh1VHX3IxDyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Move the soc device register code to drivers/soc/imx to align with
i.MX8.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use CONFIG_ARM to guard compile

 arch/arm/mach-imx/cpu.c   | 166 -------------------------------------------
 drivers/soc/imx/Makefile  |   3 +
 drivers/soc/imx/soc-imx.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 166 deletions(-)
 create mode 100644 drivers/soc/imx/soc-imx.c

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 5b969f31c9e9..65c7224f5250 100644
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
 
@@ -82,157 +70,3 @@ void __init imx_aips_allow_unprivileged_access(
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
index 000000000000..70819e03ab1e
--- /dev/null
+++ b/drivers/soc/imx/soc-imx.c
@@ -0,0 +1,176 @@
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

