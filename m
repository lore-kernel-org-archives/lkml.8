Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C3C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C6124653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X16CoxP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgBZFdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:33:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:21882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbgBZFdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:33:13 -0500
X-UUID: e4ce7581da6f48f282f867ccedf16f1e-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x7STFyQuO/xyu34ZYtZeHjDau3Np4ocLuWWyy6b0cAI=;
        b=X16CoxP/dyFBzfjosrCDBmmZNMDYmZCpIhNWGFH4XJ0aTsHA+9gCNrsq5wFoNbHOHGxDfomaJEnezXW5C3vzR7JT02oNu01/7VpioFj2wOHes8lWZ/LZMfsmNqK3DGzcPPFmPMyK1cAIrWCgBB4FxrzKfJF+fnabxQpdtPIEYO8=;
X-UUID: e4ce7581da6f48f282f867ccedf16f1e-20200226
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 973007024; Wed, 26 Feb 2020 13:32:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Feb
 2020 13:28:53 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Feb 2020 13:31:28 +0800
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
Subject: [PATCH v9 5/5] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Wed, 26 Feb 2020 13:32:38 +0800
Message-ID: <20200226053238.31646-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226053238.31646-1-jitao.shi@mediatek.com>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FE2D5650BCB40F1CA1B9C24BBECF52B836DCD3F5FD44BDAEC5892942C903FDF62000:8
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
MzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQppbmRleCBkYjMyNzJm
N2E0YzQuLmFlNGM2MzA4YmI2OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCkBA
IC0xMCw3ICsxMCw5IEBADQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9vZi5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGlu
dXgvb2ZfZ3Bpby5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KIA0KQEAgLTc0LDYgKzc2LDkgQEAgc3Ry
dWN0IG10a19kcGkgew0KIAllbnVtIG10a19kcGlfb3V0X3ljX21hcCB5Y19tYXA7DQogCWVudW0g
bXRrX2RwaV9vdXRfYml0X251bSBiaXRfbnVtOw0KIAllbnVtIG10a19kcGlfb3V0X2NoYW5uZWxf
c3dhcCBjaGFubmVsX3N3YXA7DQorCXN0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KKwlzdHJ1Y3Qg
cGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KKwlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19k
cGk7DQogCWludCByZWZjb3VudDsNCiAJdTMyIHBjbGtfc2FtcGxlOw0KIH07DQpAQCAtMzg3LDYg
KzM5Miw5IEBAIHN0YXRpYyB2b2lkIG10a19kcGlfcG93ZXJfb2ZmKHN0cnVjdCBtdGtfZHBpICpk
cGkpDQogCWlmICgtLWRwaS0+cmVmY291bnQgIT0gMCkNCiAJCXJldHVybjsNCiANCisJaWYgKGRw
aS0+cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCisJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRw
aS0+cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KKw0KIAltdGtfZHBpX2Rpc2FibGUoZHBpKTsN
CiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+cGl4ZWxfY2xrKTsNCiAJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGRwaS0+ZW5naW5lX2Nsayk7DQpAQCAtNDExLDYgKzQxOSw5IEBAIHN0YXRpYyBp
bnQgbXRrX2RwaV9wb3dlcl9vbihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KIAkJZ290byBlcnJfcGl4
ZWw7DQogCX0NCiANCisJaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZHBpKQ0KKwkJcGlu
Y3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZHBpKTsNCisNCiAJbXRr
X2RwaV9lbmFibGUoZHBpKTsNCiAJcmV0dXJuIDA7DQogDQpAQCAtNzE5LDYgKzczMCwyNiBAQCBz
dGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
b2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgoZGV2LT5vZl9ub2RlLCAicGNsay1zYW1wbGUiLCAx
LA0KIAkJCQkgICAmZHBpLT5wY2xrX3NhbXBsZSk7DQogDQorCWRwaS0+cGluY3RybCA9IGRldm1f
cGluY3RybF9nZXQoJnBkZXYtPmRldik7DQorCWlmIChJU19FUlIoZHBpLT5waW5jdHJsKSkgew0K
KwkJZHBpLT5waW5jdHJsID0gTlVMTDsNCisJCWRldl9kYmcoJnBkZXYtPmRldiwgIkNhbm5vdCBm
aW5kIHBpbmN0cmwhXG4iKTsNCisJfQ0KKwlpZiAoZHBpLT5waW5jdHJsKSB7DQorCQlkcGktPnBp
bnNfZ3BpbyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRwaS0+cGluY3RybCwgImdwaW9tb2RlIik7
DQorCQlpZiAoSVNfRVJSKGRwaS0+cGluc19ncGlvKSkgew0KKwkJCWRwaS0+cGluc19ncGlvID0g
TlVMTDsNCisJCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIGdwaW9t
b2RlIVxuIik7DQorCQl9DQorCQlpZiAoZHBpLT5waW5zX2dwaW8pDQorCQkJcGluY3RybF9zZWxl
Y3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZ3Bpbyk7DQorDQorCQlkcGktPnBpbnNf
ZHBpID0gcGluY3RybF9sb29rdXBfc3RhdGUoZHBpLT5waW5jdHJsLCAiZHBpbW9kZSIpOw0KKwkJ
aWYgKElTX0VSUihkcGktPnBpbnNfZHBpKSkgew0KKwkJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0K
KwkJCWRldl9kYmcoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgZHBpbW9kZSFcbiIp
Ow0KKwkJfQ0KKwl9DQogCW1lbSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09V
UkNFX01FTSwgMCk7DQogCWRwaS0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIG1l
bSk7DQogCWlmIChJU19FUlIoZHBpLT5yZWdzKSkgew0KLS0gDQoyLjIxLjANCg==

