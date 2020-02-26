Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB05C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973E424653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3snKtXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBZHS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:18:58 -0500
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:39456
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbgBZHS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:18:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLda447KvSPNgeWzGXFTMDVzHjv67J+ntjLCEHyZ/1lmv6ajWTvzS0jzXXAxiwBnKdKmsrkHm9Z3xYCrGnJd4alsfF+PWeS8mLTPBoo5jujnfxXoy4hpwVMXwErqMlha1ADSauHDwXOlSys6mR7oy/jyWGCFhxauLnZiKUixxoSWmS8/9x35cd20LjSkp+naenh0uhacCdt26VXz49YJSOnUVvWhaa96GP4d8xf/hpKfMwfl1otF8fAuHIhlin8p9nZvgKveza9IWTWcZqqfQ+/EL/yQfTCiimpfl81oVXU16YYNdr0igfph97p6IX9eoxKKLZ/CpDWnkvOkDhjgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk8GoFSDbRtszFiYYHcBQ6IlTKuNv5lqKoyhWO6HQGk=;
 b=hPnGmCDjeJQiBTz8CpM/7B3Kt6sIusuYUJ3VAnfErtJwKL7BoTRqtknTBZBPyKumJy3ZEvWLOpWisEdkqkSuA6w9GbIkvE21y/kFSv4MCwF/OgiAB4VJl0stmOerAX+wCe5nJeZDm1qJTvDZvYgVe7zEZAzm0jpK6+OA3UA0hmhr5Eioayp6wk/tdozWucm/vgfpvlWokZ933y32TXyvO8GPVoM7Tmt/V+KnLN29P0cfjJc3y08pSyu44RzcyiW8CnFmUOrfn84lqepZHBsZbYCYazjkKhCsGuYd5KV2ja2Y7ag05kAM5yQWyXtCPytRJ6xM9cndONPJ1hY2GqRilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk8GoFSDbRtszFiYYHcBQ6IlTKuNv5lqKoyhWO6HQGk=;
 b=K3snKtXa78m2PxQ0npp5k7UyZTQSaaIZ5utOglItV6zEc6hb31zbU3Y8zuAYBNC3oqsEEpvJmzHruaj+l5+kRO4whD8WPYmTKZVn+L8vGHyYzdy1PR0vgsCm+0mgp2AdcktYTTvwVhBVj5XWNU+PPMYcu+vU+Wl1CXu10CLqZ+Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6819.eurprd04.prod.outlook.com (52.132.212.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 07:18:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 07:18:54 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
        robh@kernel.org
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/2] firmware: arm_scmi: add smc/hvc transports support
Date:   Wed, 26 Feb 2020 15:12:49 +0800
Message-Id: <1582701171-26842-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0131.apcprd01.prod.exchangelabs.com (2603:1096:4:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 07:18:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b15bc919-5b95-4401-9900-08d7ba8c22a0
X-MS-TrafficTypeDiagnostic: AM0PR04MB6819:|AM0PR04MB6819:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB681997D767C5D208FA6E3C2588EA0@AM0PR04MB6819.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(186003)(2906002)(6512007)(36756003)(966005)(52116002)(6486002)(69590400006)(5660300002)(478600001)(316002)(16526019)(4326008)(9686003)(86362001)(81156014)(81166006)(66556008)(7416002)(8936002)(26005)(956004)(2616005)(6506007)(66946007)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6819;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GFMILwS39nRDDurBqyxC1z5DAE6bTHZWG9gtBkGZwgtDG9MOHiGnmcYrDhpEHVBXysyGpoKx8z0RhzG/dC6bw/NoG+8hqAuMy4OzsRcfDy7mffqczWthfd70OTVczy/23GsJCCPvmLz9zpHd9I+HDGju69QG5fs8KEFbGuxrRh88EDHO2TyGnB/15WADQ4LV+X1AmbzuSt2ddY/ZKyF7F081zaQomsQqzFN10OKJQ58bKobbXAJM5utlkaN/wRnFHFi90O/dCVL/9DPdS0EzXZ6bPtDcJzbuBTauOtD3Nra/9EgjO2gR5OAP+tLOpEFZbCi71XYguENhHxBhG5xH6JnHm7uvEjlShYrFdsmj9Yqw6ZAsgp9/WPXT3Xl6iRH5Jo9SDp8TPSQ4cJPQEUbr6lO5Q+8HtuPjFMSx5s9uOP642qusmd0PT4FxgnY7MW/S5HaGyL9D+/fgxU5wwiW/4WHNt+nIAmUUfsWK5BP2gVsdfWp5IyegrJDOn2Zaxa5coiMeeBCpHcQFG4MinsCT4dJS4FN3qV8V8sDRdThyVtweqvUMJjATut7qa+/qASsdv4poIYwft8+dNu4MxbACLXrgiQ/g1geBD/mjE0SaofztuVn7tdJNHB8keojQcov
X-MS-Exchange-AntiSpam-MessageData: h2iyqcuYSyTSINsJCE5YWrbcPfexuSvWVR2uYbe3ycf2LjxfijWQ+9w+eLWTn1L3Z4yaWgv5vUV/9w00r4dWfalfH4DdvsDIzsoeuBf980WxJ8sVLxNORaTedhjnw/mg3bOP34uWb5jJHYIwk1aj9A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15bc919-5b95-4401-9900-08d7ba8c22a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 07:18:53.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPe6m7Nr/SJ6LQ1GVHJVNnABGEz6Svg/0ua14XZDtwfJ5FJHql25wpD8uNb4TPmrFGmEiUX/+qOJJA4xa6/1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

All protocol share same smc/hvc id, the protocol id will be take as
2nd arg when issue smc/hvc.
Each protocol could use its own shmem or share the same shmem
Per smc/hvc, only Tx supported.

Peng Fan (2):
  dt-bindings: arm: arm,scmi: add smc/hvc transport
  firmware: arm_scmi: add smc/hvc transport

 Documentation/devicetree/bindings/arm/arm,scmi.txt |   3 +-
 drivers/firmware/arm_scmi/Makefile                 |   2 +-
 drivers/firmware/arm_scmi/common.h                 |   3 +
 drivers/firmware/arm_scmi/driver.c                 |   2 +
 drivers/firmware/arm_scmi/smc.c                    | 146 +++++++++++++++++++++
 5 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/smc.c

-- 
2.16.4

