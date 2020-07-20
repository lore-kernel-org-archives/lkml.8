Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0146C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D612080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gfKdszcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGTJGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:46 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:30692
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728199AbgGTJGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBQc0YByJfxTFnErQeXzGAWwOa+c6yySDPS1UnTRl6IJuI5L6phCyFB3HyeOkjW+CXnddsobua8HNURI15rNQPzTzfVuKL0tEuRvqo9pB9FbRl0gyryyA0jLRvinrTIch4dIwD0tzqRURMQjJ5Jp2AkBtMYuR8YG18y49jnoKPcX1x4h3CtOVSZPzVwjTL0nNv4zCkMgwGY1jI/kQ4UxSaCEfLEfGfqrXTQ20NtCfvg4q1XUM46htOzDOJ5xoMjR94vgT/9wkUaUr6/EsHcQ49zfZ+Pf3pCcXbpfuk+y8BQO4lfcE6hJTqZ4S6ZEfXoWXWBgto8kgLdc7R2jEvnSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cdBvoqcm2N7236Wx/8Y1vELz+K7/q5quSaRCjCdGkM=;
 b=ez7dLVE6YIMA+dGJZskxl9ctB4Fnt85xa965GcvN3PYn7jxKO6VxyFu4+niXWVWRUsHwAZLMrM46DlmbfojLs194rRDLlPoCCiyfjnTeCvav2Y6c3w/iu/hw0q+xbPFsMnMR5WGd66/pi+gedxL3e8tw6uaHVaKn0GmmIMx19FbhJCi07GXYPenqO5NY4thrR3rs4v50VPWdsp7DPjqvtxs4fFHymEpA8wGMkz4QhingVb4FdfgeP1R0B8UJqQRt9J1igkpg/tkejVeEep978BGF2UfAaHxstoKJ4RIK2iPcn8E3JtWUwrWexArVIeQtvVwzwvdVNV03h+V/XPEmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cdBvoqcm2N7236Wx/8Y1vELz+K7/q5quSaRCjCdGkM=;
 b=gfKdszcWfsOmgo7WLZ9Tmgb3/UixA0Wx2j86VCkEDRVDP0mgg75HwfZRpiw70TjjKSiZ1Fz84XUwbH03PnWwiZ9Hl/YhAs5osB4c3iEksB8BofO+OXa2YNw5cmnI+043F0oaisBcuC8UfWWjSmusByn6U0zMdfnBX+bYmFT41nA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:25 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:25 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 6/7] dt-bindings: arm: imx: Documentation of the SC secvio driver
Date:   Mon, 20 Jul 2020 11:06:16 +0200
Message-Id: <1595235977-106241-7-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 856ced29-09e2-4725-d395-08d82c8c2e3f
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB376218A9F270D9EB58EE7C48D37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72yyxv8BWCJadDFRdfcZI53As5N+2zN7gLgi7Hkt5J0NZmQ6TiBX3Bzg/srKBszm3SjSNspM50Jy2riqv3UtfleoHGqGKGtKPZjn4HuCtovfErFoJ5Md/nmpmFaR7/+lCs9UJco1+oglVU1g5SkqD/XbASF9GviopPAnm/0NCA2wlHUi/wGV3YojDngGiDkcWpjh5Bz9orqevAkNm///MUslmFtA/dqIHqv36SdrOOxL4gg9xCFlMotammfG8zAqOTNYLxQ5Hu7r0JxOW7lsbH4eVjUM+h7d8ulxm7z1/X8Xugvwm+ZkZHo0bjdjXm1rYTrnlaLap7Il1GYrKaRfOj686CSDm6KpuEDt6FwnZg/STyPXt7RT12nZJ0Nh6PoT7zQseuPUyeGuBenpUHps8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(8676002)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(966005)(6486002)(478600001)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iePU5r+udav6sjWGcMkmseP563BiMmCEOxCCm57QN3Y6GNudT9Ri48Yn+wbdXPnFf+ijqvGlmsFm78KegWSw9KbNMVMFDNvQWnHCBNYwq/BM6Uw1zgVyKwGavV1vu4UrDoHSeRkrWhdNxSeuchHdpEDhpZLxkY30hhVRYCoUx2dm+mWz62pm8NGIgNsdcRE7o/cTlaWc7X6JjKSX3CGVFeTezvPcR9z7R/R1bIcecgw+AYvaBcPEFYpnWUEEdBCbm1Gy8mproaGK0L8+iCjyMQLfrW1vAZpSiCZJAJ00bkC45tZoccetCfgi468welqvOfR3pX1+AHD5zd6v03vWAzxH3lexZC5y+omQgB5JA0Pth05eBf3I0Ao3uvQUqnAGO49Cv4X/gEk+0SnkOR+k4lxhBhFAfF8Z0DNXZn9/WhCJ9BrEmWljU3FKHOQOfrxCnzFl/1dP58yLDoy28OV85p56iFtPt2y17CKdntV+qD8=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856ced29-09e2-4725-d395-08d82c8c2e3f
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:25.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4puxKMEP7qxIoWvsvgNIvc51WnweNq6fDHykOwrsQNBanPEAr+uQGGzm+/FnzXLqhDyTJSeidSiClgIwNNCuH/18kRKpauDP4y9kzZd+mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

This patch adds the documentation for the SECurity VIOlation
driver using the SCU on imx8x and imx8q.

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
new file mode 100644
index 00000000..59b9a86
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,imx-sc-secvio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Security Violation driver
+
+maintainers:
+  - Franck LENORMAND <franck.lenormand@nxp.com>
+
+description: |
+  Receive security violation from the SNVS via the SCU firmware. Allow to
+  register notifier for additional processing
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-sc-secvio
+  nvmem:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the nvmem provider.
+
+required:
+  - compatible
+  - nvmem
+
+examples:
+  - |
+    sc_secvio: sc-secvio
+        compatible = "fsl,imx-sc-secvio";
+        nvmem = <&ocotp>
+    };
-- 
2.7.4

