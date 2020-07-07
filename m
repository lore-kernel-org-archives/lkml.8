Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6368520578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cXHGGEDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgGGPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:46:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59707 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729131AbgGGPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:37 -0400
X-UUID: 74bb7f4f8a944a41bdd876d7a55ca644-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KMWcgcPL1XjMD/Va1W+LCp1J+xXGTJ5bSqx6Wn/nPUA=;
        b=cXHGGEDqx59+r2LSl0F5kJuTyeyqdu1jsUIwwX3006c2f6SqatMaXkkcaSuKEJBYt8d4vrPqXo0thCVIqBLFGCLR7/SSOafx1kCcgrXSLVIwMP4MmQ8zb8J/rfgCxdL+fxrGiZqa2E9r5Jdrw+c1++UP8jw61aR+cQzZvU2bm2c=;
X-UUID: 74bb7f4f8a944a41bdd876d7a55ca644-20200707
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1677902217; Tue, 07 Jul 2020 23:46:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 23:46:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 23:46:23 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Subject: [PATCH v3 0/9] support cmdq helper function on mt6779 platform
Date:   Tue, 7 Jul 2020 23:45:05 +0800
Message-ID: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzdXBwb3J0IG1vcmUgZ2NlIGhlbHBlciBmdW5jdGlvbiBvbiBtdDY3NzkgcGxh
dGZvcm0uDQoNCmRlcGVuZHMgb24gcGF0Y2g6IHN1cHBvcnQgZ2NlIG9uIG10Njc3OSBwbGF0Zm9y
bQ0KDQphbmQgZGVwZW5kcyBvbiBmb2xsb3dpbmcgYXBwbGllZCBwYXRjaGVzDQpzb2M6IG1lZGlh
dGVrOiBjbWRxOiBhZGQgc2V0IGV2ZW50IGZ1bmN0aW9uDQpzb2M6IG1lZGlhdGVrOiBjbWRxOiBl
eHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCnNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBhc3NpZ24g
ZnVuY3Rpb24NCg0KQ2hhbmdlIHNpbmNlIHYyOg0KLSBLZWVwIGJlaGF2aW9yIGluIGRybSBjcnRj
IGRyaXZlciBhbmQNCiAgc2VwYXJhdGUgYnVnIGZpeCBjb2RlIGludG8gYW5vdGhlciBwYXRjaC4N
Cg0KQ2hhbmdlIHNpbmNlIHYxOg0KLSBSZW5hbWUgY21kcV9tYm94X3NoaWZ0KCkgdG8gY21kcV9n
ZXRfc2hpZnRfcGEoKS4NCg0KDQpEZW5uaXMgWUMgSHNpZWggKDkpOg0KICBzb2M6IG1lZGlhdGVr
OiBjbWRxOiBhZGQgYWRkcmVzcyBzaGlmdCBpbiBqdW1wDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6
IGFkZCB3cml0ZV9zIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0ZV9z
X21hc2sgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHJlYWRfcyBmdW5jdGlv
bg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyB2YWx1ZSBmdW5jdGlvbg0KICBz
b2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfc19tYXNrIHZhbHVlIGZ1bmN0aW9uDQogIHNv
YzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBqdW1wIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNt
ZHE6IGFkZCBjbGVhciBvcHRpb24gaW4gY21kcV9wa3Rfd2ZlIGFwaQ0KICBkcm0vbWVkaWF0ZWs6
IHJlZHVjZSBjbGVhciBldmVudA0KDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jICB8ICAgMiArLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
ICAgfCAxMTMgKysrKysrKysrKysrKysrKysrKysrKy0NCiBpbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oIHwgICA2ICstDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaCAgICB8ICA5MyArKysrKysrKysrKysrKysrKystDQogNCBmaWxlcyBjaGFuZ2Vk
LCAyMDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE4LjA=

