Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE37207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FgNboaKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgETD1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:27:54 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:51715
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgETD1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJPzUfkc6TWkkftR6sVfjSRbBWPBXnE64H1A0dkYrEO5jCxydJ3+JDdwt8GkQ8DKkaxtTW2bcoGK8WTAq+BlZgCzRYWf837mjJ0+xUmfrweaviCyVg6YsUZV++3uQ5pYU7Sbf9wcJZ1I88hl0vXDBpYLNAfzZ6GeRbuzUOq4o4YjclMqMMbNAzydjhwXY50Aj9trfzd1d1sDA7D2MOUG9A5KmWC7qa81vZiuHOGhIQL8GlOQog1VR44JcjUw2EJyMbuKTAqu9z9kNRJSCrKi9Rzwj8Q2PzI1TR16HPlswW9UCkjK+t58k4sqfwwZDO5xa99CaxUoCiQQ4CnUNqmLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BkgKAThBVF8tSEp2mHeTU1JoVKUnKaO8cl0gJDsnnI=;
 b=C2xvk+BfLoXzZ6QA1mnPwSwY43/yEw9/MCoatuZkwnut+ondV21itdAt1EbLoUvuUFwWZ/qV5IbHGceJRJwR9zNVXKAC7XLHtOsaLKS888ueGAKEkK4Ct63MCyPu74THQGeozov0XXfUba0Em2kYZqMggmxB/AZRvEx0U/fogQTHE+msCm2+rqa81JRaQO3mBxuJFSgCnXtCBH16A4Qcgs5vP74z7Z+c0TM7hDkyczq4nomT801ovSvP4lq34eZL/DpWIbxtbGYD8ylRc3ciGOZ1YR76Og7ExPeQC/kN50R6kVaMN0fbz/39TtzL6vuR22VMiuZheDOoQm7TRQvx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BkgKAThBVF8tSEp2mHeTU1JoVKUnKaO8cl0gJDsnnI=;
 b=FgNboaKG2NA/E5VasTsJywyEdF5f4dOPlkNvAxW5yhS8CD/sV/mudpXaqxjCnWopz784qNacuAq9f1QyPdJU3Q34WgaLO48sd+bVa/SRtlSGRfRfOcHV4iIjtv4M4ZzEuBc7dYPEk5VWGT4IT8Bx/9djpyoozv8WwdQFWWqD49c=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2726.eurprd04.prod.outlook.com (2603:10a6:4:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 03:27:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 03:27:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mailbox: imx: Disable the clock on
 devm_mbox_controller_register() failure
Thread-Topic: [PATCH] mailbox: imx: Disable the clock on
 devm_mbox_controller_register() failure
Thread-Index: AQHWLlXFx6d57+barUeOxi2c3HgBpaiwUHEg
Date:   Wed, 20 May 2020 03:27:50 +0000
Message-ID: <DB6PR0402MB2760C33F17B6234DBDB560C188B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200520032246.12482-1-festevam@gmail.com>
In-Reply-To: <20200520032246.12482-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [221.225.35.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24fdc845-60f1-454e-93c8-08d7fc6dc688
x-ms-traffictypediagnostic: DB6PR0402MB2726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2726A0829044C7A3BD91857888B60@DB6PR0402MB2726.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHZpwYgosG0KisoAf2A0V5O8QiG+IJwTNfGJAYDkhc2SFHBMjDvouqVzJeBRKlJI5PteoIJniTmfKU+TxGBOUCKA1lt9BXH0szGrILzL8I7r3d//52yUktbc/gNOe/CfEB3pujSqOZah8xvtYOy56X/MmUoJi9SjOtYS51gLMcqcBSAZEhuMzOP59/3t94N460GBzpD1lWDfFPEc8SWmz79jGS6HC0fcwXIC4PNV6m21kk9RnecR0DtUmmnXXH/riVMIfC7jokBMzX89P3d68PETfcc9Sfr2R81XVxbK+lLiW3NN0Xxnnx5jLBmP9sqZERiwe0ZP7wIqSxtxRkxrhRdd4Jj8GwPRcZJcuwo8EV7JhybxvktBnGuNEQRnf9hu3dH+OsE83GtD0dPGcD6F/KWOBSk02fJP28lHumh7H8y20CYna8dlPoLFcWo8HNv1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(86362001)(66446008)(64756008)(66556008)(6506007)(66476007)(71200400001)(54906003)(66946007)(110136005)(8676002)(52536014)(44832011)(316002)(7696005)(8936002)(478600001)(55016002)(5660300002)(9686003)(2906002)(186003)(76116006)(15650500001)(33656002)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xRgWvoXr60k8Bm3ZBBxLxRhuGS0wOQ/BgpzOXJsT+kXMKNIz4R14qnQsv5HEPIbseH6atOTJ9YFxYJ8csgYbYZSJiR1Zp5vgfCAJlg3M0hw1uhIeGSc/45I72w8suhvz7JdV1QbFKxpkmkciriAWR2FZ8E+dP3h6ep0Kdb4GHdBVSimsUIck37lV6qgnhjGt871KTlz+yO0GU2ShxPxZ8NJQpF4rk3J/rp1lZ4evdJT4lCFSA44pSP2ZYs8w20odMl8SjeRMkzolrwGAbmCCdKQcVIIarNudUeB151NEJp+etPnGwCnSlBlBbl1ogAlLfanCyvuTAbNzk4TR6jUAMQMBFpU0uGHG1bJkclfTdJyLGcI3lRdumgT2k7beMqQfzUNKZwlYnjIUWC9GMPEY48xuW/iAr0p5j4JStzoOcchvUvL2D2JvsQzqbKJYQ1lJgZer/ygl4wL+vtrUKJEuEFVRRyQwFYb5foVfge5leoXBnUW1+bX2bQRjSKRDxMdK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fdc845-60f1-454e-93c8-08d7fc6dc688
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 03:27:50.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0thifexUU2DOLrVJi5bU6oeONybxAa8BbFPSWUuEEf7nRThD3WXtuenSItqYgNSYFlnLRxI7fZqImYU2OWf0Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] mailbox: imx: Disable the clock on
> devm_mbox_controller_register() failure
>=20
> devm_mbox_controller_register() may fail, and in the case of failure the
> priv->clk clock that was previously enabled, should be disabled.
>=20
> Fixes: 2bb7005696e2 ("mailbox: Add support for i.MX messaging unit")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/mailbox/imx-mailbox.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index 7906624a731c..3f7c4548c18f 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -508,7 +508,13 @@ static int imx_mu_probe(struct platform_device
> *pdev)
>=20
>  	platform_set_drvdata(pdev, priv);
>=20
> -	return devm_mbox_controller_register(dev, &priv->mbox);
> +	ret =3D devm_mbox_controller_register(dev, &priv->mbox);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>=20
>  static int imx_mu_remove(struct platform_device *pdev)
> --
> 2.17.1

