Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17167C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01EF2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NjCDJqZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgGVJh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:37:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGVJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:37:27 -0400
X-UUID: bc25f425410f41ba8a1479cacb3d51f7-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FbUlnD+6PGhMZQV7tfhB8H9xa+hG0Mjtj1brBRLF1eY=;
        b=NjCDJqZSzVquYPFYJwusCyl/Vop979U6xQSBzPzcZwY8yH2c+KowPJAc7jw/6zgmYvqola2IawEkb4pSxDkUiKZt+vQs4ITmdsEUJSiyMWfsteRHOuCRH1WMMTFYpOLxBlxgHBCia9QVM0JHib40F9LYPZXI3mH6pyCF/6TwDgQ=;
X-UUID: bc25f425410f41ba8a1479cacb3d51f7-20200722
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 663952016; Wed, 22 Jul 2020 17:37:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 17:37:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 17:37:17 +0800
Message-ID: <1595410637.10848.7.camel@mtkswgap22>
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
Date:   Wed, 22 Jul 2020 17:37:17 +0800
In-Reply-To: <1595402238.10848.3.camel@mtkswgap22>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
         <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
         <1595330677.16172.55.camel@mhfsdcap03>
         <28bf052f-e388-d300-4abe-38f17bff01b6@gmail.com>
         <1595402238.10848.3.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C22B2906B1149C311E4910FDDED4D5CC64A63EC1BAEA8344B0C812F5ABAEB5352000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTIyIGF0IDE1OjE3ICswODAwLCBNaWxlcyBDaGVuIHdyb3RlOg0KPiBP
