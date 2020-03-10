Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B296C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B69024680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mCjr+Jhm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fEvJTOuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCJL7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:59:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7105 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJL7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583841609; x=1615377609;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=h6kUGegPdWJFyng435n0ggVbjR+48E3m+hupAEgEt80=;
  b=mCjr+JhmRbukKbNQHGqWcw+50YeA+hlm4XDw5FK0dkb5I5nzQn40iDmg
   l0IsyNCLQV0z1mJbZsxi8dkMgYK1egIfx1h6gJih/3NHKdsk1SW1S9zRX
   czSQpHPTtk7ef9+SQdWZFVrg7/76XvEHx+3+UeFCuxosM3717KERt+/D2
   0koHoN/waIUrHaqMfDCDfDQVlQSvw7g42zkjijWy6T1pcTTZqrsWN50qJ
   vHfG7lCGoSKyowft7LVDKcbTMEsPfdnLhKNafMqvqC8kD9mfHGup2D8GE
   BlOfCHc+m2HvE64TPRJvN4n3HVcan99DuzwRZ79CRTljG0vpav1tOxdkw
   A==;
IronPort-SDR: 8xsQmlp+3NG6y4g4kJ8wZL546XwZLYFAOnnvSNfEZXxNuEEpyjECbwX7W/2iXEtj6IdRpet62E
 wZ+FhWKYJWuXaN6Tsocx7lyBDFwsK7ml85rUqMklRou4xOJcrTBrANajz+BF5EQMXMQxZ8WHNP
 mYq4L171mCEau0ifT5IDwtJsrRJ6+NkqazaDxNqID7CxMV8ZaNAIMdVq6SgVEBgnfBONRo86+P
 k7qlkDIc7hvlycYBJt+mz6OYoKM/pBtNKDBhAjjz7dBby6IwRRO64xVoitOaSwNels55TlRxs0
 rl4=
X-IronPort-AV: E=Sophos;i="5.70,536,1574092800"; 
   d="scan'208";a="234090018"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 20:00:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlu9pVu9Wx4vamyTETVjFLsC3f5m+EpsF6zVsIJMoYsAcjrKRM7QPJyu/6cpKU25+V5VGfYNJzYBP/I4MVZ2KKX3D6iPWVnRkjP6Lyu+DDyic7UzKYAjzxyNQ0RYlVB02V7MSidOhIbUBObfV2b4sF8sfnQ0FquvCsZN6ctziDemf4ll1bmCiwwIejg/eGSHSHBL+kMHQO7Ejp8DLoApuQL8Ad6MzqLCNRbRv3wpgMxtbqbpoXNbby7bzrA4qcqzMwHnXDpff6BPVpnyrJm1q9jEZxOPNDn7DSzYcTvMZlrXeuyESCfECveelsGx5ZxJB0tzNqPE8qZx3iCorVEjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aguvtPYocPTp/rvYjn8F5ylhMzKveRDQk3YDuIfh9Ls=;
 b=URsbs0oZ/ci7qUP8nusLTRnVdb4p664QwzdCv2GOxweAL3gB73XUEdVWjEjqkdzVoHZWag8P73LCTHOHuVb7yc96/V5+rteamvyNDiGV5LdMxrd+vkMyzCMItOaVOGJJkImYqj9Wr/q3dlbb/JOHfH8jPqkL6J6Qfv21UVOyPRxlF0jg9y0KPgZunDUoiXwKU8fPXGft6ISNj+toJXuiQdvD8DRkZXbKUfle+ThE6IgoetE/fXHR20MWPpjg5I/xQsBWbIORxNXYm3WCneMATTdr5H2ny3a73c++M1VX6/KCSObV4yloMbHZAOfoQ0N3Kj9romL/EAogmNnDejo9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aguvtPYocPTp/rvYjn8F5ylhMzKveRDQk3YDuIfh9Ls=;
 b=fEvJTOuANcNVZd+wh9/3Kz4BhyFkPfpxwCnriDzhQXHoO4jqwuFq2d1vKDT+S2RnpSV4PQW3yTmoYFBzmY2i2ZK8rXThOwAVRXTZVXjFSzMOpBII/g0Q4phqh49Z2b7hHbHz0j/Sy4oSOpFmpPtDnfL40IivG6t9G+2xM1rs6aE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB6767.namprd04.prod.outlook.com (2603:10b6:208:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 11:59:50 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 11:59:50 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH] RISC-V: Only select essential drivers for SOC_VIRT config
