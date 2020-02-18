Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C4C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0088B206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sXVIT622"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBRJjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:39:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22851 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbgBRJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:39:17 -0500
X-UUID: 894563186cfb4e2c94083de0129ee869-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=88UyVkUPd1vjYzMQOhcBOlBUEN4pXU5WdvfEcD2AmXM=;
        b=sXVIT62284OFPnYfbu66uZQOb3Vj+pQnXw8cQlQTG7J23wHM2NDnxv33Te9GzUbLeA3v5fvL4/dVM/ua7uPytH38gXtZEPuFanY7RrHf8Nu8pIAiLqrtyPbRuSgWmhcNYsBL0+GSOaywbyYQjXIyuvO7qft3fSq8t0mm2PbCUpA=;
X-UUID: 894563186cfb4e2c94083de0129ee869-20200218
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <mac.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1207599105; Tue, 18 Feb 2020 17:39:12 +0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 17:38:01 +0800
Received: from MTKMBS01N1.mediatek.inc ([fe80::7931:498c:8d17:a7e3]) by
 mtkmbs01n1.mediatek.inc ([fe80::7931:498c:8d17:a7e3%14]) with mapi id
 15.00.1395.000; Tue, 18 Feb 2020 17:38:01 +0800
From:   =?utf-8?B?TWFjIEx1ICjnm6flrZ/lvrcp?= <mac.lu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
CC:     =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>
Subject: RE: NVMEM usage consult for device information
Thread-Topic: NVMEM usage consult for device information
Thread-Index: AdXmDac8eWqjMQtSTjOqGzetWWZMiP//12mA//95HQCAAInxgP//d7Wg
Date:   Tue, 18 Feb 2020 09:38:00 +0000
Message-ID: <ce2b064dd28c400fad8dfb0d60b1486e@mtkmbs01n1.mediatek.inc>
References: <06d083206a4f4f5981be9d2e628162f8@mtkmbs01n1.mediatek.inc>
 <11b42d7b-ff96-d377-5225-6f9fcd5c57b8@linaro.org>
 <57c79cb8f45449d3ba49609cdd4a0767@mtkmbs01n1.mediatek.inc>
 <6db967dc-7776-a10e-21cd-ba47ff6f02c3@linaro.org>
