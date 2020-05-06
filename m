Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA41D206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oW7BYfQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgEFJDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:03:38 -0400
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:1504
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbgEFJDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXqQ2L2LlekanEGi9cbBfwC+L4DYBIgHHkgg9CTOHamMazpOS0MRbt9k7wiVGkYKnHTjDWTgPP1PBp1xTgNRcpWyBWG0kEXbmA8bBe9uE/oC++dgi830xnyVV4O5nund4sguHipD8R4anFMKxjQyHj2oeBv6PoqTqEidJAQd2P0f2R56sA343n1JHE5oZ4hJTd45Mek/oBCbApsDiOr4lJPiqBPhIQupBKp/pRqKrscEx0UzuZOSEcynNz1kTqiZOHt6TOpOGGF+ISckwsu2hV2HZt0PF16lXr8GZLqb7VS16CljIHrQwHN/lca6ohA0CbebJzdUSVPWkK0lJg4PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2BfXoS9qBaERq/kGDPcIC4TKFAY2d6ul1LOyp/gL04=;
 b=JBdkwvb0+FDnU10CsowOGkvV5saVnd7e8w7McIwiFDr864G5w1HhmOIrqr/dIB7fueu8HPPsv+Rf5J2DyL462n3Wbb0D2Sn6pZz5t1nqxr2ln1n03c30I3tPLaK7gYJ5+bbYpjJcoQxWbI0xwp+zxZGuX3VTqJL6l/s56iO0hBnTfVmcoH801nhrWv8IZC1FVG3wHktONUAVPnyzbqKVHV8quYnPmdqUVSYzElls7A4rW4iir7I3ycM98Sx3FT/5Eb4xzM4yGVhwuWcFd523F541zfQXdf79nhGSqgNHapyLtjx0JRXmI+dXo+rRPC0Xo3Kt2a368MDcSLi04JSvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2BfXoS9qBaERq/kGDPcIC4TKFAY2d6ul1LOyp/gL04=;
 b=oW7BYfQPUyCj08wcYsW44PML9TdMJK/9VJydMBWElXQ4o58AZ68OjjJCi6iFxLoHs63nQ94jjXp55RaK0O3VDhPQhPl71s1w/Kjtx2gV2qr6jmUgvA93XMq1jelSOTqDbZGw4hs1RcAkxoZW1DV/Lg3A2SrBwiWlt1e+zO+4apc=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 09:03:33 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792%9]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 09:03:33 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jun.li@freescale.com" <jun.li@freescale.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: audio: Fix a missing error return value in
 audio_bind()
Thread-Topic: [PATCH] usb: gadget: audio: Fix a missing error return value in
 audio_bind()
