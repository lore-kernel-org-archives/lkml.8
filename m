Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A6C3527C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B8222D06
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NMPiME1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgHFJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:29:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729125AbgHFJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:23:54 -0400
X-UUID: 9e0d86cab91b406ca54e43ba3d261a5f-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nV+1VPDViPYhiu9TwtqZGVPTCpQQXdDn8Cms96SrwTc=;
        b=NMPiME1gvLs6mV8YUHlx/a+TjdUv3ZvCWvMEHXkZigoChZ2+QQfBD3up3h9zIGp3Hd0vekqn4xCvgcFyN+kguZOQJuIGRC+wKKYsZUqk0FbijK9CgjGmuH75X+m6QrZXOMKuyQIA7OBjvknUWU9BntEQ5C7GcXTArkuA0DGqOVU=;
X-UUID: 9e0d86cab91b406ca54e43ba3d261a5f-20200806
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 126296518; Thu, 06 Aug 2020 17:22:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 17:21:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 17:21:59 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v17 07/12] soc: mediatek: Add subsys clock control for bus protection
Date:   Thu, 6 Aug 2020 17:21:50 +0800
Message-ID: <1596705715-15320-8-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHRoZSBidXMgcHJvdGVjdGlvbiBvcGVyYXRpb25zLCBzb21lIHN1YnN5cyBjbG9ja3MgbmVl
ZCB0byBiZSBlbmFibGVkDQpiZWZvcmUgcmVsZWFzaW5nIHRoZSBwcm90ZWN0aW9uLCBhbmQgdmlj
ZSB2ZXJzYS4NCkJ1dCB0aG9zZSBzdWJzeXMgY2xvY2tzIGNvdWxkIG9ubHkgYmUgY29udHJvbGxl
ZCBvbmNlIGl0cyBjb3JyZXNwb25kaW5nDQpwb3dlciBkb21haW4gaXMgdHVybmVkIG9uIGZpcnN0
Lg0KSW4gdGhpcyBwYXRjaCwgd2UgYWRkIHRoZSBzdWJzeXMgY2xvY2sgY29udHJvbCBpbnRvIGl0
cyByZWxldmFudCBzdGVwcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyB8IDM5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAzNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jDQppbmRleCA1MDJiNjZmLi5lYzYyMTQzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMNCkBAIC03LDYgKzcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KICNpbmNsdWRl
IDxsaW51eC9pb3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KKyNpbmNs
dWRlIDxsaW51eC9vZl9jbGsuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9wbV9kb21h
aW4uaD4NCkBAIC05Nyw2ICs5OCw3IEBADQogI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VO
X01GR19TTk9PUF9PVVQJQklUKDIzKQ0KIA0KICNkZWZpbmUgTUFYX0NMS1MJMw0KKyNkZWZpbmUg
TUFYX1NVQlNZU19DTEtTIDEwDQogDQogI2RlZmluZSBNQVhfU1RFUFMJNQ0KIA0KQEAgLTE2NSw2
ICsxNjcsNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFpbiB7DQogCXN0cnVjdCBnZW5lcmljX3BtX2RvbWFp
biBnZW5wZDsNCiAJc3RydWN0IHNjcCAqc2NwOw0KIAlzdHJ1Y3QgY2xrICpjbGtbTUFYX0NMS1Nd
Ow0KKwlzdHJ1Y3QgY2xrICpzdWJzeXNfY2xrW01BWF9TVUJTWVNfQ0xLU107DQogCWNvbnN0IHN0
cnVjdCBzY3BfZG9tYWluX2RhdGEgKmRhdGE7DQogCXN0cnVjdCByZWd1bGF0b3IgKnN1cHBseTsN
CiB9Ow0KQEAgLTQyNywxNiArNDMwLDIyIEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2VyX29uKHN0
cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCXZhbCB8PSBQV1JfUlNUX0JfQklUOw0K
IAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQogDQotCXJldCA9IHNjcHN5c19zcmFtX2VuYWJsZShz
Y3BkLCBjdGxfYWRkcik7DQorCXJldCA9IHNjcHN5c19jbGtfZW5hYmxlKHNjcGQtPnN1YnN5c19j
bGssIE1BWF9TVUJTWVNfQ0xLUyk7DQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byBlcnJfcHdyX2Fj
azsNCiANCisJcmV0ID0gc2Nwc3lzX3NyYW1fZW5hYmxlKHNjcGQsIGN0bF9hZGRyKTsNCisJaWYg
KHJldCA8IDApDQorCQlnb3RvIGVycl9zcmFtOw0KKw0KIAlyZXQgPSBzY3BzeXNfYnVzX3Byb3Rl
Y3RfZGlzYWJsZShzY3BkKTsNCiAJaWYgKHJldCA8IDApDQotCQlnb3RvIGVycl9wd3JfYWNrOw0K
KwkJZ290byBlcnJfc3JhbTsNCiANCiAJcmV0dXJuIDA7DQogDQorZXJyX3NyYW06DQorCXNjcHN5
c19jbGtfZGlzYWJsZShzY3BkLT5zdWJzeXNfY2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KIGVycl9w
d3JfYWNrOg0KIAlzY3BzeXNfY2xrX2Rpc2FibGUoc2NwZC0+Y2xrLCBNQVhfQ0xLUyk7DQogZXJy
X2NsazoNCkBAIC00NjMsNiArNDcyLDggQEAgc3RhdGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0
cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byBv
dXQ7DQogDQorCXNjcHN5c19jbGtfZGlzYWJsZShzY3BkLT5zdWJzeXNfY2xrLCBNQVhfU1VCU1lT
X0NMS1MpOw0KKw0KIAkvKiBzdWJzeXMgcG93ZXIgb2ZmICovDQogCXZhbCA9IHJlYWRsKGN0bF9h
ZGRyKTsNCiAJdmFsIHw9IFBXUl9JU09fQklUOw0KQEAgLTUwMCw2ICs1MTEsMjQgQEAgc3RhdGlj
IGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQog
CXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQgaW5pdF9zdWJzeXNfY2xrcyhzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wLA0KKwkJc3RydWN0IGNsayAqKmNsaykNCit7DQorCWludCBzdWJfY2xr
X2NudCA9IG9mX2Nsa19nZXRfcGFyZW50X2NvdW50KG5wKTsNCisJaW50IGk7DQorDQorCUJVR19P
TihzdWJfY2xrX2NudCA+IE1BWF9TVUJTWVNfQ0xLUyk7DQorDQorCWZvciAoaSA9IDA7IGkgPCBz
dWJfY2xrX2NudDsgaSsrKSB7DQorCQljbGtbaV0gPSBvZl9jbGtfZ2V0KG5wLCBpKTsNCisNCisJ
CWlmIChJU19FUlIoY2xrW2ldKSkNCisJCQlyZXR1cm4gUFRSX0VSUihjbGtbaV0pOw0KKwl9DQor
DQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgaW50IGluaXRfYmFzaWNfY2xrcyhzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LCBzdHJ1Y3QgY2xrICoqY2xrLA0KIAkJCWNvbnN0IGNoYXIg
KiBjb25zdCAqbmFtZSkNCiB7DQpAQCAtNTMzLDExICs1NjIsMTcgQEAgc3RhdGljIGludCBzY3Bz
eXNfZ2V0X2RvbWFpbihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBzdHJ1Y3Qgc2NwICpz
Y3AsDQogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqc3ViOw0KIAl1MzIgcGFyZW50X2lkLCBjaGlsZF9p
ZDsNCiAJaW50IHJldDsNCisJc3RydWN0IHNjcF9kb21haW4gKnNjcGQ7DQogDQogCXJldCA9IHNj
cHN5c19nZXRfZG9tYWluX2lkKG5vZGUsICZwYXJlbnRfaWQpOw0KIAlpZiAocmV0KQ0KIAkJcmV0
dXJuIHJldDsNCiANCisJc2NwZCA9ICZzY3AtPmRvbWFpbnNbcGFyZW50X2lkXTsNCisJcmV0ID0g
aW5pdF9zdWJzeXNfY2xrcyhub2RlLCBzY3BkLT5zdWJzeXNfY2xrKTsNCisJaWYgKHJldCkNCisJ
CXJldHVybiByZXQ7DQorDQogCWZvcl9lYWNoX2NoaWxkX29mX25vZGUobm9kZSwgc3ViKSB7DQog
CQlyZXQgPSBzY3BzeXNfZ2V0X2RvbWFpbl9pZChzdWIsICZjaGlsZF9pZCk7DQogCQlpZiAocmV0
KQ0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

