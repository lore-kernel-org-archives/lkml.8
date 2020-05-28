Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7720C56
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MDAFNpR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405538AbgE1RHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:07:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405353AbgE1RFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:16 -0400
X-UUID: 31fa0fca628d4d00b4418e2df2009a44-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=A1yEVTAAPXmkb1voL9ofORATdhhJt+rPBnyZJEjeoIU=;
        b=MDAFNpR2KN/eJf2va5dQoz7ZD8/SGiPyEA04o51RSPGIXumxcwmOcbYeDzEgFjbgAaSVvrmZ6+NZ3fOEl5iqiRIFFtpclJ9c9V+vXPYWD9cinQEUddtp+9+4UDVMNK1Oum8yOlRJpvkiZAUvttGAy9mCPjozE8LlgBHV4EslGHs=;
X-UUID: 31fa0fca628d4d00b4418e2df2009a44-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1634530953; Fri, 29 May 2020 01:05:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:07 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:07 +0800
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
Subject: [PATCH v6] support gce on mt6779 platform
Date:   Fri, 29 May 2020 01:04:35 +0800
Message-ID: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0A7A7DAD0F7B2228A38B441CB5B4C08F26FDE1F1C012783C0DCE4A784086282F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzdXBwb3J0IGdjZSBvbiBtdDY3NzkgcGxhdGZvcm0uDQoNCkNoYW5nZSBzaW5j
ZSB2NToNCi0gc3BlYXJhdGUgYWRkcmVzcyBzaGlmdCBjb2RlIGluIGNsaWVudCBoZWxwZXIgYW5k
IG1haWxib3ggY29udHJvbGxlcg0KLSBzZXBhcmF0ZSB3cml0ZV9zL3dyaXRlX3NfbWFzayBhbmQg
d3JpdGVfc192YWx1ZS93cml0ZV9zX21hc2tfdmFsdWUgc28gdGhhdA0KICBjbGllbnQgY2FuIGRl
Y2lkZSB1c2UgbWFzayBvciBub3QNCi0gZml4IHR5cG8gaW4gaGVhZGVyDQoNCkNoYW5nZSBzaW5j
ZSB2NDoNCi0gZG8gbm90IGNsZWFyIGRpc3AgZXZlbnQgYWdhaW4gaW4gZHJtIGRyaXZlcg0KLSBz
eW1ib2xpemUgdmFsdWUgMSB0byBqdW1wIHJlbGF0aXZlDQoNClsuLi4gc25pcCAuLi5dDQoNCg0K
DQpEZW5uaXMgWUMgSHNpZWggKDE2KToNCiAgZHQtYmluZGluZzogZ2NlOiBhZGQgZ2NlIGhlYWRl
ciBmaWxlIGZvciBtdDY3NzkNCiAgbWFpbGJveDogY21kcTogdmFyaWFibGl6ZSBhZGRyZXNzIHNo
aWZ0IGluIHBsYXRmb3JtDQogIG1haWxib3g6IGNtZHE6IHN1cHBvcnQgbXQ2Nzc5IGdjZSBwbGF0
Zm9ybSBkZWZpbml0aW9uDQogIG1haWxib3g6IG1lZGlhdGVrOiBjbWRxOiBjbGVhciB0YXNrIGlu
IGNoYW5uZWwgYmVmb3JlIHNodXRkb3duDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IHJldHVybiBz
ZW5kIG1zZyBlcnJvciBjb2RlDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBhZGRyZXNzIHNo
aWZ0IGluIGp1bXANCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFzc2lnbiBmdW5jdGlvbg0K
ICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyBmdW5jdGlvbg0KICBzb2M6IG1lZGlh
dGVrOiBjbWRxOiBhZGQgd3JpdGVfc19tYXNrIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNt
ZHE6IGFkZCByZWFkX3MgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRl
X3MgdmFsdWUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3NfbWFz
ayB2YWx1ZSBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBleHBvcnQgZmluYWxpemUg
ZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGp1bXAgZnVuY3Rpb24NCiAgc29j
OiBtZWRpYXRlazogY21kcTogYWRkIGNsZWFyIG9wdGlvbiBpbiBjbWRxX3BrdF93ZmUgYXBpDQog
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBzZXQgZXZlbnQgZnVuY3Rpb24NCg0KIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQgICB8ICAgOCArLQ0KIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAgICB8ICAgMyArLQ0KIGRyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgICAgICB8IDEwMSArKysrKystLQ0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgICAgICB8IDE2MyArKysrKysr
KysrKystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5oICAgICAgICAgIHwg
MjIyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmggICAgICB8ICAxMCArLQ0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggICAgICAgICB8IDEyNSArKysrKysrKystDQogNyBmaWxlcyBjaGFuZ2VkLCA1OTkgaW5z
ZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
ZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaA0KDQotLSANCjIuMTguMA==

