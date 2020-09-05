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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363CFC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6E22074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bkGz1rCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgIEINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:13:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48717 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgIEINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:13:40 -0400
X-UUID: 381da0d9dfc14e219da206127e3f36d9-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=l8Aq+TVie3k2Aq8o0+LpX7YhzFPWXC7lxDHgVz1jlN4=;
        b=bkGz1rChh67LqdQ67gfHpVcgAJ7yNbvPtp57KCbXZF0M+rEzthCI2pnA0M1Pv0no3n3ws3EYwimYcsdacuULKf1YrJpZDx815yDfXkD/FV2Q6gZWuJC1sVzw6ymzdazX6x/ii0egxQ7fmGXHqjAX5DjTJdHGunSgunJ5fo3pr0Y=;
X-UUID: 381da0d9dfc14e219da206127e3f36d9-20200905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 202941406; Sat, 05 Sep 2020 16:13:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:13:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:13:31 +0800
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
Subject: [PATCH v2 15/23] iommu/mediatek: Add iova reserved function
Date:   Sat, 5 Sep 2020 16:09:12 +0800
Message-ID: <20200905080920.13396-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 72F648CDE297A7F1184FD55C1EE483861396E92899FD3A72EB0D9BDF248D4C5D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG11bHRpcGxlIGlvbW11X2RvbWFpbnMsIHdlIG5lZWQgdG8gcmVzZXJ2ZSBzb21lIGlvdmEg
cmVnaW9ucy4gVGFrZSBhDQpleGFtcGxlLCBJZiB0aGUgZGVmYXVsdCBpb3ZhIHJlZ2lvbiBpcyAw
IH4gNEcsIGJ1dCB0aGUgMHg0MDAwXzAwMDAgfg0KMHg0M2ZmX2ZmZmYgaXMgb25seSBmb3IgdGhl
IHNwZWNpYWwgQ0NVMCBkb21haW4uIFRodXMgd2Ugc2hvdWxkIGV4Y2x1ZGUNCnRoaXMgcmVnaW9u
IGZvciB0aGUgZGVmYXVsdCBpb3ZhIHJlZ2lvbi4NCg0KVGhpcyBwYXRjaCBhZGRzIGlvdmEgcmVz
ZXJ2ZWQgZmxvdy4gSXQncyBhIHByZXBhcmluZyBwYXRjaCBmb3Igc3VwcG9ydGluZw0KbXVsdGkt
ZG9tYWluLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbmFuIHN1biA8YW5hbi5zdW5AbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2
ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDUgKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDMzIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBkMjI3NzJlYzY0YzguLjViNjM3MzIwNDRk
ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCkBAIC0xNTMsNiArMTUzLDExIEBAIHN0YXRpYyBMSVNUX0hFQUQo
bTR1bGlzdCk7CS8qIExpc3QgYWxsIHRoZSBNNFUgSFdzICovDQogDQogI2RlZmluZSBmb3JfZWFj
aF9tNHUoZGF0YSkJbGlzdF9mb3JfZWFjaF9lbnRyeShkYXRhLCAmbTR1bGlzdCwgbGlzdCkNCiAN
CitzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uIHsNCisJZG1hX2FkZHJfdAkJaW92YV9iYXNl
Ow0KKwl1bnNpZ25lZCBsb25nIGxvbmcJc2l6ZTsNCit9Ow0KKw0KIC8qDQogICogVGhlcmUgbWF5
IGJlIDEgb3IgMiBNNFUgSFdzLCBCdXQgd2UgYWx3YXlzIGV4cGVjdCB0aGV5IGFyZSBpbiB0aGUg
c2FtZSBkb21haW4NCiAgKiBmb3IgdGhlIHBlcmZvcm1hbmNlLg0KQEAgLTUzOSw2ICs1NDQsMjcg
QEAgc3RhdGljIGludCBtdGtfaW9tbXVfb2ZfeGxhdGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQ0KIAlyZXR1cm4gaW9tbXVfZndzcGVjX2FkZF9pZHMo
ZGV2LCBhcmdzLT5hcmdzLCAxKTsNCiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2lvbW11X2dldF9y
ZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LA0KKwkJCQkgICAgICAgc3RydWN0IGxpc3Rf
aGVhZCAqaGVhZCkNCit7DQorCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRldl9pb21t
dV9wcml2X2dldChkZXYpOw0KKwljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpy
ZXN2Ow0KKwlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsNCisJaW50IHByb3QgPSBJ
T01NVV9XUklURSB8IElPTU1VX1JFQUQ7DQorCXVuc2lnbmVkIGludCBpOw0KKw0KKwlmb3IgKGkg
PSAwOyBpIDwgZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbl9ucjsgaSsrKSB7DQorCQlyZXN2
ID0gZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbiArIGk7DQorDQorCQlyZWdpb24gPSBpb21t
dV9hbGxvY19yZXN2X3JlZ2lvbihyZXN2LT5pb3ZhX2Jhc2UsIHJlc3YtPnNpemUsDQorCQkJCQkJ
IHByb3QsIElPTU1VX1JFU1ZfUkVTRVJWRUQpOw0KKwkJaWYgKCFyZWdpb24pDQorCQkJcmV0dXJu
Ow0KKw0KKwkJbGlzdF9hZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsNCisJfQ0KK30NCisN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzID0gew0KIAkuZG9t
YWluX2FsbG9jCT0gbXRrX2lvbW11X2RvbWFpbl9hbGxvYywNCiAJLmRvbWFpbl9mcmVlCT0gbXRr
X2lvbW11X2RvbWFpbl9mcmVlLA0KQEAgLTU1Myw2ICs1NzksOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzID0gew0KIAkucmVsZWFzZV9kZXZpY2UJPSBtdGtf
aW9tbXVfcmVsZWFzZV9kZXZpY2UsDQogCS5kZXZpY2VfZ3JvdXAJPSBtdGtfaW9tbXVfZGV2aWNl
X2dyb3VwLA0KIAkub2ZfeGxhdGUJPSBtdGtfaW9tbXVfb2ZfeGxhdGUsDQorCS5nZXRfcmVzdl9y
ZWdpb25zID0gbXRrX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMsDQorCS5wdXRfcmVzdl9yZWdpb25z
ID0gZ2VuZXJpY19pb21tdV9wdXRfcmVzdl9yZWdpb25zLA0KIAkucGdzaXplX2JpdG1hcAk9IFNa
XzRLIHwgU1pfNjRLIHwgU1pfMU0gfCBTWl8xNk0sDQogfTsNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXgg
YWU3OTA5ODE1Y2RiLi5kNDVjMTNjOWQzMjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAtNDQsMTAgKzQ0
LDE1IEBAIGVudW0gbXRrX2lvbW11X3BsYXQgew0KIAlNNFVfTVQ4MTgzLA0KIH07DQogDQorc3Ry
dWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbjsNCisNCiBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSB7DQogCWVudW0gbXRrX2lvbW11X3BsYXQgbTR1X3BsYXQ7DQogCXUzMiAgICAgICAgICAgICAg
ICAgZmxhZ3M7DQogCXUzMiAgICAgICAgICAgICAgICAgaW52X3NlbF9yZWc7DQorDQorCXVuc2ln
bmVkIGludCAgICAgICAgaW92YV9yZWdpb25fbnI7DQorCWNvbnN0IHN0cnVjdCBtdGtfaW9tbXVf
aW92YV9yZWdpb24gICAqaW92YV9yZWdpb247DQogCXVuc2lnbmVkIGNoYXIgICAgICAgbGFyYmlk
X3JlbWFwW01US19MQVJCX0NPTV9NQVhdW01US19MQVJCX1NVQkNPTV9NQVhdOw0KIH07DQogDQot
LSANCjIuMTguMA0K

