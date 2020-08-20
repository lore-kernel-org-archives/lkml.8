Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC859C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9290B2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Ok07fS94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHTHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:52:24 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:52487
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbgHTHwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:52:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIo0ukr/tZi05K76JZSmoAXDJM9l/GxXnneXpHxlt0Sv4/f3lDEWf9l/SSpNtzGJ3XgsgbPI6psu36lUaFjKJTezwnXwORlnLx2mRyiPoSImFtoFI78sKk6Ydvb1rqJ2Z53zQzd5lyR5Yw6CkN6okXreYaphLfnUlOXm4ES1VptgxQzUFHMtSiSYDFV0vxjtUCi/LWcA5xTJcwXNcHI4c7dxSqMu/pkaCusxH/EzLmHRT/iOMGThgo5PNZ4E6Zsl260H8aThuIkNGIIhflVAcSpfSeG7k2pme9vKNHNRYxpdS4nlLDaMjXyVwvR8/2D0qfFVkBNnEtVanONgOiQcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnf3nmAMf0jniAlfsxDeUj7QFOtbRyfP2ALd/gz7Q3I=;
 b=Ch7De4FjAN1XBEDUQWsKEpCcMunS97E80uPIiPCQ2ePVOv7+wIlCJaEprx0YKi7RnyqF0+8nuVD66xFVsRGLuL/tEERVTv1K5GWwcLKDfIoA49CrUezzfbrfTQ8nru8w/tb+AYnfzAZYXUUhqGD2OnWHa+wkyfta//OuJ+Bti6FYNlAupfoFUyM7vMr/3hzop/FTTdqZ4IrAPCJPaVEXm6sTghQmZtUyfySup4QHn6JK0YWVQ+8omeWLyv9fUluiJ8KHpGsGUB6a52niAXF+quXhjugcap8ndoEDgV+S+g02IgNuNLv6Lt64N5V3m/7JvSoJ+QzEd6OM9pT9WDoNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnf3nmAMf0jniAlfsxDeUj7QFOtbRyfP2ALd/gz7Q3I=;
 b=Ok07fS94C5yZiSRQ4f+F/M5OpLbpfIEuEY5B9Th5fvWxX9HMOSriVwaHI+o1C0KPyivHSRspDGpHGWFxw0ORv2do1RMAucsTwKtBqqSicYxvNXLLdhsVkQ6TpqHbu/tI65snHCmvI2bsDOGDAU40YY7mVeKneFXlYXFz9L2DhV0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:52:15 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:52:15 +0000
Date:   Thu, 20 Aug 2020 15:35:29 +0800
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
Subject: [PATCH 05/12] regulator: ltc3589: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153529.4c658b61@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:52:12 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe96ed47-9148-4f02-b77b-08d844ddf486
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB456311CE913E16AE319CE9F0ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6RMGkcdO4Wi2Riv2nUnxv8ch/SxXlz9lYN6KnOusJnuPoXy13aZzw9Xdw1G9dZCjYRdgmJ+05deI/9jx44bbnhrf7EhAjNJotB5c5PY5F5rbfoLlx629DUBtXQzS+rhEtHXf0PrjZPj6UrZshWEZPLEMMfkPDYYCKoWtmrgGdsMSSZ2H/ybLXVfdUo3MVowo0ECBNd31aJtV1CwXkskOB6bpJGeM8X/Gm9mq5CGG6Y6Rgd94ynsu3yYIfStY4VxmuWDgz6F0er6GNHXM3WfvHPnPZ3RmRPq/lxBTcnvCTUmb/EM3xPlH5cDObUfg2vw9EUL7MBR5hVDOaQQGqzo2VdK17tmIq9J+FMfjsm6n2xVfpYjGxA7ygN79nzLbjK7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WlMz3vbJRachqM7TKXPoRtWPPzuD4CA66FvHZ/0yKGdMBvsYFZGyXn3eL5xD/lYj1BVpZs7CoQYFgkyk3i3RFgzQgCRqcBwZEIMQZHaI822FckSPoZ3jSBVaiwbTrqx81njRlhu9tzfbmvKVEedzz4fJx3qGpmuPNvtdxLRE9ZlGJvVg6hX9i/MtQLXFefP78hJaulDwZ3LqW3LsfyKP02BZ219oFJ3bKDvyq5YMlcSv7XU4Q0EFT8QmV4uBPHKcEW4eA4Ns36+SC1ZzlcwoXikUvbAs3PyXCFtL3a4Mh1xFESDI0+piGKAWjw6szEo06DXeg2v5dsOmDQonO18nn3JliHVFq8CbNbllf716tCBzXZAZxa51s1qZUoG26a6okA5zjwe+IgP7+cqU2DBs3x3qS58JUJX5+JsiEjI/urSzebxqhaNk1/x4EnkkwsPRLRLJUgp+ydlbYAn5IvAJlt2LhCU/0FUsVO2mAnzkeS1fbvk5ZMx0jrSCSFkgdoeb+UP34Uo6oIEAKpBWWlC94KjBS4390z9jC0bwGhNV+1zr88YKvvbnOsTsCDJbAt7813Dh92s1ZYrG89CUeX505Mlp41C00v/qMbITiax2nsPfsJMK21e1GdscFamN7ZTGANwHQXqNBFM7VUuWKTmQOg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe96ed47-9148-4f02-b77b-08d844ddf486
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:52:15.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQbEZZXAvKkL9d0Pty4QjXLw1IwMzUlKDBSUOKTwiiuUQ+Hg5ZdqIAvFgC1tRTh8HwIlJ7lwALbkgv3ilKGrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/ltc3589.c:460:34: warning: =E2=80=98ltc3589_of_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
  460 | static const struct of_device_id ltc3589_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/ltc3589.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 9a037fdc5fc5..c73010bb3b41 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -457,6 +457,7 @@ static const struct i2c_device_id ltc3589_i2c_id[] =3D =
{
 };
 MODULE_DEVICE_TABLE(i2c, ltc3589_i2c_id);
=20
+#ifdef CONFIG_OF
 static const struct of_device_id ltc3589_of_match[] =3D {
 	{
 		.compatible =3D "lltc,ltc3589",
@@ -473,6 +474,7 @@ static const struct of_device_id ltc3589_of_match[] =3D=
 {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ltc3589_of_match);
+#endif
=20
 static struct i2c_driver ltc3589_driver =3D {
 	.driver =3D {
--=20
2.28.0

