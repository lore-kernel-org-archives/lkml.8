Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA22074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="M1YZi7Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCMOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:30:53 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:51266 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:30:52 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: yAVKD0RHxYIxeHBd/FF67CpYk8ckseS6yr5t+zpm/9AszjNc48KWJX9vURlv2VIQmf1Jm33exX
 UToRR85o8Iwo2MmolNOte6dGORnUKoAjJJMzn05kHdz+1qpMMJN8zgjoLBhmdu+GZPjYrUl7l1
 uULpgG5WBZfPv+jC6f49n85eb9HD3d/nUqsOmOkoYMlbh1gimMWbld8ZgUDz4Zvlj7TfiGlK+I
 fK8O3znb19qKQIFCIkTJrVIa3n5+PSCm5FaubDClM5EO5hwxPdqJlID2J/g31C4+a7wt5J053m
 aSI=
X-IronPort-AV: E=Sophos;i="5.70,548,1574146800"; 
   d="scan'208";a="5563306"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Mar 2020 07:30:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 07:30:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 13 Mar 2020 07:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri3Is3Qxu0K9V4sEIWMMRjWyFZR5ZrT7vr7wOWfIlyNPVfEAId2lAIHc71BijnMxWWpF3JTLrK/QqLdnvqRhTlQPqFvN/5CYuqDfZQQrRmnO1LDmVRH5IV9MBK4ZLiNjSCvuCZFJlWJAv+WH2oh1bRrDTCyp+u0jNviuGHCoet1wbJ5fFCij05/yTHG5wbAtGR6Ja88sxJaHairFlxA5dM59pTFfZpLZg9EPDNAtuEo5REG6NhG46Kag9eZHTsE3vdaVj3xRKUIrDon0GBi4BMBQJZD7CKoTPmDK8HIN77Y1ZNuN8q14GJzY/Onzj8nnskVnVIkctimy5aCUCQoagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0WkAc6atkij4tyHTbIHCyNENEOmL/waY7NTITYZdM4=;
 b=g/r3FxpS8LnXS5VAXaWcnAujoCAAD6EqzDRwUKdOabUodSszcbkCwXgigSWo1qD8ipAyzGjYUzYFITe+p4FC38IFO54MNdl3T3Ipq0/1j72kLqdIqoPGnyAkeZSHc0jHYuhEjXJ891H7p8KZv9gw1NQilrxkqHivxOdUN9PwS+6a7QsuQca6IoBaq3bzp9aqsZyFUVQ34EpYk2Jxp0q56KEa2G+PJUfduG4m2BMpDTFrHR4r/cV1GHefc/Vy1AmYvFCERQASOf2DWcz6fm8cfvbRbzLJpd6FjBQKrghHzEigsgTnHF2p1rLuQ0p/mo90QBqG2eAl1RCS7CoVh8663g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0WkAc6atkij4tyHTbIHCyNENEOmL/waY7NTITYZdM4=;
 b=M1YZi7NnjqdVsx653wtZunMBSvnfaVWUC1kBxjzE938a2qrfdYuNGi8ESmY3aTt8EqBAAhBtJHPCKN3Q5JXVBJ7RnGlMmhgGzn+2c4BtmUuAbXrjUOj75LUhcQZf5ADxE5aXVg3I1ojagUA4ibRwD9Eq3lZ6/6ttpdi64mNh9Qo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4479.namprd11.prod.outlook.com (2603:10b6:208:17b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 14:30:48 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 14:30:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <michal.simek@xilinx.com>, <ludovic.barre@st.com>,
        <john.garry@huawei.com>, <tglx@linutronix.de>,
        <nishkadg.linux@gmail.com>, <michael@walle.cc>,
        <dinguyen@kernel.org>, <thor.thayer@linux.intel.com>,
        <swboyd@chromium.org>, <opensource@jilayne.com>,
        <mika.westerberg@linux.intel.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <jethro@fortanix.com>, <info@metux.net>,
        <alexander.sverdlin@nokia.com>, <rfontana@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions with
 a manufacturer name
Thread-Topic: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions
 with a manufacturer name
Thread-Index: AQHV+UP9aMq9KhVwKUKrK+Ih7RO/bw==
Date:   Fri, 13 Mar 2020 14:30:48 +0000
Message-ID: <2838624.3XVpXx8FI0@192.168.1.3>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <91394111-cbd6-c24e-485d-88fcd6825dc7@ti.com>
 <20200313103007.7d7ea6af@collabora.com>
In-Reply-To: <20200313103007.7d7ea6af@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db6fa0dc-92f6-4766-d806-08d7c75b1fc6
x-ms-traffictypediagnostic: MN2PR11MB4479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB447905CF96D59ED7D35C1FDEF0FA0@MN2PR11MB4479.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(5660300002)(8936002)(66946007)(14286002)(81166006)(66556008)(64756008)(66446008)(76116006)(66476007)(8676002)(91956017)(81156014)(86362001)(478600001)(316002)(6506007)(2906002)(4326008)(54906003)(26005)(7416002)(6512007)(7406005)(186003)(9686003)(6486002)(53546011)(6916009)(71200400001)(39026012)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4479;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cTbzBh8KNl15tYvD5g+srdVVg7SkZ8nhPts6Hmxwr4hOsLDKXzoOl+oC14H0k2gLsWTjOF4wBy9VpkKhzdI4HF8m0nnlph6p/Zc3lN2TRqfVxNGL2bvz3TSKSMougyqJS39isywPLQOmyv7Fy1LFnCy22jYaRCi/Hd4El40KbDfuC/VKFRe/AUqv6E+o1zqC+qpITvN0hsFaEY5lZXjvVAExXyVPix7AC3v7zST0Jcqymch4qf/Tzh473BCL099P9V7EqWiAvB9Lb4fSTSk2Vax0uJiHWnctPkr1t3nGmlKfrsCxrzWOY7KU7d8oG4gTjDnCJc0Rtc7c+/OrB43rohaAJRIRAnx4T7mwnUmkMPsLvQVYt+2bCjvwu7AlxVSjeiJgLJn5XkcehbuhxCdrjzqVu6gxNycwG9DL5y0WAkJgeqYVTcmzoYEi+9f20SEU2aDIzCiBXqoZENOLzGdxd9UGofNof/TIts72/9k69Dtmmiq0X46tw4sb01X5+JUmS72MTjnct2/6meP0gV6Sw==
x-ms-exchange-antispam-messagedata: jtjUzHtXu6mLeil1fzNzi/K3zXi0Qba96XohPba9BR8FHNNrTW8iNWh0oh0OdLHQADtLuoleB+CGQW8k1NlO0q8m4NBf09/6a5S+vEF+DnW3Gv9m+oZqzsGPi7qqx5tFAFzZho9rfuX28hW7lnULzQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91F0FF6E328E9140903FE1F0A48236EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db6fa0dc-92f6-4766-d806-08d7c75b1fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 14:30:48.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEdOmCKOS8d00DQAyeBUWphQz9/LLW/XAQqdI4KzbbV7l+keMh3oj3kPJ6LqckQM1u3hfxJ6BX8L6YGtj7GM4enHmf8tpV5jr9l02H/JmNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 13, 2020 11:30:07 AM EET Boris Brezillon wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Fri, 13 Mar 2020 11:34:55 +0530
>=20
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
> > On 02/03/20 11:37 pm, Tudor.Ambarus@microchip.com wrote:
> > > From: Boris Brezillon <bbrezillon@kernel.org>
> > >=20
> > > Replace the manufacturer prefix by something describing more precisel=
y
> > > what those functions do.
> > >=20
> > > Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> > > [tudor.ambarus@microchip.com: prepend spi_nor_ to all modified method=
s.]
> > > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > ---
> > >=20
> > >  drivers/mtd/spi-nor/spi-nor.c | 88 ++++++++++++++++++---------------=
--
> > >  1 file changed, 45 insertions(+), 43 deletions(-)
> > >=20
> > > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > > b/drivers/mtd/spi-nor/spi-nor.c
> > > index caf0c109cca0..b15e262765e1 100644
> > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > @@ -568,14 +568,15 @@ static int spi_nor_read_cr(struct spi_nor *nor,=
 u8
> > > *cr)> >=20
> > >  }
> > > =20
> > >  /**
> > >=20
> > > - * macronix_set_4byte() - Set 4-byte address mode for Macronix flash=
es.
> > > + * spi_nor_en4_ex4_set_4byte() - Enter/Exit 4-byte mode for Macronix
> > > like
> > > + * flashes.
> > >=20
> > >   * @nor:   pointer to 'struct spi_nor'.
> > >   * @enable:        true to enter the 4-byte address mode, false to e=
xit
> > >   the 4-byte *         address mode.
> > >   *
> > >   * Return: 0 on success, -errno otherwise.
> > >   */
> > >=20
> > > -static int macronix_set_4byte(struct spi_nor *nor, bool enable)
> > > +static int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool enabl=
e)
> >=20
> > Sounds a bit weird, how about simplifying this to:
> >       spi_nor_set_4byte_addr_mode()
> >=20
> > Or if you want to be specific:
> >       spi_nor_en_ex_4byte_addr_mode()
>=20
> You're right. Maybe we can simplify things by having a single function
> that does optional steps based on new flags
>=20
> SPI_NOR_EN_EX_4B_NEEDS_WEN
> SPI_NOR_CLEAR_EAR_ON_4B_EXIT
>=20
> This should probably be done in a separate patch though, so ack on the
> spi_nor_en_ex_4byte_addr_mode() rename, assuming we also change the
> bool argument name to enter.

