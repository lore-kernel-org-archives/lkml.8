Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA710C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB6A20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P3vPznNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393536AbgFSRwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:52:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30411 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731445AbgFSRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:52:11 -0400
X-UUID: 4478a7f4d29c44a0baeac7527268ac55-20200620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sIDH8EdAE4qcmj93nhKlzx7c6UAV1dzXbtm0oufG89w=;
        b=P3vPznNbBFt87BddjbeK4q1uarTDy5M62LRiA60qFwjamgD6+S/0/pXdGMxxKeHEZuKtFb8AAqQ2+jC7qp6Y1sWZdOePsSSRpV3ueXiW0dPCVpDqYopHUHo5lPTbuLmWXcjd0NYTQgmEbaRgfKZY/hmtFuGp/5lKZF8Ja/Y+nqA=;
X-UUID: 4478a7f4d29c44a0baeac7527268ac55-20200620
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1320373898; Sat, 20 Jun 2020 01:52:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Jun 2020 01:52:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Jun 2020 01:52:01 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Subject: [PATCH v2 2/2] Bluetooth: btmtksdio: fix up firmware download sequence
Date:   Sat, 20 Jun 2020 01:52:02 +0800
Message-ID: <8ed6746c7d2ce6a38eb88c78c81593c0cbd4451f.1592588740.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7d835850c16e07d1346c763900cc8c880182f497.1592588740.git.sean.wang@mediatek.com>
References: <7d835850c16e07d1346c763900cc8c880182f497.1592588740.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpEYXRhIFJBTSBvbiB0
aGUgZGV2aWNlIGhhdmUgdG8gYmUgcG93ZXJlZCBvbiBiZWZvcmUgc3RhcnRpbmcgdG8gZG93bmxv
YWQNCnRoZSBmaXJtd2FyZS4NCg0KdjEtPnYyOg0KCXJlYmFzZWQgdG8gYmx1ZXRvb3RoLW5leHQN
Cg0KRml4ZXM6IDlhZWJmZDRhMjIwMCAoIkJsdWV0b290aDogbWVkaWF0ZWs6IGFkZCBzdXBwb3J0
IGZvciBNZWRpYVRlayBNVDc2NjNTIGFuZCBNVDc2NjhTIFNESU8gZGV2aWNlcyIpDQpDby1kZXZl
bG9wZWQtYnk6IE1hcmsgQ2hlbiA8TWFyay1ZVy5DaGVuQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IE1hcmsgQ2hlbiA8TWFyay1ZVy5DaGVuQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvYmx1
ZXRvb3RoL2J0bXRrc2Rpby5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2JsdWV0b290aC9idG10a3NkaW8uYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrc2Rpby5jDQpp
bmRleCA1MTk3ODhjNDQyY2EuLjExNDk0Y2QyYTk4MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0bXRrc2Rpby5jDQorKysgYi9kcml2ZXJzL2JsdWV0b290aC9idG10a3NkaW8uYw0K
QEAgLTY4NSw3ICs2ODUsNyBAQCBzdGF0aWMgaW50IG10a19zZXR1cF9maXJtd2FyZShzdHJ1Y3Qg
aGNpX2RldiAqaGRldiwgY29uc3QgY2hhciAqZnduYW1lKQ0KIAljb25zdCB1OCAqZndfcHRyOw0K
IAlzaXplX3QgZndfc2l6ZTsNCiAJaW50IGVyciwgZGxlbjsNCi0JdTggZmxhZzsNCisJdTggZmxh
ZywgcGFyYW07DQogDQogCWVyciA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBmd25hbWUsICZoZGV2
LT5kZXYpOw0KIAlpZiAoZXJyIDwgMCkgew0KQEAgLTY5Myw2ICs2OTMsMjAgQEAgc3RhdGljIGlu
dCBtdGtfc2V0dXBfZmlybXdhcmUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGNvbnN0IGNoYXIgKmZ3
bmFtZSkNCiAJCXJldHVybiBlcnI7DQogCX0NCiANCisJLyogUG93ZXIgb24gZGF0YSBSQU0gdGhl
IGZpcm13YXJlIHJlbGllcyBvbi4gKi8NCisJcGFyYW0gPSAxOw0KKwl3bXRfcGFyYW1zLm9wID0g
TVRLX1dNVF9GVU5DX0NUUkw7DQorCXdtdF9wYXJhbXMuZmxhZyA9IDM7DQorCXdtdF9wYXJhbXMu
ZGxlbiA9IHNpemVvZihwYXJhbSk7DQorCXdtdF9wYXJhbXMuZGF0YSA9ICZwYXJhbTsNCisJd210
X3BhcmFtcy5zdGF0dXMgPSBOVUxMOw0KKw0KKwllcnIgPSBtdGtfaGNpX3dtdF9zeW5jKGhkZXYs
ICZ3bXRfcGFyYW1zKTsNCisJaWYgKGVyciA8IDApIHsNCisJCWJ0X2Rldl9lcnIoaGRldiwgIkZh
aWxlZCB0byBwb3dlciBvbiBkYXRhIFJBTSAoJWQpIiwgZXJyKTsNCisJCXJldHVybiBlcnI7DQor
CX0NCisNCiAJZndfcHRyID0gZnctPmRhdGE7DQogCWZ3X3NpemUgPSBmdy0+c2l6ZTsNCiANCi0t
IA0KMi4yNS4xDQo=

