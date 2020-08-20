Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97B3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E24B21744
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ZkEU/HJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHTHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:51:47 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:39649
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTHvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:51:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRtKnEHC3Iv2dI96XoqRGArxUw/mxXMQvlCe3sDJVRHgKYeyGUdyuE51q7iPy+/54EIe2RFrlRU+st2rA18ttoSq2i7pwheXhC0Nxcy1r5fJHuaCW5V3T8wZy/R3KXY7y/BXtVeaF8RAFD+faLkk8pWNLkA6X/3KBlsXiyV+JBDWcBoEj5a/4AnL2GUafMmNmRn8gbipsb1WtEiA3R12XgzyHN9LxmFNt9GWz4R6zRIQ+ukTnalDyhum7b0umFsXDZ+B6VGqbwQU1EJhz7Pq5Z2yprDS9//j7OwjUrGli5hhtNA1iUABrvY2pZ/+ANpBS+MMV+E9OJYAFUjzLvj+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B2/JNzCKZKLjBhv6F3rxJW1sECk3G2yv+iD/ySGx/o=;
 b=Lf6C97bePYPcDh0+IymfXLxHiYEF6FiDcpMF92tounc+yHWk7/DLLvYL8FkHE5msTH2DFeOo2TD1V39SPyzPdfBLc3kazgH3d0/yrr3SaM6qtcnkDhjMCbne/yH1TFGn1IRFA0M7BHMZKV/g55J6XXzqM1Lv3VS0Pol359FrpS3CTqz0o1MS0WiOAyEiF4yxl5KcEtmFBSN4ren2kpFdT1GKNKMFFXjR9PS/tykqxg6wynYMhXI2DpMiIogRgwfTLUDtwv3sh4t3dlac1Tx2BVvGElx1isCkU3G2ui8knqtZJsRjzT/Ig9BVlYQOvkfA96Bet8e+DZe8BqqFpxjhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B2/JNzCKZKLjBhv6F3rxJW1sECk3G2yv+iD/ySGx/o=;
 b=ZkEU/HJdmu6TxXcvMFD1K3u4ow+4t7pmlNSoVcyuUFXVm35563KeCjffYDvPpgVpXBg/HB5LzYCI96NrNihdPDA1G2navuhZOmV1rgvwqCQ7SZ4uaJzEYK6Mt7VJ21gXRdAIWcgGUkRcKVT32KMpyh8mXnAf3quVDpPIn6bSAro=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4834.namprd03.prod.outlook.com (2603:10b6:408:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 07:51:43 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:51:42 +0000
Date:   Thu, 20 Aug 2020 15:34:10 +0800
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
Subject: [PATCH 03/12] regulator: fan53555: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153410.498aa9d3@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:51:39 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9458ca1-456f-4953-1bed-08d844dde0c2
X-MS-TrafficTypeDiagnostic: BN8PR03MB4834:
X-Microsoft-Antispam-PRVS: <BN8PR03MB483469D92A3FE545BE5DD9E8ED5A0@BN8PR03MB4834.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6JXlAfTs0hl4HgJuoMucnY6VsLCO5WWyJ0Lm0p1/qpzqbUi2I/Q2o9vmpoERCJt6zZ0O3EDKtpxqUD8BigJdubArMZxgTdv7nIo0T/rTnXu3/U86yjF4UGOwPdZykXHNU8qQcoKLymYoOyeTVNFktwMdZdYzb1biVcCkP/03SHq8f//hgQ994OtPqjkoeXFDPE69y9iLMPvH2utL0foKDiccH29ElTxRhBnWYjQuIXlml6DPdQtKmTS7XoA3nfJY3odbh4MsiWKpDXrMJTWkkHpRcfP5s+5ACy72q1rPW8jVAMYrECum5OLY+H90OyAo156vvJZH5zhlBPmYiuzqsYaIArGqpk0gYg52bfDS7YdYfI5CtyWQyZjo1G8pPzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(478600001)(956004)(5660300002)(186003)(1076003)(8936002)(8676002)(9686003)(2906002)(66946007)(66556008)(66476007)(6666004)(4326008)(16576012)(110011004)(4744005)(316002)(52116002)(83380400001)(26005)(6486002)(86362001)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mdvqFX6mYF99jP1RtZ7kfAFD4Tr4HelpiZFAf3VWzu9HXsitIxVc38CVfBD070mXRZt5yjy678Nr8e+5AmmvWZnLd8mIGVilwiCe67qgXvJJLVlTm4TXVBqzinBbpRTfE14zVGUFdoS0tUDTquV4otD+ywFHeQlU+oBwlNcPWSCxQ4Lb0MQmukVc5sc+rQNni5CpIT2lLQmkbPa8m/Xy5sYmA8S0kcW5UdBWmoLhaViCDbMEe3heKb1IlTeWfFzaFOjgVRBvedGjc3rOhcyRAiaqXcjhCVEtW5UVDMctl3KkqCzdNg2+47SQKnqsJBVFl1gCi5xtdPPVt/OZC7rJH6BcBS6b9AQBf5RVM69u7UQgNJGemJI1zzgGkAY4ffhE/Nsa2vnshJX+SZwMtTha35g6zNdQXnQEuL1SBNzeiTGbq3PW0DoOdQmVgVgXOY1UvUWsC4IlqR1pptsWLrpE6KvIkMRdGOqFQLsX8JTCzj1pgDmNvcSOKuqfKAJv5k9N8Lguzm8t4V2ZkBY52lxYjv1C1jctOwFMGVIdUArG0kqd3HsgTFJMA+KC1OQTxrSphKFM0OEthdeZqcnxXAuWA3FujzqKtMHnUg3iEzghZlhBDMDYsC7KmPZemu/O0tx4aQi3Ndw1w4ckaTs+fmEEaw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9458ca1-456f-4953-1bed-08d844dde0c2
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:51:42.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHSkNnhI99pmFWOCK2dvsJx1tIMZXzNzf1MEHFmzeCex9L2h/iULGdKlGX4NSIMo4AUTp5ACqXMm3Hq+bA8b+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/fan53555.c:439:34: warning: =E2=80=98fan53555_dt_ids=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
  439 | static const struct of_device_id fan53555_dt_ids[] =3D {
      |                                  ^~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/fan53555.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 00c83492f774..387c53f387ba 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -436,6 +436,7 @@ static struct fan53555_platform_data *fan53555_parse_dt=
(struct device *dev,
 	return pdata;
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id fan53555_dt_ids[] =3D {
 	{
 		.compatible =3D "fcs,fan53526",
@@ -453,6 +454,7 @@ static const struct of_device_id fan53555_dt_ids[] =3D =
{
 	{ }
 };
 MODULE_DEVICE_TABLE(of, fan53555_dt_ids);
+#endif
=20
 static int fan53555_regulator_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
--=20
2.28.0

