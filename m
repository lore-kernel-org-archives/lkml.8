Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F5BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6B320882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="C2SdqW09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUMXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:23:24 -0500
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:2947
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbgAUMXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:23:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRlVTWtqR5g21jhapZZ4A7t05V6NLoKTst2fypA2DKqPTfC1jzLx7SVwr2JGSnunLFR2gEUQgR5wu4TLgZvZR4Rz3IBW9MnMbjg9Oa/YDX5HVm03g8km7ZJFh4VHMpcE4HDEgUJKBo811nnOJCj1JgR9jTQrvm6wzIM8kxon6wyI8RfFf1o/IoWXnxY+MOfAXfA4tV7y0Ik/apCt+zbIQeBaGWxOtIo1Apln9sOvhaUgK1SNtso95k6+7AblF9BWoIKf7WFnOLud30uG0YMhKu0224x2uzHQjTVx5ejB4fKkeuGT5hT0zNTkWsQuRln21R0HClPCouBqgHrfyJ0lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQiUZmfKlDzitUKrz5GZy7FwddUcS/XIGunNuGweFA=;
 b=Jy39PU6w6w91HCygPAmYt61TN5ePKbrKUyKNeuKO8agms03dc3fLqDr9i1boCU3y2V96uvGqN1HWUPvUsG1ZjlFXi3VDOytlqX9aKCrpXBwiuJE1aFdAMwdmkMtXDrsNsU55QdbwOGsVLWeVzIMbdDIJsw0RkzPm6r32KbXAdgVV7yvMNyLQq2iGLbNNEA1sx+xK8eiul6i2d1En072AK3eQFyMcPx0kYl73ZZelLWXByba9S496J/qP8XNdRk62KvQ4i+XMYvg2DTKolT7vBgsrSMb8jeh+WypZwmubnqSqjX7Pfi3ciMA3kHdjmhtkzWfmnSqzn5I6JeSNDJ/JFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwQiUZmfKlDzitUKrz5GZy7FwddUcS/XIGunNuGweFA=;
 b=C2SdqW09rvMmvB7tm8A38y3hLDJbb7m+wooTjhv4aJnIeemH7cFSNs22fkxmfQh03zGOjq593mf8dyH9C6My2K7f2PcR5QXlCzQpkoMd8AQBlyAR5muoxHDyT8DbvxqP4RuiHfUlRXZylelVc77x7AFG+xfm8cNFydsIaHdMN2U=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (52.132.170.74) by
 MN2PR08MB6206.namprd08.prod.outlook.com (52.132.168.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 12:23:20 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::61af:ed8:e19b:cb6a]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::61af:ed8:e19b:cb6a%3]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 12:23:20 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shivamurthy Shastri <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH 3/4] mtd: spinand: Add M70A series Micron SPI
 NAND devices
Thread-Topic: [EXT] Re: [PATCH 3/4] mtd: spinand: Add M70A series Micron SPI
 NAND devices
Thread-Index: AQHVz3qxhHT4F5gqHEqpiIf5nVR3gqfzXyrA
Date:   Tue, 21 Jan 2020 12:23:20 +0000
Message-ID: <MN2PR08MB6397062A37D39287E820A0D8B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
        <20200119145432.10405-4-sshivamurthy@micron.com>
 <20200120111626.7cb2f6c5@xps13>
