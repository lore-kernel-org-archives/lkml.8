Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D32C21532
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rTYqOdTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgFRHRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:17:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60927 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbgFRHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:17:17 -0400
X-UUID: e8455561c44641ffb33f1fde6f3d70d3-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aDN+iiFlgb/HTwHnI1GgrUUk9EOWb7fnkVZpVNjf0yw=;
        b=rTYqOdTbz9Vb4gOIc7omEyOWE5VLJ1HjwntjUdSH6YTsuxcYpE0GGVDE2fbpbX0+vdV14YBdtgUkvIKCr2mpVV1VJXidoJdKHE58TE8K/hti3E5h81l9IjHlSlJfsPpW/5tf1nhfe5ZUYcpqNYHRaNm+IMiY3mbyIBDMa5DfOcY=;
X-UUID: e8455561c44641ffb33f1fde6f3d70d3-20200618
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 454420887; Thu, 18 Jun 2020 15:17:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 15:17:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 15:17:08 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Subject: [PATCH 2/2] Bluetooth: btmtksdio: fix up firmware download sequence
Date:   Thu, 18 Jun 2020 15:17:07 +0800
Message-ID: <51dda3f7e6e3a01b20145c5e879e837cec78b7da.1592463595.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c9bf7346a060d8913b670bbed7ed9e60b592e16f.1592463595.git.sean.wang@mediatek.com>
References: <c9bf7346a060d8913b670bbed7ed9e60b592e16f.1592463595.git.sean.wang@mediatek.com>
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
YWQNCnRoZSBmaXJtd2FyZS4NCg0KRml4ZXM6IDlhZWJmZDRhMjIwMCAoIkJsdWV0b290aDogbWVk
aWF0ZWs6IGFkZCBzdXBwb3J0IGZvciBNZWRpYVRlayBNVDc2NjNTIGFuZCBNVDc2NjhTIFNESU8g
ZGV2aWNlcyIpDQpDby1kZXZlbG9wZWQtYnk6IE1hcmsgQ2hlbiA8TWFyay1ZVy5DaGVuQG1lZGlh
dGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hcmsgQ2hlbiA8TWFyay1ZVy5DaGVuQG1lZGlhdGVr
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrc2Rpby5jIHwgMTYgKysrKysrKysrKysrKysr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10a3NkaW8uYyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0bXRrc2Rpby5jDQppbmRleCA1MTk3ODhjNDQyY2EuLjExNDk0Y2QyYTk4MiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrc2Rpby5jDQorKysgYi9kcml2ZXJzL2JsdWV0
b290aC9idG10a3NkaW8uYw0KQEAgLTY4NSw3ICs2ODUsNyBAQCBzdGF0aWMgaW50IG10a19zZXR1
cF9maXJtd2FyZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgY29uc3QgY2hhciAqZnduYW1lKQ0KIAlj
b25zdCB1OCAqZndfcHRyOw0KIAlzaXplX3QgZndfc2l6ZTsNCiAJaW50IGVyciwgZGxlbjsNCi0J
dTggZmxhZzsNCisJdTggZmxhZywgcGFyYW07DQogDQogCWVyciA9IHJlcXVlc3RfZmlybXdhcmUo
JmZ3LCBmd25hbWUsICZoZGV2LT5kZXYpOw0KIAlpZiAoZXJyIDwgMCkgew0KQEAgLTY5Myw2ICs2
OTMsMjAgQEAgc3RhdGljIGludCBtdGtfc2V0dXBfZmlybXdhcmUoc3RydWN0IGhjaV9kZXYgKmhk
ZXYsIGNvbnN0IGNoYXIgKmZ3bmFtZSkNCiAJCXJldHVybiBlcnI7DQogCX0NCiANCisJLyogUG93
ZXIgb24gZGF0YSBSQU0gdGhlIGZpcm13YXJlIHJlbGllcyBvbi4gKi8NCisJcGFyYW0gPSAxOw0K
Kwl3bXRfcGFyYW1zLm9wID0gTVRLX1dNVF9GVU5DX0NUUkw7DQorCXdtdF9wYXJhbXMuZmxhZyA9
IDM7DQorCXdtdF9wYXJhbXMuZGxlbiA9IHNpemVvZihwYXJhbSk7DQorCXdtdF9wYXJhbXMuZGF0
YSA9ICZwYXJhbTsNCisJd210X3BhcmFtcy5zdGF0dXMgPSBOVUxMOw0KKw0KKwllcnIgPSBtdGtf
aGNpX3dtdF9zeW5jKGhkZXYsICZ3bXRfcGFyYW1zKTsNCisJaWYgKGVyciA8IDApIHsNCisJCWJ0
X2Rldl9lcnIoaGRldiwgIkZhaWxlZCB0byBwb3dlciBvbiBkYXRhIFJBTSAoJWQpIiwgZXJyKTsN
CisJCXJldHVybiBlcnI7DQorCX0NCisNCiAJZndfcHRyID0gZnctPmRhdGE7DQogCWZ3X3NpemUg
PSBmdy0+c2l6ZTsNCiANCi0tIA0KMi4yNS4xDQo=