Date:   Tue, 10 Mar 2020 17:29:25 +0530
Message-Id: <20200310115925.126174-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.22.61) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 11:59:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.22.61]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fbda0f8-e415-4d87-b186-08d7c4ea895c
X-MS-TrafficTypeDiagnostic: MN2PR04MB6767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB67671CA1471B09C7CC82701C8DFF0@MN2PR04MB6767.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(26005)(1076003)(110136005)(186003)(54906003)(16526019)(316002)(2616005)(7696005)(52116002)(956004)(86362001)(81166006)(66946007)(36756003)(8936002)(66476007)(478600001)(8676002)(6666004)(55236004)(66556008)(5660300002)(8886007)(1006002)(4326008)(55016002)(81156014)(44832011)(2906002)(32040200004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6767;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTMDuANTHa2kPkJ/JboI72u9SCQVOMoO6rehQQVWJ1nPLEybHpWofCvC6YHN5TfSVhSsm4hDH/vu/uww3TOFqMYZMI35loi7h4j3gZjcCsYpaGIUUgig9brFz+FiGGcwaFzjh3KI7sgxYIKW3K0Xe/yXa5/VV3N01+bUR8iQ+oXLS/C+ic728biqYRaFn0PDMQdq6B8P4MXF52avIW3uYDZc76wQYEzD8v9A38ZTl+Yv1s+FqBX/sPNfZGfys7FlTd1b6MbNzGL5x+KMzOADgO8lZ26CWI216A2kNkilVQQpvjjEg1wgyaL7gbxHpAsT6MUNH3uv6tHlgl0O7o4do7YLdHxCzUBkjKtGGR+PtbBpNxcdKBWtzyEL0bchAfCQgwc5xpNdr/U458D+ZGiItea31m7KmTbsP2PhbmAojubs0JjT1bQ/U1EiAo3X5EN/Ym/99SI/20Pz8SwNEi8IOFutrvUYb//Pgv9Oc2kwxEE4E2Z7qiqMxvJAPl/7h02Y
X-MS-Exchange-AntiSpam-MessageData: 7uSByQaC1UjxmaqoEJCSibXwz0LDxwoiH/RlehKI1VOunni8uo01cyHYPDUWJVcXau/E139dF77Y7P5XLRAD1B1Ps6WmLIuLNLyy3s/ENAdDWPDnMUWR33LW4vBWEHc0UidWi7WauHkQ8f+gGYK46Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbda0f8-e415-4d87-b186-08d7c4ea895c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 11:59:50.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8iwkZKYPwviQ+77mcgNUx2HVHd9gxQpK9WKMytFEDzvQs6AbgGIvoZkogjUB9Eyd+mfy+auby7rdQPS50ipDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kconfig select causes build failues for SOC_VIRT config becaus
we are selecting lot of VIRTIO drivers without selecting all required
dependencies.

Better approach is to only select essential drivers from SOC_VIRT
config option and enable required VIRTIO drivers using defconfigs.

Fixes: 759bdc168181 ("RISC-V: Add kconfig option for QEMU virt machine")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig.socs           | 14 --------------
 arch/riscv/configs/defconfig      | 16 +++++++++++++++-
 arch/riscv/configs/rv32_defconfig | 16 +++++++++++++++-
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 3078b2de0b2d..a131174a0a77 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -12,20 +12,6 @@ config SOC_SIFIVE
 
 config SOC_VIRT
        bool "QEMU Virt Machine"
-       select VIRTIO_PCI
-       select VIRTIO_BALLOON
-       select VIRTIO_MMIO
-       select VIRTIO_CONSOLE
-       select VIRTIO_NET
-       select NET_9P_VIRTIO
-       select VIRTIO_BLK
-       select SCSI_VIRTIO
-       select DRM_VIRTIO_GPU
-       select HW_RANDOM_VIRTIO
-       select RPMSG_CHAR
-       select RPMSG_VIRTIO
-       select CRYPTO_DEV_VIRTIO
-       select VIRTIO_INPUT
        select POWER_RESET_SYSCON
        select POWER_RESET_SYSCON_POWEROFF
        select GOLDFISH
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index c8f084203067..2557c5372a25 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_NETLINK_DIAG=y
 CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
@@ -38,12 +39,15 @@ CONFIG_PCIE_XILINX=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
+CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
 CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
@@ -54,13 +58,16 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -74,6 +81,12 @@ CONFIG_USB_UAS=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_VIRTIO=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
@@ -88,16 +101,17 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_9P_FS=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_PER_CPU_MAPS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_WQ_WATCHDOG=y
-CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_DEBUG_TIMEKEEPING=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index a844920a261f..0292879a9690 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -31,6 +31,7 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_NETLINK_DIAG=y
 CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
@@ -38,12 +39,15 @@ CONFIG_PCIE_XILINX=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
+CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
 CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
@@ -54,11 +58,14 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_VIRTIO=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -70,6 +77,12 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_RTC_CLASS=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_VIRTIO=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
@@ -84,16 +97,17 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_9P_FS=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_PER_CPU_MAPS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_WQ_WATCHDOG=y
-CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_DEBUG_TIMEKEEPING=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
-- 
2.17.1

