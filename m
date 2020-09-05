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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0137C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5865F20757
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFpOp74z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgIEIOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:14:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48603 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728313AbgIEIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:14:44 -0400
X-UUID: 00dc1d75ef68401ab1df6a840c582e5a-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RGC4TyuwgH+C0nl9qqtSkY3WkBISOgOe8Q8KEaKsHZg=;
        b=FFpOp74zlpgQJL8hFhxGQE7Bb7vDVuCD8R2WElaffKQKG+g6G9JG+7N4JMQbPCepJlUp5QYqnyXbpGVXtQJfkJA7WGGF0WVkXD7mXPvdTD6L44qp2aSltXdAbeAUfHsLJ/eWSZ7fqkFr5bM5yEdvdJkUUTNoIuu9P7R04LWv9+g=;
X-UUID: 00dc1d75ef68401ab1df6a840c582e5a-20200905
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1671242871; Sat, 05 Sep 2020 16:14:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:14:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:14:38 +0800
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
Subject: [PATCH v2 22/23] iommu/mediatek: Add mt8192 support
Date:   Sat, 5 Sep 2020 16:09:19 +0800
Message-ID: <20200905080920.13396-23-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5B5F9E93F3ACDA5B93F530C569B8DA973D4AF1AF300DD1BD6639A2B983DAA07A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG10ODE5MiBpb21tdSBzdXBwb3J0Lg0KDQpGb3IgbXVsdGkgZG9tYWluLCBBZGQgMU0gZ2Fw
IGZvciB0aGUgdmRlYyBkb21haW4gc2l6ZS4gVGhhdCBpcyBiZWNhdXNlDQp2ZGVjIEhXIGhhcyBh
IGVuZCBhZGRyZXNzIHJlZ2lzdGVyIHdoaWNoIHJlcXVpcmUgKHN0YXJ0X2FkZHIgKw0KbGVuKSBy
YXRoZXIgdGhhbiAoc3RhcnRfYWRkciArIGxlbiAtIDEpLiBUYWtlIGEgZXhhbXBsZSwgaWYgdGhl
IHN0YXJ0X2FkZHINCmlzIDB4ZmZmMDAwMDAsIHNpemUgaXMgMHgxMDAwMDAsIHRoZW4gdGhlIGVu
ZF9hZGRyZXNzIGlzIDB4ZmZmMDAwMDAgKw0KMHgxMDAwMDAgPSAweDEgMDAwMCAwMDAwLiBidXQg
dGhlIHJlZ2lzdGVyIG9ubHkgaXMgMzJiaXQuIHRodXMgSFcgd2lsbCBnZXQNCnRoZSBlbmQgYWRk
cmVzcyBpcyAwLiBUbyBhdm9pZCB0aGlzIGlzc3VlLCBJIGFkZCAxTSBnYXAgZm9yIHRoaXMuDQoN
ClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCiBkcml2
ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IGQwNTkzZDMxNzI0MC4uZWJjMzc2N2I2MmFiIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KQEAgLTE3MSw2ICsxNzEsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfaW9tbXVfaW92YV9yZWdpb24gc2luZ2xlX2RvbWFpbltdID0gew0KIAl7LmlvdmFfYmFzZSA9
IDAsCQkuc2l6ZSA9IFNaXzRHfSwNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lv
bW11X2lvdmFfcmVnaW9uIG10ODE5Ml9tdWx0aV9kb21bXSA9IHsNCisJeyAuaW92YV9iYXNlID0g
MHgwLAkJLnNpemUgPSBTWl80R30sCQkvKiBkaXNwOiAwIH4gNEcgKi8NCisJI2lmIElTX0VOQUJM
RUQoQ09ORklHX0FSQ0hfRE1BX0FERFJfVF82NEJJVCkNCisJeyAuaW92YV9iYXNlID0gU1pfNEcs
CQkuc2l6ZSA9IFNaXzRHIC0gU1pfMU19LAkvKiB2ZGVjOiA0RyB+IDhHIGdhcDogMU0gKi8NCisJ
eyAuaW92YV9iYXNlID0gU1pfNEcgKiAyLAkuc2l6ZSA9IFNaXzRHIC0gU1pfMU19LAkvKiBDQU0v
TURQOiA4RyB+IDEyRyAqLw0KKwl7IC5pb3ZhX2Jhc2UgPSAweDI0MDAwMDAwMFVMTCwJLnNpemUg
PSAweDQwMDAwMDB9LAkvKiBDQ1UwICovDQorCXsgLmlvdmFfYmFzZSA9IDB4MjQ0MDAwMDAwVUxM
LAkuc2l6ZSA9IDB4NDAwMDAwMH0sCS8qIENDVTEgKi8NCisJI2VuZGlmDQorfTsNCisNCiAvKg0K
ICAqIFRoZXJlIG1heSBiZSAxIG9yIDIgTTRVIEhXcywgQnV0IHdlIGFsd2F5cyBleHBlY3QgdGhl
eSBhcmUgaW4gdGhlIHNhbWUgZG9tYWluDQogICogZm9yIHRoZSBwZXJmb3JtYW5jZS4NCkBAIC05
NjcsMTEgKzk3NywyMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEg
bXQ4MTgzX2RhdGEgPSB7DQogCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7NH0sIHs1fSwgezZ9LCB7
N30sIHsyfSwgezN9LCB7MX19LA0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfcGxhdF9kYXRhIG10ODE5Ml9kYXRhID0gew0KKwkubTR1X3BsYXQgICAgICAgPSBNNFVfTVQ4
MTkyLA0KKwkuZmxhZ3MgICAgICAgICAgPSBIQVNfQkNMSyB8IEhBU19TVUJfQ09NTSB8IE9VVF9P
UkRFUl9XUl9FTiB8DQorCQkJICBXUl9USFJPVF9FTiB8IElPVkFfMzRfRU4sDQorCS5pbnZfc2Vs
X3JlZyAgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KKwkuaW92YV9yZWdpb24gICAgPSBtdDgx
OTJfbXVsdGlfZG9tLA0KKwkuaW92YV9yZWdpb25fbnIgPSBBUlJBWV9TSVpFKG10ODE5Ml9tdWx0
aV9kb20pLA0KKwkubGFyYmlkX3JlbWFwICAgPSB7ezB9LCB7MX0sIHs0LCA1fSwgezd9LCB7Mn0s
IHs5LCAxMSwgMTksIDIwfSwNCisJCQkgICB7MCwgMTQsIDE2fSwgezAsIDEzLCAxOCwgMTd9fSwN
Cit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19pb21tdV9vZl9p
ZHNbXSA9IHsNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItbTR1IiwgLmRhdGEg
PSAmbXQyNzEyX2RhdGF9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1tNHUi
LCAuZGF0YSA9ICZtdDY3NzlfZGF0YX0sDQogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLW00dSIsIC5kYXRhID0gJm10ODE3M19kYXRhfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMtbTR1IiwgLmRhdGEgPSAmbXQ4MTgzX2RhdGF9LA0KKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Mi1tNHUiLCAuZGF0YSA9ICZtdDgxOTJfZGF0YX0sDQogCXt9DQog
fTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaA0KaW5kZXggNWUzNDY0NjRjZGY4Li5kMjcwMmVkYTI1ZDQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5oDQpAQCAtNDIsNiArNDIsNyBAQCBlbnVtIG10a19pb21tdV9wbGF0IHsNCiAJTTRV
X01UNjc3OSwNCiAJTTRVX01UODE3MywNCiAJTTRVX01UODE4MywNCisJTTRVX01UODE5MiwNCiB9
Ow0KIA0KIHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdpb247DQotLSANCjIuMTguMA0K

