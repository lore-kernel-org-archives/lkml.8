Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4CBC2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7574B20786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XzUasTQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgC3Cf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:35:27 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:38600 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728687AbgC3Cf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:35:27 -0400
X-UUID: b6e59cec30534194be135c614879536a-20200330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fDyV786cq6YSeUNY8H+6Pi/uU5KR8v5kIaA8/PRFvFQ=;
        b=XzUasTQvxTtMj0elugmkj1IG9aCSNv1sY5DEnco9TK1eGm4PUduZ751NrCBTh0b0k9on09SfXxewd3I9dRfFsO+WkvOCwVWjXASc7Q09YAahyBZIz0cHwPagY+jJSOWJnjFPmCutDSbw8Dkm7U+tl0ObblP9X6jEMno8EVY56u4=;
X-UUID: b6e59cec30534194be135c614879536a-20200330
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 319311301; Mon, 30 Mar 2020 10:35:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 30 Mar
 2020 10:35:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Mar 2020 10:35:15 +0800
Message-ID: <1585535724.28859.18.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/4] usb: xhci: xhci-plat: Add support for Broadcom
 STB SoC's
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Al Cooper <alcooperx@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-usb@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Mar 2020 10:35:24 +0800
In-Reply-To: <20200327204711.10614-3-alcooperx@gmail.com>
References: <20200327204711.10614-1-alcooperx@gmail.com>
         <20200327204711.10614-3-alcooperx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 47B6B53D0CD1B42A1DEB937425994BFCC1374EBB0DC4205D91873D64D7EDBD012000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiBGcmksIDIwMjAtMDMtMjcgYXQgMTY6NDcgLTA0MDAsIEFsIENvb3BlciB3cm90ZToN
