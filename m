Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF08C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91F2071E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IixsFQVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBTKpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:45:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1461 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbgBTKpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:45:31 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAi29q028248;
        Thu, 20 Feb 2020 11:45:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=SDLZfN1PVeIeP/oOuE8HENlAFs0IpyTU/Nnjdty9yds=;
 b=IixsFQVL+jgkNMKo+P9LaxgTZZfri46T2GD8br/B8mN71/ZLgHHRSDxp3oG9oT4MLdtA
 +XH/1212Z4GtB+72p6qxZjDzpuyIg9EnpmZnzVh0/azD80xba8VdBaX7MN0rRBwZqtjd
 LRSEmA/AUiaX/eAHPp3glPVR9jufAp6bSvOcQ/Z7g7wJ3Ljar/eo7wVzUbZAABjEBSPV
 mwRxFr4MhFfcYDyXtUVxReOqHj6WHWs4JBlLHdMXhqxntgfDWYobvr464d9ctcpfTFK+
 SX/c8e9Pqp0c7Ytu68FJhHxxyuena0DiZijktOBIDOAMx3vM6aiz38k5YncJ5nMAKAtl kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y8ub1gdap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 11:45:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E1B910002A;
        Thu, 20 Feb 2020 11:45:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCACC2AAEB9;
        Thu, 20 Feb 2020 11:45:06 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 11:45:06 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 20 Feb 2020 11:45:05 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v4 3/3] clocksource: Add Low Power STM32 timers driver
Thread-Topic: [PATCH v4 3/3] clocksource: Add Low Power STM32 timers driver
Thread-Index: AQHV59mpsik/WRqXdUuknFgx3rC1tqgj1SiA
Date:   Thu, 20 Feb 2020 10:45:05 +0000
Message-ID: <9cc4af9e-27d0-96c3-b3f1-20c88f89b70a@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-4-benjamin.gaignard@st.com>
 <687ab83c-6381-57aa-3bc1-3628e27644b5@linaro.org>
