Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB47820775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QPVWPwg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgG1I7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:59:31 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:52485
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728474AbgG1I73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi/UcLlHCXQNN6CBAyrIJl2SkG2utX5gtFVWJQp5hW4vYDjTgjerbo1U6IgnuxvjP9+W5ZfR4m9/46IorNVb+xRvXNkw4dQO6fuaZZ5U1FlxcBdf4AOiqqHYfpiun/JiE3mr3bMk7g6b3Bl3pNS68gfUplIFj0FStDEMlVoJHacX34lLA9Qlw3cEO84tRBskCA93JfHkb3ca5A9mqcrcd5PoqJncBUIFOCEwZe/duHYzZ+7fcX22Rxc6PzO3ZVO4tiWeB/B0YNCPkZM4eTNSLMuVrQhZhw5y8gF6lzcfVTs27PUVxokJ4oamtLI1MmWPAgOOapwAJv7PDOg5wcmmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3q9qceQW+ne+Ts3yq31vqnQ43fTAwd7b9tRBWnyk5M=;
 b=h2BVclNylGvq0xtGp9rSaIuBTM7/CCmJQOKNmfEb6xXwcIflpf05skyIxJnqxzOT2W0hpPu/Y7NmA+SJxZPf0+yUPtfinJkoXfhwev0fMe8nmCPYUO8qEJPF9zh8VVSD4+uoW8GAa0zTRH0mu2uNLzs/eyWmSK+UB3nzIZ/tjLJ0Q8KxxT7Tjkon7fzzaT2Cr3Auk0aevH9MVfenzyKPoyeCn5t0DLb3UD/Bkc1fPM7QaX1NFMrFhFYYkKEE2tdp2qbD2uMnJEtdHcgrlZsfwupxWMSu7QRGPuWjreB0GixP9Su33PGYqxRid0Xi63/aAPxOwIeTCyEMIBysVUZgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3q9qceQW+ne+Ts3yq31vqnQ43fTAwd7b9tRBWnyk5M=;
 b=QPVWPwg05637Sl9w/UtAot+zwckcu8TEGWFOdR/0O0Ny/ujhmIyqf9kS5RNMtjHsnI5kZkooEZoIcEYCQCZaSDjkt6g1Nud6EM3XAVPe0vB72BRpd7QYWvwpoSCkGR6/J3HIRvZV4levnbbvV5hHJEyQ66wUGRKjkt48HVytfFY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 08:59:25 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 08:59:25 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     arnd@arndb.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Support i.MX8MN/P/Q
Date:   Tue, 28 Jul 2020 16:55:04 +0800
Message-Id: <1595926504-6121-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 08:59:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1e91424-62fc-4e5a-741e-08d832d486fe
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2375D1EBBAE1658FA9B61E1C88730@DB6PR0401MB2375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCvphMMVkZ9hBKBqUkgFHBnioJsEZi7qEvD5bWAsFZd5wQlYC9T+4j1oPpDHMaB3ha0GScDKWKl3/1Y023bRi66qvPrzqH4H2ZhkjFHt9mjeK74J8Nn0ejpI4QmtBYPnHzS4TElBeUtcUZVpcBEWSh7y2Y1U96OPONy5yEn8/JfUAJ/j8qfPM1rynv2W8N3c5+RCqBhjMA/SyVYdjBc04jVZOIuG1zrz0k1IHljVVi2c9eimI9sJKj2ePMDW+Z5zb51Ifw+F6Sg2jlQnEXCIkdfyzQvA4RxCgSzSv7Q52v9APHn4JYgJA77PmxV6dPs3HugHmDoPPEdLtLaXZwN490+CoA3MLTgyfrM8UKliZEcJCNJA0a7mEIhVZMjeEQkm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(478600001)(36756003)(26005)(5660300002)(4326008)(83380400001)(86362001)(69590400007)(4744005)(8676002)(52116002)(6506007)(8936002)(2906002)(6486002)(186003)(6512007)(9686003)(66476007)(66556008)(6666004)(316002)(66946007)(16526019)(2616005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ttWuuu0Wm67xaakwt4+2oT3xPuEiEW4iMKtaFAaWzWAeHmPi3VzwjsZhLSINCS1fsU+48EJq+8rWEMY217S3fxel+NDGaYzuihJeL0QWka3NUqdHUCLTJRlLMBoDphDyZOBVf+BU7r0iIaekh5JcsOOW1yhs6sePVqq0E+n7SfP8tfVDIdVwRBeWNzf3cf69Zq6QHgneH+AsUNMb5BVEmi5jwco6Cy3zQFSwt26fiUr5M9c6YYC84NMN9iQ/ZdnQdESVQodYMMsC8AA0vqGOlUv+q/njtIrNbwEu2R/gQYUcFFoOZiD/ypOGSE0dwPXMZ+1iTnSjqfhMnISEa0N7Hn/rsnY2DFTt2FXq7yZqB/XxM7NxIJXhPqPXZHMEjB4Qze1jkqIf4H2luRk/SuigN0eM5bUY8fCi0uyYOfOTJLVLtZxhUl/oV0Y3vhGBodA3vtXa79xYR/zhg7IxbFUtP1GWIJBg2qAB/SYjP4MdS5lxBWY9jH4pyfGFctLoxaVl
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e91424-62fc-4e5a-741e-08d832d486fe
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:59:25.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxZ2xFhP9FINoR3nf8yQ3YkOMAXI58IgOEvlhW0LYDF/f3RgJQhUCW4Zw+SjNGaXQ9U2aOrixUBNZPoIKzxEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MN/P/Q is built with AArch64 hardware, this is to support
it could run in AArch32 mode with clock and pinctrl driver enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 82d3ffb18e70..fbd02365e3b6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -218,6 +218,9 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
 CONFIG_PINCTRL_IMX8MM=y
+CONFIG_PINCTRL_IMX8MN=y
+CONFIG_PINCTRL_IMX8MP=y
+CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_SIOX=m
 CONFIG_GPIO_MAX732X=y
@@ -407,6 +410,9 @@ CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MN=y
+CONFIG_CLK_IMX8MP=y
+CONFIG_CLK_IMX8MQ=y
 CONFIG_SOC_IMX8M=y
 CONFIG_IIO=y
 CONFIG_MMA8452=y
-- 
2.16.4

