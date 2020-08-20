Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51517C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D38C2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="IhKg3YZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHTHzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:55:11 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:33531
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbgHTHzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxuks3pFP6ERlEzCvhlPvlpkgarNBM7pmVG0hHIFBW9u50j7PVrTWsJRLufwreLrleASm/lwoGQUKEkofAWSnECymuzlJ3cI7cQI/mGQDQN2CJ/jjNUyQ+/QZvORwn3CAl9IScB0vVJUonZX+wlbtMgQjBNBxBuitpFgSMvhY42SHXGLau4+MKUdpIU1h9/57AuPsemwBLIdvPnNZ6+3vcuwYRcCgAYEvFVUYsS2JQIg2t/NAvmmDiJccyzEdZO+oJtcUW3ckINIy2t1v4ehM2RM4gRFmQo7KlVvW1aLkB7ugDvbvyGJ2SzP1GlgHLa19OQjNI/hJ3hXSU4i+HcZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0F+bCmqcAnRxC8KfRXIvz6WdWsumQc7DWHZHtfxOus=;
 b=kfS1hhXBVidDvOtnj7CrW1tap/3H1ce/AreoxxWwkadpWbIg5To3+fALA2NuZWIsZj73zWLHd/D3sou4QudAxTmwTNr6QfhCeu5VsySzbbGMb7zE9lncwLMdVpJ9h2tFsaqh41XM04hp14ZfpfPenQZ2IrAGPevrSgELUcEoZMGuQAt3/2A2xOn7tFKKcpn0d+a0O0uXOojJ7UlNUguFEAH4jq1s9QKXDbmk4+q/ktinTbrIuUoIAY1rq7uG48Wgq1RWq27GPVMUf7bvzuy1yTLtoAL2mLE9kYphk8iIjByF5vy0ZZngP7aExYJe21tDMtaE8Y7aGW8m5ahEkd+jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0F+bCmqcAnRxC8KfRXIvz6WdWsumQc7DWHZHtfxOus=;
 b=IhKg3YZ1G4PGsJ96Tum3KqPYGjUZsFI9Joxx4Q25H5Dnr5XRgJW1NBNHdMSK73s0TKOqFatjd/G1ToCG4NMLYd1cNPDT53nN3WIBhymaNMNxoOJZ1aebMtVsIUzyjphFJnPGFejQv8jfqRI1IhKdm+pBTvfb45g6gZsnc9UTDnY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:55:04 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:55:04 +0000
Date:   Thu, 20 Aug 2020 15:34:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/12] regulator: fixed: Fix W=1 build warnings when
 CONFIG_OF=n
Message-ID: <20200820153436.39088071@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:55:01 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31f1421c-bf0f-4c46-e3ee-08d844de58e6
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB45635C561B5D1601C9927DFAED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S55hj0RnyNfk/t4q6QGeGpTNuP2YUyq7EPiTIyNOJZg7Ze5LUd3au2DsC2kcE+2CPYki+r0bnKCQTB5GEto8vVSmIMjTJLnDKlUM2QKXzKv/JFH2aXeOJK5jPtr6QXyEn20NZPyGtPb0Oe0A2o8/L3uJOd6YipBmWr1VWn4cMJxz/H9emfh1RWEZBeKVUiU4qcYa5JuuPFz5XQsDetBXsJafCpRBCiX4mVeHkaPpn6e+MuZnNHFQ7eTntH4eS9nh/mFa1GrIrnM9cRoaavggqc07M3xIE11SGZomSRgcNVpn3inXdEK8x/bOQAT6hvU1tp2GxUNpVmRYeVLaJRfQYq2P2YO6bJTtzoGJ+XR1t9uThu7NfoP2lTV8Da+/1l60
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Pvicf3XeI+mnIRJBXholur0MDPEe9yuHdr58X5UpSn5rLhET3hMysg+3eK1BKQiiXNr61IEpY9EwFTEm7i4NibdxCI9aLhFpZM3Q9m/XGi6/oImteOJhAnkbprZ2Iu84WQ5RrpKqldOtk8yDwb4Sh9VFARNT+bWTmMLaIm4C17QNndTy5h28lbE/pdI0iska+mUzq+JOIg3VTAU+Cegy3g+voXUe8pLXN2zcL3xImkH4m+IlTy4xCsHmo4J/yNT2QgTYGWE5cAQ1ifndn/MLtTFMFD/EXar61K8MwvvMscX59oHeHjXtvEc3rVrXRvp1h0oBSQwu0cw+gf/thvxWzLjslbwDY+V25kY5mc4iF/sOHhSGKl8XomGwpz1u9gPEDb+bXAdR5K7yKJE8tQ4bkPwPaphkX0I7tX/6s4pXV5+WqCULiMtvT8GFlUoUktY0dlXeci4EDO+YMJdHfFUDjCjkEHsWCDq7dptoHxjT5ybhs0tQcLQr1xSmUFmLtg15O5PICwGTxAjbNO/XXFSQ3/35/MONLKl8HMu24k8bMzI+yKiiF+2q21ibn1H7+QyRKy5AqqkQCJxg4jZbvs6ZKH7YHKBSWKH72OfqlnEONyDLnH6ZjpOv3Jl/UU63ih5/JTNqvvN9CCGxZFySt1+AsQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f1421c-bf0f-4c46-e3ee-08d844de58e6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:55:04.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpRNSr8GOGI1vx1omaF4z3aS0x5eZRQXmm1/1851d8oJVDPVUr2x+SEj/9r2O1jBVQV0SFi/shZGhPm3DVENHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings when CONFIG_OF=3Dn:

drivers/regulator/fixed.c:48:36: warning: =E2=80=98fixed_clkenable_data=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
   48 | static const struct fixed_dev_type fixed_clkenable_data =3D {
      |                                    ^~~~~~~~~~~~~~~~~~~~
drivers/regulator/fixed.c:44:36: warning: =E2=80=98fixed_voltage_data=E2=80=
=99 defined but not used [-Wunused-const-variable=3D]
   44 | static const struct fixed_dev_type fixed_voltage_data =3D {
      |                                    ^~~~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/fixed.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d54830e48b8d..2d92a471ebc1 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -41,14 +41,6 @@ struct fixed_dev_type {
 	bool has_enable_clock;
 };
=20
-static const struct fixed_dev_type fixed_voltage_data =3D {
-	.has_enable_clock =3D false,
-};
-
-static const struct fixed_dev_type fixed_clkenable_data =3D {
-	.has_enable_clock =3D true,
-};
-
 static int reg_clock_enable(struct regulator_dev *rdev)
 {
 	struct fixed_voltage_data *priv =3D rdev_get_drvdata(rdev);
@@ -260,6 +252,14 @@ static int reg_fixed_voltage_probe(struct platform_dev=
ice *pdev)
 }
=20
 #if defined(CONFIG_OF)
+static const struct fixed_dev_type fixed_voltage_data =3D {
+	.has_enable_clock =3D false,
+};
+
+static const struct fixed_dev_type fixed_clkenable_data =3D {
+	.has_enable_clock =3D true,
+};
+
 static const struct of_device_id fixed_of_match[] =3D {
 	{
 		.compatible =3D "regulator-fixed",
--=20
2.28.0

