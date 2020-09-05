Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91120C2BBD0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6481620757
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hsrla56n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgIEIOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:14:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45327 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbgIEIOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:14:22 -0400
X-UUID: c58bd589b13047adb3d1229e79782b47-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oz8nF/O5DEM+ruQBFr1fmCos9I+cM4wdZKMWELCXako=;
        b=hsrla56nHUJ1n+PuxDooNUobI4Coej6pqwduUpqoosGx4Bex8/tC4K2/c8V+8DYuYyA9zYCHiRAH5TjjBL8sr5P8tU76Yl0jKKzjCIBXnWglqHowRUmMTTsXYDnZ7476Vxo+3NA81MdYg8eVIStgwDw3S0BEk9uffCd2m4JR0G4=;
X-UUID: c58bd589b13047adb3d1229e79782b47-20200905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 38352271; Sat, 05 Sep 2020 16:14:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:14:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:14:09 +0800
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
Subject: [PATCH v2 18/23] iommu/mediatek: Support up to 34bit iova in tlb flush
Date:   Sat, 5 Sep 2020 16:09:15 +0800
Message-ID: <20200905080920.13396-19-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 707BF9E0B5763FFE53C76E1B1ABD8E34A67C5356A6D0A7E61567458B3BA72F402000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlvdmEgaXMgMzRiaXQsIHRoZSBpb3ZhWzMyXVszM10gaXMgdGhlIGJpdDAvMSBpbiB0
aGUgdGxiIGZsdXNoDQpyZWdpc3Rlci4gQWRkIGEgbmV3IG1hY3JvIGZvciB0aGlzLg0KDQp0aGVy
ZSBpcyBhIG1pbm9yIGNoYW5nZSB1bnJlbGF0ZWQgd2l0aCB0aGlzIHBhdGNoLiBpdCBhbHNvIHVz
ZSB0aGUgbmV3DQptYWNyby4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTEgKysrKysrKy0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCmluZGV4IDU0Y2FkOTIzYWUxNi4uOWZlOWE3MDY3NDJjIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KQEAgLTEyNSw2ICsxMjUsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X29wcyBtdGtf
aW9tbXVfb3BzOw0KIA0KIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0
IG10a19pb21tdV9kYXRhICpkYXRhKTsNCiANCisjZGVmaW5lIE1US19JT01NVV9BRERSKGFkZHIp
ICh7dW5zaWduZWQgbG9uZyBfYWRkciA9IGFkZHI7IFwNCisJCQkgICAgICAobG93ZXJfMzJfYml0
cyhfYWRkcikgfCB1cHBlcl8zMl9iaXRzKF9hZGRyKSk7IH0pDQorDQogLyoNCiAgKiBJbiBNNFUg
NEdCIG1vZGUsIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGlzIHJlbWFwcGVkIGFzIGJlbG93Og0KICAq
DQpAQCAtMjEzLDggKzIxNiw5IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV90bGJfZmx1c2hfcmFu
Z2Vfc3luYyh1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLA0KIAkJd3JpdGVsX3JlbGF4
ZWQoRl9JTlZMRF9FTjEgfCBGX0lOVkxEX0VOMCwNCiAJCQkgICAgICAgZGF0YS0+YmFzZSArIGRh
dGEtPnBsYXRfZGF0YS0+aW52X3NlbF9yZWcpOw0KIA0KLQkJd3JpdGVsX3JlbGF4ZWQoaW92YSwg
ZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WTERfU1RBUlRfQSk7DQotCQl3cml0ZWxfcmVsYXhlZChp
b3ZhICsgc2l6ZSAtIDEsDQorCQl3cml0ZWxfcmVsYXhlZChNVEtfSU9NTVVfQUREUihpb3ZhKSwN
CisJCQkgICAgICAgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WTERfU1RBUlRfQSk7DQorCQl3cml0
ZWxfcmVsYXhlZChNVEtfSU9NTVVfQUREUihpb3ZhICsgc2l6ZSAtIDEpLA0KIAkJCSAgICAgICBk
YXRhLT5iYXNlICsgUkVHX01NVV9JTlZMRF9FTkRfQSk7DQogCQl3cml0ZWxfcmVsYXhlZChGX01N
VV9JTlZfUkFOR0UsDQogCQkJICAgICAgIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0lOVkFMSURBVEUp
Ow0KQEAgLTYzNCw4ICs2MzgsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0
IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCiAJaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1
X3BsYXQgPT0gTTRVX01UODE3MykNCiAJCXJlZ3ZhbCA9IChkYXRhLT5wcm90ZWN0X2Jhc2UgPj4g
MSkgfCAoZGF0YS0+ZW5hYmxlXzRHQiA8PCAzMSk7DQogCWVsc2UNCi0JCXJlZ3ZhbCA9IGxvd2Vy
XzMyX2JpdHMoZGF0YS0+cHJvdGVjdF9iYXNlKSB8DQotCQkJIHVwcGVyXzMyX2JpdHMoZGF0YS0+
cHJvdGVjdF9iYXNlKTsNCisJCXJlZ3ZhbCA9IE1US19JT01NVV9BRERSKGRhdGEtPnByb3RlY3Rf
YmFzZSk7DQogCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSVZS
UF9QQUREUik7DQogDQogCWlmIChkYXRhLT5lbmFibGVfNEdCICYmDQotLSANCjIuMTguMA0K

