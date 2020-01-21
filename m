Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463F4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042B620678
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cHOWjkG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAUSkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:40:49 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:21779 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:40:48 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cv1Xvyt2z/4I+JtxROkSEFVwjmE9a7+VNjjJN+QIuMz5PLLwZVgb+lNnlzYAmE+PhVePo3AZ0d
 ZnTD/rpmbXgxvtkj+wddddltndhN39lK58D5GYbjNd0i7GWoA2dVqaAq5OaMeIEMQP7rrhpLg/
 MqGAGZCBuxQk+WOOfrqoVirI1PLeEXjzaZg3w5XO0F2Mqw+8fzOmQhJfBEJFS5DNjBba9IJEc+
 Ss4jo2PmdkFEY8lFe1GpumFl8JPUSRn+o4OfKS/3E8jOJmqh5AkhNVqqZtjIGQEef6NNspTHmD
 53o=
X-IronPort-AV: E=Sophos;i="5.70,346,1574146800"; 
   d="scan'208";a="62641088"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 11:40:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 11:40:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 11:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcZXaKLZdhgIZLd5gUQO69E38yLJJxLHlaOAvWOsJCuhcTsZJNESJtRpDJWaFN39XVqmtMFajxnEic88bTMZpD72sS43+afepVw5084LQZbilB5CjCYIjb8/x5EC16V/X/hIScHTyiTv1+fBAEVD/XK2E9d4dQS3E6SuzlEguXClXRoxYvYO2zenw2LIV4ev1mtdcjDmAUyOTZtGGVBi6nH8RVrbzOTsaBdg4CKEiuohYyj4IKpsOyq6jPGB8FLDlr2dGz6FGxqkkz4/FW/zwKr18qLMqlMLzwIAFSK3CNYD8MCMdNndTC7Hn4JfU7hG9Zh5iHMwrSpNaWpBEnWLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZSI0fQBxoymQcYZ6j6pcHv8MKgA4cxhjB8pCx+nsXk=;
 b=RvOKaUBfK/93xMALS8LMB5WV1GB1FaFtqtUoXmD7bpu+yXRypKtBNyerZkAbSRyXUcMDxotwAEPqKCVMWtzlzbk9OOLi0iqTxKPMEY+ZgWu3ZUyZx2ALlopcpRt89cfFFbwHDxK3DadoZC3nnBhxfenjOxag2kl/mIboek3SDmejQH3k2sKTFLKIip6pweRSjf3hmX+bJUPpz2yl9vvuFIg9ZntYeljvWLamnlf0stKuJ8AAuN0XhA3w3CdDXP1rgoEhQXI9N8uWJFUEV1QNP5KffU7nQSVFiiUuHMxNfeKsXEgqDHnFsp87YJoyEzGfqZBuUEQXte2vlihRRleWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZSI0fQBxoymQcYZ6j6pcHv8MKgA4cxhjB8pCx+nsXk=;
 b=cHOWjkG6085gHUEVxQbZtDOf12j8HRKAe3rLxKSx/3HlwstUwn1dLuTbmWG1KdQaEyZygFK7eO6F5rk3L5t7D0pdgL13+enBv+oBRH/3K4IK5BptQuMXs284dPGiq1MEyUV6fBY1whkNKSjN9Vs0/D+8p4j80cPZIFgcpnCQk9I=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4143.namprd11.prod.outlook.com (20.179.150.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 18:40:46 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 18:40:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
Thread-Topic: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
Thread-Index: AQHVzpf32dqEzZAPf0S4HyMwJjELNQ==
Date:   Tue, 21 Jan 2020 18:40:45 +0000
Message-ID: <5476415.ab72jjm3fZ@192.168.0.113>
References: <20200103223423.14025-1-michael@walle.cc>
 <3862353.UOg0IvECEa@localhost.localdomain>
 <d3f03e392c060ff4ed4c2ae8a8999d9f@walle.cc>
In-Reply-To: <d3f03e392c060ff4ed4c2ae8a8999d9f@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa415d8-04b0-4851-f7e5-08d79ea16d82
x-ms-traffictypediagnostic: MN2PR11MB4143:
x-microsoft-antispam-prvs: <MN2PR11MB41433E07053FBF2A0ED6C5E1F00D0@MN2PR11MB4143.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(91956017)(66446008)(66946007)(2906002)(54906003)(66556008)(66476007)(64756008)(6486002)(81156014)(8936002)(71200400001)(81166006)(8676002)(76116006)(9686003)(86362001)(6512007)(186003)(316002)(4326008)(6916009)(5660300002)(26005)(6506007)(53546011)(14286002)(478600001)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4143;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0G3iUMerPSiR5kWuGfdiGu0wxzRcwiVeObpgVlmnjs0v3nUi9pJmNMK8Za4kJNoaw3ZN8ki+5wCV1lPAbf64ZOSNlZG3xxPWgbIqXu9yhePwGDDtOreodTBTj++c0aCFDxjNyk8TmIf789AylX7ISz8myot3sXl6a+MlZri2MwQqmUaosCyIpqHrlcBK5PRzOdHWC2BW3sBS5yB3w3xNImfOZyiYYilQ4f1Ne9YTqCATfYdhv2wQPr6GI1cSBotWc4zjM8Icfh8k1ccjPaQ6ujCeqZCUt/VopAvy9IEcCEgL4RR3OBRlm5ExyTIdy5HRISOuvD7fI00L/bPRYUQ8SP5YWCP7OzpSonjQpWsXtfFH/Pf1QU05H3ZN7bZby1nME2RB6fXvIIT8eVE2nB74rHXfizrALYCGuQdWHA3I04hfOkuFxooetHsiu8FOl1A+cmojs0Q8Zgd4sS1JitTP7E2oy5R8rVhEHPvPHS/DN8bhKnDzCmOUa0nW6vwlTFL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7EE87AC2552CD45B19B94ED6068EF88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: caa415d8-04b0-4851-f7e5-08d79ea16d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 18:40:45.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9wzVVRC+xgDi80fZsK96Kwpq58EaCpbdH/jAAuyOK7YXXwODebxOZlnP40G2CJKmIjWrtebCbzaOnNMc/GoFcf5wEPQt5NqqEUjV+V79VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

On Monday, January 20, 2020 5:55:55 PM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Tudor,
>=20
> Am 2020-01-20 12:03, schrieb Tudor.Ambarus@microchip.com:
> > On Monday, January 20, 2020 12:24:25 AM EET Michael Walle wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
> >>=20
> >> Hi Tudor,
> >=20
> > Hi, Michael,
> >=20
> >> >> Am 2020-01-13 11:07, schrieb Michael Walle:
> >> >> >>> Btw. is renaming the flashes also considered a backwards
> >> >> >>> incomaptible
> >> >> >>> change?
> >> >> >>=20
> >> >> >> No, we can fix the names.
> >> >> >>=20
> >> >> >>> And can there be two flashes with the same name? Because IMHO i=
t
> >> >> >>> would
> >> >> >>> be
> >> >> >>=20
> >> >> >> I would prefer that we don't. Why would you have two different
> >> >> >> jedec-ids with
> >> >> >> the same name?
> >> >> >=20
> >> >> > Because as pointed out in the Winbond example you cannot distigui=
sh
> >> >> > between
> >> >> > W25Q32DW and W25Q32JWIQ; and in the Macronix example between
> >> >> > MX25L8005
> >> >> > and
> >> >> > MX25L8006E. Thus my reasoning was to show only the common part, i=
e
> >> >> > W25Q32
> >> >> > or MX25L80 which should be the same for this particular ID. Like =
I
> >> >> > said, I'd
> >> >> > prefer showing an ambiguous name instead of a wrong one. But then
> >> >> > you
> >> >> > may
> >> >> > have different IDs with the same ambiguous name.
> >> >>=20
> >> >> Another solution would be to have the device tree provide a hint fo=
r
> >> >> the
> >> >> actual flash chip. There would be multiple entries in the spi_nor_i=
ds
> >> >> with the
> >> >> same flash id. By default the first one is used (keeping the curren=
t
> >> >> behaviour). If there is for example
> >> >>=20
> >> >>    compatible =3D "jedec,spi-nor", "w25q32jwq";
> >> >>=20
> >> >> the flash_info for the w25q32jwq will be chosen.
> >> >=20
> >> > This won't work for plug-able flashes. You will influence the name i=
n
> >> > dt to be
> >> > chosen as w25q32jwq, and if you change w25q32jwq with w25q32dw you w=
ill
> >> > end up
> >> > with a wrong name for w25q32dw, thus the same problem.
> >>=20
> >> No, because then the device tree is wrong and doesn't fit the
> >> hardware.
> >> You'd
> >> have to some instance which could change the device tree node, like
> >> the
> >> bootloader or some device tree overlay for plugable flashes. We should
> >> try to
> >> solve the actual problem at hand first..
> >>=20
> >> It is just not possible to autodetect the SPI flash, just because
> >> the vendors reuse the same IDs for flashes with different features
> >> (and
> >> the
> >> SFDP is likely not enough). Therefore, you need to have a hint in some
> >> place
> >> to use the flash properly.
> >>=20
> >> > If the flashes are identical but differ just in terms of name, we ca=
n
> >> > rename
> >> > the flash to "w25q32jwq (w25q32dw)". I haven't studied the differenc=
es
> >> > between
> >> > these flashes; if you want to fix them, send a patch and I'll try to
> >> > help.
> >>=20
> >> It is not only the name, here are two examples which differ in
> >>=20
> >> functionality:
> >>   (1) mx25l8005 doesn't support dual/quad mode. mx25l8006e supports
> >>=20
> >> dual/quad
> >>=20
> >>       mode
> >>  =20
> >>   (2) mx25u3235f doesn't support TB bit, mx25u3232e has a TB bit.
> >>=20
> >> well.. to repeat myself, the mx25l25635_post_bfpt_fixups is a third
> >=20
> > sorry if this exhausted you.
>=20
> TBH, this is no fun (and I'm doing this on my spare time because I like

It's not my fault that you're not having fun when someone disagrees with yo=
u.

> open source). I guess our opinions differ waaay too much. I don't

Up to a point, yes, our opinions differ. I'm not rejecting your suggestion,=
 I=20
just say that we should implement it as a last resort, when there's nothing=
=20
auto-detectable at run-time that can differentiate between two flashes that=
=20
share the same id.

> really like band-aid fixes; eg. with vague information "it seems that
> the F version adveritses support for Fast Read 4-4-4", what about other

We can update the comment to clear the incertitude: "The F version advertis=
es=20
support for Fast Read 4-4-4""

> flashes with that idcode and this property. This might break at any time
> or with anyone trying support for other flashes with that ID.

The jedec-id should be unique in the first place, manufacturers that use th=
e=20
same jedec-id for different flavors of flashes are doing a bad thing. A thi=
rd=20
flash with the same jedec-id is unlikely to happen.

>=20
> That's what I've meant with first come first serve, I'm lucky now that
> there was no flash with the same jedec id as the W25Q32JW.
>=20
> To add the MX25U3232F I could check the JEDEC revision (or the BFPT
> length) because it differers from the MX25U3235F. But I don't feel well

I prefer this because it's auto-detectable. If you don't feel well doing it=
,=20
don't do it.

> doing that. Who says Macronix won't update their description for the
> MX25U3235F to the new revision.. FYI the Winbond guys apparently use the

You are raising theoretical problems. We can fix this when we will encounte=
r=20
it.

> first OTP region to store the JEDEC data, which is clever because they
> can update it during production.

If you say so.

>=20
> >> example.
> >=20
> > Flash auto-detection is nice and we should preserve it if possible. I
> > would
> > prefer having a post bfpt fixup than giving a hint about the flash in
> > the
> > compatible.
>=20
> see above.
>=20
> > The flashes that you mention are quite old and I don't know if it
> > is worth to harm the auto-detection for them. A compromise has to be
> > made.
>=20
> so you'd drop support for them? because SFDP is never read if there is
> no
> DUAL_READ or QUAD_READ flag.

mx25l8006e  defines bfpt, while mx25l8005 doesn't. We can differentiate the=
se=20
too.
>=20
> > You can gain traction in your endeavor if you have such a flash and
> > there's
> > nothing auto-detectable that differentiates it from some other flash
> > that
> > shares the sama jedec-id.
> >=20
> > If you have such a flash and you care about it, send a patch and I'll
> > try to
> > help.
>=20
> Given my reasoning above.. well maybe in the future. The Macronix would

ok

> be
> a second source candidate. For now we are using the Winbond flash.
>=20
> I would rather like to have the flash protection topic and OTP support
> sorted out, because that is something we are actually using.

You can speed up the process by reviewing/testing the BP3 support. In turn,=
=20
maybe Jungseung will review your OTP patches.

To sum up: the flash auto-detection (with capabilities) greatly ease the=20
device tree node description and it allows us to plug and play different=20
manufacturer flashes using the same dtb. I have a connector on one of my=20
boards, to which I connect different types of flashes (assuming they have=20
similar frequency and modes). So I would always prefer to have a post bfpt=
=20
hook to differentiate between flashes which share the same jedec-id, than=20
compromising the generic compatible. Of course, if there's nothing auto-
detectable that can differentiate between the flashes, then your idea can b=
e=20
implemented, but I would do this as a last resort.

There's also the idea of compromise. The jedec-id should be unique in the=20
first place, manufacturers that use the same jedec-id for different flavors=
 of=20
flashes are taking a wrong design decision. Do I want to cripple the generi=
c=20
compatible just for an old flash with a bad jedec-id? I don't know yet. Als=
o,=20
the flashes that share the same id are quite old, and if nobody screamed ab=
out=20
this until now, it's fine by me. You raised some theoretical questions, you=
=20
don't really use the macronix flashes, what I say is that we should conside=
r=20
fixing them when it's actually required. And that the extension of the=20
compatible should be done as a last resort, as of now it has more=20
disadvantages than advantages.

Cheers,
ta

>=20
> -michael
>=20
> >> -michael
> >>=20
> >> > Cheers,
> >> > ta
> >> >=20
> >> >> I know this will conflict with the new rule that there should only =
be
> >> >>=20
> >> >>    compatible =3D "jedec,spi-nor";
> >> >>=20
> >> >> without the actual flash chip. But it seems that it is not always
> >> >> possible
> >> >> to just use the jedec id to match the correct chip.
> >> >>=20
> >> >> Also see for example mx25l25635_post_bfpt_fixups() which tries to
> >> >> figure
> >> >> out different behaviour by looking at "some" SFDP data. In this cas=
e
> >> >> we
> >> >> might have been lucky, but I fear that this won't work in all cases
> >> >> and
> >> >> for older flashes it won't work at all.
> >> >>=20
> >> >> BTW I do not suggest to add the strings to the the spi_nor_dev_ids[=
].
> >> >>=20
> >> >> I guess that would be a less invasive way to fix different flashes
> >> >> with
> >> >> same jedec ids.
> >> >>=20
> >> >> -michael



