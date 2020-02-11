Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A76C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3CD20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="k/ztwU0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBKIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:07:24 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51731 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbgBKIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:07:23 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: pnpa/BOHNK+TDH0Po7WUXBrUmOpi/2Ih1FyufWv/DHfVjQEzBDSVer1/WvALjgL+KnWCyuV98s
 brHzpFkLNBjiLFSWYPV5sjLBHCnXznyWpw9Q3Em5p/VVPUjL0fqjXXLyt24zR7yCQ+Wg3tzic/
 UDl681hytWsD3WFiUUCUy9ay+QwmhGB+4xGUqJoiUYZ5jLA8Gx7z8VWqlNCEBnAy2ILWrf2mIu
 3Dt8nt9oWLJFdyGJ7hiwIVFr0Jh1gKh3VTnMmyabeodlweNG5QZdg4Mg2Za7loMyXU+PO6XQM9
 RHc=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="68013459"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 01:07:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 01:07:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Feb 2020 01:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8dwE8kyWI2EYrJw8kR4V+cl8njOQ4VnqX+1fVJXOU+FsY2g9e3zMXuUIDiGbwtuLxD0Kj2lY5Wn3OL9eOnmlRsSSiu5qt5bFmsbiBL/3ieXjU+ehma8e0KMaSSCSVK2tUnQai20JK/vFuvdmAm2m4gXe3xCZViWxHTBVSG5GQWcLnq92u2wB1Y8NrYS5G+T7DSKxUck9AVrZARIPeIk8SP4G5ZwnJ9yZQGSWxwHdecZFVeKrcry3lFfm94SK2ykg/Ji0IFi92tuJFtwXcqmUyNb30zateNVhc2paVuRHh2wJ/vr8xZO5y8v9n/LBXX025K6ZQez+k7hpFJ4k8GRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfTMyvPu0e7bAjyqYch9fILTQ3iK5gkGr4BtrbteLwk=;
 b=JGxON+65EbrLbxcxYY5fvXk9sY7nQM1oBrxbTK7/rdbglhOayA1QG+1mKCzBZFIl0LXLY2VM1180wZwq5g3zJThgVPygJODLDTF2bk7illeYxo8LBbtKgsPTgcx2QWP7FPtoq88qAmz02jkamYTuA+H53HXbcbhb5WPs17XIMhR9gXD6lZePemhITK2uFgDSqdkkbWTrL4GSKj6FI5KBcgFIQ/f9JTKHrrRoqoM3JoibTIEddpz+Erfv0+OynOwd5hGqVBbgFdLUGtcmQoHcx8rpYok93BK4Dq53Uyz1kVZiTalB60/5xV8r7Ehmt3rcvP0cNqLpDGO+jk45I33lPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfTMyvPu0e7bAjyqYch9fILTQ3iK5gkGr4BtrbteLwk=;
 b=k/ztwU0YgskozAd5h8b1XKEB0l9e5AY4eeKiEeNzr2hYnzaQVc0kW8JjQp8CG4dEEQOwduIkvMVQ+g0ZqoyE0fJ1E2KpBUT4MZwGo7iv7Ioq5icGY4A0HxJ1bEjkPL1f9mpAK8Np4luGfcO8U39y9joLT+58I1Gmu0NHzxyqDyU=
Received: from DM6PR11MB4123.namprd11.prod.outlook.com (20.176.125.204) by
 DM6PR11MB4011.namprd11.prod.outlook.com (20.176.127.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 08:07:14 +0000
Received: from DM6PR11MB4123.namprd11.prod.outlook.com
 ([fe80::85db:d80e:e645:ac17]) by DM6PR11MB4123.namprd11.prod.outlook.com
 ([fe80::85db:d80e:e645:ac17%2]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 08:07:14 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: sam9x60: add watchdog node
Thread-Topic: [PATCH 1/3] ARM: dts: at91: sam9x60: add watchdog node
Thread-Index: AQHV4LJEiJwS9sDv30Gv1Q4x2b4QpQ==
Date:   Tue, 11 Feb 2020 08:07:14 +0000
Message-ID: <1581408369-14469-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6bb7e39-36fd-46d4-5b3f-08d7aec96774
x-ms-traffictypediagnostic: DM6PR11MB4011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4011800488F06950EB01906EE8180@DM6PR11MB4011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(107886003)(5660300002)(6506007)(6636002)(86362001)(26005)(110136005)(54906003)(71200400001)(478600001)(6512007)(186003)(316002)(36756003)(8676002)(4326008)(8936002)(66476007)(66946007)(81156014)(64756008)(66446008)(66556008)(2906002)(2616005)(6486002)(81166006)(76116006)(4744005)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4011;H:DM6PR11MB4123.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cXiPxqUsdgB9wuBFbu9AoQvHdCgyJq5tMK5lCUL2TPAA6YlvmW+wflELCVm6yC7reVa7s6crSiGCzVul6aN9rJt7b6RWp9JgWL9yI0XQPa38lJnN0yEkpLbKc75dHKlgEXVSghfreiv+HdEOgOzrSJLFFOe3GZBGD/ZJHAL6eyEn9lMkK6GOmay5cpdt8/2qpdr2XJsZ/mZQlLdfy5mIPkmUPT+VuFDPllfeB2Ry26Pe154jAPfWhv1lIy006wY1WtBEQYvd+uYQzm/u+r/Lw2HMZABv3UePxA7GJWhQqTKIv2vkawqrHcgJ8NZwfsHDGk6Dm6EU4vfFJSDo2IxXZ+Z7yWUsPKMs4pkoYr7UkG+lr4apHjjLlGvEghjSRvvPRSJunlILR5uG0CnpAz4KY2i/lshiDdfUlfLLgpgmSPADY4nF5Y30oZupdixRo+c2
x-ms-exchange-antispam-messagedata: 9adwQAoKUMdyFWT1paBObAb07/iwWk7tjMTZsoiKxw+zzhfJZr5rKlIA4ndOcPBUsKy8IkQ2hKtU2zKG7abOUcVzakr+TvcOSvuiBxC1VWrp9yDrL8gkFZzMPhVw5CUM0RD0L5jKt7jzbL9gWbiauQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb7e39-36fd-46d4-5b3f-08d7aec96774
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 08:07:14.2843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxJx1XjjpgMoiQm24T5GL2ksxea055GlXq2j0YAZm0oatSM5DMTEaoS0hYyUzNwynBevgdQ+g8xX6tFOEHkvQOeFiywluI7PpPfHJibhacs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add node for watchdog timer.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sam9x60.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dts=
i
index 326b393..6763423 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -686,6 +686,14 @@
 				interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks =3D <&clk32k 0>;
 			};
+
+			watchdog: watchdog@ffffff80 {
+				compatible =3D "microchip,sam9x60-wdt";
+				reg =3D <0xffffff80 0x24>;
+				interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks =3D <&clk32k 0>;
+				status =3D "disabled";
+			};
 		};
 	};
 };
--=20
2.7.4
