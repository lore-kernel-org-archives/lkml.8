Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C10DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5008A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="hbfQDW7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHTHz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:55:26 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:24237
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbgHTHzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBW0Qm/523wbbtMxI4KWgnwZmWElDfDIk4DAmAmn9l669E5lc3pz7nB8X4eyTnM1ix6D7NSblM8LWjdNMKXZ+GTR5TQj5IWLCzRhqdU28/eDrZShcz22c/sabSNV4c+0ZkgbgYvd7uLNYdZb4DkhZcrq6HO+I9EbkcNqN+IhWasXZ4+9P/BedJi+fmZfj1LzYcBhLWTkmz9MFGB+N2JGMMXIx0OaQZR+D2roaxYVD10GV2Bl7bRCb/gK9TTwA8w7JDr+ir3Rb9RGEbR9p8tObgGfbRip4qwRhKsSNCkttAUtwQLlkjR0/w2k3q+cmt576U4xaeAngQmbRF6W2635xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3zdwZEIEY3QYW7SGpQYmAMFrLLvTDP6gpCky+gDaWE=;
 b=Wg7gtw3Z7YilNOZQeAchoVAojKo4BbPxc+re0CQKzRid/3Wgq6SElGOYN4vq1Ql9XJRZw7Oaop7/jAaGmUTmHdag7fgfyTSYNJAgDAYfvxccpXCtTHgH/5Rtf6/G+vxfk7YRqPWP68cY2klX79EPc7ECSNmNDgjSp+bAN32KyZA+xOwRHMIWM7B+3cGS/+joAQRgANpPg0zm2W/N3V9oInGro1f8kAJfyjwTPp37HtUkB0j/mPH0zoCQCGg/Apu/g0ho667TcUOP/z3ip2h/Ac+LOkdASmnolMxFe2GeVp+OgyPDSt3vyhTcQHXpUkQEhZmU8qVcaL89lcXyki5Yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3zdwZEIEY3QYW7SGpQYmAMFrLLvTDP6gpCky+gDaWE=;
 b=hbfQDW7cck1d6pmGNKRxjX6twkLJG46OAs7MVO9RfFKOJDMSmbgjwU0BMqHiC6djT5W79FvfYQ5YtuoAweoi5O7Er03SU41Fgf5moHV6JCZsaznUX15NgEY7wdwV33XHOeO3pUPdJtuGNM/bijJwJiOmG5c5C7o0SNTJC1VVxz0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:55:20 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:55:20 +0000
Date:   Thu, 20 Aug 2020 15:37:00 +0800
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
Subject: [PATCH 07/12] regulator: max1586: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820153700.21be8ff4@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:55:17 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f4a4b4-d5d6-4990-5fbf-08d844de629a
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4563A9CE13267201B4AEB6FAED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9le9ZTYwdlgs7VKCacD0J7pDyRyw81FV+y3OA1OJGtlD1zwgHJ/HvLH6Kh1E6Nmivkbs59RglAzyQhBMeC+5ofxqkBYaoBycsCXzDrBOojt/XJ3sSZBgGfI9FBdAUN0Kkjm5XBo3geL1kN6rsjOepD40x8MDKnv+Xbop47CC+kchDADE6p6DtM5Oyrg3JsEo7R1i6R1GK9iK2qY8//EwuFVqoUO+zQzwfVa+7lWgIO7QVzxZ//iNia+TV2dAXJjndm3PmcotxB4A06uZgKAuGNrg4Y340IbH0wYa2rYBSWpeTq/QG+4KorVV7/SGD9hKo1HEr574mKOLLCOsIw285FTYdjiFnqO1ptqDs99/K49FvhiNFdNqP7JOL2iRsz7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UmCF4udFDTyQmvRodyyfDvvVOHlhVOIZhgPfZM2bg92dryaXfHc3e0s36YdP3FbCDhhhiE2D72kwojG1ZzCB/CPO6efXYJDEyCOafLEMW9THFe/Sct3/sxOHzdBmkQcMJD07Blyh8HYXodofqN3HQ4vM54zJBx0pTFti2kDq4EdGBIcsQJfD1ONIoFO9KNjXe/j0AfUWCD7WBcXfOn5eK7KDVoMDx2gG4SjDnIp0TScOET+ZPByu0KO7bHBxn79JhRFZF/knnJlOiKLqoaqsKAfAWOqMI1Y00rU8YaeZKhxQM2kFLPT+Idt+Dd23LiSeHX7+xatgVmfJROxsTaNMuyqWruf9VAwfezHUJO3wchtx/RdGfScdjx7ONfKme8RFkCb6iwMbp82lqEmERx+pRD1jmU47P8ySQnveB2PxJ9P0xTFxDeYSagcK5UUk0QBVLfn9m8/elGgXqJvOhH1ZMcpaE8xEMydPedrfcPzsEglUqfyy+G5/n6nYt8xq5dH58SMlFM7XpYNRZmyYdXalghTR69ZwakxVLim6p/RPLiGqibFZfpTe+HdKRoz2JaYrF3jga5KvaE21rvCtNOmraaj8Ok2/9QN+rnI0VTWWV8zgmf14P0XLKYW4CMyuFhbLwC7PqXY0uHExkkZb4NT1dA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f4a4b4-d5d6-4990-5fbf-08d844de629a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:55:20.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvrZsZjJnH3ozfg+uNQrEf/0de8fEhL4r0dglJg8DOBpuyzip1EKDDH6iOweL2sE0oCOq4sL+2ouS1pj9M9vWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/max1586.c:204:34: warning: =E2=80=98max1586_of_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
  204 | static const struct of_device_id max1586_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/max1586.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index f8941025780b..2ddcdd2908b1 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -201,11 +201,13 @@ static int of_get_max1586_platform_data(struct device=
 *dev,
 	return 0;
 }
=20
+#ifdef CONFIG_OF
 static const struct of_device_id max1586_of_match[] =3D {
 	{ .compatible =3D "maxim,max1586", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, max1586_of_match);
+#endif
=20
 static int max1586_pmic_probe(struct i2c_client *client,
 					const struct i2c_device_id *i2c_id)
--=20
2.28.0

