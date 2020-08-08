Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2007AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF9E22D00
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oixF0R5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHHCy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:54:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58624 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbgHHCyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:54:55 -0400
X-UUID: 5e27325285174b1b82851a510028635a-20200808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MHq/uU/tNRZCdlIsrS4UrGJdmAWY+kaQP1yt6SUyZBQ=;
        b=oixF0R5ewHZ3yEXPB2oYUrijs7dp7e768hdB4lwEfrvUcciMQN3UcsaBl/SmnXS3yhY+l8kQGIDPCrDwv1D5EIPhNiLOTZg6ZK5LF5n9XCdLB7ThK4WGbP4QrDSXueSc2y0HgUYDCKhvE7gOhzEuQ5wt6jo1kOH52lTTRlH1Kl4=;
X-UUID: 5e27325285174b1b82851a510028635a-20200808
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 740594823; Sat, 08 Aug 2020 10:54:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 Aug 2020 10:54:43 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Aug 2020 10:54:42 +0800
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
Subject: [RESEND v7, PATCH 5/7] drm/mediatek: add fifo_size into rdma private data
Date:   Sat, 8 Aug 2020 10:53:49 +0800
Message-ID: <1596855231-5782-6-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2V0IHRoZSBmaWZvIHNpemUgZnJvbSBkZXZpY2UgdHJlZQ0KYmVjYXVzZSBlYWNoIHJkbWEgaW4g
dGhlIHNhbWUgU29DIG1heSBoYXZlIGRpZmZlcmVudCBmaWZvIHNpemUNCg0KU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIHwgMTkgKysrKysrKysrKysrKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KaW5kZXggZTA0MzE5Zi4u
Nzk0YWNjNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9y
ZG1hLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCkBA
IC02Myw2ICs2Myw3IEBAIHN0cnVjdCBtdGtfZGlzcF9yZG1hIHsNCiAJc3RydWN0IG10a19kZHBf
Y29tcAkJZGRwX2NvbXA7DQogCXN0cnVjdCBkcm1fY3J0YwkJCSpjcnRjOw0KIAljb25zdCBzdHJ1
Y3QgbXRrX2Rpc3BfcmRtYV9kYXRhCSpkYXRhOw0KKwl1MzIJCQkJZmlmb19zaXplOw0KIH07DQog
DQogc3RhdGljIGlubGluZSBzdHJ1Y3QgbXRrX2Rpc3BfcmRtYSAqY29tcF90b19yZG1hKHN0cnVj
dCBtdGtfZGRwX2NvbXAgKmNvbXApDQpAQCAtMTMxLDEyICsxMzIsMTggQEAgc3RhdGljIHZvaWQg
bXRrX3JkbWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3
aWR0aCwNCiAJdW5zaWduZWQgaW50IHRocmVzaG9sZDsNCiAJdW5zaWduZWQgaW50IHJlZzsNCiAJ
c3RydWN0IG10a19kaXNwX3JkbWEgKnJkbWEgPSBjb21wX3RvX3JkbWEoY29tcCk7DQorCXUzMiBy
ZG1hX2ZpZm9fc2l6ZTsNCiANCiAJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCB3aWR0aCwg
Y29tcCwNCiAJCQkgICBESVNQX1JFR19SRE1BX1NJWkVfQ09OXzAsIDB4ZmZmKTsNCiAJbXRrX2Rk
cF93cml0ZV9tYXNrKGNtZHFfcGt0LCBoZWlnaHQsIGNvbXAsDQogCQkJICAgRElTUF9SRUdfUkRN
QV9TSVpFX0NPTl8xLCAweGZmZmZmKTsNCiANCisJaWYgKHJkbWEtPmZpZm9fc2l6ZSkNCisJCXJk
bWFfZmlmb19zaXplID0gcmRtYS0+Zmlmb19zaXplOw0KKwllbHNlDQorCQlyZG1hX2ZpZm9fc2l6
ZSA9IFJETUFfRklGT19TSVpFKHJkbWEpOw0KKw0KIAkvKg0KIAkgKiBFbmFibGUgRklGTyB1bmRl
cmZsb3cgc2luY2UgRFNJIGFuZCBEUEkgY2FuJ3QgYmUgYmxvY2tlZC4NCiAJICogS2VlcCB0aGUg
RklGTyBwc2V1ZG8gc2l6ZSByZXNldCBkZWZhdWx0IG9mIDggS2lCLiBTZXQgdGhlDQpAQCAtMTQ1
LDcgKzE1Miw3IEBAIHN0YXRpYyB2b2lkIG10a19yZG1hX2NvbmZpZyhzdHJ1Y3QgbXRrX2RkcF9j
b21wICpjb21wLCB1bnNpZ25lZCBpbnQgd2lkdGgsDQogCSAqLw0KIAl0aHJlc2hvbGQgPSB3aWR0
aCAqIGhlaWdodCAqIHZyZWZyZXNoICogNCAqIDcgLyAxMDAwMDAwOw0KIAlyZWcgPSBSRE1BX0ZJ
Rk9fVU5ERVJGTE9XX0VOIHwNCi0JICAgICAgUkRNQV9GSUZPX1BTRVVET19TSVpFKFJETUFfRklG
T19TSVpFKHJkbWEpKSB8DQorCSAgICAgIFJETUFfRklGT19QU0VVRE9fU0laRShyZG1hX2ZpZm9f
c2l6ZSkgfA0KIAkgICAgICBSRE1BX09VVFBVVF9WQUxJRF9GSUZPX1RIUkVTSE9MRCh0aHJlc2hv
bGQpOw0KIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCByZWcsIGNvbXAsIERJU1BfUkVHX1JETUFf
RklGT19DT04pOw0KIH0NCkBAIC0yOTEsNiArMjk4LDE2IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3Bf
cmRtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIGNvbXBf
aWQ7DQogCX0NCiANCisJaWYgKG9mX2ZpbmRfcHJvcGVydHkoZGV2LT5vZl9ub2RlLCAibWVkaWF0
ZWsscmRtYV9maWZvX3NpemUiLCAmcmV0KSkgew0KKwkJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91
MzIoZGV2LT5vZl9ub2RlLA0KKwkJCQkJICAgIm1lZGlhdGVrLHJkbWFfZmlmb19zaXplIiwNCisJ
CQkJCSAgICZwcml2LT5maWZvX3NpemUpOw0KKwkJaWYgKHJldCkgew0KKwkJCWRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIGdldCByZG1hIGZpZm8gc2l6ZVxuIik7DQorCQkJcmV0dXJuIHJldDsNCisJ
CX0NCisJfQ0KKw0KIAlyZXQgPSBtdGtfZGRwX2NvbXBfaW5pdChkZXYsIGRldi0+b2Zfbm9kZSwg
JnByaXYtPmRkcF9jb21wLCBjb21wX2lkLA0KIAkJCQkmbXRrX2Rpc3BfcmRtYV9mdW5jcyk7DQog
CWlmIChyZXQpIHsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

