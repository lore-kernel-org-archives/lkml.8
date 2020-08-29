Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B667DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0A208A9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P3IN9sfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgH2Ivb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:51:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42926 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726280AbgH2Iv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:51:26 -0400
X-UUID: a3ef6c5f6f394e619b9502582e028790-20200829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qB65JvNr4zmGYx3nhQrYXy0tBUEmKp+M+ZtGMwCgkrg=;
        b=P3IN9sfz2JqgBKezp3WwLMQOHzCCPvZU44zmxVehZ0Lzunafo3VDxSIvdKOqkpABGE2JNZhRUzUiENVQc3FKlrbMqqH7yHVe+BfWjL82Losk1TDmLVbitawkeXBpxOLwQXqeysFmY0HoAclfkPt5sV5oMaEj/PHsbQHB/nO0+3s=;
X-UUID: a3ef6c5f6f394e619b9502582e028790-20200829
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1633658668; Sat, 29 Aug 2020 16:51:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 29 Aug 2020 16:51:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 29 Aug 2020 16:51:19 +0800
Message-ID: <1598691080.9982.9.camel@mtkswgap22>
Subject: Re: [RESEND PATCH v4] iommu/mediatek: check 4GB mode by reading
 infracfg
From:   Miles Chen <miles.chen@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>,
        <wsd_upstream@mediatek.com>, David Hildenbrand <david@redhat.com>,
        "Joerg Roedel" <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 29 Aug 2020 16:51:20 +0800
In-Reply-To: <e34db4dc-49a6-d414-e438-b528703ffb80@arm.com>
References: <20200826085618.2889-1-miles.chen@mediatek.com>
         <1598506280.19851.5.camel@mhfsdcap03>
         <e34db4dc-49a6-d414-e438-b528703ffb80@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CC0124F12646A90ABE3CE289DF8E2C577772453E21C8EABC2308FFBE2B5335F42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTI3IGF0IDIwOjI3ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMDgtMjcgMDY6MzEsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIwLTA4
