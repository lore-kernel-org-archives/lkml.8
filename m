Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9829C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3EA62072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uU0K7gWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgGUCQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:16:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11310 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbgGUCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:16:26 -0400
X-UUID: a19c054b7fde42b58d6bb2b3cd59a97b-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1bSgcMBsyM3c9aSUx6HgVWkvGxtBrg5PzcKspdBYPfE=;
        b=uU0K7gWFecpXxjP8fs8a5jIXNn9ppUVyp+B6uKN62qUvJ0dRRftxxRmZqXu7i1sHHMUKv/k0GTiOXhvrx6LDDIf63aLx7DUfDNz+3AXiQqR3RVRpswopdwczSzcpnmOKVG+wCJogGwnu8umHFijHrLpU9qBDRcgvAxSvQI12HuU=;
X-UUID: a19c054b7fde42b58d6bb2b3cd59a97b-20200721
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 300682285; Tue, 21 Jul 2020 10:16:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Jul 2020 10:16:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 10:16:21 +0800
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
        Christoph Hellwig <hch@lst.de>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
Date:   Tue, 21 Jul 2020 10:16:19 +0800
Message-ID: <20200721021619.25575-1-miles.chen@mediatek.com>
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
IG1vZHVsZS4NCg0KQ2hhbmdlIHNpbmNlIHYxOg0KMS4gcmVtb3ZlIHRoZSBwaGFuZGxlIHVzYWdl
LCBzZWFyY2ggZm9yIGluZnJhY2ZnIGluc3RlYWQgWzNdDQoyLiB1c2UgaW5mcmFjZmcgaW5zdGVh
ZCBvZiBpbmZyYWNmZ19yZWdtYXANCjMuIG1vdmUgaW5mcmFjZmcgZGVmaW5pdGFpb25zIHRvIGxp
bnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo0LiB1cGRhdGUgZW5hYmxlXzRHQiBvbmx5IHdo
ZW4gaGFzXzRnYl9tb2RlDQoNClsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82LzMvNzMz
DQpbMl0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNi80LzEzNg0KWzNdIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDIwLzcvMTUvMTE0Nw0KDQpDYzogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51
eC5pYm0uY29tPg0KQ2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KQ2M6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IFlpbmdqb2UgQ2hlbiA8eWluZ2pv
ZS5jaGVuQG1lZGlhdGVrLmNvbT4NCkNjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
CkNjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCkNjOiBDaGFvIEhhbyA8Y2hhby5o
YW9AbWVkaWF0ZWsuY29tPg0KQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpDYzog
TWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6
IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyAgICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0t
DQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCB8ICAzICsrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQppbmRleCAyYmU5NmYxY2RiZDIuLjE2NzY1ZjUzMjg1MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0z
LDcgKzMsNiBAQA0KICAqIENvcHlyaWdodCAoYykgMjAxNS0yMDE2IE1lZGlhVGVrIEluYy4NCiAg
KiBBdXRob3I6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KICAqLw0KLSNpbmNsdWRl
IDxsaW51eC9tZW1ibG9jay5oPg0KICNpbmNsdWRlIDxsaW51eC9idWcuaD4NCiAjaW5jbHVkZSA8
bGludXgvY2xrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KQEAgLTE1LDEzICsx
NCwxNiBAQA0KICNpbmNsdWRlIDxsaW51eC9pb21tdS5oPg0KICNpbmNsdWRlIDxsaW51eC9pb3Bv
bGwuaD4NCiAjaW5jbHVkZSA8bGludXgvbGlzdC5oPg0KKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lz
Y29uLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCiAjaW5jbHVkZSA8bGludXgv
b2ZfaW9tbXUuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQogI2luY2x1ZGUgPGxpbnV4
L29mX3BsYXRmb3JtLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNp
bmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNs
dWRlIDxsaW51eC9zcGlubG9jay5oPg0KKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvaW5m
cmFjZmcuaD4NCiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCiAjaW5jbHVkZSA8c29jL21lZGlh
dGVrL3NtaS5oPg0KIA0KQEAgLTU5OSw4ICs2MDEsMTAgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IHJlc291cmNlICAg
ICAgICAgKnJlczsNCiAJcmVzb3VyY2Vfc2l6ZV90CQlpb2FkZHI7DQogCXN0cnVjdCBjb21wb25l
bnRfbWF0Y2ggICptYXRjaCA9IE5VTEw7DQorCXN0cnVjdCByZWdtYXAJCSppbmZyYWNmZzsNCiAJ
dm9pZCAgICAgICAgICAgICAgICAgICAgKnByb3RlY3Q7DQogCWludCAgICAgICAgICAgICAgICAg
ICAgIGksIGxhcmJfbnIsIHJldDsNCisJdTMyCQkJdmFsOw0KIA0KIAlkYXRhID0gZGV2bV9remFs
bG9jKGRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghZGF0YSkNCkBAIC02
MTQsMTAgKzYxOCwyMiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogCWRhdGEtPnByb3RlY3RfYmFz
ZSA9IEFMSUdOKHZpcnRfdG9fcGh5cyhwcm90ZWN0KSwgTVRLX1BST1RFQ1RfUEFfQUxJR04pOw0K
IA0KLQkvKiBXaGV0aGVyIHRoZSBjdXJyZW50IGRyYW0gaXMgb3ZlciA0R0IgKi8NCi0JZGF0YS0+
ZW5hYmxlXzRHQiA9ICEhKG1heF9wZm4gPiAoQklUX1VMTCgzMikgPj4gUEFHRV9TSElGVCkpOw0K
LQlpZiAoIWRhdGEtPnBsYXRfZGF0YS0+aGFzXzRnYl9tb2RlKQ0KLQkJZGF0YS0+ZW5hYmxlXzRH
QiA9IGZhbHNlOw0KKwlkYXRhLT5lbmFibGVfNEdCID0gZmFsc2U7DQorCWlmIChkYXRhLT5wbGF0
X2RhdGEtPmhhc180Z2JfbW9kZSkgew0KKwkJaW5mcmFjZmcgPSBzeXNjb25fcmVnbWFwX2xvb2t1
cF9ieV9jb21wYXRpYmxlKA0KKwkJCQkibWVkaWF0ZWssbXQ4MTczLWluZnJhY2ZnIik7DQorCQlp
ZiAoSVNfRVJSKGluZnJhY2ZnKSkgew0KKwkJCWluZnJhY2ZnID0gc3lzY29uX3JlZ21hcF9sb29r
dXBfYnlfY29tcGF0aWJsZSgNCisJCQkJCSJtZWRpYXRlayxtdDI3MTItaW5mcmFjZmciKTsNCisJ
CQlpZiAoSVNfRVJSKGluZnJhY2ZnKSkNCisJCQkJcmV0dXJuIFBUUl9FUlIoaW5mcmFjZmcpOw0K
Kw0KKwkJfQ0KKwkJcmV0ID0gcmVnbWFwX3JlYWQoaW5mcmFjZmcsIFJFR19JTkZSQV9NSVNDLCAm
dmFsKTsNCisJCWlmIChyZXQpDQorCQkJcmV0dXJuIHJldDsNCisJCWRhdGEtPmVuYWJsZV80R0Ig
PSAhISh2YWwgJiBGX0REUl80R0JfU1VQUE9SVF9FTik7DQorCX0NCiANCiAJcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJZGF0YS0+YmFzZSA9
IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L2luZnJhY2ZnLmgNCmluZGV4IGZkMjVmMDE0ODU2Ni4uMjMzNDYzZDc4OWM2IDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KKysrIGIvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaA0KQEAgLTMyLDYgKzMyLDkgQEANCiAjZGVmaW5l
IE1UNzYyMl9UT1BfQVhJX1BST1RfRU5fV0IJCShCSVQoMikgfCBCSVQoNikgfCBcDQogCQkJCQkJ
IEJJVCg3KSB8IEJJVCg4KSkNCiANCisjZGVmaW5lIFJFR19JTkZSQV9NSVNDCQkJCTB4ZjAwDQor
I2RlZmluZSBGX0REUl80R0JfU1VQUE9SVF9FTgkJCUJJVCgxMykNCisNCiBpbnQgbXRrX2luZnJh
Y2ZnX3NldF9idXNfcHJvdGVjdGlvbihzdHJ1Y3QgcmVnbWFwICppbmZyYWNmZywgdTMyIG1hc2ss
DQogCQlib29sIHJlZ191cGRhdGUpOw0KIGludCBtdGtfaW5mcmFjZmdfY2xlYXJfYnVzX3Byb3Rl
Y3Rpb24oc3RydWN0IHJlZ21hcCAqaW5mcmFjZmcsIHUzMiBtYXNrLA0KLS0gDQoyLjE4LjANCg==

