Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D0C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25EB20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NrHPrzns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgG1KQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:16:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28522 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728463AbgG1KQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:16:26 -0400
X-UUID: d6aed8235a804c3ea65a385665d534e0-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RA6L6eQAY3y0CXSCG2I/vbMfvebMTIOJHOzZ3+Di/tc=;
        b=NrHPrznsn64JSDDkq1/OOckyJs68+CgeGTs+K2QBgMNEV4o+YE5uE8l4KSA7RjqDz3a2ZR/nxGq1xUg2anwbY9kEFqqnJjPgLj42Mp4l31/89izbiy6EoXxkzoaQQChk92L7tczonCKKNRUevvXWwxVV0cTZ10CNJBdUc2T/kB4=;
X-UUID: d6aed8235a804c3ea65a385665d534e0-20200728
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1938322275; Tue, 28 Jul 2020 18:16:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 18:16:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 18:16:20 +0800
From:   Freddy Hsin <freddy.hsin@mediatek.com>
To:     <linux-mediatek@lists.infradead.or>,
        <linux-arm-kernel@lists.infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Saravana Kannan <saravanak@google.com>,
        <linux-kernel@vger.kernel.org>, <chang-an.chen@mediatek.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        <wsd_upstream@mediatek.com>, <kuohong.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, Freddy Hsin <freddy.hsin@mediatek.com>
