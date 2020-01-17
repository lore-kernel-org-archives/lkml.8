Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48223C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058102073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bE4/kovb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgAQN5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:57:15 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52087 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:57:14 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 7Jd4np2x5iyJ1VTskUuV1In+XiK39WY2mB+lfr7gRUT/3Fdq0P42brvB8bRDFG96OwhIHW7qqu
 Wk6iFI+8DA17PRNoT/s7+sxUW2+PrGFJec9qqdfJcQxlXyWcItEHCgJfhsn8M1tfwPJrtaGap2
 1IzRQmfwE9yU+oLj09pf/u6mLTPLILrnhll49/VtqVKISvV1JcdzUj+S5LiuRurFe3o+4Eho0s
 QNM5aApHeG1LPHmTEpjczzO0hJRyeq2gSI2IhbL0pKXsw8ySic0MrJGiqjAq8VABBS+TexOBs2
 e4I=
X-IronPort-AV: E=Sophos;i="5.70,330,1574146800"; 
   d="scan'208";a="62277244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 06:57:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 06:57:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jan 2020 06:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp9g7+XvCnYHvZRCHHd1qopTPI3OC/pKQwuU2NqUD+eOnl7QPCEXLi8f8PoiAYGhVHiPscwKUiBGlji+zYYjH3YUDZPXOxsNvC3gF3zntNJQvJTwalKg8/miStGdbYMivcYoa+J+sH+Aw/eF/8OjDT65EceWZZBn4i1FaiSLPatEKeuC3JSHqOLRitTO+6ic7pXaPrl6Wf8OuxdR8dNa6lSsZTJYjk2N+JKR37K/kVkCIYiz8yMHAcRPZQc4oynNovQGUqNyJgBdK+Th4FgrSSX86pZPxx4ZP9M2nnVhrHdcVWaM0ilsfZWOoI/8g4u3vP+en6SZfMZb1yWqIL0vZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbOM6vT24cGNFBXttd4pxXe6dCi83XMCvd8Az9/YEeM=;
 b=lNTAFGzB9aj/8BOV4A8jpLDbLFXg0yMKff5dIMOo8eI5IYRuJGElYPFDeo9vQde8YF2FFmk2VGkxy0GcjGq+b11G0wb7wu/9Iyo8L11bzpyCuQUZePJF/Oz7iiomVOU198XxFKonz4Hics93AifideuNFoo88SKq5foqrtm18Rzy3g8BgcjJvZIuTcBNvnrw+dAGXwglzV2iudY6P4v/xM1T3AIRCt7tFJHjPqrC/WD0f8EhuSk8BSe/dR7Ud5uXz1pNpNapauOJhzbwzc4JDsmDOyiEMuwrRP+ibwGOjpKP/p50gupX11IDd7EA1I9ClLSd7TSRJ2W2XZHWbda4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbOM6vT24cGNFBXttd4pxXe6dCi83XMCvd8Az9/YEeM=;
 b=bE4/kovbD+n8xksYeLcs9Q+q7bpuQ9/ATLnQNOWl/dG2Wks9R1G6n9+SuEhAG0wQ7OEAn4d+mF6vTPGCl5HgLKZ4McxACRkJ4aiw6dh5ulAuxouVRzYfcMsJf6qtIGkmm9m+I+sdl4N3ZkU/K3uyBApS6A+5XTrSBe2/XkxJ31Y=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4125.namprd11.prod.outlook.com (10.255.181.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 13:57:04 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 13:57:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix selection of 4-byte addressing opcodes
 on Spansion
Thread-Topic: [PATCH] mtd: spi-nor: Fix selection of 4-byte addressing opcodes
 on Spansion
Thread-Index: AQHVzT3/7b4WTBnS4UypfxmdSedmUg==
Date:   Fri, 17 Jan 2020 13:57:04 +0000
Message-ID: <4519613.SuZX2zaz4Z@localhost.localdomain>
References: <20200108051343.1939-1-vigneshr@ti.com>
In-Reply-To: <20200108051343.1939-1-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 392e096c-ee0e-4af7-4f5e-08d79b55224c
x-ms-traffictypediagnostic: MN2PR11MB4125:
x-microsoft-antispam-prvs: <MN2PR11MB41257E823C205389F1E2FBF3F0310@MN2PR11MB4125.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(6486002)(6512007)(66556008)(8936002)(64756008)(66446008)(66476007)(9686003)(76116006)(91956017)(81166006)(81156014)(8676002)(4326008)(86362001)(5660300002)(66946007)(110136005)(316002)(54906003)(186003)(26005)(71200400001)(478600001)(2906002)(53546011)(6506007)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4125;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1fE+NknBWapWXqDQFAWDxrPvwj/n+wP4XUiGmqrhI8k97LQykU+Z0mqkiu6t9ngLYMRx4lL+YhXxk7zhjNgHPR78NbGpYom8AtAa8Ed5/Cz7dCsA69s/LB2yDRj6XS4Mue/kUCidxPucY6x3cUu/TDXxdAHUf/OMj9eD12OsYIwNI0B6uaD0i8GpnQ2gjK+9Cvz9uSUGU04Y+tzQHfotbVizFs2YIanixut5T3CRouil9G0HG42j6wukd6x9Kpo1EtOvFN7fjE7esIQAmR/6bJgmYlgRAbG2d2hSjz95uV4zEjlAVZmxabnzvG26p0bO9BLLuAZCbZKd0XDA8OklQ1luGcVgH9pjPy5nVsRM7DUMIzCQcKLKFmhWiCajUc0yqVzgpz1PBzIg9N2OzToF/t4eW9yAsL7uHv4+FizvsX9dO7mcQmg2myV+XV2Vj5nF3TwJF8HFFw1RhmiDXMo1OYizV/bjOwmBSc5tFgEPFh7p5B5QiqwNl+lw+QJNI6E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82E4067AD1AF244AB8F64A46585AB2FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 392e096c-ee0e-4af7-4f5e-08d79b55224c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 13:57:04.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIyF0Jlzx1L0iRnLWnpHs4TKvq/ZbHiiWz640XsgXAZkgxdHVX4acqIKH9+d0Lcqc6o9Ps2lPhnWIyTdTfT8VN/9UqDp8ervtDq94EBGfGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel,

Please queue this to mtd/fixes.

Thanks,
ta

On Wednesday, January 8, 2020 7:13:43 AM EET Vignesh Raghavendra wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> mtd->size is still unassigned when running spansion_post_sfdp_fixups()
> hook, therefore use nor->params.size to determine the size of flash devic=
e.
>=20
> This makes sure that 4-byte addressing opcodes are used on Spansion
> flashes that are larger than 16MiB and don't have SFDP 4BAIT table
> populated.
>=20
> Fixes: 92094ebc385e ("mtd: spi-nor: Add spansion_post_sfdp_fixups()")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index 1082b6bb1393..cd47f07deff3 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4783,9 +4783,7 @@ static void spi_nor_info_init_params(struct spi_nor
> *nor)
>=20
>  static void spansion_post_sfdp_fixups(struct spi_nor *nor)
>  {
> -       struct mtd_info *mtd =3D &nor->mtd;
> -
> -       if (mtd->size <=3D SZ_16M)
> +       if (nor->params.size <=3D SZ_16M)
>                 return;
>=20
>         nor->flags |=3D SNOR_F_4B_OPCODES;
> --
> 2.24.1



