Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A519C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E579206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kfjHsFhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgG0PCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:02:08 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:35489
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbgG0PCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODzNot2By2FWB81EDI0VXvuNtDZTEeMb5s5leyoPiWF4mpSxUVG6z2Ejz6JJlCJ8pR236Qwr/P09PVOywQQA2swwTchohixgt5UmLiCGZoQiA/YJobSCFo7jrYiMtwk1ggBDwTKizUKd/nqvuejm8Ep2tccf1QlEOt5cv8WF+/cif24Amll9MYucsEweQqQsKfSAnTS1bKtiDdszb149f5dgEEpILL0McnfyYOlasx97GGw1Svu/SgiR2/kgQCISgXE0MtmDuq3Q7DlGnZ9BMNQzCoijI/EylAZmFoByycPS3RZkJz9BbY2FMaBqHZkEKqhSaLUa7SWn0AgIVfg3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b837BxrxehIucfYdqYaIUEsqCmkPkJnOzVY5zH8jEj4=;
 b=OiIUyEPcfycF503HOiaFIhzOfDrXPmynZx4Ti/752AuSvo2eZmoZkYPMMo5qgOocs7PfIOEkYo8PGx3gCnCWTou3ACCYIaotUCB3asQP/g0mBSDt9nUflCaadU7cJSyF2L89d3exbX2cKVLMSPtVEyzdLDkNk17THEiJs/s8tRFMGdEFOKc0roGiCKAvsOJcIvufFFYU52xzVmZ84uWXWZpi4CiZZNQO1SmM5cqcDlCQdM00+mvfBtH9zQcrl6CpwYT6Qgp6jy7CbDi+uEtL2LMD4pL4BXcCijyn4rDNEoCimwWyZ5wNpf9pEuUl2XGsbYTEInvwaunjJp/5pFWzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b837BxrxehIucfYdqYaIUEsqCmkPkJnOzVY5zH8jEj4=;
 b=kfjHsFhuhL+dPFnU1qWKdF2FJePegvTT9lk16PcyO15IXdL/NmEpdO7g/xsMFgB5r153EBr1/2RizrLmvZc0VNQh41bAZbPqcYZsOCAlYMn3x5lfBVWCoiKcNizaLPGEPher4qN95mWIaBBtJTBMRwfG5Jt0+9cClgsq9SpUEe0=
Received: from BN6PR13CA0026.namprd13.prod.outlook.com (2603:10b6:404:13e::12)
 by BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Mon, 27 Jul
 2020 15:02:01 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::a9) by BN6PR13CA0026.outlook.office365.com
 (2603:10b6:404:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend
 Transport; Mon, 27 Jul 2020 15:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 15:02:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:02:00 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:02:00 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 10:01:55 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
Date:   Mon, 27 Jul 2020 20:28:28 +0530
Message-ID: <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b7f4a6-2327-426d-dd9e-08d8323e040d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2791:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2791ACE49EE34FF44D8962D9E7720@BYAPR12MB2791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLh+83Qyb+LDXyxIujSu2MLB/4fGHv4EWwKFrFHTi8xjeCzOm4epce3j02AJoxW1Gule+KXevPOLqJI9dbNgASEEUYTF2HtcUlSiFgJwl9e64HV9jql/10rnoBdBz2qpyNOqIQTqOLoRlKHrhKvw44QHw/74RTBaxSjXQUkP6fchmMHVe/KLNqtEajnSNqPaIiWVtvd2hRvi+Gwv0q8YZcVz8rszT4UTM0vAd8Yb1iwyiUeYcbYOBaD8XgXAhRqSYZamPF6Pv4qrJHz1EUq7qJpV8nvQpP3S2ppyXGJoLIYFu1or45RZSsqxmioIv4BzUu/JYQEgg8sP3MjbGeOZumn0BxB9RWqDqVS5ae5g5OZRv4h9+jnWnaRklPVMElLTbIV/z2tOQZoRiIQuqRnJ9KJwVce63C09IbsmGxiYqT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(2616005)(47076004)(109986005)(7416002)(8936002)(81166007)(5660300002)(4744005)(36756003)(82740400003)(316002)(336012)(426003)(54906003)(6666004)(70206006)(478600001)(70586007)(26005)(86362001)(8676002)(186003)(82310400002)(2906002)(356005)(7696005)(4326008)(83380400001)(1076003)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:02:00.9854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b7f4a6-2327-426d-dd9e-08d8323e040d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changing SND_SOC_RT5682_I2C to SND_SOC_RT5682 because,
This flag which was previously set as SND_SOC_RT5682
used to build rt5682 codec driver but by changing into
SND_SOC_RT5682_I2C is preventing to build rt5682 codec
driver and machine driver fails to probe.So Reverting the changes.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index e37cf72f2bab..77ffdb41bee5 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -29,7 +29,7 @@ config SND_SOC_AMD_ACP3x
 
 config SND_SOC_AMD_RV_RT5682_MACH
 	tristate "AMD RV support for RT5682"
-	select SND_SOC_RT5682_I2C
+	select SND_SOC_RT5682
 	select SND_SOC_MAX98357A
 	select SND_SOC_CROS_EC_CODEC
 	select I2C_CROS_EC_TUNNEL
-- 
2.17.1

