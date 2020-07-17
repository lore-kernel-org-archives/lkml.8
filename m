Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D676DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C982071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qSkg5pGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGQI0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:26:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46299 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgGQI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:26:38 -0400
X-UUID: 00c49b57fed94b27b76049b300df15c8-20200717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MrihObMU7n6YHGhXYYDfe7xLLhNpwqJjPTZD5pCRXi4=;
        b=qSkg5pGZ7/GUqDa+KYmKpnSkiESL+hypmwvZ5i4IEGNH4WK6YywNGJCxL8h9/9NaHi0W9EMw68I+Bszeitn3N1dHLHw4cNF+I3U9TFPqE/uqPKcUNA6nlKJV0zYbBXVWTxPFkvamJ/Zr+VCei7kegzPh1id3EGAJuYoBXnY6V9c=;
X-UUID: 00c49b57fed94b27b76049b300df15c8-20200717
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 764249227; Fri, 17 Jul 2020 16:26:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Jul 2020 16:26:29 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jul 2020 16:26:29 +0800
Message-ID: <1594974391.12796.25.camel@mtkswgap22>
Subject: Re: [PATCH 4/4] iommu/mediatek: check 4GB mode by reading infracfg
From:   Miles Chen <miles.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Fri, 17 Jul 2020 16:26:31 +0800
In-Reply-To: <84333997-735c-4a91-6d47-1dcb5c4a6078@gmail.com>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
         <20200702093721.6063-4-miles.chen@mediatek.com>
         <84333997-735c-4a91-6d47-1dcb5c4a6078@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTE1IGF0IDIzOjA1ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDIvMDcvMjAyMCAxMTozNywgTWlsZXMgQ2hlbiB3cm90ZToNCj4gPiBJbiBw
