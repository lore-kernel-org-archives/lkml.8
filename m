Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C38C4BA3C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95BA24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="okkoAKSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgB0Iu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:50:26 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:30470 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbgB0IuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1582793422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06YWNsTMoau3wb3JOJ5G4nFJSZUaD3KCKOvRYzVk6LE=;
        b=okkoAKSqAH/pq925NJhNB8qCaMAqwq5KxNcFgYv1QGU2GDaNj0LLQZoj0Uhus/0AEwTOu3
        +lv9UvE4LCkn6Nu3Itc3Hp2zB2ISyCduoOciTVmqcqnKAzdXpi/Kn2MsY1uptRjiW+4fej
        9J9rPb39G1jkD4J5KniW2uxSfEThvyI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mta-256-4Jkb65eAPCWrAR7HqZ-4Ow-1; Thu, 27 Feb 2020 08:50:21 +0000
X-MC-Unique: 4Jkb65eAPCWrAR7HqZ-4Ow-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB2510.EURPRD10.PROD.OUTLOOK.COM (20.177.59.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 08:50:19 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 08:50:19 +0000
Received: from [172.17.183.132] (80.93.235.40) by LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 08:50:17 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: Re: [External] Re: [PATCH v2 5/8] usb: mausb_host: Introduce PAL
 processing
Thread-Topic: [External] Re: [PATCH v2 5/8] usb: mausb_host: Introduce PAL
 processing
Thread-Index: AQHV7ItbzvqingZIeEeVfzReVaM/AagtaWKAgAFTXwA=
Date:   Thu, 27 Feb 2020 08:50:18 +0000
Message-ID: <55d0673a-fd13-4afe-6dca-a98f058656c3@displaylink.com>
References: <659eab4d-a995-d372-2c46-8b3d72ba13bc@displaylink.com>
 <1582720533.17520.26.camel@suse.com>
In-Reply-To: <1582720533.17520.26.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27)
 To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7945bf5d-a2cb-4ab4-bb6a-08d7bb62125f
x-ms-traffictypediagnostic: VI1PR10MB2510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB251025B1AE4FAF0284657E0C91EB0@VI1PR10MB2510.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39830400003)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(44832011)(956004)(6486002)(52116002)(2906002)(316002)(5660300002)(2616005)(107886003)(54906003)(16576012)(110136005)(36756003)(4326008)(66476007)(16526019)(31686004)(64756008)(66556008)(66446008)(8936002)(8676002)(81166006)(26005)(81156014)(66946007)(71200400001)(31696002)(86362001)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2510;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZGBJ773/TvCwDCbNXsqibDohcWjUmLYVmqXypdz6F5ZxDZt1Iaos0Q3fYTOsUdxooV+jWHEC8FNWJHXaJXlAedmJ6L1MdbehLeElNKZb+ZOG7jLOkomNMTVHcZXpuTcDNyPwBG0o4DnzzQKh0Mw+4fJShivHiSFrHOn+3pr97dtNS7HpSpkhjdGgkWgvnSVqN23WURsYxsEMqqFH8iJIepF1RBXJd4bOh6OAdv8T7wiPxzmnBydY50EjhMkBQL+O94KkkAgfgeHEWRCtyicEmJujI21HJjbEO1FRIXdLVE/9zFSkNfWcQfaNT/awVutyAlhv7ctKwWpe4sqA0aQXWxBaXFhqYoN2z6wxQCT6eG8gRT/u7f9CueeEm7Rvu0HrBGSOZ2I38d5Iw0tiubS1LlbgH56+/VrBSv13t04MRibHzXySL82JYVqfvXScFei
x-ms-exchange-antispam-messagedata: kxmXHBIBxGxLzr97Q73NWlctx+Mbviqm5uSAhjubAkDuiW5v4ogGgxUtLisqXtdMfkoBQyN4ssnw466c8r01mSiDmZfwzkrSCVHEhCXCDZ7e+sOw3PeH7gl36tC1JZGHVi3nkDjReiA/VMhh3LtdwA==
Content-ID: <3318E076C76DE74CB8F76332E6676FF6@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7945bf5d-a2cb-4ab4-bb6a-08d7bb62125f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 08:50:18.9595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5dHA4XTfV1mjd+njKbyATzB/mZ5t2+KaBswSGuFNvabueo12C6GCCUQEVi1gTJO3Gpb7qws1avPFereXunUttTTmcZQZsm1H1aBkiz7WS0NKr3SLLC0uU2GU2UElj3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2510
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMi4yMC4gMTM6MzUsIE9saXZlciBOZXVrdW0gd3JvdGU6DQo+IEFtIE1pdHR3b2NoLCBk
ZW4gMjYuMDIuMjAyMCwgMDk6NTggKzAwMDAgc2NocmllYiBWbGFkaW1pciBTdGFua292aWMNCj4g
DQo+ICtpbnQgbWF1c2JfZW5xdWV1ZV9ldmVudF9mcm9tX3VzZXIodTggbWFkZXZfYWRkciwgdTE2
IG51bV9vZl9ldmVudHMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MTYg
bnVtX29mX2NvbXBsZXRlZCkNCj4gK3sNCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiArICAgICAgIHN0cnVjdCBtYXVzYl9kZXZpY2UgKmRldjsNCj4gKw0KPiArICAgICAgIHNwaW5f
bG9ja19pcnFzYXZlKCZtc3MubG9jaywgZmxhZ3MpOw0KPiANCj4gWW91IHNhdmUgdGhlIGZsYWdz
Lg0KPiANCj4gKyAgICAgICBkZXYgPSBtYXVzYl9nZXRfZGV2X2Zyb21fYWRkcl91bnNhZmUobWFk
ZXZfYWRkcik7DQo+ICsNCj4gKyAgICAgICBpZiAoIWRldikgew0KPiArICAgICAgICAgICAgICAg
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXNzLmxvY2ssIGZsYWdzKTsNCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHNwaW5fbG9j
a19pcnFzYXZlKCZkZXYtPm51bV9vZl91c2VyX2V2ZW50c19sb2NrLCBmbGFncyk7DQo+IA0KPiBZ
b3Ugb3ZlcndyaXRlIHRoZSBmbGFncy4NCj4gDQo+ICsgICAgICAgZGV2LT5udW1fb2ZfdXNlcl9l
dmVudHMgKz0gbnVtX29mX2V2ZW50czsNCj4gKyAgICAgICBkZXYtPm51bV9vZl9jb21wbGV0ZWRf
ZXZlbnRzICs9IG51bV9vZl9jb21wbGV0ZWQ7DQo+ICsgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZGV2LT5udW1fb2ZfdXNlcl9ldmVudHNfbG9jaywgZmxhZ3MpOw0KPiANCj4gWW91ciBy
ZXN0b3JlIHRoZSBmbGFncy4NCj4gDQo+ICsgICAgICAgcXVldWVfd29yayhkZXYtPndvcmtxLCAm
ZGV2LT53b3JrKTsNCj4gKyAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtc3MubG9jaywg
ZmxhZ3MpOw0KPiANCj4gWW91IHJlc3RvcmUgdGhlIG92ZXJ3cml0dGVuIGZsYWdzLg0KPiANCj4g
VGhpcyBjYW5ub3QgYmUgcmlnaHQuDQo+IA0KPiAJUmVnYXJkcw0KPiAJCU9saXZlcg0KPiANCllv
dSdyZSByaWdodC4gV2UnbGwgYWRkcmVzcyB0aGlzIGlzc3VlLg0KDQotLSANClJlZ2FyZHMsDQpW
bGFkaW1pci4NCg==

