Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A624C2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="leOQQCQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHTHyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:54:04 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:39137
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbgHTHx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG9f9cE0u1sQCD7+niTvpJnC1WFP627UBRWRHK9OAB/8mSxmAKGnCyriB9URqBH2vCwDF6TQIeHfoQKaj9PXxWRl0tp5WiB8ku6PulMOl/N7vmxlnMMBLss2BLX8+dBDY2Vo+TkaphVdlQAes1xv/d1fQmCg9toxrlFkmqYjlqWUakozb7fvrqlJ73MwQSYcc3NGJOduAp9QLyKfh5NY8oV8oKe7ah1k2yrJZ9waHLTM08c0Y8BrdNUphcfCdAyJDkjm0/GiRPaR0T9NA7e6GhHoiZBxUxTSQbJmmFv4xoO0/ktEpM2SGd+F01FRlbAPSuqyQEPYO8r1bY/v6wjY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idRfbtuXcxttm8DJ5dwgdNnWSAjl1gQN3akJ3AMtUuE=;
 b=M9ghDbJo1xRVl5ZXWZxhFPklNdoosf1ILes6c9qis7tNJBFr2WKUy7ntO3KCrOuodukTCQMxZpgbiDzRDHd7th0xAKwOY4WiDQqWJ5fh4JG7at+oyyi2NBjhaYJlh2krebbo8Y7YCcIOLXbkAateBaIJyAH2CHPH1FUPGwHMBPLlNhQwqelosW1jG5SK+ITfEXmZKkS4pzjbyDyNzXL404Mhrndb69KbVKQ6Mnb8+rq3zDbDcXpzyG3OD11aN/cePb+st1WIhctK9NPOERfmQ9KjDTgt152CRdJFnZ/0PKbxmckmv9DDR2KuYniQXNcEivjt5ZiQtXP8nD8WOOfDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idRfbtuXcxttm8DJ5dwgdNnWSAjl1gQN3akJ3AMtUuE=;
 b=leOQQCQXkNP5S5fbHy/CI4IQUjpMYLGpL1/iqqfhfzil8Vp+b/BQ/UeNZ7Va3IYmazEq6vvNCrkuZHI5/YVKn83t1TtAyIiYMGxWyfkrbje1dJEq+G7LR2KU/rYhV3zTWK0LymFVicVhPnh8+K/2Jxh1aMtusDStTOIrfKSbZ04=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:53:56 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:53:56 +0000
Date:   Thu, 20 Aug 2020 15:32:13 +0800
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
Subject: [PATCH 01/12] regulator: 88pg86x: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153213.4d9a9666@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:53:53 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be45bb7-77c4-4657-52d0-08d844de30ac
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4563E87A49C0DB997BB1E253ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY6kj9JjzEglhivnKaFa/6ijaAei0xoddw0Ru/QDWQmwd+YD2cf8B4/3NBnut7Fzf6Zdkeq9Y3h48kd6myS0d+CMUPW/a8slTmISQeNJWcDLl03W69lISR1cfIJ2gWdFFYikdVfNCg+YYx3h4f/rZilctCcJHvD7aHcnI9/RRiirOPIp7IgQl5fkhPcpjhQyPFQfgzhwV8Qosvg/H92jL7iSfuHY1tMM+H6wtDwdG9/lqgnAWmFWx3jEbhhx+RYgAv2tlQeWQcyVxY8G5JT8mczmXHqCU7Mp3KRzDwjBN5XznV0QVZktRYaCmEks2mbdtwX1FcpzC3Yufoui7SLrVWkby6esCmoqXAkDQT6sNGEO/MBrR0FxKjCgiXrX5XOc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RQeSPSspgDrpaiAbdpqLngAeM9m2qJZls/RLow5DK/tsIfSgesYsIN7RXNYJrPmtCMEpIQLYups4qd0Nvl/CLN2s3H393wriCuuoCZnihuc4oqlabg5nE4Pix4bLavgxuSmdbT1nDDj5aj9++E4jb8EgC4i9P/U+3QtxloSacSnWkhEUezSG6qzDgkBGYJiiWhqQy+K83iywsD+jhp2L7ZxIsXyJIb/sYRcnMWJqId2+HlcB5JhvGsD4PnMOIHvCfPfg/uyYl3m2Dcw0GwTXXh3Kt1X+ByEMgue5c5Wte3kk/7WCDlqmeyYLMcbF+c7n2VrSEARWMtBIaQ0mkMhZKViMuMUR0Bw36HQyaEq6wY9ck+T66+sscuNRXZQ4m+uKiH1c6iSA1YtxeQasaGAXc9pxo46y8hqIUiEUFLLtzkPQ6mF9uQggKO5aFRJJ8p8qv4FeY9VDTrJaTdMZR+Q73baNUAYVRUIfr8OrJfNMyzhqznnsMb1mrJoSXZ7dd0LgpSOLa68kPyn/lQHEzC5JIzrqdSwd39oqYj7LlS1i6SGLom791BspXaaiqlJwJOVUdLJpvMdNy+8LKRbGxfBxPlGlMBMAMA7EbkLLzLfrIkXAb7cXn1xJEH2+89Fdq/4nvWKHzwlnYuWJqjL0uSFZew==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be45bb7-77c4-4657-52d0-08d844de30ac
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:53:56.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kgok1vVjyRMINm3D6AY/jwYNGuZT8fWj9hU96JgPu2r5kpd8g1TAgLJPdXy7N+GpKeBK327JGJmh+aQQLket6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/88pg86x.c:87:34: warning: =E2=80=98pg86x_dt_ids=E2=80=99 =
defined but not used [-Wunused-const-variable=3D]
87 | static const struct of_device_id pg86x_dt_ids [] =3D {
   |                                  ^~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/88pg86x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/88pg86x.c b/drivers/regulator/88pg86x.c
index 71cfa2c5de5e..c47c14d190f5 100644
--- a/drivers/regulator/88pg86x.c
+++ b/drivers/regulator/88pg86x.c
@@ -84,12 +84,14 @@ static int pg86x_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id pg86x_dt_ids [] =3D {
 	{ .compatible =3D "marvell,88pg867" },
 	{ .compatible =3D "marvell,88pg868" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pg86x_dt_ids);
+#endif
=20
 static const struct i2c_device_id pg86x_i2c_id[] =3D {
 	{ "88pg867", },
--=20
2.28.0

