Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C73C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093C9206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W/1lPp0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgGVHP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:15:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25251 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727096AbgGVHP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:15:58 -0400
X-UUID: d331a230923941bb81206dcd421e9959-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eioeC0FtTQ1I836sh9xci60mvaR1B/7eikG6MlrGfMw=;
        b=W/1lPp0NEbJf+lJZGPKIs45XHDlPMt+SpLnLA5Lft7lV/0qolfOC2yAziWropllbzcr4m8Qm+kWWc3dX2mozJOaB2nWdo3gpKz6BDNoPj+BY7rfEeuqW1OSFcOF2or4URpnuHRwbw+NungSZmBONWNJHf90hplUuRz1Qgg0Fbcg=;
X-UUID: d331a230923941bb81206dcd421e9959-20200722
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 160040994; Wed, 22 Jul 2020 15:15:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:15:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:15:50 +0800
Message-ID: <1595402150.10848.1.camel@mtkswgap22>
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        "Christoph Hellwig" <hch@lst.de>, Chao Hao <chao.hao@mediatek.com>
Date:   Wed, 22 Jul 2020 15:15:50 +0800
In-Reply-To: <cc04ce89-9790-b127-19e5-8f2f1b91ad4f@redhat.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
         <cc04ce89-9790-b127-19e5-8f2f1b91ad4f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 125A2A6B996131DF2178586BE457C60F26919FB3EC0293BA66AB66B8DF6B504B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTIxIGF0IDExOjEwICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMjEuMDcuMjAgMDQ6MTYsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gSW4gcHJldmlv
