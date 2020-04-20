Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3BC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70718205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s8il7NlB";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="X2ZrHJg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDTKxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:53:21 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:40807 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587379999; x=1618915999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZuPXdwBubRWzckv0AlLDY2iKwmKwat4MlAGMlwJGTmE=;
  b=s8il7NlBZjrx0GG/1xuPhXv9E/sl/o7NwcO09jlEBW6mDXJIb8FmhZAM
   AMa9X2TIVcp2RMg5pIN350vqxZw2yJ+2UlXYpd/tJEXu7n/D2BEU5/f5W
   kVMpVjk8ciqZG1xWLfbM+s7kR7vm6aCs4XOddUE77GNDPYrFwS2IVlPFT
   ZFQSEAa5YM4KuP45wN2p32wOeJLB5DnCCpCJBFpSdqP+uP1xa8fQ2uGSc
   XZM23IGWawdnfMvsSu9AnO0sB7FSfRIuufCZObebQm3dNP3j3cV34drLQ
   g0dVROQaINKf3m9pClDhLXWB5lv3p41h2CADex37Gql+cmfJla2zIBB++
   A==;
IronPort-SDR: k1g7WKsjD+fD3FUY+ngDoKaDcgavEjgN7ZVItSI3YTcPndA2/UmvMhL79Xg6NNGhkdDNCT1Rcj
 CLf3ntj7w3kAf0olFzlhsLMiPRoLHGvoTQ7qyiyGaUoZLGDgdY3cxArB9cuPG05FAHXQXp1O+0
 WhOyOhCkulumPKbWf/lASxMSI8wIv8mQGS1rUrQwxTSUs2UPXiJ5GILievWVv0ik4nlsDkYGDd
 fM7B7lGWKYXsvsoPVBHmThpCCGs0XbgaU76v29JGonKmdxbC3uiOuz9LW7zuR6BxJY2Vk9lJr2
 4Jk=
