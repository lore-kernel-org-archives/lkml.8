Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3206CC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F088E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="p2Bj3or5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgBKIH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:07:29 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51743 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgBKIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:07:25 -0500
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
IronPort-SDR: xo7oi8CpGu8AV8FCIcFcLMOZjhD0V0gjo5eeAKpMmaZkLxOfdL7yFt821jXWbOecJFaIFF+BY7
 JFZztmGfNqwRCYcbY6Xz6ZQa+DiX36II7sbNlodPgY2/K7wYnoQxBm9aijxnGe66LiDvYx69eK
 DMdwMAPSiGUND9pL4EI+Ny1/joNOj7m1jJ18/9cyAcrjHyO0jQ8BW26noh53fJB18WF+1cXZ4r
 xgqlGFr6q1i3D1S3qOg2ybclX6SH6dRbeFt3pzjz3QNgjdR93QrhA5WW/QZ3Pwj6cklqOxZPLz
 aIw=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="68013464"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 01:07:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 01:07:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Feb 2020 01:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIp6WFhQkdULodYrIjbqgRpEznd2ijwkUBn6ngIiy6IIgqePRvTTPExL/vqP5tlt//VhlIM7NkxwzPm7fdShXL7v/ZLTQibjiOZfmDPfcFwflwFTMCFDO8g+GfMgXNIyFEeIVW3MXTaij57zFcexCdk9WIws1FFuRu3UoAZx8WvSAeqOKHBygbKoH7hWaIp0irnVa6UOSEpJepGVEM5fAU0MG4Ht70E2/GnuD9Lzy/v2omYAHO/x0yoOYenu8Frw5JjOxAFKZerEWr6edcvC0S334+SFUqTVim/CXnUvn1lXBfR4CHXvgQ30sceYo74VdymrivO9+p570GWzDLUgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMg1z7j/gBQsHjeJVZBW6Nj2qcWmFAX5Fe/vhxY6WnY=;
 b=ajrdExMTpf5s5VsWKp9GmfPno9PITmW29fXNm8bQtZYogKt+Xx+RJECR/nP5TTBRyTqpLxRFQOY+LhW5ODIBteKpIrLXI/yi990AU9VA360IGRwjWEBtSP+1QZ89LxnBS7X8sB8pf5AnhIITEpmgsnrePMxbB26zORVDRXQIOXTZqyAcLRLwD0rjXQT1w2a8T0reU4TUYf810Sa3UfwHqxKiFhRIyosgHtPm6LP5RUKzKcjvT+FaYKNc/E3rkAv+3nG8ddjjapaDPyktZ8JbFhfTdHqkrPPGc9jKXDMMkDCNjTD6p9W+MCAbpml2jkMHqxpUhCofssRrVOYfZzY7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMg1z7j/gBQsHjeJVZBW6Nj2qcWmFAX5Fe/vhxY6WnY=;
 b=p2Bj3or5sjxJFlTqkkBAMt0U+5VObtA83ZXjVd/dYT8oy5uzoXcxIwVW35qLrUMFyxMZMVLklzhEw+8R7mWurEm2V+FS9bXwfuobIG0i3gJiBcz12MBEyQ6KSLii1b5sm+Bz/o2oo7A8NrOHyfsMZ9MU5FuI3arr4Vq/mUzrbVE=
Received: from DM6PR11MB4123.namprd11.prod.outlook.com (20.176.125.204) by
 DM6PR11MB4011.namprd11.prod.outlook.com (20.176.127.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 08:07:15 +0000
Received: from DM6PR11MB4123.namprd11.prod.outlook.com
 ([fe80::85db:d80e:e645:ac17]) by DM6PR11MB4123.namprd11.prod.outlook.com
 ([fe80::85db:d80e:e645:ac17%2]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 08:07:15 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 3/3] ARM: configs: at91: enable sama5d4 compatible watchdog
Thread-Topic: [PATCH 3/3] ARM: configs: at91: enable sama5d4 compatible
 watchdog
Thread-Index: AQHV4LJFeseR12rGk0yZaOTkf/LqOA==
Date:   Tue, 11 Feb 2020 08:07:15 +0000
Message-ID: <1581408369-14469-3-git-send-email-eugen.hristev@microchip.com>
References: <1581408369-14469-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1581408369-14469-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58387fe1-fdc2-428a-19f1-08d7aec9682e
x-ms-traffictypediagnostic: DM6PR11MB4011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4011A104B562AEFEAB800080E8180@DM6PR11MB4011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(107886003)(5660300002)(6506007)(6636002)(86362001)(26005)(110136005)(54906003)(71200400001)(478600001)(6512007)(186003)(316002)(36756003)(8676002)(4326008)(8936002)(66476007)(66946007)(81156014)(64756008)(66446008)(66556008)(2906002)(2616005)(6486002)(81166006)(76116006)(4744005)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4011;H:DM6PR11MB4123.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGs2edRMKiGrHUDSnBQpwT/ekRHaG01tkrU+J6zeg2fLggo9OOwGah+Vznm30lFMsH8+obSW9Q+wmVqMdNpGhCLgK29NwUsMqh/4DA+yjYm99fk+oqkbqBvDYZkBh8qpyvf3ByGGJ9J8+fuDg3h9r5wR6iSRAbn5y2NeSB52mQExPfwYKAJmtqcnKP/9X0U+rTzUjxD/te5Tp+rFJhubbopftQkXzfHDOGcYCVCkKDXDmurOcd9pmfMOCObYT2DtsrPCDqb2AN9m5S3WgV9OQS6ZN8fxahojlq8tVsiyGtmJI2ozwVTpYlxQQjD0favy+uFPYgTyHPC7uvCJAK7TvxYpY81Yew57ptHlqHfKZ8M+rOXHTkCWIz26tj8qd6AgRensc0xrV8zrtQ8TAa9dA0Q7fZR8UAqQPsRB9wwrHmdDCN9IH/w/K8+zcf4UxaEg
x-ms-exchange-antispam-messagedata: +mA4hYUYSEYcPpT/8fX4LaGyvFUJh6Wjg7VRXtlfoRh+KwDnSDBTed0Wc93VuPjDKYdfeMk3v/yAauWU8GZGJhth6n7onKEJqG7ebrgF+rtVDTyUPXCX5waipz84JSFnXajK3+nPWWlsV9uyUxncbA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58387fe1-fdc2-428a-19f1-08d7aec9682e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 08:07:15.4026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZqV47e6agAx0+/UH14w5+Qt84G8/aNnGa0yO8QDjpMv545f/RvfmDikdHSkInn82EU7K+ULu+q+DIh7Ya9BS68lUVfUXxE9nZihDS5l0qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Enable CONFIG_SAMA5D4_WATCHDOG. This driver is compatible with sam9x60
watchdog timer block.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_=
defconfig
index f66bb98..4a0ba2a 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -118,6 +118,7 @@ CONFIG_POWER_SUPPLY=3Dy
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=3Dy
 CONFIG_AT91SAM9X_WATCHDOG=3Dy
+CONFIG_SAMA5D4_WATCHDOG=3Dy
 CONFIG_MFD_ATMEL_FLEXCOM=3Dy
 CONFIG_MFD_ATMEL_HLCDC=3Dy
 CONFIG_REGULATOR=3Dy
--=20
2.7.4
