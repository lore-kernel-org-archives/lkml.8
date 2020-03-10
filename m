Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B32DC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A72C246A1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PRys5ls9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgCJMze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:55:34 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:28515
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729514AbgCJMzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwZqq+joS+RtmgzquYV6mP/eBqn0YZOmyB4cG8BmKQbCkdeGBkt+0GOIS/RmHINnEZsx5YunrYdLdDaHeqRAWB3lzvnCjmJVpTyWONAFogoWR40fwqBABEzr3fs1JT7er+jkJ7k9FLwDEY9zcu6IS0yViCiepWQ5kMY64WXhBaPgPXfIkvF1R/RN6yzEfbOS8PSoah/Ar2wFrS5RND60M+nsZ197ALWlwKayE0jbQu3QIp2pauD6nRg46lcRMJYzeiY7GJvYkrSDWvIAK6/ghpRjJXncPiP0WlD7K6a6M6DMshQErFU5nDcs46i+6XyKy9Z/HgZecbrSaMkLO2W6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Uus/LcNegpG5KDSluygrz9MpaOfSH/A5RcrdGs630=;
 b=I1WlpN3MIWsj7J4QlfR7MCFrldHzSqsD0vlUBjoIoYynbZJBR0hS9ZkMjhpPOihQ/2rXNm9tSnByNjH9XMl1cQPtaMI13ZN0LVi4vFn4Vq0xxFJUp+gNapLqNvnBACWyjWL2Bc0OVV5gz0AdurygAwtD9K0W8VKwreKXk3vDM9rskJxf1hGhMM258MHL97dgRHmuVLMrGkzg1MoGQuHrfpwyhdWdqA/qkI3/xUJAkYLWbK4aS8XEKX69J/V/wV4aEtqSbUFkDceddqvIiS2RItMTEd/lle8KzpiaqEBYGaiWMWb+tQRoJps9TnbMz70Ze/LVltMoSBnOOP2wtcdDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Uus/LcNegpG5KDSluygrz9MpaOfSH/A5RcrdGs630=;
 b=PRys5ls944CL1/OtIJftPC66+E3j4GCdgUswTjxTAU/ys7e08L5C9Xju5Gg4fDQZzNedMyKv6g48HuoGXHZzgk5x8Y1CPS0JPG46ON5mke5QIZOkQTzrkblk9tdk2Pfb5KNeVQO4EhWk2NdF6oDLJ40IiaxEieWQ0TdOJ5/yT3E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5410.eurprd04.prod.outlook.com (20.178.114.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 12:55:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 12:55:27 +0000
From:   peng.fan@nxp.com
To:     catalin.marinas@arm.com, will@kernel.org, nsaenzjulienne@suse.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable without EXPERT
Date:   Tue, 10 Mar 2020 20:48:46 +0800
Message-Id: <1583844526-24229-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 12:55:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 251c156d-f4ab-47a7-b4ef-08d7c4f24e0d
X-MS-TrafficTypeDiagnostic: AM0PR04MB5410:|AM0PR04MB5410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5410D062633DE2F070CBF81B88FF0@AM0PR04MB5410.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:218;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(8676002)(6506007)(66556008)(956004)(2906002)(5660300002)(2616005)(81156014)(4744005)(81166006)(6666004)(316002)(66476007)(6486002)(66946007)(8936002)(52116002)(6512007)(36756003)(9686003)(4326008)(69590400007)(478600001)(26005)(186003)(16526019)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5410;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7GeBbXxj7OZS38iBCnuR5YDit0Jh88jivpqoenpM0+7amCJMP+NIwHzMxd/b2sDsvB2xHm0UaF9Rpt0EbDUsW/mR5AS5jGqK0EZN4McfVerBu9GqruRgetRmcGFjYfPa8m9MTYvdC17im20m6m2UIAb7ECOuB8niiHELPZJ75+xn+ioL5p+1JQBGKEJ/WUArhdUZErPYhswtvCMoQadgmYHLjMmOVja4TPJG2rGIr2sZ0bwscV8+NXm5tH7g0rnRLLKAgheuRnpQUf0wGw29SQFMOGJetIh1TWZCID1eIOqmu9saCv8mFgeiahHZbNBr3saAAZPL1EcecVdpuo31jdU/FddSPO7Uk7arhxQ0L85OILpmiP0QjeHTW0Ztt+mBG1g7cNFtlP7+3cQJv9C5J80Ikj7Fg+tKyQhHFz/B70fuG/jA2lwuh09FCljYD0ZI43up5oCFXpJgG4/Acd03l4Qk9uGfv3fEICQ6dJVo83XIZ3La1pVeggPYNV7wkLd
X-MS-Exchange-AntiSpam-MessageData: dAM3c1wj5QEs3RyRRXV7+d6bJ7v31BiBEGMzCTH9fhDrgMA0qBeXYkx08vZ08olUEEIGabqILB8VEhcymOoFiV9C+ohCYPhHO504syy14I4GxLBFrucApDRcDrtb1gdnktGQk11S5AapGUXBtJf3Fw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251c156d-f4ab-47a7-b4ef-08d7c4f24e0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:55:27.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOp9z7B448SUWZ2YcoPmQqaQ/gIAXKrO76whYK2i0fsGP33eSEWUgtJ1b1eHhb/3ogp0GclDwFi2dlalWW9jNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5410
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
enables both ZONE_DMA and ZONE_DMA32. The lower 1GB memory
will be occupied by ZONE_DMA, this will cause CMA allocation
fail on some platforms, because CMA area could not across
different type of memory zones.

Make CONFIG_ZONE_DMA configurable without EXPERT option
could let people build non debug kernel image with
CONFIG_ZONE_DMA disabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 217e12ff2115..c4ba8bf011e1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -270,7 +270,7 @@ config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
 config ZONE_DMA
-	bool "Support DMA zone" if EXPERT
+	bool "Support DMA zone"
 	default y
 
 config ZONE_DMA32
-- 
2.16.4

