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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7468620724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VpxL9iYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHTFrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:31 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19665 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726741AbgHTFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:24 -0400
X-UUID: b7af6cac8c08447cbdc646d38bb552b2-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5sSpZZcpQp5FJBj/SDQBR6BT8ozF7J0Kcnq2Pn400hc=;
        b=VpxL9iYMRunqKI0VfBNVDKL7WbKPCmo04A7tJmVgl4gmvioyAhDBcLVem83VMcocIDwBfOH4VY8F4DhPK0s10kMKv+c7YMw6GRiMwFzSwkKRUnf7c7OS7mWm6mj8WmrEgLtkPuz1+lnfXK+DvQqe4vA5jtyqKNzTIJzYkgiX2eY=;
X-UUID: b7af6cac8c08447cbdc646d38bb552b2-20200820
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 879988992; Thu, 20 Aug 2020 13:47:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:12 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 05/11] usb: oxu210hp-hcd: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:43 +0800
Message-ID: <1597902349-8998-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ADA5C27A1C9997E08369B6D6F031D0C2CA451BD6E5946D2FA33777F126C20AEC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMgfCAy
MSArKysrKysrKysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L294dTIx
MGhwLWhjZC5jIGIvZHJpdmVycy91c2IvaG9zdC9veHUyMTBocC1oY2QuYw0KaW5kZXggY2ZhN2Rk
Mi4uMjdkYmJlMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMN
CisrKyBiL2RyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMNCkBAIC0yNCw2ICsyNCw3IEBA
DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZXBhcmFtLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RtYS1t
YXBwaW5nLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9s
bC5oPg0KIA0KICNpbmNsdWRlIDxhc20vaXJxLmg+DQogI2luY2x1ZGUgPGFzbS91bmFsaWduZWQu
aD4NCkBAIC03NDgsMTggKzc0OSwxNiBAQCBzdGF0aWMgaW50IGhhbmRzaGFrZShzdHJ1Y3Qgb3h1
X2hjZCAqb3h1LCB2b2lkIF9faW9tZW0gKnB0ciwNCiAJCQkJCXUzMiBtYXNrLCB1MzIgZG9uZSwg
aW50IHVzZWMpDQogew0KIAl1MzIgcmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQotCQly
ZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJaWYgKHJlc3VsdCA9PSB+KHUzMikwKQkJLyogY2FyZCBy
ZW1vdmVkICovDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCQlyZXN1bHQgJj0gbWFzazsNCi0JCWlm
IChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsNCi0JCXVkZWxheSgxKTsNCi0JCXVzZWMt
LTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0ID0g
cmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYg
bWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3VsdCA9PSBVMzJfTUFYKSwNCisJCQkJCTEsIHVz
ZWMpOw0KKwlpZiAocmVzdWx0ID09IFUzMl9NQVgpCQkvKiBjYXJkIHJlbW92ZWQgKi8NCisJCXJl
dHVybiAtRU5PREVWOw0KKw0KKwlyZXR1cm4gcmV0Ow0KIH0NCiANCiAvKiBGb3JjZSBIQyB0byBo
YWx0IHN0YXRlIGZyb20gdW5rbm93biAoRUhDSSBzcGVjIHNlY3Rpb24gMi4zKSAqLw0KLS0gDQox
LjkuMQ0K

