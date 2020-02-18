Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0363C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837F206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ww6tDLwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgBRJ1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:27:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42239 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726199AbgBRJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:27:41 -0500
X-UUID: f6d3716aafa949aaafbacb9fa00e74e6-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uOZO7hmEY6MTMfyO9+ZNVzS/vh4dCpKJJZNw9nfXF/o=;
        b=Ww6tDLweL2jF1dqoh9Z3D7jjPU8XYoxY/4U9HPKZ4rc9XYkpiLmKAFVswdWchxf/LFF21G0ENMrnknG5N3DJ4Ny/Pf++clI/2up/jSBmv71VLP0GT7Ex77XCMxayXwG4lfZjfrR6i2te3IHJNmEQZCEHwCMcvnUd6BTQv2UypDQ=;
X-UUID: f6d3716aafa949aaafbacb9fa00e74e6-20200218
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mac.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 787747047; Tue, 18 Feb 2020 17:27:35 +0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 17:26:24 +0800
Received: from MTKMBS01N1.mediatek.inc ([fe80::7931:498c:8d17:a7e3]) by
 mtkmbs01n1.mediatek.inc ([fe80::7931:498c:8d17:a7e3%14]) with mapi id
 15.00.1395.000; Tue, 18 Feb 2020 17:26:24 +0800
From:   =?utf-8?B?TWFjIEx1ICjnm6flrZ/lvrcp?= <mac.lu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
CC:     =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>
Subject: RE: NVMEM usage consult for device information
Thread-Topic: NVMEM usage consult for device information
Thread-Index: AdXmDac8eWqjMQtSTjOqGzetWWZMiP//12mA//95HQA=
Date:   Tue, 18 Feb 2020 09:26:24 +0000
Message-ID: <57c79cb8f45449d3ba49609cdd4a0767@mtkmbs01n1.mediatek.inc>
References: <06d083206a4f4f5981be9d2e628162f8@mtkmbs01n1.mediatek.inc>
 <11b42d7b-ff96-d377-5225-6f9fcd5c57b8@linaro.org>
In-Reply-To: <11b42d7b-ff96-d377-5225-6f9fcd5c57b8@linaro.org>
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

SGkgU3Jpbmk6DQo+SXMgdGhpcyBkYXRhIHN0b3JlZCBpbiBhIG5vbiB2b2xhdGlsZSBtZW1vcnkg
b24gdGhlIFNvQz8NCj5pZiB5ZXMsIHRoZW4gd2Ugc2hvdWxkIGhhdmUgYSBwcm9wZXIgbnZtZW0g
cHJvdmlkZXIgZHJpdmVyLg0KDQpZZXMuIFRoaXMgZGF0YSBpcyBzdG9yZWQgaW4gbm9uIHZvbGF0
aWxlIG1lbW9yeSBvbiB0aGUgU29DLg0KSXQgd291bGQgYmUgcmVhZCBhdCBib290bG9hZGVyIGFu
ZCBkZWxpdmVyZWQgdG8ga2VybmVsIGJ5IERUQi4NCg0KDQpUaGFua3MNCk1hYw0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU3Jpbml2YXMgS2FuZGFnYXRsYSBbbWFpbHRvOnNy
aW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZ10gDQpTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAx
OCwgMjAyMCA1OjE5IFBNDQpUbzogTWFjIEx1ICjnm6flrZ/lvrcpIDxtYWMubHVAbWVkaWF0ZWsu
Y29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbWVkaWF0ZWtAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KQ2M6IEFuZHJldy1DVCBDaGVuICjpmbPmmbrov6opIDxBbmRyZXctQ1Qu
Q2hlbkBtZWRpYXRlay5jb20+DQpTdWJqZWN0OiBSZTogTlZNRU0gdXNhZ2UgY29uc3VsdCBmb3Ig
ZGV2aWNlIGluZm9ybWF0aW9uDQoNCg0KDQpPbiAxOC8wMi8yMDIwIDA1OjE2LCBNYWMgTHUgKOeb
p+Wtn+W+tykgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gTWVkaWF0ZWvCoGNoaXAgaGF2ZSBzb21l
IFNPQyBjb25maWd1cmF0aW9ucyBhbmQgc3BlY2lmaWMgZGF0YSB3aGljaCANCj4gd291bGQgYmUg
ZGVsaXZlcmVkIHRvIGtlcm5lbCBieSBEVEIuDQo+IA0KSXMgdGhpcyBkYXRhIHN0b3JlZCBpbiBh
IG5vbiB2b2xhdGlsZSBtZW1vcnkgb24gdGhlIFNvQz8NCmlmIHllcywgdGhlbiB3ZSBzaG91bGQg
aGF2ZSBhIHByb3BlciBudm1lbSBwcm92aWRlciBkcml2ZXIuDQoNCi0tc3JpbmkNCg0KPiBTbyB3
ZSB3YW50IHRvIGltcGxlbWVudCBhIG5ldyBOVk1FTSBkcml2ZXIgdG8gcmV0cmlldmUgdGhlc2Ug
ZGF0YSBmb3IgDQo+IHVzZSBieSB0aGUgTlZNRU0gRnJhbWV3b3JrLg0KPiANCj4gRG8geW91IGFn
cmVlIHdpdGggdGhlIHVzYWdlIGZvciBvdXIgYXBwbGljYXRpb24/DQo+IA0KPiBUaGFua3MNCj4g
DQo+IE1hYw0KPiANCj4gKioqKioqKioqKioqKiBNRURJQVRFSyBDb25maWRlbnRpYWxpdHkgTm90
aWNlICoqKioqKioqKioqKioqKioqKioqIFRoZSANCj4gaW5mb3JtYXRpb24gY29udGFpbmVkIGlu
IHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkNCj4gYXR0YWNobWVudHMpIG1heSBi
ZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBvciANCj4gb3RoZXJ3aXNl
IGV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRl
bmRlZCANCj4gdG8gYmUgY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQo
cykuIEFueSB1c2UsIA0KPiBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24sIHByaW50aW5nLCBy
ZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIA0KPiBlLW1haWwgKGluY2x1ZGluZyBpdHMNCj4g
YXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hp
Yml0ZWQgYW5kIG1heSANCj4gYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVk
IHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgDQo+IGJlbGlldmUgdGhhdCB5b3UgaGF2ZSBy
ZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgDQo+IHNlbmRl
ciBpbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwpLCBkZWxldGUgYW55IGFu
ZCBhbGwgDQo+IGNvcGllcyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50
cykgZnJvbSB5b3VyIHN5c3RlbSwgDQo+IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQg
b2YgdGhpcyBlLW1haWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KPiANCg==
