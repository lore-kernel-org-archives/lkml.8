Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603DDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7E1246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tj8fjfxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgB1IQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:16:26 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34991 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbgB1IQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:16:26 -0500
X-UUID: 0d424f0724a84460a3c9eb8dcaccc17a-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZURVBJvcNy7+s3YjJr/hwpBv6N9yfElSzaYb2eZ+VsU=;
        b=Tj8fjfxqK6xefdVl38PW4a0nNb12+pEhxrLQO0X/GDCrYF62RjBMz7h/cOHtQObObPAl4tjl70tMNlIXp3PFoAS+ONbBvDlSBEzkOJRBxUxmrBANJ98uBBJmSaoR8cG9Epa9jODcs9/YJ03Yi/mY90hRcOxn623j62JCsYAbKZA=;
X-UUID: 0d424f0724a84460a3c9eb8dcaccc17a-20200228
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 952329502; Fri, 28 Feb 2020 16:15:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 16:14:28 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 16:16:06 +0800
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
Subject: [PATCH v11 6/6] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Fri, 28 Feb 2020 16:14:41 +0800
Message-ID: <20200228081441.88179-7-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228081441.88179-1-jitao.shi@mediatek.com>
References: <20200228081441.88179-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4B695817580141192BDE9DB1EA1283C630CF297A489B08CFEF63122DE1C7CFB32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3aGVuIGRwaSBpcyBk
aXNhYmxlZC4NCkFvdmlkIGxlYWthZ2UgY3VycmVudCBmcm9tIHNvbWUgZHBpIHBpbnMgKEhzeW5j
IFZzeW5jIERFIC4uLiApLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwg
NDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDQyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
Yw0KaW5kZXggZGIzMjcyZjdhNGM0Li5mZWNlODY2MWQ4YjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwaS5jDQpAQCAtMTAsNyArMTAsOSBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCiAjaW5jbHVkZSA8bGludXgvb2YuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+
DQorI2luY2x1ZGUgPGxpbnV4L29mX2dwaW8uaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGgu
aD4NCisjaW5jbHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPg0KICNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCiANCkBAIC03
NCw2ICs3Niw5IEBAIHN0cnVjdCBtdGtfZHBpIHsNCiAJZW51bSBtdGtfZHBpX291dF95Y19tYXAg
eWNfbWFwOw0KIAllbnVtIG10a19kcGlfb3V0X2JpdF9udW0gYml0X251bTsNCiAJZW51bSBtdGtf
ZHBpX291dF9jaGFubmVsX3N3YXAgY2hhbm5lbF9zd2FwOw0KKwlzdHJ1Y3QgcGluY3RybCAqcGlu
Y3RybDsNCisJc3RydWN0IHBpbmN0cmxfc3RhdGUgKnBpbnNfZ3BpbzsNCisJc3RydWN0IHBpbmN0
cmxfc3RhdGUgKnBpbnNfZHBpOw0KIAlpbnQgcmVmY291bnQ7DQogCXUzMiBwY2xrX3NhbXBsZTsN
CiB9Ow0KQEAgLTM4Nyw2ICszOTIsOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX3Bvd2VyX29mZihz
dHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KIAlpZiAoLS1kcGktPnJlZmNvdW50ICE9IDApDQogCQlyZXR1
cm47DQogDQorCWlmIChkcGktPnBpbmN0cmwgJiYgZHBpLT5waW5zX2dwaW8pDQorCQlwaW5jdHJs
X3NlbGVjdF9zdGF0ZShkcGktPnBpbmN0cmwsIGRwaS0+cGluc19ncGlvKTsNCisNCiAJbXRrX2Rw
aV9kaXNhYmxlKGRwaSk7DQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPnBpeGVsX2Nsayk7
DQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPmVuZ2luZV9jbGspOw0KQEAgLTQxMSw2ICs0
MTksOSBAQCBzdGF0aWMgaW50IG10a19kcGlfcG93ZXJfb24oc3RydWN0IG10a19kcGkgKmRwaSkN
CiAJCWdvdG8gZXJyX3BpeGVsOw0KIAl9DQogDQorCWlmIChkcGktPnBpbmN0cmwgJiYgZHBpLT5w
aW5zX2RwaSkNCisJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5z
X2RwaSk7DQorDQogCW10a19kcGlfZW5hYmxlKGRwaSk7DQogCXJldHVybiAwOw0KIA0KQEAgLTcw
NSw2ICs3MTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxODNfY29u
ZiA9IHsNCiBzdGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiB7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQorCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqZXA7DQogCXN0cnVjdCBtdGtfZHBpICpkcGk7DQogCXN0cnVjdCByZXNvdXJj
ZSAqbWVtOw0KIAlpbnQgY29tcF9pZDsNCkBAIC03MTYsOSArNzI4LDM3IEBAIHN0YXRpYyBpbnQg
bXRrX2RwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAlkcGktPmRl
diA9IGRldjsNCiAJZHBpLT5jb25mID0gKHN0cnVjdCBtdGtfZHBpX2NvbmYgKilvZl9kZXZpY2Vf
Z2V0X21hdGNoX2RhdGEoZGV2KTsNCi0Jb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgoZGV2LT5v
Zl9ub2RlLCAicGNsay1zYW1wbGUiLCAxLA0KLQkJCQkgICAmZHBpLT5wY2xrX3NhbXBsZSk7DQog
DQorCWVwID0gb2ZfZ3JhcGhfZ2V0X2VuZHBvaW50X2J5X3JlZ3MoZGV2LT5vZl9ub2RlLCAwLCAw
KTsNCisJaWYgKCFlcCkgew0KKwkJZGV2X2VycihkZXYsICJGYWlsZWQgZ2V0IHRoZSBlbmRwb2lu
dCBwb3J0XG4iKTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQorDQorCS8qIEdldCB0aGUgc2Ft
cGxpbmcgZWRnZSBmcm9tIHRoZSBlbmRwb2ludC4gKi8NCisJb2ZfcHJvcGVydHlfcmVhZF91MzIo
ZXAsICJwY2xrLXNhbXBsZSIsICZkcGktPnBjbGtfc2FtcGxlKTsNCisJb2Zfbm9kZV9wdXQoZXAp
Ow0KKw0KKwlkcGktPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0KCZwZGV2LT5kZXYpOw0KKwlp
ZiAoSVNfRVJSKGRwaS0+cGluY3RybCkpIHsNCisJCWRwaS0+cGluY3RybCA9IE5VTEw7DQorCQlk
ZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIVxuIik7DQorCX0NCisJaWYg
KGRwaS0+cGluY3RybCkgew0KKwkJZHBpLT5waW5zX2dwaW8gPSBwaW5jdHJsX2xvb2t1cF9zdGF0
ZShkcGktPnBpbmN0cmwsICJpZGxlIik7DQorCQlpZiAoSVNfRVJSKGRwaS0+cGluc19ncGlvKSkg
ew0KKwkJCWRwaS0+cGluc19ncGlvID0gTlVMTDsNCisJCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJD
YW5ub3QgZmluZCBwaW5jdHJsIGlkbGUhXG4iKTsNCisJCX0NCisJCWlmIChkcGktPnBpbnNfZ3Bp
bykNCisJCQlwaW5jdHJsX3NlbGVjdF9zdGF0ZShkcGktPnBpbmN0cmwsIGRwaS0+cGluc19ncGlv
KTsNCisNCisJCWRwaS0+cGluc19kcGkgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShkcGktPnBpbmN0
cmwsICJhY3RpdmUiKTsNCisJCWlmIChJU19FUlIoZHBpLT5waW5zX2RwaSkpIHsNCisJCQlkcGkt
PnBpbnNfZHBpID0gTlVMTDsNCisJCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBw
aW5jdHJsIGFjdGl2ZSFcbiIpOw0KKwkJfQ0KKwl9DQogCW1lbSA9IHBsYXRmb3JtX2dldF9yZXNv
dXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQogCWRwaS0+cmVncyA9IGRldm1faW9yZW1h
cF9yZXNvdXJjZShkZXYsIG1lbSk7DQogCWlmIChJU19FUlIoZHBpLT5yZWdzKSkgew0KLS0gDQoy
LjIxLjANCg==

