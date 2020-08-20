Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF0CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1CA20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CmjQhUgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHTFrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:40 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:50343 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726867AbgHTFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:31 -0400
X-UUID: 5e126d961bd742daa778001d3e6d9bad-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5gFAciF6+KEY7dJjqp1IMdzJnWb/5lXTm4tMKH4rq6Y=;
        b=CmjQhUgL2VBxftDXlKgAIdTPp2m0rHC53nToqz6Tmc3Nib4WYIxjZtBRyeEADArLAJXDkSa4YJkRbWn6xKvCUQYpv8N4+r1TVGIiptZyBCDW1qlKeGvpKeRVzqW6L9rDAXtjBSqiHa3Yz4ey5l8xzURYinL9ve2GOoFLHSZMxPY=;
X-UUID: 5e126d961bd742daa778001d3e6d9bad-20200820
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 959376651; Thu, 20 Aug 2020 13:47:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:18 +0800
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
Subject: [PATCH v2 10/11] usb: udc: net2280: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:48 +0800
Message-ID: <1597902349-8998-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1AFE4B6A20DAF01A9B43BF0F84F116481CA1E4D92096B78CB884D2EFB6C51D732000:8
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
cnZhcmQuZWR1Pg0KLS0tDQp2MjogYWRkIEFja2VkLWJ5IEFsYW4NCi0tLQ0KIGRyaXZlcnMvdXNi
L2dhZGdldC91ZGMvbmV0MjI4MC5jIHwgMjEgKysrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjgwLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL25ldDIyODAuYw0KaW5kZXggNzUzMGJkOS4uZjFhMjFmNCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L25ldDIyODAuYw0KQEAgLTUyLDYgKzUyLDcgQEANCiAjaW5jbHVkZSA8bGludXgvdXNiL2dhZGdl
dC5oPg0KICNpbmNsdWRlIDxsaW51eC9wcmVmZXRjaC5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5o
Pg0KKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiANCiAjaW5jbHVkZSA8YXNtL2J5dGVvcmRl
ci5oPg0KICNpbmNsdWRlIDxhc20vaXJxLmg+DQpAQCAtMzYwLDE4ICszNjEsMTYgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGVuYWJsZV9wY2lpcnFlbmIoc3RydWN0IG5ldDIyODBfZXAgKmVwKQ0KIHN0
YXRpYyBpbnQgaGFuZHNoYWtlKHUzMiBfX2lvbWVtICpwdHIsIHUzMiBtYXNrLCB1MzIgZG9uZSwg
aW50IHVzZWMpDQogew0KIAl1MzIJcmVzdWx0Ow0KKwlpbnQJcmV0Ow0KIA0KLQlkbyB7DQotCQly
ZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJaWYgKHJlc3VsdCA9PSB+KHUzMikwKQkJLyogImRldmlj
ZSB1bnBsdWdnZWQiICovDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCQlyZXN1bHQgJj0gbWFzazsN
Ci0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsNCi0JCXVkZWxheSgxKTsNCi0J
CXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJ
cmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSgocmVz
dWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3VsdCA9PSBVMzJfTUFYKSwNCisJCQkJ
CTEsIHVzZWMpOw0KKwlpZiAocmVzdWx0ID09IFUzMl9NQVgpCQkvKiBkZXZpY2UgdW5wbHVnZ2Vk
ICovDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCB1c2JfZXBfb3BzIG5ldDIyODBfZXBfb3BzOw0KLS0gDQoxLjkuMQ0K

