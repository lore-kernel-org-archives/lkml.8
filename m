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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B66C433EB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F9D20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QokLMbbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgGKGwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23715 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:01 -0400
X-UUID: 6d7ba65a555e4627995719caa0e62e9e-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sEiaKj8+B4t3boj7mRPJMc76iEHueHPApwh8Duxwsfc=;
        b=QokLMbbBZ+YEYeyx+7n/NmoUjeT2q3+Rlp+XZmOyoK9oQmAnv4UH6Cez+QZLOLCP4tt/B5bijURWtH22O3fuK3L2q0TBVwRDdoMXDKSsKWZHwAAu37spOtzS44lsoXH1eGDzPyXZdwG9WEGnpRK4OJjAXNVn79Kf2UPegxDWaBI=;
X-UUID: 6d7ba65a555e4627995719caa0e62e9e-20200711
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 743627226; Sat, 11 Jul 2020 14:51:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:52 +0800
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
Subject: [PATCH 14/21] iommu/mediatek: Add single domain
Date:   Sat, 11 Jul 2020 14:48:39 +0800
Message-ID: <20200711064846.16007-15-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E2BD001D552BBF5B1333269437BCDBFED01E27E9CA7423881F6A591C561CD3522000:8
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
bW11L210a19pb21tdS5jDQppbmRleCBmZGZkYjc1NzA2ZTAuLmRiMWYwNjMyNGVjYyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCkBAIC0xNTYsNiArMTU2LDEwIEBAIHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdp
b24gew0KIAlzaXplX3QJCQlzaXplOw0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
aW9tbXVfaW92YV9yZWdpb24gc2luZ2xlX2RvbWFpbltdID0gew0KKwl7LmlvdmFfYmFzZSA9IDAs
IC5zaXplID0gU1pfNEd9LA0KK307DQorDQogLyoNCiAgKiBUaGVyZSBtYXkgYmUgMSBvciAyIE00
VSBIV3MsIEJ1dCB3ZSBhbHdheXMgZXhwZWN0IHRoZXkgYXJlIGluIHRoZSBzYW1lIGRvbWFpbg0K
ICAqIGZvciB0aGUgcGVyZm9ybWFuY2UuDQpAQCAtOTAwLDYgKzkwNCw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCiAJLm00dV9wbGF0
ICAgICA9IE00VV9NVDI3MTIsDQogCS5mbGFncyAgICAgICAgPSBIQVNfNEdCX01PREUgfCBIQVNf
QkNMSyB8IEhBU19WTERfUEFfUk5HLA0KIAkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZfU0VM
X0dFTjEsDQorCS5pb3ZhX3JlZ2lvbiAgPSBzaW5nbGVfZG9tYWluLA0KKwkuaW92YV9yZWdpb25f
bnIgPSBBUlJBWV9TSVpFKHNpbmdsZV9kb21haW4pLA0KIAkubGFyYmlkX3JlbWFwID0ge3swfSwg
ezF9LCB7Mn0sIHszfSwgezR9LCB7NX0sIHs2fSwgezd9fSwNCiB9Ow0KIA0KQEAgLTkwNyw2ICs5
MTMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ2Nzc5X2Rh
dGEgPSB7DQogCS5tNHVfcGxhdCAgICAgID0gTTRVX01UNjc3OSwNCiAJLmZsYWdzICAgICAgICAg
PSBIQVNfU1VCX0NPTU0gfCBPVVRfT1JERVJfV1JfRU4gfCBXUl9USFJPVF9FTiwNCiAJLmludl9z
ZWxfcmVnICAgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMiwNCisJLmlvdmFfcmVnaW9uICAgPSBzaW5n
bGVfZG9tYWluLA0KKwkuaW92YV9yZWdpb25fbnIgPSBBUlJBWV9TSVpFKHNpbmdsZV9kb21haW4p
LA0KIAkubGFyYmlkX3JlbWFwICA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs1fSwgezcsIDh9LCB7
MTB9LCB7OX19LA0KIH07DQogDQpAQCAtOTE0LDYgKzkyMiw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9
IE00VV9NVDgxNzMsDQogCS5mbGFncwkgICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwg
UkVTRVRfQVhJLA0KIAkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZfU0VMX0dFTjEsDQorCS5p
b3ZhX3JlZ2lvbiAgPSBzaW5nbGVfZG9tYWluLA0KKwkuaW92YV9yZWdpb25fbnIgPSBBUlJBWV9T
SVpFKHNpbmdsZV9kb21haW4pLA0KIAkubGFyYmlkX3JlbWFwID0ge3swfSwgezF9LCB7Mn0sIHsz
fSwgezR9LCB7NX19LCAvKiBMaW5lYXIgbWFwcGluZy4gKi8NCiB9Ow0KIA0KQEAgLTkyMSw2ICs5
MzEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTgzX2Rh
dGEgPSB7DQogCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTgzLA0KIAkuZmxhZ3MgICAgICAgID0g
UkVTRVRfQVhJLA0KIAkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZfU0VMX0dFTjEsDQorCS5p
b3ZhX3JlZ2lvbiAgPSBzaW5nbGVfZG9tYWluLA0KKwkuaW92YV9yZWdpb25fbnIgPSBBUlJBWV9T
SVpFKHNpbmdsZV9kb21haW4pLA0KIAkubGFyYmlkX3JlbWFwID0ge3swfSwgezR9LCB7NX0sIHs2
fSwgezd9LCB7Mn0sIHszfSwgezF9fSwNCiB9Ow0KIA0KLS0gDQoyLjE4LjANCg==

