Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3670AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E098206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ntea0POZ";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="U54gFSOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgENFDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:53 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35460 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgENFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432600; x=1620968600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmRSUJ755DlMSJzAp0TqHwl4Egm8+0PmSlk5WykowOc=;
  b=Ntea0POZ9oHq/wrc265zTyhDXq+i1m2S7Ni0rJenN5RwMqafVVKIQIPI
   6naroMrwJL3brPkrvBy/famhgnHEDL8e2KX1nH+fEj1UihQzuLUlpS+H1
   N/mgXKQU+wzRI7yIEGiqjUTouN/KuiVwvte0ZfC2NdWaxSxa5KYv/NUgR
   Qd80nPvPGtlsffUOTObnwd91QeQisCEb6GzwcxKE7iNQ7NS6Y3CLWoQN5
   9rYdj+7uKHX7xDdIumJlU7DcXYJBRnycKA0TS/YHIMzNtcQeGfjeNlAJJ
   14V4PXheNayX1wBsc4788TvclN7lwYYaWGeFUBLMI6aTqQYymiosZ+onG
   Q==;
IronPort-SDR: 6A9annevawis5e5S9wLNezJjDO/frIrmqBhA0w9BJ86vZ5f1HVnPvU7aUn9VoqKAZb5LTQZvxy
 MEv1wG9J3hLoxS0Rs+L7E1b+NEQcrPoI/19olx3f+z6S16kbvLFCpzRvCjJ0RhJLZq1v/S6aZI
 BQB4AMvZ7fz/Qeu4vxJZB8BnuYEI7hcAgZce2c2cr8YC6NMbaB3TlkzgtJIdoJ32NXIsRcWXyY
 B6mzAMYoDL4do91lI8Yqmdb714lTjx0nEUX2LAvEmrBT2ue4oqWLdZgCUgvUkqhsXsIcmLuKst
 q+o=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551116"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAmKKG21EPPhqGW9mzOtyJ/MNYU7/BTXDrjlIXlD+zrKzidpF+VfC4IdozpxNyN9CaVlokLMElzKEB6NFR31tc1ApAVN+9Fk+Vvnx/on77a0hRH6dgYVKXdji3rASBkNsLBr37q9iY76TkeLIJrHLZaYk/NPnxZ0Lw/q3JEhBk8ytAPDech3aqNU1SRXmTHj6sQnXSOg8IuebimQUlLOEo0JL9PCs3vTC8AOCIsPhKaLYHnk333yoLEugNLlWwEdehkAjwfV9njBqmU7ybnRpuGUu9wbg9cXxxIIScqPacXHPleX7kvb6Fz+YG+Ri9Ih3ERckCGp5WwOi0/wkt6ZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYywiaATuJhewNhlwfmaQ5pZs7GoVTxuGJ+Fh1gN9JM=;
 b=ZcrjGjcmA8B6zWlmbJKLs+qrsXoG3/PE9NsjRIaJJJ6PHNpDL6MgftT5sjK/4zdDvHIVIG85tjYbjBXhBI5I0gdYX5ma/t8MDPI6SSAq8mah1vUD9roIIR4+cDgeUmS1FaeGLMK/AGlb34nghgdHpi7rYI6xk8ItbZ472q808Hy4QKvKk3aF6lRXyYQTuJtl+5SIWiUteymjgrdFIzjyim4uQuOD7Uen/B2pC2apbUNg6IoB7z7sRGvZndWptlrDlQ/htVfAA/BDTrAvU62VShWcktlBV1Ro7+/pHKLpLFh7otO82b1L/xxpmF6JmG0Isx6sV9WIqCca7KoK8qPC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYywiaATuJhewNhlwfmaQ5pZs7GoVTxuGJ+Fh1gN9JM=;
 b=U54gFSOjOp0lBtoFxnUMSHUMRncqaDJxv643OgezQndtNpnsXgQfFs2+wVqvn4yQbTku1RyL0Hz95QBrR36V1pE4lSGlQ2u25KO1WEYuU+WKXFHO6+pYnwTakNGR4zOWBmy8yVLPXA3tPIPhYTm1LfqmOF0kKNz/6oMQMgRgcCo=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:16 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 13/16] ARM: dts: at91: sama5d2: Remove i2s and tcb aliases
 from SoC dtsi
