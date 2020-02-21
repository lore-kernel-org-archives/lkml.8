Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A046EC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF84207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pOlGpCCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgBUCjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:39:10 -0500
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:54027
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729259AbgBUCjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:39:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLV0/hdYeoUAB1+y624pw8JZi6tCOcL58oJSuLmZJe5sVhmqcD07OwHFloV4htI48ZSyNhG0xLWf5/MO2X3biQ2+mB4Pg0PtUkwJWm6Rx91E0yRVjHAaIFRTy2mMChHhQlDV+9tRQTQd1Q8o8LKt6tmO3ItCs3li1AMKFlj2p6crXqhvCnCrP62NTqVlZw4IwaSpwouSKjg8Wbx+b53VP54HKYhMkoaVhpoUrtOgK6IWRMTSQVroHtiS5bn9gfCersrda3uFrZY04inF4mWA+mP3tC5rrfFjnwgaFFGxQGPbjAqa9eNC2O9L0nrG8O5M1f9or6XlTWFLXllEtvjCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pHpzxEIbDKi2Xx5kdCK1RS4J/36DfLqAvV+tLY9f1I=;
 b=Ei1pnIRyBObs0tC9O6fNjgS3JeIYGnkW7bc3GvGlfvQasR+kk4sM1gK8GfZdYodLtHwT71ssswfVlFKLaVoP3ROWBsAhuozAYyEYlB3p/1NJRaAQdZt9b6jVwMhn4dLK9ESguRS6EuqgYdnlhetPLCVk5bCq3TrRzzZ1TxFwvttMNvMtfv7LXlawNhCwyi4Oerdm0R8ES8llnL8Vh9yHyt6am+ywGIV4c9oc+8N69X7n398w5dz1rCRt/03n3XZUYnxBeIkM5C+kAyAK8kAPATt4f+M9j2HgpOdQ5hBB7S41XorTy+ITQw6o88vcOKPOdMm3O01/4Vq9LA7vnv44yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pHpzxEIbDKi2Xx5kdCK1RS4J/36DfLqAvV+tLY9f1I=;
 b=pOlGpCCwfD/a2e7PugDOgjzNE3nV6dq/DsaC30XRkxPt2IMGt/YS+yySG6sa51S0TmAFbP1UQljCy5rnCtlYv+WLl4xlN5RymQsdE9hQbd2g8Cfyx6/uJ8TF8/i6EooKB0XQfQdNgiXD75qmufADN3lbpL5vXMoVn8KjOSWTFIc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (52.134.89.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 21 Feb 2020 02:38:24 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 02:38:24 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        olof@lixom.net, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 1/2] firmware: imx: add dummy functions
Date:   Fri, 21 Feb 2020 10:32:18 +0800
Message-Id: <1582252339-15733-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
References: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 02:38:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d75dcb9-c7c7-4d62-d080-08d7b6771f47
X-MS-TrafficTypeDiagnostic: AM0PR04MB5281:|AM0PR04MB5281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52815A54BD10E6614419595788120@AM0PR04MB5281.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(2616005)(9686003)(26005)(4326008)(956004)(478600001)(6506007)(36756003)(5660300002)(6486002)(6512007)(16526019)(8676002)(86362001)(8936002)(52116002)(69590400006)(2906002)(186003)(66946007)(81166006)(66556008)(81156014)(316002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5281;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlGIXc2fupVgG9aHsM9c2/HOGkMQvE5iDr/twPvxqzM83IWYK94CP6U5rZgFwLZkem0sH+giiTW6nfjuW8P1vVFllCAGtl9JkFxPr/A5bixbOGRZIVkLtkrxLy3LaHnnpl6HY5fSvYgO46KSinCeZ3f8Nt7LyrXS3hXrSFqbDUQ7LSLoEDVPQd+y0Co8J1/5bDGX0YXlC77JM5H1OnQmow2xbnpjALFvZDJvcj3Bh1Mf/uSjOlrdrLVXmlpuMGlU1DIXVNPAqLoy+e0By8QPzyoHBvPL5Jk52t6i8GnJZDtn7iJn2DrplAq6UP3wIdmQTcAhgDMrF9z/qoZh8We1H2VFiUvG6krK+ww7OBhcRIe/T2Xr7VCE7EQFXWXsALk7HrQ3nTyCd3vQru7kS8jVpPEcgwRcfnVNdZimHspW7nRj8Vccjw+JiYncFzJNlGeVSWi6LAtW10VV1PcYCxjk7AfPwJIglM0LbM+GEOpqtHbldt/dyU1rUVDv4N7/CFzNFL5C+0QawgF6F3vk6TR1Lw8axdFYGfMyFNEznICxc2Q=
X-MS-Exchange-AntiSpam-MessageData: S04rmBY6VoneMLkxg4OlS4ZMNLgzeU8//g57muue28C7ytN8nJY3v6tOKkVTpG8H+zFKi+PDwS2HYv6ZlVTmZPeCRyLbDkg78XNkHVR0KCxq5nt2lqbE26GjXSl569oSLYcpUXdqGWuUGNVhUIdXsA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d75dcb9-c7c7-4d62-d080-08d7b6771f47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 02:38:24.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5y7Ax4UvaMPdggOTzs9YxbG/CUdBWumgI1wmC2DUsR8JAU1ZNtwf6K1ND51egFcAaw4kgkiYawDOWzVrq+s/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
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
index 031dd4d3c766..760db08a67fc 100644
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
+static inline int imx_sc_misc_set_control(struct imx_sc_ipc *ipc,
+					  u32 resource, u8 ctrl, u32 val)
+{
+	return -ENOTSUPP;
+}
 
+static inline int imx_sc_misc_get_control(struct imx_sc_ipc *ipc,
+					  u32 resource, u8 ctrl, u32 *val)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+				      bool enable, u64 phys_addr)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_MISC_API_H */
-- 
2.16.4

