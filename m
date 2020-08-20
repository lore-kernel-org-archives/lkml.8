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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1B62078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="czV+AgkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHTGGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23595 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgHTGGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:06:02 -0400
X-UUID: b82de08971b946d3aed2258cd25444af-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Goa7JPmDFNuSu9rW6OSEL3atM2vBJYhtQ96kEWsc+t8=;
        b=czV+AgkWdFpfxcS6yTiw7gnojEFDXr76H0FMk16lX4LfI3gVSzSeUWPktHfWD0rJ9G/zb91L+ArqdT4GVhXa4z/X/7fiiT9btWMZF0LF2D334pExmyHahdnTYQHRSQfgEqIsYvFPu1f6PDOf0EkyVFyuBy6mditBW0r1HPL1rS4=;
X-UUID: b82de08971b946d3aed2258cd25444af-20200820
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2119355855; Thu, 20 Aug 2020 14:05:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:55 +0800
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
Subject: [PATCH v1 18/21] drm/mediatek: add dither bypass shadow register function
Date:   Thu, 20 Aug 2020 14:04:15 +0800
Message-ID: <1597903458-8055-19-git-send-email-yongqiang.niu@mediatek.com>
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

YWRkIGRpdGhlciBieXBhc3Mgc2hhZG93IHJlZ2lzdGVyIGZ1bmN0aW9uDQoNClNpZ25lZC1vZmYt
Ynk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDExICsrKysrKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQppbmRleCAwYzgxMjUzLi4zMTViZDNhIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KQEAgLTIzLDYg
KzIzLDkgQEANCiAjZGVmaW5lIERJU1BfT0RfSU5UU1RBCQkJCTB4MDAwYw0KICNkZWZpbmUgRElT
UF9PRF9DRkcJCQkJMHgwMDIwDQogI2RlZmluZSBESVNQX09EX1NJWkUJCQkJMHgwMDMwDQorDQor
I2RlZmluZSBESVRIRVJfUkVHKGlkeCkJCQkJKDB4MTAwICsgKGlkeCkgKiA0KQ0KKyNkZWZpbmUg
RElUSEVSX0JZUEFTU19TSEFET1cJCQkJQklUKDApDQogI2RlZmluZSBESVNQX0RJVEhFUl81CQkJ
CTB4MDExNA0KICNkZWZpbmUgRElTUF9ESVRIRVJfNwkJCQkweDAxMWMNCiAjZGVmaW5lIERJU1Bf
RElUSEVSXzE1CQkJCTB4MDEzYw0KQEAgLTI5MSw2ICsyOTQsMTMgQEAgc3RhdGljIHZvaWQgbXRr
X2RpdGhlcl9zdG9wKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQogCXdyaXRlbF9yZWxheGVk
KDB4MCwgY29tcC0+cmVncyArIERJU1BfRElUSEVSX0VOKTsNCiB9DQogDQorc3RhdGljIHZvaWQg
bXRrX2RpdGhlcl9ieXBhc3Nfc2hhZG93KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQorew0K
KwltdGtfZGRwX3dyaXRlX21hc2soTlVMTCwgRElUSEVSX0JZUEFTU19TSEFET1csIGNvbXAsDQor
CQkJICAgRElUSEVSX1JFRygwKSwNCisJCQkgICBESVRIRVJfQllQQVNTX1NIQURPVyk7DQorfQ0K
Kw0KIHN0YXRpYyB2b2lkIG10a19nYW1tYV9jb25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29t
cCwgdW5zaWduZWQgaW50IHcsDQogCQkJICAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQgaW50
IHZyZWZyZXNoLA0KIAkJCSAgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpj
bWRxX3BrdCkNCkBAIC0zNjgsNiArMzc4LDcgQEAgc3RhdGljIHZvaWQgbXRrX3Bvc3RtYXNrX3N0
b3Aoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCiAJLmNvbmZpZyA9IG10a19kaXRoZXJfY29u
ZmlnLA0KIAkuc3RhcnQgPSBtdGtfZGl0aGVyX3N0YXJ0LA0KIAkuc3RvcCA9IG10a19kaXRoZXJf
c3RvcCwNCisJLmJ5cGFzc19zaGFkb3cgPSBtdGtfZGl0aGVyX2J5cGFzc19zaGFkb3csDQogfTsN
CiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZ2FtbWEgPSB7
DQotLSANCjEuOC4xLjEuZGlydHkNCg==

