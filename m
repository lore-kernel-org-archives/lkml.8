Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3FC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DE20578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YtdI/BxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgCKHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:41:07 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2977 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728339AbgCKHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:41:07 -0400
X-UUID: e6e7c733b1584eb08b1c1fea03798e31-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t8hedylVJwkJMYP7UnqBpDhKqAa/d5AZ7g/YjEG5AI8=;
        b=YtdI/BxAMRQ8mOy/RKXbjQm8g6IgtEzYRMnMvxsDeVvV06dNCBF17s44gGov+ODpIvfPu/DLMC3jjVAohaQ5V+CooVpejUtOmAA0BjX2UoVlToMYQE4duO6jFIJq4WnjahM8xf5ORs/IkeCjJe/Jl24l2KglBSpoxhm+4EZmauM=;
X-UUID: e6e7c733b1584eb08b1c1fea03798e31-20200311
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2122408000; Wed, 11 Mar 2020 15:40:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:38:26 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:42:04 +0800
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
Subject: [PATCH v3 3/4] drm/mediatek: add the mipitx driving control
Date:   Wed, 11 Mar 2020 15:40:31 +0800
Message-ID: <20200311074032.119481-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311074032.119481-1-jitao.shi@mediatek.com>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FD68469F06CED291422597CC0694F2D92E1A1462DDD16CD56C8592C26162E0552000:8
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
ICAgICAgICB8IDYgKysrKysrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4
LmggICAgICAgIHwgMSArDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlw
aV90eC5jIHwgNyArKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5jDQppbmRleCBlNGQzNDQ4NGVjYzgu
LjJhMWFjNGU5N2NiYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bWlwaV90eC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYw0K
QEAgLTEyNSw2ICsxMjUsMTIgQEAgc3RhdGljIGludCBtdGtfbWlwaV90eF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlyZXQgPSBv
Zl9wcm9wZXJ0eV9yZWFkX3UzMihkZXYtPm9mX25vZGUsICJkcml2ZS1zdHJlbmd0aC1taWNyb2Ft
cCIsDQorCQkJCSAgICZtaXBpX3R4LT5taXBpdHhfZHJpdmUpOw0KKwkvKiBJZiBjYW4ndCBnZXQg
dGhlICJtaXBpX3R4LT5taXBpdHhfZHJpdmUiLCBzZXQgaXQgZGVmYXVsdCAweDggKi8NCisJaWYg
KHJldCA8IDApDQorCQltaXBpX3R4LT5taXBpdHhfZHJpdmUgPSAweDg7DQorDQogCXJlZl9jbGtf
bmFtZSA9IF9fY2xrX2dldF9uYW1lKHJlZl9jbGspOw0KIA0KIAlyZXQgPSBvZl9wcm9wZXJ0eV9y
ZWFkX3N0cmluZyhkZXYtPm9mX25vZGUsICJjbG9jay1vdXRwdXQtbmFtZXMiLA0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19taXBpX3R4LmgNCmluZGV4IDQxM2YzNWQ4NjIxOS4uZWVhNDQzMjdm
ZTlmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmgN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oDQpAQCAtMjcsNiAr
MjcsNyBAQCBzdHJ1Y3QgbXRrX21pcGlfdHggew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQogCXZv
aWQgX19pb21lbSAqcmVnczsNCiAJdTMyIGRhdGFfcmF0ZTsNCisJdTMyIG1pcGl0eF9kcml2ZTsN
CiAJY29uc3Qgc3RydWN0IG10a19taXBpdHhfZGF0YSAqZHJpdmVyX2RhdGE7DQogCXN0cnVjdCBj
bGtfaHcgcGxsX2h3Ow0KIAlzdHJ1Y3QgY2xrICpwbGw7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jDQppbmRleCA5MWYwOGEzNTFmZDAuLjEyNGZkZjk1
ZjFlNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21p
cGlfdHguYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90
eC5jDQpAQCAtMTcsNiArMTcsOSBAQA0KICNkZWZpbmUgUkdfRFNJX0JHX0NPUkVfRU4JCUJJVCg3
KQ0KICNkZWZpbmUgUkdfRFNJX1BBRF9USUVMX1NFTAkJQklUKDgpDQogDQorI2RlZmluZSBNSVBJ
VFhfVk9MVEFHRV9TRUwJMHgwMDEwDQorI2RlZmluZSBSR19EU0lfSFNUWF9MRE9fUkVGX1NFTAkJ
KDB4ZiA8PCA2KQ0KKw0KICNkZWZpbmUgTUlQSVRYX1BMTF9QV1IJCTB4MDAyOA0KICNkZWZpbmUg
TUlQSVRYX1BMTF9DT04wCQkweDAwMmMNCiAjZGVmaW5lIE1JUElUWF9QTExfQ09OMQkJMHgwMDMw
DQpAQCAtMTIzLDYgKzEyNiwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfbWlwaV90eF9wb3dlcl9vbl9z
aWduYWwoc3RydWN0IHBoeSAqcGh5KQ0KIAltdGtfbWlwaV90eF9jbGVhcl9iaXRzKG1pcGlfdHgs
IE1JUElUWF9EM19TV19DVExfRU4sIERTSV9TV19DVExfRU4pOw0KIAltdGtfbWlwaV90eF9jbGVh
cl9iaXRzKG1pcGlfdHgsIE1JUElUWF9DS19TV19DVExfRU4sIERTSV9TV19DVExfRU4pOw0KIA0K
KwltdGtfbWlwaV90eF91cGRhdGVfYml0cyhtaXBpX3R4LCBNSVBJVFhfVk9MVEFHRV9TRUwsDQor
CQkJCVJHX0RTSV9IU1RYX0xET19SRUZfU0VMLA0KKwkJCQltaXBpX3R4LT5taXBpdHhfZHJpdmUg
PDwgNik7DQorDQogCW10a19taXBpX3R4X3NldF9iaXRzKG1pcGlfdHgsIE1JUElUWF9DS19DS01P
REVfRU4sIERTSV9DS19DS01PREVfRU4pOw0KIH0NCiANCi0tIA0KMi4yMS4wDQo=

