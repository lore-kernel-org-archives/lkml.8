Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B6CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3002076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ZJj2qSa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHTHv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:51:56 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:12768
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpFZ/lHg6fh6FNOZ8DQEiusROr7lhERNEAzSpk7qwMGyh7/BDs8AgBkBf7C4Pge0CY6qfWSfrK+WiXET7Od7NpTcxhRBiyKmY/QXxdwvI+5PtpdaKpl/Q/TiyeUIpvOWmr1JW+9AaB6Ru3ut+Uc7hlJALIDMHTzRv50jtpB/7zgZHarf58FiK7ImBMaCLWdl6NU5Yb2G1hZsjKVMEJ21Mq5ZFU5iihgg8yGSSjBnXbkgM14zm5M2ejVPi5NjC1Boxs/o5fFDtOXPv9MybcR4LkKZbvmY8sfagcOMrgQ8q6FL9OpptQQkuXGl0u4koed67jHxlpIixcuXOK1okQ+v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6r3a7f5HXta43l3bKvwm/ztY7DNODH815tZybl7iU8=;
 b=LpAPsWc/rMQsgYZV3MXF2bWitjzE5C6dXqyvf2LaY3lX+FMYlNhgUT/ZCi1r7FbhrGFhE8TRzUkqawpHWLCwqOt7eiwTlj14nl3I4iaiOnVkeffA6Cb72MSHATzf+hyFEwXM9Ebeuv466qbQaUGB593Ag0Z4kwepwlrYK8tWk4YGii8HlmESlW3AwD+FY22kYGZWiFNR3HoVSi5yFzqgw/mT4y9ULK49oOn7p+a4M5Yt+4SL/kG17vlAU9j9vciyuFBQlN0ckmD+Bnv/fB3IoxuPWO3dTU2B1FZR2Ios3qutLbCibrCExlMKZKTItIS+7tm7aziE4VYFAjGdypg7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6r3a7f5HXta43l3bKvwm/ztY7DNODH815tZybl7iU8=;
 b=ZJj2qSa7YpQGZPYdbd4iIFy+Lc93+ctBEzl9ED0ZICFm5GGh2BSVFE3wsrzWo+pJiqeACc/BnghpdLmKxrQv+UIIEO7icf2lTxtkd7Ze8ATNA+2JL+U3v+0zGQZmPksdazOSpI93WUECpspD0l11LV9Qwbw1hQfdp4tLYqhGPOw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:51:49 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:51:49 +0000
Date:   Thu, 20 Aug 2020 15:36:15 +0800
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
Subject: [PATCH 06/12] regulator: ltc3676: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153615.352947f6@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:51:45 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11172cbc-63d1-4e41-f2c7-08d844dde493
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4563B3E97BBD373C9C6B3EFFED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mH0ydswDHdNYylQwBRv75mKUuCWrlGXV0i2byJ178GNHZso6tFTnBrmez5aSXrrEHn+BgeJ3v7MCvFNrt4gdFdVrgGR+x/+xXf3Bbo+9hGDN6BHgcjVoF7ciWcSKUKqH2hBIBIRg20wUPpxyxkFlWkl4TgF+rt6+zIOOrdHvgUinkKjHB9w287zc2yzYRn1o/jlFSIpFC/gekQCQa/31UlBaiEZNALO3oE0AX5YcjgbRY168dcQq4LdsX2y2+oYMi5mGjHOxFrMP+VLOTjx88QAc/A/jliA1dlU0oDToaKlzFgQ1RBtGhgMaitXPlb4LIBNIkMrHXxBxiKK6xfIRgWfA5qVA9gQMTgY2RShqkXhF0TtCiXUdfCnp0s29T/E3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6NFwbL6CJIYazAISo/bnG3r+Ds6Wg9sfYCz03SHgYnOFzI82O7XHLHkH0jYeV0IB5P5qAL0w1AvoHMU8irvoY4P2KLdL7rLHwtLUEWYgDMKaYMxdvfdmoqsAxEQ2ZmTDjK6wM0gkDX9/sEcbKcLLdZ7ZcyeC2v6VvBNGzpBomo1Jg/Ff7nT10E9KAd0KDd+AzlXV0+OLBso3z5kb/r4HKsUZsCjWzj1uTgUoRgbfDYjl1pse6mzU34Q8JyuPei9JrQktCWre+B00VtqD8c2537PzF71FeUcvMUVrNamVT9Kv8R1AZekirT0XB/rXL5/TzjBwkZDRNt7/0PFWMAZONcwR8bqpPWrW/hAEJWBwjCrSylvXMe0t4SIPcXf8Xy/fYPXq+Y7rIswPgBgNJ2BGulervlD7oPV9+EUSSHvdFS0KIJZfFpAFDtKaw5ZWCXd47Hh/1FwQH/drQfvcniyEVvrE/GS5vQbrnaY1/gGvIaIbQvlObqvMPJ8NQ69bbmmTTkd0NMwTRIeMFqOpAXLO2dHd24rPDdftDrvJ3RQhWS2ZzjnYqwxeSDYpTgabxtn5tXbkDQUgy7U+ClvlL9siaJFSTwLNRMW0Hm9uvk4DBpnLzA91ARLTvNitphV6ragWndNXg7WCDY+0lO7W8gz5cw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11172cbc-63d1-4e41-f2c7-08d844dde493
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:51:48.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGPBBTSz2wThhp54meTkCN2myFjZ5Pesw18aKK/dEuJ4jr+rqzNJydq/SnX2Z6plgzndecBPQwIq6/YFkT3D7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/ltc3676.c:371:34: warning: =E2=80=98ltc3676_of_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
  371 | static const struct of_device_id ltc3676_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/ltc3676.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 093b3e4a6303..0778d5bb7559 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -368,11 +368,13 @@ static const struct i2c_device_id ltc3676_i2c_id[] =
=3D {
 };
 MODULE_DEVICE_TABLE(i2c, ltc3676_i2c_id);
=20
+#ifdef CONFIG_OF
 static const struct of_device_id ltc3676_of_match[] =3D {
 	{ .compatible =3D "lltc,ltc3676" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ltc3676_of_match);
+#endif
=20
 static struct i2c_driver ltc3676_driver =3D {
 	.driver =3D {
--=20
2.28.0

