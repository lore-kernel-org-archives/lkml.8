Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9500C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A472080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="CDzKWISe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgEJPci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:32:38 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6076
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgEJPci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewqiKJSNYqt6P6HyyUaLWTdkJwtMrYUXWIqgSW3me59d07KuzSEi0uFZD8BDkCBQTN9rj96zZPyj71beZsb2QlooY+XpMyMNSqWQECiyjdbEENisTc2zoXL2YVeEzv/9Dhh5ahhhxjFbHaYC2+UssXXwCmMr0i2kbvWQdrwF1RN/ug9Qq0wYWLbBgikd6w1oO1jqpf2e3TfdbRiaRE2qdzjL662nj1kAMstVe+rEumpm9fzHHhTPOjubrpVhgv+50+cJNcfpFJDBc9oFxbnVGN6zzT1TklGEsb/aagGoUb+wY6o+CeJw7P73rBb/63Qulyb2wG+0Qx5vLQDn4s1KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE56DstZ339OfsCDeTV1GGD2Mytnt7gt0rGqE7NvJ1o=;
 b=A/9N1jI+MYjWCpabd98oJ0u28apqo3QaicZpJvcgSCC3Qt0dOfwqt7JfGxNZVvIFMqgfwiaou8D0Dh8lakyo/m306wHVKPpub9Rpn2wLL0YBa+dd54cXhkMj63DgeH/ddrSICsdJHv4nxdf8PW8v183LnRQcBPbHfhyoJ1MWkIdLN90UKMSe5j59SmaeDl1c8Wu348E++6hyMpWztTEBbMdLvxc/wYYtGVl5EfsTZsAzMDlHQDTi6PuLWHYSfQ+/cJNoWvA60wxSDZD/4SmN2wL/slo1nF1Ykn87IHjNx7yxk+wn3kXD17rMQUbpTwNZrNe3iogORbLjUV9yWkQl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE56DstZ339OfsCDeTV1GGD2Mytnt7gt0rGqE7NvJ1o=;
 b=CDzKWISePlq/UgBn+KoG2Q1Wx/7kRdAYhuzK/hWB/oEqJtRXAskN7nP4Yi24cSF78eAabvVo/fEG4Ewce2zSCVd3OB7o+C1O90gqHI4WR/LUtlGUG/MPWQ36YTCRpXo5c1yupdT7gAVf6SiQbjYb/cV4DaKRZFRMkQ2VhrctBwU=
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2437.namprd13.prod.outlook.com (2603:10b6:a02:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Sun, 10 May
 2020 15:32:33 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Sun, 10 May 2020
 15:32:33 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Anup Patel <anup@brainfault.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed
 A00 board.
Thread-Topic: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed
 A00 board.
Thread-Index: AQHWHtYDB/cpTmsjKkuAl+bHjseykqiYg+KAgABe/XCAAUf3gIAASp8QgAAV9YCAACZUc4AE69UQ
Date:   Sun, 10 May 2020 15:32:33 +0000
Message-ID: <BYAPR13MB2614D39F1EEF60841112177399A00@BYAPR13MB2614.namprd13.prod.outlook.com>
References: <BN8PR13MB2611968A7252308925FF18B399A70@BN8PR13MB2611.namprd13.prod.outlook.com>
        <mhng-29e22ca7-538a-4094-923f-8fbc0fd327b9@palmerdabbelt-glaptop1>
        <BYAPR13MB2614FE811C8DD83BBDD3A26599A40@BYAPR13MB2614.namprd13.prod.outlook.com>
        <CAAhSdy2-ECrOP=kZOTXxj1t+f8NrcYjbXKDRwPB3KU36mDmWWg@mail.gmail.com>
 <87d07h8qx7.fsf@igel.home>
In-Reply-To: <87d07h8qx7.fsf@igel.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=sifive.com;
x-originating-ip: [116.74.156.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c51b0e68-c67f-4aae-b8bf-08d7f4f75c24
x-ms-traffictypediagnostic: BYAPR13MB2437:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR13MB2437B7FF030419F6491647D499A00@BYAPR13MB2437.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 039975700A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSU2vVxmtGlStnUsKtchojndBgtC3Psv2ZPmmSeUXYnd723spBkyoFoMt/qAxMlgia1oR7+WdTnDi8i7KEumE5si9Hz48/7hWQoaWLBMrv+nL/hUIslnaFH2N58jr4kgXqffYBi2yf9mzBnVNHpLuBo+6p4r9XoEtWeuemPJ05MgzO7V5gkltmdBVzTgxNnbPYP+axeNl8I6TjJyUOP0+0s0LvfJwUpDzlSuaBxoT2tw5sZMPNsM3wbqE4AnLdD/aZ9LbLJFwik6NzR0C/ffs8vXAPwPwxHIyQGw0yL9BKlLVvkpFA1t9m5kApSDNXgLjVjDGUku5GgTApNtfulDHZbrLJiiu418S6VH7sP7wlXDrbnddw3MQqjHNY8aZ8zWIl+2uCXWCaWDmI+dbRpJ18C/nX0EqE/xw3O4X1IT8xaWVN0b8nytYfQ60a+fbz069NhX4/8dQNtso2nQl/gSs9oy5HoGPxVGxLBaRSBw6qvyoKzy9j+aogDIwfEP9H6dXivHsDUwFFZObuicH8/nxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(366004)(346002)(376002)(136003)(396003)(33430700001)(71200400001)(478600001)(186003)(33440700001)(44832011)(6506007)(64756008)(55236004)(7696005)(86362001)(9686003)(33656002)(26005)(53546011)(66946007)(66556008)(110136005)(2906002)(7416002)(76116006)(66446008)(54906003)(8936002)(52536014)(5660300002)(66476007)(55016002)(4326008)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VtE6dZNxFllYVkO5JdZbIqAzMY4Vmfj+vxESoEbwFWSshmGJB5VN2Bo8zWSLjplZmdcGqSp3DWqXslromda2Cx7Kq4TFIxMNNmMtMNsLtI/Ocy0H8A7ouyoAbFXlQLjrPHjjd/93fvoYly1ajwHDm5bTA/MCM0rG+fH0EIY2o5P2gTjQkr3VHlXGnOAk8CF85Pnx/hDEdQOYeu4z09LXWJC7nD15QmJGmRvu7Bz8imV00Tnuj/mBasneDzIIvSlQ/duK4Nw6F7lbrhkykauLkw7vENX615VB2fjYZP/0TfTGCVrDdBw7ncap4c/Nh3vbz/ty3H2MJyZnGY2KQhvVqwT6mk/qlG7AKDme28EuTOYv7Ozfo2ZwT9LVG7TCmqKbw4k95rUzeUw5t5/l1gespRLkKe1R3brsYHs/fubULNJcpbv0D+TwgTzXr0ZZbjI3kiOkucffgDj34z+zabe3XV+xxY2NZp/eUI7aUtpNIh665p1/y7LGLdezDirkPFTd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51b0e68-c67f-4aae-b8bf-08d7f4f75c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2020 15:32:33.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXM9IRYx1JSYeb+cnFphflaAMbPlb97FonilITmjYiQQMtcwr3N9RzNQnW4WgxAuqV+arALSmj7iXvwBKrl2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Andreas Schwab <schwab@linux-m68k.org>
> Sent: Wednesday, May 6, 2020 12:57 PM
> To: Anup Patel <anup@brainfault.org>
> Cc: Sagar Kadam <sagar.kadam@sifive.com>; Palmer Dabbelt
> <palmer@dabbelt.com>; vigneshr@ti.com; tudor.ambarus@microchip.com;
> richard@nod.at; Paul Walmsley <paul.walmsley@sifive.com>; linux-
> kernel@vger.kernel.org; linux-mtd@lists.infradead.org;
> miquel.raynal@bootlin.com; linux-riscv@lists.infradead.org
> Subject: Re: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unlea=
shed
> A00 board.
>
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>
> On Mai 06 2020, Anup Patel wrote:
>

Thanks for suggestions Anup and Andreas.
I missed to reply, sorry for that.

> > We had build issues in past by selecting major driver subsystems
> > in Kconfig.socs
> >

Please let me know if I am wrong, are you stating about the build issues, f=
ixed in
commit bd6f20333c67 ("RISC-V: Only select essential drivers for SOC_VIRT co=
nfig")
which was due to all platform dependent and independent driver's enabled in=
 Kconfig.soc
for virtual platform.
Kconfig.socs as meant for platform drivers we can guard SPI_SIFIVE with a g=
uard "if SPI"
so that come across " WARNING: unmet direct dependencies detected for SPI_S=
IFIVE"
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,7 @@ config SOC_SIFIVE
        select CLK_SIFIVE
        select CLK_SIFIVE_FU540_PRCI
        select SIFIVE_PLIC
+       imply SPI_SIFIVE if SPI
        help
          This enables support for SiFive SoC platform hardware.

> > I suggest to select SPI_SIFIVE from Kconfig.socs
>
> SPI_SIFIVE can be m, don't override that.
>
> Andreas.
>
Currently SPI and SPI_SIFIVE are default enabled via defconfig.
In Kconfig.socs if we force the config  option using "select" SPI_SIFIVE wi=
ll lose its configurable option.
So I was thinking of using the weak dependency using "imply" as above, so t=
hat SPI_SIFIVE can
still be modular if required i.e 'm'.
We can then have other platform independent driver's ( SPI, MTD and MTD_SPI=
_NOR) required for
enabling SPI_NOR flash into the defconfig.
This way we can have SPI_SIFIVE in Kconfig.soc's and SPI_SIFIVE will also b=
e modular
Please let me know your views on this, or if I am missing something.

Thanks & BR,
Sagar Kadam

> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA
> AEC1
> "And now for something completely different."