Thread-Topic: [PATCH 13/16] ARM: dts: at91: sama5d2: Remove i2s and tcb
 aliases from SoC dtsi
Thread-Index: AQHWKaz6zm5AhRR5OkWBdP+dKKvzLA==
Date:   Thu, 14 May 2020 05:03:15 +0000
Message-ID: <20200514050301.147442-14-tudor.ambarus@microchip.com>
References: <20200514050301.147442-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200514050301.147442-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df3fdfab-af79-40c3-be46-08d7f7c41c8d
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB44830C2B31F06A82786D0155F0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpKh9Ypsqd4rFlhqZZL5DQmoXyEbmmzLVyyCNPd981qTf6irH/jJDgHIZebiweFgPsx8IIsO7lsCqw5GGN6ubw0gYXnr8mtT39dK6FdVNwLadqvO6LxAWK/NFGGhCVmSvIwFCML902W1JZRbMYTSCJa8aK5WXhdxnEPVhR9RLGBKF46AsVb1cXRK49alljVZ3jNGUCt20t8xWEWWwOCkxNEiEQkyyj283wsF3g37e/kZOt0juGcxiaitILHwoLrZgiUP/BAnyeF6D14rwMAh6RiMMnTArww0yl4vTpTtQ9X1DpGyw6/JXxtuXxcwxIp4isDiKyDSaimNiLI/AP0Jj4TPOUAlDLJTFbCJRjihSMPBb8gKazna8LKXN4C0fvwWE+QCj5q9OagQHkocl0QOdH4Du3WBmv5nD1LVf3KGlHID6w+mR+QKsq5R/8/18dbA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(4744005)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rXCIdYqmBp9nEWQccWIH7zaALSBqmQ62HOnElBaoSSPcYmqEwb1FL+WIhjcLb/fvaj806dm0+fjT/Q07ZNntdWLfsN2xPdf4wn35/2SmHV7ou5k4ZwIGm9OWZHIpnYtBvF9X0sUvvj8cygbnXS9h+Me8z0idXHigixA7YQIJJ73t21qugR94mO9438VaMRwbnIrrG2CqQQz9ywRfUIDMTSoZoAC5ITUQLWmr2bHbjjpgBWonVL9hl7sw0d4gKjVUBFGpTRZB84KQIrXLazZi1cRQDQw2Hzla4G5tCSuBGATjif/5vTVd0Fdkb9K5QwLXXX2H+s4ka3QKHameBnldDv04kkni+xhQFoxYo8svVwCm4e/UfN7zQNtsjFk6GtkBuiuiswy6qrxJp8vdYxtKVVUSA0ZD4sp9vT6bUg4LxWBDIQewsqd7M6isCMEzF/jRdKonTO8nsocyME5wg8xcFeXxARUxji07i0/FoVC9PqOtKjEphJ77+ZVK9HJkMQCx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: df3fdfab-af79-40c3-be46-08d7f7c41c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:15.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JelWh5hr7c6rhNHzGuB7D5tBiZQmPmmLseJFSyczaUu9IUIMXFgHgMyfPVmgFHQMumlNjc1GJuQ+wBmVtsP/Oag+USGyHforw6TvVz42ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Device aliases are board-specific, if needed one should define them
in board dts rather than in the SoC dtsi. If an alias from the SoC
dtsi is addressed by a driver that does not use any of the of_alias*()
methods, we can drop it. This is the case for the i2s aliases, drop
them. tcb aliases point to nodes that are not enabled in any of the
sama5d2 based platforms. atmel_tclib.c is scheduled to go away, any
board using that alias is already broken, so get rid of the tcb aliases
too.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index b8cdeedee6bc..c0a3ca8f9bf7 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -21,10 +21,6 @@
 	aliases {
 		serial0 =3D &uart1;
 		serial1 =3D &uart3;
-		tcb0 =3D &tcb0;
-		tcb1 =3D &tcb1;
-		i2s0 =3D &i2s0;
-		i2s1 =3D &i2s1;
 	};
=20
 	cpus {
--=20
2.23.0
