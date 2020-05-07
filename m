Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91878C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7F5208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qyBKBT8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGGG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:06:29 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:22990
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgEGGG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUFbxpyTanLpko96DSVJViCzLG/GZy1kdmmvm42LR0KLLwBHo77KIELw/Z/i2A9kzFnZjE875iaEQYYAM7Z8hgaM2VutGsXefK3LC6mZRGn4dpV5AfYpunyhDU1ScLeetfqi7YAvM9dSFW1fjdzdEzftSLUPdlmiVnqFWAB9bhxrryorN1jl9GOCGwFm3LHpasP9E+o8Hwf2Olf8l15JfpXvIlHUmMtcH4UxLZsioO0lJgEibtJFT8X2lv/Rw4LLX+uZuzkXcqDMh/tymRbDUM0QtC38V7k0alq/8bEMpUqRT0bDftOOacMfw2rpNZNndZXyYxu72+7u3VSNLjHYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua3eDSyrLvZQQ8z4E/8SRL7EpI+SLqLXgYNjTduIt9M=;
 b=c+FFXEJcg5nKqdmMY7cKADZpIHZnwekOuPwb7yrjKxd+49jnCahThR6tolVa7dV9kFTGNFu/n80stenGzVJd+RZkCdLnlNrsi92SSnmzfLZWeuF/ct2hpTfLUdtETrK0vh7Ed/qgBlmfJcu8OTPF2xFUukvZ+hF8YI4UqBjI6+oosTfsIQEKZUs/dUabIy2OfnNSWaoQkfsgjsWZtcSRsTlc7xCXO4jVvXca2sFlO3VhvM/yoTALvDNXHNnjQ5TKsJNsB5EAx9sv/wdkIRfgM20zIEZL/T4zRb1cum8ZoJWk4xZFGDd+7z4kJ7IOM6UxiWkf6zOz7QMB0c6ASudarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua3eDSyrLvZQQ8z4E/8SRL7EpI+SLqLXgYNjTduIt9M=;
 b=qyBKBT8E5i2trPSvyKL6Egs2GR4vu0IZdpqKd7ey9QbtGB99cNc4seqlvythpPC9VFEHXyd08MUCrbKXMFdO0tw2c/6298Va2aQDekWWjpNjDFlJqMQ2LKS9M1hs+0WDwQytvdNnIz6m8x3fhRQFbJ7GHN+gazXK/scDvhbLF8Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2710.eurprd04.prod.outlook.com (2603:10a6:4:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 06:06:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:06:20 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 10/10] clk: imx8mp: mark memrepair clock as critical
Date:   Thu,  7 May 2020 13:56:19 +0800
Message-Id: <1588830979-11586-11-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
References: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0147.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 06:06:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5416266-f311-4917-ea58-08d7f24cc30d
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2710:|DB6PR0402MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27109603DF326443934CCEB588A50@DB6PR0402MB2710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qX96wcFsPswwc15SvKf9QoUqK3KlmI3Gyilq5CFSFtnDlMNGmhzwNxLM3Yh5u7rfAhdYjx5MRKrDIxJiTiV2kp8p76ews4vex8dkNxV2Gb5D95xmq5+I2Wwf/eY4uEKuhcpmRKzPLWIe5hpCj8fwdkh+KHr7RZffnO0bD6LX1fFLGl7teZenl+FqaOYPbtDSUdNM/KbNZv+5LzxPDWf8X93LYwVtfksBwNMSdWUJ24OZufA5cpFQtPlq98M6VxVi0DmpodMYUq+/T902SlWZP0LditFsb1HBev61bGRhGWhs87aPvPkiY/pdvGiXCZ4xFTfr6HoStsdRLxzPfjjSCoGZhYUngwGPuuZvZGrJEAGICDIsz68ac6YQJyoHEMZHTZbOBV3avpBjKcf2pVHq2aenNpySQWjH20DTuV66oAUqUJpD7iXhcWGnY7JFYPDqpS6jX7eEKHvMa/gaZB9PP2VL7hseLh89ZcWjyfWx5RjPnsK7rz580VarNt4Jl7nbXIv+bVvHqL7W2IdXtNs3aEq3aGRt2QbRLFaWhIKQ6YPLr6uf9Loj7BT693rBbE5X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(33430700001)(316002)(33440700001)(478600001)(2616005)(16526019)(4326008)(66476007)(66946007)(86362001)(2906002)(66556008)(956004)(6486002)(52116002)(36756003)(8676002)(26005)(6506007)(8936002)(5660300002)(186003)(6512007)(9686003)(83320400001)(83280400001)(83300400001)(83310400001)(83290400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6hHfuq5+ocQjzXhAW0IZSSKBn0bzAuOcpFb/DVr7wdvYuDFKoOgPfPpBDPhPJjCbwSYPzfk3cs1E5AHIoj0cXb9hLxhNQWitN6lQMv3DMy9CWZDvxvD4LxZr2dBLaFSAr9kKEcyZXG9QxM4m1B0TX+zDp0JXY/z/Vu1LmxZIFQxJMRe7lDGIgoHHhBMZEGbY3hbESBrIs8sbrrBoofi335hyuCiKSRxuT9xpIi59+IOpYMcRuK+kF+JlUJP6AfcyChLjH5zOmUjj2HUlTh1KliZS41ZHU3hx85ZdlaeT1PjLva+VJTRMbqcN4N98JdlFSeCgGvv3uI+DNgPAR2s82DmhkV2l20ZVht/at4dpnvze4qMB9zWrkOKcF3n+IMc3sT9g0oMTCMiVmYTgpMb/pLyoLu39e2jzUBpNx19wCrVs0tIX2e9n5376YM8vpXxCqa+Gm1EKL+j7axZRfPbODhvrpqHHiN9ipKBHHy4MfYuRBs8Mc8nsygyOMiNzWnwlMGb28i8A4Vqgm5uO/MGqPMSW2fG+To8ERHUlO2P0DvO7X/P03z7XswLFNg6vje8jQYonUqAQrNJX7onBXc8IOb7jpnYmM/7m9KclOGclw/Pn8LliB8yEDQ1VSTxmHTM3JSGw2niqAaC+0bHPOs78FkZxlDiFIQah0e0VdeTLnYpibYUE5MP9/iNfUKs6W/dAkF7Nl1ouQsh5qCPY7cWZ9UBtrdza3getHX2fRl8wMqD58vsPuC/xcyi75CMADE/uVx5v+yR9PtpOiSSfELdEWivuc61B15iHGnEY95KsTKE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5416266-f311-4917-ea58-08d7f24cc30d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 06:06:20.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xPF5UTyYKPx2USJxwq0xkwbpIY3KzNeZNbFVbBm/9jKdvK6yoaY6+/Nwc5+8ifbAlRc97MoaRd1s59YVU9d6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If memrepair root clock in CCM is disabled, the memory repair logic
in HDMIMIX can’t work. So let's mark it as critical clock.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index b4d9db9d5bf1..a7c59d7a40de 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -590,7 +590,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
 	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
-	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite("memrepair", imx8mp_memrepair_sels, ccm_base + 0xa300);
+	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("memrepair", imx8mp_memrepair_sels, ccm_base + 0xa300);
 	hws[IMX8MP_CLK_PCIE_PHY] = imx8m_clk_hw_composite("pcie_phy", imx8mp_pcie_phy_sels, ccm_base + 0xa380);
 	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
 	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
-- 
2.16.4

