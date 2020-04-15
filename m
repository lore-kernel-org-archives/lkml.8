Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD3C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B0D2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u9F4vImH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbgDOBNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:13:55 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388394AbgDOBNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:13:34 -0400
X-UUID: 6b2547368f62461696c9d15b020bfc5c-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jaJQuh8fvp6T9Be9ipJU3hsADftSb0W/4ALoBtZp+2k=;
        b=u9F4vImHJ9YxND0bBd3lhYXXSUqIqcZYHsgEpM7eimTaJzH11WJmQV60u5CG16ZWgVkexXX8qzJXu/jJWbS/o9NHld0dJkAwCyc2Jb+pI8egfiDJUspn9NmY0qU/bJujeb1Ux2CsW8fp+D9o+Rva87PtPdVt+JKlrqRHhYJeCIs=;
X-UUID: 6b2547368f62461696c9d15b020bfc5c-20200415
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1741448416; Wed, 15 Apr 2020 09:13:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Apr
 2020 09:13:26 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 09:13:23 +0800
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
Subject: [PATCH v15 3/3] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Wed, 15 Apr 2020 09:13:19 +0800
Message-ID: <20200415011319.25559-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20200415011319.25559-1-jitao.shi@mediatek.com>
References: <20200415011319.25559-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C3AD1FEB0857C1B01CAC2862F68CBFD9E7616DEFBCFC35987262C8A2BEE0528C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3aGVuIGRwaSBpcyBk
aXNhYmxlZC4NCkFvdmlkIGxlYWthZ2UgY3VycmVudCBmcm9tIHNvbWUgZHBpIHBpbnMgKEhzeW5j
IFZzeW5jIERFIC4uLiApLg0KDQpSZXZpZXdlZC1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5n
Lmh1QGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgMzEg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rw
aS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KaW5kZXggMDg3ZjVjZTcz
MmUxLi4xZTAxMjU0Nzg4ZDkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQpAQCAt
MTAsNyArMTAsOSBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvb2YuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4
L29mX2dwaW8uaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4NCisjaW5jbHVkZSA8bGlu
dXgvcGluY3RybC9jb25zdW1lci5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCiANCkBAIC03NCw2ICs3Niw5IEBAIHN0cnVj
dCBtdGtfZHBpIHsNCiAJZW51bSBtdGtfZHBpX291dF95Y19tYXAgeWNfbWFwOw0KIAllbnVtIG10
a19kcGlfb3V0X2JpdF9udW0gYml0X251bTsNCiAJZW51bSBtdGtfZHBpX291dF9jaGFubmVsX3N3
YXAgY2hhbm5lbF9zd2FwOw0KKwlzdHJ1Y3QgcGluY3RybCAqcGluY3RybDsNCisJc3RydWN0IHBp
bmN0cmxfc3RhdGUgKnBpbnNfZ3BpbzsNCisJc3RydWN0IHBpbmN0cmxfc3RhdGUgKnBpbnNfZHBp
Ow0KIAlpbnQgcmVmY291bnQ7DQogfTsNCiANCkBAIC0zNzksNiArMzg0LDkgQEAgc3RhdGljIHZv
aWQgbXRrX2RwaV9wb3dlcl9vZmYoc3RydWN0IG10a19kcGkgKmRwaSkNCiAJaWYgKC0tZHBpLT5y
ZWZjb3VudCAhPSAwKQ0KIAkJcmV0dXJuOw0KIA0KKwlpZiAoZHBpLT5waW5jdHJsICYmIGRwaS0+
cGluc19ncGlvKQ0KKwkJcGluY3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBp
bnNfZ3Bpbyk7DQorDQogCW10a19kcGlfZGlzYWJsZShkcGkpOw0KIAljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZHBpLT5waXhlbF9jbGspOw0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5lbmdp
bmVfY2xrKTsNCkBAIC00MDMsNiArNDExLDkgQEAgc3RhdGljIGludCBtdGtfZHBpX3Bvd2VyX29u
KHN0cnVjdCBtdGtfZHBpICpkcGkpDQogCQlnb3RvIGVycl9waXhlbDsNCiAJfQ0KIA0KKwlpZiAo
ZHBpLT5waW5jdHJsICYmIGRwaS0+cGluc19kcGkpDQorCQlwaW5jdHJsX3NlbGVjdF9zdGF0ZShk
cGktPnBpbmN0cmwsIGRwaS0+cGluc19kcGkpOw0KKw0KIAltdGtfZHBpX2VuYWJsZShkcGkpOw0K
IAlyZXR1cm4gMDsNCiANCkBAIC03MDUsNiArNzE2LDI2IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlkcGktPmRldiA9IGRldjsNCiAJ
ZHBpLT5jb25mID0gKHN0cnVjdCBtdGtfZHBpX2NvbmYgKilvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoZGV2KTsNCiANCisJZHBpLT5waW5jdHJsID0gZGV2bV9waW5jdHJsX2dldCgmcGRldi0+ZGV2
KTsNCisJaWYgKElTX0VSUihkcGktPnBpbmN0cmwpKSB7DQorCQlkcGktPnBpbmN0cmwgPSBOVUxM
Ow0KKwkJZGV2X2RiZygmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3RybCFcbiIpOw0KKwl9
DQorCWlmIChkcGktPnBpbmN0cmwpIHsNCisJCWRwaS0+cGluc19ncGlvID0gcGluY3RybF9sb29r
dXBfc3RhdGUoZHBpLT5waW5jdHJsLCAic2xlZXAiKTsNCisJCWlmIChJU19FUlIoZHBpLT5waW5z
X2dwaW8pKSB7DQorCQkJZHBpLT5waW5zX2dwaW8gPSBOVUxMOw0KKwkJCWRldl9kYmcoJnBkZXYt
PmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgaWRsZSFcbiIpOw0KKwkJfQ0KKwkJaWYgKGRwaS0+
cGluc19ncGlvKQ0KKwkJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5w
aW5zX2dwaW8pOw0KKw0KKwkJZHBpLT5waW5zX2RwaSA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRw
aS0+cGluY3RybCwgImRlZmF1bHQiKTsNCisJCWlmIChJU19FUlIoZHBpLT5waW5zX2RwaSkpIHsN
CisJCQlkcGktPnBpbnNfZHBpID0gTlVMTDsNCisJCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5u
b3QgZmluZCBwaW5jdHJsIGFjdGl2ZSFcbiIpOw0KKwkJfQ0KKwl9DQogCW1lbSA9IHBsYXRmb3Jt
X2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQogCWRwaS0+cmVncyA9IGRl
dm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIG1lbSk7DQogCWlmIChJU19FUlIoZHBpLT5yZWdzKSkg
ew0KLS0gDQoyLjEyLjUNCg==

