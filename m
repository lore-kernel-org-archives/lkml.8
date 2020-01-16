Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5962C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A892075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E6bi9Nty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgAPJhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:37:02 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:64362
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731359AbgAPJhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaP1V70G5VYMR4CeOcIMM1CiDWyA4RpXVEamDnWW9Wfxk+phPqplNWSnUSpgOkeS+Cse3uRvsPA8896ioC32hmjzYrT0cl1apl9qB90unA3lMlkoqHa/phu4kYZ5hDLgfpqRXCGuev74Cs/9d8jNuIDbIiVpSAthjGCEkVk5+90G6TQ7oFlta6agZs32DK0EHJXPKWZjBcanFArhSJecWW0Q44zXzbEEEVDpsSeuSHeWsDWJWPkYyYyciMv+Jg6rDMUQXjd/ht22swNPYMtxrW/COSy1YSGpOmx7e7VC+iCT3bufXhmtQBlIAEof8tgZ7gTPSxEcAAzanx4K1aPzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlJoconKYcpTSaPKk3IB2Ja8D3tpGGcnW8ypi+qaPVQ=;
 b=oObD36QkZj6AQh4bH58kgsdPUgQgx3DkXMCE0HYgbYfq+7V/92HOPaJ3iecFECIxec+Ghk9oeDlAXVUP7SeyLF3eSDPNAiYgWDrn0Jkna+EwjfDtUOIfF7Ewc3h3gmybQASTDu2inTk/GOv2nlXtfwm/GZxXY7tTreX1kEjEiVdJfRtu+vxwyBPeNNqKZtmnZBt3i66oBUG4P+qwK3u5rvNQA3EbL5PvpFziw3PKBJHA2boPFv7+JgO4xxhZWhrNyttfyJ0A9R7AOBSxtGTbvhmm1w1BfiebqM/xG3IpNQwJ++DTJvN3yWjRbeGIvJjIotkLqA0WLTRZ8AN4fuSIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlJoconKYcpTSaPKk3IB2Ja8D3tpGGcnW8ypi+qaPVQ=;
 b=E6bi9Ntycb33x0JenSDvEjIOVVswUkZyKxjR78eUzBmo1V5FNbwMfjwBoe3BN4QHKa/sJWKYYzJMHlYjG5hsFKT8sE4Pr49DK/ShughgS0oyqlxL/s5fLUKDkvKYduWrU5CSYS+y4AXd6a8djqx4ZnMZ1vhHHqlCnCHP+ly1SUo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.124.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 09:36:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 09:36:57 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 09:36:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC 3/4] ARM: imx: move cpu definitions into a header
Thread-Topic: [RFC 3/4] ARM: imx: move cpu definitions into a header
Thread-Index: AQHVzFB+G3o1/8PlD0Sf3//E6frY/A==
Date:   Thu, 16 Jan 2020 09:36:57 +0000
Message-ID: <1579167145-1480-4-git-send-email-peng.fan@nxp.com>
References: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e41dfa4-2b21-48ac-ad83-08d79a67a14e
x-ms-traffictypediagnostic: AM0PR04MB4337:|AM0PR04MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4337F497D7540FBA27503BF288360@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(8936002)(86362001)(69590400006)(71200400001)(6512007)(186003)(16526019)(52116002)(956004)(44832011)(2616005)(6486002)(26005)(6506007)(478600001)(4326008)(7416002)(2906002)(81166006)(66556008)(81156014)(66476007)(66446008)(8676002)(110136005)(316002)(54906003)(5660300002)(36756003)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjHwxXi9OLfgWozZHI+n2W0hWQu+9DZZsngWID2s5UoGUaEXqC6HwO4iLwR6sop1pFhllhvxJjltE6ee9/Q53ud9e3yIBRgo6DyWSPm/UHqjSiiTYXzxvRzqckk1zOeaHN0wE62E5KMZvOyoMWvPvVyveraziW6YwwCo2sdYEdzv0/huwD40FoZGOST83upuL9emayNan5Oi6WE7ThQd6rx2UdmocDX7E8vtav69S/8VAY5ux8DgP2pB/FU93uMDi0RQP+kckG3og6s3Y53ZUuuKdkQ2EWcdPcr0EfBDTZBmugljB5D7T7NCf75QOcH9BHPnpHqC/xD6aWFf3ewBsV3N41bR2yN+CN5jyVHIwMCyfg/BxaX20XL+9SiXM1Ssll+SlE2557wqmx7aaSwqyWAaKcj9M1cj8GfvNHJqAagNJZecqqEx+XdooOULmJUyafFRBpFmQVFtYhI+eGxKaNjCqU2yFhBNuolqyFBjNzlxdbImoS2CRl+Y/Ogu+DV/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e41dfa4-2b21-48ac-ad83-08d79a67a14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 09:36:57.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALl+g3ALjXIZXavXA4/xVKtWHaW3K6dEEchDGfBdg6g7u+BvLVU9vm2FLfwQAT1MORqhyIo/LaiMQR88Dsue8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The soc device register code will be moved to drivers/soc/imx/,
the code needs the cpu type definitions. So let's move the cpu
type definitions to a header.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mxc.h | 22 +---------------------
 include/soc/imx/cpu.h   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 21 deletions(-)
 create mode 100644 include/soc/imx/cpu.h

diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 2bfd2d59b4a6..fe2d0f5abfcc 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -8,35 +8,15 @@
 #define __ASM_ARCH_MXC_H__
=20
 #include <linux/types.h>
+#include <soc/imx/cpu.h>
=20
 #ifndef __ASM_ARCH_MXC_HARDWARE_H__
 #error "Do not include directly."
 #endif
=20
-#define MXC_CPU_MX1		1
-#define MXC_CPU_MX21		21
-#define MXC_CPU_MX25		25
-#define MXC_CPU_MX27		27
-#define MXC_CPU_MX31		31
-#define MXC_CPU_MX35		35
-#define MXC_CPU_MX51		51
-#define MXC_CPU_MX53		53
-#define MXC_CPU_IMX6SL		0x60
-#define MXC_CPU_IMX6DL		0x61
-#define MXC_CPU_IMX6SX		0x62
-#define MXC_CPU_IMX6Q		0x63
-#define MXC_CPU_IMX6UL		0x64
-#define MXC_CPU_IMX6ULL		0x65
-/* virtual cpu id for i.mx6ulz */
-#define MXC_CPU_IMX6ULZ		0x6b
-#define MXC_CPU_IMX6SLL		0x67
-#define MXC_CPU_IMX7D		0x72
-#define MXC_CPU_IMX7ULP		0xff
-
 #define IMX_DDR_TYPE_LPDDR2		1
=20
 #ifndef __ASSEMBLY__
-extern unsigned int __mxc_cpu_type;
=20
 #ifdef CONFIG_SOC_IMX6SL
 static inline bool cpu_is_imx6sl(void)
diff --git a/include/soc/imx/cpu.h b/include/soc/imx/cpu.h
new file mode 100644
index 000000000000..0669fc08a501
--- /dev/null
+++ b/include/soc/imx/cpu.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __IMX_CPU_H__
+#define __IMX_CPU_H__
+
+#define MXC_CPU_MX1		1
+#define MXC_CPU_MX21		21
+#define MXC_CPU_MX25		25
+#define MXC_CPU_MX27		27
+#define MXC_CPU_MX31		31
+#define MXC_CPU_MX35		35
+#define MXC_CPU_MX51		51
+#define MXC_CPU_MX53		53
+#define MXC_CPU_IMX6SL		0x60
+#define MXC_CPU_IMX6DL		0x61
+#define MXC_CPU_IMX6SX		0x62
+#define MXC_CPU_IMX6Q		0x63
+#define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6ULL		0x65
+/* virtual cpu id for i.mx6ulz */
+#define MXC_CPU_IMX6ULZ		0x6b
+#define MXC_CPU_IMX6SLL		0x67
+#define MXC_CPU_IMX7D		0x72
+#define MXC_CPU_IMX7ULP		0xff
+
+#ifndef __ASSEMBLY__
+extern unsigned int __mxc_cpu_type;
+#endif
+
+#endif
--=20
2.16.4

