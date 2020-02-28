Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B5BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED24246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ky9EmE1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgB1NpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60099 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726867AbgB1No7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:44:59 -0500
X-UUID: e8bb48947a9946a08acb1aea8836e8ba-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=y7T1TMD9w293pE+Fxbud4yhXgZQSFHACeiXgIaBB2Vs=;
        b=Ky9EmE1HcdDiMzqgmx6yp9aIR8Hv72WlBjmUImO1yhLIxbMQkIoyxYpswULDla8is0zvtl1hMvkNXm5BOKpuKH017kA9bWK3I6xteBEibdMQWjQYzPHgmLkw56qSJ1goM6VshLdoFXnycChqrCDJRc1q+00bL+USYp6p27a+290=;
X-UUID: e8bb48947a9946a08acb1aea8836e8ba-20200228
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1548517905; Fri, 28 Feb 2020 21:44:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:43:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:44:49 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v3 00/13] support gce on mt6779 platform
Date:   Fri, 28 Feb 2020 21:44:07 +0800
Message-ID: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzdXBwb3J0IGdjZSBvbiBtdDY3NzkgcGxhdGZvcm0uDQoNCkNoYW5nZSBzaW5j
ZSB2MjoNCi0gcmViYXNlIG9udG8gNS42LXJjMQ0KLSByZW1vdmUgdW5uZWNlc3NhcnkgZGVmaW5p
dGlvbg0KLSBhZGQgY2xlYXIgcGFyYW1ldGVyIGluIHdmZSBhcGkNCi0gc2VwYXJhdGUgYXNzaWdu
IGFuZCB3cml0ZV9zIGFwaQ0KLSBhZGQganVtcCBhcGkgaW5zdGVhZCBvZiBmaW5hbGl6ZSBpbiBs
b29wDQoNCkNoYW5nZSBzaW5jZSB2MToNCi0gY2hhbmdlIHdyaXRlX3MgaW50ZXJmYWNlIHRvIGNv
bnNpc3RhbnQgd2l0aCByZWFkX3MNCi0gcmVtb3ZlIGNvbWJpbmF0aW9uIGZ1bmN0aW9uIGFuZCBk
ZXNpZ24gd3JpdGVfc192YWx1ZSBmdW5jdGlvbg0KLSBkbyBub3QgY2hlY2sgZmluYWxpemVkIGFu
ZCBleHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCi0gZ2l2ZSBhcmdfYSBuYW1lDQoNCg0KDQpEZW5u
aXMgWUMgSHNpZWggKDEzKToNCiAgZHQtYmluZGluZzogZ2NlOiBhZGQgZ2NlIGhlYWRlciBmaWxl
IGZvciBtdDY3NzkNCiAgbWFpbGJveDogY21kcTogdmFyaWFibGl6ZSBhZGRyZXNzIHNoaWZ0IGlu
IHBsYXRmb3JtDQogIG1haWxib3g6IGNtZHE6IHN1cHBvcnQgbXQ2Nzc5IGdjZSBwbGF0Zm9ybSBk
ZWZpbml0aW9uDQogIG1haWxib3g6IG1lZGlhdGVrOiBjbWRxOiBjbGVhciB0YXNrIGluIGNoYW5u
ZWwgYmVmb3JlIHNodXRkb3duDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IHJldHVybiBzZW5kIG1z
ZyBlcnJvciBjb2RlDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBhc3NpZ24gZnVuY3Rpb24N
CiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3MgZnVuY3Rpb24NCiAgc29jOiBtZWRp
YXRlazogY21kcTogYWRkIHJlYWRfcyBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBh
ZGQgd3JpdGVfcyB2YWx1ZSBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBleHBvcnQg
ZmluYWxpemUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGp1bXAgZnVuY3Rp
b24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGNsZWFyIG9wdGlvbiBpbiBjbWRxX3BrdF93
ZmUgYXBpDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBzZXQgZXZlbnQgZnVuY3Rpb24NCg0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQgICB8ICAgOCArLQ0K
IGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgICAgICB8ICA5NyArKysr
KysrLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgICAgICB8IDE0
MyArKysrKysrKysrLQ0KIGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaCAgICAg
ICAgICB8IDIyMiArKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oICAgICAgfCAgMTAgKy0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oICAgICAgICAgfCAgOTQgKysrKysrKy0NCiA2IGZpbGVzIGNoYW5nZWQsIDU0
MyBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5oDQoNCi0tIA0KMi4xOC4w

