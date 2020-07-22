Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF03420709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eiGybXaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgGVHRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:17:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48334 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727096AbgGVHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:17:28 -0400
X-UUID: 7a2513fa0d424fa1a7682445476d6c20-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0eYS2Sr9yV83oAq6NJ7EPUIvy6CetJuQT3lQICq8KtI=;
        b=eiGybXaI8Y+E4yJdFDB9GZh+xxct51/zsUP0YJWa2H+gIUVbnQbJzQs9vxlYKJ/Vh+IID3oXb1Yhr34TJST3HN/oq9/qtgq61Kbq7kYRQBceIMrjc7Lu8rLPnXS0oHwJxN0F9zPU24Vg0Y5SzLpb9WG7p5iw7CQC8ew5Xmd/w44=;
X-UUID: 7a2513fa0d424fa1a7682445476d6c20-20200722
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1610361252; Wed, 22 Jul 2020 15:17:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:17:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:17:18 +0800
Message-ID: <1595402238.10848.3.camel@mtkswgap22>
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
From:   Miles Chen <miles.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Rob Herring" <robh@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Wed, 22 Jul 2020 15:17:18 +0800
In-Reply-To: <28bf052f-e388-d300-4abe-38f17bff01b6@gmail.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
         <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
         <1595330677.16172.55.camel@mhfsdcap03>
         <28bf052f-e388-d300-4abe-38f17bff01b6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 58DFCF7CA20D7056E3E09FFF1EF0DBB987C420E96805A5AFD92BC2023E6D19FD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTIxIGF0IDIzOjE5ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjEvMDcvMjAyMCAxMzoyNCwgWW9uZyBXdSB3cm90ZToNCj4gPiBPbiBUdWUs
