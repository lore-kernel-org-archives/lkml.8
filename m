Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB1EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008C2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SjNBQ6we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaK4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:56:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43559 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726121AbgHaK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:56:53 -0400
X-UUID: d92c9e3114fa4d5c8c978949b4224d19-20200831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PFK96T7avqn9jICrOvLa+GZbdRwSDF9sP7kZd14N3es=;
        b=SjNBQ6weldBIG4cCv4v/RPnwzTdTxs5IQIjHtZhR4RBdjJe/nKlWJUWONsjlKK/3OjNjAX/cP++Px1uHRAHGe2c40dtq7y/zYwZKZSNqiFLrbnurigTOnLoo5SFAbfocv31xnZrAlFDBB09+DfFoam9uOMdhbb2DbX/AtzakNgc=;
X-UUID: d92c9e3114fa4d5c8c978949b4224d19-20200831
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1501708277; Mon, 31 Aug 2020 18:56:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 18:56:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 Aug 2020 18:56:38 +0800
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
Subject: [PATCH v5] iommu/mediatek: check 4GB mode by reading infracfg
Date:   Mon, 31 Aug 2020 18:56:39 +0800
Message-ID: <20200831105639.2856-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 80F077771CDF5D82782C84C936A5D97B92B6AC9617A3A67447E00A9E4B201C822000:8
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
Y29tPg0KDQotLS0NCg0KQ2hhbmdlIHNpbmNlIHY0DQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBkYXRh
LT5lbmFibGVfNEdCID0gZmFsc2UsIHNpbmNlIGl0IGlzIGt6YWxsb2MoKWVkLg0KDQpDaGFuZ2Ug
c2luY2UgdjMNCi0gdXNlIGxvcmUua2VybmVsLm9yZyBsaW5rcw0KLSBtb3ZlICJjaGFuZ2Ugc2lu
Y2UuLi4iIGFmdGVyICItLS0iDQoNCkNoYW5nZSBzaW5jZSB2MjoNCi0gZGV0ZXJtaW5lIGNvbXBh
dGlibGUgc3RyaW5nIGJ5IG00dV9wbGF0DQotIHJlYmFzZSB0byBuZXh0LTIwMjAwNzIwDQotIGFk
ZCAiLS0tIg0KDQpDaGFuZ2Ugc2luY2UgdjE6DQotIHJlbW92ZSB0aGUgcGhhbmRsZSB1c2FnZSwg
c2VhcmNoIGZvciBpbmZyYWNmZyBpbnN0ZWFkIFszXQ0KLSB1c2UgaW5mcmFjZmcgaW5zdGVhZCBv
ZiBpbmZyYWNmZ19yZWdtYXANCi0gbW92ZSBpbmZyYWNmZyBkZWZpbml0YWlvbnMgdG8gbGludXgv
c29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCi0gdXBkYXRlIGVuYWJsZV80R0Igb25seSB3aGVuIGhh
c180Z2JfbW9kZQ0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAgICAgICAgICB8
IDMzICsrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL2luZnJhY2ZnLmggfCAgMyArKysNCiAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggNzg1YjIyOGQzOWE2Li5lN2I4
YjJiYjA4YTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMyw3ICszLDYgQEANCiAgKiBDb3B5cmlnaHQg
KGMpIDIwMTUtMjAxNiBNZWRpYVRlayBJbmMuDQogICogQXV0aG9yOiBZb25nIFd1IDx5b25nLnd1
QG1lZGlhdGVrLmNvbT4NCiAgKi8NCi0jaW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4NCiAjaW5j
bHVkZSA8bGludXgvYnVnLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KICNpbmNsdWRlIDxs
aW51eC9jb21wb25lbnQuaD4NCkBAIC0xNSwxMyArMTQsMTYgQEANCiAjaW5jbHVkZSA8bGludXgv
aW9tbXUuaD4NCiAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2xp
c3QuaD4NCisjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9v
Zl9hZGRyZXNzLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2lvbW11Lmg+DQogI2luY2x1ZGUgPGxp
bnV4L29mX2lycS5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQog
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCisj
aW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmg+DQogI2luY2x1ZGUgPGFzbS9i
YXJyaWVyLmg+DQogI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCiANCkBAIC02NDAsOCAr
NjQyLDExIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCXN0cnVjdCByZXNvdXJjZSAgICAgICAgICpyZXM7DQogCXJlc291cmNlX3Np
emVfdAkJaW9hZGRyOw0KIAlzdHJ1Y3QgY29tcG9uZW50X21hdGNoICAqbWF0Y2ggPSBOVUxMOw0K
KwlzdHJ1Y3QgcmVnbWFwCQkqaW5mcmFjZmc7DQogCXZvaWQgICAgICAgICAgICAgICAgICAgICpw
cm90ZWN0Ow0KIAlpbnQgICAgICAgICAgICAgICAgICAgICBpLCBsYXJiX25yLCByZXQ7DQorCXUz
MgkJCXZhbDsNCisJY2hhciAgICAgICAgICAgICAgICAgICAgKnA7DQogDQogCWRhdGEgPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsNCiAJaWYgKCFkYXRhKQ0K
QEAgLTY1NSwxMCArNjYwLDI4IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gLUVOT01FTTsNCiAJZGF0YS0+cHJvdGVj
dF9iYXNlID0gQUxJR04odmlydF90b19waHlzKHByb3RlY3QpLCBNVEtfUFJPVEVDVF9QQV9BTElH
Tik7DQogDQotCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBpcyBvdmVyIDRHQiAqLw0KLQlk
YXRhLT5lbmFibGVfNEdCID0gISEobWF4X3BmbiA+IChCSVRfVUxMKDMyKSA+PiBQQUdFX1NISUZU
KSk7DQotCWlmICghTVRLX0lPTU1VX0hBU19GTEFHKGRhdGEtPnBsYXRfZGF0YSwgSEFTXzRHQl9N
T0RFKSkNCi0JCWRhdGEtPmVuYWJsZV80R0IgPSBmYWxzZTsNCisJaWYgKE1US19JT01NVV9IQVNf
RkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpIHsNCisJCXN3aXRjaCAoZGF0YS0+
cGxhdF9kYXRhLT5tNHVfcGxhdCkgew0KKwkJY2FzZSBNNFVfTVQyNzEyOg0KKwkJCXAgPSAibWVk
aWF0ZWssbXQyNzEyLWluZnJhY2ZnIjsNCisJCQlicmVhazsNCisJCWNhc2UgTTRVX01UODE3MzoN
CisJCQlwID0gIm1lZGlhdGVrLG10ODE3My1pbmZyYWNmZyI7DQorCQkJYnJlYWs7DQorCQlkZWZh
dWx0Og0KKwkJCXAgPSBOVUxMOw0KKwkJfQ0KKw0KKwkJaW5mcmFjZmcgPSBzeXNjb25fcmVnbWFw
X2xvb2t1cF9ieV9jb21wYXRpYmxlKHApOw0KKw0KKwkJaWYgKElTX0VSUihpbmZyYWNmZykpDQor
CQkJcmV0dXJuIFBUUl9FUlIoaW5mcmFjZmcpOw0KKw0KKwkJcmV0ID0gcmVnbWFwX3JlYWQoaW5m
cmFjZmcsIFJFR19JTkZSQV9NSVNDLCAmdmFsKTsNCisJCWlmIChyZXQpDQorCQkJcmV0dXJuIHJl
dDsNCisJCWRhdGEtPmVuYWJsZV80R0IgPSAhISh2YWwgJiBGX0REUl80R0JfU1VQUE9SVF9FTik7
DQorCX0NCiANCiAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0Vf
TUVNLCAwKTsNCiAJZGF0YS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7
DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgNCmluZGV4IGZkMjVmMDE0ODU2Ni4u
MjMzNDYzZDc4OWM2IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5m
cmFjZmcuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KQEAg
LTMyLDYgKzMyLDkgQEANCiAjZGVmaW5lIE1UNzYyMl9UT1BfQVhJX1BST1RfRU5fV0IJCShCSVQo
MikgfCBCSVQoNikgfCBcDQogCQkJCQkJIEJJVCg3KSB8IEJJVCg4KSkNCiANCisjZGVmaW5lIFJF
R19JTkZSQV9NSVNDCQkJCTB4ZjAwDQorI2RlZmluZSBGX0REUl80R0JfU1VQUE9SVF9FTgkJCUJJ
VCgxMykNCisNCiBpbnQgbXRrX2luZnJhY2ZnX3NldF9idXNfcHJvdGVjdGlvbihzdHJ1Y3QgcmVn
bWFwICppbmZyYWNmZywgdTMyIG1hc2ssDQogCQlib29sIHJlZ191cGRhdGUpOw0KIGludCBtdGtf
aW5mcmFjZmdfY2xlYXJfYnVzX3Byb3RlY3Rpb24oc3RydWN0IHJlZ21hcCAqaW5mcmFjZmcsIHUz
MiBtYXNrLA0KLS0gDQoyLjE4LjANCg==

