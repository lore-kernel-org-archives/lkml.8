Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE53AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2D12078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A4gQWpFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHTGFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:05:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65280 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726749AbgHTGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:44 -0400
X-UUID: 9a2e663fcd78424280cfec847758fc54-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZdEoowJE8yrsOxJwibOQFbZ5BGKEhdg3fQs9sloWNGY=;
        b=A4gQWpFpN4QRLQpfBS8o/tWhoontD1ZZP0gamEnDFdl274EhR5IryiGJpzBefK6St4KUNfuoc/+FBuC8YoIg1iUEBjMiBJnfpUngZtElqQCFu9GQoQNw16fiYPo4j44MeZH6BLz9xGnq4lCSE8L83qqrYaiuqPNFC9d0QbLO200=;
X-UUID: 9a2e663fcd78424280cfec847758fc54-20200820
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 246718716; Thu, 20 Aug 2020 14:05:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:36 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:35 +0800
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
Subject: [PATCH v1 05/21] mtk-mmsys: add ovl mout on  support
Date:   Thu, 20 Aug 2020 14:04:02 +0800
Message-ID: <1597903458-8055-6-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIG92bCBtb3V0IG9uIHN1cHBvcnQNCg0KU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8
eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
bXN5cy9tdDgxOTItbW1zeXMuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMgICAgICAgICAgfCAgOCArKysrKysrKw0KIGluY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oICAgIHwgIDMgKysrDQogMyBmaWxlcyBj
aGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tbXN5cy9tdDgxOTItbW1zeXMuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL210
ODE5Mi1tbXN5cy5jDQppbmRleCAwMDZkNDFkLi4wNjA4MGFkIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbW1zeXMvbXQ4MTkyLW1tc3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL21tc3lzL210ODE5Mi1tbXN5cy5jDQpAQCAtMTM0LDEwICsxMzQsMzMgQEAgc3RhdGlj
IHZvaWQgbXRrX21tc3lzX2RkcF9zb3V0X3NlbCh2b2lkIF9faW9tZW0gKmNvbmZpZ19yZWdzLA0K
IAl9DQogfQ0KIA0KK3N0YXRpYyBpbnQgbXRrX21tc3lzX292bF9tb3V0X2VuKGVudW0gbXRrX2Rk
cF9jb21wX2lkIGN1ciwNCisJCQkJIGVudW0gbXRrX2RkcF9jb21wX2lkIG5leHQsDQorCQkJCSB1
bnNpZ25lZCBpbnQgKmFkZHIpDQorew0KKwlpbnQgdmFsdWUgPSAtMTsNCisNCisJKmFkZHIgPSBN
VDgxOTJfTU1TWVNfT1ZMX01PVVRfRU47DQorDQorCWlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9P
VkwwICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9PVkxfMkwwKQ0KKwkJdmFsdWUgPSBESVNQX09W
TDBfR09fQkc7DQorCWVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX09WTF8yTDAgJiYgbmV4
dCA9PSBERFBfQ09NUE9ORU5UX09WTDApDQorCQl2YWx1ZSA9IERJU1BfT1ZMMF8yTF9HT19CRzsN
CisJZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfT1ZMMCkNCisJCXZhbHVlID0gRElTUF9P
VkwwX0dPX0JMRU5EOw0KKwllbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9PVkxfMkwwKQ0K
KwkJdmFsdWUgPSBESVNQX09WTDBfMkxfR09fQkxFTkQ7DQorCWVsc2UNCisJCXZhbHVlID0gLTE7
DQorDQorCXJldHVybiB2YWx1ZTsNCit9DQorDQogc3RhdGljIHN0cnVjdCBtdGtfbW1zeXNfY29u
bl9mdW5jcyBtbXN5c19mdW5jcyA9IHsNCiAJLm1vdXRfZW4gPSBtdGtfbW1zeXNfZGRwX21vdXRf
ZW4sDQogCS5zZWxfaW4gPSBtdGtfbW1zeXNfZGRwX3NlbF9pbiwNCiAJLnNvdXRfc2VsID0gbXRr
X21tc3lzX2RkcF9zb3V0X3NlbCwNCisJLm92bF9tb3V0X2VuID0gbXRrX21tc3lzX292bF9tb3V0
X2VuLA0KIH07DQogDQogc3RhdGljIGludCBtbXN5c19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1tbXN5cy5j
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCmluZGV4IDgyOGQ1OWUuLjEzNjJk
MDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYw0KKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCkBAIC03Niw2ICs3NiwxNCBAQCB2b2lk
IG10a19tbXN5c19kZHBfY29ubmVjdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQogCQlyZWcgPSByZWFk
bF9yZWxheGVkKGNvbmZpZ19yZWdzICsgYWRkcikgfCB2YWx1ZTsNCiAJCXdyaXRlbF9yZWxheGVk
KHJlZywgY29uZmlnX3JlZ3MgKyBhZGRyKTsNCiAJfQ0KKw0KKwlpZiAocHJpdl9mdW5jcy0+b3Zs
X21vdXRfZW4pIHsNCisJCXZhbHVlID0gcHJpdl9mdW5jcy0+b3ZsX21vdXRfZW4oY3VyLCBuZXh0
LCAmYWRkcik7DQorCQlpZiAodmFsdWUgPj0gMCkgew0KKwkJCXJlZyA9IHJlYWRsX3JlbGF4ZWQo
Y29uZmlnX3JlZ3MgKyBhZGRyKSB8IHZhbHVlOw0KKwkJCXdyaXRlbF9yZWxheGVkKHJlZywgY29u
ZmlnX3JlZ3MgKyBhZGRyKTsNCisJCX0NCisJfQ0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChtdGtf
bW1zeXNfZGRwX2Nvbm5lY3QpOw0KIA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1tbXN5cy5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lz
LmgNCmluZGV4IDhlZjNlYWEuLmVlZmM3YjEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstbW1zeXMuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLW1tc3lzLmgNCkBAIC01NSw2ICs1NSw5IEBAIHN0cnVjdCBtdGtfbW1zeXNfY29ubl9mdW5j
cyB7DQogCXZvaWQgKCpzb3V0X3NlbCkodm9pZCBfX2lvbWVtICpjb25maWdfcmVncywNCiAJCQkg
ZW51bSBtdGtfZGRwX2NvbXBfaWQgY3VyLA0KIAkJCSBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0
KTsNCisJaW50ICgqb3ZsX21vdXRfZW4pKGVudW0gbXRrX2RkcF9jb21wX2lkIGN1ciwNCisJCQkg
ICBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0LA0KKwkJCSAgIHVuc2lnbmVkIGludCAqYWRkcik7
DQogfTsNCiANCiB2b2lkIG10a19tbXN5c19yZWdpc3Rlcl9jb25uX2Z1bmNzKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

