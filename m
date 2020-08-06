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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C7C38149
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A058922D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y3H2sHxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgHFJda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:33:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51591 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729008AbgHFJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:22:47 -0400
X-UUID: ca487f489f414c2db250a778624f327c-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WTzfa/t8bk8sxGScWdoKmOhtLiKTTktmTscE+vpAf7A=;
        b=Y3H2sHxrdbxhUsv7i6HYTKbS3X042OhpO2CCpu0wA9AMhC712bvUHe2uc5i+i2OK1Jak8EZ2chZgeufiJLiBCTjuWEveiiFqyrWwTquyUkHCUqB5P22LB5JpKT3G4McQLnougvVnp7mo+vmM3VysHW15UqhJ2pF6N7H2UMY+RVM=;
X-UUID: ca487f489f414c2db250a778624f327c-20200806
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1798099553; Thu, 06 Aug 2020 17:22:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v17 06/12] soc: mediatek: Add support for hierarchical scpsys device node
Date:   Thu, 6 Aug 2020 17:21:49 +0800
Message-ID: <1596705715-15320-7-git-send-email-weiyi.lu@mediatek.com>
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

VHJ5IHRvIGxpc3QgYWxsIHRoZSBwb3dlciBkb21haW5zIG9mIHVuZGVyIHBvd2VyIGNvbnRyb2xs
ZXINCm5vZGUgdG8gc2hvdyB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIGVhY2ggcG93ZXIgZG9tYWlu
IGRpcmVjdGx5DQppbnN0ZWFkIG9mIGZpbGxpbmcgdGhlIGRlcGVuZGVuY3kgaW4gc2NwX3NvY19k
YXRhLg0KQW5kIGNvdWxkIGJlIG1vcmUgY2xlYXJseSB0byBncm91cCBzdWJzeXMgY2xvY2tzIGlu
dG8gcG93ZXIgZG9tYWluDQpzdWIgbm9kZSB0byBpbnRyb2R1Y2Ugc3Vic3lzIGNsb2NrcyBvZiBi
dXMgcHJvdGVjdGlvbiBpbiBuZXh0IHBhdGNoLg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8
d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jIHwgMTAzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDVhMmMzMjMuLjUwMmI2NmYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1zY3BzeXMuYw0KQEAgLTE4MiwxMSArMTgyLDEzIEBAIHN0cnVjdCBzY3Agew0KIAlz
dHJ1Y3QgcmVnbWFwICppbmZyYWNmZzsNCiAJc3RydWN0IHJlZ21hcCAqc21pX2NvbW1vbjsNCiAJ
c3RydWN0IHNjcF9jdHJsX3JlZyBjdHJsX3JlZzsNCisJc3RydWN0IGxpc3RfaGVhZCBkZXBfbGlu
a3M7DQogfTsNCiANCiBzdHJ1Y3Qgc2NwX3N1YmRvbWFpbiB7DQogCWludCBvcmlnaW47DQogCWlu
dCBzdWJkb21haW47DQorCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsNCiB9Ow0KIA0KIHN0cnVjdCBz
Y3Bfc29jX2RhdGEgew0KQEAgLTUxMyw2ICs1MTUsNzkgQEAgc3RhdGljIGludCBpbml0X2Jhc2lj
X2Nsa3Moc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IGNsayAqKmNsaywNCiAJ
cmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyBpbnQgc2Nwc3lzX2dldF9kb21haW5faWQoc3RydWN0
IGRldmljZV9ub2RlICpub2RlLCB1MzIgKmlkKQ0KK3sNCisJaW50IHJldDsNCisNCisJcmV0ID0g
b2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInJlZyIsIGlkKTsNCisJaWYgKHJldCkNCisJCXBy
X2VycigiJXBPRm46IGZhaWxlZCB0byByZXRyaWV2ZSBkb21haW4gaWQsIHJldD0lZFxuIiwgbm9k
ZSwgcmV0KTsNCisNCisJcmV0dXJuIHJldDsNCit9DQorDQorc3RhdGljIGludCBzY3BzeXNfZ2V0
X2RvbWFpbihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBzdHJ1Y3Qgc2NwICpzY3AsDQor
CQkJc3RydWN0IGRldmljZV9ub2RlICpub2RlLCBjb25zdCBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRh
ICpkYXRhKQ0KK3sNCisJc3RydWN0IHNjcF9zdWJkb21haW4gKmRlcF9ub2RlOw0KKwlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnN1YjsNCisJdTMyIHBhcmVudF9pZCwgY2hpbGRfaWQ7DQorCWludCByZXQ7
DQorDQorCXJldCA9IHNjcHN5c19nZXRfZG9tYWluX2lkKG5vZGUsICZwYXJlbnRfaWQpOw0KKwlp
ZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShub2Rl
LCBzdWIpIHsNCisJCXJldCA9IHNjcHN5c19nZXRfZG9tYWluX2lkKHN1YiwgJmNoaWxkX2lkKTsN
CisJCWlmIChyZXQpDQorCQkJZ290byBvdXQ7DQorDQorCQlkZXBfbm9kZSA9IGRldm1fa3phbGxv
YygmcGRldi0+ZGV2LCBzaXplb2YoKmRlcF9ub2RlKSwgR0ZQX0tFUk5FTCk7DQorCQlpZiAoIWRl
cF9ub2RlKSB7DQorCQkJcmV0ID0gLUVOT01FTTsNCisJCQlnb3RvIG91dDsNCisJCX0NCisNCisJ
CWRlcF9ub2RlLT5vcmlnaW4gPSBwYXJlbnRfaWQ7DQorCQlkZXBfbm9kZS0+c3ViZG9tYWluID0g
Y2hpbGRfaWQ7DQorCQlsaXN0X2FkZCgmZGVwX25vZGUtPmxpc3QsICZzY3AtPmRlcF9saW5rcyk7
DQorDQorCQlzY3BzeXNfZ2V0X2RvbWFpbihwZGV2LCBzY3AsIHN1YiwgZGF0YSk7DQorCX0NCisN
CisJcmV0dXJuIDA7DQorDQorb3V0Og0KKwlvZl9ub2RlX3B1dChzdWIpOw0KKwlyZXR1cm4gcmV0
Ow0KK30NCisNCitzdGF0aWMgaW50IHRyYXZlcnNlX3NjcChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2LCBzdHJ1Y3Qgc2NwICpzY3AsDQorCQkJY29uc3Qgc3RydWN0IHNjcF9kb21haW5fZGF0
YSAqc2NwX2RvbWFpbl9kYXRhKQ0KK3sNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRl
djsNCisJc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCisJc3RydWN0IGRl
dmljZV9ub2RlICpzdWI7DQorCWludCByZXQ7DQorDQorCUlOSVRfTElTVF9IRUFEKCZzY3AtPmRl
cF9saW5rcyk7DQorDQorCWZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlKG5wLCBzdWIp
IHsNCisJCXJldCA9IHNjcHN5c19nZXRfZG9tYWluKHBkZXYsIHNjcCwgc3ViLCBzY3BfZG9tYWlu
X2RhdGEpOw0KKwkJaWYgKHJldCkgew0KKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0
byBoYW5kbGUgbm9kZSAlcE9GbjogJWRcbiIsIHN1YiwgcmV0KTsNCisJCQlnb3RvIGVycjsNCisJ
CX0NCisJfQ0KKw0KKwlyZXR1cm4gMDsNCisNCitlcnI6DQorCW9mX25vZGVfcHV0KHN1Yik7DQor
CXJldHVybiByZXQ7DQorfQ0KKw0KIHN0YXRpYyBzdHJ1Y3Qgc2NwICppbml0X3NjcChzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkJCWNvbnN0IHN0cnVjdCBzY3BfZG9tYWluX2RhdGEg
KnNjcF9kb21haW5fZGF0YSwgaW50IG51bSwNCiAJCQljb25zdCBzdHJ1Y3Qgc2NwX2N0cmxfcmVn
ICpzY3BfY3RybF9yZWcpDQpAQCAtNTgyLDYgKzY1NywxMCBAQCBzdGF0aWMgc3RydWN0IHNjcCAq
aW5pdF9zY3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiANCiAJcGRfZGF0YS0+bnVt
X2RvbWFpbnMgPSBudW07DQogDQorCXJldCA9IHRyYXZlcnNlX3NjcChwZGV2LCBzY3AsIHNjcF9k
b21haW5fZGF0YSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KKw0KIAlm
b3IgKGkgPSAwOyBpIDwgbnVtOyBpKyspIHsNCiAJCXN0cnVjdCBzY3BfZG9tYWluICpzY3BkID0g
JnNjcC0+ZG9tYWluc1tpXTsNCiAJCXN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQgPSAm
c2NwZC0+Z2VucGQ7DQpAQCAtMTIwOCw3ICsxMjg3LDcgQEAgc3RhdGljIGludCBzY3BzeXNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJY29uc3Qgc3RydWN0IHNjcF9zb2Nf
ZGF0YSAqc29jOw0KIAlzdHJ1Y3Qgc2NwICpzY3A7DQogCXN0cnVjdCBnZW5wZF9vbmVjZWxsX2Rh
dGEgKnBkX2RhdGE7DQotCWludCBpLCByZXQ7DQorCWludCBpLCByZXQgPSAwOw0KIA0KIAlzb2Mg
PSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQogDQpAQCAtMTIyMCwxNSAr
MTI5OSwyMyBAQCBzdGF0aWMgaW50IHNjcHN5c19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIA0KIAlwZF9kYXRhID0gJnNjcC0+cGRfZGF0YTsNCiANCi0JZm9yIChpID0gMCwg
c2QgPSBzb2MtPnN1YmRvbWFpbnM7IGkgPCBzb2MtPm51bV9zdWJkb21haW5zOyBpKyssIHNkKysp
IHsNCi0JCXJldCA9IHBtX2dlbnBkX2FkZF9zdWJkb21haW4ocGRfZGF0YS0+ZG9tYWluc1tzZC0+
b3JpZ2luXSwNCi0JCQkJCSAgICAgcGRfZGF0YS0+ZG9tYWluc1tzZC0+c3ViZG9tYWluXSk7DQot
CQlpZiAocmV0ICYmIElTX0VOQUJMRUQoQ09ORklHX1BNKSkNCi0JCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJGYWlsZWQgdG8gYWRkIHN1YmRvbWFpbjogJWRcbiIsDQotCQkJCXJldCk7DQorCWlmIChz
b2MtPnN1YmRvbWFpbnMgJiYgc29jLT5udW1fc3ViZG9tYWlucykgew0KKwkJZm9yIChpID0gMCwg
c2QgPSBzb2MtPnN1YmRvbWFpbnM7IGkgPCBzb2MtPm51bV9zdWJkb21haW5zOyBpKyssIHNkKysp
IHsNCisJCQlyZXQgPSBwbV9nZW5wZF9hZGRfc3ViZG9tYWluKHBkX2RhdGEtPmRvbWFpbnNbc2Qt
Pm9yaWdpbl0sDQorCQkJCQkJICAgICBwZF9kYXRhLT5kb21haW5zW3NkLT5zdWJkb21haW5dKTsN
CisJCQlpZiAocmV0ICYmIElTX0VOQUJMRUQoQ09ORklHX1BNKSkNCisJCQkJZGV2X2VycigmcGRl
di0+ZGV2LCAiRmFpbGVkIHRvIGFkZCBzdWJkb21haW46ICVkXG4iLCByZXQpOw0KKwkJfQ0KKwl9
IGVsc2Ugew0KKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShzZCwgJnNjcC0+ZGVwX2xpbmtzLCBsaXN0
KSB7DQorCQkJcmV0ID0gcG1fZ2VucGRfYWRkX3N1YmRvbWFpbihwZF9kYXRhLT5kb21haW5zW3Nk
LT5vcmlnaW5dLA0KKwkJCQkJCSAgICAgcGRfZGF0YS0+ZG9tYWluc1tzZC0+c3ViZG9tYWluXSk7
DQorCQkJaWYgKHJldCAmJiBJU19FTkFCTEVEKENPTkZJR19QTSkpDQorCQkJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIkZhaWxlZCB0byBhZGQgc3ViZG9tYWluOiAlZFxuIiwgcmV0KTsNCisJCX0NCiAJ
fQ0KIA0KLQlyZXR1cm4gMDsNCisJcmV0dXJuIHJldDsNCiB9DQogDQogc3RhdGljIHN0cnVjdCBw
bGF0Zm9ybV9kcml2ZXIgc2Nwc3lzX2RydiA9IHsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

