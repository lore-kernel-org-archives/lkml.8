Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04ED12078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cxBhGK5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHTGGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13121 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726852AbgHTGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:52 -0400
X-UUID: b756f09a9c244157af3ff069810e9104-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=81cl5lR8q9Xp2cMEda341JaElbb5a2VFUjfbX8XXRgM=;
        b=cxBhGK5O7qRZASx6HpHjPKVRm1kK7sxUoxnhMkLslim0cJK1Z2KUgGc6s3vNzz81WLqKsqqqLaipXrh4ygAyrWoFXyj1o2DSaJbamC+hmvk8yYims8+LU6WZNJcu7Iwih+JQe7vqoH5+wevJkp4/GAD+DRoPd1sakQO3WQ5/7I4=;
X-UUID: b756f09a9c244157af3ff069810e9104-20200820
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 357292008; Thu, 20 Aug 2020 14:05:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:47 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:46 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 15/21] drm/mediatek: add color bypass shadow register function
Date:   Thu, 20 Aug 2020 14:04:12 +0800
Message-ID: <1597903458-8055-16-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGNvbG9yIGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVuY3Rpb24NCg0KU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY29sb3IuYyB8IDE1ICsrKysrKysrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY29sb3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9jb2xvci5jDQppbmRleCAzMTkxOGZhLi44M2IwNzVhIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jb2xvci5jDQpAQCAtMTcsNiArMTcsOCBA
QA0KICNkZWZpbmUgRElTUF9DT0xPUl9DRkdfTUFJTgkJCTB4MDQwMA0KICNkZWZpbmUgRElTUF9D
T0xPUl9TVEFSVF9NVDI3MDEJCQkweDBmMDANCiAjZGVmaW5lIERJU1BfQ09MT1JfU1RBUlRfTVQ4
MTczCQkJMHgwYzAwDQorI2RlZmluZSBESVNQX0NPTE9SX1NIQURPV19DVFJMCQkJMHgwY2IwDQor
I2RlZmluZSBDT0xPUl9CWVBBU1NfU0hBRE9XCQkJCUJJVCgwKQ0KICNkZWZpbmUgRElTUF9DT0xP
Ul9TVEFSVChjb21wKQkJCSgoY29tcCktPmRhdGEtPmNvbG9yX29mZnNldCkNCiAjZGVmaW5lIERJ
U1BfQ09MT1JfV0lEVEgoY29tcCkJCQkoRElTUF9DT0xPUl9TVEFSVChjb21wKSArIDB4NTApDQog
I2RlZmluZSBESVNQX0NPTE9SX0hFSUdIVChjb21wKQkJCShESVNQX0NPTE9SX1NUQVJUKGNvbXAp
ICsgMHg1NCkNCkBAIC0yNiw2ICsyOCw3IEBADQogDQogc3RydWN0IG10a19kaXNwX2NvbG9yX2Rh
dGEgew0KIAl1bnNpZ25lZCBpbnQgY29sb3Jfb2Zmc2V0Ow0KKwlib29sIGhhc19zaGFkb3c7DQog
fTsNCiANCiAvKioNCkBAIC02Myw5ICs2NiwyMSBAQCBzdGF0aWMgdm9pZCBtdGtfY29sb3Jfc3Rh
cnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCiAJd3JpdGVsKDB4MSwgY29tcC0+cmVncyAr
IERJU1BfQ09MT1JfU1RBUlQoY29sb3IpKTsNCiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2NvbG9y
X2J5cGFzc19zaGFkb3coc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCit7DQorCXN0cnVjdCBt
dGtfZGlzcF9jb2xvciAqY29sb3IgPSBjb21wX3RvX2NvbG9yKGNvbXApOw0KKw0KKwlpZiAoY29s
b3ItPmRhdGEtPmhhc19zaGFkb3cpIHsNCisJCW10a19kZHBfd3JpdGVfbWFzayhOVUxMLCBDT0xP
Ul9CWVBBU1NfU0hBRE9XLCBjb21wLA0KKwkJCQkgICBESVNQX0NPTE9SX1NIQURPV19DVFJMLA0K
KwkJCQkgICBDT0xPUl9CWVBBU1NfU0hBRE9XKTsNCisJfQ0KK30NCisNCiBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBtdGtfZGlzcF9jb2xvcl9mdW5jcyA9IHsNCiAJLmNv
bmZpZyA9IG10a19jb2xvcl9jb25maWcsDQogCS5zdGFydCA9IG10a19jb2xvcl9zdGFydCwNCisJ
LmJ5cGFzc19zaGFkb3cgPSBtdGtfY29sb3JfYnlwYXNzX3NoYWRvdywNCiB9Ow0KIA0KIHN0YXRp
YyBpbnQgbXRrX2Rpc3BfY29sb3JfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2UgKm1hc3RlciwNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