IDIwMjAtMDctMjEgYXQgMTE6NDAgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+ID4+
DQo+ID4+IE9uIDIxLzA3LzIwMjAgMDQ6MTYsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4+PiBJbiBw
cmV2aW91cyBkaXNjdXNzaW9uIFsxXSBhbmQgWzJdLCB3ZSBmb3VuZCB0aGF0IGl0IGlzIHJpc2t5
IHRvDQo+ID4+PiB1c2UgbWF4X3BmbiBvciB0b3RhbHJhbV9wYWdlcyB0byB0ZWxsIGlmIDRHQiBt
b2RlIGlzIGVuYWJsZWQuDQo+ID4+Pg0KPiA+Pj4gQ2hlY2sgNEdCIG1vZGUgYnkgcmVhZGluZyBp
bmZyYWNmZyByZWdpc3RlciwgcmVtb3ZlIHRoZSB1c2FnZQ0KPiA+Pj4gb2YgdGhlIHVuLWV4cG9y
dGVkIHN5bWJvbCBtYXhfcGZuLg0KPiA+Pj4NCj4gPj4+IFRoaXMgaXMgYSBzdGVwIHRvd2FyZHMg
YnVpbGRpbmcgbXRrX2lvbW11IGFzIGEga2VybmVsIG1vZHVsZS4NCj4gPj4+DQo+ID4+PiBDaGFu
Z2Ugc2luY2UgdjE6DQo+ID4+PiAxLiByZW1vdmUgdGhlIHBoYW5kbGUgdXNhZ2UsIHNlYXJjaCBm
b3IgaW5mcmFjZmcgaW5zdGVhZCBbM10NCj4gPj4+IDIuIHVzZSBpbmZyYWNmZyBpbnN0ZWFkIG9m
IGluZnJhY2ZnX3JlZ21hcA0KPiA+Pj4gMy4gbW92ZSBpbmZyYWNmZyBkZWZpbml0YWlvbnMgdG8g
bGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCj4gPj4+IDQuIHVwZGF0ZSBlbmFibGVfNEdC
IG9ubHkgd2hlbiBoYXNfNGdiX21vZGUNCj4gPj4+DQo+ID4+PiBbMV0gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzYvMy83MzNfXzshIUNUUk5L
QTl3TWcwQVJidyF3NVlqWTgzWVJMOV9pamdYSHdCMXgyRG5iNUJxaUZVSThINUlBeUFXV0ZNdlVK
S0k5UWJqX3p0YTJBYWlGWmVqaVEkIA0KPiA+Pj4gWzJdIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82LzQvMTM2X187ISFDVFJOS0E5d01nMEFS
YnchdzVZalk4M1lSTDlfaWpnWEh3QjF4MkRuYjVCcWlGVUk4SDVJQXlBV1dGTXZVSktJOVFial96
dGEyQWE5VTJ5UXlnJCANCj4gPj4+IFszXSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8xNS8xMTQ3X187ISFDVFJOS0E5d01nMEFSYnchdzVZ
alk4M1lSTDlfaWpnWEh3QjF4MkRuYjVCcWlGVUk4SDVJQXlBV1dGTXZVSktJOVFial96dGEyQWF4
cGtfV2p3JCANCj4gPj4+DQo+ID4+PiBDYzogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0u
Y29tPg0KPiA+Pj4gQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiA+
Pj4gQ2M6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+Pj4gQ2M6IFlpbmdqb2Ug
Q2hlbiA8eWluZ2pvZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPj4+IENjOiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCj4gPj4+IENjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCj4gPj4+IENjOiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KPiA+Pj4gQ2M6
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4+PiBDYzogTWF0dGhpYXMgQnJ1Z2dl
ciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENo
ZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJz
L2lvbW11L210a19pb21tdS5jICAgICAgICAgICAgIHwgMjYgKysrKysrKysrKysrKysrKysrKysr
LS0tLS0NCj4gPj4+ICAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggfCAg
MyArKysNCj4gPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPj4+IGluZGV4IDJiZTk2ZjFjZGJk
Mi4uMTY3NjVmNTMyODUzIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+Pj4gQEAgLTMs
NyArMyw2IEBADQo+ID4+PiAgICAgKiBDb3B5cmlnaHQgKGMpIDIwMTUtMjAxNiBNZWRpYVRlayBJ
bmMuDQo+ID4+PiAgICAgKiBBdXRob3I6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0K
PiA+Pj4gICAgICovDQo+ID4+PiAtI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQo+ID4+PiAg
ICAjaW5jbHVkZSA8bGludXgvYnVnLmg+DQo+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvY2xrLmg+
DQo+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+ID4+PiBAQCAtMTUsMTMg
KzE0LDE2IEBADQo+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCj4gPj4+ICAgICNp
bmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPj4+ICAgICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+
DQo+ID4+PiArI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPj4+ICAgICNpbmNsdWRl
IDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvb2ZfaW9tbXUu
aD4NCj4gPj4+ICAgICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gPj4+ICAgICNpbmNsdWRl
IDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KPiA+Pj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPj4+ICAgICNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2su
aD4NCj4gPj4+ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmg+DQo+ID4+
PiAgICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPj4+ICAgICNpbmNsdWRlIDxzb2MvbWVk
aWF0ZWsvc21pLmg+DQo+ID4+PiAgICANCj4gPj4+IEBAIC01OTksOCArNjAxLDEwIEBAIHN0YXRp
YyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+
PiAgICAJc3RydWN0IHJlc291cmNlICAgICAgICAgKnJlczsNCj4gPj4+ICAgIAlyZXNvdXJjZV9z
aXplX3QJCWlvYWRkcjsNCj4gPj4+ICAgIAlzdHJ1Y3QgY29tcG9uZW50X21hdGNoICAqbWF0Y2gg
PSBOVUxMOw0KPiA+Pj4gKwlzdHJ1Y3QgcmVnbWFwCQkqaW5mcmFjZmc7DQo+ID4+PiAgICAJdm9p
ZCAgICAgICAgICAgICAgICAgICAgKnByb3RlY3Q7DQo+ID4+PiAgICAJaW50ICAgICAgICAgICAg
ICAgICAgICAgaSwgbGFyYl9uciwgcmV0Ow0KPiA+Pj4gKwl1MzIJCQl2YWw7DQo+ID4+PiAgICAN
Cj4gPj4+ICAgIAlkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tF
Uk5FTCk7DQo+ID4+PiAgICAJaWYgKCFkYXRhKQ0KPiA+Pj4gQEAgLTYxNCwxMCArNjE4LDIyIEBA
IHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4+PiAgICAJCXJldHVybiAtRU5PTUVNOw0KPiA+Pj4gICAgCWRhdGEtPnByb3RlY3RfYmFz
ZSA9IEFMSUdOKHZpcnRfdG9fcGh5cyhwcm90ZWN0KSwgTVRLX1BST1RFQ1RfUEFfQUxJR04pOw0K
PiA+Pj4gICAgDQo+ID4+PiAtCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBpcyBvdmVyIDRH
QiAqLw0KPiA+Pj4gLQlkYXRhLT5lbmFibGVfNEdCID0gISEobWF4X3BmbiA+IChCSVRfVUxMKDMy
KSA+PiBQQUdFX1NISUZUKSk7DQo+ID4+PiAtCWlmICghZGF0YS0+cGxhdF9kYXRhLT5oYXNfNGdi
X21vZGUpDQo+ID4+PiAtCQlkYXRhLT5lbmFibGVfNEdCID0gZmFsc2U7DQo+ID4+PiArCWRhdGEt
PmVuYWJsZV80R0IgPSBmYWxzZTsNCj4gPj4+ICsJaWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzXzRn
Yl9tb2RlKSB7DQo+ID4+PiArCQlpbmZyYWNmZyA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X2Nv
bXBhdGlibGUoDQo+ID4+PiArCQkJCSJtZWRpYXRlayxtdDgxNzMtaW5mcmFjZmciKTsNCj4gPj4+
ICsJCWlmIChJU19FUlIoaW5mcmFjZmcpKSB7DQo+ID4+PiArCQkJaW5mcmFjZmcgPSBzeXNjb25f
cmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKA0KPiA+Pj4gKwkJCQkJIm1lZGlhdGVrLG10Mjcx
Mi1pbmZyYWNmZyIpOw0KPiA+Pj4gKwkJCWlmIChJU19FUlIoaW5mcmFjZmcpKQ0KPiA+Pj4gKwkJ
CQlyZXR1cm4gUFRSX0VSUihpbmZyYWNmZyk7DQo+ID4+DQo+ID4+IEkgdGhpbmsgd2Ugc2hvdWxk
IGNoZWNrIG00dV9wbGF0IGluc3RlYWQgdG8gZGVjaWRlIHdoaWNoIGNvbXBhdGlibGUgd2UgaGF2
ZSB0bw0KPiA+PiBsb29rIGZvci4NCj4gPj4gQW5vdGhlciBvcHRpb24gd291bGQgYmUgdG8gYWRk
IGEgZ2VuZXJhbCBjb21wYXRpYmxlIHNvbWV0aGluZyBsaWtlDQo+ID4+ICJtdGstaW5mcmFjZmci
IGFuZCBzZWFyY2ggZm9yIHRoYXQuIFRoYXQgd291bGQgbmVlZCBhbiB1cGRhdGUgb2YgYWxsIERU
UyBoYXZpbmcNCj4gPj4gYSBpbmZyYWNmZyBjb21wYXRpYmxlIHJpZ2h0IG5vdy4gQWZ0ZXIgdGhp
bmtpbmcgdHdpY2UsIHRoaXMgd291bGQgYnJlYWsgbmV3ZXINCj4gPj4ga2VybmVsIHdpdGggb2xk
ZXIgZGV2aWNlIHRyZWUsIHNvIG1heWJlIGl0J3MgYmV0dGVyIHRvIGdvIHdpdGggbTR1X3BsYXQg
c3dpdGNoDQo+ID4+IHN0YXRlbWVudC4NCj4gPiANCj4gPiBBZGQgYSAiY2hhciAqaW5mcmFjZmci
IGluIHRoZSBwbGF0X2RhdGEsIFVzZSB0aGUgbXQyNzEyLCBtdDgxNzMNCj4gPiBjb3JyZXNwb25k
aW5nIHN0cmluZyBpbiBpdC4gSWYgaXQgaXMgTlVMTCwgSXQgbWVhbnMgdGhlICJlbmFibGVfNEdC
Ig0KPiA+IGFsd2F5cyBpcyBmYWxzZS4gVGhlbiB3ZSBhbHNvIGNhbiByZW1vdmUgdGhlIGZsYWcg
Imhhc180Z2JfbW9kZSIuDQo+ID4gDQo+ID4gaXMgdGhpcyBPSz8NCj4gPiANCj4gDQo+IEl0J3Mg
YW4gb3B0aW9uLCBidXQgSSBwZXJzb25hbGx5IGZpbmQgdGhhdCBhIGJpdCBoYWNreS4NCg0KVGhh
bmtzIFlvbmcgYW5kIE1hdHRoaWFzIGZvciB5b3VyIGNvbW1lbnQuDQpJIHdpbGwgdHJ5IGFkZGlu
ZyBhIGNoYXIgKmluZnJhY2ZnIGluIHBhdGNoIHYzLg0KDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1h
dHRoaWFzDQoNCg==

