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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B040C2D0A7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79582074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gVHCGHEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgIEIN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:13:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3074 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbgIEIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:13:57 -0400
X-UUID: 3eb9a74b16cb4e09a9d58c60a057e26e-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pMU7cXDAfnjPywcyu7y0QXMV0hTqN18SPFUpxi7UALI=;
        b=gVHCGHEEXErNEpcawhIK3LfrT907bsQVtScge/mRx3onRA6HgQNWMSanZuSTuakSwPUPglYq53DnZyNZOaNvmHh3OAY/wCgxwqqI1sSL5Yf8XD4+eXh65hR9WJL7Q4weR2NBSNCttara6iGDYQs17pTY2DIOTg4Niic4HUIsNss=;
X-UUID: 3eb9a74b16cb4e09a9d58c60a057e26e-20200905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1278988371; Sat, 05 Sep 2020 16:13:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:13:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:13:44 +0800
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
Subject: [PATCH v2 16/23] iommu/mediatek: Add single domain
Date:   Sat, 5 Sep 2020 16:09:13 +0800
Message-ID: <20200905080920.13396-17-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVmYXVsdGx5IHRoZSBpb3ZhIHJhbmdlIGlzIDAtNEcuIGhlcmUgd2UgYWRkIGEgc2luZ2xlLWRv
bWFpbigwLTRHKQ0KZm9yIHRoZSBwcmV2aW91cyBTb0MuIHRoaXMgYWxzbyBpcyBhIHByZXBhcmlu
ZyBwYXRjaCBmb3Igc3VwcG9ydGluZw0KbXVsdGktZG9tYWlucy4NCg0KU2lnbmVkLW9mZi1ieTog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19p
b21tdS5jIHwgMTIgKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQppbmRleCA1YjYzNzMyMDQ0ZGUuLjEwYjlhODZlYTgyNiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCkBAIC0xNTgsNiArMTU4LDEwIEBAIHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdp
b24gew0KIAl1bnNpZ25lZCBsb25nIGxvbmcJc2l6ZTsNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uIHNpbmdsZV9kb21haW5bXSA9IHsNCisJey5pb3Zh
X2Jhc2UgPSAwLAkJLnNpemUgPSBTWl80R30sDQorfTsNCisNCiAvKg0KICAqIFRoZXJlIG1heSBi
ZSAxIG9yIDIgTTRVIEhXcywgQnV0IHdlIGFsd2F5cyBleHBlY3QgdGhleSBhcmUgaW4gdGhlIHNh
bWUgZG9tYWluDQogICogZm9yIHRoZSBwZXJmb3JtYW5jZS4NCkBAIC04NzcsNiArODgxLDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0K
IAkubTR1X3BsYXQgICAgID0gTTRVX01UMjcxMiwNCiAJLmZsYWdzICAgICAgICA9IEhBU180R0Jf
TU9ERSB8IEhBU19CQ0xLIHwgSEFTX1ZMRF9QQV9STkcsDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdf
TU1VX0lOVl9TRUxfR0VOMSwNCisJLmlvdmFfcmVnaW9uICA9IHNpbmdsZV9kb21haW4sDQorCS5p
b3ZhX3JlZ2lvbl9uciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVt
YXAgPSB7ezB9LCB7MX0sIHsyfSwgezN9LCB7NH0sIHs1fSwgezZ9LCB7N319LA0KIH07DQogDQpA
QCAtODg0LDYgKzg5MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSBtdDY3NzlfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICAgPSBNNFVfTVQ2Nzc5LA0KIAkuZmxh
Z3MgICAgICAgICA9IEhBU19TVUJfQ09NTSB8IE9VVF9PUkRFUl9XUl9FTiB8IFdSX1RIUk9UX0VO
LA0KIAkuaW52X3NlbF9yZWcgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KKwkuaW92YV9yZWdp
b24gICA9IHNpbmdsZV9kb21haW4sDQorCS5pb3ZhX3JlZ2lvbl9uciA9IEFSUkFZX1NJWkUoc2lu
Z2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVtYXAgID0ge3swfSwgezF9LCB7Mn0sIHszfSwgezV9
LCB7NywgOH0sIHsxMH0sIHs5fX0sDQogfTsNCiANCkBAIC04OTEsNiArODk5LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KIAkubTR1
X3BsYXQgICAgID0gTTRVX01UODE3MywNCiAJLmZsYWdzCSAgICAgID0gSEFTXzRHQl9NT0RFIHwg
SEFTX0JDTEsgfCBSRVNFVF9BWEksDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxf
R0VOMSwNCisJLmlvdmFfcmVnaW9uICA9IHNpbmdsZV9kb21haW4sDQorCS5pb3ZhX3JlZ2lvbl9u
ciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7
MX0sIHsyfSwgezN9LCB7NH0sIHs1fX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KIH07DQogDQpA
QCAtODk4LDYgKzkwOCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSBtdDgxODNfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQogCS5mbGFn
cyAgICAgICAgPSBSRVNFVF9BWEksDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxf
R0VOMSwNCisJLmlvdmFfcmVnaW9uICA9IHNpbmdsZV9kb21haW4sDQorCS5pb3ZhX3JlZ2lvbl9u
ciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7
NH0sIHs1fSwgezZ9LCB7N30sIHsyfSwgezN9LCB7MX19LA0KIH07DQogDQotLSANCjIuMTguMA0K

