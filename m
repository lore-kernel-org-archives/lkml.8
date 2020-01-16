Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BAC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828AB2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="xxtyZlTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPLNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:13:30 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52772 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgAPLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:13:30 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GBAllv020809;
        Thu, 16 Jan 2020 06:12:59 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xhb7tefw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 06:12:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOyDgI/nWqtvFPWZNvqUaD7sKNxD8jD4fNa9CbUbffJHfTHZM6LtiT7M+cIMK+DZIWxvZ8pjaio27cavCSHMbBKiH7KTSAYCpinw4O1L2lKV2vlUacpirztI9LBU9OiD8H1AnO+E1dP3fHR/Cna58skXlr8CylLlZ7MynmMSriuByQqG1YnzBCrXVpzQD4xxn3rPdgHTiZw6/G314VdW8wcjjIbtojKeRKzRn712gw0zEBZ6syGwH3BULjIAmbsjo63bn/KwHYZdmDUisXG4QgUtbvAVnw8IZAqUzOqLWptHJxukl9qCae7hoiq4lpnL8fohMGpX74tOhM0etB1HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5/H9RQHl64Q4IC0xcAKx+jV3yYixtQvDjtUijn9U0Q=;
 b=HwVwcjEUpAEFzn46Y5uS1fk8x3JbOMMTUmRHoLKFnl7pU8r3r81GJSEoZGi8ubuaXkkPAnQ0YRaZTiWXcI04c1Inqd7iZ22lQAo8Ciyi53rJaEGlGYHWEMGtNDX3VLXuPuO3T+R1fcX0oYkVPMMAQHZexfFDLXAZqRv2I4QT17imkrH3xoHnUnDQ7F4cCH4WCJAlYtzn6nmrEHh2fbHE+IzYrrQ/SX+ScrObvcDLNUAg6QMDJYQphZHzwMmtNfNuDR9LzjnL1/lvwpRaIglFQNlx10r/nfZnUAam4mvPo5Q5xS9WQ2GjYwypwbAFQvydD5GXTW946fq32urwJTmQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5/H9RQHl64Q4IC0xcAKx+jV3yYixtQvDjtUijn9U0Q=;
 b=xxtyZlTC6pc773KjkZ7ojlZ0YpWTl7Iyq0MYeM30UGzX3BcT+kE2cIPofQqrpFmJR5NqsvtV+s/fJxA/BRj5S9caZlSfSc9wrjsEsrHJ+PLg1U92KMCOlZ4sWr/CrCslEghc16bGBF3PbU2Ru/1WeK4dKQwHfZa28w6ObyIgHTg=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5301.namprd03.prod.outlook.com (20.180.15.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 11:12:58 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 11:12:58 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "m.olbrich@pengutronix.de" <m.olbrich@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] usb: dwc3: gadget: Handle dequeuing of non queued URB
 gracefully
Thread-Topic: [PATCH] usb: dwc3: gadget: Handle dequeuing of non queued URB
 gracefully
Thread-Index: AQHVlLDojXL384lpc0mH5s1psXELpaeHpQ4AgGXt+oA=
Date:   Thu, 16 Jan 2020 11:12:58 +0000
Message-ID: <9d6ec804e3f1f462e5c6a43d19c83ff3493e3727.camel@analog.com>
References: <20191106144553.16956-1-alexandru.ardelean@analog.com>
         <20191112144108.GA1859@pengutronix.de>
