Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A1FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D5420C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Am65U8ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbgFXGgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:36:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32558 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389161AbgFXGgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:36:52 -0400
X-UUID: aafbf51206634258a2df94bc1f5ba20b-20200624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dyrzMGwsnsiMhIacftJo7XUszB6l2wtiz1xwMW8R/c0=;
        b=Am65U8lnm61YapKhelbvFNf2q1U1T6Vwon0jPy5pKhqj47mzQWEyR3AsvvbAnKTJrOYw8BfpvHeyIHsZNE2ESjCc8gODTA0UC9fTXF4vqmq4PiEFYF18TSc7wkAVOEv7eFT2KaT5GwKnz3Ko0YSeJyKcXa1Ov03hSSMeRyr2CTE=;
X-UUID: aafbf51206634258a2df94bc1f5ba20b-20200624
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1189343506; Wed, 24 Jun 2020 14:36:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Jun 2020 14:36:41 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Jun 2020 14:36:41 +0800
Message-ID: <1592980561.24677.1.camel@mbjsdccf07>
Subject: Re: [PATCH v4 6/7] iommu/mediatek: Add REG_MMU_WR_LEN definition
 preparing for mt6779
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Wed, 24 Jun 2020 14:36:01 +0800
In-Reply-To: <e9a62fd8-ed8c-05d6-1eaa-49d5a471cd3a@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
         <20200617030029.4082-7-chao.hao@mediatek.com>
         <9e2c52d6-a887-1977-8877-fbcd30cb4261@gmail.com>
         <1592564184.5692.6.camel@mbjsdccf07>
         <e9a62fd8-ed8c-05d6-1eaa-49d5a471cd3a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA2LTIxIGF0IDEzOjAxICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTkvMDYvMjAyMCAxMjo1NiwgY2hhbyBoYW8gd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDIwLTA2LTE3IGF0IDExOjIyICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiA+
