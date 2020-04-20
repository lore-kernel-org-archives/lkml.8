Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B6C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266BD206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JVW5cLg2";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="L+OP9bfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDTMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:14:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48866 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDTMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587384874; x=1618920874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F5v/uLFYZO5WA9NgUC3siu3JBWvuEHnIKrI6SosES+o=;
  b=JVW5cLg25uNAO3zOfUHyQ6JHMkBCXGbp1Mhqe7fbn0QTzu1lbetv6Ca7
   FQheZOAkcfzNnf2d8JvAkinZvwx6rAG9zOtBbdKfOQi354R7DrzISUlOs
   YnCw20P8pmgAy6US/kJ49HlsekUI/V7siStfEczPuBgvlVI+OfNlY34qD
   /mqrJZxKxz7qsS0JM8iyVOxnXIOYH2lyCwHub44ZmQwyMET/AHIbokB0X
   8G6yeGKaZ79GjdZgwey3brusOvW/x9kXFgABXoYMXgUdAHKesQ//6k9qV
   kam5LDmXDurXQUkqOnXM0F+cbyEXZITdsmZZtPQkeIlqHpLasxn2zxKtn
   A==;
IronPort-SDR: SgSkmHq4STMJCu3iwrRgHq5Bei4GiQaoRip1SGZC+pV9zQf+KHoEnamLWYWOuImN3oNAOI9fCs
 YTvmtRluJ0xsDgXZ8xJVD5xL3tHHk9oJ8vHGToQFPUM5T34xnkCfoPAw1PvPg8kux9F98SwDNm
 6DIzvZ5SgGw6CZBA8e3t6w8WdGgLgfUv2eHgFH1Hq+Od12/RbO+hZiPYdOr8wYqX8yW8MAuJHU
 iLICSSsa/kz9ftOG6/WgN7B1p5j1tWS3HehzEe9NJUa6lAiAahGtJ9vwKo7DwczABznnJWwV8Y
 pLA=
