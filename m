Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1690EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED75D206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z52ZZwty";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vo583oKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgENFDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:11 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35441 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgENFDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432588; x=1620968588;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TSexiDkQCH7zfebUhamGMaYfEJXG7bLgnyL+idOQP2Q=;
  b=z52ZZwtyoy9dE49JGM4nF50IAFoW+aO0c52puXDDko7xfJxjWu17Ah6E
   OKODeLY4w7yyeT+aN7r2xun1Mug2iS4JUvp/iPBwewOnXY/X6P+Ekzf/T
   PlveJAkoDFUjhliXGDR3dfwRdECPGarlIV1l+af8GhZuCLFXdN7E9vCUc
   E3OzfRJ27TWjg+a+2xCTOXZuBZVE5b3b7+Sxh6yUeK6QKBX70eeayIpg/
   z/b+4ySmaPoAn6yp/txfmiqjNY8urcAM3j7vm2F2XLR8nz+vBKpyLPA5g
   dSsPzJSsOqvtOL75k1VjopCTbcTYFA+qKX6r6yMNNDhLFpFEyYoAcso91
   w==;
IronPort-SDR: ARGYZ5UuCMAdqxWFXC08rYZJ4Z1Rh9T+H391IhPoUT5XCg7215wm7NkIabagn4mi12tSg69Zuo
 a7Y81Hm8bfabS+FPHDpe/huLUEo0tPKGp9rudGcCzgVInRMK2j6S/a86B/4+gsHAJyS/lyy1AO
 FBdAomiwCT2EzEXrZ/L0bWBn5hV4znk++/9vWzlGdTDnnLgxYbdbN4qiIeia9KSHwLg5OXmimQ
 IsAhhoMlAwSOwvzis/lp3CLmNAp1dVsPrpYd+6dBE+tpxt/8uK/kt00kRmwJKxD6gc4o0CpIij
 WLw=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551072"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 May 2020 22:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQmojqUmgsI774bXwhH8RT/FNdjxAYX5GloucIRsBjjYQwHg66gDRLEdI2HsKyaj04d4Rh0kjcBRyO30Visr+cf/+0efdbk1i2O/CvlGbudXa6uX+D2sxYdwWeTtQNOrIZlz/UDpXDXW+M2gJgMdS4I+gvtuyotftayVa8lmhNwUUZyBMenuCcqF8L1WILG40uDPLC3zzVWtIdEflro99ArujrI0HPIsZ4i6ubPth4bAbLu22UQ1VJnl+tbtBuxJPFGx9plyUfJFG2rxpCR7P4gXZ9XTveam9Xm+fEqmvKyGJVR914d3H0GNA6JDm0DgdDr5J8JlaDq1S1u5+R07AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLu20Zj4HmXk889XYgjlzp+zdbqrOcMBaFgYmvoIgdI=;
 b=OlZJQGKCnRiphb2gUBhGNdnNothbMIZiNZYjOg+5QbJBFS8D/3vdsonA80pufWW6Y12UCAgj5MOiEfeB+j3JrQVdDNzlPgodOwAhD8SHZcARGk+jChG80fAoSq/hrWw1TxTeEQJeQr3h2hfcLBbwZQpmW4fq9VGOrwmf4GGuIismBF6sa+73tLv3oE+TfoD4jeCWRztqsf0oBY0pQCsKSSVxdnISVcGOm5331dAbMk3shrsXCeD9Nt1WD5lQPn7qc/zYoP5l701D594QnskuY5+b3AzcjFm+tb9WQ7lJNQfs5JHaIRUjzbKcyxUwkwjjm8a6urLpAWH9QS8q9I8Ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLu20Zj4HmXk889XYgjlzp+zdbqrOcMBaFgYmvoIgdI=;
 b=vo583oKfvzamJJrsUZ+4EpRHNd6Y5zz4nP+Wo7bjPqBwD8IpIgsHHBR0nzPyf3KWzO8gvHLCfA6M1oTsGc24jPiVyI191WZ61m3ino8/AfQmCJE3CvRlfCu1op/fKRfOKr1MNS7pVe8y+3OBHaAshq5PLmJCbS8SL0RJLbP5mVI=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:06 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 00/16] ARM: dts: at91: sama5d2: Rework Flexcom definitions
Thread-Topic: [PATCH 00/16] ARM: dts: at91: sama5d2: Rework Flexcom
 definitions
