Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2302C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CD7206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="arMyY0h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgAMAIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:08:25 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47502 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbgAMAIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:08:25 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D1304891A9;
        Mon, 13 Jan 2020 13:08:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1578874101;
        bh=DUc98AByVyner2V8GExY/rd2Z/R7mWamTeb95Q/WjYY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=arMyY0h90qxS49qk0tOeR1uDG3nnhT310coX4vuiJ4nkWFhvIk2mealFO+ZQJ1nZh
         Xf6UCp5dGjtcvrhl6uAeVNucnha5FC/kAFHArUJiwT8NJVD8D6Tf4x7ARxMeJeFdir
         b5GQ7DcqluR/uve1mB8W3NZpD4ZeO1PEq4DD/Fb7ijZBNcPP7jKf8rwX3w2+7tn4AR
         G2JucYx83IOXmxAhiyCCRKETBuWxdPB/6JlwO4LGvy1+8E1zKVGFBb0mHtkbIIENl7
         wXaDNoraylM8Rr9Apeer1Gwlwpzj/XG7acCGue9Pxq/cBV4dyb2VdQ0WSbo2ccjt8r
         NrCN6LEsk0EPg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e1bb4f50000>; Mon, 13 Jan 2020 13:08:21 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Mon, 13 Jan 2020 13:08:19 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Mon, 13 Jan 2020 13:08:19 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Added attenuator bypass support
Thread-Topic: [PATCH v2 2/2] hwmon: (adt7475) Added attenuator bypass support
Thread-Index: AQHVyaWPG3VSEsacPU68Y58jOBbOuQ==
Date:   Mon, 13 Jan 2020 00:08:19 +0000
Message-ID: <c5e9118cf36735602cfd01a64076b98ab0ad3802.camel@alliedtelesis.co.nz>
References: <20191219033213.30364-1-logan.shaw@alliedtelesis.co.nz>
         <20191219033213.30364-3-logan.shaw@alliedtelesis.co.nz>
         <e88b029b-dbb3-e423-5c37-0917d7716b66@roeck-us.net>
