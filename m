Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389C5C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3C82080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZWuGLRvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBXMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:21:12 -0500
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:4353
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbgBXMVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPycoQhZKWh6lygN00NruP7+8pWqhUsJLfe+hWy6XPp0RRu54Wuodt2iaZre+gBwf3P5J+VHa7YAXANYKsxJtdbSv8XratINDa3QYztBpRgearui9/WaBuJkvtmNmaXXaWd9wsuhMXk+uGPMUC0BVVv7oXr2HIjKQNIfEGyEzSDJ6PMeG0I43bHtOjfV4WhptkcyqV8PRHFj52eSRL4EbBYvytwKJNOgBufv/O0RRYWDAbz27I4OU/5mRivk+RtemMP+YexdXuZOo6jBbgq1esK8FXRKcqasi4lAKKQji2QeLb1erpFN2mGnbH4gzVtkdFb/d4Qfiy+oXacoQyOHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHxcmVKGfrdDerATQ+EJ7vFcPynWagSATcLhAN8jaOQ=;
 b=nBv4xjG5I9gkelVbEuLRCKKoKPBpQ3Eem35DXtE7EQS/pIpyS0IYI2MsuzmtEQazH8wVezlCZXvA0C3EacbNCw2qZw0i+IX30RzeVRnLuqxz3A529dd4CzFOqod0/rDvIzq/O7LdSTKCtQe2p9IlA4ab39bxpGQU3ghIA7HlgLPWlGEkO37YVFB8TzHdqTMWaDU0lXlgnEVWCxmyiS5xo4AqexbPbuYMw+m5gdBgql1qd6vEPwC0CSiua+V5x5jVTuRl5NCn66f6QIThCRpzV1xMCKGU5r3meiZAiBGS0islFsCu8ZtFQdQd7pHdYix+uhUojG86/oGlAyNh4s2fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHxcmVKGfrdDerATQ+EJ7vFcPynWagSATcLhAN8jaOQ=;
 b=ZWuGLRvX8bd/KspGUEY++bBf/8nW8NFgiTRz6B/HxvnqNK/9t16/LC9uYifp7OUOXZitcLs5I88G7oh2pqjP6y6zHAhq/2GCrdbSPyjb8CdoL57XXU6VSdhSs0vrfGfiWO56yDB3m/SSfYLg7126Mi4XArNmjmygcvZY6RAMgms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 12:20:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 12:20:59 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, leonard.crestez@nxp.com,
        o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        m.felsch@pengutronix.de, hongxing.zhu@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] dt-bindings: mailbox: imx-mu: add fsl,scu property
Date:   Mon, 24 Feb 2020 20:14:32 +0800
Message-Id: <1582546474-21721-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
References: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0077.apcprd04.prod.outlook.com (2603:1096:202:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 12:20:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90f766de-3c01-44fc-d97d-08d7b9240130
X-MS-TrafficTypeDiagnostic: AM0PR04MB6289:|AM0PR04MB6289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB628998DC4D3DBF93227D88B988EC0@AM0PR04MB6289.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(4744005)(2616005)(6506007)(9686003)(6512007)(15650500001)(26005)(86362001)(81166006)(52116002)(6666004)(8936002)(7416002)(8676002)(81156014)(5660300002)(66556008)(316002)(16526019)(6486002)(4326008)(69590400006)(66946007)(36756003)(186003)(66476007)(478600001)(2906002)(956004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCAQsfLHQpSsjzWWFm5/YysXvQeBfKaQ3AWwQDA4lUBqo4zBvC2aodTIC3VDWg9rz/Bs3//1K8rw0P0eSL31yoT7QhqrChnedxa21SH8mTxQMYInDx+cTqPJM4zIW22exw3bg9PkIn3ss8bpy7lGnWA0eMZm9oVC/9lsOlw2R0GwI5qPiQjqm9B8WEEgWQe8fdAtcpK7waQzEfb7wU4KdDy5lWUFeWpgwnCwOTWgeHdHyUVNeEbmjZ+knLt8yOupcmoNFal/UgHBJop+l/DP2qRhK5hysx5/8U9xOgp3V2HlEmG7LQ7XhXcSOvfCyaZb80KVASKxjDXbCVCqRKn5IcQQ8jhfYwlZK90Bg+Zph825QxM55uCZIez1/nm6HyiOjkD7IfOhIEFFhx1Z3kMx+UFm29Xm2ZjZatONvtYteThsMMGkGFFKb2CfzeV4BFlfKVqzsKoHX6jSE7T4XZv8zYmPu9v911jCs5VdKnA0kTPBgPxFH9BoZgGjMrEVdJ3v5eIuyDJxud+Ti3jAM0h5jTi2K46IoDN2DLpklH3QeNDXut2iOJdbP4QwW49Fuh1I
X-MS-Exchange-AntiSpam-MessageData: CnYgFtliJlj0Hz9j/G4dvmJHJe0Cj5m4i8fPW2DfpVeVtVONPYEil4bSLW2oQ0lXsqrvDaUQzLCkUAD4zrna8YMBF/yHYdi/+UG9AKdrdBWq8ig9Ov/zKD53EJgpoZafwIbiFjkM0Uu6zVntGc5u0Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f766de-3c01-44fc-d97d-08d7b9240130
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 12:20:58.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owD5yGkxosnDYwmrJXZY9t16yz0KJxu5Ok2/NhyYj8e6W3HpJKFu/v37MxFsVfbK8ReI37/ZbM9PXEStnzildA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add fsl,scu property, this needs to be enabled for SCU channel type.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 9c43357c5924..5b502bcf7122 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -45,6 +45,7 @@ Optional properties:
 -------------------
 - clocks :	phandle to the input clock.
 - fsl,mu-side-b : Should be set for side B MU.
+- fsl,scu: Support i.MX8/8X SCU channel type
 
 Examples:
 --------
-- 
2.16.4

