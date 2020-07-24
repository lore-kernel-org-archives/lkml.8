Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67836C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBB3206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXljTslu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXT4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:56:30 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:33826
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgGXT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5uJU6KqO/dzqE+Mn7riBxERhWMQOjK3xyi+JkOYIfTNV1TnYd7xdOkfAws6c8GAvraLRnfJuC7qQ2zF0a3RbnxnVkudBGuhr4ACgsNA5X5pM8qmqK8YUvSqz7ORpeqs3IEQDsA4tD4W7jGs3YNwCDcHomJKSAzTAiRoSqftNxJDFaskAcxGguk7cjoft5p5MC6PrnR8+aUt2gFMrecQG4Lz2p7P2wn5F+Cetnv4W0VAxlqNL+gisa/obhNiAHxzcIfyVEfx1k9sYs31xPtrvLATi75meb3RdVBWEv4i9fpUTxAxpSsc4DyzCArUv30d8u4i1UfjTBDsd+O3rQhL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU/ius8UgfVJqWHtc7jqG+RWPsgHOQPKR/nQgqb0bM0=;
 b=Zl/ZctQst10Kd5H24AjxXLZI+7XkS8/3uYUFGK1nKuyHpayflPuP88iUIjkJCq7Fu1dDkvNEKCChqEo9a/NwM2Sldo8CUdseO/SyOKll4iHmUtW+1cthU+sPjmF4e1z1DFlx/ltk/sW8tOeyWg/CnETGUoNVwVmqKay6DQTEKq9q0CDWqUbkPVBkNFEu5FYRdSzwoK88Au3awt+38fLGzeySdCvWXp8vy5zaPcYpnN8Bdhqd/10EUGAGGAcTvw1FrsN48kw4o+KLwQoaTw8/iiI3mTty5wZELuTuTTj4f7bjGdMNoOcezTY+UE/wsTeqY/YUPJqwyHsKQKCe7/QfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU/ius8UgfVJqWHtc7jqG+RWPsgHOQPKR/nQgqb0bM0=;
 b=KXljTsluJScIBMxc/V+rEx9xG4Iyltndup8XJSNIhIN0gHVKEHSOEY46wWmhCy5Yz09YZp04t/IwhyItXh1zXzPrAMybEWrc+Nml78n0WiSIAERzdgVK/zefYdxLJFUW+D/bsCwcWfgHXZkfZL/5M+0qQ2CojD2YzuAOqhRrmok=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 19:56:26 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::bd05:e7bf:ce39:6f32]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::bd05:e7bf:ce39:6f32%3]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 19:56:26 +0000
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
Subject: [PATCH] ASoC: AMD: Restore PME_EN state at Power On
Date:   Sat, 25 Jul 2020 01:25:52 +0530
Message-Id: <20200724195600.11798-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::29) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MA1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Fri, 24 Jul 2020 19:56:23 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e40922fd-46a6-4972-ef6a-08d8300ba5b4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1599781B3DD109ADD56A25AFF8770@MWHPR12MB1599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GO1Wxa7H2pS2rztiNr5JiAIlgnYE6s9LqGrRwXrPm13UUisPA0n+jIeNH7fXjJmkAni45TvNkljqTS57uGQ/F2+zZ6Xwn/Tzo0IHBHfzXvMoPAzuqJtlKJX+a4nUV4IgcHyIGnOZUWUYwydaOypqrThnaV7uFzgIZcdPtqHzgyJvpJDmxr0dtRQ3uqAAzzww/01m9v9qFAT6MtaakW/nF+9KxAvGK3VnoG7kb9sRq3SkmAAeYiem4afY8B1fUwQqkk30YrC4R17okrsdEu5G1aqeium2m751Wel7fBnGF5MpGAcmrpEeY0TxyVNtyaWFmCmBWElQ1aIb8ywgHyS/eO77JEDIzcTH+TXZSf5qEkBNJljj1z1LJRKNFx1Y2Bo4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(5660300002)(44832011)(2616005)(956004)(6512007)(86362001)(2906002)(66476007)(66946007)(66556008)(316002)(6506007)(4326008)(16526019)(186003)(26005)(8676002)(54906003)(478600001)(8936002)(6666004)(52116002)(6486002)(83380400001)(109986005)(1076003)(36756003)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CFkGkaVVpcRIOMTrUDkTWvuvCNpGsqi6uvVFkDMDkhLigULTXvKGyq+hccm4PvLXH8ncsGZHqa8EVQhCeKz29mIL3vrOk4y8r0VSRbzhXnkpqEXTW6KnTEMSkxQu4N46JPpzC3s0a7a1d/Aww71CHx2D+jkysb1FxvWZ+J9+QpFtU0MtcUbb6o59jUk1CkWIUk6rVKn0Nu11NpkgpH5xMcaDl1uSjQtnFQBDcwSb8nBzTj/8mJgz9pY/4/mFYwWOSmMYmSq4LIqT9jmL/yU0jCBeUdwW1P5CvH5PuGu6l1q9df9Sy7Dcur/P5/OIkg2zF1M7qEfl1yzFhsdLA60ph8Bh2NFjiplZ/gmMRas1CXOzMEQKJGpKPV4+BgMb9s0vhVnvfdPwdPHZLheJ1nFXmtBWFbM4xEs8ycTVnczBnzeQLVdZDxYbrRkLxvVEdgvL4bdbsgQhqm9JFkkCasTShcDDPUvn58opl/OpdwJXTls=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40922fd-46a6-4972-ef6a-08d8300ba5b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 19:56:25.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cnF7Ww4bx/U8CDsYA3tcJl7as4VJKK1+QbCN7Nt1Zq/XdjwFOGQ1NV7lYkWv2JzfLPw58v2lfpZuvlvu5jA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1599
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PME_EN state needs to restored to the value set by fmw.
For the devices which are not using I2S wake event which gets
enabled by PME_EN bit, keeping PME_EN enabled burns considerable amount
of power as it blocks low power state.
For the devices using I2S wake event, PME_EN gets enabled in fmw and the
state should be maintained after ACP Power On.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index ebf4388b6262..31b797c8bfe6 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -19,10 +19,12 @@ struct acp3x_dev_data {
 	bool acp3x_audio_mode;
 	struct resource *res;
 	struct platform_device *pdev[ACP3x_DEVS];
+	u32 pme_en;
 };
 
