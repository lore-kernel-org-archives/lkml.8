Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEDC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B4620728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="ryBSdqRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgAQHoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:44:06 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:8462
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727804AbgAQHoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:44:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSf1yzEo+LeQlYZmaE+lRE6hImkowpyXs8F5EQa6B9w4z6r4C7D2EWm7RmzFQu+SjRghAbpdydwHnlaBo4Tqe8VwN1HkbFRjKJJDE2IK9NMXp0HQS8H4i06X8UqdpEvzmqSbA9Z81YggN146Ss3yro7Q+kSpNm/BFAZ5Zb0peuWRQ4fy4pqgYClRtnvATi84aIzBc82XvzWG58/vn2hUJDx04CVnpS7Cc36eGzSXtt7A4YOR9SRjxCenz7nCyO98YFJO4QgNNHx0VLE11X4UKPDD2soXfW0fncDSHh2rsYh1uEuwVhL8YOQ3A8mhjSqgVZELBSB3GNWX0BqxXrgxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4ZmAoJ5SHPqhdVbD2ZMWRl6EnQAXCTAeercScOkxEY=;
 b=W0XvaiRXD61FtZp26bU9ScQWJI4fL/tUV3JpOxr8xYpLkxTUNgC6sBfsHs1AioMaGXP7ZG7svZCXboTyxdwllpJc2HVHVs4vJ3QObwar/xi3+jR8l316aNguGAHd+0UQZk9uK74/lWNpvltFR8VtumKmb1h5sFpYWmqK/P+rJdZ0Z3/Z+TWBYNqenIXoqqVoQhi+5mL7rx/i8PR1pZLG106SrGxGPznmNMVDBg+15b6VEvNvNNmLlrRep31j9DG6rHk/VoUH0UP7TkrlwEf7rv/20MuV43/yHUjeVhH4FVEutfuC+Vdhb7zzYBPoLwbLB42ZhJ9K1W+1kbTgr9MdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4ZmAoJ5SHPqhdVbD2ZMWRl6EnQAXCTAeercScOkxEY=;
 b=ryBSdqRbuCvpv5NrRu0q6O/sLmFf/dVPFla1hRdRCyiyxsOsWPOa8eHnw2qY6nucNAo4QuSQnmmYiR28JCscTJmxDfcMGNItoE1K8cY4fW1WxRScyI1CkE3Fe9LHPbD6Bv7NG6bg7H7OGGFa5ppDZqjdCIlVPOg478/5sc7VMao=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3765.namprd13.prod.outlook.com (20.180.15.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Fri, 17 Jan 2020 07:44:03 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 07:44:03 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bp@suse.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v4 0/2] cacheinfo support to read no. of L2 cache ways enabled
Date:   Fri, 17 Jan 2020 13:13:36 +0530
Message-Id: <1579247018-6720-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::18) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 07:43:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d7090a3-fe10-41eb-984c-08d79b2105ce
X-MS-TrafficTypeDiagnostic: CH2PR13MB3765:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB376525E3AA3D839E23FA10DD8C310@CH2PR13MB3765.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39850400004)(366004)(396003)(376002)(189003)(199004)(6512007)(2616005)(107886003)(316002)(956004)(5660300002)(52116002)(36756003)(16526019)(1006002)(6666004)(26005)(66476007)(66946007)(66556008)(186003)(966005)(6486002)(86362001)(8936002)(6506007)(44832011)(8676002)(81156014)(81166006)(4326008)(478600001)(7416002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3765;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GgEoWgoop3FGJbUiDnlG+7BawdWqoHOvb2q/Jc8TE3yxTaiUjol03LpxnrU5rsPrU5W7HA/YufZa/oi1LFrCzOf+Er9qHWJ0VwDhF+5QRUzsOVXD2O2awWpiHtTWafqDAPNSFA8LVRjBrW/Ha+YB2LcBYOOEfF7vxo9ZlxwKKp+imV5X+jyqgYfNSsidXOUtKk9SERiRVfBSu+BagCZ7mv/EampSnrVcrR7O+NegHB0Qx3sO+3nx1BQLyQjTqHAvXrjSTsZQsC6PRnvxDyZ/xEQloKuHUmtTfspHz1GnbVTuvJ1xUU3vByJP+lILwmAxdCG6Al1o+L/dUl1pycGs9Ne8NkL708ETgbx7V4ssuis7vndibTm4z0YT1auBHi+z6HhSIrwStk9YM+4AtXosHvs7vWgmXmAI6C9PW/OpabaXCJQ31BNDh7VPde/m8Uj2Z7XDcPaqkBXvgQSxMd8Wz38A4DygmpQqbuL73i320Y=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7090a3-fe10-41eb-984c-08d79b2105ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 07:44:03.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBcKrqmJO+KbCuGJLPjQAZIbV+PzYyb4vyE2LW+xcl3wVBGUPHBQO/R5I+EnBj4LMpYgJ+okHtN6RTMQLfKsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset includes 2 patches. Patch 1 implements cache_get_priv_group
which make use of a generic ops structure to return a private attribute
group for custom cacheinfo. Patch 2 implements a private attribute named
"number_of_ways_enabled" in the cacheinfo framework. Reading this
attribute returns the number of L2 cache ways enabled at runtime,

This patchset is based on Linux v5.5-rc6 and tested on HiFive Unleashed
board.

v4 vs v3:
- Rename "sifive_l2_largest_wayenabled" to "l2_largest_wayenabled" and
  make it a static function

v3 vs v2:
- As per Anup Patel's suggestion[0], implement a new approach which uses
  generic ops structure. Hence addition of patch 1 to this series and
  corresponding changes to patch 2.
- Dropped "riscv: dts: Add DT support for SiFive L2 cache controller"
  patch since it is already merged
- Rebased on Linux v5.5-rc6

Changes in v2:
- Rebase the series on v5.5-rc3
- Remove the reserved-memory node from DT

[0]: https://lore.kernel.org/linux-riscv/CAAhSdy0CXde5s_ya=4YvmA4UQ5f5gLU-Z_FaOr8LPni+s_615Q@mail.gmail.com/

Yash Shah (2):
  riscv: cacheinfo: Implement cache_get_priv_group with a generic ops
    structure
  riscv: Add support to determine no. of L2 cache way enabled

 arch/riscv/include/asm/cacheinfo.h   | 15 ++++++++++++++
 arch/riscv/kernel/cacheinfo.c        | 17 ++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 arch/riscv/include/asm/cacheinfo.h

-- 
2.7.4

