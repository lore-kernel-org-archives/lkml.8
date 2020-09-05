Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE34C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379EE2074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a+wIi4Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgIEIPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:15:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64526 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728313AbgIEIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:15:03 -0400
X-UUID: c21189dd011046be8692aee744fdc952-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bDFMxyBvv5aUYhv7Kw0G7oECaVz+/jg2a4bXq4Hhva0=;
        b=a+wIi4Nc3EGRTPeJVYaoYckJEJiq0OXkHavdbGezQsjFB6Y7sMXt5Rj0RFn/XwkSySJfiBbO/aaIFTzmE+cRzteanZqz+wdinwr+pL09s+/QHy+a2i7UbbMgFhVRoDFcTU01eLxZWLqi0UEi9exHfdg8r+O0N0L6b6/rLSxUYrQ=;
X-UUID: c21189dd011046be8692aee744fdc952-20200905
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 826668872; Sat, 05 Sep 2020 16:14:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:14:48 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:14:48 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 23/23] memory: mtk-smi: Add mt8192 support
Date:   Sat, 5 Sep 2020 16:09:20 +0800
Message-ID: <20200905080920.13396-24-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 73EDEEB69FD905FCD3F8B384323A8BA6F12431163B00FB918134C6D1A1253C4C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG10ODE5MiBzbWkgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxOSArKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1z
bWkuYw0KaW5kZXggZTk0Yzk5Y2EyODgzLi4wZWMzZWZmNGQ5MmQgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAg
LTI2MSw2ICsyNjEsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10
a19zbWlfbGFyYl9tdDgxODMgPSB7DQogCQkJCSAgICAgIC8qIElQVTAgfCBJUFUxIHwgQ0NVICov
DQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4gbXRrX3NtaV9s
YXJiX210ODE5MiA9IHsNCisJLmNvbmZpZ19wb3J0ICAgICAgICAgICAgICAgID0gbXRrX3NtaV9s
YXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbCwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfbGFyYl9vZl9pZHNbXSA9IHsNCiAJew0KIAkJLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXNtaS1sYXJiIiwNCkBAIC0yODIsNiArMjg2LDEwIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfbGFyYl9vZl9pZHNbXSA9
IHsNCiAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zbWktbGFyYiIsDQogCQkuZGF0
YSA9ICZtdGtfc21pX2xhcmJfbXQ4MTgzDQogCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5Mi1zbWktbGFyYiIsDQorCQkuZGF0YSA9ICZtdGtfc21pX2xhcmJfbXQ4MTky
DQorCX0sDQogCXt9DQogfTsNCiANCkBAIC00MjEsNiArNDI5LDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX3NtaV9jb21tb25fcGxhdCBtdGtfc21pX2NvbW1vbl9tdDgxODMgPSB7DQogCQkg
ICAgRl9NTVUxX0xBUkIoNyksDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlf
Y29tbW9uX3BsYXQgbXRrX3NtaV9jb21tb25fbXQ4MTkyID0gew0KKwkuZ2VuICAgICAgPSBNVEtf
U01JX0dFTjIsDQorCS5oYXNfZ2FscyA9IHRydWUsDQorCS5idXNfc2VsICA9IEZfTU1VMV9MQVJC
KDEpIHwgRl9NTVUxX0xBUkIoMikgfCBGX01NVTFfTEFSQig1KSB8DQorCQkgICAgRl9NTVUxX0xB
UkIoNiksDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfc21p
X2NvbW1vbl9vZl9pZHNbXSA9IHsNCiAJew0KIAkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLXNtaS1jb21tb24iLA0KQEAgLTQ0Miw2ICs0NTcsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbXRrX3NtaV9jb21tb25fb2ZfaWRzW10gPSB7DQogCQkuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODMtc21pLWNvbW1vbiIsDQogCQkuZGF0YSA9ICZtdGtfc21pX2Nv
bW1vbl9tdDgxODMsDQogCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5
Mi1zbWktY29tbW9uIiwNCisJCS5kYXRhID0gJm10a19zbWlfY29tbW9uX210ODE5MiwNCisJfSwN
CiAJe30NCiB9Ow0KIA0KLS0gDQoyLjE4LjANCg==

