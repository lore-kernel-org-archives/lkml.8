Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81975C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D9020716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CULjs+MI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCLJJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:09:08 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:6129
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgCLJJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RChnQ+SfiMQzscqGQ+/3IQLMyNfsOvlaCWWOU+p1Wn1gIVgVEyHADIhUXk51wyMG4F+2YlsQtMBrUfRqci1cu2qKyBHssG6/YR9TO0jl9dJCvlWbEOzwgT5KVil/aIRioB34q58AeErJkXakaqFDdsWTse6Z8G4MDOsNI1egSuJgPu2JCmnPAg++ROWapWW4HmnCUAXXZ4h95YVZm9kpvA7r5Fjm6eu8XpN1YuRMbqKrBeHWtFxs/EjbrPAkv9yQyTUo2AuVG6axRBbzUROEQYCNgIlRVuY6RJdK9UebXKiGcXTuYOSlx4CV8RPDHrMJNcwoRQznSx0sPUmA1PBWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmiXlFQ3dGb4nFSU8nWLTwcL1z33bug6yhy5/CqzBjE=;
 b=oMH1UhcA6LFzggMerUP7mTk95Jp1ckKHeX1czFED4z+l8C7kCGLQ4fqfHhhSef4Jd1hLVwk74sDSGzExFdWZKTlcL3wPBBy5Vq5XitFB20TxJMuM9ApOdpJfsB2r2DLuWEeTWJXBlf9NJkv4tt+lIyrU1S6dPDBWLjdzSN8O9EYW/JBqA3czWrWr9mesBi5uGMwvAb9j6ddPUGQ1ibjHClqnEj3tCbFcVSF+IIQRVZI80JtDS4cH7B/e2NmOTm9aB7szxl1qYDuX6O26fqtS3EHbj512cFR7h+8ka/d/05dEly8FRELzWTkiUooea2QEunzU2pSSyAqWCnbr2CempQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmiXlFQ3dGb4nFSU8nWLTwcL1z33bug6yhy5/CqzBjE=;
 b=CULjs+MIXWemIRuPxR36GBHuA/i01esWlvhwaVXgMFTr2VW+pRT+bFTuYlmYczZTVI+WUbd0EbLyCGQBapIKbK4pXwUIfKe5BIKvVdCWGUYBDwa6Mbp+a0uWg+mtLUZrC9xRyGTrX9TlH+Pir8ZxUbFAHlc8N3LNwHxLwsO9SnY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:09:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:09:04 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, sboyd@kernel.org, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com, daniel.baluta@nxp.com, aford173@gmail.com,
        ping.bai@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        heiko@sntech.de, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 08/10] clk: imx: add imx8m_clk_hw_composite_bus
Date:   Thu, 12 Mar 2020 17:01:30 +0800
Message-Id: <1584003692-25523-9-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
References: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.14 via Frontend Transport; Thu, 12 Mar 2020 09:08:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d8df14c-cad3-454a-a7a1-08d7c665030b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5795:|AM0PR04MB5795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5795FDAD369F9A8EBF48A49688FD0@AM0PR04MB5795.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(6666004)(52116002)(69590400007)(66946007)(6506007)(9686003)(6486002)(86362001)(66476007)(66556008)(6512007)(5660300002)(4326008)(956004)(36756003)(16526019)(26005)(186003)(478600001)(7416002)(2906002)(316002)(81166006)(2616005)(81156014)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACC0EEop3CCQqZNpYOJugNbxzCPQdqnhPfQwXLDesI/bfVClCJSqqmm/H5O5q8scEl/vFHPD84MneiS6oCaFgluPSvlKI5YLsrVjiAH3OyHzibrymUWpcnXTf4aAODSwMdwuDjJQ3Q2xXH1mP7NASGC21PaI4j29odhUgsy3UDiAsZ739SF786gbAIn8sCIh3n+R+TwGheb1Txb1A9TB0kXUG5vS3WahFObf6npQNgsDfgXB4If7LLfis50Ah4uEo3HHKp+qY5MV8GlsPYjsqiZGnUZRQpu8HttgVTf5rjCyytoPaZRd236X33hMru/Ew+XtgX28fxX1togZYOrkwmIKzmGwk3zTunYztNKaceOfMhznraMHs1Z/hTbl35fbop4ujebrIlgTPCbtC9pUoFSgtIDgb6rFm+2aOc/U9qNX/HI+dhUNCtm7BI7kVZC58pRdRgOTboc+ed24ArioMa+QdNHVaJkOr1GoN3ENAGMewVW5PNQW9lZ5zoKpZjcr
X-MS-Exchange-AntiSpam-MessageData: /ALYEcpm/fAdbG7EmhL4JXxL1uhznWLpNWDaGI6bpWYVdujmFkSl0j4oUxCzLFZwwnopRHTmCjk9RslhGVlfBEniZhhfQcFrR1HNS+MqNIcTrlQdqvNKzWTkCfRvkXQHupTMlq0yXu4nXE2viguRCw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8df14c-cad3-454a-a7a1-08d7c665030b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:09:04.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKwuznjBeH8IuwyAsTQrkOa+xkGnPwNBIif/cFRnr/RkdxNgqq6gX7lnwRmkV3is2c22SYNt62fR4tLB55K7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx8m_clk_hw_composite_bus api for bus clk root slice usage.
Because the mux switch sequence issue, we could not reuse Peripheral
Clock Slice code, need use composite specific mux operation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 5 +++++
 drivers/clk/imx/clk.h              | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index fe05b3c4d4fc..086c9ed68bdf 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -223,6 +223,11 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		div->width = PCG_CORE_DIV_WIDTH;
 		divider_ops = &clk_divider_ops;
 		mux_ops = &imx8m_clk_composite_mux_ops;
+	} else if (composite_flags & IMX_COMPOSITE_BUS) {
+		div->shift = PCG_PREDIV_SHIFT;
+		div->width = PCG_PREDIV_WIDTH;
+		divider_ops = &imx8m_clk_composite_divider_ops;
+		mux_ops = &imx8m_clk_composite_mux_ops;
 	} else {
 		div->shift = PCG_PREDIV_SHIFT;
 		div->width = PCG_PREDIV_WIDTH;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f074dd8ec42e..d4ea1609bcb7 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -478,6 +478,7 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *step);
 
 #define IMX_COMPOSITE_CORE	BIT(0)
+#define IMX_COMPOSITE_BUS	BIT(1)
 
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    const char * const *parent_names,
@@ -486,6 +487,12 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    u32 composite_flags,
 					    unsigned long flags);
 
+#define imx8m_clk_hw_composite_bus(name, parent_names, reg)	\
+	imx8m_clk_hw_composite_flags(name, parent_names, \
+			ARRAY_SIZE(parent_names), reg, \
+			IMX_COMPOSITE_BUS, \
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
 #define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
 	imx8m_clk_hw_composite_flags(name, parent_names, \
 			ARRAY_SIZE(parent_names), reg, \
-- 
2.16.4

