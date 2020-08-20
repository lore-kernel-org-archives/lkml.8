Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E033207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="d7BLIftl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHTJQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:16:53 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:23675
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727125AbgHTJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NACtE7ZqtERHAYms3ER+qqy/Id2/cFdZmBLwAANqxCnhh9haV03f/K2CkIYRV4KjFRzJdHVPGIMy8yottARajx2uR2kCQ0aiCQpG2dr5OWJngyHgKp0Tov8Hp5EIP/AchoSZB9NVfkvAM69mEQNh1eiM2/t552TXRtjzNl4+nJcxFZ93Blk5lBweqeHKZipCo95QOVeRrdvlG72WnQlUN4I6hzhbWMANoqcc8eGCqcw8alv/DFp2Pv51GFh0HAe2CWfNiM/NM1Hx4oixco+9+ib0McviBCmS20jVBTEyoAo2hCaYQDmez1jDtpeYyDZsj2w4xot6W2+VAstdVcliww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM6/JOlbgW/DXaQv1/61oneRFPp9b+EVt2boDh6c2DY=;
 b=YWpOgu3G7p5YPIVGmc6FNNJUmk8by+0VLRSNRi7Yykn2E9Y2TnNJAtmaj6+A+sa2BHia8c+AYcJVFwwu64BiJuEK/0geyhq4wXGM2xQIxue36yO5H/L9j2H367OE/hAikP+w62mQvnAgCTY+s7D7JMYjIfqRdGimfKV9S5nllR5eN8DLxxtwsky6oJr5hCn/pzsHOEahV8SIXXidK1DrvKoXvA8aPuduXSjc18kqwzZvERbsT+O+q9Ety09kg9PL7hTESsJG/xLJ6F7NSb3twMLbaDW6nMOguq9zf+yNJJOrccfuAqdhN7jYCyyWB4KDLbC4Y7YprNh23idBo1Oc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM6/JOlbgW/DXaQv1/61oneRFPp9b+EVt2boDh6c2DY=;
 b=d7BLIftlkBR4BukCSPg4bNCCO2MoClKyFuLx8QxGGAAiUEHcPKQkRwEOXvj+si1JPPvn6kN0V3FZblNsGMtDb4eh3uu7q1IkfwPXNATfLG/MkLlg3ViX5eu3fqtdLGMkkbVjQYWqU04DFvukveyPbDTsnTdZfGRWEAK/hO2jSIM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4738.namprd03.prod.outlook.com (2603:10b6:408:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:15:39 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 09:15:39 +0000
Date:   Thu, 20 Aug 2020 17:11:51 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/4] regulator: mp886x: support setting switch freq
Message-ID: <20200820171151.12b01534@xhacker.debian>
In-Reply-To: <20200820171020.5df4683b@xhacker.debian>
References: <20200820171020.5df4683b@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:404:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 09:15:37 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edde4e3b-95b6-47cf-21d8-08d844e99b0a
X-MS-TrafficTypeDiagnostic: BN8PR03MB4738:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4738B279E3AE0DFE1D6A8E47ED5A0@BN8PR03MB4738.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7P1LqjuIbqv/1GsZgGAvRSM8zcydB2f36Io69uKaKCL9ChrTeWRFKSpvH2xqSJKyagmbfsesdiFMAqRggSFuGN+SmM4VMuKCYgB3ZrWdjHFmWQRWEF+WGBqDzaoJPpRVql+Fl20fGGseNyt1CP3OMalobdI4CK8WhkgwusLXfN1565RYS3vE+f3w/xm1tjCD37ovYJh4dX2xHOWF7zS2PUKdehZ5Sk5DijJIIn3x6QMR2Pjx2TEJZbHeQn+8kWd9sZhSU1yp3yb5KV9eEtOqsSV+cHspKIko2VfAETvt/ryvh9w2WfI5q3ihPA1oraRhQpcoGXcquzLTraw8qX8+yf/jNcdLYIsaLwxkcpLDdpVuyHAMhSVa6ZVIx0QDh37g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(316002)(2906002)(110136005)(66476007)(6486002)(66556008)(66946007)(110011004)(16576012)(4326008)(8676002)(478600001)(5660300002)(26005)(86362001)(9686003)(6666004)(52116002)(956004)(186003)(1076003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9AhRj63J7YBqtkthLTaUFuI20K1/rHO+kV8oDVDVGbQmsVkVu/696d8ckwpsSEOimi/X5I+0c8bqf8eL8S3YWq+hRnqZrRT8Lr5uMZy6hfO4GJzA9ur3H3/WmME0d+3NAyGfeJQrjV5umcoSYE3BwaNb7RWl0Gz8TByH8UZ2BDWmdNcM+Qaot1c4dSNpyT60wvi07UdAf8fjhErso/0LwCMKf65G0fIYxd2AMuqqjY0u474id6zkHFs4AryDYLeB1YnDaoTdCHnqeBAX7RN2XE1w87Taovf9R8te7ULCL/jgYOnaZamwDgXvIrN2TlI8z6xxaEC7AvY6wphDVgLxHkFHVAIfweW0nZ2Wzc4ie7BG87UGZeFSPfKIS51G/aBVjFnwlDCBnzC00XzD6Hn9Dh8MgEiGS7hCwT69clsgk/vCTQx0pXBuLj3rLlMgvv+uSSsu6zX3BdmlFt67mmbL8bxPCsQrYBehL0yn1sa+1nq/533YfFUtwlLNiI4R8D7Iz+ucMhtuzMo0TMJbZE5iZjM/GCam1W2IoABfWy8i6wbEmguqmaEG8Y1HOjUPLRV4PfW6O7sPRBolkfepRxop8EXa7SeYAfK+719UGAUnHcLpXZqVgmQMGIds3EsLo9Y7Tf3Mr/K0b7ZbSEsAVfl8qA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edde4e3b-95b6-47cf-21d8-08d844e99b0a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:15:39.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwnRSKneyLp26/oB1Izxrw25IMqHS1A6AmtTO90DhzWDCN3bwcJAzAdzSl3Gq8koiPseORcGECgt+bpi52rNVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both MP8867 and MP8869 support different switch frequency.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/mp886x.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 1305bf217df1..a84fd74081de 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -22,10 +22,14 @@
 #define  MP886X_SLEW_MASK	(0x7 << MP886X_SLEW_SHIFT)
 #define  MP886X_GO		(1 << 6)
 #define  MP886X_EN		(1 << 7)
+#define MP8869_SYSCNTLREG2	0x02
 
 struct mp886x_cfg_info {
 	const struct regulator_ops *rops;
 	const int slew_rates[8];
+	const int switch_freq[4];
+	const u8 fs_reg;
+	const u8 fs_shift;
 };
 
 struct mp886x_device_info {
@@ -60,6 +64,24 @@ static int mp886x_set_ramp(struct regulator_dev *rdev, int ramp)
 				  MP886X_SLEW_MASK, reg << MP886X_SLEW_SHIFT);
 }
 
