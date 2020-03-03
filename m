Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D92080C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M0KxgiaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCCF3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:29:07 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:40303 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727101AbgCCF3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:29:07 -0500
X-UUID: c82264bcb04a4db1a4db6f8f29a215dc-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GqzXCNpUxckx5ubY4kpCVp1Ssj5d8Wj9EwIiSJrnVsA=;
        b=M0KxgiaWNQP78m4hALiSd+LrrtNyFRKrKbdKOOyvSYT8DAIfPh7yRIAAfS/pgA81XB/p+QirYaPRb+ug7INWAzhm/z2PSWxVwMnWduVSApxPafiiHkH4g9bxVazBH++lbQ/D4+TyvFK2H0OT0mKmQzX3d5GT8CRm/dH0dldBtLc=;
X-UUID: c82264bcb04a4db1a4db6f8f29a215dc-20200303
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2079417183; Tue, 03 Mar 2020 13:28:05 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar
 2020 13:26:42 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 3 Mar 2020 13:28:25 +0800
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
Subject: [PATCH v12 5/6] drm/mediatek: dpi sample mode support
Date:   Tue, 3 Mar 2020 13:27:21 +0800
Message-ID: <20200303052722.94795-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200303052722.94795-1-jitao.shi@mediatek.com>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3D36277970DB06A6EBC23EF3A5F4498C51A7F40E0CCB673E784DCA18328176BE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFBJIGNhbiBzYW1wbGUgb24gZmFsbGluZywgcmlzaW5nIG9yIGJvdGggZWRnZS4NCldoZW4gRFBJ
IHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KSXQgY2FuIHJl
ZHVjZSBoYWxmIGRhdGEgaW8gcGlucy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgMTggKysrKysr
KysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5j
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KaW5kZXggMDg3ZjVjZTczMmUx
Li5kYjMyNzJmN2E0YzQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwaS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQpAQCAtNzUs
NiArNzUsNyBAQCBzdHJ1Y3QgbXRrX2RwaSB7DQogCWVudW0gbXRrX2RwaV9vdXRfYml0X251bSBi
aXRfbnVtOw0KIAllbnVtIG10a19kcGlfb3V0X2NoYW5uZWxfc3dhcCBjaGFubmVsX3N3YXA7DQog
CWludCByZWZjb3VudDsNCisJdTMyIHBjbGtfc2FtcGxlOw0KIH07DQogDQogc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgbXRrX2RwaSAqbXRrX2RwaV9mcm9tX2VuY29kZXIoc3RydWN0IGRybV9lbmNvZGVy
ICplKQ0KQEAgLTM0OCw2ICszNDksMTMgQEAgc3RhdGljIHZvaWQgbXRrX2RwaV9jb25maWdfZGlz
YWJsZV9lZGdlKHN0cnVjdCBtdGtfZHBpICpkcGkpDQogCQltdGtfZHBpX21hc2soZHBpLCBkcGkt
PmNvbmYtPnJlZ19oX2ZyZV9jb24sIDAsIEVER0VfU0VMX0VOKTsNCiB9DQogDQorc3RhdGljIHZv
aWQgbXRrX2RwaV9lbmFibGVfcGNsa19zYW1wbGVfZHVhbF9lZGdlKHN0cnVjdCBtdGtfZHBpICpk
cGkpDQorew0KKwltdGtfZHBpX21hc2soZHBpLCBEUElfRERSX1NFVFRJTkcsIEREUl9FTiB8IERE
Ul80UEhBU0UsDQorCQkgICAgIEREUl9FTiB8IEREUl80UEhBU0UpOw0KKwltdGtfZHBpX21hc2so
ZHBpLCBEUElfT1VUUFVUX1NFVFRJTkcsIEVER0VfU0VMLCBFREdFX1NFTCk7DQorfQ0KKw0KIHN0
YXRpYyB2b2lkIG10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChzdHJ1Y3QgbXRrX2RwaSAqZHBp
LA0KIAkJCQkJZW51bSBtdGtfZHBpX291dF9jb2xvcl9mb3JtYXQgZm9ybWF0KQ0KIHsNCkBAIC00
MzksNyArNDQ3LDggQEAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNwbGF5X21vZGUoc3RydWN0
IG10a19kcGkgKmRwaSwNCiAJcGxsX3JhdGUgPSBjbGtfZ2V0X3JhdGUoZHBpLT50dmRfY2xrKTsN
CiANCiAJdm0ucGl4ZWxjbG9jayA9IHBsbF9yYXRlIC8gZmFjdG9yOw0KLQljbGtfc2V0X3JhdGUo
ZHBpLT5waXhlbF9jbGssIHZtLnBpeGVsY2xvY2spOw0KKwljbGtfc2V0X3JhdGUoZHBpLT5waXhl
bF9jbGssDQorCQkgICAgIHZtLnBpeGVsY2xvY2sgKiAoZHBpLT5wY2xrX3NhbXBsZSA+IDEgPyAy
IDogMSkpOw0KIAl2bS5waXhlbGNsb2NrID0gY2xrX2dldF9yYXRlKGRwaS0+cGl4ZWxfY2xrKTsN
CiANCiAJZGV2X2RiZyhkcGktPmRldiwgIkdvdCAgUExMICVsdSBIeiwgcGl4ZWwgY2xvY2sgJWx1
IEh6XG4iLA0KQEAgLTQ1MCw3ICs0NTksOCBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3Bs
YXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KIAlsaW1pdC55X2JvdHRvbSA9IDB4MDAxMDsN
CiAJbGltaXQueV90b3AgPSAweDBGRTA7DQogDQotCWRwaV9wb2wuY2tfcG9sID0gTVRLX0RQSV9Q
T0xBUklUWV9GQUxMSU5HOw0KKwlkcGlfcG9sLmNrX3BvbCA9IGRwaS0+cGNsa19zYW1wbGUgPT0g
MSA/DQorCQkJIE1US19EUElfUE9MQVJJVFlfUklTSU5HIDogTVRLX0RQSV9QT0xBUklUWV9GQUxM
SU5HOw0KIAlkcGlfcG9sLmRlX3BvbCA9IE1US19EUElfUE9MQVJJVFlfUklTSU5HOw0KIAlkcGlf
cG9sLmhzeW5jX3BvbCA9IHZtLmZsYWdzICYgRElTUExBWV9GTEFHU19IU1lOQ19ISUdIID8NCiAJ
CQkgICAgTVRLX0RQSV9QT0xBUklUWV9GQUxMSU5HIDogTVRLX0RQSV9QT0xBUklUWV9SSVNJTkc7
DQpAQCAtNTA0LDYgKzUxNCw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2Rl
KHN0cnVjdCBtdGtfZHBpICpkcGksDQogCW10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChkcGks
IGRwaS0+Y29sb3JfZm9ybWF0KTsNCiAJbXRrX2RwaV9jb25maWdfMm5faF9mcmUoZHBpKTsNCiAJ
bXRrX2RwaV9jb25maWdfZGlzYWJsZV9lZGdlKGRwaSk7DQorCWlmIChkcGktPnBjbGtfc2FtcGxl
ID4gMSkNCisJCW10a19kcGlfZW5hYmxlX3BjbGtfc2FtcGxlX2R1YWxfZWRnZShkcGkpOw0KIAlt
dGtfZHBpX3N3X3Jlc2V0KGRwaSwgZmFsc2UpOw0KIA0KIAlyZXR1cm4gMDsNCkBAIC03MDQsNiAr
NzE2LDggQEAgc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogDQogCWRwaS0+ZGV2ID0gZGV2Ow0KIAlkcGktPmNvbmYgPSAoc3RydWN0IG10a19k
cGlfY29uZiAqKW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KKwlvZl9wcm9wZXJ0eV9y
ZWFkX3UzMl9pbmRleChkZXYtPm9mX25vZGUsICJwY2xrLXNhbXBsZSIsIDEsDQorCQkJCSAgICZk
cGktPnBjbGtfc2FtcGxlKTsNCiANCiAJbWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJZHBpLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNl
KGRldiwgbWVtKTsNCi0tIA0KMi4yMS4wDQo=

