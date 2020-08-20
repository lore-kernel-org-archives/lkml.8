Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270082076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="bjOyaqr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHTHwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:52:30 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:52487
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbgHTHwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN2w27agZnqgEA9oa3EDc+TZussk50ocX/lb7i85iRbxkOQJ3B6N2dPwnufv/f68oztEPmV0TpD7vAtN25pI4Oxby/HYLqE4p6LWBCod8dIi3ZgnoMdaIVQBB8zJRmrYB67y4lBGtng3uc9B3peTIGO8zedtHNt/HhjVea+m6dVo3oh+mK6ZN1Ec+rAZ5itbZjfZUfFpRRmBUGDvO0NPqMtE+qKfDRsGlAO5XhP8uzPXonPx5zVxSq3i7GCDAaAUowHLAbffoehiaNnywPOGbC9hI4FFMkU7h+seISFDIWvLPwacNuSRHvddJuqhTcXHRxPemZDSwDqdVa3l5vSlgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY98/iL0igA9aI5KOwzSk23gsLJVoLsPK3WGTOCE19k=;
 b=Qrj1A982jvDR3L/vDTJ3KstETCDQGsfIxVk+8gg1TzdALFiATTXaHK/H6F1qUomb25Bo/Wfv+C77kFd4YtPzjl8KTBt4Ud3q8fx3b7nDXKFMp0Pt82cwUUD8Cxv+xRHTAAl5sdA5bx+xkeC0NNNNGgWRNqA3tKdMKAq5MC5uPPkSCHJ/kNxk3XiDTmi3r4Log5MSLDxfNF+qR3jALJNksbDebKWuYaBrwinhpJZrF+u6LLDoHoW38B7cn4zZafhdGvDYd6HewvFE9oaKWH8sUPQu3EwdSgt3UBeUekIrnn7d5Lu0Un1hc0ak7e6hrX2wfSzoGZMBc+Ae/NzHASoCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY98/iL0igA9aI5KOwzSk23gsLJVoLsPK3WGTOCE19k=;
 b=bjOyaqr7+w1nUwvFKx5C9R0mq54GiwRFgSwXjYDfh1nywbgG1eM4xG4ErPvzJM06JR1M+XIuAqzHotKcbJP3UpVJBV+3ovNIhYCDec0swYRvysMuJ6wxurrLGqAqp3RZ7OcgaYDz1K39qB+Cr65uxs7GwO7/73063UHPuQhr2/Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:52:22 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:52:22 +0000
Date:   Thu, 20 Aug 2020 15:37:29 +0800
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
Subject: [PATCH 08/12] regulator: max77826: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153729.4bee7e48@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:52:19 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39989689-7188-493e-6047-08d844ddf87e
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB456327E806361D7C5321AF47ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5glhRY6cYMwHxVlCZO/Pw23Mn66kjd4aKjkuZyrS8fiyKq3ixCAVhOdqDg69PRsb4mU5SaKuFcPmJEktQJLeHOcZ3zrS1imw8jswEPA63qAQwhDhS+XQEMpFFFNL20qvicNaxQyo5ACvi0yDxsQf7HVuyH5xNHe61XJRRC699nPKaDsHpsA1Nb0T8P1UrY2Th5uYCji4gsAE7HECWmcCzM7iF9T3Gf3logQy3OO3xy1pb3NIW24hmF6ZbYVYScxkEVdZFrXkEL9swpi3Li43ucPGJQ89q531uuZoY6bU+kGcaXIzHNO62kWAC/ma4WAZbfGVfsSuYFQlXn6PODpJRNeKpIbJ+Fy/CCTGzwNQXv6lVsnMZDwFzajIVzmCl9X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0C1RznXcXqwL+LTr4MfdOC7wZ9fuIX9wILv25biXbSxxpoYTnSvtqsj2IT5quk6QMnS7Kj0ED6W7eVwmCgmx+tyrXBH4XU58EAODmaNGfg8HiDBtwxs3pp+8g56ApLTdXqqdESm+b4CH4M+kH5nc776h3D++cIG9WaejGIfT9oWYtwC/BStNon87u2cBb+B7fu0ElREdepH16Bei5N6qxHiFvtXcNjKXriGObmLSUUp/vc1EBVcXwO3VQOOC+QAxdlA2BfjcMePLQX/+VYSQFYWX4zTYb/9b4tbzkzpGBzTac+VfiCOlQRTxgUHPG6cLUh5jRw32SBxfQe8bRraoMUhLSJlmeL4tL58qzhU4RnpQu4a7VnUF78nslf9UQhlbF3HtYvegYlDxl+jgiaWX/lXWc11NExC2sPVy1y9QoW/1i8we3/hMwRcfBlAKdAVOX+rC3eYJcf22oB6Hwau59iX1AbKKofVkf47dqDm2t9DWakSHmLEKujiY1b+u+tyeROqzi3nBXbxAoPXgEc6YkjU54nPw1BusMgQQlfsvomXniOrcm0Qen2mwMxyjxKzijRk4fJw6eTWyklxytCXJFN6pTayR1/EEWBMjve9jmpv/zVG/BxfEWGAkkw6nS9PkXv76xCw4OFlFo53RoYgbQA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39989689-7188-493e-6047-08d844ddf87e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:52:22.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk8iTm89XHsAtHoM1pEL/YGsE/5Rk0q9H0VTNycwR01TySthq9bcAlpKN7s9l5weTB2lH7WI7SOP/AKcsR48zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/max77826-regulator.c:277:34: warning: =E2=80=98max77826_o=
f_match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
  277 | static const struct of_device_id max77826_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/max77826-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/max=
77826-regulator.c
index 502ab6afc814..7fbdcd7118a8 100644
--- a/drivers/regulator/max77826-regulator.c
+++ b/drivers/regulator/max77826-regulator.c
@@ -274,11 +274,13 @@ static int max77826_i2c_probe(struct i2c_client *clie=
nt)
 	return max77826_read_device_id(regmap, dev);
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id max77826_of_match[] =3D {
 	{ .compatible =3D "maxim,max77826" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, max77826_of_match);
+#endif
=20
 static const struct i2c_device_id max77826_id[] =3D {
 	{ "max77826-regulator" },
--=20
2.28.0

