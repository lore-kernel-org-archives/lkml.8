Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32766C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088FB20658
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZRsNNfLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgGULZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:25:49 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48750 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728108AbgGULZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:25:49 -0400
X-UUID: 0515596a95c24048a7b50e6f2c9789e6-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qpykmZSQGs2bMX7gw2YPF5m+GwO54FLnah9QDtNvrQ0=;
        b=ZRsNNfLe2QClA7ks/IJQ35Eb2WrkD3idGZMPmzmS5ZcXcFbVPc1u1eiC1TCntDcxiRiiePXhccXyq7TIX7P/TKHaqCp+sHB+YRbGNufIqdQExCocbCLvStuwJJ2eqgxjx3kRj5Hynm8dwpKyZniVfhH6iZmfzNYLoVW1SACiRi0=;
X-UUID: 0515596a95c24048a7b50e6f2c9789e6-20200721
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1266660983; Tue, 21 Jul 2020 19:25:42 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jul
 2020 19:25:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 19:25:39 +0800
Message-ID: <1595330677.16172.55.camel@mhfsdcap03>
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 21 Jul 2020 19:24:37 +0800
In-Reply-To: <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
         <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FAB7B75237DE000BACAED1A8055572801DDE7023171D49975F3AB582270F9ECD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTIxIGF0IDExOjQwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjEvMDcvMjAyMCAwNDoxNiwgTWlsZXMgQ2hlbiB3cm90ZToNCj4gPiBJbiBw
