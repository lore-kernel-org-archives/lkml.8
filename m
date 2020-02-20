Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B6C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4651208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1Kz0u+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBTGbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:31:05 -0500
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:25925
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgBTGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfj2HIrmq3iIDPFwDCHa+grtCt36Ww3zYrAScxcnPAZgYLuEs92O/XX6cu8Xn7njtib26aU2jdxoqh/xtVEa4DKpOINh2DnumIMDxeMuXDh0ovuv/ETod1tvmdAf2im/UhDEKwszLY499PmH6Xtslmc/Nlp8fjN509GNCpqxHPQqWvZD6OGlxnSKhKuckEz6ds17BDZlSJ23/inLyrsIHWTgngXdnnd7TqaDJuXPyRU6vrd06b2hgotSShdBu74FGtp09Cnx8NzhIF6twp3bQ49mnajyq+WUR1Z5faqHIm7o9//qpD7fKqOLncWwh9qxikipeIHKK51LXa11KqDzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uE/QSC0B3WORImci7u2ZQ5qpDnJiJIDHvsx10aHPIw=;
 b=Q8+iRrC4kvNvPR7sbQRQXDl1+hQ6n2348DnZwlPrzIdWQZnMaaEcYBS51j4pRaA11f8L8GLVwN0T4mm2l/135VRgk+e493ZhRfJrh9hiBxBSmILBZlNgqqv25XmiOX8YE+Xcn2r85boKgAFzdsaXEt4ElD7CYtkVcX3cR4B6myBdr2uRUAZ2pUHcQSkuyAVcnd3CVa7CUhmRMHbICN9R70BrH/3hoG/Tqd4nLFVAq8EiJT/Tbb/wB2wzvjtzd6xDD3bpL/+tF7TCdCQpPrkcjpaI1TaXvOvJZhgPkJ0r6frBIc5COKpLLpENWkoXnbE+NeNhMm3xFdVr9bWWx4fluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uE/QSC0B3WORImci7u2ZQ5qpDnJiJIDHvsx10aHPIw=;
 b=n1Kz0u+zfHvpQaeVnsPeP43J7gHkVulN5lkdJdJUdVVobyC5n1mEb2s97C6ea3xO0myEJPi/jKdy/3aJJt8ps7mkro+lZ1HFjb3SRkAgXRGyoZ7bZ70fQESyag2heIW+fAQ2OhtDWIkA6ugMnMtRvDp2KUkxhBSPCL8iplj1R1E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4860.eurprd04.prod.outlook.com (20.176.233.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Thu, 20 Feb 2020 06:30:22 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 06:30:22 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        olof@lixom.net, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/2] firmware: imx: add dummy functions
Date:   Thu, 20 Feb 2020 14:24:02 +0800
Message-Id: <1582179843-14375-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
References: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 06:30:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 272da3df-0224-4a6f-56e5-08d7b5ce5d12
X-MS-TrafficTypeDiagnostic: DB7PR04MB4860:|DB7PR04MB4860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4860C4D565B75CFE8CB1C73488130@DB7PR04MB4860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(8936002)(6666004)(66946007)(66556008)(66476007)(81166006)(5660300002)(69590400006)(81156014)(8676002)(6486002)(9686003)(6512007)(4326008)(36756003)(478600001)(2906002)(86362001)(2616005)(16526019)(316002)(956004)(186003)(26005)(6506007)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4860;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHLKv6lj31z0SIfXnhcv3A/V5OyJxTxs5BgX4WTT2NA/2c9+tvhOPUlnWYP4d76cqUBGC/vqapCkAERPR+iigcJQFbXnVLomeoWaD9g7HaBgCd+a5AOgy/cCK6y1z9t2DVhZZ39+7GVgYdxajTmsu40By5UbRmUwiyx/F6zZrNlxelI3bDi0BzqNcrRGWGwp9c4RMFkkIhTjPNWluayelpykRMnbn8nWLGVogY6NMerId9ci+N5322EHDZWhpddAY9RtCm+0RT5Lg3cYeUKJVTV6iPM2Ooy9G8Y97qYhxYNB3DmUfZuQGg2qPUEoZB2CZpVFud7u8XAP4F1ltxzXEl5F0PvJzod9ZR1OLcyJ+an0ICPP/ijskg4VFa/ZzrDio0lKRLLJVV0o+ZwJPX+ZGxxNM7Pr4gv4G2pU0swLtL+t+C+g3CEINUZRwnTo+LSdPNmfprt44eO9vemnY/XGNkSC6MO4bWjXQ+TDAcbxgslI13UsZifKZ0ZCy7zlnEJdDVDDM4a8hcB5Qt1rD1SwwOYy452dd78f8MyC7dOzjoo=
X-MS-Exchange-AntiSpam-MessageData: J9/Lb7QdictPpTt3xRJ9f3mwIGurD9vLKnCFEVX9zy9G3Ldetx1JBNxeLO4qxCgNm+SOwgk2DVArIDQE2dnJ11JigjrEgua7UStjS4nRwOYq5sV7VxFsFG68ErJiEUexhhznRJug++V2QKpEAollMQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272da3df-0224-4a6f-56e5-08d7b5ce5d12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 06:30:22.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4Oz2QaiFGHTDdZLkm5U3+WNzQOWShD817LEPvQWj9wKqEsBQ2wJFoptl/0Mr80OX5HQcriLBGKCNH4PjOenQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

IMX_SCU_SOC could be enabled with COMPILE_TEST, however there is
no dummy functions when CONFIG_IMX_SCU not defined. Then there
will be build failure.

So add dummy functions to avoid build failure for COMPILE_TEST

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/ipc.h      | 13 +++++++++++++
 include/linux/firmware/imx/sci.h      | 22 ++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h | 19 +++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 6312c8cb084a..30475082f472 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -35,6 +35,7 @@ struct imx_sc_rpc_msg {
 	uint8_t func;
 };
 
+#ifdef CONFIG_IMX_SCU
 /*
  * This is an function to send an RPC message over an IPC channel.
  * It is called by client-side SCFW API function shims.
@@ -56,4 +57,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp);
  * @return Returns an error code (0 = success, failed if < 0)
  */
 int imx_scu_get_handle(struct imx_sc_ipc **ipc);
+#else
+static inline int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg,
+				   bool have_resp)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_IPC_H */
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 17ba4e405129..7ea875b186e3 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -16,8 +16,30 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 
+#ifdef CONFIG_IMX_SCU
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
+#else
+static inline int imx_scu_enable_general_irq_channel(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_SCI_H */
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
index 031dd4d3c766..3f4a0f526b73 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -46,6 +46,7 @@ enum imx_misc_func {
  * Control Functions
  */
 
+#ifdef CONFIG_IMX_SCU
 int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
 			    u8 ctrl, u32 val);
 
@@ -54,5 +55,23 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 
 int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
 			bool enable, u64 phys_addr);
+#else
+int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
+			    u8 ctrl, u32 val)
+{
+	return -ENOTSUPP;
+}
+
+int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
+			    u8 ctrl, u32 *val)
+{
+	return -ENOTSUPP;
+}
 
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 phys_addr)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_MISC_API_H */
-- 
2.16.4

