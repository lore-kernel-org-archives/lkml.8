Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D05C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF652083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W2Z/bVmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgCCK7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:59:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40631 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgCCK7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:59:03 -0500
X-UUID: c8be9f893939486b86a55058bb6470e8-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4gus99AtaWbfJ9Jj+bwXAIVepEEKDooIVQr0HxfQqRY=;
        b=W2Z/bVmBpfMXBaPYcNmhZFaDkQUaAg3wmsXh3id6rvMWX3YZjPwxGHhgoqPnk7WD7xU5T7n/Xh5YVD+KrqJrtgFlV2pHvuMbcZ8gDggVqZz3uAsncys2PnOfnXjXCznZwn6KyC7Pao66zrTlD92WjF212bq3u2BLwKt8MFqyM58=;
X-UUID: c8be9f893939486b86a55058bb6470e8-20200303
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2020885471; Tue, 03 Mar 2020 18:58:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:57:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:58:12 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v4 10/13] soc: mediatek: cmdq: export finalize function
Date:   Tue, 3 Mar 2020 18:58:42 +0800
Message-ID: <1583233125-7827-11-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXhwb3J0IGZpbmFsaXplIGZ1bmN0aW9uIHRvIGNsaWVudCB3aGljaCBoZWxwcyBhcHBlbmQgZW9j
IGFuZCBqdW1wDQpjb21tYW5kIHRvIHBrdC4gTGV0IGNsaWVudCBkZWNpZGUgY2FsbCBmaW5hbGl6
ZSBvciBub3QuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhz
aWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYyB8IDEgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICB8
IDcgKystLS0tLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICB8IDgg
KysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRj
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCmluZGV4IDBkZmNk
MTc4N2U2NS4uN2RhYWFiYzI2ZWIxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmMNCkBAIC00OTAsNiArNDkwLDcgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX2h3
X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJCWNtZHFfcGt0X2NsZWFy
X2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQogCQljbWRxX3BrdF93
ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCiAJCW10a19jcnRjX2RkcF9j
b25maWcoY3J0YywgY21kcV9oYW5kbGUpOw0KKwkJY21kcV9wa3RfZmluYWxpemUoY21kcV9oYW5k
bGUpOw0KIAkJY21kcV9wa3RfZmx1c2hfYXN5bmMoY21kcV9oYW5kbGUsIGRkcF9jbWRxX2NiLCBj
bWRxX2hhbmRsZSk7DQogCX0NCiAjZW5kaWYNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQppbmRleCBhOWViYmFiYjc0MzkuLjU5YmMxMTY0YjQxMSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTM3Miw3ICszNzIsNyBAQCBpbnQgY21kcV9w
a3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0K
IH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQogDQotc3RhdGljIGludCBjbWRx
X3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCitpbnQgY21kcV9wa3RfZmluYWxp
emUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQogew0KIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBp
bnN0ID0geyB7MH0gfTsNCiAJaW50IGVycjsNCkBAIC0zOTIsNiArMzkyLDcgQEAgc3RhdGljIGlu
dCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCiANCiAJcmV0dXJuIGVy
cjsNCiB9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9maW5hbGl6ZSk7DQogDQogc3RhdGljIHZv
aWQgY21kcV9wa3RfZmx1c2hfYXN5bmNfY2Ioc3RydWN0IGNtZHFfY2JfZGF0YSBkYXRhKQ0KIHsN
CkBAIC00MjYsMTAgKzQyNyw2IEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCiAJdW5zaWduZWQgbG9uZyBmbGFn
cyA9IDA7DQogCXN0cnVjdCBjbWRxX2NsaWVudCAqY2xpZW50ID0gKHN0cnVjdCBjbWRxX2NsaWVu
dCAqKXBrdC0+Y2w7DQogDQotCWVyciA9IGNtZHFfcGt0X2ZpbmFsaXplKHBrdCk7DQotCWlmIChl
cnIgPCAwKQ0KLQkJcmV0dXJuIGVycjsNCi0NCiAJcGt0LT5jYi5jYiA9IGNiOw0KIAlwa3QtPmNi
LmRhdGEgPSBkYXRhOw0KIAlwa3QtPmFzeW5jX2NiLmNiID0gY21kcV9wa3RfZmx1c2hfYXN5bmNf
Y2I7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IGZlYzI5MmFhYzgz
Yy4uOTllNzcxNTVmOTY3IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
QEAgLTIxMyw2ICsyMTMsMTQgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTggc3Vic3lzLA0KICAqLw0KIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KIA0KKy8qKg0KKyAqIGNtZHFf
cGt0X2ZpbmFsaXplKCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KKyAq
IEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBl
bHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNtZHFfcGt0X2ZpbmFs
aXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KTsNCisNCiAvKioNCiAgKiBjbWRxX3BrdF9mbHVzaF9h
c3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJvbm91c2x5IGV4ZWN1dGUgdGhlIENNRFEN
CiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgcGFja2V0IGFuZCBjYWxsIGJhY2sgYXQgdGhl
IGVuZCBvZiBkb25lIHBhY2tldA0KLS0gDQoyLjE4LjANCg==

