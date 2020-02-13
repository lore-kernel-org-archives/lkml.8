Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79568C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB6206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBeJjzXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgBMEEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:04:39 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:41486
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbgBMEEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:04:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybj+3x6m5PbYyJEmcivfsNT6T/s0wbrpYEREtfF20QSJvVBCFV8iKdw9P7mlHEOd3ayGjaa6JLoRXPTLGsgpzRsF1AhAP1mipe4K6G6FTMW7VfDFhdDuCG9D7SkNa868TAGvBUtZBxa0evbFix/sYvrRh1vEK62qPNrE+8MH3RG6pVVs2mrsSAKK++2Cn0B2zXcphP+5s/It5jxbTvrJucFiK9BatiGnNScY31itRNuENIpnv5lnvVxH6p7iFFDy4xwVsGM5vi815fb1T47ZYtXGKxt3B5mSankJsE/K5hRwyEYpeJBLr3rmvEZYzW+9kriDq8r8yyC2LJNCVWRq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRXwC/+YUmGPuAXuuGVkqYWLQt0AdSWQy8klGxhzrew=;
 b=fpINHh4Oj1Ng6qIbz0SfNruf2H3bL/w/HLzF0MpvI/ewEYcWd2MPThmmIBaf9AqJmvZkcv4cj1B/i3aKE/oxSW56xwPuEJXKljuu8wVl13enEWrqPgqiJhvLxkR6CnobMWhbRvPTPgW2mN9PbcetdLAvY+rWgn07cw8Ed4CuygDk2n1RfBII0VfgV8mgVuKgpbULC2a3DoXnot9Fkqc8GdY0y7cWp7ooQquTcr6WpwPcPCgKWBTVDpNRG1veagy5v9UZyypQ0f2DI7NSHtoNl+nOC8WMtGJW8ULnKl1G1Tm4fcvCB5vGksS8jDm3fuEFnKseJg5TzMppbRKDr/8U5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRXwC/+YUmGPuAXuuGVkqYWLQt0AdSWQy8klGxhzrew=;
 b=kBeJjzXC3YMLDNMDahAx6Dyyc5OfhlZDnsGsaRcNvmRf5uh9Njg1EIKwDeBtSFs4EKG60wMGK3rSlWtw1UuNsGaj4oKCxtlKSH6Y78+8ueXGmlZOqBGKzhkBtDicwiZjYWhqLTE4yHsqBraKn3R0D7o88eWGEYtAu3Rag6e4N0I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5220.eurprd04.prod.outlook.com (20.176.215.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 13 Feb 2020 04:04:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 04:04:35 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] firmware: arm_scmi: add smc/hvc transports support
Date:   Thu, 13 Feb 2020 11:58:48 +0800
Message-Id: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.12 via Frontend Transport; Thu, 13 Feb 2020 04:04:32 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 790923b7-353a-4fac-32b2-08d7b039d690
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:|AM0PR04MB5220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5220CFBAE8423A2989997946881A0@AM0PR04MB5220.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(52116002)(4326008)(26005)(186003)(6666004)(36756003)(69590400006)(6486002)(956004)(2616005)(86362001)(8936002)(2906002)(478600001)(66476007)(5660300002)(81156014)(8676002)(81166006)(6506007)(9686003)(6512007)(316002)(66556008)(16526019)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5220;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVoiqv9Jl9Vcj+j7Qdx52akaUnWd+Gim66WPt22tJQDRQN1o6ICSNRuzxuePeKluf3Nysz/ba8Brjma5BzF5i8ACngHNIEIpY80N/zGV99BaaacJOk3SO2GrUMktR7X+YG1c4o/roTgt+wM70m0MlXCR34FAIKWdDEAmmLnCxjKhcDHEV35f0k0SEV66BVS8wtL2Aeni5WjVI3TonMBDLTYsJ5sZgP7HazEqiahKYbNLxNUKUGbj5zn/D28K+7Pl51aDMrm4oRH427DPVTn9uTUUMT4PgxljPxO0yX3HJdLaHZzDiEpuL4c4IWdtKcSgw+CC5eQJnyEKc8xhMtI357x6zrUrZgMv9JuVJaC+TzUfzhaBnfNrVD3p5GtjztsS2JbZi/n1U97lpTXV/zASEUwfIF2hCTbR2OscLPIL33WhmWCrRPLwuclG1AE7JeefKtzAAdeaMnaZzAxXsxvgkjn0g0KvjA+NmP+nFTJYDYrkfOoWuOzhWUl0LgvygEQdZl34lqtxZV0c5qHhMTyXHfO5DBj/eLtRu9pDDdDq0AY=
X-MS-Exchange-AntiSpam-MessageData: 9zH3emyVoK8daxGhb0VmdVewPWSfiq2Khf877K6Tzp6q3E3NdGlXL00Krqn3BSsPmc9PMmGG3iHWB+0bpOgR4QrBtXoWb55zPgB9B6J2c4PvAm9cb6eMmdPjiAG8VoTdVnZibh/P3nU1nKZCBB89hw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790923b7-353a-4fac-32b2-08d7b039d690
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:04:35.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHz1bfN3ia1m2um2ljl4d0h9NFKL8vJiDicr70aqPseGuhSwOgVS38r3Z4q/i/PF8qm91bverld1L2WmXznMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V2:
 patch 1/2: only add smc-id property
 patch 2/2: Parse smc/hvc from psci node
	    Use prot_id as 2nd arg when issue smc/hvc
	    Differentiate tranports using mboxes or smc-id property

This is to add smc/hvc transports support, based on Viresh's v6.
SCMI firmware could be implemented in EL3, S-EL1, NS-EL2 or other
A core exception level. Then smc/hvc could be used. And for vendor
specific firmware, a wrapper layer could added in EL3, S-EL1,
NS-EL2 and etc to translate SCMI calls to vendor specific firmware calls.

A new compatible string arm,scmi-smc is added. arm,scmi is still for
mailbox transports.

All protocol share same smc/hvc id, the protocol id will be take as
2nd arg when issue smc/hvc.
Each protocol could use its own shmem or share the same shmem
Per smc/hvc, only Tx supported.

Peng Fan (2):
  dt-bindings: arm: arm,scmi: add smc/hvc transports
  firmware: arm_scmi: add smc/hvc transports

 Documentation/devicetree/bindings/arm/arm,scmi.txt |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   2 +-
 drivers/firmware/arm_scmi/common.h                 |   4 +-
 drivers/firmware/arm_scmi/driver.c                 |  11 +-
 drivers/firmware/arm_scmi/mailbox.c                |   2 +-
 drivers/firmware/arm_scmi/smc.c                    | 222 +++++++++++++++++++++
 6 files changed, 235 insertions(+), 7 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/smc.c

-- 
2.16.4

