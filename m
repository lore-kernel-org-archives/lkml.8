Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F318C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276EB20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ipi1GCli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDIHSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:18:54 -0400
Received: from mail-vi1eur05on2082.outbound.protection.outlook.com ([40.107.21.82]:13633
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgDIHSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIHkcFcCp1J71dB91MoZI8ykg5tZ+5waIVjBCJGB+nymOO/vr7t3bKlB4LFTwH5dozZlwWD97euEhp7jVFw9qjUx5+dL9FbyIHXdVh+JM9V1hyiiImSS5RlPKembqFY75md/YrVpjqVGW13vLngIMjeTrKmV7C3VMvImB7dyI7SsOTT282l0KM4iix6IhdM3ZLJsDDgwC0Q086WsilGUvfLED5uhHRp4PU4GQzouUq/otQFqusl7QROcFZngX8ZIT85lSvqaDESoZ+ZSepAb0EnABQvkeS/O6rzjJLXpAe6hXdsCn1kzMq5HF52a3vfVD9IswMLJyAjKM2ZPmikK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n50d34UAFoD31TdOb/UenHzu6OWlJmOwhnhtBlo5j5c=;
 b=mO/T9WNMhXDoZsAtDMmHnhUiDp7vFJhi8xO4MXAzRSmNqZlSLozz9hDv3Nauy35t9yaL05amtJQlLQrWztks9vTi3DdLDk/zlxL2Mk4ddN3l7luiakKtmmUAFGW0qlAB7owGpQvmzHB1+kvS9j8HMPSxUlsOvmgN7Zb/8UDQtdLCjigqiETDC6J2z1qKZ7APVZWmC9d8LpGbsOzeJqxMnttt6j4Na3ezwcfd2wHII2elU11fJu2JBSzbk2/A5cKQ2/XUdLMGLSq8t79959vC53+G7TdQvlp8C70YvhmMkYcgQl4SinCvKpbYwpwSxLkf7KhVbrxLaCR1ooTbgbl8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n50d34UAFoD31TdOb/UenHzu6OWlJmOwhnhtBlo5j5c=;
 b=ipi1GCliSh4eZjRcjZURyy7U57j7cBO3Ungx6KL6VuHNTbCVJk2SHHMZBhwR7pU17rJmfCZbZy4GTohEvMHT/JD66rFIbWoaQ+YlYeCVFzSs4lVrGOVGWDQoEXN/GJaxInwTyqmSDM2tax/G2DeIBG6jVYNirP9zD2WbUncIUtY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30)
 by DB3PR0402MB3756.eurprd04.prod.outlook.com (2603:10a6:8:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 9 Apr
 2020 07:18:50 +0000
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c]) by DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c%7]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 07:18:50 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/5] ASoC: SOF: imx8: Fix randbuild error
Date:   Thu,  9 Apr 2020 10:18:28 +0300
Message-Id: <20200409071832.2039-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
References: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::12) To DB3PR0402MB3835.eurprd04.prod.outlook.com
 (2603:10a6:8:3::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 07:18:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee9c015c-7667-4dae-3435-08d7dc563f9e
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3756:|DB3PR0402MB3756:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3756CA5F03DCA1ED0AC3D884B8C10@DB3PR0402MB3756.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3835.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(4326008)(5660300002)(478600001)(316002)(26005)(1076003)(66476007)(7416002)(6512007)(81156014)(81166007)(66556008)(54906003)(6506007)(2906002)(66946007)(52116002)(956004)(2616005)(8936002)(6916009)(6486002)(8676002)(86362001)(6666004)(186003)(16526019)(44832011);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPE+gwww9T4kW1i/4v2B5mGElFOZ+aPOxTquTyszQQmcbNWBQefFy5VfFD8nKESlGtONUYpW6H2DI5CobeqvVB9hGDcShxOXEwv+XdMJyoC0oJA8UmGtCVIsODmQxl94XSm9hXn4Fu5BZr4A6bbye1VBPoIHVc30uZ0L8pifB+aV/J6fnJ3Gyn9VaV9FIVxj/dglATxeczwWg8O2YW+Zur/Xy+u7zqvLBJp3IaCScUt/tqU3YuuILKBAee2Pr10/OR9v6TeC2bI3WmVcXsl6QaI1y2TyfShSThYsdOWSbNO41J8ncuMEBcpstwN6GRReXECQW4+DdzubzhoOLpUVnFvWq+/OL912E7RBc2sOi2/1pNolnDWKOrdjO25pK1CEP+5jTehGB9Te0AtbAArPhtBV3roxThrF26BSUszc3nGnP0XKqmvcn+MDOVq2NQX2
X-MS-Exchange-AntiSpam-MessageData: f6vMJReL9/IxuVn7rD7tgBriULb1O5PjyJEbqpVOpSvv2gtlOhcJlECeHfs6hPwJLFi8tHw18Fwd3SwOQ6Vpk4oEJUtK4xz6ApyZVyekQcIockQpBClkoXdB9H0TQwNSlCDeNBSBUWqEoU+PdPqzcw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c015c-7667-4dae-3435-08d7dc563f9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 07:18:49.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7zRttgvq/KAIjs8HgDPpuexA1p5MrGoFRwVUeGHAneddxIWUY7T00n+7NuEJhrq/Xw2hBZYagDEAkEPfrvgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

when do randconfig like this:
CONFIG_SND_SOC_SOF_IMX8_SUPPORT=y
CONFIG_SND_SOC_SOF_IMX8=y
CONFIG_SND_SOC_SOF_OF=y
CONFIG_IMX_DSP=m
CONFIG_IMX_SCU=y

there is a link error:

sound/soc/sof/imx/imx8.o: In function 'imx8_send_msg':
imx8.c:(.text+0x380): undefined reference to 'imx_dsp_ring_doorbell'

Select IMX_DSP in SND_SOC_SOF_IMX8_SUPPORT to fix this

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index bae4f7bf5f75..812749064ca8 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -14,7 +14,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
 config SND_SOC_SOF_IMX8_SUPPORT
 	bool "SOF support for i.MX8"
 	depends on IMX_SCU
-	depends on IMX_DSP
+	select IMX_DSP
 	help
 	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
 	  Say Y if you have such a device.
-- 
2.17.1

