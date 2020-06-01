Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED275C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CDA20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bs5r+W2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFADyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:54:07 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:13703
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbgFADyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+Nrigny+0wZxFD55mfWlC19UugyLVrWTRbDsaWQZNgDBu8ktKlaZmnD2DWRAb9mymzgQGj1cpDJIfPMSytb7xSmduwJOKXyru3FzYzXS6eE6e+vSs3JcGvW5D1Y+EHrDBMzW3nk7fILBZwoc0Mp4WUfTRWwNbb9xbhYOeST841KAlxVRhCz34OeFy3gcuGm37EFjJ7t3T1xgPP5S5bUrb/kGpOgvtu7NX/up0AcEmIg/vpNw3E7vprQjIWTqKtM8aUg+T+tCLZCvIC23/mUAHOCW7JyO1/w986TbU8B5tIbD4BDlnstKx4/xoIK3HlMafr3DjSDrdHg2P0/gLw/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvpJmM62ji+KohxQ8u/BkIjRnZ7++RLYseC9Eit9cfQ=;
 b=d5S5ScYNjL33+i1kbrb4naQfDFNki5WiCpO54aHVTC5vtxfEJWY/UUO+fkxpcg/8rPiPailVkLClucIGiIqMvWaEzs8otPYqY+DAknzPOSifT7OTjx0POYsrmzjulzudReud8HfZ/xJ7HjFCF0k8JM2aL680e2Fife53pA5TjAPEmTsnoi2Bymb+zTGIQs5bGj7kAMnvcJMYgLQsoJKWlVVuXW1UP55Ax+YG0kqNwhESJXkFd5OblXSolmcrGjXBun8Q6gzZ0zhBBSH3crwmPdj4hITe4i1L3KZhXMX+NJohdsigdIfpIKI7f9VpxW3JVOyBhrlVmCQB1B+G1ppvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvpJmM62ji+KohxQ8u/BkIjRnZ7++RLYseC9Eit9cfQ=;
 b=bs5r+W2JIDpd8SjujiK5aKqIiZJw+cRx5NqisURxB1mi1YV9XKzV8dbAvyh37KiuSGT6+Th+qy7jtaC4SpLeUyo+RJXzIypvsI5k9Y+CzZoKbxk1D61SLlemU9sb/EKJuHJxRJW6tO6GhX6aqSqPUd0vgC5QQuUEJZCCAi0onVQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2920.eurprd04.prod.outlook.com (2603:10a6:4:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 03:54:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 03:54:01 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de, jaswinder.singh@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] clk: imx8mp: add mu root clk
Date:   Mon,  1 Jun 2020 11:43:19 +0800
Message-Id: <1590982999-7149-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
References: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0096.apcprd03.prod.outlook.com (2603:1096:4:7c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 03:53:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 562a2846-ead5-47c7-6de8-08d805df6b63
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB29208A0C73C8DA66F3DDA307888A0@DB6PR0402MB2920.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HI9Cfxls5qWDdr7H3UDW+xiMlwwP1xq+ibYfO4QtDtE852s3vKmF84PlANAQm8JWWmQ6ytXvvr+GsI53hJEIH6pyn5UMImdFqAojxSID3jtNyU35FEIbltfkdrQPmIcoCk1ucDcaIrN9b/RIlq5B4WHX+xMmi95dGJS6GLVJe3OB4WC/2ZL+Vov8QYyIi3H/RsuICKx8ctKA55dcX3KnVMbC/jrPpAUf0w+3tKBRR5JYF+GfEgmPknCr4D0ubj+fW2d/xAxBWSbfdyaq+P5p4o6uhKla4d8ejb/BmY9nPiDnx42TqrdrT1rfw4lMLynMGEHCmX1TfifXTVLzxoiKarAnUBRjZJyQHsabFiHvqJr6vLjnYw63sIxkigkgOqvlBtFsPigdEfZ5H8TJvyAwsNwYf2gUySRKeQyIyeN9v8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(36756003)(4326008)(6486002)(8936002)(6666004)(8676002)(7416002)(6506007)(9686003)(6512007)(478600001)(69590400007)(16526019)(26005)(316002)(52116002)(5660300002)(66946007)(66476007)(2906002)(66556008)(86362001)(186003)(956004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d5WnHW6qRhBlBidB+S3xyhI7ZMURk9tV0mInehdcPrN7g5Ud/ey5Cq6TK4SKwx5tPe76uQcY0Lofy1UaE1XMxAxu90p+hn1YqaCdmG743gYU6w5EMwCd7MpY+4RePZZhBppAlW8gxdwPTANajm2REbGczYaQr/bgb6fx+lEGp7ajFj4TP/pbndC5ATFu2mlHixeMeQWU+91NrD3ynOhJ8nvhSgUa6NPvTJ72jZFwYk1SKci/HYLsgAdKJh60vbBquQBUuwEHZKeg6fJOaKa2hRX5Oy4PlL/jJ8cBeszb1unsy+P8M7ERPL8ppE6X4Z+Syeo6Wo/U8H7u137R3XVGOdLnvjVfUCJRddi6CBdcIjm7vYF9EEPBndNEE2vkMwH7wv0OBhq1y2EgJ9A7NRPKu+1ChQVU5LXnigO/QYVqOAmFBOe1wNaRMV5pbTObmXWPfZE4blXJT6UwKNpPXyC8WG+9ZOmte9Iw93+JT20cj23by5MFSn3YE3bownfekzMX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a2846-ead5-47c7-6de8-08d805df6b63
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 03:54:01.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8C6ojl56knBrSUTokC3sP1kyCZz2oAZBm160NvXtv9/AI58nhRCTAhDfeLWzK+mEO6R3PUedMNIBbx7fdBCFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mu root clk for mu mailbox usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index b4d9db9d5bf1..ca747712400f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -680,6 +680,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", ccm_base + 0x4180, 0);
 	hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", ccm_base + 0x4190, 0);
 	hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", ccm_base + 0x41a0, 0);
+	hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", ccm_base + 0x4210, 0);
 	hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", ccm_base + 0x4220, 0);
 	hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", ccm_base + 0x4250, 0);
 	hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", ccm_base + 0x4280, 0);
-- 
2.16.4

