Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4301CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE2820707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="IUT/rnTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgFPMBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:01:25 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:34211
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbgFPMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7eoQXLlP1TnBTpNHv/ipNIKuK+zzOL05VDzXmPwFF+Zw/OmHjXC4R32MibIQZJJc1xkaJ7883HhxFzfaPbcQNz+J8LJtY/7yZwo9IUw3jDvGwqds2OslKa/f6IoFgmslehixg/rix6ROP2T3FNXEvxKlFuiLG04Mf1/jLw6r0x7lDR8E379HFpbN4ObQi8LmemBfWUFCA+NYRVIDKI/wm1zUrPNBbj/VohivJqf/rEs6m17NrmcpwlxT1GOcTwekxhSUF5f1uuv62VzUPuGEU7cv+BTYqdZO3VoikRf2nndF3ZcaA9UHbE89B66usJN6Q7aLB+isnHrT8flYVc2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQUwghQBIlyWOgMEomySlhHigzb9LkGY0gigbDBTZBU=;
 b=If0U1SfdhC3IGAQVZV7YRCdOHiNWDPFc9vkIvFVVsNwRCMBJaSpwICqZYCT3Ky8DzS4wfYlwyojpGOZIKRPT6AcXNer9OHdVe6vMwXS9bx/mbN9dIX3Kxe87XSnAXRkJj0H83bqSbiLJQN65jMXhZQY2gIjGZNcLzFobz0d0MG8Z3Ojl4xVchamkX4Y+95qyONzJ+IXrB9SZ115W8m9SNS7pbjXkj800wnExkzgwm7BB/wGXj7F12XrS2ll8zmy42qKCx5LLOMIS7KOr2/UQ2Z2WiPsznMs7bjGDBq2cIEHP6h1nQe9LUd1k42xdmYozSonbX0THxg2/azvm8LCWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQUwghQBIlyWOgMEomySlhHigzb9LkGY0gigbDBTZBU=;
 b=IUT/rnThefE03c6LEPQIe5DdFLJQHUdti9ylSYhFL4tsrMpG1GiF1kGIMIslyk70IIYw7LB52iHrdkzUbrPQsDLajqAHUnipmjajFF6ZaKzSZSs9+cGxGfOJTLVKNUCgK8nHTR9ylQ28/0BVukPegXjQyLc9VSH5wS/jCT5KgZ0=
Authentication-Results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1409.namprd13.prod.outlook.com
 (2603:10b6:404:111::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.13; Tue, 16 Jun
 2020 12:01:22 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::68f2:768a:7a8b:e790]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::68f2:768a:7a8b:e790%7]) with mapi id 15.20.3109.018; Tue, 16 Jun 2020
 12:01:21 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com
Cc:     aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        atish.patra@wdc.com, anup@brainfault.org, alistair.francis@wdc.com,
        lollivier@baylibre.com, deepa.kernel@gmail.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
Date:   Tue, 16 Jun 2020 17:31:01 +0530
Message-Id: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3088.25 via Frontend Transport; Tue, 16 Jun 2020 12:01:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c8d9cb-70f9-4207-e0c9-08d811ecfc00
X-MS-TrafficTypeDiagnostic: BN6PR13MB1409:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR13MB14090BAA12AE6157626B78668C9D0@BN6PR13MB1409.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0ZUbZ1YMHYY+MmLxuXkMkNnkHl2kqTegYpXpOfRPrH4Ms3yFh1n88gB6xRtS08iIno2rVHEMQ3b0G2/H5mTqSHtfec/aWqOpsu8Bwc+ObvwsrAO1vsQS0WRvToyZFCtFJAMFI81x7ylHUp04ZNlzzihYkIE21Hcaqm257oiRmGiU/unKiyvm4nWwlfJ4DGMJ+Yf8I84mdHg15+vQDADropRz/jjzz/trvTifH8yRI8nEVvfnwekF18bnlRlg1P88hAw8EPN4NK2VPZJkScfil9z72Ao2rDh4r7C89SwbSQhl8GjCIHh7cbqU/hmsZQACHo3pOQfZTTVvr0PTGQTdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(366004)(136003)(39850400004)(396003)(346002)(376002)(2616005)(6506007)(52116002)(956004)(4744005)(6486002)(36756003)(6666004)(4326008)(6512007)(8676002)(107886003)(44832011)(6636002)(7416002)(8936002)(478600001)(86362001)(5660300002)(16526019)(186003)(2906002)(26005)(83380400001)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ctUQnQMzXXtqOiqoU9ViZnaGTnXWf4N3ki9QiI6suue3QPgl9Pu8Y/INKSZ78y9SQKIbfTG0EeWiX1gbN1fzNPA4NRKYwTzgsWSU0NgL9DyhFfT3DNBezu1aum/Y2luU4kyjvhoNU9nxPVPftUMTuBzDKaZWt3aqPvk1lkBmy/bz1+QWnIGA2gcwPtLu4PlVqIGsHS6sbjCxGBxsKx/ct7GaO7NlO/uqgfJxxSeVqnf9N/bZmCfSJHipGsEj2xjmxH0AcAWxvkiaDKKgkyEd5BmCXihcK6Ts5orFC4hoad+t+mHKuQN0e4XzJgDNbJyBqt/A9C9wh4EVf02W6k8iO5iFg1LcFvYPeSDLqFW8f6NGQSkhuSq2pgyJiH77aH6wy2Pfm0K9hPzMSeLG2rOgFTM+PqIG2DKbEmOSvCk3OFnz3CpxB1l0miU+7KNc9z1Lm9hELfBT2+IrwvVVUmSBcwswUwgT0P0Hx51Mq90ycGw=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c8d9cb-70f9-4207-e0c9-08d811ecfc00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 12:01:21.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVHoh2vXRrZA3hHT59bViQwou2jvOcNcW/CyyRH17WXjyguABKcjyurpKFEYpV2mRFT4JSV9UvWo12mFEtEfHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds the support for dynamic CPU frequency switching
for FU540-C000 SoC on the HiFive Unleashed board. All the patches are
based on Paul Walmsley's work.

This series is based on Linux v5.7 and tested on HiFive unleashed board.

Yash Shah (3):
  riscv: defconfig, Kconfig: enable CPU power management
  riscv: dts: fu540-c000: define hart clocks
  riscv: dts: HiFive Unleashed: define a default set of CPU OPPs

 arch/riscv/Kconfig                                 |  8 +++++
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |  5 +++
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 38 ++++++++++++++++++++++
 arch/riscv/configs/defconfig                       |  5 +++
 4 files changed, 56 insertions(+)

-- 
2.7.4

