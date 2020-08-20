Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F1E2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="P1Mt5cG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHTIAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:00:38 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:56303
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbgHTIAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2Fr039mhkjv0h8qZyoDZAp06p4B+2KT5AehmeSQLBRGozRFW/vurLLEOJdKrt/5gr/3kVsm16UAFcGmmn6Nc2hRwasAKe4Jth84VNwTz0IBu1hJf9v5fEIBBUrJHkyXFNpznGZ2521y7Lys4RKWmJB3eTF6WIoN/78FikCqVhqippYa+MC3Our7MeZnezwPWx5VLUIV5f0gO5ougDwcbhCQdAp/sUsAfs3U2H2XzNubp61kCigJ0avzuEiWn5JAw1G+aRPNUS0XpKxaAYChO3SYQCb0ZUpHmR+zx2lJv8UUUQNFOPXsE5eB3Wg1+kNa6jN4O2hZKgFhWNviJmmSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEE/uf+lGN6v0rd4q1AgcaV70h711P2y/1/OScSbPjY=;
 b=djLWhHmfutmdGUY6XzTAov9RvO0MvnXWzj/yVTu8BmXeeVctO6DlvAllPQGPtiXsFuuVCn7YafBoJ7ScQ9kx6R5oqX18lVZlfXRR3tMe3LI2VWqFVD1hXw88DMnMADIVp9hh7EDu9wOrl+Sjtx1cK+EYOhNum5rBo8OMA7yeFXly16gz+uLshLsNKiU4PWJBD+iRt/Z8FtWu8DsTWstyiTP4zVXsW48iTq3iXM1TkX/0J/rUxfS4n9tSVGv/Yrhmo7Q0qgpxsHxd2CF67aWyd17A32jeEGJCcyfpe/R4A3SoEMD1G3VzSq42BymbTB4Rdn/CEgoJKATzt5gmeIIVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEE/uf+lGN6v0rd4q1AgcaV70h711P2y/1/OScSbPjY=;
 b=P1Mt5cG5TqJNkolzFgMkoGHrzuTvrt+f9G5/hDf1/+OhjVB8dHO3KWmgM/EtWALgzPeiyrLj4q2TOlugXl0HosT2rVB4e/FqQWPfQTAcAPxrNbYM73DcjChiZDkBxfguKEU+8pmblaVIyj9iDc7N5Jf3WOlOOgm4WwZvIgpBKmU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 08:00:33 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 08:00:33 +0000
Date:   Thu, 20 Aug 2020 16:00:10 +0800
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
Subject: [PATCH 10/12] regulator: stm32-pwr: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820155903.26c152b7@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by HK2PR04CA0082.apcprd04.prod.outlook.com (2603:1096:202:15::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 08:00:29 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd56ef4-ade7-46fd-e220-08d844df1cf4
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4563D642641C2CAEBD7D7B49ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCtfxuBy+q9q24BnXbwJuHnTz6vzpWu42shqLcJk7mvyR8YvPu5GFLPVaRvTjke8v86AWxGNuiuFl9gdzJ+LTSz3dwjXpBEqLiRD8PVTuppUbGK1vcP0OaA1R6YXm4E1szjJtR+o0FYeRNkhIp782vPHaFglPbfrxX9+Qiv73Mkf325qoOZ0X1PWESvYPcWDuKOcGhLeecD3lcMIqeZh6I4R1MSaJv6+b8UkYLu0fPGiaIhYuNaibjy8dxjCzf6hgFmcbxUztGOhgXDUbcOEgPU9xs9OQ6osgjHEEs5V9+4c7RGcslW1zCFLVQGU1bDeJJwH6WqD9/DGCmy573g/qAK5gxuSj8BA+ahsFzuyycrIl3eZcnHIuj+0iHLIzL4D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ySUn+f6tExyRX/6bY/1uU6UIDG0xwcdWzTOGKUR60/YGB0pZIGaf+7qT4ponQ4imirzzoynYK2BoD0dsQAlZ+vx0fT89R83l125uW7gH2V7TqREujhxVfT0zCr8BXDv10R0PuNzj4H+eRllOIvi9yoeY/pUYH2dhRNM+EjR17MZJQ1MjwBE2enRu4A+qr37Z3yXzagP23NyRJpC8mSDlDm5l0u5q2OLNCudqKqyd2/NNz6xF8GN+5x72+EyZYw+yYbLi0rcn3hLH8/c+0pBnLzOAQh9FxFlt98nhfCyuzNorZAVPThA4NZSL23iaov8aK+JwYy5W7MKZhxKxeElJ6XdFIUmPDkR37SC5vITcnCpTPCQbYnGc1c8lJiHJPCSUc4W3k1oH69+ty8mMqQzo76QPddRTNAwesTUlgA3BvNGMBJ5Rp5tDUIueCNxwLsM+X7CYxFLbHKsJlolXp3D+tJd9kidypmIiVvDRiZAN54Zog1nTKPjKR1T68Tb8zAsfsX0o5b0Hx0szUEadSMKE9j4lE6kMSe1pGuYK0xCxyHF9ueIDUqLduQ46fWc3bJ8J75yy2BitBbSXApuTk5kMkdqPo9StnVv5ULZexkTq+yyWPrz5AJcl7uy6QsngXvUJGBoMo3q3aUkWDmDfJaIA/A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd56ef4-ade7-46fd-e220-08d844df1cf4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 08:00:33.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vzWRZCaCqE2P7PQNcmsWXAy38Tb5k1O0EB18+dOYYu3BhbolcmzVp70R5ONfcssS+VeayG0iK7Tu4C2/ajmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/stm32-pwr.c:169:34: warning: =E2=80=98stm32_pwr_of_match=
=E2=80=99 defined but not used [-Wunused-const-variable=3D]
  169 | static const struct of_device_id stm32_pwr_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/stm32-pwr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index e0e627b0106e..3d5cd954c391 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -166,11 +166,13 @@ static int stm32_pwr_regulator_probe(struct platform_=
device *pdev)
 	return ret;
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id stm32_pwr_of_match[] =3D {
 	{ .compatible =3D "st,stm32mp1,pwr-reg", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_pwr_of_match);
+#endif
=20
 static struct platform_driver stm32_pwr_driver =3D {
 	.probe =3D stm32_pwr_regulator_probe,
--=20
2.28.0

