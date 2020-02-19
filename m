Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950DC3404F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7D9222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LHulx4eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgBSHdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:33:50 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:44169
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSHdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:33:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwl2WDnhWHSktyYMtgf3eYRJvhOW5RFm/qLijcNknvESgnYhTO82p9+dVbTqUvPOBpfFRp1DWrUcTql7UjaKQPkS7OVxhe157QGXysAPgteZCRmw6O7LcVSc9s5GRPFBijA/ygWmYnxMg+Xy8FSvPpPK5BU/7SDRFfXZV9Vnag8ZItma7Mis1l2zIAlmr9dY8l6vAckAdvDx2G5awEFgjao7XTbFOPYBBapg+nAHeXwfCN8DIdymB4vctGQ0Bave/GAIa/wmG8sDsFdNa2RiNbE40x5kOo5V2OqL1Ja9ECZ+rFibrTvGx12ID0qHDFs1t7QaYI8KC6JTPYsEQQtHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MJu2Gqo9PEPupr/NB04nKB7lM0ivhY3/SZe4/3Nzvg=;
 b=BrRpEhg10itNzpttIwiDDEwLetdg5MDswnoaXc3gM9Pm1UJdfDoLaNvqJMlInY/VN9pQFFs9UcFq2gmPRgFDH1PzAsjYts/yLwicpoDSlEemDosla77Uv+T3Wsl/9p/nqUm1qepMhWhcXK3mIzhV7YNagKQTB33wMiVPIhWqA9zEa4vACj0ba8yXF2eULmRV8n3cxg8riSs48SmJ11kGbT3MNZMO+sXnptDuQZCixV7NdVnAt5JWE30HUePhf69z/BXkJa0E0ZTi6k5sj5dZMo4bbohiyBeKVGlwRpQW+rSszf4P5N7Wpt29kteAzxeN6NHM2oauscQpjquOSOrhnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MJu2Gqo9PEPupr/NB04nKB7lM0ivhY3/SZe4/3Nzvg=;
 b=LHulx4eqdGUks/B0R+eRHEBE9hXarPYnkXMRdzD5WBTGivOncpqbZk3IOFS5NsqiQ+PzODoWY5On6d1KXX2tY0Vo2C6M/d0z2V/83fxfo3M2OF0BNIrZtGYjTB/YmkHmBBIABfX790ZBAlW29nxW4oWOizXVKjoFDQKMITx1roE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3969.eurprd04.prod.outlook.com (52.134.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:33:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:33:46 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/9] dt-bindings: remoteproc: imx-rproc: support i.MX[8,8M,7ULP]
Date:   Wed, 19 Feb 2020 15:27:38 +0800
Message-Id: <1582097265-20170-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:33:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc12d2a7-7da0-4fcf-4cb6-08d7b50e0dc9
X-MS-TrafficTypeDiagnostic: AM0PR04MB3969:|AM0PR04MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB3969F193BBB261C16156BEC488100@AM0PR04MB3969.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(66556008)(66476007)(8676002)(478600001)(186003)(52116002)(956004)(81166006)(81156014)(7416002)(5660300002)(4326008)(2616005)(66946007)(8936002)(16526019)(316002)(69590400006)(9686003)(6666004)(36756003)(2906002)(86362001)(6506007)(6512007)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3969;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtdf1Do9hVjh8HcjRO+N03E3Tl+8cEq7cD6KNB6j3zcBq4Zk+qlqRAGDFQqd3AeiuhhmkQYTAa2qhnT0pY+lrUOHG+/mlAjkpgmcPp+5v+gV1wIxYQNhUg5X+rlXaltpkLlOW20neeS6PDZ/L+fmvqwNJDb72HkDU2qUzjjNho+jZ6NWConOvRUYXF7ITNDtRbUMdYLg+b6QjoaIDMHKVF1HKdbwWPmbI4RdZa+/xhxc1fy5bj2qHlm5zfCrLZGrCg/Aeh/Nv/oroTEzvOGwEF2Uatu3kthxKyTokzWOe6o+efUv6oFTAzUuv5e9ajZ80ZqsF9RPCpMQ/d66RAULza5Wq3neuMn42UMEjxLxq6MxPRFwaKup62pMNOypGsxGC3TdfUKDV1wC06fwJw4intEzJRpKY65+5kZjK8fYN3BzLW9+bfy80OpwZBS3lbVFu0W7+eCUVaJCSLRmo03uIfIWtgdwoh6dmC7U7n6jofsqR0u8Gt27Zyfd/Vg/2wWYKfE+dqs1XlGnd2LBHlB5PzuMLmmlihgw0t+eL2qO9cg=
X-MS-Exchange-AntiSpam-MessageData: 24Nfrdg+XD2VIjvLHMzSYkIgLCwQSt462Vann5SCQmEOVL0foQTQ1uoG3g7Kks4zDSqYzpBFbxrDH/QX8nEqFBwAmK203lMqd4ZhwZtXpZI3qynPwBHJK1jdHH+ZqIeFzIR7WNSPK2zzWBV7KnsGmQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc12d2a7-7da0-4fcf-4cb6-08d7b50e0dc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:33:46.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox/EimDem/RbtzZQ+TzzgPLxeOPRnbBw8+K2d5Ip9xFXjZ31rc3PCmvuEIsuL2l0RXNq/nx5LqETEOw5/5HAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support i.MX8/8M/7ULP:
 - Introduce early-booted property for M4 booted before Linux
 - Introduce mboxes for rpmsg/virtio to communicate with M4
 - Introduce mub-partition for hardware partition supported by i.MX8
 - Introduce rsrc-table which hold the resource table

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/imx-rproc.yaml  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
index 12a5f3de38fb..be708130d5c0 100644
--- a/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
@@ -19,6 +19,12 @@ properties:
       enum:
         - "fsl,imx7d-cm4"
         - "fsl,imx6sx-cm4"
+        - "fsl,imx7ulp-cm4"
+        - "fsl,imx8mm-cm4"
+        - "fsl,imx8qm-cm4"
+        - "fsl,imx8qxp-cm4"
+
+  early-booted: true
 
   clocks:
     items:
@@ -30,11 +36,39 @@ properties:
      allOf:
        - $ref: "/schemas/types.yaml#/definitions/phandle"
 
+  mboxes:
+    description:
+      This property is required only if the rpmsg/virtio functionality is used.
+      List of <&phandle type channel> - 1 channel for TX, 1 channel for RX,
+      1 channel for RXDB.
+      (see mailbox/fsl,mu.txt)
+    maxItems: 3
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+      - const: rxdb
+    maxItems: 3
+
   memory-region:
     description:
       List of phandles to the reserved memory regions.
       (see ../reserved-memory/reserved-memory.txt)
 
+  mub-partition:
+    description:
+      The remote Co-processor hardware partition which is only valid for
+      i.MX SoCs with hardware partition feature.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  rsrc-table:
+    description:
+      Resource table array is required only if the rpmsg/virtio
+      functionality is used.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+
 required:
   - compatible
   - clocks
-- 
2.16.4

