Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE1C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F26F222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NnLryxhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBULbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:31:24 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:44920 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728018AbgBULbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:31:24 -0500
X-UUID: 930a4b4ddf6244fcb9076d480a603978-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EXe7y+o2d7iRqWPavTvifj5buUeUDoNRZjUZQ38OTRs=;
        b=NnLryxhD7hWPE9mnEDLPB+C6iqEmL1G+JR2DwT07Nw1nOSILg87GT0/B0GrXYFVumR4I65f9HxR45hlIJo8mVE1YvLeV6cN1ExpxJ7lUiBRh6RQznltIlwnCEroWVAvUNgToKHH+RdMh/hQt9/bhWiy7SUVZklEzzBLQj/RwaeI=;
X-UUID: 930a4b4ddf6244fcb9076d480a603978-20200221
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1200173710; Fri, 21 Feb 2020 19:28:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Feb
 2020 19:24:02 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 21 Feb 2020 19:27:37 +0800
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
Subject: [PATCH v6 4/4] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Fri, 21 Feb 2020 19:28:28 +0800
Message-ID: <20200221112828.55837-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200221112828.55837-1-jitao.shi@mediatek.com>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9A8E6822595FF18CCA96293E9D8AAB0CAD367449040DC0B45EFD2AD7116372492000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHVsbCBkcGkgcGlucyBsb3cgd2hlbiBkcGkgaGFzIG5vdGhpbmcgdG8gZGlzcGxheS4gQW92aWQg
bGVha2FnZQ0KY3VycmVudCBmcm9tIHNvbWUgZHBpIHBpbnMgKEhzeW5jIFZzeW5jIERFIC4uLiAp
Lg0KDQpTb21lIGNoaXBzIGhhdmUgZHBpIHBpbnMsIGJ1dCB0aGVyZSBhcmUgc29tZSBjaGlwIGRv
bid0IGhhdmUgcGlucy4NClNvIHRoaXMgZnVuY3Rpb24gaXMgY29udHJvbGxlZCBieSBkZXZpY2Ug
dHJlZS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyB8IDM3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KaW5kZXggZTFhMzMyNTRkZmJlLi40MTcx
MmU1YTcyMWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQpAQCAtMTAsNyArMTAs
OSBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvb2YuaD4N
CiAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX2dwaW8u
aD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4NCisjaW5jbHVkZSA8bGludXgvcGluY3Ry
bC9jb25zdW1lci5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4NCiANCkBAIC03NCw4ICs3NiwxMiBAQCBzdHJ1Y3QgbXRrX2Rw
aSB7DQogCWVudW0gbXRrX2RwaV9vdXRfeWNfbWFwIHljX21hcDsNCiAJZW51bSBtdGtfZHBpX291
dF9iaXRfbnVtIGJpdF9udW07DQogCWVudW0gbXRrX2RwaV9vdXRfY2hhbm5lbF9zd2FwIGNoYW5u
ZWxfc3dhcDsNCisJc3RydWN0IHBpbmN0cmwgKnBpbmN0cmw7DQorCXN0cnVjdCBwaW5jdHJsX3N0
YXRlICpwaW5zX2dwaW87DQorCXN0cnVjdCBwaW5jdHJsX3N0YXRlICpwaW5zX2RwaTsNCiAJaW50
IHJlZmNvdW50Ow0KIAlib29sIGR1YWxfZWRnZTsNCisJYm9vbCBkcGlfcGluX2N0cmw7DQogfTsN
CiANCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBtdGtfZHBpICptdGtfZHBpX2Zyb21fZW5jb2Rlcihz
dHJ1Y3QgZHJtX2VuY29kZXIgKmUpDQpAQCAtMzg3LDYgKzM5Myw5IEBAIHN0YXRpYyB2b2lkIG10
a19kcGlfcG93ZXJfb2ZmKHN0cnVjdCBtdGtfZHBpICpkcGkpDQogCWlmICgtLWRwaS0+cmVmY291
bnQgIT0gMCkNCiAJCXJldHVybjsNCiANCisJaWYgKGRwaS0+ZHBpX3Bpbl9jdHJsKQ0KKwkJcGlu
Y3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZ3Bpbyk7DQorDQogCW10
a19kcGlfZGlzYWJsZShkcGkpOw0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5waXhlbF9j
bGspOw0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5lbmdpbmVfY2xrKTsNCkBAIC00MTEs
NiArNDIwLDkgQEAgc3RhdGljIGludCBtdGtfZHBpX3Bvd2VyX29uKHN0cnVjdCBtdGtfZHBpICpk
cGkpDQogCQlnb3RvIGVycl9waXhlbDsNCiAJfQ0KIA0KKwlpZiAoZHBpLT5kcGlfcGluX2N0cmwp
DQorCQlwaW5jdHJsX3NlbGVjdF9zdGF0ZShkcGktPnBpbmN0cmwsIGRwaS0+cGluc19kcGkpOw0K
Kw0KIAltdGtfZHBpX2VuYWJsZShkcGkpOw0KIAlyZXR1cm4gMDsNCiANCkBAIC03MTYsNiArNzI4
LDMxIEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAlkcGktPmRldiA9IGRldjsNCiAJZHBpLT5jb25mID0gKHN0cnVjdCBtdGtfZHBpX2Nv
bmYgKilvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCiAJZHBpLT5kdWFsX2VkZ2UgPSBv
Zl9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LT5vZl9ub2RlLCAiZHBpX2R1YWxfZWRnZSIpOw0KKwlk
cGktPmRwaV9waW5fY3RybCA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYtPm9mX25vZGUsDQor
CQkJCQkJICAiZHBpX3Bpbl9tb2RlX3N3YXAiKTsNCisNCisJaWYgKGRwaS0+ZHBpX3Bpbl9jdHJs
KSB7DQorCQlkcGktPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0KCZwZGV2LT5kZXYpOw0KKwkJ
aWYgKElTX0VSUihkcGktPnBpbmN0cmwpKSB7DQorCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fu
bm90IGZpbmQgcGluY3RybCFcbiIpOw0KKwkJCXJldHVybiBQVFJfRVJSKGRwaS0+cGluY3RybCk7
DQorCQl9DQorDQorCQlkcGktPnBpbnNfZ3BpbyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRwaS0+
cGluY3RybCwNCisJCQkJCQkgICAgICAiZ3Bpb21vZGUiKTsNCisJCWlmIChJU19FUlIoZHBpLT5w
aW5zX2dwaW8pKSB7DQorCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3Ry
bCBncGlvbW9kZSFcbiIpOw0KKwkJCXJldHVybiBQVFJfRVJSKGRwaS0+cGluc19ncGlvKTsNCisJ
CX0NCisNCisJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2dw
aW8pOw0KKw0KKwkJZHBpLT5waW5zX2RwaSA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRwaS0+cGlu
Y3RybCwgImRwaW1vZGUiKTsNCisJCWlmIChJU19FUlIoZHBpLT5waW5zX2RwaSkpIHsNCisJCQlk
ZXZfZXJyKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIGRwaW1vZGUhXG4iKTsNCisJ
CQlyZXR1cm4gUFRSX0VSUihkcGktPnBpbnNfZHBpKTsNCisJCX0NCisJfQ0KIA0KIAltZW0gPSBw
bGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KIAlkcGktPnJl
Z3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCBtZW0pOw0KLS0gDQoyLjIxLjANCg==

