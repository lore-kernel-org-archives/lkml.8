Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91588C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542E82084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fa6k6aI1";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="M+gzLZiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDUEwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:52:09 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:53971 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUEwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587444728; x=1618980728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kcuRfF3wOOIH6y7YJTYK8rGqDUdN8xpS9MBPB1A74Xc=;
  b=fa6k6aI1tDYgkluyd+gao51byrtjkvQ64VSYbH0wUHN2hCrouHrxDi6s
   +SCr+wCSP+eP+uSNuaR9/TUrAMbL8VKglrdU5aVcvzYZc55lsQAy4BNWM
   lkBLq3UeZsxLWWOinRjxCWNZhxI080x+PTGIMx1XPCB9XsWDYXlzwbPBk
   5B0dNc3aYQj1eMDoNcyQ1q6hphRjifglofrNzC+IQfaLV2Sps5gElp9xf
   i86y+sgGBFYCpqLVjagIQj6EAEYN3vfPae1Kqf5klbsausan8CLN8UBjF
   J6zpfDmDvLR4RzFUz3/ieBxIQI5wSozj7JVBl1pCvTbucy72MQqZL8UUh
   A==;
IronPort-SDR: mLt/66QvLhnQ3vzM1TFPPnt964/BXzzXyb6XOqenofzwbDQvi7b4/JjIRvKsqvKvD1/lNSiVJF
 LPyIHk43TyeemTH50eg11y8d67mP9WNWHArcG/5wRKXDR6a9iOk8QK/X/ldcqAvI2seOLk6fHO
 drqnMaWTEMKIrlpSe1sn8eMapaG616isDL3TV7u+UDSmmgLYroPv3nxEd3TQBUFJ7Sgh+AjzXR
 D05fKWOw9jb3pO1b/hfN0S1nhJBs5X3yQVIFj6/O4tXHv67TAAMMO8CjQw2Qp3is1/1vNgPMkw
 g+8=
