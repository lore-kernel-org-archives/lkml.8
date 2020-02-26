Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD16C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DE42467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="BA2vK/9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgBZJ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:57:32 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:40333 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbgBZJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1582711048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GMAeEUisq/fTEGN18JFOBILvZMEP1SjsMBORCeLkH6M=;
        b=BA2vK/9vnJn+oU1vN4LmUDIzH+zWA4F2MC2AErllJmoLou6Bpu3s7MowP93okGF0sIlayh
        Rxgtv2v6Ff3f09uJB6Ffp7SdEnQFt718XlaWMD3bJEOp9bg+89Ri53psB0b78LYEeTikNb
        qmoaIS0XvMAwkhzC5Z6DCBu27wWNZpI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-26-m23DxplwOT67jpSSWbFKPw-1; Wed, 26 Feb 2020 09:57:26 +0000
X-MC-Unique: m23DxplwOT67jpSSWbFKPw-1
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM (52.133.63.154) by
 AM0PR10MB2676.EURPRD10.PROD.OUTLOOK.COM (20.178.119.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:57:24 +0000
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6]) by AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:57:24 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1PR07CA0255.eurprd07.prod.outlook.com (2603:10a6:803:b4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.12 via Frontend Transport; Wed, 26 Feb 2020 09:57:23 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: [PATCH v2 0/8] Add MA USB Host driver
Thread-Topic: [PATCH v2 0/8] Add MA USB Host driver
Thread-Index: AQHV7IskUwNNQv/Aj0qPQBxaE+JY1Q==
Date:   Wed, 26 Feb 2020 09:57:24 +0000
Message-ID: <013d6b8e-3e61-b41d-614a-8c115f2e2c9f@displaylink.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0255.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::22) To AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:40::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1477a866-d3b9-45c9-a7ae-08d7baa2474f
x-ms-traffictypediagnostic: AM0PR10MB2676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB2676ABF587540B5C3CADE75391EA0@AM0PR10MB2676.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(81166006)(8936002)(44832011)(8676002)(81156014)(956004)(36756003)(478600001)(71200400001)(2906002)(5660300002)(16576012)(316002)(54906003)(86362001)(66946007)(26005)(64756008)(66446008)(2616005)(31686004)(4326008)(6916009)(66476007)(66556008)(16526019)(52116002)(107886003)(31696002)(186003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB2676;H:AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZtMWrSIxlP8DMbpOND9uO7kgYk9GWVIDyK4QQEsRBDlqdOG/p3CW67ERyn1tx2YgpWdstyVOASJNsqA+T8b26KBLiYQaXbCXJPIMy2D7+IvdEqJtyoJxljwHiybmedn3yUb5MYOrWnbn8bL8KbQNb4ve8ERqyi8Cm3jIvZlOv3j2Gucws9woP7X5sfuol5ZC2zwhRW+qsE2kuPz5uUdQ8GYypSjpk5V/ZWYUcABzuv3YYNyh8zU4sY0cY/kdZvh70O9YhGxkDkAoDYc4nPOyRXYLLdtmHSSYjs51vFuwPg3cTbTQRSe5tzCXLalW4cfDKbkl+kStjG/61uqMvmmTKI/IqZUOUwDEPRu1Jpry+ByFjF7U4DI9fGLRjfdIC2JfMhzFHQeOS5MrpdQj1pd8hM2Ovh+CaB3jOJXtWq5d6/AFlaLZT70PO6tRXekChl7
x-ms-exchange-antispam-messagedata: pYG6m5x+KtsU4r15mMZI1dJv+vPLZCELErVh2d7PYo/shtihhSBMVlciXi6l/LD8KT6FYydULhEJeL2W/ROcYRrAPGLA0I62xuXv3H8U5GgsV0HIIrUGY9/yqGaBhdDe5p/rJGEEJeCpXpY5J6NyeA==
Content-ID: <333849C2BFF7A14AADF543C1FE7B9EAD@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1477a866-d3b9-45c9-a7ae-08d7baa2474f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 09:57:24.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWPhAtYqFGIRjvYHgCWohTF6cCFM8iZGPiwpYuuzXZN2hDz0Vf5+SWA1OEt/wNjdKlACRBmyiggFMN6J/S8vYV4UdKdZNEG44Ppi/inCW7I3+RWO503/dzuIXvP1jFPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2676
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MA USB Host driver provides USB connectivity over an available
network, allowing host device to access remote USB devices attached
to one or more MA USB devices (accessible via network).

This driver has been developed to enable the host to communicate
with DisplayLink products supporting MA USB protocol (MA USB device,
in terms of MA USB Specification).

MA USB protocol used by MA USB Host driver has been implemented in
accordance with MA USB Specification Release 1.0b.

This driver depends on the functions provided by DisplayLink's
user-space driver.

v2:
- Fixed licensing info in headers
- Reorganized code to lower file count
- Patch has been split into 8 smaller patches

Vladimir Stankovic (8):
   usb: Add MA-USB Host kernel module
   usb: mausb_host: Add link layer implementation
   usb: mausb_host: HCD initialization
   usb: mausb_host: Implement initial hub handlers
   usb: mausb_host: Introduce PAL processing
   usb: mausb_host: Add logic for PAL-to-PAL communication
   usb: mausb_host: MA-USB PAL events processing
   usb: mausb_host: Process MA-USB data packets

  MAINTAINERS                                  |    7 +
  drivers/usb/Kconfig                          |    2 +
  drivers/usb/Makefile                         |    2 +
  drivers/usb/mausb_host/Kconfig               |   14 +
  drivers/usb/mausb_host/Makefile              |   18 +
  drivers/usb/mausb_host/hcd.c                 | 1897 ++++++++++++++++
  drivers/usb/mausb_host/hcd.h                 |  162 ++
  drivers/usb/mausb_host/hpal.c                | 2082 ++++++++++++++++++
  drivers/usb/mausb_host/hpal.h                |  339 +++
  drivers/usb/mausb_host/hpal_data.c           |  719 ++++++
  drivers/usb/mausb_host/hpal_data.h           |   34 +
  drivers/usb/mausb_host/hpal_events.c         |  611 +++++
  drivers/usb/mausb_host/hpal_events.h         |   85 +
  drivers/usb/mausb_host/ip_link.c             |  346 +++
  drivers/usb/mausb_host/ip_link.h             |   83 +
  drivers/usb/mausb_host/ma_usb.h              |  869 ++++++++
  drivers/usb/mausb_host/mausb_address.h       |   34 +
  drivers/usb/mausb_host/mausb_driver_status.h |   17 +
  drivers/usb/mausb_host/mausb_event.h         |  224 ++
  drivers/usb/mausb_host/mausb_host.c          |  213 ++
  drivers/usb/mausb_host/utils.c               |  360 +++
  drivers/usb/mausb_host/utils.h               |   45 +
  22 files changed, 8163 insertions(+)
  create mode 100644 drivers/usb/mausb_host/Kconfig
  create mode 100644 drivers/usb/mausb_host/Makefile
  create mode 100644 drivers/usb/mausb_host/hcd.c
  create mode 100644 drivers/usb/mausb_host/hcd.h
  create mode 100644 drivers/usb/mausb_host/hpal.c
  create mode 100644 drivers/usb/mausb_host/hpal.h
  create mode 100644 drivers/usb/mausb_host/hpal_data.c
  create mode 100644 drivers/usb/mausb_host/hpal_data.h
  create mode 100644 drivers/usb/mausb_host/hpal_events.c
  create mode 100644 drivers/usb/mausb_host/hpal_events.h
  create mode 100644 drivers/usb/mausb_host/ip_link.c
  create mode 100644 drivers/usb/mausb_host/ip_link.h
  create mode 100644 drivers/usb/mausb_host/ma_usb.h
  create mode 100644 drivers/usb/mausb_host/mausb_address.h
  create mode 100644 drivers/usb/mausb_host/mausb_driver_status.h
  create mode 100644 drivers/usb/mausb_host/mausb_event.h
  create mode 100644 drivers/usb/mausb_host/mausb_host.c
  create mode 100644 drivers/usb/mausb_host/utils.c
  create mode 100644 drivers/usb/mausb_host/utils.h

--=20
2.17.1