In-Reply-To: <20191112144108.GA1859@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4118e08d-d18e-436c-7450-08d79a750b1f
x-ms-traffictypediagnostic: CH2PR03MB5301:
x-microsoft-antispam-prvs: <CH2PR03MB5301014E3BF22BCD6D187DDFF9360@CH2PR03MB5301.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(6506007)(86362001)(6486002)(6916009)(6512007)(71200400001)(5660300002)(8936002)(8676002)(2616005)(81156014)(54906003)(316002)(81166006)(4001150100001)(186003)(26005)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(478600001)(4326008)(2906002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5301;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nx0MCiDWWYtEqAqAZqruQX3d+wKxtEzTiv2ijRJ4VOWUsp2kNGpnfj9iwW33WbihvnqvF6i/V+w2JscSN8KrVT7pIRMLW9SvsFFvDcMl+zOIqE+rYBN4S58PwQl5ztRMjP1JJD74Hvvcbxd4U/0hPhfDp6tDLgPBHzTVpO+kcQVutt+w4KqrAUBkZp9UmPv9BcquPh4o/pJ8zT/wkPwhbbl68WLuJgvHoZsrQvAKI9UUvYrj0hLW6WCbS7Q9WEtA9+FmkAQAxVkeBaX6nqBOQmwx5q1/C2fD0iT70IMVPGbCaFse+3lkoY2gsc2sATimsF/Si+th6qHEde/M495wqgPi9DLuYXj7aZ4YUJu4ikNy9VfRA8kRCFXJPUAO3ykLPMXxPlPnqRFuR0PXWy2LQ6hkt9vZ893dAXY7qKzMDShT5tJH5+3YvmXvUqFZrZhj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC5A1814E6BD1B4381EEC0C7688A2162@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4118e08d-d18e-436c-7450-08d79a750b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 11:12:58.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/yhTIFiyUCW4m6wF3+y3UP2LBXJeIegIdVVhE99Wh0TZkrDrfuDKWI8/MjpnsFkweu2hj1Q1s4HCr2kG2Eg3SvQTHxwd0BE7JKrd3jWZns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_03:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=972 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTEyIGF0IDE1OjQxICswMTAwLCBNaWNoYWVsIE9sYnJpY2ggd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgTm92IDA2LCAyMDE5IGF0IDA0OjQ1OjUzUE0g
KzAyMDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiBGcm9tOiBMYXJzLVBldGVyIENs
YXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiANCj4gPiBUcnlpbmcgdG8gZGVxdWV1ZSBhbmQg
VVJCIHRoYXQgaXMgY3VycmVudGx5IG5vdCBxdWV1ZWQgc2hvdWxkIGJlIGEgbm8tDQo+ID4gb3AN
Cj4gPiBhbmQgYmUgaGFuZGxlZCBncmFjZWZ1bGx5Lg0KPiA+IA0KPiA+IFVzZSB0aGUgbGlzdCBm
aWVsZCBvZiB0aGUgVVJCIHRvIGluZGljYXRlIHdoZXRoZXIgaXQgaXMgcXVldWVkIG9yIG5vdA0K
PiA+IGJ5DQo+ID4gc2V0dGluZyBpdCB0byB0aGUgZW1wdHkgbGlzdCB3aGVuIGl0IGlzIG5vdCBx
dWV1ZWQuDQo+ID4gDQo+ID4gSGFuZGxpbmcgdGhpcyBncmFjZWZ1bGx5IGFsbG93cyBmb3IgcmFj
ZSBjb25kaXRpb24gZnJlZSBzeW5jaHJvbml6YXRpb24NCj4gPiBiZXR3ZWVuIHRoZSBjb21wbGV0
ZSBjYWxsYmFjayBiZWluZyBjYWxsZWQgdG8gdG8gYSBjb21wbGV0ZWQgdHJhbnNmZXINCj4gPiBh
bmQNCj4gPiB0cnlpbmcgdG8gY2FsbCB1c2JfZXBfZGVxdWV1ZSgpIGF0IHRoZSBzYW1lIHRpbWUu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFm
b28uZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUu
YXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+IFRoYW5rcywgbm8gbW9yZSAiZHdjMyBmZTIwMDAw
MC51c2I6IHJlcXVlc3QgMDAwMDAwMDBjZGQ0MmU0YSB3YXMgbm90DQo+IHF1ZXVlZA0KPiB0byBl
cDJpbiIgbWVzc2FnZXMgd2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQuDQo+IA0KPiBUZXN0ZWQtYnk6
IE1pY2hhZWwgT2xicmljaCA8bS5vbGJyaWNoQHBlbmd1dHJvbml4LmRlPg0KPiANCg0KSSB0aG91
Z2h0IEkgcmVwbGllZCBoZXJlLCBidXQgSSBndWVzcyBJIG5ldmVyIGhpdCB0aGUgU2VuZCBidXR0
b24uDQpNYW55IHRoYW5rcyBATWljaGFlbCBmb3IgdGVzdGluZyB0aGlzLg0KDQpJJ2QgYWxzbyB1
c2UgdGhlIG9wcG9ydHVuaXR5IHRvIG1ha2UgdGhpcyBhIHBhdGNoLXBpbmcgbWVzc2FnZS4NCg0K
VGhhbmtzDQpBbGV4DQoNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8
IDcgKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gaW5kZXggYTlhYmE3MTZiZjgwLi5iNTAw
ZWM2YjBhYTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiBAQCAtMTc0LDcgKzE3NCw3IEBA
IHN0YXRpYyB2b2lkDQo+ID4gZHdjM19nYWRnZXRfZGVsX2FuZF91bm1hcF9yZXF1ZXN0KHN0cnVj
dCBkd2MzX2VwICpkZXAsDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkd2MzCQkJKmR3YyA9IGRlcC0+
ZHdjOw0KPiA+ICANCj4gPiAtCWxpc3RfZGVsKCZyZXEtPmxpc3QpOw0KPiA+ICsJbGlzdF9kZWxf
aW5pdCgmcmVxLT5saXN0KTsNCj4gPiAgCXJlcS0+cmVtYWluaW5nID0gMDsNCj4gPiAgCXJlcS0+
bmVlZHNfZXh0cmFfdHJiID0gZmFsc2U7DQo+ID4gIA0KPiA+IEBAIC04NDQsNiArODQ0LDcgQEAg
c3RhdGljIHN0cnVjdCB1c2JfcmVxdWVzdA0KPiA+ICpkd2MzX2dhZGdldF9lcF9hbGxvY19yZXF1
ZXN0KHN0cnVjdCB1c2JfZXAgKmVwLA0KPiA+ICAJcmVxLT5lcG51bQk9IGRlcC0+bnVtYmVyOw0K
PiA+ICAJcmVxLT5kZXAJPSBkZXA7DQo+ID4gIAlyZXEtPnN0YXR1cwk9IERXQzNfUkVRVUVTVF9T
VEFUVVNfVU5LTk9XTjsNCj4gPiArCUlOSVRfTElTVF9IRUFEKCZyZXEtPmxpc3QpOw0KPiA+ICAN
Cj4gPiAgCXRyYWNlX2R3YzNfYWxsb2NfcmVxdWVzdChyZXEpOw0KPiA+ICANCj4gPiBAQCAtMTU0
MCw2ICsxNTQxLDEwIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1Y3Qg
dXNiX2VwDQo+ID4gKmVwLA0KPiA+ICANCj4gPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gPiAgDQo+ID4gKwkvKiBOb3QgcXVldWVkLCBub3RoaW5nIHRvIGRvICov
DQo+ID4gKwlpZiAobGlzdF9lbXB0eSgmcmVxLT5saXN0KSkNCj4gPiArCQlnb3RvIG91dDA7DQo+
ID4gKw0KPiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShyLCAmZGVwLT5wZW5kaW5nX2xpc3QsIGxp
c3QpIHsNCj4gPiAgCQlpZiAociA9PSByZXEpDQo+ID4gIAkJCWJyZWFrOw0K
