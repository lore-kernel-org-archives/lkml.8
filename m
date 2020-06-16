Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809AEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579DE20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="eLaEbcqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgFPMBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:01:33 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:6161
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbgFPMBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUrkUSvHUr6UTq0D7X8j84VkDtrmbA023KGvItdYYHIEHw9S9tL3ctEmHZfaAgAFBIvgkGaytEqFQ5WYD7QvtjDSGkaWU1+teHA4IZLVyVE4ruFVA85zH6Ag2418qIknVn59dD/CLK0m/9+kXXcGuAatbSxPbN3LE/D/GE7+agEfmnhF/lTDFh90a6ztAKRZTvTyhci1L/Grdb8bYRZn5vs9Bc6FMAMRQhMwztvSxFZwBHKBvpvOD0Qs9oCfp53rOdewke5RsgvCk9yk5hQLs+RPxhPduyGeq+JXocVpj3XP9OzUUYqCJOuc/CH7P++oih7/6iOiBGx2x8Es7jR+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SCNgSKq5YVKyhNqG1Z4u5Lh9kmk05r6mzL4E09q08Y=;
 b=Hn5ku9yDEv5H88bTkghsN5IRZmWk6irNveVAmtXjQDWmwrXzo+nSyfOSDcZ2FAplpudJ8kNnoV9BfVWSuHrKAMFXF/S22Rm3/KWLfKw5mWCChp86hrw+DVw1+FG4Jffz08oYwuQ/uWGQ7CAbTaXNuk/R4KP7QowOQ9auaWNODiVEBdFgQ33K2+Gufft1qvGhtcgjt8rjqRMFNMA1cAYnhhcECDVN5ogf0u+GMYOkQT9WsZTFQdKeW+DGrhXKGhHR7GBBY3SLnqahICTh/rIkdhIS4x9Y1+QW7Gk4/reTw9mb1z+Z8+V2C6OFclrrZvsTBsdO/vcWKPGQZ7BGbpm3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SCNgSKq5YVKyhNqG1Z4u5Lh9kmk05r6mzL4E09q08Y=;
 b=eLaEbcqZT8zDKDUpu5khyMApmK3JeHBic8ZBK9hvQqyjGTJhb/9Xu3NAc9ixcjYS8anlfQIhcTFm3bd81HC1TYcSskKt2mky8XR6/oSkS8IuuX6r8Fuz6RBDx6CgLnQAONK0b2vqGH/5WcObTXFy/zcEo9JEalkQfrRCToyYy2M=
Authentication-Results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1409.namprd13.prod.outlook.com
 (2603:10b6:404:111::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.13; Tue, 16 Jun
 2020 12:01:29 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::68f2:768a:7a8b:e790]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::68f2:768a:7a8b:e790%7]) with mapi id 15.20.3109.018; Tue, 16 Jun 2020
 12:01:29 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com
Cc:     aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        atish.patra@wdc.com, anup@brainfault.org, alistair.francis@wdc.com,
        lollivier@baylibre.com, deepa.kernel@gmail.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/3] riscv: defconfig, Kconfig: enable CPU power management
Date:   Tue, 16 Jun 2020 17:31:02 +0530
Message-Id: <1592308864-30205-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3088.25 via Frontend Transport; Tue, 16 Jun 2020 12:01:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd7212a1-b9bc-44ad-a81d-08d811ed00aa
X-MS-TrafficTypeDiagnostic: BN6PR13MB1409:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR13MB14092C8E4676443F2E81D42E8C9D0@BN6PR13MB1409.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7d5MdAho7Jp+zXSdJ1EOLEg/Im3nV5s2/Elm++0/qEcwqDaxs348NGkcphKFOFXu5kncYVa0Tt1drT/A5t0DMU7Cc4YaxhAfMUaycJ6U+/69lMbf1YnzWQKKKXmLM0zPCHqRxHmbDCcmJtGJTfUe5nMJBXeByQRUMKpFDziWTlOkJAcEfnKuGeSnfgoSsFM9QPXM3mUNhB+ZXxefdS4uMaV1KsvqqZWEa8BhedgcrNLWQ8o/JMPDBqX5DHXIhH/QumDA2PDqsNIkkMkkPx59C5HXkSzt4xceA+TisOKym7rP11WEXYfqN25mh0V8Xz+1Vapx8omKGWeimEhTh5Q3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39850400004)(396003)(346002)(376002)(2616005)(6506007)(52116002)(956004)(6486002)(36756003)(6666004)(4326008)(6512007)(8676002)(107886003)(44832011)(6636002)(7416002)(8936002)(478600001)(86362001)(5660300002)(16526019)(186003)(2906002)(26005)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XREa9rx5RefXWvkJTWdpMupon39D5HeCKhwEqOpzeE+BTNt8CIT/WZjDP4mRppJm7JWBIgKLYWyOWmMQ2Ha5vvlGZXfbadJeGgxSDshlcstgE1s3alE+A818J4LO3trHWTZqiw+hrEX6wyJsm5+K1toyNdMuAmlX8Um6d3HYUe4jZkglNHnJozCsyfJW6PWAFAoi6qvERb1zKvMgGaMRp73iXAXrrZpkk/tZSCycQKl9QrBlt2A7A9AV5hJfmHgucwLj05t5e1fCwnyfLlnY8nccX3ieVh5O/E4tVSkOVaHgZNzEHs9KxBrQApZbgiUv9k0QG/xR38VYEpAPVHkRXoSWpMowGZcl7VCOjQuzgTMryc6C1EY8LFNFpw1YOHMBEnLPnLwdWP8YnfRSz5s1lIurA2wVRnso3NypssRgKXXpLztYnOYwjANctwhVkI8YMbuHgE0oHPbvjunmiMM31ohwnhf1sD/go9G3NsQG1cM=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7212a1-b9bc-44ad-a81d-08d811ed00aa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 12:01:29.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1sfu/su+DbOUKKBKHO9YhBWevvkJYe4m9vffR/qYFp4gGpaicGDiDU8pevj1O71g/q4qBpz/X0IPOwIDZK8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPUFreq and CPUIdle for RISC-V systems to be configured with
Kconfig, and compile the kernel code to support it by default. This
will be used to support dynamic CPU frequency switching for the HiFive
Unleashed board, along with any future RISC-V boards that support
CPU power management.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/Kconfig           | 8 ++++++++
 arch/riscv/configs/defconfig | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a31e1a4..1c8443e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -381,6 +381,14 @@ endchoice
 
 endmenu
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+source "drivers/cpufreq/Kconfig"
+
+endmenu
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4da4886..58f4bce 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -17,6 +17,11 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
-- 
2.7.4