Subject: [PATCH v1 2/2] timer: mt6873: porting Mediatek timer driver to loadable module
Date:   Tue, 28 Jul 2020 18:16:17 +0800
Message-ID: <1595931377-21627-3-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
References: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cG9ydGluZyBNZWRpYXRlayB0aW1lciBkcml2ZXIgdG8gbG9hZGFibGUgbW9kdWxlDQoNClNpZ25l
ZC1vZmYtYnk6IEZyZWRkeSBIc2luIDxmcmVkZHkuaHNpbkBtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcgICAgICAgICAgfCAgICAyICstDQogZHJpdmVycy9j
bG9ja3NvdXJjZS9tbWlvLmMgICAgICAgICAgIHwgICAgNCArKystDQogZHJpdmVycy9jbG9ja3Nv
dXJjZS90aW1lci1tZWRpYXRlay5jIHwgICAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnIGIvZHJpdmVycy9j
bG9ja3NvdXJjZS9LY29uZmlnDQppbmRleCA5MTQxODM4Li41MzgzNTFhIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnDQorKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL0tj
b25maWcNCkBAIC00NzIsNyArNDcyLDcgQEAgY29uZmlnIFNZU19TVVBQT1JUU19TSF9DTVQNCiAJ
Ym9vbA0KIA0KIGNvbmZpZyBNVEtfVElNRVINCi0JYm9vbCAiTWVkaWF0ZWsgdGltZXIgZHJpdmVy
IiBpZiBDT01QSUxFX1RFU1QNCisJdHJpc3RhdGUgIk1lZGlhdGVrIHRpbWVyIGRyaXZlciINCiAJ
ZGVwZW5kcyBvbiBIQVNfSU9NRU0NCiAJc2VsZWN0IFRJTUVSX09GDQogCXNlbGVjdCBDTEtTUkNf
TU1JTw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvbW1pby5jIGIvZHJpdmVycy9j
bG9ja3NvdXJjZS9tbWlvLmMNCmluZGV4IDlkZTc1MTUuLjU1MDQ1NjkgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2Nsb2Nrc291cmNlL21taW8uYw0KKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9tbWlv
LmMNCkBAIC0yMSw2ICsyMSw3IEBAIHU2NCBjbG9ja3NvdXJjZV9tbWlvX3JlYWRsX3VwKHN0cnVj
dCBjbG9ja3NvdXJjZSAqYykNCiB7DQogCXJldHVybiAodTY0KXJlYWRsX3JlbGF4ZWQodG9fbW1p
b19jbGtzcmMoYyktPnJlZyk7DQogfQ0KK0VYUE9SVF9TWU1CT0woY2xvY2tzb3VyY2VfbW1pb19y
ZWFkbF91cCk7DQogDQogdTY0IGNsb2Nrc291cmNlX21taW9fcmVhZGxfZG93bihzdHJ1Y3QgY2xv
Y2tzb3VyY2UgKmMpDQogew0KQEAgLTQ2LDcgKzQ3LDcgQEAgdTY0IGNsb2Nrc291cmNlX21taW9f
cmVhZHdfZG93bihzdHJ1Y3QgY2xvY2tzb3VyY2UgKmMpDQogICogQGJpdHM6CU51bWJlciBvZiB2
YWxpZCBiaXRzDQogICogQHJlYWQ6CU9uZSBvZiBjbG9ja3NvdXJjZV9tbWlvX3JlYWQqKCkgYWJv
dmUNCiAgKi8NCi1pbnQgX19pbml0IGNsb2Nrc291cmNlX21taW9faW5pdCh2b2lkIF9faW9tZW0g
KmJhc2UsIGNvbnN0IGNoYXIgKm5hbWUsDQoraW50IGNsb2Nrc291cmNlX21taW9faW5pdCh2b2lk
IF9faW9tZW0gKmJhc2UsIGNvbnN0IGNoYXIgKm5hbWUsDQogCXVuc2lnbmVkIGxvbmcgaHosIGlu
dCByYXRpbmcsIHVuc2lnbmVkIGJpdHMsDQogCXU2NCAoKnJlYWQpKHN0cnVjdCBjbG9ja3NvdXJj
ZSAqKSkNCiB7DQpAQCAtNjgsMyArNjksNCBAQCBpbnQgX19pbml0IGNsb2Nrc291cmNlX21taW9f
aW5pdCh2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0IGNoYXIgKm5hbWUsDQogDQogCXJldHVybiBj
bG9ja3NvdXJjZV9yZWdpc3Rlcl9oeigmY3MtPmNsa3NyYywgaHopOw0KIH0NCitFWFBPUlRfU1lN
Qk9MKGNsb2Nrc291cmNlX21taW9faW5pdCk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3Nv
dXJjZS90aW1lci1tZWRpYXRlay5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRl
ay5jDQppbmRleCA5MzE4ZWRjLi41Yzg5YjZiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbG9ja3Nv
dXJjZS90aW1lci1tZWRpYXRlay5jDQorKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1l
ZGlhdGVrLmMNCkBAIC0xMyw2ICsxMyw5IEBADQogI2luY2x1ZGUgPGxpbnV4L2Nsb2Nrc291cmNl
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnFy
ZXR1cm4uaD4NCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQorI2luY2x1ZGUgPGxpbnV4L29m
X2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVk
ZSA8bGludXgvc2NoZWRfY2xvY2suaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNs
dWRlICJ0aW1lci1vZi5oIg0KQEAgLTMwOSw1ICszMTIsNDEgQEAgc3RhdGljIGludCBfX2luaXQg
bXRrX2dwdF9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSkNCiANCiAJcmV0dXJuIDA7DQog
fQ0KKw0KKyNpZmRlZiBNT0RVTEUNCitzdGF0aWMgaW50IG10a190aW1lcl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJaW50ICgqdGltZXJfaW5pdCkoc3RydWN0IGRl
dmljZV9ub2RlICpub2RlKTsNCisJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5v
Zl9ub2RlOw0KKw0KKwl0aW1lcl9pbml0ID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2
LT5kZXYpOw0KKwlyZXR1cm4gdGltZXJfaW5pdChucCk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a190aW1lcl9tYXRjaF90YWJsZVtdID0gew0KKwl7DQorCQku
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY1NzctdGltZXIiLA0KKwkJLmRhdGEgPSBtdGtfZ3B0
X2luaXQsDQorCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc2NS10aW1l
ciIsDQorCQkuZGF0YSA9IG10a19zeXN0X2luaXQsDQorCX0sDQorCXt9DQorfTsNCisNCitzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfdGltZXJfZHJpdmVyID0gew0KKwkucHJvYmUg
PSBtdGtfdGltZXJfcHJvYmUsDQorCS5kcml2ZXIgPSB7DQorCQkubmFtZSA9ICJtdGstdGltZXIi
LA0KKwkJLm9mX21hdGNoX3RhYmxlID0gbXRrX3RpbWVyX21hdGNoX3RhYmxlLA0KKwl9LA0KK307
DQorTU9EVUxFX0RFU0NSSVBUSU9OKCJNRURJQVRFSyBNb2R1bGUgdGltZXIgZHJpdmVyIik7DQor
TU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KKw0KK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIobXRr
X3RpbWVyX2RyaXZlcik7DQorI2Vsc2UNCiBUSU1FUl9PRl9ERUNMQVJFKG10a19tdDY1NzcsICJt
ZWRpYXRlayxtdDY1NzctdGltZXIiLCBtdGtfZ3B0X2luaXQpOw0KIFRJTUVSX09GX0RFQ0xBUkUo
bXRrX210Njc2NSwgIm1lZGlhdGVrLG10Njc2NS10aW1lciIsIG10a19zeXN0X2luaXQpOw0KKyNl
bmRpZg0KLS0gDQoxLjcuOS41DQo=

