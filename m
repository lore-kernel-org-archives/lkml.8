Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B977C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD312491C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gcC5RzbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgFUOSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730077AbgFUOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:42 -0400
X-UUID: e9bb55b6b7d84314ad0597bc41818436-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qVgjYAF9HH+u1fTquUk95ZdNXJ4MuniYtTz3ClruoAk=;
        b=gcC5RzbTjv+Bm5BBFFx+rNMzLyOxMip5MTahJAurRzn2rQVanAc2Iki5WwT2qjxLJDj5n7fPKR18Vhpqp8RFrirnGix99or82fyR1MfrQP5Xm/OqTF26ALt2dUqDHlAu0vhnpwriBHIhESLnVVPmH72P/PqW0y9WUuvoLGXnt7c=;
X-UUID: e9bb55b6b7d84314ad0597bc41818436-20200621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1819669271; Sun, 21 Jun 2020 22:18:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 22:18:29 +0800
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
Subject: [PATCH v1 0/11] support cmdq helper function on mt6779 platform
Date:   Sun, 21 Jun 2020 22:18:24 +0800
Message-ID: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzdXBwb3J0IGNtZHEgaGVscGVyIGZ1bmN0aW9uIG9uIG10Njc3OSBwbGF0Zm9y
bSwNCmJhc2VkIG9uICJzdXBwb3J0IGdjZSBvbiBtdDY3NzkgcGxhdGZvcm0iIHBhdGNoc2V0Lg0K
DQoNCkRlbm5pcyBZQyBIc2llaCAoMTEpOg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgYWRk
cmVzcyBzaGlmdCBpbiBqdW1wDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBhc3NpZ24gZnVu
Y3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3MgZnVuY3Rpb24NCiAgc29j
OiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3NfbWFzayBmdW5jdGlvbg0KICBzb2M6IG1lZGlh
dGVrOiBjbWRxOiBhZGQgcmVhZF9zIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFk
ZCB3cml0ZV9zIHZhbHVlIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0
ZV9zX21hc2sgdmFsdWUgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogZXhwb3J0IGZp
bmFsaXplIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBqdW1wIGZ1bmN0aW9u
DQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBjbGVhciBvcHRpb24gaW4gY21kcV9wa3Rfd2Zl
IGFwaQ0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgc2V0IGV2ZW50IGZ1bmN0aW9uDQoNCiBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwgICAzICstDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDE1OSArKysrKysrKysrKysrKysr
KysrKystLQ0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgIDgg
Ky0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMTI0ICsrKysr
KysrKysrKysrKysrLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMjgwIGluc2VydGlvbnMoKyksIDE0IGRl
bGV0aW9ucygtKQ0KDQotLSANCjIuMTguMA==

