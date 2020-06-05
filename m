Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900CD2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cXcIEIsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgFEJ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:56:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11769 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726243AbgFEJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:55:59 -0400
X-UUID: 03a96d29eece400781d4f1ede98062e7-20200605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0zI7CVoALCkpFWkgGGj1AbfVE36QPtMcgdNgl75YRMo=;
        b=cXcIEIsqrnB6Rr8oAwIuCJtu9hryZbshnsvBjGe5LPrLEVJ5WKnWdHRo1GMetj2b/dFjP4QeLCJMvQwkRaOWCnPFWlG8GHdU13iB4Rf0g1LPyVj0hoJmf384UyBvgMQLojAQNfP/4y5fly96WiXnR9xMl9wHpJwgL77GSusvuWM=;
X-UUID: 03a96d29eece400781d4f1ede98062e7-20200605
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 9677772; Fri, 05 Jun 2020 17:55:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Jun 2020 17:55:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Jun 2020 17:55:50 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <matthias.bgg@gmail.com>, <hariprasad.kelam@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v2, 1/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
Date:   Fri, 5 Jun 2020 17:53:44 +0800
Message-ID: <1591350825-18152-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 069F9BBDD4B821B89F92B59CD0BC2631142D0F22892B0205B49D61B390E5C21F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VwcG9ydHMgRE1JQyBvbmUtd2lyZSBtb2RlLiBVc2VzIGEgRFQgcHJvcGVydHkgImRtaWMtbW9k
ZSIgdG8gc2VsZWN0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKaWF4aW4gWXUgPGppYXhpbi55dUBtZWRp
YXRlay5jb20+DQotLS0NCiBzb3VuZC9zb2MvY29kZWNzL210NjM1OC5jIHwgMjMgKysrKysrKysr
KysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9tdDYzNTguYyBiL3NvdW5k
L3NvYy9jb2RlY3MvbXQ2MzU4LmMNCmluZGV4IDFiODMwZWEuLjFmMzlkNTkgMTAwNjQ0DQotLS0g
YS9zb3VuZC9zb2MvY29kZWNzL210NjM1OC5jDQorKysgYi9zb3VuZC9zb2MvY29kZWNzL210NjM1
OC5jDQpAQCAtOTUsNiArOTUsOCBAQCBzdHJ1Y3QgbXQ2MzU4X3ByaXYgew0KIAlzdHJ1Y3QgcmVn
dWxhdG9yICphdmRkX3JlZzsNCiANCiAJaW50IHdvdl9lbmFibGVkOw0KKw0KKwl1bnNpZ25lZCBp
bnQgZG1pY19vbmVfd2lyZV9tb2RlOw0KIH07DQogDQogaW50IG10NjM1OF9zZXRfbXRrYWlmX3By
b3RvY29sKHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY21wbnQsDQpAQCAtMTgzMSw3ICsxODMz
LDEwIEBAIHN0YXRpYyBpbnQgbXQ2MzU4X2RtaWNfZW5hYmxlKHN0cnVjdCBtdDYzNThfcHJpdiAq
cHJpdikNCiAJbXQ2MzU4X210a2FpZl90eF9lbmFibGUocHJpdik7DQogDQogCS8qIFVMIGRtaWMg
c2V0dGluZyAqLw0KLQlyZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBNVDYzNThfQUZFX1VMX1NS
Q19DT04wX0gsIDB4MDA4MCk7DQorCWlmIChwcml2LT5kbWljX29uZV93aXJlX21vZGUpDQorCQly
ZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBNVDYzNThfQUZFX1VMX1NSQ19DT04wX0gsIDB4MDQw
MCk7DQorCWVsc2UNCisJCXJlZ21hcF93cml0ZShwcml2LT5yZWdtYXAsIE1UNjM1OF9BRkVfVUxf
U1JDX0NPTjBfSCwgMHgwMDgwKTsNCiANCiAJLyogVUwgdHVybiBvbiAqLw0KIAlyZWdtYXBfd3Jp
dGUocHJpdi0+cmVnbWFwLCBNVDYzNThfQUZFX1VMX1NSQ19DT04wX0wsIDB4MDAwMyk7DQpAQCAt
MjQyNiw2ICsyNDMxLDIwIEBAIHN0YXRpYyBpbnQgbXQ2MzU4X2NvZGVjX3Byb2JlKHN0cnVjdCBz
bmRfc29jX2NvbXBvbmVudCAqY21wbnQpDQogCS5udW1fZGFwbV9yb3V0ZXMgPSBBUlJBWV9TSVpF
KG10NjM1OF9kYXBtX3JvdXRlcyksDQogfTsNCiANCitzdGF0aWMgdm9pZCBtdDYzNThfcGFyc2Vf
ZHQoc3RydWN0IG10NjM1OF9wcml2ICpwcml2KQ0KK3sNCisJaW50IHJldDsNCisJc3RydWN0IGRl
dmljZSAqZGV2ID0gcHJpdi0+ZGV2Ow0KKw0KKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihk
ZXYtPm9mX25vZGUsICJtZWRpYXRlayxkbWljLW1vZGUiLA0KKwkJCQkgICAmcHJpdi0+ZG1pY19v
bmVfd2lyZV9tb2RlKTsNCisJaWYgKHJldCkgew0KKwkJZGV2X3dhcm4ocHJpdi0+ZGV2LCAiJXMo
KSBmYWlsZWQgdG8gcmVhZCBkbWljLW1vZGVcbiIsDQorCQkJIF9fZnVuY19fKTsNCisJCXByaXYt
PmRtaWNfb25lX3dpcmVfbW9kZSA9IDA7DQorCX0NCit9DQorDQogc3RhdGljIGludCBtdDYzNThf
cGxhdGZvcm1fZHJpdmVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0K
IAlzdHJ1Y3QgbXQ2MzU4X3ByaXYgKnByaXY7DQpAQCAtMjQ0NSw2ICsyNDY0LDggQEAgc3RhdGlj
IGludCBtdDYzNThfcGxhdGZvcm1fZHJpdmVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogCWlmIChJU19FUlIocHJpdi0+cmVnbWFwKSkNCiAJCXJldHVybiBQVFJfRVJSKHBy
aXYtPnJlZ21hcCk7DQogDQorCW10NjM1OF9wYXJzZV9kdChwcml2KTsNCisNCiAJZGV2X2luZm8o
cHJpdi0+ZGV2LCAiJXMoKSwgZGV2IG5hbWUgJXNcbiIsDQogCQkgX19mdW5jX18sIGRldl9uYW1l
KCZwZGV2LT5kZXYpKTsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

