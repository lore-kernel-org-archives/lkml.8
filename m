Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93042C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B94E20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="z43s9fBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgFPLoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:44:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6688 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgFPLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:44:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GBZ0Wk012134;
        Tue, 16 Jun 2020 13:44:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=NneIqC9y5kxpsEMwdz4kWV76JLL/a0bbk4vzbiTymbc=;
 b=z43s9fBxwe8u1Z2wLMtNhnb0RgCk2+j4zVOjmfmdqMgo3IwbIS8GbmxYvcj//IJXntWk
 GdKCcRbNOz5K+anwkSwBrkQNbEzSByLg21e+rUUBJS0/3lFrpqBuQGWjtmL14FqZcwb1
 MpFcsh3ooNLRGAGLCINvnqiH0ZWA1LfwoJPAnvDdmxOBE+sPV2O1lT/aT7ycVzXDYFMt
 iWal/IIAk1jW1O1f/0yIOEQo+wZVP6Rz9BvEw9AMvxzfe6wfY/a6Hsl/ioxggnfxjyhS
 FkOokVv9rz7ncGceHH0TwkE3f0g+bnf5E2haGxSEGKDB3aFb1jryIzuHHaoTby2bQmgH bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mmjvy2ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 13:44:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13E23100034;
        Tue, 16 Jun 2020 13:44:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 024CB2C198C;
        Tue, 16 Jun 2020 13:44:02 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 16 Jun
 2020 13:44:01 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 16 Jun 2020 13:44:01 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Fabrice GASNIER <fabrice.gasnier@st.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v7 0/6] clockevent: add low power STM32 timer