Pg0KPiA+PiBPbiAxNy8wNi8yMDIwIDA1OjAwLCBDaGFvIEhhbyB3cm90ZToNCj4gPj4+IFNvbWUg
cGxhdGZvcm1zKGV4OiBtdDY3NzkpIGhhdmUgYSBuZXcgcmVnaXN0ZXIgY2FsbGVkIGJ5IFJFR19N
TVVfV1JfTEVODQo+ID4+PiB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLg0KPiA+Pj4gVGhpcyBwYXRj
aCBhZGQgdGhpcyByZWdpc3RlciBkZWZpbml0aW9uLg0KPiA+Pg0KPiA+PiBQbGVhc2UgYmUgbW9y
ZSBzcGVjaWZpYyB3aGF0IHRoaXMgcmVnaXN0ZXIgaXMgYWJvdXQuDQo+ID4+DQo+ID4gT0suIHRo
YW5rcy4NCj4gPiBXZSBjYW4gdXNlICJoYXNfd3JfbGVuIiBmbGFnIHRvIGNvbnRyb2wgd2hldGhl
ciB3ZSBuZWVkIHRvIHNldCB0aGUNCj4gPiByZWdpc3Rlci4gSWYgdGhlIHJlZ2lzdGVyIHVzZXMg
ZGVmYXVsdCB2YWx1ZSwgaW9tbXUgd2lsbCBzZW5kIGNvbW1hbmQgdG8NCj4gPiBFTUkgd2l0aG91
dCByZXN0cmljdGlvbiwgd2hlbiB0aGUgbnVtYmVyIG9mIGNvbW1hbmRzIGJlY29tZSBtb3JlIGFu
ZA0KPiA+IG1vcmUsIGl0IHdpbGwgZHJvcCB0aGUgRU1JIHBlcmZvcm1hbmNlLiBTbyB3aGVuIG1v
cmUgdGhhbg0KPiA+IHRlbl9jb21tYW5kcyhkZWZhdWx0IHZhbHVlKSBkb24ndCBiZSBoYW5kbGVk
IGZvciBFTUksIElPTU1VIHdpbGwgc3RvcA0KPiA+IHNlbmQgY29tbWFuZCB0byBFTUkgZm9yIGtl
ZXBpbmcgRU1JJ3MgcGVyZm9ybWFjZSBieSBlbmFibGluZyB3cml0ZQ0KPiA+IHRocm90dGxpbmcg
bWVjaGFuaXNtKGJpdFs1XVsyMV09MCkgaW4gTU1VX1dSX0xFTl9DVFJMIHJlZ2lzdGVyLg0KPiA+
IA0KPiA+IEkgd2lsbCB3cml0ZSBkZXNjcmlwdGlvbiBhYm92ZSB0byBjb21taXQgbWVzc2FnZSBp
biBuZXh0IHZlcnNpb24NCj4gPiANCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEhh
byA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyB8IDEwICsrKysrKysrKysNCj4gPj4+ICBkcml2ZXJzL2lvbW11L210a19p
b21tdS5oIHwgIDIgKysNCj4gPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykN
Cj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPj4+IGluZGV4IGE2ODdlOGRiMGU1MS4uYzcwNmJj
YTY0ODdlIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+
Pj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+Pj4gQEAgLTQ2LDYgKzQ2LDgg
QEANCj4gPj4+ICAjZGVmaW5lIEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RFX0JJVAkJKEJJVCgzKSB8
IEJJVCgxOSkpDQo+ID4+PiAgDQo+ID4+PiAgI2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgw
NTANCj4gPj4+ICsjZGVmaW5lIFJFR19NTVVfV1JfTEVOCQkJCTB4MDU0DQo+ID4+PiArI2RlZmlu
ZSBGX01NVV9XUl9USFJPVF9ESVNfQklUCQkJKEJJVCg1KSB8ICBCSVQoMjEpKQ0KPiA+Pj4gIA0K
PiA+Pj4gICNkZWZpbmUgUkVHX01NVV9DVFJMX1JFRwkJCTB4MTEwDQo+ID4+PiAgI2RlZmluZSBG
X01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUgkJKDIgPDwgNCkNCj4gPj4+IEBAIC01ODEsNiAr
NTgzLDEyIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19p
b21tdV9kYXRhICpkYXRhKQ0KPiA+Pj4gIAkJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5i
YXNlICsgUkVHX01NVV9WTERfUEFfUk5HKTsNCj4gPj4+ICAJfQ0KPiA+Pj4gIAl3cml0ZWxfcmVs
YXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4gPj4+ICsJaWYgKGRhdGEt
PnBsYXRfZGF0YS0+aGFzX3dyX2xlbikgew0KPiA+Pj4gKwkJLyogd3JpdGUgY29tbWFuZCB0aHJv
dHRsaW5nIG1vZGUgKi8NCj4gPj4+ICsJCXJlZ3ZhbCA9IHJlYWRsX3JlbGF4ZWQoZGF0YS0+YmFz
ZSArIFJFR19NTVVfV1JfTEVOKTsNCj4gPj4+ICsJCXJlZ3ZhbCAmPSB+Rl9NTVVfV1JfVEhST1Rf
RElTX0JJVDsNCj4gPj4+ICsJCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJF
R19NTVVfV1JfTEVOKTsNCj4gPj4+ICsJfQ0KPiA+Pj4gIA0KPiA+Pj4gIAlpZiAoZGF0YS0+cGxh
dF9kYXRhLT5yZXNldF9heGkpIHsNCj4gPj4+ICAJCS8qIFRoZSByZWdpc3RlciBpcyBjYWxsZWQg
U1RBTkRBUkRfQVhJX01PREUgaW4gdGhpcyBjYXNlICovDQo+ID4+PiBAQCAtNzM3LDYgKzc0NSw3
IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiA+Pj4gIAlzdHJ1Y3QgbXRrX2lvbW11X3N1c3BlbmRfcmVnICpyZWcgPSAm
ZGF0YS0+cmVnOw0KPiA+Pj4gIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBkYXRhLT5iYXNlOw0KPiA+
Pj4gIA0KPiA+Pj4gKwlyZWctPndyX2xlbiA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJFR19NTVVf
V1JfTEVOKTsNCj4gPj4NCj4gPj4gQ2FuIHdlIHJlYWQvd3JpdGUgdGhlIHJlZ2lzdGVyIHdpdGhv
dXQgYW55IHNpZGUgZWZmZWN0IGFsdGhvdWdoIGhhcmR3YXJlIGhhcyBub3QNCj4gPj4gaW1wbGVt
ZW50ZWQgaXQgKCFoYXNfd3JfbGVuKT8NCj4gPiANCj4gPiBJdCBkb2Vzbid0IGhhdmUgc2lkZSBl
ZmZlY3QuIEJlY2FzdWUgYWxsIHRoZSBNVEsgcGxhdGZvcm0gaGF2ZSB0aGUNCj4gPiByZWdpc3Rl
ciBmb3IgaW9tbXUgSFcuIElmIHdlIG5lZWQgdG8gaGF2ZSByZXF1aXJlbWVudCBmb3IgcGVyZm9y
bWFuY2UsDQo+ID4gd2UgY2FuIHNldCBpdCBieSBoYXNfd3JfbGVuLg0KPiA+IEJ1dCBJJ20gU29y
cnksIHRoZSBuYW1lIG9mIGZsYWcoaGFzX3dyX2xlbikgaXMgbm90IGV4YWN0LCBJIHdpbGwgcmVu
YW1lDQo+ID4gaXQgaW4gbmV4dCB2ZXJzaW9uLCBleDogIndyX3Rocm90X2VuIg0KPiA+IA0KPiA+
Pg0KPiA+Pg0KPiA+Pj4gIAlyZWctPm1pc2NfY3RybCA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJF
R19NTVVfTUlTQ19DVFJMKTsNCj4gPj4+ICAJcmVnLT5kY21fZGlzID0gcmVhZGxfcmVsYXhlZChi
YXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4gPj4+ICAJcmVnLT5jdHJsX3JlZyA9IHJlYWRsX3Jl
bGF4ZWQoYmFzZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KPiA+Pj4gQEAgLTc2MSw2ICs3NzAsNyBA
QCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiA+Pj4gIAkJZGV2X2VycihkYXRhLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGNs
ayglZCkgaW4gcmVzdW1lXG4iLCByZXQpOw0KPiA+Pj4gIAkJcmV0dXJuIHJldDsNCj4gPj4+ICAJ
fQ0KPiA+Pj4gKwl3cml0ZWxfcmVsYXhlZChyZWctPndyX2xlbiwgYmFzZSArIFJFR19NTVVfV1Jf
TEVOKTsNCj4gPj4+ICAJd3JpdGVsX3JlbGF4ZWQocmVnLT5taXNjX2N0cmwsIGJhc2UgKyBSRUdf
TU1VX01JU0NfQ1RSTCk7DQo+ID4+PiAgCXdyaXRlbF9yZWxheGVkKHJlZy0+ZGNtX2RpcywgYmFz
ZSArIFJFR19NTVVfRENNX0RJUyk7DQo+ID4+PiAgCXdyaXRlbF9yZWxheGVkKHJlZy0+Y3RybF9y
ZWcsIGJhc2UgKyBSRUdfTU1VX0NUUkxfUkVHKTsNCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+Pj4gaW5k
ZXggZDUxZmY5OWMyYzcxLi45OTcxY2VkZDcyZWEgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oDQo+ID4+PiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5o
DQo+ID4+PiBAQCAtMjUsNiArMjUsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3N1c3BlbmRfcmVnIHsN
Cj4gPj4+ICAJdTMyCQkJCWludF9tYWluX2NvbnRyb2w7DQo+ID4+PiAgCXUzMgkJCQlpdnJwX3Bh
ZGRyOw0KPiA+Pj4gIAl1MzIJCQkJdmxkX3BhX3JuZzsNCj4gPj4+ICsJdTMyCQkJCXdyX2xlbjsN
Cj4gPj4+ICB9Ow0KPiA+Pj4gIA0KPiA+Pj4gIGVudW0gbXRrX2lvbW11X3BsYXQgew0KPiA+Pj4g
QEAgLTQzLDYgKzQ0LDcgQEAgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgew0KPiA+Pj4gIAli
b29sCQkgICAgaGFzX21pc2NfY3RybDsNCj4gPj4+ICAJYm9vbAkJICAgIGhhc19zdWJfY29tbTsN
Cj4gPj4+ICAJYm9vbCAgICAgICAgICAgICAgICBoYXNfdmxkX3BhX3JuZzsNCj4gPj4+ICsJYm9v
bCAgICAgICAgICAgICAgICBoYXNfd3JfbGVuOw0KPiA+Pg0KPiA+PiBHaXZlbiB0aGUgZmFjdCB0
aGF0IHdlIGFyZSBhZGRpbmcgbW9yZSBhbmQgbW9yZSBwbGF0X2RhdGEgYm9vbCB2YWx1ZXMsIEkg
dGhpbmsNCj4gPj4gaXQgd291bGQgbWFrZSBzZW5zZSB0byB1c2UgYSB1MzIgZmxhZ3MgcmVnaXN0
ZXIgYW5kIGFkZCB0aGUgYXBwcm9wcmlhdGUgbWFjcm8NCj4gPj4gZGVmaW5pdGlvbnMgdG8gc2V0
IGFuZCBjaGVjayBmb3IgYSBmbGFnIHByZXNlbnQuDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3Vy
IGFkdmljZS4NCj4gPiBkbyB5b3UgbWVhbiBsaWtlIHRoaXM6DQo+ID4gc3RydWN0IHBsYXRfZmxh
ZyB7DQo+ID4gDQo+ID4gICAgICAgICAjZGVmaW5lICBIQVNfNEdCX01PREUgICBCSVQoMCkNCj4g
PiAgICAgICAgICNkZWZpbmUgIEhBU19CQ0xLICAgICAgIEJJVCgxKQ0KPiA+ICAgICAgICAgI2Rl
ZmluZSAgUkVTVF9BWEkgICAgICAgQklUKDIpDQo+ID4gICAgICAgICAuLi4gLi4uDQo+ID4gDQo+
ID4gICAgICAgICB1MzIgZmxhZzsNCj4gPiB9Ow0KPiA+IA0KPiA+IHN0cnVjdCBtdGtfaW9tbXVf
cGxhdF9kYXRhIHsNCj4gPiAgICAgICAgIC4uLi4uLg0KPiA+ICAgICAgICAgc3RydWN0IHBsYXRf
ZmxhZyBmbGFnOw0KPiA+ICAgICAgICAgLi4uLi4uDQo+ID4gfTsNCj4gPiANCj4gDQo+IE5lYXJs
eSwgSSBtZWFuIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiAjZGVmaW5lICBIQVNfNEdCX01P
REUgICBCSVQoMCkNCj4gI2RlZmluZSAgSEFTX0JDTEsgICAgICAgQklUKDEpDQo+ICNkZWZpbmUg
IFJFU1RfQVhJICAgICAgIEJJVCgyKQ0KPiANCj4gI2RlZmluZSBNVEtfSU9NTVVfSEFTX0ZMQUco
cGRhdGEsIF94KQlcDQo+IAkJKCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkgPT0gKF94KSkNCj4g
DQo+IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCj4gCS4uLg0KPiAJdTMyIGZsYWdzOw0K
PiAJLi4uDQo+IH0NCj4gDQo+IGlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRh
LCBIQVNfQkNMSykNCj4gLi4uDQo+IA0KDQpPaywgZ290IGl0LCB0aGFua3MNCg0KDQo+IFJlZ2Fy
ZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+IA0KPiA+PiBSZWdhcmRzLA0KPiA+PiBNYXR0aGlhcw0K
PiA+Pg0KPiA+Pj4gIAlib29sICAgICAgICAgICAgICAgIHJlc2V0X2F4aTsNCj4gPj4+ICAJdTMy
ICAgICAgICAgICAgICAgICBpbnZfc2VsX3JlZzsNCj4gPj4+ICAJdW5zaWduZWQgY2hhciAgICAg
ICBsYXJiaWRfcmVtYXBbOF1bNF07DQo+ID4+Pg0KPiA+IA0KDQo=

