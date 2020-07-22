Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C98720709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t8MdMqMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgGVOTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:19:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61334 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgGVOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:19:33 -0400
X-UUID: bf6ea4f9f55e4573aecfd81459315b05-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GVJnyqG5qtAiG4ewbpOZ6PTRkaO5mAaqoonpe2maeS0=;
        b=t8MdMqMHCFhobvALTO9P3crQSzsBrFgmKaI9XrslUnc9oZKutld7zPqYAJigJ88f0dgcAMdVSuoM0hUQlH+zj8D3fGyLtn3jIuycITTzv43P00d9By0I42AkYD55dP7oY4JGI44t6ITPQo0WH3yY1xm2AvJsmqDloTlMnT148Jc=;
X-UUID: bf6ea4f9f55e4573aecfd81459315b05-20200722
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1636749737; Wed, 22 Jul 2020 22:19:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 22:19:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 22:19:25 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3] iommu/mediatek: check 4GB mode by reading infracfg
Date:   Wed, 22 Jul 2020 22:19:25 +0800
Message-ID: <20200722141925.14861-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3FDBDF1D74D313BDD0B5091DC2AD0F9931F251897C4EB80046840637F0DE86352000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gcHJldmlvdXMgZGlzY3Vzc2lvbiBbMV0gYW5kIFsyXSwgd2UgZm91bmQgdGhhdCBpdCBpcyBy
aXNreSB0bw0KdXNlIG1heF9wZm4gb3IgdG90YWxyYW1fcGFnZXMgdG8gdGVsbCBpZiA0R0IgbW9k
ZSBpcyBlbmFibGVkLg0KDQpDaGVjayA0R0IgbW9kZSBieSByZWFkaW5nIGluZnJhY2ZnIHJlZ2lz
dGVyLCByZW1vdmUgdGhlIHVzYWdlDQpvZiB0aGUgdW4tZXhwb3J0ZWQgc3ltYm9sIG1heF9wZm4u
DQoNClRoaXMgaXMgYSBzdGVwIHRvd2FyZHMgYnVpbGRpbmcgbXRrX2lvbW11IGFzIGEga2VybmVs
IG1vZHVsZS4NCg0KLS0tDQoNCkNoYW5nZSBzaW5jZSB2MjoNCi0gZGV0ZXJtaW5lIGNvbXBhdGli
bGUgc3RyaW5nIGJ5IG00dV9wbGF0DQotIHJlYmFzZSB0byBuZXh0LTIwMjAwNzIwDQotIGFkZCAi
LS0tIg0KDQpDaGFuZ2Ugc2luY2UgdjE6DQotIHJlbW92ZSB0aGUgcGhhbmRsZSB1c2FnZSwgc2Vh
cmNoIGZvciBpbmZyYWNmZyBpbnN0ZWFkIFszXQ0KLSB1c2UgaW5mcmFjZmcgaW5zdGVhZCBvZiBp
bmZyYWNmZ19yZWdtYXANCi0gbW92ZSBpbmZyYWNmZyBkZWZpbml0YWlvbnMgdG8gbGludXgvc29j
L21lZGlhdGVrL2luZnJhY2ZnLmgNCi0gdXBkYXRlIGVuYWJsZV80R0Igb25seSB3aGVuIGhhc180
Z2JfbW9kZQ0KDQpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNi8zLzczMw0KWzJdIGh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzYvNC8xMzYNClszXSBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAyMC83LzE1LzExNDcNCg0KQ2M6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNv
bT4NCkNjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCkNjOiBZaW5nam9lIENoZW4gPHlpbmdqb2UuY2hlbkBt
ZWRpYXRlay5jb20+DQpDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQpDYzogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCkNjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlh
cy5iZ2dAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jICAgICAgICAgICAg
IHwgMzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvaW5mcmFjZmcuaCB8ICAzICsrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCA1OWU1YTYyYTM0ZGIuLjll
YzY2NjE2ODgyMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zLDcgKzMsNiBAQA0KICAqIENvcHlyaWdo
dCAoYykgMjAxNS0yMDE2IE1lZGlhVGVrIEluYy4NCiAgKiBBdXRob3I6IFlvbmcgV3UgPHlvbmcu
d3VAbWVkaWF0ZWsuY29tPg0KICAqLw0KLSNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KICNp
bmNsdWRlIDxsaW51eC9idWcuaD4NCiAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQogI2luY2x1ZGUg
PGxpbnV4L2NvbXBvbmVudC5oPg0KQEAgLTE1LDEzICsxNCwxNiBAQA0KICNpbmNsdWRlIDxsaW51
eC9pb21tdS5oPg0KICNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgv
bGlzdC5oPg0KKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQogI2luY2x1ZGUgPGxpbnV4
L29mX2FkZHJlc3MuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfaW9tbXUuaD4NCiAjaW5jbHVkZSA8
bGludXgvb2ZfaXJxLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQogI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4N
CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0K
KyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaD4NCiAjaW5jbHVkZSA8YXNt
L2JhcnJpZXIuaD4NCiAjaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KIA0KQEAgLTY0MCw4
ICs2NDIsMTEgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiAJc3RydWN0IHJlc291cmNlICAgICAgICAgKnJlczsNCiAJcmVzb3VyY2Vf
c2l6ZV90CQlpb2FkZHI7DQogCXN0cnVjdCBjb21wb25lbnRfbWF0Y2ggICptYXRjaCA9IE5VTEw7
DQorCXN0cnVjdCByZWdtYXAJCSppbmZyYWNmZzsNCiAJdm9pZCAgICAgICAgICAgICAgICAgICAg
KnByb3RlY3Q7DQogCWludCAgICAgICAgICAgICAgICAgICAgIGksIGxhcmJfbnIsIHJldDsNCisJ
dTMyCQkJdmFsOw0KKwljaGFyICAgICAgICAgICAgICAgICAgICAqcDsNCiANCiAJZGF0YSA9IGRl
dm1fa3phbGxvYyhkZXYsIHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0KIAlpZiAoIWRhdGEp
DQpAQCAtNjU1LDEwICs2NjAsMjkgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCXJldHVybiAtRU5PTUVNOw0KIAlkYXRhLT5wcm90
ZWN0X2Jhc2UgPSBBTElHTih2aXJ0X3RvX3BoeXMocHJvdGVjdCksIE1US19QUk9URUNUX1BBX0FM
SUdOKTsNCiANCi0JLyogV2hldGhlciB0aGUgY3VycmVudCBkcmFtIGlzIG92ZXIgNEdCICovDQot
CWRhdGEtPmVuYWJsZV80R0IgPSAhIShtYXhfcGZuID4gKEJJVF9VTEwoMzIpID4+IFBBR0VfU0hJ
RlQpKTsNCi0JaWYgKCFNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNfNEdC
X01PREUpKQ0KLQkJZGF0YS0+ZW5hYmxlXzRHQiA9IGZhbHNlOw0KKwlkYXRhLT5lbmFibGVfNEdC
ID0gZmFsc2U7DQorCWlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNf
NEdCX01PREUpKSB7DQorCQlzd2l0Y2ggKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQpIHsNCisJ
CWNhc2UgTTRVX01UMjcxMjoNCisJCQlwID0gIm1lZGlhdGVrLG10MjcxMi1pbmZyYWNmZyI7DQor
CQkJYnJlYWs7DQorCQljYXNlIE00VV9NVDgxNzM6DQorCQkJcCA9ICJtZWRpYXRlayxtdDgxNzMt
aW5mcmFjZmciOw0KKwkJCWJyZWFrOw0KKwkJZGVmYXVsdDoNCisJCQlwID0gTlVMTDsNCisJCX0N
CisNCisJCWluZnJhY2ZnID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZShwKTsN
CisNCisJCWlmIChJU19FUlIoaW5mcmFjZmcpKQ0KKwkJCXJldHVybiBQVFJfRVJSKGluZnJhY2Zn
KTsNCisNCisJCXJldCA9IHJlZ21hcF9yZWFkKGluZnJhY2ZnLCBSRUdfSU5GUkFfTUlTQywgJnZh
bCk7DQorCQlpZiAocmV0KQ0KKwkJCXJldHVybiByZXQ7DQorCQlkYXRhLT5lbmFibGVfNEdCID0g
ISEodmFsICYgRl9ERFJfNEdCX1NVUFBPUlRfRU4pOw0KKwl9DQogDQogCXJlcyA9IHBsYXRmb3Jt
X2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQogCWRhdGEtPmJhc2UgPSBk
ZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9p
bmZyYWNmZy5oDQppbmRleCBmZDI1ZjAxNDg1NjYuLjIzMzQ2M2Q3ODljNiAxMDA2NDQNCi0tLSBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCkBAIC0zMiw2ICszMiw5IEBADQogI2RlZmluZSBN
VDc2MjJfVE9QX0FYSV9QUk9UX0VOX1dCCQkoQklUKDIpIHwgQklUKDYpIHwgXA0KIAkJCQkJCSBC
SVQoNykgfCBCSVQoOCkpDQogDQorI2RlZmluZSBSRUdfSU5GUkFfTUlTQwkJCQkweGYwMA0KKyNk
ZWZpbmUgRl9ERFJfNEdCX1NVUFBPUlRfRU4JCQlCSVQoMTMpDQorDQogaW50IG10a19pbmZyYWNm
Z19zZXRfYnVzX3Byb3RlY3Rpb24oc3RydWN0IHJlZ21hcCAqaW5mcmFjZmcsIHUzMiBtYXNrLA0K
IAkJYm9vbCByZWdfdXBkYXRlKTsNCiBpbnQgbXRrX2luZnJhY2ZnX2NsZWFyX2J1c19wcm90ZWN0
aW9uKHN0cnVjdCByZWdtYXAgKmluZnJhY2ZnLCB1MzIgbWFzaywNCi0tIA0KMi4xOC4wDQo=

