Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0914C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7751F2063A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HANf0K7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgDKHoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:44:38 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:37086 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725899AbgDKHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:44:37 -0400
X-UUID: ba456588f9db49a798718c0c55767750-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AHxhUn2kmmaiTpuNqyuJ91haPBs27z9l86TI6FY89lo=;
        b=HANf0K7OwymCJmRC/RqCZPhcDTIdxnfUP1R+AltCBZ+zuN5FxTUZf1Jmq7SZPjEA64Zo7Cm6k0iEUn8EBIKXUwqgzRMevEGEe2dXimYWLCTinPY5dR0tTEszinZQr2Ky1efo4hfI5SOZBRm67ReyBFyIbpnhiWeE8oSeXfJmGKE=;
X-UUID: ba456588f9db49a798718c0c55767750-20200411
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1950745472; Sat, 11 Apr 2020 15:44:28 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Apr
 2020 15:44:28 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 11 Apr 2020 15:44:25 +0800
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
        Jitao Shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v6 3/4] drm/mediatek: add the mipitx driving control
Date:   Sat, 11 Apr 2020 15:44:07 +0800
Message-ID: <20200411074408.38090-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200411074408.38090-1-jitao.shi@mediatek.com>
References: <20200411074408.38090-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F585F1D0662B1E91FEA6FA77DF2A7867D88A48573C1192C85F33AC2D99FED72D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgaW4gZGV2aWNlIHRyZWUgdG8gY29udHJvbCB0aGUgZHJpdmluZyBieSBk
aWZmZXJlbnQNCmJvYXJkLg0KDQpSZXZpZXdlZC1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5n
Lmh1QGtlcm5lbC5vcmc+DQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMu
YmdnQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5jICAg
ICAgICB8IDE0ICsrKysrKysrKysrKysrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19t
aXBpX3R4LmggICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4
MTgzX21pcGlfdHguYyB8ICA3ICsrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90
eC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMNCmluZGV4IGU0ZDM0
NDg0ZWNjOC4uZTMwMWFmNjQ4MDllIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19taXBpX3R4LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlw
aV90eC5jDQpAQCAtMTI1LDYgKzEyNSwyMCBAQCBzdGF0aWMgaW50IG10a19taXBpX3R4X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQor
CXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgImRyaXZlLXN0cmVuZ3Ro
LW1pY3JvYW1wIiwNCisJCQkJICAgJm1pcGlfdHgtPm1pcGl0eF9kcml2ZSk7DQorCS8qIElmIGNh
bid0IGdldCB0aGUgIm1pcGlfdHgtPm1pcGl0eF9kcml2ZSIsIHNldCBpdCBkZWZhdWx0IDB4OCAq
Lw0KKwlpZiAocmV0IDwgMCkNCisJCW1pcGlfdHgtPm1pcGl0eF9kcml2ZSA9IDQ2MDA7DQorDQor
CS8qIGNoZWNrIHRoZSBtaXBpdHhfZHJpdmUgdmFsaWQgKi8NCisJaWYgKG1pcGlfdHgtPm1pcGl0
eF9kcml2ZSA+IDYwMDAgfHwgbWlwaV90eC0+bWlwaXR4X2RyaXZlIDwgMzAwMCkgew0KKwkJZGV2
X3dhcm4oZGV2LCAiZHJpdmUtc3RyZW5ndGgtbWljcm9hbXAgaXMgaW52YWxpZCAlZCwgbm90IGlu
IDMwMDAgfiA2MDAwXG4iLA0KKwkJCSBtaXBpX3R4LT5taXBpdHhfZHJpdmUpOw0KKwkJbWlwaV90
eC0+bWlwaXR4X2RyaXZlID0gY2xhbXBfdmFsKG1pcGlfdHgtPm1pcGl0eF9kcml2ZSwgMzAwMCwN
CisJCQkJCQkgIDYwMDApOw0KKwl9DQorDQogCXJlZl9jbGtfbmFtZSA9IF9fY2xrX2dldF9uYW1l
KHJlZl9jbGspOw0KIA0KIAlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkZXYtPm9mX25v
ZGUsICJjbG9jay1vdXRwdXQtbmFtZXMiLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfbWlwaV90eC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBp
X3R4LmgNCmluZGV4IDQxM2YzNWQ4NjIxOS4uZWVhNDQzMjdmZTlmIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmgNCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfbWlwaV90eC5oDQpAQCAtMjcsNiArMjcsNyBAQCBzdHJ1Y3QgbXRrX21p
cGlfdHggew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQogCXZvaWQgX19pb21lbSAqcmVnczsNCiAJ
dTMyIGRhdGFfcmF0ZTsNCisJdTMyIG1pcGl0eF9kcml2ZTsNCiAJY29uc3Qgc3RydWN0IG10a19t
aXBpdHhfZGF0YSAqZHJpdmVyX2RhdGE7DQogCXN0cnVjdCBjbGtfaHcgcGxsX2h3Ow0KIAlzdHJ1
Y3QgY2xrICpwbGw7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19t
dDgxODNfbWlwaV90eC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlw
aV90eC5jDQppbmRleCA5MWYwOGEzNTFmZDAuLmU0Y2M5Njc3NTBjYiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jDQpAQCAtMTcsNiArMTcsOSBA
QA0KICNkZWZpbmUgUkdfRFNJX0JHX0NPUkVfRU4JCUJJVCg3KQ0KICNkZWZpbmUgUkdfRFNJX1BB
RF9USUVMX1NFTAkJQklUKDgpDQogDQorI2RlZmluZSBNSVBJVFhfVk9MVEFHRV9TRUwJMHgwMDEw
DQorI2RlZmluZSBSR19EU0lfSFNUWF9MRE9fUkVGX1NFTAkJKDB4ZiA8PCA2KQ0KKw0KICNkZWZp
bmUgTUlQSVRYX1BMTF9QV1IJCTB4MDAyOA0KICNkZWZpbmUgTUlQSVRYX1BMTF9DT04wCQkweDAw
MmMNCiAjZGVmaW5lIE1JUElUWF9QTExfQ09OMQkJMHgwMDMwDQpAQCAtMTIzLDYgKzEyNiwxMCBA
QCBzdGF0aWMgdm9pZCBtdGtfbWlwaV90eF9wb3dlcl9vbl9zaWduYWwoc3RydWN0IHBoeSAqcGh5
KQ0KIAltdGtfbWlwaV90eF9jbGVhcl9iaXRzKG1pcGlfdHgsIE1JUElUWF9EM19TV19DVExfRU4s
IERTSV9TV19DVExfRU4pOw0KIAltdGtfbWlwaV90eF9jbGVhcl9iaXRzKG1pcGlfdHgsIE1JUElU
WF9DS19TV19DVExfRU4sIERTSV9TV19DVExfRU4pOw0KIA0KKwltdGtfbWlwaV90eF91cGRhdGVf
Yml0cyhtaXBpX3R4LCBNSVBJVFhfVk9MVEFHRV9TRUwsDQorCQkJCVJHX0RTSV9IU1RYX0xET19S
RUZfU0VMLA0KKwkJCQkobWlwaV90eC0+bWlwaXR4X2RyaXZlIC0gMzAwMCkgLyAyMDAgPDwgNik7
DQorDQogCW10a19taXBpX3R4X3NldF9iaXRzKG1pcGlfdHgsIE1JUElUWF9DS19DS01PREVfRU4s
IERTSV9DS19DS01PREVfRU4pOw0KIH0NCiANCi0tIA0KMi4yMS4wDQo=

