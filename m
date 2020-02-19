Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D3C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7E8208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="WEyoNVp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBSAeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:34:00 -0500
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:45922
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbgBSAd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdyXniQISawmwZ/F87KSx/I6+WIAjLG6hDtF+TJCIOrkUxSaDxYSE8CQAUQR/r6XvZk9Gsv23e92e+a37aU09sFs8XWEVH3e+DBRgXHmppaO2Hf+ckCusxJygMGJNh6bHpAnB/ucvAPFsAdOs1pbtMlAXYaN1DGWudVEJV0uq3foi/oSIoPhh0nOnxeEUecPl3NS8FdVnMn/pY6Com5IBkHJ4exzG0V2ylyLIQ/l3mXjQDI+EnVQa3R4pQSu3z0spAockp7szMES0xj6533hh1N4T0EVGxdCUrzY5r3brPCnz98I1laGr5zaDAscDW9s871tewjnhHhz63qlh3kJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqMOXwCIA4YmSfN3xI2nBLaoNruTAwS5pdIF+xD9+y4=;
 b=HaOwocAM527WHDlTPKz/i6A9pkkfwyNLaK5c87OTYl+H9blBTzW0UWHJ61wnVcm5O6FORTNwErOsXURKqz++7mrYsS+szKdlyGcGqZ/RoYtYKo8M9j2kAKFj6ms3V4pCSXC8CwEGnUK7wFp7A8OoldBwVBzlifpNAmyUPmDQ/7LrZnG2iYpxDj2REMHjov+f6QUSgtJfMW1ysslaYh9ywrhr3Nw1qUFZ6HVX6uycxqAunsrXEzZnbgSe5+BXffjbP2n0fSzRkErbwxGqlm78TJNNqHObCFDzErgDSBE+rwnsLhUhuFcdyuzS7xMEQCzzx8WWWMnlWvCW5DQ09WBrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqMOXwCIA4YmSfN3xI2nBLaoNruTAwS5pdIF+xD9+y4=;
 b=WEyoNVp0NpptqIo0bfbBQej/38MYsVLNYyrvNaAT3bNxZF91PMz28vDPGvqRy58qhJSwZGpvWhm9yKbJUi9nCSr4gTMPSowYZf4s6ifkmg0CFWmuSUpNUoYFsG4uR3XFbtpb3enmp923C3353uzkD8eCMY/4M7AaXFSk4beMmSk=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4383.jpnprd01.prod.outlook.com (20.179.174.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 00:33:56 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 00:33:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "b-liu@ti.com" <b-liu@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "slemieux.tyco@gmail.com" <slemieux.tyco@gmail.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "vz@mleia.com" <vz@mleia.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 14/20] usb: gadget: renesas_usb3: remove useless cast for
 driver.name
Thread-Topic: [PATCH 14/20] usb: gadget: renesas_usb3: remove useless cast for
 driver.name
Thread-Index: AQHV5pJjlc+xczpn3U64bn6qmWQNnqghqx0w
Date:   Wed, 19 Feb 2020 00:33:56 +0000
Message-ID: <TYAPR01MB45442877135FCCE97570E2BBD8100@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
 <1582054383-35760-15-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1582054383-35760-15-git-send-email-clabbe@baylibre.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da2a68e8-f36b-43ab-6780-08d7b4d3676a
x-ms-traffictypediagnostic: TYAPR01MB4383:
x-microsoft-antispam-prvs: <TYAPR01MB43834029F4DE4D023C2DEDDFD8100@TYAPR01MB4383.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(110136005)(4326008)(186003)(55016002)(9686003)(76116006)(316002)(478600001)(71200400001)(26005)(5660300002)(55236004)(66446008)(6506007)(64756008)(66476007)(66946007)(66556008)(33656002)(86362001)(7696005)(2906002)(54906003)(4744005)(81166006)(81156014)(8936002)(8676002)(52536014)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4383;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1U7aIJT3ENhL0xDGC2VEcfWcahvdi156dLcN9sv2nrv0KPeUQ9AQoBgKcmx+fiVCEeLwo7EGwVM4ps53lE8aPNwjDs6NWDzFbzcisuKHI7H1CPpiDFqm/yT0/ebmZ4K57ye1uKENBNKgjqTIgfskkeZG6zdHcjUXxis5R0jlmkAEfwCpXtlh4/IgHUXQTNOhMldiFsynCHxs+tAHF1/ZHMhIZ1KeT1OT36wl7fGAlYUvrjfWzd3bEmYkrzHXBfTceFa95ciElHo8qYC5voEOQwRdG3UdRXjbi8KEEfHrGkh66ScUb96x2bh3hC6m0IgxP8pYrTUg504t6zpXAJbcZIcdLhXof4eYw6P847Pcr5WR6hGS/ccssv9bSdmApwvV8Esq5cAkAvagjU9+XCzJcPLvG46A2L7njW5yxVnPKZbH71Zy8X+lL76Qixeb5MvErcc2HzpWFXuILC5NAn74BvLImtl6Kmz/fv5qeP3+qQXy5gAGB237HjpU7lgSNK7
x-ms-exchange-antispam-messagedata: VX3lC1QpfpUmzqlnH+fZlv0plpW4JOJj5BTke8GTRAhO6xc6Zjql392ZuY3k5uL9BSuVbnJVvPkC6FhJkPiXrKuExkYv7W3qozr51u7GCNkX92th7WFtLsGpkT3+qyh66dqJvuu+73pZSV40E1aWKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a68e8-f36b-43ab-6780-08d7b4d3676a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 00:33:56.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkbZccuKt5+73KAF6K1o/PLSOOjVSgSLKvpdCI9YqJObrldbfr6ENm/TTuKPbtZ0QcppPUHGLfBd6h6VVvXwQKUo+m1swrMrPlu2TUCyUQOuYovUe0BumIP+jPZ/f+mU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Corentin Labbe, Sent: Wednesday, February 19, 2020 4:33 AM
>=20
> device_driver name is const char pointer, so it not useful to cast
> udc_name (which is already const char).
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

