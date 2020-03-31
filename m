Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7FCC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215AD207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="exqZv8Zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgCaI2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:24 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16243 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730096AbgCaI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:21 -0400
X-UUID: f1a47595bc71470cad10f050830f46d2-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rciAlFaUJxmJYeohlOVBqQpG4bjwObp3/2jJtpkx6Pc=;
        b=exqZv8ZbSWE8wbJq5lV8qXOiCE/z8SWcY8gdzE07NG9kknApdvjh7H+Ej67YpoUXRRA2bl3Zi1dRfbdx6NgY764qtUT7Xi8DisP1AL+fAHxlojdFlQ0ajSaNVeC5DK04FSjr4uvAkXgHusa/mgA9GRsJ9B60GZ4YNCfYZZQjZ6k=;
X-UUID: f1a47595bc71470cad10f050830f46d2-20200331
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1144074984; Tue, 31 Mar 2020 16:27:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 16:27:58 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 31 Mar 2020 16:27:55 +0800
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
Subject: [PATCH v4 3/4] drm/mediatek: add the mipitx driving control
Date:   Tue, 31 Mar 2020 16:27:24 +0800
Message-ID: <20200331082725.81048-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200331082725.81048-1-jitao.shi@mediatek.com>
References: <20200331082725.81048-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CDD238A934F4566BB8936801F8D4F688F9A8C445ACBA109B34F45B0AA54C47932000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgaW4gZGV2aWNlIHRyZWUgdG8gY29udHJvbCB0aGUgZHJpdmluZyBieSBk
aWZmZXJlbnQNCmJvYXJkLg0KDQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhp
YXMuYmdnQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5j
ICAgICAgICB8IDE0ICsrKysrKysrKysrKysrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19taXBpX3R4LmggICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bXQ4MTgzX21pcGlfdHguYyB8ICA3ICsrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlw
aV90eC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMNCmluZGV4IGU0
ZDM0NDg0ZWNjOC4uZTMwMWFmNjQ4MDllIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19taXBpX3R4LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bWlwaV90eC5jDQpAQCAtMTI1LDYgKzEyNSwyMCBAQCBzdGF0aWMgaW50IG10a19taXBpX3R4X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQog
DQorCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgImRyaXZlLXN0cmVu
Z3RoLW1pY3JvYW1wIiwNCisJCQkJICAgJm1pcGlfdHgtPm1pcGl0eF9kcml2ZSk7DQorCS8qIElm
IGNhbid0IGdldCB0aGUgIm1pcGlfdHgtPm1pcGl0eF9kcml2ZSIsIHNldCBpdCBkZWZhdWx0IDB4
OCAqLw0KKwlpZiAocmV0IDwgMCkNCisJCW1pcGlfdHgtPm1pcGl0eF9kcml2ZSA9IDQ2MDA7DQor
DQorCS8qIGNoZWNrIHRoZSBtaXBpdHhfZHJpdmUgdmFsaWQgKi8NCisJaWYgKG1pcGlfdHgtPm1p
cGl0eF9kcml2ZSA+IDYwMDAgfHwgbWlwaV90eC0+bWlwaXR4X2RyaXZlIDwgMzAwMCkgew0KKwkJ
ZGV2X3dhcm4oZGV2LCAiZHJpdmUtc3RyZW5ndGgtbWljcm9hbXAgaXMgaW52YWxpZCAlZCwgbm90
IGluIDMwMDAgfiA2MDAwXG4iLA0KKwkJCSBtaXBpX3R4LT5taXBpdHhfZHJpdmUpOw0KKwkJbWlw
aV90eC0+bWlwaXR4X2RyaXZlID0gY2xhbXBfdmFsKG1pcGlfdHgtPm1pcGl0eF9kcml2ZSwgMzAw
MCwNCisJCQkJCQkgIDYwMDApOw0KKwl9DQorDQogCXJlZl9jbGtfbmFtZSA9IF9fY2xrX2dldF9u
YW1lKHJlZl9jbGspOw0KIA0KIAlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkZXYtPm9m
X25vZGUsICJjbG9jay1vdXRwdXQtbmFtZXMiLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfbWlwaV90eC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19t
aXBpX3R4LmgNCmluZGV4IDQxM2YzNWQ4NjIxOS4uZWVhNDQzMjdmZTlmIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmgNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oDQpAQCAtMjcsNiArMjcsNyBAQCBzdHJ1Y3QgbXRr
X21pcGlfdHggew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQogCXZvaWQgX19pb21lbSAqcmVnczsN
CiAJdTMyIGRhdGFfcmF0ZTsNCisJdTMyIG1pcGl0eF9kcml2ZTsNCiAJY29uc3Qgc3RydWN0IG10
a19taXBpdHhfZGF0YSAqZHJpdmVyX2RhdGE7DQogCXN0cnVjdCBjbGtfaHcgcGxsX2h3Ow0KIAlz
dHJ1Y3QgY2xrICpwbGw7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19tdDgxODNfbWlwaV90eC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNf
bWlwaV90eC5jDQppbmRleCA5MWYwOGEzNTFmZDAuLmU0Y2M5Njc3NTBjYiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jDQpAQCAtMTcsNiArMTcs
OSBAQA0KICNkZWZpbmUgUkdfRFNJX0JHX0NPUkVfRU4JCUJJVCg3KQ0KICNkZWZpbmUgUkdfRFNJ
X1BBRF9USUVMX1NFTAkJQklUKDgpDQogDQorI2RlZmluZSBNSVBJVFhfVk9MVEFHRV9TRUwJMHgw
MDEwDQorI2RlZmluZSBSR19EU0lfSFNUWF9MRE9fUkVGX1NFTAkJKDB4ZiA8PCA2KQ0KKw0KICNk
ZWZpbmUgTUlQSVRYX1BMTF9QV1IJCTB4MDAyOA0KICNkZWZpbmUgTUlQSVRYX1BMTF9DT04wCQkw
eDAwMmMNCiAjZGVmaW5lIE1JUElUWF9QTExfQ09OMQkJMHgwMDMwDQpAQCAtMTIzLDYgKzEyNiwx
MCBAQCBzdGF0aWMgdm9pZCBtdGtfbWlwaV90eF9wb3dlcl9vbl9zaWduYWwoc3RydWN0IHBoeSAq
cGh5KQ0KIAltdGtfbWlwaV90eF9jbGVhcl9iaXRzKG1pcGlfdHgsIE1JUElUWF9EM19TV19DVExf
RU4sIERTSV9TV19DVExfRU4pOw0KIAltdGtfbWlwaV90eF9jbGVhcl9iaXRzKG1pcGlfdHgsIE1J
UElUWF9DS19TV19DVExfRU4sIERTSV9TV19DVExfRU4pOw0KIA0KKwltdGtfbWlwaV90eF91cGRh
dGVfYml0cyhtaXBpX3R4LCBNSVBJVFhfVk9MVEFHRV9TRUwsDQorCQkJCVJHX0RTSV9IU1RYX0xE
T19SRUZfU0VMLA0KKwkJCQkobWlwaV90eC0+bWlwaXR4X2RyaXZlIC0gMzAwMCkgLyAyMDAgPDwg
Nik7DQorDQogCW10a19taXBpX3R4X3NldF9iaXRzKG1pcGlfdHgsIE1JUElUWF9DS19DS01PREVf
RU4sIERTSV9DS19DS01PREVfRU4pOw0KIH0NCiANCi0tIA0KMi4yMS4wDQo=

