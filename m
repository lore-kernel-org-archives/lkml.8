Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD27121744
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="slWfhiJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG1FEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:04:33 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:11102
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbgG1FEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQIomICpD1wAQiXDxo+jSyUJ+yQgbzUkUASF0ETsc6zyvyj9dxhFH6L1nSXh/Fe5+PcLN1mrCCcNrJkOdSSR+g29gpjBFDnKjaF4r2is3iwYAr1OAX+Et/HbdaOvEsV3FePOHJ0F6N+zFd4DGGFEyU2WXrvUE/+NhB9KbSFOeSCcnFKtmCckdVzq7RhUnm/Tb1RDf12rW523yl/RQFxL8Z9555gnx+kbFcLfr0Kq+UHQpJugNeTrxaMtPM+qP1UuJldSOtscQjoIZWlf6qDbl6Xv9GOcQiscn3pIEKI1+3RvHcwE2C5Gp1tS1tdGr7H73ZOc6fH59peNme+5JtEiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hdthGFMvmSI4g/LWy6wh09HbL9NqjmtgCMw0H52NjU=;
 b=fo/A0GV7qbvoBtze3AE1kU6Ei/airZtbtJVE0AmEnLfKwpGz6ljtw0+ifYhdQuktXNdPvuz63Iz9or641ixObxpj8JGVPRjULBEWq+QugixI7S9kTOzvKXVPWN0DI6YlIiVTTlzsyWE3GsXNtTLqu6gUVIufQQCrQa7VNpSaEO+Y2z/rj+MscQi/H/pNS+urZJgOO/d4IvnVOEHdby3jyqvUnx04XU2mB/5jd55nOADPjQzUiCY3ZgzD24C2M5ff5P7Uitt/v35ncWF5NnqXG8VRlxqZ30FcrU4hkm++N+TNXtcqJyMcCW6KSEHeV5Z6vs8LpSLhMwzAB/liVEyLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hdthGFMvmSI4g/LWy6wh09HbL9NqjmtgCMw0H52NjU=;
 b=slWfhiJ+lE0bpaEiYKh0719M3lmOq5CqFxuJGabLJpoJrDvIBAJAzOOneXAygW68mz1zAAkdLvobThZE8kuGrtm79CcV6vVI+tRxhXVpN0hKAKvjrAeYvxMVfPYonzSNkWPfbiFim27iowPYR629PRKbOp3OUwkKugjYyTEdE0A=