Thread-Topic: [RESEND v7 0/6] clockevent: add low power STM32 timer
Thread-Index: AQHWOaYlv9Zz94A0REiA+Z4Po30KbajbEgYA
Date:   Tue, 16 Jun 2020 11:44:01 +0000
Message-ID: <50df6585-d9df-4cb3-5589-aab2c97cad51@st.com>
References: <20200603125439.23275-1-benjamin.gaignard@st.com>
In-Reply-To: <20200603125439.23275-1-benjamin.gaignard@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3A9FD8EF4B9F44C864F4556F63E33A2@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDYvMy8yMCAyOjU0IFBNLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4gVGhpcyBz
ZXJpZXMgYWRkIGxvdyBwb3dlciB0aW1lciBhcyBib2FkY2FzdCBjbG9ja2V2ZW50IGRldmljZS4N
Cj4gTG93IHBvd2VyIHRpbWVyIGNvdWxkIHJ1bnMgZXZlbiB3aGVuIENQVXMgYXJlIGluIGlkbGUg
bW9kZSBhbmQNCj4gY291bGQgd2FrZXVwIHRoZW0uDQo+DQo+IExlZSBoYXMgYWNrZWQgdGhlIE1G
RCBwYXJ0Lg0KPiBDbG9ja3NvdXJjZSBkcml2ZXIgc3RpbGwgbmVlZCB0byBiZSByZXZpZXdlZCBi
eSBtYWludGFpbmVycy4NCj4gQWRkIG1pc3NpbmcgcGFydCBvZiB0aGUgYmluZGluZ3MgdG8gZGVz
Y3JpYmUgaW50ZXJydXB0Lg0KDQpIaSBMZWUsDQoNCkkgdGhpbmsgZXZlcnl0aGluZyBoYXMgYmVl
biByZXZpZXdlZCBhbmQgYWNrZWQgaW4gdGhpcyBzZXJpZXMuDQpNYXkgSSBoYXZlIGZvcmdvdCBz
b21ldGhpbmcgdGhhdCBwcmV2ZW50IGl0IHRvIGJlIG1lcmdlID8NCg0KQmVuamFtaW4NCg0KPg0K
PiB2ZXJzaW9uIDcgcmVzZW5kOg0KPiAtIHdpdGggRGFuaWVsIGFjayBmb3IgZHJpdmVyIHBhdGNo
DQo+IC0gd2l0aCBSb2IgcmV2aWV3IGZvciBiaW5kaW5ncyBwYXRjaA0KPg0KPiB2ZXJzaW9uIDc6
DQo+IC0gcmViYXNlZCBvbiB0b3Agb2YgdjUuNy1yYzINCj4NCj4gdmVyc2lvbiA2Og0KPiAtIHNp
bXBsaWZ5IGJpbmRpbmcsIERUIGFuZCBjb2RlIHRvIHVzZSBvbmx5IG9uZSBpbnRlcnJ1cHQNCj4N
Cj4gdmVyc2lvbiA1Og0KPiAtIGRvY3VtZW50IGludGVycnVwdHMgYW5kIGludGVycnVwdC1uYW1l
cyBiaW5kaW5ncw0KPiAtIHVzZSBhIGRpZmZlcmVudCB3YWtlIHVwIGludGVycnVwdA0KPiAtIGFk
ZCBkZXZpY2UtdHJlZSBwYXRjaA0KPiAtIG1ha2UgU1RNMzJNUDE1NyBzZWxlY3QgbG93IHBvd2Vy
IHRpbWVyIGNvbmZpZ3VyYXRpb24gZmxhZw0KPiAtIGVuYWJsZSBmYXN0X2lvIGluIHJlZ21hcCBj
b25maWd1cmF0aW9uDQo+DQo+IHZlcnNpb24gNDoNCj4gLSBtb3ZlIGRlZmluZXMgaW4gbWZkL3N0
bTMyLWxwdGltZXIuaA0KPiAtIGNoYW5nZSBjb21wYXRpYmxlIGFuZCBzdWJub2RlIG5hbWVzDQo+
IC0gZG9jdW1lbnQgd2FrZXVwLXNvdXJjZSBwcm9wZXJ0eQ0KPiAtIHJld29yZCBjb21taXQgbWVz
c2FnZQ0KPiAtIG1ha2UgZHJpdmVyIEtjb25maWcgZGVwZW5kcyBvZiBNRkRfU1RNMzJfTFBUSU1F
Ug0KPiAtIHJlbW92ZSB1c2VsZXNzIGluY2x1ZGUNCj4gLSByZW1vdmUgcmF0ZSBhbmQgY2xrIGZp
ZWxkcyBmcm9tIHRoZSBwcml2YXRlIHN0cnVjdHVyZQ0KPiAtIHRvIGFkZCBjb21tZW50cyBhYm91
dCB0aGUgcmVnaXN0ZXJzIHNlcXVlbmNlIGluIHN0bTMyX2Nsa2V2ZW50X2xwX3NldF90aW1lcg0K
PiAtIHJld29yayBwcm9iZSBmdW5jdGlvbiBhbmQgdXNlIGRldm1fcmVxdWVzdF9pcnEoKQ0KPiAt
IGRvIG5vdCBhbGxvdyBtb2R1bGUgdG8gYmUgcmVtb3ZlZA0KPg0KPiB2ZXJzaW9uIDM6DQo+IC0g
Zml4IHRpbWVyIHNldCBzZXF1ZW5jZQ0KPiAtIGRvbid0IGZvcmdldCB0byBmcmVlIGlycSBvbiBy
ZW1vdmUgZnVuY3Rpb24NCj4gLSB1c2UgZGV2bV9remFsbG9jIHRvIHNpbXBsaWZ5IGVycm9ycyBo
YW5kbGluZyBpbiBwcm9iZSBmdW5jdGlvbg0KPg0KPiB2ZXJzaW9uIDI6DQo+IC0gc3RtMzIgY2xr
ZXZlbnQgZHJpdmVyIGlzIG5vdyBhIGNoaWxkIG9mIHRoZSBzdG0zMiBscCB0aW1lciBub2RlDQo+
IC0gYWRkIGEgcHJvYmUgZnVuY3Rpb24gYW5kIGFkcGF0IHRoZSBkcml2ZXIgdG8gdXNlIHJlZ21h
cCBwcm92aWRlDQo+ICAgIGJ5IGl0IHBhcmVudA0KPiAtIHN0b3AgdXNpbmcgdGltZXJfb2YgaGVs
cGVycw0KPg0KPg0KPiBCZW5qYW1pbiBHYWlnbmFyZCAoNik6DQo+ICAgIGR0LWJpbmRpbmdzOiBt
ZmQ6IERvY3VtZW50IFNUTTMyIGxvdyBwb3dlciB0aW1lciBiaW5kaW5ncw0KPiAgICBBUk06IGR0
czogc3RtMzI6IEFkZCB0aW1lciBzdWJub2RlcyBvbiBzdG0zMm1wMTUgU29Dcw0KPiAgICBtZmQ6
IHN0bTMyOiBBZGQgZGVmaW5lcyB0byBiZSB1c2VkIGZvciBjbGtldmVudCBwdXJwb3NlDQo+ICAg
IG1mZDogc3RtMzI6IGVuYWJsZSByZWdtYXAgZmFzdF9pbyBmb3Igc3RtMzItbHB0aW1lcg0KPiAg
ICBjbG9ja3NvdXJjZTogQWRkIExvdyBQb3dlciBTVE0zMiB0aW1lcnMgZHJpdmVyDQo+ICAgIEFS
TTogbWFjaC1zdG0zMjogc2VsZWN0IGxvdyBwb3dlciB0aW1lciBmb3IgU1RNMzJNUDE1Nw0KPg0K
PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zdCxzdG0zMi1scHRpbWVyLnlhbWwgIHwg
ICA1ICsNCj4gICBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTUxLmR0c2kgICAgICAgICAgICAg
ICAgICB8ICAzNSArKysrDQo+ICAgYXJjaC9hcm0vbWFjaC1zdG0zMi9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gICBkcml2ZXJzL2Nsb2Nrc291cmNlL01h
a2VmaWxlICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVycy9jbG9ja3Nv
dXJjZS90aW1lci1zdG0zMi1scC5jICAgICAgICAgICAgICAgfCAyMjEgKysrKysrKysrKysrKysr
KysrKysrDQo+ICAgZHJpdmVycy9tZmQvc3RtMzItbHB0aW1lci5jICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgIGluY2x1ZGUvbGludXgvbWZkL3N0bTMyLWxwdGltZXIuaCAgICAg
ICAgICAgICAgICAgIHwgICA1ICsNCj4gICA4IGZpbGVzIGNoYW5nZWQsIDI3MyBpbnNlcnRpb25z
KCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItc3Rt
MzItbHAuYw0KPg0K
