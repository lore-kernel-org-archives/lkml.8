Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE34DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9607C2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="eBfxegga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHTHzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:55:32 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:28905
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbgHTHz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7i+t0tkYQc0SjTJMEzGhA/FORWM0YXAhzWtfeKuk/+CajLvrzdnmWndAFXVjeTjR5Gx8IfYU/5HZIWNkrZ+2T0vu/TI4t6ESxKfJXgAQk968hTb65I8m9zRDeVpc8Gia3MVOz0JnmBSKuTXPnglf0gSS1bocRSE+H/s/VkFxa6fdteTZ9t2joi/ZTNhlN0/WPep3VgYNA0yWV0pRmYHodv8TIchhqfQfCMeXDRyIlS9n6whc8vRt8779bKTTuiKoq1Hlt6rvGQyuyj99lfZruc0T8FN7nf6FtqsU/SpCg6kn5KjZA4GUHJujfH2RmBCWg5FWHfQT++bv2CwHVAYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIBWkqwgrba5o7D2YduJImEnPNs0UI/3+EVP5ccdMGY=;
 b=HGUPWvXsoUhDqKSshGifHMRZUduDH+/vpIonmVXm00Gftd6EKzrmZoyf0DFmVOadhRIDQv4eq8qBGh7kzg1wbZlDqp5X0ie7UgTuGVgnpJUMs2NibozKliEjdLCj6Np877HA6eAME2NNlpuDqyJMpXTUIHuGI9JMsc7ZV9RqMKqBDOuGKgf0HA3MxcrTer7d9sgXCl9C0DcLhkJZln9lpPDTJbFqjYmSZ735UjxaLUKpLDMO+wGRI8jXbv6Dat9p6AisV3rkW1qDxUIzIMUNWDzLCyYp3iyMHX0Ktvzvgle+SpoSA3xctX/Y8ErEAndBMNX7B3tKUZTY7buGn2g5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIBWkqwgrba5o7D2YduJImEnPNs0UI/3+EVP5ccdMGY=;
 b=eBfxeggaZOOstw1mKT18uVO3tcWPFB9CKjeLoN6XB0uuKZyca0IYH69W6qjG4WPkfGBkSz4qvQaQ+cxeJxfCWWBdXU3Gq++2So5RltPJ8hTxla/VigrGYdY2Jby0kjmWkOQOcwpaPXsjojrkaSkEiSQtCDUzD/yqTMjOoV9I9Co=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:55:26 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:55:26 +0000
Date:   Thu, 20 Aug 2020 15:47:04 +0800
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
Subject: [PATCH 12/12] regulator: sy8106a: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820154704.14554720@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:55:23 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc5f0b7e-7e0a-45de-64f5-08d844de663d
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB45630594D00FE1BFDF3BD391ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91Y5vmgbIBvLxxSSwG1BQT/nEOhigh+nxTuOwmj6anJW3PNqlA/J34L7JpGSLwKo7JIZ3MULnUHhvBaZs+HQzzDdnMu0gze6Ave/+PJUBCLIR4j35ElzSZcjkEv9gKjRFP4cLyCjbAydtBZFjfILWibS2Sk18AwHQfomeOzFE8+dJy12C72NC0dMRYIgEM0478NTciuFuq+fle7DC/hMqB6gWzFSqmgIuE3e/Au5SK3Wbjm95DzQrpvbmtt0RTjtyNt5M+QWt9wYieynybQO4MWNSQtk/8TYYyrp/yprBm1riUnsEQknEuOmilTXfZV0Ov3uO3hDvzOCA9AjAju/4mGH2i+Us1ht2o17fAuj+QEF5I8SYOVdOIIXhK4NiZdU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ir4uxmwi6IDskQkqx7G4ftsxyJvffmbI5nDdNXrzTqL6WHi6f6AtVC3r0e3Jwi2UXgvtUoDuaVEULHyoEFl1eHLgsJo3Eo9P3qq4CQ2Il8cJI5VPvaJoVbQV+4uXYvK/1EXYAResqDmwIDSWPJaTQyzZxWrxXO31T7/bYdjLubqE2C0+KSSTLSbXHP25N3DlO4/oKzfvLzlU70fOFqPeSg40M5RFtphpfmyq8/+qAyvgl07SPPBX54mL/aJb1tmzf3YU0tSNYUhc2sdS+nSwsnlvAkzjPVSzqgMQPzGviMytNEpYXJw5z65sxcxEntaxM5Sy3FbMRFFexrPI3B1V+MpDJeFiplOp19CXb1fAFP57iCi/nEh27c+JcWQSbwpVp6pX7aEgE4e50q1nCyC7awQyH4scTj9lqA36KzXbWtx+xIvlURce6HwFwg8kc68I6SlR8wQN8/o+1qdWBC3lgcF3ilmxYt1/e6L4EpimEJHE+k95yFKAhVoeq7nbCevphrgzmRqZhGXL9NEP8phebz38eshQ3Hl0KNV0A6Ry/oAY8zZ6q4ZFsjZ1IqsFDBmVc+DXqQGyRJWtEtlWy/Aava/eMNxO8h/nC4z2u3y8BIxn3OH0ZijJDeaQNmiUOsqLX95OV5ta7yUU7yio8m0Ldw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5f0b7e-7e0a-45de-64f5-08d844de663d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:55:26.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xirjHcObegYLoN3gT1jUW4rkvu637yC59EGkgJpQ21sY09q7v5NzAvAUWN/gVBrnHJQrgPdsuEvf5FgFTM2HeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/sy8106a-regulator.c:126:34: warning: =E2=80=98sy8106a_i2c=
_of_match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
  126 | static const struct of_device_id sy8106a_i2c_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8106a-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy81=
06a-regulator.c
index 2222e739e62b..1878caf4dd40 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -123,11 +123,13 @@ static int sy8106a_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id sy8106a_i2c_of_match[] =3D {
 	{ .compatible =3D "silergy,sy8106a" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sy8106a_i2c_of_match);
+#endif
=20
 static const struct i2c_device_id sy8106a_i2c_id[] =3D {
 	{ "sy8106a", 0 },
--=20
2.28.0

