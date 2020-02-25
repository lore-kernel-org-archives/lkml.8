Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D8C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D8324676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R8XRv+fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgBYLrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:47:55 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:59945 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:47:53 -0500
X-UUID: 9bb78951937b4b45aeef237ee2988633-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XdO6DxCLv2eqDKtcLSh5mOGePmSad4AJHFN1yrqNlXg=;
        b=R8XRv+fMDzvu9Wjj7wkss2/zr1Oj8fbuWiunL8Cj2WHl052rtl0dLKPqLm+/p4+p4555Qb2AK9e09U8v3mFvhCsZBOmW2k807pUpzquymz2sEfVkLYOtprKOfdFfP8lNtFZPpHHxC/r/T7VYOThpXzHbBKb/6qcf8nthpah5YzI=;
X-UUID: 9bb78951937b4b45aeef237ee2988633-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1840605644; Tue, 25 Feb 2020 19:47:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 19:48:16 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 19:46:20 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 3/4] drm/mediatek: add the mipitx driving control
Date:   Tue, 25 Feb 2020 19:47:29 +0800
Message-ID: <20200225114730.124939-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225114730.124939-1-jitao.shi@mediatek.com>
References: <20200225114730.124939-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 99280E93026C520557BB989933A6DAE48EB4CE48DF3A64BA3B1611BB93E08A7D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgaW4gZGV2aWNlIHRyZWUgdG8gY29udHJvbCB0aGUgZHJpdmluZyBieSBk
aWZmZXJlbnQNCmJvYXJkLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHgu
YyAgICAgICAgfCA2ICsrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90
eC5oICAgICAgICB8IDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21p
cGlfdHguYyB8IDcgKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYw0KaW5kZXggZTRkMzQ0ODRlY2M4
Li5lYzg0MDZjODZiZmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X21pcGlfdHguYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMN
CkBAIC0xMjUsNiArMTI1LDEyIEBAIHN0YXRpYyBpbnQgbXRrX21pcGlfdHhfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCXJldHVybiByZXQ7DQogCX0NCiANCisJcmV0ID0g
b2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2LT5vZl9ub2RlLCAibWlwaXR4LWN1cnJlbnQtZHJpdmUi
LA0KKwkJCQkgICAmbWlwaV90eC0+bWlwaXR4X2RyaXZlKTsNCisJLyogSWYgY2FuJ3QgZ2V0IHRo
ZSAibWlwaV90eC0+bWlwaXR4X2RyaXZlIiwgc2V0IGl0IGRlZmF1bHQgMHg4ICovDQorCWlmIChy
ZXQgPCAwKQ0KKwkJbWlwaV90eC0+bWlwaXR4X2RyaXZlID0gMHg4Ow0KKw0KIAlyZWZfY2xrX25h
bWUgPSBfX2Nsa19nZXRfbmFtZShyZWZfY2xrKTsNCiANCiAJcmV0ID0gb2ZfcHJvcGVydHlfcmVh
ZF9zdHJpbmcoZGV2LT5vZl9ub2RlLCAiY2xvY2stb3V0cHV0LW5hbWVzIiwNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfbWlwaV90eC5oDQppbmRleCA0MTNmMzVkODYyMTkuLmVlYTQ0MzI3ZmU5
ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguaA0KQEAgLTI3LDYgKzI3
LDcgQEAgc3RydWN0IG10a19taXBpX3R4IHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAl2b2lk
IF9faW9tZW0gKnJlZ3M7DQogCXUzMiBkYXRhX3JhdGU7DQorCXUzMiBtaXBpdHhfZHJpdmU7DQog
CWNvbnN0IHN0cnVjdCBtdGtfbWlwaXR4X2RhdGEgKmRyaXZlcl9kYXRhOw0KIAlzdHJ1Y3QgY2xr
X2h3IHBsbF9odzsNCiAJc3RydWN0IGNsayAqcGxsOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYw0KaW5kZXggOTFmMDhhMzUxZmQwLi4xMjRmZGY5NWYx
ZTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBp
X3R4LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHgu
Yw0KQEAgLTE3LDYgKzE3LDkgQEANCiAjZGVmaW5lIFJHX0RTSV9CR19DT1JFX0VOCQlCSVQoNykN
CiAjZGVmaW5lIFJHX0RTSV9QQURfVElFTF9TRUwJCUJJVCg4KQ0KIA0KKyNkZWZpbmUgTUlQSVRY
X1ZPTFRBR0VfU0VMCTB4MDAxMA0KKyNkZWZpbmUgUkdfRFNJX0hTVFhfTERPX1JFRl9TRUwJCSgw
eGYgPDwgNikNCisNCiAjZGVmaW5lIE1JUElUWF9QTExfUFdSCQkweDAwMjgNCiAjZGVmaW5lIE1J
UElUWF9QTExfQ09OMAkJMHgwMDJjDQogI2RlZmluZSBNSVBJVFhfUExMX0NPTjEJCTB4MDAzMA0K
QEAgLTEyMyw2ICsxMjYsMTAgQEAgc3RhdGljIHZvaWQgbXRrX21pcGlfdHhfcG93ZXJfb25fc2ln
bmFsKHN0cnVjdCBwaHkgKnBoeSkNCiAJbXRrX21pcGlfdHhfY2xlYXJfYml0cyhtaXBpX3R4LCBN
SVBJVFhfRDNfU1dfQ1RMX0VOLCBEU0lfU1dfQ1RMX0VOKTsNCiAJbXRrX21pcGlfdHhfY2xlYXJf
Yml0cyhtaXBpX3R4LCBNSVBJVFhfQ0tfU1dfQ1RMX0VOLCBEU0lfU1dfQ1RMX0VOKTsNCiANCisJ
bXRrX21pcGlfdHhfdXBkYXRlX2JpdHMobWlwaV90eCwgTUlQSVRYX1ZPTFRBR0VfU0VMLA0KKwkJ
CQlSR19EU0lfSFNUWF9MRE9fUkVGX1NFTCwNCisJCQkJbWlwaV90eC0+bWlwaXR4X2RyaXZlIDw8
IDYpOw0KKw0KIAltdGtfbWlwaV90eF9zZXRfYml0cyhtaXBpX3R4LCBNSVBJVFhfQ0tfQ0tNT0RF
X0VOLCBEU0lfQ0tfQ0tNT0RFX0VOKTsNCiB9DQogDQotLSANCjIuMjEuMA0K

