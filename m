Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497ABC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E480B2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JbkmT7fU";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I93ep6EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDUElD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:41:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46240 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDUElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587444061; x=1618980061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rfznibZJMcgkLrqQVbBTO36dDtPwbkixebVCYnwnGrc=;
  b=JbkmT7fUEtKR2yNPEBS3P/DR9R5EMBLtH41tG1L+DxvNkA6zQBR3f/5x
   26isxZG9EvQTQiQxrKC4XbBGHB/06t1gH7gMFEKQUI6GSAKUV+Yalf5pF
   WLa2ylmb8eDd9DhYJIx6nqhg8dxCdroZ1fMsBIduZkrzVT1RQuiW3GNj6
   o7C8zeYluJotR5X0PhDWhCgU9xKL329HM5zfkj9uAsCKQuTUv5IM4XD1W
   2H8SzyiBf5jJxuzPPG8+o9lpyrVCDA5qr1wMP35FOTEjQDuRhBjVRs6na
   7mWymLDK3338Hu0CrUCVVr9mq3YFbJ30UoJzb74xcBMIEo6b4xTOPP2a2
   g==;
IronPort-SDR: hb62XXifCNpOHPMXkSDS0nWjNn63yrWZ4WEMWefoImClC2Q38h0cHfJbrvdU9t8YViR8wbewmQ
 SVsaVYNsC9VTbPW3dIopv8jWIFo50O6rGWyB1EXZdedo/rE5AfYY4ceEJekWw902hygfRVgfIt
 d8tct5bpLupp5q0IAV8+TsMelSHFXjWraarg/5/HtbDwZxN5oxTEKFTz6Af+HRvYMInRbbRv8o
 xz2nnhPBwefk6MmLvUz08QE4GwTca+JMyMsunutOm0I0YKaVYC53Qs95atc9TjOgWtq0gN1r85
 3Vo=
X-IronPort-AV: E=Sophos;i="5.72,409,1580799600"; 
   d="scan'208";a="76659645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 21:41:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 21:41:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Apr 2020 21:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqaGoM9yVMJ9LnXS1TCpBIqUBzrlw2WxTmbRQlCoynozApeLmLtxHhvlDEC/kvP5NRkwzER4YK233dGZhr57/j8PtIyjnZiRRlzqeB6/GsL0aXhMNQKU+zaR1nI2c40WISRSjXw43oeV0sKsXo58MPrLfCCwBDU+cfuUJhc6/HhRMZBa/uNuufq4By+JAa94CqOUONTHMc4UJw9PN1OI72zObOkei6TC2XcfUK7ARKnkkN3C7azbZ1TocPzXDS3oncY1kT4A5dGNGOZeKXUbnOq4pbZ9lu1f9PQxcHAEQF1JUUrYYnvfEXN21aNBu6SK87F/RoOPl+ZwHRvAn0O7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkTkVHiehOnQwmLG1BZmfbVOb64g7hfQbi6Qr6OlIdQ=;
 b=DBfc2glOec7cN4uTkcaogzX6q6pxCLbG1LuPRMqk9yuLG+iKcUVjtlY9inb7ntglLUihTucC+FHxVXaJby2KTkFdKlg1SEP6SKfKiYp4D02RNlsgaJNQC26xBgIckX6CscAK9qZWhPhONCGJxVpbiL0mCMnYGeM5J4pDU0nMSbfiy3W/0UrvA9NZUT300WgadOkVnVPhgjNrGlSEM4/27i6b07qPOz8ZfxMEKEML2iyIT0kznhfbvfYRbiSco6MX4IAi9jYqufHqko9T/7LsZk/yDr6FsATJlrea1yNvwSgVUpPMR31KBvZ8P8ZJrFRaz1CF/C8g9/04aIP78wbfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkTkVHiehOnQwmLG1BZmfbVOb64g7hfQbi6Qr6OlIdQ=;
 b=I93ep6EPnkYYY+Aa3XD/GXCijJNtWq6GGox+9ChqUHwOzuv+Kk1GZpHrEC9MgSQQP/x1ZxAKp9qFhopniKHcs0/nXwPUGI1dNympB31TbxEBWbjtOhjKOYMOwIm6siW9xyVxTQ5aniX+fI4OtBLbs7VZ4cxGZwJ2T9hadMilOF0=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 04:40:57 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 04:40:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <cleger@kalrayinc.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for is25lp01g
