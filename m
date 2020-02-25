Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B883C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A7A21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eALK+AzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgBYGrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:47:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43864 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726936AbgBYGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:47:15 -0500
X-UUID: d51652eed4cf43c38c8c9510bab19513-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ah93O+SRvsLWOuwyTs14lXjM9jwFW/4/KiNPMynf+hs=;
        b=eALK+AzOn6zcq9t4LsQPV7Z7W+m6XoFD+kyabPd2LALvrqjF3F4uNU1u/p45qgSsIgyxvjZdI/NDYxEFReP3j+tRxpPgsK/F4eB9kytNpzD960DR4v9WfXdlSy8Sfs5UbqdVlKwkzV2Gc1sPHi9yAoWoDxFf7G9XbZrFcx6o8ZQ=;
X-UUID: d51652eed4cf43c38c8c9510bab19513-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1254474963; Tue, 25 Feb 2020 14:46:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 14:45:28 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 14:45:30 +0800
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
Subject: [PATCH v7 4/4] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Tue, 25 Feb 2020 14:46:38 +0800
Message-ID: <20200225064638.112282-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225064638.112282-1-jitao.shi@mediatek.com>
References: <20200225064638.112282-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2CF4D1DC9803C00A81C421A3E9B72BDFE2CAB33A816F6AD4A1F35BE5DCC8070D2000:8
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
MzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
Yw0KaW5kZXggYzNlNjMxYjkzYzJlLi5jYTU3MDA0MGZmZGYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
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
X2RwaSk7DQorDQogCW10a19kcGlfZW5hYmxlKGRwaSk7DQogCXJldHVybiAwOw0KIA0KQEAgLTcx
Niw4ICs3MjcsMjYgQEAgc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogDQogCWRwaS0+ZGV2ID0gZGV2Ow0KIAlkcGktPmNvbmYgPSAoc3RydWN0
IG10a19kcGlfY29uZiAqKW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KLQlkcGktPnBj
bGtfc2FtcGxlID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgoZGV2LT5vZl9ub2RlLA0KLQkJ
CQkJCSAgICAgICJwY2xrLXNhbXBsZSIpOw0KKwlvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChk
ZXYtPm9mX25vZGUsICJwY2xrLXNhbXBsZSIsIDEsDQorCQkJCSAgICZkcGktPnBjbGtfc2FtcGxl
KTsNCisNCisJZHBpLT5waW5jdHJsID0gZGV2bV9waW5jdHJsX2dldCgmcGRldi0+ZGV2KTsNCisJ
aWYgKElTX0VSUihkcGktPnBpbmN0cmwpKQ0KKwkJZGV2X2RiZygmcGRldi0+ZGV2LCAiQ2Fubm90
IGZpbmQgcGluY3RybCFcbiIpOw0KKw0KKwlkcGktPnBpbnNfZ3BpbyA9IHBpbmN0cmxfbG9va3Vw
X3N0YXRlKGRwaS0+cGluY3RybCwgImdwaW9tb2RlIik7DQorCWlmIChJU19FUlIoZHBpLT5waW5z
X2dwaW8pKSB7DQorCQlkcGktPnBpbnNfZ3BpbyA9IE5VTEw7DQorCQlkZXZfZGJnKCZwZGV2LT5k
ZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIGdwaW9tb2RlIVxuIik7DQorCX0NCisJaWYgKGRwaS0+
cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCisJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+
cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KKw0KKwlkcGktPnBpbnNfZHBpID0gcGluY3RybF9s
b29rdXBfc3RhdGUoZHBpLT5waW5jdHJsLCAiZHBpbW9kZSIpOw0KKwlpZiAoSVNfRVJSKGRwaS0+
cGluc19kcGkpKSB7DQorCQlkcGktPnBpbnNfZHBpID0gTlVMTDsNCisJCWRldl9kYmcoJnBkZXYt
PmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgZHBpbW9kZSFcbiIpOw0KKwl9DQogDQogCW1lbSA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQogCWRwaS0+
cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIG1lbSk7DQotLSANCjIuMjEuMA0K

