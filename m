Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BBEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244E52166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Kd3qekBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCBSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:41:46 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55530 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCBSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:41:46 -0500
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
IronPort-SDR: MAMv96/j/LMDj499/TZQWziL9NGmVkwPMckB6taGZVmmH5dT9EGw85L04fK5cKBknLw9UTCHuv
 Wgvi4JAphYLwitmkW2QsVgnHy2fWjCj9ZCbVIspOTZce9LmWi0iltTOugws/gvhdC61bHHRzl7
 aH+DN7i0PQ2ztzTuX8QaN35DH/qFlm0Sc9XJQlINAILwlYzn9Qxvf4FssnY7+hCDPMEn/Sm+6H
 i+X/8fuWRCofaxmbiWFGr5zDnEmbs7mo6R2PTg5Sagq9ztNuf9aAmHr8F7Losv57e+7h48fQj9
 N64=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="68556762"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:41:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:11:43 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7T35jznAy0NxP0HP1mt+cYNJd4VqONpkNJQd/MQLKYYU0J21b7gnnESvOrad4CBy2UfAGx3CLId2+ZpnEvmKn2pgjjj/wnZExJ3y1NTj1y7dyn/FcSuMB3p91LA/EpXkWRMAd7HMx6BhdVaUIFpuK2pnPxJUjUfHxsK5wcrgp8HDJWaxrvdMEtKVlB9uMeo0hgWiMcsLQIfuYxT5z5FARM4FNiU09ItL5nXpBFMcjVajJ4PDcwNwwKwWn/pBXcbk4QZCwALLGMaiuesE3dJiGZkhXrMVmraq/8JAInzYZwja3xiC3vOCdSwAOREmFiAKCEf0T4zqf+asy+VkwiGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7evzqpedXlC2VW5XtGOozKmkcbq8HWazP2age8MSy8=;
 b=nFlzsBSDN3Tf9SOu7p6DwEcG5//WDqJ04zaMHpOsYa05mDHgDWyiL33EFhh1nAiN/mG6Z35fbl6aRyIHt3upVrO5MOs45uSeQieHExOrJr68Q59ZNPpungzOWS7ra2sqMkLo98UQG8fu/IZ1NmBrFoVAWUI3r/RvH+IvNPIMqrKbTxXEKUBskEyc7jqJcqljAnBmGm/hmMI4pvGWk25T9JeBPJJUlFxhNiQvgkSHxO2h2crQArUFYC7jGGKs1Z5nHTSh4hl4DCCf4Vtf9pPjbNWSqEmEDnqSKFsCsLFtavZn4kLgbbDJwEi1e3qvxTqwNE2YZXd2KIO0WpbeunIaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7evzqpedXlC2VW5XtGOozKmkcbq8HWazP2age8MSy8=;
 b=Kd3qekBE3f2fljwh10ntKkpezw3ap9Fs/hX3q10TugjOx9xeV+6OrnZ/x3ppYOwr998cp3b2Ukro9jov+idK3FCbF0B7spG+EZClQYHUivF3dr9xKPgsRIIa3Tb+5Iw0uX1Ybu5hRnc3719c783rASxp63kuMmzrQTRVYekEBCw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:11:41 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:11:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <j.neuschaefer@gmx.net>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Refactor spi_nor_read_id()
Thread-Topic: [PATCH v2] mtd: spi-nor: Refactor spi_nor_read_id()
Thread-Index: AQHV8L4Gb9MROFWvGECs4qQxGNhQEQ==
Date:   Mon, 2 Mar 2020 18:11:41 +0000
Message-ID: <11395630.65iIH9RknS@localhost.localdomain>
References: <20200223173713.2981-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200223173713.2981-1-j.neuschaefer@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ccbbcf1-7a25-4d15-9532-08d7bed528a9
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-microsoft-antispam-prvs: <MN2PR11MB4142A17A7979CD600170DC57F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(26005)(66446008)(6486002)(186003)(4326008)(478600001)(9686003)(6512007)(6916009)(966005)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(53546011)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(81156014)(81166006)(8676002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPb+a+c5DY3M5J/7yVQ+3Cq/WliwU0vtn90GWxRRig6lBwmZza0Aq87Q5rQ7moPMcq3+8BkohdLCviA4BvQFXkrzhhWqdEvCnNXwTkFoYbdhUHvYz3I5Q41gHFDMH271JBbnJXp3AUohKZzlMiwXS/ZrT0ZUdruQ4M9jJCm6XlllYHOLt/rkosm2LwEvUEd9vvGyRVFBa5GS3v050cDlQSAeNGoAoONdXQn4K/sMXNviafqYg//xlo1MKYJEcYxf8MIt/D80BE9zFDNp7cN02CtWMzbp+L+36vtTI6Ps+JEX0tfot5WAdEr7Vt1Y7AmvoNwhO5RKz1AaTdxdxvY7DmQp2zYmEwPKbvKjL0uZTfQSVsExfdgklhh5PWEUvzUqJXRQsBf6BmZVeDiD/Oyaezzbxs47hbzcMUH3twZ38OWlWuw3oTSBGanLQw18qX/d1NiskWS95de8qZGq4f+5F3LI1E6zT79eT+YBDQ0tTbPlV6QjLPGz5KZE1C15XUwK+jyX/OuQn6ICqEwVAUGy1sSx0bcb4lcLKiqWg1Wd73hbnNowqbmG5Jz3YZoPAe/u
x-ms-exchange-antispam-messagedata: 24b6jiSJqii6+BSGzdpBr0krHHamBMbAvAEEqk2DmjBhuC9OBtBDnipPeS6cAtQzMD2bo/vVKnCx135WXt+KhzzhwcVCz708kB3v8GAx11SuV+5h7penK1SrNP1yrYLyb0qgk94shQU0Rr888lMTDg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <256C4BC2074A704B87D53D8B1AC8A49D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccbbcf1-7a25-4d15-9532-08d7bed528a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:11:41.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DTb7qm4tDWhhQ6Om+njeW0d2kMHp2qirOas3s5zR2ubUVGaGgDbYHUMu8T2+ed2l7UJJD53LtrE2lnElUAMpc95EJbk+bIc71fPM8WbvMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 23, 2020 7:37:13 PM EET Jonathan Neusch=E4fer wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> - Don't use `tmp` for two purposes (return value, loop counter).
>   Instead, use `i` for the loop counter, and `ret` for the return value.
> - Don't use tabs between type and name in variable declarations,
>   for consistency with other functions in spi-nor.c.
> - Rewrite nested `if`s as `if (a && b)`.
> - Remove `info` variable, and use spi_nor_ids[i] directly.
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> ---
>=20
> v2:
> - As suggested by Tudor Ambarus:
>   - rename tmp to ret
>   - remove tabs between variable type and name
>   - remove `info` variable
>=20
> v1:
> - https://lore.kernel.org/lkml/20200218151034.24744-1-j.neuschaefer@gmx.n=
et/
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>=20

Changed i's type from int to unsigned int, reordered local variables and=20
applied to spi-nor/next. Thanks,
ta

