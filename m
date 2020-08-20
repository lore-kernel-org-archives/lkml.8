Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB98220658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="TJf2C65v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHTHzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:55:38 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:32960
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbgHTHze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:55:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsNOZw3eItSyeWBMEc3tfat2Ihd3G85n7L1TZXH6/ophHx2EootJD/jZ2jCob/slfn+dBXxXNWBJ1TRDFDea+t7CYbZGBtgFpr5DjigXEXMUpq7Fq5jwuAloWH3WEuhp6Gb8CGlgbsq/3zkj04MYaZYIpsgl6MWbKwh/Xa64qEkQ1r1yeTJsBudYkVdpbVNwIh2RCtXm/xN5HwnHyM4HmQ09mFsmfvkCcbd8p90+m8hJw+1gfO4jSIwehzUOeemqpkkTUwFDRwTDOCkLYh23KzhF3onuVRn1jT/w4E11joSs38zszKi7aaN1zSFCuFfMgNDSs5mdmKcs7seblFjlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kanzZz1aFkEpsO38Xf9fvG+FLxN0hTM8qu+uLoFHXI=;
 b=JVu+H4zEOb3thscMklQgpYcsGYRdx0JWpTvXTHEi60jyiBSVnDWX03BEYPd/vY6V8YcsZuJTXJ3peJjv/MEP+iNz6bEt0ySA/7CF7MbMi477AGVYyXkYp4aIn1ZWzXsuCl7dPB+O/DXmGIOLsZuBUNczyQTyn2ZgGRmoKmKLFPf3o95UOYhi2X4XgtcQmoIexCfihfmo9/jpOx03uHweSvWFvQ5T3ci9Yea90waPilGQgnZrFxg+HMt7u/0Cbp5gyen1sn40xbsV88MeSgAtrJTWD4z40VDFlpVCg0IDEZbPbQUSYsRSCYob+n7HXk2W549mgeICtOIUkfC2x1QL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kanzZz1aFkEpsO38Xf9fvG+FLxN0hTM8qu+uLoFHXI=;
 b=TJf2C65va6FweqIWsZAf8VGJaysW8bNYB2eu4wJWJiM773weLwGaUxTUae1tLFgEroWy+1uixJxZKOr7sxH8om27n9ZvPmj9pQShj4OZmo/0mWB+vQq7MA/m+V5eLkMlDDVnw94TYtrG63Cmx9hbRjABIAHwOiDfES4hW/Z23mE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4563.namprd03.prod.outlook.com (2603:10b6:408:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 07:55:32 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:55:32 +0000
Date:   Thu, 20 Aug 2020 15:46:26 +0800
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
Subject: [PATCH 11/12] regulator: stm32-vrefbuf: Fix W=1 build warning when
 CONFIG_OF=n
Message-ID: <20200820154626.79d83157@xhacker.debian>
In-Reply-To: <20200820152926.42c48840@xhacker.debian>
References: <20200820152926.42c48840@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:55:29 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f47b96f-e2d9-496e-71e6-08d844de69ee
X-MS-TrafficTypeDiagnostic: BN7PR03MB4563:
X-Microsoft-Antispam-PRVS: <BN7PR03MB456332EB3C4BBFD20C13CD7BED5A0@BN7PR03MB4563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SL3fq435P5DMu+vnDOPIHovKEtBUHiJDf8MHuDIvU54BzNMr8wXvRzeTDoFnwasQQAe8bklSDHniZyBH/IxieuXgKyfAVmq8JJnpMZFeLdcnFgW//a10Bxp1HNh+G0VmZnG/YSWcq54C2P+y5cSn7N/+E8+umJJ0RHMtXbb75WeFc2pG3fkFeNO04CiSy07LO7kPjAnbf+q+FfCc7+t8XZyAlEwPytSgaqhF7VXKLwsNDm2L3qfxuaMltp7C1Cq+uHDW7N2a/088+sUaHFCNSsElSUFo+D9vSRYI/ZIP6S+nxQxik+fqMEq0a7+d73le7Z8UMVtGIjv8uPdIONXnzx54hicdpnqYgf7uV7lEIPeICG+ltw9gTjUCojLfyJoD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(1076003)(4744005)(4326008)(2906002)(5660300002)(6666004)(478600001)(956004)(9686003)(83380400001)(26005)(316002)(86362001)(52116002)(8676002)(66946007)(16576012)(66556008)(6486002)(110011004)(8936002)(66476007)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TN+waXo8hfC7kS4ggs5cd7Yq8P74Wx2QMm0LF6pcStDx1v6sAQ/znKWIkoLnM712ulCf8iMq6k0DcCZCepS10S9CoOPGteAKYb2EbOb9iHmOsnU+0/cOoTpBLtuPR16g+Dq4eeZ9CuIHEo9u3fkiLFAlL40c5mDm9FRPztQeOVxN0PwzSNj6BSfeS9IN50W/PNr0IjSDxaeTxD1CByDV0ddnEG4u7JsPbi9QicLwL3mANuKSsIZjnm75IckIl3mLWM2YSdqjA1EOShlk9tQWSAWSh6Vmg1ATwQx5rIPvmUFthSkLOKsAr1N/ImaH/4xKMxKg7mbjyL1NaVxmkWuwjrVhOUBpqWYC5Wm68CVmvlEPsNUEOsAXrfZX5HmN6PYHfebUhnVvAJ8e8WofB/L/xE+DFGhLv5HtYe4VPc0j4noetmvhRg+nYRlZhaPgyn4e5RyuYhOqnSa09bHfl24vhX7DZUbVwON7lkrdsbO8EgXnY9cN9yr8xbEJE+D2h8eZZL+CeSgb7rmnpXf5bGrKktah5Py2zag7SqiL6BYF9m/QHAcAUYppf0HRtbsMutABCPhsUy+J+2Gzcafu0O+2HCzG44tfIk3mXc/AHOOwPS2/spkKyXFX2sC15cmopOnL2STjoJCYyq8kAT1wh1SUCA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f47b96f-e2d9-496e-71e6-08d844de69ee
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:55:32.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL/OqZ6p8gsW/yfyey4RFu5tQhBwlv+Na5IAL8KzM+ggjFjN0TCFy/YCg4fAk/ak1CtVcHMiISq3mA7RVlSX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning when CONFIG_OF=3Dn:

drivers/regulator/stm32-vrefbuf.c:287:34: warning: =E2=80=98stm32_vrefbuf_o=
f_match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
  287 | static const struct of_device_id stm32_vrefbuf_of_match[] =3D {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/stm32-vrefbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vr=
efbuf.c
index 992bc18101ef..5a5c12d9ea22 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -284,11 +284,13 @@ static const struct dev_pm_ops stm32_vrefbuf_pm_ops =
=3D {
 			   NULL)
 };
=20
+#ifdef CONFIG_OF
 static const struct of_device_id stm32_vrefbuf_of_match[] =3D {
 	{ .compatible =3D "st,stm32-vrefbuf", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_vrefbuf_of_match);
+#endif
=20
 static struct platform_driver stm32_vrefbuf_driver =3D {
 	.probe =3D stm32_vrefbuf_probe,
--=20
2.28.0

