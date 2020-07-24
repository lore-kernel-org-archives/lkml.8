Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C3C4347E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDB020767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxuG2qKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgGXHoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:44:01 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:26464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbgGXHn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBLMZdQNxOvzteK/H+gE6T4pg65KA+hYX1fNRFyhAuZMTVypZBnQaDLQbt+oz5CKxAK13EYeCqklrVgXXWSn/SpR+QMBVxGY25/g1DTM+o3u/ApQIqKGDq9vtUoJwT7qAv0Lmstcx0JEG9jDfRdfc0ECSzbBfVcilt6nGcEx2EErjpDgmP5bH9p2Abrpy5G0439lR5JSxZ4lzUlCbiAn4NsDgoLZC/iBnCpeM5Hk+6Jv2gE/dLvy9UkO7XNCB4lepuuHW78e1+JkMtXNvK1xddeRiliscCGA/jRMTjjurmuGqCIFFoBd8YcB7lq1/5ux2Y17cshUVQC43UFt1PpitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9PER7tJVHanuJZgCm9ErNp4Xtl84HfXSUbuBJPMqvM=;
 b=XxL9D67GGpTahHdvHIEnv4Dg5CybLK2a/ghpKBh7NxCYmvVOivBmVoujEGcS5nxeUVvG5qXDuz8ego3+18yfg+VEJ1uCBNEwgUdBDH18rEyurXVdbZewYmzdY8mNBRrWeMUW11viQRP8bZz+IreMxPGfYvF/BB1wydUHAD2TOJ9U1nGuLm3Iwx6OCDDWHgbYj6pfCysRfYAxV2DirOQwBhwnJCnkvDHTiRppcJ1dw81xh2SZKc7/EVSHXQZKxYJwDHzMMrNCDBZvKgzPj9NbO2y/qrV5HoxQULxmTntr+r9TsUdWD6bclFwIMYvFshv/ZtZ2P+8BTLzKRnKIn0WewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9PER7tJVHanuJZgCm9ErNp4Xtl84HfXSUbuBJPMqvM=;
 b=kxuG2qKCU2MZQb7aqj2eXtnu4WxfOd78e/vfEBsBbSeY7op/jYsm9vcwoPPClmDLbGyDvXVYzsc3Dhb+2E5kwYyURNJxRkLteHPPfL4Mwz5rNIPXI8te/5n1//XYiStp6oicRt6TKY1sJL4qgZk8+IHKrNYlxasCiDko9Ai5530=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:43:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 06/10] remoteproc: imx_rproc: add load hook
Date:   Fri, 24 Jul 2020 16:08:09 +0800
Message-Id: <20200724080813.24884-7-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:50 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09efdae1-9660-43d4-4047-08d82fa550f1
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858449761DECCE66B7D09FC88770@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2eVnLRBXqM2usHHpmO+CDx5E6eZTkI7D8jvuDEPe5MeDFaRSFichJM1HSELAr1Cap36j9LFEhB3M7roub49JGVZwtQwgsqCu3ztOG07fqNKhDwkXV5AjjQQfjDb/DLO1EUlILJdpdLeLPblbAKZ3EWCjZULmxm4nKLYCwUUJyI8wC42KCln/U2DIGeSMY6n46mTsjDTyWlIwZWCCSWEP3/6wmQdsPcHwv9pxc6VETlbXT+FfO9bfrIN1Hgqjn97meKW05r/AbW2bl/rLNA1wx7ghhAalTpvrEhErTwXlKaHaVTFkERTiAAUDIo0J6omo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(36756003)(478600001)(1076003)(2906002)(6666004)(16526019)(186003)(26005)(6506007)(44832011)(956004)(2616005)(86362001)(6486002)(66946007)(316002)(8936002)(7416002)(6512007)(66476007)(66556008)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bQisqhNZcBXoHnrt1CeG53YrUuBqxIxwOHfytyrQQgbJlbPZPQdhN2CIsU9Wt0nlM57bgSf9q2FgASRgWhGwBJEkBCidZAZ+SHL2DMN/gOMnUpZHuS4WVr/06Z8T1N/sKGpiaG8sX8k1e80JKQerPAOi0/wGuwnp1yKBDcLLuOpiRFLhNctBw5Qn/g4nfgYg2DbedgqHAADt0xWDKryMqyrnE/FCLnM/59wASZO0V8IE2cejU78VowLjLANfe8d36tikTCmB5x5Lm4oIxlE92nUCiwgSLBdoimAm/PEvWFZS0KNikJCcvGotecjidB1RJoPSLmQc6JbBmT3/H3EOA24keWbHyZDP7QxFnzZuMFjVEW2OV6b5xKHvzuIAMCgAIVf9WnxJ8REsdI71722aHy83rLeIb6KWRklMQlJDmqQOB91Y1ZLaK/xik3RNiNZ7JFFfRk3jiMkZAIFxHHtOLN/H51u/apdUNeyz+zEsZoc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09efdae1-9660-43d4-4047-08d82fa550f1
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:54.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18pW4hA7DfvczYWr/Fc+gzcqS7dJ5xipyYvG50SpDGu5T02XsvSszVtoSpxXp7gO+F2SkmOXkVE1L91IsXJkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To i.MX8, we not able to see the correct data written into TCM when
using ioremap_wc, so use ioremap.

