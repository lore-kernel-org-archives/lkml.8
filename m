Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C5A2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cmylI8IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFQDB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:01:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4811 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726720AbgFQDBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:01:15 -0400
X-UUID: e5c5e6dc3df24fdd8171ae3f73ba7612-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tI5yYu408gV43UkHvfzp5IIwTJR94Q+9kyhZO32jWGI=;
        b=cmylI8IZ+h6V+Q/CkqxqqtJ9jBXeB0LxMxJ7nXCCTckWgEF6Imla0p/lL8A0jeZjNL2DeVP9TUFQInhUaN/S7ZwxHwVFPFCcf/Y4x+28+r90w5piJV1M6ntc2U7dUUZy1F+fcFrhkYlU+nKIAQIP8XqSLMjUDwHr10A5aI2pI9s=;
X-UUID: e5c5e6dc3df24fdd8171ae3f73ba7612-20200617
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1378228981; Wed, 17 Jun 2020 11:01:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:01:09 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:01:02 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v4 5/7] iommu/mediatek: Add sub_comm id in translation fault
Date:   Wed, 17 Jun 2020 11:00:27 +0800
Message-ID: <20200617030029.4082-6-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200617030029.4082-1-chao.hao@mediatek.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
UmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyB8IDIwICsrKysrKysrKysrKystLS0tLS0tDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaCB8ICAzICsrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBmMjM5MTlmZWJhNGUuLmE2
ODdlOGRiMGU1MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC05MSw2ICs5MSw4IEBADQogI2RlZmluZSBS
RUdfTU1VMV9JTlZMRF9QQQkJCTB4MTQ4DQogI2RlZmluZSBSRUdfTU1VMF9JTlRfSUQJCQkJMHgx
NTANCiAjZGVmaW5lIFJFR19NTVUxX0lOVF9JRAkJCQkweDE1NA0KKyNkZWZpbmUgRl9NTVVfSU5U
X0lEX0NPTU1fSUQoYSkJCQkoKChhKSA+PiA5KSAmIDB4NykNCisjZGVmaW5lIEZfTU1VX0lOVF9J
RF9TVUJfQ09NTV9JRChhKQkJKCgoYSkgPj4gNykgJiAweDMpDQogI2RlZmluZSBGX01NVV9JTlRf
SURfTEFSQl9JRChhKQkJCSgoKGEpID4+IDcpICYgMHg3KQ0KICNkZWZpbmUgRl9NTVVfSU5UX0lE
X1BPUlRfSUQoYSkJCQkoKChhKSA+PiAyKSAmIDB4MWYpDQogDQpAQCAtMjI5LDcgKzIzMSw3IEBA
IHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkN
CiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2X2lkOw0KIAlzdHJ1Y3QgbXRrX2lv
bW11X2RvbWFpbiAqZG9tID0gZGF0YS0+bTR1X2RvbTsNCiAJdTMyIGludF9zdGF0ZSwgcmVndmFs
LCBmYXVsdF9pb3ZhLCBmYXVsdF9wYTsNCi0JdW5zaWduZWQgaW50IGZhdWx0X2xhcmIsIGZhdWx0
X3BvcnQ7DQorCXVuc2lnbmVkIGludCBmYXVsdF9sYXJiLCBmYXVsdF9wb3J0LCBzdWJfY29tbSA9
IDA7DQogCWJvb2wgbGF5ZXIsIHdyaXRlOw0KIA0KIAkvKiBSZWFkIGVycm9yIGluZm8gZnJvbSBy
ZWdpc3RlcnMgKi8NCkBAIC0yNDUsMTAgKzI0NywxNCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRr
X2lvbW11X2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQogCX0NCiAJbGF5ZXIgPSBmYXVsdF9p
b3ZhICYgRl9NTVVfRkFVTFRfVkFfTEFZRVJfQklUOw0KIAl3cml0ZSA9IGZhdWx0X2lvdmEgJiBG
X01NVV9GQVVMVF9WQV9XUklURV9CSVQ7DQotCWZhdWx0X2xhcmIgPSBGX01NVV9JTlRfSURfTEFS
Ql9JRChyZWd2YWwpOw0KIAlmYXVsdF9wb3J0ID0gRl9NTVVfSU5UX0lEX1BPUlRfSUQocmVndmFs
KTsNCi0NCi0JZmF1bHRfbGFyYiA9IGRhdGEtPnBsYXRfZGF0YS0+bGFyYmlkX3JlbWFwW2ZhdWx0
X2xhcmJdOw0KKwlpZiAoZGF0YS0+cGxhdF9kYXRhLT5oYXNfc3ViX2NvbW0pIHsNCisJCWZhdWx0
X2xhcmIgPSBGX01NVV9JTlRfSURfQ09NTV9JRChyZWd2YWwpOw0KKwkJc3ViX2NvbW0gPSBGX01N
VV9JTlRfSURfU1VCX0NPTU1fSUQocmVndmFsKTsNCisJfSBlbHNlIHsNCisJCWZhdWx0X2xhcmIg
PSBGX01NVV9JTlRfSURfTEFSQl9JRChyZWd2YWwpOw0KKwl9DQorCWZhdWx0X2xhcmIgPSBkYXRh
LT5wbGF0X2RhdGEtPmxhcmJpZF9yZW1hcFtmYXVsdF9sYXJiXVtzdWJfY29tbV07DQogDQogCWlm
IChyZXBvcnRfaW9tbXVfZmF1bHQoJmRvbS0+ZG9tYWluLCBkYXRhLT5kZXYsIGZhdWx0X2lvdmEs
DQogCQkJICAgICAgIHdyaXRlID8gSU9NTVVfRkFVTFRfV1JJVEUgOiBJT01NVV9GQVVMVF9SRUFE
KSkgew0KQEAgLTc3OCw3ICs3ODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9w
bGF0X2RhdGEgbXQyNzEyX2RhdGEgPSB7DQogCS5oYXNfYmNsayAgICAgICA9IHRydWUsDQogCS5o
YXNfdmxkX3BhX3JuZyA9IHRydWUsDQogCS5pbnZfc2VsX3JlZyAgICA9IFJFR19NTVVfSU5WX1NF
TF9HRU4xLA0KLQkubGFyYmlkX3JlbWFwICAgPSB7MCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwg
OX0sDQorCS5sYXJiaWRfcmVtYXAgICA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs0fSwgezV9LCB7
Nn0sIHs3fX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2Rh
dGEgbXQ4MTczX2RhdGEgPSB7DQpAQCAtNzg3LDE0ICs3OTMsMTQgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KIAkuaGFzX2JjbGsgICAg
ID0gdHJ1ZSwNCiAJLnJlc2V0X2F4aSAgICA9IHRydWUsDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdf
TU1VX0lOVl9TRUxfR0VOMSwNCi0JLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1fSwg
LyogTGluZWFyIG1hcHBpbmcuICovDQorCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7MX0sIHsyfSwg
ezN9LCB7NH0sIHs1fX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KIH07DQogDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0gew0KIAkubTR1X3Bs
YXQgICAgID0gTTRVX01UODE4MywNCiAJLnJlc2V0X2F4aSAgICA9IHRydWUsDQogCS5pbnZfc2Vs
X3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwNCi0JLmxhcmJpZF9yZW1hcCA9IHswLCA0LCA1
LCA2LCA3LCAyLCAzLCAxfSwNCisJLmxhcmJpZF9yZW1hcCA9IHt7MH0sIHs0fSwgezV9LCB7Nn0s
IHs3fSwgezJ9LCB7M30sIHsxfX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBtdGtfaW9tbXVfb2ZfaWRzW10gPSB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IGFmZDdhMmRl
NWMxZS4uZDUxZmY5OWMyYzcxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
aA0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTQxLDEwICs0MSwxMSBAQCBz
dHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQogCS8qIEhXIHdpbGwgdXNlIHRoZSBFTUkgY2xv
Y2sgaWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xrIi4gKi8NCiAJYm9vbCAgICAgICAgICAgICAgICBo
YXNfYmNsazsNCiAJYm9vbAkJICAgIGhhc19taXNjX2N0cmw7DQorCWJvb2wJCSAgICBoYXNfc3Vi
X2NvbW07DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQogCWJvb2wgICAg
ICAgICAgICAgICAgcmVzZXRfYXhpOw0KIAl1MzIgICAgICAgICAgICAgICAgIGludl9zZWxfcmVn
Ow0KLQl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0K
Kwl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFs4XVs0XTsNCiB9Ow0KIA0KIHN0cnVj
dCBtdGtfaW9tbXVfZG9tYWluOw0KLS0gDQoyLjE4LjANCg==

