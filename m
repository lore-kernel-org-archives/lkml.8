Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B0E206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pl9JPAtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404604AbgFXPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:35:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52712 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404382AbgFXPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:35:19 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OFJYoi024017;
        Wed, 24 Jun 2020 17:35:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=b+udD3OXhTb7dseIg7ZIscRe7YziBcqF8XPAUo/vPPs=;
 b=pl9JPAtPrhWMl+xBkAeN6miQKnlay1SPmoUhuBmZNqzXzw9qqgB5Ke3fBSkn9LQXkbAq
 0mrAbItaXum+GYqRLVQScSdEG43BOxXlbnexcjC4lBCSZJB+iZKSaizDLWiotpPRJcoX
 s7uWNtX/WUdfqnv6Z2N4tHbuWkQk4hybCdBT6GoDrRJw5nRCY2simVpVqe1aM78qPXfz
 zsjpZlaLDdNYxO8vL1VCQldkjnvTWVrCao+1pMTzwWtrn/8cSe7czcxSm0AHc2k9TjfZ
 +a6HmA1HnLfS93fzwDsHhIyMhrCDeKPQp6MPpAQ0Ra2OrPE8TgAQQwLUrOndRvCy/iMm 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31uuumcwdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 17:35:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A996100034;
        Wed, 24 Jun 2020 17:35:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 823A62C5BAE;
        Wed, 24 Jun 2020 17:35:04 +0200 (CEST)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Jun
 2020 17:35:04 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Wed, 24 Jun 2020 17:35:04 +0200
From:   Yannick FERTRE <yannick.fertre@st.com>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pop.adrian61@gmail.com" <pop.adrian61@gmail.com>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi.c: Add VPG runtime config
 through debugfs
Thread-Topic: [PATCH v2] drm/bridge: dw-mipi-dsi.c: Add VPG runtime config
 through debugfs
