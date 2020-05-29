Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58974212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QNlJLET6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgE2HUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:20:19 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:5352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgE2HUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKmyEEWOYtwM4uv6QraucmEtAwht32nCL3ImWmwcBV7+ZAiPMkkglZVbrCT5okB1X7TyrsBZFP9nWsVwot1F+SglHejj5OGK3MLCpwnG/ZF9nurTkjl2JfdD2NWkMYG+pN8FspAwUHYlmvD3s6ZIlnJ3v50B+JDcMTcItja8C53Xs6BEyrHf7baBO5IyXxPnalbF0Z4FdmECETTEgYZM80zIAf9mN2jUU5cX5Lw3VYcBm/EfSjv4RHXJ+Mh4/jG56rhfsSn9jOjr6G4xnO5bNoPij5lJoGBw2URNWb4Xc3BaYuRSw1UQGRrIARur3mnhUtAS0M7WODCeIJ9e0jBwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P06kTL9wNE/9ZX/r7XbwXCd4CuSOnccM8OO+rnVKulA=;
 b=k4e4Jlkv4hYD8jgghVw4p+wW0yUfgFrvvIqiU0e1f5EiRbSKprTTAgOBQpT3Y3aWEEeSWdOjPNcGMJDNVWyUJ/mR2cQZhwKqnPiWI7XMi9EiwnAfN3fY8cbZQuRX+YGlwPryK27RHO2WMMLfVw2JPs9IrcVLcdTiSTyRDF2Mi3wTq0SwWOEhA/XO1odVOC88KTZXqZBPrdEDBft0ZO4kR+uFgtpse+HZxXPP/PefWDv7WlrR1GJds5e3QYU5RwY+WAQZ0O1fmSSNZehs+KvbPqEutNRvzqIDrPs8xRpUQLJzYyENIpJ8Cxk581x2sE4idI+YuvlxpkA7XTSuwWIWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P06kTL9wNE/9ZX/r7XbwXCd4CuSOnccM8OO+rnVKulA=;
 b=QNlJLET6zHulijIiwUQaJ0fKM+SSXPwzOPt60KIec3Ts0+zrVGVttAg3MignWWLF1xg3HFmDWx5rvKAo2ru1z3o5dbQEclpZNapBWsl5ZGHqtTa+eLj4vK1epJHBeZytdh4x4nKmZlnzTtME1fnzBflKPUGT5PUsiNHt6qVBXyM=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6840.eurprd04.prod.outlook.com (2603:10a6:20b:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 07:20:14 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 07:20:14 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb/phy-generic: Add support for OTG VBUS supply control
Thread-Topic: [PATCH] usb/phy-generic: Add support for OTG VBUS supply control
Thread-Index: AQHWM23eFY1+Pfs1gUaTviqfbn5UWqi9XTqAgAE1OoCAABn7AA==
Date:   Fri, 29 May 2020 07:20:14 +0000
Message-ID: <20200529072036.GA32755@b29397-desktop>
References: <20200526145051.31520-1-mike.looijmans@topic.nl>
 <20200528112051.GB2604@b29397-desktop>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.976751ef-854e-4011-a18e-b2d0439b2aee@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.5ef445e7-974a-4eff-8ab7-9d43664977e4@emailsignatures365.codetwo.com>
 <3fe53080-cc74-3b0b-3041-2c4fde1b7e30@topic.nl>
In-Reply-To: <3fe53080-cc74-3b0b-3041-2c4fde1b7e30@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: topic.nl; dkim=none (message not signed)
 header.d=none;topic.nl; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 809032a4-a738-4592-fea4-08d803a0bb5c
x-ms-traffictypediagnostic: AM7PR04MB6840:
x-microsoft-antispam-prvs: <AM7PR04MB684037A2FC6F20097F1DA4058B8F0@AM7PR04MB6840.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLQHP4jH5dTzDmSvc5PROVKezuPcNMip3k3wZJqR3bR6ZeQfKMLrVArxEkDjTr97ciC5aE7UG8HTtj1h6inCixCljk+3/nTpQxgFMSptmsDO/vKqy6pThGScOYTM1qBgRjPWxeGIQcY8o3t8MenGCg1nPgrg1QD9dQVgdgqFovKjtDztch2uqSWnxr2bxKEtXJ9rb5f74gyFSDG6/KK0bZfW7eaRsRyBDL2cCjkMIpLbRAdJq6d4pdaIfx1eGdGPv2OR71tepxLrjqXc6UhU5NADYBF3Q2LbdBJW/1H5R2tf2/QfxiAVL1kto88lw+6UUuMUG+0dUcyZUW4vHzlnhAX6WRZ/9LrLCzG23VRVAYnC3AIEYmcOg8UZxCyw6KCUMpohgssiC6ynxBhu2vXAG9vbKNvPvpnhkw0moniCZPwc0NSZ8mtTi+UVj/aGzRdgzblaNpn8/c1Wc7LWiir2ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(6916009)(966005)(186003)(91956017)(76116006)(8676002)(66946007)(9686003)(66556008)(64756008)(66476007)(66446008)(45080400002)(4326008)(6512007)(6486002)(8936002)(478600001)(83380400001)(5660300002)(2906002)(53546011)(44832011)(26005)(6506007)(86362001)(33716001)(33656002)(54906003)(1076003)(71200400001)(316002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2x1bDl7+/gaZyZVQW6B47e3lQA3jfF+5RryNjFem9GkRCes+qcyzhrfTpe4SJhHXPNwP+CB5Pztdo60Ki9IDzt1wJvO5mXMEJwFo2MSB2HFVwPe/js1Hza2a3f0bx5kcbQRJmhzN95ZdCbXgzfmt5XQ9YB7hIiQ7+RwaG4jFQvnzwyCkAk+5ByoFuLOLbZkULxp1Ahc6k+GsPyX2jkljJCPwMQ6wQWd+pv7N/L0iZBfnPiC0oNvSNuZ0QmJjSQ38ytUjHhWaJLGnH0wVr0b3w3eU9MAOLXmFdgBbk6J8NN2yAKgAco3dR2m4ZGUYLarRRvelnRGuhhV9rlB2SJxwOvpsF1xGWDu4/IyeelMzc43ybrm/aNvlsDJXfvrn3fsq0kWoz76v6udDcOj85eIUjIE+slhxIZABWsbW+j7MK+UtFVSm3IZ7uKbf7P9auV6LF51XSUsnqlKv1o5CQzv2IpBJzrrkU0eZzuI2MRLpqG4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED25584213755B4FBEE5008A6C765D7E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809032a4-a738-4592-fea4-08d803a0bb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 07:20:14.4785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UbueCNL0ascPEzp04MjQabJYO7eOJRpqUZbyJQq9skozqC68pUSpZCwbm/5D1JRyNDzWAuKjNRsgTF4gyWhig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-29 07:47:37, Mike Looijmans wrote:
>=20
> Met vriendelijke groet / kind regards,
>=20
> Mike Looijmans
> System Expert
>=20
>=20
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>=20
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww=
.topicproducts.com%2F&amp;data=3D02%7C01%7Cpeter.chen%40nxp.com%7Cc8a5e33bb=
d3141b57d5408d80393cff2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637263=
280668758097&amp;sdata=3De5yJuVtOJ9%2BUqmRl6HNk14Fd0%2FPR2jQAhOl1vHtYJKg%3D=
&amp;reserved=3D0
>=20
> Please consider the environment before printing this e-mail
> On 28-05-2020 13:20, Peter Chen wrote:
> > On 20-05-26 16:50:51, Mike Looijmans wrote:
> > > This enables support for VBUS on boards where the power is supplied
> > > by a regulator. The regulator is enabled when the USB port enters
> > > HOST mode.
> > >=20
> > Why you don't do this at your host controller driver?
>=20
> That was my first thought too, but it made more sense to do it here. It's
> about how things are connected on the board, and not about the controller=
.
> Also makes for a consistent devicetree when using different SOCs on the s=
ame
> carrier board.

A standard interface is: port_power for hc_driver, but seems the xHCI
doesn't implement it.

>=20
> I already needed this driver to properly reset the USB phy, which the
> controller driver also did not do. So it made sense to add the vbus power
> control to this driver too.
>=20
> If you have a strong preference for the controller driver, I can move thi=
s
> to the DWC3 driver which happens to be the controller for the latest batc=
h
> of SOMs.
>=20

You may ask Mathias or Felipe for comments where is suitable for vbus
regulator.

> > > +
> > >   	nop->dev		=3D dev;
> > >   	nop->phy.dev		=3D nop->dev;
> > >   	nop->phy.label		=3D "nop-xceiv";
> > > @@ -278,6 +319,7 @@ int usb_phy_gen_create_phy(struct device *dev, st=
ruct usb_phy_generic *nop)
> > >   	nop->phy.otg->usb_phy		=3D &nop->phy;
> > >   	nop->phy.otg->set_host		=3D nop_set_host;
> > >   	nop->phy.otg->set_peripheral	=3D nop_set_peripheral;
> > > +	nop->phy.otg->set_vbus		=3D nop_set_vbus;

OTG is dead, even USB-IF has refused OTG test since 2019-09, you may
avoid to use OTG structure.

Peter


> > >   	return 0;
> > >   }
> > > diff --git a/drivers/usb/phy/phy-generic.h b/drivers/usb/phy/phy-gene=
ric.h
> > > index 7ee80211a688..a3663639ea1e 100644
> > > --- a/drivers/usb/phy/phy-generic.h
> > > +++ b/drivers/usb/phy/phy-generic.h
> > > @@ -14,7 +14,9 @@ struct usb_phy_generic {
> > >   	struct gpio_desc *gpiod_reset;
> > >   	struct gpio_desc *gpiod_vbus;
> > >   	struct regulator *vbus_draw;
> > > +	struct regulator *vbus_reg;
> > >   	bool vbus_draw_enabled;
> > > +	bool vbus_reg_enabled;
> > >   	unsigned long mA;
> > >   	unsigned int vbus;
> > >   };
> > > --=20
> > > 2.17.1
> > >=20
>=20
> --=20
> Mike Looijmans
>=20

--=20

Thanks,
Peter Chen=
