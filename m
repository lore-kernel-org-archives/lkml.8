Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7672469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tdkTQz+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgB1OtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:49:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:63173 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbgB1OtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:49:08 -0500
X-UUID: 138b06b591704c6280134076cf712b37-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=S8rYojz3CCXZsrWk7K/95dRmIjgQg2sAN3aYNGrhVNU=;
        b=tdkTQz+/pxE8T8E9ABQZY6jLqaEt9mCR2M84Q9jFd/Wo2sIHnlBkybhd916CA5vHQXJgQyO+dO0nBvqqa2tXy6R1YMcHDacsGlZDzy2xI6p+Is9L0QfV2xmkvGtzZRFuiRiqYxxva+ioihsXHP5wD+VaVnUrBOzvNkJYduRdymw=;
X-UUID: 138b06b591704c6280134076cf712b37-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 820977458; Fri, 28 Feb 2020 22:49:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 22:48:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 22:48:54 +0800
Message-ID: <1582901342.14824.4.camel@mtksdaap41>
Subject: Re: [PATCH v3 07/13] soc: mediatek: cmdq: add write_s function
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
Date:   Fri, 28 Feb 2020 22:49:02 +0800
In-Reply-To: <1582897461-15105-9-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-9-git-send-email-dennis-yc.hsieh@mediatek.com>
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
WUMgSHNpZWggd3JvdGU6DQo+IGFkZCB3cml0ZV9zIGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1
bmN0aW9ucyB3aGljaA0KPiB3cml0ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0
ZXIgdG8gYWRkcmVzcw0KPiB3aXRoIGxhcmdlIGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCj4gDQoNClJl
dmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMzQgKysrKysrKysr
KysrKysrKysrKysrKystDQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIHwgIDIgKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAg
fCAyMCArKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KPiBpbmRleCA4MzQyYTVjOTRiYzcuLjY4YjQyYzkzNWZlNiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTE4LDYgKzE4LDEwIEBAIHN0cnVjdCBj
bWRxX2luc3RydWN0aW9uIHsNCj4gIAl1bmlvbiB7DQo+ICAJCXUzMiB2YWx1ZTsNCj4gIAkJdTMy
IG1hc2s7DQo+ICsJCXN0cnVjdCB7DQo+ICsJCQl1MTYgYXJnX2M7DQo+ICsJCQl1MTYgc3JjX3Jl
ZzsNCj4gKwkJfTsNCj4gIAl9Ow0KPiAgCXVuaW9uIHsNCj4gIAkJdTE2IG9mZnNldDsNCj4gQEAg
LTI5LDcgKzMzLDcgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KPiAgCQlzdHJ1Y3Qgew0K
PiAgCQkJdTggc29wOjU7DQo+ICAJCQl1OCBhcmdfY190OjE7DQo+IC0JCQl1OCBhcmdfYl90OjE7
DQo+ICsJCQl1OCBzcmNfdDoxOw0KPiAgCQkJdTggZHN0X3Q6MTsNCj4gIAkJfTsNCj4gIAl9Ow0K
PiBAQCAtMjIyLDYgKzIyNiwzNCBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93
cml0ZV9tYXNrKTsNCj4gIA0KPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gKwkJICAgICB1MTYgYWRkcl9sb3csIHUx
NiBzcmNfcmVnX2lkeCwgdTMyIG1hc2spDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gaW5zdCA9IHsgezB9IH07DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWlmIChtYXNrICE9IFUz
Ml9NQVgpIHsNCj4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KPiArCQlpbnN0Lm1hc2sg
PSB+bWFzazsNCj4gKwkJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsN
Cj4gKwkJaWYgKGVyciA8IDApDQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJCWluc3QubWFz
ayA9IDA7DQo+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfU19NQVNLOw0KPiArCX0gZWxz
ZSB7DQo+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCj4gKwl9DQo+ICsNCj4gKwlp
bnN0LnNyY190ID0gQ01EUV9SRUdfVFlQRTsNCj4gKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdf
aWR4Ow0KPiArCWluc3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQo+ICsJaW5zdC5zcmNfcmVnID0gc3Jj
X3JlZ19pZHg7DQo+ICsNCj4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBp
bnN0KTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfcyk7DQo+ICsNCj4g
IGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+IGluZGV4IDEyMWMzYmI2ZDNkZS4uOGVm
ODdlMWJkMDNiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmgNCj4gQEAgLTU5LDYgKzU5LDggQEAgZW51bSBjbWRxX2NvZGUgew0KPiAgCUNNRFFfQ09ERV9K
VU1QID0gMHgxMCwNCj4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gIAlDTURRX0NPREVfRU9D
ID0gMHg0MCwNCj4gKwlDTURRX0NPREVfV1JJVEVfUyA9IDB4OTAsDQo+ICsJQ01EUV9DT0RFX1dS
SVRFX1NfTUFTSyA9IDB4OTEsDQo+ICAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4gIH07DQo+
ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
Yi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IGluZGV4IDgzMzQwMjEx
ZTFkMy4uYzcyZDgyNmQ4OTM0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gQEAgLTEyLDYgKzEyLDggQEANCj4gICNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0K
PiAgDQo+ICAjZGVmaW5lIENNRFFfTk9fVElNRU9VVAkJMHhmZmZmZmZmZnUNCj4gKyNkZWZpbmUg
Q01EUV9BRERSX0hJR0goYWRkcikJKCh1MzIpKCgoYWRkcikgPj4gMTYpICYgR0VOTUFTSygzMSwg
MCkpKQ0KPiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShhZGRyKSB8IEJJVCgx
KSkNCj4gIA0KPiAgc3RydWN0IGNtZHFfcGt0Ow0KPiAgDQo+IEBAIC0xMDIsNiArMTA0LDI0IEBA
IGludCBjbWRxX3BrdF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLCB1MTYg
b2Zmc2V0LCB1MzIgdmFsdWUpOw0KPiAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gIAkJCXUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMy
IG1hc2spOw0KPiAgDQo+ICsvKioNCj4gKyAqIGNtZHFfcGt0X3dyaXRlX3MoKSAtIGFwcGVuZCB3
cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBw
YWNrZXQNCj4gKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXNnZXIgSUQgd2hp
Y2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQo+ICsgKiBAYWRkcl9sb3c6CWxvdyBhZGRy
ZXNzIG9mIHBhDQo+ICsgKiBAc3JjX3JlZ19pZHg6CXRoZSBDTURRIGludGVybmFsIHJlZ2lzdGVy
IElEIHdoaWNoIGNhY2hlIHNvdXJjZSB2YWx1ZQ0KPiArICogQG1hc2s6CXRoZSBzcGVjaWZpZWQg
dGFyZ2V0IGFkZHJlc3MgbWFzaywgdXNlIFUzMl9NQVggaWYgbm8gbmVlZA0KPiArICoNCj4gKyAq
IFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0K
PiArICoNCj4gKyAqIFN1cHBvcnQgd3JpdGUgdmFsdWUgdG8gcGh5c2ljYWwgYWRkcmVzcyB3aXRo
b3V0IHN1YnN5cy4gVXNlIENNRFFfQUREUl9ISUdIKCkNCj4gKyAqIHRvIGdldCBoaWdoIGFkZHJl
ZXMgYW5kIGNhbGwgY21kcV9wa3RfYXNzaWduKCkgdG8gYXNzaWduIHZhbHVlIGludG8gaW50ZXJu
YWwNCj4gKyAqIHJlZy4gQWxzbyB1c2UgQ01EUV9BRERSX0xPVygpIHRvIGdldCBsb3cgYWRkcmVz
cyBmb3IgYWRkcl9sb3cgcGFyYW1ldGVyd2hlbg0KPiArICogY2FsbCB0byB0aGlzIGZ1bmN0aW9u
Lg0KPiArICovDQo+ICtpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiArCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19y
ZWdfaWR4LCB1MzIgbWFzayk7DQo+ICsNCj4gIC8qKg0KPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBh
cHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gICAqIEBw
a3Q6CXRoZSBDTURRIHBhY2tldA0KDQo=

