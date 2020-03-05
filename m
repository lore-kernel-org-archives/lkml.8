Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A31C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449262084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JmvWG41R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCEAuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:50:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54461 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbgCEAuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:50:04 -0500
X-UUID: 16a3c3b4396f47f9ad509f0e2531cf64-20200305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kKyBokw0nHSD5G4NnU/6ssdFSMmw3W6g132ZYmBRN8o=;
        b=JmvWG41RARYZiVlIyy22bD+tS7VwPyYFsdlT7GUPj1HscQLMXU5tP5WPdYzXVCTV8EulJAWhPvnbC4ayDy45+22A5wg6NeY8kq2jN74Hdz0qXLvDSPXraYWVFJGho7TjHnBBDwtVc2wYWofm9Ut6OSVWUNjhYBSLP9yTQzS9fX4=;
X-UUID: 16a3c3b4396f47f9ad509f0e2531cf64-20200305
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 553839731; Thu, 05 Mar 2020 08:49:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Mar 2020 08:48:57 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Mar 2020 08:49:13 +0800
Message-ID: <1583369398.28558.1.camel@mtkswgap22>
Subject: Re: [PATCH v4 12/13] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
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
Date:   Thu, 5 Mar 2020 08:49:58 +0800
In-Reply-To: <1583291126.1062.7.camel@mtksdaap41>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-13-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583291126.1062.7.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBXZWQsIDIwMjAtMDMtMDQg
YXQgMTE6MDUgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiBIaSwgRGVubmlzOg0KPiANCj4gT24gVHVl
LCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4g
QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KPiA+IGV2ZW50IHNo
b3VsZCBiZSBjbGVhciB0byAwIGFmdGVyIEdDRSByZWNlaXZlIGl0Lg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8
IDIgKy0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDUg
KysrLS0NCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8IDMg
Ky0tDQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCA1ICsr
Ky0tDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBp
bmRleCA3ZGFhYWJjMjZlYjEuLjQ5MTZhN2Y3NWQyMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBAQCAtNDg4LDcgKzQ4OCw3IEBAIHN0YXRp
YyB2b2lkIG10a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2Ny
dGMpDQo+ID4gIAlpZiAobXRrX2NydGMtPmNtZHFfY2xpZW50KSB7DQo+ID4gIAkJY21kcV9oYW5k
bGUgPSBjbWRxX3BrdF9jcmVhdGUobXRrX2NydGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0K
PiA+ICAJCWNtZHFfcGt0X2NsZWFyX2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9l
dmVudCk7DQo+ID4gLQkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9l
dmVudCk7DQo+ID4gKwkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9l
dmVudCwgdHJ1ZSk7DQo+IA0KPiBUaGVyZSBpcyBhbHdheXMgY2xlYXIgZXZlbnQgYmVmb3JlIHdh
aXQgZXZlbnQsIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8NCj4gY2xlYXIgZXZlbnQgYWZ0ZXIgZXZl
bnQgaXMgd2FpdGVkLiBTbyB0aGlzIHNob3VsZCBiZQ0KPiANCj4gY21kcV9wa3Rfd2ZlKGNtZHFf
aGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgZmFsc2UpOw0KDQpPaywgd2lsbCBmaXggaW4g
bmV4dCB2ZXJzaW9uLCB0aGFua3MuDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQoNCj4gDQo+IFJl
Z2FyZHMsDQo+IENLDQo+IA0KPiA+ICAJCW10a19jcnRjX2RkcF9jb25maWcoY3J0YywgY21kcV9o
YW5kbGUpOw0KPiA+ICAJCWNtZHFfcGt0X2ZpbmFsaXplKGNtZHFfaGFuZGxlKTsNCj4gPiAgCQlj
bWRxX3BrdF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFfY2IsIGNtZHFfaGFuZGxl
KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGluZGV4IGYy
N2M2NzAzNDg4MC4uNGY3NjcxOThkMGZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMNCj4gPiBAQCAtMjk1LDE1ICsyOTUsMTYgQEAgaW50IGNtZHFfcGt0
X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lk
eCwNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUpOw0K
PiA+ICANCj4gPiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KQ0KPiA+ICtpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZl
bnQsIGJvb2wgY2xlYXIpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KPiA+ICsJdTMyIGNsZWFyX29wdGlvbiA9IGNsZWFyID8gQ01EUV9XRkVf
VVBEQVRFIDogMDsNCj4gPiAgDQo+ID4gIAlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQo+
ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIA0KPiA+ICAJaW5zdC5vcCA9IENNRFFfQ09ERV9X
RkU7DQo+ID4gLQlpbnN0LnZhbHVlID0gQ01EUV9XRkVfT1BUSU9OOw0KPiA+ICsJaW5zdC52YWx1
ZSA9IENNRFFfV0ZFX09QVElPTiB8IGNsZWFyX29wdGlvbjsNCj4gPiAgCWluc3QuZXZlbnQgPSBl
dmVudDsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBp
bnN0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBp
bmRleCAzZjZiYzBkZmQ1ZGEuLjQyZDJhMzBlNmE3MCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC0yNyw4ICsyNyw3IEBADQo+ID4g
ICAqIGJpdCAxNi0yNzogdXBkYXRlIHZhbHVlDQo+ID4gICAqIGJpdCAzMTogMSAtIHVwZGF0ZSwg
MCAtIG5vIHVwZGF0ZQ0KPiA+ICAgKi8NCj4gPiAtI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQko
Q01EUV9XRkVfVVBEQVRFIHwgQ01EUV9XRkVfV0FJVCB8IFwNCj4gPiAtCQkJCQlDTURRX1dGRV9X
QUlUX1ZBTFVFKQ0KPiA+ICsjZGVmaW5lIENNRFFfV0ZFX09QVElPTgkJCShDTURRX1dGRV9XQUlU
IHwgQ01EUV9XRkVfV0FJVF9WQUxVRSkNCj4gPiAgDQo+ID4gIC8qKiBjbWRxIGV2ZW50IG1heGlt
dW0gKi8NCj4gPiAgI2RlZmluZSBDTURRX01BWF9FVkVOVAkJCTB4M2ZmDQo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gaW5kZXggMWE2YzU2ZjNiZWMxLi5kNjM3NDk0
NDA2OTcgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
PiBAQCAtMTUyLDExICsxNTIsMTIgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiAgLyoqDQo+ID4gICAq
IGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENN
RFEgcGFja2V0DQo+ID4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+IC0gKiBAZXZlbnQ6
CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gIndhaXQgYW5kIENMRUFSIg0KPiA+ICsgKiBAZXZl
bnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gd2FpdA0KPiA+ICsgKiBAY2xlYXI6CWNsZWFy
IGV2ZW50IG9yIG5vdCBhZnRlciBldmVudCBhcnJpdmUNCj4gPiAgICoNCj4gPiAgICogUmV0dXJu
OiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gICAq
Lw0KPiA+IC1pbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQp
Ow0KPiA+ICtpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQs
IGJvb2wgY2xlYXIpOw0KPiA+ICANCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X2NsZWFyX2V2
ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4g
DQo+IA0KDQo=

