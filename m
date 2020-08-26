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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1881DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D864F2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EMLRIUB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHZGWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:22:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33843 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgHZGWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:22:50 -0400
X-UUID: 3d906c26148845369c5ba3fc48e774f0-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GIkhKgz7Elf9zu2USBbkj5bdyXwJ9NQ0IBkBTXI6x1k=;
        b=EMLRIUB3+W2rhkoNq652bxCof4cmA8Zfh9NWX9dM15wlJ9aKZJvGegwwY7tIP5deJLja9DF2clyEI4pl2jmtoC2sXBSMEDeyTrErRSR04a19v2h192nW6ce3+oqGVjiqnC52P3wALOoAhBBV7JUJcjTn5gHyvnGaciju+G8ZSXo=;
X-UUID: 3d906c26148845369c5ba3fc48e774f0-20200826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chih-en.hsu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2022027483; Wed, 26 Aug 2020 14:22:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 14:22:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 14:22:45 +0800
From:   Chih-En Hsu <chih-en.hsu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Andrew-CT.Chen@mediatek.com>, <Michael.Mei@mediatek.com>,
        Chih-En Hsu <chih-en.hsu@mediatek.com>
Subject: [PATCH v2] nvmem: mtk-efuse: Remove EFUSE register write support
Date:   Wed, 26 Aug 2020 14:21:50 +0800
Message-ID: <20200826062148.27293-1-chih-en.hsu@mediatek.com>
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
Zm9yIE5WTUVNIGNvbnN1bWVycy4NCg0KRml4ZXM6IDRjN2U0ZmUzNzc2NiAoIm52bWVtOiBtZWRp
YXRlazogQWRkIE1lZGlhdGVrIEVGVVNFIGRyaXZlciIpDQpTaWduZWQtb2ZmLWJ5OiBDaGloLUVu
IEhzdSA8Y2hpaC1lbi5oc3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9udm1lbS9tdGst
ZWZ1c2UuYyB8IDE0IC0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYyBiL2RyaXZlcnMv
bnZtZW0vbXRrLWVmdXNlLmMNCmluZGV4IDg1NmQ5YzNmYzM4ZS4uNmE1MzdkOTU5ZjE0IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYw0KKysrIGIvZHJpdmVycy9udm1lbS9t
dGstZWZ1c2UuYw0KQEAgLTI4LDE5ICsyOCw2IEBAIHN0YXRpYyBpbnQgbXRrX3JlZ19yZWFkKHZv
aWQgKmNvbnRleHQsDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgaW50IG10a19yZWdfd3Jp
dGUodm9pZCAqY29udGV4dCwNCi0JCQkgdW5zaWduZWQgaW50IHJlZywgdm9pZCAqX3ZhbCwgc2l6
ZV90IGJ5dGVzKQ0KLXsNCi0Jc3RydWN0IG10a19lZnVzZV9wcml2ICpwcml2ID0gY29udGV4dDsN
Ci0JdTMyICp2YWwgPSBfdmFsOw0KLQlpbnQgaSA9IDAsIHdvcmRzID0gYnl0ZXMgLyA0Ow0KLQ0K
LQl3aGlsZSAod29yZHMtLSkNCi0JCXdyaXRlbCgqdmFsKyssIHByaXYtPmJhc2UgKyByZWcgKyAo
aSsrICogNCkpOw0KLQ0KLQlyZXR1cm4gMDsNCi19DQotDQogc3RhdGljIGludCBtdGtfZWZ1c2Vf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQpAQCAtNjEsNyArNDgsNiBAQCBzdGF0aWMgaW50IG10a19lZnVz
ZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAllY29uZmlnLnN0cmlkZSA9
IDQ7DQogCWVjb25maWcud29yZF9zaXplID0gNDsNCiAJZWNvbmZpZy5yZWdfcmVhZCA9IG10a19y
ZWdfcmVhZDsNCi0JZWNvbmZpZy5yZWdfd3JpdGUgPSBtdGtfcmVnX3dyaXRlOw0KIAllY29uZmln
LnNpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQogCWVjb25maWcucHJpdiA9IHByaXY7DQogCWVj
b25maWcuZGV2ID0gZGV2Ow0KLS0gDQoyLjE4LjANCg==

