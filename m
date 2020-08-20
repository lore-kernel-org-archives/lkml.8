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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B701C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14F72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sRnt7nEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHTGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9635 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbgHTGGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:06:04 -0400
X-UUID: 953687bc1c584919a9de97a74478c4d0-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2KcvHK1Jr9oJkknwRko3J/Skm+3J8NuMuW2fpqtgTDE=;
        b=sRnt7nEEIMj4iGqRSY4gUXU9jq/+3cfdi00nAnLy0HsBGVqh/+ItbTOgmEtbYSakhNQJL+Kkne6H5BpN8DPn3vYC9cbwN+dzG7JKSotkb6LmzokTzYLF953fftpgYyRvxjhFPggby9pOXKbsnRPrITZjWa+X+zW/X+Uwb69zFaI=;
X-UUID: 953687bc1c584919a9de97a74478c4d0-20200820
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 502150299; Thu, 20 Aug 2020 14:06:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:58 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:57 +0800
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
Subject: [PATCH v1 20/21] drm/mediatek: add ccorr bypass shadow register function
Date:   Thu, 20 Aug 2020 14:04:17 +0800
Message-ID: <1597903458-8055-21-git-send-email-yongqiang.niu@mediatek.com>
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

YWRkIGNjb3JyIGJ5cGFzcyBzaGFkb3cgcmVnaXN0ZXIgZnVuY3Rpb24NCg0KU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMTAgKysrKysrKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KaW5kZXggYjRhNmRmNS4uZmYyM2E5NCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCkBAIC01NSw2ICs1
NSw4IEBADQogI2RlZmluZSBESVNQX0NDT1JSX0NPRUZfMgkJCTB4MDA4OA0KICNkZWZpbmUgRElT
UF9DQ09SUl9DT0VGXzMJCQkweDAwOEMNCiAjZGVmaW5lIERJU1BfQ0NPUlJfQ09FRl80CQkJMHgw
MDkwDQorI2RlZmluZSBESVNQX0NDT1JSX1NIQURPVwkJCTB4MDBBMA0KKyNkZWZpbmUgQ0NPUlJf
QllQQVNTX1NIQURPVwkJCQlCSVQoMikNCiANCiAjZGVmaW5lIERJU1BfRElUSEVSX0VOCQkJCTB4
MDAwMA0KICNkZWZpbmUgRElUSEVSX0VOCQkJCUJJVCgwKQ0KQEAgLTI4NCw2ICsyODYsMTMgQEAg
c3RhdGljIHZvaWQgbXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwN
CiAJCSAgICAgIGNvbXAsIERJU1BfQ0NPUlJfQ09FRl80KTsNCiB9DQogDQorc3RhdGljIHZvaWQg
bXRrX2Njb3JyX2J5cGFzc19zaGFkb3coc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCit7DQor
CW10a19kZHBfd3JpdGVfbWFzayhOVUxMLCBDQ09SUl9CWVBBU1NfU0hBRE9XLCBjb21wLA0KKwkJ
CSAgIERJU1BfQ0NPUlJfU0hBRE9XLA0KKwkJCSAgIENDT1JSX0JZUEFTU19TSEFET1cpOw0KK30N
CisNCiBzdGF0aWMgdm9pZCBtdGtfZGl0aGVyX2NvbmZpZyhzdHJ1Y3QgbXRrX2RkcF9jb21wICpj
b21wLCB1bnNpZ25lZCBpbnQgdywNCiAJCQkgICAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQg
aW50IHZyZWZyZXNoLA0KIAkJCSAgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3Br
dCAqY21kcV9wa3QpDQpAQCAtMzgxLDYgKzM5MCw3IEBAIHN0YXRpYyB2b2lkIG10a19wb3N0bWFz
a19zdG9wKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQogCS5zdGFydCA9IG10a19jY29ycl9z
dGFydCwNCiAJLnN0b3AgPSBtdGtfY2NvcnJfc3RvcCwNCiAJLmN0bV9zZXQgPSBtdGtfY2NvcnJf
Y3RtX3NldCwNCisJLmJ5cGFzc19zaGFkb3cgPSBtdGtfY2NvcnJfYnlwYXNzX3NoYWRvdw0KIH07
DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2RpdGhlciA9
IHsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

