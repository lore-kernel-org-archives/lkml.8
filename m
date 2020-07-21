Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9964920771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ibE87Yvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgGUPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:20:54 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:28932
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729956AbgGUPUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA/n3Ip7UaNM+1ZHmErY4GfM6ztxECcAwNMJrPrhoe8sTsI/MsYZgMhMBJ25CJM+aqzTGpfKCFP0vM6893ymfS+JqRcJX7AKoHeNdCfD0To/BnyxyzsOvV87jyZduhDEcCF9CWrsaGlwcHnkW/7WjlrFZJmoKETL0caMTfzvfNhkECM6PCmwPgXf6ohGEYlk6NqnB8RxaEnQwPSs7GQ66McBpfHWOsJtaW46DbgSM+mTp8I1rEhwethBtboaqP0lYqRJKqHnycstwk7H5vxsEzKpJrfouS+DIQoUEfmenGzQNUlM5+JBNlZA1bpQX81zBArcKZR60PnxFXCqKB9QLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ8ScE2rDx6xvAGDqZgv2yBADWxMiDMCXHu5TB7CGhI=;
 b=CAVJHyuTi+Rz/mBwoEdAj/aKd0n11H//oiXCDdJ99OYsQ5woRrV9YJrKXWoZdaO7Yd7uejZXpHo6OcTs/t3lnfK1WaieSTRhmTGf8JA4c+sXfTuYQAvgsJz+MwydGXEgzLS61vEJ394ywJri3SarCEnbdCBXz0F2dkflgna2ls9fpR72TVrqgmROM+gQNJHmj56pE5eEFLzs3b6FHLl09zTX7dxvkQ6Zdx2SL60jn3TkdxoEWNQKWrZAgFply1mLonCc/89ou/sYf8SEA7L+z3je/3EfZKIGfgKQE2BEIc5Y06yvcW/Psl9AUwNpn7co0fgUhf1uh590r+JIgn/Qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ8ScE2rDx6xvAGDqZgv2yBADWxMiDMCXHu5TB7CGhI=;
 b=ibE87YvhpzxwF4mvkVkPCTJFuIKM+3oLpy2tYdmVM95tMoFo/ONC25yHUIny0oBUMV+D2rTqg7Hk5mNwNj9C4Il+YDOWfqA/uFxIcqmk3vn3aG3BDZ2vrQuOM+8DxIvyPHmx72DjHIf0gs6iE112syrd7AsQANCKC16teuAeSHU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6212.eurprd04.prod.outlook.com
 (2603:10a6:208:148::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 15:20:42 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 15:20:42 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v2 4/5] dt-bindings: arm: imx: Documentation of the SC secvio driver
Date:   Tue, 21 Jul 2020 17:20:34 +0200
Message-Id: <1595344835-67746-5-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 21 Jul 2020 15:20:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd75c127-abd0-47a3-2116-08d82d89a187
X-MS-TrafficTypeDiagnostic: AM0PR04MB6212:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB62121BB52DAA9992FD2C8DA3D3780@AM0PR04MB6212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMa3gBrOA5MGoy1eHM1+jCgnS3ATSQX3uGTpv1ZyNXsVNdQSaew5b602+kXwPvvdu9LupepP8YTQ9DHszumYzjGKaTiQzBO0WhxKlwbNeYGuXh1e3K4az8A88pf+qjy8Cs0nYAtWpRrU9zOA1igDioTimca958+dqcUAwlznKC71J3Ee/QAbdudxYDaPOG2m54EHmUECR5QCHr2Ahwac5tdazdDtYvZHRClFbmOd8ch3M9ct7pJ82WQZSdX7akAE5zKaIwww8DOsbNJPqaa0VWkCzAMosZjUGga7v4h9M+/lbJogZUwBC/D22dceEX5+WomgukPNWsObQWtHC1dbc2qVo/aICg5dcuwqRJJWCvhX5qRMaF5tueq5RvMqXDQfOeSctfDXIk1jHXZmvuAesQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(2906002)(8936002)(8676002)(86362001)(66476007)(66556008)(316002)(6506007)(66946007)(52116002)(186003)(26005)(6486002)(4326008)(2616005)(956004)(6666004)(9686003)(6512007)(966005)(478600001)(83380400001)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ea1bMkNKFtiEEI/VCBZ37qo3Kn3IFxQCNKkYuxN6M88Wbrja1vNqWel2ZNvlKKB44RFYR8N+xrAfwlk2h1jQDE3tfHgtj6TIJHys6sZ0zKZNFhpFznpf3lfwNDMjkcL3a9CFiR+we26o/oi6epcHXOixJC+R2qVbIt1p96nDNeSIleBcIIpzsklz9SN/vEwJA2r3ktXJkH3ZWDVXEzKT2JUj4DO7hlpJWT1VY3CC6aKvmBsPTsFBgKh+VniHdBPKXlu2a4XZhPlEch7eAbw96bFJUWqRnqmq/TpVTK5DoQvVqi5ObQ+Iw6QuLVZk5tsxoqFMtLcUf/hfJ39ORjHfSvjpdY127ImkhJ5p4Kkv1iJQs3wNUJaCt23K7bRvIkHVN3gKXnaUtimQbB1V/wBVyptjCFbH5m95RFAWUQGifEp2v6XhiHY8YMxG+lsmV2Y52R6cfPPEp1OYY2G6+FfkIZQH4wN7pfiHluGZAtSBfjg=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd75c127-abd0-47a3-2116-08d82d89a187
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 15:20:41.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTZEk2P34PFmHJJCsvngYlqu1GLs9XKlXwKNVOsTd+j9Ofte27Xz/Qy8fgWSzBplw1IPTsZgqZsKcQj/7AeBPFp0zfUPSyJ0DcfHmY73Scg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
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
index 0000000..59b9a86
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

