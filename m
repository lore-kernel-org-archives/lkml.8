Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D72C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 04:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15323214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 04:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="z61qDmEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA2Ear (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 23:30:47 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44982 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgA2Ear (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 23:30:47 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BBAC8891AD;
        Wed, 29 Jan 2020 17:30:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580272243;
        bh=EvrHikCnKPOGhV8o+Zxqajpo6c4UAMFR8e8x5+neHNE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=z61qDmEhA71mTsq0GI99T5TKqaO8fUbSL8CuTHzJpyRbH+jRogQlvf8zyu7q1b6xI
         8KnIBZaIOPLmcEz6A268YpVhfVlqcRwU+A+oXBORt4PM9HlQU9tnhQkVS43eTQDBsJ
         yLhVd9qkG+l8yaZQFa4qbFXlh49wiZE/6/kYQ+kzlPc7oOcBUgZ4Gu20f47M73K/+r
         G5Zy3Cmbr8N5veSrpFenC1rYuvtMKoJdgM+SXcwm/Tkqnktj8KYnSENJWIDA3L0FaJ
         NnseRgzuKwj5rx4L5MwnHfsbTNQhGvTAPnOWgkRM+aPHdQQ5UsMLNvNAKVOImwYJ96
         cCuM98FI7jUYQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e310a730000>; Wed, 29 Jan 2020 17:30:43 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan 2020 17:30:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Wed, 29 Jan 2020 17:30:40 +1300
From:   Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Thread-Topic: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Thread-Index: AQHV1JVtwGwHv/A/qEeLHCGfFZLcOaf9zzQAgAJnaoA=
Date:   Wed, 29 Jan 2020 04:30:39 +0000
Message-ID: <b1d669567b5f9f00dfb5d6dab89262f68c5523f1.camel@alliedtelesis.co.nz>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
         <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
         <20200127154800.GA7023@bogus>