Received: from HE1PR0501MB2812.eurprd05.prod.outlook.com (2603:10a6:3:c8::9)
 by HE1PR0501MB2188.eurprd05.prod.outlook.com (2603:10a6:3:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 05:04:30 +0000
Received: from HE1PR0501MB2812.eurprd05.prod.outlook.com
 ([fe80::6127:fa1e:4deb:2e7b]) by HE1PR0501MB2812.eurprd05.prod.outlook.com
 ([fe80::6127:fa1e:4deb:2e7b%8]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 05:04:29 +0000
From:   Shravan Ramani <sramani@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] platform/mellanox: mlxbf-pmc: Add Mellanox BlueField
 PMC driver
Thread-Topic: [PATCH v1] platform/mellanox: mlxbf-pmc: Add Mellanox BlueField
 PMC driver
Thread-Index: AQHWY/St1rItZf3xw0iUiUMeHj3EmakbQIIAgAEuJBA=
Date:   Tue, 28 Jul 2020 05:04:29 +0000
Message-ID: <HE1PR0501MB28125EED224EE4F487862974CE730@HE1PR0501MB2812.eurprd05.prod.outlook.com>
References: <0bad52e6e10ff2e8d8a19f95bab7642ec5e71838.1595838334.git.sramani@mellanox.com>
 <CAHp75Vdsw61-uNi2TiR7F4j0s=F6XCnQC_j81hXfyJ9tfeq8QA@mail.gmail.com>
In-Reply-To: <CAHp75Vdsw61-uNi2TiR7F4j0s=F6XCnQC_j81hXfyJ9tfeq8QA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [60.243.63.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0e3d14e-8d3c-43ec-006c-08d832b3b57e
x-ms-traffictypediagnostic: HE1PR0501MB2188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0501MB218871AA0E11E4C019D1C928CE730@HE1PR0501MB2188.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quUbiaUAlZYsaNi5iGJPEVaV65NoiNLVBbM3nOT5xM10AW/QKwVxOF/+OndtKIgqC8J5pApyeekDnICeCIM1ImJNc1aS30ys9U7rIKgWDfTrv9kJu5fT5cESDGHwVDDokI1MpF32VliLK7OYDF3LwAvaC4j2T8K7nYUaVKS8ndZCrHjt0X37Ii25vBj/qOYrCg/8846RSoWd3MaQXaXjuRM3245bBv8JH4bZhi/vfkOMNXHyrXUpqBbJ7+HVaiNP2QNe88iGy22nGPwL52zM9YNgk8mwYesNgeWHc1+FPPku/nymA+OpnaVM8BdXYA076Hx/sLPWbft7EE55UcukVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2812.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(66556008)(64756008)(66446008)(71200400001)(66476007)(76116006)(7696005)(83380400001)(33656002)(478600001)(5660300002)(52536014)(86362001)(186003)(4326008)(8936002)(26005)(6506007)(2906002)(53546011)(55016002)(8676002)(6916009)(316002)(9686003)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o8gQab1TLIp3BApxVa5r00wgYzc7SkSuiHnwpTQzHvAkFOXq9L8GQe0fo6j+KOZhZ1gJoDfvY4mGShiHaf8YRqJONPKcvdcpf4ebgCSl/0m3A4yRXAi/zR9yx7qhfdUdZTpBsGy1EB2jRv5D7Y9ePlC85iJcwODQB3sEAjhSK2xKH4bQkCKHPGtWrX+mwqilEKx9hKjpq5dr/RqmzNe6yiI/hh5k9S8O0qdMZw4mS92LJb1u+XrKj4PRzoi2IrZszYOyZh6OQVHyezJfNosWpBCRoY8LEYuP3Nje1owAdFQo99RzoZCt9LDNZJlUjZ3SS3V8j/6xJyTnBxAePNT4bH4uOv2khHga9fMaHeGhxPtizex4n8DIP5/6xsXvu7FAPCOnIZKihx1JpbAcv3t3+pZd7kmUEiW/kX5pCWnaR5oUV7Usc6cxXzPmO7nesJ+YraUaAxhhGIgMnwvbCfi7A+k+uCea4GsVgiyem5qUhI8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2812.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e3d14e-8d3c-43ec-006c-08d832b3b57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 05:04:29.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOnRyZFiesYDmUbZV4iR44j/x1XIXnyaaEcgZ5N+WwHwGTQbDHoVuOP4MK0l8nNhIH6m0nsU32a8Wi+PMA6qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMjcsIDIw
MjAgNDoyNCBQTQ0KPiBUbzogU2hyYXZhbiBSYW1hbmkgPHNyYW1hbmlAbWVsbGFub3guY29tPg0K
PiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVhZC5vcmc+OyBEYXJyZW4gSGFydA0K
PiA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBtZWxsYW5v
eC5jb20+OyBKaXJpIFBpcmtvDQo+IDxqaXJpQG1lbGxhbm94LmNvbT47IFBsYXRmb3JtIERyaXZl
ciA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxXSBwbGF0Zm9ybS9tZWxsYW5veDogbWx4YmYtcG1jOiBBZGQgTWVsbGFub3gg
Qmx1ZUZpZWxkDQo+IFBNQyBkcml2ZXINCj4gDQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDEy
OjAyIFBNIFNocmF2YW4gS3VtYXIgUmFtYW5pDQo+IDxzcmFtYW5pQG1lbGxhbm94LmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGUgcGVyZm9ybWFuY2UgbW9kdWxlcyBpbiBCbHVlRmllbGQgYXJlIHBy
ZXNlbnQgaW4gc2V2ZXJhbCBoYXJkd2FyZQ0KPiA+IGJsb2NrcyBhbmQgZWFjaCBibG9jayBwcm92
aWRlcyBhY2Nlc3MgdG8gdGhlc2Ugc3RhdHMgZWl0aGVyIHRocm91Z2gNCj4gPiBjb3VudGVycyB0
aGF0IGNhbiBiZSBwcm9ncmFtbWVkIHRvIG1vbml0b3Igc3VwcG9ydGVkIGV2ZW50cyBvciB0aHJv
dWdoDQo+ID4gbWVtb3J5LW1hcHBlZCByZWdpc3RlcnMgdGhhdCBob2xkIHRoZSByZWxldmFudCBp
bmZvcm1hdGlvbi4NCj4gPiBUaGUgaGFyZHdhcmUgYmxvY2tzIHRoYXQgaW5jbHVkZSBhIHBlcmZv
cm1hbmNlIG1vZHVsZSBhcmU6DQo+ID4gICogVGlsZSAoYmxvY2sgY29udGFpbmluZyAyIGNvcmVz
IGFuZCBhIHNoYXJlZCBMMiBjYWNoZSkNCj4gPiAgKiBUUklPIChQQ0llIHJvb3QgY29tcGxleCkN
Cj4gPiAgKiBNU1MgKE1lbW9yeSBTdWItc3lzdGVtIGNvbnRhaW5pbmcgdGhlIE1lbW9yeSBDb250
cm9sbGVyIGFuZCBMMw0KPiA+IGNhY2hlKQ0KPiA+ICAqIEdJQyAoSW50ZXJydXB0IGNvbnRyb2xs
ZXIpDQo+ID4gICogU01NVSAoU3lzdGVtIE1lbW9yeSBNYW5hZ2VtZW50IFVuaXQpIFRoZSBtbHhf
cG1jIGRyaXZlciBwcm92aWRlcw0KPiA+IGFjY2VzcyB0byBhbGwgb2YgdGhlc2UgcGVyZm9ybWFu
Y2UgbW9kdWxlcyB0aHJvdWdoIGEgaHdtb24gc3lzZnMNCj4gPiBpbnRlcmZhY2UuDQo+IA0KPiBK
dXN0IGJyaWVmIGNvbW1lbnRzOg0KPiAtIGNvbnNpZGVyIHRvIHJldmlzaXQgaGVhZGVyIGJsb2Nr
IHRvIHNlZSB3aGF0IGlzIHJlYWxseSBuZWNlc3NhcnkgYW5kIHdoYXQgY2FuDQo+IGJlIGRyb3Bw
ZWQNCj4gLSBhZGQgY29tbWEgdG8gdGhlIGFycmF5cyB3aGVyZSBsYXN0IGxpbmUgaXMgbm90IGEg
dGVybWluYXRpb24NCj4gLSBsb29rIGF0IG1hdGNoX3N0cmluZygpIC8gc3lzZnNfbWF0Y2hfc3Ry
aW5nKCkgQVBJLCBJIHRoaW5rIHRoZXkgY2FuIGJlIHV0aWxpc2VkDQo+IGhlcmUNCj4gLSBVVUlE
IG1hbmlwdWxhdGlvbnMgKGVzcC4gd2l0aCB0aGF0IEdVSURfSU5JVCgpIGFnYWluc3Qgbm9uLWNv
bnN0YW50KSBzZWVtcw0KPiB0b28gbXVjaCwgY29uc2lkZXIgcmVmYWN0b3JpbmcgYW5kIGNsZWFu
aW5nIHVwIHRoZXNlIHBpZWNlcw0KDQpDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBvbiB3aGF0
IGFwcHJvYWNoIHlvdSdkIGxpa2UgbWUgdG8gdGFrZSB3aXRoIHRoZSBVVUlEIG1hbmlwdWxhdGlv
bj8NCkkgdXNlZCB0aGUgc2FtZSBhcHByb2FjaCBhcyBpbiBkcml2ZXJzL3BsYXRmb3JtL21lbGxh
bm94L21seGJmLWJvb3RjdGwuYyB3aGljaCBzZWVtZWQgbGlrZSBhbiBhcHByb3ByaWF0ZSBleGFt
cGxlLg0KQW55IG90aGVyIHBvaW50ZXJzIHdvdWxkIGJlIGhlbHBmdWwuDQoNClRoYW5rcyBmb3Ig
dGhlIGZlZWRiYWNrLiBXaWxsIGFkZHJlc3MgYWxsIHRoZSBvdGhlciBjb21tZW50cyBpbiB2Mi4N
Cg0KUmVnYXJkcywNClNocmF2YW4NCg0KPiAtIHVzZSBrc3Ryb3RvKigpIEFQSSBpbnN0ZWFkIG9m
IHNzY2FuZi4gSXQgaGFzIGEgcmFuZ2UgY2hlY2sNCj4gDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3Qg
UmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
