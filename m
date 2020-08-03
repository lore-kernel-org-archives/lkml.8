Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A414C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E76206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PBtAdG3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHCGR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728296AbgHCGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:15 -0400
X-UUID: b44ecaec613942d5912a701aad6be7e6-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rjZDdVmKwlvCS5P7LK/+wokqw80LDUbVpUuPU9b4MXE=;
        b=PBtAdG3OUhO0EKZ7QrfIBhYI1/TLJsb9KssUm7goxz1UVCpaXByX3XFksd41P28Bi205YjopxJfsmf15zIZ4q9eML9GBXZnzAYbzHRjzUXm6H32Qvbonka5fEQOGejOF43afzUgeoBWYZ5TMAJ8Rg/k5Wnq+IO3BV5FptWnaHEM=;
X-UUID: b44ecaec613942d5912a701aad6be7e6-20200803
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 763517607; Mon, 03 Aug 2020 14:17:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:10 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v2,4/6] reset-controller: ti: introduce a new reset handler
Date:   Mon, 3 Aug 2020 14:15:09 +0800
Message-ID: <20200803061511.29555-5-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200803061511.29555-1-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRv
Z2V0aGVyLg0KSWYgc29tZSBtb2R1bGVzIG5lZWQgZG8gc2VyaWFsaXplZCBhc3NlcnQgYW5kIGRl
YXNzZXJ0IG9wZXJhdGlvbnMNCnRvIHJlc2V0IGl0c2VsZiwgcmVzZXRfY29udHJvbF9yZXNldCBj
YW4gYmUgY2FsbGVkIGZvciBjb252ZW5pZW5jZS4NCg0KQ2hhbmdlLUlkOiBJOTA0Njk5MmIxMTVh
NDZmMzU5NGRlNTdmYTg5YzZhMmRlOTk1N2Q0OQ0KLS0tDQogZHJpdmVycy9yZXNldC9yZXNldC10
aS1zeXNjb24uYyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lz
Y29uLmMgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQppbmRleCBhMjYzNWMyMWRi
N2YuLjFjNzRiY2I5YTZjMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lz
Y29uLmMNCisrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCkBAIC01Niw2ICs1
Niw3IEBAIHN0cnVjdCB0aV9zeXNjb25fcmVzZXRfZGF0YSB7DQogCXN0cnVjdCByZWdtYXAgKnJl
Z21hcDsNCiAJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9sICpjb250cm9sczsNCiAJdW5z
aWduZWQgaW50IG5yX2NvbnRyb2xzOw0KKwlib29sIGFzc2VydF9kZWFzc2VydF90b2dldGhlcjsN
CiB9Ow0KIA0KICNkZWZpbmUgdG9fdGlfc3lzY29uX3Jlc2V0X2RhdGEocmNkZXYpCVwNCkBAIC0x
NTgsMTAgKzE1OSwyNCBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9zdGF0dXMoc3RydWN0
IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCiAJCSEoY29udHJvbC0+ZmxhZ3MgJiBTVEFU
VVNfU0VUKTsNCiB9DQogDQorc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXQoc3RydWN0IHJlc2V0
X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCisJCQkgIHVuc2lnbmVkIGxvbmcgaWQpDQorew0KKwlz
dHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2RhdGEgKmRhdGEgPSB0b190aV9zeXNjb25fcmVzZXRfZGF0
YShyY2Rldik7DQorDQorCWlmIChkYXRhLT5hc3NlcnRfZGVhc3NlcnRfdG9nZXRoZXIpIHsNCisJ
CXRpX3N5c2Nvbl9yZXNldF9hc3NlcnQocmNkZXYsIGlkKTsNCisJCXJldHVybiB0aV9zeXNjb25f
cmVzZXRfZGVhc3NlcnQocmNkZXYsIGlkKTsNCisJfSBlbHNlIHsNCisJCXJldHVybiAtRU5PVFNV
UFA7DQorCX0NCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyB0
aV9zeXNjb25fcmVzZXRfb3BzID0gew0KIAkuYXNzZXJ0CQk9IHRpX3N5c2Nvbl9yZXNldF9hc3Nl
cnQsDQogCS5kZWFzc2VydAk9IHRpX3N5c2Nvbl9yZXNldF9kZWFzc2VydCwNCiAJLnN0YXR1cwkJ
PSB0aV9zeXNjb25fcmVzZXRfc3RhdHVzLA0KKwkucmVzZXQJCT0gdGlfc3lzY29uX3Jlc2V0LA0K
IH07DQogDQogc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCkBAIC0yMDQsNiArMjE5LDExIEBAIHN0YXRpYyBpbnQgdGlfc3lzY29u
X3Jlc2V0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQljb250cm9sc1tp
XS5mbGFncyA9IGJlMzJfdG9fY3B1cChsaXN0KyspOw0KIAl9DQogDQorCWlmIChvZl9wcm9wZXJ0
eV9yZWFkX2Jvb2wobnAsICJhc3NlcnQtZGVhc3NlcnQtdG9nZXRoZXIiKSkNCisJCWRhdGEtPmFz
c2VydF9kZWFzc2VydF90b2dldGhlciA9IHRydWU7DQorCWVsc2UNCisJCWRhdGEtPmFzc2VydF9k
ZWFzc2VydF90b2dldGhlciA9IGZhbHNlOw0KKw0KIAlkYXRhLT5yY2Rldi5vcHMgPSAmdGlfc3lz
Y29uX3Jlc2V0X29wczsNCiAJZGF0YS0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsNCiAJZGF0
YS0+cmNkZXYub2Zfbm9kZSA9IG5wOw0KLS0gDQoyLjE4LjANCg==

