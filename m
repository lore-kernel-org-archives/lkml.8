Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE9C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F2207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TNA6tUof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBSCId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:08:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39079 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727872AbgBSCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:08:32 -0500
X-UUID: c1bc2e3e265b484a86280060ac9c3944-20200219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1qzoJ6EEatPElYiOsXSiqLR5375SqMzBtOAuZFX/AiM=;
        b=TNA6tUofyYcQArXX4MKw0nqvFHDizn8J8XAFUqbi8y1KEeO1o5SZC0BD80UBKZfXArUWX3fU73sNUPQVcI/Sy7iKUDQZOA7hnrTn7jX3uUJLBlGBEZ8VNvulYk+IFvznd0uy2/Ezgv8x7K+jA82Ogk7w0SaOxJhS6HH8c5S6Vy4=;
X-UUID: c1bc2e3e265b484a86280060ac9c3944-20200219
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 838099783; Wed, 19 Feb 2020 10:08:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Feb 2020 10:05:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Feb 2020 10:07:52 +0800
From:   <light.hsieh@mediatek.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sean.wang@kernel.org>,
        <kuohong.wang@mediatek.com>, Light Hsieh <light.hsieh@mediatek.com>
Subject: [PATCH v2 2/2] pinctrl: make MediaTek MT6765 pinctrl ready for buidling loadable module
Date:   Wed, 19 Feb 2020 10:08:22 +0800
Message-ID: <1582078102-26332-2-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1582078102-26332-1-git-send-email-light.hsieh@mediatek.com>
References: <1582078102-26332-1-git-send-email-light.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5F8F33AF66A46C291F16CEF9770660E849AC8E6E373F8FB78901EB26DDD278DC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlnaHQgSHNpZWggPGxpZ2h0LmhzaWVoQG1lZGlhdGVrLmNvbT4NCg0KVGhpcyBwYXRj
aCBtYWtlIHBpbmN0cmwtbXQ2NzY1IHJlYWR5IGZvciBidWlsZGluZyBhcyBsb2FkYWJsZSBtb2R1
bGUuDQoNClNpZ25lZC1vZmYtYnk6IExpZ2h0IEhzaWVoIDxsaWdodC5oc2llaEBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICB8IDIg
Ky0NCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NjUuYyB8IDQgKysrKw0K
IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZlcnMvcGluY3Ry
bC9tZWRpYXRlay9LY29uZmlnDQppbmRleCA0Y2QxMTA5Li5jNjQ1ZmRiIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL0tjb25maWcNCisrKyBiL2RyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9LY29uZmlnDQpAQCAtODksNyArODksNyBAQCBjb25maWcgUElOQ1RSTF9NVDI3MTIN
CiAJc2VsZWN0IFBJTkNUUkxfTVRLDQogDQogY29uZmlnIFBJTkNUUkxfTVQ2NzY1DQotCWJvb2wg
Ik1lZGlhdGVrIE1UNjc2NSBwaW4gY29udHJvbCINCisJdHJpc3RhdGUgIk1lZGlhdGVrIE1UNjc2
NSBwaW4gY29udHJvbCINCiAJZGVwZW5kcyBvbiBPRg0KIAlkZXBlbmRzIG9uIEFSTTY0IHx8IENP
TVBJTEVfVEVTVA0KIAlkZWZhdWx0IEFSTTY0ICYmIEFSQ0hfTUVESUFURUsNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NjUuYyBiL2RyaXZlcnMvcGlu
Y3RybC9tZWRpYXRlay9waW5jdHJsLW10Njc2NS5jDQppbmRleCA5MDVkYWU4Yy4uMmM1OWQzOSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10Njc2NS5jDQor
KysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NjUuYw0KQEAgLTYsNiAr
Niw3IEBADQogICoNCiAgKi8NCiANCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2luY2x1
ZGUgInBpbmN0cmwtbXRrLW10Njc2NS5oIg0KICNpbmNsdWRlICJwaW5jdHJsLXBhcmlzLmgiDQog
DQpAQCAtMTEwMywzICsxMTA0LDYgQEAgc3RhdGljIGludCBfX2luaXQgbXQ2NzY1X3BpbmN0cmxf
aW5pdCh2b2lkKQ0KIAlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZtdDY3NjVfcGlu
Y3RybF9kcml2ZXIpOw0KIH0NCiBhcmNoX2luaXRjYWxsKG10Njc2NV9waW5jdHJsX2luaXQpOw0K
Kw0KK01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCitNT0RVTEVfREVTQ1JJUFRJT04oIk1lZGlh
VGVrIE1UNjc2NSBQaW5jdHJsIERyaXZlciIpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

