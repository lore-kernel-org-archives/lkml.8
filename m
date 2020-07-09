Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A05120720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UAPYBQ5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgGIHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:09:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:20654 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbgGIHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:09:50 -0400
X-UUID: 0436a738b37e4c1c8e2c04569d38f0df-20200709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KN9hhzoH05uLeemQtJA/oz8qydIgDPv4Z3bmecE5HhY=;
        b=UAPYBQ5shMTeK3m01pYEwcU3+kokwT2eBJO7UG9yllafqBt3pjL+Gmea8VXejA3JVAmGhXHEAIkgzhUKOVN8DNLj+Y6lytNYM/pTKfnmHBegb8r9LpiFk7iCOF11KKuMv+JT7mJILqqRBnh8Y2iMrpNSE9z2EslPXLHwkqbs4gY=;
X-UUID: 0436a738b37e4c1c8e2c04569d38f0df-20200709
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2115013973; Thu, 09 Jul 2020 15:09:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Jul 2020 15:09:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jul 2020 15:09:40 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v3 PATCH] usb: mtu3: remove unnecessary NULL pointer checks
Date:   Thu, 9 Jul 2020 15:09:01 +0800
Message-ID: <1594278541-24968-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E0704D007BDFE6557E27D3F2225493E6F51B016FC12D4C256CBF91EF0F07D15E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNsYXNzIGRyaXZlciB3aWxsIGVuc3VyZSB0aGUgcGFyYW1ldGVycyBhcmUgbm90IE5VTEwN
CnBvaW50ZXJzIGJlZm9yZSBjYWxsIHRoZSBob29rIGZ1bmN0aW9uIG9mIHVzYl9lcF9vcHMsDQpz
byBubyBuZWVkIGNoZWNrIHRoZW0gYWdhaW4uDQoNClJlcG9ydGVkLWJ5OiBNYXJrdXMgRWxmcmlu
ZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2MzogcmVtb3ZlIHVubmVjZXNzYXJ5IE5V
TEwgcG9pbnRlciBjaGVja3MgYnV0IG5vdCBhZGQgbW9yZSBjaGVja3MuDQoNCnYyOiBub3RoaW5n
IGNoYW5nZWQsIGJ1dCBhYmFuZG9uIGFub3RoZXIgcGF0Y2guDQotLS0NCiBkcml2ZXJzL3VzYi9t
dHUzL210dTNfZ2FkZ2V0LmMgfCAyNSArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9tdHUzL210dTNfZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNf
Z2FkZ2V0LmMNCmluZGV4IGY5MzczMmUuLjZiMjZjYjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vz
Yi9tdHUzL210dTNfZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQu
Yw0KQEAgLTI2MywyMyArMjYzLDE1IEBAIHZvaWQgbXR1M19mcmVlX3JlcXVlc3Qoc3RydWN0IHVz
Yl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KIHN0YXRpYyBpbnQgbXR1M19nYWRn
ZXRfcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQogCQlzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSwg
Z2ZwX3QgZ2ZwX2ZsYWdzKQ0KIHsNCi0Jc3RydWN0IG10dTNfZXAgKm1lcDsNCi0Jc3RydWN0IG10
dTNfcmVxdWVzdCAqbXJlcTsNCi0Jc3RydWN0IG10dTMgKm10dTsNCisJc3RydWN0IG10dTNfZXAg
Km1lcCA9IHRvX210dTNfZXAoZXApOw0KKwlzdHJ1Y3QgbXR1M19yZXF1ZXN0ICptcmVxID0gdG9f
bXR1M19yZXF1ZXN0KHJlcSk7DQorCXN0cnVjdCBtdHUzICptdHUgPSBtZXAtPm10dTsNCiAJdW5z
aWduZWQgbG9uZyBmbGFnczsNCiAJaW50IHJldCA9IDA7DQogDQotCWlmICghZXAgfHwgIXJlcSkN
Ci0JCXJldHVybiAtRUlOVkFMOw0KLQ0KIAlpZiAoIXJlcS0+YnVmKQ0KIAkJcmV0dXJuIC1FTk9E
QVRBOw0KIA0KLQltZXAgPSB0b19tdHUzX2VwKGVwKTsNCi0JbXR1ID0gbWVwLT5tdHU7DQotCW1y
ZXEgPSB0b19tdHUzX3JlcXVlc3QocmVxKTsNCi0JbXJlcS0+bXR1ID0gbXR1Ow0KLQ0KIAlpZiAo
bXJlcS0+bWVwICE9IG1lcCkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KQEAgLTMwMyw2ICsyOTUs
NyBAQCBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLA0KIAkJ
cmV0dXJuIC1FU0hVVERPV047DQogCX0NCiANCisJbXJlcS0+bXR1ID0gbXR1Ow0KIAltcmVxLT5y
ZXF1ZXN0LmFjdHVhbCA9IDA7DQogCW1yZXEtPnJlcXVlc3Quc3RhdHVzID0gLUVJTlBST0dSRVNT
Ow0KIA0KQEAgLTMzNSwxMSArMzI4LDExIEBAIHN0YXRpYyBpbnQgbXR1M19nYWRnZXRfZGVxdWV1
ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQogCXN0cnVjdCBt
dHUzX2VwICptZXAgPSB0b19tdHUzX2VwKGVwKTsNCiAJc3RydWN0IG10dTNfcmVxdWVzdCAqbXJl
cSA9IHRvX210dTNfcmVxdWVzdChyZXEpOw0KIAlzdHJ1Y3QgbXR1M19yZXF1ZXN0ICpyOw0KKwlz
dHJ1Y3QgbXR1MyAqbXR1ID0gbWVwLT5tdHU7DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCWlu
dCByZXQgPSAwOw0KLQlzdHJ1Y3QgbXR1MyAqbXR1ID0gbWVwLT5tdHU7DQogDQotCWlmICghZXAg
fHwgIXJlcSB8fCBtcmVxLT5tZXAgIT0gbWVwKQ0KKwlpZiAobXJlcS0+bWVwICE9IG1lcCkNCiAJ
CXJldHVybiAtRUlOVkFMOw0KIA0KIAlkZXZfZGJnKG10dS0+ZGV2LCAiJXMgOiByZXE9JXBcbiIs
IF9fZnVuY19fLCByZXEpOw0KQEAgLTM3OSw5ICszNzIsNiBAQCBzdGF0aWMgaW50IG10dTNfZ2Fk
Z2V0X2VwX3NldF9oYWx0KHN0cnVjdCB1c2JfZXAgKmVwLCBpbnQgdmFsdWUpDQogCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQogCWludCByZXQgPSAwOw0KIA0KLQlpZiAoIWVwKQ0KLQkJcmV0dXJuIC1F
SU5WQUw7DQotDQogCWRldl9kYmcobXR1LT5kZXYsICIlcyA6ICVzLi4uIiwgX19mdW5jX18sIGVw
LT5uYW1lKTsNCiANCiAJc3Bpbl9sb2NrX2lycXNhdmUoJm10dS0+bG9jaywgZmxhZ3MpOw0KQEAg
LTQyNCw5ICs0MTQsNiBAQCBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2VwX3NldF93ZWRnZShzdHJ1
Y3QgdXNiX2VwICplcCkNCiB7DQogCXN0cnVjdCBtdHUzX2VwICptZXAgPSB0b19tdHUzX2VwKGVw
KTsNCiANCi0JaWYgKCFlcCkNCi0JCXJldHVybiAtRUlOVkFMOw0KLQ0KIAltZXAtPndlZGdlZCA9
IDE7DQogDQogCXJldHVybiB1c2JfZXBfc2V0X2hhbHQoZXApOw0KLS0gDQoxLjkuMQ0K

