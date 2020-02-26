Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B1C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733E21927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pd5RZqHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgBZEqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:46:51 -0500
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:10942
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgBZEqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:46:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fueg0Iwp3cEUogk0WJ9yTF1Oc/PRqzsxhn3NkncwzxvYF7pBPis++0RaMCoMREPplVJbHyEAkWeXwpdEwLkYRrMB0iwLCKNYKG2eu/hKkf1YV9TqMLGpxZLRBIw7UAQwx8mVeP+E2zE05OIV9OEy8rXRa9Yd5IfeE4QgIOtMdu9Gz+qJQ7q3N5aua5F37fYprtJBZnStfSl+aiknxo8+SVbEmGuhTQTRWvisIWjDksrgXcGlA4m2/cjHVWt44D2pFt19htCYy4mSiqRkoV/49x9NnNNlyxspsCcpDme7h6kHG6OSIUJlFvsGBVku16rpw/4npy5US2TIDKSJ5Oi6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZT/kpWbky4PBBxMhfp6SQau3eA2dkkcyCx2boASfgg=;
 b=Qy79zhR2cLNX19MB1YAdXo8VGAQYWkW5XmNBM075iKXf+9m94K/bSH25htqQBbQ4U5e0/BApSnRHDb6vRKrGxUEOgz9ibLQGSN7++FjxBVWZ4HXgYfuiTU8qAJHdLKg38h+S/0uWpdUB7kefSPGME9pajtzdEMoSLv0o777OSncbDwKPEA6dMXrqvjoLY0ll59VvZsYORA0XVE2qlwQnGcnrLTHtv44JsKg8OoUkhEtpoQgz9UOdOJft48jCDQnbqcOIPkgXqIxA3YZ7bpL6pwUydCCTs5PVxSTX2NCNCEGp/YFIYtwPmc2d/1T/7u/ytiO9TkxQHA6dE0tma80vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZT/kpWbky4PBBxMhfp6SQau3eA2dkkcyCx2boASfgg=;
 b=Pd5RZqHBvB71H9c+fD1GQeS8Eh8epLRPAaj231iajMEv5Sh09Ut7l9AGxBmqZV17ZYFOolVllWByP1J0gG6HBW2AJxKWehfyAxuqq3jsxmAZkLy+s5xIqZXnnPXFVaGZ3bhoeHrAYdfmWpnb4sEn24VcUCO0cK/5LLr+L94nB7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 04:46:47 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 04:46:47 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/4] dt-bindings: mailbox: imx-mu: add SCU MU support
Date:   Wed, 26 Feb 2020 12:40:40 +0800
Message-Id: <1582692043-683-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
References: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0135.apcprd06.prod.outlook.com
 (2603:1096:1:1f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0135.apcprd06.prod.outlook.com (2603:1096:1:1f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 04:46:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4a32344-1fe9-4c7e-8157-08d7ba76e2ca
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:|AM0PR04MB4291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4291CA2083E2A814A319034E88EA0@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(69590400006)(6486002)(316002)(6512007)(9686003)(86362001)(8936002)(2906002)(36756003)(4326008)(8676002)(81156014)(5660300002)(15650500001)(81166006)(52116002)(478600001)(66946007)(956004)(2616005)(66476007)(66556008)(186003)(16526019)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIUODb2YoYd6a/1UIoID9CNpRGvKLGygkfMJjd7iqZ6XylICGXoOJMiNa8ybKhiyvmv6P+EwP65dkjuZ838qxmI6TmTUZ+QZVmCAAmLAqJiRF82mcOtdGrHsJlLOLXzmmLc0lGfc7eOOIvxq93wYRz9ZeN+VXHvMT+ql9ICQ37SZkjZNMS8QzCYY4GfTcDsc2UuVg89L19IIjENDoNHwuv1bcX0YpfTcVTXX48/DQ4FWtK9alckO8GzLvCKs+MJVdQXK6InGwjfi0walNkbGhqIXWD0O54AGQE+JK4HhM0DjJxBXiRpqVL2JfQSPYAMEb8aAYCjDNHNlBFT5X2F+bXlQrbO6pIBq8NA0EgFe4BWTkxkIp1JeqGosg58hAffY13JWVYq22CppFm5lokuMLOQJ+mxaoHrRa69YEP9+LxgRAON8B4GZI0Viq38bgY/KXG6kElLWPUgK5AJEBl2+CmAXH537I8BBNxXdmeS6Xl4t/nve2DxmFUkiKCe9ubBms/TYetBY06l2Hj4YGYn1GYYxIWdSz1BVE3RpmZO4eyY=
X-MS-Exchange-AntiSpam-MessageData: SmZuh9uWhlr+XbpL9qbP5iuQawn1Yp+4B+TkOSAxj6vpmGpbWq2lTWRajhIZAuWhTbYcMEENSvo/lg7Z1+l7/w3R/h6ly6oBRe48d1+g9O+PU4Dq1fgjJkFg2WG313Vylw03y5ktO73SNq4WeZ7DXg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a32344-1fe9-4c7e-8157-08d7ba76e2ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 04:46:47.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uefZZMkiza8RWRUkrdfJnebUbhZT7KSRaFGgMIpHRi8qG/npTm+GbvGZjdVtSo5GH8pqs+gLBxNK1+aFD0Ki7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8/8X SCU MU is dedicated for communication between SCU
and Cortex-A cores from hardware design, it could not be reused
for other purpose. To use SCU MU more effectivly, add "fsl,imx8-scu-mu"
compatile to support fast IPC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 New patch

 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 9c43357c5924..31486c9f6443 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -23,6 +23,8 @@ Required properties:
 		be included together with SoC specific compatible.
 		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
 		compatible to support it.
+		To communicate with i.MX8 SCU, "fsl,imx8-mu-scu" could be
+		used for fast IPC
 - reg :		Should contain the registers location and length
 - interrupts :	Interrupt number. The interrupt specifier format depends
 		on the interrupt controller parent.
-- 
2.16.4