However common elf loader using memset.

To arm64, "dc      zva, dst" is used in memset.
Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,

"If the memory region being zeroed is any type of Device memory,
this instruction can give an alignment fault which is prioritized
in the same way as other alignment faults that are determined
by the memory type."

On i.MX platforms, when elf is loaded to onchip TCM area, the region
is ioremapped, so "dc zva, dst" will trigger abort.

So add i.MX specific loader to address the TCM write issue.

The change not impact i.MX6/7 function.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index aee790efbf7b..c23726091228 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -15,6 +16,9 @@
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 
+#include "remoteproc_internal.h"
+#include "remoteproc_elf_helpers.h"
+
 #define IMX7D_SRC_SCR			0x0C
 #define IMX7D_ENABLE_M4			BIT(3)
 #define IMX7D_SW_M4P_RST		BIT(2)
@@ -247,10 +251,82 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 	return va;
 }
 
+static int imx_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	const void *ehdr, *phdr;
+	int i, ret = 0;
+	u16 phnum;
+	const u8 *elf_data = fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u32 elf_phdr_get_size = elf_size_of_phdr(class);
+
+	ehdr = elf_data;
+	phnum = elf_hdr_get_e_phnum(class, ehdr);
+	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
+
+	/* go through the available ELF segments */
+	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
+		u64 da = elf_phdr_get_p_paddr(class, phdr);
+		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
+		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
+		u64 offset = elf_phdr_get_p_offset(class, phdr);
+		u32 type = elf_phdr_get_p_type(class, phdr);
+		void *ptr;
+
+		if (type != PT_LOAD)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
+			type, da, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
+				filesz, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
+				offset + filesz, fw->size);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!rproc_u64_fit_in_size_t(memsz)) {
+			dev_err(dev, "size (%llx) does not fit in size_t type\n",
+				memsz);
+			ret = -EOVERFLOW;
+			break;
+		}
+
+		/* grab the kernel address for this device address */
+		ptr = rproc_da_to_va(rproc, da, memsz);
+		if (!ptr) {
+			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
+				memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* put the segment where the remote processor expects it */
+		if (filesz)
+			memcpy_toio(ptr, elf_data + offset, filesz);
+	}
+
+	return ret;
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.da_to_va       = imx_rproc_da_to_va,
+	.load		= imx_rproc_elf_load_segments,
+	.parse_fw	= rproc_elf_load_rsc_table,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.sanity_check	= rproc_elf_sanity_check,
+	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
 static int imx_rproc_addr_init(struct imx_rproc *priv,
-- 
2.16.4

