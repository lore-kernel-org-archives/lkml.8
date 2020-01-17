Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D89C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E19F2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HNwHeQb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgAQLq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:46:59 -0500
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:41094
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgAQLq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:46:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/Ch4hyEb1sBNtPYJmLbMWo8yjay+SjvLFV9lg1AL9DK5bceAlMjWQ3SweWJ1XnbfzfkGx5tv0eWGxCnMSBJk/DzI8t3ZBTn8AOlypF7XNkKQ5d4nLuZqR+zSql9cno9tBUGsCgiuSTiOKg4aIHqVoW8MpvivW0DIq1+jlMrsnSn7JwYTkY4cpOKLqbcjORNzUlTzt8wjV4y5xLxodTDdwEpu/2Q89NpybkVI0uJPXA3dolx+BXR/uQcLU5Bf2xA3rAC0P3wkXT6UcvR2nxRK6+I5NYtrdB6Xbwoz+6bBvGGylkRTYUHxJ5VUniDDUR6ZiqRMrohnXv5sHrxhuyKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iqQ/4Q6bwrhoWYt/b5Ze+Roqw0ehTq7QeeoYd+GnyA=;
 b=CPbc42z0+R3ih8wL5JkWu3FMVSCDU5ZyVpClfTVcU9kJ43ZBqXL8cjqRTPH5Jq83lt6y9vD3J11Hq/MHUcKC6M/jFa0uHQzGYMPwNXh2c6SKKFHUhcgSKNGxUoKWDQ2brdk7Rd7kjcibgTqJSi/ieYERndvRMaomyVyGEAhYNaRcAmMPF8nmYpJM5O/AnBJXa1M96fnYahdcSO+hnuxGpJvag4HJb944+X20e82aEVeDnhEY4Axgo1ieUAr7gGPta21SftIHsAPdLJCYO4kWYDUS2ECZKLXLkWByfgomDX8rT0y6Fs2JIPFt+/5SVGaOMCmXiBGwQchab5tAcqOZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iqQ/4Q6bwrhoWYt/b5Ze+Roqw0ehTq7QeeoYd+GnyA=;
 b=HNwHeQb0czp16R6cyZfrCi/Jt2mxPL7LnOMKkB+RKuLdboPdtBEQQZRIYJ7JRsEycBQ+gltgkeZhQ84HSjOFLZ9AKTsFVeioK8BBiUCza9rFnFQQQ7u/eQ8r8HcV6TH8nn+klOIdnQTXlQvUja3QzVifAkpVyDMz2HOGUfmUNwM=
Received: from MN2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:208:a8::41)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Fri, 17 Jan
 2020 11:46:56 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::202) by MN2PR12CA0028.outlook.office365.com
 (2603:10b6:208:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Fri, 17 Jan 2020 11:46:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 11:46:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jan
 2020 05:46:54 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 17 Jan 2020 05:46:51 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Additional DAI for I2S SP instance.
Date:   Fri, 17 Jan 2020 17:15:09 +0530
Message-ID: <1579261510-12580-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(428003)(199004)(189003)(5660300002)(36756003)(4326008)(186003)(86362001)(8936002)(8676002)(336012)(81156014)(316002)(478600001)(81166006)(2616005)(109986005)(426003)(70586007)(7696005)(54906003)(356004)(70206006)(6666004)(2906002)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3294;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45466748-0537-46e9-ea21-08d79b42f3c7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32948A0C64549136C66454D7E7310@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0285201563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRMwaUqs1Vx0KQ7v77RMEeiMy3OAZv/RBZv2vjFdIx3zMjjrFtmviywMkpaV4ehdVjfiUDl6BEYHFTcehKaVrgbGXK7PzUhsoSDPGRXIr+JF5ZsIca+/d5mDr6mwMc+w3xK9HX7GtlVwbee8FR+4XHLtfYP39haHkTGQErylYMnTMIOqbEuJ2kklH0k79KJ2NxCfMI1vIYUDT6Bstsp8hsLavrSJf4nUBzU0Q7nQIeiFUCYquBRhnq8gpsfQucOLwUtyV7zno8ynTuAqkGKM4IbAKNLPGJIB5JF3M7tqIJQRs0Np8HYNN6meqMK7dz0GNoMfNb/wtsQ3w7Iy+CaRTZiLjHZ/RxjCiZwINXUjB1de/cCGPl44SVaaubQBSY/HlfPwznDTgtN3YdsuHowuTuZgk33a3aW9bWkLaawU9dXzDzoz0Iqknw05nLlel10kiwct+nn7S6kS3Ncj0iNnAhacEjsifqjwhL6Sq297HWQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 11:46:55.5896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45466748-0537-46e9-ea21-08d79b42f3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S SP instance has separate BCLK and LRCLK for Tx and Rx.
Creating additional DAI for Rx.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x.h     | 2 +-
 sound/soc/amd/raven/pci-acp3x.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index b6a80dc..21e7ac0 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -13,7 +13,7 @@
 #define TDM_ENABLE 1
 #define TDM_DISABLE 0
 
-#define ACP3x_DEVS		3
+#define ACP3x_DEVS		4
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
 #define	ACP3x_I2S_MODE	0
 #define	ACP3x_REG_START	0x1240000
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 2f9f5290..65330bb 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -225,7 +225,13 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		pdevinfo[2].id = 1;
 		pdevinfo[2].parent = &pci->dev;
 		pdevinfo[2].num_res = 1;
-		pdevinfo[2].res = &adata->res[2];
+		pdevinfo[2].res = &adata->res[1];
+
+		pdevinfo[3].name = "acp3x_i2s_playcap";
+		pdevinfo[3].id = 2;
+		pdevinfo[3].parent = &pci->dev;
+		pdevinfo[3].num_res = 1;
+		pdevinfo[3].res = &adata->res[2];
 		for (i = 0; i < ACP3x_DEVS; i++) {
 			adata->pdev[i] =
 				platform_device_register_full(&pdevinfo[i]);
-- 
2.7.4