X-IronPort-AV: E=Sophos;i="5.72,406,1580799600"; 
   d="scan'208";a="73890738"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 05:14:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 05:14:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Apr 2020 05:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIufhnjJ2LIZiab6qHRm+hiPkvJ643/telsZJCXz3rc4vLnNrhMnTf3i8cQupcmEOBz69NfFrTbfz+Gw1R2GgFiuLLs9rHpODmaZRBI53DKIOvp+Ii0wtpY6EBBPjXswzcAxpU33b2nFTVH9YGnbvI86TLenDVkzRAyrQmobmOv6g9KdeDwx5JTMn9wkd0TmhiJSJUaIx/tNMiZuBkVw2ORboX5i7NFvUnB/7AMie0/E3Ry+fKCHeFXzVyVLGn4+FMcd4vGJZMvl+1yR5Ukw5S/654+Hy/FRx3stIvopjTBDk2AV4hVRoiaF2r7V3wgEXtkzK6YgoygNDreSaEZNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otuktP0JJ5UxPiwkfed5DRe+ZEl8wMKWk16inPR1z/8=;
 b=CDHoKyE45W2zeWr/wiDTw6yDtU5v70ubKhdP0bq5TRJKAlX9Eq1rlb0f7ss3ohIpeOw+g21tOnaDRSTAhM45Zm5JxUDjj4b9hHTeaVJEXZs3UcwHUxQ3bYeeWOOuRTYs5YSoIchRJAU7XmDF0WPKkp0zSBzmrmTmoXELS8W/CUFwW5muVEzUyN6TIhphOiypxyiJPNcjZSmZyix5vpUUfCOhcntBBcS9NMQPAhkfWzXXM5sSyboFTDoEPuvobp2csrKcQKw7we0ImVVPLlr/pNKvogRov/k9FPS6QHIq9bSJFE6Iy1MuleU2WjNv/bQjIsxhqOY3IiFNifhArbGn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otuktP0JJ5UxPiwkfed5DRe+ZEl8wMKWk16inPR1z/8=;
 b=L+OP9bfioZH9XcsuLU3tkWpxUrKhTWQE6W2ZkOgx4zx1nmMk7LRz9WYlu3HwvE1CiYBZ5h/e/bkT+KAUTTJ7oqDtceU+KDIUWIudiAPn5DjsS0VYo5onUAg114uNQFFbnPuTl9J0Ta68580gTOQskv5TVWGasojJdSqRQLqJPkQ=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4136.namprd11.prod.outlook.com (2603:10b6:a03:192::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 12:14:31 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 12:14:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <cleger@kalray.eu>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for is25lp01g
Thread-Topic: [PATCH] mtd: spi-nor: Add support for is25lp01g
Thread-Index: AQHWFw0/tWJ4ISRUwk6rGADNBybaDA==
Date:   Mon, 20 Apr 2020 12:14:31 +0000
Message-ID: <1950407.5XCTmqoEVg@192.168.0.120>
References: <20200417160839.25880-1-cleger@kalray.eu>
In-Reply-To: <20200417160839.25880-1-cleger@kalray.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ed8a48-1945-48df-3c31-08d7e52461a4
x-ms-traffictypediagnostic: BY5PR11MB4136:
x-microsoft-antispam-prvs: <BY5PR11MB413645A99455209DC2C49514F0D40@BY5PR11MB4136.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(53546011)(4326008)(8936002)(6506007)(91956017)(76116006)(86362001)(66476007)(66556008)(66946007)(5660300002)(64756008)(66446008)(71200400001)(478600001)(186003)(14286002)(26005)(8676002)(6512007)(9686003)(316002)(6486002)(81156014)(2906002)(6916009)(54906003)(39026012)(138113003);DIR:OUT;SFP:1501;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j9YthWhseAwglrb1m4ofmiVUaZ7gauG+s1LfRseSbYF4R7+1FITAH4aD2PRv6mrKbn51PItKFDmmnE1eKAnt99AlT23cN7T6Ctc/PE8ed/4xQ1wqf+pxzo4I8RJA9mDcvS71wWKUBp2/vvw5YCqDjNW/udg2cmBgIgE3ThkvkmTyx57GGQ3T23aE6qtzhEwtXeHmgl/DkAZUHiHexJXfkAtyMvyq7einLZ4uLxZBGrZbe3E6/Dt3q0kyV2Q6/eXHXPIi7e2sbb3wlw4jBQvju4iJQbxmKSuLbUcBy0dUiepAAxYYPo+zc3Q+E85vLCtiNllLqAx9dD59Zrx7wkDz8ZaGb5bzHK6zhk8lynw0AViX44AmbXOjIp5PinE8s292sJDniSkxvbNIxBI+bCFe8JWAhKjxRAfCzTr67k44Whbuq90yrjizGqbsnOFZekNj6Ner0Nz5tnPFx4tvnszqfpbttylq6Xsjz0NhVCa7Mrhi66ulVXsQk33dCNBktHa4F29vERJeGs5OrJKD8cDwLs5GI1D+GZyCWgpwYlHt1L31jpbEMjtV7RDVG1vcLARnsgPFu6bu+Hio/dxqKSPtrTsgPQ4v8rM+KraD3qdfWwWRN7N21uyC/WBs50lM8Q8aVbBAx5K84g9ZrHzaepsoYf+mUaW22s40JDokSXCPJWSDhTbmnq8+HyCRkXyuaPxBtqYYfwFOb9Oke3B4Vo8BC94BS3lbcmxm1zYEMBDF69CvJfyVNkxME8c7PSdQ68O0GN9YL+845E2VxKIwcWUCP2IdL6/kMVqAS/w76heeALA=
x-ms-exchange-antispam-messagedata: LYHPjBWVmODKOStcloFrpHPJuzUduiP6EsKo+dFT624CCvAh0cCzMA34iGKYtPf0MS50JG3vsMwvTFajdEPvSgoX6kyRp8L5R0PNTHiaC2MX8Ch+OSFEztCz2X7AMgc9jDl/HmNkVoahl6RXj4m1ng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B2E29904E118641B933F430C110B0ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ed8a48-1945-48df-3c31-08d7e52461a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 12:14:31.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EF89kxBBbgkkheETL+76Tu8QIoOWXfPtXejyVQlUhYLwolEuWhaa1XcvyhnYDy97MTtX5mLcT+npu8g+CQFQ4WRxgb8cFtnqRbylueOjdNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Clement,

On Friday, April 17, 2020 7:08:39 PM EEST Clement Leger wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Update the issi_parts table for is25lp01g (128MB) device from ISSI.
> Tested on Kalray K200 board.
>=20
> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/mtd/spi-nor/issi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index ffcb60e54a80..c3c3438e3d08 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -49,6 +49,8 @@ static const struct flash_info issi_parts[] =3D {
>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_R=
EAD
> | SPI_NOR_4B_OPCODES)
>                 .fixups =3D &is25lp256_fixups },
> +       { "is25lp01g",  INFO(0x9d601b, 0, 64 * 1024, 2048,

There is a "K" flavor of this flash which has 512 Byte Page size with 256 K=
B
Block size. While the page size can be determined by parsing SFDP, I think =
we=20
will have some problems with sector_size because as of now, the sector_size=
 is=20
always set to 64KB. An incorrect sector_size will affect erases and locking=
.

Cheers,
ta



