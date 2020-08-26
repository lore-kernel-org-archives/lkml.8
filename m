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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA278206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xs0VYNt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHZIkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:40:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18292 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727021AbgHZIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:40:42 -0400
X-UUID: a37b6cfbcb0140fb914aae1be120bc20-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+mnt8cOOUo/Gbs/M+1Kh1w8rzXbTxn9MCY3/8X/qpvE=;
        b=Xs0VYNt0V0zUDjnUH9uGH5EJhekD8H5pfyzPX/FojMUTFRnTdQsgO1qDNCX+RHE9AYqy5n7wr0JOgPr5xw7OicyRZTJaVMSkZdcJ0spJtSXGYLlCnjT8Twlh2FR/jsZPMkjlvslzyUuo6fusEBrxYuox4Y7tPPOFo7cg/fkq/+c=;
X-UUID: a37b6cfbcb0140fb914aae1be120bc20-20200826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chih-en.hsu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1334441339; Wed, 26 Aug 2020 16:40:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:40:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 16:40:29 +0800
From:   Chih-En Hsu <chih-en.hsu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Andrew-CT.Chen@mediatek.com>, <Michael.Mei@mediatek.com>,
        Chih-En Hsu <chih-en.hsu@mediatek.com>
Subject: [PATCH v3] nvmem: mtk-efuse: Remove EFUSE register write support
Date:   Wed, 26 Aug 2020 16:39:45 +0800
Message-ID: <20200826083943.810-1-chih-en.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBpcyB0byByZW1vdmUgZnVuY3Rpb24gIm10a19yZWdfd3JpdGUiIHNpbmNlDQpN
ZWRpYXRlayBFRlVTRSBoYXJkd2FyZSBvbmx5IHN1cHBvcnRzIHJlYWQgZnVuY3Rpb25hbGl0eQ0K
Zm9yIE5WTUVNIGNvbnN1bWVycy4NCg0KRml4ZXM6IGJhMzYwZmQwNDBlMyAoIm52bWVtOiBtdGst
ZWZ1c2U6IHJlbW92ZSBudm1lbSByZWdtYXAgZGVwZW5kZW5jeSIpDQpTaWduZWQtb2ZmLWJ5OiBD
aGloLUVuIEhzdSA8Y2hpaC1lbi5oc3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9udm1l
bS9tdGstZWZ1c2UuYyB8IDE0IC0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYyBiL2Ry
aXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMNCmluZGV4IDg1NmQ5YzNmYzM4ZS4uNmE1MzdkOTU5ZjE0
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYw0KKysrIGIvZHJpdmVycy9u
dm1lbS9tdGstZWZ1c2UuYw0KQEAgLTI4LDE5ICsyOCw2IEBAIHN0YXRpYyBpbnQgbXRrX3JlZ19y
ZWFkKHZvaWQgKmNvbnRleHQsDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgaW50IG10a19y
ZWdfd3JpdGUodm9pZCAqY29udGV4dCwNCi0JCQkgdW5zaWduZWQgaW50IHJlZywgdm9pZCAqX3Zh
bCwgc2l6ZV90IGJ5dGVzKQ0KLXsNCi0Jc3RydWN0IG10a19lZnVzZV9wcml2ICpwcml2ID0gY29u
dGV4dDsNCi0JdTMyICp2YWwgPSBfdmFsOw0KLQlpbnQgaSA9IDAsIHdvcmRzID0gYnl0ZXMgLyA0
Ow0KLQ0KLQl3aGlsZSAod29yZHMtLSkNCi0JCXdyaXRlbCgqdmFsKyssIHByaXYtPmJhc2UgKyBy
ZWcgKyAoaSsrICogNCkpOw0KLQ0KLQlyZXR1cm4gMDsNCi19DQotDQogc3RhdGljIGludCBtdGtf
ZWZ1c2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQpAQCAtNjEsNyArNDgsNiBAQCBzdGF0aWMgaW50IG10
a19lZnVzZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAllY29uZmlnLnN0
cmlkZSA9IDQ7DQogCWVjb25maWcud29yZF9zaXplID0gNDsNCiAJZWNvbmZpZy5yZWdfcmVhZCA9
IG10a19yZWdfcmVhZDsNCi0JZWNvbmZpZy5yZWdfd3JpdGUgPSBtdGtfcmVnX3dyaXRlOw0KIAll
Y29uZmlnLnNpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQogCWVjb25maWcucHJpdiA9IHByaXY7
DQogCWVjb25maWcuZGV2ID0gZGV2Ow0KLS0gDQoyLjE4LjANCg==

