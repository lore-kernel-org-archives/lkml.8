Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF5C3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E076724654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Br3pVW4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgBTFPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:15:46 -0500
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:6221
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgBTFPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:15:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8zSVlQV5jDuWxKDpWEZfD88YM+MvCqxN7LubsPdbY743hWXVBnd5BoAR/Ef1GXbDcgLeRttvylwV0b8hoZQmoUZx1D5ltv4ZtIh36k2C1JUEQFT+sAHc35sJSnnsediYIN9Cxprhaom4G6IN+a3rDULYncPRR9qDAIQ3vUmBVwMtJ5NVA4Z6/I4zMA2lCCwKbcHh4UJwDcofykGzCvIa/uQTaUxtzWfqlyCI16CqQ7sTCKae/fVK3ycqZ55S3TXAawRyPoQds9YDFXMG5UwxudBjNla9nPhHaYjoL09SIaK+kvDI5UYPh11yHnTJC2hbhX0Ky0fJtkdATKrMK2PSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0QdYbW9hQZiaX1B2N+bNv9XwqGcFsZKNFsxULV2KXA=;
 b=RRjJn4ZQHhEdNQy9KyEsssjpzED85+P2gtJ+SY22P9R/QZuRtHVEHIbtXNhbd2+Ja2cIAQv78CP7yB6AH5qPMSpQHYfi72yKRZjlWohcNgPMj/waGucFgNttY5g5Gmg6x9G2ZvDJKPKbeOMsHJNWdWwvGu3e0tcrS39n2R8tIo/gEi+H0eB4HAwJWIPxfceiKG0sGnth9518Oi2Kcz4B4URFRvBLlFVyxgWo8TdIA3qtnN/oUvCawxYXdgqmS18EMUsKighOco1C8jN+lc718wdyQ2O8mcFQPvZtfeciD1zThapN7qJBx9i+9hza7gLYkGmdVLHOPkOZ1+3NcKriag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0QdYbW9hQZiaX1B2N+bNv9XwqGcFsZKNFsxULV2KXA=;
 b=Br3pVW4CcQ5R7JdhFlc3DkI0fh2yRPDJpFzSwOQSLiIdvbKkjl+NhZv4MMG/JaWXKFlvESfx3JzJuhZ3sFOukFP9cC53D4GcdkXHBWsJ9HjE2M0RjSIpreI0hWlQ6vxchxmvkGn143HmpVBeKtwsvTAzBM3Ihxccvj139lYqEwc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3495.namprd13.prod.outlook.com (52.132.247.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9; Thu, 20 Feb 2020 05:15:42 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::55a5:5dab:67de:b5d8]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::55a5:5dab:67de:b5d8%5]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 05:15:42 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, anup@brainfault.org,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, bp@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways enabled
Date:   Thu, 20 Feb 2020 10:45:17 +0530
Message-Id: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: PN1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::26) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by PN1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 05:15:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eaa0bd8-7cae-4580-2af1-08d7b5c3eea8
X-MS-TrafficTypeDiagnostic: CH2PR13MB3495:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB3495F3AE00D5CDC1A2FAD7C88C130@CH2PR13MB3495.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39830400003)(136003)(396003)(376002)(366004)(199004)(189003)(4326008)(8936002)(316002)(81166006)(8676002)(5660300002)(6486002)(81156014)(52116002)(107886003)(6506007)(66946007)(2616005)(16526019)(6512007)(956004)(478600001)(2906002)(6636002)(66556008)(86362001)(186003)(6666004)(36756003)(66476007)(44832011)(966005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3495;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MZCh2RMhMermJbZjla7pbW8WVzLUzfdOoJPPfTfKoLjdDzPGhg4bqrts2nEKXFGBY67Ykn7kESSwru4ojAqFoUXJ0ONpSoKSrKa29FIl7jkfUhdM2c9tJ6CDHnLPni+2fC0VJW1dQYrdTsganLEPA0eKU0gnH+NeR9Q/APRV+4TaH7JE8s64ackGbQPykPOFcdq0u8ckDVilvoIfGslP8YZned7b01iFcHt6eEUMj6ggObM8kDJ1u7rH1vw4hNxGmblpF3VA4aCvTyTI1dgIRSE9uDLf95dggW4lx61u9CPcJU3snLsZzf+wDhN0vHSTVO7IJo3c5HZ9ouKZemjYRYc6uJE7vl1InXmU4q3ZzzyXrkr9rpzGNBxHlFTNt37F92s5PjE8h9QSrxSUDpXSHSj0Xu8i4BDfmey5ji/aYHhnzjo9+0Zf1mn4ynMoPmFmsftPdKEtwqaKNwOstptwCY69nircSZNiWV9iCQcvyNyMf93oShK72G1tksCSdbRyC913UnHsO6Ry8/7U6JnqA==
X-MS-Exchange-AntiSpam-MessageData: JPaCU8yf5lRn69ji8JuJk3hGkCLv6YyBEKP/IwPUQGmvBH/blsWDu5x789o93s7yVAMd6cpXs6BpjkCFBY9e//OWPu+zCmupYqDQScGhU6RkXOeOIj4tPFN8Fs+Ic/SMGv6+CSq6rWvxOReU87StdQ==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaa0bd8-7cae-4580-2af1-08d7b5c3eea8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 05:15:42.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaRQgNs7ysEzi17CPkUIyr9VZ8z9oBAsQKJXYrIPqauIQLpqvLir6sxhYvxIP6xOmpAL49ZH1PRK7qGUOUsLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset includes 2 patches. Patch 1 implements cache_get_priv_group
which make use of a generic ops structure to return a private attribute
group for custom cacheinfo. Patch 2 implements a private attribute named
"number_of_ways_enabled" in the cacheinfo framework. Reading this
attribute returns the number of L2 cache ways enabled at runtime,

This patchset is based on Linux v5.6-rc2 and tested on HiFive Unleashed
board.

v5:
- Since WayEnable is 8bits, mask out and return only the last 8 bit in
  l2_largest_wayenabled()
- Rebased on Linux v5.6-rc2

v4:
- Rename "sifive_l2_largest_wayenabled" to "l2_largest_wayenabled" and
  make it a static function

v3:
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

