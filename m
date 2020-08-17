Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D1720658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JLxLRJ1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHQCu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:50:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41113 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726919AbgHQCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:50:20 -0400
X-UUID: dc8e32b7525d41bd922fb07f26428077-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=keeKoJIRKUWFE6P/EASXouOcJ/N4TDpUj5yGA3TaFgs=;
        b=JLxLRJ1I4279hHgA4aVe2HMhLsaWkykIAV7aMnLd9Kh3y/XkhYSIDeU75RS3Burmsk9Bs6ityN5D58CWEfJKNLnAmYoslMdmYe8D7svs18hofMbi6Sv4sSGTmFhdjmoTDYgDXB1pm6cR3PDJWrYDZRQhX14Y/O8KYF09X9Nj5tM=;
X-UUID: dc8e32b7525d41bd922fb07f26428077-20200817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1341079207; Mon, 17 Aug 2020 10:50:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 10:50:12 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 10:50:12 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <afd@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v3,3/4] reset-controller: ti: introduce a new reset handler
Date:   Mon, 17 Aug 2020 10:48:41 +0800
Message-ID: <20200817024842.5289-4-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817024842.5289-1-crystal.guo@mediatek.com>
References: <20200817024842.5289-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW50cm9kdWNlIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5kIGRlYXNz
ZXJ0IHRvZ2V0aGVyLg0KSWYgc29tZSBtb2R1bGVzIG5lZWQgZG8gc2VyaWFsaXplZCBhc3NlcnQg
YW5kIGRlYXNzZXJ0IG9wZXJhdGlvbnMNCnRvIHJlc2V0IGl0c2VsZiwgcmVzZXRfY29udHJvbF9y
ZXNldCBjYW4gYmUgY2FsbGVkIGZvciBjb252ZW5pZW5jZS4NCg0KU3VjaCBhcyByZXNldC1xY29t
LWFvc3MuYywgaXQgaW50ZWdyYXRlcyBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRvZ2V0aGVyDQpieSAn
cmVzZXQnIG1ldGhvZC4gTVRLIFNvY3MgYWxzbyBuZWVkIHRoaXMgbWV0aG9kIHRvIHBlcmZvcm0g
cmVzZXQuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRl
ay5jb20+DQotLS0NCiBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jIHwgMjYgKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lz
Y29uLmMgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQppbmRleCBhMjYzNWMyMWRi
N2YuLjA4Mjg5MzQyZjlhZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lz
Y29uLmMNCisrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCkBAIC0xNSw2ICsx
NSw3IEBADQogICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4N
CiAgKi8NCiANCisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCiAjaW5jbHVkZSA8bGludXgvbWZk
L3N5c2Nvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgv
b2YuaD4NCkBAIC01Niw2ICs1Nyw3IEBAIHN0cnVjdCB0aV9zeXNjb25fcmVzZXRfZGF0YSB7DQog
CXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCiAJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9s
ICpjb250cm9sczsNCiAJdW5zaWduZWQgaW50IG5yX2NvbnRyb2xzOw0KKwl1bnNpZ25lZCBpbnQg
cmVzZXRfZHVyYXRpb25fdXM7DQogfTsNCiANCiAjZGVmaW5lIHRvX3RpX3N5c2Nvbl9yZXNldF9k
YXRhKHJjZGV2KQlcDQpAQCAtODksNyArOTEsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNl
dF9hc3NlcnQoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCiAJbWFzayA9IEJJ
VChjb250cm9sLT5hc3NlcnRfYml0KTsNCiAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBBU1NF
UlRfU0VUKSA/IG1hc2sgOiAweDA7DQogDQotCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoZGF0
YS0+cmVnbWFwLCBjb250cm9sLT5hc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQorCXJldHVy
biByZWdtYXBfd3JpdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmFzc2VydF9vZmZzZXQs
IG1hc2ssIHZhbHVlKTsNCiB9DQogDQogLyoqDQpAQCAtMTIwLDcgKzEyMiw3IEBAIHN0YXRpYyBp
bnQgdGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAq
cmNkZXYsDQogCW1hc2sgPSBCSVQoY29udHJvbC0+ZGVhc3NlcnRfYml0KTsNCiAJdmFsdWUgPSAo
Y29udHJvbC0+ZmxhZ3MgJiBERUFTU0VSVF9TRVQpID8gbWFzayA6IDB4MDsNCiANCi0JcmV0dXJu
IHJlZ21hcF91cGRhdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmRlYXNzZXJ0X29mZnNl
dCwgbWFzaywgdmFsdWUpOw0KKwlyZXR1cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0YS0+cmVnbWFw
LCBjb250cm9sLT5kZWFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCiB9DQogDQogLyoqDQpA
QCAtMTU4LDkgKzE2MCwyNiBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9zdGF0dXMoc3Ry
dWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCiAJCSEoY29udHJvbC0+ZmxhZ3MgJiBT
VEFUVVNfU0VUKTsNCiB9DQogDQorc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXQoc3RydWN0IHJl
c2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCisJCQkJICB1bnNpZ25lZCBsb25nIGlkKQ0KK3sN
CisJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9kYXRhICpkYXRhID0gdG9fdGlfc3lzY29uX3Jlc2V0
X2RhdGEocmNkZXYpOw0KKwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSB0aV9zeXNjb25fcmVzZXRfYXNz
ZXJ0KHJjZGV2LCBpZCk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlpZiAoZGF0
YS0+cmVzZXRfZHVyYXRpb25fdXMpDQorCQl1c2xlZXBfcmFuZ2UoZGF0YS0+cmVzZXRfZHVyYXRp
b25fdXMsIGRhdGEtPnJlc2V0X2R1cmF0aW9uX3VzICogMik7DQorDQorCXJldHVybiB0aV9zeXNj
b25fcmVzZXRfZGVhc3NlcnQocmNkZXYsIGlkKTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVj
dCByZXNldF9jb250cm9sX29wcyB0aV9zeXNjb25fcmVzZXRfb3BzID0gew0KIAkuYXNzZXJ0CQk9
IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQsDQogCS5kZWFzc2VydAk9IHRpX3N5c2Nvbl9yZXNldF9k
ZWFzc2VydCwNCisJLnJlc2V0CQk9IHRpX3N5c2Nvbl9yZXNldCwNCiAJLnN0YXR1cwkJPSB0aV9z
eXNjb25fcmVzZXRfc3RhdHVzLA0KIH07DQogDQpAQCAtMjA0LDYgKzIyMyw5IEBAIHN0YXRpYyBp
bnQgdGlfc3lzY29uX3Jlc2V0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
CQljb250cm9sc1tpXS5mbGFncyA9IGJlMzJfdG9fY3B1cChsaXN0KyspOw0KIAl9DQogDQorCW9m
X3Byb3BlcnR5X3JlYWRfdTMyKHBkZXYtPmRldi5vZl9ub2RlLAkicmVzZXQtZHVyYXRpb24tdXMi
LA0KKwkJCQkmZGF0YS0+cmVzZXRfZHVyYXRpb25fdXMpOw0KKw0KIAlkYXRhLT5yY2Rldi5vcHMg
PSAmdGlfc3lzY29uX3Jlc2V0X29wczsNCiAJZGF0YS0+cmNkZXYub3duZXIgPSBUSElTX01PRFVM
RTsNCiAJZGF0YS0+cmNkZXYub2Zfbm9kZSA9IG5wOw0KLS0gDQoyLjE4LjANCg==

