Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602EFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5624922
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hLIqvh/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgFUOTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:19:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38162 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730167AbgFUOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:47 -0400
X-UUID: 2c4fd55c4f7344869aa6647e79990df6-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nRSxux3jPezOAmIEYBHHJHw/jcJ6YJjo04hJRda3rGo=;
        b=hLIqvh/+7LwxHU8QgEpPf5uurerRA4dqmxyzjGX7WwY+fGnsiz9MeP5MhKvgtzpVv4Vm75mH03sLGHp79VSzGMqRrbHrMW9oDsPtjwG+dwGbDZY5n1angeKetzZ7xZ2P6naK0oXX6ZAcEweT0d3/EfkWDTtVHFQGP6poHfvEvz4=;
X-UUID: 2c4fd55c4f7344869aa6647e79990df6-20200621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 400774330; Sun, 21 Jun 2020 22:18:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 22:18:31 +0800
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
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v1 07/11] soc: mediatek: cmdq: add write_s_mask value function
Date:   Sun, 21 Jun 2020 22:18:31 +0800
Message-ID: <1592749115-24158-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3NfbWFza192YWx1ZSBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMg
d2hpY2gNCndyaXRlcyBhIGNvbnN0YW50IHZhbHVlIHRvIGFkZHJlc3Mgd2l0aCBtYXNrIGFuZCBs
YXJnZSBkbWENCmFjY2VzcyBzdXBwb3J0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNp
ZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyB8ICAgMjEgKysrKysrKysrKysrKysrKysrKysrDQogaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAgIDE1ICsrKysrKysrKysrKysr
Kw0KIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMmFkNzhkZjQ2NjM2Li5lMzcyYWUwNjUyNDAgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0yOTMsNiArMjkzLDI3
IEBAIGludCBjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBo
aWdoX2FkZHJfcmVnX2lkeCwNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3Zh
bHVlKTsNCiANCitpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1OCBoaWdoX2FkZHJfcmVnX2lkeCwNCisJCQkJdTE2IGFkZHJfbG93LCB1MzIgdmFs
dWUsIHUzMiBtYXNrKQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0K
KwlpbnQgZXJyOw0KKw0KKwlpbnN0Lm9wID0gQ01EUV9DT0RFX01BU0s7DQorCWluc3QubWFzayA9
IH5tYXNrOw0KKwllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KKwlp
ZiAoZXJyIDwgMCkNCisJCXJldHVybiBlcnI7DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfV1JJ
VEVfU19NQVNLOw0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KKwlpbnN0Lm9mZnNl
dCA9IGFkZHJfbG93Ow0KKwlpbnN0LnZhbHVlID0gdmFsdWU7DQorDQorCXJldHVybiBjbWRxX3Br
dF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0
X3dyaXRlX3NfbWFza192YWx1ZSk7DQorDQogaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTE2IGV2ZW50KQ0KIHsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9
IHsgezB9IH07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDdmMWMx
MTVhNjZiOC4uNmU4Y2FhY2VkYzgwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KQEAgLTE2NSw2ICsxNjUsMjEgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KIAkJCSAgIHUxNiBhZGRy
X2xvdywgdTMyIHZhbHVlKTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF93cml0ZV9zX21hc2tfdmFs
dWUoKSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgd2l0aCBtYXNrIHRvIHRoZSBDTURRDQorICoJ
CQkJICAgcGFja2V0IHdoaWNoIHdyaXRlIHZhbHVlIHRvIGEgcGh5c2ljYWwNCisgKgkJCQkgICBh
ZGRyZXNzDQorICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQorICogQGhpZ2hfYWRkcl9yZWdfaWR4
OglpbnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBjb250YWlucyBoaWdoIGFkZHJlc3Mgb2YgcGEN
CisgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNzIG9mIHBhDQorICogQHZhbHVlOgl0aGUgc3BlY2lm
aWVkIHRhcmdldCB2YWx1ZQ0KKyAqIEBtYXNrOgl0aGUgc3BlY2lmaWVkIHRhcmdldCBtYXNrDQor
ICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0
dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1OCBoaWdoX2FkZHJfcmVnX2lkeCwNCisJCQkJdTE2IGFkZHJfbG93LCB1MzIg
dmFsdWUsIHUzMiBtYXNrKTsNCisNCisvKioNCiAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3
YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KICAqIEBwa3Q6CXRoZSBD
TURRIHBhY2tldA0KICAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byAid2FpdCBh
bmQgQ0xFQVIiDQotLSANCjEuNy45LjUNCg==

