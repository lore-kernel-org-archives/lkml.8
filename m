Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17117C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2F320708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1fG0G8ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgGGKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:32:54 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:11264
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726745AbgGGKcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l54omh208ayP/id6Q0YVvq8fsQcCQ1c94XaGxm+v4n+mhOSzV6W209bL+dpw6CUVzUJpYKc7HsAGpqoUjV6S4G5co50/dOfYFG9N76Z0yz5u9cTlo6THn1mfHxvTSLFuLbjaBNFTzT3Kua+k+0bJmfdMrpcRxzQR/0X8W0pONBgHmih5fhgnNMbY3ot1duKOZ29/pwSwLUG6ZatPJZ645QDMFdYUE76FkOVY6u+r0lOQmiWtCEGEIxc0OZQyaJM6Zwsvji0mnbGE/oMvJLIRIvhvgGCuJ/fAJ0gB/I1ZBPhvaHdio3s443WZYDyCXjBwqwTWYilU8pxrx8a6TU7qKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo0jBFwdYzI2HgdAr+Ljv02NvSGjdaRxTWqn/fpRYLc=;
 b=e8RgiFfYP2CRC7N0knr1TkeDL3AycGSIW0991HV5sAUJ6FMVk6u6DLhka04+2yFMZqbs5wd1pLblshPHsNGCOaQICdtST+Pzj5gzbBODbClie20o2XqygyV5YYxrpb24rA+vaM9kyCFbvunjjjhcHjy/AUBarfzVIknss032H6JhgGlqPK6S++gULfL9cCchGibx4B3tpYSF81qG1zzYc9dhBWxif6wfUptC1odNqtfykQoCvFyyWGsoun2BleUxo3wYFsWrw6ufsgW+tmJ/d7qqT7QmLGn6pAb2eRPXaBPpFQ0haZPocGaOw6w6s73sxVWe/kNQCJ2glB4RWGd/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo0jBFwdYzI2HgdAr+Ljv02NvSGjdaRxTWqn/fpRYLc=;
 b=1fG0G8sskQ6PoNyV8Ee1lFIoJ4ouXliu9b/+emAwgLTjjfDhjy1IS3Dsa0dHRBUk+VXqwlGcWtSFnUssMhrIRUXkJMvIBOcireEXxmdrpqGfoq6WHDcV8C/wVBfdzzBoaRdp8NNWns3U19oO54Kxo7q4M1ob/3L6HsRMC3RZLik=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by BN6PR12MB1297.namprd12.prod.outlook.com (2603:10b6:404:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 7 Jul
 2020 10:32:49 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a8) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Tue, 7 Jul 2020 10:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 10:32:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Jul 2020
 05:32:47 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Jul 2020
 05:32:47 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Jul 2020 05:32:44 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <hui.wang@canonical.com>,
        <Alexander.Deucher@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: add ACPI dependency check
Date:   Tue, 7 Jul 2020 16:16:41 +0530
Message-ID: <1594118813-18689-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(478600001)(26005)(70586007)(82310400002)(6666004)(70206006)(4326008)(186003)(47076004)(83380400001)(336012)(2906002)(54906003)(316002)(36756003)(2616005)(4744005)(356005)(86362001)(426003)(5660300002)(8936002)(81166007)(8676002)(82740400003)(6916009)(7696005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d3ebdd-6a28-4b20-129b-08d82261189f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1297:
X-Microsoft-Antispam-PRVS: <BN6PR12MB129793D50BB5D4A6F6260B6697660@BN6PR12MB1297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlR5EPCd6bFcOWMQCeve1pztoeCubiE/8MDO2yd+IbIbImslI5EhYJqBAOzYDjgdHq7oBfrgbggBtlVOOaeG/2aCBg6f1I5xyqyuY3YijSXjRG2u2O+Pv+SSp/S5arKZfH+AqJ+PimCfPRb2q5NoGzRp9mISFtYvG4MfElw+Vv6EhqoVqbIOAYf9yn7M5w+8H3/GKJ9w57jW8NKmj2O5VoapcZcW2F0LUcvjkEIddwzCDloHphHHxHH5g5sSSfnH/NlsCoBVIBlJ8m+yTulFxcvOY1d+00TgVsEGl0zoJIB13ax9ZxbktlcPXgRRzl7PmLo2UXAM1FW594q40MZSOTFadtrg4UiQtHjUsqKxDvA+fY6vGxrPZqrodF2T+IUQCYzWw4hJrFG1pIVnY7z4mw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:32:49.1556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d3ebdd-6a28-4b20-129b-08d82261189f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI dependency for evaluating DMIC hardware
runtime.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index d1faea5..165c93f 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -218,6 +218,7 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 		ret = -ENODEV;
 		goto de_init;
 	} else if (dmic_acpi_check == ACP_DMIC_AUTO) {
+#if defined(CONFIG_ACPI)
 		handle = ACPI_HANDLE(&pci->dev);
 		ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
 		if (ACPI_FAILURE(ret)) {
@@ -228,6 +229,7 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 			ret = -ENODEV;
 			goto de_init;
 		}
+#endif
 	}
 
 	adata->res = devm_kzalloc(&pci->dev,
-- 
2.7.4

