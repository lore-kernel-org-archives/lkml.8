Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F1C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CEA24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PbL2cZCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBSIGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:23 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16780 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgBSIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:23 -0500
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
IronPort-SDR: FG0giC8yO/zxEicxGN5bdtY8IGoFWrSm2JPVl7hEQyj551DemTPRlX8nejnWvwuqI8Y+XNE7eG
 oP/b91TJPfUEP/zdy7hPU2Xg5BNDh3VU+PwSytngA2BSRwKtfiv8xAMpNtvvBQNDkmyA+VLZRn
 GgXmE5z8YF4yQ6Uei3X+607u20PiOytLBkJt3i5lfjT+lkqb6UwtJuCXcGfm9MKBIpkloDXun3
 RIOOvKjIkeahHMOX/VKtKYip88ytMI3j5247e6FAtg/gp6ToT4IR2IpAv5A6VWF9eRNZvD793i
 NmQ=
X-IronPort-AV: E=Sophos;i="5.70,459,1574146800"; 
   d="scan'208";a="67180599"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Feb 2020 01:06:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 19 Feb 2020 01:06:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 19 Feb 2020 01:06:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezIQtEvznOLYayLb99itK8K7+KUoP2FQWr853Rwu6SD4sHquhRO1FGHGle/wYMg1raZbliMxLLUrKnXElIxU/Bmz/Y9za9Mll0+kqHmOs/yXUqYuqo/jyaur00jBuAT6m/fWwHWrp60y3zFGm51ye0qULaKTsb+F7nFVW2Zg0ybkoyu5iH8unjFDgb/rah8OwLVPFu0xGkEh4NSFoS4EQUXJ3z2OF0z0c1gb6HuzXAEBfuWoW1SO+/MGxZfgjSWjsziVjbHP8cBv6q9EIkN43g18QIY8mAE+Gb/qg8JJ7fmAunByetb4tC0GladSqmqSAwWkcMGWismcQtz3aBCYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8czYuADdaQQwt8BtN1lJ+OPd5Aa27YGlhC2kjdKBQOc=;
 b=IbYDxy6MbLTpQe6hSQp3ZHeZbvJwpoQOqJMBZ8mjwIxbHotsdMK1z2+3IKCMZce5CaysDUn/pzvZ59TddFH4MZMBYZAnZa5aNdt4HJiKL4N1ezlW+ndmNSNouefHlfP1l46MNtSr/MBE0WYYkHfbc4/zZCBq2Kmk+N/ylDX8Eg7A0Is1ZfbVHTI5yLrGX2nZYhwo+3DKMSAgswPl47/YsHV0rmqMGfPxoeoO5DzE8UNKBjP6nyzMCD2k866y+aFHJ1MatuCVmtyzTbkiHsahBjC09i3eLTuvlMcItHdj0skuhcjPnXTyH5t160HfGCTNyPmuMJBq+nU/VuKWlqipmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8czYuADdaQQwt8BtN1lJ+OPd5Aa27YGlhC2kjdKBQOc=;
 b=PbL2cZCnJ3RAZuqVw9iYXj8f0BxcLf743/JDsYcjAIkLrhEjYnqlj5kbFyKdgochfXOX6nGNO1NK/E3Bm0fy5sA8mypXbq8nKCUkX5tyHptdf4BTBEErBDdHBgk1wIGGRWIJIWryfvrHSn47znjqWPlMXdjNUvzwSXteLMZP67w=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4175.namprd11.prod.outlook.com (10.255.181.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 08:06:08 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <j.neuschaefer@gmx.net>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Simplify loop in spi_nor_read_id()
Thread-Topic: [PATCH] mtd: spi-nor: Simplify loop in spi_nor_read_id()
Thread-Index: AQHV5vtxJe3NG8eq40Gy2BJBFopNWA==
Date:   Wed, 19 Feb 2020 08:06:08 +0000
Message-ID: <5604429.rq6fcmI4QA@localhost.localdomain>
References: <20200218151034.24744-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200218151034.24744-1-j.neuschaefer@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 607fd1e8-6fff-48cc-c38e-08d7b51293be
x-ms-traffictypediagnostic: MN2PR11MB4175:
x-microsoft-antispam-prvs: <MN2PR11MB4175CCC07719B0958759A272F0100@MN2PR11MB4175.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(2906002)(8936002)(5660300002)(71200400001)(6916009)(316002)(54906003)(26005)(6512007)(9686003)(53546011)(86362001)(81156014)(81166006)(6506007)(8676002)(478600001)(91956017)(66946007)(186003)(76116006)(64756008)(66556008)(6486002)(66476007)(4326008)(66446008)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4175;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2uoiHUXVIgunodQM/QMKWn47G6qQ8kqDTiGkYZYqtyvlD5C+BPQGfHqVVPdUqZ7VmAfoZjF3APLtQQb2U8FvzRopUrEks889LugIxNxS4VijMeC7y88Y4RcEeoJrtpSNI5lzpFs2L2cowF2ML64tXokN28cgjcpaNZUolc5kR64Ivx4A4MP5i9X9qMVMyc+D4s5fwjF8CuUrfDgiv3C+P7bJ0RHACXHMKUsxVHmq+uKLZrQNDnSETOlMMc74dlZTXYuK8AnYXqcEHvl/5lQriQw9tVx7gUWMwQkku+joB67UaqalfFNS4BQvl5xE0Y7DaFlKZ3cto2+4NUdqbvmQvahuSApOZNCKird8rLxhqzRv67allItScVUiSbIe7C3NZ3ybZUaFH6J/1Sxo/1ANowPiF27ZkKcSpnztnLwN//Nvf16h/9TA+B+c1r21epRuB290MwHhQLay6tcdWxKuvjf+oRQz4qTKpJtx6G7gmIlRmQxydpR6xharOm3P3X8
x-ms-exchange-antispam-messagedata: Oes7xXBpK4y8kIaYa8BoPTWjS6OSSLYWHxlRUg9CBidnFpSjhT+89nrSIoIqujITeaJ55f493A4wQxIMtIk7TrOt4fJRpPI+9BSeHEcX1XL485JUkWt8bpY4x7mD3vGWi0kiAutb7wWRc3OTCyld2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <483678ED2FE2CC458C339AA72BBE6CF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 607fd1e8-6fff-48cc-c38e-08d7b51293be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 08:06:08.8096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Yu2dMYTB5nj/qBviLlnM5XehZrjxB7nzGYmwPtW8BUGMtf9m6FLQ76HX6hKNvX8ujs6wIsraBXO/6GKe9NN0AcJmmq5ZnSyza3k23kbVhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan,

On Tuesday, February 18, 2020 5:10:34 PM EET Jonathan Neusch=E4fer wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> - Don't use `tmp` for two purposes (return value, loop counter)
> - Name the loop counter `i`, as is convention
> - Return the pointer variable that the if conditions leading up to the
>   return statement already operate on, rather than a different
>   expression that evaluates to the same pointer
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index 4fc632ec18fe..c491572d5267 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2711,7 +2711,7 @@ static const struct flash_info spi_nor_ids[] =3D {
>=20
>  static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  {
> -       int                     tmp;
> +       int                     tmp, i;

while cleaning this function, would you rename tmp with ret?

>         u8                      *id =3D nor->bouncebuf;

and please drop this tab between u8 and *id

>         const struct flash_info *info;

Also, IMO, the definition of variables should be done with the focus of=20
avoiding stack padding. With this in mind, I would first define the pointer=
s=20
and then the ints and smaller types. But there are others than prefer defin=
ing=20
the variables in a tree/reverse-tree way, depending of the length of the li=
ne.=20
There's no agreement on this, either way if fine, do as you prefer.

>=20
> @@ -2732,11 +2732,11 @@ static const struct flash_info
> *spi_nor_read_id(struct spi_nor *nor) return ERR_PTR(tmp);
>         }
>=20
> -       for (tmp =3D 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
> -               info =3D &spi_nor_ids[tmp];
> +       for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
> +               info =3D &spi_nor_ids[i];
>                 if (info->id_len) {
>                         if (!memcmp(info->id, id, info->id_len))
> -                               return &spi_nor_ids[tmp];
> +                               return info;

Looks good,

Cheers,
ta

