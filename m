Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2DC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jOCmVC9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAMLJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:09:08 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10230 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:09:07 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 47+DNGPkVYJj6IhJbQ0MFIxsu9yNJErEnU88CBUv8rR0SfBFRhfid2EsoquYTPDP22kEQjU8SE
 HoguHfYPuVsWwNOj5DCXKwCKhesZajt8+5w8RF6bKbKLMpO0OUHoJqE7s6TIVps1wNRDd1Es/P
 e+Kitwi8hUxzW81XRSJalW+0PE1ZIucqGDDXeFDd+xS/R8F/9ccpHXmwlVx+RnWXtNuhcJ3Pdt
 Q6s6UPTykSDfoz9cXr6rmsqOOS7Zz0vA5ATIt1OnuC8jzhKwOgvK6l7j5LH8S/AzaFgvuoMdD6
 o5c=
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="64504719"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 04:09:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 04:09:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 04:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBbFV0jsDZYeNvMVCNz49h4BfuaJnM7gNSf2YN+u9Ey4K9/P0S7EYPWi8GgBqYUBwxwSGNhGe7kauU0/Y7sO6hcgxZ/6fKm13XzBl4u2fkpOwuY433a8d846/cp0mXZCKuwxw2t9l1S7WI1JH0Gi7waxefnXkDju97OnSESwyPUu0uiGB7jcL499IBkTpz+86y8iYU8WpltjsY0Cmv4vwsFJ4oQtGhw6h1XYNc1iN5MgmfcoOeX/PKQzqe9VySEXfnsj56fkdy0Z3lUMAqDTFyOyzPGz+ki0vHWYG1zYc2shHj0+k5aAg6FO7F0L6JcQNfvTiseJwaHXDaShCeF6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0XVf5ZbWECYD8Nx8HwMdzIzFZRtFRR99Q28fsyPqkY=;
 b=B5CN2cVRHNzH8Vs2dOyFw+0m91rszgY5nxA9SUoAp7MXAbM4WSBxWSPqrUCAILywQUWpo/wktwnGkFy45NnV7SbgjjnEFQeBHO93sBPXatdhqMQxusDazGfSW8SUowrv6KybWS/9ssnztxGGYaDbkmg4IANnb1sT+JI/V5L6evm56T7yS6NXurev/CTKerCdCFnNqY2mwrFQJBkjsu0FTlBdk3mH8R61D+5NTL5oItlGDmlgYtG1InBxdeQjibWElwLqeUDj1hfXwiZoW0zim3I4i2ax4koUEL6JRBjDmOVlWKiDY9XsmZt840u+uKjwPcw5l4ymD56Z+7645mrY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0XVf5ZbWECYD8Nx8HwMdzIzFZRtFRR99Q28fsyPqkY=;
 b=jOCmVC9bBEdp6lMnkb5CIqWfuhijcgwVwelmSZX1oFBmWl+2LfFHYnkuxtWxqoJcVKaVMna219RHnlP/BRRm9QYl0wazcaffChZO0PMleEVAxzOJd8yD5bDrnTuJnUQOXw8X4FxDm0jGbJBs5+mMKi05K0OzUG12vU7N874VpPQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4240.namprd11.prod.outlook.com (52.135.36.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 11:09:05 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 11:09:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: fix locking argument in
 spi_nor_is_locked()
Thread-Topic: [PATCH 2/2] mtd: spi-nor: fix locking argument in
 spi_nor_is_locked()
Thread-Index: AQHVyfmtB/RTe4VPuUuyKr1XQJxpYqfoYgKAgAANwwA=
Date:   Mon, 13 Jan 2020 11:09:04 +0000
Message-ID: <5175555.c6S9m0lmIv@localhost.localdomain>
References: <20200107222317.3527-1-michael@walle.cc>
 <1617765.HVoytVeEL0@localhost.localdomain>
 <7344bb68b2714755a736e8d27e06aa8e@walle.cc>
In-Reply-To: <7344bb68b2714755a736e8d27e06aa8e@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fe4f846-331e-4725-74d4-08d7981900ad
x-ms-traffictypediagnostic: MN2PR11MB4240:
x-microsoft-antispam-prvs: <MN2PR11MB424090274B76383FDC9D1B36F0350@MN2PR11MB4240.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(54906003)(6486002)(4326008)(8676002)(316002)(81156014)(110136005)(8936002)(81166006)(2906002)(71200400001)(86362001)(5660300002)(6512007)(9686003)(76116006)(91956017)(66446008)(66556008)(64756008)(66476007)(66946007)(186003)(478600001)(6506007)(53546011)(26005)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4240;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMp3yfNdoRHiwR5u0n4zSEECxezu5V1ttH7HlDE14a6ga9HxK0Pfso00PpaAJUp80vOnn7txpxo/vtMTewm8/MzdcD3XAEfk/3+lTplB10X10vPDGtUJ7BaoaeebMoJ2UmgKSEYFZQ1b0d+PZtZutVwIhXS5rctucwJd7P11xrLoJ4HMu5ohXTWC7hxN1+bRxhVQmyEY0Mw93olc2XLI9YPIVgBdZHTPDtPjQbRQsOfN9Mn5VymJ6YikdSP10RMmrXVBgnVa+ZZez88pOR7z7jEtbmYYhECLcnPJ4CjZVoLdOP3kC4RP4U2uzZPSaHDzuRCwDjPFg4Kv4smGAVh8Zxw+srtjUA56LBCn5SOJ0PBnaPjIohIAdzF45kA/UNwlborKgsCi/9lBPnxWuEpfvuCzPyfwRJrkyJLs7lxcCXwSYEEiDyIXTF5TG/WZO9ZFQt/QdqnflxNuJag1tyUqt9NrWRbHwQKLnDHosmc1zFQnlGxHyejOrFCGGJjTpTNf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F636E13D199C1C4AB4C2E45224D7A4D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe4f846-331e-4725-74d4-08d7981900ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 11:09:04.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K84BdHyprooUt5YPTt+66lkakwZo0pt+v1umXkS8nczB0/wtlcPfARF0hnwfGdKsJsWacSE2zcD4mD8+EhUJ4Coanet3TIc4jRUZsUHl5bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 13, 2020 12:19:47 PM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
> Am 2020-01-13 11:10, schrieb Tudor.Ambarus@microchip.com:
> > Hi, Michael,
> >=20
> > On Wednesday, January 8, 2020 12:23:17 AM EET Michael Walle wrote:
> >> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> >> index b661fd948a25..a8fcb1d70510 100644
> >> --- a/include/linux/mtd/spi-nor.h
> >> +++ b/include/linux/mtd/spi-nor.h
> >> @@ -235,6 +235,7 @@ enum spi_nor_ops {
> >>=20
> >>         SPI_NOR_OPS_ERASE,
> >>         SPI_NOR_OPS_LOCK,
> >>         SPI_NOR_OPS_UNLOCK,
> >>=20
> >> +       SPI_NOR_OPS_IS_LOCKED,
> >>=20
> >>  };
> >=20
> > There is no NOR controller that uses this enum, can we get rid of it?
>=20
> you mean the second argument of the spi_nor_lock_and_prep() and
> spi_nor_unlock_and_unprep()? sure. But it removes information from the

yes

> prepare() callback. like in "prepare what?". From what I see its only

Prepare the controller for whatever op. As I see, it is used for taking a b=
us=20
mutex and for enabling some clock.
=20
> used for locking. Maybe then rename it to prepare_lock and
> prepare_unlock.
>=20

I would keep the function name as it is. Maybe Vignesh has some other opini=
on=20
on this?

Cheers,
ta


