Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3620C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A927E206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/Wj+9h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFACRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:17:09 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:12322
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbgFACRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaZ6H+W2v2YQVr64M6cyiDsBQlQEO9kQOTJ7B+AyW0uijgnFjK6BP0mMxAcBYaS1YoaHy7fBWInPJtAGs7Ql1RDDeKhH0N90UB+4Cals8gPS+qEAn/tDa0DM9r0g14aEuWJUCTGBoxt9D9S2Ik739YmeUSZQV2XNAIK13Hmdmtl+i6iF6WNGTXWl0GiWHtleiztUUzB6SaYXsd2f7wh8r4NVXlt+/43/UoqMFl3cB3MyOaD7lnQEbqpVqbHIbSzj9IfSd2Tab+CZukeAVs80QJK6brnsZedHURTJp6NYVZK9w1F7xCmqylWuanff2FOI7rjGKKXIuhghj6HlEeMUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/uCrrf8eXSNnP3fRBRNZyue5G0xVLa5q6XIiRQDvbk=;
 b=SGrZN1gjXC1YdDtxc3ZHZmNS87BavIl/eiG2Nb7Q2Qj665kPJbb9MQhNzYHIxKQX6mLlbckrTbgwdgtpF688zpblDVwlGmd9+Kg47bke1Z0iS+zYjWwpyDeTaY0DSUlyhziU0x0vkTW9wKSQ70FZF8n+5i/4X97e7bPtFhh/kK97n4nxiGq8Jheh+gtt601I+6YqHPboXalfjDC+FpuWvjTdJ7OZ3ZliMXFZKha7wC+i3XdECKDBBp9m5mKlSfTimA4/ozaQIRVxAW4ObxCj7fi98VdpjAu0E5upc2AFnVicNKFIp/uk+nJgawkD+XPm8wpMmagYC6OQYuRl42YrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/uCrrf8eXSNnP3fRBRNZyue5G0xVLa5q6XIiRQDvbk=;
 b=H/Wj+9h5aiKRGy/bL+cUR4acKOelBM1lDAdN47Ws6Ivux+zhATRqlAFuerF5xy7zHK/lWfGJvZHwUlbn9OHX5BZ9XIyVHq395847X8l/xC2wDDItm7K4bXZiIBJWRIxfXQoA4jElN1kwpbIfWG6u1bCjdfLsj4xBcjXD4n8dChI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2744.eurprd04.prod.outlook.com (2603:10a6:4:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 02:17:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 02:17:01 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: dts: imx8qxp: add i2c aliases
Date:   Mon,  1 Jun 2020 10:06:19 +0800
Message-Id: <1590977180-9957-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
References: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0157.apcprd06.prod.outlook.com
 (2603:1096:1:1e::11) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0157.apcprd06.prod.outlook.com (2603:1096:1:1e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.17 via Frontend Transport; Mon, 1 Jun 2020 02:16:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3af68e2-2845-4ecf-6a19-08d805d1de16
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2744F6CA340D830718970F0B888A0@DB6PR0402MB2744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJOKYqp7YG8lwygDWMr/+FTsLVu6sMWtBPoqylWYvnfV6ADsKxp0CgFua3zwjvdHmCwj2YKquR7rtIWciw1lZcd3EBHmNcCyklNADxS0Z81IyLIB4dDtjKGWC0OBPgVAat60HRivsU+wNfwivwnJ+9U2etQYYbPk6yyMnnvrkZ8FX0OOLG98ME0J6uE3tQ10WigRIWOosXkTX2ROEKzKoRPUN9iASrVdjvwK79DnPQkyojjVLJIrIXExxPe29yMNPV1mMQLBZhUPkxmxc0Ig8lEHse93ZUZbggLHPS3SvDZuM5gwVGowVoSGdYclMquhR1ItZ3SpVpAsEabJLjeOBLChguVTcz+pYzW5n6MS7rLcout6txBdzCHstt48AUtkTf9Pns08gdMA0vMIQViRyHCXXPSkeTy7RAdas67/OTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(26005)(316002)(52116002)(6666004)(186003)(16526019)(6506007)(8676002)(6512007)(9686003)(478600001)(6486002)(8936002)(4326008)(69590400007)(2906002)(36756003)(66946007)(66476007)(66556008)(2616005)(956004)(86362001)(4744005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rzT9m8S7kh87dFWVmpEGoDwa1tPFvk0RPQc48QyYY1FZSj6uXobhEIvVF1Sa/XekCAIVY9hmyImPai11mdZvrVYBjTz3wvj7iTfA2/1xXszHMf+/ksVr8IGR3dXNbMZoZleIN8CaWSJADBhmUbxmlhJ2AwH99bv8GmJDqzty5zOvgDqJRAtnGv660jiOgR4kbn1+cbtrLmt7I3OaN0qCagJXFmxvzsRFJc5ZXRag2Zr6McPqLeDCTC4zbrzRChE4LdCjtf6JcWWkH8EeHbF39O9S9hiEVkNryb4p1vE46AO396eMhnSzPdSsGaVZH7mlm05b/DQOKSTQQCMA/IzXpY1MI5HQQtovw+YtITZATnJPdtVqTjLcAcE8BlE7uTrZ9Qz9AlYFeqhF4sj84yQ12honuuVGe2Ihv2xwhZiBy7PJ+eES0y2rHNI+Lan4weZv3bxTcJyjfWABRRcSQ5w6hnJXWj44H/NIXGJPabJziTg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af68e2-2845-4ecf-6a19-08d805d1de16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 02:17:00.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpQ7pv92OloIwlLbTQcqy5rGyZbTSg8pq1Ml3g8XFcGyLMR6Q1qiGfTqylXf+0ZsRoFs6pFJ3fR75hF40ADsLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The devices could be enumerated properly with aliases.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 33363c127478..8ce997110cd6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -19,6 +19,10 @@
 	#size-cells = <2>;
 
 	aliases {
+		i2c0 = &adma_i2c0;
+		i2c1 = &adma_i2c1;
+		i2c2 = &adma_i2c2;
+		i2c3 = &adma_i2c3;
 		gpio0 = &lsio_gpio0;
 		gpio1 = &lsio_gpio1;
 		gpio2 = &lsio_gpio2;
-- 
2.16.4