In-Reply-To: <6db967dc-7776-a10e-21cd-ba47ff6f02c3@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3Jpbmk6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCldlIHdvdWxkIGltcGxlbWVudCB0
aGUgZHJpdmVyIGFuZCB0aGVuIHN1Ym1pdCBmb3IgcmV2aWV3Lg0KDQpUaGFua3MNCk1hYw0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU3Jpbml2YXMgS2FuZGFnYXRsYSBbbWFp
bHRvOnNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZ10gDQpTZW50OiBUdWVzZGF5LCBGZWJy
dWFyeSAxOCwgMjAyMCA1OjMwIFBNDQpUbzogTWFjIEx1ICjnm6flrZ/lvrcpIDxtYWMubHVAbWVk
aWF0ZWsuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbWVkaWF0ZWtA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KQ2M6IEFuZHJldy1DVCBDaGVuICjpmbPmmbrov6opIDxBbmRy
ZXctQ1QuQ2hlbkBtZWRpYXRlay5jb20+DQpTdWJqZWN0OiBSZTogTlZNRU0gdXNhZ2UgY29uc3Vs
dCBmb3IgZGV2aWNlIGluZm9ybWF0aW9uDQoNCg0KDQpPbiAxOC8wMi8yMDIwIDA5OjI2LCBNYWMg
THUgKOebp+Wtn+W+tykgd3JvdGU6DQo+IEhpIFNyaW5pOg0KPj5JcyB0aGlzIGRhdGEgc3RvcmVk
IGluIGEgbm9uIHZvbGF0aWxlIG1lbW9yeSBvbiB0aGUgU29DPw0KPj5pZiB5ZXMsIHRoZW4gd2Ug
c2hvdWxkIGhhdmUgYSBwcm9wZXIgbnZtZW0gcHJvdmlkZXIgZHJpdmVyLg0KPiANCj4gWWVzLiBU
aGlzIGRhdGEgaXMgc3RvcmVkIGluIG5vbiB2b2xhdGlsZSBtZW1vcnkgb24gdGhlIFNvQy4NCkl0
IG1ha2VzIHNlbnNlIHRvIGhhdmUgIG52bWVtIGRyaXZlciBpbiB0aGF0IGNhc2UuIHdoaWNoIGNh
biB0aGVuIGJlIHVzZWQgYnkgRGV2aWNlIFRyZWUgdG8gcmV0cmlldmUgdGhlIHJlcXVpcmVkIGNv
bmZpZ3VyYXRpb25zIGZyb20gTlZNRU0uDQoNCi0tc3JpbmkNCj4gSXQgd291bGQgYmUgcmVhZCBh
dCBib290bG9hZGVyIGFuZCBkZWxpdmVyZWQgdG8ga2VybmVsIGJ5IERUQi4NCg0KPiANCj4gDQo+
IFRoYW5rcw0KPiBNYWMNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFNyaW5pdmFzIEthbmRhZ2F0bGEgW21haWx0bzpzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5v
cmddDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDE4LCAyMDIwIDU6MTkgUE0NCj4gVG86IE1h
YyBMdSAo55un5a2f5b63KSA8bWFjLmx1QG1lZGlhdGVrLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IA0KPiBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENj
OiBBbmRyZXctQ1QgQ2hlbiAo6Zmz5pm66L+qKSA8QW5kcmV3LUNULkNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiBTdWJqZWN0OiBSZTogTlZNRU0gdXNhZ2UgY29uc3VsdCBmb3IgZGV2aWNlIGluZm9ybWF0
aW9uDQo+IA0KPiANCj4gDQo+IE9uIDE4LzAyLzIwMjAgMDU6MTYsIE1hYyBMdSAo55un5a2f5b63
KSB3cm90ZToNCj4+IEhlbGxvLA0KPj4gDQo+PiBNZWRpYXRla8KgY2hpcCBoYXZlIHNvbWUgU09D
IGNvbmZpZ3VyYXRpb25zIGFuZCBzcGVjaWZpYyBkYXRhIHdoaWNoIA0KPj4gd291bGQgYmUgZGVs
aXZlcmVkIHRvIGtlcm5lbCBieSBEVEIuDQo+PiANCj4gSXMgdGhpcyBkYXRhIHN0b3JlZCBpbiBh
IG5vbiB2b2xhdGlsZSBtZW1vcnkgb24gdGhlIFNvQz8NCj4gaWYgeWVzLCB0aGVuIHdlIHNob3Vs
ZCBoYXZlIGEgcHJvcGVyIG52bWVtIHByb3ZpZGVyIGRyaXZlci4NCj4gDQo+IC0tc3JpbmkNCj4g
DQo+PiBTbyB3ZSB3YW50IHRvIGltcGxlbWVudCBhIG5ldyBOVk1FTSBkcml2ZXIgdG8gcmV0cmll
dmUgdGhlc2UgZGF0YSBmb3IgDQo+PiB1c2UgYnkgdGhlIE5WTUVNIEZyYW1ld29yay4NCj4+IA0K
Pj4gRG8geW91IGFncmVlIHdpdGggdGhlIHVzYWdlIGZvciBvdXIgYXBwbGljYXRpb24/DQo+PiAN
Cj4+IFRoYW5rcw0KPj4gDQo+PiBNYWMNCj4+IA0KPj4gKioqKioqKioqKioqKiBNRURJQVRFSyBD
b25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqIA0KPj4gVGhlIGluZm9y
bWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55DQo+
PiBhdHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVn
ZWQsIG9yIA0KPj4gb3RoZXJ3aXNlIGV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGlj
YWJsZSBsYXdzLiBJdCBpcyANCj4+IGludGVuZGVkIHRvIGJlIGNvbnZleWVkIG9ubHkgdG8gdGhl
IGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCANCj4+IGRpc3NlbWluYXRpb24sIGRp
c3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgDQo+PiBl
LW1haWwgKGluY2x1ZGluZyBpdHMNCj4+IGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCANCj4+IG1heSBiZSB1bmxhd2Z1bC4g
SWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCANCj4+
IG9yIGJlbGlldmUgdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSANCj4+IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJlcGx5aW5nIHRv
IHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgDQo+PiBhbGwgY29waWVzIG9mIHRoaXMgZS1t
YWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgDQo+PiBzeXN0ZW0sIGFu
ZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8gYW55IG90aGVy
IHBlcnNvbi4gVGhhbmsgeW91IQ0KPj4gDQo+IA0KPiAqKioqKioqKioqKioqIE1FRElBVEVLIENv
bmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKiogVGhlIA0KPiBpbmZvcm1h
dGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueQ0KPiBh
dHRhY2htZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQs
IG9yIA0KPiBvdGhlcndpc2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxl
IGxhd3MuIEl0IGlzIGludGVuZGVkIA0KPiB0byBiZSBjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNp
Z25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgDQo+IGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1
dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgDQo+IGUtbWFpbCAo
aW5jbHVkaW5nIGl0cw0KPiBhdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykg
aXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IA0KPiBiZSB1bmxhd2Z1bC4gSWYgeW91IGFy
ZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciANCj4gYmVsaWV2
ZSB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90
aWZ5IHRoZSANCj4gc2VuZGVyIGltbWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFp
bCksIGRlbGV0ZSBhbnkgYW5kIGFsbCANCj4gY29waWVzIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRp
bmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCANCj4gYW5kIGRvIG5vdCBkaXNj
bG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIgcGVyc29uLiBUaGFu
ayB5b3UhDQo+IA0K
