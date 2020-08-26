Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275AA2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hqvi7lbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHZI4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:56:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7989 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727793AbgHZI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:56:26 -0400
X-UUID: 5449f9c61e02490db3bee6e3dc33b42a-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0y0Vfo6/get6fXxv+JKbgOiwCIDoQLsBCkYvCv7n8ek=;
        b=hqvi7lbj0WRx7lbM4KJFWEvN8WPZZaznw0EePpBG/ULsutCHqAWvkQlrmufhNrzPdaMBLCkgxLAFcHWHysK0j6I3t+ftEEGzpASlUI8duR3SzWNPTeY+jVOP2T+pjGhvolLwVho7CBeWCG2Fz4aqaArdWWSwhSYfOOlwflbbvCU=;
X-UUID: 5449f9c61e02490db3bee6e3dc33b42a-20200826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 990541766; Wed, 26 Aug 2020 16:56:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:56:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 16:56:17 +0800
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
Subject: [RESEND PATCH v4] iommu/mediatek: check 4GB mode by reading infracfg
Date:   Wed, 26 Aug 2020 16:56:18 +0800
Message-ID: <20200826085618.2889-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
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
IG1vZHVsZS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA2MDMxNjEx
MzIuMjQ0MS0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tLw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMDA2MDQwODAxMjAuMjYyOC0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29t
Lw0KWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA3MTUyMDUxMjAuR0E3Nzg4
NzZAYm9ndXMvDQoNCkNjOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQpDYzog
RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQpDYzogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQpDYzogWWluZ2pvZSBDaGVuIDx5aW5nam9lLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KQ2M6IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KDQotLS0NCg0KQ2hhbmdlIHNpbmNlIHYzDQotIHVzZSBsb3JlLmtlcm5lbC5vcmcgbGlu
a3MNCi0gbW92ZSAiY2hhbmdlIHNpbmNlLi4uIiBhZnRlciAiLS0tIg0KDQpDaGFuZ2Ugc2luY2Ug
djI6DQotIGRldGVybWluZSBjb21wYXRpYmxlIHN0cmluZyBieSBtNHVfcGxhdA0KLSByZWJhc2Ug
dG8gbmV4dC0yMDIwMDcyMA0KLSBhZGQgIi0tLSINCg0KQ2hhbmdlIHNpbmNlIHYxOg0KLSByZW1v
dmUgdGhlIHBoYW5kbGUgdXNhZ2UsIHNlYXJjaCBmb3IgaW5mcmFjZmcgaW5zdGVhZCBbM10NCi0g
dXNlIGluZnJhY2ZnIGluc3RlYWQgb2YgaW5mcmFjZmdfcmVnbWFwDQotIG1vdmUgaW5mcmFjZmcg
ZGVmaW5pdGFpb25zIHRvIGxpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQotIHVwZGF0ZSBl
bmFibGVfNEdCIG9ubHkgd2hlbiBoYXNfNGdiX21vZGUNCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgICAgICAgICAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiBp
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oIHwgIDMgKysrDQogMiBmaWxlcyBj
aGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmlu
ZGV4IDc4NWIyMjhkMzlhNi4uYWRjMzUwMTUwNDkyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTMsNyAr
Myw2IEBADQogICogQ29weXJpZ2h0IChjKSAyMDE1LTIwMTYgTWVkaWFUZWsgSW5jLg0KICAqIEF1
dGhvcjogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQogICovDQotI2luY2x1ZGUgPGxp
bnV4L21lbWJsb2NrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0KICNpbmNsdWRlIDxsaW51
eC9jbGsuaD4NCiAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQpAQCAtMTUsMTMgKzE0LDE2
IEBADQogI2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5o
Pg0KICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24u
aD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9p
b21tdS5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCiAjaW5jbHVkZSA8bGludXgvb2Zf
cGxhdGZvcm0uaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorI2luY2x1
ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUg
PGxpbnV4L3NwaW5sb2NrLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNm
Zy5oPg0KICNpbmNsdWRlIDxhc20vYmFycmllci5oPg0KICNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsv
c21pLmg+DQogDQpAQCAtNjQwLDggKzY0MiwxMSBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgcmVzb3VyY2UgICAgICAg
ICAqcmVzOw0KIAlyZXNvdXJjZV9zaXplX3QJCWlvYWRkcjsNCiAJc3RydWN0IGNvbXBvbmVudF9t
YXRjaCAgKm1hdGNoID0gTlVMTDsNCisJc3RydWN0IHJlZ21hcAkJKmluZnJhY2ZnOw0KIAl2b2lk
ICAgICAgICAgICAgICAgICAgICAqcHJvdGVjdDsNCiAJaW50ICAgICAgICAgICAgICAgICAgICAg
aSwgbGFyYl9uciwgcmV0Ow0KKwl1MzIJCQl2YWw7DQorCWNoYXIgICAgICAgICAgICAgICAgICAg
ICpwOw0KIA0KIAlkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tF
Uk5FTCk7DQogCWlmICghZGF0YSkNCkBAIC02NTUsMTAgKzY2MCwyOSBAQCBzdGF0aWMgaW50IG10
a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIC1F
Tk9NRU07DQogCWRhdGEtPnByb3RlY3RfYmFzZSA9IEFMSUdOKHZpcnRfdG9fcGh5cyhwcm90ZWN0
KSwgTVRLX1BST1RFQ1RfUEFfQUxJR04pOw0KIA0KLQkvKiBXaGV0aGVyIHRoZSBjdXJyZW50IGRy
YW0gaXMgb3ZlciA0R0IgKi8NCi0JZGF0YS0+ZW5hYmxlXzRHQiA9ICEhKG1heF9wZm4gPiAoQklU
X1VMTCgzMikgPj4gUEFHRV9TSElGVCkpOw0KLQlpZiAoIU1US19JT01NVV9IQVNfRkxBRyhkYXRh
LT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpDQotCQlkYXRhLT5lbmFibGVfNEdCID0gZmFsc2U7
DQorCWRhdGEtPmVuYWJsZV80R0IgPSBmYWxzZTsNCisJaWYgKE1US19JT01NVV9IQVNfRkxBRyhk
YXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpIHsNCisJCXN3aXRjaCAoZGF0YS0+cGxhdF9k
YXRhLT5tNHVfcGxhdCkgew0KKwkJY2FzZSBNNFVfTVQyNzEyOg0KKwkJCXAgPSAibWVkaWF0ZWss
bXQyNzEyLWluZnJhY2ZnIjsNCisJCQlicmVhazsNCisJCWNhc2UgTTRVX01UODE3MzoNCisJCQlw
ID0gIm1lZGlhdGVrLG10ODE3My1pbmZyYWNmZyI7DQorCQkJYnJlYWs7DQorCQlkZWZhdWx0Og0K
KwkJCXAgPSBOVUxMOw0KKwkJfQ0KKw0KKwkJaW5mcmFjZmcgPSBzeXNjb25fcmVnbWFwX2xvb2t1
cF9ieV9jb21wYXRpYmxlKHApOw0KKw0KKwkJaWYgKElTX0VSUihpbmZyYWNmZykpDQorCQkJcmV0
dXJuIFBUUl9FUlIoaW5mcmFjZmcpOw0KKw0KKwkJcmV0ID0gcmVnbWFwX3JlYWQoaW5mcmFjZmcs
IFJFR19JTkZSQV9NSVNDLCAmdmFsKTsNCisJCWlmIChyZXQpDQorCQkJcmV0dXJuIHJldDsNCisJ
CWRhdGEtPmVuYWJsZV80R0IgPSAhISh2YWwgJiBGX0REUl80R0JfU1VQUE9SVF9FTik7DQorCX0N
CiANCiAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAw
KTsNCiAJZGF0YS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCBiL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCmluZGV4IGZkMjVmMDE0ODU2Ni4uMjMzNDYz
ZDc4OWM2IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcu
aA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KQEAgLTMyLDYg
KzMyLDkgQEANCiAjZGVmaW5lIE1UNzYyMl9UT1BfQVhJX1BST1RfRU5fV0IJCShCSVQoMikgfCBC
SVQoNikgfCBcDQogCQkJCQkJIEJJVCg3KSB8IEJJVCg4KSkNCiANCisjZGVmaW5lIFJFR19JTkZS
QV9NSVNDCQkJCTB4ZjAwDQorI2RlZmluZSBGX0REUl80R0JfU1VQUE9SVF9FTgkJCUJJVCgxMykN
CisNCiBpbnQgbXRrX2luZnJhY2ZnX3NldF9idXNfcHJvdGVjdGlvbihzdHJ1Y3QgcmVnbWFwICpp
bmZyYWNmZywgdTMyIG1hc2ssDQogCQlib29sIHJlZ191cGRhdGUpOw0KIGludCBtdGtfaW5mcmFj
ZmdfY2xlYXJfYnVzX3Byb3RlY3Rpb24oc3RydWN0IHJlZ21hcCAqaW5mcmFjZmcsIHUzMiBtYXNr
LA0KLS0gDQoyLjE4LjANCg==

