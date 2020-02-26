Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D075C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C68A21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P0gmdkmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgBZAEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:04:48 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:6243
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbgBZAEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:04:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCg9sipByLtvSLlseke4mFy/fQOxwwjuzR73elGoxuXnstC3sg2S1i4qO6FZNfIuVI5jbqUYMfBYsG6zAZkv+wbslFN57PbChCBE/dA5Qv8eJkJQdcmKlDZ+a746oN2k2ywDqKT0d7rvuTG8FqfJI6TdGSIxPobNleXExT9Z6xXQDOKUbQWmoJPL+GX2CK1oUv8n9OX2p9BNqG3hUXjzvspAae9VMqHEVsod/Re5zrkU/VEFhjsMZBekiCZ8SOYhqz8EijO/TQYQDBB9tT9IDShFzwjGyVkAcx11F6frxZ4qS1iIjm/sduSnnqA9F1iSgK82nBlJIXplFqKVa7cVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/LLQdr1poyhFFLAgKasMXpIUyfTn496MmtbVJsq1Hk=;
 b=DVQsyzFaJiwy10iPy46Sa+P8Hgs5Dmuq+UxGOTUeqK4KemEfLK/tAU8hnXQZQ5EgeQW9uoK/pbI8Pziww80jfoS4Qu029urDGXs3kCp7+K6NY277baB/hLs63uxYGwTa4hGYK4msFWXWppzZTWalcFz4LOkO6KgJJtstrgXl9UyuWBMDKQZKVkbPgN1x+523VZeNSbfgRAoF+mcCe+/1vLKPWiCqxsu9J0H0EVhGgA1iKLlO1YEDNwqSIR/OeKe+anDjT8GqHpfCBzHfSgDbU3FXxALr0F5Q8JxjSwydcmn4AoZC0NFH7NdPkL95vhgCw9fmXdkJLMuK3NFUZJBwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/LLQdr1poyhFFLAgKasMXpIUyfTn496MmtbVJsq1Hk=;
 b=P0gmdkmA6ZViBbm2kUDpsz/J2zOGRCZ6fbZi1I8m1+802a1qHjHE4gy2ukOltRMVd/xUO2vIIGbBGgniZ10ujrkrlyzuWiuaFaDRh9zsoKW2tBon9uxPw1jopQnvaOIlLFSR1vDuiNaCUMCtaZdFjoomXFgOqdrE5vLChSHtOlQ=
Received: from CY4PR22CA0026.namprd22.prod.outlook.com (2603:10b6:903:ed::12)
 by SN6PR02MB4415.namprd02.prod.outlook.com (2603:10b6:805:a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 00:04:43 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ed:cafe::9e) by CY4PR22CA0026.outlook.office365.com
 (2603:10b6:903:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 26 Feb 2020 00:04:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Wed, 26 Feb 2020 00:04:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j6kBu-0006Ht-GR; Tue, 25 Feb 2020 16:04:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j6kBp-00049U-DR; Tue, 25 Feb 2020 16:04:37 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j6kBg-00048g-Dn; Tue, 25 Feb 2020 16:04:28 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH] arch: arm64: xilinx: Make zynqmp_firmware driver optional
Date:   Tue, 25 Feb 2020 16:04:20 -0800
Message-Id: <1582675460-26914-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(7696005)(186003)(478600001)(36756003)(5660300002)(7416002)(6666004)(70206006)(356004)(2906002)(70586007)(2616005)(26005)(4326008)(336012)(316002)(6636002)(81156014)(54906003)(107886003)(9786002)(81166006)(426003)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4415;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c85e4bd-4b17-4c8b-b4df-08d7ba4f7b5e
X-MS-TrafficTypeDiagnostic: SN6PR02MB4415:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4415582C933A2747359CDF8CB8EA0@SN6PR02MB4415.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0325F6C77B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OMs0QFQsLLU3Afn2CKGB0P0PrrxTWolQEKu773Z1RLgcmBU22wrSRKWY4oDXKueSThd52BOlnVgYqmipskcHQsehifFvmFPjZMR7mehHYXYbvWPSmtTqbGI9rV8kY2Nc4oknK6k81R3fh0/1wfMkVec5ogawNIfZu6gRiWlgEe0fGOuTjpGQGnpPDru1bH+LKN885xNVY1tmVWyXIFLCes0KQOjGwDRvw4V0QEzFze2AgtR9U55MKlnf+37pYaVJsDIRlcNP80JBdNrWHJWshL3eQEJ4l6/mLQWeDWnibCpi6xzYb4BLS9cdDw80cLGkSyvIpO3jaypKk+AB34HjXStKFTOCVW745MHTE3+wvJ2w5J7E2nffMyn+hQmeBq86gKIjwgecuNCQoNDeX8McCPAjA+b3KydP59i9TB1Lbny6oOgGNCtSDfU0KEV5p6j
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 00:04:42.9910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c85e4bd-4b17-4c8b-b4df-08d7ba4f7b5e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Make zynqmp_firmware driver as optional to disable it, if user don't
want to use default zynqmp firmware interface.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 arch/arm64/Kconfig.platforms    | 1 -
 drivers/firmware/xilinx/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b2b504e..563c93d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -301,7 +301,6 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
-	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index bd33bbf..9a9bd19 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -6,6 +6,8 @@ menu "Zynq MPSoC Firmware Drivers"
 
 config ZYNQMP_FIRMWARE
 	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	depends on ARCH_ZYNQMP
+	default y if ARCH_ZYNQMP
 	select MFD_CORE
 	help
 	  Firmware interface driver is used by different
-- 
2.7.4

