Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D44C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD4121D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xe2V/al6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgIJVOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:14:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49506 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIJVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:10:48 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5663C891B0;
        Fri, 11 Sep 2020 09:10:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599772240;
        bh=ZOR2FkHMAmV06tVsK4jL8Y9czeowezeyErC8UsDyzJA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=xe2V/al6Axmpx6SCcm+LDwH/ZblGhw90gYv/8QtJp3H8w8w4qfo5STvWl1RD2Ucuc
         UPbPKf11mCQ3RPcpfBqaxgFvU2KwoIleFcqjUkJekDJsamwPhaJx9lqZMW19oxzHSi
         4Yy8nUAM5UvcKhH5F2CQGKVwBK5FImsYWepEWl+EUXPDvZwp8mMx5xyGzJ61cnozi9
         Rfmid+YoiHp/RN0EbL3sqFstxa46yh5DnLqFASEdHQZQ6jmjsBPY5tmoRTxLihloB9
         x5/2Kj9bm2EeQdTWpeDcDO+iNzHxfk/RyHD1ZYQ8PJ81gz0khwe9rHlunncpSIl04d
         B7bwj/BOPxyFQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5a964e0001>; Fri, 11 Sep 2020 09:10:38 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 11 Sep 2020 09:10:40 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Fri, 11 Sep 2020 09:10:40 +1200
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: ohci: Default to per-port over-current protection
Thread-Topic: [PATCH] usb: ohci: Default to per-port over-current protection
Thread-Index: AQHWhl1fdub8noz43U2gfYoH/UQ9C6lfjryAgAIJCAA=
Date:   Thu, 10 Sep 2020 21:10:39 +0000
Message-ID: <26e5ca85dc566b1fa9b11d07c0d70cac1573525e.camel@alliedtelesis.co.nz>
References: <20200909035734.22463-1-hamish.martin@alliedtelesis.co.nz>
         <20200909140547.GB817244@rowland.harvard.edu>