Cj4gQWRkIHN1cHBvcnQgZm9yIEJyb2FkY29tIFNUQiBTb0MncyB0byB0aGUgeGhjaSBwbGF0Zm9y
bSBkcml2ZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsIENvb3BlciA8YWxjb29wZXJ4QGdtYWls
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktYnJjbS5jIHwgMTYgKysrKysr
KysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLWJyY20uaCB8IDE2ICsrKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0LmMgfCAxMSArKysrKysrKysr
Kw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy91c2IvaG9zdC94aGNpLWJyY20uYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1icmNtLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9ob3N0L3hoY2ktYnJjbS5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLWJyY20uYw0KPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmJmOGMwYmZkMTc4MA0K
PiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1icmNtLmMNCj4g
QEAgLTAsMCArMSwxNiBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gKy8qIENvcHlyaWdodCAoYykgMjAxOCwgQnJvYWRjb20gKi8NCj4gKw0KPiArI2luY2x1ZGUg
PGxpbnV4L3VzYi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3VzYi9oY2QuaD4NCj4gKw0KPiArI2lu
Y2x1ZGUgInhoY2kuaCINCj4gKw0KPiAraW50IHhoY2lfcGxhdF9icmNtX2luaXRfcXVpcmsoc3Ry
dWN0IHVzYl9oY2QgKmhjZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgeGhjaV9oY2QJKnhoY2kgPSBoY2Rf
dG9feGhjaShoY2QpOw0KPiArDQo+ICsJeGhjaS0+cXVpcmtzIHw9IFhIQ0lfUkVTRVRfT05fUkVT
VU1FOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2ktYnJjbS5oIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLWJyY20uaA0KPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU2NDgwMGZhZTRkNQ0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1icmNtLmgNCj4gQEAg
LTAsMCArMSwxNiBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8N
Cj4gKy8qIENvcHlyaWdodCAoYykgMjAxOCwgQnJvYWRjb20gKi8NCj4gKw0KPiArI2lmbmRlZiBf
WEhDSV9CUkNNX0gNCj4gKyNkZWZpbmUgX1hIQ0lfQlJDTV9IDQo+ICsNCj4gKyNpZiBJU19FTkFC
TEVEKENPTkZJR19VU0JfWEhDSV9CUkNNKQ0KPiAraW50IHhoY2lfcGxhdF9icmNtX2luaXRfcXVp
cmsoc3RydWN0IHVzYl9oY2QgKmhjZCk7DQo+ICsjZWxzZQ0KPiArc3RhdGljIGlubGluZSBpbnQg
eGhjaV9wbGF0X2JyY21faW5pdF9xdWlyayhzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0KPiArew0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiArI2VuZGlmDQo+ICsjZW5kaWYgLyogX1hIQ0lfQlJDTV9IICov
DQo+ICsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0LmMgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5jDQo+IGluZGV4IDMxNWI0NTUyNjkzYy4uM2U5MGExMjA3
ODAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0LmMNCj4gQEAgLTIyLDYgKzIyLDcgQEANCj4gIA0K
PiAgI2luY2x1ZGUgInhoY2kuaCINCj4gICNpbmNsdWRlICJ4aGNpLXBsYXQuaCINCj4gKyNpbmNs
dWRlICJ4aGNpLWJyY20uaCINCj4gICNpbmNsdWRlICJ4aGNpLW12ZWJ1LmgiDQo+ICAjaW5jbHVk
ZSAieGhjaS1yY2FyLmgiDQo+ICANCj4gQEAgLTExMiw2ICsxMTMsMTAgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB4aGNpX3BsYXRfcHJpdiB4aGNpX3BsYXRfcmVuZXNhc19yY2FyX2dlbjMgPSB7DQo+
ICAJU0VUX1hIQ0lfUExBVF9QUklWX0ZPUl9SQ0FSKFhIQ0lfUkNBUl9GSVJNV0FSRV9OQU1FX1Yz
KQ0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCB4aGNpX3BsYXRfcHJpdiB4aGNp
X3BsYXRfYnJjbSA9IHsNCj4gKwkuaW5pdF9xdWlyayA9IHhoY2lfcGxhdF9icmNtX2luaXRfcXVp
cmssDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB1c2Jf
eGhjaV9vZl9tYXRjaFtdID0gew0KPiAgCXsNCj4gIAkJLmNvbXBhdGlibGUgPSAiZ2VuZXJpYy14
aGNpIiwNCj4gQEAgLTE0Nyw2ICsxNTIsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgdXNiX3hoY2lfb2ZfbWF0Y2hbXSA9IHsNCj4gIAl9LCB7DQo+ICAJCS5jb21wYXRpYmxl
ID0gInJlbmVzYXMscmNhci1nZW4zLXhoY2kiLA0KPiAgCQkuZGF0YSA9ICZ4aGNpX3BsYXRfcmVu
ZXNhc19yY2FyX2dlbjMsDQo+ICsJfSwgew0KPiArCQkuY29tcGF0aWJsZSA9ICJicmNtLHhoY2kt
YnJjbS12MiIsDQo+ICsJCS5kYXRhID0gJnhoY2lfcGxhdF9icmNtLA0KVGhpcyBvbmUgaXMgbm90
IGRlc2NyaWJlZCBpbiBkdC1iaW5kaW5nLg0KPiArCX0sIHsNCj4gKwkJLmNvbXBhdGlibGUgPSAi
YnJjbSxiY203NDQ1LXhoY2kiLA0KPiArCQkuZGF0YSA9ICZ4aGNpX3BsYXRfYnJjbSwNCmJjbTc0
NDUgaXMgYSBTb0MgbmFtZSA/IA0KdGhlIHF1aXJrIG9ubHkgaGFwcGVucyBvbiB0aGlzIG9uZT8g
b3Igb24gYWxsIFNvQ3Mgd2l0aCBCcm9hZGNvbSB4SElDDQpJUD8NCg0KPiAgCX0sDQo+ICAJe30s
DQo+ICB9Ow0KDQo=

