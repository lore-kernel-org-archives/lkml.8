Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B97C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410AA2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a+gRClzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgGTJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:42 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:30692
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbgGTJGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2k/NP6/ytntMLLk3pJ5SVBdORq3/5fmYxBpGGzTtWbwsfLQtlUzZ+VzmKhdyqIMmfj+z80V1RtwY4SlAcdk1kiZLn2GDDnxdZMF1F4yOWU0+QbnM0Ph5Y26Szt6kHgf2jTYzyTvS/Q6sfw7aaJgGVZ4Z3xjm9coOVXiAq86G183w1dI1Tw0/A9eIO5n3syf2j3Eyk/Z/793Vpds8Cyd0ZSgapvRYBRqE65pJWBsLDEH/28qy0q14jSq4ZztPMSmibqa5ziYcJN4G0gnzGRRyF0h3aQV9nN1N7OrpKtaPvPwZ4WLB0YgMLTxezous30AKNYMuGuXbHVa/05ezbo/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+ANOC2LZJTXxvGYCfV0qUVXAlifzQ3rb1vOIbg9ddg=;
 b=nZwCjw4ll6gt6nAUWKhgMiSoCmI29hrtmI7OFc5MlaUUPDXPSh3KW7uxpP11KoFPB7XbnPPGMWVxKuXUXB9oqd6ae8FywT802aoRzMvhEHOBDc/8BXZx1IxHa8BBD/GlRk8R1JLbqJAm+GyqLzR8Pq0KbvHXVJ4Tt1F3XIfqJXOiVohElqmB12cbBRqtvvGqQ5FMp4KISlfOOVyOABKhv1AEW4JzuQprAek2AoF9KJVAWtBPuhIaxtbhCxeV0uspg4uKgVXJcjQS+2PT+Z40986bP7B00eV+0WnvyWrpgjTTZFYmy9IJ4h+FVMuTn2nUDr417rrbSBKDbSksS8WfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+ANOC2LZJTXxvGYCfV0qUVXAlifzQ3rb1vOIbg9ddg=;
 b=a+gRClzAvRmz4ISxervFJ1NK41pe6XrN1aL+Dd6Qq/llIGrnB2wPNTvA0Pe/i6T94DR2oPzTguEFfw20iyX2K+UchkeWBCl4D71xMLqfu6Ey5tFODBmGH+qS+w3jV9Kj3/Ds01jV7h4aEwWk9nc3urZ0H0WfvR51km5V/NcbmVY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:22 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:22 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 3/7] firmware: imx: scu-seco: Add SEcure Controller APIS
Date:   Mon, 20 Jul 2020 11:06:13 +0200
Message-Id: <1595235977-106241-4-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fc3c465-a325-4b9d-e14b-08d82c8c2c40
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3762707CB78FFAE0E26AEE4ED37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+bUWxVyB1t6ImJg4OQN04zm2sURxfQakLkA4Z5mV+GpTH+OHZTyYGJCVfvr0XDZ/5f1FgJ1qmssknHqk3KWGa2/bN2lRoFWz9KZUzNvPa7XTcP7G5M3lf3GglEI/2/ivmxD86OWiS+2QuAkG4ZFJGfCtSZEoBoqh8kqP0h+iPGKooLDy4G2uRmoVdcDMbZn0n74CfFwoPppF/1N2a2b8r7niimSQ9iimc9rm/An9qBRFtDEiT/qbajhFYbDd6W5yFRMbJEAeNMP+5naxMr14Z7xqHVar+lzOFIcdoyHqPOA4FRDavACAFjI7Kn4DMuAJOVEFlZvs2b94nf8V/4/2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(8676002)(30864003)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(6486002)(478600001)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AHFFE5Ig6Yb2PedJQ5HCAL+lm5ecD9pgsulxXDgp6caaPW8sau2Vllcm7LJyeigKqEzbQIyXnHEORuzMthcjmN7V+tlqHZCDJA62vpr2b45L5BGA9miJhAVa59M7/2OLQZoy8RTj8Iaxufcc+1+z8fTlP0Ft45tUb7mXy5iVUM81avD5tZ/ZjcaVbbloHVXISwPH4glq+4jRi55XARyb30rdAhQDrBdvN2993DA75KzuB/GmEG+RcoCUvu8fvCqolIvnsMcxGSKZq0RWq23yw7SrrkdvE18dhU5o49nPgqGRyCuh3Wg94exGIMosCQgoBSHXeTHnfIjFfsEyvmZHzC9lEauYSmLiVL9Xr+EQmoOnPpN/dOmi+bg6vN/QTvPJOINpqLdhsFwNeYQffq3fXKmoGUEB1h9NDVFSdr7GWhCskcHZnaJOb4f0p24TuoJT7JTjjl9bwU+ivSAtgkT05DrLdWROgnaIcMiRORB3PEI=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc3c465-a325-4b9d-e14b-08d82c8c2c40
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:22.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZedQtEZylUHnHdLvlDnyXGIQsfgmEUC3m52060WDzDnAD4vLLkAWUQSOd6bmnawgVdbzn9TCLQENhVy9Ux00mDGp5ASTtpFvesx2jkBUeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
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
index 17ea361..d522de8 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o seco.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 7c13595..94576a4 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -254,6 +254,9 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
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
index 00000000..9047a75
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
index 8910574..6924359 100644
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
index 3c459f5..97245e5 100644
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
index 00000000..25450ad
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

