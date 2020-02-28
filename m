Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5997BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279F92469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rK2xvdfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgB1Oc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:32:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:28862 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726860AbgB1Oc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:32:56 -0500
X-UUID: 2e8db6e70c9c49dda18a0ffc1f66d1f1-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tCcBPOv9JtXBkELXSRqCsT2eYGkv19cNJithXm3gQmI=;
        b=rK2xvdfFpUEKoKLgQMQtPi0oTugLow49yQ9vccqNylPPRo0ThMvqO1nx9zBCZNJZ3MbgtWHT1sNLleghvtYcx10mPhdXGxnrCOyX97ekU01OSV3UtHax94Ns0XvPfjRduWQIT1khCC+TRsw7GqXLid2xZjfYnEeU0g3vNuFa/Xo=;
X-UUID: 2e8db6e70c9c49dda18a0ffc1f66d1f1-20200228
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1308984288; Fri, 28 Feb 2020 22:32:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 22:31:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 22:32:41 +0800
Message-ID: <1582900369.14824.2.camel@mtksdaap41>
Subject: Re: [PATCH v3 12/13] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
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
Date:   Fri, 28 Feb 2020 22:32:49 +0800
In-Reply-To: <1582897461-15105-14-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-14-git-send-email-dennis-yc.hsieh@mediatek.com>
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
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBjbGVhciBwYXJhbWV0ZXIgdG8gbGV0IGNsaWVudCBkZWNp
ZGUgaWYNCj4gZXZlbnQgc2hvdWxkIGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBt
ZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMgICB8IDUgKysrLS0NCj4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmggfCAzICstLQ0KPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAg
ICB8IDUgKysrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5k
ZXggYmJjNjhhN2M4MWU5Li40MDZlMWQzNGQyMzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0yOTUsMTUgKzI5NSwxNiBAQCBpbnQgY21kcV9wa3Rf
d3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4
LA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKTsNCj4gIA0K
PiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KPiAr
aW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50LCBib29sIGNs
ZWFyKQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0K
PiArCXUzMiBjbGVhcl9vcHRpb24gPSBjbGVhciA/IENNRFFfV0ZFX1VQREFURSA6IDA7DQo+ICAN
Cj4gIAlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0K
PiAgDQo+ICAJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7DQo+IC0JaW5zdC52YWx1ZSA9IENNRFFf
V0ZFX09QVElPTjsNCj4gKwlpbnN0LnZhbHVlID0gQ01EUV9XRkVfT1BUSU9OIHwgY2xlYXJfb3B0
aW9uOw0KPiAgCWluc3QuZXZlbnQgPSBldmVudDsNCj4gIA0KPiAgCXJldHVybiBjbWRxX3BrdF9h
cHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
YWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmgNCj4gaW5kZXggM2Y2YmMwZGZkNWRhLi40MmQyYTMwZTZhNzAgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtMjcsOCArMjcs
NyBAQA0KPiAgICogYml0IDE2LTI3OiB1cGRhdGUgdmFsdWUNCj4gICAqIGJpdCAzMTogMSAtIHVw
ZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KPiAgICovDQo+IC0jZGVmaW5lIENNRFFfV0ZFX09QVElPTgkJ
CShDTURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9XQUlUIHwgXA0KPiAtCQkJCQlDTURRX1dGRV9X
QUlUX1ZBTFVFKQ0KPiArI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9XRkVfV0FJVCB8
IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQo+ICANCj4gIC8qKiBjbWRxIGV2ZW50IG1heGltdW0gKi8N
Cj4gICNkZWZpbmUgQ01EUV9NQVhfRVZFTlQJCQkweDNmZg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmgNCj4gaW5kZXggMWE2YzU2ZjNiZWMxLi5kNjM3NDk0NDA2OTcgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMTUyLDExICsxNTIs
MTIgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUx
NiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gIC8qKg0KPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBl
bmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gICAqIEBwa3Q6
CXRoZSBDTURRIHBhY2tldA0KPiAtICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRv
ICJ3YWl0IGFuZCBDTEVBUiINCj4gKyAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0
byB3YWl0DQo+ICsgKiBAY2xlYXI6CWNsZWFyIGV2ZW50IG9yIG5vdCBhZnRlciBldmVudCBhcnJp
dmUNCj4gICAqDQo+ICAgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNv
ZGUgaXMgcmV0dXJuZWQNCj4gICAqLw0KPiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTE2IGV2ZW50KTsNCj4gK2ludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQoNCkkgdGhpbmsgeW91IHNob3VsZCBtb2Rp
ZnkgY2xpZW50IGRyaXZlciBbMV0gYXMgd2VsbCBpbiB0aGlzIHBhdGNoLg0KQ2hhbmdlIGl0IHRv
DQoNCmNtZHFfcGt0X3dmZShjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQsIGZhbHNl
KTsNCg0KWzFdDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmM/aD12NS42LXJjMyNuNDkxDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICANCj4gIC8qKg0K
PiAgICogY21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVudCBjb21tYW5k
IHRvIHRoZSBDTURRIHBhY2tldA0KDQo=