dXMgZGlzY3Vzc2lvbiBbMV0gYW5kIFsyXSwgd2UgZm91bmQgdGhhdCBpdCBpcyByaXNreSB0bw0K
PiA+IHVzZSBtYXhfcGZuIG9yIHRvdGFscmFtX3BhZ2VzIHRvIHRlbGwgaWYgNEdCIG1vZGUgaXMg
ZW5hYmxlZC4NCj4gPiANCj4gPiBDaGVjayA0R0IgbW9kZSBieSByZWFkaW5nIGluZnJhY2ZnIHJl
Z2lzdGVyLCByZW1vdmUgdGhlIHVzYWdlDQo+ID4gb2YgdGhlIHVuLWV4cG9ydGVkIHN5bWJvbCBt
YXhfcGZuLg0KPiA+IA0KPiA+IFRoaXMgaXMgYSBzdGVwIHRvd2FyZHMgYnVpbGRpbmcgbXRrX2lv
bW11IGFzIGEga2VybmVsIG1vZHVsZS4NCj4gPiANCj4gPiBDaGFuZ2Ugc2luY2UgdjE6DQo+ID4g
MS4gcmVtb3ZlIHRoZSBwaGFuZGxlIHVzYWdlLCBzZWFyY2ggZm9yIGluZnJhY2ZnIGluc3RlYWQg
WzNdDQo+ID4gMi4gdXNlIGluZnJhY2ZnIGluc3RlYWQgb2YgaW5mcmFjZmdfcmVnbWFwDQo+ID4g
My4gbW92ZSBpbmZyYWNmZyBkZWZpbml0YWlvbnMgdG8gbGludXgvc29jL21lZGlhdGVrL2luZnJh
Y2ZnLmgNCj4gPiA0LiB1cGRhdGUgZW5hYmxlXzRHQiBvbmx5IHdoZW4gaGFzXzRnYl9tb2RlDQo+
IA0KPiBOaXQ6IFdlIHRlbmQgdG8gcGxhY2Ugc3VjaCBpbmZvcm1hdGlvbiBiZWxvdyB0aGUgIi0t
LSIgKGFkZGluZyBhIHNlY29uZA0KPiBvbmUpIHN1Y2ggdGhhdCB0aGlzIGluZm9ybWF0aW9uIGlz
IGRpc2NhcmRlZCB3aGVuIHRoZSBwYXRjaCBpcyBwaWNrZWQgdXAuDQoNClRoYW5rcywgSSdsbCBh
ZGQgYSAiLS0tIiBiZWZvcmUgdGhlICJDaGFuZ2Ugc2luY2UuLi4iIGluIHBhdGNoIHYzLg0KPiAN
Cj4gPiANCj4gPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDIwLzYvMy83MzNfXzshIUNUUk5LQTl3TWcwQVJidyF3clAySDBhenVaa1RIU25N
X0VUa2k0a1RfRk1GMENsN2FiUVg4dElIWDBpVHI2NUprdk1DZTRqRHQ4NGRfWWhCckEkIA0KPiA+
IFsyXSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MjAvNi80LzEzNl9fOyEhQ1RSTktBOXdNZzBBUmJ3IXdyUDJIMGF6dVprVEhTbk1fRVRraTRrVF9G
TUYwQ2w3YWJRWDh0SUhYMGlUcjY1Smt2TUNlNGpEdDg2SUdobW91USQgDQo+ID4gWzNdIGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzE1LzEx
NDdfXzshIUNUUk5LQTl3TWcwQVJidyF3clAySDBhenVaa1RIU25NX0VUa2k0a1RfRk1GMENsN2Fi
UVg4dElIWDBpVHI2NUprdk1DZTRqRHQ4NTV6NHhkcXckIA0KPiA+IA0KPiA+IENjOiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+ID4gQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPg0KPiA+IENjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4N
Cj4gPiBDYzogWWluZ2pvZSBDaGVuIDx5aW5nam9lLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IENj
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gPiBDYzogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQo+ID4gQ2M6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+
DQo+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IE1hdHRoaWFz
IEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWls
ZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKyst
LS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oIHwgIDMgKysr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCAyYmU5NmYxY2RiZDIuLjE2NzY1ZjUzMjg1
MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0zLDcgKzMsNiBAQA0KPiA+ICAgKiBD
b3B5cmlnaHQgKGMpIDIwMTUtMjAxNiBNZWRpYVRlayBJbmMuDQo+ID4gICAqIEF1dGhvcjogWW9u
ZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gICAqLw0KPiA+IC0jaW5jbHVkZSA8bGlu
dXgvbWVtYmxvY2suaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvY2xrLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gPiBA
QCAtMTUsMTMgKzE0LDE2IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9pb21tdS5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9v
Zl9hZGRyZXNzLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9pb21tdS5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9yZWdtYXAuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0
ZWsvaW5mcmFjZmcuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQo+ID4gICNpbmNs
dWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQo+ID4gIA0KPiA+IEBAIC01OTksOCArNjAxLDEwIEBA
IHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgICAgICAgICAqcmVzOw0KPiA+ICAJcmVzb3VyY2Vfc2l6
ZV90CQlpb2FkZHI7DQo+ID4gIAlzdHJ1Y3QgY29tcG9uZW50X21hdGNoICAqbWF0Y2ggPSBOVUxM
Ow0KPiA+ICsJc3RydWN0IHJlZ21hcAkJKmluZnJhY2ZnOw0KPiA+ICAJdm9pZCAgICAgICAgICAg
ICAgICAgICAgKnByb3RlY3Q7DQo+ID4gIAlpbnQgICAgICAgICAgICAgICAgICAgICBpLCBsYXJi
X25yLCByZXQ7DQo+ID4gKwl1MzIJCQl2YWw7DQo+ID4gIA0KPiA+ICAJZGF0YSA9IGRldm1fa3ph
bGxvYyhkZXYsIHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFkYXRhKQ0K
PiA+IEBAIC02MTQsMTAgKzYxOCwyMiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+ICAJ
ZGF0YS0+cHJvdGVjdF9iYXNlID0gQUxJR04odmlydF90b19waHlzKHByb3RlY3QpLCBNVEtfUFJP
VEVDVF9QQV9BTElHTik7DQo+ID4gIA0KPiA+IC0JLyogV2hldGhlciB0aGUgY3VycmVudCBkcmFt
IGlzIG92ZXIgNEdCICovDQo+ID4gLQlkYXRhLT5lbmFibGVfNEdCID0gISEobWF4X3BmbiA+IChC
SVRfVUxMKDMyKSA+PiBQQUdFX1NISUZUKSk7DQo+ID4gLQlpZiAoIWRhdGEtPnBsYXRfZGF0YS0+
aGFzXzRnYl9tb2RlKQ0KPiA+IC0JCWRhdGEtPmVuYWJsZV80R0IgPSBmYWxzZTsNCj4gPiArCWRh
dGEtPmVuYWJsZV80R0IgPSBmYWxzZTsNCj4gPiArCWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc180
Z2JfbW9kZSkgew0KPiA+ICsJCWluZnJhY2ZnID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29t
cGF0aWJsZSgNCj4gPiArCQkJCSJtZWRpYXRlayxtdDgxNzMtaW5mcmFjZmciKTsNCj4gPiArCQlp
ZiAoSVNfRVJSKGluZnJhY2ZnKSkgew0KPiA+ICsJCQlpbmZyYWNmZyA9IHN5c2Nvbl9yZWdtYXBf
bG9va3VwX2J5X2NvbXBhdGlibGUoDQo+ID4gKwkJCQkJIm1lZGlhdGVrLG10MjcxMi1pbmZyYWNm
ZyIpOw0KPiA+ICsJCQlpZiAoSVNfRVJSKGluZnJhY2ZnKSkNCj4gPiArCQkJCXJldHVybiBQVFJf
RVJSKGluZnJhY2ZnKTsNCj4gPiArDQo+ID4gKwkJfQ0KPiA+ICsJCXJldCA9IHJlZ21hcF9yZWFk
KGluZnJhY2ZnLCBSRUdfSU5GUkFfTUlTQywgJnZhbCk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiAr
CQkJcmV0dXJuIHJldDsNCj4gPiArCQlkYXRhLT5lbmFibGVfNEdCID0gISEodmFsICYgRl9ERFJf
NEdCX1NVUFBPUlRfRU4pOw0KPiANCj4gKEkgYW0gYWJzb2x1dGVseSBub3QgZmFtaWxpYXIgd2l0
aCBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieSAuLi4sIEkgYW0NCj4gbWlzc2luZyBzb21lIGNvbnRl
eHQsIHNvIHNvcnJ5IGZvciB0aGUgc3R1cGlkIHF1ZXN0aW9ucykNCj4gDQo+IFdobyBzZXRzIHRo
ZSByZWdtYXAgdmFsdWUgYW5kIGJhc2VkIG9uIHdoYXQ/IFdobyBkZWNpZGVzIHRoYXQgNEdCIG1v
ZGUNCj4gaXMgc3VwcG9ydGVkIG9yIG5vdD8gQW5kIHdobyBkZWNpZGVzIGlmIDRHQiBtb2RlIGlz
ICpyZXF1aXJlZCogb3Igbm90Pw0KPiANCg0K

