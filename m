Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5DF2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="j+oSdNVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHTHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:52:15 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:45647
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbgHTHwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:52:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEvax3OKoJTWma7pjLdCrjEV6VveqbSp8ReDXCGdxL7RkxTcN4PnLdMA7w3nyZcuwfVhgmhqqloNtUAxVT8zq1N0uEWZFoFPRS4FasSorRzDcT55zaN2B6fU0Am5G1XOzkQ1/wsaZTvaLmMsdaalsvQvL6qS1tgl1JkRNDoa5uNI+qytQCHTTj4G6qHr2z9pbnS6ORPjcLqevI9bxgzJqMd2SGNYVsfXw0k9R3DdtPIm82xyBm4Tu3MmXUhdCSBYPonvL0NSp+PCb0D3jM0Iv/X8YZY6lJCdha6J41lvKDt24IiDFpRpxAv23cr/728q5bDqfpk1cf+AKiB/vfmT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf9elrSMrynWeCwBNS4UstmD+7omgZ5RHNj2u7wXjT8=;
 b=ExAa6jS9qS579gDg/61/ChrjVVR+XChcT1R9+r5hHH+r57jIkBpBPWalsQGegqnrWV+su0ZEBqEKyAPgf2AS+izRdVjFSxDg59Qa5O8SldIYz8WunEg3BnGcWm+gVhBEzbZve06yvsjHD8xoU6zc1X8MQRI8rNzdHE30SQ9yTJ/bLfmyKNcgLDqCbMIPHtpNjVJSNfqdqxVxYuay3bPzCiRpGROUb/N2xLFfZ9XwLOxKFBZHtOoH/BOjs50gMGg04G55eIj9m28Si2V0Vs1NWYTvSoOxMlk/u+EGYUcNSLptapLEOle359p2ipWnS6zfRZp+FZXyhZvMfehv8G44MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf9elrSMrynWeCwBNS4UstmD+7omgZ5RHNj2u7wXjT8=;
 b=j+oSdNVPLrtSgLY6misxjuOJ6UjayAp78mtIGcbL0Dl/gH8kroKKnC0mldi7M+Tuo9RX69qmkb2sVi80+lk/xl6G+NSEa6BCnLnVxWhHPqH6oQEQ31O6DW/Ujv3xuZi3w7XzKC+r9XFDwxYpg2bQgsd8LWQJE+MVJq+9sxCA9YU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:52:09 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:52:09 +0000
Date:   Thu, 20 Aug 2020 15:33:26 +0800
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
Subject: [PATCH 02/12] regulator: da9210: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153326.4dc2eaa5@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:52:05 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad55c1e-41c3-4b62-5b7a-08d844ddf0a1
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB45632985AB0717FC4EEF3D80ED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5expQg5fpK3C9cZWhhtaQwcbguhjTYvt2pe3RmmXoN/8znE/gRN7lfzQBg4KCtFhyVjcJUIsuv1HJ9txOKTQcoQeHOOawJFR+GLQRw7TPu7hvWvQiK0eZ5+GMfVX7nqU1X6RydLnQYn4gLnXaisIB96zxO8YQqvP7nDXw3YnjYNQrPkKkT1/oUGvfbLvQ7cbkrM1KWcH6BCBVHWmF88uNYNxwCtHgI9iQtf5OVFQKsa9Jj6rZh+6LpYETe1Wn8KftUqSMb3guuzUgVW79aS522XMicY83vYB6nq+aXX4JyiF7uIlOTPklug+ka6jXkRKoT/P6ouIwuugg8BI6Sp57QO6IScjOyDVhC6zzxYVPw/CI/zpoL5H/Yx5hayi+RLJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: k/Znn0rBnP/azwhf0RXfIqIsf9arQ6mV0//KGYY77Gj/1u4rYSTCqIYYFAtHDqd9qmtZgT8XVAHhfO+OoZl3TwIhxKOjx0w3c6dRS0toAJ1gJZ9QtFLyLjNEgVoZcXIHFbntMqXOxot6FjwX2nKgf0a/XanSyR/VUJpxIJfB8Udmh0tpGfHqQDQ+k2QA9SnT0eqioaNKS5fcNxE8rsgp1lteay2ztYof9QH53F6A5BWRUHr1Nb746uHwnj6gzo1rovD2a6yN95N79iJzxfn9tMiGHQdJRN3N64GwyUT5Zq0AO9jiQV2prJ8THL0ZEqrOoqNIFj9mt11UKW2CSdKnxHejkzzrOrpe0mG7/X6/TWEG/R5Q8palvjd5VS+P8rzlEAee1cyfw4+FaN4wvTVIgZ3Upfgc3flqPB5gAh2CZIoToFV1gy6rT6gGFujY5prGaFUx5UmqptbszS3184dIgGFOBVoO0VUhP+baE/b6ep2tlw2YTq5Ap3QbQ83UY4cX0GSxMqQ13o7hcGQUXlkZyhfc8DB4Z0YtGPZgk3A2pQX6ykK1UpE1BSZSVneaZjJBym98CH4nLe6T/FPsslr3yQVjVw7kX3Hk3uO94KpoSogVp746dn2EJHy06bGB9mfdX6vTl0yZG7IlhwRiTOskfg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad55c1e-41c3-4b62-5b7a-08d844ddf0a1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:52:09.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzsXlWIZBN/YNVPyjhzi4bjfdR2t+gAIvpDknmAbcJTM6L6e6u5ZlA8JSdMUtpWsmnuHBudNeELjDET4AIPh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/da9210-regulator.c:128:34: warning: =E2=80=98da9210_dt_id=
s=E2=80=99 defined but not used [-Wunused-const-variable=3D]
  128 | static const struct of_device_id da9210_dt_ids[] =3D {
      |                                  ^~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/da9210-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da921=
0-regulator.c
index 0cdeb6186529..219baed89ba5 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -125,11 +125,13 @@ static irqreturn_t da9210_irq_handler(int irq, void *=
data)
  * I2C driver interface functions
  */
=20
+#ifdef CONFIG_OF
 static const struct of_device_id da9210_dt_ids[] =3D {
 	{ .compatible =3D "dlg,da9210", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9210_dt_ids);
+#endif
=20
 static int da9210_i2c_probe(struct i2c_client *i2c)
 {
--=20
2.28.0

