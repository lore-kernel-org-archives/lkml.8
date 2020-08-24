Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C6F206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgHXPI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:08:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45754 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgHXPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:05:48 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-126-7nFhgKAtOJWwj5eufa76-g-1; Mon, 24 Aug 2020 16:05:14 +0100
X-MC-Unique: 7nFhgKAtOJWwj5eufa76-g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 24 Aug 2020 16:05:13 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 24 Aug 2020 16:05:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guohua Zhong' <zhongguohua1@huawei.com>,
        "paubert@iram.es" <paubert@iram.es>
CC:     "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "wangle6@huawei.com" <wangle6@huawei.com>
Subject: =?utf-8?B?UkU6IFJl77yaUmU6IFtQQVRDSF0gcG93ZXJwYzogRml4IGEgYnVnIGluIF9f?=
 =?utf-8?Q?div64=5F32_if_divisor_is_zero?=
Thread-Topic: =?utf-8?B?UmXvvJpSZTogW1BBVENIXSBwb3dlcnBjOiBGaXggYSBidWcgaW4gX19kaXY2?=
 =?utf-8?Q?4=5F32_if_divisor_is_zero?=
Thread-Index: AQHWehocKoZB4BlfFESHO90JupmxU6lHWu5w
Date:   Mon, 24 Aug 2020 15:05:13 +0000
Message-ID: <c200b38836674bbbb928bf76cbb978f1@AcuMS.aculab.com>
References: <20200822172524.GA5451@lt-gp.iram.es>
 <20200824132539.35972-1-zhongguohua1@huawei.com>
In-Reply-To: <20200824132539.35972-1-zhongguohua1@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VvaHVhIFpob25nDQo+IFNlbnQ6IDI0IEF1Z3VzdCAyMDIwIDE0OjI2DQo+IA0KPiA+
PiA+SW4gZ2VuZXJpYyB2ZXJzaW9uIGluIGxpYi9tYXRoL2RpdjY0LmMsIHRoZXJlIGlzIG5vIGNo
ZWNraW5nIG9mICdiYXNlJw0KPiA+PiA+ZWl0aGVyLg0KPiA+PiA+RG8gd2UgcmVhbGx5IHdhbnQg
dG8gYWRkIHRoaXMgY2hlY2sgaW4gdGhlIHBvd2VycGMgdmVyc2lvbiBvbmx5ID8NCj4gPj4NCj4g
Pj4gPlRoZSBvbmx5IHVzZXIgb2YgX19kaXY2NF8zMigpIGlzIGRvX2RpdigpIGluDQo+ID4+ID5p
bmNsdWRlL2FzbS1nZW5lcmljL2RpdjY0LmguIFdvdWxkbid0IGl0IGJlIGJldHRlciB0byBkbyB0
aGUgY2hlY2sgdGhlcmUgPw0KPiA+Pg0KPiA+PiA+Q2hyaXN0b3BoZQ0KPiA+Pg0KPiA+PiBZZXQs
IEkgaGF2ZSBub3RpY2VkIHRoYXQgdGhlcmUgaXMgbm8gY2hlY2tpbmcgb2YgJ2Jhc2UnIGluIHRo
ZXNlIGZ1bmN0aW9ucy4NCj4gPj4gQnV0IEkgYW0gbm90IHN1cmUgaG93IHRvIGNoZWNrIGlzIGJl
dHRlci5BcyB3ZSBrbm93IHRoYXQgdGhlIHJlc3VsdCBpcw0KPiA+PiB1bmRlZmluZWQgd2hlbiBk
aXZpc29yIGlzIHplcm8uIEl0IG1heWJlIGdvb2QgdG8gcHJpbnQgZXJyb3IgYW5kIGR1bXAgc3Rh
Y2suDQoNCkkgdGhvdWdodCB0aGF0IHRoZSBvbnVzIHdhcyBwdXQgb24gdGhlIGNhbGxlciB0byBh
dm9pZCBkaXZpZGUgYnkgemVyby4NCg0KT24geDg2IGRpdmlkZSBieSB6ZXJvIGNhdXNlcyBhbiBl
eGNlcHRpb24gd2hpY2ggKEknbSBwcmV0dHkgc3VyZSkNCmxlYWRzIHRvIGEgb29wcy9wYW5pYy4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

