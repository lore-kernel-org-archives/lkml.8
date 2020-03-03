Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE249C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA0921D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fiRcpny+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCCCNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:13:13 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:8921
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbgCCCNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:13:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw0ND9NNdGA4tiBhGwPhtsTjcMuwar/tLlBTdC8LPlLJo0BzYmtw0KFSLf44lsr6WAt7QC++g0tfAQ2rQN4UuVG8GqTDwgFrZshaDYXgGMgJwFZcZ3zSZ/p6u8Ve6SfYrSzOHQhw7YzN1tXAHtdu5hZ31zZaKP6M5o4qfaXVDQ3fB2OurAv+b3JWnlJyEemDMgN83Ha0dYnPpb5NXnTwCMJEhgCfhlaUfaCJE9DL/p0FS3RPDr4DObcRay0sX/EyVWa01tPU4sHcwwsfZlkmE9itKmtPAXVfSycD7fpIuQQVFr3nj4DBlwBWbtnPP6LITHaVhdTi9Vp3iRzxpcuc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq4lYBpflAjQoQtYSMowoG+qsf+axWyvbvZhFB/9rG8=;
 b=Fi5VsvX+Q1hHsfoEc/gUqr0oYgs7HZ3CVU52mTkDGl0tdTdV67V9pIIp0saCbyuwxD2QyMgEmeUQjAA6dgyw9VceJbga7VuUPw67hCQEBwLp7k+T+6VsI9LymscmYGY1Utg2BkxqiOB5w3sPznFzjv89BgiSFob5/cfue4eRxvJ8du7S8PxLryX/fiQXkkUNy+XHJ1i+uojpV+wfCYwYPfyHsa823xbLkU/QWfLpo8zpvj93P6EgqIV+yuzhRymWS0GYGQRuXVlXHjgc2zOOLrdF7qI+zpFF+qBmsxdlhnoFi8NSp2NY6cms4Nk+SpCraX/ikDmSyw8cu9U4RTDZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq4lYBpflAjQoQtYSMowoG+qsf+axWyvbvZhFB/9rG8=;
 b=fiRcpny+Yz+q4ctolVhIW+sPIKpfJC5kwp2b7JM+vJtFjgsYFNPWWAwSeUucu98mRh/pigYQm3yKrQNJ5kV9pgKpEybCG5gWYWE/5euUbnKowPcGGBidsKOPX51ZXOO25HtAwvbbr8EqqKwyUMkUOEHu3WhGNgnNZaxTLLt90zo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6946.eurprd04.prod.outlook.com (52.132.214.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Tue, 3 Mar 2020 02:13:09 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 02:13:09 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/2] firmware: arm_scmi: add smc/hvc transports support
Date:   Tue,  3 Mar 2020 10:06:57 +0800
Message-Id: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0125.apcprd06.prod.outlook.com
 (2603:1096:1:1d::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0125.apcprd06.prod.outlook.com (2603:1096:1:1d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 02:13:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 605d27bc-e824-409e-aaf9-08d7bf186b04
X-MS-TrafficTypeDiagnostic: AM0PR04MB6946:|AM0PR04MB6946:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6946A4CF9286048E18A464A788E40@AM0PR04MB6946.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(6486002)(966005)(478600001)(36756003)(6506007)(52116002)(86362001)(2906002)(8936002)(69590400007)(8676002)(6666004)(81156014)(81166006)(26005)(6512007)(316002)(9686003)(5660300002)(66946007)(66556008)(66476007)(16526019)(186003)(956004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6946;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +leFcetlNGNT7ZS+PI+nnZo399pysI8ajtX5cxuE0d50Hf7871VaANBi/ZUgJQP8kubjI+mGrx5TwGxa6mhYw/qxfillL7aUt8EcSMUuVa1sX6Gf6zPUunk/GpY4EJt3mDLbMTeAppk+cDfbTlL86TSY6Xmj8lAaH3UGkz4y4dojRTK5m2auiuGM8uUgB00fdkb/n4F0JCwhgW+fmL+BlZPPRO8arSkuZGyI8b2tm6eTue6TAjVrW2pv6tZeYcJGJpJ0P5hpkNGt5N31LTJBkNvq8TE5WGYMMLRAZNYOIKI9xOx4GkwcGdutcFGz3GPDJhJmey5DmPz+PJZdpeikJSK4NpjLR+tJAf/Z1tL8H2/GlMfXF2EjgyS7a65ih9fUVSzTzl7HU4n2fkgXRicDlCq4agAPsCECeM0u/0ZKemTmAzwGJ3gqUs0Rhn0auZPwFrsqJO/wipEp45P8IQH6k+B5ChRlPOfVWGybMKQWCtKuEgXhZMIk1oC4FF0Jsc6FUT3MJElEai2FFF70NgVyh50E0Th7A34r9/jy5iqaokU8TRi68cfsIDQVjN3sEIEcyhAUi0w1EtWi6n+OI41buw==
X-MS-Exchange-AntiSpam-MessageData: vc9G6HGpxfgeDFhG0LSmwlN+R++ATpjbTfBkG4JY0f4E80hj1p6pwwoNmFn9NQebsdqZmW93YwlKDRsFHS9d4Xz4R9Sc+eXdnOr//QK9E4CGE/29uTYc3WR+KVH01aeS+W5alj2zwTkxEdsYpveryQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605d27bc-e824-409e-aaf9-08d7bf186b04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 02:13:09.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oAtluiFtYQmabYAFKj6mhChQNbHofxHyz5GRY4bTwBtdD8PkMz9yGaXePR9lp4f1i1+BC7xEA4g3oUovJ2gZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Drop prot_id in scmi_chan_info, since not used for now.

V3:
 Add back arm,scmi-smc compatible string
 Change smc-id to arm,smc-id
 Directly use arm_smccc_1_1_invoke
 Add prot_id in scmi_chan_info for per protocol shmem usage.

V2:
 patch 1/2: only add smc-id property
 patch 2/2: Parse smc/hvc from psci node
	    Use prot_id as 2nd arg when issue smc/hvc
	    Differentiate tranports using mboxes or smc-id property
https://lore.kernel.org/patchwork/cover/1193435/

This is to add smc/hvc transports support, based on Viresh's v6.
SCMI firmware could be implemented in EL3, S-EL1, NS-EL2 or other
A core exception level. Then smc/hvc could be used. And for vendor
specific firmware, a wrapper layer could added in EL3, S-EL1,
NS-EL2 and etc to translate SCMI calls to vendor specific firmware calls.

A new compatible string arm,scmi-smc is added. arm,scmi is still for
mailbox transports.

Per smc/hvc, only Tx supported.

Peng Fan (2):
  dt-bindings: arm: arm,scmi: add smc/hvc transport
  firmware: arm_scmi: add smc/hvc transport

 Documentation/devicetree/bindings/arm/arm,scmi.txt |   3 +-
 drivers/firmware/arm_scmi/Makefile                 |   2 +-
 drivers/firmware/arm_scmi/common.h                 |   1 +
 drivers/firmware/arm_scmi/driver.c                 |   1 +
 drivers/firmware/arm_scmi/smc.c                    | 145 +++++++++++++++++++++
 5 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/smc.c

-- 
2.16.4

