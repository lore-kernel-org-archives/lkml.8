Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C083C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188852078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RtagHxbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHTGGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44885 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726820AbgHTGFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:49 -0400
X-UUID: 2437b09b084e4afd8c5377f0baa8d2f3-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CYF0YG4gNVrjrfJ9U+B9+/FbeQsInObr+OBTOYnxpFo=;
        b=RtagHxbu3Gic+6WrAk6V3rOljBI7dEe9qJ1zP7WeJX7aDywDcHhh3m9mB0JPY1oN7+VORRXF9xlAEHQL3TJ9n2zDKp1UV2gaWp739S8LXlCxxw2GCmQc0sYXEAsXKjX3NBo7mR4FseM29YR2+UaPNwIgREMb+YbZ6mu5WslCgGc=;
X-UUID: 2437b09b084e4afd8c5377f0baa8d2f3-20200820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 493149081; Thu, 20 Aug 2020 14:05:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:45 +0800
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
Subject: [PATCH v1 14/21] drm/mediatek: add bypass shadow register function call for ddp component
Date:   Thu, 20 Aug 2020 14:04:11 +0800
Message-ID: <1597903458-8055-15-git-send-email-yongqiang.niu@mediatek.com>
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

dGhlIHNoYWRvdyByZWdpc3RlciBmb3IgbXQ4MTkyIGRkcCBjb21wb25lbnQgaXMgZW5hYmxlLA0K
d2UgbmVlZCBkaXNhYmxlIGl0IGJlZm9yZSBlbmFibGUgZGRwIGNvbXBvbmVudA0KDQpTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAgfCAzICsrKw0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCA3ICsrKysrKysNCiAy
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KaW5kZXggZmU0NmM0Yi4uMTZlOWI4OCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtMjk5LDYgKzI5OSw5IEBAIHN0YXRpYyBp
bnQgbXRrX2NydGNfZGRwX2h3X2luaXQoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQog
CQlnb3RvIGVycl9tdXRleF91bnByZXBhcmU7DQogCX0NCiANCisJZm9yIChpID0gMDsgaSA8IG10
a19jcnRjLT5kZHBfY29tcF9ucjsgaSsrKQ0KKwkJbXRrX2RkcF9jb21wX2J5cGFzc19zaGFkb3co
bXRrX2NydGMtPmRkcF9jb21wW2ldKTsNCisNCiAJRFJNX0RFQlVHX0RSSVZFUigibWVkaWF0ZWtf
ZGRwX2RkcF9wYXRoX3NldHVwXG4iKTsNCiAJZm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5kZHBf
Y29tcF9uciAtIDE7IGkrKykgew0KIAkJbXRrX21tc3lzX2RkcF9jb25uZWN0KG10a19jcnRjLT5t
bXN5c19kZXYsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgN
CmluZGV4IGFlMTFiNDYuLjFmMjU3MDUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5oDQpAQCAtNDUsNiArNDUsNyBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21w
X2Z1bmNzIHsNCiAJCSAgICAgICB1bnNpZ25lZCBpbnQgYnBjLCBzdHJ1Y3QgY21kcV9wa3QgKmNt
ZHFfcGt0KTsNCiAJdm9pZCAoKnN0YXJ0KShzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKTsNCiAJ
dm9pZCAoKnN0b3ApKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApOw0KKwl2b2lkICgqYnlwYXNz
X3NoYWRvdykoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCk7DQogCXZvaWQgKCplbmFibGVfdmJs
YW5rKShzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCBzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOw0K
IAl2b2lkICgqZGlzYWJsZV92YmxhbmspKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApOw0KIAl1
bnNpZ25lZCBpbnQgKCpzdXBwb3J0ZWRfcm90YXRpb25zKShzdHJ1Y3QgbXRrX2RkcF9jb21wICpj
b21wKTsNCkBAIC0xNjksNiArMTcwLDEyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtdGtfZGRwX2N0
bV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCiAJCWNvbXAtPmZ1bmNzLT5jdG1fc2V0
KGNvbXAsIHN0YXRlKTsNCiB9DQogDQorc3RhdGljIGlubGluZSB2b2lkIG10a19kZHBfY29tcF9i
eXBhc3Nfc2hhZG93KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQorew0KKwlpZiAoY29tcC0+
ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPmJ5cGFzc19zaGFkb3cpDQorCQljb21wLT5mdW5jcy0+Ynlw
YXNzX3NoYWRvdyhjb21wKTsNCit9DQorDQogaW50IG10a19kZHBfY29tcF9nZXRfaWQoc3RydWN0
IGRldmljZV9ub2RlICpub2RlLA0KIAkJCWVudW0gbXRrX2RkcF9jb21wX3R5cGUgY29tcF90eXBl
KTsNCiBpbnQgbXRrX2RkcF9jb21wX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlX25vZGUgKmNvbXBfbm9kZSwNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

