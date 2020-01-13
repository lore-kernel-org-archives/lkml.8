Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE975C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB03206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="G+Uz/I/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgAMJGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:06:50 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:58667 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgAMJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:06:50 -0500
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
IronPort-SDR: lv+K4WNt599BS/NyJz4rWA86WJVgXExSpf8s1w1uGCMM65K5RgBdxofPvseK+BmrBU8SjmvOmk
 18HCGTvSNxtmjWuVV1uGiAQBcWvk5rQ5jQSu3TS5H+bUop5sQ8HMiItnOPk2cVZpu0TGwnZDs2
 RinFFuDacK+/pKlDHmE1xHX8IvaHuORzNPT7za2X9JOKaFp4/2TRyLO/5qUQ+6NcfXKiobIuiS
 sRZvo21vlXeoeJjc2Oum75J9sO/tjJgoABNU2/q94hoH314YgL3WTyYRN9/LUek+WSelheRdp4
 3z8=
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="62413666"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 02:06:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 02:06:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 02:06:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpMMJyOweopx0hGbItLRHHtjweif+v+Qdnz34bkPgQYFL/N3FSA+Ucl1aHimDHEmi3E4t1eqOuZm2mh1jBaRgLowqNiydOUnuXN30q1h/7EW8+WQ8eQCS4dB5CDPdUN2gW5mH+24L6DiSgjoLvEke5F4dfkilzWgGarqobIvld7inuIawhKIz4Q+CjhHKDhvb3RxYJiD2Yfs24w9/7AQ/W7nUtQOcxgy5qJ7jULow4t7iYsG4xsf5MGGoQ7a7cWnTSnryji8T1Jc8Y9Q3fmp6NZZl89UipGhjI66jY+rIah027+o7i57ZWhNk/zKQAV/19ogrWFiTg1vkIoAdgZgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpCVsIYtYpBANY/MJpuIHYNynQMYSIwoKoST3yOpxGw=;
 b=UAVCAnVPhVqLR6AGP0OF6Gi0ETs68olfjCvuCuBD3nHaRqXIydVRZVEe9A+hy0E/2/ss6ywiGH61ynETph1ipRrRGvcayHeAOVE6rz5XLoZLHIiTSnaBaNwJSBS7a/pOWrHngBNkEEYLssLbk1OXDDF3r43odBkSoNwFX6+d9MmQaGIbHwh9CUn40/RWg1mvJ90jeszChFf6ND5U+LKY6fdITfWj6emNG3jCwRVCtSFVBuqGjHNCZ/WsKkL+RNgvsmmeXemgvh7uX1ogwVTuiA9qr3DF61wAbHjbrdTwg3A6j+WvEMKLbCbL1LgrVHnjQZWNF849ktxSSzPblvud4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpCVsIYtYpBANY/MJpuIHYNynQMYSIwoKoST3yOpxGw=;
 b=G+Uz/I/QEYYPh8a5YSssABaeCHH+jMrfTZ6O07vLdz00oB0jxT1G8pIZO2lKx2gk4E7dFv98KJtmgoDovMKqIg/1BlyDbW5HjsIPH/PFOzvIWgCXRsOQN/P6GqSj0nON4hylstXh7eogeO+beRk/cZeIfIG7JihA6QiTliLZAnU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3741.namprd11.prod.outlook.com (20.178.254.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 09:06:47 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 09:06:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
Thread-Topic: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
Thread-Index: AQHVyIod2dqEzZAPf0S4HyMwJjELNQ==
Date:   Mon, 13 Jan 2020 09:06:46 +0000
Message-ID: <4050087.dyKUiXJtgz@localhost.localdomain>
References: <20200103223423.14025-1-michael@walle.cc>
 <12341010.b9DRC5f9X7@192.168.0.113>
 <9d39be0f45f4c8e087b269f0c802ed6b@walle.cc>
In-Reply-To: <9d39be0f45f4c8e087b269f0c802ed6b@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e993fac-44bd-46ba-1475-08d79807eaed
x-ms-traffictypediagnostic: MN2PR11MB3741:
x-microsoft-antispam-prvs: <MN2PR11MB3741934489E8099943A2E67AF0350@MN2PR11MB3741.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(66476007)(66446008)(2906002)(6506007)(53546011)(64756008)(66556008)(71200400001)(66946007)(76116006)(91956017)(26005)(186003)(5660300002)(86362001)(8936002)(4326008)(6916009)(966005)(6486002)(81166006)(6512007)(316002)(9686003)(81156014)(478600001)(8676002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3741;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNkmYE3APZZ4XQwqmEkz/7e/iuKS0MQJCgrKXFR4I5zDib4eDe/GQ6Edpuv3BluqzPnG0Hq5w1XNcah6BOTLkdUx8uqmQu//4nmx0S4Ulu501+dhDagDpBXd3gN916MhjfsO527sPr3edwkSziR+Bk39IvDEWmJRmmQasvg+A1LiSwlcfYbDaif/q2kO4vFLZa1ykmNabR7Le1N32TF0anhKHthbQgpse+/mmCP4t95DZgGjeSuhlxldNjxuFur0zMnRSZi8WQdq+yjH6BJmBrsGbXhenQUkealiA38/ZAssJ+MagJMnoja+6DeSXYSgsC5D7iK3NgJk/liL61gmpk7hMQX1xIjMxXnO5NPEGifPZ/0xvfBMzIoKJMWofz31cD0i+CWld6x0xkfr4KEtT8WSZsJr4kUMIzwGMB1gZY0hGkB18uSOKSWQrLNRMNZdMuZLolMfUdZPtOBnzLtj4wj0///QHU6hJaNM/d0xuSjs/j6u4yXfDjxYqPfBB4GiguJ2S/qDJxA5Rx0oHoKuqg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <311EF93BFEDECF4DA32A4D293000C1C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e993fac-44bd-46ba-1475-08d79807eaed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 09:06:46.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sumKPbNe/3NBr4bdbOEN8yZbqt9YoSgnLqpsUA2paIHvwwBpR8lQgQMAPyF0t9Y2JF3tWkk5T2vMfEaO16RjijiR7mNWZvKxUIS5QXTn9K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

On Sunday, January 12, 2020 1:16:12 AM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Tudor,
>=20
> Am 2020-01-11 15:19, schrieb Tudor.Ambarus@microchip.com:
> > Hi, Michael,
> >=20
> > On Saturday, January 4, 2020 12:34:23 AM EET Michael Walle wrote:
> >> Add support for the Winbond W25QnnJW-IM flashes. These have a
> >> programmable QE bit. There are also the W25QnnJW-IQ variant which
> >> shares
> >> the ID with the W25QnnFW parts. These have the QE bit hard strapped to
> >> 1, thus don't support hardware write protection.
> >=20
> > There are few flavors of hw write protection supported by this flash,
> > the Q
> > version does not disable them all. How about saying just that the /HOLD
> > function is disabled?
>=20
> I don't get your point here ;) My understanding is that HOLD# and WP#
> will
> be disabled. Thus there is no "hardware write protection". What other hw
> write protection do you have in mind?

Time delay write disable after Power-up for example.

>=20
> > When we receive new flash id patches, we ask the contributors to
> > specify if
> > they test the flash, in which modes (single, quad), and with which
> > controller.
> > Ideally all the flash's flags should be tested, but there are cases in
> > which
> > the controllers do not support quad read for example, and we accept the
> > patches even if tested in single read mode. SPI_NOR_HAS_LOCK and
> > SPI_NOR_HAS_TB must be tested as well.
> >=20
> > Even if the patches are rather simple, we ask for this to be sure that
> > we
> > don't add a flash that is broken from day one. So, would you please
> > tell us
> > what flashes did you test, what flags, and with which controller?
>=20
> Ok will add that to the commit message. Just to make sure. I've only
> tested the
> 32mbit part. So is it still ok to include all other flashes of this
> family?

No, just the ones that you can test please.

>=20
> For now. tested with the NXP FlexSPI, single and dual (no quad since we
> are
> using the write protection feature and IO2 and IO3 are not connected to
> the
> CPU). So write protection is also tested. I will retest the TB bit.

Great, thanks.

>=20
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >>=20
> >>  drivers/mtd/spi-nor/spi-nor.c | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>=20
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c
> >> b/drivers/mtd/spi-nor/spi-nor.c
> >> index addb6319fcbb..3fa8a81bdab0 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -2627,6 +2627,11 @@ static const struct flash_info spi_nor_ids[] =
=3D
> >> {
> >>=20
> >>                      SECT_4K | SPI_NOR_DUAL_READ |
> >=20
> > SPI_NOR_QUAD_READ |
> >=20
> >>                      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> >>     =20
> >>      },
> >>=20
> >> +    {
> >> +            "w25q16jwim", INFO(0xef8015, 0, 64 * 1024,  32,
> >=20
> > "i" is for the temperature range, which is not a fixed characteristic.
> > Usually
> > there are flashes with the same jedec-id, but with different
> > temperature
> > ranges. Let's drop the "i" and rename it to "w25q16jwm"
>=20
> Only that there is no flash with that part name :( according to the
> datasheet

The datasheet describes the W25Q32JW flash (check the first page of the=20
datasheet). There are two flavors of this flash, each with its own jedec-id=
: Q=20
version uses 156016h, M 158016h. We should name this flashes as "w25q32jwq"=
=20
and "w25q32jwm". Please notice that I skipped intentionally the "i"  that=20
stands for temperature range. Manufacturers can provide better temperature=
=20
ranges for the same flash without changing the jedec-id. See this datasheet=
:

https://ro.mouser.com/datasheet/2/949/w25q128jv_revf_03272018_plus-1489608.=
pdf

> there is only this one temp range available. From what I've seen for now
> (esp
> looking at the macronix parts) it seems to first come first serve ;)
> That being said, I don't insist on keeping that name, I'm fine with any
> name,

you should be fine just with the name that best describes the flash :)

> since I've learned you cannot rely on it in any way. Eg. the w25q32jwiq
> will
> be discovered as w25q32dw. Or some Macronix flashes will be discovered
> as
> ancient ones.

Would you please study what's wrong with these names and provide a patch to=
=20
fix them?

>=20
> Btw. is renaming the flashes also considered a backwards incomaptible
> change?

No, we can fix the names.

> And can there be two flashes with the same name? Because IMHO it would
> be

I would prefer that we don't. Why would you have two different jedec-ids wi=
th=20
the same name?

Cheers,
ta

> better to just have the name "w25q16" regardless whether its an FW/JW/JV
> etc.
> It's better to show an ambiguous name than a wrong name.
>=20
> -michael



