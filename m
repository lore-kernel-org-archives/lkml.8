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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9184FC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656B8246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OibC/kNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB1FWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:22:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4369 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725794AbgB1FWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:22:49 -0500
X-UUID: 7992e77d8a314341972fcad71c0e8d02-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5cFcI6oejfKgvdPigAG7lz/WkjQ0ZoTObgew3f2ti/4=;
        b=OibC/kNLmJADxfO+OC3xFgDxQ9MEV87pexgsFFSwGCPEefpRNpI7TRiY5Lt4/dbV3v/8tHmLDKeV6cV3OZAqN2A8NUM6Rv9ykEpjLBzn5ZSOaK4JHs4lqTcky0ACpmq4W5mL4Wu/9hnXCLhCy0TTmKxsa0s3oy+xLXv5Nj6hNnA=;
X-UUID: 7992e77d8a314341972fcad71c0e8d02-20200228
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1474536278; Fri, 28 Feb 2020 13:21:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 13:22:18 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 13:22:07 +0800
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
Subject: [PATCH v10 5/5] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Fri, 28 Feb 2020 13:21:28 +0800
Message-ID: <20200228052128.82136-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228052128.82136-1-jitao.shi@mediatek.com>
References: <20200228052128.82136-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F98AB8D0A87863EFA2C70BBE779F1DEAF0C572D9FECD78516D03F7B0CB365BA02000:8
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
N2E0YzQuLjAxMzNhZDhmNmE3ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
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
bnNfZ3BpbyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRwaS0+cGluY3RybCwgImlkbGUiKTsNCisJ
CWlmIChJU19FUlIoZHBpLT5waW5zX2dwaW8pKSB7DQorCQkJZHBpLT5waW5zX2dwaW8gPSBOVUxM
Ow0KKwkJCWRldl9kYmcoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgaWRsZSFcbiIp
Ow0KKwkJfQ0KKwkJaWYgKGRwaS0+cGluc19ncGlvKQ0KKwkJCXBpbmN0cmxfc2VsZWN0X3N0YXRl
KGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KKw0KKwkJZHBpLT5waW5zX2RwaSA9IHBp
bmN0cmxfbG9va3VwX3N0YXRlKGRwaS0+cGluY3RybCwgImFjdGl2ZSIpOw0KKwkJaWYgKElTX0VS
UihkcGktPnBpbnNfZHBpKSkgew0KKwkJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KKwkJCWRldl9k
YmcoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgYWN0aXZlIVxuIik7DQorCQl9DQor
CX0NCiAJbWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAw
KTsNCiAJZHBpLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCiAJaWYg
KElTX0VSUihkcGktPnJlZ3MpKSB7DQotLSANCjIuMjEuMA0K

