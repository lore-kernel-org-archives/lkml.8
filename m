Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C0C33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 03:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2632206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 03:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zBLRHy2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgA3DIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 22:08:02 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46674 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgA3DIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 22:08:01 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1FE88891A9;
        Thu, 30 Jan 2020 16:07:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580353677;
        bh=VwVKeAXGYG/qLeDQHPdbOAovnx1jlVZPO9hTF9Q9Rk4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=zBLRHy2S6BLqsl/6+AQa8s/GgjbMDg8J2fHl2E47O45tLr55mvkDSvQP2a46waBwT
         svDppjxUzEQv6wJzDoCISEYqcyNaSRnvKirXlftWFlSjhQSn4ao8ZuAWaPTVs/18wX
         VeHbGBhKoM9MieKYbsjF+LVOhL9dOAPZYC81b71xS2v6l3sFRbIYWMWFLWDd21TYKz
         4rFGE6x404CiF+HACdIuMJKg/Z40F8V2zqNVKAF9J1Bv0F+QSqckDbwcEKBn/gbJhi
         CjQAzGSRKhwUdvBmW0pzcYHVnJ8SPiU0nNao5XPUZ4Gb9siPvs5u5Y7GQa8e22XXqt
         c9eswVe7xIjKQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e32488d0001>; Thu, 30 Jan 2020 16:07:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Thu, 30 Jan 2020 16:07:56 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Thu, 30 Jan 2020 16:07:56 +1300
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
Thread-Index: AQHV1JVtwGwHv/A/qEeLHCGfFZLcOaf9zzQAgAPiowA=
Date:   Thu, 30 Jan 2020 03:07:56 +0000
Message-ID: <9d4afb3f77e1dea7f050fe32616ca955fb95eaa9.camel@alliedtelesis.co.nz>
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
Content-ID: <922FE763DB5A4E4D853151B7CFC1996E@atlnz.lc>
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
DQo+IA0KPiBOZWVkcyBhIHZlbmRvciBwcmVmaXggYW5kIGEgdHlwZSByZWYuIA0KPiANCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIENvbmZpZ3VyZXMgYnlwYXNzaW5nIHRoZSBp
bmRpdmlkdWFsIHZvbHRhZ2UgaW5wdXQNCj4gPiArICAgICAgYXR0ZW51YXRvciwgb24gaW4wLiBU
aGlzIGlzIHN1cHBvcnRlZCBvbiB0aGUgQURUNzQ3NiBhbmQNCj4gPiBBRFQ3NDkwLg0KPiA+ICsg
ICAgICBJZiBzZXQgdG8gYSBub24temVybyBpbnRlZ2VyIHRoZSBhdHRlbnVhdG9yIGlzIGJ5cGFz
c2VkLCBpZg0KPiA+IHNldCB0bw0KPiA+ICsgICAgICB6ZXJvIHRoZSBhdHRlbnVhdG9yIGlzIG5v
dCBieXBhc3NlZC4gSWYgdGhlIHByb3BlcnR5IGlzDQo+ID4gYWJzZW50IHRoZW4NCj4gPiArICAg
ICAgdGhlIGNvbmZpZyByZWdpc3RlciBpcyBub3QgbW9kaWZpZWQuDQo+IA0KPiBTb3VuZHMgbGlr
ZSB0aGlzIGNvdWxkIGJlIGJvb2xlYW4/IElmIG5vdCwgZGVmaW5lIGEgc2NoZW1hIGZvciB3aGF0
DQo+IGFyZSANCj4gdmFsaWQgdmFsdWVzLg0KDQpCeSBib29sZWFuIGFyZSB5b3UgcmVmZXJyaW5n
IHRvIGEgZHRzIHByb3BlcnR5IHRoYXQgaXMgZXZhbHVhdGVkICh1c2luZw0KZnVuY3Rpb24gb2Zf
cHJvcGVydHlfcmVhZF9ib29sKSBhcyB0cnVlL2ZhbHNlLCBkZXBlbmRpbmcgb24gaXRzDQpwcmVz
ZW5jZT8gRm9yIGV4YW1wbGUgInJlZ3VsYXRvci1hbHdheXMtb24iIGluOg0KL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvcmVndWxhdG9yLnlhbWwgLg0KDQo+IA0K
PiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgYnlwYXNzLWF0dGVudWF0b3ItaW4x
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgQ29uZmlndXJlcyBieXBhc3Np
bmcgdGhlIGluZGl2aWR1YWwgdm9sdGFnZSBpbnB1dA0KPiA+ICsgICAgICBhdHRlbnVhdG9yLCBv
biBpbjEuIFRoaXMgaXMgc3VwcG9ydGVkIG9uIHRoZSBBRFQ3NDczLA0KPiA+IEFEVDc0NzUsDQo+
ID4gKyAgICAgIEFEVDc0NzYgYW5kIEFEVDc0OTAuIElmIHNldCB0byBhIG5vbi16ZXJvIGludGVn
ZXIgdGhlDQo+ID4gYXR0ZW51YXRvcg0KPiA+ICsgICAgICBpcyBieXBhc3NlZCwgaWYgc2V0IHRv
IHplcm8gdGhlIGF0dGVudWF0b3IgaXMgbm90IGJ5cGFzc2VkLg0KPiA+IElmIHRoZQ0KPiA+ICsg
ICAgICBwcm9wZXJ0eSBpcyBhYnNlbnQgdGhlbiB0aGUgY29uZmlnIHJlZ2lzdGVyIGlzIG5vdCBt
b2RpZmllZC4NCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGJ5cGFzcy1hdHRl
bnVhdG9yLWluMzoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIENvbmZpZ3Vy
ZXMgYnlwYXNzaW5nIHRoZSBpbmRpdmlkdWFsIHZvbHRhZ2UgaW5wdXQNCj4gPiArICAgICAgYXR0
ZW51YXRvciwgb24gaW4zLiBUaGlzIGlzIHN1cHBvcnRlZCBvbiB0aGUgQURUNzQ3NiBhbmQNCj4g
PiBBRFQ3NDkwLg0KPiA+ICsgICAgICBJZiBzZXQgdG8gYSBub24temVybyBpbnRlZ2VyIHRoZSBh
dHRlbnVhdG9yIGlzIGJ5cGFzc2VkLCBpZg0KPiA+IHNldCB0bw0KPiA+ICsgICAgICB6ZXJvIHRo
ZSBhdHRlbnVhdG9yIGlzIG5vdCBieXBhc3NlZC4gSWYgdGhlIHByb3BlcnR5IGlzDQo+ID4gYWJz
ZW50IHRoZW4NCj4gPiArICAgICAgdGhlIGNvbmZpZyByZWdpc3RlciBpcyBub3QgbW9kaWZpZWQu
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBieXBhc3MtYXR0ZW51YXRvci1p
bjQ6DQo+IA0KPiBUaGVzZSA0IGNvdWxkIGJlIGEgc2luZ2xlIGVudHJ5IHVuZGVyIHBhdHRlcm5Q
cm9wZXJ0aWVzLg0KPiANCj4gDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBD
b25maWd1cmVzIGJ5cGFzc2luZyB0aGUgaW5kaXZpZHVhbCB2b2x0YWdlIGlucHV0DQo+ID4gKyAg
ICAgIGF0dGVudWF0b3IsIG9uIGluNC4gVGhpcyBpcyBzdXBwb3J0ZWQgb24gdGhlIEFEVDc0NzYg
YW5kDQo+ID4gQURUNzQ5MC4NCj4gPiArICAgICAgSWYgc2V0IHRvIGEgbm9uLXplcm8gaW50ZWdl
ciB0aGUgYXR0ZW51YXRvciBpcyBieXBhc3NlZCwgaWYNCj4gPiBzZXQgdG8NCj4gPiArICAgICAg
emVybyB0aGUgYXR0ZW51YXRvciBpcyBub3QgYnlwYXNzZWQuIElmIHRoZSBwcm9wZXJ0eSBpcw0K
PiA+IGFic2VudCB0aGVuDQo+ID4gKyAgICAgIHRoZSBjb25maWcgcmVnaXN0ZXIgaXMgbm90IG1v
ZGlmaWVkLg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+
ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4g
PiArICAtIHwNCj4gPiArICAgIGkyYyB7DQo+ID4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KPiA+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKyAgICAgIGh3bW9u
QDJlIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImFkaSxhZHQ3NDc2IjsNCj4gPiArICAg
ICAgICByZWcgPSA8MHgyZT47DQo+ID4gKyAgICAgICAgYnlwYXNzLWF0dGVudWF0b3ItaW4wID0g
PDE+Ow0KPiA+ICsgICAgICAgIGJ5cGFzcy1hdHRlbnVhdG9yLWluMSA9IDwwPjsNCj4gPiArICAg
ICAgfTsNCj4gPiArICAgIH07DQo+ID4gKy4uLg0KPiA+IC0tIA0KPiA+IDIuMjUuMA0KPiA+IA0K