X-IronPort-AV: E=Sophos;i="5.72,409,1580799600"; 
   d="scan'208";a="73979363"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 21:52:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 21:52:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Apr 2020 21:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYBXHJwM+wrSV+ccUu/7/1yroZbxLLsMLe7na2H6LZgYF+dbD1nMvNB9n7RsR65dA6y6C3gD9GIhVvQVTu3+N2L55m1tPMc4DZS5riIQEFirb2kcqQ8Tye9SHOIdedm4e23E+700ojn3b9FGRSfK67jop3lvUGVQgkGm06/T1JjzKhc57BygfxAxBP2SwvC7+0UNJUw0Lq8mttPsy8K7JESrvEGEWD/MBJ9fkuaU95CC5F/7WQi5SEtE7v9+R+cDkmVFuVxlFaSjgoaG5OQD5BlXQsqdFa1w4+DGgBkMSyRWzr6R/9gW+tH0y7KRFyvMpLwa9NHfV6rS7KpF8hI55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcuRfF3wOOIH6y7YJTYK8rGqDUdN8xpS9MBPB1A74Xc=;
 b=GLZNG4S/QUBzxCHQXWWBNkuw5PP3wN1xRxruWJjBBd8w8pxTZuW7Syfq57Im4vsUtfDWc7+bDuuRJA542B51UdrVB9AnJXMZPHSau6b7m7ShpGcHmJE/3s4N/WOMcitSjFplh0aiLWYb3CoMOfNlT3bPOHubJIf7J7hY73LGgYIa3vxRz/z7fcWpjrvOOwUvvc9RA1NAwQ/Q7iXCsoEZc/OLfjM8hn8nYNAE7gy5Pt4VCnax7YyV9d/RTp9Xcdadm/t8MbtRkjTfWZCWFjJxdqLwR3fMl9o6PNYg6GM+gZuguKFMzr7yHmqukCSlAqHIG0k83NUpRa985fO+ruGPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcuRfF3wOOIH6y7YJTYK8rGqDUdN8xpS9MBPB1A74Xc=;
 b=M+gzLZiYejw0A9E3PSZLePf7G55IxI/xGNlQeTgp1C1F3brILT5g7Y3KLI8Os9ZucG+oepe8DLne2j1tWJJwSatnbHkYglP0tbZY6qDWWytLF5cy+2H8Nt2vzo+amDqJk/YGUhfRUdePhoEHCx1g0/JgANKiq3S+7Xdvfz5qKMk=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4387.namprd11.prod.outlook.com (2603:10b6:a03:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 04:52:02 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 04:52:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <danielwa@cisco.com>
CC:     <xe-linux-external@cisco.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Thread-Topic: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Thread-Index: AQHWFyrJEeAl1Y63FkSdbq93yQPoxg==
Date:   Tue, 21 Apr 2020 04:52:01 +0000
Message-ID: <9715610.TpusJ8o3lr@192.168.0.120>
References: <20200417174620.16420-1-danielwa@cisco.com>
 <12178429.kzmL6e4XO6@192.168.0.120> <20200420162550.GZ24466@zorba>
In-Reply-To: <20200420162550.GZ24466@zorba>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87bd4c2c-928e-4c17-8aa5-08d7e5afbb4e
x-ms-traffictypediagnostic: BY5PR11MB4387:
x-microsoft-antispam-prvs: <BY5PR11MB43876546E6FF801CC87D815FF0D50@BY5PR11MB4387.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(316002)(66946007)(66476007)(66556008)(76116006)(64756008)(71200400001)(4326008)(66446008)(5660300002)(186003)(54906003)(91956017)(966005)(2906002)(81156014)(8936002)(8676002)(26005)(6506007)(53546011)(14286002)(6486002)(478600001)(86362001)(6916009)(9686003)(6512007)(39026012);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohdmcydyN/+4QHGCBR71zw0vDEZ/ASykGSW+H96ZuoGubebfzNFrO24m0+E1nodsq3+5+64ffjIF3ttsrydWUXee6+7XH46h4SCqyZahdMfs4e5uZ/vunl1Gj1TJQJpPDqJeHaLiW0IRYX+cF3e1c0AOPlvDlEFsWiJ16JnthOEeK/0xMrSUla3hwlTn6Lhl4o8rs0UV7GndafGfaC/vKyo9t1BZHxI77/1ILH2JFCzag26nJQaDeA7nfSPxKAV6W6huvWN7tA8pqOJDfoP09F3bdn+HRIBQZIZb8OLA58HAgW5w13rUZ174FYPxafLlQ40QQETvUPGChXjbv8SdhmOfGmpGyWwWTNiRxkz2AJolP/jBmdJM+rL1TnuJB1DbODdHycsIzw18xCBd+Qm2bRYOq/0+AtH1a1pyOKBSDbiZRWhR/q0tUubAFt6jjJJjENKbKMd8IoMAo1AICqHhyYseixQNtXOtp0WSfwltuAJ5RmGsRxFP6NEbLVWGJaJWd/Vtk1uZKZSjq00cm34QPZwlB44e7o8RRmeG+7KdV8mV8HUqdcBywoTDPCEM90qQ2t32W1+EHl2An8Ymw+tXRA==
x-ms-exchange-antispam-messagedata: asyEKS8qIRmFvKrInO8v1/Wl6gmAxT/NiCGaA1+PnwE8aoixQuyWXVHtFKbWpdq8OGAtLu/R9xdeW/b2wVd5SYOKIioDlt/0rmURc/f2b+nvcnbsxxyiuF4nzfRhoPj64YrknWjS+crtDp2TKE8cRg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87E0B0B534719C4DA8797796E957ECFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bd4c2c-928e-4c17-8aa5-08d7e5afbb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 04:52:01.9139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WO+oRfiMlu4TAcY2uhIQFVIJ7dXf+FA/zugX4o8gwIeI5AjmykoLQA7lWFWxNQAV9YKJDAKv6M6ckjygDyEjAWRsB/nYpNDL0jyNaxEsNec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 20, 2020 7:25:51 PM EEST Daniel Walker (danielwa) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
> On Mon, Apr 20, 2020 at 03:45:59PM +0000, Tudor.Ambarus@microchip.com wro=
te:
> > Hi, Daniel,
> >=20
> > On Friday, April 17, 2020 8:46:19 PM EEST Daniel Walker wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w
> > > the
> > > content is safe
> > >=20
> > > The n25q256a supports 4-byte opcodes so lets add the flag.
> >=20
> > This is not true for all the n25q256a flashes. SPINOR_OP_PP_4B,
> > SPINOR_OP_BE_4K_4B and SPINOR_OP_SE_4B are valid just for the part numb=
ers
> > N25Q256A83ESF40x, N25Q256A83E1240x, and N25Q256A83ESFA0F.
> >=20
> > You need to differentiate between the aforementioned flashes and the re=
st
> > in the n25q256a, in order to add the 4-byte opcodes flag.
>=20
> How do you suggest I do that ? Can I add a new entry into this table with
> more specific information about the chips ?
>=20

We need to find a differentiator at runtime. If we are lucky, there might b=
e=20
some SFDP changes between the 4-byte opcodes capable flashes and the rest.=
=20
Please dump all the sfdp tables, we can start from there. There's a thread=
=20
that might interest you, see http://u-boot.10912.n7.nabble.com/Regressions-=
in-MTD-SPI-FLASH-td382956.html#a383126.

A more elegant way to solve it, is by parsing the 4bait sfdp table, but I=20
haven't checked if this flash supports it or not. Anyway, not something tha=
t=20
we can control, the manufacturer should add it.

Cheers,
ta


