Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E999C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4604F2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="KtedYWOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgBLJoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:44:06 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:23660 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729041AbgBLJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1581500640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/0+USp6paT9N06xRZkWJdijjSjfnLkGtvQKebCcq04=;
        b=KtedYWOjpORwfdXKBGVczA8ogGXSVuEgdnX7gUlIk4DRNj+cm8tc0JQq9iRa2aftV7Jy1d
        Nrsvwvb0lSxDY23LaEP9Kz6sraQi6zFQz8fSuDFxOERmG+5j/Cso81dwwmJq+fMPe2+HF7
        U+5lPgyombizjl60dAkkhK2QFNHtUpY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mta-212-ZEnj4N7QO7Sm0Jd1RDdWfQ-1; Wed, 12 Feb 2020 09:43:58 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB3328.EURPRD10.PROD.OUTLOOK.COM (52.133.246.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Wed, 12 Feb 2020 09:43:57 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 09:43:57 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1PR0901CA0102.eurprd09.prod.outlook.com (2603:10a6:800:7e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 09:43:57 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [PATCH 1/1] usb: Add MA USB Host driver
Thread-Topic: [PATCH 1/1] usb: Add MA USB Host driver
Thread-Index: AQHV4YjyLYDrSQfvlEuniaE5anSHYw==
Date:   Wed, 12 Feb 2020 09:43:57 +0000
Message-ID: <cbdf5e30-00cf-7430-c9be-5d9dd798c393@displaylink.com>
References: <VI1PR10MB1965B4B61D7A9808B2EA095591180@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <61e63056-31f9-9d4b-60c1-8cbf0372d34f@displaylink.com>
 <20200211164108.GC1931506@kroah.com>
In-Reply-To: <20200211164108.GC1931506@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0102.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::28) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b128bd-7536-4edc-bfed-08d7afa014bc
x-ms-traffictypediagnostic: VI1PR10MB3328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB332832B2E82CFF830537FFD0911B0@VI1PR10MB3328.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(199004)(189003)(31686004)(4326008)(107886003)(81156014)(71200400001)(36756003)(16526019)(4744005)(186003)(26005)(81166006)(31696002)(44832011)(54906003)(16576012)(8936002)(6916009)(316002)(6486002)(2616005)(956004)(86362001)(5660300002)(66476007)(66556008)(52116002)(64756008)(2906002)(478600001)(8676002)(66446008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB3328;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3iC/bAJ8CQQNwkrAkk8D5BKUDEz4jHdifKQhs/YSZgBXKfQ7eve+hRWugnZtDV7M5EBNWPrm36f1zoKTsI3V5V/qRpinsG+mlak6AsX2yxO0iMZGb7MM3X6+d1Ejrr7nNyOO2Ol79JJ4s38WOQ9vMsBjNxTcT/jzg8o4kM6i9vflMtmt3wwPncleH/C+1V9iPmWh7db3EWLBtF1pTvP8ZxJ5v8cWTu9BDJ3L+q/JPlyMHRJIaOF6/VBiofSH/IQ/4bFydWoKQvxu9f+WkSA5abd/86DF277B8zi6tVf03PJRb93MOFN0WxRe6o1KBVJZRRDYcuJUmEOnYAxAbBN/OEaUcFGCH2i0b35GE+7gkMAgCWGx2UMJzdAz6b2I4N5ESlqhey2Z8Uw6uo3BynSq/dqWRqqidJHEFZD4F8u0uxMNiXQlAx9kawcMx4+Xkz8Y
x-ms-exchange-antispam-messagedata: u1KczzophwghtHBA1j7AfY+CrH+BS83S9liXieRaEueLUzGd26Tft84Qwxrn8nL3Zg9L5K0HUY2iif8JNMZdBnE8Q8KYqq6rT5g2ejI08p4ftKUawqo/rJ0x6Kfg1bvJP/bx7xovS+XhzaMVJ22pgA==
Content-ID: <92EF8E50F4040047AD78DBFC67138DFE@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b128bd-7536-4edc-bfed-08d7afa014bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 09:43:57.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC5b6teqOkMvMdJORGAynwswiv9fBPnphk2WthZ14/uq97HCW8F/KfxwxaWWFQ6x3kmqoMe/ZRbFF/TgKd+gDuaIf2WfP2aULvbWYFI6OgzhO9PK8PWS7KaXj4cbAHvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3328
X-MC-Unique: ZEnj4N7QO7Sm0Jd1RDdWfQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.2.20. 17:41, gregkh@linuxfoundation.org wrote:
> On Tue, Feb 11, 2020 at 04:21:24PM +0000, Vladimir Stankovic wrote:
>> +++ b/drivers/usb/mausb_host/include/common/ma_usb.h
>> @@ -0,0 +1,873 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>=20
> Nice.
>=20
>> +/*
>> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> + *
>> + * This file is subject to the terms and conditions of the GNU General =
Public
>> + * License v2. See the file COPYING in the main directory of this archi=
ve for
>> + * more details.
>=20
> Note, COPYING does not say what you think it says here :)
>=20
> Please remove all "license boilerplate" from all of these files, with
> the use of SPDX you do not need it, and, as is the case here, it can
> often be wrong.
>=20
> thanks,
>=20
> greg k-h
>=20
Agree. Will address.

Regards,
Vladimir.

