Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05125C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC26124673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ImJx4iMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAVGsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:48:13 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:25042 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgAVGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:48:13 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bztLMLlSpC2DQPPBBhJNpfXuVSfs7OiDnET7emPXEUFLdG6bm3PhqdIHfqS0RgTpXyK+mj92fs
 y/xlZDtHhOgLdzf3aJBD/G5SoHlawdPl6qm6oXW8iFQEtAvOZGApPhtW9R2cs5XS6z/N7EIEAw
 hd6UiMiCeJHep58F+NqVo/knQwsWoBe7uSgrzWxS7Ep8rtq6UA/Mzt+33Wqg7BDPWNpHUbyZWg
 jA+FUKpiJe4l0ec8RcM5zgpatPplgv4ocHt70Uehh10mfbOZnMP3Xned1eE8iBYgk9HQbuWuCL
 KrA=
X-IronPort-AV: E=Sophos;i="5.70,348,1574146800"; 
   d="scan'208";a="63364374"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 23:48:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 23:48:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 23:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIWpnxN4/N8rDAdtCvFvYH65FS2L5OA85vUIKKPM8dfNj0hNNsAW56GgC8gea+A0xUnsMCtLaebvx1stEdynpGd1jlCultAYi3LwWy2tGHJBVDT5XpyxzBNKOpGwa1e/sfEQer5qtp/cmLOGTDNT3Xo5UaQjS9HnyIVZwQKXSD55UHj10fuNIdSQWE3rBkBxpu57PQF33fLx27g/tJXfFvevhLpZ5d544BR1Xxk+qdMTg7fLdg9ZBPsRjW0ARTDjsZJNg7Ix7dog/kZeN6/CUx3EvlJ4Co62NUxwm4VOxb9Wo0DBNkpvWyE/u5BEIToWuIGveoFsfTGb/RPmofPMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9pqcxz0WMvwb7LzkxpKDFG/Ps/X1r68VOboBJMkuV4=;
 b=WLISHLncnxVLNyclDOHkTML6zOCtNzbScouqFWRilxLRSPQi+VTOQl8E8CmueniCLZKf5BSomMADt50gQv7j9PI7bsoyqEl2Xpwky0+kf2Wynd9sz0tzkGH79HGMRSlcukNXeXBfX50AyNvTD9tm9Ocd8Fh1iaiiCAW1p7OFusTFGMeq7nSiErUpmaDfPwlO1cpXybNtCqX4Df09Y/TFg2r33DbiiKezFufkdZoN+JI6u8wcmKr+KTfuWTKNhwv4DCOQEQh0L6pYqP2fkXX23bRbztP1xfasyTDZ4gEghI4cLZw+ltMbZUt2XVuOttFqJIt9RvliusDrcAHM+pVP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9pqcxz0WMvwb7LzkxpKDFG/Ps/X1r68VOboBJMkuV4=;
 b=ImJx4iMeJyFe4cyKzPfRMlVjQt0MG79bdxMFeXwvIOkM7dmJApInFx8PvV/Q+kcciWpCyeq5VHZwhGgo+uUFq08XuLV6G5hVdvS/Z8ZacvM/39pm0vrTu1gxRz9cfPBsuX0vBNgs5gplr18FIERRBWrC7jjRO9pBxkzHD1AoXlU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3550.namprd11.prod.outlook.com (20.178.251.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 06:48:08 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 06:48:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
Thread-Topic: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
Thread-Index: AQHVzpf32dqEzZAPf0S4HyMwJjELNQ==
Date:   Wed, 22 Jan 2020 06:48:07 +0000
Message-ID: <2088283.tnVAhDz6N7@192.168.0.113>
References: <20200103223423.14025-1-michael@walle.cc>
 <5476415.ab72jjm3fZ@192.168.0.113>
 <1e78fbe87c0d6dc19a27210551b02af4@walle.cc>
In-Reply-To: <1e78fbe87c0d6dc19a27210551b02af4@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f03162e-219f-4418-5fc8-08d79f0709ff
x-ms-traffictypediagnostic: MN2PR11MB3550:
x-microsoft-antispam-prvs: <MN2PR11MB35505AA2FBB9C631D11E4351F00C0@MN2PR11MB3550.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(53546011)(6506007)(81166006)(8676002)(81156014)(30864003)(64756008)(66556008)(9686003)(26005)(71200400001)(186003)(6486002)(86362001)(478600001)(66476007)(4326008)(8936002)(6512007)(66446008)(66946007)(76116006)(5660300002)(91956017)(54906003)(14286002)(2906002)(6916009)(316002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3550;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzIWlJ+GaeqdJ+y+4naPwkV3X9teZLBXzUCYSvMKaJmOfDHqLCmOgemZ3jhCD6oK9qUWwdx1q+URGrAb7EXkQJGkIRPcWGj4h/lDpajyzUhk+4BCT1woWfOhP7lpfXHNxUgbwki416jLrBR/4RL/p4O/npvuA/JOWNBT7oKY/BJior5ZB3TKMZg/FDzkULB1inLnOJ0J4ZHnyVJFoW2DBerQB9J/R6HRvV+efgInCKKNnkDcH1V9D6CfWXM6jNRzsyLzxBMi623W61k8bcTP1KFL2evZgP6l1xbB0E0+PO1S436maN0w8FXWwsy0RdQQh01pT+KoQ0wOQMyi/RitFEjFpXwTnq98EOtO3TyvnadnFdMvAPgtATRi5AJcuRJLjFYidApI+fR1pNToyzmV3IZGp5qlalWSuTb9+YQnz6PxmwAyMqbv6xl65A+ByFBpIFq3RejF3w/N03583VaaFwtqeqcpWhkFrl4p5I97mY+xWLcZ3bTXgnGKYzbAxL5u
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E12EC0405ADE6640AFB20FDCB6748AAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f03162e-219f-4418-5fc8-08d79f0709ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 06:48:07.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lav8fMisMM2fLvr+BOJWZuv4Lu52slgsswRl0MjUu/8I0+mg4TWqv3t4ne8l80dtVzDKULeNw2VVUYsoaOqYfreHSOOgzHwS3KmGw69/O8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

On Wednesday, January 22, 2020 1:28:52 AM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Tudor,
>=20
> Am 2020-01-21 19:40, schrieb Tudor.Ambarus@microchip.com:
> > Hi, Michael,
> >=20
> > On Monday, January 20, 2020 5:55:55 PM EET Michael Walle wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
> >>=20
> >> Hi Tudor,
> >>=20
> >> Am 2020-01-20 12:03, schrieb Tudor.Ambarus@microchip.com:
> >> > On Monday, January 20, 2020 12:24:25 AM EET Michael Walle wrote:
> >> >> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now
> >> >> the
> >> >> content is safe
> >> >>=20
> >> >> Hi Tudor,
> >> >=20
> >> > Hi, Michael,
> >> >=20
> >> >> >> Am 2020-01-13 11:07, schrieb Michael Walle:
> >> >> >> >>> Btw. is renaming the flashes also considered a backwards
> >> >> >> >>> incomaptible
> >> >> >> >>> change?
> >> >> >> >>=20
> >> >> >> >> No, we can fix the names.
> >> >> >> >>=20
> >> >> >> >>> And can there be two flashes with the same name? Because IMH=
O
> >> >> >> >>> it
> >> >> >> >>> would
> >> >> >> >>> be
> >> >> >> >>=20
> >> >> >> >> I would prefer that we don't. Why would you have two differen=
t
> >> >> >> >> jedec-ids with
> >> >> >> >> the same name?
> >> >> >> >=20
> >> >> >> > Because as pointed out in the Winbond example you cannot
> >> >> >> > distiguish
> >> >> >> > between
> >> >> >> > W25Q32DW and W25Q32JWIQ; and in the Macronix example between
> >> >> >> > MX25L8005
> >> >> >> > and
> >> >> >> > MX25L8006E. Thus my reasoning was to show only the common part=
,
> >> >> >> > ie
> >> >> >> > W25Q32
> >> >> >> > or MX25L80 which should be the same for this particular ID. Li=
ke
> >> >> >> > I
> >> >> >> > said, I'd
> >> >> >> > prefer showing an ambiguous name instead of a wrong one. But t=
hen
> >> >> >> > you
> >> >> >> > may
> >> >> >> > have different IDs with the same ambiguous name.
> >> >> >>=20
> >> >> >> Another solution would be to have the device tree provide a hint
> >> >> >> for
> >> >> >> the
> >> >> >> actual flash chip. There would be multiple entries in the
> >> >> >> spi_nor_ids
> >> >> >> with the
> >> >> >> same flash id. By default the first one is used (keeping the
> >> >> >> current
> >> >> >> behaviour). If there is for example
> >> >> >>=20
> >> >> >>    compatible =3D "jedec,spi-nor", "w25q32jwq";
> >> >> >>=20
> >> >> >> the flash_info for the w25q32jwq will be chosen.
> >> >> >=20
> >> >> > This won't work for plug-able flashes. You will influence the nam=
e
> >> >> > in
> >> >> > dt to be
> >> >> > chosen as w25q32jwq, and if you change w25q32jwq with w25q32dw yo=
u
> >> >> > will
> >> >> > end up
> >> >> > with a wrong name for w25q32dw, thus the same problem.
> >> >>=20
> >> >> No, because then the device tree is wrong and doesn't fit the
> >> >> hardware.
> >> >> You'd
> >> >> have to some instance which could change the device tree node, like
> >> >> the
> >> >> bootloader or some device tree overlay for plugable flashes. We sho=
uld
> >> >> try to
> >> >> solve the actual problem at hand first..
> >> >>=20
> >> >> It is just not possible to autodetect the SPI flash, just because
> >> >> the vendors reuse the same IDs for flashes with different features
> >> >> (and
> >> >> the
> >> >> SFDP is likely not enough). Therefore, you need to have a hint in s=
ome
> >> >> place
> >> >> to use the flash properly.
> >> >>=20
> >> >> > If the flashes are identical but differ just in terms of name, we
> >> >> > can
> >> >> > rename
> >> >> > the flash to "w25q32jwq (w25q32dw)". I haven't studied the
> >> >> > differences
> >> >> > between
> >> >> > these flashes; if you want to fix them, send a patch and I'll try=
 to
> >> >> > help.
> >> >>=20
> >> >> It is not only the name, here are two examples which differ in
> >> >>=20
> >> >> functionality:
> >> >>   (1) mx25l8005 doesn't support dual/quad mode. mx25l8006e supports
> >> >>=20
> >> >> dual/quad
> >> >>=20
> >> >>       mode
> >> >>  =20
> >> >>   (2) mx25u3235f doesn't support TB bit, mx25u3232e has a TB bit.
> >> >>=20
> >> >> well.. to repeat myself, the mx25l25635_post_bfpt_fixups is a third
> >> >=20
> >> > sorry if this exhausted you.
> >>=20
> >> TBH, this is no fun (and I'm doing this on my spare time because I
> >> like
> >=20
> > It's not my fault that you're not having fun when someone disagrees
> > with you.
>=20
> The reason is not the disagreement, but how you're (not) answering my
> arguments.
> Like in the other thread, the question about the uselessness of the
> flash_lock
> and flash_unlock tools with SPI-NOR and the (IMHO) bad behaviour when
> the user

The flash unlock at probe was a bad decision, but we can't be backward=20
compatible. kconfig or module param will solve the problem without breaking=
=20
backward compatibility.

> actually uses flash_lock. Please, don't take this personally, I'll buy
> you a
> beer at FOSDEM :p back to the technical stuff.

I don't take this personally, but I think the discussion went in a wrong=20
direction, and I feel that we waste time on theoretical problems.

>=20
> >> open source). I guess our opinions differ waaay too much. I don't
> >=20
> > Up to a point, yes, our opinions differ. I'm not rejecting your
> > suggestion, I
> > just say that we should implement it as a last resort, when there's
> > nothing
> > auto-detectable at run-time that can differentiate between two flashes
> > that
> > share the same id.
> >=20
> >> really like band-aid fixes; eg. with vague information "it seems that
> >> the F version adveritses support for Fast Read 4-4-4", what about
> >> other
> >=20
> > We can update the comment to clear the incertitude: "The F version
> > advertises
> > support for Fast Read 4-4-4""
> >=20
> >> flashes with that idcode and this property. This might break at any
> >> time
> >> or with anyone trying support for other flashes with that ID.
> >=20
> > The jedec-id should be unique in the first place, manufacturers that
> > use the
> > same jedec-id for different flavors of flashes are doing a bad thing. A
> > third
> > flash with the same jedec-id is unlikely to happen.
>=20
> MX25U3232F, MX25U3235F, MX25U3273F, MX25U3235E all use the same 0x2c2536
> identification. And these are only the active ones. I bet there are a
> bunch of older 32MBit flashes.
>=20
> MX25U6432F, MX25U6472F, MX25U6433F, MX25U6435F, MX25U6473F all use the
> same 0x2c2537 id.
>=20
> W25Q32JW-IQ, W25Q32DW, W25Q32FW all use the same 0x156016 id.
>=20
> btw. thats why I argued to just have MX25U32 or W25Q32 as a name for the
> flashes.
>=20
> >> That's what I've meant with first come first serve, I'm lucky now that
> >> there was no flash with the same jedec id as the W25Q32JW.
> >>=20
> >> To add the MX25U3232F I could check the JEDEC revision (or the BFPT
> >> length) because it differers from the MX25U3235F. But I don't feel
> >> well
> >=20
> > I prefer this because it's auto-detectable. If you don't feel well
> > doing it,
> > don't do it.
>=20
> ok, I'll do so for the MX25U3232F support.
>=20
> >> doing that. Who says Macronix won't update their description for the
> >> MX25U3235F to the new revision.. FYI the Winbond guys apparently use
> >> the
> >=20
> > You are raising theoretical problems. We can fix this when we will
> > encounter
> > it.
> >=20
> >> first OTP region to store the JEDEC data, which is clever because they
> >> can update it during production.
> >=20
> > If you say so.
> >=20
> >> >> example.
> >> >=20
> >> > Flash auto-detection is nice and we should preserve it if possible. =
I
> >> > would
> >> > prefer having a post bfpt fixup than giving a hint about the flash i=
n
> >> > the
> >> > compatible.
> >>=20
> >> see above.
> >>=20
> >> > The flashes that you mention are quite old and I don't know if it
> >> > is worth to harm the auto-detection for them. A compromise has to be
> >> > made.
> >>=20
> >> so you'd drop support for them? because SFDP is never read if there is
> >> no
> >> DUAL_READ or QUAD_READ flag.
> >=20
> > mx25l8006e  defines bfpt, while mx25l8005 doesn't. We can differentiate
> > these
> > too.
> >=20
> >> > You can gain traction in your endeavor if you have such a flash and
> >> > there's
> >> > nothing auto-detectable that differentiates it from some other flash
> >> > that
> >> > shares the sama jedec-id.
> >> >=20
> >> > If you have such a flash and you care about it, send a patch and I'l=
l
> >> > try to
> >> > help.
> >>=20
> >> Given my reasoning above.. well maybe in the future. The Macronix
> >> would
> >=20
> > ok
> >=20
> >> be
> >> a second source candidate. For now we are using the Winbond flash.
> >>=20
> >> I would rather like to have the flash protection topic and OTP support
> >> sorted out, because that is something we are actually using.
> >=20
> > You can speed up the process by reviewing/testing the BP3 support. In
> > turn,
> > maybe Jungseung will review your OTP patches.
> >=20
> > To sum up: the flash auto-detection (with capabilities) greatly ease
> > the
> > device tree node description and it allows us to plug and play
> > different
> > manufacturer flashes using the same dtb. I have a connector on one of
> > my
> > boards, to which I connect different types of flashes (assuming they
> > have
> > similar frequency and modes). So I would always prefer to have a post
> > bfpt
> > hook to differentiate between flashes which share the same jedec-id,
> > than
> > compromising the generic compatible.
>=20
> and making assumptions which are true for the flashes you currently know
> about.

I don't want to introduce code which I don't know if it will ever be used.

> > Of course, if there's nothing auto-
> > detectable that can differentiate between the flashes, then your idea
> > can be
> > implemented, but I would do this as a last resort.
> >=20
> > There's also the idea of compromise. The jedec-id should be unique in
> > the
> > first place, manufacturers that use the same jedec-id for different
> > flavors of
> > flashes are taking a wrong design decision. Do I want to cripple the
> > generic
> > compatible just for an old flash with a bad jedec-id? I don't know yet.
> > Also,
> > the flashes that share the same id are quite old, and if nobody
> > screamed about
> > this until now, it's fine by me.
>=20
> See above, the assumption that newer flashes have differnet jedec-ids is
> wrong.
>=20
> > You raised some theoretical questions, you
> > don't really use the macronix flashes, what I say is that we should
> > consider
> > fixing them when it's actually required. And that the extension of the
> > compatible should be done as a last resort, as of now it has more
> > disadvantages than advantages.
>=20
> Well what are the disadvantages? I don't argue against the
> autodetection. I

- generic compatible eases the use. I don't have to check the dtb each time=
 I=20
change a plug-able flash, to see if I gave a wrong hint for the flash in th=
e=20
extended compatible
- people will prefer to use the extended compatible instead of trying to au=
to-
detect the differences at run-time (it's easier, but wrong).

> argue to have a mechanism _already_ in place when the autodetection
> fails.
> If you don't specify the hint, everything stays the same.
>=20
> We could have the advantages of both worlds, have a generic "w25q32"
> which tries
> its best for autodetection and a specific "w25q32fw" which could can be
> hinted.
> Same for like "mx25u32" and "mx25u3232f", "mx25u3235f" etc.
>=20

If you possess 2 flashes that we can't correctly detect at run-time and you=
=20
care to fix them, then your suggestion has a good change to be implemented.=
 I=20
will not introduce code that is not used, in the hope that it will be used.=
 No=20
compatible extension if we have a way to auto-detect the flash.

Cheers,
ta

>=20
> > Cheers,
> > ta
> >=20
> >> -michael
> >>=20
> >> >> -michael
> >> >>=20
> >> >> > Cheers,
> >> >> > ta
> >> >> >=20
> >> >> >> I know this will conflict with the new rule that there should on=
ly
> >> >> >> be
> >> >> >>=20
> >> >> >>    compatible =3D "jedec,spi-nor";
> >> >> >>=20
> >> >> >> without the actual flash chip. But it seems that it is not alway=
s
> >> >> >> possible
> >> >> >> to just use the jedec id to match the correct chip.
> >> >> >>=20
> >> >> >> Also see for example mx25l25635_post_bfpt_fixups() which tries t=
o
> >> >> >> figure
> >> >> >> out different behaviour by looking at "some" SFDP data. In this
> >> >> >> case
> >> >> >> we
> >> >> >> might have been lucky, but I fear that this won't work in all ca=
ses
> >> >> >> and
> >> >> >> for older flashes it won't work at all.
> >> >> >>=20
> >> >> >> BTW I do not suggest to add the strings to the the
> >> >> >> spi_nor_dev_ids[].
> >> >> >>=20
> >> >> >> I guess that would be a less invasive way to fix different flash=
es
> >> >> >> with
> >> >> >> same jedec ids.
> >> >> >>=20
> >> >> >> -michael



