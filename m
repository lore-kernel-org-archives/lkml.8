Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA8A21744
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="gXEYhmkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHTHwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:52:11 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:45647
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTHwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGHfTwgzLiTBk+INrDQh4XmW7djAfSNPqkmW4WoPg4ps7upzKhlxK9aYShJcL6hahEhLtt/b1hzDg9b9hoTNWUB6KGeQiD5DD558geAY6WXj6iBe9rUfOTvAHdQ0mqwr9G7eKOa9zFA58xkvwxd9dZ97YyiKM+oEvIzO+pauwYXKQopRz+m9skplmwX7bzDXyXkyMD5WbQMv80sQVTXmIS2U6w60EXQTW4G1hLISlVHGZ3H8bMc+uGn155fF6m6gM04kMmVs9z6ryFMMJSmI9N6KDprBOXTSAu+Y4UjrNw7fcoYOSpyAHgO7F9ZhsxGs4TnZFfcTStlLOYBujTbRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNtAOBC3aUw8TNLgI4GIzbD8jxcV4QRv6CXfrsJeh8Q=;
 b=i3OgaSXHEqiqGoY60SSkKirCKIO0jvqGg7u94gS0CqLONEeI+49YRFLAELqdP3UXNdDxaCefEQnflDljQKMWsvu8LzIeN4xzRSrRCFzzxGXG2CnfesuIONxL0JYOL5vCE+2rRMVUx7MIf7BiWVzenBMFwpbktFqmlM2KCHxQSQD+tYKSBf7wC4AhOW/zRO8xFAdA2keH2L+GD4ngDVM5cd56cTGCL7liNOq5xtmi43OBWS3dLyS9uh08PPoGeIp1YbEMrZkyOWyeDzJ/a/93GwlHwrowILeDIj+s8UxZ4yiGRXyQkm5JnAd6MpkbhE8h78yqvpZYEq7KlYosIn5CIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNtAOBC3aUw8TNLgI4GIzbD8jxcV4QRv6CXfrsJeh8Q=;
 b=gXEYhmkrjvk3T5/kiEDpsw4UL15YC6T4101E/f8vaAgP8xk7380/JKUOkiUAjynUWuzZTWH/ktLA7ppg5OUYuFghezELeKDzoiDXTU+ymAIL8h+GPL2QaeYMpMtSjgQg6ogACBiWpapIuAt/nf+DMa/f3ZXwPX347Drf8MzLYH4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:52:02 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:52:02 +0000
Date:   Thu, 20 Aug 2020 15:38:16 +0800
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
Subject: [PATCH 09/12] regulator: pwm: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153816.5f64bd0e@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:51:59 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f664a77e-fdf2-4598-0474-08d844ddec74
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4563321E4B75C8F6FCA8322BED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/XqH51IPVQItCmHnFwwhXHwzphOAuyDgX5bMXtey1oRMZxxtlKPV/q660ZzjnqDPL6fCsUuEKYl2ORq6azibbN+yxpo9FtVs3089ym86XVvlU/3qDc7DVL+p6Nnd3SVSs+bhp23u7X+53BIygpAPIHgV2DrCEdB8hmQZLdjJUkagLigdtFIybLmNTEuKSkMtMJcgSidvYCXts2hbbmJ/CA29To4U3BH7sKlgn3LyCsfMhW+ZO9lghHchTyHp7kHLGcly7pYtk5q7jJY1EBZzos1ji8QRKTvUXJtoCGhVZZV1J/jyyi/FOGMhwB/TAad9KI2JpwUJVDSfd4u61UiBhgZqmE3FQzSglzSomNWL2itwSmw64iUC0HeJYyFLN6q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: abaGsiNSvE7whFO2We9VMFdZfGDpGCPYOf9OiV3stxDDcKfD1PAAvhZN1u2UcPXrr+2wSpSxDTv96m93rV2tCWi2/MTItd0iB/rZBzQt0IVbE+USj9EzEQIRYDtgB+6bYb+w27M7/9yiMiLgbC0JobNyp2RrcR56U2u1bl6fLDRtmhf98xj0RWBpOIT04Z0cIEnyzAjt3icc46IDbvCIu4Q8C2VsSa6BP/eXJShq9AI/Ljm2k1cinok0qEg3RHdM3Ci7S8qHhvXYXfsbeZdpjmg6vBzNkPfsvLjD0ojwrTiF/g5HDrsxSqHf8JRS6brNykUMOJbWXXy6ylTTawqMErQU/Z9IxspPA+1hqff2xHl0VSYMV2x2l7AFz+1wAN2Gn1T5Zs6dTdF6tNZMrOxe7nN7a9icw9KHH2WontEizkhfp0a1PzpxxHmXzTyNqwvpcBZcXXpNCOQZB7xXYjHSmdO3VJcoTF04W1YWztVD4VJs1TfPeH9Zc7siBxjskNL3c702HqhJdNaJa6V4E29LnmpKinICTdY69+G5C1LTAc4hd4ul2EKt6x6yKatDQS1go2GnuJETgbeNKTivyrIycngMesyes+ul6zL09UnkRI15QICb4ezxaouUBOo3HWZXuqCYPNMope1eThjzO28slw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f664a77e-fdf2-4598-0474-08d844ddec74
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:52:02.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiyW2059+gRGwUdSRFmJ5p/7LKxlB+900+eIHOT6NTqZJ24+nXC8Ng/DrRS8mNSpriaEiSe7yg7TcXsIXClzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/pwm-regulator.c:393:34: warning: =E2=80=98pwm_of_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
  393 | static const struct of_device_id pwm_of_match[] =3D {
      |                                  ^~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/pwm-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regu=
lator.c
index 3234b118b53e..c00829bd5d7b 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -390,11 +390,13 @@ static int pwm_regulator_probe(struct platform_device=
 *pdev)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id pwm_of_match[] =3D {
 	{ .compatible =3D "pwm-regulator" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
+#endif
=20
 static struct platform_driver pwm_regulator_driver =3D {
 	.driver =3D {
--=20
2.28.0

