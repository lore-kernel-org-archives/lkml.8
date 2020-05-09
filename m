Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55DFC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFCA2495C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xp+IWSS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgEIIkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49373 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728007AbgEIIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:24 -0400
X-UUID: 3a659193b7cc4238a6993e8efbfb5df3-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rPAnzwaR6O/GGAIhKQLkHATI14Jacs04rANBVEp2mY0=;
        b=Xp+IWSS/nf5d5eLxm/0xWpJMa0TyoXi4zrnBnzhZb4qLZoPnF5UwoUgKsutoWmB6AT6cjg+E636O2uhwVKKfsLo2XPmhdWVLUAxRGiyzSnJ82R3FHKkC68GZY2chsJJRmfLo4q6mFM6oPR7q7XnfO1yAtMLKALlobpEd7GwUe/U=;
X-UUID: 3a659193b7cc4238a6993e8efbfb5df3-20200509
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1600407145; Sat, 09 May 2020 16:40:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:14 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:13 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>
Subject: [PATCH v3 5/7] iommu/mediatek: Add sub_comm id in translation fault
Date:   Sat, 9 May 2020 16:36:52 +0800
Message-ID: <20200509083654.5178-6-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200509083654.5178-1-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A3C151D800C9A29925EFA4791AFBA4D946A49C30C4A8135BEDDDE73D30FB8C6F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1heCBsYXJiIG51bWJlciB0aGF0IGEgaW9tbXUgSFcgc3VwcG9ydCBpcyA4KGxhcmIwfmxh
cmI3IGluIHRoZSBiZWxvdw0KZGlhZ3JhbSkuDQpJZiB0aGUgbGFyYidzIG51bWJlciBpcyBvdmVy
IDgsIHdlIHVzZSBhIHN1Yl9jb21tb24gZm9yIG1lcmdpbmcNCnNldmVyYWwgbGFyYnMgaW50byBv
bmUgbGFyYi4gQXQgdGhpcyBjYXNlLCB3ZSB3aWxsIGV4dGVuZCBsYXJiX2lkOg0KYml0WzExOjld
IG1lYW5zIGNvbW1vbi1pZDsNCmJpdFs4OjddIG1lYW5zIHN1YmNvbW1vbi1pZDsNCkZyb20gdGhl
c2UgdHdvIHZhcmlhYmxlLCB3ZSBjb3VsZCBnZXQgdGhlIHJlYWwgbGFyYiBudW1iZXIgd2hlbg0K
dHJhbnNsYXRpb24gZmF1bHQgaGFwcGVuLg0KVGhlIGRpYWdyYW0gaXMgYXMgYmVsb3c6DQoJCSBF
TUkNCgkJICB8DQoJCUlPTU1VDQoJCSAgfA0KICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLQ0K
CSAgIHwgICAgICAgICAgICAgICB8DQoJY29tbW9uMSAgIAljb21tb24wDQoJICAgfAkJICAgfA0K
CSAgIC0tLS0tLS0tLS0tLS0tLS0tDQoJCSAgfA0KICAgICAgICAgICAgIHNtaSBjb21tb24NCgkJ
ICB8DQogIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICB8ICAgICAgIHwg
ICAgICAgfCAgICAgICB8ICAgICB8ICAgIHwNCiAzJ2QwICAgIDMnZDEgICAgMydkMiAgICAzJ2Qz
ICAuLi4gIDMnZDcgICA8LWNvbW1vbl9pZChtYXggaXMgOCkNCiAgfCAgICAgICB8ICAgICAgIHwg
ICAgICAgfCAgICAgfCAgICB8DQpMYXJiMCAgIExhcmIxICAgICB8ICAgICBMYXJiMyAgLi4uIExh
cmI3DQoJCSAgfA0KCSAgICBzbWkgc3ViIGNvbW1vbg0KCQkgIHwNCiAgICAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCiAgICAgfCAgICAgICAgfCAgICAgICB8ICAgICAgIHwNCiAgICAyJ2Qw
ICAgICAyJ2QxICAgIDInZDIgICAgMidkMyAgIDwtc3ViX2NvbW1vbl9pZChtYXggaXMgNCkNCiAg
ICAgfCAgICAgICAgfCAgICAgICB8ICAgICAgIHwNCiAgIExhcmI4ICAgIExhcmI5ICAgTGFyYjEw
ICBMYXJiMTENCg0KSW4gdGhpcyBwYXRjaCB3ZSBleHRlcm4gbGFyYl9yZW1hcFtdIHRvIGxhcmJf
cmVtYXBbOF1bNF0gZm9yIHRoaXMuDQpsYXJiX3JlbWFwW3hdW3ldOiB4IG1lYW4gY29tbW9uLWlk
IGFib3ZlLCB5IG1lYW5zIHN1YmNvbW1vbl9pZCBhYm92ZS4NCg0KV2UgY2FuIGFsc28gZGlzdGlu
Z3Vpc2ggaWYgdGhlIE00VSBIVyBoYXMgc3ViX2NvbW1vbiBieSBoYXNfc3ViX2NvbW0NCnByb3Bl
cnR5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0K
LS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDIwICsrKysrKysrKysrKystLS0tLS0t
DQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAzICsrLQ0KIDIgZmlsZXMgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBkNzNk
ZTk4N2Y4YmUuLjM5MTRjNDE4ZDFiMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC05MCw2ICs5MCw4IEBA
DQogI2RlZmluZSBSRUdfTU1VMV9JTlZMRF9QQQkJCTB4MTQ4DQogI2RlZmluZSBSRUdfTU1VMF9J
TlRfSUQJCQkJMHgxNTANCiAjZGVmaW5lIFJFR19NTVUxX0lOVF9JRAkJCQkweDE1NA0KKyNkZWZp
bmUgRl9NTVVfSU5UX0lEX0NPTU1fSUQoYSkJCQkoKChhKSA+PiA5KSAmIDB4NykNCisjZGVmaW5l
IEZfTU1VX0lOVF9JRF9TVUJfQ09NTV9JRChhKQkJKCgoYSkgPj4gNykgJiAweDMpDQogI2RlZmlu
ZSBGX01NVV9JTlRfSURfTEFSQl9JRChhKQkJCSgoKGEpID4+IDcpICYgMHg3KQ0KICNkZWZpbmUg
Rl9NTVVfSU5UX0lEX1BPUlRfSUQoYSkJCQkoKChhKSA+PiAyKSAmIDB4MWYpDQogDQpAQCAtMjI4
LDcgKzIzMCw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGludCBpcnEsIHZv
aWQgKmRldl9pZCkNCiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2X2lkOw0KIAlz
dHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tID0gZGF0YS0+bTR1X2RvbTsNCiAJdTMyIGludF9z
dGF0ZSwgcmVndmFsLCBmYXVsdF9pb3ZhLCBmYXVsdF9wYTsNCi0JdW5zaWduZWQgaW50IGZhdWx0
X2xhcmIsIGZhdWx0X3BvcnQ7DQorCXVuc2lnbmVkIGludCBmYXVsdF9sYXJiLCBmYXVsdF9wb3J0
LCBzdWJfY29tbSA9IDA7DQogCWJvb2wgbGF5ZXIsIHdyaXRlOw0KIA0KIAkvKiBSZWFkIGVycm9y
IGluZm8gZnJvbSByZWdpc3RlcnMgKi8NCkBAIC0yNDQsMTAgKzI0NiwxNCBAQCBzdGF0aWMgaXJx
cmV0dXJuX3QgbXRrX2lvbW11X2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQogCX0NCiAJbGF5
ZXIgPSBmYXVsdF9pb3ZhICYgRl9NTVVfRkFVTFRfVkFfTEFZRVJfQklUOw0KIAl3cml0ZSA9IGZh
dWx0X2lvdmEgJiBGX01NVV9GQVVMVF9WQV9XUklURV9CSVQ7DQotCWZhdWx0X2xhcmIgPSBGX01N
VV9JTlRfSURfTEFSQl9JRChyZWd2YWwpOw0KIAlmYXVsdF9wb3J0ID0gRl9NTVVfSU5UX0lEX1BP
UlRfSUQocmVndmFsKTsNCi0NCi0JZmF1bHRfbGFyYiA9IGRhdGEtPnBsYXRfZGF0YS0+bGFyYmlk
X3JlbWFwW2ZhdWx0X2xhcmJdOw0KKwlpZiAoZGF0YS0+cGxhdF9kYXRhLT5oYXNfc3ViX2NvbW0p
IHsNCisJCWZhdWx0X2xhcmIgPSBGX01NVV9JTlRfSURfQ09NTV9JRChyZWd2YWwpOw0KKwkJc3Vi
X2NvbW0gPSBGX01NVV9JTlRfSURfU1VCX0NPTU1fSUQocmVndmFsKTsNCisJfSBlbHNlIHsNCisJ
CWZhdWx0X2xhcmIgPSBGX01NVV9JTlRfSURfTEFSQl9JRChyZWd2YWwpOw0KKwl9DQorCWZhdWx0
X2xhcmIgPSBkYXRhLT5wbGF0X2RhdGEtPmxhcmJpZF9yZW1hcFtmYXVsdF9sYXJiXVtzdWJfY29t
bV07DQogDQogCWlmIChyZXBvcnRfaW9tbXVfZmF1bHQoJmRvbS0+ZG9tYWluLCBkYXRhLT5kZXYs
IGZhdWx0X2lvdmEsDQogCQkJICAgICAgIHdyaXRlID8gSU9NTVVfRkFVTFRfV1JJVEUgOiBJT01N
VV9GQVVMVF9SRUFEKSkgew0KQEAgLTc4NSw3ICs3OTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19pb21tdV9wbGF0X2RhdGEgbXQyNzEyX2RhdGEgPSB7DQogCS5oYXNfYmNsayAgICAgPSB0
cnVlLA0KIAkuaGFzX3ZsZF9wYV9ybmcgICA9IHRydWUsDQogCS5pbnZfc2VsX3JlZyA9IFJFR19N
TVVfSU5WX1NFTF9HRU4xLA0KLQkubGFyYmlkX3JlbWFwID0gezAsIDEsIDIsIDMsIDQsIDUsIDYs
IDcsIDgsIDl9LA0KKwkubGFyYmlkX3JlbWFwID0ge3swfSwgezF9LCB7Mn0sIHszfSwgezR9LCB7
NX0sIHs2fSwgezd9fSwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3Bs
YXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCkBAIC03OTQsMTQgKzgwMCwxNCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQogCS5oYXNfYmNs
ayAgICAgPSB0cnVlLA0KIAkucmVzZXRfYXhpICAgID0gdHJ1ZSwNCiAJLmludl9zZWxfcmVnID0g
UkVHX01NVV9JTlZfU0VMX0dFTjEsDQotCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwg
NX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KKwkubGFyYmlkX3JlbWFwID0ge3swfSwgezF9LCB7
Mn0sIHszfSwgezR9LCB7NX19LCAvKiBMaW5lYXIgbWFwcGluZy4gKi8NCiB9Ow0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODNfZGF0YSA9IHsNCiAJLm00
dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQogCS5yZXNldF9heGkgICAgPSB0cnVlLA0KIAkuaW52
X3NlbF9yZWcgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwNCi0JLmxhcmJpZF9yZW1hcCA9IHswLCA0
LCA1LCA2LCA3LCAyLCAzLCAxfSwNCisJLmxhcmJpZF9yZW1hcCA9IHt7MH0sIHs0fSwgezV9LCB7
Nn0sIHs3fSwgezJ9LCB7M30sIHsxfX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBtdGtfaW9tbXVfb2ZfaWRzW10gPSB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IGFmZDdh
MmRlNWMxZS4uZDUxZmY5OWMyYzcxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuaA0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTQxLDEwICs0MSwxMSBA
QCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQogCS8qIEhXIHdpbGwgdXNlIHRoZSBFTUkg
Y2xvY2sgaWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xrIi4gKi8NCiAJYm9vbCAgICAgICAgICAgICAg
ICBoYXNfYmNsazsNCiAJYm9vbAkJICAgIGhhc19taXNjX2N0cmw7DQorCWJvb2wJCSAgICBoYXNf
c3ViX2NvbW07DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQogCWJvb2wg
ICAgICAgICAgICAgICAgcmVzZXRfYXhpOw0KIAl1MzIgICAgICAgICAgICAgICAgIGludl9zZWxf
cmVnOw0KLQl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhd
Ow0KKwl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFs4XVs0XTsNCiB9Ow0KIA0KIHN0
cnVjdCBtdGtfaW9tbXVfZG9tYWluOw0KLS0gDQoyLjE4LjANCg==

