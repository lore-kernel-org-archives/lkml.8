Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3455C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C2A208A7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uVtaZAO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgEXRje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:39:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21691 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387656AbgEXRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:39:33 -0400
X-UUID: bd043902c5a64ada902523b1c0ac946b-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Budt1Q/YKyyHz1LfMtaltAftGMWuXZGR8k5sFbQgD9I=;
        b=uVtaZAO0ztm5vjRXLPBVsHPSqkJDUZIT8Nku1f1uGLGcCikpf2MC6DJ/gmfZeJ0MeCFEAy7xDlaiL0bmnyCP0fgET1W/KvHNQHdIklTni3sMIPiLSHhAbNoH4R2GDlr7qdRcAW8vI+P1bdK98QyCkiNNdtt+8u4E6X3ufujFITo=;
X-UUID: bd043902c5a64ada902523b1c0ac946b-20200525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 303714022; Mon, 25 May 2020 01:39:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 01:39:22 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 01:39:22 +0800
Message-ID: <1590341965.31286.27.camel@mtkswgap22>
Subject: Re: [PATCH v5 13/13] soc: mediatek: cmdq: add set event function
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
Date:   Mon, 25 May 2020 01:39:25 +0800
In-Reply-To: <d00dd874-edda-701a-2acc-540ed19d1300@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-14-git-send-email-dennis-yc.hsieh@mediatek.com>
         <d00dd874-edda-701a-2acc-540ed19d1300@gmail.com>
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
MC0wNS0xNiBhdCAyMDozMiArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9u
IDA4LzAzLzIwMjAgMTE6NTIsIERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgc2V0IGV2
ZW50IGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1bmN0aW9ucyB0byBzZXQgc3BlY2lmaWMgZXZl
bnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMu
aHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYyAgIHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmggfCAgMSArDQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmggICAgfCAgOSArKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gPiBpbmRleCBlYzU2MzdkNDMyNTQuLjMyOTRjOTI4NTk5NCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTMyNyw2ICszMjcsMjEg
QEAgaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZl
bnQpDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9jbGVhcl9ldmVudCk7DQo+
ID4gIA0KPiA+ICtpbnQgY21kcV9wa3Rfc2V0X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1
MTYgZXZlbnQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7
IHswfSB9Ow0KPiA+ICsNCj4gPiArCWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsN
Cj4gPiArCWluc3QudmFsdWUgPSBDTURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFM
VUU7DQo+ID4gKwlpbnN0LmV2ZW50ID0gZXZlbnQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNtZHFf
cGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJP
TChjbWRxX3BrdF9zZXRfZXZlbnQpOw0KPiA+ICsNCj4gPiAgaW50IGNtZHFfcGt0X3BvbGwoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgCQkgIHUxNiBvZmZzZXQsIHUzMiB2
YWx1ZSkNCj4gPiAgew0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
aA0KPiA+IGluZGV4IDQyZDJhMzBlNmE3MC4uYmEyZDgxMTE4M2E5IDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gQEAgLTE3LDYgKzE3LDcg
QEANCj4gPiAgI2RlZmluZSBDTURRX0pVTVBfUEFTUwkJCUNNRFFfSU5TVF9TSVpFDQo+ID4gIA0K
PiA+ICAjZGVmaW5lIENNRFFfV0ZFX1VQREFURQkJCUJJVCgzMSkNCj4gPiArI2RlZmluZSBDTURR
X1dGRV9VUERBVEVfVkFMVUUJCUJJVCgxNikNCj4gPiAgI2RlZmluZSBDTURRX1dGRV9XQUlUCQkJ
QklUKDE1KQ0KPiA+ICAjZGVmaW5lIENNRFFfV0ZFX1dBSVRfVkFMVUUJCTB4MQ0KPiA+ICANCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCBkNjM3NDk0NDA2
OTcuLmNhNzAyOTZhZTEyMCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KPiA+IEBAIC0xNjgsNiArMTY4LDE1IEBAIGludCBjbWRxX3BrdF93ZmUoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQo+ID4gICAqLw0KPiA+ICBp
bnQgY21kcV9wa3RfY2xlYXJfZXZlbnQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7
DQo+ID4gIA0KPiA+ICsvKioNCj4gPiArICogY21kcV9wa3Rfc2V0X2V2ZW50KCkgLSBhcHBlbmQg
c2V0IGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEBwa3Q6CXRoZSBD
TURRIHBhY2tldA0KPiA+ICsgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHRvIGJlIHNldA0K
PiANCj4gQ2FuIHdlIGFkZCB0aGUgZXZlbnRzIGFuZCB0aGVpciBjb2RlLCBzbyB0aGF0IGxhdGVy
IG9uLCB3aGVuIGEgY29uc3VtZXIgY2FsbHMNCj4gY21kcV9wa3Rfc2V0X2V2ZW50KCkgd2UgZG9u
J3QgaGF2ZSBhbnkgbWFnaWMgdmFsdWVzIHRoYXQgYXJlIGhhcmQgdG8gdW5kZXJzdGFuZD8NCg0K
UGxlYXNlIHNlZSBwYXRjaCAwMi8xMzoNCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVy
bWFpbC9saW51eC1tZWRpYXRlay8yMDIwLU1hcmNoLzAyNzgwMS5odG1sDQoNCkRlZmluaXRpb25z
IGJlZ2luIHdpdGggQ01EUV9FVkVOVF8gaXMgdGhlIGV2ZW50IGlkIHRvIHRoaXMgZnVuY3Rpb24u
DQpTaW5jZSB0aGUgZXZlbnQgaWQgaXMgZGlmZmVyZW50IGJldHdlZW4gcGxhdGZvcm0sIGNsaWVu
dCBtdXN0IHBhcnNlIGl0DQpmcm9tIGRldmljZSB0cmVlLiBTbyBubyBtYWdpYyB2YWx1ZXMgcmVx
dWlyZSB3aGVuIGNhbGwgdGhpcyBmdW5jdGlvbi4NCg0KDQpSZWdhcmQsDQpEZW5uaXMNCg0KDQo+
IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAw
IGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gKyAqLw0K
PiA+ICtpbnQgY21kcV9wa3Rfc2V0X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZl
bnQpOw0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X3BvbGwoKSAtIEFwcGVuZCBw
b2xsaW5nIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFIHRvDQo+ID4gICAqCQkg
ICAgIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCB3YWl0IGZvciBhIHNwZWNpZmllZA0KPiA+
IA0KDQo=

