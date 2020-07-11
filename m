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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5EC433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B848420720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nUBEuMrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGKGvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:51:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32522 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:51 -0400
X-UUID: 0988d45bc59946f4969a52bd4972c7cc-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YUbcm/TBN5RpjbvnJmbmtx55LW0FOK8Zwv658hz9Q9w=;
        b=nUBEuMrJxTmU4gj5oZNvNCTfCSfYG7LjZnG2ttLkf/x1TkEhtM8OC2PlqllGxBm783YCyQbG0fvq2DeHB1zqoAEuAF+zPnqdzQtKi/lBXv+wn/Jr49amotH4kTGygOrhe9fLuOAUsH2uYcYYH8fmTNKxSlh4bvH0OVUyZM0+NpE=;
X-UUID: 0988d45bc59946f4969a52bd4972c7cc-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 912225520; Sat, 11 Jul 2020 14:51:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:36 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        Hao Chao <hao.chao@mediatek.com>
Subject: [PATCH 12/21] iommu/mediatek: Add iova reserved function
Date:   Sat, 11 Jul 2020 14:48:37 +0800
Message-ID: <20200711064846.16007-13-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E991A55DC3F3DBDB7EA98A2A0FED2C01FE166FBEE9AB15389FC6CB8FE9770A432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG11bHRpcGxlIGlvbW11X2RvbWFpbnMsIHdlIG5lZWQgdG8gcmVzZXJ2ZSBzb21lIGlvdmEg
cmVnaW9ucywgc28gd2UNCndpbGwgYWRkIG10a19pb21tdV9pb3ZhX3JlZ2lvbiBzdHJ1Y3R1cmUu
IEl0IGluY2x1ZGVzIHRoZSBiYXNlIGFkZHJlc3MNCmFuZCBzaXplIG9mIHRoZSByYW5nZS4NClRo
aXMgaXMgYSBwcmVwYXJpbmcgcGF0Y2ggZm9yIHN1cHBvcnRpbmcgbXVsdGktZG9tYWluLg0KDQpT
aWduZWQtb2ZmLWJ5OiBBbmFuIHN1bjxhbmFuLnN1bkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBIYW8gQ2hhbzxoYW8uY2hhb0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBZb25n
IFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaCB8ICA1ICsrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggMDNhNmQ2NmY0YmVmLi5mZGZkYjc1NzA2ZTAgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11
L210a19pb21tdS5jDQpAQCAtMTUxLDYgKzE1MSwxMSBAQCBzdGF0aWMgTElTVF9IRUFEKG00dWxp
c3QpOwkvKiBMaXN0IGFsbCB0aGUgTTRVIEhXcyAqLw0KIA0KICNkZWZpbmUgZm9yX2VhY2hfbTR1
KGRhdGEpCWxpc3RfZm9yX2VhY2hfZW50cnkoZGF0YSwgJm00dWxpc3QsIGxpc3QpDQogDQorc3Ry
dWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbiB7DQorCWRtYV9hZGRyX3QJCWlvdmFfYmFzZTsNCisJ
c2l6ZV90CQkJc2l6ZTsNCit9Ow0KKw0KIC8qDQogICogVGhlcmUgbWF5IGJlIDEgb3IgMiBNNFUg
SFdzLCBCdXQgd2UgYWx3YXlzIGV4cGVjdCB0aGV5IGFyZSBpbiB0aGUgc2FtZSBkb21haW4NCiAg
KiBmb3IgdGhlIHBlcmZvcm1hbmNlLg0KQEAgLTU0NSw2ICs1NTAsMzYgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfb2ZfeGxhdGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgb2ZfcGhhbmRsZV9h
cmdzICphcmdzKQ0KIAlyZXR1cm4gaW9tbXVfZndzcGVjX2FkZF9pZHMoZGV2LCBhcmdzLT5hcmdz
LCAxKTsNCiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3Ry
dWN0IGRldmljZSAqZGV2LA0KKwkJCQkgICAgICAgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkNCit7
DQorCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYp
Ow0KKwljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpyZXN2Ow0KKwlzdHJ1Y3Qg
aW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsNCisJaW50IHByb3QgPSBJT01NVV9XUklURSB8IElP
TU1VX1JFQUQ7DQorCXVuc2lnbmVkIGludCBpOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgZGF0YS0+
cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbl9ucjsgaSsrKSB7DQorCQlyZXN2ID0gZGF0YS0+cGxhdF9k
YXRhLT5pb3ZhX3JlZ2lvbiArIGk7DQorDQorCQlyZWdpb24gPSBpb21tdV9hbGxvY19yZXN2X3Jl
Z2lvbihyZXN2LT5pb3ZhX2Jhc2UsIHJlc3YtPnNpemUsDQorCQkJCQkJIHByb3QsIElPTU1VX1JF
U1ZfUkVTRVJWRUQpOw0KKwkJaWYgKCFyZWdpb24pDQorCQkJcmV0dXJuOw0KKw0KKwkJbGlzdF9h
ZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsNCisJfQ0KK30NCisNCitzdGF0aWMgdm9pZCBt
dGtfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQorCQkJCSAgICAg
ICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQ0KK3sNCisJc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9u
ICplbnRyeSwgKm5leHQ7DQorDQorCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRyeSwgbmV4
dCwgaGVhZCwgbGlzdCkNCisJCWtmcmVlKGVudHJ5KTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0
cnVjdCBpb21tdV9vcHMgbXRrX2lvbW11X29wcyA9IHsNCiAJLmRvbWFpbl9hbGxvYwk9IG10a19p
b21tdV9kb21haW5fYWxsb2MsDQogCS5kb21haW5fZnJlZQk9IG10a19pb21tdV9kb21haW5fZnJl
ZSwNCkBAIC01NTksNiArNTk0LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRr
X2lvbW11X29wcyA9IHsNCiAJLnJlbGVhc2VfZGV2aWNlCT0gbXRrX2lvbW11X3JlbGVhc2VfZGV2
aWNlLA0KIAkuZGV2aWNlX2dyb3VwCT0gbXRrX2lvbW11X2RldmljZV9ncm91cCwNCiAJLm9mX3hs
YXRlCT0gbXRrX2lvbW11X29mX3hsYXRlLA0KKwkuZ2V0X3Jlc3ZfcmVnaW9ucyA9IG10a19pb21t
dV9nZXRfcmVzdl9yZWdpb25zLA0KKwkucHV0X3Jlc3ZfcmVnaW9ucyA9IG10a19pb21tdV9wdXRf
cmVzdl9yZWdpb25zLA0KIAkucGdzaXplX2JpdG1hcAk9IFNaXzRLIHwgU1pfNjRLIHwgU1pfMU0g
fCBTWl8xNk0sDQogfTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5o
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggZTk2NWJjYjE2OWMwLi5iYjkyOWI4
NzVkOGMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysgYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAtNDMsMTAgKzQzLDE1IEBAIGVudW0gbXRrX2lvbW11
X3BsYXQgew0KIAlNNFVfTVQ4MTgzLA0KIH07DQogDQorc3RydWN0IG10a19pb21tdV9pb3ZhX3Jl
Z2lvbjsNCisNCiBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQogCWVudW0gbXRrX2lvbW11
X3BsYXQgbTR1X3BsYXQ7DQogCXUzMiAgICAgICAgICAgICAgICAgZmxhZ3M7DQogCXUzMiAgICAg
ICAgICAgICAgICAgaW52X3NlbF9yZWc7DQorDQorCXVuc2lnbmVkIGludCAgICAgICAgaW92YV9y
ZWdpb25fbnI7DQorCWNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdpb24gICAqaW92YV9y
ZWdpb247DQogCXVuc2lnbmVkIGNoYXIgICAgICAgbGFyYmlkX3JlbWFwW01US19MQVJCX0NPTV9N
QVhdW01US19MQVJCX1NVQkNPTV9NQVhdOw0KIH07DQogDQotLSANCjIuMTguMA0K