LTI2IGF0IDE2OjU2ICswODAwLCBNaWxlcyBDaGVuIHdyb3RlOg0KPiA+PiBJbiBwcmV2aW91cyBk
aXNjdXNzaW9uIFsxXSBhbmQgWzJdLCB3ZSBmb3VuZCB0aGF0IGl0IGlzIHJpc2t5IHRvDQo+ID4+
IHVzZSBtYXhfcGZuIG9yIHRvdGFscmFtX3BhZ2VzIHRvIHRlbGwgaWYgNEdCIG1vZGUgaXMgZW5h
YmxlZC4NCj4gPj4NCj4gPj4gQ2hlY2sgNEdCIG1vZGUgYnkgcmVhZGluZyBpbmZyYWNmZyByZWdp
c3RlciwgcmVtb3ZlIHRoZSB1c2FnZQ0KPiA+PiBvZiB0aGUgdW4tZXhwb3J0ZWQgc3ltYm9sIG1h
eF9wZm4uDQo+ID4+DQo+ID4+IFRoaXMgaXMgYSBzdGVwIHRvd2FyZHMgYnVpbGRpbmcgbXRrX2lv
bW11IGFzIGEga2VybmVsIG1vZHVsZS4NCj4gPj4NCj4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMDA2MDMxNjExMzIuMjQ0MS0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29t
Lw0KPiA+PiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMDYwNDA4MDEyMC4y
NjI4LTEtbWlsZXMuY2hlbkBtZWRpYXRlay5jb20vDQo+ID4+IFszXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjAwNzE1MjA1MTIwLkdBNzc4ODc2QGJvZ3VzLw0KPiA+Pg0KPiA+PiBD
YzogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPiA+PiBDYzogRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4+IENjOiBZb25nIFd1IDx5b25nLnd1QG1l
ZGlhdGVrLmNvbT4NCj4gPj4gQ2M6IFlpbmdqb2UgQ2hlbiA8eWluZ2pvZS5jaGVuQG1lZGlhdGVr
LmNvbT4NCj4gPj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiA+PiBDYzog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPj4gQ2M6IE1hdHRoaWFzIEJydWdnZXIg
PG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4g
PG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+Pg0KPiA+PiAtLS0NCj4gPj4NCj4gPj4gQ2hh
bmdlIHNpbmNlIHYzDQo+ID4+IC0gdXNlIGxvcmUua2VybmVsLm9yZyBsaW5rcw0KPiA+PiAtIG1v
dmUgImNoYW5nZSBzaW5jZS4uLiIgYWZ0ZXIgIi0tLSINCj4gPj4NCj4gPj4gQ2hhbmdlIHNpbmNl
IHYyOg0KPiA+PiAtIGRldGVybWluZSBjb21wYXRpYmxlIHN0cmluZyBieSBtNHVfcGxhdA0KPiA+
PiAtIHJlYmFzZSB0byBuZXh0LTIwMjAwNzIwDQo+ID4+IC0gYWRkICItLS0iDQo+ID4+DQo+ID4+
IENoYW5nZSBzaW5jZSB2MToNCj4gPj4gLSByZW1vdmUgdGhlIHBoYW5kbGUgdXNhZ2UsIHNlYXJj
aCBmb3IgaW5mcmFjZmcgaW5zdGVhZCBbM10NCj4gPj4gLSB1c2UgaW5mcmFjZmcgaW5zdGVhZCBv
ZiBpbmZyYWNmZ19yZWdtYXANCj4gPj4gLSBtb3ZlIGluZnJhY2ZnIGRlZmluaXRhaW9ucyB0byBs
aW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KPiA+PiAtIHVwZGF0ZSBlbmFibGVfNEdCIG9u
bHkgd2hlbiBoYXNfNGdiX21vZGUNCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYyAgICAgICAgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+
PiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggfCAgMyArKysNCj4gPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4+
DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYw0KPiA+PiBpbmRleCA3ODViMjI4ZDM5YTYuLmFkYzM1MDE1MDQ5MiAx
MDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+PiArKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4+IEBAIC0zLDcgKzMsNiBAQA0KPiA+PiAgICAq
IENvcHlyaWdodCAoYykgMjAxNS0yMDE2IE1lZGlhVGVrIEluYy4NCj4gPj4gICAgKiBBdXRob3I6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+PiAgICAqLw0KPiA+PiAtI2luY2x1
ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0KPiA+
PiAgICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvY29tcG9u
ZW50Lmg+DQo+ID4+IEBAIC0xNSwxMyArMTQsMTYgQEANCj4gPj4gICAjaW5jbHVkZSA8bGludXgv
aW9tbXUuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4+ICAgI2luY2x1
ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+
ID4+ICAgI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGlu
dXgvb2ZfaW9tbXUuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4+ICAg
I2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+PiAg
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2Nr
Lmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmg+DQo+ID4+
ICAgI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQo+ID4+ICAgI2luY2x1ZGUgPHNvYy9tZWRpYXRl
ay9zbWkuaD4NCj4gPj4gICANCj4gPj4gQEAgLTY0MCw4ICs2NDIsMTEgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4gICAJc3Ry
dWN0IHJlc291cmNlICAgICAgICAgKnJlczsNCj4gPj4gICAJcmVzb3VyY2Vfc2l6ZV90CQlpb2Fk
ZHI7DQo+ID4+ICAgCXN0cnVjdCBjb21wb25lbnRfbWF0Y2ggICptYXRjaCA9IE5VTEw7DQo+ID4+
ICsJc3RydWN0IHJlZ21hcAkJKmluZnJhY2ZnOw0KPiA+PiAgIAl2b2lkICAgICAgICAgICAgICAg
ICAgICAqcHJvdGVjdDsNCj4gPj4gICAJaW50ICAgICAgICAgICAgICAgICAgICAgaSwgbGFyYl9u
ciwgcmV0Ow0KPiA+PiArCXUzMgkJCXZhbDsNCj4gPj4gKwljaGFyICAgICAgICAgICAgICAgICAg
ICAqcDsNCj4gPj4gICANCj4gPj4gICAJZGF0YSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigq
ZGF0YSksIEdGUF9LRVJORUwpOw0KPiA+PiAgIAlpZiAoIWRhdGEpDQo+ID4+IEBAIC02NTUsMTAg
KzY2MCwyOSBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4+ICAgCWRhdGEtPnByb3Rl
Y3RfYmFzZSA9IEFMSUdOKHZpcnRfdG9fcGh5cyhwcm90ZWN0KSwgTVRLX1BST1RFQ1RfUEFfQUxJ
R04pOw0KPiA+PiAgIA0KPiA+PiAtCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBpcyBvdmVy
IDRHQiAqLw0KPiA+PiAtCWRhdGEtPmVuYWJsZV80R0IgPSAhIShtYXhfcGZuID4gKEJJVF9VTEwo
MzIpID4+IFBBR0VfU0hJRlQpKTsNCj4gPj4gLQlpZiAoIU1US19JT01NVV9IQVNfRkxBRyhkYXRh
LT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpDQo+ID4+IC0JCWRhdGEtPmVuYWJsZV80R0IgPSBm
YWxzZTsNCj4gPj4gKwlkYXRhLT5lbmFibGVfNEdCID0gZmFsc2U7DQo+IA0KPiBOaXQ6IHRoaXMg
aXNuJ3QgcmVhbGx5IG5lY2Vzc2FyeSwgc2luY2UgdGhlIHN0cnVjdHVyZSBpcyBremFsbG9jKCll
ZC4NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudCwgSSB3aWxsIHJlbW92ZSB0aGlzIHRoaXMgaW4g
djUuDQo+IA0KPiA+PiArCWlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBI
QVNfNEdCX01PREUpKSB7DQo+ID4+ICsJCXN3aXRjaCAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxh
dCkgew0KPiA+PiArCQljYXNlIE00VV9NVDI3MTI6DQo+ID4+ICsJCQlwID0gIm1lZGlhdGVrLG10
MjcxMi1pbmZyYWNmZyI7DQo+ID4+ICsJCQlicmVhazsNCj4gPj4gKwkJY2FzZSBNNFVfTVQ4MTcz
Og0KPiA+PiArCQkJcCA9ICJtZWRpYXRlayxtdDgxNzMtaW5mcmFjZmciOw0KPiA+PiArCQkJYnJl
YWs7DQo+ID4+ICsJCWRlZmF1bHQ6DQo+ID4+ICsJCQlwID0gTlVMTDsNCj4gPj4gKwkJfQ0KPiA+
PiArDQo+ID4gDQo+ID4gVGhpcyBjYW4gYmUgc2ltcGxpZmllZDoNCj4gPiANCj4gPiAgICAgICAg
ICBpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQyNzEyKQ0KPiA+IAkJcCA9
ICJtZWRpYXRlayxtdDI3MTItaW5mcmFjZmciOw0KPiA+IAllbHNlIGlmKGRhdGEtPnBsYXRfZGF0
YS0+bTR1X3BsYXQgPT0gTTRVX01UODE3MykNCj4gPiAJCXAgPSAibWVkaWF0ZWssbXQ4MTczLWlu
ZnJhY2ZnIjsNCj4gPiAJZWxzZQ0KPiA+IAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBSaWdodCwg
YXQgdGhpcyBwb2ludCB0aGUgSEFTXzRHQl9NT0RFIGZsYWcgaXMgZW50aXJlbHkgcmVkdW5kYW50
IGFuZCANCj4gc2hvdWxkIGJlIHJlbW92ZWQuIEZXSVcgSSBzdGlsbCB0aGluayB5b3VyIHN1Z2dl
c3Rpb24gb2YgcHV0dGluZyB0aGUgDQo+IGluZnJhY2ZnIG5hbWVzIGludG8gcGxhdF9kYXRhIHdv
dWxkIGJlIGV2ZW4gYmV0dGVyIGFuZCBjbGVhbmVyIC0gdGhlcmUncyANCj4gcGxlbnR5IG9mIHBy
ZWNlZGVudCBmb3IgdGhhdCBzb3J0IG9mIHRoaW5nIChzZWUgImdpdCBncmVwICdcLmNsa19uYW1l
JyIgDQo+IGZvciBleGFtcGxlKS4NCj4gDQo+IFJvYmluLg0KDQpobW0sIEkgaGF2ZSBubyBzdHJv
bmcgb3BpbmlvbiBhYm91dCB0aGlzLiBXZSBoYXZlIGRpc2N1c3NlZCB0aGlzDQphcHByb2FjaCBi
ZWZvcmUgYW5kIGJ1aWx0IHRoaXMgcGF0Y2ggYmFzZWQgb24gdGhlIGRpc2N1c3Npb24uDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTI3NjgwMS8NCg0KDQoNCk1pbGVz
DQo+IA0KPiA+IA0KPiA+IFRoZW4sDQo+ID4gUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VA
bWVkaWF0ZWsuY29tPg0KPiA+IAkNCj4gPiANCj4gPj4gKwkJaW5mcmFjZmcgPSBzeXNjb25fcmVn
bWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKHApOw0KPiA+PiArDQo+ID4+ICsJCWlmIChJU19FUlIo
aW5mcmFjZmcpKQ0KPiA+PiArCQkJcmV0dXJuIFBUUl9FUlIoaW5mcmFjZmcpOw0KPiA+PiArDQo+
ID4+ICsJCXJldCA9IHJlZ21hcF9yZWFkKGluZnJhY2ZnLCBSRUdfSU5GUkFfTUlTQywgJnZhbCk7
DQo+ID4+ICsJCWlmIChyZXQpDQo+ID4+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+PiArCQlkYXRhLT5l
bmFibGVfNEdCID0gISEodmFsICYgRl9ERFJfNEdCX1NVUFBPUlRfRU4pOw0KPiA+PiArCX0NCj4g
Pj4gICANCj4gPj4gICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VS
Q0VfTUVNLCAwKTsNCj4gPj4gICAJZGF0YS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShk
ZXYsIHJlcyk7DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9p
bmZyYWNmZy5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KPiA+PiBp
bmRleCBmZDI1ZjAxNDg1NjYuLjIzMzQ2M2Q3ODljNiAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KPiA+PiArKysgYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo+ID4+IEBAIC0zMiw2ICszMiw5IEBADQo+ID4+ICAg
I2RlZmluZSBNVDc2MjJfVE9QX0FYSV9QUk9UX0VOX1dCCQkoQklUKDIpIHwgQklUKDYpIHwgXA0K
PiA+PiAgIAkJCQkJCSBCSVQoNykgfCBCSVQoOCkpDQo+ID4+ICAgDQo+ID4+ICsjZGVmaW5lIFJF
R19JTkZSQV9NSVNDCQkJCTB4ZjAwDQo+ID4+ICsjZGVmaW5lIEZfRERSXzRHQl9TVVBQT1JUX0VO
CQkJQklUKDEzKQ0KPiA+PiArDQo+ID4+ICAgaW50IG10a19pbmZyYWNmZ19zZXRfYnVzX3Byb3Rl
Y3Rpb24oc3RydWN0IHJlZ21hcCAqaW5mcmFjZmcsIHUzMiBtYXNrLA0KPiA+PiAgIAkJYm9vbCBy
ZWdfdXBkYXRlKTsNCj4gPj4gICBpbnQgbXRrX2luZnJhY2ZnX2NsZWFyX2J1c19wcm90ZWN0aW9u
KHN0cnVjdCByZWdtYXAgKmluZnJhY2ZnLCB1MzIgbWFzaywNCj4gPiANCj4gPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsDQo+ID4gDQoNCg==

