Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3E921734
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pGZ5+7hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgHVIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:09:43 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60731 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727125AbgHVIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:30 -0400
X-UUID: ad0ccc16cb6e49d38e56d6dee58c6482-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LsbK3aFahnUwEjBrSyDBs20PI2uINsZC3CgcxYtUvus=;
        b=pGZ5+7hCH5z8nTSxm/gBczHnE6thvtTTSG2DSToZybPP15dRl59uT/6u6DvHIAeEB6To9oFsiCQiBA07CxOhPyiJ0zZxvqGw8j14I7R8BTLgUL0HsqBeNBMsBWuFvPyBzPfeWdCHW6pFaSQwB7An5R73Rr8Be3k0Ssotky2u4sM=;
X-UUID: ad0ccc16cb6e49d38e56d6dee58c6482-20200822
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1793161018; Sat, 22 Aug 2020 16:09:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:16 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 10/11] usb: udc: net2280: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:52 +0800
Message-ID: <1598083553-31896-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EBA55633475A74F5350E24D54A47F2D17B9DBC34C97AF2348851A60721F9E9F72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBB
bGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KQ2M6IEZlbGlwZSBCYWxiaSA8
YmFsYmlAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcu
eXVuQG1lZGlhdGVrLmNvbT4NCkFja2VkLWJ5OiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhh
cnZhcmQuZWR1Pg0KLS0tDQp2Mzogbm8gY2hhbmdlcw0KDQp2MjogYWRkIEFja2VkLWJ5IEFsYW4N
Ci0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5jIHwgMjEgKysrKysrKysrKy0t
LS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjgwLmMgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KaW5kZXggNzUzMGJkOS4uZjFhMjFmNCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5jDQorKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KQEAgLTUyLDYgKzUyLDcgQEANCiAjaW5jbHVk
ZSA8bGludXgvdXNiL2dhZGdldC5oPg0KICNpbmNsdWRlIDxsaW51eC9wcmVmZXRjaC5oPg0KICNp
bmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiANCiAjaW5j
bHVkZSA8YXNtL2J5dGVvcmRlci5oPg0KICNpbmNsdWRlIDxhc20vaXJxLmg+DQpAQCAtMzYwLDE4
ICszNjEsMTYgQEAgc3RhdGljIGlubGluZSB2b2lkIGVuYWJsZV9wY2lpcnFlbmIoc3RydWN0IG5l
dDIyODBfZXAgKmVwKQ0KIHN0YXRpYyBpbnQgaGFuZHNoYWtlKHUzMiBfX2lvbWVtICpwdHIsIHUz
MiBtYXNrLCB1MzIgZG9uZSwgaW50IHVzZWMpDQogew0KIAl1MzIJcmVzdWx0Ow0KKwlpbnQJcmV0
Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJaWYgKHJlc3VsdCA9PSB+
KHUzMikwKQkJLyogImRldmljZSB1bnBsdWdnZWQiICovDQotCQkJcmV0dXJuIC1FTk9ERVY7DQot
CQlyZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsN
Ci0JCXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1
cm4gLUVUSU1FRE9VVDsNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhwdHIsIHJl
c3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3VsdCA9
PSBVMzJfTUFYKSwNCisJCQkJCTEsIHVzZWMpOw0KKwlpZiAocmVzdWx0ID09IFUzMl9NQVgpCQkv
KiBkZXZpY2UgdW5wbHVnZ2VkICovDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcmV0dXJuIHJl
dDsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZXBfb3BzIG5ldDIyODBfZXBfb3Bz
Ow0KLS0gDQoxLjkuMQ0K

