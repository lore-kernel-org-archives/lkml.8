Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62313C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285612054F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wj+TOXnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEOIlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:41:35 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:42578
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbgEOIle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:41:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGoGJ1qFcUckiq566mdX4ob9IwJmzHm+szmp7MaWL/COH13cLRlAR4IllCW4Lp7VQic1ItOsuFwhXX2WOhdPzkrY7dpje4jKW7+dqMPyAE7LenzEV4iu4Lnc+FMbxKs3iSFvHKtCYQUk5zeeJVjWGopc5etNmPqDA8terAaZAUpmlV/I9W1C8dakqWX6YN7nVrM6yPaJ5hyFLbhxaqJrHLSk+VZIE44M/070X6m5oCieqIFbJKrTYkIptwE88sbwD+wgy0HrY+H/daDa6KDgVC+vX3IwrQed/MkBvaC8ABU15A2ijKt/RHw0W5HNdztE/al9nlCwP/nFdHcI4CUO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EEAKB5esFSlZ8D/393HhvPTpht8CVcE54s1sgwTmcc=;
 b=gOL5Rabczid9hTu0dO/uAZaK5C+a6F+kp5DCZ/W5OHSedOsIRfpug9PDKuJhFduymtzTGAdMyLi8r2GfCLhMdqX7VFXQFr7Kp2g8GVrXIPKiy0HhhR/GgfB7StkrPhWv4OeIOQ2cRassK4TidtrCapf1sNKudp04bDocN2hkCct8p9sV43+E0RkqZPfObiD3HthnIs1U3p/d+llZzoJg9MmD4t+D/HgYiMgu8XkDoX4P5lQm+vfOcsuzrypxAC4bPsL+vI1G6ipZO/z62d3oI4xC1B6I/Y0zaozz2DMLIAa23FUwA7V7RRBOi97DHedbm6yLbazHU3sI1QQxp8dCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EEAKB5esFSlZ8D/393HhvPTpht8CVcE54s1sgwTmcc=;
 b=Wj+TOXndMybcFZAjtk4Ysm/QIjRTnojy8YWV9yntzg7ytOooSkWrynm8Gk6Xym2nUe/GAxcdrcoItE9o/K+BS/teyVX4mX6m0inAkjDHaeiWn9Q6KPBpVMLJsM113XQoiApZ6NsF0+fdG+73RsR8uqGRRTYRVizsz9nuIItTQF8=
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (20.178.206.140) by
 BYAPR13MB2725.namprd13.prod.outlook.com (20.178.206.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.13; Fri, 15 May 2020 08:41:30 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Fri, 15 May 2020
 08:41:29 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "anup.patel@wdc.com" <anup.patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: RE: [PATCH v1 2/2] spi: nor: update page program settings for
 is25wp256 using post bfpt fixup
Thread-Topic: [PATCH v1 2/2] spi: nor: update page program settings for
 is25wp256 using post bfpt fixup
Thread-Index: AQHWKeYAxlvBjs/+4kCjqacoVp02OaioumMAgAAX5fA=
Date:   Fri, 15 May 2020 08:41:29 +0000
Message-ID: <BYAPR13MB2614A8044A8AA51A3C0E020A99BD0@BYAPR13MB2614.namprd13.prod.outlook.com>
References: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
 <1589457051-5410-3-git-send-email-sagar.kadam@sifive.com>
 <20200515070436.hk5ho7ygluqznpcq@yadavpratyush.com>
In-Reply-To: <20200515070436.hk5ho7ygluqznpcq@yadavpratyush.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: yadavpratyush.com; dkim=none (message not signed)
 header.d=none;yadavpratyush.com; dmarc=none action=none
 header.from=sifive.com;
x-originating-ip: [116.74.150.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fdd7f0a-8395-4fd2-d43f-08d7f8abc379
x-ms-traffictypediagnostic: BYAPR13MB2725:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR13MB2725B1615CAF711AFA951A2499BD0@BYAPR13MB2725.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ajdq5p4KbsqPnT7sbFaSt8HKM7kCVHbV/XeG/KvokAE90QL6OfeE5pL9T0g64qpvV0TCtQHS22L5qvXYZefnHwB8Fs26tdUHQ4Y8RGqfpupDq26TozlYpfeQePEXVGBbmTNAAu035m28wzlmJjt+EIy22U8e4ZNum4WLCyl8ukXF/oVMCqoAlMOgELrB7PPBHpyBnh/QTUL9B16WFqwwTcVbhYM2J1RyCrV5o4/AaKo1M/oK9yEOkCSR3eLC/cAWYf/1xWhSvD4zwK1UwW52qZOn5eCbg1N2oHOtoSYLtHOSLe/WhUrBxx/x6Ixc/rNMJb/GhDovKeFuiMizWglzi2IhKblW+sOd6vCo9oExWT+JKa6LFaHs0ScjSlkLmaIZXZJ29HuusPxvbJcFDePtNNz7/lAn7EO2pMWzaKZv8g5fjRbJFDZZrSNsWs4m43KH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(396003)(366004)(316002)(66446008)(9686003)(6506007)(8676002)(71200400001)(26005)(86362001)(55236004)(4326008)(53546011)(7696005)(7416002)(64756008)(66476007)(478600001)(66556008)(8936002)(44832011)(15650500001)(33656002)(2906002)(6916009)(54906003)(76116006)(107886003)(5660300002)(55016002)(66946007)(52536014)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lvd+oDoykGMn8dliuf1v0n1ADn1Fp/W3Z+Tc6G9PqQ605TuEGAY5wKL+mE3SmfqSK4CkQ0U8R/nejcJunNDOuqx7hjZUoQTdXJdR87ubOjhMrYLOH3My2MeT1HJF1ptW7gSJAXY14oD4ycdwqmTz9y9DlxchZSSq9Jj5kLKUtexactVXrE8LSEKx7l5IZWcVCeoekL+JkeGowvBrfVVfcmeXe+/Vu2zInRx3miQ9YpP3w2v7bHUCqSzhtSXwH5y7itS+fgDdnAn8CttQOLqmCfzEnTWhIPedIG0yoCscpCT8CcmeNd1GXK4RtpUUWZ2lA5XhuE4SNR68fsZSrcsR+NQyuxxZtMhuFIXGbOT7P/CHeqq7UNe1OdxD5uIF/mn24GRyFDWKjSA4pddhNQTUaref37sHWRKrboySMVstXbX5L2wGbNLzXFwYEtnYcZv0BovapQFaZeVqmETtP/APfVo8aJMezQYX7UMPsfTnM0w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdd7f0a-8395-4fd2-d43f-08d7f8abc379
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 08:41:29.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgXSQfxrF5eor72FFZSYnPwV24LvVmHw5Cr1n4qpZtDJhm/OfxxikI51/FuZfsGYZe8lsT4fWlUEqPcAfHYB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

> -----Original Message-----
> From: Pratyush Yadav <me@yadavpratyush.com>
> Sent: Friday, May 15, 2020 12:35 PM
> To: Sagar Kadam <sagar.kadam@sifive.com>
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mtd@lists.infradead.org; tudor.ambarus@microchip.com;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com;
> anup.patel@wdc.com; aou@eecs.berkeley.edu; palmer@dabbelt.com; Paul
> Walmsley <paul.walmsley@sifive.com>
> Subject: Re: [PATCH v1 2/2] spi: nor: update page program settings for
> is25wp256 using post bfpt fixup
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> Hi Sagar,
>=20
> On 14/05/20 04:50AM, Sagar Shrikant Kadam wrote:
> > During SFDP parsing it is seen that the IS25WP256d device is missing 4B=
AIT
> > (4-Byte address instruction table), due to which it's page program
> > capacity doesn't get correctly populated and the device gets configured
> > with 4-byte Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1
> > even though it can work with SNOR_PROTO_1_1_4.
> >
> > Here using the post bfpt fixup hooks we update the page program
> > settings to 4-byte QUAD Input Page program operations.
> >
> > The patch is tested on HiFive Unleashed A00 board and it benefits
> > few seconds of average write time for entire flash write.
> >
> > QUAD Input Page Program operations:
> > > time mtd_debug write /dev/mtd0 0 33554432 rd32M
> > Copied 33554432 bytes from rd32M to address 0x00000000 in flash
> > real    0m 32.85s
> > user    0m 0.00s
> > sys     0m 31.79s
> >
> > Serial Input Page Program operations:
> > > time mtd_debug write /dev/mtd0 0 33554432 rd32M
> > Copied 33554432 bytes from rd32M to address 0x00000000 in flash
> > real    0m 35.87s
> > user    0m 0.00s
> > sys     0m 35.42s
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  drivers/mtd/spi-nor/issi.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> > index ffcb60e..9eb6e82 100644
> > --- a/drivers/mtd/spi-nor/issi.c
> > +++ b/drivers/mtd/spi-nor/issi.c
> > @@ -23,6 +23,22 @@ is25lp256_post_bfpt_fixups(struct spi_nor *nor,
> >               BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
> >               nor->addr_width =3D 4;
> >
> > +     /*
> > +      * On IS25WP256d device 4-Byte address instruction table doesn't
> > +      * get populated and so the device get's configured with 4-byte
> > +      * Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1 even
> > +      * though it supports SNOR_PROTO_1_1_4, so priorotize QUAD write
> > +      * over SINGLE write if device id table holds SPI_NOR_QUAD_READ.
> > +      */
> > +     if (strcmp(nor->info->name, "is25wp256") =3D=3D 0) {
>=20
> Instead of doing this, wouldn't it make more sense to have a separate
> fixup hook for is25wp256? Does this device also need the above address
> width fixup? If it does, maybe that can be split into a separate
> function, and used by both the fixups?
>=20
Thanks for suggestion. Yes this device requires the above address width fix=
up.
I suspect that this QUAD mode fix might also be required for "is25lp256" de=
vice.
But since I don't have it on my board, I couldn't validate it. If someone c=
ould give it a try
on "is25lp256" device and confirm this, then I guess we can remove this che=
ck from=20
here "if (strcmp(nor->info->name, "is25wp256") =3D=3D 0)" and rename the is=
25lp256_post_bfpt_fixups
to is25lpwp256_post_bfpt_fixups to use command fixup for both flash devices=
,
else I am also ok to split it into separate function as suggested that can =
be used by both fixup's

Thanks & BR,
Sagar Kadam

> > +             if (nor->info->flags & SPI_NOR_QUAD_READ) {
> > +                     params->hwcaps.mask |=3D SNOR_HWCAPS_PP_1_1_4;
> > +                     spi_nor_set_pp_settings
> > +                             (&params->page_programs[SNOR_CMD_PP_1_1_4=
],
> > +                              SPINOR_OP_PP_1_1_4,
> > +                              SNOR_PROTO_1_1_4);
> > +             }
> > +     }
> >       return 0;
> >  }
>=20
> --
> Regards,
> Pratyush Yadav
