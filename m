Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C76BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0934C20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="RMuI2ADL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgESKqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:46:50 -0400
Received: from mail-eopbgr690062.outbound.protection.outlook.com ([40.107.69.62]:62368
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726859AbgESKqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:46:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBEyoHsgeLrAB/QaKXcBdr8iNprhFVB0ooU4yANzUPOsxuKpuJar8fvrcobdedTxVV1I9mBb8sAYUmWDWkwgnarrwfcEBhHANAv5s36/8FCU6mHO7pMHFgxSFfgMqqbNfJHjmCru4Ayatj5kqxMFeVd6Inov5LnS6RDcH28Q3APWRGl4Y7EBw+jrGHS4N/blg3qzzP07pgUyjw1mQkVklnyB7SiyYXuzXqvxVEo4gK6fzkvI0Gx+0dhp+o9UrQN6wi0Y2fXCFlVwbook+gsuC9AVVKjQN5hSXO3csMWs3wF7aSIm91epQg5mIdahSbGU6NgeEBBzn4zHpHsZqSQCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Wn0DVJtsrYagW/LRvYjoTz0Wc573KNruenw/iPvcU=;
 b=DherarqGUOAJ7gQjHEVXSZe5UpBDkf5Fr5b5Y7EQgz9xDUF28LMsIDGKWhXv8P8kFAbkCeA1ybfIVxunbruGQ+K7wFDxHOlGt7iY3a4QsTmI6+qjzDJyAAWhmlx/AHNktw4oKwF/PEYwm0OftQByXQlcu79OFltD2XaIpH1Ol3VC2LODC3tXKxnNWa2LKFqFEeDyR/ddCKPwQVKmjAIwCQOqYC7HG3zOvvjkKw5/WR5yFpM1XC4tsX3w3onano1ad+mBXubHqRX9/ouPZGNSDH7VOFvLcMhbox+WW7+B96s4F+G9akIceaG3inqGfXDrQY4qZTFqJKryTg9cJSPi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Wn0DVJtsrYagW/LRvYjoTz0Wc573KNruenw/iPvcU=;
 b=RMuI2ADLZ6Hgp9fBFZQHkG7yck1RHIbHMZ9q/QldWyN7o0m8PBCgTh/Xn6SQEK4jCriXvxfnd2sd0e1tmkelLLBMrhGpzXuZWg1XZy/Sj2xG3oOPnHJPWcf6HP3vOCfX5pb42Itf1PIlrTPHVmjly/FGD7AsAVoUnT2G2s6eGwg=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=sifive.com;
Received: from DM6PR13MB2619.namprd13.prod.outlook.com (2603:10b6:5:140::13)
 by DM6PR13MB3882.namprd13.prod.outlook.com (2603:10b6:5:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Tue, 19 May
 2020 10:46:47 +0000
Received: from DM6PR13MB2619.namprd13.prod.outlook.com
 ([fe80::ad23:dfbe:7ec:e5ca]) by DM6PR13MB2619.namprd13.prod.outlook.com
 ([fe80::ad23:dfbe:7ec:e5ca%3]) with mapi id 15.20.3000.015; Tue, 19 May 2020
 10:46:47 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        anup.patel@wdc.com, Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed A00
Date:   Tue, 19 May 2020 03:46:26 -0700
Message-Id: <1589885187-31247-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589885187-31247-1-git-send-email-sagar.kadam@sifive.com>
References: <1589885187-31247-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DM6PR13MB2619.namprd13.prod.outlook.com
 (2603:10b6:5:140::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:e0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.10 via Frontend Transport; Tue, 19 May 2020 10:46:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7172545-83a3-4f70-eb78-08d7fbe1ed7a
X-MS-TrafficTypeDiagnostic: DM6PR13MB3882:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB38828DB4A8C006C0F2B11CB599B90@DM6PR13MB3882.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6FbN/C+ljg9uJmPxcpWpEe0gC9TZEu8jXFQXmjo8e2h75anUrQdosQKW8iPre5F9EPCxYlxkpNCu1NqUohFVZv4BGDQ4ADFA7jph/2S6XuYRWGgoZd/xmyOQG5QKvku3kBlXt3Z8jLv1HuPU0deMS30BS/bligXJFxqlFG1deRLGArniI1XmOYETpEUZQyht9FOjFq8idvOGgjHW2lBIGbNgjQIXk+lgvAgTQCm9/2niFxJuqBmo9NPf+/sJFw3tC8HlbRHBV3+ERFtQA33GqKS0Jt3F8sAQ1mYaOaVLepZc1IJYqj+k3FdURo6BvdO5i9ANs6Dzgnb6BQ+0xjoYdiYkDYYjbEH2rQjnE1BdVX4JiSpoMRBRbTzIbacA4vIUnCyY9JBUVHRXvCQ9KRN2/qAuOxTzRMKkNgPrKEU9+p3Q8b3pwE/2iMo+EtXh77t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB2619.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(39850400004)(376002)(366004)(7416002)(4326008)(86362001)(6666004)(66946007)(66556008)(66476007)(316002)(5660300002)(107886003)(36756003)(2906002)(26005)(6486002)(52116002)(16526019)(2616005)(7696005)(956004)(8936002)(8676002)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QNoHph9qFMusgJwQajExXVXArYJDfjgzFXm1yuVjNJQYPIxsjmGZRy2G+tgQED9gOJnps1b1A4cRUHsre00A55/lgKmQ+xJG9Rm1XBM0NQHPBi2eS9mVQTxVbER5tVc0UPybfmRmlnn8dEU+uykJqtn2D+Bv+MmXZlsEvJnMhq+boJgSYo3jt/uV31UYmcKVMaTKdVDWhrqHnepL/CsXZoAt6BPUxiej/wyWzLo11NA/YGGP5ceKRJDYK3CRasz2UL6odX7Kb7BefJdmBbkmREPF66Zzf0BIJDQTbKlyqw9kP2dB+cvhYUzhs09QacL1dt/OZve/AUy7JfJXxqPDtg+tC4pK9n6bEZxJtXDeZNdgYDQNrWSFqSJbhJTh7Hcq1EFw5kOshOrp+m0IE2xeXaQ/946ZQNR7r+1gB9WfweUSIp+0lSuIADBOEKsevX4Pr7BePH3pY6y5khEmLGUuW6JeadUeq9JBVnnVRcK4hOE=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7172545-83a3-4f70-eb78-08d7fbe1ed7a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:46:46.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Abmria6zSZnomc0GW7NH73BiEr973fLpLlm23ViwrdligDRbZunNyJ+WFnI/GA0VrrKL8SCjIcItChCISS3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MTD based SPI-NOR framework in order to use spi flash available
on HiFive Unleashed A00 board, and move SPI_SIFIVE to Kconfig.socs. The
configurability of SPI_SIFIVE is retained and still can be enabled or
disabled as required.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 arch/riscv/Kconfig.socs      | 1 +
 arch/riscv/configs/defconfig | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 216286d..bcb0b1a 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,7 @@ config SOC_SIFIVE
 	select CLK_SIFIVE
 	select CLK_SIFIVE_FU540_PRCI
 	select SIFIVE_PLIC
+	imply SPI_SIFIVE if SPI
 	help
 	  This enables support for SiFive SoC platform hardware.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4da4886..8e2d467 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -62,7 +62,6 @@ CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
-CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=y
@@ -80,6 +79,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_RTC_CLASS=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
-- 
2.7.4

