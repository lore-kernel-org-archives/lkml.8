Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252CFC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ED82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="c568one4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMKKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:10:30 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4793 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:10:29 -0500
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
IronPort-SDR: KqN1Cj2pjtDSrXrs5lrLCUL/HVQIl3ikxEpTHQIHAdvJjyPGWSwH8dCWqKZSSJMT0myfpxhb5h
 FTpChnGVMZQ9az4dah/TzMeGy+C208RMyvRmFCmXX+UZpD8mXNRjeImds6D/nygkX1+cxCH2y1
 JsOpIJWSybhtCg+W/hyYQMrg/Y8y2v41LJOq3eb5dtMzDMrS0LtwOSZ43HM4HUMUMwrytgStiG
 ok2+DIjlKL2JZfxrUh5xw+xJFuBpfwo+9wfmlw2S91OKQw/3NvmIUmZwR6snPL7vNfD5Btp8Qi
 oFQ=
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="60582878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 03:10:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 03:10:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 03:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbl7VCXmeblTp4hnWqFHz+n6NHpkrQq5g2M/CO7HVIk6nkZSAmLB0yR6aJ0+6pDhwvZuHKoFsNrTDRfXzHm3tAjX8rSYMT6ZBeAJ1tIQXr0xY7Pv1DGbP5tcAIHW19HSnnIbw7WcsICzEGlzYlbQ8RWXJ3pQm9qr15CpWh+dnScqNdEx4l+qB9MK3caJ8OFEKPuizyKQdGMK4MAku3B0woCfEAMLF13WjIgFaC1YMs/qfQ93S9WBM7E/u+lt/Ia1efLDWpN8XtYbKCbAETaD/LvhJEzZ8Dy/VAgg1tnZf3r4ZtIU0FF8bA2v1F/AkL6fAZx9VUkTYBSypOKkckvaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr0i2o/BAHBMybjq3kFoqxacZgUeo2lnEFdJ1x3Nkho=;
 b=nQSSFH+f9RNCerhmjpHJiQHzUvBCSYK0jkkuonvBO8S/7i71lMzJAXk2wcN5QFWoJ0JR3KLRsszimw3zsbPU2TWm4+mwT3ELce4SRaHFk2RKCCea60/df6TgictWHOv/b96hzG755UnK8oFVxJ5qwSW3AqkTFpdJ9HnGdNHnFRAEfODUqada2Bj09J3R2iyHSJm0YdtLov9jiMPsqQITgPQ3OtqEP37HFXYiCCxYkOGdAv1PR0al8KdonS+ve/f32ViErLysWnB3BIzvPtj29lSVd6hvDTDk1gbzdWIf+XifZR9bDxmMOQzf6h8Qa8gbqrttZxBq65tyHbLHe7eN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr0i2o/BAHBMybjq3kFoqxacZgUeo2lnEFdJ1x3Nkho=;
 b=c568one4FLC24psOO56MC0ivUxanH6qqigLjGB5IANW6rd2+ZOEaFanloqffpIK9Bfu2CdBaN6busXRUeDdD0HFVmCnXPEpa5Ex91oE3vlYOAja/SR7DaYBHZ31fircUvxRQITO3EjvpEU0d5+Qn3MZtitwGyt7COVhFd3m98Gc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4335.namprd11.prod.outlook.com (52.135.38.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Mon, 13 Jan 2020 10:10:27 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 10:10:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <computersforpeace@gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: fix locking argument in
 spi_nor_is_locked()
Thread-Topic: [PATCH 2/2] mtd: spi-nor: fix locking argument in
 spi_nor_is_locked()
Thread-Index: AQHVyfmtB/RTe4VPuUuyKr1XQJxpYg==
Date:   Mon, 13 Jan 2020 10:10:27 +0000
Message-ID: <1617765.HVoytVeEL0@localhost.localdomain>
References: <20200107222317.3527-1-michael@walle.cc>
 <20200107222317.3527-2-michael@walle.cc>
In-Reply-To: <20200107222317.3527-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0c1ecdd-cdb7-4a20-e443-08d79810d00d
x-ms-traffictypediagnostic: MN2PR11MB4335:
x-microsoft-antispam-prvs: <MN2PR11MB4335F2806F01014A54D62556F0350@MN2PR11MB4335.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(4326008)(6486002)(53546011)(6506007)(86362001)(186003)(316002)(26005)(478600001)(54906003)(6916009)(81156014)(66946007)(66446008)(81166006)(8936002)(6512007)(4744005)(9686003)(66556008)(64756008)(8676002)(5660300002)(66476007)(71200400001)(91956017)(2906002)(76116006)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4335;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9+bTQJUslgqVXZIEebceDjXvvQt55roTbP7TmpU/heP4ZNwIFs3++pIuPNgQFx0G8uA/wPUDy3A3SSlPE597rkX6tgWM8RbzNzlUp0oKN4CVl64NnSs9qWA00uzggvSz/XtrqrJazhGUHTjqScPdSvG82LTflB6h4ZM1Wu5YWbBl5TTUg+hqVB8IDfFzNuta1go5/MOOBrk40dJK+7mdIWzA2mVFIrzl3tqHlBfl/zR4Nl1VwmeCzm6efUEJCuM3r5bXUv4qnqoYuQxbx/EiBWv125yDGc5/MU1Z1s9k8NopeCxAqXautTAFdrVjjsC1L14DB/Ch8FI/ZFwpEdaCyVKOgOIVrLW3Zhbt1s8+zP6U6nc32/zVDG4fUfDVCd23R1qdxfdaRYLNNQbV3yu7U+kv4UAKEOWrzC4zc1I/Beu4CDh6rZF5QvqSY1HETs3L7DBtU9dcKBOq8hbJ3hsvqkCh7IHKaE6q58fP0unfSgjXb2+iVyLWyajzXSPA/Ky
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB3A0BE49DAE9E42AE777CF0B42EE019@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c1ecdd-cdb7-4a20-e443-08d79810d00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 10:10:27.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EyAp0h2Mp9F5VjDwXugWDsDXQISAM1r2OxuzM4eZhv0Dq7HaMSxW9IxbTjVcwouJYe1RViaB6mte3Je1KpyiKGmrjQKHWEerHF3vNiJ2pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

On Wednesday, January 8, 2020 12:23:17 AM EET Michael Walle wrote:
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b661fd948a25..a8fcb1d70510 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -235,6 +235,7 @@ enum spi_nor_ops {
>         SPI_NOR_OPS_ERASE,
>         SPI_NOR_OPS_LOCK,
>         SPI_NOR_OPS_UNLOCK,
> +       SPI_NOR_OPS_IS_LOCKED,
>  };

There is no NOR controller that uses this enum, can we get rid of it?

Cheers,
ta

