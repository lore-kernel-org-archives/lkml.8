Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE11C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364D020723
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jMx/eEV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCMDif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:38:35 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:12848
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgCMDie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw3O+xCyXl1BH24oLTqPmx12huJNfZRW/EKLsDgz37VNx5QXvAjYQF9D2oUKyeLUa11H5XiGb7KKL57ZOC8+kraLSco+D0P6gXrRCv5O0aerR2ELzDi1qk2Els2aHXkHj4GghxgGozdXbS1Moa4DHV/gxR/mivV51Ft4uw1y/WwtNIC/tW4noMJOk6A0FLD1jj5BioDxvRGR8Luiv+1tNpDJ5+WTClwKRLTM0FISAZ4J2M3fz1A0XUcdtsyiBa7a81wWYwqyuTWzjLdxoPeBxir124LNNvK8MVRMkCkp4F7m5kwbFsJ7a8dYlHHBBIhx0XwsnxXPohEAHwvHrDCE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25tS1woafAGnBsmjPt2TuVzG3pkzNgKxfL60vBicqkc=;
 b=IJDIb0lL6QijCapYomR6qg4vTzovdqSahv6gsDHtMoxsMkKzmtQElOxsnWw1SzbRJcWfq8v5Qjl/ErG88U4bOrtnrW7HrWggNowNnway3M5cZlRUd2BUl06yy9+4+8O4s7Bu8NusZb8dEPQ1mSldQj4cXUezPUQX15dTTJ3OSoiSGvaObPgCY1Uc4zjQK0TwtBJa4+iGXa/Z328jNSrqnc4Z0+HqU5Q7EU5C0tqM9bSSZZPiuEt0uGzO328gaQZKbFu734z6HoSlmebnRfuhRSWCqYPWk65jTRS+MpYJ/YYgOiLtmhWpFBF4WjkDuZz1ynpnduJ5v3RRqDFn0KUfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25tS1woafAGnBsmjPt2TuVzG3pkzNgKxfL60vBicqkc=;
 b=jMx/eEV5UPupXev39wQ7+M/eB+lOgpIinTJuoDxU4mr/7oU01F6PSlEKmVxMkomxasMrBXTAY0liTnVnEQcy+gfkcmkU3wmfSsaZi8zKG9IBrazLorKZgsZXEpQ32Ygom8K5SwsrBLbfTqMKo+sLBHb6ecOSOt29PMSNulrBGeo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4979.eurprd04.prod.outlook.com (20.177.40.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 03:38:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 03:38:29 +0000
From:   peng.fan@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: dts: Makefile: build arm64 device tree
Date:   Fri, 13 Mar 2020 11:31:54 +0800
Message-Id: <1584070314-26495-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0158.apcprd06.prod.outlook.com
 (2603:1096:1:1e::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0158.apcprd06.prod.outlook.com (2603:1096:1:1e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 03:38:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5429b77c-0beb-4d50-c3b4-08d7c6fffef7
X-MS-TrafficTypeDiagnostic: AM0PR04MB4979:|AM0PR04MB4979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB497929438D651F14C28037F988FA0@AM0PR04MB4979.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(81156014)(66476007)(478600001)(66556008)(8936002)(956004)(8676002)(52116002)(66946007)(2616005)(81166006)(4744005)(26005)(69590400007)(86362001)(6486002)(4326008)(36756003)(6666004)(316002)(6506007)(2906002)(5660300002)(9686003)(6512007)(186003)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4979;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gYT5VLb5ntIxlEwM+D0BK36fxtrg2ALS8Vb80aq5tayv5hD4rQAkHcitJaLIXcKdWO43ixnS/zDDG0/A7LRrYvFpNy8KwWR60ZwtYDLslRN5yvIIi9mEf0UhJW4IOiMCzq9B+6KN5n5qVsVY1j2IBRcIXrSzaz6sNIS9+K15stjWHRwEkAkoaQDcKaTNVF116+yJmxfEV5jnmAOU2wCZyu8rzAqfPFT3xGqe88FzplB3XYomiRIirfjCR5I35gBn8lLM1qBQ0QRaWV6ytuti7Q1kuKyoOE+e//Tlar9n7cDhDe227JgPHKS1hv9kj7JeydbSXUDei337JwtUxI5iGdjndV/COHiRShrhCfCtGmylMa7PrT9SJqZH2Z0ODNAyEzgq6ek+9kNrx97DCFYDgzkKtukh/F7xe6Pubxj0fLnWgozAqXyo+Kx1ecjan7H/WvOemDkVFuvyKohj+k+eVfO7p6SBnYMVNqWcGDZZMYRIJ2DEN2SGQFGbraBaAzI
X-MS-Exchange-AntiSpam-MessageData: R7976ptjbbfFsFcMbIDNmBRI5ic1Ixs/U3dJBE6o30vL3I3HqsK9+vmrI3UmFh43SxM6FKlE4It2qW95E6OcbRm+CSUAAoKxD2EGHjWUAUF1+AU1TwmZ+nGojcABt52T9/2rb0zNAZ0hUS29lQ9kPw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5429b77c-0beb-4d50-c3b4-08d7c6fffef7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 03:38:29.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntTFqXvUg+bDR69zV4EdPYQkW+dNzG5AxoYuZVTgojbfYYkcJ8Fw5+58clQoVB2TU0GHhRchAgJFxGnO0XkAmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To support aarch32 mode linux on aarch64 hardware, we need
build the device tree, so include the arm64 device tree path.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 This is just the device tree part. Besides this,
 I am not sure whether need to create a standalone defconfig under arm32
 for aarch32 mode linux on aarch64 hardware, or use multi_v7_defconfig.
 multi_v7_defconfig should be ok, need to include LPAE config.

 arch/arm/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e874fbf5a1f3..ff0161c1df5f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1341,3 +1341,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
 	aspeed-bmc-quanta-q71l.dtb
+
+subdir-y += ../../../../arch/arm64/boot/dts
-- 
2.16.4

