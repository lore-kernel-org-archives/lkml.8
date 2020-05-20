Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB2CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487192053B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJTYkbeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgETGBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:01:36 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:6240
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgETGBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSb7B0a0SpZrupKW+rGtIptVRRqk88pftqHDz7F4XDJRT8XdFfwS6O4ExOwsb9Us0oBbx1hsRga4NRJ7QakYD1QynaHpubpoNx1EFV+fFJaFuQtOI6g3fXPqTKoOIG1oaPpARF2F9NrN/uQFviJHZIXaFDuZw4/WGbTRscuanogsk9c9SVIRuteu3oouBPQA7qD93BGf9MrbtktviKV06reMq9L/TujkLbLiLKpAVQm5sN0z0x5YlvtBoLEU7dHuTSsUdOUSFji/cV0HWmjowzqjQRSFlwMbvdIJ18QN4bWaBpAUlekVhZTpaKkkMUEMQ9VSc7/n7MxKqrKkonXOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO+ZJwaqo/jwsFAgbxJpnhA0S+05/BD1fyNiDWk72Zc=;
 b=XEvJw/aR2ImEYhqONgDCyc+MjSnOg8YmO5I1Ddd5DeRImxwO9K0o/ajEC99X+eC1IgLrVt8RHg+wCwRMkmh+Rum9uDcyuuBsHB3CBLqm/hyBNJ1/tGuKajQjwvx+AR1HvH7ZclxjDi/RNcr71+LD1mygt0szV1C2QLxerMD/o48qJEO7zcUDRvRpN+o2hn0eaIjEQ2GGxd/icfHOfzL64fuzShdlX3jEuu+lRuwtD2CD9TAkaliTvuW3+igxVC/3ORvylsu1WY/kc8EmDqY4lwGiGugWtEjTAuoFZn/Le9VjRhkyacwQEdMv29nedcI9Yt5sxgLVKikXHxGtPrIWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO+ZJwaqo/jwsFAgbxJpnhA0S+05/BD1fyNiDWk72Zc=;
 b=XJTYkbeLPk1U3NKlmJYCyQ9X2sqx89hRqiY3ru/InCcB7W6AQ1dytV9Bt1ZqAndYf0AOvki99k3wE5C2FddFHyAB7laq/WYr/uj8GsooAFfs6OiVvLv/XUYE1vj5rCu34GACdC5j6E56agVVfGmi26oB7jUiMKofPrUIfrE1vxY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2790.eurprd04.prod.outlook.com (2603:10a6:4:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 06:01:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 06:01:32 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, cphealy@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/3] ARM: imx: move cpu definitions into a header
