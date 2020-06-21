Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE7F2491F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ppaik4jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgFUOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17793 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730190AbgFUOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:47 -0400
X-UUID: 24e9fc548b3746c392e250452d0b3676-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fvMw5ljFu1mfguRoXf60m5fp2sNpcRGVzbt+sAiy2PA=;
        b=Ppaik4jtjkeMRGVM5F8rvQsK043cjQNMQy/PaTpa3ZD82khRiDI5xfXfardsA9y6jkV6H1IS1aJHgKmMI3w+aIkGWbgsLTq3mP95EZ4FP/rJ0LgjQ6XtQT1Q7iwsa9UlklEAIRunx4pI5AofmMJUxTXOCcR3SKYHoKlh955F7pM=;
X-UUID: 24e9fc548b3746c392e250452d0b3676-20200621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 431989172; Sun, 21 Jun 2020 22:18:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v1 09/11] soc: mediatek: cmdq: add jump function
Date:   Sun, 21 Jun 2020 22:18:33 +0800
Message-ID: <1592749115-24158-10-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCmNvbnRhaW5zIGluc3RydWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8ICAgMTMgKysrKysrKysrKysrKw0KIGluY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgICAxMSArKysrKysrKysrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KaW5kZXggMjQ4OTQ1MTA4YTM2Li4wMDlmODZhZTcyYzYgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0xMyw2ICsxMyw3IEBADQogI2RlZmlu
ZSBDTURRX1BPTExfRU5BQkxFX01BU0sJQklUKDApDQogI2RlZmluZSBDTURRX0VPQ19JUlFfRU4J
CUJJVCgwKQ0KICNkZWZpbmUgQ01EUV9SRUdfVFlQRQkJMQ0KKyNkZWZpbmUgQ01EUV9KVU1QX1JF
TEFUSVZFCTENCiANCiBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCkBAIC0z
OTEsNiArMzkyLDE4IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfYXNz
aWduKTsNCiANCitpbnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2Fk
ZHJfdCBhZGRyKQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0KKw0K
KwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQorCWluc3Qub2Zmc2V0ID0gQ01EUV9KVU1QX1JF
TEFUSVZFOw0KKwlpbnN0LnZhbHVlID0gYWRkciA+Pg0KKwkJY21kcV9tYm94X3NoaWZ0KCgoc3Ry
dWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktPmNoYW4pOw0KKwlyZXR1cm4gY21kcV9wa3RfYXBw
ZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9qdW1w
KTsNCisNCiBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQogew0K
IAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggZWFjMTQwNWU0ODcyLi4xODM2NGQ4MWU4ZjcgMTAw
NjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMjQ0LDYgKzI0NCwxNyBA
QCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMs
DQogaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgs
IHUzMiB2YWx1ZSk7DQogDQogLyoqDQorICogY21kcV9wa3RfanVtcCgpIC0gQXBwZW5kIGp1bXAg
Y29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0UNCisgKgkJICAgICB0byBleGVjdXRl
IGFuIGluc3RydWN0aW9uIHRoYXQgY2hhbmdlIGN1cnJlbnQgdGhyZWFkIFBDIHRvDQorICoJCSAg
ICAgYSBwaHlzaWNhbCBhZGRyZXNzIHdoaWNoIHNob3VsZCBjb250YWlucyBtb3JlIGluc3RydWN0
aW9uLg0KKyAqIEBwa3Q6ICAgICAgICB0aGUgQ01EUSBwYWNrZXQNCisgKiBAYWRkcjogICAgICAg
cGh5c2ljYWwgYWRkcmVzcyBvZiB0YXJnZXQgaW5zdHJ1Y3Rpb24gYnVmZmVyDQorICoNCisgKiBS
ZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisg
Ki8NCitpbnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBh
ZGRyKTsNCisNCisvKioNCiAgKiBjbWRxX3BrdF9maW5hbGl6ZSgpIC0gQXBwZW5kIEVPQyBhbmQg
anVtcCBjb21tYW5kIHRvIHBrdC4NCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCiAgKg0KLS0g
DQoxLjcuOS41DQo=

