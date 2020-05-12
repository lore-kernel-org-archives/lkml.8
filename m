Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386FAC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C1120733
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h5kS3iTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgELHef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:34:35 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:43195
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbgELHef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:34:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JktY3AWo3Nh+CSIMyDL8eTzmXiUqbS2HTq8txn4wuEz9jUIqZUmy53z3Fl7gbnal1FNy5CquMG2+z+ebnctwqtQ47V9Kt+5Zh/bxx9bG2aIGf5htykI01OdGGX17iwuIew/b78v2OdGugv3zvFp2GGIqby9CjJk8xBwULsZx5sbIaBHbjbrjudcC2eQH4PZxSBZcWynlI1MUOCFUzGC8UzLJu+eMUjfCmOISOonNKwEMWYnmsTb2dr0/6CHsl62I9WeYSGQiSqWEq7iOCBSP0OCY2RJF62IfEGgOai/NYPgHPCCyu10p+K9Ce2pSKG3Po7AR0RlxXWxjN1qV1A2IAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDEdStoExKChGrIbKEwGNeUsZgdSI0qsSzHI3jcegnU=;
 b=h6rDdl8BRhDKskLgjnqx/bd4/GVLhC0FIQ+QWzLHAj6yT38CSvNwMZPOv4/ECMmtLM0qc+H78UR3RuhE/0opYWKmDigxsc8PpkyREETgtNxGQ3BwB8HcRFdssXBAvHrJwd/aS8scdqPGYhu1qMIauB6+34X2nTdnsFpFzb+ozqoPv2w7ECdZt8kvlw7x2Bgy45/NRMFVWbMDGSMOzr2QI7NI+VbdYc7SHtAomgsCvlqMLIaeJS3j4nrYJyheu4Y+rKlwrL0ujzlH4yfMfU4FYG0ahkv7mHAoysFgi++bYKbldxE8Q6/6Bb46d8pNp1/RX5oE6sw0uElavRbjgray1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDEdStoExKChGrIbKEwGNeUsZgdSI0qsSzHI3jcegnU=;
 b=h5kS3iThMgex4zB9q1m04v+htIMYn2KzuInW4oyBC4gYjcGRjuv1BFyuk1APSFbqToW51N5S/tYgkZ7Wl403DegDoyi8qjZYVJhZu8xYC9RDGEkg0+n/gM0whAqLVkEJxq0GmN7GDINcmxBzbidtUw3hMkmX+b3/CBf16GlNFNg=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5882.eurprd04.prod.outlook.com (2603:10a6:10:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 07:34:31 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 07:34:31 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 RESEND 0/3] perf/imx_ddr: Add system PMU support
Date:   Tue, 12 May 2020 15:31:12 +0800
Message-Id: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:3:1::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:3:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 07:34:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59d91777-be81-411c-9a69-08d7f646e66f
X-MS-TrafficTypeDiagnostic: DB8PR04MB5882:|DB8PR04MB5882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5882D668DA478F5358403DA5E6BE0@DB8PR04MB5882.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4zxrimVU2z8nduCyUJXA1fQVmmraSxv279zF6d8Hx2dB9Rm1Yl/GGlzR+Ud861c6DGe1Xk5ZZQvzQ9mqKxaq2dnWz7jvwHUvu0w3PRhVLbw8z0Dpy+UTCHD3YkjMXugN1VvXubhR3R52d2znsg7BgYwQ/TpTLUPHhoJUelk2yczJ3wywhsJPqr3uDBXT5ITomcssxNL34K9N+P5TdbpgqjfV8lKb6/HyGwngNxP4Yfxj9FZae4ZS+Fo7O3ZcVs2S5bA1pb+G7LJd0bFbbI9e6eo4tEO2zCB5ZYJStK08EvVd9Mv3jmrXQceyOxAwfgocvliqW6tJcbmaZlahv4PCJ8sZQ43pTPCJ+HfeIxTd9nJ+LssIog14AY0suuoFs9+tvLrGOWV4V9YfO9XInzzYqGjUVp67gAl90/gpyH/NXD6pgnetOO0u0IhzAD2SPkmn95xSALWVeG3SmPWQYX8x2S6QmaA4A7q2EkM8wNK7dsRabtEV9RKI7cUq84Aba8K+EnFYLsrT/1CCuamVh0SZVctVSqZq3JpB3RM7qpKg7aRfqlFYe/X97FPnp3tQA4w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(33430700001)(8676002)(69590400007)(33440700001)(5660300002)(66476007)(36756003)(66946007)(1076003)(8936002)(66556008)(186003)(4326008)(86362001)(16526019)(6666004)(26005)(4744005)(956004)(316002)(478600001)(2616005)(6512007)(6506007)(2906002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J2fPxGs/sGCzx+GlU65MIvgSmQ1zGNh1z2MHnvEr4Gh613l6ZWPacQVZ55//nlUwdXLaUQEwMg2N1ijdUmoF4B8pGSKTO8FcW/1tQ69eMVdm+5X0NoCf6o0+hwIZOv3sXc94YByVxTHtqk9ecvYlPxK+PrT4niqdWSq9JjaONVBSUb50E4djNBdef2tuj4I7/Z3UsXNpf8lbPlIy+JC2ii/cRUDG5QGXtD7MTq/oWZAxfhLyGazH2PCJTQ7qLR0Nog6qg32HI2L3VoQXulDKCIvSU1VBYw1BwwLFUi3tPLTeS0HjiHqX2+4rGQ3avtAKi+m/Bu66cITj7TijMMTdcaQigg9kBbhwJzd3DeiNdiznkp3OQeWCWfrbv1gGHRhBe/gocIwU8ROv5IwGA/uVRxdDQQ3FD/aSvYP6oJqAYPWMP5CDdNJHizRMXb5BlKhN2fp4Q6L9zK9/YXuIeYHryJmGkBNiG0c7qjtAltn2FqQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d91777-be81-411c-9a69-08d7f646e66f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 07:34:30.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lm3JJQzr6ePDeemw1RaJWsD7rHfrITnAeYP4XLXKigZhDlFCIR6F3EkRCJMqWVV5aaA+yZPebpiftZiRrV25YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set adds system PMU support for i.MX8 DDR Perf.

The sysfs location for userspace to get the PMU identifier under the
directory:
	/sys/bus/event_source/devices/<PMU DEVICE>/identifier

Joakim Zhang (3):
  perf/imx_ddr: Add system PMU identifier for userspace
  bindings/perf/imx-ddr: update compatible string
  arch: arm64: imx8mq/m/n: remove unused compatible string

 .../devicetree/bindings/perf/fsl-imx-ddr.txt  |  4 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  2 +-
 drivers/perf/fsl_imx8_ddr_perf.c              | 45 +++++++++++++++++--
 5 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.17.1