In-Reply-To: <20200127154800.GA7023@bogus>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:25:ae22:bff:fe77:dd09]
Content-Type: text/plain; charset="utf-8"
Content-ID: <11C16659AB712A42901761CD37A8F60B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTI3IGF0IDA5OjQ4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBKYW4gMjcsIDIwMjAgYXQgMTE6MTA6MTRBTSArMTMwMCwgTG9nYW4gU2hhdyB3cm90
ZToNCj4gPiBBZGRlZCBhIG5ldyBmaWxlIGRvY3VtZW50aW5nIHRoZSBhZHQ3NDc1IGRldmljZXRy
ZWUgYW5kIGFkZGVkIHRoZQ0KPiA+IGZvdXINCj4gPiBuZXcgcHJvcGVydGllcyB0byBpdC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBTaGF3IDxsb2dhbi5zaGF3QGFsbGllZHRlbGVz
aXMuY28ubno+DQo+ID4gLS0tDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2h3bW9uL2FkdDc0NzUueWFtbCAgICB8IDk1DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55
YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9od21vbi9hZHQ3NDc1LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9od21vbi9hZHQ3NDc1LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uNDUwZGE1ZTY2ZTA3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1Lnlh
bWwNCj4gPiBAQCAtMCwwICsxLDk1IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjANCj4gDQo+IER1YWwgbGljZW5zZSBuZXcgYmluZGluZ3MgcGxlYXNlOg0KPiANCj4g
KEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+IA0KPiA+ICslWUFNTCAxLjINCj4gPiAr
LS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYWR0NzQ3NS55YW1s
Iw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUu
eWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBBRFQ3NDc1IGh3bW9uIHNlbnNvcg0KPiA+ICsNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBKZWFuIERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuY29t
Pg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBUaGUgQURUNzQ3MywgQURUNzQ3
NSwgQURUNzQ3NiwgYW5kIEFEVDc0OTAgYXJlIHRoZXJtYWwgbW9uaXRvcnMNCj4gPiBhbmQgbXVs
dGlwbGUNCj4gPiArICBQV04gZmFuIGNvbnRyb2xsZXJzLg0KPiA+ICsNCj4gPiArICBUaGV5IHN1
cHBvcnQgbW9uaXRvcmluZyBhbmQgY29udHJvbGxpbmcgdXAgdG8gZm91ciBmYW5zICh0aGUNCj4g
PiBBRFQ3NDkwIGNhbiBvbmx5DQo+ID4gKyAgY29udHJvbCB1cCB0byB0aHJlZSkuIFRoZXkgc3Vw
cG9ydCByZWFkaW5nIGEgc2luZ2xlIG9uIGNoaXANCj4gPiB0ZW1wZXJhdHVyZQ0KPiA+ICsgIHNl
bnNvciBhbmQgdHdvIG9mZiBjaGlwIHRlbXBlcmF0dXJlIHNlbnNvcnMgKHRoZSBBRFQ3NDkwDQo+
ID4gYWRkaXRpb25hbGx5DQo+ID4gKyAgc3VwcG9ydHMgbWVhc3VyaW5nIHVwIHRvIHRocmVlIGN1
cnJlbnQgZXh0ZXJuYWwgdGVtcGVyYXR1cmUNCj4gPiBzZW5zb3JzIHdpdGgNCj4gPiArICBzZXJp
ZXMgcmVzaXN0YW5jZSBjYW5jZWxsYXRpb24gKFNSQykpLg0KPiA+ICsNCj4gPiArICBEYXRhc2hl
ZXRzOg0KPiA+ICsgIGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vcHViL0NvbGxhdGVyYWwvQURUNzQ3
My1ELlBERg0KPiA+ICsgIGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vcHViL0NvbGxhdGVyYWwvQURU
NzQ3NS1ELlBERg0KPiA+ICsgIGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vcHViL0NvbGxhdGVyYWwv
QURUNzQ3Ni1ELlBERg0KPiA+ICsgIGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vcHViL0NvbGxhdGVy
YWwvQURUNzQ5MC1ELlBERg0KPiA+ICsNCj4gPiArICBEZXNjcmlwdGlvbiB0YWtlbiBmcm9tIG9t
c2VtaWNvbmR1Y3RvcnMgc3BlY2lmaWNhdGlvbiBzaGVldHMsDQo+ID4gd2l0aCBtaW5vcg0KPiAN
Cj4gb21zZW1pPw0KPiAgXg0KPiANCj4gPiArICByZXBocmFzaW5nLg0KPiA+ICsNCj4gPiArcHJv
cGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAg
LSBhZGksYWR0NzQ3Mw0KPiA+ICsgICAgICAtIGFkaSxhZHQ3NDc1DQo+ID4gKyAgICAgIC0gYWRp
LGFkdDc0NzYNCj4gPiArICAgICAgLSBhZGksYWR0NzQ5MA0KPiA+ICsNCj4gPiArICByZWc6DQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBieXBhc3MtYXR0ZW51YXRvci1pbjA6
DQo+IA0KPiBOZWVkcyBhIHZlbmRvciBwcmVmaXggYW5kIGEgdHlwZSByZWYuIA0KDQpBZGkgKEFu
YWxvZyBEZXZpY2VzKSBzb2xkIHRoZSBBRFQgcHJvZHVjdCBsaW5lIChhbW9uZ3N0IG90aGVyIHRo
aW5ncykNCnRvIE9uIFNlbWljb25kdWN0b3IuIEFzIGNoYW5naW5nIHRoZSB2ZW5kb3Igb2YgdGhl
c2UgY2hpcHMgKGluIGNvZGUpDQp3b3VsZCBicmVhayBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSBz
aG91bGQgd2Uga2VlcCB0aGUgdmVuZG9yIGFzIGFkaT8NCg0KVG8gY29uZmlybSwgd291bGQgdGhp
cyBtYWtlIHRoZSBwcm9wZXJ0eSAiYWRpLGFkdDc0NzYsYnlwYXNzLQ0KYXR0ZW51YXRvci1pbjAi
Pw0KDQpTbyB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggcGF0dGVyblByb3BlcnRpZXMgeW91IHdv
dWxkIGVuZCB1cCB3aXRoDQpzb21ldGhpbmcgbGlrZToNCg0KImFkaSwoYWR0NzQ3M3xhZHQ3NDc1
fGFkdDc0NzZ8YWR0NzQ5MCksYnlwYXNzLWF0dGVudWF0b3ItaW5bMDEzNF0iDQoNCj4gDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBDb25maWd1cmVzIGJ5cGFzc2luZyB0aGUg
aW5kaXZpZHVhbCB2b2x0YWdlIGlucHV0DQo+ID4gKyAgICAgIGF0dGVudWF0b3IsIG9uIGluMC4g
VGhpcyBpcyBzdXBwb3J0ZWQgb24gdGhlIEFEVDc0NzYgYW5kDQo+ID4gQURUNzQ5MC4NCj4gPiAr
ICAgICAgSWYgc2V0IHRvIGEgbm9uLXplcm8gaW50ZWdlciB0aGUgYXR0ZW51YXRvciBpcyBieXBh
c3NlZCwgaWYNCj4gPiBzZXQgdG8NCj4gPiArICAgICAgemVybyB0aGUgYXR0ZW51YXRvciBpcyBu
b3QgYnlwYXNzZWQuIElmIHRoZSBwcm9wZXJ0eSBpcw0KPiA+IGFic2VudCB0aGVuDQo+ID4gKyAg
ICAgIHRoZSBjb25maWcgcmVnaXN0ZXIgaXMgbm90IG1vZGlmaWVkLg0KPiANCj4gU291bmRzIGxp
a2UgdGhpcyBjb3VsZCBiZSBib29sZWFuPyBJZiBub3QsIGRlZmluZSBhIHNjaGVtYSBmb3Igd2hh
dA0KPiBhcmUgDQo+IHZhbGlkIHZhbHVlcy4NCj4gDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArICBieXBhc3MtYXR0ZW51YXRvci1pbjE6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjog
fA0KPiA+ICsgICAgICBDb25maWd1cmVzIGJ5cGFzc2luZyB0aGUgaW5kaXZpZHVhbCB2b2x0YWdl
IGlucHV0DQo+ID4gKyAgICAgIGF0dGVudWF0b3IsIG9uIGluMS4gVGhpcyBpcyBzdXBwb3J0ZWQg
b24gdGhlIEFEVDc0NzMsDQo+ID4gQURUNzQ3NSwNCj4gPiArICAgICAgQURUNzQ3NiBhbmQgQURU
NzQ5MC4gSWYgc2V0IHRvIGEgbm9uLXplcm8gaW50ZWdlciB0aGUNCj4gPiBhdHRlbnVhdG9yDQo+
ID4gKyAgICAgIGlzIGJ5cGFzc2VkLCBpZiBzZXQgdG8gemVybyB0aGUgYXR0ZW51YXRvciBpcyBu
b3QgYnlwYXNzZWQuDQo+ID4gSWYgdGhlDQo+ID4gKyAgICAgIHByb3BlcnR5IGlzIGFic2VudCB0
aGVuIHRoZSBjb25maWcgcmVnaXN0ZXIgaXMgbm90IG1vZGlmaWVkLg0KPiA+ICsgICAgbWF4SXRl
bXM6IDENCj4gPiArDQo+ID4gKyAgYnlwYXNzLWF0dGVudWF0b3ItaW4zOg0KPiA+ICsgICAgZGVz
Y3JpcHRpb246IHwNCj4gPiArICAgICAgQ29uZmlndXJlcyBieXBhc3NpbmcgdGhlIGluZGl2aWR1
YWwgdm9sdGFnZSBpbnB1dA0KPiA+ICsgICAgICBhdHRlbnVhdG9yLCBvbiBpbjMuIFRoaXMgaXMg
c3VwcG9ydGVkIG9uIHRoZSBBRFQ3NDc2IGFuZA0KPiA+IEFEVDc0OTAuDQo+ID4gKyAgICAgIElm
IHNldCB0byBhIG5vbi16ZXJvIGludGVnZXIgdGhlIGF0dGVudWF0b3IgaXMgYnlwYXNzZWQsIGlm
DQo+ID4gc2V0IHRvDQo+ID4gKyAgICAgIHplcm8gdGhlIGF0dGVudWF0b3IgaXMgbm90IGJ5cGFz
c2VkLiBJZiB0aGUgcHJvcGVydHkgaXMNCj4gPiBhYnNlbnQgdGhlbg0KPiA+ICsgICAgICB0aGUg
Y29uZmlnIHJlZ2lzdGVyIGlzIG5vdCBtb2RpZmllZC4NCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+
ID4gKw0KPiA+ICsgIGJ5cGFzcy1hdHRlbnVhdG9yLWluNDoNCj4gDQo+IFRoZXNlIDQgY291bGQg
YmUgYSBzaW5nbGUgZW50cnkgdW5kZXIgcGF0dGVyblByb3BlcnRpZXMuDQo+IA0KPiANCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIENvbmZpZ3VyZXMgYnlwYXNzaW5nIHRoZSBp
bmRpdmlkdWFsIHZvbHRhZ2UgaW5wdXQNCj4gPiArICAgICAgYXR0ZW51YXRvciwgb24gaW40LiBU
aGlzIGlzIHN1cHBvcnRlZCBvbiB0aGUgQURUNzQ3NiBhbmQNCj4gPiBBRFQ3NDkwLg0KPiA+ICsg
ICAgICBJZiBzZXQgdG8gYSBub24temVybyBpbnRlZ2VyIHRoZSBhdHRlbnVhdG9yIGlzIGJ5cGFz
c2VkLCBpZg0KPiA+IHNldCB0bw0KPiA+ICsgICAgICB6ZXJvIHRoZSBhdHRlbnVhdG9yIGlzIG5v
dCBieXBhc3NlZC4gSWYgdGhlIHByb3BlcnR5IGlzDQo+ID4gYWJzZW50IHRoZW4NCj4gPiArICAg
ICAgdGhlIGNvbmZpZyByZWdpc3RlciBpcyBub3QgbW9kaWZpZWQuDQo+ID4gKyAgICBtYXhJdGVt
czogMQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAg
LSByZWcNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgaTJjIHsN
Cj4gPiArICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICNzaXplLWNlbGxz
ID0gPDA+Ow0KPiA+ICsNCj4gPiArICAgICAgaHdtb25AMmUgew0KPiA+ICsgICAgICAgIGNvbXBh
dGlibGUgPSAiYWRpLGFkdDc0NzYiOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDJlPjsNCj4gPiAr
ICAgICAgICBieXBhc3MtYXR0ZW51YXRvci1pbjAgPSA8MT47DQo+ID4gKyAgICAgICAgYnlwYXNz
LWF0dGVudWF0b3ItaW4xID0gPDA+Ow0KPiA+ICsgICAgICB9Ow0KPiA+ICsgICAgfTsNCj4gPiAr
Li4uDQo+ID4gLS0gDQo+ID4gMi4yNS4wDQo+ID4gDQo=
