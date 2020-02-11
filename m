Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D46C352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707502080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H5llIGAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgBKDW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:22:28 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37002 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727697AbgBKDW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:22:27 -0500
X-UUID: bdf61638c71449f5908812329f70ec33-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tEOggtQy/EqJpYQ2IFx+sKkfNPiyND9IStXrZG2iXWs=;
        b=H5llIGAv67raMfkwMq5UMAw6MIQdqb4KtxguQq9j/UsxVDlx7qNnUb+EQcckYRrKA0sJs7Eu+qbwGG6bV1Xky1+Hv3E3ArujG/SCIz/0TTxXqz+F5b8mFu/83lB1t0gtBrOcSMVylUrhXl8/UxgoSv2XgsTshs3oLpnMYy2p1DI=;
X-UUID: bdf61638c71449f5908812329f70ec33-20200211
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1554577059; Tue, 11 Feb 2020 11:21:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:21:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 07/11] phy: phy-mtk-tphy: add a property for internal resistance
Date:   Tue, 11 Feb 2020 11:21:12 +0800
Message-ID: <077d27de8b6afaaf5bd361c53cf164d2eac6458a.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
References: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AB692E99B080603309F355FDAECC1BFE60E5CACC20141590B85034F86DE9E8012000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIHR1bmUgSi1LIHZvbHRhZ2UgYnkgaW50ZXJuYWwgUiAocmVzaXN0YW5j
ZSksIHRoZQ0KcmFuZ2UgaXMgWzAsIDMxXSwgdGhlIHJlc2lzdGFuY2UgdmFsdWUgaXMgYWJvdXQg
Ni45SyBvaG0gZm9yIDAsDQozLjhLIG9obSBmb3IgMzEsIGFuZCB0aGUgc3RlcCBpcyAxSyBvaG0N
Cg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29t
Pg0KLS0tDQp2NTogbm8gY2hhbmdlcw0KDQp2NDogY2hhbmdlIGNvbW1pdCBsb2cNCg0KdjM6IGNo
YW5nZSBjb21taXQgbG9nDQoNCnYyOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2ZXJzL3BoeS9tZWRp
YXRlay9waHktbXRrLXRwaHkuYyB8IDE2ICsrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5
LW10ay10cGh5LmMNCmluZGV4IDVhZmUzMzYyMWRiYy4uNGEyZGM5MmYxMGY1IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCisrKyBiL2RyaXZlcnMvcGh5
L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQpAQCAtNDMsNiArNDMsOCBAQA0KICNkZWZpbmUgUEEw
X1JHX1VTQjIwX0lOVFJfRU4JCUJJVCg1KQ0KIA0KICNkZWZpbmUgVTNQX1VTQlBIWUFDUjEJCTB4
MDA0DQorI2RlZmluZSBQQTFfUkdfSU5UUl9DQUwJCUdFTk1BU0soMjMsIDE5KQ0KKyNkZWZpbmUg
UEExX1JHX0lOVFJfQ0FMX1ZBTCh4KQkoKDB4MWYgJiAoeCkpIDw8IDE5KQ0KICNkZWZpbmUgUEEx
X1JHX1ZSVF9TRUwJCQlHRU5NQVNLKDE0LCAxMikNCiAjZGVmaW5lIFBBMV9SR19WUlRfU0VMX1ZB
TCh4KQkoKDB4NyAmICh4KSkgPDwgMTIpDQogI2RlZmluZSBQQTFfUkdfVEVSTV9TRUwJCUdFTk1B
U0soMTAsIDgpDQpAQCAtMzAyLDYgKzMwNCw3IEBAIHN0cnVjdCBtdGtfcGh5X2luc3RhbmNlIHsN
CiAJaW50IGV5ZV9zcmM7DQogCWludCBleWVfdnJ0Ow0KIAlpbnQgZXllX3Rlcm07DQorCWludCBp
bnRyOw0KIAlpbnQgZGlzY3RoOw0KIAlib29sIGJjMTJfZW47DQogfTsNCkBAIC04NTMsMTIgKzg1
NiwxNCBAQCBzdGF0aWMgdm9pZCBwaHlfcGFyc2VfcHJvcGVydHkoc3RydWN0IG10a190cGh5ICp0
cGh5LA0KIAkJCQkgJmluc3RhbmNlLT5leWVfdnJ0KTsNCiAJZGV2aWNlX3Byb3BlcnR5X3JlYWRf
dTMyKGRldiwgIm1lZGlhdGVrLGV5ZS10ZXJtIiwNCiAJCQkJICZpbnN0YW5jZS0+ZXllX3Rlcm0p
Ow0KKwlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAibWVkaWF0ZWssaW50ciIsDQorCQkJ
CSAmaW5zdGFuY2UtPmludHIpOw0KIAlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAibWVk
aWF0ZWssZGlzY3RoIiwNCiAJCQkJICZpbnN0YW5jZS0+ZGlzY3RoKTsNCi0JZGV2X2RiZyhkZXYs
ICJiYzEyOiVkLCBzcmM6JWQsIHZydDolZCwgdGVybTolZCwgZGlzYzolZFxuIiwNCisJZGV2X2Ri
ZyhkZXYsICJiYzEyOiVkLCBzcmM6JWQsIHZydDolZCwgdGVybTolZCwgaW50cjolZCwgZGlzYzol
ZFxuIiwNCiAJCWluc3RhbmNlLT5iYzEyX2VuLCBpbnN0YW5jZS0+ZXllX3NyYywNCiAJCWluc3Rh
bmNlLT5leWVfdnJ0LCBpbnN0YW5jZS0+ZXllX3Rlcm0sDQotCQlpbnN0YW5jZS0+ZGlzY3RoKTsN
CisJCWluc3RhbmNlLT5pbnRyLCBpbnN0YW5jZS0+ZGlzY3RoKTsNCiB9DQogDQogc3RhdGljIHZv
aWQgdTJfcGh5X3Byb3BzX3NldChzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksDQpAQCAtODk1LDYgKzkw
MCwxMyBAQCBzdGF0aWMgdm9pZCB1Ml9waHlfcHJvcHNfc2V0KHN0cnVjdCBtdGtfdHBoeSAqdHBo
eSwNCiAJCXdyaXRlbCh0bXAsIGNvbSArIFUzUF9VU0JQSFlBQ1IxKTsNCiAJfQ0KIA0KKwlpZiAo
aW5zdGFuY2UtPmludHIpIHsNCisJCXRtcCA9IHJlYWRsKGNvbSArIFUzUF9VU0JQSFlBQ1IxKTsN
CisJCXRtcCAmPSB+UEExX1JHX0lOVFJfQ0FMOw0KKwkJdG1wIHw9IFBBMV9SR19JTlRSX0NBTF9W
QUwoaW5zdGFuY2UtPmludHIpOw0KKwkJd3JpdGVsKHRtcCwgY29tICsgVTNQX1VTQlBIWUFDUjEp
Ow0KKwl9DQorDQogCWlmIChpbnN0YW5jZS0+ZGlzY3RoKSB7DQogCQl0bXAgPSByZWFkbChjb20g
KyBVM1BfVVNCUEhZQUNSNik7DQogCQl0bXAgJj0gflBBNl9SR19VMl9ESVNDVEg7DQotLSANCjIu
MjUuMA0K