-static int acp3x_power_on(void __iomem *acp3x_base)
+static int acp3x_power_on(struct acp3x_dev_data *adata)
 {
+	void __iomem *acp3x_base = adata->acp3x_base;
 	u32 val;
 	int timeout;
 
@@ -39,10 +41,10 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	while (++timeout < 500) {
 		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
 		if (!val) {
-			/* Set PME_EN as after ACP power On,
-			 * PME_EN gets cleared
+			/* ACP power On clears PME_EN.
+			 * Restore the value to its prior state
 			 */
-			rv_writel(0x1, acp3x_base + mmACP_PME_EN);
+			rv_writel(adata->pme_en, acp3x_base + mmACP_PME_EN);
 			return 0;
 		}
 		udelay(1);
@@ -74,12 +76,13 @@ static int acp3x_reset(void __iomem *acp3x_base)
 	return -ETIMEDOUT;
 }
 
-static int acp3x_init(void __iomem *acp3x_base)
+static int acp3x_init(struct acp3x_dev_data *adata)
 {
+	void __iomem *acp3x_base = adata->acp3x_base;
 	int ret;
 
 	/* power on */
-	ret = acp3x_power_on(acp3x_base);
+	ret = acp3x_power_on(adata);
 	if (ret) {
 		pr_err("ACP3x power on failed\n");
 		return ret;
@@ -151,7 +154,9 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
-	ret = acp3x_init(adata->acp3x_base);
+	/* Save ACP_PME_EN state */
+	adata->pme_en = rv_readl(adata->acp3x_base + mmACP_PME_EN);
+	ret = acp3x_init(adata);
 	if (ret)
 		goto disable_msi;
 
@@ -274,7 +279,7 @@ static int snd_acp3x_resume(struct device *dev)
 	struct acp3x_dev_data *adata;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp3x_init(adata->acp3x_base);
+	ret = acp3x_init(adata);
 	if (ret) {
 		dev_err(dev, "ACP init failed\n");
 		return ret;
-- 
2.20.1

