Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6112FC2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E0720857
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mL+jfjih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDKHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:44:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24843 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbgDKHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:44:38 -0400
X-UUID: 8929f2f7a1e948c88716c9e1cffa2c02-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GY6kkVqQdoO6pb5HRhb6+TbQErdD2FZ5VWwTRBcTUlY=;
        b=mL+jfjiho+ZbId8z+3DJ3Hy0SXHhfmso+RWzUGhHubKEFfdozV5tC7TTuE1TyStWiVKtynSjloaOKFdOLPB1BpYn9R8dYFqrgQqdVeH1R+U/buV/4Iye3HDfucW9+CCkSKXGFPXASsQ/RnTv8JKfz9X708EXkgbvBLOLES8PK84=;
X-UUID: 8929f2f7a1e948c88716c9e1cffa2c02-20200411
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 346581309; Sat, 11 Apr 2020 15:44:28 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Apr
 2020 15:44:29 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 11 Apr 2020 15:44:27 +0800
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
Subject: [PATCH v6 4/4] drm/mediatek: config mipitx impedance with calibration data
Date:   Sat, 11 Apr 2020 15:44:08 +0800
Message-ID: <20200411074408.38090-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200411074408.38090-1-jitao.shi@mediatek.com>
References: <20200411074408.38090-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AFB922CAAE16CBA39DB068B9B2C548EFCE1B0533F1A41542C3961D0FDA54E06B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVhZCBjYWxpYnJhdGlvbiBkYXRhIGZyb20gbnZtZW0sIGFuZCBjb25maWcgbWlwaXR4IGltcGVk
YW5jZSB3aXRoDQpjYWxpYnJhdGlvbiBkYXRhIHRvIG1ha2Ugc3VyZSB0aGVpciBpbXBlZGFuY2Ug
YXJlIDEwMG9obS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMgICAg
ICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfbWlwaV90eC5oICAgICAgICB8ICAzICsrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19tdDgxODNfbWlwaV90eC5jIHwgMjEgKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjQg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19taXBpX3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYw0KaW5k
ZXggZTMwMWFmNjQ4MDllLi44Y2VlMjU5MWU3MjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19taXBpX3R4LmMNCkBAIC04OCw2ICs4OCw0NCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBo
eV9vcHMgbXRrX21pcGlfdHhfb3BzID0gew0KIAkub3duZXIgPSBUSElTX01PRFVMRSwNCiB9Ow0K
IA0KK3N0YXRpYyB2b2lkIG10a19taXBpX3R4X2dldF9jYWxpYnJhdGlvbl9kYXRhbChzdHJ1Y3Qg
bXRrX21pcGlfdHggKm1pcGlfdHgpDQorew0KKwlzdHJ1Y3QgbnZtZW1fY2VsbCAqY2VsbDsNCisJ
c2l6ZV90IGxlbjsNCisJdTMyICpidWY7DQorDQorCWNlbGwgPSBudm1lbV9jZWxsX2dldChtaXBp
X3R4LT5kZXYsICJjYWxpYnJhdGlvbi1kYXRhIik7DQorCWlmIChJU19FUlIoY2VsbCkpIHsNCisJ
CWRldl9pbmZvKG1pcGlfdHgtPmRldiwgImNhbid0IGdldCBudm1lbV9jZWxsX2dldCwgaWdub3Jl
IGl0XG4iKTsNCisJCXJldHVybjsNCisJfQ0KKwlidWYgPSAodTMyICopbnZtZW1fY2VsbF9yZWFk
KGNlbGwsICZsZW4pOw0KKwludm1lbV9jZWxsX3B1dChjZWxsKTsNCisNCisJaWYgKElTX0VSUihi
dWYpKSB7DQorCQlkZXZfaW5mbyhtaXBpX3R4LT5kZXYsICJjYW4ndCBnZXQgZGF0YSwgaWdub3Jl
IGl0XG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlpZiAobGVuIDwgMyAqIHNpemVvZih1MzIp
KSB7DQorCQlkZXZfaW5mbyhtaXBpX3R4LT5kZXYsICJpbnZhbGlkIGNhbGlicmF0aW9uIGRhdGFc
biIpOw0KKwkJa2ZyZWUoYnVmKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwltaXBpX3R4LT5ydF9j
b2RlWzBdID0gKChidWZbMF0gPj4gNiAmIDB4MWYpIDw8IDUpIHwNCisJCQkgICAgICAgKGJ1Zlsw
XSA+PiAxMSAmIDB4MWYpOw0KKwltaXBpX3R4LT5ydF9jb2RlWzFdID0gKChidWZbMV0gPj4gMjcg
JiAweDFmKSA8PCA1KSB8DQorCQkJICAgICAgIChidWZbMF0gPj4gMSAmIDB4MWYpOw0KKwltaXBp
X3R4LT5ydF9jb2RlWzJdID0gKChidWZbMV0gPj4gMTcgJiAweDFmKSA8PCA1KSB8DQorCQkJICAg
ICAgIChidWZbMV0gPj4gMjIgJiAweDFmKTsNCisJbWlwaV90eC0+cnRfY29kZVszXSA9ICgoYnVm
WzFdID4+IDcgJiAweDFmKSA8PCA1KSB8DQorCQkJICAgICAgIChidWZbMV0gPj4gMTIgJiAweDFm
KTsNCisJbWlwaV90eC0+cnRfY29kZVs0XSA9ICgoYnVmWzJdID4+IDI3ICYgMHgxZikgPDwgNSkg
fA0KKwkJCSAgICAgICAoYnVmWzFdID4+IDIgJiAweDFmKTsNCisJa2ZyZWUoYnVmKTsNCit9DQor
DQogc3RhdGljIGludCBtdGtfbWlwaV90eF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIHsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCkBAIC0xNzQsNiAr
MjEyLDggQEAgc3RhdGljIGludCBtdGtfbWlwaV90eF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIA0KIAltaXBpX3R4LT5kZXYgPSBkZXY7DQogDQorCW10a19taXBpX3R4X2dl
dF9jYWxpYnJhdGlvbl9kYXRhbChtaXBpX3R4KTsNCisNCiAJcmV0dXJuIG9mX2Nsa19hZGRfcHJv
dmlkZXIoZGV2LT5vZl9ub2RlLCBvZl9jbGtfc3JjX3NpbXBsZV9nZXQsDQogCQkJCSAgIG1pcGlf
dHgtPnBsbCk7DQogfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bWlwaV90eC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmgNCmluZGV4
IGVlYTQ0MzI3ZmU5Zi4uYzc2ZjA3YzNmZGViIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19taXBpX3R4LmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfbWlwaV90eC5oDQpAQCAtMTIsOSArMTIsMTEgQEANCiAjaW5jbHVkZSA8bGludXgvZGVsYXku
aD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQor
I2luY2x1ZGUgPGxpbnV4L252bWVtLWNvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2Rl
dmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8
bGludXgvcGh5L3BoeS5oPg0KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogDQogc3RydWN0IG10
a19taXBpdHhfZGF0YSB7DQogCWNvbnN0IHUzMiBtcHBsbF9wcmVzZXJ2ZTsNCkBAIC0yOCw2ICsz
MCw3IEBAIHN0cnVjdCBtdGtfbWlwaV90eCB7DQogCXZvaWQgX19pb21lbSAqcmVnczsNCiAJdTMy
IGRhdGFfcmF0ZTsNCiAJdTMyIG1pcGl0eF9kcml2ZTsNCisJdTMyIHJ0X2NvZGVbNV07DQogCWNv
bnN0IHN0cnVjdCBtdGtfbWlwaXR4X2RhdGEgKmRyaXZlcl9kYXRhOw0KIAlzdHJ1Y3QgY2xrX2h3
IHBsbF9odzsNCiAJc3RydWN0IGNsayAqcGxsOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfbXQ4MTgzX21pcGlfdHguYw0KaW5kZXggZTRjYzk2Nzc1MGNiLi45ZjNlNTVhZWViYjIg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYw0K
QEAgLTI4LDYgKzI4LDcgQEANCiAjZGVmaW5lIE1JUElUWF9QTExfQ09ONAkJMHgwMDNjDQogI2Rl
ZmluZSBSR19EU0lfUExMX0lCSUFTCQkoMyA8PCAxMCkNCiANCisjZGVmaW5lIE1JUElUWF9EMlBf
UlRDT0RFCTB4MDEwMA0KICNkZWZpbmUgTUlQSVRYX0QyX1NXX0NUTF9FTgkweDAxNDQNCiAjZGVm
aW5lIE1JUElUWF9EMF9TV19DVExfRU4JMHgwMjQ0DQogI2RlZmluZSBNSVBJVFhfQ0tfQ0tNT0RF
X0VOCTB4MDMyOA0KQEAgLTEwOCw2ICsxMDksMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtf
b3BzIG10a19taXBpX3R4X3BsbF9vcHMgPSB7DQogCS5yZWNhbGNfcmF0ZSA9IG10a19taXBpX3R4
X3BsbF9yZWNhbGNfcmF0ZSwNCiB9Ow0KIA0KK3N0YXRpYyB2b2lkIG10a19taXBpX3R4X2NvbmZp
Z19jYWxpYnJhdGlvbl9kYXRhKHN0cnVjdCBtdGtfbWlwaV90eCAqbWlwaV90eCkNCit7DQorCWlu
dCBpLCBqOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgNTsgaSsrKSB7DQorCQlpZiAoKG1pcGlfdHgt
PnJ0X2NvZGVbaV0gJiAweDFmKSA9PSAwKQ0KKwkJCW1pcGlfdHgtPnJ0X2NvZGVbaV0gfD0gMHgx
MDsNCisNCisJCWlmICgobWlwaV90eC0+cnRfY29kZVtpXSA+PiA1ICYgMHgxZikgPT0gMCkNCisJ
CQltaXBpX3R4LT5ydF9jb2RlW2ldIHw9IDB4MTAgPDwgNTsNCisNCisJCWZvciAoaiA9IDA7IGog
PCAxMDsgaisrKQ0KKwkJCW10a19taXBpX3R4X3VwZGF0ZV9iaXRzKG1pcGlfdHgsDQorCQkJCU1J
UElUWF9EMlBfUlRDT0RFICogKGkgKyAxKSArIGogKiA0LA0KKwkJCQkxLCBtaXBpX3R4LT5ydF9j
b2RlW2ldID4+IGogJiAxKTsNCisJfQ0KK30NCisNCiBzdGF0aWMgdm9pZCBtdGtfbWlwaV90eF9w
b3dlcl9vbl9zaWduYWwoc3RydWN0IHBoeSAqcGh5KQ0KIHsNCiAJc3RydWN0IG10a19taXBpX3R4
ICptaXBpX3R4ID0gcGh5X2dldF9kcnZkYXRhKHBoeSk7DQpAQCAtMTMwLDYgKzE0OSw4IEBAIHN0
YXRpYyB2b2lkIG10a19taXBpX3R4X3Bvd2VyX29uX3NpZ25hbChzdHJ1Y3QgcGh5ICpwaHkpDQog
CQkJCVJHX0RTSV9IU1RYX0xET19SRUZfU0VMLA0KIAkJCQkobWlwaV90eC0+bWlwaXR4X2RyaXZl
IC0gMzAwMCkgLyAyMDAgPDwgNik7DQogDQorCW10a19taXBpX3R4X2NvbmZpZ19jYWxpYnJhdGlv
bl9kYXRhKG1pcGlfdHgpOw0KKw0KIAltdGtfbWlwaV90eF9zZXRfYml0cyhtaXBpX3R4LCBNSVBJ
VFhfQ0tfQ0tNT0RFX0VOLCBEU0lfQ0tfQ0tNT0RFX0VOKTsNCiB9DQogDQotLSANCjIuMjEuMA0K

