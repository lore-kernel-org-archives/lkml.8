Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDA120749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tJmoCOe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgCMPuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:50:14 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52023 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgCMPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:50:14 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cbKeo1Y8w1Ud7j5sRYEZd9a+ZDmCCEDO0aMazeh3KDe2VEyUjPrsikhNxCLBrHoiqdq0gQfv6i
 Uqe/OVuvb0HYlq3Uq4t9nwxoM8+uePj5pEfTFMcSrj2ZKlw0cMZbKVJBFqslzaj1GoaByp3kSl
 5Qrtdb0OrHQ2X60ykISqC8oXQmW+tGIPR56tymm3Qm7BqS+/0Zmau5tMKQ0Z5HRje8bozCrQ/8
 PtL9MQjeB9UmtuXA7SfOuP4SFx9NilwHHW198y+KEKybWnMm01wwMZnwekGoT1wYEj4XH+glUn
 beA=
X-IronPort-AV: E=Sophos;i="5.70,549,1574146800"; 
   d="scan'208";a="69890320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Mar 2020 08:50:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 08:50:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 13 Mar 2020 08:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb/nVK8zkSVqF+KFtaxLQbhSdqSZxplCYjT2CEmGA7rRQEhRTEdgrSS41dYd/+ciHg2GkxbQE1ciS3DNWVfr+dzryptucg1ol+oUiqRe1nP5kxzx2/vsnmRUCFKIiA7B0dveGaq+bGNmta4Z+qnzlbnCQC93eH3AO8yZtH1jKpd9qIUHloQGhqW8T5ABD3DP6uyXcxVL4cWk0ImMXMpwQrMgAK6vjEwGln5/Ejn+YzKdNTYxrTdjI1l6ZPfooXYPURuG1wHEBV0hanbnfUuAoUOfgvIIKNQs/nASQLMr9O92V2Pv7dXWsvG2lM0JL0hKkUnlNiqU8uJOkGzcW4XcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPmlBCq3srfYpkDt5yvbrsPLnxekGBYkIZrl+4OFc5c=;
 b=Z6NAjCnqZBIV+8Fn0VyTKEJgZEAIyLWdPLhqeRFmBI0ggolHEOEMyLJ3CEo3m406DPQd2RHwsimO7ubUt017UNlqapXkeHLxXwu1lGv7lw3tzeGq8aJGRyj2srZYepOw6ymRW05A+2KMydbXpy6g4cbbwopNzwXFyvElutilxJb/HomhAXCkMY/GYHhub+aLIz5X93XuJCtfF0uo2p72IVu74C7Lw6B88tup/qSce1HyzGBTPdt6cLZv0x+k+1i93y+gojlg2jvcH2z6/UZ//j5awUVmnCPejbjSunAcv/6Tn6C+GI0ZElNU9goOhnt+hIidGQML4cpxO7i1kZJtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPmlBCq3srfYpkDt5yvbrsPLnxekGBYkIZrl+4OFc5c=;
 b=tJmoCOe4BXcGCaNXfmDUT+8Mh9c4WD3zPimn3hEXkQJq9wrIdZAt9VA4L2p3h7XgImjcZ2jJ+Ehss++omAWFmb+WkDi4sHaTdNViXH3LNSPAdwm7Z2Xsn9aBXE6iEdcS77veA8RT1YJ9GtapGg2ZeV2JS1h/QXHi+QlpoKGAmzY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4126.namprd11.prod.outlook.com (2603:10b6:208:136::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 15:50:10 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 15:50:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>
CC:     <boris.brezillon@collabora.com>, <kstewart@linuxfoundation.org>,
        <alexandre.belloni@bootlin.com>, <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, <thor.thayer@linux.intel.com>,
        <jethro@fortanix.com>, <rfontana@redhat.com>,
        <miquel.raynal@bootlin.com>, <opensource@jilayne.com>,
        <richard@nod.at>, <allison@lohutok.net>, <michal.simek@xilinx.com>,
        <Ludovic.Desroches@microchip.com>, <joel@jms.id.au>,
        <nishkadg.linux@gmail.com>, <john.garry@huawei.com>,
        <vz@mleia.com>, <alexander.sverdlin@nokia.com>,
        <matthias.bgg@gmail.com>, <tglx@linutronix.de>,
        <swboyd@chromium.org>, <mika.westerberg@linux.intel.com>,
        <ludovic.barre@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <bbrezillon@kernel.org>, <andrew@aj.id.au>,
        <Nicolas.Ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <dinguyen@kernel.org>, <michael@walle.cc>,
        <linux-mediatek@lists.infradead.org>, <info@metux.net>
Subject: Re: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions with
 a manufacturer name
Thread-Topic: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions
 with a manufacturer name
Thread-Index: AQHV+UP9aMq9KhVwKUKrK+Ih7RO/b6hGq5wA
Date:   Fri, 13 Mar 2020 15:50:10 +0000
Message-ID: <16008638.kvcHKcsGDv@192.168.1.3>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <20200313103007.7d7ea6af@collabora.com> <2838624.3XVpXx8FI0@192.168.1.3>
In-Reply-To: <2838624.3XVpXx8FI0@192.168.1.3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 101f555e-8f02-4a38-3139-08d7c7663666
x-ms-traffictypediagnostic: MN2PR11MB4126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4126CE5701C57D29EEBD10C7F0FA0@MN2PR11MB4126.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(9686003)(6506007)(2906002)(64756008)(4326008)(81166006)(81156014)(8936002)(7416002)(53546011)(6916009)(6512007)(7406005)(86362001)(5660300002)(66446008)(66476007)(186003)(54906003)(91956017)(14286002)(76116006)(8676002)(66946007)(71200400001)(478600001)(316002)(6486002)(26005)(66556008)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4126;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhhcrOcOhWrquR/SIR3WXQY0tfjEP2p/5vasdxc2YFSLgZAPVehovfM6NDvj2EbbZrUer6suknjLLLRXRtjGEFSamZ6Rw4upBC5iOxhy+AZLrdPU/TFYWkH0f+JekHMks9x/QEgkDK9taNfrIMbvhQ00/xLXNqDc25HxmZbbjRvQd+ROAtgnbjbm7bLsOOlMBUoLPapdr+IwHfw2tt7JNj47AsYjRiKITv5EzEiTUXtSJdCWMlehMbqJ8xG93IUQBUxi2Rqxuyv2ZcN9/5nPG1P75vXbNUwUft8TDlWii7IX8CeXIGxA2PMp4CM+dDbblelI80vefsE+8+KISURHWmEs9a8AStLcT6a/yVsM27PgXT7l61yoGKwbBUzfAU2Igk8C1BVPC8RjkVczfARKDhSqa+irBTn/FNRm2b28k+LejcvRxeY6HIkxMf5DXOZtCoCakdQCSxw7KOqP6qqVDXnu6iyFnyn9IFtSWQkXTVTxxrShF/52toztUCptY88k
x-ms-exchange-antispam-messagedata: Uca3gAXglqRfETJ4cOmjenxQj8XQMLyShcBh1/HlfH+NHiaFvMXI5B3PX8tlXp2BzMlKyqgdpEuWiCyzARbOLivtAGSXUnpeku43NP18VUz8mAnwdqAMrJ0G/3wIMxgMMia2rKSlhpPwv9euhlq0+w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4968D74D5D41C449BEF42DBDB71FD00B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 101f555e-8f02-4a38-3139-08d7c7663666
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 15:50:10.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFI0/8+UneYoZK/vraiXf+nKyKmQJWVCUYHO14qIR7jNnMN/QC7Ld8sy1PSGGFTYwvOuxGDBwIQ0G+CDviml/w/vH5rEuoUOA0/SZU2zk2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 13, 2020 4:30:48 PM EET Tudor.Ambarus@microchip.com wrote:
> > > > - * macronix_set_4byte() - Set 4-byte address mode for Macronix
> > > > flashes.
> > > > + * spi_nor_en4_ex4_set_4byte() - Enter/Exit 4-byte mode for Macron=
ix
> > > > like
> > > > + * flashes.
> > > >=20
> > > > * @nor:   pointer to 'struct spi_nor'.
> > > > * @enable:        true to enter the 4-byte address mode, false to e=
xit
> > > > the 4-byte *         address mode.
> > > > *
> > > > * Return: 0 on success, -errno otherwise.
> > > > */
> > > >=20
> > > > -static int macronix_set_4byte(struct spi_nor *nor, bool enable)
> > > > +static int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool
> > > > enable)
> > >=20
> > > Sounds a bit weird, how about simplifying this to:
> > > spi_nor_set_4byte_addr_mode()
> > >=20
> > > Or if you want to be specific:
> > > spi_nor_en_ex_4byte_addr_mode()
> >=20
> > You're right. Maybe we can simplify things by having a single function
> > that does optional steps based on new flags
> >=20
> > SPI_NOR_EN_EX_4B_NEEDS_WEN
> > SPI_NOR_CLEAR_EAR_ON_4B_EXIT
> >=20
> > This should probably be done in a separate patch though, so ack on the
> > spi_nor_en_ex_4byte_addr_mode() rename, assuming we also change the
> > bool argument name to enter.
>=20
> A single big function will be ugly to handle because of the
> spansion_set_4byte() -> it uses a different opcode.
>=20
> I like the nor->params>set_4byte hook.
>=20
> I think that spi_nor_en4_ex4_set_4byte() can be renamed to
> spi_nor_set_4byte() and be the only set_4byte() method exposed to
> manufacturers.
> spansion_set_4byte() will be static in core.c and the rest will be privat=
e
> in the manufacturer drivers.
>=20
> Here's how the manufacturers enter and exit the 4 byte mode:
> -> eon, gidadevice, issi, macronix, xmc use EN4B/EX4B
> -> micron-st needs WEN -> private method as they are the only ones that
> require this
> -> newer spansion have a 4BAM opcode (new, public command), older spansio=
n
> flashes use BRWR (legacy in core.c, spansion_set_4byte())
> -> winbond set_4byte method is hackish and may be reason for just a flash
> fixup hook -> private method

I'll drop the set_4byte changes from this patch. I'm adding a dedicated pat=
ch=20
immediately after this, to implement what I said above.

Cheers,
ta