Thread-Index: AQHWITg+2d4HmGUDzkWJmNFd0Xw0X6iayB0A
Date:   Wed, 6 May 2020 09:03:33 +0000
Message-ID: <20200506090358.GD30237@b29397-desktop>
References: <20200503104707.148996-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200503104707.148996-1-christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b678fb9-03ef-4306-f82d-08d7f19c5a7a
x-ms-traffictypediagnostic: AM7PR04MB6885:|AM7PR04MB6885:
x-microsoft-antispam-prvs: <AM7PR04MB6885C6434C549D31C0A97D118BA40@AM7PR04MB6885.eurprd04.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiP0JzLzIZgnAChs8V4bbqmFeasD4/UxmnQyin+XSMe6eAPN8ullhuWgmu5YZYYrpeRavXX4TT95K/jpvrhc+MwN+NuY9BxtZVbvv+RDEnMAthG4JPrks1irN2Ozj5Iqk6AdYlKVq31E0qXglpDHn9i0vHGKom1eurIbOD4VkELtFyNitSZS0zluyqSGQI9RcwpquY5dwcSWxZZv5cSwoRqy+W/1LPj9Vj9e0qFsIVJ2XTQPAoJcvb4q4gsil7Cp0GttYHf1GDYeRQSRNFwBEYKkEaOZATSK4/a1QG1pLzMKJkb1Ik7/V9vdxioa9X4f0O1sjFgbtelWS8uV/mzBS3HEUjBF5yvhjEo6sh8XpTHcAMmaJHxfyx94qJ3jbfdmCQmeBwfFPamrvSSq5H9q3MEhyz4xwMavumAaEqfu1z46v3V4njdHy+BxKpOHh+NP5PQNvf/aMe1m3GjRQHvRtcqNbPFmY6oBz08QvfR7gpzv6MIWKTtg3bNushLoof0vKCFPpJz5JFHLZf/TqX946w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(33430700001)(6916009)(4326008)(6486002)(86362001)(316002)(6512007)(44832011)(9686003)(33656002)(54906003)(186003)(26005)(66446008)(478600001)(66946007)(91956017)(76116006)(66556008)(33716001)(66476007)(64756008)(53546011)(5660300002)(6506007)(1076003)(8676002)(4744005)(8936002)(33440700001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: p1faWPCUgip8TEJ8Cw6AMMjJg2jrNRmY7aWp3yDYHkgr4/ER8SleZ8jPVockkyCl88fsBhuUbzG69X0rzj/2P+IHgp4mohJrWrYJZMbfIJiUUhu4qbHsaSKAnaShy5gCaOB46f2vF0T9yjA48vEeCjbc4NoYUofchOFBrDivSoKY/YtrMcRW7+i5Hc+f/edyAlTLVwp3QYOeFe+WwZF6MHPG7wfnKy/kf65fsZDv3fdOY5DxzJSXfiDybeKMGC2D+bojECTm+sG3lCXrjO+Cz4BZC1qju3jnXTSYNn/NYk5P8jew00Ehqt1T95gFJTWNLurKAVJ7G/TwH1+OuSUi+dR7E6q/JlNAlZe/HtPidowcBRtan7n6m4dUOr+8oZx+en6ytUgtSeiTvQ2wqndUyMma+KyT7+rMMygLTHNRBP5MbfqT3eDQJ36dZhCdsBS3wJzwasAOqqYFLIVGhxaLXtxIYAfJ7bYs0UAVS8zugkv83I+aNrNNJ63vqDKrkvoxPnNeYNXNeNR4tgTpCPDV8XAVKhua105LZzUO8R+7QoQBkAZZ2bGa5DCUAdUWW4//GBzcmr5MWqnJGTsoL3NjZeYPsWFTbrfpHwQlxj8jzZ+P4gAvVxkuEbTJcBYw1Bxkyy4/XQJ9OZlNWGWmRE7XVBPNTjTTuOHxyzrNvz2dqI/JbW729FL3Kw4IWX0+DcDNMscHQvh/nAdq9HB40NySelfF+UnsRr2l2CKsdKb6z6LcnCYCpMhEN7nYcPndEJWFmYBrcYqmN5aXfpwm+D5PDREHwkRYvIM0oqbqtuCORvE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3C6C58B08C009448250D33884C2E52C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b678fb9-03ef-4306-f82d-08d7f19c5a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 09:03:33.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9UErcjrPZCrEQ5fOHy2Eb0zDxcWC+87SvbAfT3A4sEx5tCBIqh4X9DM2yngHNf5xR3DzOzQ3IJRoCOVCQyiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-03 12:47:07, Christophe JAILLET wrote:
> If 'usb_otg_descriptor_alloc()' fails, we must return an error code, not =
0.
>=20
> Fixes: 56023ce0fd70 ("usb: gadget: audio: allocate and init otg descripto=
r by otg capabilities")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/gadget/legacy/audio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/legacy/audio.c b/drivers/usb/gadget/legac=
y/audio.c
> index dd81fd538cb8..a748ed0842e8 100644
> --- a/drivers/usb/gadget/legacy/audio.c
> +++ b/drivers/usb/gadget/legacy/audio.c
> @@ -300,8 +300,10 @@ static int audio_bind(struct usb_composite_dev *cdev=
)
>  		struct usb_descriptor_header *usb_desc;
> =20
>  		usb_desc =3D usb_otg_descriptor_alloc(cdev->gadget);
> -		if (!usb_desc)
> +		if (!usb_desc) {
> +			status =3D -ENOMEM;
>  			goto fail;
> +		}
>  		usb_otg_descriptor_init(cdev->gadget, usb_desc);
>  		otg_desc[0] =3D usb_desc;
>  		otg_desc[1] =3D NULL;
> --=20
> 2.25.1
>=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