Thread-Index: AQHWDBotLzsm/jdHJ0Ge7FgHm5JcQqjoQFOA
Date:   Wed, 24 Jun 2020 15:35:04 +0000
Message-ID: <d46d3aaf-d3cd-e5e1-81b9-c019537bd09a@st.com>
References: <a809feb7d7153a92e323416f744f1565e995da01.1586180592.git.angelo.ribeiro@synopsys.com>
In-Reply-To: <a809feb7d7153a92e323416f744f1565e995da01.1586180592.git.angelo.ribeiro@synopsys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B9D6134796BA45821981F3137C9CC2@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_08:2020-06-24,2020-06-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5nZWxvLA0KdGhhbmtzIGZvciB0aGUgcGF0Y2guDQpUZXN0ZWQtYnk6IFlhbm5pY2sg
RmVydHJlIDx5YW5uaWNrLmZlcnRyZUBzdC5jb20+DQpUZXN0ZWQgT0sgb24gU1RNMzJNUDEtRElT
Q08sIERTSSB2MS4zMQ0KDQpCZXN0IHJlZ2FyZHMNCg0KDQpPbiA0LzYvMjAgMzo0OSBQTSwgQW5n
ZWxvIFJpYmVpcm8gd3JvdGU6DQo+IEFkZCBzdXBwb3J0IGZvciB0aGUgdmlkZW8gcGF0dGVybiBn
ZW5lcmF0b3IgKFZQRykgQkVSIHBhdHRlcm4gbW9kZSBhbmQNCj4gY29uZmlndXJhdGlvbiBpbiBy
dW50aW1lLg0KPiANCj4gVGhpcyBlbmFibGVzIHVzaW5nIHRoZSBkZWJ1Z2ZzIGludGVyZmFjZSB0
byBtYW5pcHVsYXRlIHRoZSBWUEcgYWZ0ZXINCj4gdGhlIHBpcGVsaW5lIGlzIHNldC4NCj4gQWxz
bywgZW5hYmxlcyB0aGUgdXNhZ2Ugb2YgdGhlIFZQRyBCRVIgcGF0dGVybi4NCj4gDQo+IENoYW5n
ZXMgaW4gdjI6DQo+ICAgIC0gQWRkZWQgVklEX01PREVfVlBHX01PREUNCj4gICAgLSBTb2x2ZWQg
aW5jb21wYXRpYmxlIHJldHVybiB0eXBlIG9uIF9fZ2V0IGFuZCBfX3NldA0KPiANCj4gUmVwb3J0
ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTog
QWRyaWFuIFBvcCA8cG9wLmFkcmlhbjYxQGdtYWlsLmNvbT4NCj4gQ2M6IEd1c3Rhdm8gUGltZW50
ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiBDYzogSm9hbyBQaW50byA8anBp
bnRvQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IEpvc2UgQWJyZXUgPGpvc2UuYWJyZXVAc3lub3BzeXMu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG8gUmliZWlybyA8YW5nZWxvLnJpYmVpcm9Ac3lu
b3BzeXMuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3
LW1pcGktZHNpLmMgfCA5OCArKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4gaW5kZXggYjE4MzUx
Yi4uOWRlMzY0NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5
cy9kdy1taXBpLWRzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMv
ZHctbWlwaS1kc2kuYw0KPiBAQCAtOTEsNiArOTEsNyBAQA0KPiAgICNkZWZpbmUgVklEX01PREVf
VFlQRV9CVVJTVAkJCTB4Mg0KPiAgICNkZWZpbmUgVklEX01PREVfVFlQRV9NQVNLCQkJMHgzDQo+
ICAgI2RlZmluZSBWSURfTU9ERV9WUEdfRU5BQkxFCQlCSVQoMTYpDQo+ICsjZGVmaW5lIFZJRF9N
T0RFX1ZQR19NT0RFCQlCSVQoMjApDQo+ICAgI2RlZmluZSBWSURfTU9ERV9WUEdfSE9SSVpPTlRB
TAkJQklUKDI0KQ0KPiAgIA0KPiAgICNkZWZpbmUgRFNJX1ZJRF9QS1RfU0laRQkJMHgzYw0KPiBA
QCAtMjIxLDYgKzIyMiwyMSBAQA0KPiAgICNkZWZpbmUgUEhZX1NUQVRVU19USU1FT1VUX1VTCQkx
MDAwMA0KPiAgICNkZWZpbmUgQ01EX1BLVF9TVEFUVVNfVElNRU9VVF9VUwkyMDAwMA0KPiAgIA0K
PiArI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPiArI2RlZmluZSBWUEdfREVGUyhuYW1lLCBkc2kp
IFwNCj4gKwkoKHZvaWQgX19mb3JjZSAqKSYoKCpkc2kpLnZwZ19kZWZzLm5hbWUpKQ0KPiArDQo+
ICsjZGVmaW5lIFJFR0lTVEVSKG5hbWUsIG1hc2ssIGRzaSkgXA0KPiArCXsgI25hbWUsIFZQR19E
RUZTKG5hbWUsIGRzaSksIG1hc2ssIGRzaSB9DQo+ICsNCj4gK3N0cnVjdCBkZWJ1Z2ZzX2VudHJp
ZXMgew0KPiArCWNvbnN0IGNoYXIJCQkJKm5hbWU7DQo+ICsJYm9vbAkJCQkJKnJlZzsNCj4gKwl1
MzIJCQkJCW1hc2s7DQo+ICsJc3RydWN0IGR3X21pcGlfZHNpCQkJKmRzaTsNCj4gK307DQo+ICsj
ZW5kaWYgLyogQ09ORklHX0RFQlVHX0ZTICovDQo+ICsNCj4gICBzdHJ1Y3QgZHdfbWlwaV9kc2kg
ew0KPiAgIAlzdHJ1Y3QgZHJtX2JyaWRnZSBicmlkZ2U7DQo+ICAgCXN0cnVjdCBtaXBpX2RzaV9o
b3N0IGRzaV9ob3N0Ow0KPiBAQCAtMjM4LDkgKzI1NCwxMiBAQCBzdHJ1Y3QgZHdfbWlwaV9kc2kg
ew0KPiAgIA0KPiAgICNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gICAJc3RydWN0IGRlbnRyeSAq
ZGVidWdmczsNCj4gLQ0KPiAtCWJvb2wgdnBnOw0KPiAtCWJvb2wgdnBnX2hvcml6b250YWw7DQo+
ICsJc3RydWN0IGRlYnVnZnNfZW50cmllcyAqZGVidWdmc192cGc7DQo+ICsJc3RydWN0IHsNCj4g
KwkJYm9vbCB2cGc7DQo+ICsJCWJvb2wgdnBnX2hvcml6b250YWw7DQo+ICsJCWJvb2wgdnBnX2Jl
cl9wYXR0ZXJuOw0KPiArCX0gdnBnX2RlZnM7DQo+ICAgI2VuZGlmIC8qIENPTkZJR19ERUJVR19G
UyAqLw0KPiAgIA0KPiAgIAlzdHJ1Y3QgZHdfbWlwaV9kc2kgKm1hc3RlcjsgLyogZHVhbC1kc2kg
bWFzdGVyIHB0ciAqLw0KPiBAQCAtNTMwLDkgKzU0OSwxMSBAQCBzdGF0aWMgdm9pZCBkd19taXBp
X2RzaV92aWRlb19tb2RlX2NvbmZpZyhzdHJ1Y3QgZHdfbWlwaV9kc2kgKmRzaSkNCj4gICAJCXZh
bCB8PSBWSURfTU9ERV9UWVBFX05PTl9CVVJTVF9TWU5DX0VWRU5UUzsNCj4gICANCj4gICAjaWZk
ZWYgQ09ORklHX0RFQlVHX0ZTDQo+IC0JaWYgKGRzaS0+dnBnKSB7DQo+ICsJaWYgKGRzaS0+dnBn
X2RlZnMudnBnKSB7DQo+ICAgCQl2YWwgfD0gVklEX01PREVfVlBHX0VOQUJMRTsNCj4gLQkJdmFs
IHw9IGRzaS0+dnBnX2hvcml6b250YWwgPyBWSURfTU9ERV9WUEdfSE9SSVpPTlRBTCA6IDA7DQo+
ICsJCXZhbCB8PSBkc2ktPnZwZ19kZWZzLnZwZ19ob3Jpem9udGFsID8NCj4gKwkJICAgICAgIFZJ
RF9NT0RFX1ZQR19IT1JJWk9OVEFMIDogMDsNCj4gKwkJdmFsIHw9IGRzaS0+dnBnX2RlZnMudnBn
X2Jlcl9wYXR0ZXJuID8gVklEX01PREVfVlBHX01PREUgOiAwOw0KPiAgIAl9DQo+ICAgI2VuZGlm
IC8qIENPTkZJR19ERUJVR19GUyAqLw0KPiAgIA0KPiBAQCAtOTYxLDYgKzk4Miw2OCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgZHdfbWlwaV9kc2lfYnJpZGdlX2Z1bmNz
ID0gew0KPiAgIA0KPiAgICNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gICANCj4gK2ludCBkd19t
aXBpX2RzaV9kZWJ1Z2ZzX3dyaXRlKHZvaWQgKmRhdGEsIHU2NCB2YWwpDQo+ICt7DQo+ICsJc3Ry
dWN0IGRlYnVnZnNfZW50cmllcyAqdnBnID0gZGF0YTsNCj4gKwlzdHJ1Y3QgZHdfbWlwaV9kc2kg
KmRzaTsNCj4gKwl1MzIgbW9kZV9jZmc7DQo+ICsNCj4gKwlpZiAoIXZwZykNCj4gKwkJcmV0dXJu
IC1FTk9ERVY7DQo+ICsNCj4gKwlkc2kgPSB2cGctPmRzaTsNCj4gKw0KPiArCSp2cGctPnJlZyA9
IChib29sKXZhbDsNCj4gKw0KPiArCW1vZGVfY2ZnID0gZHNpX3JlYWQoZHNpLCBEU0lfVklEX01P
REVfQ0ZHKTsNCj4gKw0KPiArCWlmICgqdnBnLT5yZWcpDQo+ICsJCW1vZGVfY2ZnIHw9IHZwZy0+
bWFzazsNCj4gKwllbHNlDQo+ICsJCW1vZGVfY2ZnICY9IH52cGctPm1hc2s7DQo+ICsNCj4gKwlk
c2lfd3JpdGUoZHNpLCBEU0lfVklEX01PREVfQ0ZHLCBtb2RlX2NmZyk7DQo+ICsNCj4gKwlyZXR1
cm4gMDsNCj4gK30NCj4gKw0KPiAraW50IGR3X21pcGlfZHNpX2RlYnVnZnNfc2hvdyh2b2lkICpk
YXRhLCB1NjQgKnZhbCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZGVidWdmc19lbnRyaWVzICp2cGcgPSBk
YXRhOw0KPiArDQo+ICsJaWYgKCF2cGcpDQo+ICsJCXJldHVybiAtRU5PREVWOw0KPiArDQo+ICsJ
KnZhbCA9ICp2cGctPnJlZzsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtERUZJ
TkVfREVCVUdGU19BVFRSSUJVVEUoZm9wc194MzIsIGR3X21pcGlfZHNpX2RlYnVnZnNfc2hvdywN
Cj4gKwkJCSBkd19taXBpX2RzaV9kZWJ1Z2ZzX3dyaXRlLCAiJWxsdVxuIik7DQo+ICsNCj4gK3N0
YXRpYyB2b2lkIGRlYnVnZnNfY3JlYXRlX2ZpbGVzKHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJc3Ry
dWN0IGR3X21pcGlfZHNpICpkc2kgPSBkYXRhOw0KPiArCXN0cnVjdCBkZWJ1Z2ZzX2VudHJpZXMg
ZGVidWdmc1tdID0gew0KPiArCQlSRUdJU1RFUih2cGcsIFZJRF9NT0RFX1ZQR19FTkFCTEUsIGRz
aSksDQo+ICsJCVJFR0lTVEVSKHZwZ19ob3Jpem9udGFsLCBWSURfTU9ERV9WUEdfSE9SSVpPTlRB
TCwgZHNpKSwNCj4gKwkJUkVHSVNURVIodnBnX2Jlcl9wYXR0ZXJuLCBWSURfTU9ERV9WUEdfTU9E
RSwgZHNpKSwNCj4gKwl9Ow0KPiArCWludCBpOw0KPiArDQo+ICsJZHNpLT5kZWJ1Z2ZzX3ZwZyA9
IGttYWxsb2Moc2l6ZW9mKGRlYnVnZnMpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWRzaS0+ZGVi
dWdmc192cGcpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCW1lbWNweShkc2ktPmRlYnVnZnNfdnBn
LCBkZWJ1Z2ZzLCBzaXplb2YoZGVidWdmcykpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUoZGVidWdmcyk7IGkrKykNCj4gKwkJZGVidWdmc19jcmVhdGVfZmlsZShkc2ktPmRl
YnVnZnNfdnBnW2ldLm5hbWUsIDA2NDQsDQo+ICsJCQkJICAgIGRzaS0+ZGVidWdmcywgJmRzaS0+
ZGVidWdmc192cGdbaV0sDQo+ICsJCQkJICAgICZmb3BzX3gzMik7DQo+ICt9DQo+ICsNCj4gICBz
dGF0aWMgdm9pZCBkd19taXBpX2RzaV9kZWJ1Z2ZzX2luaXQoc3RydWN0IGR3X21pcGlfZHNpICpk
c2kpDQo+ICAgew0KPiAgIAlkc2ktPmRlYnVnZnMgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25h
bWUoZHNpLT5kZXYpLCBOVUxMKTsNCj4gQEAgLTk2OSwxNCArMTA1MiwxMyBAQCBzdGF0aWMgdm9p
ZCBkd19taXBpX2RzaV9kZWJ1Z2ZzX2luaXQoc3RydWN0IGR3X21pcGlfZHNpICpkc2kpDQo+ICAg
CQlyZXR1cm47DQo+ICAgCX0NCj4gICANCj4gLQlkZWJ1Z2ZzX2NyZWF0ZV9ib29sKCJ2cGciLCAw
NjYwLCBkc2ktPmRlYnVnZnMsICZkc2ktPnZwZyk7DQo+IC0JZGVidWdmc19jcmVhdGVfYm9vbCgi
dnBnX2hvcml6b250YWwiLCAwNjYwLCBkc2ktPmRlYnVnZnMsDQo+IC0JCQkgICAgJmRzaS0+dnBn
X2hvcml6b250YWwpOw0KPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGVzKGRzaSk7DQo+ICAgfQ0KPiAg
IA0KPiAgIHN0YXRpYyB2b2lkIGR3X21pcGlfZHNpX2RlYnVnZnNfcmVtb3ZlKHN0cnVjdCBkd19t
aXBpX2RzaSAqZHNpKQ0KPiAgIHsNCj4gICAJZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKGRzaS0+
ZGVidWdmcyk7DQo+ICsJa2ZyZWUoZHNpLT5kZWJ1Z2ZzX3ZwZyk7DQo+ICAgfQ0KPiAgIA0KPiAg
ICNlbHNlDQo+IA==
