Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F48C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCD520675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W900ciI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBKIHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:07:25 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51731 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgBKIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:07:24 -0500
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
IronPort-SDR: Et8IHCmdg3zJYmBY5YbZWcGHOZlrAYZAgj8UOaM4DccvsMhQgSb5kEeCWQ9xzc1oBswDxQ2U3j
 iCzu6seQsgBd1dLJ68gRXv8btJXovJT5eeCNRWMw0oTM6XJ/VcAzNkZSuvRxlkAgplyk2ndNsZ
 Iv/UvYsW5PRZ0A9y2+KsaZPcRaqlyvsfXIHiULeq5t2ctDq41kUlPtX7IQnBQg51XHqtLPGVz3
 g0nwLz7lD9Pw9Oiwk6J1kDtElSFDh5wXrsoyjELPrgNxAxmAYjGgTM81rjay4jH053KcxGrWx2
 4b4=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="68013467"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 01:07:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 01:07:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Feb 2020 01:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4Ja2YCdzr4g6nEcG8H7sXtjVlA7u2VIl0YcFCxgaPth6koO3HcgW9odP77okUgZ2L7/RSSnYX/QcByjSu2+mcj2JYBKIcQjUcCyo6IdfVv8qPQIgkksZJYTMjEonEZlVwsMStc6suAgRZy0J8xRhF4Zw8yv+aWEKU157Yb3Xqr4l4hO/OOC2jyRZCESAjWZ7zJBbDyzezHI1+LqvSeu6wbeBtE3+0ba2B1OBtjlgMs/sIHG5t0FI4+4LSwlTTjDFjM/MU7AvsCwxwvbh7m/KcikoN76wjL2zjsX+TbmE9PQsPowHiNK8rcigIEgRY5WE+lnms3B2wsb+yYP+YZgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86kk4qrZ2B2zknE3x8ycKe1XNJV/JmhikUI3khjl4VE=;
 b=fh+7w8cOXBkK8OIdxTQoa51iplfeThAZfI6a04I9rOZ3SP9MjrYPU5/FMeqnoiyhFnHs2NQzGG5DzhZyWhMcKIIrdnVpIhwbqcTRmlPRrH24o5FXasFZeapdGDEPLT6D/oNo3dQnv21fvspOmPCzzgyiHRvY9BcwPaKFLWLGp2jEaUVqNaH6+uFRAS8MKG90KlXRCjiT17QTt16Co1qyTlvuf/phNnmkLoo6PIIJLSKKUDwpEqkTSQHLK5mZWUlJtyWrFixxIfgCBbMmb6WJfL0O9LJlG3Qo4oLmc8qIoe03c24mHorJVwLff09tA2QBHetr7W1ysGP6D1lDHZ+sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86kk4qrZ2B2zknE3x8ycKe1XNJV/JmhikUI3khjl4VE=;
 b=W900ciI+xlO0HBn3csv5J9yVFGxs8J3fmn9bMcnkq0ab4CQ0T1Ar+0ei3yuURxazFOhrcHGhWrrVbnRqxkXnpgzkYM0OtqUNbh9jQUTZhdLMEVPL0micTchHYRofcQ7mK2hZob0mbz0JsEYmdPFPEKd5pI1skNI3D9BY6F4dBjs=
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
Subject: [PATCH 2/3] ARM: dts: at91: sam9x60ek: enable watchdog node
Thread-Topic: [PATCH 2/3] ARM: dts: at91: sam9x60ek: enable watchdog node
Thread-Index: AQHV4LJF1Hog0kspA0eb3pDFUsn70g==
Date:   Tue, 11 Feb 2020 08:07:14 +0000
Message-ID: <1581408369-14469-2-git-send-email-eugen.hristev@microchip.com>
References: <1581408369-14469-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1581408369-14469-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f47edc-9e83-4f2a-36c3-08d7aec967ca
x-ms-traffictypediagnostic: DM6PR11MB4011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4011381169572AD102006720E8180@DM6PR11MB4011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(107886003)(5660300002)(6506007)(6636002)(86362001)(26005)(110136005)(54906003)(71200400001)(478600001)(6512007)(186003)(316002)(36756003)(8676002)(4326008)(8936002)(66476007)(66946007)(81156014)(64756008)(66446008)(66556008)(2906002)(2616005)(6486002)(81166006)(76116006)(4744005)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4011;H:DM6PR11MB4123.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUc4HAiPMUhaGnFxqPFBjPeDYVJteG3SdHIRi4FxhRuHNrGAU5tffrJbu7y8e0iq9tx/XF6mOKvnepYIqJEFU+LL2K+z4swLRUYp7mMK69As/XG4v9avyZS9YhEsiuaz9qNyE3i8A/a4WcBHY47i/hYF0z+sWFio0JMaIjOc/ohrJtJwNqm6rwelF4UvJkffWH9df8ukpaUzqCg+++ebl9yDwnrvm44GJH1JikcwF57dTtkD1xp5TLLmpJSUr1bDvbJFgwasGGvU2W1nuzOenUbScvrnewDqHGGvaEBrobeqIrRgigNASCio6teU7ZAMiK/5Ji+aDMYWOEQhoI/mRsir0qZ1W/khkrwYuwygThbIL1C7OW2IVmOhvOSogSVIcvRTlzhWe3zdcQSqRQLJ2JzgcEPfjoWO4ilSMqaIqal7zPsy2581/KmkW4Ue0ZCk
x-ms-exchange-antispam-messagedata: yiQsI8Jb/EIOGNqMfUfkiYSbeEGEfaaROdhRoUMoEuTU8TTxifCd4eSw8eTS/40lhp8OP8T0Mohf3KJXLyb8rxdazvV9lbctXXmgZPpVBDXenVxT6aPoYxMge66b4G6qb7t0emUCjJHHOypXR2P6Jg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f47edc-9e83-4f2a-36c3-08d7aec967ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 08:07:14.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZuxVFkWwOL2xW0l/dwsIFsLqR3v+HRTCXKAwp0zCDUtThyLCyeHWo0Liu8xb1pH9FbqLLm8SPbfNArVtGi3UxzqF6m+CLvbKGXwwc2Q01I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Enable node for watchdog timer

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-=
sam9x60ek.dts
index 9f30132..b484745 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -645,3 +645,8 @@
 &usb2 {
 	status =3D "okay";
 };
+
+&watchdog {
+	status =3D "okay";
+};
+
--=20
2.7.4
