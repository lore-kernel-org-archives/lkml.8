Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E48C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CBA206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YWX33tso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHXH4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:56:35 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:55778
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbgHXH4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3BKqBPp8ohbhavshJlIRYG/XLMrh5Fb8mpWByLuYJbY5UG5euZqWTdpCVwAo4VD2qni2gHjwJhKgBl86lBxyUQ08SYGmfU8IKf0g5bh4hS3thEDFxicXQlfX+MwvawtlVH3kXc3b/ho5vSXIW64TpBh6c0nGQyig5OdrOjAMdzgemnhQZza3I2JvLeyK036aFkvv+qg7jpLz0sEUoD6YW+HbRTQurgW1YKNKUjAwMog9qOxb656fY/+CZ+avGaZfOXjbhU9EhyzpEMLuS9yg0aJEIGSRKpVXGRtZJAfqc9wu4W1HgP5EXGyMX4W8NX0l1l7a5hr4vk25xtgNOIjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suh7BpPH8TthzZQHXSXqDhTwQ37E/Ux4WcKQdVOonlU=;
 b=JNeWynJl1MDqWwyx73m7+NWS3FjHoGKrnwghqGTCGQ3r16gC3v7wZyESgk+T58kdaHnzTQoDCTiYa5fAQkhc7E9xJreAeWQBQOlCwaxlgRyItqe37kZv8BW2T1BsAB14OjXM4Hwvfm9QaWVQdm7HCVIINtogIsRocH9nyBQEtDoRCjZsoBw01Dp2yAFA9AtgSNcc87hoUQjAHDYUCdtbB8fmQBjAL75BC6SmxjM3GgLP3D6HHhQpODXbdLyc33+udlKp/fJQeyAU8Vp2GhKW23DExUfTOYhf7ytXCe0m8Xdz8fs/B+osVOEAM8K7KNBeIfTnaBYgfRgf/sibVEZEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suh7BpPH8TthzZQHXSXqDhTwQ37E/Ux4WcKQdVOonlU=;
 b=YWX33tsos2WwjVh0oUAypW2xc2A9ZXi/scmFJ53H6AYmTnDYFXTBQpMEtakM6VgxZnEnook2sdDvGZzSl68SsUq56McvgMNeB7Krjeb6ECIbQT+/wYonbyH3tyBfr4w4gufmanzeGhgqIPICfu1ExLVzWdZUqpjT5cmH76HtDL0=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR04MB5951.eurprd04.prod.outlook.com
 (2603:10a6:803:d5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 07:56:25 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 07:56:25 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound
 card
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound
 card
Thread-Index: AdZ560NIGNcMdNkYSiK9PRUDUr/UFA==
Date:   Mon, 24 Aug 2020 07:56:25 +0000
Message-ID: <VI1PR0402MB3342064B54636847F4737442E3560@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11189ef2-7270-4240-de7b-08d848033336
x-ms-traffictypediagnostic: VI1PR04MB5951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB59516885B45DB29EC640BE65E3560@VI1PR04MB5951.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H0Qa3VR9smzPWiObD/Rsf7JQYH0eyrlTg5wyyu2q6CMHWIHkMCfQxLWCtk2fpAdl8UOY0Na8Ubmv4/gWprX9nWgRkmJOtjxzNTCsrvSkm+DCDhk4Y8vtAb41W4R2OcEUY28wlqQyavHvsvW+3L7s7FZu65NxOnaKFONzFQJx8iespaJahKuq/5P8AAf7P1H920x6K6TyfHqLwem5+aqQw6wIc4FLpn+UJyAj8Y0Xf3w3pghLyrfQERMjfW9qbeFd19fcM6qLaBj7dXV47dO2m9ZNh293s+ucatJiBTtYXwek8bBnfPYTtSldCHD0znHPIU8MRnTR+/5zCQO0x+7BgG5n/JXIz/8ZXxWtLUwjJ/UM6soWAV1qvDrQIshFbN5KjLqm2qxhFfg/eAlsAgbTK/F+d03H7rRWjYUqkLKK4wUC6081KF8+MlwIj1DjuJ/zV+hTibHcVUy8hOrh5pJg0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(71200400001)(33656002)(8936002)(478600001)(83080400001)(83380400001)(966005)(66476007)(64756008)(66556008)(9686003)(66446008)(66946007)(76116006)(2906002)(54906003)(52536014)(5660300002)(8676002)(7696005)(4326008)(186003)(6506007)(86362001)(26005)(110136005)(45080400002)(316002)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D+wNZVhuf3tiMUpwjwUTBTxrVqEX4zN1OpX152CiYQh47sbcZLYZ7pdfyhPj8Vsgg1qmEYMzRRYWAqN7/XSZsFs4vNv7W8nflSTj6+9WwhLhJ7xctk0Hiy3enT9u46aWiQiVbWrrJKPtFY4TUdDaNlJxXE8szotCx4bnrI6VPr00YaGzUVPKvMUE0E7OttZ+aJa7IwJJ18d+KzY6WO9vUkvzQKLAN/DNOIkHeBqzTTlKMqincgMbJTa6LUw5IxGIYSo8btONanb/N9dWj/zeTv6Fbi5f8QTFX2vf2V/3bwgv6x6PK4hyLRC+E1GAWryHemUr2pE4ywtV7B6sD0SeqUIh+XqHboQFQoduyLsbAxvE5Ch+dElq5K8mERuFszmq1R2u0oofvbtTQcQ8B0xdcrbvr1CK05rg9Fl4krAn8T+v9fSXFVOeHRw6p2gffq8gRbsSjSgTWkBZgHPy7QlUMxaD1KwYRQt5eoEB2X9BVFN+QMXk/0jECRGN3cYD6b8xC4Lcsx/6B5f1YtlEsgfjQGu+jiKbJePKONFu8Jhf7bxs9qGxlbajYEz0zEL0T1wYH5vUd5xpPo6heZBlM0jsydOuCMyuMwqvpKUoP9Ld2ANoiBd+kcDxwKFJTtwSFp/PxPOwsqOuqANmTSSlenpRLA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11189ef2-7270-4240-de7b-08d848033336
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 07:56:25.3351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxbW0J7Dh1H+p9OU8JpScwMpoTZ8LiGh9ZRE0J53veBPl/1YIuv6mj+0iBwgQABH2tZMOPl8NDUZ7NYayH3Q6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn, Fabio

> >
> > > I would like to know your opinion, should I move headphone detect
> > > GPIO To audmux group?
> >
> > What about adding a dedicated pinctrl_hp for the headphone detect pin
> > like it is done at:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> >
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.g
> it%2
> > Ftree%2Farch%2Farm64%2Fboot%2Fdts%2Ffreescale%2Fimx8mq-
> librem5.dtsi%3F
> > h%3Dfor-
> next%26id%3D8f0216b006e5f553d28c4c1a991b5234693a49cb%23n130&am
> >
> p;data=3D02%7C01%7Cshengjiu.wang%40nxp.com%7C672e70414ead4170b617
> 08d847c
> >
> 05117%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63733823860
> 3810133&
> >
> amp;sdata=3D69K7rVsYB35Iq%2FdE%2FSf2%2B862VlwOFRwSTYBML7OQxUE%3
> D&amp;res
> > erved=3D0
> >
> > My point is that we should avoid adding a hog group when possible.
>=20
> I agree.  Hog group should be used as the last sort, when there is no cle=
ar
> client device owning the pins.
>=20

Ok, thanks. I have sent v2.  That I refined three patches for this topic.

  ARM: dts: imx6sx-sdb: Add headphone detection for sound card
  ARM: dts: imx6sl-evk: Add headphone detection for sound card
  ARM: dts: imx6sll-evk: Add audio sound card node

Best regards
Wang shengjiu




