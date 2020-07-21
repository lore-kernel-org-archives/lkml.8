Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169362065F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZfVfqEYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgGUPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:20:46 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:28932
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729938AbgGUPUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:20:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Epwex0cbz6FpVGxWXBCWz0mU7EJzMyw26e4b5QKk5A/OioPeVORB3YmY+BrxoOgA8VJj3YfoCvFl07gUYNWn2/pihygnGdwDEtiKtUAgzpSNvwrplANmHHgn68MTxej3nPT7wtvtG6XUmbjdxu/8lFRYpgh4LLbWcrFQfz+UBPQ25bPq+6NXaSxoM27irtug26G1xO2lkEBjKlxpX7K6mCQ8MAdDUtB7nHNhcArmNP4EGUNyKsX0ip6S4Gwrs3xZ6OyAgElBK0gvXMq9ur0IO+E2Fo6f2BkYYNlHNKgOE0Fg1sE2W0qBxj1Of9ps82UVV07kN7BuaU+jZ4MWEKdJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7l3Pb/odbPMXsqAIfTFOAxgm+wtQB9k3oRVl1c5gxE=;
 b=khyUBkE6RHGM2Bp9SoUf+TdLnkBO5vsppYN8kLDn54PPATuqgHtEPUf1lnicCp/GaxmftJggIkHGjanGPgUMoTheRf1wc9/cDrVvOHDTBBPIcCPQGF6LoSIu4nIWix4jXssWh8QYWwNVfcJhZTi7WcDcqeWsbEryJ/q9BfQC5LsEMkbj4s5eWGpDytbSKbaexjDRSB6CEKe9rncRDgtPPYDxo5JSxAtC93PX2js2b8HR6VBcofEDTYk6S5r6zIf7zTMcqzdUbB/UQIbyovhpr4aiyx3HvY87vGmXUN861/Jd0UdQEqAQa8ACfy8neiFVVaXVDRUEscG9LYMeQ+O0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7l3Pb/odbPMXsqAIfTFOAxgm+wtQB9k3oRVl1c5gxE=;
 b=ZfVfqEYy46w7+TfSBUcVmjbALVMBBBaQv7ovvPAT5YKnvw1G+Jr+kA5h+y0eoKQJ/OEfSIAiOoa5zY04EYVePW9IBEyIxIxkT/6NB2N0NkggNW70XGD9eIGdpYTwB6Mwis/XZSLXBaZsQHGEi9bydwOYyFOBqzIG2XjNjZoSYRI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6212.eurprd04.prod.outlook.com
 (2603:10a6:208:148::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 15:20:38 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 15:20:38 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v2 1/5] firmware: imx: scu-seco: Add SEcure Controller APIS
