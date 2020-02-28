Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B6E2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OyD/T0rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgB1Ou3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:50:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:62274 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726905AbgB1Ou2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:50:28 -0500
X-UUID: 82bc67a19d344b1d90a1b70cde1a4245-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3ueQZiL6nqQ1TnauprptHOqb48LlnkrdGjJXo+9vhGU=;
        b=OyD/T0rHPJluiKZmsYCpVCfNxrZEWj6P/RAkBv8mn6qz7q5iMYYxubn44OcoPPMCDzZNm5Wq2FkazYipVl2yW486eDt1G3KflhAvJiGq6Q3aY2oM/5OUO1TqlVVgKyeRvmJKldZlFv7gdUnI+r/3dW2d1ysSMsNs5uMUVDC2heM=;
X-UUID: 82bc67a19d344b1d90a1b70cde1a4245-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 658126459; Fri, 28 Feb 2020 22:50:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 22:49:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 22:50:11 +0800
Message-ID: <1582901419.14824.5.camel@mtksdaap41>
Subject: Re: [PATCH v3 08/13] soc: mediatek: cmdq: add read_s function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Fri, 28 Feb 2020 22:50:19 +0800
In-Reply-To: <1582897461-15105-10-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-10-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCByZWFkX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVu
Y3Rpb25zIHdoaWNoIHN1cHBvcnQgcmVhZCB2YWx1ZSBmcm9tDQo+IHJlZ2lzdGVyIG9yIGRtYSBw
aHlzaWNhbCBhZGRyZXNzIGludG8gZ2NlIGludGVybmFsIHJlZ2lzdGVyLg0KPiANCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogRGVu
bmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAxNSArKysrKysrKysrKysr
KysNCj4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgMSArDQo+
ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMTMgKysrKysrKysr
KysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBpbmRleCA2OGI0MmM5MzVmZTYuLjQyOGY5
OTI4OGNhNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4g
QEAgLTIyNiw2ICsyMjYsMjEgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3Jp
dGVfbWFzayk7DQo+ICANCj4gK2ludCBjbWRxX3BrdF9yZWFkX3Moc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwgdTE2IGFkZHJfbG93LA0KPiArCQkgICAgdTE2IHJl
Z19pZHgpDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07
DQo+ICsNCj4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1JFQURfUzsNCj4gKwlpbnN0LmRzdF90ID0g
Q01EUV9SRUdfVFlQRTsNCj4gKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KPiArCWlu
c3QucmVnX2RzdCA9IHJlZ19pZHg7DQo+ICsJaW5zdC5zcmNfcmVnID0gYWRkcl9sb3c7DQo+ICsN
Cj4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gK30NCj4g
K0VYUE9SVF9TWU1CT0woY21kcV9wa3RfcmVhZF9zKTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X3dy
aXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gIAkJ
ICAgICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCwgdTMyIG1hc2spDQo+ICB7DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5j
bHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBpbmRleCA4ZWY4N2UxYmQw
M2IuLjNmNmJjMGRmZDVkYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210
ay1jbWRxLW1haWxib3guaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+IEBAIC01OSw2ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gIAlDTURR
X0NPREVfSlVNUCA9IDB4MTAsDQo+ICAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQo+ICAJQ01EUV9D
T0RFX0VPQyA9IDB4NDAsDQo+ICsJQ01EUV9DT0RFX1JFQURfUyA9IDB4ODAsDQo+ICAJQ01EUV9D
T0RFX1dSSVRFX1MgPSAweDkwLA0KPiAgCUNNRFFfQ09ERV9XUklURV9TX01BU0sgPSAweDkxLA0K
PiAgCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiBpbmRleCBjNzJkODI2ZDg5MzQuLjAxYjQxODRhZjMxMCAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IEBAIC0xMDQsNiArMTA0LDE5IEBAIGlu
dCBjbWRxX3BrdF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLCB1MTYgb2Zm
c2V0LCB1MzIgdmFsdWUpOw0KPiAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gIAkJCXUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1h
c2spOw0KPiAgDQo+ICsvKg0KPiArICogY21kcV9wa3RfcmVhZF9zKCkgLSBhcHBlbmQgcmVhZF9z
IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQN
Cj4gKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXNnZXIgSUQgd2hpY2ggY29u
dGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQo+ICsgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNzIG9m
IHBhDQo+ICsgKiBAYWRkcjoJdGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1h
IHRvIHJlYWQNCj4gKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRCB0
byBjYWNoZSByZWFkIGRhdGENCj4gKyAqDQo+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVs
c2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gKyAqLw0KPiAraW50IGNtZHFfcGt0X3Jl
YWRfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LCB1MTYgYWRk
cl9sb3csDQo+ICsJCSAgICB1MTYgcmVnX2lkeCk7DQo+ICsNCj4gIC8qKg0KPiAgICogY21kcV9w
a3Rfd3JpdGVfcygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQN
Cj4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KDQo=