In-Reply-To: <687ab83c-6381-57aa-3bc1-3628e27644b5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <875F2F9A967A304E9315302279A4D65A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMjAvMjAgMTE6MzYgQU0sIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiBPbiAxNy8w
Mi8yMDIwIDE0OjQ1LCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+IEZyb206IEJlbmphbWlu
IEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5hcm8ub3JnPg0KPj4NCj4+IEltcGxlbWVu
dCBjbG9jayBldmVudCBkcml2ZXIgdXNpbmcgbG93IHBvd2VyIFNUTTMyIHRpbWVycy4NCj4+IExv
dyBwb3dlciB0aW1lciBjb3VudGVycyBydW5uaW5nIGV2ZW4gd2hlbiBDUFVzIGFyZSBzdG9wcGVk
Lg0KPj4gSXQgY291bGQgYmUgdXNlZCBhcyBjbG9jayBldmVudCBicm9hZGNhc3RlciB0byB3YWtl
IHVwIENQVXMgYnV0IG5vdCBsaWtlDQo+PiBhIGNsb2Nrc291cmNlIGJlY2F1c2UgZWFjaCBpdCBy
aXNlIGFuIGludGVycnVwdCB0aGUgY291bnRlciByZXN0YXJ0IGZyb20gMC4NCj4+DQo+PiBMb3cg
cG93ZXIgdGltZXJzIGhhdmUgYSAxNiBiaXRzIGNvdW50ZXIgYW5kIGEgcHJlc2NhbGVyIHdoaWNo
IGFsbG93IHRvDQo+PiBkaXZpZGUgdGhlIGNsb2NrIHBlciBwb3dlciBvZiAyIHRvIHVwIDEyOCB0
byB0YXJnZXQgYSAzMktIeiByYXRlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdh
aWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5hcm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTog
UGFzY2FsIFBhaWxsZXQgPHAucGFpbGxldEBzdC5jb20+DQo+PiAtLS0NCj4+IHZlcnNpb24gNDoN
Cj4+IC0gbW92ZSBkZWZpbmVzIGluIG1mZC9zdG0zMi1scHRpbWVyLmgNCj4+IC0gY2hhbmdlIGNv
bXBhdGlibGVuYW1lDQo+PiAtIHJld29yZCBjb21taXQgbWVzc2FnZQ0KPj4gLSBtYWtlIGRyaXZl
ciBLY29uZmlnIGRlcGVuZHMgb2YgTUZEX1NUTTMyX0xQVElNRVINCj4+IC0gcmVtb3ZlIHVzZWxl
c3MgaW5jbHVkZQ0KPj4gLSByZW1vdmUgcmF0ZSBhbmQgY2xrIGZpZWxkcyBmcm9tIHRoZSBwcml2
YXRlIHN0cnVjdHVyZQ0KPj4gLSB0byBhZGQgY29tbWVudHMgYWJvdXQgdGhlIHJlZ2lzdGVycyBz
ZXF1ZW5jZSBpbiBzdG0zMl9jbGtldmVudF9scF9zZXRfdGltZXINCj4+IC0gcmV3b3JrIHByb2Jl
IGZ1bmN0aW9uIGFuZCB1c2UgZGV2bV9yZXF1ZXN0X2lycSgpDQo+PiAtIGRvIG5vdCBhbGxvdyBt
b2R1bGUgdG8gYmUgcmVtb3ZlZA0KPj4gLSBtYWtlIHN1cmUgdGhhdCB3YWtldXAgaW50ZXJydXB0
IGlzIHNldA0KPj4NCj4+ICAgZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnICAgICAgICAgIHwg
ICA3ICsrDQo+PiAgIGRyaXZlcnMvY2xvY2tzb3VyY2UvTWFrZWZpbGUgICAgICAgICB8ICAgMSAr
DQo+PiAgIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItc3RtMzItbHAuYyB8IDIxMyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDIyMSBp
bnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsb2Nrc291cmNl
L3RpbWVyLXN0bTMyLWxwLmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJj
ZS9LY29uZmlnIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnDQo+PiBpbmRleCBjYzkwOWU0
NjU4MjMuLjlmYzJiNTEzZGI2ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2Uv
S2NvbmZpZw0KPj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnDQo+PiBAQCAtMjky
LDYgKzI5MiwxMyBAQCBjb25maWcgQ0xLU1JDX1NUTTMyDQo+PiAgIAlzZWxlY3QgQ0xLU1JDX01N
SU8NCj4+ICAgCXNlbGVjdCBUSU1FUl9PRg0KPj4gICANCj4+ICtjb25maWcgQ0xLU1JDX1NUTTMy
X0xQDQo+PiArCWJvb2wgIkxvdyBwb3dlciBjbG9ja3NvdXJjZSBmb3IgU1RNMzIgU29DcyINCj4+
ICsJZGVwZW5kcyBvbiBNRkRfU1RNMzJfTFBUSU1FUiB8fCBDT01QSUxFX1RFU1QNCj4+ICsJaGVs
cA0KPj4gKwkgIFRoaXMgb3B0aW9uIGVuYWJsZXMgc3VwcG9ydCBmb3IgU1RNMzIgbG93IHBvd2Vy
IGNsb2NrZXZlbnQgYXZhaWxhYmxlDQo+PiArCSAgb24gU1RNMzIgU29Dcw0KPj4gKw0KPj4gICBj
b25maWcgQ0xLU1JDX01QUzINCj4+ICAgCWJvb2wgIkNsb2Nrc291cmNlIGZvciBNUFMyIFNvQ3Mi
IGlmIENPTVBJTEVfVEVTVA0KPj4gICAJZGVwZW5kcyBvbiBHRU5FUklDX1NDSEVEX0NMT0NLDQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9NYWtlZmlsZSBiL2RyaXZlcnMvY2xv
Y2tzb3VyY2UvTWFrZWZpbGUNCj4+IGluZGV4IDcxMzY4NmZhYTU0OS4uYzAwZmZmYmQ0NzY5IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9NYWtlZmlsZQ0KPj4gKysrIGIvZHJp
dmVycy9jbG9ja3NvdXJjZS9NYWtlZmlsZQ0KPj4gQEAgLTQ0LDYgKzQ0LDcgQEAgb2JqLSQoQ09O
RklHX0JDTV9LT05BX1RJTUVSKQkrPSBiY21fa29uYV90aW1lci5vDQo+PiAgIG9iai0kKENPTkZJ
R19DQURFTkNFX1RUQ19USU1FUikJKz0gdGltZXItY2FkZW5jZS10dGMubw0KPj4gICBvYmotJChD
T05GSUdfQ0xLU1JDX0VGTTMyKQkrPSB0aW1lci1lZm0zMi5vDQo+PiAgIG9iai0kKENPTkZJR19D
TEtTUkNfU1RNMzIpCSs9IHRpbWVyLXN0bTMyLm8NCj4+ICtvYmotJChDT05GSUdfQ0xLU1JDX1NU
TTMyX0xQKQkrPSB0aW1lci1zdG0zMi1scC5vDQo+PiAgIG9iai0kKENPTkZJR19DTEtTUkNfRVhZ
Tk9TX01DVCkJKz0gZXh5bm9zX21jdC5vDQo+PiAgIG9iai0kKENPTkZJR19DTEtTUkNfTFBDMzJY
WCkJKz0gdGltZXItbHBjMzJ4eC5vDQo+PiAgIG9iai0kKENPTkZJR19DTEtTUkNfTVBTMikJKz0g
bXBzMi10aW1lci5vDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1z
dG0zMi1scC5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1zdG0zMi1scC5jDQo+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi41MGVlY2RiODgyMTYNCj4+
IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItc3RtMzIt
bHAuYw0KPj4gQEAgLTAsMCArMSwyMTMgQEANCj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPj4gKy8qDQo+PiArICogQ29weXJpZ2h0IChDKSBTVE1pY3JvZWxlY3Ryb25p
Y3MgMjAxOSAtIEFsbCBSaWdodHMgUmVzZXJ2ZWQNCj4+ICsgKiBBdXRob3JzOiBCZW5qYW1pbiBH
YWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPiBmb3IgU1RNaWNyb2VsZWN0cm9uaWNz
Lg0KPj4gKyAqCSAgICBQYXNjYWwgUGFpbGxldCA8cC5wYWlsbGV0QHN0LmNvbT4gZm9yIFNUTWlj
cm9lbGVjdHJvbmljcy4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L2Nsb2NrY2hpcHMuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgv
aW50ZXJydXB0Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L21mZC9zdG0zMi1scHRpbWVyLmg+DQo+
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRy
ZXNzLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcG1fd2FrZWlycS5oPg0K
Pj4gKw0KPj4gKyNkZWZpbmUgQ0ZHUl9QU0NfT0ZGU0VUCQk5DQo+PiArI2RlZmluZSBTVE0zMl9M
UF9SQVRJTkcJCTQwMA0KPj4gKyNkZWZpbmUgU1RNMzJfVEFSR0VUX0NMS1JBVEUJKDMyMDAwICog
SFopDQo+PiArI2RlZmluZSBTVE0zMl9MUF9NQVhfUFNDCTcNCj4+ICsNCj4+ICtzdHJ1Y3Qgc3Rt
MzJfbHBfcHJpdmF0ZSB7DQo+PiArCXN0cnVjdCByZWdtYXAgKnJlZzsNCj4+ICsJc3RydWN0IGNs
b2NrX2V2ZW50X2RldmljZSBjbGtldnQ7DQo+PiArCXVuc2lnbmVkIGxvbmcgcGVyaW9kOw0KPj4g
K307DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBzdG0zMl9scF9wcml2YXRlKg0KPj4gK3RvX3By
aXYoc3RydWN0IGNsb2NrX2V2ZW50X2RldmljZSAqY2xrZXZ0KQ0KPj4gK3sNCj4+ICsJcmV0dXJu
IGNvbnRhaW5lcl9vZihjbGtldnQsIHN0cnVjdCBzdG0zMl9scF9wcml2YXRlLCBjbGtldnQpOw0K
Pj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHN0bTMyX2Nsa2V2ZW50X2xwX3NodXRkb3duKHN0
cnVjdCBjbG9ja19ldmVudF9kZXZpY2UgKmNsa2V2dCkNCj4+ICt7DQo+PiArCXN0cnVjdCBzdG0z
Ml9scF9wcml2YXRlICpwcml2ID0gdG9fcHJpdihjbGtldnQpOw0KPj4gKw0KPj4gKwlyZWdtYXBf
d3JpdGUocHJpdi0+cmVnLCBTVE0zMl9MUFRJTV9DUiwgMCk7DQo+PiArCXJlZ21hcF93cml0ZShw
cml2LT5yZWcsIFNUTTMyX0xQVElNX0lFUiwgMCk7DQo+PiArCS8qIGNsZWFyIHBlbmRpbmcgZmxh
Z3MgKi8NCj4+ICsJcmVnbWFwX3dyaXRlKHByaXYtPnJlZywgU1RNMzJfTFBUSU1fSUNSLCBTVE0z
Ml9MUFRJTV9BUlJNQ0YpOw0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIGludCBzdG0zMl9jbGtldmVudF9scF9zZXRfdGltZXIodW5zaWduZWQgbG9uZyBldnQs
DQo+PiArCQkJCSAgICAgICBzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpjbGtldnQsDQo+PiAr
CQkJCSAgICAgICBpbnQgaXNfcGVyaW9kaWMpDQo+PiArew0KPj4gKwlzdHJ1Y3Qgc3RtMzJfbHBf
cHJpdmF0ZSAqcHJpdiA9IHRvX3ByaXYoY2xrZXZ0KTsNCj4+ICsNCj4+ICsJLyogZGlzYWJsZSBM
UFRJTUVSIHRvIGJlIGFibGUgdG8gd3JpdGUgaW50byBJRVIgcmVnaXN0ZXIqLw0KPj4gKwlyZWdt
YXBfd3JpdGUocHJpdi0+cmVnLCBTVE0zMl9MUFRJTV9DUiwgMCk7DQo+PiArCS8qIGVuYWJsZSBB
UlIgaW50ZXJydXB0ICovDQo+PiArCXJlZ21hcF93cml0ZShwcml2LT5yZWcsIFNUTTMyX0xQVElN
X0lFUiwgU1RNMzJfTFBUSU1fQVJSTUlFKTsNCj4+ICsJLyogZW5hYmxlIExQVElNRVIgdG8gYmUg
YWJsZSB0byB3cml0ZSBpbnRvIEFSUiByZWdpc3RlciAqLw0KPj4gKwlyZWdtYXBfd3JpdGUocHJp
di0+cmVnLCBTVE0zMl9MUFRJTV9DUiwgU1RNMzJfTFBUSU1fRU5BQkxFKTsNCj4+ICsJLyogc2V0
IG5leHQgZXZlbnQgY291bnRlciAqLw0KPj4gKwlyZWdtYXBfd3JpdGUocHJpdi0+cmVnLCBTVE0z
Ml9MUFRJTV9BUlIsIGV2dCk7DQo+PiArDQo+PiArCS8qIHN0YXJ0IGNvdW50ZXIgKi8NCj4+ICsJ
aWYgKGlzX3BlcmlvZGljKQ0KPj4gKwkJcmVnbWFwX3dyaXRlKHByaXYtPnJlZywgU1RNMzJfTFBU
SU1fQ1IsDQo+PiArCQkJICAgICBTVE0zMl9MUFRJTV9DTlRTVFJUIHwgU1RNMzJfTFBUSU1fRU5B
QkxFKTsNCj4+ICsJZWxzZQ0KPj4gKwkJcmVnbWFwX3dyaXRlKHByaXYtPnJlZywgU1RNMzJfTFBU
SU1fQ1IsDQo+PiArCQkJICAgICBTVE0zMl9MUFRJTV9TTkdTVFJUIHwgU1RNMzJfTFBUSU1fRU5B
QkxFKTsNCj4gVGhlIHJlZ21hcCBjb25maWcgaW4gc3RtMzItbHB0aW1lciBpcyBub3QgZGVmaW5l
ZCB3aXRoIHRoZSBmYXN0X2lvIGZsYWcNCj4gKG9uIHB1cnBvc2Ugb3Igbm90PykgdGhhdCBtZWFu
cyB3ZSBjYW4gcG90ZW50aWFsbHkgZGVhZGxvY2sgaGVyZSBhcyB0aGUNCj4gbG9jayBpcyBhIG11
dGV4Lg0KPg0KPiBJc24ndCBpdCBkZXRlY3RlZCB3aXRoIHRoZSBsb2NrIHZhbGlkYXRpb24gc2No
ZW1lPw0KSXQgd2Fzbid0IGEgcHJvYmxlbSB3aXRoIG90aGVyIHBhcnRzIG9mIHRoZSBtZmQgYW5k
IEkgZG9uJ3Qgbm90aWNlIA0KaXNzdWVzIHNvIEkgZ3Vlc3MgaXQgaXMgb2suDQo+DQo+PiArCXJl
dHVybiAwOw0KPj4gK30NCj4+ICtzdGF0aWMgaW50IHN0bTMyX2Nsa2V2ZW50X2xwX3JlbW92ZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gK3sNCj4+ICsJcmV0dXJuIC1FQlVTWTsg
LyogY2Fubm90IHVucmVnaXN0ZXIgY2xvY2tldmVudCAqLw0KPj4gK30NCj4gV29uJ3QgYmUgdGhl
IG1mZCBpbnRvIGFuIGluY29uc2lzdGVudCBzdGF0ZSBoZXJlPyBUaGUgb3RoZXIgc3Vic3lzdGVt
cw0KPiB3aWxsIGJlIHJlbW92ZWQgYnV0IHRoaXMgb25lIHdpbGwgcHJldmVudCB0byB1bmxvYWQg
dGhlIG1vZHVsZSBsZWFkaW5nDQo+IHRvIGEgc2l0dWF0aW9uIHdoZXJlIHRoZSBtZmQgaXMgcGFy
dGlhbGx5IHJlbW92ZWQgYnV0IHN0aWxsIHRoZXJlDQo+IHdpdGhvdXQgYSBwb3NzaWJsZSByZWNv
dmVyeSwgbm8/DQpXZSBjYW4ndCBlbmFibGUgdGhlIHRpbWVyIHBhcnQgb2YgdGhlIG1mZCBhdCB0
aGUgc2FtZSB0aW1lIHRoYW4gdGhlIA0Kb3RoZXIgZmVhdHVyZXMuDQpJdCBoYXMgYmUgZXhjbHVz
aXZlIGFuZCB0aGF0IGV4Y2x1ZGUgdGhlIHByb2JsZW0geW91IGRlc2NyaWJlIGFib3ZlLg0KDQo+
DQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3RtMzJfY2xrZXZlbnRfbHBf
b2ZfbWF0Y2hbXSA9IHsNCj4+ICsJeyAuY29tcGF0aWJsZSA9ICJzdCxzdG0zMi1scHRpbWVyLXRp
bWVyIiwgfSwNCj4+ICsJe30sDQo+PiArfTsNCj4+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBz
dG0zMl9jbGtldmVudF9scF9vZl9tYXRjaCk7DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBwbGF0
Zm9ybV9kcml2ZXIgc3RtMzJfY2xrZXZlbnRfbHBfZHJpdmVyID0gew0KPj4gKwkucHJvYmUJPSBz
dG0zMl9jbGtldmVudF9scF9wcm9iZSwNCj4+ICsJLnJlbW92ZSA9IHN0bTMyX2Nsa2V2ZW50X2xw
X3JlbW92ZSwNCj4+ICsJLmRyaXZlcgk9IHsNCj4+ICsJCS5uYW1lID0gInN0bTMyLWxwdGltZXIt
dGltZXIiLA0KPj4gKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHN0bTMyX2Nsa2V2
ZW50X2xwX29mX21hdGNoKSwNCj4+ICsJfSwNCj4+ICt9Ow0KPg0K
