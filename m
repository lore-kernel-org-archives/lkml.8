Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C485CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A421324888
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="grs4E7EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgFUNWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:22:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56177 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729596AbgFUNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:22:19 -0400
X-UUID: b4db1b57d7d74d778bdbd5826ad2d26c-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7baMzIyPNg+TFEral2VkSNt/ytu43JUL3f22WRv9/Kc=;
        b=grs4E7EKI0EvgqXzpkf/f+1JM3DRJWcZlASb8JlUMJ7WHSaShKVej6H/QAxhxMbo9iZemsgqFlBou4vvJEjAfDHpN4FGmIs082kURMYkQ+HA11x0ZNoKZjwNpCmOTEMV2ogRIBGqJ49yCMeigj+CBd2BDkSfN1scsyS9fmU60bE=;
X-UUID: b4db1b57d7d74d778bdbd5826ad2d26c-20200621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1983914733; Sun, 21 Jun 2020 21:22:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 21:22:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 21:22:06 +0800
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
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v7 4/4] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Sun, 21 Jun 2020 21:22:11 +0800
Message-ID: <1592745731-14614-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQpjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMgfCAgIDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
Yw0KaW5kZXggOTk5NGFjOTQyNmQ2Li5iNTZkMzQwYzg5ODIgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQorKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5jDQpAQCAtMzg3LDYgKzM4NywxMiBAQCBzdGF0aWMgaW50IGNtZHFfbWJveF9z
ZW5kX2RhdGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdm9pZCAqZGF0YSkNCiANCiAJaWYgKGxp
c3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKSB7DQogCQlXQVJOX09OKGNsa19lbmFi
bGUoY21kcS0+Y2xvY2spIDwgMCk7DQorCQkvKg0KKwkJICogVGhlIHRocmVhZCByZXNldCB3aWxs
IGNsZWFyIHRocmVhZCByZWxhdGVkIHJlZ2lzdGVyIHRvIDAsDQorCQkgKiBpbmNsdWRpbmcgcGMs
IGVuZCwgcHJpb3JpdHksIGlycSwgc3VzcGVuZCBhbmQgZW5hYmxlLiBUaHVzDQorCQkgKiBzZXQg
Q01EUV9USFJfRU5BQkxFRCB0byBDTURRX1RIUl9FTkFCTEVfVEFTSyB3aWxsIGVuYWJsZQ0KKwkJ
ICogdGhyZWFkIGFuZCBtYWtlIGl0IHJ1bm5pbmcuDQorCQkgKi8NCiAJCVdBUk5fT04oY21kcV90
aHJlYWRfcmVzZXQoY21kcSwgdGhyZWFkKSA8IDApOw0KIA0KIAkJd3JpdGVsKHRhc2stPnBhX2Jh
c2UgPj4gY21kcS0+c2hpZnRfcGEsDQpAQCAtNDUwLDYgKzQ1NiwzOCBAQCBzdGF0aWMgaW50IGNt
ZHFfbWJveF9zdGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQogDQogc3RhdGljIHZvaWQg
Y21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQogew0KKwlzdHJ1Y3Qg
Y21kcV90aHJlYWQgKnRocmVhZCA9IChzdHJ1Y3QgY21kcV90aHJlYWQgKiljaGFuLT5jb25fcHJp
djsNCisJc3RydWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRhdGEoY2hhbi0+bWJveC0+ZGV2
KTsNCisJc3RydWN0IGNtZHFfdGFzayAqdGFzaywgKnRtcDsNCisJdW5zaWduZWQgbG9uZyBmbGFn
czsNCisNCisJc3Bpbl9sb2NrX2lycXNhdmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0K
KwlpZiAobGlzdF9lbXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpDQorCQlnb3RvIGRvbmU7
DQorDQorCVdBUk5fT04oY21kcV90aHJlYWRfc3VzcGVuZChjbWRxLCB0aHJlYWQpIDwgMCk7DQor
DQorCS8qIG1ha2Ugc3VyZSBleGVjdXRlZCB0YXNrcyBoYXZlIHN1Y2Nlc3MgY2FsbGJhY2sgKi8N
CisJY21kcV90aHJlYWRfaXJxX2hhbmRsZXIoY21kcSwgdGhyZWFkKTsNCisJaWYgKGxpc3RfZW1w
dHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KKwkJZ290byBkb25lOw0KKw0KKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCisJ
CQkJIGxpc3RfZW50cnkpIHsNCisJCWNtZHFfdGFza19leGVjX2RvbmUodGFzaywgQ01EUV9DQl9F
UlJPUik7DQorCQlrZnJlZSh0YXNrKTsNCisJfQ0KKw0KKwljbWRxX3RocmVhZF9kaXNhYmxlKGNt
ZHEsIHRocmVhZCk7DQorCWNsa19kaXNhYmxlKGNtZHEtPmNsb2NrKTsNCitkb25lOg0KKwkvKg0K
KwkgKiBUaGUgdGhyZWFkLT50YXNrX2J1c3lfbGlzdCBlbXB0eSBtZWFucyB0aHJlYWQgYWxyZWFk
eSBkaXNhYmxlLiBUaGUNCisJICogY21kcV9tYm94X3NlbmRfZGF0YSgpIGFsd2F5cyByZXNldCB0
aHJlYWQgd2hpY2ggY2xlYXIgZGlzYWJsZSBhbmQNCisJICogc3VzcGVuZCBzdGF0dWUgd2hlbiBm
aXJzdCBwa3Qgc2VuZCB0byBjaGFubmVsLCBzbyB0aGVyZSBpcyBubyBuZWVkDQorCSAqIHRvIGRv
IGFueSBvcGVyYXRpb24gaGVyZSwgb25seSB1bmxvY2sgYW5kIGxlYXZlLg0KKwkgKi8NCisJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQogfQ0KIA0K
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7
DQotLSANCjEuNy45LjUNCg==

