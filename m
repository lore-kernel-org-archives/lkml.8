Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D71207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tmUvUyDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJNYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:24:47 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:11584
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgGJNYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKgAJrm7BLzMmAv6pPakt9JJctJfcSUtSmc6SQR9subM4dTvBaGiGJT4lx5ed7rzVqKwMTQAJUWcP+ZALos2Zq6XRxSWWJHoreGG80BeD1zbB2evSp6MkNlaIeJsPRpm01LwmVY3sn/94NCaRpkYcA8klOtUcrP8Cxc9yJVmfXKimJ8yKzz7jjWm28J3UUZ6MTpVgTGQyCrIsUt99FDhFZFlBgWUSAF84vl6IgC4bXGm1Ko2dZd8qvKxA7Ra7Yox6hJQOqt7tzq/SDdi9p8OgI7mp5ZDmFwNSStPTJeg6clUcQGOqUPFoQ9OVOmkkWyzJ9RJu64orqqT5qwgGw732w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaJt5SCXOUjbaWST4hkoOW6E0B1nZRjBFKK2dgdhhLo=;
 b=gNAf9cMRrBG+TY/Ntf0YD2kb3QQINdg4HdX/MTRGIkxTQ9jbTNSwe38Fp0atohza5PImgQITHct+B3Mu26BZIIK7y46U4/i7E3gqq0s4RbT1ZzMDojWHNvtcx9LvHHw0pnDZNfcs8aup/q5F2gPfYOS3IOsJ/IJy/XZ8wjB9nF9KP4GhGWGt2TLS2W7g4XOz/upOpgHikds9wC7y9Gb2T8nQe1N6cTz2KR3u3+ZWKXL/S4oue2nQV65uO/0KuoGGvOyQB40E9DeHpZo4mgzd7g8BxtMaXATfRxTklvqT1ZG2u10FbDCfARoMw88RPctR+F7y+s3mpu8QE7Bz7btyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaJt5SCXOUjbaWST4hkoOW6E0B1nZRjBFKK2dgdhhLo=;
 b=tmUvUyDme4iMhlhPlQDl6hXy77FGUtTRIXj0TfcRDTqML5P4Jxd5scA0Bc5zPfe8eXCq04dOqm96tlafEOM/PjlwUlpzcScUOpLtW5zCqZ2bV89NByBodmdMkihc0OnmERa1PTCnAGZiO+btHkflMGkRxnw9ZNEvyOxL0RWRyC0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4821.eurprd05.prod.outlook.com (2603:10a6:20b:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 10 Jul
 2020 13:24:43 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 13:24:43 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: colibri-imx6: remove pinctrl-names orphan
Date:   Fri, 10 Jul 2020 15:24:21 +0200
Message-Id: <20200710132423.497230-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 13:24:41 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84ed454-8822-4ace-e57a-08d824d49a99
X-MS-TrafficTypeDiagnostic: AM6PR05MB4821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4821BB2503DE8B70B6CFC3FAF4650@AM6PR05MB4821.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQbuA3O0Yc/wmBffTAvxc9NCbCU1O9cbF4+djCCUTeAW//7S7+4RKKcQr34R2zAybwxmb5b4o7Cege2PrcgHvuhuoV0hYYJUgF0XShTf6Kw8+M5x+asLYn8qKdXI6V3+4bEQWXrd7wrMmGuRn0+cLfNoPmdctAyBNfLGSm8y7aYkZk4/KIqqLzmyGUopN2pnUlpmqOMOxDp1VhyFeACErjORIfP40l0+r8F4v9UqPDdEFJa0unMN9vgNP/IUU38KmwmE/Zk8OmSRkRVcF2YcSulunVkVGLH6uEjISzlTMmSERDvQOwxagHvvUQE26Aoo74uwuwctqnv7AKmmvPn/txsM1Z0vrRNoBxwTbJ7LWd1zyDAz4UjIUKXx2kxt9ajj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(4744005)(1076003)(66476007)(66556008)(83380400001)(6506007)(26005)(6512007)(8936002)(54906003)(44832011)(4326008)(2906002)(316002)(6486002)(66946007)(2616005)(956004)(86362001)(5660300002)(6916009)(478600001)(8676002)(186003)(36756003)(52116002)(6666004)(16526019)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nWw2g7GvdKy3DmAHRQxNnFzK6xopqX4e57Nd8NXMc4jOrASfHDZc1eLodyDA1MVZbqtpVxq1wslIfeJ9ura67i8Zwk1Zdb7qALOUwySxWkU88+0GFuGRn7uUsprKuh7Muw9rhJ0C44R2SBlxMBZUWKYunARPJl/4BddGJq5eaSYcjAnW4sZhPXRgMFjFuy4kF2LHHJUPNsPgEdAbCGCzt7G5iJmvqkT7qgqMcPkZp+j3zXoxDLBAhPUBkjERkiOgjBltQtOUVO2JlXRFs8KdTpb/5d9BXlSC6Z0/biVBciqWFBON59yst56rjobvoSL9JvElJQ1Lgku/k0OTdxwBxqz6Uq0lcUl7DoLV/zE5HcWyOBJTJJNCur9MjC3khWjW/EpGBrHxcm9FPb7gbinGlHAtpNjkWNTiaGdb6j9Z5SCzH/LJGAiV+ZgsoSGJ6lD2tB5phi3Ey+scYHm944LrZlv0FTjRlTXF63WyUCXFYZw=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ed454-8822-4ace-e57a-08d824d49a99
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:24:43.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuNn5BtjsQL3LXrtbidmMY5Cy9nPL6wPWeq378Ne0JCgpVIX44QPvCA6accOX3ETq2ECYZ+r1ht5iXiBMP34k0BYxkc6NtyycTDV3yzhgdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not necessary without a pinctrl-0 statement. Remove this
orphan.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 240b86d2eb71..a4a54c82e28f 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -362,7 +362,6 @@ &uart3 {
 };
 
 &usbotg {
-	pinctrl-names = "default";
 	disable-over-current;
 	dr_mode = "peripheral";
 	status = "disabled";
-- 
2.27.0

