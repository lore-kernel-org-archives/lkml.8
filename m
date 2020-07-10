Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD222078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BMa+iUzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgGJIoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:44:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31554 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726615AbgGJIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:44:09 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A8hugw023269;
        Fri, 10 Jul 2020 10:43:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+8RAqgZ8a6NmGd9X4MEqGphV/o8H2tk6T5fumgTJaC0=;
 b=BMa+iUzCxVZPujFHN2I4gIZj6BjgYEpeajwNDvln/iAsqeQ/6ehEXIXZSmUdpD1XZS85
 8JdK8nkqK5Kp8DfddPP1Lqk2nsZvlAEN3lEiK5RuROa2dQ47hxJPlzHyVGxa9PVgUltY
 r++upg1bRKPK1Xp5+KGYXzWxMNk3zpdNL/sT7wBimbX7KPoqW4kyjq+ayWTK4VOPwOxn
 Wn+KeOiJ4Y2ioJepy1XnM8AvooCx56rM5aYaeJRrOWCN9egwiXkx6PJ+Q+cLBYXTKwmF
 vcvqswmPoKw5Iqvih+UTh13+JBM+pUrLEXbvHeCqRum/6O2gOmpJeGHOFfYZr7BWSZd5 hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k3w237d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 10:43:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FBD710002A;
        Fri, 10 Jul 2020 10:43:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 679412AD2BB;
        Fri, 10 Jul 2020 10:43:52 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 10:43:52 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 10 Jul 2020 10:43:51 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Antonio BORNEO <antonio.borneo@st.com>
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: allow LP commands in video
 mode
Thread-Topic: [PATCH v2] drm/bridge/synopsys: dsi: allow LP commands in video
 mode
Thread-Index: AQHWVTFH38ZYMkorkkKnxOYVxCrrvKkAYIgA
Date:   Fri, 10 Jul 2020 08:43:51 +0000
Message-ID: <0df822a2-a6a6-0ec6-a6c2-a59b821113c3@st.com>
References: <20200708140836.32418-1-yannick.fertre@st.com>
In-Reply-To: <20200708140836.32418-1-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <87B46CB0E55D4F4C85FBFFD7D51061D7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_02:2020-07-10,2020-07-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvOC8yMCA0OjA4IFBNLCBZYW5uaWNrIEZlcnRyZSB3cm90ZToNCj4gRnJvbTogQW50
b25pbyBCb3JuZW8gPGFudG9uaW8uYm9ybmVvQHN0LmNvbT4NCj4gDQo+IEN1cnJlbnQgY29kZSBv
bmx5IHNlbmRzIExQIGNvbW1hbmRzIGluIGNvbW1hbmQgbW9kZS4NCj4gDQo+IEFsbG93cyBzZW5k
aW5nIExQIGNvbW1hbmRzIGFsc28gaW4gdmlkZW8gbW9kZSBieSBzZXR0aW5nIHRoZQ0KPiBwcm9w
ZXIgZmxhZyBpbiBEU0lfVklEX01PREVfQ0ZHLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW50b25p
byBCb3JuZW8gPGFudG9uaW8uYm9ybmVvQHN0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jIHwgOCArKysrKysrKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYnJp
ZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4gaW5kZXggMWEyNGVhNjQ4ZWY4Li5lOWEwZjQy
ZmY5OWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHct
bWlwaS1kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1p
cGktZHNpLmMNCj4gQEAgLTg5LDYgKzg5LDcgQEANCj4gICAjZGVmaW5lIFZJRF9NT0RFX1RZUEVf
Tk9OX0JVUlNUX1NZTkNfRVZFTlRTCTB4MQ0KPiAgICNkZWZpbmUgVklEX01PREVfVFlQRV9CVVJT
VAkJCTB4Mg0KPiAgICNkZWZpbmUgVklEX01PREVfVFlQRV9NQVNLCQkJMHgzDQo+ICsjZGVmaW5l
IEVOQUJMRV9MT1dfUE9XRVJfQ01ECQlCSVQoMTUpDQo+ICAgI2RlZmluZSBWSURfTU9ERV9WUEdf
RU5BQkxFCQlCSVQoMTYpDQo+ICAgI2RlZmluZSBWSURfTU9ERV9WUEdfSE9SSVpPTlRBTAkJQklU
KDI0KQ0KPiAgIA0KPiBAQCAtMzc2LDYgKzM3NywxMyBAQCBzdGF0aWMgdm9pZCBkd19taXBpX21l
c3NhZ2VfY29uZmlnKHN0cnVjdCBkd19taXBpX2RzaSAqZHNpLA0KPiAgIA0KPiAgIAlkc2lfd3Jp
dGUoZHNpLCBEU0lfTFBDTEtfQ1RSTCwgbHBtID8gMCA6IFBIWV9UWFJFUVVFU1RDTEtIUyk7DQo+
ICAgCWRzaV93cml0ZShkc2ksIERTSV9DTURfTU9ERV9DRkcsIHZhbCk7DQo+ICsNCj4gKwl2YWwg
PSBkc2lfcmVhZChkc2ksIERTSV9WSURfTU9ERV9DRkcpOw0KPiArCWlmIChscG0pDQo+ICsJCXZh
bCB8PSBFTkFCTEVfTE9XX1BPV0VSX0NNRDsNCj4gKwllbHNlDQo+ICsJCXZhbCAmPSB+RU5BQkxF
X0xPV19QT1dFUl9DTUQ7DQo+ICsJZHNpX3dyaXRlKGRzaSwgRFNJX1ZJRF9NT0RFX0NGRywgdmFs
KTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGludCBkd19taXBpX2RzaV9nZW5fcGt0X2hkcl93
cml0ZShzdHJ1Y3QgZHdfbWlwaV9kc2kgKmRzaSwgdTMyIGhkcl92YWwpDQo+IA0KDQooKyBBbnRv
bmlvKQ0KDQpIaSBZYW5uaWNrICYgQW50b25pbywNCg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIENv
cm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQpUZXN0ZWQtYnk6IFBoaWxpcHBlIENvcm51IDxw
aGlsaXBwZS5jb3JudUBzdC5jb20+DQoNCihUZXN0ZWQgd2l0aCB0aGUgMyBwYXRjaGVzIG5hbWVk
DQpkcm0vYnJpZGdlL3N5bm9wc3lzOiBkc2k6IGFsbG93IExQIGNvbW1hbmRzIGluIHZpZGVvIG1v
ZGUNCmRybS9icmlkZ2Uvc3lub3BzeXM6IGRzaTogYWxsb3cgc2VuZGluZyBsb25nZXIgTFAgY29t
bWFuZHMNCmRybS9icmlkZ2Uvc3lub3BzeXM6IGRzaTogYWRkIHN1cHBvcnQgZm9yIG5vbi1jb250
aW51b3VzIEhTIGNsb2NrDQpvbiB2YXJpb3VzIGRzaSBicmlkZ2VzICsgc3RtMzJtcDE1NyBkaXNj
byBib2FyZCkNCg0KTWFueSB0aGFua3MNClBoaWxpcHBlIDotKQ==
