Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9BC2BC11
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2479F20EDD
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sl4zEzkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgIIDAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:00:05 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:26535 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726714AbgIIDAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:00:01 -0400
X-UUID: 101bf987e33d431181992afd78134148-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CoD/azwfliGei22WWvULFvB+ftOMVB//DhdbZ0hZnHU=;
        b=sl4zEzktFiutz5nvkbSsH4pFpxV/fd1d8o8y4PAkqoq/RMjXJ8KnsB4Nma1cL9Fs9YZyyD58vyklStV/C0fVHA/ehJuf6JdpVnQSrd5/Cg8fdZE7EL5JvNabnGPzi0GtE2SyQyMmordu3clIHHRQ/AFMVi9WVetesqocamck/6Q=;
X-UUID: 101bf987e33d431181992afd78134148-20200909
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 758830955; Wed, 09 Sep 2020 10:59:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 10:59:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 10:59:51 +0800
Message-ID: <1599620279.14806.18.camel@mhfsdcap03>
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Suman Anna <s-anna@ti.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?=" 
        <Yong.Liang@mediatek.com>
Date:   Wed, 9 Sep 2020 10:57:59 +0800
In-Reply-To: <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-4-crystal.guo@mediatek.com>
         <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8FF367AE59B7085B86EBAFD42EA9607EE2343874A68663AA8489A4A9C3D323D32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTAzIGF0IDA3OjQwICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiBI
aSBDcnlzdGFsLA0KPiANCj4gT24gOC8xNi8yMCAxMDowMyBQTSwgQ3J5c3RhbCBHdW8gd3JvdGU6
DQo+ID4gSW50cm9kdWNlIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5k
IGRlYXNzZXJ0IHRvZ2V0aGVyLg0KPiA+IElmIHNvbWUgbW9kdWxlcyBuZWVkIGRvIHNlcmlhbGl6
ZWQgYXNzZXJ0IGFuZCBkZWFzc2VydCBvcGVyYXRpb25zDQo+ID4gdG8gcmVzZXQgaXRzZWxmLCBy
ZXNldF9jb250cm9sX3Jlc2V0IGNhbiBiZSBjYWxsZWQgZm9yIGNvbnZlbmllbmNlLg0KPiANCj4g
VGhlcmUgYXJlIG11bHRpcGxlIGNoYW5nZXMgaW4gdGhpcyBzYW1lIHBhdGNoLiBJIHRoaW5rIHlv
dSBzaG91bGQgc3BsaXQgdGhpcw0KPiBmdW5jdGlvbmFsaXR5IGF3YXkgZnJvbSB0aGUgY2hhbmdl
IGZvciB0aGUgcmVnbWFwX3VwZGF0ZV9iaXRzKCkgdG8NCj4gcmVnbWFwX3dyaXRlX2JpdHMoKSwg
c2ltaWxhciB0byB3aGF0IHlvdSBoYXZlIGRvbmUgaW4geW91ciB2MiBQYXRjaCA0Lg0KPiANCg0K
VGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpJIHdpbGwgc3BsaXQgdGhpcyBwYXRjaCBpbiB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gDQo+ID4gU3VjaCBhcyByZXNldC1xY29tLWFvc3MuYywg
aXQgaW50ZWdyYXRlcyBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRvZ2V0aGVyDQo+ID4gYnkgJ3Jlc2V0
JyBtZXRob2QuIE1USyBTb2NzIGFsc28gbmVlZCB0aGlzIG1ldGhvZCB0byBwZXJmb3JtIHJlc2V0
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMg
fCAyNiArKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lz
Y29uLmMNCj4gPiBpbmRleCBhMjYzNWMyMWRiN2YuLjA4Mjg5MzQyZjlhZiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQo+ID4gKysrIGIvZHJpdmVycy9y
ZXNldC9yZXNldC10aS1zeXNjb24uYw0KPiA+IEBAIC0xNSw2ICsxNSw3IEBADQo+ID4gICAqIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+ID4gICAqLw0KPiA+
ICANCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9t
ZmQvc3lzY29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L29mLmg+DQo+ID4gQEAgLTU2LDYgKzU3LDcgQEAgc3RydWN0IHRpX3N5c2Nvbl9y
ZXNldF9kYXRhIHsNCj4gPiAgCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gPiAgCXN0cnVjdCB0
aV9zeXNjb25fcmVzZXRfY29udHJvbCAqY29udHJvbHM7DQo+ID4gIAl1bnNpZ25lZCBpbnQgbnJf
Y29udHJvbHM7DQo+ID4gKwl1bnNpZ25lZCBpbnQgcmVzZXRfZHVyYXRpb25fdXM7DQo+ID4gIH07
DQo+ID4gIA0KPiA+ICAjZGVmaW5lIHRvX3RpX3N5c2Nvbl9yZXNldF9kYXRhKHJjZGV2KQlcDQo+
ID4gQEAgLTg5LDcgKzkxLDcgQEAgc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHN0
cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gIAltYXNrID0gQklUKGNvbnRy
b2wtPmFzc2VydF9iaXQpOw0KPiA+ICAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBBU1NFUlRf
U0VUKSA/IG1hc2sgOiAweDA7DQo+ID4gIA0KPiA+IC0JcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0
cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4g
PiArCXJldHVybiByZWdtYXBfd3JpdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmFzc2Vy
dF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgLyoqDQo+ID4gQEAg
LTEyMCw3ICsxMjIsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9kZWFzc2VydChzdHJ1
Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+ICAJbWFzayA9IEJJVChjb250cm9s
LT5kZWFzc2VydF9iaXQpOw0KPiA+ICAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBERUFTU0VS
VF9TRVQpID8gbWFzayA6IDB4MDsNCj4gPiAgDQo+ID4gLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9i
aXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7
DQo+ID4gKwlyZXR1cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5k
ZWFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgLyoqDQo+
ID4gQEAgLTE1OCw5ICsxNjAsMjYgQEAgc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfc3RhdHVz
KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gIAkJIShjb250cm9sLT5m
bGFncyAmIFNUQVRVU19TRVQpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW50IHRpX3N5
c2Nvbl9yZXNldChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+ICsJCQkJ
ICB1bnNpZ25lZCBsb25nIGlkKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0
X2RhdGEgKmRhdGEgPSB0b190aV9zeXNjb25fcmVzZXRfZGF0YShyY2Rldik7DQo+ID4gKwlpbnQg
cmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQocmNkZXYsIGlk
KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAo
ZGF0YS0+cmVzZXRfZHVyYXRpb25fdXMpDQo+ID4gKwkJdXNsZWVwX3JhbmdlKGRhdGEtPnJlc2V0
X2R1cmF0aW9uX3VzLCBkYXRhLT5yZXNldF9kdXJhdGlvbl91cyAqIDIpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQocmNkZXYsIGlkKTsNCj4gDQo+IEkgZWNo
byBQaGlsaXBwJ3MgY29tbWVudHMgWzFdIGZyb20geW91ciBvcmlnaW5hbCB2MSBzZXJpZXMgYWJv
dXQgdGhpcy4gV2UgZG9uJ3QNCj4gbmVlZCBhIHByb3BlcnR5IHRvIGRpc3Rpbmd1aXNoIHRoaXMs
IGJ1dCB5b3UgY291bGQgYWRkIGEgZmxhZyB1c2luZyBtYXRjaCBkYXRhDQo+IGFuZCBNZWRpYXRl
ayBjb21wYXRpYmxlLCBhbmQgdXNlIHRoYXQgd2l0aGluIHRoaXMgZnVuY3Rpb24sIG9yIG9wdGlv
bmFsbHkgc2V0DQo+IHRoaXMgb3BzIGJhc2VkIG9uIGNvbXBhdGlibGUgKHdoYXRldmVyIGlzIHBy
ZWZlcnJlZCBieSBQaGlsaXBwKS4NCj4gDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCj4gDQo+IFsxXSBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvbW1lbnQvMjM1MTkxOTMvDQo+IA0KSGkgU3Vt
YW4sIFBoaWxpcHANCg0KV2hpY2ggbWV0aG9kIHdvdWxkIHlvdSByZWNvbW1lbmQgbW9yZT8NCjEu
IGxpa2UgdjIgcGF0Y2gsIGJ1dCBhc3NpZ24gdGhlIGZsYWcgImRhdGEtPmFzc2VydF9kZWFzc2Vy
dF90b2dldGhlciINCmRpcmVjdGx5IChtYXliZSByZW5hbWUgImFzc2VydF9kZWFzc2VydF90b2dl
dGhlciIgdG8NCiJyZXNldF9vcF9hdmFpbGFibGUiKQ0KDQoyLiB1c2UgTWVkaWF0ZWsgY29tcGF0
aWJsZSB0byBkZWNpZGUgdGhlIHJlc2V0IGhhbmRsZXIgYXZhaWxhYmxlIG9yIG5vdC4NCg0KVGhh
bmtzDQpDcnlzdGFsDQoNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBy
ZXNldF9jb250cm9sX29wcyB0aV9zeXNjb25fcmVzZXRfb3BzID0gew0KPiA+ICAJLmFzc2VydAkJ
PSB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0LA0KPiA+ICAJLmRlYXNzZXJ0CT0gdGlfc3lzY29uX3Jl
c2V0X2RlYXNzZXJ0LA0KPiA+ICsJLnJlc2V0CQk9IHRpX3N5c2Nvbl9yZXNldCwNCj4gPiAgCS5z
dGF0dXMJCT0gdGlfc3lzY29uX3Jlc2V0X3N0YXR1cywNCj4gPiAgfTsNCj4gPiAgDQo+ID4gQEAg
LTIwNCw2ICsyMjMsOSBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCWNvbnRyb2xzW2ldLmZsYWdzID0gYmUzMl90
b19jcHVwKGxpc3QrKyk7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICsJb2ZfcHJvcGVydHlfcmVhZF91
MzIocGRldi0+ZGV2Lm9mX25vZGUsCSJyZXNldC1kdXJhdGlvbi11cyIsDQo+ID4gKwkJCQkmZGF0
YS0+cmVzZXRfZHVyYXRpb25fdXMpOw0KPiA+ICsNCj4gPiAgCWRhdGEtPnJjZGV2Lm9wcyA9ICZ0
aV9zeXNjb25fcmVzZXRfb3BzOw0KPiA+ICAJZGF0YS0+cmNkZXYub3duZXIgPSBUSElTX01PRFVM
RTsNCj4gPiAgCWRhdGEtPnJjZGV2Lm9mX25vZGUgPSBucDsNCj4gPiANCj4gDQoNCg==

