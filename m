Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C58C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A7220842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0JnVuTzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCCJFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:05:14 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:13024
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgCCJFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:05:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9W0BFhgzluaphVxxqUsdty2vejRuVs68HHWB/8LHmIrs+H44xKQlArXqYi0GKZumG7K2l+yM8ff2rjhgR0ORfIfXqgbsn5j3ndrC1ysM87dpRLKsTZGwOtIHEYPpUK17u34KMqK4OULeeIWTp209EOp7YhwfuKjgUHVplp5ZWCAIkvXb2tnoAXu0iGJ+EPzOXMokSb91PvDVhNw1P64CIkD+W11gdB6wMJqEKqKN4Q9NbS3AU11GG3kEKtjEZkobXxOZsdVYNqLB0OVOixK/Wz7R5jFiKSphbknR09DCQPlEqhW2X5GK8iM5FBxJemKUO9Ay9NgCx86+Y5wXrYpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ozdbwqOLKHlyU+aN487uFVAEOmYIZvEMgqOjQWE6IU=;
 b=h5BOXpHk3i2efQHVmo6JY/2lDRljodVz9q62nxJFbkOPkGVMRz/uu1VLWPpbzpt2s0eGfNZ/YeHz1oYbIeDT4NXQOGhcnz0hZVlsbCbLygz2u/r+M2Wt3iHbtiowHZVVhgWec4pua57UHX/Vg7UeWxVE3/i/xVCLpPej9O6f5Av5ho1yJznH1JQKAaeTMvIViHZs/YEtdda/Z78U9pqkNgfrXesXM0INa0cyUBHRZFhO74mjwwYGezho02p6iuztA2B+x8UV9R3lb2A6IAlNErO0AoHvoXMe1WPGaZJSc+e+EYiYi+mr6eRitHzwSORFyiFSml7OP5XZRdoVboBzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ozdbwqOLKHlyU+aN487uFVAEOmYIZvEMgqOjQWE6IU=;
 b=0JnVuTzZb96QxomygX7rK0rdgNfKCnKPfScnXoeflqy7hmAAvc0JGEupuGJ6/LFvEe9pNpeMG/tL0Lf0V4/HdwOl2Di7Qg/065nIMA0ShzDB997NIsr2CRBNk/gSizcS1GfK7NgPm90rljJcieIZLvENGcXN3hW5J3kl7H8AH8o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 09:05:11 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c3:c235:f1b0:50cc]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c3:c235:f1b0:50cc%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 09:05:11 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: Fix compile warning of argument type
Date:   Tue,  3 Mar 2020 14:34:37 +0530
Message-Id: <20200303090444.95805-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL2.amd.com (165.204.156.251) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend Transport; Tue, 3 Mar 2020 09:05:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be809644-69d4-42a5-6c18-08d7bf51fa59
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:|MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408CF3791805E0FEB8223E0F8E40@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(66946007)(66476007)(6666004)(4326008)(66556008)(36756003)(86362001)(2906002)(478600001)(5660300002)(54906003)(44832011)(7696005)(81166006)(81156014)(52116002)(6486002)(8936002)(316002)(4744005)(16526019)(2616005)(956004)(109986005)(26005)(8676002)(1076003)(186003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4408;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4emphRYB1OEjXQfgHeASJZtaX/pPxfCXznfTG1rhavbHp/AWslepDxHNke8s2fZ9SXBH3q4iFvfy8e+L5c2aTOkrl6zKDag7XN9Ac7oJyO5S0qkflzQYIOSPIWmhZIN+BCrctTTV36cz//YFTk2avtYtJkHh8hbS5LtPPGpW5xbccHb79vDixu/v3fQiHYk2lJgRiPA96qhEeJvHT9QLVSiaRF+e3UAFSS3lumZxA5kfMfox4jKXHxzximCjl06Frncsd8X8Yxx+2akPWdiZTNWKuCeDlIeiVHri/SuJPJnXsG8ggsf/VPUSORUVH1vict3DTkaFEDwEj4NAFR6dD+wAuYDFcCcBhSSO3Goc2KKZBsH5S9OZwf7Vkm9/ziFTJ7okuRbmhF6xOM75eItDRmGNHgc7hZy0Vbpz9S+esln4Yk3uR7zlmdHKMAjbNlOLQDF7NYi6dqJFIqQAvNtopdg3mmnagUn196NnX61z1p0=
X-MS-Exchange-AntiSpam-MessageData: KpDaZY6elSl/ivCGVimhQ6plpEW3Y2Uj7YKsuA6nT2uQ5laPMmkggctRZzap3arJaNz5NF4wWCMrx7IylQtpQ0rhSAHh3vP5NGmr7tnhpxtEpPsZCBZ3DOMqVvFiHV3XnjFtAdf8AkCVxXD46mscTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be809644-69d4-42a5-6c18-08d7bf51fa59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 09:05:11.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFnk+Yz9H572k2gsxIpKpeNl1X1M7upQ18nzs//3SVDFwd7ccTrRcuO7XPmGka5Kr/r8tVHnpI/O2pbJQ1ZUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
>> sound/soc//amd/acp3x-rt5682-max9836.c:341:23: warning: format '%d'
>> expects argument of type 'int', but argument 3 has type 'long int'
>> [-Wformat=]
      dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 511b8b1722aa..521c9ab4c29c 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -338,7 +338,7 @@ static int acp3x_probe(struct platform_device *pdev)
 
 	dmic_sel = devm_gpiod_get(&pdev->dev, "dmic", GPIOD_OUT_LOW);
 	if (IS_ERR(dmic_sel)) {
-		dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",
+		dev_err(&pdev->dev, "DMIC gpio failed err=%ld\n",
 			PTR_ERR(dmic_sel));
 		return PTR_ERR(dmic_sel);
 	}
-- 
2.17.1

