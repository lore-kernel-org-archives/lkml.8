Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C189C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5621775
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O3NTT6X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgCCK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:58:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:27651 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbgCCK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:58:54 -0500
X-UUID: bc28cf9fb76044f1b8655af63dcb9bc2-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6S4cmgY34o+0zFiuRZM1NT2lvbrUAigCkPYuDJM+qhg=;
        b=O3NTT6X+p8kXyxJf5pOkkyAuMwLeqLk6RdsE5BK/hDCKcFQCFlbpiOCbfuInxqSBgnqUGygKUFrL7eqGDbhzzFeJqlUlw2k/MLYODRVr6KXsW/X2arN3/RuvUDmSlWNq8LKyVFEE4rNuqMVvSpfXEqOYdCVqEUoE9cM2jKS2m1c=;
X-UUID: bc28cf9fb76044f1b8655af63dcb9bc2-20200303
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1088778630; Tue, 03 Mar 2020 18:58:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:57:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:58:10 +0800
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
        HS Liao <hs.liao@mediatek.com>
Subject: [PATCH v4 00/13] support gce on mt6779 platform
Date:   Tue, 3 Mar 2020 18:58:32 +0800
Message-ID: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
ZSB2MzoNCi0gcmVmaW5lIGNvZGUgZm9yIGxvY2FsIHZhcmlhYmxlIHVzYWdlDQotIHVzZSBjbWRx
IGVycm9yIGNvZGUgdG8gY29uc2lzdGVudCB3aXRoIGN1cnJlbnQgZGVzaWduDQotIHJldHVybiBl
cnJvciBkaXJlY3RseSBhZnRlciBzZW5kIGlmIGVycm9yIGNvZGUgcmV0dXJuDQotIGFsc28gbW9k
aWZ5IGRybSBkcml2ZXIgd2hpY2ggdXNlcyBjbWRxX3BrdF93ZmUgYXBpDQotIGFkZCBmaW5hbGl6
ZSBpbiBkcm0gZHJpdmVyDQoNCkNoYW5nZSBzaW5jZSB2MjoNCi0gcmViYXNlIG9udG8gNS42LXJj
MQ0KLSByZW1vdmUgdW5uZWNlc3NhcnkgZGVmaW5pdGlvbg0KLSBhZGQgY2xlYXIgcGFyYW1ldGVy
IGluIHdmZSBhcGkNCi0gc2VwYXJhdGUgYXNzaWduIGFuZCB3cml0ZV9zIGFwaQ0KLSBhZGQganVt
cCBhcGkgaW5zdGVhZCBvZiBmaW5hbGl6ZSBpbiBsb29wDQoNClsuLi4gc25pcCAuLi5dDQoNCg0K
RGVubmlzIFlDIEhzaWVoICgxMyk6DQogIGR0LWJpbmRpbmc6IGdjZTogYWRkIGdjZSBoZWFkZXIg
ZmlsZSBmb3IgbXQ2Nzc5DQogIG1haWxib3g6IGNtZHE6IHZhcmlhYmxpemUgYWRkcmVzcyBzaGlm
dCBpbiBwbGF0Zm9ybQ0KICBtYWlsYm94OiBjbWRxOiBzdXBwb3J0IG10Njc3OSBnY2UgcGxhdGZv
cm0gZGVmaW5pdGlvbg0KICBtYWlsYm94OiBtZWRpYXRlazogY21kcTogY2xlYXIgdGFzayBpbiBj
aGFubmVsIGJlZm9yZSBzaHV0ZG93bg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiByZXR1cm4gc2Vu
ZCBtc2cgZXJyb3IgY29kZQ0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgYXNzaWduIGZ1bmN0
aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0ZV9zIGZ1bmN0aW9uDQogIHNvYzog
bWVkaWF0ZWs6IGNtZHE6IGFkZCByZWFkX3MgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21k
cTogYWRkIHdyaXRlX3MgdmFsdWUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogZXhw
b3J0IGZpbmFsaXplIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBqdW1wIGZ1
bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBjbGVhciBvcHRpb24gaW4gY21kcV9w
a3Rfd2ZlIGFwaQ0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgc2V0IGV2ZW50IGZ1bmN0aW9u
DQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0ICAgfCAgIDgg
Ky0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgICAgfCAgIDMg
Ky0NCiBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jICAgICAgICAgICAgfCAxMDEg
KysrKysrLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgICAgICAg
fCAxNDMgKysrKysrKysrKy0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tdDY3NzktZ2NlLmgg
ICAgICAgICAgfCAyMjIgKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaCAgICAgIHwgIDEwICstDQogaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaCAgICAgICAgIHwgIDk0ICsrKysrKystDQogNyBmaWxlcyBjaGFuZ2Vk
LCA1NDggaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaA0KDQotLSANCjIuMTguMA==

