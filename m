Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA8AC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A715020792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q4OJbjt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgG0HRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:17:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52175 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727047AbgG0HQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:45 -0400
X-UUID: 69d17728301a4f0fa7c2c995c1c0a018-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IOySdoF/dmmR5ME5Xkb3uJOwAvtUS4UDWtTsJzmoSt8=;
        b=q4OJbjt1MLYxwuBe+Ssk8MHXyRHATHDvsNnC/fAXHwkRHdjNFi1hicroGvKvrX4OcIti8NsVwYuDj9BdOBX0ZXHOR6r2AofYP4fqErsTgII/r9B8ph4d2V1+h/umDPp5S+IlbtPgU4gzhvI3Rg1iKd+A01ZRZDz7+Wh3FIQkJPU=;
X-UUID: 69d17728301a4f0fa7c2c995c1c0a018-20200727
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1383872797; Mon, 27 Jul 2020 15:16:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:39 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 08/11] usb: mtu3: remove useless member @busy in mtu3_ep struct
Date:   Mon, 27 Jul 2020 15:14:57 +0800
Message-ID: <1595834101-13094-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1lbWJlciBAYnVzeSBpbiBtdHUzX2VwIHN0cnVjdCBpcyB1bm5lY2Vzc2FyeSwgc28gcmVt
b3ZlIGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9tdHUzL210dTMuaCAgICAgICAgfCAxIC0NCiBk
cml2ZXJzL3VzYi9tdHUzL210dTNfZ2FkZ2V0LmMgfCA2IC0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMvbXR1My5o
IGIvZHJpdmVycy91c2IvbXR1My9tdHUzLmgNCmluZGV4IDlkNjhmMjUuLjhmZDgzYmQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3VzYi9tdHUzL210dTMuaA0KKysrIGIvZHJpdmVycy91c2IvbXR1My9t
dHUzLmgNCkBAIC0yOTQsNyArMjk0LDYgQEAgc3RydWN0IG10dTNfZXAgew0KIA0KIAlpbnQgZmxh
Z3M7DQogCXU4IHdlZGdlZDsNCi0JdTggYnVzeTsNCiB9Ow0KIA0KIHN0cnVjdCBtdHUzX3JlcXVl
c3Qgew0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYyBiL2RyaXZl
cnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0KaW5kZXggMmJjOWE5NS4uZWY5ZmNkNSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2Iv
bXR1My9tdHUzX2dhZGdldC5jDQpAQCAtMTcsNyArMTcsNiBAQCB2b2lkIG10dTNfcmVxX2NvbXBs
ZXRlKHN0cnVjdCBtdHUzX2VwICptZXAsDQogew0KIAlzdHJ1Y3QgbXR1M19yZXF1ZXN0ICptcmVx
Ow0KIAlzdHJ1Y3QgbXR1MyAqbXR1Ow0KLQlpbnQgYnVzeSA9IG1lcC0+YnVzeTsNCiANCiAJbXJl
cSA9IHRvX210dTNfcmVxdWVzdChyZXEpOw0KIAlsaXN0X2RlbCgmbXJlcS0+bGlzdCk7DQpAQCAt
MjUsOCArMjQsNiBAQCB2b2lkIG10dTNfcmVxX2NvbXBsZXRlKHN0cnVjdCBtdHUzX2VwICptZXAs
DQogCQltcmVxLT5yZXF1ZXN0LnN0YXR1cyA9IHN0YXR1czsNCiANCiAJbXR1ID0gbXJlcS0+bXR1
Ow0KLQltZXAtPmJ1c3kgPSAxOw0KLQ0KIAl0cmFjZV9tdHUzX3JlcV9jb21wbGV0ZShtcmVxKTsN
CiAJc3Bpbl91bmxvY2soJm10dS0+bG9jayk7DQogDQpAQCAtNDAsMTQgKzM3LDEyIEBAIHZvaWQg
bXR1M19yZXFfY29tcGxldGUoc3RydWN0IG10dTNfZXAgKm1lcCwNCiAJdXNiX2dhZGdldF9naXZl
YmFja19yZXF1ZXN0KCZtZXAtPmVwLCAmbXJlcS0+cmVxdWVzdCk7DQogDQogCXNwaW5fbG9jaygm
bXR1LT5sb2NrKTsNCi0JbWVwLT5idXN5ID0gYnVzeTsNCiB9DQogDQogc3RhdGljIHZvaWQgbnVr
ZShzdHJ1Y3QgbXR1M19lcCAqbWVwLCBjb25zdCBpbnQgc3RhdHVzKQ0KIHsNCiAJc3RydWN0IG10
dTNfcmVxdWVzdCAqbXJlcSA9IE5VTEw7DQogDQotCW1lcC0+YnVzeSA9IDE7DQogCWlmIChsaXN0
X2VtcHR5KCZtZXAtPnJlcV9saXN0KSkNCiAJCXJldHVybjsNCiANCkBAIC0xOTUsNyArMTkwLDYg
QEAgc3RhdGljIGludCBtdHUzX2dhZGdldF9lcF9lbmFibGUoc3RydWN0IHVzYl9lcCAqZXAsDQog
CWlmIChyZXQpDQogCQlnb3RvIGVycm9yOw0KIA0KLQltZXAtPmJ1c3kgPSAwOw0KIAltZXAtPndl
ZGdlZCA9IDA7DQogCW1lcC0+ZmxhZ3MgfD0gTVRVM19FUF9FTkFCTEVEOw0KIAltdHUtPmFjdGl2
ZV9lcCsrOw0KLS0gDQoxLjkuMQ0K

