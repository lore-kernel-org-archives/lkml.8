Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9CC433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9573208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UrrfWmEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgGWCFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:05:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28225 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387744AbgGWCFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:05:00 -0400
X-UUID: 5da1960f1fef4b059b4fae46f302f882-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PQR+pTRUJr2p2puT6kEgda5uTBofuzbyJhCIDKViHyo=;
        b=UrrfWmEM8lHzjImmf5k9oRlssqM9kbkRKdL1PjMoNJACRgWsxIppljhHsuYVMuly0vjp4hvVOtswkMh0vwrR3ao50pjbP6W58y3oUOONsa1tDfd/6Fq1Ryjd1noOIy1ZMp8SsmqRLBfZ+p6sb2iK0Ll5JTk0NqyYHcLsts4Gvvw=;
X-UUID: 5da1960f1fef4b059b4fae46f302f882-20200723
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 928054689; Thu, 23 Jul 2020 10:04:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 10:04:54 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:04:49 +0800
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
Subject: [v7, PATCH 6/7] drm/mediatek: add fifo_size into rdma private data
Date:   Thu, 23 Jul 2020 10:03:17 +0800
Message-ID: <1595469798-3824-7-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhlIGZpZm8gc2l6ZSBvZiByZG1hIGluIG10ODE4MyBpcyBkaWZmZXJlbnQuDQpyZG1hMCBmaWZv
IHNpemUgaXMgNWsNCnJkbWExIGZpZm8gc2l6ZSBpcyAyaw0KDQpTaWduZWQtb2ZmLWJ5OiBZb25n
cWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgfCAxOSArKysrKysrKysrKysrKysrKystDQog
MSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQppbmRleCBlMDQzMTlmLi43OTRhY2M1
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KQEAgLTYzLDYg
KzYzLDcgQEAgc3RydWN0IG10a19kaXNwX3JkbWEgew0KIAlzdHJ1Y3QgbXRrX2RkcF9jb21wCQlk
ZHBfY29tcDsNCiAJc3RydWN0IGRybV9jcnRjCQkJKmNydGM7DQogCWNvbnN0IHN0cnVjdCBtdGtf
ZGlzcF9yZG1hX2RhdGEJKmRhdGE7DQorCXUzMgkJCQlmaWZvX3NpemU7DQogfTsNCiANCiBzdGF0
aWMgaW5saW5lIHN0cnVjdCBtdGtfZGlzcF9yZG1hICpjb21wX3RvX3JkbWEoc3RydWN0IG10a19k
ZHBfY29tcCAqY29tcCkNCkBAIC0xMzEsMTIgKzEzMiwxOCBAQCBzdGF0aWMgdm9pZCBtdGtfcmRt
YV9jb25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50IHdpZHRoLA0K
IAl1bnNpZ25lZCBpbnQgdGhyZXNob2xkOw0KIAl1bnNpZ25lZCBpbnQgcmVnOw0KIAlzdHJ1Y3Qg
bXRrX2Rpc3BfcmRtYSAqcmRtYSA9IGNvbXBfdG9fcmRtYShjb21wKTsNCisJdTMyIHJkbWFfZmlm
b19zaXplOw0KIA0KIAltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIHdpZHRoLCBjb21wLA0K
IAkJCSAgIERJU1BfUkVHX1JETUFfU0laRV9DT05fMCwgMHhmZmYpOw0KIAltdGtfZGRwX3dyaXRl
X21hc2soY21kcV9wa3QsIGhlaWdodCwgY29tcCwNCiAJCQkgICBESVNQX1JFR19SRE1BX1NJWkVf
Q09OXzEsIDB4ZmZmZmYpOw0KIA0KKwlpZiAocmRtYS0+Zmlmb19zaXplKQ0KKwkJcmRtYV9maWZv
X3NpemUgPSByZG1hLT5maWZvX3NpemU7DQorCWVsc2UNCisJCXJkbWFfZmlmb19zaXplID0gUkRN
QV9GSUZPX1NJWkUocmRtYSk7DQorDQogCS8qDQogCSAqIEVuYWJsZSBGSUZPIHVuZGVyZmxvdyBz
aW5jZSBEU0kgYW5kIERQSSBjYW4ndCBiZSBibG9ja2VkLg0KIAkgKiBLZWVwIHRoZSBGSUZPIHBz
ZXVkbyBzaXplIHJlc2V0IGRlZmF1bHQgb2YgOCBLaUIuIFNldCB0aGUNCkBAIC0xNDUsNyArMTUy
LDcgQEAgc3RhdGljIHZvaWQgbXRrX3JkbWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNv
bXAsIHVuc2lnbmVkIGludCB3aWR0aCwNCiAJICovDQogCXRocmVzaG9sZCA9IHdpZHRoICogaGVp
Z2h0ICogdnJlZnJlc2ggKiA0ICogNyAvIDEwMDAwMDA7DQogCXJlZyA9IFJETUFfRklGT19VTkRF
UkZMT1dfRU4gfA0KLQkgICAgICBSRE1BX0ZJRk9fUFNFVURPX1NJWkUoUkRNQV9GSUZPX1NJWkUo
cmRtYSkpIHwNCisJICAgICAgUkRNQV9GSUZPX1BTRVVET19TSVpFKHJkbWFfZmlmb19zaXplKSB8
DQogCSAgICAgIFJETUFfT1VUUFVUX1ZBTElEX0ZJRk9fVEhSRVNIT0xEKHRocmVzaG9sZCk7DQog
CW10a19kZHBfd3JpdGUoY21kcV9wa3QsIHJlZywgY29tcCwgRElTUF9SRUdfUkRNQV9GSUZPX0NP
Tik7DQogfQ0KQEAgLTI5MSw2ICsyOTgsMTYgQEAgc3RhdGljIGludCBtdGtfZGlzcF9yZG1hX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gY29tcF9pZDsNCiAJ
fQ0KIA0KKwlpZiAob2ZfZmluZF9wcm9wZXJ0eShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxyZG1h
X2ZpZm9fc2l6ZSIsICZyZXQpKSB7DQorCQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihkZXYt
Pm9mX25vZGUsDQorCQkJCQkgICAibWVkaWF0ZWsscmRtYV9maWZvX3NpemUiLA0KKwkJCQkJICAg
JnByaXYtPmZpZm9fc2l6ZSk7DQorCQlpZiAocmV0KSB7DQorCQkJZGV2X2VycihkZXYsICJGYWls
ZWQgdG8gZ2V0IHJkbWEgZmlmbyBzaXplXG4iKTsNCisJCQlyZXR1cm4gcmV0Ow0KKwkJfQ0KKwl9
DQorDQogCXJldCA9IG10a19kZHBfY29tcF9pbml0KGRldiwgZGV2LT5vZl9ub2RlLCAmcHJpdi0+
ZGRwX2NvbXAsIGNvbXBfaWQsDQogCQkJCSZtdGtfZGlzcF9yZG1hX2Z1bmNzKTsNCiAJaWYgKHJl
dCkgew0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

