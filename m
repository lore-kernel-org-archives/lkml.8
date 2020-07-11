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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51781C433EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CBE20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hZ+5XT6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGKGwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35558 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728152AbgGKGwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:43 -0400
X-UUID: 8bf2ef7cbbad4d0ba7fc277f275626e5-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yf085KSU3PMUn6TkSNQXo1sLly+cdKGR+5jbWgYX2B0=;
        b=hZ+5XT6LTicyUwJekF9VLxKtDj9tElV7YuQ7GR/3FnDbMD+JVcFzl3ZxGKAeUcmubHnIMNHDfceU2ZkFrsOCrDVMt7gyDZYDd92Q6OLVpPmlfnag1tTNiBdq9+CIYG/b9AM+3KjPEekGgm+EvEzQxZO6HigiadFmlt5U6tJlQBo=;
X-UUID: 8bf2ef7cbbad4d0ba7fc277f275626e5-20200711
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1085459974; Sat, 11 Jul 2020 14:52:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:36 +0800
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
Subject: [PATCH 20/21] iommu/mediatek: Add mt8192 support
Date:   Sat, 11 Jul 2020 14:48:45 +0800
Message-ID: <20200711064846.16007-21-yong.wu@mediatek.com>
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

QWRkIG10ODE5MiBpb21tdSBzdXBwb3J0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25n
Lnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyMCAr
KysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAgMSArDQog
MiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggYTRh
YzQxZTYwYzRmLi5kYTdkMDU1YWY5MTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMTY4LDYgKzE2OCwx
NCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbiBzaW5nbGVfZG9t
YWluW10gPSB7DQogCXsuaW92YV9iYXNlID0gMCwgLnNpemUgPSBTWl80R30sDQogfTsNCiANCitz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbiBtdDgxOTJfbXVsdGlfZG9t
W10gPSB7DQorCXsgLmlvdmFfYmFzZSA9IDB4MCwgLnNpemUgPSBTWl80R30sCSAgICAgIC8qIGRp
c3AgOiAwIH4gNEcgKi8NCisJeyAuaW92YV9iYXNlID0gU1pfNEcsIC5zaXplID0gU1pfNEd9LCAg
ICAgICAgIC8qIHZkZWMgOiA0RyB+IDhHICovDQorCXsgLmlvdmFfYmFzZSA9IFNaXzRHICogMiwg
LnNpemUgPSBTWl80R30sICAgICAvKiBDQU0vTURQOiA4RyB+IDEyRyAqLw0KKwl7IC5pb3ZhX2Jh
c2UgPSAweDI0MDAwMDAwMFVMTCwgLnNpemUgPSAweDQwMDAwMDB9LCAvKiBDQ1UwICovDQorCXsg
LmlvdmFfYmFzZSA9IDB4MjQ0MDAwMDAwVUxMLCAuc2l6ZSA9IDB4NDAwMDAwMH0sIC8qIENDVTEg
Ki8NCit9Ow0KKw0KIC8qDQogICogVGhlcmUgbWF5IGJlIDEgb3IgMiBNNFUgSFdzLCBCdXQgd2Ug
YWx3YXlzIGV4cGVjdCB0aGV5IGFyZSBpbiB0aGUgc2FtZSBkb21haW4NCiAgKiBmb3IgdGhlIHBl
cmZvcm1hbmNlLg0KQEAgLTk5MSwxMSArOTk5LDIzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2lvbW11X3BsYXRfZGF0YSBtdDgxODNfZGF0YSA9IHsNCiAJLmxhcmJpZF9yZW1hcCA9IHt7MH0s
IHs0fSwgezV9LCB7Nn0sIHs3fSwgezJ9LCB7M30sIHsxfX0sDQogfTsNCiANCitzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTkyX2RhdGEgPSB7DQorCS5tNHVfcGxh
dCAgICAgICA9IE00VV9NVDgxOTIsDQorCS5mbGFncyAgICAgICAgICA9IEhBU19TVUJfQ09NTSB8
IE9VVF9PUkRFUl9XUl9FTiB8IFdSX1RIUk9UX0VODQorCQkJICB8IElPVkFfMzRfRU4sDQorCS5p
bnZfc2VsX3JlZyAgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KKwkuaW92YV9yZWdpb24gICAg
PSBtdDgxOTJfbXVsdGlfZG9tLA0KKwkuaW92YV9yZWdpb25fbnIgPSBBUlJBWV9TSVpFKG10ODE5
Ml9tdWx0aV9kb20pLA0KKwkubGFyYmlkX3JlbWFwICAgPSB7ezB9LCB7MX0sIHs0LCA1fSwgezd9
LCB7Mn0sIHs5LCAxMSwgMTksIDIwfSwNCisJCQkgICB7MCwgMTQsIDE2fSwgezAsIDEzLCAxOCwg
MTd9fSwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19pb21t
dV9vZl9pZHNbXSA9IHsNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItbTR1Iiwg
LmRhdGEgPSAmbXQyNzEyX2RhdGF9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3
OS1tNHUiLCAuZGF0YSA9ICZtdDY3NzlfZGF0YX0sDQogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTczLW00dSIsIC5kYXRhID0gJm10ODE3M19kYXRhfSwNCiAJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODMtbTR1IiwgLmRhdGEgPSAmbXQ4MTgzX2RhdGF9LA0KKwl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1tNHUiLCAuZGF0YSA9ICZtdDgxOTJfZGF0YX0sDQog
CXt9DQogfTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggMTE3OTViOGQ4MmZmLi5kNDJhMjUwMTU2YmQg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5oDQpAQCAtNDEsNiArNDEsNyBAQCBlbnVtIG10a19pb21tdV9wbGF0IHsN
CiAJTTRVX01UNjc3OSwNCiAJTTRVX01UODE3MywNCiAJTTRVX01UODE4MywNCisJTTRVX01UODE5
MiwNCiB9Ow0KIA0KIHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdpb247DQotLSANCjIuMTguMA0K

