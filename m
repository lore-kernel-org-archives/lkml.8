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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A682080C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RLCN62+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgCCF3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:29:11 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:58435 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727174AbgCCF3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:29:11 -0500
X-UUID: 45cf88fcc2b047f2bbd92d85db28eb50-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sB31c1utjXoEI0bkxHgvZA0r/O+d8TC2fbnDDVG92d8=;
        b=RLCN62+1nXVlFbVoOONZPrKcEpjwpH18fb0tQ1Uzx7AEIjjwyZrDne8Ed7wbL3UA850GmC4/DQUoysxzV9t6GW1kxyFlqmgvQZIiOCDiqYazlYf20omM7u4q2IF2bPS5Bx4J3bHznYpFpAfDxcfmHJ4T3PQ7Y2trnMk1b1L11Kg=;
X-UUID: 45cf88fcc2b047f2bbd92d85db28eb50-20200303
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1542098083; Tue, 03 Mar 2020 13:28:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar
 2020 13:23:39 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 3 Mar 2020 13:28:31 +0800
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
Subject: [PATCH v12 6/6] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Tue, 3 Mar 2020 13:27:22 +0800
Message-ID: <20200303052722.94795-7-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200303052722.94795-1-jitao.shi@mediatek.com>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A7DA1D6B70A54B88BB92C62DF5B57B82FE7C188A7E6E462BA9E92C17D90207F02000:8
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
Yw0KaW5kZXggZGIzMjcyZjdhNGM0Li5iNjM1OWU5Nzk1ODggMTAwNjQ0DQotLS0gYS9kcml2ZXJz
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
ZShkcGktPnBpbmN0cmwsICJzbGVlcCIpOw0KKwkJaWYgKElTX0VSUihkcGktPnBpbnNfZ3Bpbykp
IHsNCisJCQlkcGktPnBpbnNfZ3BpbyA9IE5VTEw7DQorCQkJZGV2X2RiZygmcGRldi0+ZGV2LCAi
Q2Fubm90IGZpbmQgcGluY3RybCBpZGxlIVxuIik7DQorCQl9DQorCQlpZiAoZHBpLT5waW5zX2dw
aW8pDQorCQkJcGluY3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZ3Bp
byk7DQorDQorCQlkcGktPnBpbnNfZHBpID0gcGluY3RybF9sb29rdXBfc3RhdGUoZHBpLT5waW5j
dHJsLCAiZGVmYXVsdCIpOw0KKwkJaWYgKElTX0VSUihkcGktPnBpbnNfZHBpKSkgew0KKwkJCWRw
aS0+cGluc19kcGkgPSBOVUxMOw0KKwkJCWRldl9kYmcoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5k
IHBpbmN0cmwgYWN0aXZlIVxuIik7DQorCQl9DQorCX0NCiAJbWVtID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJZHBpLT5yZWdzID0gZGV2bV9pb3Jl
bWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCiAJaWYgKElTX0VSUihkcGktPnJlZ3MpKSB7DQotLSAN
CjIuMjEuMA0K

