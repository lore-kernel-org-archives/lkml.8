Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64E6C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838D424658
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="PkAvDVlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgAMGi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:38:59 -0500
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:6167
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732311AbgAMGi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:38:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4L4xROtbbbKyrT2gCvzY7jx7uOtUwjwfJ1sIgwYwesRXl9M/Po29oQUefp3vL4YwR6zQOo4g8mgxD5/NAVJr+XPLjgXgl0YRkAqSzIyOK7C+Q31Yn4uiFzJNgGrAKrdMKKLwQ4zMTCZLzSRvofYF1FmyI5jf/fmdjWP5jtxfRs1AD8FhgGe4gaSprNveejavZTQEO1PofCUQiZiRYQAw0PPphrT8vw7+0Qjpxq+DrM8Uw1+V38iremHfHw4QCqrhXX0ZLF7lVku/iZXd9I+uaxjUbhR25g1xzLrcb7VWDlg69pPxsBIYE7QI6Bidc8c9KqGj+gFkprt6SoCFghPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqOIirRI0cZBJAG6vheFx55TC+0TTtAeku5hlq/OSZg=;
 b=CXOq0jRViSu1rP4CPeJnakUaBPZP5eOruS4S20WuLD/VB97MCEhv8Fz6warWERXuiDHb8Kiw5akmqSLxe3cGTzygg+hdsIwaRW0wQojAfm07OQGZfE7DVFv5lVOlme+0iom5FvpzPCTJy0fJaRRUktlMLzbdYU82mPDDiH1OWzYs6U93pNqRfTBBZuy8uyBVza62BbJCdlE0wMGbR8PZrbniCEhcve1uOVKPbFugedylrnUPSSz5JgE1oDhBDBxHWtUXN/g/qfdtjgc0XY86kSmCTfF6/J72SUT/hkwOHT/KZV5sHl5KstfwmHPDYATptR/IXSQiWtDsXymH5c7pKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqOIirRI0cZBJAG6vheFx55TC+0TTtAeku5hlq/OSZg=;
 b=PkAvDVltjWc6ZD+BOfAMXVLjh/ByekWj+Kah+V/oQsQPlICBOhIo5uAH0xUXh6MUS6O/FmBe5qFvawHScyn9aso8dZnsRv7qdYrMbHYb09FH58THSqs9kGQrAPr4hEDUxFILYUAPIwt9VhDeWLVSAaelJBCURmSIVcfhajAhLBw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3317.namprd13.prod.outlook.com (52.132.246.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Mon, 13 Jan 2020 06:38:55 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2644.015; Mon, 13 Jan 2020
 06:38:55 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bp@suse.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 0/2] cacheinfo support to read no. of L2 cache ways enabled
Date:   Mon, 13 Jan 2020 12:08:18 +0530
Message-Id: <1578897500-23897-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::21) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.11 via Frontend Transport; Mon, 13 Jan 2020 06:38:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a3c56c-5f02-4a32-a2b5-08d797f342ef
X-MS-TrafficTypeDiagnostic: CH2PR13MB3317:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB3317B10A28D63E42601EC1C88C350@CH2PR13MB3317.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39830400003)(136003)(346002)(189003)(199004)(66476007)(2906002)(6506007)(66556008)(66946007)(26005)(186003)(16526019)(44832011)(5660300002)(2616005)(956004)(86362001)(8936002)(36756003)(52116002)(7416002)(4326008)(6666004)(966005)(6486002)(81166006)(6512007)(316002)(8676002)(81156014)(478600001)(107886003)(1006002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3317;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CU7QHZr2iL7342kfz7d88TMRbQZmTJnznQRqyNDO5dtgIB8SjJe8idkulPOHnYWiyd+GaokkvQdLNvmtOlK9tHvZ1zYFuoB5/qEm/w40Pztmrs4uWcovEHcN+Ul1OkYYwDpeFx0ROq42dZWU/MLLks6tWWzJxhA3fWW8hFRym50Pg3GEcnmY8HxVa9mh+8gR4Z6UEO/LZ0JmC+sdixdfJJYYOPinEe19F+Zx8zOjrpti+BidNw54aiqXHgouXYfq67A6uRSJv+q93yn8ULPc+ku4Sz60Ph3OhPjUQYtRjdOMjENaqM5YoNAmcld1YpvgwfiTKNMw1Hl00cStKfLw3LHN1Y10gG/pou/Wn6dyGLQ3XB4aHBPRLyd8tOqvhjPykNyetPqBL5CEBXOfeaZvAW/M5Gb/Xtuj/GzoBdSP7KJTtsldX958JHdA2WkB/WJHJJLwb026hZn0Th703wYbIrXtJTAMV1XwbgNCvGGuqy5bbUXjV7hmnyWn9cF4R8aBgPvRda25QvnrZ4N01HSXg==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a3c56c-5f02-4a32-a2b5-08d797f342ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 06:38:55.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ16dDxNVcP5GSAePV7coctCFPvckxHHozeCury/L5S45WvxnM6mWYoBsw3CvXLeKmKBvhLJgwhA9LgPIIiFyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3317
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
 include/soc/sifive/sifive_l2_cache.h |  2 ++
 4 files changed, 72 insertions(+)
 create mode 100644 arch/riscv/include/asm/cacheinfo.h

-- 
2.7.4

