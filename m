Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5D92067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GsbEro2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCICHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 22:07:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54618 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbgCICHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 22:07:44 -0400
X-UUID: e2fedb98a27a4aa7807276ff00b02162-20200309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=17MyIh5es8+oWEfzyMzpzHwqTieeb22zUb4UUI66VDE=;
        b=GsbEro2QROKwbTUJcqFz6G+vVTLniRBvF+e8J4Z9Qqk/BYiixF5YhWtxizwGfSMXOre02+Wh99mivEJB5iPmzRdP5Dr6kJ9r4bbuv6CMA4bEdilrsllEaj3bEzXIYippAVPJLht7V0yNK8bRg4fiQN09RvTWN5tBZEKjlAodfjA=;
X-UUID: e2fedb98a27a4aa7807276ff00b02162-20200309
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 356268346; Mon, 09 Mar 2020 10:07:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Mar 2020 10:08:45 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Mar 2020 10:07:36 +0800
Message-ID: <1583719659.28331.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 12/13] soc: mediatek: cmdq: add clear option in
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
Date:   Mon, 9 Mar 2020 10:07:39 +0800
In-Reply-To: <1583664775-19382-13-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-13-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gU3VuLCAyMDIwLTAzLTA4IGF0IDE4OjUyICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBjbGVhciBwYXJhbWV0ZXIgdG8gbGV0IGNsaWVudCBkZWNp
ZGUgaWYNCj4gZXZlbnQgc2hvdWxkIGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQu
DQo+IA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8IDIg
Ky0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCA1ICsrKy0t
DQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgMyArLS0NCj4g
IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCA1ICsrKy0tDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gaW5kZXggN2RhYWFiYzI2ZWIx
Li5hMDY1YjNhNDEyY2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMNCj4gQEAgLTQ4OCw3ICs0ODgsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfaHdf
Y29uZmlnKHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiAgCWlmIChtdGtfY3J0Yy0+
Y21kcV9jbGllbnQpIHsNCj4gIAkJY21kcV9oYW5kbGUgPSBjbWRxX3BrdF9jcmVhdGUobXRrX2Ny
dGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KPiAgCQljbWRxX3BrdF9jbGVhcl9ldmVudChj
bWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KPiAtCQljbWRxX3BrdF93ZmUoY21k
cV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCj4gKwkJY21kcV9wa3Rfd2ZlKGNtZHFf
aGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgZmFsc2UpOw0KPiAgCQltdGtfY3J0Y19kZHBf
Y29uZmlnKGNydGMsIGNtZHFfaGFuZGxlKTsNCj4gIAkJY21kcV9wa3RfZmluYWxpemUoY21kcV9o
YW5kbGUpOw0KPiAgCQljbWRxX3BrdF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFf
Y2IsIGNtZHFfaGFuZGxlKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMN
Cj4gaW5kZXggYmI1YmUyMGZjNzBhLi5lYzU2MzdkNDMyNTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0yOTYsMTUgKzI5NiwxNiBAQCBpbnQgY21k
cV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9y
ZWdfaWR4LA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKTsN
Cj4gIA0KPiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50
KQ0KPiAraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50LCBi
b29sIGNsZWFyKQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHsw
fSB9Ow0KPiArCXUzMiBjbGVhcl9vcHRpb24gPSBjbGVhciA/IENNRFFfV0ZFX1VQREFURSA6IDA7
DQo+ICANCj4gIAlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQo+ICAJCXJldHVybiAtRUlO
VkFMOw0KPiAgDQo+ICAJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7DQo+IC0JaW5zdC52YWx1ZSA9
IENNRFFfV0ZFX09QVElPTjsNCj4gKwlpbnN0LnZhbHVlID0gQ01EUV9XRkVfT1BUSU9OIHwgY2xl
YXJfb3B0aW9uOw0KPiAgCWluc3QuZXZlbnQgPSBldmVudDsNCj4gIA0KPiAgCXJldHVybiBjbWRx
X3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmgNCj4gaW5kZXggM2Y2YmMwZGZkNWRhLi40MmQyYTMwZTZhNzAgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtMjcs
OCArMjcsNyBAQA0KPiAgICogYml0IDE2LTI3OiB1cGRhdGUgdmFsdWUNCj4gICAqIGJpdCAzMTog
MSAtIHVwZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KPiAgICovDQo+IC0jZGVmaW5lIENNRFFfV0ZFX09Q
VElPTgkJCShDTURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9XQUlUIHwgXA0KPiAtCQkJCQlDTURR
X1dGRV9XQUlUX1ZBTFVFKQ0KPiArI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9XRkVf
V0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQo+ICANCj4gIC8qKiBjbWRxIGV2ZW50IG1heGlt
dW0gKi8NCj4gICNkZWZpbmUgQ01EUV9NQVhfRVZFTlQJCQkweDNmZg0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggMWE2YzU2ZjNiZWMxLi5kNjM3NDk0NDA2OTcg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMTUyLDEx
ICsxNTIsMTIgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gIC8qKg0KPiAgICogY21kcV9wa3Rfd2ZlKCkg
LSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gICAq
IEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiAtICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0
eXBlIHRvICJ3YWl0IGFuZCBDTEVBUiINCj4gKyAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQg
dHlwZSB0byB3YWl0DQo+ICsgKiBAY2xlYXI6CWNsZWFyIGV2ZW50IG9yIG5vdCBhZnRlciBldmVu
dCBhcnJpdmUNCj4gICAqDQo+ICAgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVy
cm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gICAqLw0KPiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsNCj4gK2ludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQo+ICANCj4gIC8qKg0KPiAgICog
Y21kcV9wa3RfY2xlYXJfZXZlbnQoKSAtIGFwcGVuZCBjbGVhciBldmVudCBjb21tYW5kIHRvIHRo
ZSBDTURRIHBhY2tldA0KDQo=

