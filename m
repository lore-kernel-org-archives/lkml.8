Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D37421582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eb8icTg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDWHIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:08:35 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:60663
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbgDWHIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGpsuvk36CniBlplmQtE7ZLDJmFOZs3/LkQcPmLtuNDx7tb89ctJx6oOfXXkjLZW7RY9g/VmbiuxBrj2oT5EPUzPBeggLwNBoVzQmzfT8gF7RfnvHrciVSmfXIcp8TJGeQearL4WyH3qBTvlk+rZ1+8QH0DbDFil4l5U21C02l8qKH18wueMjhvRpu/3GK/6Sv8bn2sOgrkUqli9llRfUyKtOpYTu9jexQRlcBImtwOO4vd9OCR83rX4z2bv40TvcrkODgX36YcVekA7R43zQv7Ey/AaZbeA7W17rs3YPfXmhfF26yDhlQbmug/HcAp4Ed7WijplNqr1id67XeHbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zOy39rk5Xge0p5JCMCrKXCRpmTTvNYyP9zXs1h67S0=;
 b=eM28EIVxSiVy5yjNLcfN3ZLccpMfL+FWAjN+OAfFvoTFwmFeRj2ws8ZwJWux1/yPARv7+8kwoRzir3ft4jO4OuAFS/AmwqWOf6ZrFnFTwUccp12H1qbVV/KRbsECVjaSznsXq/aOsOFAAvloGBOEaQYHyO2S+r1FlviaaPSp0zwRyBRfQ3iBQut4kz30PLi0iy4QUPhjR/KLy4cA5eW67swsc2pQh+pd+wwAdJjr15RD0S70zAFXEja/xYR0AEprwcixtRgF3oaUOIaY8qqUZCO8tj4eSdwF24QJsYu3N6L8EKzZsp28oEbAokyPdQO3KKvwR3GKV2wcrqdt1tLV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zOy39rk5Xge0p5JCMCrKXCRpmTTvNYyP9zXs1h67S0=;
 b=Eb8icTg4ig6Q7upnutAGDt3irUkWH3K7drVpeslarKwdPHKZnSNJ0Z+kUQAPQLQ4+swTXmJv7FfdfQndZ6lX1bWY+a1g1mL5czH3pgW3nbi/aVHe/hf0sG49t77tkrWZnyeNOTNQDhEFPpaS7BDm8afwaVuME0CtkFhVdgmRGcc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2855.eurprd04.prod.outlook.com (2603:10a6:4:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:08:30 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:08:30 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] firmware: imx: scu-pd: ignore power domain not owned
Date:   Thu, 23 Apr 2020 14:59:33 +0800
Message-Id: <1587625174-32668-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0149.apcprd04.prod.outlook.com (2603:1096:3:16::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 07:08:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34566bfc-f4a8-4085-3e6b-08d7e75520cf
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2855:|DB6PR0402MB2855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28553DA623358C5E41AA042488D30@DB6PR0402MB2855.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(66946007)(4326008)(6512007)(9686003)(66476007)(4744005)(6486002)(66556008)(69590400007)(6666004)(5660300002)(86362001)(8676002)(81156014)(6506007)(52116002)(16526019)(8936002)(2616005)(316002)(2906002)(478600001)(186003)(956004)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/FLOqmoVcj1Q/So1zFlyKRedji74htY1IQX6Nxnz6Qb2cUURINigPEirpBuQaU0SY4fr+rAeA6QQIGRGuyAKiCv6wGkiUVHOXVoQv3sJjCTAXlqEXk+GM6RrmOsneXezBoCBdsR89hjNrZl2X37i5QUoRTHqY4M99r+n1sMzCXi8nlI1Z/MwVnlgQZpWPRfEWDwx0ZuVpzc+ew3OdGaofFcFaIiksPIHIYirAoqGeUIOGiGFQ0ig5k2FZ00ppcoS4tLmElz7iWKmibGzqFfUMQszF78s6JPbkKiknKcyigAlt+5lmWvPn2xMCjvXZpcUBqaTRjvnZyo5Eo0kgFfi4d742XpWzEtwGUoGtbBkVj6pUynGsnpdubbiNoXFUTnTczzKdeZgC8lz0PYhX7s4payHABz676zJPR3KDQRKdqJVhwSkAqWWvsZ2V6XrbiS83BYzONcqRv23ZKYb0R7ZizPZ/CjM5Au4H+qZjcVFY6xLDqKmls1hjcmiHeX1sc6
X-MS-Exchange-AntiSpam-MessageData: vknaM7/RpfCgS4GMAjp9Q+LJ9wqpOVCg9pdHsviqNXFXoPxgYzG/LeArwCXv8xflo3a+wU0cK0IWxn+JbM0G7O8muzQVnR0hZdj7+xOdkvDsrGjKYA2kAwHD4FR+OnGqb5cGA0oeC+38JETExXIWyA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34566bfc-f4a8-4085-3e6b-08d7e75520cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:08:30.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgmhLamEJZyzXGgprYllFy5/VOhOKybT8OdQHPY6hzEdCL7YnltsoAByM8JEZ2BNsVlMaLsvTpysOjHmkc8wkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Should not register power domain that not owned by current
partition.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index d1b313fa7b96..7b43bd63cc1e 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -46,6 +46,7 @@
 
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/rm.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -246,6 +247,9 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 	struct imx_sc_pm_domain *sc_pd;
 	int ret;
 
+	if (!imx_sc_rm_is_resource_owned(pm_ipc_handle, pd_ranges->rsrc + idx))
+		return NULL;
+
 	sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
 	if (!sc_pd)
 		return ERR_PTR(-ENOMEM);
-- 
2.16.4