Date:   Tue, 21 Jul 2020 17:20:31 +0200
Message-Id: <1595344835-67746-2-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 21 Jul 2020 15:20:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2b997b2-be4b-4324-ad92-08d82d899f72
X-MS-TrafficTypeDiagnostic: AM0PR04MB6212:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB62121EDF7149D3AA180DD591D3780@AM0PR04MB6212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XipSmdA+4oziMCyMRtMjvCH4IZWi+2NoyRmGQU9VvJbbCo3eD8+4NqF0QqwYD6aNHrBxMDprgHpp/xehkangmlt8vKFPuDkUYwZggafnr0+y8odKIYErER+EyHFA51uejYerOSRVeTCn1ySEOfUl0SH7CKJ0Ym2gvkdBQYMRmB9BVyz0+wvxa6NqnUkn02c5LBdRtw3DfLSEZrshTsbuPZsB/pZvEnhZwjXgSPJGZgv2fxRPdXBFbcpLsXb3RQtDMMOmGxTiuoER+SGIk4KpUFMK5oSiRyc0FHPeKwcUpESU7p6+y3pn+njGIP9SEN0lst3kyeNDF3lr3t5zGDQ15Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(2906002)(8936002)(8676002)(86362001)(66476007)(66556008)(316002)(6506007)(66946007)(52116002)(30864003)(186003)(26005)(6486002)(4326008)(2616005)(956004)(6666004)(9686003)(6512007)(478600001)(83380400001)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oKPimgzToylM74ky3IVC3B2dNcvXSkyMaKUWKykSYc77Wlh8ANKZcdLbbcD0u26HFqyPQEehvi3mbhN0Ilw6pUpR+TPSLdf6QFfUbgeNNhWfdT6kHPFPyzTo2o5EJbhRG7i1TnD6w7GahfU+vpsgtOEyjcFfxLwW4Nv4eeAsRBWuDrAl4Itets5T6Ay36IrgOUMKr8jShRPlpcus46zqgG2a+4li0YYDgybWeEs/SkD7/gdMKAyYlR/S2H1UVTMrfeQNIzOAFnM/6OJkugxqysQQemJV3S7/9FzE3gFuXl8wqzYNHqNCjuKZbg4MKn4mJ3Za8Q4xVVbRKniSkWvik1wSzgk1Oy+orFp6tktpRY+DygxRVTNzDowN25zkC53pBb98zRuVDVbqnnFcjgUGZYOiO+YjrmJjdQomQabZoIAIWZLlRoshnv11m0kdekyjRx83oin7l2qEdGTcIyYSywIA4tUO6CIavVnEosdjGI0=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b997b2-be4b-4324-ad92-08d82d899f72
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 15:20:38.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWgA/Or8ZgD8MSkKMCDmYgFs587kOnpF91hy1S+yuYWrZSsNtGtcuppXYQB/t6mg3HhlyRUe2T/tcX4LVZkDmWevInQGZ6SEecmEfLZ+WI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patch adds the APIs:
 - imx_sc_seco_build_info: get commit and sha of SECO
 - imx_sc_seco_secvio_enable: enable SNVS IRQ handling
 - imx_sc_seco_secvio_config: configure SNVS register
 - imx_sc_seco_secvio_dgo_config: configure SNVS DGO register

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 drivers/firmware/imx/Makefile         |   2 +-
 drivers/firmware/imx/imx-scu.c        |   3 +
 drivers/firmware/imx/seco.c           | 275 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/ipc.h      |   1 +
 include/linux/firmware/imx/sci.h      |   1 +
 include/linux/firmware/imx/svc/seco.h |  73 +++++++++
 6 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 include/linux/firmware/imx/svc/seco.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acba..f23e2b0 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index dca79ca..ed7b87b 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -245,6 +245,9 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
 			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
 			ret = 0;
+		if (saved_svc == IMX_SC_RPC_SVC_SECO &&
+		    saved_func == IMX_SC_SECO_FUNC_BUILD_INFO)
+			ret = 0;
 	}
 
 out:
diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
new file mode 100644
index 0000000..9047a75
--- /dev/null
+++ b/drivers/firmware/imx/seco.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ *
+ * File containing client-side RPC functions for the SECO service. These
+ * functions are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/sci.h>
+
+struct imx_sc_msg_seco_get_build_id {
+	struct imx_sc_rpc_msg hdr;
+	u32 version;
+	u32 commit;
+};
+
+/**
+ * imx_sc_seco_build_info() - Get version and coomit ID of the SECO
+ *
+ * @ipc: IPC handle
+ * @version: Version of the SECO
+ * @commit: Commit ID of the SECO
+ *
+ * Return:
+ * 0 - OK
+ * < 0 - error.
+ */
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	int ret;
+	struct imx_sc_msg_seco_get_build_id msg = {0};
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (version)
+		*version = msg.version;
+	if (commit)
+		*commit = msg.commit;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_build_info);
+
+struct imx_sc_msg_seco_sab_msg {
+	struct imx_sc_rpc_msg hdr;
+	u32 smsg_addr_hi;
+	u32 smsg_addr_lo;
+};
+
+/**
+ * imx_sc_seco_secvio_enable() - Enable the processing of secvio IRQ from the
+ * SNVS by the SECO
+ *
+ * @ipc: IPC handle
+ *
+ * Return:
+ * 0 - OK
+ * < 0 - error.
+ */
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	struct imx_sc_rpc_msg msg;
+	struct imx_sc_rpc_msg *hdr = &msg;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_ENABLE;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_enable);
+
+struct imx_sc_msg_req_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+	u8 id;
+	u8 access;
+	u8 size;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+} __packed;
+
+/**
+ * imx_sc_seco_secvio_config() - Configure a set of SNVS registers for SECure
+ * VIOlation
+ *
+ * Some registers are extended by others registers, they configure the same
+ * kind of behavior, it constitutes a set
+ *
+ * @ipc: IPC handle
+ * @id: ID of the register, ie the offset of the first register of the set
+ * @access: Write (1) or Read (0) the registers
+ * @data0: Data for the first register
+ * @data1: Data for the second register
+ * @data2: Data for the third register
+ * @data3: Data for the fourth register
+ * @data4: Data for the fifth register
+ * @size: Number of register to configure
+ *
+ * Return:
+ * 0 - OK
+ * < 0 - error.
+ */
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	struct imx_sc_msg_req_seco_config msg;
+	struct imx_sc_msg_resp_seco_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	if (!ipc)
+		return -EINVAL;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_CONFIG;
+	hdr->size = 7;
+
+	/* Check the pointers on data are valid and set it if doing a write */
+	switch (size) {
+	case 5:
+		if (!data4)
+			return -EINVAL;
+		if (access)
+			msg.data4 = *data4;
+		fallthrough;
+	case 4:
+		if (!data3)
+			return -EINVAL;
+		if (access)
+			msg.data3 = *data3;
+		fallthrough;
+	case 3:
+		if (!data2)
+			return -EINVAL;
+		if (access)
+			msg.data2 = *data2;
+		fallthrough;
+	case 2:
+		if (!data1)
+			return -EINVAL;
+		if (access)
+			msg.data1 = *data1;
+		fallthrough;
+	case 1:
+		if (!data0)
+			return -EINVAL;
+		if (access)
+			msg.data0 = *data0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	msg.id = id;
+	msg.access = access;
+	msg.size = size;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_config *)&msg;
+
+	/* Pointers already checked so we just copy the data if reading */
+	if (!access)
+		switch (size) {
+		case 5:
+			*data4 = resp->data4;
+			fallthrough;
+		case 4:
+			*data3 = resp->data3;
+			fallthrough;
+		case 3:
+			*data2 = resp->data2;
+			fallthrough;
+		case 2:
+			*data1 = resp->data1;
+			fallthrough;
+		case 1:
+			*data0 = resp->data0;
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_config);
+
+struct imx_sc_msg_req_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+	u8 id;
+	u8 access;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+} __packed;
+
+/**
+ * imx_sc_seco_secvio_enable() - Configure the DGO module
+ *
+ * @ipc: IPC handle
+ * @id: ID of the register, ie the offset of the register
+ * @access: Write (1) or Read (0) the registers
+ * @data: Data for the register
+ *
+ * Return:
+ * 0 - OK
+ * < 0 - error.
+ */
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	struct imx_sc_msg_req_seco_dgo_config msg;
+	struct imx_sc_msg_resp_seco_dgo_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	if (!ipc)
+		return -EINVAL;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG;
+	hdr->size = 3;
+
+	if (!data)
+		return -EINVAL;
+	if (access)
+		msg.data = *data;
+
+	msg.access = access;
+	msg.id = id;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_dgo_config *)&msg;
+
+	if (!access && data)
+		*data = resp->data;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_dgo_config);
diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 89105743..6924359 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -25,6 +25,7 @@ enum imx_sc_rpc_svc {
 	IMX_SC_RPC_SVC_PAD = 6,
 	IMX_SC_RPC_SVC_MISC = 7,
 	IMX_SC_RPC_SVC_IRQ = 8,
+	IMX_SC_RPC_SVC_SECO = 9,
 };
 
 struct imx_sc_rpc_msg {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 22c7657..914dce1 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,6 +15,7 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/seco.h>
 
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
diff --git a/include/linux/firmware/imx/svc/seco.h b/include/linux/firmware/imx/svc/seco.h
new file mode 100644
index 0000000..25450ad
--- /dev/null
+++ b/include/linux/firmware/imx/svc/seco.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Security Controller (SECO) function.
+ *
+ * SECO_SVC (SVC) Security Controller Service
+ *
+ * Module for the Security Controller (SECO) service.
+ */
+
+#ifndef _SC_SECO_API_H
+#define _SC_SECO_API_H
+
+#include <linux/errno.h>
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPC RM function calls.
+ */
+enum imx_sc_seco_func {
+	IMX_SC_SECO_FUNC_UNKNOWN = 0,
+	IMX_SC_SECO_FUNC_BUILD_INFO = 16,
+	IMX_SC_SECO_FUNC_SECVIO_ENABLE = 25,
+	IMX_SC_SECO_FUNC_SECVIO_CONFIG = 26,
+	IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit);
+
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc);
+
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size);
+
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data);
+
+#else /* IS_ENABLED(CONFIG_IMX_SCU) */
+static inline
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_IMX_SCU) */
+
+#endif /* _SC_SECO_API_H */
-- 
2.7.4