Date:   Wed, 20 May 2020 13:51:28 +0800
Message-Id: <1589953889-30955-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:3:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.31 via Frontend Transport; Wed, 20 May 2020 06:01:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08a32479-0450-450a-9043-08d7fc833efd
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2790D8F10DB95FF0CB5858D388B60@DB6PR0402MB2790.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwFkwDi4b9hmfE4hToYK5FzULNMYvGmFqK6VSbtTrg0OAeqY73uNsNgC9OZON/IxkfZAXEyF8ETQOYYuilmO45bpvgeQ2mA2SemLXhbliB27zInaFIV2+J/gv6baW86zL5wtwVsAsA4rv5+7mdBLsCawhWBLawQiaMxvX1CWYeytw4VlhtjTvg7os5HCjRnCNFphcG2Wmu/IfAWOgG7lQtBBxbPgx+nzFxx7yNa/emioe71FyLzKKfU3U4s1MyousibU99mIYT3OcgAqAzUMkiMLEXFuAXV3bEtI1UDPKp3EXICY7M0MQq4kg5HvquQoIkV7ekV1S2cw5IVnJO7k2kUdbqBmbaFFMD6nlB9NSyWVWR+eyypX1UZ0I4LFXfDjAAZnAlPk9R+eJSwfIbDKE6X/xcu3qDMBprKApFe2v96OzpS19vW5UXz7cIbtL8N6sQqAPBX7dIjQ7YMeT9w2semOeSgYyBf3rD7EulQcpe0NHdH2/1rOmrtgnm6a/pIY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(7416002)(2906002)(16526019)(186003)(66556008)(6486002)(86362001)(956004)(66476007)(2616005)(66946007)(69590400007)(316002)(26005)(5660300002)(4326008)(8676002)(6512007)(478600001)(9686003)(36756003)(52116002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pqfMFHJn13pQlrUxFXfYRgcHe6u8rJq0coJGNI9Sx9nXmtAuznFKoqCIYKEsAMcaBrerh0Hx/zxnGr7Og0YJr1O/nsNyFdnbvOFznfiGqlznv0t2yT4DdOb6kXyBkUej4+09gvgIJHb5NWwcfno4eCUJ/gxbrm2locUGX0w/otFNisLU1ybUYHX9PC/0r8OO/QYL6w4u7DetrpZ7VCz5FDZEGjygtOUQe0+nX7YX7tHiAkw3bLd227b3OwNHUVk0iLaAjMP8ZHwmvZp67+9djL5mpp5rMEqnbnVox7C1KLWDALd4M41/qVu/7g+/CldIK2cPcyHKZlG8Jv0dXTejkA3dVAAS+xTjX+FIKU8eokPLMh88oPXb5u0qNheYOx7oRyzGALGjlgbnw33r1HDv6bk3OoDcF7Ap2HGD33G3ascVHBGC3vTgCDI2x5NcW9dqHzXrcchc2VuMxlirZMQnMqKCMtE1s/vrgr4Ec9wYGEhF/MnxNIeeGjmreaMeM5Uu
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a32479-0450-450a-9043-08d7fc833efd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 06:01:32.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYVJCsgKRWvhswEK+hlccibCkLmkam06/adbs2/kURvr1QwAupwMOV177JQ0qPOfnUKZwV+OV+QhbjJJ3eKjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2790
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
 arch/arm/mach-imx/mxc.h | 28 +---------------------------
 include/soc/imx/cpu.h   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 27 deletions(-)
 create mode 100644 include/soc/imx/cpu.h

diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 48e6d781f15b..fe2d0f5abfcc 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -8,41 +8,15 @@
 #define __ASM_ARCH_MXC_H__
 
 #include <linux/types.h>
+#include <soc/imx/cpu.h>
 
 #ifndef __ASM_ARCH_MXC_HARDWARE_H__
 #error "Do not include directly."
 #endif
 
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
-#define MXC_CPU_VFx10		0x010
-#define MXC_CPU_VF500		0x500
-#define MXC_CPU_VF510		(MXC_CPU_VF500 | MXC_CPU_VFx10)
-#define MXC_CPU_VF600		0x600
-#define MXC_CPU_VF610		(MXC_CPU_VF600 | MXC_CPU_VFx10)
-
 #define IMX_DDR_TYPE_LPDDR2		1
 
 #ifndef __ASSEMBLY__
-extern unsigned int __mxc_cpu_type;
 
 #ifdef CONFIG_SOC_IMX6SL
 static inline bool cpu_is_imx6sl(void)
diff --git a/include/soc/imx/cpu.h b/include/soc/imx/cpu.h
new file mode 100644
index 000000000000..42d6aeb951fa
--- /dev/null
+++ b/include/soc/imx/cpu.h
@@ -0,0 +1,36 @@
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
+#define MXC_CPU_VFx10		0x010
+#define MXC_CPU_VF500		0x500
+#define MXC_CPU_VF510		(MXC_CPU_VF500 | MXC_CPU_VFx10)
+#define MXC_CPU_VF600		0x600
+#define MXC_CPU_VF610		(MXC_CPU_VF600 | MXC_CPU_VFx10)
+
+#ifndef __ASSEMBLY__
+extern unsigned int __mxc_cpu_type;
+#endif
+
+#endif
-- 
2.16.4

