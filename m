Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C9C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5FD2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MZ2Zpe3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDIHTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:19:06 -0400
Received: from mail-vi1eur05on2082.outbound.protection.outlook.com ([40.107.21.82]:13633
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgDIHTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4xLKlThJNJRP37jBaUqixfw8cm0r6H7ppedVNz+S4+ILSoaVBIDbAd6Eyl5XO0hLFgPcfFx5l/qe40olcCytdnp0Us1OiMLgTmSxJOIkuEgfAro4qlsvHrmFRIqXrbDtmxtsqx4y3s3yJlEdF8V4TDG5QIm/Xq/+AGVwGGnONzlWZ6kHhghR9R6ODA1pYIwJfSvBUWP029qJTzwWJzC4GdPj1KHlS+s9frmvfL+v9cRw/FiHKdW2tg30/KNIqwOztL2OtXWXWQCqAxEvR84TAqVI3AEoRmGaG0ycOuHdGg55LVF5Vng7sdf9rJdfoKs7j4x7393MciwsqjpFY7T0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/75uZVJuRyvM42nUIlOOHDEUg2Md3mX+iZHM+ujtfQ=;
 b=dOmJSVVyAooW7MXun3nDP4PJdejHeRcH77tTN+vC9H8372q6ZVs5SuRsEj+Ox3TE8LW9+Lap/FDyHbLnwMHkbGd6AqRQVoPAEi13PFBKGycQNsAc6RhHoeYoKcNMB6BEOulEjLW7TAdneu00xU8svYD2GUF1nzPbO3anv7iC2H4PopHT7IgMUFTOqW0HfByljxeKCqnvDFX5UrTLfawoBIwC+g+khOp70feEBAATY1D2da1OQ+aWTZS7oU4+yuEBE4RF2RNmSVR2JfoC7cSgE+HBHJFZbFqoCpCcZdH3zB4TjfIAdTapL0qzlhNpzE6DygGP9mJO/8rqTlNZy9Vx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/75uZVJuRyvM42nUIlOOHDEUg2Md3mX+iZHM+ujtfQ=;
 b=MZ2Zpe3n9wfTaq/WQe25kZwxDxLQPlbuaZEw+M1G22/i/LcaVQyzDgVGYo8PtVyMiMtRisX8bsB/sd6M5m23a7WmruYx8QNieRow5D7tSO3JiGnT8A3TEfU1ZJlb8PoZP59ROalmT37VAoC4jN+pcaetFirfYYxn++bLQdFgwuc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30)
 by DB3PR0402MB3756.eurprd04.prod.outlook.com (2603:10a6:8:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 9 Apr
 2020 07:18:53 +0000
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c]) by DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c%7]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 07:18:53 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 4/5] ASoC: SOF: Add i.MX8MP device descriptor
Date:   Thu,  9 Apr 2020 10:18:31 +0300
Message-Id: <20200409071832.2039-5-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
References: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::12) To DB3PR0402MB3835.eurprd04.prod.outlook.com
 (2603:10a6:8:3::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 07:18:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c82cea9-f93d-498a-ccec-08d7dc56423f
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3756:|DB3PR0402MB3756:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3756570C99C22A3F4F8D9B75B8C10@DB3PR0402MB3756.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3835.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(4326008)(5660300002)(478600001)(316002)(26005)(1076003)(66476007)(6512007)(81156014)(81166007)(66556008)(6506007)(2906002)(66946007)(52116002)(956004)(2616005)(8936002)(6916009)(6486002)(8676002)(86362001)(6666004)(186003)(16526019)(44832011);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQFtS+ypWS4/DkuUU+TsDkYz5jmBRB7dSHV1E4cvP0BDwdjAAX5tQL3MJ9X2F0061krOqdTuoXM/D1uh3wfpnfYq/2vvnTeAQstKAu5Zq0bHBdFpgk+Ypb3TK3QH4KqIsjzx6evZYFl3CUUTJceijDUM4jnBEOJ7pC0tOGPL4tYUtqJt5ydKq3dz2cGtBCQm45vGQzMRW4jmybuE1d/jJ5vXcaHSEg39jS7LLuNKRPhHZlc8I/9XKoUpX4STtRjsPOSIxRmXWk+XHaNzqNIvb014a0IV6XMLnCXoQJNxCnvO385JR13nuvHYkClBR2bq0ywQI9jYsib6Kl1IQX2K8/L1Ou9Vl4CwJTd6SpHBZd23qmxVwGrKajwhdZwMtQgVS3nbAUD3BL7mp4uMiMu2s86TkYVcoQaSMNMhuwtWVYsaikuMDAYLlnbhaUx2M0dZ
X-MS-Exchange-AntiSpam-MessageData: ytQawywCaerAF3GaYyYGKx0UQUmCNTMFGxCUK3ljqRnw+IiCNA7g/nMKkBAzqJZLtgoWHaXYaOHrjGXv0ofNwSQ2XxrHBtJzaxOnA+U7/GpW+6OoZymSxYpOYNxDuKUwwKRnKPcImApSEcHVSVD8MQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c82cea9-f93d-498a-ccec-08d7dc56423f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 07:18:53.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX/ruktDay0ds5vUF8t0mw/TP08YIJmYPJoz4ePkhtIXiEX3c4H6ARF3AaOyEmmxjQ8+5dXsCHWHZ0viMtcDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Add SOF device and DT descriptor for i.MX8MP platform.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/sof-of-dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 16e49f2ee629..c6167597d6fe 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -14,6 +14,7 @@
 
 extern struct snd_sof_dsp_ops sof_imx8_ops;
 extern struct snd_sof_dsp_ops sof_imx8x_ops;
+extern struct snd_sof_dsp_ops sof_imx8m_ops;
 
 /* platform specific devices */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
@@ -34,6 +35,16 @@ static struct sof_dev_desc sof_of_imx8qm_desc = {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8M)
+static struct sof_dev_desc sof_of_imx8mp_desc = {
+	.default_fw_path = "imx/sof",
+	.default_tplg_path = "imx/sof-tplg",
+	.default_fw_filename = "sof-imx8m.ri",
+	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
+	.ops = &sof_imx8m_ops,
+};
+#endif
+
 static const struct dev_pm_ops sof_of_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
 	SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
@@ -113,6 +124,9 @@ static const struct of_device_id sof_of_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
 	{ .compatible = "fsl,imx8qxp-dsp", .data = &sof_of_imx8qxp_desc},
 	{ .compatible = "fsl,imx8qm-dsp", .data = &sof_of_imx8qm_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8M)
+	{ .compatible = "fsl,imx8mp-dsp", .data = &sof_of_imx8mp_desc},
 #endif
 	{ }
 };
-- 
2.17.1

