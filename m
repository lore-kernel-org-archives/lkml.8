Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C594C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41442077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j8Lj6DsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgGVIqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:46:16 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:64257
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbgGVIqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpS5M3H6kWHht2I0WtkOk+5SpDsslJ6dxdHvxL7ZMa4CVlMAiyKu8jOemyofdNAQaMqIdtbS8ATLYj2H0hvOeatPeeSOF3AQ+51+O483AZ7jI0/VeQ0gy0B3iloST7ha/9h1KBH20Y5YDJlQrhollY90iwisV3KSNtBQ69IrKJY7jjRQ1PNbWUvf7s5sfHNinJPO96Hyqhrd6yYC4D+jEc+6fFL9Jz+BkmjD4/v4gTbdzpeSwx3SQYF4oKE9ImLZjmpLmZ6RXb6FZ5VRFZ02QCjwFoHsssLqKhcWJhKxmoXi/dOpuvClmiqrLJa76hLpKs4YPHbotQoqbbyWWqrAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqjw8pnL2pA3STiUSuTPqk7faLrJfDAiBRz+2CnDzck=;
 b=X6gziyso7W2gSZkqvBpyg1Ib3SNnQYTGt+0yB1ZrMPALHzDbnGBOfRpIXf8Ej3Xrfqlxw+kbccR8fzlItNRif3zF2fnZmtKGqPjupBk4a9tMQp0X/JAClEkANORA3RKIBPGD2IMjGTAJZp6RQ/dpqosPdssC/bouMp0KJVyKAt/Po8JqOXAuCh6SswXVYuWK1uyvgQRmsO7R+WxBAq0b7SrOug2/8rX1D+LO4m8f/pG/lZDBV86oE0zcbZScGLE0+oUHJN1WO/p3y68MsUsr5az1/j+vKZtefqt1pa19HVibY3eydAp9MHqSxvnNgnfwxoIlViVa15SVK22TnO9w2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqjw8pnL2pA3STiUSuTPqk7faLrJfDAiBRz+2CnDzck=;
 b=j8Lj6DsAcLaI2JE4MAZo4KYOeTpGFEjclcuWnh2t9IwJ06H057dPUq0xd/XeYbH+Aux/tV4TXeBdDEyBH1Diug1XBTZmUH9T6Xb3T7Ko1jgPX9vyEvIsI2T88ipIAxc3kwrwdR8YHgN24tKxH8m+fHNO7P5GbwnwHcFVrh26W2E=
Received: from DB8PR04MB7162.eurprd04.prod.outlook.com (2603:10a6:10:12c::13)
 by DBBPR04MB6268.eurprd04.prod.outlook.com (2603:10a6:10:cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 08:46:13 +0000
Received: from DB8PR04MB7162.eurprd04.prod.outlook.com
 ([fe80::59f1:4502:9518:3404]) by DB8PR04MB7162.eurprd04.prod.outlook.com
 ([fe80::59f1:4502:9518:3404%9]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 08:46:13 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 3/7] usb: cdns3: convert to
 devm_platform_ioremap_resource_byname
Thread-Topic: [PATCH 3/7] usb: cdns3: convert to
 devm_platform_ioremap_resource_byname
Thread-Index: AQHWX/0cG9oxnTeJEkmy/Xf7kPi+jqkTSIRg
Date:   Wed, 22 Jul 2020 08:46:12 +0000
Message-ID: <DB8PR04MB71626E57AECABAA95C60E7F88B790@DB8PR04MB7162.eurprd04.prod.outlook.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
 <1595404275-8449-3-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1595404275-8449-3-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51a1df86-71bf-4306-ae18-08d82e1bb053
x-ms-traffictypediagnostic: DBBPR04MB6268:
x-microsoft-antispam-prvs: <DBBPR04MB62688F680F7E51C3C19218AF8B790@DBBPR04MB6268.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:279;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kof3+VmlNj9PFr2X5Ob4p9c1wq2LW6mQAhsHHzSglRDq+EchEkbCvcbFIShTSjyIBDxbfS3zVwqmfceoUFEcBXiLNJaCtxGhTVSKVE6joUZxm1DH0sjB+qfc/7cIBfCelWG6iUNUbntGOb2nvfTwmmWGNnw0Wnw0TndJUxt/2ekRJuXZQRRS9fPNppAAX9x93tgHVHpOE1DNRzEYqEbqXol4ze4B3ORpIERXBjQE/ctR2AAJiT2mYoNjYUOgc3dJG2joUFHe9aMmXvNFeJaNLu8QQubVjFp4QZS9w/64JgBt4XvNiMcctdK2NHKxjIoDiH2+vvtam45d0jKDSU9Bsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7162.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(7696005)(86362001)(186003)(26005)(4326008)(55016002)(71200400001)(52536014)(33656002)(8676002)(478600001)(4744005)(66556008)(66476007)(64756008)(66946007)(9686003)(66446008)(76116006)(110136005)(54906003)(8936002)(44832011)(83380400001)(2906002)(6506007)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CTAyguOHb/Dxp/miqgbuCq/ISITTwAp0D5wOS/jKvQnlcIMQzC1pVP3O8jp6NCySv7DzFQygXjd6nLULWf14PXAWhfMr0HUR+ZEiuZSU6SRezxMTUtSh2RyQWah1lUnRaO+DxegeN/JK0hRuMtNoB2sjjRPCzwlkg7PAOJez4qcp83c2yHnZWIjm0l0ZYWFgxkYb8UZZJGW5dypMs1EfNFZhYJajJ1is/SE5mRFpXnmytR22NTnipzTzH0CEk8QQeKbjVNw2ZKe2KuiCjBq1WEXevKsv+JJQUgeZwdzMfDRTRmXTSsFsYhklSZ7QdnQ9oDhKpfDd47dzKnTjw8MzSnVodqgrw2kDyj+RIZ6gu6ZeGwfIcHc4t9r2zlBosiSuCARdWVB51hHP9qzMGfX8T4Zal9MozBRpbbglEFV9WH4J37+nDYfOQu/R5SqgakXO3DomJGQJ+7/ZuVQNyWgLpMN83/EUflXqRzjrOEr7NKc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7162.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a1df86-71bf-4306-ae18-08d82e1bb053
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 08:46:12.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfS2D09FvxQJA1Y7uQq0Z+5ZjwfrSCCNTs6VzVKn7AWB65KSNA5kaNsbhg2cFy4P5ifNp/VSNFP+FC2L8oyIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Use devm_platform_ioremap_resource_byname() to simplify code
>=20
> Cc: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/cdns3/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c index
> 19bbb5b..24faf60 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -436,8 +436,7 @@ static int cdns3_probe(struct platform_device *pdev)
>  	if (cdns->dev_irq < 0)
>  		dev_err(dev, "couldn't get peripheral irq\n");
>=20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dev");
> -	regs =3D devm_ioremap_resource(dev, res);
> +	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
>  	cdns->dev_regs	=3D regs;
> --

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
