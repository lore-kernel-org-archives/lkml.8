Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D681C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3162192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LECGlAek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgCKHTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:19:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44497 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726160AbgCKHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:19:50 -0400
X-UUID: c3ad8a71dd6e4b81af3c19b06804cdc5-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9JBTj+vrzKP+Q6L5ukHhTC+DxupJsI7Gf1gGQQIuWJk=;
        b=LECGlAekGrmj9vK4FqEiDn3xXGc3ZpcBqIZoY3RX2B21vgXCJw0vYbqmPRXHP1y3N9ANYaS/GYWD3Rnx44dBZKmy2RQhCGrWOwhJqgeJBZdwD9KWW/+gsplXtjNUYrc5howKWSjk4PZniYwxVSRPJe0d+71xHsSV1kLEuXJ9n+M=;
X-UUID: c3ad8a71dd6e4b81af3c19b06804cdc5-20200311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1331942434; Wed, 11 Mar 2020 15:18:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:14:30 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:18:11 +0800
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
Subject: [PATCH v13 5/6] drm/mediatek: dpi sample mode support
Date:   Wed, 11 Mar 2020 15:18:22 +0800
Message-ID: <20200311071823.117899-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311071823.117899-1-jitao.shi@mediatek.com>
References: <20200311071823.117899-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CEF2DB693517EEF1C396A846C8B59F9FFC734174A6225D38E0F4AC176537DA292000:8
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
b20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KaW5kZXggMDg3
ZjVjZTczMmUxLi4yODcxZTY4ZTc3NjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwaS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5j
DQpAQCAtNzUsNiArNzUsNyBAQCBzdHJ1Y3QgbXRrX2RwaSB7DQogCWVudW0gbXRrX2RwaV9vdXRf
Yml0X251bSBiaXRfbnVtOw0KIAllbnVtIG10a19kcGlfb3V0X2NoYW5uZWxfc3dhcCBjaGFubmVs
X3N3YXA7DQogCWludCByZWZjb3VudDsNCisJdTMyIHBjbGtfc2FtcGxlOw0KIH07DQogDQogc3Rh
dGljIGlubGluZSBzdHJ1Y3QgbXRrX2RwaSAqbXRrX2RwaV9mcm9tX2VuY29kZXIoc3RydWN0IGRy
bV9lbmNvZGVyICplKQ0KQEAgLTM0OCw2ICszNDksMTMgQEAgc3RhdGljIHZvaWQgbXRrX2RwaV9j
b25maWdfZGlzYWJsZV9lZGdlKHN0cnVjdCBtdGtfZHBpICpkcGkpDQogCQltdGtfZHBpX21hc2so
ZHBpLCBkcGktPmNvbmYtPnJlZ19oX2ZyZV9jb24sIDAsIEVER0VfU0VMX0VOKTsNCiB9DQogDQor
c3RhdGljIHZvaWQgbXRrX2RwaV9lbmFibGVfcGNsa19zYW1wbGVfZHVhbF9lZGdlKHN0cnVjdCBt
dGtfZHBpICpkcGkpDQorew0KKwltdGtfZHBpX21hc2soZHBpLCBEUElfRERSX1NFVFRJTkcsIERE
Ul9FTiB8IEREUl80UEhBU0UsDQorCQkgICAgIEREUl9FTiB8IEREUl80UEhBU0UpOw0KKwltdGtf
ZHBpX21hc2soZHBpLCBEUElfT1VUUFVUX1NFVFRJTkcsIEVER0VfU0VMLCBFREdFX1NFTCk7DQor
fQ0KKw0KIHN0YXRpYyB2b2lkIG10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChzdHJ1Y3QgbXRr
X2RwaSAqZHBpLA0KIAkJCQkJZW51bSBtdGtfZHBpX291dF9jb2xvcl9mb3JtYXQgZm9ybWF0KQ0K
IHsNCkBAIC00MzksNyArNDQ3LDggQEAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNwbGF5X21v
ZGUoc3RydWN0IG10a19kcGkgKmRwaSwNCiAJcGxsX3JhdGUgPSBjbGtfZ2V0X3JhdGUoZHBpLT50
dmRfY2xrKTsNCiANCiAJdm0ucGl4ZWxjbG9jayA9IHBsbF9yYXRlIC8gZmFjdG9yOw0KLQljbGtf
c2V0X3JhdGUoZHBpLT5waXhlbF9jbGssIHZtLnBpeGVsY2xvY2spOw0KKwljbGtfc2V0X3JhdGUo
ZHBpLT5waXhlbF9jbGssDQorCQkgICAgIHZtLnBpeGVsY2xvY2sgKiAoZHBpLT5wY2xrX3NhbXBs
ZSA+IDEgPyAyIDogMSkpOw0KIAl2bS5waXhlbGNsb2NrID0gY2xrX2dldF9yYXRlKGRwaS0+cGl4
ZWxfY2xrKTsNCiANCiAJZGV2X2RiZyhkcGktPmRldiwgIkdvdCAgUExMICVsdSBIeiwgcGl4ZWwg
Y2xvY2sgJWx1IEh6XG4iLA0KQEAgLTQ1MCw3ICs0NTksOCBAQCBzdGF0aWMgaW50IG10a19kcGlf
c2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KIAlsaW1pdC55X2JvdHRvbSA9
IDB4MDAxMDsNCiAJbGltaXQueV90b3AgPSAweDBGRTA7DQogDQotCWRwaV9wb2wuY2tfcG9sID0g
TVRLX0RQSV9QT0xBUklUWV9GQUxMSU5HOw0KKwlkcGlfcG9sLmNrX3BvbCA9IGRwaS0+cGNsa19z
YW1wbGUgPT0gMSA/DQorCQkJIE1US19EUElfUE9MQVJJVFlfUklTSU5HIDogTVRLX0RQSV9QT0xB
UklUWV9GQUxMSU5HOw0KIAlkcGlfcG9sLmRlX3BvbCA9IE1US19EUElfUE9MQVJJVFlfUklTSU5H
Ow0KIAlkcGlfcG9sLmhzeW5jX3BvbCA9IHZtLmZsYWdzICYgRElTUExBWV9GTEFHU19IU1lOQ19I
SUdIID8NCiAJCQkgICAgTVRLX0RQSV9QT0xBUklUWV9GQUxMSU5HIDogTVRLX0RQSV9QT0xBUklU
WV9SSVNJTkc7DQpAQCAtNTA0LDYgKzUxNCw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlz
cGxheV9tb2RlKHN0cnVjdCBtdGtfZHBpICpkcGksDQogCW10a19kcGlfY29uZmlnX2NvbG9yX2Zv
cm1hdChkcGksIGRwaS0+Y29sb3JfZm9ybWF0KTsNCiAJbXRrX2RwaV9jb25maWdfMm5faF9mcmUo
ZHBpKTsNCiAJbXRrX2RwaV9jb25maWdfZGlzYWJsZV9lZGdlKGRwaSk7DQorCWlmIChkcGktPnBj
bGtfc2FtcGxlID4gMSkNCisJCW10a19kcGlfZW5hYmxlX3BjbGtfc2FtcGxlX2R1YWxfZWRnZShk
cGkpOw0KIAltdGtfZHBpX3N3X3Jlc2V0KGRwaSwgZmFsc2UpOw0KIA0KIAlyZXR1cm4gMDsNCkBA
IC02OTMsNiArNzA1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTgz
X2NvbmYgPSB7DQogc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KKwlzdHJ1
Y3QgZGV2aWNlX25vZGUgKmVwOw0KIAlzdHJ1Y3QgbXRrX2RwaSAqZHBpOw0KIAlzdHJ1Y3QgcmVz
b3VyY2UgKm1lbTsNCiAJaW50IGNvbXBfaWQ7DQpAQCAtNzA1LDYgKzcxOCwxNiBAQCBzdGF0aWMg
aW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJZHBpLT5k
ZXYgPSBkZXY7DQogCWRwaS0+Y29uZiA9IChzdHJ1Y3QgbXRrX2RwaV9jb25mICopb2ZfZGV2aWNl
X2dldF9tYXRjaF9kYXRhKGRldik7DQogDQorCWVwID0gb2ZfZ3JhcGhfZ2V0X2VuZHBvaW50X2J5
X3JlZ3MoZGV2LT5vZl9ub2RlLCAwLCAwKTsNCisJaWYgKCFlcCkgew0KKwkJZGV2X2VycihkZXYs
ICJGYWlsZWQgZ2V0IHRoZSBlbmRwb2ludCBwb3J0XG4iKTsNCisJCXJldHVybiAtRUlOVkFMOw0K
Kwl9DQorDQorCS8qIEdldCB0aGUgc2FtcGxpbmcgZWRnZSBmcm9tIHRoZSBlbmRwb2ludC4gKi8N
CisJb2ZfcHJvcGVydHlfcmVhZF91MzIoZXAsICJwY2xrLXNhbXBsZSIsICZkcGktPnBjbGtfc2Ft
cGxlKTsNCisJb2Zfbm9kZV9wdXQoZXApOw0KKw0KIAltZW0gPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KIAlkcGktPnJlZ3MgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCBtZW0pOw0KIAlpZiAoSVNfRVJSKGRwaS0+cmVncykpIHsNCi0tIA0KMi4y
MS4wDQo=

