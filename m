Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EE7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33179208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="knrk4kLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405421AbgE1RFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:05:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405365AbgE1RFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:19 -0400
X-UUID: 4256408a63594533a001f5a0c85602e8-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dotcr1Xwp5H3JYAUwK5C43/xOJm1pfZbdz8YmDajNS8=;
        b=knrk4kLteIegxoisrXuGmkxOQdko0kbfwDexFCigwEy+Sc91i33xsUdxd/X1Eq7nLF8GfCvcq+EK1XlzqGEG0k5uNJw1tSU2iCnjAfwxIiXwtFo2PoHXsSrmWGxsm2IhV6tBLaWLU7GO5vSh1jhZ/CX0Weo76EThyWnIJ4mAgXs=;
X-UUID: 4256408a63594533a001f5a0c85602e8-20200529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1516474353; Fri, 29 May 2020 01:05:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
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
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v6 00/16] support gce on mt6779 platform
Date:   Fri, 29 May 2020 01:04:36 +0800
Message-ID: <1590685491-17107-2-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
eW1ib2xpemUgdmFsdWUgMSB0byBqdW1wIHJlbGF0aXZlDQoNClsuLi4gc25pcCAuLi5dDQoNCioq
KiBCTFVSQiBIRVJFICoqKg0KDQpEZW5uaXMgWUMgSHNpZWggKDE2KToNCiAgZHQtYmluZGluZzog
Z2NlOiBhZGQgZ2NlIGhlYWRlciBmaWxlIGZvciBtdDY3NzkNCiAgbWFpbGJveDogY21kcTogdmFy
aWFibGl6ZSBhZGRyZXNzIHNoaWZ0IGluIHBsYXRmb3JtDQogIG1haWxib3g6IGNtZHE6IHN1cHBv
cnQgbXQ2Nzc5IGdjZSBwbGF0Zm9ybSBkZWZpbml0aW9uDQogIG1haWxib3g6IG1lZGlhdGVrOiBj
bWRxOiBjbGVhciB0YXNrIGluIGNoYW5uZWwgYmVmb3JlIHNodXRkb3duDQogIHNvYzogbWVkaWF0
ZWs6IGNtZHE6IHJldHVybiBzZW5kIG1zZyBlcnJvciBjb2RlDQogIHNvYzogbWVkaWF0ZWs6IGNt
ZHE6IGFkZCBhZGRyZXNzIHNoaWZ0IGluIGp1bXANCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRk
IGFzc2lnbiBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyBmdW5j
dGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfc19tYXNrIGZ1bmN0aW9uDQog
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCByZWFkX3MgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRl
azogY21kcTogYWRkIHdyaXRlX3MgdmFsdWUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21k
cTogYWRkIHdyaXRlX3NfbWFzayB2YWx1ZSBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRx
OiBleHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGp1
bXAgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGNsZWFyIG9wdGlvbiBpbiBj
bWRxX3BrdF93ZmUgYXBpDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBzZXQgZXZlbnQgZnVu
Y3Rpb24NCg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLWdjZS50eHQgICB8
ICAgOCArLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAgICB8
ICAgMyArLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgICAgICB8
IDEwMSArKysrKystLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAg
ICAgICB8IDE2MyArKysrKysrKysrKystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5
LWdjZS5oICAgICAgICAgIHwgMjIyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggICAgICB8ICAxMCArLQ0KIGluY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmggICAgICAgICB8IDEyNSArKysrKysrKystDQogNyBmaWxl
cyBjaGFuZ2VkLCA1OTkgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlL210Njc3OS1nY2UuaA0KDQotLSANCjIu
MTguMA0K