In-Reply-To: <20200909140547.GB817244@rowland.harvard.edu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:24:31e3:fe43:144f:ed22]
Content-Type: text/plain; charset="utf-8"
Content-ID: <493841997D548246AD94ABB4D9CEE196@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTA5IGF0IDEwOjA1IC0wNDAwLCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiBP
biBXZWQsIFNlcCAwOSwgMjAyMCBhdCAwMzo1NzozNFBNICsxMjAwLCBIYW1pc2ggTWFydGluIHdy
b3RlOg0KPiA+IFNvbWUgaW50ZWdyYXRlZCBPSENJIGNvbnRyb2xsZXIgaHVicyBkbyBub3QgZXhw
b3NlIGFsbCBwb3J0cyBvZiB0aGUNCj4gPiBodWINCj4gPiB0byBwaW5zIG9uIHRoZSBTb0MuIElu
IHNvbWUgY2FzZXMgdGhlIHVuY29ubmVjdGVkIHBvcnRzIGdlbmVyYXRlDQo+ID4gc3B1cmlvdXMg
b3Zlci1jdXJyZW50IGV2ZW50cy4gRm9yIGV4YW1wbGUgdGhlIEJyb2FkY29tIDU2MDYwL1Jhbmdl
cg0KPiA+IDIgU29DDQo+ID4gY29udGFpbnMgYSBub21pbmFsbHkgMyBwb3J0IGh1YiBidXQgb25s
eSB0aGUgZmlyc3QgcG9ydCBpcyB3aXJlZC4NCj4gPiANCj4gPiBEZWZhdWx0IGJlaGF2aW91ciBm
b3Igb2hjaS1wbGF0Zm9ybSBkcml2ZXIgaXMgdG8gdXNlIGdsb2JhbCBvdmVyLQ0KPiA+IGN1cnJl
bnQNCj4gPiBwcm90ZWN0aW9uIG1vZGUgKEFLQSAiZ2FuZ2VkIikuIFRoaXMgbGVhZHMgdG8gdGhl
IHNwdXJpb3VzIG92ZXItDQo+ID4gY3VycmVudA0KPiA+IGV2ZW50cyBhZmZlY3RpbmcgYWxsIHBv
cnRzIGluIHRoZSBodWIuDQo+ID4gDQo+ID4gV2Ugbm93IGFsdGVyIHRoZSBkZWZhdWx0IHRvIHVz
ZSBwZXItcG9ydCBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbi4NCj4gPiANCj4gPiBUaGlzIHBhdGNo
IHJlc3VsdHMgaW4gdGhlIGZvbGxvd2luZyBjb25maWd1cmF0aW9uIGNoYW5nZXMgZGVwZW5kaW5n
DQo+ID4gb24gcXVpcmtzOg0KPiA+IC0gRm9yIHF1aXJrIE9IQ0lfUVVJUktfU1VQRVJJTyBubyBj
aGFuZ2VzLiBUaGVzZSBzeXN0ZW1zIHJlbWFpbiBzZXQNCj4gPiB1cA0KPiA+ICAgZm9yIGdhbmdl
ZCBwb3dlciBzd2l0Y2hpbmcgYW5kIG5vIG92ZXItY3VycmVudCBwcm90ZWN0aW9uLg0KPiANCj4g
SG93IGFib3V0IGNoYW5naW5nIHRoZSBxdWlyayBuYW1lIHRvIHNvbWV0aGluZyBtb3JlIG1lYW5p
bmdmdWwsIHN1Y2gNCj4gYXMgDQo+IE9IQ0lfUVVJUktfR0FOR0VEX1BPV0VSX05PX09WRVJDVVJS
RU5UPw0KSSdsbCBsb29rIGF0IHRoYXQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBsYXRlci4gVGhlIGNv
ZGUgSSdtIG1vZGlmeWluZw0Kc2VlbXMgdG8gYmUgY2xvbmVkIGluIHZhcmlvdXMgZHJpdmVycyBz
byBwZXJoYXBzIHRoYXQgbmVlZHMgdG8gYmUNCmNlbnRyYWxpc2VkIGFzIHRoZSBuZXh0IHN0ZXA/
IFNlZSByZWZzIHRvIE9IQ0lfUVVJUktfU1VQRVJJTyBpbiB1MTMyLQ0KaGNkLmMgYW5kIGZ0ZGkt
ZWxhbi5jLg0KDQo+IA0KPiA+IC0gRm9yIHF1aXJrIE9IQ0lfUVVJUktfQU1ENzU2IG9yIE9IQ0lf
UVVJUktfSFVCX1BPV0VSIHBvd2VyDQo+ID4gc3dpdGNoaW5nDQo+ID4gICByZW1haW5zIGF0IG5v
bmUsIHdoaWxlIG92ZXItY3VycmVudCBwcm90ZWN0aW9uIGlzIG5vdyBndWFyYW50ZWVkDQo+ID4g
dG8gYmUNCj4gPiAgIHNldCB0byBwZXItcG9ydCByYXRoZXIgdGhhbiB0aGUgcHJldmlvdXMgYmVo
YXZpb3VyIHdoZXJlIGl0IHdhcw0KPiA+IGVpdGhlcg0KPiA+ICAgbm9uZSBvciBnbG9iYWwgb3Zl
ci1jdXJyZW50IHByb3RlY3Rpb24gZGVwZW5kaW5nIG9uIHRoZSB2YWx1ZSBhdA0KPiA+ICAgZnVu
Y3Rpb24gZW50cnkuDQo+IA0KPiBBbHNvIGNvbnNpZGVyIHJlbmFtaW5nIE9IQ0lfUVVJUktfSFVC
X1BPV0VSIHRvIHNvbWV0aGluZyBsaWtlIA0KPiBPSENJX1FVSVJLX1BPUlRfUE9XRVJfQUxXQVlT
X09OLg0KRGl0dG8gdGhlIGFib3ZlIGNvbW1lbnQuDQoNCj4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBB
bGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhhbWlzaCBNYXJ0aW4gPGhhbWlzaC5tYXJ0aW5AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC9vaGNpLWhjZC5jIHwgMTcgKysrKysrKysrKystLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYyBiL2Ry
aXZlcnMvdXNiL2hvc3Qvb2hjaS0NCj4gPiBoY2QuYw0KPiA+IGluZGV4IGRkMzdlNzdkYWUwMC4u
OGFiODFmNmFiMTUwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2Qu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYw0KPiA+IEBAIC02NzMsMjAg
KzY3MywyNSBAQCBzdGF0aWMgaW50IG9oY2lfcnVuIChzdHJ1Y3Qgb2hjaV9oY2QgKm9oY2kpDQo+
ID4gIA0KPiA+ICAJLyogaGFuZGxlIHJvb3QgaHViIGluaXQgcXVpcmtzIC4uLiAqLw0KPiA+ICAJ
dmFsID0gcm9vdGh1Yl9hIChvaGNpKTsNCj4gPiAtCXZhbCAmPSB+KFJIX0FfUFNNIHwgUkhfQV9P
Q1BNKTsNCj4gPiArCS8qIENvbmZpZ3VyZSBmb3IgcGVyLXBvcnQgb3Zlci1jdXJyZW50IHByb3Rl
Y3Rpb24gYnkgZGVmYXVsdCAqLw0KPiA+ICsJdmFsICY9IH5SSF9BX05PQ1A7DQo+ID4gKwl2YWwg
fD0gUkhfQV9PQ1BNOw0KPiA+ICAJaWYgKG9oY2ktPmZsYWdzICYgT0hDSV9RVUlSS19TVVBFUklP
KSB7DQo+ID4gLQkJLyogTlNDIDg3NTYwIGFuZCBtYXliZSBvdGhlcnMgKi8NCj4gPiArCQkvKiBO
U0MgODc1NjAgYW5kIG1heWJlIG90aGVycy4NCj4gPiArCQkgKiBHYW5nZWQgcG93ZXIgc3dpdGNo
aW5nLCBubyBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbi4NCj4gPiArCQkgKi8NCj4gPiAgCQl2YWwg
fD0gUkhfQV9OT0NQOw0KPiA+IC0JCXZhbCAmPSB+KFJIX0FfUE9UUEdUIHwgUkhfQV9OUFMpOw0K
PiA+IC0JCW9oY2lfd3JpdGVsIChvaGNpLCB2YWwsICZvaGNpLT5yZWdzLT5yb290aHViLmEpOw0K
PiA+ICsJCXZhbCAmPSB+KFJIX0FfUE9UUEdUIHwgUkhfQV9OUFMgfCBSSF9BX1BTTSB8DQo+ID4g
UkhfQV9PQ1BNKTsNCj4gPiAgCX0gZWxzZSBpZiAoKG9oY2ktPmZsYWdzICYgT0hDSV9RVUlSS19B
TUQ3NTYpIHx8DQo+ID4gIAkJCShvaGNpLT5mbGFncyAmIE9IQ0lfUVVJUktfSFVCX1BPV0VSKSkg
ew0KPiA+ICAJCS8qIGh1YiBwb3dlciBhbHdheXMgb247IHJlcXVpcmVkIGZvciBBTUQtNzU2IGFu
ZCBzb21lDQo+ID4gLQkJICogTWFjIHBsYXRmb3Jtcy4gIGdhbmdlZCBvdmVyY3VycmVudCByZXBv
cnRpbmcsIGlmDQo+ID4gYW55Lg0KPiA+ICsJCSAqIE1hYyBwbGF0Zm9ybXMuDQo+ID4gIAkJICov
DQo+ID4gKwkJdmFsICY9IH5SSF9BX1BTTTsNCj4gPiAgCQl2YWwgfD0gUkhfQV9OUFM7DQo+IA0K
PiBQU00gaXMgaWdub3JlZCB3aGVuIE5QUyBpcyBvbi4gIFlvdSBuZWVkbid0IGJvdGhlciB0byBz
ZXQgaXQuDQpPSywgSSdsbCByZW1vdmUgdGhhdC4NCg0KPiANCj4gPiAtCQlvaGNpX3dyaXRlbCAo
b2hjaSwgdmFsLCAmb2hjaS0+cmVncy0+cm9vdGh1Yi5hKTsNCj4gPiAgCX0NCj4gPiArCW9oY2lf
d3JpdGVsKG9oY2ksIHZhbCwgJm9oY2ktPnJlZ3MtPnJvb3RodWIuYSk7DQo+ID4gKw0KPiA+ICAJ
b2hjaV93cml0ZWwgKG9oY2ksIFJIX0hTX0xQU0MsICZvaGNpLT5yZWdzLT5yb290aHViLnN0YXR1
cyk7DQo+ID4gIAlvaGNpX3dyaXRlbCAob2hjaSwgKHZhbCAmIFJIX0FfTlBTKSA/IDAgOiBSSF9C
X1BQQ00sDQo+ID4gIAkJCQkJCSZvaGNpLT5yZWdzLQ0KPiA+ID5yb290aHViLmIpOw0KPiANCj4g
WW91IGRpZG4ndCBhY3R1YWxseSBjaGFuZ2UgdGhlIGRlZmF1bHQ6IGRpc3RydXN0X2Zpcm13YXJl
IGlzIHN0aWxsIA0KPiBpbml0aWFsaXplZCB0byB0cnVlLg0KWWVzLiBJIGRpZG4ndCBuZWVkIHRv
IGZvciBteSBzeXN0ZW0gYnV0IEkgdW5kZXJzdGFuZCB5b3Ugd2FudCB0byBkbyB0aGUNCmNoYW5n
ZS4gSSdsbCBtYWtlIHRoYXQgYSBzZWNvbmQgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgdG8ga2VlcCB0
aGUNCmxvZ2ljYWwgY2hhbmdlcyBxdWl0ZSBzZXBhcmF0ZSBpbiBjYXNlIG9mIHJlZ3Jlc3Npb24u
DQoNCnYyICgzPykgc2VyaWVzIGNvbWluZyBzb29uLg0KDQpUaGFua3MsDQpIYW1pc2ggTS4NCg0K
PiANCj4gQWxhbiBTdGVybg0K
