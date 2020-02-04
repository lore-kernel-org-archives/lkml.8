Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54967C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD52166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="V6FC4DGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBDLMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:12:24 -0500
Received: from mail-am6eur05hn2233.outbound.protection.outlook.com ([52.101.152.233]:26047
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbgBDLMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:12:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxZPAFA243hJ4M8u7eJdVPmQVA5u94MuhElIQn6OhThQ6aMouVm7gpHEAqOeI3zKzldvrVE0atIK6iBCKPwetZYixNqh/k3wqVBkb/CorDzsuTsUjthH6pjHo6fQ5qX/vKu/ETt30FnlTNZFrPKQt32CTpR3TQnaASGjmWz5g4GGdev3bjsJduIck7HQrKpOIvTjxtJeuLBWvyw3S9+7QcjTXgzgzSwP0ieLn/PWPDe6CiV4wESWmJbfGk5QviZT4L+9S8a/vY8vA4xEuKoX2Jwrnh+bGkxuzxxaARbNMrPjGZp/bi2g3f1KVSFZLGomPTQF+kCBQgbvSb1Fedca5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJqzLF0LHNIHPzWqjjH4y4e7LesX12zHZKU8YrqxJwQ=;
 b=bJ5NplhSzAwUtjBx0gVjpNtyVYeA4gAYlpZLzsoxgEK6+6r5jh/DoQNwyuVtp57lY+QMiA2gJ9m9DCuHMn31GAS+s25WdmEM8tALg5SGyoJ9GJyQYfni5X3GivtjTeqQB+XsXwXFHr3IglI8h149KMZPTCepRdsZNFT+lYAxFv7HFk/NRKOfyOUpOaypw69Aikh+CXx+4tofFyFfruKcLoswvNDmpVC/as6KPYF/f230QAcOkPTJqHm9JFvtkj2MD0HzQUzMvq+KCyYQxYY4gzkjo6HafAS7ZVpXKHB+Uw2+S4PREYD2PgiTW+u5COKuXDGxmkjmT+8+WyUSweV8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJqzLF0LHNIHPzWqjjH4y4e7LesX12zHZKU8YrqxJwQ=;
 b=V6FC4DGvru7rsEpw9bVAXqtqaTFjTmg7LgIlgamkkb5Lf2S6A8BEgFpRNXxgsNVI48jfcCDE5OOayjjf+8URHCiwNH7Y8PZXXll56nZtsA3m1T/HWSwbzBUK4Or/07jcd0R3jQ3SUDIVvCehSBu6V0OdWxJcUBde0N3IxddjzHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5632.eurprd05.prod.outlook.com (20.178.120.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 11:12:08 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 11:12:08 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_AD7879
Date:   Tue,  4 Feb 2020 13:11:50 +0200
Message-Id: <20200204111151.3426090-6-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::13) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
Received: from localhost (194.105.145.90) by PR0P264CA0169.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30 via Frontend Transport; Tue, 4 Feb 2020 11:12:07 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feafd06d-0f98-49df-b49d-08d7a96312cf
X-MS-TrafficTypeDiagnostic: VI1PR05MB5632:|VI1PR05MB5632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB56329D56948F5B71C58EF913F9030@VI1PR05MB5632.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(39840400004)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(1076003)(86362001)(4744005)(36756003)(5660300002)(4326008)(6666004)(44832011)(316002)(6486002)(52116002)(6496006)(54906003)(16526019)(186003)(26005)(956004)(2616005)(478600001)(66556008)(66476007)(6916009)(7416002)(66946007)(2906002)(8936002)(81156014)(8676002)(81166006)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB5632;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP2k5VWj9Jg1yoN9Yc/cagueqT9NTC2mXyynXkBN7xFIipViba1jmuKhhm5lx5zo1Z5j87Q1tmcosNihhI+yVmNVLnC71DTTjjCqbHzyH+FrEMul6H8xH71UkItbAA55oCBaK5iEWusdPlu/otcBucEk1ykFJq3FA8L4aUTcvi627rkIo34P4QGS4aozLUf34YWnC6n1Ld4MWadm7lMvPubWArKSsCiX4htw4g/dY1X1cudOujbxu8rGUsX/IaPan3YzoZhCAswIpfjGqzAYt3vvavt/MpB4RN3u5qbS+d4a4Wr2C51IU0vBBO9xe9CNTCzHREAdUU8FZR93J3ISqi9J1jw58BcSC8GXwRQXp6i0/V0XNZbJjmw47Wwi4t1xFoeHlfOkAwVbJTDQBYzWw/1fgHv7yJIehDe3AK5JR4u2mMJAsDXzSenGmrw5Rb1wMXju9Z9JmN4Rf6f03xMcLkKq0PfPyL9We2UnTWb58QMXaMAwwvttVkd/4yVK5nplQ/pFEaNYNcHp7Nog2iKNnydQLTDK10G6ti9DK+KsQUKcSQVcNkaLZ7Tv0e8EU/bHgVF1ks1s0/ah44rtkIWVFK7AELLQ5gNzfvh3lC/vvChWI9MyLjAz4PkAprSenBDrzjjW8uwfjWe0TGXXlx7NQZo7MmpKlkC0GgxxFxNkxfIHs+VUkCeXRbO1AlbL+i2iCvxx4KgjQKfQ8doEsVnxSbdbcfsOYxQZGOn/Td6VAbCUipXeO/Vw3GmzRf4LOoSgeLc5QPoP65hbmA8gQiSvoQ==
X-MS-Exchange-AntiSpam-MessageData: +hVxH3qjGMk3c9eSCNYbgZsorPbrGrgT2lkOJIrA8xzVXJfH4cDc+ioZuBpqHS0cuhS+Nxie8teUoCI4ZGBfNTQ0C3Nkw52iPTT6ZYCKmPg2guxe7NSZDe+v+Z6yaOT/8DdwPoE/DB0dWBmaCus60A==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feafd06d-0f98-49df-b49d-08d7a96312cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:12:08.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh8Y9KAdJZNQD+EObtifnAkDAbTOaPsXr86U8FWo99U22eU7xBPMwDsx+E3peUijOy05UDFcF0Aj0Ghb1o4j7QOxhR46cBZqRctN7AudyE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Computer on module Colibri iMX7S/iMX7D has
an AD7879 touchscreen controller.

This patch enables the TOUCHSCREEN_AD7879 and TOUCHSCREEN_AD7879_I2C
which support the mentioned controller in i2c mode.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7cf452ddaa0a..5a20d12d62bd 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -179,6 +179,8 @@ CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
+CONFIG_TOUCHSCREEN_AD7879=y
+CONFIG_TOUCHSCREEN_AD7879_I2C=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_TOUCHSCREEN_DA9052=y
 CONFIG_TOUCHSCREEN_EGALAX=y
-- 
2.24.1

