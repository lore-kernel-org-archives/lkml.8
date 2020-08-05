Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257F6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BE522B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YXy8/EmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgHEUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:13:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726778AbgHEQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
X-UUID: 6c99506808a94693880c95551ac8f399-20200805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JXjGlkK/YIWf9M/m8rQeaHnLeFDyiE8gIxUc5tlncsU=;
        b=YXy8/EmRpseEQohslA8ZYPUMskFBa/FlYEWQ4fVzp2cpgJMVKCWfLvBLVVjn6C6vE2PmUyerT7NbvCWH8dEkM/xj2og+Ru1jqPhOfEVB5dOzCFOgRgnbyoT3ZYM6l8/TekRcl3ZjRvkxSG+5eUEiytm5AcFdnDmYFMG4l+JpjRc=;
X-UUID: 6c99506808a94693880c95551ac8f399-20200805
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1347454479; Wed, 05 Aug 2020 18:53:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 5 Aug 2020 18:53:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 5 Aug 2020 18:53:17 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <robh+dt@kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <qii.wang@mediatek.com>
Subject: [PATCH v3 1/4] i2c: mediatek: Add apdma sync in i2c driver
Date:   Wed, 5 Aug 2020 18:52:19 +0800
Message-ID: <1596624742-14727-2-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1596624742-14727-1-git-send-email-qii.wang@mediatek.com>
References: <1596624742-14727-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCB0aGUgYXBkbWEgcmVtb3ZlIGhhbmQtc2hha2Ugc2lnbmFsLCBpdCBuZWVkIHRvIGtlZXAg
aTJjIGFuZA0KYXBkbWEgaW4gc3luYyBtYW51YWxseS4NCg0KUmV2aWV3ZWQtYnk6IFlpbmdqb2Ug
Q2hlbiA8eWluZ2pvZS5jaGVuQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBNYXR0aGlhcyBC
cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogUWlpIFdhbmcg
PHFpaS53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXQ2
NXh4LmMgfCAyMyArKysrKysrKysrKysrKysrKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1tdDY1eHguYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXQ2NXh4LmMNCmlu
ZGV4IGRlZWY2OWUuLmU2Yjk4NGEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LW10NjV4eC5jDQorKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW10NjV4eC5jDQpAQCAtNDgs
NiArNDgsOSBAQA0KIA0KICNkZWZpbmUgSTJDX0RNQV9DT05fVFgJCQkweDAwMDANCiAjZGVmaW5l
IEkyQ19ETUFfQ09OX1JYCQkJMHgwMDAxDQorI2RlZmluZSBJMkNfRE1BX0FTWU5DX01PREUJCTB4
MDAwNA0KKyNkZWZpbmUgSTJDX0RNQV9TS0lQX0NPTkZJRwkJMHgwMDEwDQorI2RlZmluZSBJMkNf
RE1BX0RJUl9DSEFOR0UJCTB4MDIwMA0KICNkZWZpbmUgSTJDX0RNQV9TVEFSVF9FTgkJMHgwMDAx
DQogI2RlZmluZSBJMkNfRE1BX0lOVF9GTEFHX05PTkUJCTB4MDAwMA0KICNkZWZpbmUgSTJDX0RN
QV9DTFJfRkxBRwkJMHgwMDAwDQpAQCAtMjA1LDYgKzIwOCw3IEBAIHN0cnVjdCBtdGtfaTJjX2Nv
bXBhdGlibGUgew0KIAl1bnNpZ25lZCBjaGFyIHRpbWluZ19hZGp1c3Q6IDE7DQogCXVuc2lnbmVk
IGNoYXIgZG1hX3N5bmM6IDE7DQogCXVuc2lnbmVkIGNoYXIgbHRpbWluZ19hZGp1c3Q6IDE7DQor
CXVuc2lnbmVkIGNoYXIgYXBkbWFfc3luYzogMTsNCiB9Ow0KIA0KIHN0cnVjdCBtdGtfaTJjX2Fj
X3RpbWluZyB7DQpAQCAtMzExLDYgKzMxNSw3IEBAIHN0cnVjdCBpMmNfc3BlY192YWx1ZXMgew0K
IAkudGltaW5nX2FkanVzdCA9IDEsDQogCS5kbWFfc3luYyA9IDAsDQogCS5sdGltaW5nX2FkanVz
dCA9IDAsDQorCS5hcGRtYV9zeW5jID0gMCwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2kyY19jb21wYXRpYmxlIG10NjU3N19jb21wYXQgPSB7DQpAQCAtMzI0LDYgKzMyOSw3IEBA
IHN0cnVjdCBpMmNfc3BlY192YWx1ZXMgew0KIAkudGltaW5nX2FkanVzdCA9IDAsDQogCS5kbWFf
c3luYyA9IDAsDQogCS5sdGltaW5nX2FkanVzdCA9IDAsDQorCS5hcGRtYV9zeW5jID0gMCwNCiB9
Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2kyY19jb21wYXRpYmxlIG10NjU4OV9jb21w
YXQgPSB7DQpAQCAtMzM3LDYgKzM0Myw3IEBAIHN0cnVjdCBpMmNfc3BlY192YWx1ZXMgew0KIAku
dGltaW5nX2FkanVzdCA9IDAsDQogCS5kbWFfc3luYyA9IDAsDQogCS5sdGltaW5nX2FkanVzdCA9
IDAsDQorCS5hcGRtYV9zeW5jID0gMCwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2kyY19jb21wYXRpYmxlIG10NzYyMl9jb21wYXQgPSB7DQpAQCAtMzUwLDYgKzM1Nyw3IEBAIHN0
cnVjdCBpMmNfc3BlY192YWx1ZXMgew0KIAkudGltaW5nX2FkanVzdCA9IDAsDQogCS5kbWFfc3lu
YyA9IDAsDQogCS5sdGltaW5nX2FkanVzdCA9IDAsDQorCS5hcGRtYV9zeW5jID0gMCwNCiB9Ow0K
IA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2kyY19jb21wYXRpYmxlIG10ODE3M19jb21wYXQg
PSB7DQpAQCAtMzYyLDYgKzM3MCw3IEBAIHN0cnVjdCBpMmNfc3BlY192YWx1ZXMgew0KIAkudGlt
aW5nX2FkanVzdCA9IDAsDQogCS5kbWFfc3luYyA9IDAsDQogCS5sdGltaW5nX2FkanVzdCA9IDAs
DQorCS5hcGRtYV9zeW5jID0gMCwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2ky
Y19jb21wYXRpYmxlIG10ODE4M19jb21wYXQgPSB7DQpAQCAtMzc1LDYgKzM4NCw3IEBAIHN0cnVj
dCBpMmNfc3BlY192YWx1ZXMgew0KIAkudGltaW5nX2FkanVzdCA9IDEsDQogCS5kbWFfc3luYyA9
IDEsDQogCS5sdGltaW5nX2FkanVzdCA9IDEsDQorCS5hcGRtYV9zeW5jID0gMCwNCiB9Ow0KIA0K
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19pMmNfb2ZfbWF0Y2hbXSA9IHsN
CkBAIC03OTgsNiArODA4LDcgQEAgc3RhdGljIGludCBtdGtfaTJjX2RvX3RyYW5zZmVyKHN0cnVj
dCBtdGtfaTJjICppMmMsIHN0cnVjdCBpMmNfbXNnICptc2dzLA0KIAl1MTYgc3RhcnRfcmVnOw0K
IAl1MTYgY29udHJvbF9yZWc7DQogCXUxNiByZXN0YXJ0X2ZsYWcgPSAwOw0KKwl1MTYgZG1hX3N5
bmMgPSAwOw0KIAl1MzIgcmVnXzRnX21vZGU7DQogCXU4ICpkbWFfcmRfYnVmID0gTlVMTDsNCiAJ
dTggKmRtYV93cl9idWYgPSBOVUxMOw0KQEAgLTg1MSwxMCArODYyLDE2IEBAIHN0YXRpYyBpbnQg
bXRrX2kyY19kb190cmFuc2ZlcihzdHJ1Y3QgbXRrX2kyYyAqaTJjLCBzdHJ1Y3QgaTJjX21zZyAq
bXNncywNCiAJCW10a19pMmNfd3JpdGV3KGkyYywgbnVtLCBPRkZTRVRfVFJBTlNBQ19MRU4pOw0K
IAl9DQogDQorCWlmIChpMmMtPmRldl9jb21wLT5hcGRtYV9zeW5jKSB7DQorCQlkbWFfc3luYyA9
IEkyQ19ETUFfU0tJUF9DT05GSUcgfCBJMkNfRE1BX0FTWU5DX01PREU7DQorCQlpZiAoaTJjLT5v
cCA9PSBJMkNfTUFTVEVSX1dSUkQpDQorCQkJZG1hX3N5bmMgfD0gSTJDX0RNQV9ESVJfQ0hBTkdF
Ow0KKwl9DQorDQogCS8qIFByZXBhcmUgYnVmZmVyIGRhdGEgdG8gc3RhcnQgdHJhbnNmZXIgKi8N
CiAJaWYgKGkyYy0+b3AgPT0gSTJDX01BU1RFUl9SRCkgew0KIAkJd3JpdGVsKEkyQ19ETUFfSU5U
X0ZMQUdfTk9ORSwgaTJjLT5wZG1hYmFzZSArIE9GRlNFVF9JTlRfRkxBRyk7DQotCQl3cml0ZWwo
STJDX0RNQV9DT05fUlgsIGkyYy0+cGRtYWJhc2UgKyBPRkZTRVRfQ09OKTsNCisJCXdyaXRlbChJ
MkNfRE1BX0NPTl9SWCB8IGRtYV9zeW5jLCBpMmMtPnBkbWFiYXNlICsgT0ZGU0VUX0NPTik7DQog
DQogCQlkbWFfcmRfYnVmID0gaTJjX2dldF9kbWFfc2FmZV9tc2dfYnVmKG1zZ3MsIDEpOw0KIAkJ
aWYgKCFkbWFfcmRfYnVmKQ0KQEAgLTg3Nyw3ICs4OTQsNyBAQCBzdGF0aWMgaW50IG10a19pMmNf
ZG9fdHJhbnNmZXIoc3RydWN0IG10a19pMmMgKmkyYywgc3RydWN0IGkyY19tc2cgKm1zZ3MsDQog
CQl3cml0ZWwobXNncy0+bGVuLCBpMmMtPnBkbWFiYXNlICsgT0ZGU0VUX1JYX0xFTik7DQogCX0g
ZWxzZSBpZiAoaTJjLT5vcCA9PSBJMkNfTUFTVEVSX1dSKSB7DQogCQl3cml0ZWwoSTJDX0RNQV9J
TlRfRkxBR19OT05FLCBpMmMtPnBkbWFiYXNlICsgT0ZGU0VUX0lOVF9GTEFHKTsNCi0JCXdyaXRl
bChJMkNfRE1BX0NPTl9UWCwgaTJjLT5wZG1hYmFzZSArIE9GRlNFVF9DT04pOw0KKwkJd3JpdGVs
KEkyQ19ETUFfQ09OX1RYIHwgZG1hX3N5bmMsIGkyYy0+cGRtYWJhc2UgKyBPRkZTRVRfQ09OKTsN
CiANCiAJCWRtYV93cl9idWYgPSBpMmNfZ2V0X2RtYV9zYWZlX21zZ19idWYobXNncywgMSk7DQog
CQlpZiAoIWRtYV93cl9idWYpDQpAQCAtOTAwLDcgKzkxNyw3IEBAIHN0YXRpYyBpbnQgbXRrX2ky
Y19kb190cmFuc2ZlcihzdHJ1Y3QgbXRrX2kyYyAqaTJjLCBzdHJ1Y3QgaTJjX21zZyAqbXNncywN
CiAJCXdyaXRlbChtc2dzLT5sZW4sIGkyYy0+cGRtYWJhc2UgKyBPRkZTRVRfVFhfTEVOKTsNCiAJ
fSBlbHNlIHsNCiAJCXdyaXRlbChJMkNfRE1BX0NMUl9GTEFHLCBpMmMtPnBkbWFiYXNlICsgT0ZG
U0VUX0lOVF9GTEFHKTsNCi0JCXdyaXRlbChJMkNfRE1BX0NMUl9GTEFHLCBpMmMtPnBkbWFiYXNl
ICsgT0ZGU0VUX0NPTik7DQorCQl3cml0ZWwoSTJDX0RNQV9DTFJfRkxBRyB8IGRtYV9zeW5jLCBp
MmMtPnBkbWFiYXNlICsgT0ZGU0VUX0NPTik7DQogDQogCQlkbWFfd3JfYnVmID0gaTJjX2dldF9k
bWFfc2FmZV9tc2dfYnVmKG1zZ3MsIDEpOw0KIAkJaWYgKCFkbWFfd3JfYnVmKQ0KLS0gDQoxLjku
MQ0K