Thread-Index: AQHWKaz0lTobzlRRV0ujGkZZNIV0NQ==
Date:   Thu, 14 May 2020 05:03:06 +0000
Message-ID: <20200514050301.147442-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7005605-d41b-49e4-86c6-08d7f7c416b2
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB44834F74C74D4BB43F43D251F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9O2m4BIM+PhdGFC9+lAjOGFdyhMRgMIBsIoTjq5m6cUS0iJHf9SiA66qefzd2Xx8WVRaA3w5D768jHSQ/SUorPsoyuUGdeLA0nTTQGIIVUOkrYxtlgXZ1jCrhuCfSJUw2vXe8ALJyaC1qWqzqgPBSUYPaYuAmUOOJdDREHY134mjeQg7hEzi3GMARAHuzUgROjdNnJ1dhJYQ5OlRzt/X3Y4U+wtmCvkg2oyEXRp7KbPEpbChCN/uqnjNss2GMUXDKbzV/MDeyTOde+ldC9gF5l7ca5Dg+sNZb/QYYDcPQDx/OBt2FIGss3ylHUrYSeV8RBDH1XzEGUse/ZK1osYZhh+woFO/NU4XRyAqh4MNOyn16yV+dAAhUYmd4x+b0E/LC4p/UZXrsRK3/SHMdTXaf+evkySbbO0H6io1CJiR7uyLWnJcutLYE/C622Nkwh5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TNR4Iy9CHQ3gO6j06FBCXkDQUi7xzHc7vOWw74KQyyM/finiBsrd21dyQO+xXOPheULXIjGKozTU4FjZWJT2MDALAlChu+TH5ZRTdPaOqZkwuzww3fI3Uc3o0her5sM6s/NKcLaoI7LjifXGFwYH3Y8OaMWW0eAOo/sOTJnoNCVqqIxKzUOfKPKemxz7+dEKyexsdco7HO/usXao3yfcFUxOJ+fpVJCOnZxPPCNJh3cFGrPjbPY+MZnyj7TbAJu+vMi5AMGOs8lgP+JN3GFqxTIMBSLgICXTCamEt7HKUglPMPCTEeeTtqXkjtNM3lj9axSp2a0PhnEarkMAzga6UxzQ5ilLM7ObQjxnSuUMFgRzLdQmNhdaSnqZaAEdcduUsX4pIv6whVDRSXhAJAy4ei+X8hVb4U1cc4cphVLGlOalzrZ6d4Td2UMOWGh/OIWAwJgWQ0/2GB521dKHAtOO7wzJi5HEZ2AgTMnVd46z2fc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d7005605-d41b-49e4-86c6-08d7f7c416b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:06.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3o8UdvVa+T9sV4tCVChpKKPlNB0EZbYynQkO4Oao2MdYBpt3SwCamnTiFXv6ErZaQi/1Jef0zgJsoHyJ6EXBSUnVsxZ2Uvnhot6EPueaek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rework the sama5d2 SoC flexcom definitions. The Flexcom IPs are
in the SoC. Move all the flexcom nodes together with their function
definitions in the SoC dtsi. Boards will just fill the pins and enable
the desired functions. With this we remove the duplication of the
flexcom definitions across the sama5d2 boards.

Round the flexcom support and add the missing flexcom definitions.
All the flexcom functions are now defined.

Apart of the aliases and the new flx0 i2c function on sama5d2_xplained,
the only functional change that this patch set adds, is that it uart5,
uart6 and uart7 inherit the atmel,fifo-size =3D <32>; optional property.
These nodes have both the FIFO size described and the DMA enabled.
uart5 was tested on sama5d27-wlsom1-ek. On uart6 and uart7 a
Bluetooth module can be connected. Tested BT uart7 on sama5d2-icp.

Tudor Ambarus (16):
  ARM: dts: at91: sama5d2: Fix the label numbering for flexcom functions
  ARM: dts: at91: sama5d2: Move flx4 definitions in the SoC dtsi
  ARM: dts: at91: sama5d2: Move flx3 definitions in the SoC dtsi
  ARM: dts: at91: sama5d2: Move flx2 definitions in the SoC dtsi
  ARM: dts: at91: sama5d2: Move flx1 definitions in the SoC dtsi
  ARM: dts: at91: sama5d2: Move flx0 definitions in the SoC dtsi
  ARM: dts: at91: sama5d2: Specify the FIFO size for the Flexcom UART
  ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and UART flx4
    functions
  ARM: dts: at91: sama5d2: Add DMA bindings for the flx3 SPI function
  ARM: dts: at91: sama5d2: Add DMA bindings for the flx1 I2C function
  ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and I2C flx0
    functions
  ARM: dts: at91: sama5d2: Add missing flexcom definitions
  ARM: dts: at91: sama5d2: Remove i2s and tcb aliases from SoC dtsi
  ARM: dts: at91: sama5d2_xplained: Add alias for DBGU
  ARM: dts: at91: sama5d2_xplained: Describe the flx0 I2C function
  ARM: dts: at91: sama5d2_ptc_ek: Add comments to describe the aliases

 arch/arm/boot/dts/at91-kizbox3-hs.dts         |   4 +-
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    |  48 +--
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |  64 +---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   |  12 -
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts |  12 -
 arch/arm/boot/dts/at91-sama5d2_icp.dts        |  42 +--
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |  14 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |  42 ++-
 arch/arm/boot/dts/sama5d2.dtsi                | 295 +++++++++++++++++-
 9 files changed, 347 insertions(+), 186 deletions(-)

--=20
2.23.0