cmV2aW91cyBkaXNjdXNzaW9uIFsxXSBhbmQgWzJdLCB3ZSBmb3VuZCB0aGF0IGl0IGlzIHJpc2t5
IHRvDQo+ID4gdXNlIG1heF9wZm4gb3IgdG90YWxyYW1fcGFnZXMgdG8gdGVsbCBpZiA0R0IgbW9k
ZSBpcyBlbmFibGVkLg0KPiA+IA0KPiA+IENoZWNrIDRHQiBtb2RlIGJ5IHJlYWRpbmcgaW5mcmFj
ZmcgcmVnaXN0ZXIsIHJlbW92ZSB0aGUgdXNhZ2UNCj4gPiBvZiB0aGUgdW4tZXhwb3J0ZWQgc3lt
Ym9sIG1heF9wZm4uDQo+ID4gDQo+ID4gVGhpcyBpcyBhIHN0ZXAgdG93YXJkcyBidWlsZGluZyBt
dGtfaW9tbXUgYXMgYSBrZXJuZWwgbW9kdWxlLg0KPiA+IA0KPiA+IENoYW5nZSBzaW5jZSB2MToN
Cj4gPiAxLiByZW1vdmUgdGhlIHBoYW5kbGUgdXNhZ2UsIHNlYXJjaCBmb3IgaW5mcmFjZmcgaW5z
dGVhZCBbM10NCj4gPiAyLiB1c2UgaW5mcmFjZmcgaW5zdGVhZCBvZiBpbmZyYWNmZ19yZWdtYXAN
Cj4gPiAzLiBtb3ZlIGluZnJhY2ZnIGRlZmluaXRhaW9ucyB0byBsaW51eC9zb2MvbWVkaWF0ZWsv
aW5mcmFjZmcuaA0KPiA+IDQuIHVwZGF0ZSBlbmFibGVfNEdCIG9ubHkgd2hlbiBoYXNfNGdiX21v
ZGUNCj4gPiANCj4gPiBbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNi8zLzczMw0KPiA+
IFsyXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82LzQvMTM2DQo+ID4gWzNdIGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDIwLzcvMTUvMTE0Nw0KPiA+IA0KPiA+IENjOiBNaWtlIFJhcG9wb3J0
IDxycHB0QGxpbnV4LmlibS5jb20+DQo+ID4gQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBy
ZWRoYXQuY29tPg0KPiA+IENjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBD
YzogWWluZ2pvZSBDaGVuIDx5aW5nam9lLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IENjOiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gPiBDYzogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQo+ID4gQ2M6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ID4g
Q2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IE1hdHRoaWFzIEJydWdn
ZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hl
biA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11
L210a19pb21tdS5jICAgICAgICAgICAgIHwgMjYgKysrKysrKysrKysrKysrKysrKysrLS0tLS0N
Cj4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggfCAgMyArKysNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCAyYmU5NmYxY2RiZDIuLjE2NzY1ZjUzMjg1MyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysrIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0zLDcgKzMsNiBAQA0KPiA+ICAgICogQ29w
eXJpZ2h0IChjKSAyMDE1LTIwMTYgTWVkaWFUZWsgSW5jLg0KPiA+ICAgICogQXV0aG9yOiBZb25n
IFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAgICAqLw0KPiA+IC0jaW5jbHVkZSA8bGlu
dXgvbWVtYmxvY2suaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9idWcuaD4NCj4gPiAgICNpbmNs
dWRlIDxsaW51eC9jbGsuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4g
PiBAQCAtMTUsMTMgKzE0LDE2IEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCj4g
PiAgICNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9saXN0
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICAjaW5jbHVkZSA8
bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L29mX2lvbW11Lmg+DQo+
ID4gICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvb2Zf
cGxhdGZvcm0uaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmg+DQo+ID4gICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIu
aD4NCj4gPiAgICNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQo+ID4gICANCj4gPiBAQCAt
NTk5LDggKzYwMSwxMCBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCXN0cnVjdCByZXNvdXJjZSAgICAgICAgICpyZXM7DQo+
ID4gICAJcmVzb3VyY2Vfc2l6ZV90CQlpb2FkZHI7DQo+ID4gICAJc3RydWN0IGNvbXBvbmVudF9t
YXRjaCAgKm1hdGNoID0gTlVMTDsNCj4gPiArCXN0cnVjdCByZWdtYXAJCSppbmZyYWNmZzsNCj4g
PiAgIAl2b2lkICAgICAgICAgICAgICAgICAgICAqcHJvdGVjdDsNCj4gPiAgIAlpbnQgICAgICAg
ICAgICAgICAgICAgICBpLCBsYXJiX25yLCByZXQ7DQo+ID4gKwl1MzIJCQl2YWw7DQo+ID4gICAN
Cj4gPiAgIAlkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5F
TCk7DQo+ID4gICAJaWYgKCFkYXRhKQ0KPiA+IEBAIC02MTQsMTAgKzYxOCwyMiBAQCBzdGF0aWMg
aW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAg
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgIAlkYXRhLT5wcm90ZWN0X2Jhc2UgPSBBTElHTih2aXJ0
X3RvX3BoeXMocHJvdGVjdCksIE1US19QUk9URUNUX1BBX0FMSUdOKTsNCj4gPiAgIA0KPiA+IC0J
LyogV2hldGhlciB0aGUgY3VycmVudCBkcmFtIGlzIG92ZXIgNEdCICovDQo+ID4gLQlkYXRhLT5l
bmFibGVfNEdCID0gISEobWF4X3BmbiA+IChCSVRfVUxMKDMyKSA+PiBQQUdFX1NISUZUKSk7DQo+
ID4gLQlpZiAoIWRhdGEtPnBsYXRfZGF0YS0+aGFzXzRnYl9tb2RlKQ0KPiA+IC0JCWRhdGEtPmVu
YWJsZV80R0IgPSBmYWxzZTsNCj4gPiArCWRhdGEtPmVuYWJsZV80R0IgPSBmYWxzZTsNCj4gPiAr
CWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc180Z2JfbW9kZSkgew0KPiA+ICsJCWluZnJhY2ZnID0g
c3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgNCj4gPiArCQkJCSJtZWRpYXRlayxt
dDgxNzMtaW5mcmFjZmciKTsNCj4gPiArCQlpZiAoSVNfRVJSKGluZnJhY2ZnKSkgew0KPiA+ICsJ
CQlpbmZyYWNmZyA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X2NvbXBhdGlibGUoDQo+ID4gKwkJ
CQkJIm1lZGlhdGVrLG10MjcxMi1pbmZyYWNmZyIpOw0KPiA+ICsJCQlpZiAoSVNfRVJSKGluZnJh
Y2ZnKSkNCj4gPiArCQkJCXJldHVybiBQVFJfRVJSKGluZnJhY2ZnKTsNCj4gDQo+IEkgdGhpbmsg
d2Ugc2hvdWxkIGNoZWNrIG00dV9wbGF0IGluc3RlYWQgdG8gZGVjaWRlIHdoaWNoIGNvbXBhdGli
bGUgd2UgaGF2ZSB0byANCj4gbG9vayBmb3IuDQo+IEFub3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRv
IGFkZCBhIGdlbmVyYWwgY29tcGF0aWJsZSBzb21ldGhpbmcgbGlrZSANCj4gIm10ay1pbmZyYWNm
ZyIgYW5kIHNlYXJjaCBmb3IgdGhhdC4gVGhhdCB3b3VsZCBuZWVkIGFuIHVwZGF0ZSBvZiBhbGwg
RFRTIGhhdmluZyANCj4gYSBpbmZyYWNmZyBjb21wYXRpYmxlIHJpZ2h0IG5vdy4gQWZ0ZXIgdGhp
bmtpbmcgdHdpY2UsIHRoaXMgd291bGQgYnJlYWsgbmV3ZXIgDQo+IGtlcm5lbCB3aXRoIG9sZGVy
IGRldmljZSB0cmVlLCBzbyBtYXliZSBpdCdzIGJldHRlciB0byBnbyB3aXRoIG00dV9wbGF0IHN3
aXRjaCANCj4gc3RhdGVtZW50Lg0KDQpBZGQgYSAiY2hhciAqaW5mcmFjZmciIGluIHRoZSBwbGF0
X2RhdGEsIFVzZSB0aGUgbXQyNzEyLCBtdDgxNzMNCmNvcnJlc3BvbmRpbmcgc3RyaW5nIGluIGl0
LiBJZiBpdCBpcyBOVUxMLCBJdCBtZWFucyB0aGUgImVuYWJsZV80R0IiDQphbHdheXMgaXMgZmFs
c2UuIFRoZW4gd2UgYWxzbyBjYW4gcmVtb3ZlIHRoZSBmbGFnICJoYXNfNGdiX21vZGUiLg0KDQpp
cyB0aGlzIE9LPw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiArDQo+ID4g
KwkJfQ0KPiA+ICsJCXJldCA9IHJlZ21hcF9yZWFkKGluZnJhY2ZnLCBSRUdfSU5GUkFfTUlTQywg
JnZhbCk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQlkYXRh
LT5lbmFibGVfNEdCID0gISEodmFsICYgRl9ERFJfNEdCX1NVUFBPUlRfRU4pOw0KPiA+ICsJfQ0K
PiA+ICAgDQo+ID4gICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VS
Q0VfTUVNLCAwKTsNCj4gPiAgIAlkYXRhLT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRl
diwgcmVzKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5m
cmFjZmcuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCj4gPiBpbmRl
eCBmZDI1ZjAxNDg1NjYuLjIzMzQ2M2Q3ODljNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvaW5mcmFjZmcuaA0KPiA+IEBAIC0zMiw2ICszMiw5IEBADQo+ID4gICAjZGVmaW5l
IE1UNzYyMl9UT1BfQVhJX1BST1RfRU5fV0IJCShCSVQoMikgfCBCSVQoNikgfCBcDQo+ID4gICAJ
CQkJCQkgQklUKDcpIHwgQklUKDgpKQ0KPiA+ICAgDQo+ID4gKyNkZWZpbmUgUkVHX0lORlJBX01J
U0MJCQkJMHhmMDANCj4gPiArI2RlZmluZSBGX0REUl80R0JfU1VQUE9SVF9FTgkJCUJJVCgxMykN
Cj4gPiArDQo+ID4gICBpbnQgbXRrX2luZnJhY2ZnX3NldF9idXNfcHJvdGVjdGlvbihzdHJ1Y3Qg
cmVnbWFwICppbmZyYWNmZywgdTMyIG1hc2ssDQo+ID4gICAJCWJvb2wgcmVnX3VwZGF0ZSk7DQo+
ID4gICBpbnQgbXRrX2luZnJhY2ZnX2NsZWFyX2J1c19wcm90ZWN0aW9uKHN0cnVjdCByZWdtYXAg
KmluZnJhY2ZnLCB1MzIgbWFzaywNCj4gPiANCg0K

