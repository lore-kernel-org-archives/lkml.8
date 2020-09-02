Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401EBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159DF207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T258nlBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgIBPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:14:31 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:31663
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbgIBPNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka4WHpf+eK5HAH8PUiG0AkMc0iLzI60u9VgpXn5IoEUCNoeOhYK6bTXdiWMdHEtX2OV88fZWwtImTKGh/VJAGuyH0R85YrwJYnArGcbm327I0yMGidBfdMcAdbDhcNTWqE+sdc4LtPBqfwcDoDHgKSgOo6zOUrpxnnHEXIRx4FHW1HrwGUkJJi2PUyzH2FiLue2+SHnkiOfmE70qzVdcebjzL573R+J+hg3WX3Z5Vl24Qe6WwxBkoG6UW0uKOW6yMJPw8c02SNIAysEfMh7f014f2o8pertUY6m9/GHf8m1vQxpxk0iIBqiWlEgL1sZ4K4zWgLT7o1co6ZhSzdQJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUKk4CDxUn//JaGG3abfJhc1RqmCVGzArMGsDhB2kKQ=;
 b=HkMf43w/88KL21lD5El3gE7wZYVBEe65E1kI2YIRb6HMNIhpee1vQLwf/iwzsLGR3cSCpVw2TCUUU8KO3AW3N5cdphu7un8G5dOysJlsyEF6Pf9vjwt/hhUyGwjRXYZUL+/GAg3XViZFhzZl7V/GCxj8TYa9Yh93pdAAVl+KroJ/gZEniCRQ9ALgp+pmZkgEXenFL55Q3kCM8LdpQYKCUp3zLSL3htB+g0xFODkKdURm2DdPaMH1zafP+bmw/4zqeGa0Mb69KmViPh8G0ad95tZ5R0SW/i8OIkY4dzVWyrOFd5Y+yy/qnqYyHYmGUZqr3sac59GuSeiGx2LYWxkmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUKk4CDxUn//JaGG3abfJhc1RqmCVGzArMGsDhB2kKQ=;
 b=T258nlBgCxCQ2DVSiG40kEXZY5iuKrN2Vma2bZcOoAMluGYVDGYAf/EcfcrvdP82bifSE2MXxT2BCVQuA2m8a40JBhKHNj3SoIx8waP5gCL2+ofwEbbVdkNMr/OGfEslOoehLLrHbOnV7KSdME5VagQigpKLP/Vq7vHTswPBInc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 15:13:45 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 15:13:44 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 1/2] dt-bindings: arm64: add compatible for LX2162A QDS Board
Date:   Wed,  2 Sep 2020 20:43:29 +0530
Message-Id: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0147.apcprd03.prod.outlook.com
 (2603:1096:4:c8::20) To AM7PR04MB6885.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SG2PR03CA0147.apcprd03.prod.outlook.com (2603:1096:4:c8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 15:13:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0206887-e0ab-4ea0-43f6-08d84f52c882
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB395725B4E5BA6441F63D06C98E2F0@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iC+uudEziKxbEoHVH+lG9agJTAz/2/XoQ3zv544tF886wUTPCbjsj0d7vkNnSX0RkHDY82/qy8JlJAy+2URro9T4pIjZtlK0xV7NSGmvpFuEsInW7wRG7Slt5NT3kKx6IVG54Dx91D7yJfFONusgW3O/hontfEuzw/wnoZSCCdO6RMRIF2+FR1xzKd2+NAH6obiHq3G2D6PoD/e+kFZSY8bReLGjRdaWaY63scGFH60Dw9hQdaLxYmqP+fApoo4huMqbNShXwzWxXZZK0Z+qTlj4Mqa1/HQk8zyb99Ty4FZ11Lqyg2IXZsfn8gi4rrjPShdv2wADkha6D5UVyA6H6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(6486002)(52116002)(8936002)(55236004)(16576012)(36756003)(66556008)(9686003)(478600001)(66946007)(8676002)(66476007)(6666004)(5660300002)(4744005)(86362001)(2616005)(956004)(186003)(4326008)(26005)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bzmN5cfFL6o0j2oWPlrKG3ReER+UVoRqmaxPsrTQGwFHSPaPgdt6OIPPONupzoIymq4Sdirri3mY0yU3lCHcX3xlzrvMASZG/+wz1TcBK0VS3SZg7crMNyDPqpvog0o/tTljvGUpPnAUMDSNzlvWpMKU4ke7Z0FRGC5LSLB9t3Ut846pB4WeOq6Rj4eKzkj2HWV8o96rIX70/wtlbiQGyQYISoLd3LvtI5VsNsdTtP8Ab4D5Rsw45cdzpQrJ+2iBlM74bGG2VT6yymoOGf0FwA6z5XCe5gvhyKHm2QY66z0/6T+tqCQ5Tf2a266nGZ+iNS5xC3G2uKMTtGMCghYdcA1GK8w8KkzLOj/6k/tCqGxlHzVMZutbYqnQdlgdFnSnDMOyRdg6N0D4e8pRnw6Pkp5yYGF8MoXakEIsjhNXOxj+ORZ5TLJjIRU5SFraB3sv4y2JZJvpOSxQhXVq75NB7KdP6v755iqMs/HVYn34ulO54dBaEaK1DvDzIR9FCEfx546tBrDyTXoDyzzr4FZrCuSf5Q5q1GQtTOIJkNrRhmeBgtp16lfzCQkKxLviksWClj3TwzeAl6VJYr6zKf+5N0u7SzhhZnrhU3JCYvdCD4KTRbO/dI9d5ywm0AyXG6DbZP/DI4HYTjw8tEClQAbvVg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0206887-e0ab-4ea0-43f6-08d84f52c882
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 15:13:44.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ip1zP4knpBSThPDy4h7mAXPc2ERmYCyRHUkOw7qq26EThs3+O6uYla4XrIKFg5n1UOLqW8Z4iOHSwKFKCv6NDb1NxsacTz48pjNHjO0ODE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Add support for LX2162A, LX2162A is LX2160A based SoC.

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d73..5c7b7dd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -518,6 +518,7 @@ properties:
           - enum:
               - fsl,lx2160a-qds
               - fsl,lx2160a-rdb
+              - fsl,lx2162a-qds
           - const: fsl,lx2160a
 
       - description: S32V234 based Boards
-- 
2.7.4

