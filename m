Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67EA206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Jw7/raJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgENLve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:51:34 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6114
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgENLvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:51:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juvSvYhSOjQzTDfcHTSYAORi4feVzu7GZ4wWdqjnKYGpxeSZNZCV9DVKFTWjshvo2mb9+kkOzPax1LwSjqG0PAreOC2q6Hm34auyro+gjYfWenHfMdbAAm/+0Oz7Yq21MsOCEA6BoYXjRt5MOV9GcFVc+S4YpCeJlKBcj90i2vM0Lp8V89LS0ngfoRxYMEawa94RqAOQpAGxn0tyXk9Q9uUtvTpnAqdAkZKR2wUoUimz4SFgrcykisdfYwhr65M3ylR4u21t/HSwZ9D0cBsIVHNOdqvT5BLmRZm1+zp31c2g5QrMV79sxaGR9BIgRrcmCt+TjHi9azp6SJRR5y6hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Wn0DVJtsrYagW/LRvYjoTz0Wc573KNruenw/iPvcU=;
 b=dvDh8nQaOK7OxyRR7TY7q0Xm+dS6YNd0zUsYqOXAcgqRc5p0OzfF72kOpFnnTdAduQHjJeG+15eFLiZ/quY/qnsQ3lQTwaX+uj1TPbhTRF951Bq3/EiV/e6mLD/4efBmMjfpmdMvRDqnP/obIuO+z7gqLP6T4+0imSH/rt5wPv0Qygnq4mTJm8WTEJ+0Nav3pu+DIbAy5kI3wU5GR8FBpH067is9r5l5qpdhBl5T+SbErSGBrEpM9p05MLQ0uxHtBloisUgE2hGutxY9nat8A6L5boRyAjblNqouknWqgZ4Hs0F1GpIiXB9SnQVG+35u5RYL/xFRaZX1YrpToSQe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Wn0DVJtsrYagW/LRvYjoTz0Wc573KNruenw/iPvcU=;
 b=Jw7/raJTlp26MWzWvuUzaEMV7EA3BNvN10RbDpOQXrhrWULXRsNADzy81kmCOSnSJ/6stMx2CVsM1y1jxk0/VzUCxD/8lNtKvcY/wgAI85sPtNHY+0bi4AgjEmeCTDCvQOuHPAERlXj5J3OzS3GUfm2dKb9yvTd4iAS68YU29fw=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=sifive.com;
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2469.namprd13.prod.outlook.com (2603:10b6:a02:ca::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Thu, 14 May
 2020 11:51:26 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Thu, 14 May 2020
 11:51:26 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, anup.patel@wdc.com,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed A00 board.
Date:   Thu, 14 May 2020 04:50:50 -0700
Message-Id: <1589457051-5410-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
References: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To BYAPR13MB2614.namprd13.prod.outlook.com
 (2603:10b6:a03:b4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 11:51:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c8bfa4b-5916-4212-5790-08d7f7fd21f1
X-MS-TrafficTypeDiagnostic: BYAPR13MB2469:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB246950975F71AEFD79238F1399BC0@BYAPR13MB2469.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exTx+vJGMyZrR0WnFxGA8B9Am6L0bj8snIvaOGvkrerq975RwXS8Nt16LxQQmKm1Cz4O0TI+Zm+DBcbTnmpXuWVKj+SbCpzN/3/Sass2T2UDycilxM7yFAwbOJIFfIRWoXYr65zacHi9Op/v3C7cqD+yG4+hfsRhi4RgCcnAzhYCW2jQrOTjRTYKPUYEf0CtfG1eehkEZptfkyzwA8WL850VLd0oQJtC4Pt4sxK7iCqMv1Y4ZOKJ2UbHKktcLwyNLS9Lc5IJHGXeJAswqy1GxDT7prR7fr1pV6eYXKxK9KhVWcAiGv2C6eZjZVlIZyCoW3aG/F1pNJjvKxVC+xqCk54EdXeSm0Aro+blYDTpudbszd9QnR1BauQ8fziSSbCMu2bTzeV7TkKy/zu1IqV63V/j6EfKrohQgFlgx0Vcz+7hxRlkf773NNZXlQ/cRQMf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39850400004)(376002)(346002)(136003)(8936002)(186003)(4326008)(16526019)(2906002)(5660300002)(107886003)(26005)(66946007)(8676002)(7416002)(6666004)(478600001)(2616005)(956004)(66476007)(52116002)(7696005)(86362001)(36756003)(66556008)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CymNtYVvmwJOc+LNDCMXt4+r6cGH7beR23bx9oRDHsoJ5EADt1dS/oxqksjHIfCctcpt7MY3xOXD/mswAU4zh6qIohJV1dWnLpezZRZ85fCq4fZ60mSIy5Lj7Nl0LOfdYciZdDkmIHVa+qgiepZ2U2Q3klsDXSrJL+7+6BdTjrWXsBKtKMQFhMKozjpOV+4mcFog/DDCCa+uOE3Z2q9PwXFZ6zmX9ALAbAJmKRENSEddSOJxSHBnf2Rso5pOqBEc7oGr+iPTvT2ABus+zPigg2aTitRzJ8A5UUSXmO5sAVWHM8ZbKEAmmeGIZup0GbO4ZmZadGRov7uf9NGU0wVUDehGKY/vH8btBvjwLDiQQgFYVMv0OcYRokOcL6DqgK8IQbzU7+r0lMxcOIVlyevKJ+t0RGEKqLEJMgDQ1cY85LCwqQvjJzubICMPvGnpuBqLRBDE8bk/heECPEShrOGvpO6/vSlX4WXCle5RrxEsgKI=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8bfa4b-5916-4212-5790-08d7f7fd21f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 11:51:26.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywpLYx+VLUkngQDCCCkngcce1+QJecSmfk31XWKoAtZthRIQKJqtVvT6COGhFMm5Cz35IdwWyAp1mQWmC0F5Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2469
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