In-Reply-To: <e88b029b-dbb3-e423-5c37-0917d7716b66@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:d1a1:ea74:6baa:5aa3]
Content-Type: text/plain; charset="utf-8"
Content-ID: <72C65DAAC37BA2428B6C8CDCD4EDA87F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KENDIFJvYiBhbmQgZGV2aWNldHJlZSkNCg0KT24gV2VkLCAyMDE5LTEyLTE4IGF0IDE5OjUzIC0w
ODAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiAxMi8xOC8xOSA3OjMyIFBNLCBMb2dhbiBT
aGF3IHdyb3RlOg0KPiA+IEFkZGVkIGEgbmV3IGZpbGUgZG9jdW1lbnRpbmcgdGhlIGFkdDc0NzUg
ZGV2aWNldHJlZSBhbmQgYWRkZWQgdGhlIGZpdmUNCj4gPiBuZXcgcHJvcGVydGllcyB0byBpdC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBTaGF3IDxsb2dhbi5zaGF3QGFsbGllZHRl
bGVzaXMuY28ubno+DQo+ID4gLS0tDQo+ID4gLS0tDQo+ID4gICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9od21vbi9hZHQ3NDc1LnR4dCAgICAgfCAzNSArKysrKysrKysrKysrKysrKysrDQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnR4dA0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aHdtb24vYWR0NzQ3NS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdt
b24vYWR0NzQ3NS50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAwMDAwMC4uMzg4ZGQ3MThhMjQ2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnR4dA0KDQpUaGVyZSdz
IGFuIGVmZm9ydCB1bmRlcndheSB0byBjb252ZXJ0IHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyB0
byB5YW1sDQpzbyBpdCdkIGJlIGJldHRlciBmb3IgbmV3IGJpbmRpbmdzIHRvIHN0YXJ0IG9mZiB0
aGF0IHdheS4gSXQgc2hvdWxkIGJlDQpyZWxhdGl2ZWx5IHN0cmFpZ2h0IGZvcndhcmQsIHRoZXJl
IGFyZSBhIGNvdXBsZSBvZiBleGlzdGluZyBleGFtcGxlcw0KaW4gIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9od21vbi8gdG8gZm9sbG93Lg0KDQpBbHNvIHRoZXJlIGlzIGFuIGV4
aXN0aW5nIGVudHJ5IGluDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlh
bC1kZXZpY2VzLnlhbWwgZm9yIHRoZSBhZHQ3NDc1DQphbmQgZnJpZW5kcyB0aGF0IHNob3VsZCBi
ZSByZW1vdmVkIGFzIHBhcnQgb2YgdGhlIHBhdGNoIHRoYXQgYWRkcyB0aGUNCm5ldyBiaW5kaW5n
Lg0KDQo+ID4gQEAgLTAsMCArMSwzNSBAQA0KPiA+ICsqQURUNzQ3NSBod21vbiBzZW5zb3IuDQo+
ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICstIGNvbXBhdGlibGU6IE9uZSBv
Zg0KPiA+ICsJImFkaSxhZHQ3NDczIg0KPiA+ICsJImFkaSxhZHQ3NDc1Ig0KPiA+ICsJImFkaSxh
ZHQ3NDc2Ig0KPiA+ICsJImFkaSxhZHQ3NDkwIg0KPiA+ICsNCj4gPiArLSByZWc6IEkyQyBhZGRy
ZXNzDQo+ID4gKw0KPiA+ICtvcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICsNCj4gPiArLSBieXBh
c3MtYXR0ZW51YXRvci1hbGw6IENvbmZpZ3VyZXMgYnlwYXNzaW5nIGFsbCB2b2x0YWdlIGlucHV0
IGF0dGVudWF0b3JzLg0KPiA+ICsJVGhpcyBpcyBvbmx5IHN1cHBvcnRlZCBvbiB0aGUgQURUNzQ3
NiBhbmQgQURUNzQ5MCwgdGhpcyBwcm9wZXJ0eSBkb2VzDQo+ID4gKwlub3RoaW5nIG9uIG90aGVy
IGNoaXBzLg0KDQpJIGRvbid0IGtub3cgdGhhdCB0aGVyZSdzIGFueSBwb2ludCBpbiBzdXBwb3J0
aW5nIGJ5cGFzcy1hdHRlbnVhdG9yLWFsbCANCmV2ZW4gdGhvdWdoIHRoZSBhZHQ3NDc1IGNhbiBz
dXBwb3J0IGl0IGNvbmZpZ3VyaW5nIHBlciBWSU4gc2VlbXMgbW9yZQ0KdXNlZnVsLg0KDQo+IA0K
PiBCb3RoIGFkdDc0NzMgYW5kIGFkdDc0NzUgZG8gc3VwcG9ydCBjb25maWd1cmluZyBhbiBhdHRl
bnVhdG9yIG9uIFZDQ1ANCj4gDQo+ID4gKwkJcHJvcGVydHkgcHJlc2VudDogQml0IHNldCB0byBi
eXBhc3MgYWxsIHZvbHRhZ2UgaW5wdXQgYXR0ZW51YXRvcnMuDQo+ID4gKwkJcHJvcGVydHkgYWJz
ZW50OiBSZWdpc3RlcnMgbGVmdCB1bmNoYW5nZWQuDQo+ID4gKw0KPiA+ICstIGJ5cGFzcy1hdHRl
bnVhdG9yLWlueDogQ29uZmlndXJlcyBieXBhc3NpbmcgaW5kaXZpZHVhbCB2b2x0YWdlIGlucHV0
DQo+ID4gKwlhdHRlbnVhdG9ycywgd2hlcmUgeCBpcyBhbiBpbnRlZ2VyIGZyb20gdGhlIHNldCB7
MCwgMSwgMywgNH0uIFRoaXMNCj4gPiArCWlzIG9ubHkgc3VwcG9ydGVkIG9uIHRoZSBBRFQ3NDc2
IGFuZCBBRFQ3NDkwLCB0aGlzIHByb3BlcnR5IGRvZXMgbm90aGluZw0KPiA+ICsJb24gb3RoZXIg
Y2hpcHMuDQo+ID4gKwkJcHJvcGVydHkgcHJlc2VudDogQml0IHNldCB0byBieXBhc3Mgc3BlY2lm
aWMgdm9sdGFnZSBpbnB1dCBhdHRlbnVhdG9yDQo+ID4gKwkJCWZvciB2b2x0YWdlIGlucHV0IHgu
DQo+ID4gKwkJcHJvcGVydHkgYWJzZW50OiBSZWdpc3RlcnMgbGVmdCB1bmNoYW5nZWQuDQo+ID4g
Kw0KPiANCj4gVGhpcyBpcyBpbnRlcmVzdGluZy4gSXQgZXNzZW50aWFsbHkgbWVhbnMgInJldGFp
biBjb25maWd1cmF0aW9uIGZyb20gUk9NDQo+IE1vbml0b3IiLCBidXQgbGVhdmVzIG5vIG1lYW5z
IHRvIF9kaXNhYmxlXyB0aGUgYnlwYXNzLg0KPiANCg0KRm9yIG91ciBzeXN0ZW1zIExpbnV4IGlz
IGdlbmVyYWxseSB0aGUgUk9NIG1vbml0b3IsIGF0IGxlYXN0IGFzIGZhciBhcw0KdGhlIGh3bW9u
IGRldmljZXMgYXJlIGNvbmNlcm5lZC4gT3ZlcnJpZGluZyB0aGUgSFcgZGVmYXVsdCBtYWtlcyBz
ZW5zZQ0KZm9yIHRoYXQgY2FzZS4NCg0KRG8gd2Ugd2FudCB0aGUgYWJpbGl0eSB0byBvdmVycmlk
ZSB0aGUgY29uZmlndXJhdGlvbiBmcm9tIHRoZSBST00/IEl0DQpzaG91bGQgYmUgZWFzaWx5IGRv
YWJsZSBieSB1c2luZyBhbiBpbnRlZ2VyIHByb3BlcnR5IGluc3RlYWQgb2YgYQ0KYm9vbGVhbi4N
Cg0KPiA+ICtFeGFtcGxlOg0KPiA+ICsNCj4gPiAraHdtb25AMmUgew0KPiA+ICsJY29tcGF0aWJs
ZSA9ICJhZGksYWR0NzQ3NSI7DQo+ID4gKwlyZWcgPSA8MHgyZT47DQo+ID4gKwlieXBhc3MtYXR0
ZW51YXRvci1hbGw7DQo+ID4gKwlieXBhc3MtYXR0ZW51YXRvci1pbjE7DQo+IA0KPiBXaGF0IHdv
dWxkIGJlIHRoZSBwdXJwb3NlIG9mIHNwZWNpZnlpbmcgYm90aCBhbGwgYW5kIGluMSA/DQo+IA0K
PiA+ICt9Ow0KPiA+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiA+IA0KPiANCj4gDQo=
