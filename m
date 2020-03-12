Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF114206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xc8HqMM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCLJYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:24:20 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:57534
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbgCLJYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:24:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbTy9YcfDgEc6FiN5xz4MEwC6AGmOayOl7CeDOuFbA+3HeFwCQsrYzoNMMYDA9+rqG8VXxXXScZidhoqoUOR5uGiCS2S68SNJjEESStfqo8ZpWSiyt9PTajBPzYBN1Ijy2wVsR/6d951ERq2DMQcD335uQMD+px+E8JX81S4UUaPXcMj8tYU9Xgak0g0sHANIONrMHZn/0t0HPhb+bqIb90St4IOTr/oLUbUZp1149g/Cnq/YgcdEvyca1Xyq8tuorX83OWh5oApPRXBNGmDjkwRJYA35BPGcjYmuE7T41LVA+7IqT0kLDrNnVltyufHP0GsVFDk1NVJM/rH68Lv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxKkVhLNDncdktlbMyFcIMnEzxgzpLoSZ4lKJrsQzqA=;
 b=U9ND0W4ZD3j7vfkSNrfzHCdvfb+YRw9IaagbCV5xkWj/Y2B2Zk2MyxfT1hLF0seWGJGkYTfCqRs4J+71biExcTda+7Lfwfg+swfgKkLprhadPjKTzN3tC4FY25pA6GrWAofZ9AjLnDsNnaxMlcpZCW3Fd9cDiDSX23IU63QvsFxDrQ7f9+oISOxw/zeGsI7n+g6eIdCmfskjiytxxcI99csWm+OGZg8PE5WYimhR9kjW5eQkrMlFF07SATt9qWCoj9j50LBMHWye4G+faeYHEfuRDih/i8FhuQGliVIo56xbgYV7oEfNyVhTq4gvhvX7aVa0cMRXaNquQDHXr1v8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxKkVhLNDncdktlbMyFcIMnEzxgzpLoSZ4lKJrsQzqA=;
 b=Xc8HqMM5NDd8W97V5P5qFYzoCc5p7jVv8ePmCHPSptd0wK3ywxl5p9qnP7MfZmxgCxzVoHE7dRiUvA+qP5HFAKIv+Ze+YzUhB5/Tp/JQ3l6P3ce4ByGQcH63InTNv9ymktOp7oKTYltBRfki/F5HrJ/mWiJYvneyWrA89amP9bY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5042.eurprd04.prod.outlook.com (20.177.41.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:24:16 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:24:16 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V1 2/4] ARM: imx: cpu: drop dead code
Date:   Thu, 12 Mar 2020 17:17:23 +0800
Message-Id: <1584004645-26720-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584004645-26720-1-git-send-email-peng.fan@nxp.com>
References: <1584004645-26720-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:3:2::11) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:3:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 09:24:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99dd4fc0-0166-4b25-6cdd-08d7c6672297
X-MS-TrafficTypeDiagnostic: AM0PR04MB5042:|AM0PR04MB5042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5042F77AAFF634AFDE3D7BC288FD0@AM0PR04MB5042.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(316002)(52116002)(8676002)(8936002)(6506007)(36756003)(81166006)(81156014)(186003)(6666004)(9686003)(6486002)(16526019)(4326008)(66556008)(66476007)(26005)(7416002)(6512007)(956004)(5660300002)(86362001)(478600001)(2616005)(2906002)(66946007)(69590400007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5042;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BBvXZj/uBzj6i1TR9Urqmx7+9EWk7USnHdqqn6RKLBH+ebHB8AGinQDSW2PNSa31Mfg20K5CIEHn/nMmjxVRbN6gNCsXSAZZNIBHw+lGsI3U17XlwbF0hFBHpvHZ1XSX5ugVtyqEuaLq9ViOJv78GY3hbREVRlPNez07VBVy4FUB0Q+UoQYJJm2ImsWyTkX3XcTaT+q3VUcf3EF3qkeuZv8AGerW+TApnrmYA7PJlVDsgpcmqqh6yKaNwiM6UNKAkzBqkU7101V6FUlRjIKdf5PLhLBkcgRu/zScVJ9osDnK0ihS5xohAqJ14ysRuQOPSTIBp835Jzx6FmHG5xlLfHFwhOzw26+tQVBlou0oMcCthco8hXHa8rim7vkxsz62D9ttUjPJCFOZYNwRynqcQMtT40MwSwfKh2yLKFiJ/ISv1pqKaDTFPlxLM8x6D7+jYD2+K8AJ3dJEZyE/vhAD60HZMgvxuzbcwDGvSMhZHYbd4BZ5n1XT/yUkz6dA813
X-MS-Exchange-AntiSpam-MessageData: 9DXdf7J7javGG65UdJ12VCrNC0hthwa49PAbwN8tcVauZ5Ru9w2hnOw0w1UHDowr/DxGCHcga7uBhM8Y4AwNx/k96OkQJl+ZAIAW1gnmUoyp52uHrpTatXe+YzrrsWhdBLcfArdPdMwZefd1w1SQGw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dd4fc0-0166-4b25-6cdd-08d7c6672297
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:24:16.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UTVTjSGR1WsQex0T47HyFY+ebDYnJE+qL92+JMmmUitFiZ+7dyiFC5waEvO/6z54vhuNJGYoGfIIxc9jOsVag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

imx_soc_device_init is only called by i.MX6Q/SL/SX/UL/7D/7ULP.
So we could drop the switch case for i.MX1/2/3/5 which are dead code
that never be executed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 2df649a84697..0302cb66134b 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -108,30 +108,6 @@ static int __init imx_soc_device_init(void)
 		goto free_soc;
 
 	switch (__mxc_cpu_type) {
-	case MXC_CPU_MX1:
-		soc_id = "i.MX1";
-		break;
-	case MXC_CPU_MX21:
-		soc_id = "i.MX21";
-		break;
-	case MXC_CPU_MX25:
-		soc_id = "i.MX25";
-		break;
-	case MXC_CPU_MX27:
-		soc_id = "i.MX27";
-		break;
-	case MXC_CPU_MX31:
-		soc_id = "i.MX31";
-		break;
-	case MXC_CPU_MX35:
-		soc_id = "i.MX35";
-		break;
-	case MXC_CPU_MX51:
-		soc_id = "i.MX51";
-		break;
-	case MXC_CPU_MX53:
-		soc_id = "i.MX53";
-		break;
 	case MXC_CPU_IMX6SL:
 		ocotp_compat = "fsl,imx6sl-ocotp";
 		soc_id = "i.MX6SL";
-- 
2.16.4

