Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE90B206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BdbnORcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgHSMoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:44:09 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:60353 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728290AbgHSMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:43:03 -0400
X-UUID: 7ce18b06918c40bc94240a3df908dba3-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Dpta4H1SRQk7Li++WBp2aI6qhPf7vOedFdtzx5lB+FM=;
        b=BdbnORcN+z0BJUp0H5lM60jMuurtL4cB15OO/QYJ12tJhKS9/6FznXN2GGk3eSF3XIDtkJj3kFFUXRHxKqu5i9N4ANiSlXvwgB5Q73pHMFPehfMyc+iWU8lXpYbNWjNrZ7NCSqEpMHrCbh4WoI6p+2fIsbij+Thh2RL9zM+zO+w=;
X-UUID: 7ce18b06918c40bc94240a3df908dba3-20200819
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1470467389; Wed, 19 Aug 2020 20:42:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:52 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 10/10] usb: udc: net2280: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:41:05 +0800
Message-ID: <1597840865-26631-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E0EC442A6D048C3678D031DC199AB4D56B601BF5917F13DC48DE34E7762CD3F22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBB
bGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KQ2M6IEZlbGlwZSBCYWxiaSA8
YmFsYmlAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcu
eXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5j
IHwgMjEgKysrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9uZXQyMjgwLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KaW5kZXgg
NzUzMGJkOS4uZjFhMjFmNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0
MjI4MC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KQEAgLTUyLDYg
KzUyLDcgQEANCiAjaW5jbHVkZSA8bGludXgvdXNiL2dhZGdldC5oPg0KICNpbmNsdWRlIDxsaW51
eC9wcmVmZXRjaC5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9p
b3BvbGwuaD4NCiANCiAjaW5jbHVkZSA8YXNtL2J5dGVvcmRlci5oPg0KICNpbmNsdWRlIDxhc20v
aXJxLmg+DQpAQCAtMzYwLDE4ICszNjEsMTYgQEAgc3RhdGljIGlubGluZSB2b2lkIGVuYWJsZV9w
Y2lpcnFlbmIoc3RydWN0IG5ldDIyODBfZXAgKmVwKQ0KIHN0YXRpYyBpbnQgaGFuZHNoYWtlKHUz
MiBfX2lvbWVtICpwdHIsIHUzMiBtYXNrLCB1MzIgZG9uZSwgaW50IHVzZWMpDQogew0KIAl1MzIJ
cmVzdWx0Ow0KKwlpbnQJcmV0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0K
LQkJaWYgKHJlc3VsdCA9PSB+KHUzMikwKQkJLyogImRldmljZSB1bnBsdWdnZWQiICovDQotCQkJ
cmV0dXJuIC1FTk9ERVY7DQotCQlyZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9u
ZSkNCi0JCQlyZXR1cm4gMDsNCi0JCXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAo
dXNlYyA+IDApOw0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1l
b3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8
fA0KKwkJCQkJIHJlc3VsdCA9PSBVMzJfTUFYKSwNCisJCQkJCTEsIHVzZWMpOw0KKwlpZiAocmVz
dWx0ID09IFUzMl9NQVgpCQkvKiBkZXZpY2UgdW5wbHVnZ2VkICovDQorCQlyZXR1cm4gLUVOT0RF
VjsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZXBf
b3BzIG5ldDIyODBfZXBfb3BzOw0KLS0gDQoxLjkuMQ0K

