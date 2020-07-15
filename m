Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9161C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3AD2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="drnkV3RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGOAvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:51:54 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:25440
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbgGOAvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:51:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUNdbcrkS60dxT5ezp3HTia03r34AdzD8XFCLFFJTinulqdG3gwGpuXl9qK09gE3qvcqo7aLs2NM8FUHtKbevQWgoU0WlK4qo0OptYrspNx7nfTVTwx+EYde4fvxbdtXO/RmNuI8ZU7PTiH1QMeDehHXXp0wFWPPsW0w3GnAkQkr3DpsLDAeyf/yVIv2z+XICX/yWsldIo/L2wr9oo7GGJpsEB6FRXPI1viPcayqzcHMuR06HxWhoJ9/hsR5BwN/YOooBO7BgqvfgjTllCyj/YiTOUh7/9SuwwCdF8KZ/bOry0Ow8vIG8NQpCupgR+o+GNyhltoaQr/X4H++TwrGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R90C3VVeGyD+yL2cVWJyyC8wGY+fOCKcFkQLc0pNG9k=;
 b=OyxMSAam7pFIFa7PFytTUhfuo9KnsMa05KY+ZzP4FR5b1l1k/sztddIoeV1X0eGAGC41coNgQaY5/WcixLjbcxZVXkN8sNGfpudFLbFEH2aal2q9L6SNAmGt26qK7e+9qlw1QDUAufvoUFV7ycqnP7Q5gdRJ53p3iB9HzfzCOBuRVG8QNZI1FX+HdXZ5qYOM+DBb2PXMt481WoMxEGcXeT6VrqOR5G+whruCmxF9kOa2xqdV1OjBYWqhpGIy3ZGy5g1sBWoNrT7RJ+zMPSD7BWHC1AR8uIzA8JsMDiGWMTl5qB8rhn95W8pqizEgarM/FYjhrXESTMZShYtGrDLshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R90C3VVeGyD+yL2cVWJyyC8wGY+fOCKcFkQLc0pNG9k=;
 b=drnkV3RLlq+aMT0i8apA/w60MSe5mxj+EZxZhEdfu2dX5ORiCnFKWeM3f9UDnW5ka63+riUAdBRta2hUeKZL728cYSgc8kRRjLv8M+hcMLfIxOcAbC6pIQAFk49n8Ezq9rYAvuxNjutMYiLQKkXGxBmilSrvfKj6gDWjLkcqHKc=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5096.eurprd04.prod.outlook.com (2603:10a6:20b:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 00:51:49 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 00:51:49 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIPNKRf0OmdJ0GCrPpelAWmTKkHzuSg
Date:   Wed, 15 Jul 2020 00:51:49 +0000
Message-ID: <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
 <20200714151822.250783-2-philippe.schenker@toradex.com>
In-Reply-To: <20200714151822.250783-2-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [116.232.13.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efebfe8c-16af-4326-b422-08d8285941d7
x-ms-traffictypediagnostic: AM6PR04MB5096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB50960897CCEEB8A6D1A26EEF8B7E0@AM6PR04MB5096.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8nMhFFQPTbOWQ8q5cyPzp9h1xYf26FTFUrkyxPiy0y1J8j0UUWVI2V6bBlUOTmNetlnSdqaVOWs8iI71S/jL1Po9RFVHnTH8bH8gvl3RJwLuPaRLpuLk+aBcMpgLuDgTg+vhGwp50SiC1KbEQ9l8iaqm3PEKnrhWag9o6RoBu20e0S8if6umK4nhg74ONL/RmneRTgx31YMXu1/A5Prm5JoQyBh7Oow1DyEeLwsv9BYfCZf/+/0C5reZTSnLbQ2/Xix4h0aTuRniOcBtHkxtteUsv9rF6oxwal+HE7vQX6OyMQnGL9D/LNZZD+zG3wA1wDfiBjOVdHJtan9ZlA1VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(26005)(66946007)(52536014)(9686003)(66476007)(5660300002)(55016002)(64756008)(2906002)(66446008)(66556008)(316002)(8936002)(76116006)(186003)(8676002)(478600001)(54906003)(71200400001)(110136005)(4326008)(6506007)(7696005)(33656002)(83380400001)(44832011)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4lfS8ic6o+6a+J31Fw5S4oQsi2PkOPwsKU3Hju5hajF+uZqvfICitj3W4VGHBvr6MhGtDygf0FgPELIbSS/gZ2PPqDYcSHrJttuclnspdmvhCRNyBQu+lFyDZEXtnokdoIUk7Fh9MCXriKmQftbDXQ/6m8Hr3nCIIDO/nYp7wC2WSekv9JukIRtmul9UZeOzJOwIw5z/Zh07yjVVE630sHdwhBUi4vT5dAy90ImYuz1A28vM9OWFHnp336Bj5zZdQhkkqVEz0ECYYqofyogfoxj5VXK6TQr7jx78whRF1+O5p7dGEikNIfrbfcR5mzC6OaksR5lHgWzfyfoJfh1m6+HVmu1IR+PI1fxPPU8HkyWc+tJ+6Op8+IEPmCuXxqTu/0AuFTkr1ysAFQGrarvJeKPCdSwcmXiedPrUj5Yl69HPEaavKytmBbfbsoiZT4fZEcueOV3OF6IbVq4qv2v2yF9PtyLB3N2lTPukKBQe3ztPS2qU48c9gYkBxTm5zyqT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efebfe8c-16af-4326-b422-08d8285941d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 00:51:49.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XluKpw8tCyy6diq80gSkjw/d1iLs72dzwcaMmM06o2m2CoWiIxn4qwieiJ+yHlKDRx9t+riI13x2l0SHagPWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> The Toradex Colibri iMX6ULL board has a special USB hardware design.
> With runtime-pm enabled USB reset itself continuously. Furthermore the OT=
G port
> is also not enumerating devices if the Chipidea IP is in runtime sleep mo=
de and a
> device or host gets plugged in.
>=20

Hi Philippe,

You may describe the detail what's the special USB hardware design for your=
 board,
and why it causes the problem, and why disable runtime pm could fix this is=
sue, then,
the other users could know if it could apply to their platforms or not in f=
uture.

Peter

> This patch adds the opportunity to disable Runtime Power Management from
> devicetree
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>=20
> ---
>=20
> Changes in v2:
> - Change commit message to tell the use case for Colibri iMX6ULL
>=20
>  drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci=
_hdrc_imx.c
> index 5ae16368a0c7..5078d0695eb7 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -434,6 +434,9 @@ static int ci_hdrc_imx_probe(struct platform_device *=
pdev)
>  		usb_phy_init(pdata.usb_phy);
>  	}
>=20
> +	if (of_property_read_bool(np, "disable-runtime-pm"))
> +		pdata.flags &=3D ~CI_HDRC_SUPPORTS_RUNTIME_PM;
> +
>  	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
>  		data->supports_runtime_pm =3D true;
>=20
> --
> 2.27.0

