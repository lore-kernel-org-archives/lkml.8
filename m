Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858F82070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FLdCfQzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgE3IN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:13:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44427 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:13:58 -0400
X-UUID: 2508e1b9253f4443a4af264eb39a7d90-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bmH7fMDhBXTZkXnZCBeHpG/EY1LSFoVwd2Y4WvtFHEE=;
        b=FLdCfQzVXtrw2Y6J0TZ/aZsLRc9fBFVZhAV8lngS80f2J9AIvg4HhaABJEAhDSJ8GHtazDqP0h9EVDKWih4PoDYLxloMSYuwTADCnHVE07sqxUAP6X4B1R/FA3YRXK05La7LyKF3P6UqKYOz/YPiyqLfAkB5Too1XXXdNSzMb/w=;
X-UUID: 2508e1b9253f4443a4af264eb39a7d90-20200530
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2058549102; Sat, 30 May 2020 16:13:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:49 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v4 10/17] drm/mediatek: Add pm runtime support for ovl and rdma
Date:   Sat, 30 May 2020 16:10:11 +0800
Message-ID: <1590826218-23653-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQoNCkRpc3Bs
YXkgdXNlIHRoZSBkaXNwc3lzIGRldmljZSB0byBjYWxsIHBtX3J1bXRpbWVfZ2V0X3N5bmMgYmVm
b3JlLg0KVGhpcyBwYXRjaCBhZGQgcG1fcnVudGltZV94eCB3aXRoIG92bCBhbmQgcmRtYSBkZXZp
Y2Ugd2hvc2Ugbm9kZXMgaGFzDQoiaW9tbXVzIiBwcm9wZXJ0eSwgdGhlbiBkaXNwbGF5IGNvdWxk
IGhlbHAgcG1fcnVudGltZV9nZXQgZm9yIHNtaSB2aWENCm92bCBvciByZG1hIGRldmljZS4NCg0K
VGhpcyBpcyBhIHByZXBhcmluZyBwYXRjaCB0aGF0IHNtaSBjbGVhbmluZyB1cCAibWVkaWF0ZWss
bGFyYiIuDQoNCkNDOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTog
WW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgfCAgOSArKysrKysrKy0NCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgIHwgIDkgKysrKysrKystDQogZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8IDEyICsrKysrKysrKysrLQ0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAgMiArKw0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgMSArDQogNSBmaWxlcyBj
aGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bC5jDQppbmRleCA4OTFkODBjLi4xN2M5YmFhIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCkBAIC0xMSw2ICsxMSw3IEBADQog
I2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4N
CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3Bt
X3J1bnRpbWUuaD4NCiAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQog
DQogI2luY2x1ZGUgIm10a19kcm1fY3J0Yy5oIg0KQEAgLTM5OSw5ICs0MDAsMTMgQEAgc3RhdGlj
IGludCBtdGtfZGlzcF9vdmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
CXJldHVybiByZXQ7DQogCX0NCiANCisJcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCisNCiAJcmV0
ID0gY29tcG9uZW50X2FkZChkZXYsICZtdGtfZGlzcF9vdmxfY29tcG9uZW50X29wcyk7DQotCWlm
IChyZXQpDQorCWlmIChyZXQpIHsNCisJCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KIAkJZGV2
X2VycihkZXYsICJGYWlsZWQgdG8gYWRkIGNvbXBvbmVudDogJWRcbiIsIHJldCk7DQorCX0NCiAN
CiAJcmV0dXJuIHJldDsNCiB9DQpAQCAtNDEwLDYgKzQxNSw4IEBAIHN0YXRpYyBpbnQgbXRrX2Rp
c3Bfb3ZsX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJY29tcG9u
ZW50X2RlbCgmcGRldi0+ZGV2LCAmbXRrX2Rpc3Bfb3ZsX2NvbXBvbmVudF9vcHMpOw0KIA0KKwlw
bV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQorDQogCXJldHVybiAwOw0KIH0NCiANCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KaW5kZXggMGNiODQ4ZC4uNWVh
OGZiNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1h
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCkBAIC05
LDYgKzksNyBAQA0KICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvb2ZfaXJxLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNpbmNs
dWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oPg0KIA0KICNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCkBAIC0zMTMsOSArMzE0
LDEzIEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcmRtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIA0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwcml2KTsNCiANCisJ
cG1fcnVudGltZV9lbmFibGUoZGV2KTsNCisNCiAJcmV0ID0gY29tcG9uZW50X2FkZChkZXYsICZt
dGtfZGlzcF9yZG1hX2NvbXBvbmVudF9vcHMpOw0KLQlpZiAocmV0KQ0KKwlpZiAocmV0KSB7DQor
CQlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCiAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFk
ZCBjb21wb25lbnQ6ICVkXG4iLCByZXQpOw0KKwl9DQogDQogCXJldHVybiByZXQ7DQogfQ0KQEAg
LTMyNCw2ICszMjksOCBAQCBzdGF0aWMgaW50IG10a19kaXNwX3JkbWFfcmVtb3ZlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAljb21wb25lbnRfZGVsKCZwZGV2LT5kZXYsICZt
dGtfZGlzcF9yZG1hX2NvbXBvbmVudF9vcHMpOw0KIA0KKwlwbV9ydW50aW1lX2Rpc2FibGUoJnBk
ZXYtPmRldik7DQorDQogCXJldHVybiAwOw0KIH0NCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9jcnRjLmMNCmluZGV4IGZlODVlNDguLmM5YmM4NDQgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KQEAgLTUzOCw5ICs1MzgsMTUgQEAgc3RhdGljIHZv
aWQgbXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KIAkJ
cmV0dXJuOw0KIAl9DQogDQorCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoY29tcC0+ZGV2KTsN
CisJaWYgKHJldCA8IDApDQorCQlEUk1fREVWX0VSUk9SKGNvbXAtPmRldiwgIkZhaWxlZCB0byBl
bmFibGUgcG93ZXIgZG9tYWluOiAlZFxuIiwNCisJCQkgICAgICByZXQpOw0KKw0KIAlyZXQgPSBt
dGtfY3J0Y19kZHBfaHdfaW5pdChtdGtfY3J0Yyk7DQogCWlmIChyZXQpIHsNCiAJCW10a19zbWlf
bGFyYl9wdXQoY29tcC0+bGFyYl9kZXYpOw0KKwkJcG1fcnVudGltZV9wdXQoY29tcC0+ZGV2KTsN
CiAJCXJldHVybjsNCiAJfQ0KIA0KQEAgLTU1Myw3ICs1NTksNyBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHJtX2NydGNfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KIHsNCiAJc3Ry
dWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMgPSB0b19tdGtfY3J0YyhjcnRjKTsNCiAJc3RydWN0
IG10a19kZHBfY29tcCAqY29tcCA9IG10a19jcnRjLT5kZHBfY29tcFswXTsNCi0JaW50IGk7DQor
CWludCBpLCByZXQ7DQogDQogCURSTV9ERUJVR19EUklWRVIoIiVzICVkXG4iLCBfX2Z1bmNfXywg
Y3J0Yy0+YmFzZS5pZCk7DQogCWlmICghbXRrX2NydGMtPmVuYWJsZWQpDQpAQCAtNTc3LDYgKzU4
MywxMCBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRy
bV9jcnRjICpjcnRjLA0KIAlkcm1fY3J0Y192Ymxhbmtfb2ZmKGNydGMpOw0KIAltdGtfY3J0Y19k
ZHBfaHdfZmluaShtdGtfY3J0Yyk7DQogCW10a19zbWlfbGFyYl9wdXQoY29tcC0+bGFyYl9kZXYp
Ow0KKwlyZXQgPSBwbV9ydW50aW1lX3B1dChjb21wLT5kZXYpOw0KKwlpZiAocmV0IDwgMCkNCisJ
CURSTV9ERVZfRVJST1IoY29tcC0+ZGV2LCAiRmFpbGVkIHRvIGRpc2FibGUgcG93ZXIgZG9tYWlu
OiAlZFxuIiwNCisJCQkgICAgICByZXQpOw0KIA0KIAltdGtfY3J0Yy0+ZW5hYmxlZCA9IGZhbHNl
Ow0KIH0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KaW5k
ZXggNTdjODhkZS4uNTkzMDI3YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMNCkBAIC00OTMsNiArNDkzLDggQEAgaW50IG10a19kZHBfY29tcF9pbml0
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KIA0KIAljb21w
LT5sYXJiX2RldiA9ICZsYXJiX3BkZXYtPmRldjsNCiANCisJY29tcC0+ZGV2ID0gZGV2Ow0KKw0K
ICNpZiBJU19SRUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0KIAlpZiAob2ZfYWRkcmVzc190b19y
ZXNvdXJjZShub2RlLCAwLCAmcmVzKSAhPSAwKSB7DQogCQlkZXZfZXJyKGRldiwgIk1pc3Npbmcg
cmVnIGluICVzIG5vZGVcbiIsIG5vZGUtPmZ1bGxfbmFtZSk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCmluZGV4IGRlYmUzNjMuLjRjMDYzZTAgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQpAQCAtOTksNiAr
OTksNyBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21wIHsNCiAJdm9pZCBfX2lvbWVtICpyZWdzOw0KIAlp
bnQgaXJxOw0KIAlzdHJ1Y3QgZGV2aWNlICpsYXJiX2RldjsNCisJc3RydWN0IGRldmljZSAqZGV2
Ow0KIAllbnVtIG10a19kZHBfY29tcF9pZCBpZDsNCiAJY29uc3Qgc3RydWN0IG10a19kZHBfY29t
cF9mdW5jcyAqZnVuY3M7DQogCXJlc291cmNlX3NpemVfdCByZWdzX3BhOw0KLS0gDQoxLjkuMQ0K

