Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2070C246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="njzzJdKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgB1NpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50341 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgB1NpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:08 -0500
X-UUID: 15adbd6cb58f49e1b9f0f4e2bde2507a-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bTX0cCiScaXtIBSkv87kPytj8AhJ8XJXwamGokuJhC8=;
        b=njzzJdKZ5BxfxbTg6KgZ/N9vHy+wjZBoFSjNDQ1Zg8WLpsFCQM9RW7yUCGG550bNstweN4A477XzdEBvefvMwpXNaPfeN91bbfqqPIH6hJOjrN4L7CzCWZP07TdX8j16Bx2SO5uqXrIiczv1ECmeuKt0wWfdLwPP6uXSqUuq5jM=;
X-UUID: 15adbd6cb58f49e1b9f0f4e2bde2507a-20200228
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1256504418; Fri, 28 Feb 2020 21:45:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:44:58 +0800
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
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 00/13] support gce on mt6779 platform
Date:   Fri, 28 Feb 2020 21:44:08 +0800
Message-ID: <1582897461-15105-2-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
ZCBleHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCi0gZ2l2ZSBhcmdfYSBuYW1lDQoNCg0KRGVubmlz
IFlDIEhzaWVoICgxMyk6DQogIGR0LWJpbmRpbmc6IGdjZTogYWRkIGdjZSBoZWFkZXIgZmlsZSBm
b3IgbXQ2Nzc5DQogIG1haWxib3g6IGNtZHE6IHZhcmlhYmxpemUgYWRkcmVzcyBzaGlmdCBpbiBw
bGF0Zm9ybQ0KICBtYWlsYm94OiBjbWRxOiBzdXBwb3J0IG10Njc3OSBnY2UgcGxhdGZvcm0gZGVm
aW5pdGlvbg0KICBtYWlsYm94OiBtZWRpYXRlazogY21kcTogY2xlYXIgdGFzayBpbiBjaGFubmVs
IGJlZm9yZSBzaHV0ZG93bg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiByZXR1cm4gc2VuZCBtc2cg
ZXJyb3IgY29kZQ0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgYXNzaWduIGZ1bmN0aW9uDQog
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0ZV9zIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0
ZWs6IGNtZHE6IGFkZCByZWFkX3MgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRk
IHdyaXRlX3MgdmFsdWUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogZXhwb3J0IGZp
bmFsaXplIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBqdW1wIGZ1bmN0aW9u
DQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBjbGVhciBvcHRpb24gaW4gY21kcV9wa3Rfd2Zl
IGFwaQ0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgc2V0IGV2ZW50IGZ1bmN0aW9uDQoNCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0ICAgfCAgIDggKy0NCiBk
cml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jICAgICAgICAgICAgfCAgOTcgKysrKysr
Ky0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgICAgICAgfCAxNDMg
KysrKysrKysrKy0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tdDY3NzktZ2NlLmggICAgICAg
ICAgfCAyMjIgKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaCAgICAgIHwgIDEwICstDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaCAgICAgICAgIHwgIDk0ICsrKysrKystDQogNiBmaWxlcyBjaGFuZ2VkLCA1NDMg
aW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaA0KDQotLSANCjIuMTguMA0K

