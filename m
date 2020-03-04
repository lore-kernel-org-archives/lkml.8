Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08BBC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D7320838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R1m1Kaji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgCDDFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:05:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49191 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387397AbgCDDFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:05:35 -0500
X-UUID: 05b93ba8f8584d23bd1d7e0ef70eba83-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uV6XAfR45kceIz/xzf1Y2H5SW6enf8ExjM5OoLYTjuM=;
        b=R1m1Kaji0qro6LvyKkTo0iX3Zu3IK6TbdIOdIEPuHlaiIycUB8H4h9lhhkXJxTo6DEkrKGtLdyBp7YOC9DmRu8LDdi8vDSM944v7r9p/fm89cYFSTPTcinz9ug+tjiMmTHTLHb75gMgNjGTbGNbYiOAKdWxs0LQdIuR9pMWIV8s=;
X-UUID: 05b93ba8f8584d23bd1d7e0ef70eba83-20200304
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 256793080; Wed, 04 Mar 2020 11:05:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 11:04:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 11:02:54 +0800
Message-ID: <1583291126.1062.7.camel@mtksdaap41>
Subject: Re: [PATCH v4 12/13] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Wed, 4 Mar 2020 11:05:26 +0800
In-Reply-To: <1583233125-7827-13-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-13-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBjbGVhciBwYXJhbWV0ZXIgdG8gbGV0IGNsaWVudCBkZWNp
ZGUgaWYNCj4gZXZlbnQgc2hvdWxkIGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBt
ZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jICB8IDIgKy0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
ICAgfCA1ICsrKy0tDQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5o
IHwgMyArLS0NCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCA1
ICsrKy0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gaW5kZXgg
N2RhYWFiYzI2ZWIxLi40OTE2YTdmNzVkMjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmMNCj4gQEAgLTQ4OCw3ICs0ODgsNyBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHJtX2NydGNfaHdfY29uZmlnKHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiAgCWlm
IChtdGtfY3J0Yy0+Y21kcV9jbGllbnQpIHsNCj4gIAkJY21kcV9oYW5kbGUgPSBjbWRxX3BrdF9j
cmVhdGUobXRrX2NydGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KPiAgCQljbWRxX3BrdF9j
bGVhcl9ldmVudChjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KPiAtCQljbWRx
X3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCj4gKwkJY21kcV9w
a3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgdHJ1ZSk7DQoNClRoZXJl
IGlzIGFsd2F5cyBjbGVhciBldmVudCBiZWZvcmUgd2FpdCBldmVudCwgc28gdGhlcmUgaXMgbm8g
bmVlZCB0bw0KY2xlYXIgZXZlbnQgYWZ0ZXIgZXZlbnQgaXMgd2FpdGVkLiBTbyB0aGlzIHNob3Vs
ZCBiZQ0KDQpjbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50LCBm
YWxzZSk7DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJCW10a19jcnRjX2RkcF9jb25maWcoY3J0Yywg
Y21kcV9oYW5kbGUpOw0KPiAgCQljbWRxX3BrdF9maW5hbGl6ZShjbWRxX2hhbmRsZSk7DQo+ICAJ
CWNtZHFfcGt0X2ZsdXNoX2FzeW5jKGNtZHFfaGFuZGxlLCBkZHBfY21kcV9jYiwgY21kcV9oYW5k
bGUpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBpbmRleCBmMjdj
NjcwMzQ4ODAuLjRmNzY3MTk4ZDBmYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMNCj4gQEAgLTI5NSwxNSArMjk1LDE2IEBAIGludCBjbWRxX3BrdF93cml0ZV9z
X3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ICB9
DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUpOw0KPiAgDQo+IC1pbnQg
Y21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQo+ICtpbnQgY21k
cV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpDQo+
ICB7DQo+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ICsJdTMy
IGNsZWFyX29wdGlvbiA9IGNsZWFyID8gQ01EUV9XRkVfVVBEQVRFIDogMDsNCj4gIA0KPiAgCWlm
IChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4g
IAlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCj4gLQlpbnN0LnZhbHVlID0gQ01EUV9XRkVfT1BU
SU9OOw0KPiArCWluc3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT04gfCBjbGVhcl9vcHRpb247DQo+
ICAJaW5zdC5ldmVudCA9IGV2ZW50Ow0KPiAgDQo+ICAJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9j
b21tYW5kKHBrdCwgaW5zdCk7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KPiBpbmRleCAzZjZiYzBkZmQ1ZGEuLjQyZDJhMzBlNmE3MCAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+IEBAIC0yNyw4ICsyNyw3IEBADQo+
ICAgKiBiaXQgMTYtMjc6IHVwZGF0ZSB2YWx1ZQ0KPiAgICogYml0IDMxOiAxIC0gdXBkYXRlLCAw
IC0gbm8gdXBkYXRlDQo+ICAgKi8NCj4gLSNkZWZpbmUgQ01EUV9XRkVfT1BUSU9OCQkJKENNRFFf
V0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBcDQo+IC0JCQkJCUNNRFFfV0ZFX1dBSVRfVkFM
VUUpDQo+ICsjZGVmaW5lIENNRFFfV0ZFX09QVElPTgkJCShDTURRX1dGRV9XQUlUIHwgQ01EUV9X
RkVfV0FJVF9WQUxVRSkNCj4gIA0KPiAgLyoqIGNtZHEgZXZlbnQgbWF4aW11bSAqLw0KPiAgI2Rl
ZmluZSBDTURRX01BWF9FVkVOVAkJCTB4M2ZmDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiBpbmRleCAxYTZjNTZmM2JlYzEuLmQ2Mzc0OTQ0MDY5NyAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IEBAIC0xNTIsMTEgKzE1MiwxMiBAQCBp
bnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hf
YWRkcl9yZWdfaWR4LA0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0
IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KPiAgICogQHBrdDoJdGhlIENN
RFEgcGFja2V0DQo+IC0gKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gIndhaXQg
YW5kIENMRUFSIg0KPiArICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvIHdhaXQN
Cj4gKyAqIEBjbGVhcjoJY2xlYXIgZXZlbnQgb3Igbm90IGFmdGVyIGV2ZW50IGFycml2ZQ0KPiAg
ICoNCj4gICAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyBy
ZXR1cm5lZA0KPiAgICovDQo+IC1pbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgZXZlbnQpOw0KPiAraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IGV2ZW50LCBib29sIGNsZWFyKTsNCj4gIA0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF9jbGVh
cl9ldmVudCgpIC0gYXBwZW5kIGNsZWFyIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0
DQoNCg==

