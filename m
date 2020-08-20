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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0AEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59787207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AQ51Iu74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHTGGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35238 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbgHTGFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:55 -0400
X-UUID: 2b062464808e4ffca2481e893a1cafb8-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=36fnnR2AlgsNKVC8MFiMN1gZFhEDJZxQGNPYhMhVoAE=;
        b=AQ51Iu74p23vHnEjWOTCP6VTSfkCDMGpGyfqGsan9G08l0+SQ2ESc4QGsYqhtwZ1MaNAB2ffOgTxZs/43j0/PDHx2346PQ+vi658SuOfrjOYulNNSEBI9V87ic7KmVqQ+RQYJH8HudLVvR6LPmUDjked5IcdDvudR8vleqH2COE=;
X-UUID: 2b062464808e4ffca2481e893a1cafb8-20200820
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1765723134; Thu, 20 Aug 2020 14:05:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:48 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:47 +0800
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
Subject: [PATCH v1 16/21] drm/mediatek: add ovl bypass shadow register function
Date:   Thu, 20 Aug 2020 14:04:13 +0800
Message-ID: <1597903458-8055-17-git-send-email-yongqiang.niu@mediatek.com>
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

YWRkIG92bCBieXBhc3Mgc2hhZG93IHJlZ2lzdGVyIGZ1bmN0aW9uDQoNClNpZ25lZC1vZmYtYnk6
IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgMTYgKysrKysrKysrKysrKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCmluZGV4IDAzZWFhZGIuLmZiMGZlNTkgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KQEAgLTE5LDYgKzE5LDkgQEANCiAjZGVmaW5l
IERJU1BfUkVHX09WTF9JTlRFTgkJCTB4MDAwNA0KICNkZWZpbmUgT1ZMX0ZNRV9DUExfSU5UCQkJ
CQlCSVQoMSkNCiAjZGVmaW5lIERJU1BfUkVHX09WTF9JTlRTVEEJCQkweDAwMDgNCisjZGVmaW5l
IE9WTF9FTgkJCQkJCUJJVCgwKQ0KKyNkZWZpbmUgT1ZMX1JFQURfV09SS19SRUcJCQkJQklUKDIw
KQ0KKyNkZWZpbmUgT1ZMX0JZUEFTU19TSEFET1cJCQkJQklUKDIyKQ0KICNkZWZpbmUgRElTUF9S
RUdfT1ZMX0VOCQkJCTB4MDAwYw0KICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JTVAkJCTB4MDAxNA0K
ICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JPSV9TSVpFCQkJMHgwMDIwDQpAQCAtNjIsNiArNjUsNyBA
QCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgew0KIAl1bnNpZ25lZCBpbnQgZ21jX2JpdHM7DQog
CXVuc2lnbmVkIGludCBsYXllcl9ucjsNCiAJYm9vbCBmbXRfcmdiNTY1X2lzXzA7DQorCWJvb2wg
aGFzX3NoYWRvdzsNCiB9Ow0KIA0KIC8qKg0KQEAgLTEyNiw2ICsxMzAsMTcgQEAgc3RhdGljIHZv
aWQgbXRrX292bF9zdG9wKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQogCXdyaXRlbF9yZWxh
eGVkKDB4MCwgY29tcC0+cmVncyArIERJU1BfUkVHX09WTF9FTik7DQogfQ0KIA0KK3N0YXRpYyB2
b2lkIG10a19vdmxfYnlwYXNzX3NoYWRvdyhzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKQ0KK3sN
CisJc3RydWN0IG10a19kaXNwX292bCAqb3ZsID0gY29tcF90b19vdmwoY29tcCk7DQorDQorCWlm
IChvdmwtPmRhdGEtPmhhc19zaGFkb3cpIHsNCisJCW10a19kZHBfd3JpdGVfbWFzayhOVUxMLCBP
VkxfQllQQVNTX1NIQURPVywgY29tcCwNCisJCQkJICAgRElTUF9SRUdfT1ZMX0VOLA0KKwkJCQkg
ICBPVkxfQllQQVNTX1NIQURPVyk7DQorCX0NCit9DQorDQogc3RhdGljIHZvaWQgbXRrX292bF9j
b25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50IHcsDQogCQkJICAg
dW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwNCiAJCQkgICB1bnNpZ25lZCBp
bnQgYnBjLCBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KQEAgLTMxOCw2ICszMzMsNyBAQCBz
dGF0aWMgdm9pZCBtdGtfb3ZsX2JnY2xyX2luX29mZihzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21w
KQ0KIAkuY29uZmlnID0gbXRrX292bF9jb25maWcsDQogCS5zdGFydCA9IG10a19vdmxfc3RhcnQs
DQogCS5zdG9wID0gbXRrX292bF9zdG9wLA0KKwkuYnlwYXNzX3NoYWRvdyA9IG10a19vdmxfYnlw
YXNzX3NoYWRvdywNCiAJLmVuYWJsZV92YmxhbmsgPSBtdGtfb3ZsX2VuYWJsZV92YmxhbmssDQog
CS5kaXNhYmxlX3ZibGFuayA9IG10a19vdmxfZGlzYWJsZV92YmxhbmssDQogCS5zdXBwb3J0ZWRf
cm90YXRpb25zID0gbXRrX292bF9zdXBwb3J0ZWRfcm90YXRpb25zLA0KLS0gDQoxLjguMS4xLmRp
cnR5DQo=

