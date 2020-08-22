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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190AF208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S/2maIyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHVIJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:09:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56568 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgHVIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:19 -0400
X-UUID: ed0cf974d34d4e93b42088219df8827d-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=n+pceR4RMgmAMEAt4bZLKvLzwP+bC0iCUPc31NQ9+9s=;
        b=S/2maIyluc5PF34fxaYVNsAJU4CK0sKgXLva0awErLbQQ1xkEU3eHDD+OfddueX9+0bjdErx3vZGt5sBrlKqyEmVQwZV5XMj/72BxrKL6jI4UxVUFe+Blz+L21RY4rMKWLifWb1VUcfq2j4iK45LHY+Xyr3BmoPIiGT7LYlvNys=;
X-UUID: ed0cf974d34d4e93b42088219df8827d-20200822
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1461500314; Sat, 22 Aug 2020 16:09:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:05 +0800
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v3 01/11] usb: early: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:43 +0800
Message-ID: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 710DD285F53E49DF8C43FE47D5677618B03991FFAEE3B920486DC39D6992D9992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KQ2M6IE1hdGhpYXMgTnltYW4gPG1h
dGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52Mzogbm8gY2hhbmdlcw0KLS0t
DQogZHJpdmVycy91c2IvZWFybHkveGhjaS1kYmMuYyB8IDE0ICsrKystLS0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9lYXJseS94aGNpLWRiYy5jIGIvZHJpdmVycy91c2IvZWFybHkveGhj
aS1kYmMuYw0KaW5kZXggYzA1MDc3Ni4uYmU0ZWNiYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNi
L2Vhcmx5L3hoY2ktZGJjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2Vhcmx5L3hoY2ktZGJjLmMNCkBA
IC0xNCw2ICsxNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3BjaV9pZHMuaD4NCiAjaW5jbHVkZSA8
bGludXgvbWVtYmxvY2suaD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGlu
dXgvaW9wb2xsLmg+DQogI2luY2x1ZGUgPGFzbS9wY2ktZGlyZWN0Lmg+DQogI2luY2x1ZGUgPGFz
bS9maXhtYXAuaD4NCiAjaW5jbHVkZSA8bGludXgvYmNkLmg+DQpAQCAtMTM1LDE2ICsxMzYsOSBA
QCBzdGF0aWMgaW50IGhhbmRzaGFrZSh2b2lkIF9faW9tZW0gKnB0ciwgdTMyIG1hc2ssIHUzMiBk
b25lLCBpbnQgd2FpdCwgaW50IGRlbGF5KQ0KIHsNCiAJdTMyIHJlc3VsdDsNCiANCi0JZG8gew0K
LQkJcmVzdWx0ID0gcmVhZGwocHRyKTsNCi0JCXJlc3VsdCAmPSBtYXNrOw0KLQkJaWYgKHJlc3Vs
dCA9PSBkb25lKQ0KLQkJCXJldHVybiAwOw0KLQkJdWRlbGF5KGRlbGF5KTsNCi0JCXdhaXQgLT0g
ZGVsYXk7DQotCX0gd2hpbGUgKHdhaXQgPiAwKTsNCi0NCi0JcmV0dXJuIC1FVElNRURPVVQ7DQor
CXJldHVybiByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHB0ciwgcmVzdWx0LA0KKwkJCQkJICgo
cmVzdWx0ICYgbWFzaykgPT0gZG9uZSksDQorCQkJCQkgZGVsYXksIHdhaXQpOw0KIH0NCiANCiBz
dGF0aWMgdm9pZCBfX2luaXQgeGRiY19iaW9zX2hhbmRvZmYodm9pZCkNCi0tIA0KMS45LjENCg==

