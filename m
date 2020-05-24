Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A74C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF27820812
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X8VpmNW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbgEXRdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:33:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54155 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387656AbgEXRdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:33:00 -0400
X-UUID: efaeabddf4da4df19a9e277644f1f120-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NRUfXSdH1Y0b7w27gA4nSFgrpT/xOAe4KYnqqpyaLVw=;
        b=X8VpmNW+J3DdjGJswe/ENk/xqoBwJxero0pFRH8kfuauOXM/eBBjB04WwCfCwJaG8eZGTtwfZzRg86lipVGLtzWW5AtBwNCA3vA2kdZFCTktzg77DOHe+LMcxaLnmd0KA2iX5F81KvKt19XeOLZk1Db2W3DPSVNqMhmNR4F5/os=;
X-UUID: efaeabddf4da4df19a9e277644f1f120-20200525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1232601585; Mon, 25 May 2020 01:32:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 01:32:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 01:32:50 +0800
Message-ID: <1590341574.31286.21.camel@mtkswgap22>
Subject: Re: [PATCH v5 12/13] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 25 May 2020 01:32:54 +0800
In-Reply-To: <6029e0eb-70fa-825f-7fd4-f5127384bd8d@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-13-git-send-email-dennis-yc.hsieh@mediatek.com>
         <6029e0eb-70fa-825f-7fd4-f5127384bd8d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQoNCk9uIFNhdCwgMjAy
MC0wNS0xNiBhdCAyMDozMCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9u
IDA4LzAzLzIwMjAgMTE6NTIsIERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgY2xlYXIg
cGFyYW1ldGVyIHRvIGxldCBjbGllbnQgZGVjaWRlIGlmDQo+ID4gZXZlbnQgc2hvdWxkIGJlIGNs
ZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
RGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwgMiArLQ0KPiA+
ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgNSArKystLQ0KPiA+
ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgMyArLS0NCj4gPiAg
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDUgKysrLS0NCj4gPiAg
NCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGluZGV4IDdkYWFh
YmMyNmViMS4uYTA2NWIzYTQxMmNmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KPiA+IEBAIC00ODgsNyArNDg4LDcgQEAgc3RhdGljIHZvaWQgbXRr
X2RybV9jcnRjX2h3X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCj4gPiAg
CWlmIChtdGtfY3J0Yy0+Y21kcV9jbGllbnQpIHsNCj4gPiAgCQljbWRxX2hhbmRsZSA9IGNtZHFf
cGt0X2NyZWF0ZShtdGtfY3J0Yy0+Y21kcV9jbGllbnQsIFBBR0VfU0laRSk7DQo+ID4gIAkJY21k
cV9wa3RfY2xlYXJfZXZlbnQoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCj4g
PiAtCQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCj4g
PiArCQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50LCBmYWxz
ZSk7DQo+ID4gIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBjbWRxX2hhbmRsZSk7DQo+ID4g
IAkJY21kcV9wa3RfZmluYWxpemUoY21kcV9oYW5kbGUpOw0KPiA+ICAJCWNtZHFfcGt0X2ZsdXNo
X2FzeW5jKGNtZHFfaGFuZGxlLCBkZHBfY21kcV9jYiwgY21kcV9oYW5kbGUpOw0KPiANCj4gVGhp
cyBzaG91bGQgYmUgYW4gaW5kZXBlbmRlbnQgcGF0Y2gNCg0Kb2ssIEknbGwgc2VwYXJhdGUgdGhp
cyBwYXJ0Lg0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGluZGV4IGJiNWJlMjBmYzcwYS4uZWM1NjM3ZDQzMjU0
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBA
QCAtMjk2LDE1ICsyOTYsMTYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiAgfQ0KPiA+ICBFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUpOw0KPiA+ICANCj4gPiAtaW50IGNtZHFfcGt0
X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KPiA+ICtpbnQgY21kcV9wa3Rf
d2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpDQo+ID4gIHsN
Cj4gPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICsJdTMy
IGNsZWFyX29wdGlvbiA9IGNsZWFyID8gQ01EUV9XRkVfVVBEQVRFIDogMDsNCj4gPiAgDQo+ID4g
IAlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gIA0KPiA+ICAJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7DQo+ID4gLQlpbnN0LnZhbHVlID0g
Q01EUV9XRkVfT1BUSU9OOw0KPiA+ICsJaW5zdC52YWx1ZSA9IENNRFFfV0ZFX09QVElPTiB8IGNs
ZWFyX29wdGlvbjsNCj4gPiAgCWluc3QuZXZlbnQgPSBldmVudDsNCj4gPiAgDQo+ID4gIAlyZXR1
cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBpbmRleCAzZjZiYzBkZmQ1ZGEuLjQyZDJh
MzBlNmE3MCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KPiA+IEBAIC0yNyw4ICsyNyw3IEBADQo+ID4gICAqIGJpdCAxNi0yNzogdXBkYXRlIHZh
bHVlDQo+ID4gICAqIGJpdCAzMTogMSAtIHVwZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KPiA+ICAgKi8N
Cj4gPiAtI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9XRkVfVVBEQVRFIHwgQ01EUV9X
RkVfV0FJVCB8IFwNCj4gPiAtCQkJCQlDTURRX1dGRV9XQUlUX1ZBTFVFKQ0KPiA+ICsjZGVmaW5l
IENNRFFfV0ZFX09QVElPTgkJCShDTURRX1dGRV9XQUlUIHwgQ01EUV9XRkVfV0FJVF9WQUxVRSkN
Cj4gPiAgDQo+ID4gIC8qKiBjbWRxIGV2ZW50IG1heGltdW0gKi8NCj4gPiAgI2RlZmluZSBDTURR
X01BWF9FVkVOVAkJCTB4M2ZmDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQo+ID4gaW5kZXggMWE2YzU2ZjNiZWMxLi5kNjM3NDk0NDA2OTcgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBAQCAtMTUyLDExICsxNTIsMTIgQEAg
aW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdo
X2FkZHJfcmVnX2lkeCwNCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5k
IHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ID4gICAqIEBwa3Q6
CXRoZSBDTURRIHBhY2tldA0KPiA+IC0gKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUg
dG8gIndhaXQgYW5kIENMRUFSIg0KPiA+ICsgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5
cGUgdG8gd2FpdA0KPiA+ICsgKiBAY2xlYXI6CWNsZWFyIGV2ZW50IG9yIG5vdCBhZnRlciBldmVu
dCBhcnJpdmUNCj4gPiAgICoNCj4gPiAgICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRo
ZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gICAqLw0KPiA+IC1pbnQgY21kcV9wa3Rfd2Zl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KPiA+ICtpbnQgY21kcV9wa3Rfd2Zl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQsIGJvb2wgY2xlYXIpOw0KPiA+ICANCj4g
PiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X2NsZWFyX2V2ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZl
bnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiANCg0K

