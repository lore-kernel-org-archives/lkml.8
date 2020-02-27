Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC9C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C9A2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="LrRlfds0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgB0UY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:24:26 -0500
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com ([40.107.223.85]:13664
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbgB0UYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:24:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7RYP7wPuyMtXlInKAfCy0KlWkNXoti3fiaRjIbP1yiFIS0/ZARjwH9zQY34sh1vA8FrF6rA4qJF7pOQVshdP+L3S+0OeKi+kWmJxOZL8Hw6NJhzbFUTJ/YUsKtMxApSqJmCQPmqJ6iJ3YuESC1NRx9TL8oNLjQlorIbUXzhldfVEzrA97XGM0CK/IeHzCn7KHx5RYXFW/LBm1Nq8K+ZZltm66kc6upgr8+4X7NAzSWMaFmkuhTXZJGg1n8wObJUUoP2uClx3CD0YgSNdQd/xO009z1XHDwdp7ORclbdEJv3B0SpBOIxPBcfVP7l9gt9pxzgDofkauybDkY+43Dt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDfWROweiK7qIR793QDQD30pwX6Vl91e+/VkMgr18H4=;
 b=TwgThDfTrG5vILQ83QQJ19pi9Vv15LykTBBXrMk9L5DDxRTNWRYbFSe0AzjeWIdCcdnHHozbZoQhE1TgphME7alNvsD94Os6+OAKXXqpA1OWg45OTxkMwYO1q/IHmzKBwSZjj2lXZPmLcMriCuFPYwCPHBGcr6p0O1Dkatn/lvyRREJHky6j/f1/SjDpVmlijbxpD9yqxxTSyK9ph/fq2/ESAHZEIlDXXzqrEL8T4yRIvWKfOpsAj9slqKCpe4HZgnHhSRF1D/H4h99+x17nDM83EggpMFzp3WpRR24Dd8CXUYUDAXBS58CQc2+3HjQrHySLWfW1hSJQIBKCDc/AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDfWROweiK7qIR793QDQD30pwX6Vl91e+/VkMgr18H4=;
 b=LrRlfds0I0yA/6cFFu9t6MUBZjva0JkiSIVrOT/5+UC02BjO3dqVvmnlQ8PaxeJg8gSNkr/o0JHx9Pe37fTLnRd2sigi9uIiNdTEXYGcbvMuBFHpd4637/DSNLA/JXRnkzSy/PTZNiJ6H4nMkN2t9rvfxSehrN27N0MIS/xhDmQ=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB5982.namprd08.prod.outlook.com (2603:10b6:208:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 20:24:22 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 20:24:22 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH v4 2/5] mtd: spinand: micron: Add new Micron SPI
 NAND devices
Thread-Topic: [EXT] Re: [PATCH v4 2/5] mtd: spinand: micron: Add new Micron
 SPI NAND devices
Thread-Index: AQHV7Zrt8nxb4M5o4EyJweDi+Kt0uqgveTTwgAABmICAAADTkA==
Date:   Thu, 27 Feb 2020 20:24:22 +0000
Message-ID: <MN2PR08MB639762D89F85C2556F51D48EB8EB0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
        <20200206202206.14770-3-sshivamurthy@micron.com>
        <20200227192247.52f84723@collabora.com>
        <MN2PR08MB6397477172BAC14986175E6DB8EB0@MN2PR08MB6397.namprd08.prod.outlook.com>
 <20200227211759.7ba02273@collabora.com>
In-Reply-To: <20200227211759.7ba02273@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjBlZTliNGItNTk5Zi0xMWVhLWIxZTktOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDIwZWU5YjRkLTU5OWYtMTFlYS1iMWU5LTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iMTQyMiIgdD0iMTMyMjczMDg2NTg1NjgyNTE3IiBoPSJaVi9PZFhVRXptOWNRSUt3WHZqYm1Mak5aUm89IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIQUFBQUJWdWtqanErM1ZBZCtwNnRwT1d3V2wzNm5xMms1YkJhVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFCQUFBQUFYbTFpZ0FBQUFBQUFBQUFBQUFBQUE9PSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.86.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d8784e-3436-482d-13b0-08d7bbc30834
x-ms-traffictypediagnostic: MN2PR08MB5982:|MN2PR08MB5982:|MN2PR08MB5982:
x-microsoft-antispam-prvs: <MN2PR08MB598219082C9D6FE3492C8342B8EB0@MN2PR08MB5982.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(55236004)(26005)(4326008)(6506007)(2906002)(7696005)(54906003)(86362001)(186003)(478600001)(316002)(76116006)(66556008)(64756008)(8936002)(9686003)(81156014)(52536014)(5660300002)(8676002)(55016002)(71200400001)(33656002)(6916009)(66476007)(81166006)(66946007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5982;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ROWOrv8tsawYM6LAzq1Ta6khJbvUvDR4mR1nswnCbC7V8fQikr/U3OgqojH4OkXxwvZbAy5tunfzRp+x/QG1VZ74XgR/DUr+NR6lOIcsuSEDohoRpDV+0MjryXY5lyzG2q/bI146R+xJ/Bsbqpy/K++z6BlXyFHlmijqpiWqWQCOcFAFeYSZ+zeEgvnx+2wtY6TuuNbceDXGJdMIR3iKMczf1MuacrGwCHqvTTUwJqx5CpLR6B1YtF0lm+aFkxCbfXJ4BXmW2mEqJFc5Mp4bFZT0Q1ILDPaUuUThKlM7BZiw2tiADkQK5Fk6D5a0wz53yy9ontMKFQfAdWJYnoR5kBprJqAH96YroYtJEhERvZaPLgRbFoHlAZyLfHXmtPTD1zaIilgwTy65YrobIdthm7nOeVdt6E7bj516t7q8XSyMRFNliLEWOobB874DRTXG
x-ms-exchange-antispam-messagedata: f3STYP3uigmdMpClsO7wTmppLNbHUJOdAhYqISLPjMQeIY4iPFI6TsTS+Ao76n3NlbvYthYSZxEaqLdOIPjL9PW5itpdISz83I55LtO/rINIQriUENJHq8DYtWHJQGMc25omjuFnEeIEgV/nr3evBQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d8784e-3436-482d-13b0-08d7bbc30834
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 20:24:22.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cR1OeIEpPtmH0I+jt9TGg2s4bm7ELGJOgpydOyynsf3yxhtIVP+lCkBN0Jjdk/WECME2YbgwBYRnf8FxGF4dPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

>=20
> On Thu, 27 Feb 2020 20:16:46 +0000
> "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:
>=20
> > Hi Boris,
> >
> > Thanks for the review.
> >
> > >
> > > On Thu,  6 Feb 2020 21:22:03 +0100
> > > shiva.linuxworks@gmail.com wrote:
> > >
> > > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > >
> > > > Add device table for M79A and M78A series Micron SPI NAND devices.
> > > >
> > > > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > > ---
> > > >  drivers/mtd/nand/spi/micron.c | 31
> > > +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > > >
> > > > diff --git a/drivers/mtd/nand/spi/micron.c
> > > b/drivers/mtd/nand/spi/micron.c
> > > > index c028d0d7e236..5fd1f921ef12 100644
> > > > --- a/drivers/mtd/nand/spi/micron.c
> > > > +++ b/drivers/mtd/nand/spi/micron.c
> > > > @@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct
> > > spinand_device *spinand,
> > > >  }
> > > >
> > > >  static const struct spinand_info micron_spinand_table[] =3D {
> > > > +	/* M79A 2Gb 3.3V */
> > >
> > > Should be added in a separate patch.
> >
> > Okay, I will create separate patch for each device.
>=20
> No, I meant just for this line.

How about including this line with 1st Patch?
