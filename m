Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBCCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8E6206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aywaiOYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgGGPqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:46:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52321 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727791AbgGGPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:33 -0400
X-UUID: f620e6540173436dbeb60bd74a3e46c9-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NMbzrFgr1D1ON+0m4oV6SYOuNW2QtIquhnTgvJXv7Bg=;
        b=aywaiOYHUZJcSHN7njNTXcANfWyVZtyCsXlKbL0wSZmkCc9WuhWS24vXX5oWHoLyJQxBCHl1840b/ciNbo6oMyiNC1BCrKuG+3Sp99W3bwJjOptEYf+0DRz2DsEhC7gMk9KPZFFnvYYxgfTR1nc0zSQG+9MzNEZVHBZeM1nlXAo=;
X-UUID: f620e6540173436dbeb60bd74a3e46c9-20200707
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2090881792; Tue, 07 Jul 2020 23:46:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 23:46:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 23:46:25 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 7/9] soc: mediatek: cmdq: add jump function
Date:   Tue, 7 Jul 2020 23:45:12 +0800
Message-ID: <1594136714-11650-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCmNvbnRhaW5zIGluc3RydWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8ICAgMTMgKysrKysrKysrKysrKw0KIGluY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgICAxMSArKysrKysrKysrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KaW5kZXggYjZlMjVmMjE2NjA1Li5kNTVkYzMyOTYxMDUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0xMyw2ICsxMyw3IEBADQogI2RlZmlu
ZSBDTURRX1BPTExfRU5BQkxFX01BU0sJQklUKDApDQogI2RlZmluZSBDTURRX0VPQ19JUlFfRU4J
CUJJVCgwKQ0KICNkZWZpbmUgQ01EUV9SRUdfVFlQRQkJMQ0KKyNkZWZpbmUgQ01EUV9KVU1QX1JF
TEFUSVZFCTENCiANCiBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCkBAIC00
MDcsNiArNDA4LDE4IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfYXNz
aWduKTsNCiANCitpbnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2Fk
ZHJfdCBhZGRyKQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0KKw0K
KwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQorCWluc3Qub2Zmc2V0ID0gQ01EUV9KVU1QX1JF
TEFUSVZFOw0KKwlpbnN0LnZhbHVlID0gYWRkciA+Pg0KKwkJY21kcV9nZXRfc2hpZnRfcGEoKChz
dHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsKS0+Y2hhbik7DQorCXJldHVybiBjbWRxX3BrdF9h
cHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2p1
bXApOw0KKw0KIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCiB7
DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBkOTM5MGQ3NmVlMTQuLjM0MzU0ZTk1MmY2MCAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0yNTMsNiArMjUzLDE3
IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5
cywNCiBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lk
eCwgdTMyIHZhbHVlKTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF9qdW1wKCkgLSBBcHBlbmQganVt
cCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdDRQ0KKyAqCQkgICAgIHRvIGV4ZWN1
dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBjaGFuZ2UgY3VycmVudCB0aHJlYWQgUEMgdG8NCisgKgkJ
ICAgICBhIHBoeXNpY2FsIGFkZHJlc3Mgd2hpY2ggc2hvdWxkIGNvbnRhaW5zIG1vcmUgaW5zdHJ1
Y3Rpb24uDQorICogQHBrdDogICAgICAgIHRoZSBDTURRIHBhY2tldA0KKyAqIEBhZGRyOiAgICAg
ICBwaHlzaWNhbCBhZGRyZXNzIG9mIHRhcmdldCBpbnN0cnVjdGlvbiBidWZmZXINCisgKg0KKyAq
IFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0K
KyAqLw0KK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90
IGFkZHIpOw0KKw0KKy8qKg0KICAqIGNtZHFfcGt0X2ZpbmFsaXplKCkgLSBBcHBlbmQgRU9DIGFu
ZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KICAqDQot
LSANCjEuNy45LjUNCg==

