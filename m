Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD6DC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774A724683
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgB0Gbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:31:43 -0500
Received: from segapp02.wistron.com ([103.200.3.19]:49879 "EHLO
        segapp03.wistron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726575AbgB0Gbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:31:41 -0500
Received: from EXCHAPP03.whq.wistron (unverified [10.37.38.26]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdd93781158c0a816721818@TWNHUMSW4.wistron.com>;
 Thu, 27 Feb 2020 14:31:31 +0800
Received: from EXCHAPP02.whq.wistron (10.37.38.25) by EXCHAPP03.whq.wistron
 (10.37.38.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 14:31:30 +0800
Received: from EXCHAPP02.whq.wistron ([fe80::ecf3:5097:933e:61e6]) by
 EXCHAPP02.whq.wistron ([fe80::ecf3:5097:933e:61e6%5]) with mapi id
 15.01.1713.004; Thu, 27 Feb 2020 14:31:30 +0800
From:   <Ben_Pai@wistron.com>
To:     <joel@jms.id.au>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <andrew@aj.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <wangat@tw.ibm.com>, <Claire_Ku@wistron.com>, <Ben_Pai@wistron.com>
Subject: RE: [PATCH v1] ARM: dts: mihawk: Change the name of mihawk led
Thread-Topic: [PATCH v1] ARM: dts: mihawk: Change the name of mihawk led
Thread-Index: AQHV57IDUDu59Q0XzUS/X7KToe/Y4qgs0SeAgAG53kA=
Date:   Thu, 27 Feb 2020 06:31:30 +0000
Message-ID: <3633e9f58ab14118bf4c8df3f25ea0d2@wistron.com>
References: <20200220055255.22809-1-Ben_Pai@wistron.com>
 <CACPK8Xf=t+PY42qxF9jProYGGZZJONb=H1D4xZJc7teFWJ2FrA@mail.gmail.com>
In-Reply-To: <CACPK8Xf=t+PY42qxF9jProYGGZZJONb=H1D4xZJc7teFWJ2FrA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.37.38.230]
x-tm-snts-smtp: 07E6559BC863661D5C7F457DA7AC36875EA80F0F8E96A4F5E8765A88B6AB6E272000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWloYXdrIHBsYXRmb3JtIG5vIGxvbmdlciBzdXBwb3J0cyB0aGVzZSB0d28gTEVEcywgc28gSSB0
aGluayB0aGVzZSB0d28gTEVEcyBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIGR0cy4NCg0KU2lnbmVk
LW9mZi1ieTogQmVuIFBhaSA8QmVuX1BhaUB3aXN0cm9uLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+IA0KU2VudDog
V2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyMCA2OjU2IFBNDQpUbzogQmVuIFBhaS9XSFEvV2lz
dHJvbiA8QmVuX1BhaUB3aXN0cm9uLmNvbT4NCkNjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFuZHJldyBKZWZm
ZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBkZXZpY2V0cmVlIDxkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsg
bGludXgtYXNwZWVkIDxsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZz47IExpbnV4IEtlcm5l
bCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyB3YW5nYXRAdHcu
aWJtLmNvbTsgQ2xhaXJlIEt1L1dIUS9XaXN0cm9uIDxDbGFpcmVfS3VAd2lzdHJvbi5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIIHYxXSBBUk06IGR0czogbWloYXdrOiBDaGFuZ2UgdGhlIG5hbWUg
b2YgbWloYXdrIGxlZA0KDQpPbiBUaHUsIDIwIEZlYiAyMDIwIGF0IDA1OjUzLCBCZW4gUGFpIDxC
ZW5fUGFpQHdpc3Ryb24uY29tPiB3cm90ZToNCj4NCj4gMS5DaGFuZ2UgdGhlIG5hbWUgb2YgcG93
ZXIsIGZhdWx0IGFuZCByZWFyLWlkLg0KPiAyLlJlbW92ZSB0aGUgdHdvIGxlZHMuDQoNClRoZSBw
YXRjaCBsb29rcyBva2F5LiBXaHkgZG8geW91IHJlbW92ZSB0aGUgb3RoZXIgdHdvIGxlZHM/DQoN
ClJldmlld2VkLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEJlbiBQYWkgPEJlbl9QYWlAd2lzdHJvbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1vcHAtbWloYXdrLmR0cyB8IDE3ICsrKy0tLS0tLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtb3BwLW1paGF3
ay5kdHMgDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1vcHAtbWloYXdrLmR0cw0K
PiBpbmRleCBlNTVjYzQ1NGIxN2YuLjZjMTE4NTRiOTAwNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1vcHAtbWloYXdrLmR0cw0KPiArKysgYi9hcmNoL2FybS9i
b290L2R0cy9hc3BlZWQtYm1jLW9wcC1taWhhd2suZHRzDQo+IEBAIC0xMjAsMzUgKzEyMCwyNCBA
QA0KPiAgICAgICAgIGxlZHMgew0KPiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJncGlv
LWxlZHMiOw0KPg0KPiAtICAgICAgICAgICAgICAgZmF1bHQgew0KPiArICAgICAgICAgICAgICAg
ZnJvbnQtZmF1bHQgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXRhaW4tc3RhdGUtc2h1
dGRvd247DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQtc3RhdGUgPSAia2VlcCI7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdwaW9zID0gPCZncGlvIEFTUEVFRF9HUElPKEFB
LCAwKSBHUElPX0FDVElWRV9MT1c+Ow0KPiAgICAgICAgICAgICAgICAgfTsNCj4NCj4gLSAgICAg
ICAgICAgICAgIHBvd2VyIHsNCj4gKyAgICAgICAgICAgICAgIHBvd2VyLWJ1dHRvbiB7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldGFpbi1zdGF0ZS1zaHV0ZG93bjsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgZGVmYXVsdC1zdGF0ZSA9ICJrZWVwIjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZ3Bpb3MgPSA8JmdwaW8gQVNQRUVEX0dQSU8oQUEsIDEpIEdQSU9fQUNUSVZFX0xP
Vz47DQo+ICAgICAgICAgICAgICAgICB9Ow0KPg0KPiAtICAgICAgICAgICAgICAgcmVhci1pZCB7
DQo+ICsgICAgICAgICAgICAgICBmcm9udC1pZCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHJldGFpbi1zdGF0ZS1zaHV0ZG93bjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVs
dC1zdGF0ZSA9ICJrZWVwIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8Jmdw
aW8gQVNQRUVEX0dQSU8oQUEsIDIpIEdQSU9fQUNUSVZFX0xPVz47DQo+ICAgICAgICAgICAgICAg
ICB9Ow0KPg0KPiAtICAgICAgICAgICAgICAgcmVhci1nIHsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgcmV0YWluLXN0YXRlLXNodXRkb3duOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBk
ZWZhdWx0LXN0YXRlID0gImtlZXAiOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBncGlvcyA9
IDwmZ3BpbyBBU1BFRURfR1BJTyhBQSwgNCkgR1BJT19BQ1RJVkVfTE9XPjsNCj4gLSAgICAgICAg
ICAgICAgIH07DQo+IC0NCj4gLSAgICAgICAgICAgICAgIHJlYXItb2sgew0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICByZXRhaW4tc3RhdGUtc2h1dGRvd247DQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgIGRlZmF1bHQtc3RhdGUgPSAia2VlcCI7DQo+IC0gICAgICAgICAgICAgICAgICAgICAg
IGdwaW9zID0gPCZncGlvIEFTUEVFRF9HUElPKFksIDApIEdQSU9fQUNUSVZFX0xPVz47DQo+IC0g
ICAgICAgICAgICAgICB9Ow0KPg0KPiAgICAgICAgICAgICAgICAgZmFuMCB7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldGFpbi1zdGF0ZS1zaHV0ZG93bjsNCj4gLS0NCj4gMi4xNy4xDQo+
DQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0tIFRoaXMgZW1haWwgY29udGFpbnMgY29uZmlkZW50aWFsIG9yIGxlZ2FsbHkgDQo+IHByaXZp
bGVnZWQgaW5mb3JtYXRpb24gYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgaXRzIGludGVuZGVk
IHJlY2lwaWVudC4NCj4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgY29weWluZyBvciBk
aXN0cmlidXRpb24gb2YgdGhpcyBlbWFpbCBvciB0aGUgY29udGVudCBvZiB0aGlzIGVtYWlsIGlz
IHN0cmljdGx5IHByb2hpYml0ZWQuDQo+IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQsIHlvdSBtYXkgcmVwbHkgdG8gdGhlIHNlbmRlciBhbmQgc2hvdWxkIGRlbGV0ZSB0aGlz
IGUtbWFpbCBpbW1lZGlhdGVseS4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
IC0tLS0tLS0tLS0tLS0tLS0tLS0NCg==