A single big function will be ugly to handle because of the=20
spansion_set_4byte() -> it uses a different opcode.

I like the nor->params>set_4byte hook.

I think that spi_nor_en4_ex4_set_4byte() can be renamed to spi_nor_set_4byt=
e()=20
and be the only set_4byte() method exposed to manufacturers.=20
spansion_set_4byte() will be static in core.c and the rest will be private =
in=20
the manufacturer drivers.

Here's how the manufacturers enter and exit the 4 byte mode:
-> eon, gidadevice, issi, macronix, xmc use EN4B/EX4B
-> micron-st needs WEN -> private method as they are the only ones that=20
require this
-> newer spansion have a 4BAM opcode (new, public command), older spansion=
=20
flashes use BRWR (legacy in core.c, spansion_set_4byte())
-> winbond set_4byte method is hackish and may be reason for just a flash=20
fixup hook -> private method

Let me know if you agree with this, so I can respin later today or tomorrow=
.

cut

>=20
> > I expect sending WREN should be harmless even for cmds that don't expec=
t
> > one.

The commands may be ok, but the flash can be corrupted. The WEL bit is NOT=
=20
reset after the completion of the EN4B command on macronix flashes, so the=
=20
gates are opened for some inadvertent commands that may corrupt the memory.

Cheers,
ta