biBUdWUsIDIwMjAtMDctMjEgYXQgMjM6MTkgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6
DQo+ID4gDQo+ID4gT24gMjEvMDcvMjAyMCAxMzoyNCwgWW9uZyBXdSB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgMjAyMC0wNy0yMSBhdCAxMTo0MCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToN
Cj4gPiA+Pg0KPiA+ID4+IE9uIDIxLzA3LzIwMjAgMDQ6MTYsIE1pbGVzIENoZW4gd3JvdGU6DQo+
ID4gPj4+IEluIHByZXZpb3VzIGRpc2N1c3Npb24gWzFdIGFuZCBbMl0sIHdlIGZvdW5kIHRoYXQg
aXQgaXMgcmlza3kgdG8NCj4gPiA+Pj4gdXNlIG1heF9wZm4gb3IgdG90YWxyYW1fcGFnZXMgdG8g
dGVsbCBpZiA0R0IgbW9kZSBpcyBlbmFibGVkLg0KPiA+ID4+Pg0KPiA+ID4+PiBDaGVjayA0R0Ig
bW9kZSBieSByZWFkaW5nIGluZnJhY2ZnIHJlZ2lzdGVyLCByZW1vdmUgdGhlIHVzYWdlDQo+ID4g
Pj4+IG9mIHRoZSB1bi1leHBvcnRlZCBzeW1ib2wgbWF4X3Bmbi4NCj4gPiA+Pj4NCj4gPiA+Pj4g
VGhpcyBpcyBhIHN0ZXAgdG93YXJkcyBidWlsZGluZyBtdGtfaW9tbXUgYXMgYSBrZXJuZWwgbW9k
dWxlLg0KPiA+ID4+Pg0KPiA+ID4+PiBDaGFuZ2Ugc2luY2UgdjE6DQo+ID4gPj4+IDEuIHJlbW92
ZSB0aGUgcGhhbmRsZSB1c2FnZSwgc2VhcmNoIGZvciBpbmZyYWNmZyBpbnN0ZWFkIFszXQ0KPiA+
ID4+PiAyLiB1c2UgaW5mcmFjZmcgaW5zdGVhZCBvZiBpbmZyYWNmZ19yZWdtYXANCj4gPiA+Pj4g
My4gbW92ZSBpbmZyYWNmZyBkZWZpbml0YWlvbnMgdG8gbGludXgvc29jL21lZGlhdGVrL2luZnJh
Y2ZnLmgNCj4gPiA+Pj4gNC4gdXBkYXRlIGVuYWJsZV80R0Igb25seSB3aGVuIGhhc180Z2JfbW9k
ZQ0KPiA+ID4+Pg0KPiA+ID4+PiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vbGttbC5vcmcvbGttbC8yMDIwLzYvMy83MzNfXzshIUNUUk5LQTl3TWcwQVJidyF3NVlqWTgz
WVJMOV9pamdYSHdCMXgyRG5iNUJxaUZVSThINUlBeUFXV0ZNdlVKS0k5UWJqX3p0YTJBYWlGWmVq
aVEkIA0KPiA+ID4+PiBbMl0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDIwLzYvNC8xMzZfXzshIUNUUk5LQTl3TWcwQVJidyF3NVlqWTgzWVJMOV9p
amdYSHdCMXgyRG5iNUJxaUZVSThINUlBeUFXV0ZNdlVKS0k5UWJqX3p0YTJBYTlVMnlReWckIA0K
PiA+ID4+PiBbM10gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDIwLzcvMTUvMTE0N19fOyEhQ1RSTktBOXdNZzBBUmJ3IXc1WWpZODNZUkw5X2lqZ1hI
d0IxeDJEbmI1QnFpRlVJOEg1SUF5QVdXRk12VUpLSTlRYmpfenRhMkFheHBrX1dqdyQgDQo+ID4g
Pj4+DQo+ID4gPj4+IENjOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+ID4g
Pj4+IENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiA+Pj4gQ2M6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4+PiBDYzogWWluZ2pvZSBDaGVu
IDx5aW5nam9lLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4+PiBDYzogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+ID4gPj4+IENjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCj4gPiA+Pj4gQ2M6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ID4gPj4+
IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+ID4+PiBDYzogTWF0dGhpYXMg
QnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTog
TWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPj4+IC0tLQ0KPiA+ID4+
PiAgICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jICAgICAgICAgICAgIHwgMjYgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0NCj4gPiA+Pj4gICAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
aW5mcmFjZmcuaCB8ICAzICsrKw0KPiA+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPj4+DQo+ID4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+
ID4+PiBpbmRleCAyYmU5NmYxY2RiZDIuLjE2NzY1ZjUzMjg1MyAxMDA2NDQNCj4gPiA+Pj4gLS0t
IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+ID4+PiArKysgYi9kcml2ZXJzL2lvbW11
L210a19pb21tdS5jDQo+ID4gPj4+IEBAIC0zLDcgKzMsNiBAQA0KPiA+ID4+PiAgICAgKiBDb3B5
cmlnaHQgKGMpIDIwMTUtMjAxNiBNZWRpYVRlayBJbmMuDQo+ID4gPj4+ICAgICAqIEF1dGhvcjog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gPj4+ICAgICAqLw0KPiA+ID4+PiAt
I2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQo+ID4gPj4+ICAgICNpbmNsdWRlIDxsaW51eC9i
dWcuaD4NCj4gPiA+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ID4+PiAgICAjaW5j
bHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+ID4gPj4+IEBAIC0xNSwxMyArMTQsMTYgQEANCj4g
PiA+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+DQo+ID4gPj4+ICAgICNpbmNsdWRlIDxs
aW51eC9pb3BvbGwuaD4NCj4gPiA+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPiA+
Pj4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gPj4+ICAgICNpbmNsdWRlIDxs
aW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gPj4+ICAgICNpbmNsdWRlIDxsaW51eC9vZl9pb21tdS5o
Pg0KPiA+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4gPj4+ICAgICNpbmNs
dWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ID4+PiAgICAjaW5jbHVkZSA8bGludXgvcGxh
dGZvcm1fZGV2aWNlLmg+DQo+ID4gPj4+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4g
Pj4+ICAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gPj4+ICAgICNpbmNsdWRlIDxsaW51
eC9zcGlubG9jay5oPg0KPiA+ID4+PiArI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9pbmZy
YWNmZy5oPg0KPiA+ID4+PiAgICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gPiA+Pj4gICAg
I2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gPiA+Pj4gICAgDQo+ID4gPj4+IEBAIC01
OTksOCArNjAxLDEwIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gPj4+ICAgIAlzdHJ1Y3QgcmVzb3VyY2UgICAgICAgICAqcmVz
Ow0KPiA+ID4+PiAgICAJcmVzb3VyY2Vfc2l6ZV90CQlpb2FkZHI7DQo+ID4gPj4+ICAgIAlzdHJ1
Y3QgY29tcG9uZW50X21hdGNoICAqbWF0Y2ggPSBOVUxMOw0KPiA+ID4+PiArCXN0cnVjdCByZWdt
YXAJCSppbmZyYWNmZzsNCj4gPiA+Pj4gICAgCXZvaWQgICAgICAgICAgICAgICAgICAgICpwcm90
ZWN0Ow0KPiA+ID4+PiAgICAJaW50ICAgICAgICAgICAgICAgICAgICAgaSwgbGFyYl9uciwgcmV0
Ow0KPiA+ID4+PiArCXUzMgkJCXZhbDsNCj4gPiA+Pj4gICAgDQo+ID4gPj4+ICAgIAlkYXRhID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+ID4gPj4+ICAg
IAlpZiAoIWRhdGEpDQo+ID4gPj4+IEBAIC02MTQsMTAgKzYxOCwyMiBAQCBzdGF0aWMgaW50IG10
a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4+PiAgICAJ
CXJldHVybiAtRU5PTUVNOw0KPiA+ID4+PiAgICAJZGF0YS0+cHJvdGVjdF9iYXNlID0gQUxJR04o
dmlydF90b19waHlzKHByb3RlY3QpLCBNVEtfUFJPVEVDVF9QQV9BTElHTik7DQo+ID4gPj4+ICAg
IA0KPiA+ID4+PiAtCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBpcyBvdmVyIDRHQiAqLw0K
PiA+ID4+PiAtCWRhdGEtPmVuYWJsZV80R0IgPSAhIShtYXhfcGZuID4gKEJJVF9VTEwoMzIpID4+
IFBBR0VfU0hJRlQpKTsNCj4gPiA+Pj4gLQlpZiAoIWRhdGEtPnBsYXRfZGF0YS0+aGFzXzRnYl9t
b2RlKQ0KPiA+ID4+PiAtCQlkYXRhLT5lbmFibGVfNEdCID0gZmFsc2U7DQo+ID4gPj4+ICsJZGF0
YS0+ZW5hYmxlXzRHQiA9IGZhbHNlOw0KPiA+ID4+PiArCWlmIChkYXRhLT5wbGF0X2RhdGEtPmhh
c180Z2JfbW9kZSkgew0KPiA+ID4+PiArCQlpbmZyYWNmZyA9IHN5c2Nvbl9yZWdtYXBfbG9va3Vw
X2J5X2NvbXBhdGlibGUoDQo+ID4gPj4+ICsJCQkJIm1lZGlhdGVrLG10ODE3My1pbmZyYWNmZyIp
Ow0KPiA+ID4+PiArCQlpZiAoSVNfRVJSKGluZnJhY2ZnKSkgew0KPiA+ID4+PiArCQkJaW5mcmFj
ZmcgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKA0KPiA+ID4+PiArCQkJCQki
bWVkaWF0ZWssbXQyNzEyLWluZnJhY2ZnIik7DQo+ID4gPj4+ICsJCQlpZiAoSVNfRVJSKGluZnJh
Y2ZnKSkNCj4gPiA+Pj4gKwkJCQlyZXR1cm4gUFRSX0VSUihpbmZyYWNmZyk7DQo+ID4gPj4NCj4g
PiA+PiBJIHRoaW5rIHdlIHNob3VsZCBjaGVjayBtNHVfcGxhdCBpbnN0ZWFkIHRvIGRlY2lkZSB3
aGljaCBjb21wYXRpYmxlIHdlIGhhdmUgdG8NCj4gPiA+PiBsb29rIGZvci4NCj4gPiA+PiBBbm90
aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBhZGQgYSBnZW5lcmFsIGNvbXBhdGlibGUgc29tZXRoaW5n
IGxpa2UNCj4gPiA+PiAibXRrLWluZnJhY2ZnIiBhbmQgc2VhcmNoIGZvciB0aGF0LiBUaGF0IHdv
dWxkIG5lZWQgYW4gdXBkYXRlIG9mIGFsbCBEVFMgaGF2aW5nDQo+ID4gPj4gYSBpbmZyYWNmZyBj
b21wYXRpYmxlIHJpZ2h0IG5vdy4gQWZ0ZXIgdGhpbmtpbmcgdHdpY2UsIHRoaXMgd291bGQgYnJl
YWsgbmV3ZXINCj4gPiA+PiBrZXJuZWwgd2l0aCBvbGRlciBkZXZpY2UgdHJlZSwgc28gbWF5YmUg
aXQncyBiZXR0ZXIgdG8gZ28gd2l0aCBtNHVfcGxhdCBzd2l0Y2gNCj4gPiA+PiBzdGF0ZW1lbnQu
DQo+ID4gPiANCj4gPiA+IEFkZCBhICJjaGFyICppbmZyYWNmZyIgaW4gdGhlIHBsYXRfZGF0YSwg
VXNlIHRoZSBtdDI3MTIsIG10ODE3Mw0KPiA+ID4gY29ycmVzcG9uZGluZyBzdHJpbmcgaW4gaXQu
IElmIGl0IGlzIE5VTEwsIEl0IG1lYW5zIHRoZSAiZW5hYmxlXzRHQiINCj4gPiA+IGFsd2F5cyBp
cyBmYWxzZS4gVGhlbiB3ZSBhbHNvIGNhbiByZW1vdmUgdGhlIGZsYWcgImhhc180Z2JfbW9kZSIu
DQo+ID4gPiANCj4gPiA+IGlzIHRoaXMgT0s/DQo+ID4gPiANCj4gPiANCj4gPiBJdCdzIGFuIG9w
dGlvbiwgYnV0IEkgcGVyc29uYWxseSBmaW5kIHRoYXQgYSBiaXQgaGFja3kuDQo+IA0KPiBUaGFu
a3MgWW9uZyBhbmQgTWF0dGhpYXMgZm9yIHlvdXIgY29tbWVudC4NCj4gSSB3aWxsIHRyeSBhZGRp
bmcgYSBjaGFyICppbmZyYWNmZyBpbiBwYXRjaCB2My4NCj4gDQoNCkkgbWlzdW5kZXJzdG9vZCB0
aGUgY29tbWVudC4NCkkgc2hvdWxkIGNoZWNrIG00dV9wbGF0IHRvIGRlY2lkZSB3aGljaCBzdHJp
bmcgdG8gbG9vayBmb3IsIG5vdCBhZGRpbmcgYQ0KY2hhciAqaW5mcmFjZmcgaW4gcGF0Y2ggdjMu
DQoNCg0KTWlsZXMNCj4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBNYXR0aGlhcw0KPiANCg0K

