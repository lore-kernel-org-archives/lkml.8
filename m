Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECDC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 07:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B7720684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="b4VZnjo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgASHSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 02:18:50 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17085 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgASHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 02:18:49 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: iMbeh+n3WdhBQE/V1MSzBE/hYpMhpK+BP4bXWdnq8hEz+jmvD3PNVcIaRgGybNlSTxWTznC6kA
 Sc8VvVhNxIH0MEnMXCzr27p3zo/ny/RqNOICPEtBAANg4ZwNSUlnWSV43csa/w2wVQONQoNubM
 TenQyun2F4ys2u0aVo+XReXKdAnnJGAZ+QYPJI5osf0JxeQE/RO1mQSeG9d82D6itDYs6z8bLz
 gs9f4Tpw/NuT5cIdXRQheNfl3Zi8KZFMN6UOGyCnyXlkAoCoLvVvOAD4d0uPyVjVse5k/E0e6P
 08s=
X-IronPort-AV: E=Sophos;i="5.70,337,1574146800"; 
   d="scan'208";a="61502180"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2020 00:18:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 19 Jan 2020 00:18:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 19 Jan 2020 00:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2SZskRzuS9NlKEE21wxcfHA240abnT71TYptVu+PQ1g61CtukVNjK70LTQsfdeVc5Dvek0Jax75U+SHqKq3NG51l5GSwozA+L4QcG0lMzerleQ0/DvGL8ZnlR4jw818WajieO6hFPmolG/+l7IdEKX0h7FpoBPGfFu4QCwrodCre4lH23Nj7aKQY3dEyXskOzZU3XrVtD53tbPn5f314w+OtbYjeP8w+RNLlneoK4kqngyx+AeWXMnpC6jBB2WEnBsex0OjC/+BcXqZ99VFYxBZqceA8f/FCohW6U1IAYwtpqrvbJUNaktztu+LFuPcqkV40Kz+9oFdeHf8UlwTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZrbUn2/sNWljzsLafFxYfg+4IZCos5jRXg5/VsqT/Q=;
 b=lXtCLo1YFPnsf2SZ3Us5jydhKqrt304rk+AKfrtvMQMhBqA/YhB5F9i+f4iQx9YGvHFhXdVTgcJm7YW0hn8pxYCyUpkBsAu8EOyD2FFQjSkMu2UTm4NHM3cGb7BkQzXNJyg12O084JNoNh2r+lqpvlTXiLqf2eIcON0naDje76rb1olunaoMRi8CKR0Gg/l/UqSj9rXqtZdJ2P6ws5bNEKB4acOUQqWwTgZVxhIkGEIx10u1lCZbvPu70LovL9h3IskO2C12FThm0us5mt/l/sqbmVQZueLEdLDi4Fiy2VrSdSuFUR+W/4RxAU5nxB0imV4IvXsZl02NLvzkK+0zvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZrbUn2/sNWljzsLafFxYfg+4IZCos5jRXg5/VsqT/Q=;
 b=b4VZnjo0HVdBWVawEkFADrtQ+c7qesRnwxe1NO7RGoLeOVTQ79cmKfkR1EuVfj82t1KAaPx/dINNUXcDakAf4GHR872d3U9hPRUhO1bGeWz9h87ZmraMbO7+BpsDGwDo2hdEq0yJ35+40dLTcWPdedKeuj99J1d12d5xKlIKZcQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3629.namprd11.prod.outlook.com (20.178.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Sun, 19 Jan 2020 07:18:29 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.023; Sun, 19 Jan 2020
 07:18:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for at25sl321
Thread-Topic: [PATCH] mtd: spi-nor: Add support for at25sl321
Thread-Index: AQHVzpilvOutjn1Y2kCsQtSRhdzp1Q==
Date:   Sun, 19 Jan 2020 07:18:29 +0000
Message-ID: <2121499.oPre2Eb8Qh@192.168.0.113>
References: <20200116160209.20129-1-michael@walle.cc>
In-Reply-To: <20200116160209.20129-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f8facb7-22f4-4a54-c270-08d79cafc87d
x-ms-traffictypediagnostic: MN2PR11MB3629:
x-microsoft-antispam-prvs: <MN2PR11MB3629B677AD2A04404D35BCA9F0330@MN2PR11MB3629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:SPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39850400004)(199004)(189003)(26005)(6486002)(5660300002)(6916009)(186003)(71200400001)(14286002)(316002)(2906002)(54906003)(66556008)(4326008)(9686003)(6512007)(66446008)(64756008)(86362001)(66946007)(8936002)(66476007)(53546011)(81156014)(6506007)(91956017)(478600001)(81166006)(76116006)(8676002)(39026012)(138113003);DIR:OUT;SFP:1501;SCL:5;SRVR:MN2PR11MB3629;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJZKxhACa+mOZkxaSGgCAF1SkLi/5SLnRQX9sTCZqvMTOCODFBHeexvKNct7gD6ZaweGlP9ZRNM0XpqB1RVcUa34Z1lSY1n0/I9IQ4i3R5uaJaMhvGhkLpy3gMa+gn/y9rPh8dkdzC26nWUFIXYBW1pA3nsxMYeALaztKE0k8KQo3C0ZYIOXhl/zSwK9Esy04JBTSwipyMd/QdP8YVB0U+Eb6xcT1Se2y4LS5sTzDzQVFmJIFjsdrrQshbm84J3yvBBho0YVCEUwJksQZOEajHSAEN8m5STrB+u7jVlGF0QHhEz2KE8HO6hAW1+WetON+LHgZXen6vZ3tm71sa3KfL+e69KTRgTMGaulfrX6fZKED4VvbR4q5iCPo72d/QsH3VPzgSJR5VCPEOM1TY/3mBDFnqICTxMVru5fUrAKtf6oXVXhFi12or6Ml/LduRMPX5+x8755qVizbMzedZ47S5HN4/2Vcu2sXKM+FeuCdwQILMi0rozAbWWs9/Qc5P+ThXBaShX7WuVVBNatXRIVLouTZmuibhG2G3Os4T/dZV9QU1HqR4u1x3miEegSUM/sQ03on+oG4HQ8s09me/6VyILrnAmYlP0rAmjCtTZkUc5Uw0DZVhckvC1IafquFstEpfd99m3IevffVcCc9tZExZHOO4ygVP9X3g5Bh6YzSpp3bI3B6aG1jit0BCvIpZgUQ6tbh//wMlVS3zqBRdXehnPr2HQVX9tzWxyd55TEDPB3ZnGxDrLjz9nD0CMUCBBUt8wZNbAp9unsiSwt4j2RsptpG4/8mb+L+0fWPDvuLGM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6DE462137E06C428578221D584C2880@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8facb7-22f4-4a54-c270-08d79cafc87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 07:18:29.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0LOwHlwWHvkZs0Qr2LKS+k0szPsphTY7HIpVW29bVCPWsBxZD5rYNN1a8RTMxS9zd6CXMUCq6MYpbxIcwDx3DPBXV9TzWK3KXR0FV5rZm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 16, 2020 6:02:09 PM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> This was tested in single, dual and quad mode on a custom board with the
> NXP FlexSPI controller.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index 8226d6450069..94747059344a 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2332,6 +2332,12 @@ static const struct flash_info spi_nor_ids[] =3D {
>=20
>         { "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
>=20
> +       /* Adesto (former Atmel) */

All the atmel flashes from above start with Adesto's manufacturer id, 0x1f.
I dropped this comment, ordered the entry alphabetically and applied to spi=
-
nor/next. Thanks.
ta

> +       {
> +               "at25sl321",  INFO(0x1f4216, 0, 64 * 1024, 64,
> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +       },
> +
>         /* EON -- en25xxx */
>         { "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
>         { "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
> --
> 2.20.1



