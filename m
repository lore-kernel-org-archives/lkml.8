Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF76C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEF72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s+HZOyOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHTGFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:05:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18919 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725778AbgHTGFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:38 -0400
X-UUID: c578b6ffd56c483897870cd1f398118c-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eMCqHf5VNCtvq/O+QRSOEtg5Xwd+1FDGSGsrpAcq+Zw=;
        b=s+HZOyODiPZPySgERpgDUer2qNTepI6ICLm5Z1pTLUn6/+ykrk9iNJ9QOF8e17bWEjr006pIIZr/63sTEMcm2dNsINtuFzvQ13v1XJuG7bS8YeLMWOU5F+PWRUlna/n5qe0ctttUEe2pY1riFIFE0FgkxxZvJ8908xfrtO5578Q=;
X-UUID: c578b6ffd56c483897870cd1f398118c-20200820
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1576741474; Thu, 20 Aug 2020 14:05:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:30 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 00/21] add drm support for MT8192
Date:   Thu, 20 Aug 2020 14:03:57 +0800
Message-ID: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBpbiB2MToNCi0gYWRkIHNvbWUgbW9yZSBkZHAgY29tcG9uZW50DQotIGFkZCBtdDgx
OTIgbW1zeXMgc3VwcG9ydA0KLSBhZGQgb3ZsIG1vdW50IG9uIHN1cHBvcnQNCi0gYWRkIDIgbW9y
ZSBjbG9jayBpbnRvIG11dGV4IGRldmljZQ0KLSBmaXggb3ZsIHNtaV9pZF9lbiBhbmQgZmIgbnVs
bCBzb2Z0d2FyZSBidWcNCi0gZml4IGRkcCBjb21wb2VudCBzaXplIGNvbmZpZyBidWcNCi0gYWRk
IG10ODE5MiBkcm0gc3VwcG9ydA0KLSBhZGQgZGRwIGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVu
Y3Rpb24NCi0gYWRkIDgxOTIgZHRzIGRlc2NyaXB0aW9uDQoNCllvbmdxaWFuZyBOaXUgKDIxKToN
CiAgZHJtL21lZGlhdGVrOiBhZGQgY29tcG9uZW50IE9WTF8yTDINCiAgZHJtL21lZGlhdGVrOiBh
ZGQgY29tcG9uZW50IFBPU1RNQVNLDQogIGRybS9tZWRpYXRlazogYWRkIGNvbXBvbmVudCBSRE1B
NA0KICBtdGstbW1zeXM6IGFkZCBtdDgxOTIgbW1zeXMgc3VwcG9ydA0KICBtdGstbW1zeXM6IGFk
ZCBvdmwgbW91dCBvbiAgc3VwcG9ydA0KICBkcm0vbWVkaWF0ZWs6IGFkZCBkaXNwIGNvbmZpZyBh
bmQgbW0gMjZtaHogY2xvY2sgaW50byBtdXRleCBkZXZpY2UNCiAgZHJtL21lZGlhdGVrOiBlbmFi
bGUgT1ZMX0xBWUVSX1NNSV9JRF9FTiBmb3IgbXVsdGktbGF5ZXIgdXNlY2FzZQ0KICBkcm0vbWVk
aWF0ZWs6IGNoZWNrIGlmIGZiIGlzIG51bGwNCiAgZHJtL21lZGlhdGVrOiBmaXggYWFsIHNpemUg
Y29uZmlnDQogIGRybS9tZWRpYXRlazogZml4IGRpdGhlciBzaXplIGNvbmZpZw0KICBkcm0vbWVk
aWF0ZWs6IGZpeCBnYW1tYSBzaXplIGNvbmZpZw0KICBkcm0vbWVkaWF0ZWs6IGZpeCBjY29yciBz
aXplIGNvbmZpZw0KICBkcm0vbWVkaWF0ZWs6IGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlayBTT0Mg
TVQ4MTkyDQogIGRybS9tZWRpYXRlazogYWRkIGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVuY3Rp
b24gY2FsbCBmb3IgZGRwDQogICAgY29tcG9uZW50DQogIGRybS9tZWRpYXRlazogYWRkIGNvbG9y
IGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVuY3Rpb24NCiAgZHJtL21lZGlhdGVrOiBhZGQgb3Zs
IGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVuY3Rpb24NCiAgZHJtL21lZGlhdGVrOiBhZGQgcmRt
YSBieXBhc3Mgc2hhZG93IHJlZ2lzdGVyIGZ1bmN0aW9uDQogIGRybS9tZWRpYXRlazogYWRkIGRp
dGhlciBieXBhc3Mgc2hhZG93IHJlZ2lzdGVyIGZ1bmN0aW9uDQogIGRybS9tZWRpYXRlazogYWRk
IGFhbCBieXBhc3Mgc2hhZG93IHJlZ2lzdGVyIGZ1bmN0aW9uDQogIGRybS9tZWRpYXRlazogYWRk
IGNjb3JyIGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVuY3Rpb24NCiAgYXJtNjQ6IGR0czogbXQ4
MTkyOiBhZGQgZGlzcGxheSBub2RlDQoNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi5kdHNpICAgIHwgMTI2ICsrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfY29sb3IuYyAgIHwgIDIyICsrKysNCiBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgIHwgIDQxICsrKysrKy0NCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgIHwgIDI3ICsrKysrDQogZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8ICAgMyArDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgICAgICB8ICA4NCArKysrKysrKysrKy0tDQogZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8ICA4MCArKysrKysrKysrKy0N
CiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgICA4ICsrDQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICB8ICA0OCArKysrKysr
Kw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL01ha2VmaWxlICAgICAgICAgfCAgIDEgKw0K
IGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL210ODE5Mi1tbXN5cy5jICAgfCAxODIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1tbXN5cy5j
ICAgICAgICAgICAgfCAgIDggKysNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1z
eXMuaCAgICAgIHwgICA2ICsNCiAxMyBmaWxlcyBjaGFuZ2VkLCA2MjMgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVr
L21tc3lzL210ODE5Mi1tbXN5cy5jDQoNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