+static void mp886x_set_switch_freq(struct mp886x_device_info *di,
+				   struct regmap *regmap,
+				   u32 freq)
+{
+	const struct mp886x_cfg_info *ci = di->ci;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ci->switch_freq); i++) {
+		if (freq == ci->switch_freq[i]) {
+			regmap_update_bits(regmap, ci->fs_reg,
+				  0x3 << ci->fs_shift, i << ci->fs_shift);
+			return;
+		}
+	}
+
+	dev_err(di->dev, "invalid frequency %d\n", freq);
+}
+
 static int mp886x_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	switch (mode) {
@@ -162,6 +184,14 @@ static const struct mp886x_cfg_info mp8869_ci = {
 		1250,
 		625,
 	},
+	.switch_freq = {
+		500000,
+		750000,
+		1000000,
+		1250000,
+	},
+	.fs_reg = MP8869_SYSCNTLREG2,
+	.fs_shift = 4,
 };
 
 static int mp8867_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
@@ -233,6 +263,14 @@ static const struct mp886x_cfg_info mp8867_ci = {
 		1000,
 		500,
 	},
+	.switch_freq = {
+		500000,
+		750000,
+		1000000,
+		1500000,
+	},
+	.fs_reg = MP886X_SYSCNTLREG1,
+	.fs_shift = 1,
 };
 
 static int mp886x_regulator_register(struct mp886x_device_info *di,
@@ -273,6 +311,7 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 	struct mp886x_device_info *di;
 	struct regulator_config config = { };
 	struct regmap *regmap;
+	u32 freq;
 	int ret;
 
 	di = devm_kzalloc(dev, sizeof(struct mp886x_device_info), GFP_KERNEL);
@@ -310,6 +349,9 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 	config.driver_data = di;
 	config.of_node = np;
 
+	if (!of_property_read_u32(np, "mps,switch-frequency-hz", &freq))
+		mp886x_set_switch_freq(di, regmap, freq);
+
 	ret = mp886x_regulator_register(di, &config);
 	if (ret < 0)
 		dev_err(dev, "Failed to register regulator!\n");
-- 
2.28.0

