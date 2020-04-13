Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F21C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB71E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hviTTqyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB71E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgDMG5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgDMG5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:57:30 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30065.outbound.protection.outlook.com [40.107.3.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E69C008651
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnmcmVa7G7mKIPNiPkHD3I3ZwsGkVsg65TNiQTJ8r1gP60/oik0tKD32L0oTImcFuWCppZdt5kzU+mpLFxVmzatTyTGb7HpII9id0oxKbLgyJ5OWxlmGIiebBQdT5ys//Jg3IP6tAUnX8rmJQSUIErWZPxbL5EwikaFqlfFJ/jm/OBUCZgUNoX2lwVIQeD3WOB+7SA8JZw1jQPFPZ2ywbTcDqS71Y2Jr+XDo4WJPU/dJ31QRkJ7Rh4svA2yrVSC3Bza6ZiRTwtWHUtKjbXH1weiPnwJPFMLPOw6+FJx+jx19boC5TVm+O8Li8mLDGtK80LUfdaiPdvRHoQEKZNqnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOUvGQcFCI4VGVxKBmKJxz9nyt4dSetVyRYay1YvnBY=;
 b=NBksdiAypMHxvko+nAYZ4ON4UPX3NEEaPya3EZ1ZH/ERqTK+7C9px7gmfY+3phN+4DbqwtKeskRaaFUDQyQtT3mtO2O9zwOMt5G2z0DjE/1xA6VQVHREOZUb68u6wK2ZIkBS4UERtWV8mHNo9kEIEYyViW5dcS5nAmU7x+Jo6x7ngNUVYEu2AURpe6XW5/BuHP7oDL2lROPMBEjs8iIRN8uPmntw05kXqH50ylBeyRhukN2mQ8+mlhz1OO6vdhjY4eQwsC/PrVZzE+E4Arol5IbsrT98vgLeqo81UXrfkm3D0e4BVVMfzP21VO4mpoyeMLdCKAtU953ciRiOLaO4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOUvGQcFCI4VGVxKBmKJxz9nyt4dSetVyRYay1YvnBY=;
 b=hviTTqyH76Cdi/m7fno6QUTb6qkjCT+aKtaPPIKfu+xnGPls3f1YV19bwmim5UjdsukVt47bq78UE9IO2FzGxvqzrmdZpm4ot4b+aJ8aekfxJHbC89ARqq91axGadna4p95fUN1wHTF9AQt45QCgemuJwnW7Mii/P6gDonb6Dvo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB4564.eurprd04.prod.outlook.com (2603:10a6:208:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 06:57:21 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 06:57:21 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Date:   Mon, 13 Apr 2020 14:49:05 +0800
Message-Id: <1586760548-23046-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
References: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 06:57:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48266a4f-3604-4685-7117-08d7df77e9ca
X-MS-TrafficTypeDiagnostic: AM0PR04MB4564:|AM0PR04MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB45648212FB184E09C7FA826B88DD0@AM0PR04MB4564.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(4326008)(86362001)(8936002)(478600001)(9686003)(316002)(16526019)(26005)(6512007)(6506007)(6666004)(52116002)(186003)(966005)(8676002)(81156014)(6486002)(69590400007)(66476007)(66556008)(2616005)(956004)(36756003)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyefpIUYoddu9GW/Mra/DWfM+MvaXdICCzvmjLfDXZ5C5L3l166w4mYF8rHyLyGgEzCj8vIKdzPAjFsoHEnNMstdfJ80aQCe5rQ7hKUK/CgdNrjfSGiu2wTPXbPi0J6KDRe0nkDR3bFjDnecQa52k7SvIjs7UzkCzPhSmmH1fK/ATQBikxu6gmEzNpajxBX2mq5K8+oDfvLjQxqBI6Q2PvqJgfZ2ugB41OY+jSB9pSdYoNyWTS3DODNsQePc9hebtmWgHwormhy22c+Z1URhRIy0DK5/gKBIwE5iMCKRs+TGT8H4EgHqoy0LeQjf4CV146c+vDw5I/lnYObYdoQeMJD8uqlDW+AHiEe6MZqkoHuQ49YUHbemqdp64U+nyx36DZqIqdPGZsr59+Bg2ObLF6dKdZBsfBO1bGJSFi2snRuPV55PH2+HAEwz4Wk1ivnkpa9rQr6Qm33AgNQuNyNJ9SN4TaRanPq4ey7qUzjuTQgPONQJCVeGmpbNwsHvaNmljE4e4/pe+sTLIJBCTFql4GtnR4T0YJRU5RbJYi+b8D+ROFxTCFiXO5+1MXd4vlUR0U3VAW4C/nKjA6t5GiHICw==
X-MS-Exchange-AntiSpam-MessageData: CfpCet6f6GmSYxgYMJCArhswNh1RqI8O6wQX0Kiov13HQejz/o5NxkXeSfMtey+QUQ82VfCurGViZoL2X619l2j2zMX3BxKHgeNeV2FUoR8gVnxsPaj2O6rlNfoc0dKC3J0Bj1DAunCPylLuRnUwnQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48266a4f-3604-4685-7117-08d7df77e9ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:57:21.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wb7bmo47i20WGN5MnsJgNLMAlDq4gv3gd2R7N6RN1Wizh9imETT+dpqSzC2hh6MNkWd/uKiJFLFWl1wKo+XcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP Power Management Controller binding doc
pmc0 is used by M4, pmc1 is used by A7, they have different
register name and usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Fix dt_bindings_check

 .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
new file mode 100644
index 000000000000..c60903039718
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/imx7ulp_pmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX7ULP Power Management Controller(PMC) Device Tree Bindings
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx7ulp-pmc0
+          - fsl,imx7ulp-pmc1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    pmc0: pmc0@410a1000 {
+        compatible = "fsl,imx7ulp-pmc0";
+        reg = <0x410a1000 0x1000>;
+    };
+...
-- 
2.16.4

