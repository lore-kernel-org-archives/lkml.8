Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B095C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733D24680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iUmc3+8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBZKsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:48:12 -0500
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:6173
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbgBZKsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:48:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlm4NdWdxKoCoLRfR4c50s88mvBEVGMebcU9SkahPTAzHNkHBxQ7DHC+lOeZtkG1kO8iQQOD0ZxecPpdbth+h6DaaaLiN87fi4kS2s1GjGWZ6Yul+7KFFKSiu4Br+0ILqQnpFq6jW5ajM9FWwMBk6gZ5fK31dHhMxq1Su60GsgxzMTJR3GzWF9C6K29CSc70ZGj0iTEedGPTbhKw07FNvZqlLokFScapaGrRu47F4Q8W+J8LDEo5cmbny/BghnvOQ2WIevlLs8VxcBejjNE9Z4myZzSeK7wsYZFe+fErtKeehR9YqbEUD03z8uBj/DFIlHe7Q2vdl2sBPxIme3kfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e05O7S0fVACmLEUf4sQLdymJPZrazZng7CpD9B9TZqc=;
 b=DyEGUlxlSkluRnCTaAJxTaey3Kt5XxSQbRQ5ZMoRA2Yud0BQzgrhIIv6/JXI2x2saP1/meR/GxXIpnTMAK8kSrJSyzchXP4hLyoVbfYsHLqVfyEMfI47EOeZFwNzZutkzDhsp213u6vb2SDALdL1XjqeVBptSZ6/ZQyfD9c04Ymw+G9j2xDRUGHzxXxR7t/qtggzmp91gWYZQLCiqBE1p0KiUupGHP3hqtXDcyCLYARtxoS3MotAf5jHmoochP8fMCV9oJlBoSWOgl60BRH1g3g+NosKG5CAcAL9QtrWlMKCmFNQwCzRhrKho3OLt3W5OrVhzhguwg4/ot7Rdh7vlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e05O7S0fVACmLEUf4sQLdymJPZrazZng7CpD9B9TZqc=;
 b=iUmc3+8lEBxNmrrmvGoiwLhpii89biNTF+/92YInBEoPeJZ9IE8H4p/mxX3h9NGee1CO/NMJTBh21xUTJ4uTLvAIScb10I0MQFp0ngJwKlDqsx0o242kXLzfXrcD1PHb2OoZO0SSrEu+HaSM3WTHrJJBaFwdoiSDU6XtEDbHRVU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 by MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 10:48:09 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c895:8c76:61ae:980f]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c895:8c76:61ae:980f%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 10:48:09 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: Allow I2S wake event after ACP is powerd On
Date:   Wed, 26 Feb 2020 16:17:44 +0530
Message-Id: <20200226104746.208656-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL2.amd.com (165.204.156.251) by MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 10:48:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05ecfdab-50cc-4128-2458-08d7baa95e35
X-MS-TrafficTypeDiagnostic: MN2PR12MB3933:|MN2PR12MB3933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3933B7DE54A25F2EFFE6850CF8EA0@MN2PR12MB3933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(7696005)(52116002)(4326008)(86362001)(109986005)(26005)(186003)(4744005)(6666004)(6486002)(66476007)(66556008)(66946007)(16526019)(478600001)(81166006)(316002)(36756003)(8936002)(1076003)(8676002)(81156014)(44832011)(2906002)(2616005)(956004)(5660300002)(54906003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3933;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5J+773CcQoj6IuBubWZfetl0KizZytqnnJWyVQlHXrGOFdob+VotnsGQlLWKYj8CZ2U2l6A3EjNwr6AhhbO9Rm3Jj2JAORqSANuUhnfGbVpGn+TnJ1NO+SCLdtJBV8BR6yt5LuQ8iNLJlbRyaiqYUfeCR11VDot/jX1B/BFgJLo9u2AFUu3qHAffOLDNhPzN144kTwmEpTYu0DXphol4kGhK8cE33pbnYCIk76ozfv1bupQBWEfISeswbZDWlsyCqeXmSuEWkOy7NDyjD2kp0kCUX7dSQqsUM7LMl4X36kWCB8Hi5oP+R73wX0+NTGJgVKIol+2W6V6RjPwr0tjIB49I9mqVKIcjo37jecH1Daw+AQqapCBrINN32jsSwuqWfojTNkpPgy5sWE9b/qbKk8HyjEJ9WWRH4u7NaCkLfQWkL249j70PpRhT9IzMVSPQ+QG3+5VLmCa6Lg+6e7ilRYkp3vytl8Lgcj83UocewA=
X-MS-Exchange-AntiSpam-MessageData: Z7DxFJib44MiGgv53aQjZjx9fioIo37G2p/9E+33yZfiYAwDbrPSyM7p33XjFd5IcKjyxhZiGMoCsA58geqLIYCD2cB0fmwKC1MEzd3hOgb8YDfCRkhrzNUxFthkSpcfuFAmzbDM01aE3r+g56uoMw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ecfdab-50cc-4128-2458-08d7baa95e35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 10:48:09.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zhSEfmkIPS3deL0oQEhhFZUa6J2sLzH+8wRXS85CogxsJgiRp1TKYQHk3bbtpBaHYTJBwUajiIqsmGgK/PwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3933
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP_PME_EN allows wake interrupt to be generated when I2S wake
feature is enabled. On turning ACP On, ACP_PME_EN gets cleared.
Setting the bit back ensures that wake event can be received
when ACP is On.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index da60e2ec5535..f25ce50f1a90 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -38,8 +38,13 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	timeout = 0;
 	while (++timeout < 500) {
 		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if (!val)
+		if (!val) {
+			/* Set PME_EN as after ACP power On,
+			 * PME_EN gets cleared
+			 */
+			rv_writel(0x1, acp3x_base + mmACP_PME_EN);
 			return 0;
+		}
 		udelay(1);
 	}
 	return -ETIMEDOUT;
-- 
2.17.1