In-Reply-To: <20200120111626.7cb2f6c5@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2Q5ZTAwNjMtM2M0OC0xMWVhLWIxZTMtOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XGNkOWUwMDY1LTNjNDgtMTFlYS1iMWUzLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iNDM2NSIgdD0iMTMyMjQwODI5OTgzNDIwNzUyIiBoPSJENEllMVVhU3pnR0JJV21yY0xkV2pUYjZKU0U9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.80.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fc5ed83-ea0d-4175-9f75-08d79e6cb3c5
x-ms-traffictypediagnostic: MN2PR08MB6206:|MN2PR08MB6206:|MN2PR08MB6206:
x-microsoft-antispam-prvs: <MN2PR08MB62067104D687323D1A162B3FB80D0@MN2PR08MB6206.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(64756008)(66556008)(26005)(66946007)(478600001)(66446008)(186003)(54906003)(71200400001)(66476007)(55236004)(6506007)(8936002)(76116006)(81156014)(81166006)(316002)(8676002)(6916009)(66574012)(86362001)(55016002)(4326008)(5660300002)(7696005)(52536014)(33656002)(2906002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6206;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZaFMRp8xKyasSvyD40mM4SNG10KV3nUkoDrDX5BfX/F33vFTjKSm4FWC8siBuhuR7u4WzEbYdTKq0FABj2Th+L7p2PynDIjWytVkt9J42NGSJpdSkG7g6ug3dyB1Fhv2Y9/VJXq5oUdz3KsrOkOWP6Mr7wWLBlIFWJtk4gkLXP/w/4J1iXo9drroFxvaEmX0yODoETzi/Lfo4gwD4fzOYdJuRhwiWD60BiwewRaACylsTz1aPLwZ6yVae9bxh1ZBsIc7ENWF/FTv+N/2jZOOF+EiPmYeENXJ66ANPQpX3ve5qNWtIqrur5Y+f2aMuakbwL8DJx/xSyoPlnujTAepCkQF79xwWL5mNI68sh2QXjbHerf+GFxWHRNU2Rd+WsdvOQ/v3LkjAhTYbP0nseBo9dwd7j2zy+SF4YMnJfbZH4wBzooa3u8nigyw9XtahfGv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc5ed83-ea0d-4175-9f75-08d79e6cb3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 12:23:20.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TMww87rkb/cdCPh5qRYSd2N/3LOFpOFz6RxoU6NmsuyD68WssxjG50LJw3dXvQ3pPF9zmPBxRl2ywWeKCZFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

>=20
> Hi Shiva,
>=20
> This is remark common to the four patches: you miss the 'v2' prefix in
> the object.
>=20

Sorry for this mistake.
I recognized this after sending out the patches.

> shiva.linuxworks@gmail.com wrote on Sun, 19 Jan 2020 15:54:31 +0100:
>=20
> > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> >
> > Add device table for M70A series Micron SPI NAND devices.
> >
> > While at it, disable the Continuous Read feature which is enabled by
> > default.
>=20
> Can you please give us more detail on why this is an issue?

"Continuous Read" is the new feature added by the Micron for=20
M70A series devices. If this feature is enabled, the READ command=20
doesn't output the OOB area. The following short description
describes this feature.

Description:
If the Continuous Read feature is enabled, the device provides=20
the capability to read the whole block with a single command.
However, the read command doesn't output the OOB area.

Read command behavior (if Continuous Read enabled):
The READ CACHE command doesn't require the starting column address.
The device always output the data starting from the first column of the
cache register, and once the end of the cache register reached, the data
output continues through the next page. With the continuous read mode,
it is possible to read out the entire block using a single READ command, an=
d
once the end of the block reached, the output pins become High-Z state.

>=20
> Shall we backport it to stable?

This is not a bug fix and applicable only to M70A series devices, there is =
no
need to backport.
(FYI, the previously enabled device was M79A series)

>=20
> As a rule of thumb, when you start a sentence by "while at it" in a
> commit message and this is not a trivial change : split the patch,
> please. Unless this is really related and in this case explain how and
> why in the commit message.

Okay, I will explain in my next version.

>=20
> >
> > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > ---
> >  drivers/mtd/nand/spi/micron.c | 31
> +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/spi/micron.c
> b/drivers/mtd/nand/spi/micron.c
> > index 5fd1f921ef12..45fc37c58f8a 100644
> > --- a/drivers/mtd/nand/spi/micron.c
> > +++ b/drivers/mtd/nand/spi/micron.c
> > @@ -131,6 +131,26 @@ static const struct spinand_info
> micron_spinand_table[] =3D {
> >  		     0,
> >  		     SPINAND_ECCINFO(&micron_8_ooblayout,
> >  				     micron_8_ecc_get_status)),
> > +	/* M70A 4Gb 3.3V */
> > +	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
> > +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> > +		     NAND_ECCREQ(8, 512),
> > +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > +					      &write_cache_variants,
> > +					      &update_cache_variants),
> > +		     0,
> > +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> > +				     micron_8_ecc_get_status)),
> > +	/* M70A 4Gb 1.8V */
> > +	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
> > +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> > +		     NAND_ECCREQ(8, 512),
> > +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > +					      &write_cache_variants,
> > +					      &update_cache_variants),
> > +		     0,
> > +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> > +				     micron_8_ecc_get_status)),
> >  };
> >
> >  static int micron_spinand_detect(struct spinand_device *spinand)
> > @@ -153,8 +173,19 @@ static int micron_spinand_detect(struct
> spinand_device *spinand)
> >  	return 1;
> >  }
> >
> > +static int micron_spinand_init(struct spinand_device *spinand)
> > +{
> > +	/*
> > +	 * M70A device series enable Continuous Read feature at Power-up,
> > +	 * which is not supported. Disable this bit to avoid any possible
> > +	 * failure.
> > +	 */
> > +	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
> > +}
> > +
> >  static const struct spinand_manufacturer_ops
> micron_spinand_manuf_ops =3D {
> >  	.detect =3D micron_spinand_detect,
> > +	.init =3D micron_spinand_init,
> >  };
> >
> >  const struct spinand_manufacturer micron_spinand_manufacturer =3D {
>=20
> Thanks,
> Miqu=E8l

Thanks,
Shiva
