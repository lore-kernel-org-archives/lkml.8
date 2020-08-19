Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E6CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7043B2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N2XXvi99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgHSMp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:45:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:49518 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728246AbgHSMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:43:01 -0400
X-UUID: b1be98bf7dc9460aa572877c724c675e-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eKEone2/VvA8KcScfMxNPAUaYGhubW0D8Rj8rrilwBA=;
        b=N2XXvi99Hs5gbNj56kFZO8y/IBYFWD0IPEwVcllVkM1Qc6KYL4ozXEIEzek1C0tJVtRTgybEJiH3ZHUJxwJVmZ9cu2sFLgRJQQ4ia4Q0M52Ebat9EAonzAgIfeBomdAzM1CGhnaS3gKqL+Krz8tiZiVcYIfQXe8MEQv8Buvh6Jg=;
X-UUID: b1be98bf7dc9460aa572877c724c675e-20200819
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1738367434; Wed, 19 Aug 2020 20:42:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:46 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/10] usb: oxu210hp-hcd: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:41:00 +0800
Message-ID: <1597840865-26631-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9693D66562738BA9832D0AB5A04BE9CC0503C283B8C76DF2B82558CAC208F5212000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMgfCAyMSArKysrKysrKysrLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L294dTIxMGhwLWhjZC5jIGIvZHJpdmVycy91
c2IvaG9zdC9veHUyMTBocC1oY2QuYw0KaW5kZXggY2ZhN2RkMi4uMjdkYmJlMSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hv
c3Qvb3h1MjEwaHAtaGNkLmMNCkBAIC0yNCw2ICsyNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZXBhcmFtLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQogI2luY2x1ZGUg
PGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KIA0KICNpbmNsdWRlIDxh
c20vaXJxLmg+DQogI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCkBAIC03NDgsMTggKzc0OSwx
NiBAQCBzdGF0aWMgaW50IGhhbmRzaGFrZShzdHJ1Y3Qgb3h1X2hjZCAqb3h1LCB2b2lkIF9faW9t
ZW0gKnB0ciwNCiAJCQkJCXUzMiBtYXNrLCB1MzIgZG9uZSwgaW50IHVzZWMpDQogew0KIAl1MzIg
cmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0K
LQkJaWYgKHJlc3VsdCA9PSB+KHUzMikwKQkJLyogY2FyZCByZW1vdmVkICovDQotCQkJcmV0dXJu
IC1FTk9ERVY7DQotCQlyZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0J
CQlyZXR1cm4gMDsNCi0JCXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+
IDApOw0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0
b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJ
CQkJIHJlc3VsdCA9PSBVMzJfTUFYKSwNCisJCQkJCTEsIHVzZWMpOw0KKwlpZiAocmVzdWx0ID09
IFUzMl9NQVgpCQkvKiBjYXJkIHJlbW92ZWQgKi8NCisJCXJldHVybiAtRU5PREVWOw0KKw0KKwly
ZXR1cm4gcmV0Ow0KIH0NCiANCiAvKiBGb3JjZSBIQyB0byBoYWx0IHN0YXRlIGZyb20gdW5rbm93
biAoRUhDSSBzcGVjIHNlY3Rpb24gMi4zKSAqLw0KLS0gDQoxLjkuMQ0K

