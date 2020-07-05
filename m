Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F386C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6705520747
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Is5MmiOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGEGh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:37:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2603 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgGEGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:37:27 -0400
X-UUID: 72a4d6cf8f4f4975964692b51da82bd9-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gqm4OZfUhki8WU2CVF1hQN+tokRx4Gt+FcA3Q1zvhc8=;
        b=Is5MmiOAN5MSw/wPkUkzCcZzAe4Mad2TW4ATm7e0Zy7aQGHVbDbWQNHieNrSSG3ARTK1YRwlYSlRmhCaJh9H3NaBLOAXNR67AA/KYwAWE1JiBYrP+vyYSMBOCrzlTqrCW85haMswZAuFm4cemVn4QpA8LLykrfskeKzthTr2Pzo=;
X-UUID: 72a4d6cf8f4f4975964692b51da82bd9-20200705
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1423470906; Sun, 05 Jul 2020 14:37:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:37:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:37:17 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Subject: [PATCH v8 0/4] support gce on mt6779 platform
Date:   Sun, 5 Jul 2020 14:37:12 +0800
Message-ID: <1593931037-24405-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
ZSB2NzoNCi0gUmVuYW1lIGNtZHFfbWJveF9zaGlmdCgpIHRvIGNtZHFfZ2V0X3NoaWZ0X3BhKCku
DQoNCkNoYW5nZSBzaW5jZSB2NjoNCi0gU2VwYXJhdGUgYWxsIGhlbHBlciBmdW5jdGlvbiB0byBh
bm90aGVyIHBhdGNoc2V0Lg0KDQpDaGFuZ2Ugc2luY2UgdjU6DQotIHNwZWFyYXRlIGFkZHJlc3Mg
c2hpZnQgY29kZSBpbiBjbGllbnQgaGVscGVyIGFuZCBtYWlsYm94IGNvbnRyb2xsZXINCi0gc2Vw
YXJhdGUgd3JpdGVfcy93cml0ZV9zX21hc2sgYW5kIHdyaXRlX3NfdmFsdWUvd3JpdGVfc19tYXNr
X3ZhbHVlIHNvIHRoYXQNCiAgY2xpZW50IGNhbiBkZWNpZGUgdXNlIG1hc2sgb3Igbm90DQotIGZp
eCB0eXBvIGluIGhlYWRlcg0KDQpbLi4uIHNuaXAgLi4uXQ0KDQoNCkRlbm5pcyBZQyBIc2llaCAo
NCk6DQogIGR0LWJpbmRpbmc6IGdjZTogYWRkIGdjZSBoZWFkZXIgZmlsZSBmb3IgbXQ2Nzc5DQog
IG1haWxib3g6IGNtZHE6IHZhcmlhYmxpemUgYWRkcmVzcyBzaGlmdCBpbiBwbGF0Zm9ybQ0KICBt
YWlsYm94OiBjbWRxOiBzdXBwb3J0IG10Njc3OSBnY2UgcGxhdGZvcm0gZGVmaW5pdGlvbg0KICBt
YWlsYm94OiBtZWRpYXRlazogY21kcTogY2xlYXIgdGFzayBpbiBjaGFubmVsIGJlZm9yZSBzaHV0
ZG93bg0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGstZ2NlLnR4dCAgIHwg
ICA4ICstDQogZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAgICAgICAgIHwg
IDk3ICsrKysrKystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5oICAgICAg
ICAgIHwgMjIyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmggICAgICB8ICAgMiArDQogNCBmaWxlcyBjaGFuZ2VkLCAzMTMgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQt
YmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaA0KDQotLSANCjIuMTguMA==