X-IronPort-AV: E=Sophos;i="5.72,406,1580799600"; 
   d="scan'208";a="73112964"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 03:53:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 03:53:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Apr 2020 03:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrex+YLwjt5QkibK+uSS8sm48HnthY0vtBUgQC1WQR/nL+yaCkL0LXnt+v+x0qGmVuW5sPVGgWD+0mYr/9cVcmwI6VT4QkRWB5g0RUHfBigA48PeMrgAJ7SIDJjyajJJnoz/gGoN+gMc5J/r+j5EcNuVYQurnqnYIN7Ht4YzuO/ALKludjh1ko4Edp+gpTBe3mKkuEwhkFIzDuWngxmeJOqlnic9XJqm786KFPYO9uWnO3GRGsX74DteZs8H2wKQ5cIEVKOWQdFdFHWsvHPuPmDLgSI//+NpHQU1OiEuJ0ck+Yv2RTTFDlzJDSVN4Tk3Fp2JStDX5DEOY6uvAPgiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkD+CdL/4Whq3+RdNntYgEDDwsTe0zXwbgEw1lg7tVQ=;
 b=CuKovDf+LLwhruUWm5twjXZsCQdY/BEyK5TKYn/D6s2PAj+duEW53tJSjQ/WFtxvLileTWewgfIalIATnMW/ngLUtEUhdLYd6j9o44nNk7BV8A+BXk48P2dkFPuQNXgut8n9i/NSepaA2ZhnsPdurPGwE9yUR0KK2dtP4QNzJzDh8OSCqQ/JSA7/BpxzPqPApQjceUTmhHmcUqFhxmB8owH0l5IJX3KerHcHqg3PJxIs2e9tMFmt5hf9T7g4S+4HK4/Ltoww5OSi879qiVnzaxKvFM14CBmuH06M1hMhXLsZEOVSRchewqYlj+MXjFjUB5NDG+pz7dg73KAcVrvGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkD+CdL/4Whq3+RdNntYgEDDwsTe0zXwbgEw1lg7tVQ=;
 b=X2ZrHJg4gXPq1dbSSqLt/5GG/ypGXGjHzZbfikbTv4CaLTzlFOPhSID0QJlRiFOv94T5FAKkWuVCAwPeV24i1klPAyQAyhToYdJFIDp/zaocZ90eONLufsHC53073G/SwAOODidkSEjnpot7YciVCyzS+qk/dMUj6Z5l9fZIg4A=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4323.namprd11.prod.outlook.com (2603:10b6:a03:1c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 10:53:11 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 10:53:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <mantas@8devices.com>, <gch981213@gmail.com>, <robimarko@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix 4-byte opcode support for w25q256
Thread-Topic: [PATCH] mtd: spi-nor: fix 4-byte opcode support for w25q256
Thread-Index: AQHWFwHieCOFTav6rUeke0dD3DMEOg==
Date:   Mon, 20 Apr 2020 10:53:11 +0000
Message-ID: <43054851.jYS1km7NsV@192.168.0.120>
References: <1586958510-24012-1-git-send-email-mantas@8devices.com>
In-Reply-To: <1586958510-24012-1-git-send-email-mantas@8devices.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4810fd8-757f-4c04-2a9e-08d7e51904b0
x-ms-traffictypediagnostic: BY5PR11MB4323:
x-microsoft-antispam-prvs: <BY5PR11MB4323BE946F401E04403EDC08F0D40@BY5PR11MB4323.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(2906002)(71200400001)(26005)(53546011)(6506007)(54906003)(110136005)(316002)(14286002)(8936002)(8676002)(81156014)(478600001)(76116006)(186003)(66476007)(66556008)(64756008)(66446008)(66946007)(91956017)(5660300002)(6512007)(9686003)(4326008)(86362001)(6486002)(39026012)(138113003);DIR:OUT;SFP:1501;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIWlwxye75ihc9z9c4yL2xcxdkFXHRPuIZ2AVpHT+8QojxdJ89tyQR1QEB3Kj/sb7+m+epd79YSQotFPjoJDmohzymtNxhQbpP0nNY3ggCo6gHY9ANYhikdTRa7LuSXTKYPgpvpd6r/iG7O+w5rNMGgq0NBHmQZJbg0kvTYupHYH0mmJrNLkAU0/+RBO1xVgrwLwxyfdnZorumVkIP0kJugzbBbMJ4YHo+yrScOloVwehNz2pWK7BRgiCeaZ16bNp9VfCeUDyCtGbsnjufvvJh/MDj8/1gyDTREW3cU3xXv3MjjheLJ5cRhC68PIWtTkfjJsUdN9HxlR5dm3yFt6hoLmguWXdDguCIVX/B/85hMZi1nsnIbdDftyI4rHrxUzPWl4wXHTqzNjpniROTtNf+VxgVXuIaydnpcMHExT5TtjX5oDXax2ZZArwqNRdkBq+kOymtdP3TdaXE0QVJjDptLXZtrxa5iXsBGQnIx81f4khCgLHJVATLW8uGVfKFplKqFNqImyieYOd4Eo3E7vGQPGK8mQTZsIqRcJ/IHdXgMIBwdpvsqJvjBB8MYY/wSL5baW2RG5EkKIY+J2UBE7g2Suouk/w2ZtjufE9jCsDL4c0X5FM+5NWRkfSCCK/b0aiUyiNHIy41/W9FLRieRU7yc1x26UilurLVjMBOeKJ55weTmgXRaq1aA4qvMns9MUXRxq5fdiiEw6UYRBC04PI6nZI6dn1whkZIcE0iXzKmhhKzc66+dbmp5PmR4UYmwOSNkex7beNwWITE96rYkBkhpWAdnht4CUk40yAE2cA1U=
x-ms-exchange-antispam-messagedata: FjHgMLFlW8lPwWa8omhyQgYBkeQaJCu3DwuREFiwyZ+/uXC1pzZ3AVq1PAcevx5gAoWHqnA+PZ6Q/5LDdDRRX4IseWWkSsmFrusQSscTGYG96GIm6Jlz2GkbVfIULh8DVUpsATlHopE9mGBsjn0kFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7299F304612564A84A4021D0283F456@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4810fd8-757f-4c04-2a9e-08d7e51904b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 10:53:11.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVR8gSFWLwmogusvzHuo4Oe5/qbQ+jaIag43hh/5H4EvpBenwoknmA0QkJb0U8MXndMTzSxgGP7Zri8VrP+l+rpmiPZ8tBzOH/nM3rylTOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 15, 2020 4:48:30 PM EEST Mantas Pucka wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> There are 2 different chips (w25q256fv and w25q256jv) that share
> the same JEDEC ID. Only w25q256jv fully supports 4-byte opcodes.
> Use SFDP header version to differentiate between them.
>=20
> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c    |  4 ----
>  drivers/mtd/spi-nor/sfdp.h    |  6 ++++++
>  drivers/mtd/spi-nor/winbond.c | 30 ++++++++++++++++++++++++++++--
>  3 files changed, 34 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index f6038d3..27838f6 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -21,10 +21,6 @@
>  #define SFDP_4BAIT_ID          0xff84  /* 4-byte Address Instruction Tab=
le
> */
>=20
>  #define SFDP_SIGNATURE         0x50444653U
> -#define SFDP_JESD216_MAJOR     1
> -#define SFDP_JESD216_MINOR     0
> -#define SFDP_JESD216A_MINOR    5
> -#define SFDP_JESD216B_MINOR    6
>=20
>  struct sfdp_header {
>         u32             signature; /* Ox50444653U <=3D> "SFDP" */
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index e0a8ded..b84abd0 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -7,6 +7,12 @@
>  #ifndef __LINUX_MTD_SFDP_H
>  #define __LINUX_MTD_SFDP_H
>=20
> +/* SFDP revisions */
> +#define SFDP_JESD216_MAJOR     1
> +#define SFDP_JESD216_MINOR     0
> +#define SFDP_JESD216A_MINOR    5
> +#define SFDP_JESD216B_MINOR    6
> +
>  /* Basic Flash Parameter Table */
>=20
>  /*
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.=
c
> index 17deaba..50b2478 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -8,6 +8,32 @@
>=20
>  #include "core.h"
>=20
> +static int
> +w25q256_post_bfpt_fixups(struct spi_nor *nor,
> +                        const struct sfdp_parameter_header *bfpt_header,
> +                        const struct sfdp_bfpt *bfpt,
> +                        struct spi_nor_flash_parameter *params)
> +{
> +       /*
> +        * W25Q256JV supports 4B opcodes but W25Q256FV does not.
> +        * Unfortunately, Winbond has re-used the same JEDEC ID for both
> +        * variants which prevents us from defining a new entry in the pa=
rts
> +        * table.
> +        * To differentiate between W25Q256JV and W25Q256FV check SFDP
> header +        * version: only JV has JESD216A compliant structure
> (version 5) +        */
> +
> +       if (bfpt_header->major =3D=3D SFDP_JESD216_MAJOR &&
> +           bfpt_header->minor =3D=3D SFDP_JESD216A_MINOR)

Not sure if this is generic enough. Are you sure that the JV version will=20
never have an update for the sfdp tables?

> +               nor->flags |=3D SNOR_F_4B_OPCODES;
> +
> +       return 0;
> +}
> +
> +static struct spi_nor_fixups w25q256_fixups =3D {
> +       .post_bfpt =3D w25q256_post_bfpt_fixups,
> +};
> +

If the post_bfpt hook is called, you already have a valid bfpt table. If th=
e=20
differentiator between the JV and FV versions is that only the JV defines t=
he=20
SFDP tables, then your w25q256_post_bfpt_fixups() can look as:

static int w25q256_post_bfpt_fixups()
{
	nor->flags |=3D SNOR_F_4B_OPCODES;
	return 0;
}

Cheers,
ta

