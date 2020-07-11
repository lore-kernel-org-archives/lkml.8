Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E00C20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KvNa3smy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGKGxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:53:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9666 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726262AbgGKGxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:53:04 -0400
X-UUID: a9be5e49686e45f984eb477d9ca6576d-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XFYjQD+5gyhYkftQ2TMlioSGdoG7pjkq+qUmw2l1IQM=;
        b=KvNa3smyoENggP7SkLXpoU8qThLR+cpBfIn2d4aZSsoTqneaMXBC3Ni2VQnZ8+BgKHeAaTkBVfjp3wWJ9kye30yr41zuBlovFdbktiJNe55Uf6N9YaeGD15PGDJE37g1lCJ+maZE9uYeqDCSI0NlNXblOn4kAePKbWpPM+CFC40=;
X-UUID: a9be5e49686e45f984eb477d9ca6576d-20200711
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1721728080; Sat, 11 Jul 2020 14:53:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:44 +0800
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
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 21/21] memory: mtk-smi: Add mt8192 support
Date:   Sat, 11 Jul 2020 14:48:46 +0800
Message-ID: <20200711064846.16007-22-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
bWkuYw0KaW5kZXggZjJmNjEwMGM3NGVmLi41ZDAyNjg2MzBlNzAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAg
LTI1Miw2ICsyNTIsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10
a19zbWlfbGFyYl9tdDgxODMgPSB7DQogCQkJCSAgICAgIC8qIElQVTAgfCBJUFUxIHwgQ0NVICov
DQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4gbXRrX3NtaV9s
YXJiX210ODE5MiA9IHsNCisJLmNvbmZpZ19wb3J0ICAgICAgICAgICAgICAgID0gbXRrX3NtaV9s
YXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbCwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfbGFyYl9vZl9pZHNbXSA9IHsNCiAJew0KIAkJLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXNtaS1sYXJiIiwNCkBAIC0yNjksNiArMjczLDEwIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfbGFyYl9vZl9pZHNbXSA9
IHsNCiAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zbWktbGFyYiIsDQogCQkuZGF0
YSA9ICZtdGtfc21pX2xhcmJfbXQ4MTgzDQogCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5Mi1zbWktbGFyYiIsDQorCQkuZGF0YSA9ICZtdGtfc21pX2xhcmJfbXQ4MTky
DQorCX0sDQogCXt9DQogfTsNCiANCkBAIC00MDEsNiArNDA5LDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX3NtaV9jb21tb25fcGxhdCBtdGtfc21pX2NvbW1vbl9tdDgxODMgPSB7DQogCQkg
ICAgRl9NTVUxX0xBUkIoNyksDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlf
Y29tbW9uX3BsYXQgbXRrX3NtaV9jb21tb25fbXQ4MTkyID0gew0KKwkuZ2VuICAgICAgPSBNVEtf
U01JX0dFTjIsDQorCS5oYXNfZ2FscyA9IHRydWUsDQorCS5idXNfc2VsICA9IEZfTU1VMV9MQVJC
KDEpIHwgRl9NTVUxX0xBUkIoMikgfCBGX01NVTFfTEFSQig1KSB8DQorCQkgICAgRl9NTVUxX0xB
UkIoNiksDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfc21p
X2NvbW1vbl9vZl9pZHNbXSA9IHsNCiAJew0KIAkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLXNtaS1jb21tb24iLA0KQEAgLTQxOCw2ICs0MzMsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbXRrX3NtaV9jb21tb25fb2ZfaWRzW10gPSB7DQogCQkuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODMtc21pLWNvbW1vbiIsDQogCQkuZGF0YSA9ICZtdGtfc21pX2Nv
bW1vbl9tdDgxODMsDQogCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5
Mi1zbWktY29tbW9uIiwNCisJCS5kYXRhID0gJm10a19zbWlfY29tbW9uX210ODE5MiwNCisJfSwN
CiAJe30NCiB9Ow0KIA0KLS0gDQoyLjE4LjANCg==

