Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB8C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAB12072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ggx7JeAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgAPKfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:35:17 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:44441 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:35:17 -0500
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
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: uqrbiggs4+4XPHpXusxMm+FXAcLcwcVwTmX1wa7EbTD/xtnUk1gQ/nu5/8zM9kpWu0MPnZTIiT
 0Pe3uu6Eko99PhaV154Ueq0xvjqUQz7m5jdEu45KmwVRIO0xFVCDDGV9zLKJyQv9WSH4LE8zKw
 cmBqAtI5SdKYTRxw2HG7TLX8zqSwqH3rEwSIjlvdhBttnUIYvnJrfk73O7RziWSoCZ86KlU4de
 yfLiV5Cf51uNp10iY67KsrlwJVeisV9sy0l4S/5wDGrzLwa1aGq3saDme4kgA0ZxwCs4On6VA/
 mx8=
X-IronPort-AV: E=Sophos;i="5.70,325,1574146800"; 
   d="scan'208";a="60985654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2020 03:35:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 03:35:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 03:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5JoDmhcYm9sYEBL2YgtaflagW3ES9Q498LPremUh+jjVy2QRzf1uNtB74wFtSts6KQTke2moK338Pa0Otd39bhk3HrBRZO1dbewFitVP7aqPy5lHp0jIoCeLSN4vBKWXqDGvg97cf/n1fMS6DO+gUKzYR+DB9kpcDnEtG0mgPCCxn3Il+DtnidGMV3yumJoTXqvrfXCDvPhT778jBayCU0LHs4387cTT4zYgyoAjbe6qMBryhU0RN8qbSmGoYI9JnDPJjEaWiVSf6UgzYLX+2RNUNiE/PJsTQ2O9yQTxKG/jBtwJisPgja7ErLrnXq/yx0kp9yUp5LXfOuvhqnVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEZoMAOJ0reGsir6mlwc1NO4BDJDDZzVWJkQEqT5dKI=;
 b=ZblBL6yMDXyEZl1aVKVt8d6AP7Z0pevAqcRuXQSl91+DJqPx3QTnuTJL0nQrVCApc6bv1NSAvTlpDPqWWTYXfW99OVh911Jb2WxcS9JcjMnnVxVJSw2U3XGdYps5yZ+azrGsKxSr7F7XlU2dCwouDGv3WfWj8RFIPlWQbGyV1B/QVsDRiaQnUAhxX7GYpRYUsOZ0ICevG82n43U2rUWBcBONJ016sjN6ZdhZTytHxzFaKCAw1XXbOw93GPuh5sSS9yb2fPlImzh3w69ww/Nz20zP1FW+DvKvTfEUNIPghM1EZUGKVlAZgJ710Q2VQ28epxE6q0Hnic8tQOMJIGMPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEZoMAOJ0reGsir6mlwc1NO4BDJDDZzVWJkQEqT5dKI=;
 b=Ggx7JeAKZILaNEMb0CL3N4D53DkK4rOjg5+pHy1e/lx/rykQRwQB8Gp0DvG5WXLVqmc5NYZZ3lzyafaKYiqgZ53pZxsFLX8Cj9j0evQbr0185/VuIxEFJ94ZSj2oBM+26RIKw5i7+2Uf/QL/FcLAUNqoe1+AB+4uGQBpWhF7q+8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4286.namprd11.prod.outlook.com (52.135.38.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 10:35:13 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 10:35:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix quad enable for Spansion like flashes
Thread-Topic: [PATCH] mtd: spi-nor: Fix quad enable for Spansion like flashes
Thread-Index: AQHVzFClES9Lbc+DOUOdDHVrL3ZyDKftGJ8A
Date:   Thu, 16 Jan 2020 10:35:12 +0000
Message-ID: <2180698.lX2pLR0Ns3@localhost.localdomain>
References: <20200116093700.28308-1-michael@walle.cc>
In-Reply-To: <20200116093700.28308-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16069c5e-84c2-4fa0-dd04-08d79a6fc4d2
x-ms-traffictypediagnostic: MN2PR11MB4286:
x-microsoft-antispam-prvs: <MN2PR11MB4286B2C4A491398CC5A43B56F0360@MN2PR11MB4286.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(66556008)(66476007)(66946007)(64756008)(66446008)(76116006)(186003)(6486002)(91956017)(86362001)(71200400001)(316002)(54906003)(2906002)(6506007)(53546011)(5660300002)(6512007)(81166006)(4326008)(8676002)(9686003)(81156014)(26005)(8936002)(478600001)(6916009)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4286;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNyI3ae+g3fsRYmQlwmHycZRjvFj135VlL9hbvmUM+pMGV9nm2QWRzKihjmF8WPIbrtm7VeDWzV6l8nsEyQlsHWMnrAxSstKigH/1zt7IJMXpDOlFEP5yPEIDi5IiaJ0ZjPznwtWRdyxIRXbLE7hMkRT2tu9cMYG3n9HqXDTfA3FnNxHlt7eIEsmNwwtpRMcMp8vtxlIfvrWfxsej24+yveLzoffh6tKZKamcev/YMG/ZF/b2k//5E9Tw8a1YF8EUtztxL/dw7i0aSCNAgQc71YLHQrifpUrmNGR5Sipm1m6lLolcOeTTxFMA5H9vVMB1QjkUXsVBlw4oloSA/7KVx3zdXHRkyP51hY02fwr2VJqIo7TFhBnKqkgP2M4xN5QjTd4JqSGtVWqOIGp90R+55MKDBhxDX1NF3px0OftzcIrPJN1OmxEMwocaL0h//AuOdnu6Zv/MsQ0BINJTHe0zNyN5Jiq97rYaxQoINNmjoZe163fHdMHp/UhEARq7UJk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E315228E1097D041A74CC0E5AEC88224@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16069c5e-84c2-4fa0-dd04-08d79a6fc4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 10:35:12.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgIeA4h5C3q7JvOclqzgFOM7cqmIUexMTCpdIvHFK41Pl0mwNtYl5FAxz8r2eRA0dLD6n/ehUApLOSLd6JcGM+3v5rYy8enuFhvb/v1Rd7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 16, 2020 11:37:00 AM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The commit 7b678c69c0ca ("mtd: spi-nor: Merge spansion Quad Enable
> methods") forgot to actually set the QE bit in some cases. Thus this
> breaks quad mode accesses to flashes which support readback of the
> status register-2. Fix it.
>=20
> Fixes: 7b678c69c0ca ("mtd: spi-nor: Merge spansion Quad Enable methods")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Thanks, Michael!
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index addb6319fcbb..ea0429448207 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2140,6 +2140,8 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_=
nor
> *nor) if (nor->bouncebuf[0] & SR2_QUAD_EN_BIT1)
>                 return 0;
>=20
> +       nor->bouncebuf[0] |=3D SR2_QUAD_EN_BIT1;
> +
>         return spi_nor_write_16bit_cr_and_check(nor, nor->bouncebuf[0]);
>  }
>=20
> --
> 2.20.1