Thread-Topic: [PATCH] mtd: spi-nor: Add support for is25lp01g
Thread-Index: AQHWFw0/tWJ4ISRUwk6rGADNBybaDA==
Date:   Tue, 21 Apr 2020 04:40:56 +0000
Message-ID: <2185268.xDFeLDFsC1@192.168.0.120>
References: <20200417160839.25880-1-cleger@kalray.eu>
 <1950407.5XCTmqoEVg@192.168.0.120>
 <1734428336.16421904.1587394202163.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1734428336.16421904.1587394202163.JavaMail.zimbra@kalray.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daae8b8b-864a-4902-6a99-08d7e5ae2ee9
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-microsoft-antispam-prvs: <BY5PR11MB4483AE904615A2349F02E12CF0D50@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(66556008)(66574012)(4326008)(478600001)(66446008)(8936002)(66476007)(64756008)(81156014)(66946007)(26005)(6916009)(5660300002)(316002)(91956017)(8676002)(6486002)(76116006)(53546011)(86362001)(2906002)(6506007)(9686003)(6512007)(14286002)(71200400001)(186003)(54906003)(39026012)(138113003);DIR:OUT;SFP:1501;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6ZicMCHfX4Wj9lUDl6Z8XdD6M7bfuvPBrjrlLWY6yYqlXYWNbafBEw/rIzKpXEKSx1+CiX3rqxmzzFnUOUAqqhcIidH7sekdla6cZM7x1e0f6LErHgrj7Jw9t9gDPG2xe+lJmVrY0Ef5u47ecWdF5wuzADU4Bb4zeZw3vVWdSiMPu3yW38fLmeTB3dNTvxx46bFv+7IjoVmwJPiynOy3H4msdHNBDS4GQMQfOO8Mkr5hb6qh2nI7CYovkdxRs5vZ8ok++0+946Ww4tXaTK8127mGEO+u25mCTbJW9dtW8DN/dNk9vxin+oLEJTfbvlUdESIPpKC7KYWin7gAg33/kBNzvI3EDW1+wm1skgnkMxRHX2MplubsQ64CrW+GYMLM/s3JWEQa6OkVJsphW+CGFdBbEzqH21bt4matL0erppeg+uV/7suCJuX1hnK9e7agQbjYp94fwM+bchh9OaVjb1J8joPwOii1Qz8hT/VkHp/v9QKeqslkrBrqNCjnmg9hhhROiBGESiewwYUXgIQU4S0jgfvuojz9iqcla1p3ce684AvE0wEIAH+ZbKpjczqC/w2/Co3sKfa1rMD4j4uOSzXy8zWvlIbOX5xes5UfLzKd+hL+5xDgmJOpK6Tlw1E4eJkKA/2co0z+5jhshkCISLLYvkPrMo0P3akfrUlppe+A/s2bAMGBbwfPNCK8phn7y6nX3w3RTk8dIB3txcz13miTn8ACs1T0pDPYwEGA9aRqNB/BfQOtQ+rer6rcUc1+vqOavm9Cz5qxeYy0cJdHARIC9WSKkAnCTKWERmryeg=
x-ms-exchange-antispam-messagedata: sXlrmDmdBRY92c06IYOoc9q9jFmmooozwFKwCmT9wbuEB+xeeIAObwWnyYxjBv90N6+P5+rwFu40MekoBxp0euTfGVvEMKNYJ1IKk9ufYxh5cKDjN4XNWZfi944MW4KCQabDWUnzky+YsUp11vqMaA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E0B86EF9D4654542BE07C80947FE1F10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: daae8b8b-864a-4902-6a99-08d7e5ae2ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 04:40:56.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axTalg6ze2KmXGODU54ZYJcd3ptef+ygiWCaYP5mBajkBjPM2aLJgpU4cyTdVeKMdDnwyxMQ1HSu8CQ/vICdfnT8UeR7afH/Yqwj2gqIBic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 20, 2020 5:50:02 PM EEST Cl=E9ment Leger wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Tudor,

Hi, Clement,

>=20
> ----- On 20 Apr, 2020, at 14:14, Tudor Ambarus Tudor.Ambarus@microchip.co=
m=20
wrote:
> > Hi, Clement,
> >=20
> > On Friday, April 17, 2020 7:08:39 PM EEST Clement Leger wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
> >>=20
> >> Update the issi_parts table for is25lp01g (128MB) device from ISSI.
> >> Tested on Kalray K200 board.
> >>=20
> >> Signed-off-by: Clement Leger <cleger@kalray.eu>
> >> ---
> >>=20
> >>  drivers/mtd/spi-nor/issi.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>=20
> >> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> >> index ffcb60e54a80..c3c3438e3d08 100644
> >> --- a/drivers/mtd/spi-nor/issi.c
> >> +++ b/drivers/mtd/spi-nor/issi.c
> >> @@ -49,6 +49,8 @@ static const struct flash_info issi_parts[] =3D {
> >>=20
> >>                              SECT_4K | SPI_NOR_DUAL_READ |
> >>                              SPI_NOR_QUAD_READ
> >> |=20
> >> | SPI_NOR_4B_OPCODES)
> >> |=20
> >>                 .fixups =3D &is25lp256_fixups },
> >>=20
> >> +       { "is25lp01g",  INFO(0x9d601b, 0, 64 * 1024, 2048,
> >=20
> > There is a "K" flavor of this flash which has 512 Byte Page size with 2=
56
> > KB Block size. While the page size can be determined by parsing SFDP, I
> > think we will have some problems with sector_size because as of now, th=
e
> > sector_size is always set to 64KB. An incorrect sector_size will affect
> > erases and locking.
> Thanks, I did not noticed that ! If I understand, this will require to
> modify the core to handle sector size the same way as page_size and
> probably add a fixup to detect the "K" options from SFDP ?

Right. You can add a post_bfpt fixup hook for this flash. You can=20
differentiate between the "K" version and the rest by the page size. Since =
the=20
page size is tightly coupled with the sector size, you can amend both in th=
e=20
post_bfpt hook.

> This is probably more changes than I can handle, and you can probably dro=
p
> this patch since not really functional for "K" type flash.

I dropped it. You should try to fix it, I can guide you if needed. Or I can=
 do=20
it myself, but I'll need some help from you at testing.

Cheers,
ta