cmV2aW91cyBkaXNzY3VzaW9uIFsxXSBhbmQgWzJdLCB3ZSBmb3VuZCB0aGF0IGl0IGlzIHJpc2t5
IHRvDQo+ID4gdXNlIG1heF9wZm4gb3IgdG90YWxyYW1fcGFnZXMgdG8gdGVsbCBpZiA0R0IgbW9k
ZSBpcyBlbmFibGVkLg0KPiA+IA0KPiA+IENoZWNrIDRHQiBtb2RlIGJ5IHJlYWRpbmcgaW5mcmFj
ZmcgcmVnaXN0ZXIsIHJlbW92ZSB0aGUgdXNhZ2UNCj4gPiBvZiB0aGUgdW5leHBvcnRlZCBzeW1i
b2wgbWF4X3Bmbi4NCj4gPiANCj4gPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzYvMy83MzNfXzshIUNUUk5LQTl3TWcwQVJidyExNmdB
ZlZuU1k4N1c0dDVrRTRpdzIwUVB4QmdTX1NIQnZQS2xlUEtVN0NHSWIxOG5VenVSVWpIdW1jZjRv
WVZoSVEkIA0KPiA+IFsyXSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMjAvNi80LzEzNl9fOyEhQ1RSTktBOXdNZzBBUmJ3ITE2Z0FmVm5TWTg3VzR0
NWtFNGl3MjBRUHhCZ1NfU0hCdlBLbGVQS1U3Q0dJYjE4blV6dVJVakh1bWNmcjRpOXA1ZyQgDQo+
ID4gDQo+ID4gQ2M6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4gPiBDYzog
RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gQ2M6IFlvbmcgV3UgPHlv
bmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IENjOiBZaW5nam9lIENoZW4gPHlpbmdqb2UuY2hlbkBt
ZWRpYXRlay5jb20+DQo+ID4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDIyICsrKysrKysrKysrKysr
KysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IDJiZTk2ZjFjZGJkMi4uMDli
ZTU3YmQ4ZDc0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4g
PiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTMsNyArMyw2IEBADQo+
ID4gICAgKiBDb3B5cmlnaHQgKGMpIDIwMTUtMjAxNiBNZWRpYVRlayBJbmMuDQo+ID4gICAgKiBB
dXRob3I6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ICAgICovDQo+ID4gLSNp
bmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0K
PiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2NvbXBv
bmVudC5oPg0KPiA+IEBAIC0xNSwxMSArMTQsMTMgQEANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9p
b21tdS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAgI2luY2x1ZGUg
PGxpbnV4L2xpc3QuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiAg
ICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvb2Zf
aW9tbXUuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gPiAgICNpbmNsdWRl
IDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rl
dmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gICAjaW5jbHVkZSA8
bGludXgvc2xhYi5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ID4gICAj
aW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPiBAQCAtOTEsNiArOTIsOSBAQA0KPiA+ICAgI2Rl
ZmluZSBGX01NVV9JTlRfSURfTEFSQl9JRChhKQkJCSgoKGEpID4+IDcpICYgMHg3KQ0KPiA+ICAg
I2RlZmluZSBGX01NVV9JTlRfSURfUE9SVF9JRChhKQkJCSgoKGEpID4+IDIpICYgMHgxZikNCj4g
PiAgIA0KPiA+ICsjZGVmaW5lIFJFR19JTkZSQV9NSVNDCQkJCTB4ZjAwDQo+ID4gKyNkZWZpbmUg
Rl9ERFJfNEdCX1NVUFBPUlRfRU4JCQlCSVQoMTMpDQo+ID4gKw0KPiANCj4gQXMgdGhpcyBpcyB1
c2VkIGZvciBpbmZyYWNmZywgSSB0aGluayBpdCB3b3VsZCBiZSBnb29kIHRvIGFkZCBpdCB0byAN
Cj4gaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCBhbmQgaW5jbHVkZSB0aGF0
IGZpbGUgaGVyZS4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpvay4gSSdsbCBkbyB0aGlz
IGluIG5leHQgdmVyc2lvbi4NCj4gDQo+ID4gICAjZGVmaW5lIE1US19QUk9URUNUX1BBX0FMSUdO
CQkJMTI4DQo+ID4gICANCj4gPiAgIC8qDQo+ID4gQEAgLTU5OSw4ICs2MDMsMTAgQEAgc3RhdGlj
IGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
IAlzdHJ1Y3QgcmVzb3VyY2UgICAgICAgICAqcmVzOw0KPiA+ICAgCXJlc291cmNlX3NpemVfdAkJ
aW9hZGRyOw0KPiA+ICAgCXN0cnVjdCBjb21wb25lbnRfbWF0Y2ggICptYXRjaCA9IE5VTEw7DQo+
ID4gKwlzdHJ1Y3QgcmVnbWFwCQkqaW5mcmFjZmdfcmVnbWFwOw0KPiANCj4gTWF5YmUgY2FsbCBp
dCBqdXN0IGluZnJhY2ZnLg0KDQpvay4gSSdsbCBkbyB0aGlzIGluIG5leHQgdmVyc2lvbi4gDQo+
IA0KPiA+ICAgCXZvaWQgICAgICAgICAgICAgICAgICAgICpwcm90ZWN0Ow0KPiA+ICAgCWludCAg
ICAgICAgICAgICAgICAgICAgIGksIGxhcmJfbnIsIHJldDsNCj4gPiArCXUzMgkJCXZhbDsNCj4g
PiAgIA0KPiA+ICAgCWRhdGEgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBf
S0VSTkVMKTsNCj4gPiAgIAlpZiAoIWRhdGEpDQo+ID4gQEAgLTYxNCwxMCArNjIwLDE4IEBAIHN0
YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gICAJCXJldHVybiAtRU5PTUVNOw0KPiA+ICAgCWRhdGEtPnByb3RlY3RfYmFzZSA9IEFMSUdO
KHZpcnRfdG9fcGh5cyhwcm90ZWN0KSwgTVRLX1BST1RFQ1RfUEFfQUxJR04pOw0KPiA+ICAgDQo+
ID4gLQkvKiBXaGV0aGVyIHRoZSBjdXJyZW50IGRyYW0gaXMgb3ZlciA0R0IgKi8NCj4gPiAtCWRh
dGEtPmVuYWJsZV80R0IgPSAhIShtYXhfcGZuID4gKEJJVF9VTEwoMzIpID4+IFBBR0VfU0hJRlQp
KTsNCj4gPiAtCWlmICghZGF0YS0+cGxhdF9kYXRhLT5oYXNfNGdiX21vZGUpDQo+ID4gKwlpZiAo
ZGF0YS0+cGxhdF9kYXRhLT5oYXNfNGdiX21vZGUpIHsNCj4gPiArCQlpbmZyYWNmZ19yZWdtYXAg
PSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKGRldi0+b2Zfbm9kZSwNCj4gPiArCQkJ
CSJtZWRpYXRlayxpbmZyYWNmZyIpOw0KPiA+ICsJCWlmIChJU19FUlIoaW5mcmFjZmdfcmVnbWFw
KSkNCj4gPiArCQkJcmV0dXJuIFBUUl9FUlIoaW5mcmFjZmdfcmVnbWFwKTsNCj4gDQo+IERvIHdl
IG5lZWQgdG8gZXJyb3Igb3V0LCBvciBjb3VsZCB3ZSBiZSBjb25zZXJ2YXRpdmUgYW5kIHNldCBl
bmRhYmxlXzRHQiA9IGZhbHNlPw0KDQpXZSBoYXZlIHRvIGVycm9yIG91dCBpbiB0aGlzIGNhc2Ug
YmVjYXVzZSB0aGUgNGdiX21vZGUgc2V0dGluZyBtdXN0IGJlDQpjb25zaXN0ZW50IHdpdGggdGhl
IGgvdyBzZXR0aW5nLg0KDQo+IA0KPiA+ICsJCXJldCA9IHJlZ21hcF9yZWFkKGluZnJhY2ZnX3Jl
Z21hcCwgUkVHX0lORlJBX01JU0MsICZ2YWwpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJl
dHVybiByZXQ7DQo+ID4gKwkJZGF0YS0+ZW5hYmxlXzRHQiA9ICEhKHZhbCAmIEZfRERSXzRHQl9T
VVBQT1JUX0VOKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gICAJCWRhdGEtPmVuYWJsZV80R0IgPSBm
YWxzZTsNCj4gDQo+IE1vdmUgdGhhdCBiZWZvcmUgdGhlIGlmKCkgYW5kIHVwZGF0ZSBlbmFibGVf
NEdCIG9ubHkgaW4gY2FzZSBvZiBoYXNfNGdiX21vZGUuDQoNCm9rLiBJJ2xsIGRvIHRoaXMgaW4g
bmV4dCB2ZXJzaW9uLg0KDQpNaWxlcw0KPiANCj4gPiArCX0NCj4gPiAgIA0KPiA+ICAgCXJlcyA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gICAJ
ZGF0YS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+ID4gDQoNCg==

