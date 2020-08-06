Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71DCC3814B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E916F22DCC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nIdT9AIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgHFJf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:35:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729142AbgHFJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:22:46 -0400
X-UUID: 637f1b7d5836411e84f2c0e031f737b3-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=muvS6t9S3WSIarHkuOxN7/Mfmi70tzjpMAhn1vHWUyc=;
        b=nIdT9AIPDCaYymVhzwdBsYUeVjEBZR68KCDLrWzuOLqKg7g+g/LdOwJTXbzkNqwPHo+y+gZ5Dpfa9OwsGdJNv+RNPXE50fyZc0ho7qMuiq9Q6T4Z+ThduekiGTeavW3a9TJ1fY0QThXMn7tZwNjEGhLdpw7XS4OuARzKkJP873w=;
X-UUID: 637f1b7d5836411e84f2c0e031f737b3-20200806
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 519316754; Thu, 06 Aug 2020 17:22:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 17:22:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 17:22:00 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v17 10/12] soc: mediatek: Add a comma at the end
Date:   Thu, 6 Aug 2020 17:21:53 +0800
Message-ID: <1596705715-15320-11-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSBtaW5vciBjb2Rpbmcgc3R5bGUgZml4DQoNClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5
aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lz
LmMgfCAxNCArKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
c2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDlhNjk5
YjQuLjcxNTg4NjNiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5
cy5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCkBAIC0xNDY4LDcg
KzE0NjgsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcmVnaXN0ZXJfcG93ZXJfZG9tYWlucyhzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkubnVtX2RvbWFpbnMgPSBBUlJBWV9TSVpFKHNjcF9k
b21haW5fZGF0YV9tdDI3MDEpLA0KIAkucmVncyA9IHsNCiAJCS5wd3Jfc3RhX29mZnMgPSBTUE1f
UFdSX1NUQVRVUywNCi0JCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkQNCisJ
CS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkQsDQogCX0sDQogfTsNCiANCkBA
IC0xNDc5LDcgKzE0NzksNyBAQCBzdGF0aWMgdm9pZCBtdGtfcmVnaXN0ZXJfcG93ZXJfZG9tYWlu
cyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkubnVtX3N1YmRvbWFpbnMgPSBBUlJB
WV9TSVpFKHNjcF9zdWJkb21haW5fbXQyNzEyKSwNCiAJLnJlZ3MgPSB7DQogCQkucHdyX3N0YV9v
ZmZzID0gU1BNX1BXUl9TVEFUVVMsDQotCQkucHdyX3N0YTJuZF9vZmZzID0gU1BNX1BXUl9TVEFU
VVNfMk5EDQorCQkucHdyX3N0YTJuZF9vZmZzID0gU1BNX1BXUl9TVEFUVVNfMk5ELA0KIAl9LA0K
IH07DQogDQpAQCAtMTQ5MCw3ICsxNDkwLDcgQEAgc3RhdGljIHZvaWQgbXRrX3JlZ2lzdGVyX3Bv
d2VyX2RvbWFpbnMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJLm51bV9zdWJkb21h
aW5zID0gQVJSQVlfU0laRShzY3Bfc3ViZG9tYWluX210Njc5NyksDQogCS5yZWdzID0gew0KIAkJ
LnB3cl9zdGFfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTX01UNjc5NywNCi0JCS5wd3Jfc3RhMm5kX29m
ZnMgPSBTUE1fUFdSX1NUQVRVU18yTkRfTVQ2Nzk3DQorCQkucHdyX3N0YTJuZF9vZmZzID0gU1BN
X1BXUl9TVEFUVVNfMk5EX01UNjc5NywNCiAJfSwNCiB9Ow0KIA0KQEAgLTE0OTksNyArMTQ5OSw3
IEBAIHN0YXRpYyB2b2lkIG10a19yZWdpc3Rlcl9wb3dlcl9kb21haW5zKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYsDQogCS5udW1fZG9tYWlucyA9IEFSUkFZX1NJWkUoc2NwX2RvbWFpbl9k
YXRhX210NzYyMiksDQogCS5yZWdzID0gew0KIAkJLnB3cl9zdGFfb2ZmcyA9IFNQTV9QV1JfU1RB
VFVTLA0KLQkJLnB3cl9zdGEybmRfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTXzJORA0KKwkJLnB3cl9z
dGEybmRfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTXzJORCwNCiAJfSwNCiB9Ow0KIA0KQEAgLTE1MDgs
NyArMTUwOCw3IEBAIHN0YXRpYyB2b2lkIG10a19yZWdpc3Rlcl9wb3dlcl9kb21haW5zKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCS5udW1fZG9tYWlucyA9IEFSUkFZX1NJWkUoc2Nw
X2RvbWFpbl9kYXRhX210NzYyM2EpLA0KIAkucmVncyA9IHsNCiAJCS5wd3Jfc3RhX29mZnMgPSBT
UE1fUFdSX1NUQVRVUywNCi0JCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkQN
CisJCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkQsDQogCX0sDQogfTsNCiAN
CkBAIC0xNTE5LDcgKzE1MTksNyBAQCBzdGF0aWMgdm9pZCBtdGtfcmVnaXN0ZXJfcG93ZXJfZG9t
YWlucyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkubnVtX3N1YmRvbWFpbnMgPSBB
UlJBWV9TSVpFKHNjcF9zdWJkb21haW5fbXQ4MTczKSwNCiAJLnJlZ3MgPSB7DQogCQkucHdyX3N0
YV9vZmZzID0gU1BNX1BXUl9TVEFUVVMsDQotCQkucHdyX3N0YTJuZF9vZmZzID0gU1BNX1BXUl9T
VEFUVVNfMk5EDQorCQkucHdyX3N0YTJuZF9vZmZzID0gU1BNX1BXUl9TVEFUVVNfMk5ELA0KIAl9
LA0KIH07DQogDQpAQCAtMTUyOCw3ICsxNTI4LDcgQEAgc3RhdGljIHZvaWQgbXRrX3JlZ2lzdGVy
X3Bvd2VyX2RvbWFpbnMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJLm51bV9kb21h
aW5zID0gQVJSQVlfU0laRShzY3BfZG9tYWluX2RhdGFfbXQ4MTgzKSwNCiAJLnJlZ3MgPSB7DQog
CQkucHdyX3N0YV9vZmZzID0gMHgwMTgwLA0KLQkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MDE4NA0K
KwkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MDE4NCwNCiAJfQ0KIH07DQogDQotLSANCjEuOC4xLjEu
ZGlydHkNCg==

