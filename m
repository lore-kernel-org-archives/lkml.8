Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E0020870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LGcveeIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgGEGtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:49:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41647 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgGEGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:48:44 -0400
X-UUID: 89933ffd6fe04cdbbe94ad35ac6b9622-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6iMO0gk0hP4QF47/XhMn9JchKU1Qvxhv+Lh5xkKouP0=;
        b=LGcveeIFCW/T1pJjYFrBAFvLaCRC+ExcAoJXrGrEyO0u6rsQPt7Zg5OmjWCTENmBGKmrD7Mv8CNGCOCNoY16htddT0eja7S36Z2nMhkYWDplgcFDR0HXyuo8PwUn6sNhmvGtpMujLxYjvnBbFSbw5IrHyxbWdFiuvPHH2we3ZeA=;
X-UUID: 89933ffd6fe04cdbbe94ad35ac6b9622-20200705
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 500851885; Sun, 05 Jul 2020 14:48:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:48:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:48:36 +0800
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
Subject: Subject: [PATCH v1 0/8] support cmdq helper function on mt6779 platform
Date:   Sun, 5 Jul 2020 14:48:27 +0800
Message-ID: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
ZnVuY3Rpb24NCg0KQ2hhbmdlIHNpbmNlIHYxOg0KLSBSZW5hbWUgY21kcV9tYm94X3NoaWZ0KCkg
dG8gY21kcV9nZXRfc2hpZnRfcGEoKS4NCg0KDQpEZW5uaXMgWUMgSHNpZWggKDgpOg0KICBzb2M6
IG1lZGlhdGVrOiBjbWRxOiBhZGQgYWRkcmVzcyBzaGlmdCBpbiBqdW1wDQogIHNvYzogbWVkaWF0
ZWs6IGNtZHE6IGFkZCB3cml0ZV9zIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFk
ZCB3cml0ZV9zX21hc2sgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHJlYWRf
cyBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyB2YWx1ZSBmdW5j
dGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfc19tYXNrIHZhbHVlIGZ1bmN0
aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBqdW1wIGZ1bmN0aW9uDQogIHNvYzogbWVk
aWF0ZWs6IGNtZHE6IGFkZCBjbGVhciBvcHRpb24gaW4gY21kcV9wa3Rfd2ZlIGFwaQ0KDQogZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICB8ICAgMiArLQ0KIGRyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAxMTMgKysrKysrKysrKysrKysrKysr
KysrKy0NCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICA2ICst
DQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICA5MyArKysrKysr
KysrKysrKysrKystDQogNCBmaWxlcyBjaGFuZ2VkLCAyMDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCg0KLS0gDQoyLjE4LjA=

