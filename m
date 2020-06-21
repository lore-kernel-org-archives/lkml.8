Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B9824888
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j9cRDC/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgFUNWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:22:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17141 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728750AbgFUNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:22:18 -0400
X-UUID: dcb1ca5039c643d4aeffc63b493bd0b3-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=61D9E6WpDFFFD6POeDxGR3kU0mQz9/Xa8UTwEuKmcCI=;
        b=j9cRDC/4pZI0t6qtjJWv06LkcnFpwYy+FnvFjsfQg4Yw7DRAY0j4n1TOYkhYyb8zHzrfUgDmL6y70GJmtlFOV+5k46Ww1qZuUVV6qAJrKPgZj1l40xGJPpijRxdYXjC8ViVBKGHvkDbnpTtnbI5on7hwJoNXBu7wpzRYBUkS2GI=;
X-UUID: dcb1ca5039c643d4aeffc63b493bd0b3-20200621
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1258806545; Sun, 21 Jun 2020 21:22:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 21:22:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 21:22:05 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v7 0/4] support gce on mt6779 platform
Date:   Sun, 21 Jun 2020 21:22:07 +0800
Message-ID: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
ZSB2NjoNCi0gU2VwYXJhdGUgYWxsIGhlbHBlciBmdW5jdGlvbiB0byBhbm90aGVyIHBhdGNoc2V0
Lg0KDQpDaGFuZ2Ugc2luY2UgdjU6DQotIHNwZWFyYXRlIGFkZHJlc3Mgc2hpZnQgY29kZSBpbiBj
bGllbnQgaGVscGVyIGFuZCBtYWlsYm94IGNvbnRyb2xsZXINCi0gc2VwYXJhdGUgd3JpdGVfcy93
cml0ZV9zX21hc2sgYW5kIHdyaXRlX3NfdmFsdWUvd3JpdGVfc19tYXNrX3ZhbHVlIHNvIHRoYXQN
CiAgY2xpZW50IGNhbiBkZWNpZGUgdXNlIG1hc2sgb3Igbm90DQotIGZpeCB0eXBvIGluIGhlYWRl
cg0KDQpDaGFuZ2Ugc2luY2UgdjQ6DQotIGRvIG5vdCBjbGVhciBkaXNwIGV2ZW50IGFnYWluIGlu
IGRybSBkcml2ZXINCi0gc3ltYm9saXplIHZhbHVlIDEgdG8ganVtcCByZWxhdGl2ZQ0KDQpbLi4u
IHNuaXAgLi4uXQ0KDQoNCkRlbm5pcyBZQyBIc2llaCAoNCk6DQogIGR0LWJpbmRpbmc6IGdjZTog
YWRkIGdjZSBoZWFkZXIgZmlsZSBmb3IgbXQ2Nzc5DQogIG1haWxib3g6IGNtZHE6IHZhcmlhYmxp
emUgYWRkcmVzcyBzaGlmdCBpbiBwbGF0Zm9ybQ0KICBtYWlsYm94OiBjbWRxOiBzdXBwb3J0IG10
Njc3OSBnY2UgcGxhdGZvcm0gZGVmaW5pdGlvbg0KICBtYWlsYm94OiBtZWRpYXRlazogY21kcTog
Y2xlYXIgdGFzayBpbiBjaGFubmVsIGJlZm9yZSBzaHV0ZG93bg0KDQogLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvbWFpbGJveC9tdGstZ2NlLnR4dCAgIHwgICA4ICstDQogZHJpdmVycy9tYWlsYm94
L210ay1jbWRxLW1haWxib3guYyAgICAgICAgICAgIHwgMTAxICsrKysrKy0tDQogaW5jbHVkZS9k
dC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5oICAgICAgICAgIHwgMjIyICsrKysrKysrKysrKysr
KysrKw0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggICAgICB8ICAg
MiArDQogNCBmaWxlcyBjaGFuZ2VkLCAzMTUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0p
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2Uu
aA0KDQotLSANCjIuMTguMA==

