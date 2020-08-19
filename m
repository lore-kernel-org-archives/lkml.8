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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F8FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23221206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KIsy7nfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgHSMmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:42:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22437 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727944AbgHSMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:42:52 -0400
X-UUID: 1e87b10db66649368522f6d0f9fe8a57-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+3z+T7GeyoHeHwhU3UCJLeddq0B7PomhVS6LM+oEBwA=;
        b=KIsy7nfMKkpkQgA/qcgtoxI4fmbl1kJLdsqYq9+YInT6PLqSXvxmOSQNgjUOZj39vB94nLDK10G1l89srJH8f64XSki9VUxfbiV5QxrTmedLU+7uBPca/ujyQMOizIUWulXLlCe0IQilOmCLX/j/LSBtB1/BzjudJLRPtvvpQ4k=;
X-UUID: 1e87b10db66649368522f6d0f9fe8a57-20200819
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 221041000; Wed, 19 Aug 2020 20:42:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:42 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 01/10] usb: early: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:40:56 +0800
Message-ID: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 11A0FBB927ECEBA7F7FD5B2A90D46DA3FD7D363E0C47726682BD5434B97E97B02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KQ2M6IE1hdGhpYXMgTnltYW4gPG1h
dGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvZWFybHkveGhj
aS1kYmMuYyB8IDE0ICsrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9lYXJseS94
aGNpLWRiYy5jIGIvZHJpdmVycy91c2IvZWFybHkveGhjaS1kYmMuYw0KaW5kZXggYzA1MDc3Ni4u
YmU0ZWNiYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2Vhcmx5L3hoY2ktZGJjLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2Vhcmx5L3hoY2ktZGJjLmMNCkBAIC0xNCw2ICsxNCw3IEBADQogI2luY2x1
ZGUgPGxpbnV4L3BjaV9pZHMuaD4NCiAjaW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4NCiAjaW5j
bHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQogI2luY2x1ZGUg
PGFzbS9wY2ktZGlyZWN0Lmg+DQogI2luY2x1ZGUgPGFzbS9maXhtYXAuaD4NCiAjaW5jbHVkZSA8
bGludXgvYmNkLmg+DQpAQCAtMTM1LDE2ICsxMzYsOSBAQCBzdGF0aWMgaW50IGhhbmRzaGFrZSh2
b2lkIF9faW9tZW0gKnB0ciwgdTMyIG1hc2ssIHUzMiBkb25lLCBpbnQgd2FpdCwgaW50IGRlbGF5
KQ0KIHsNCiAJdTMyIHJlc3VsdDsNCiANCi0JZG8gew0KLQkJcmVzdWx0ID0gcmVhZGwocHRyKTsN
Ci0JCXJlc3VsdCAmPSBtYXNrOw0KLQkJaWYgKHJlc3VsdCA9PSBkb25lKQ0KLQkJCXJldHVybiAw
Ow0KLQkJdWRlbGF5KGRlbGF5KTsNCi0JCXdhaXQgLT0gZGVsYXk7DQotCX0gd2hpbGUgKHdhaXQg
PiAwKTsNCi0NCi0JcmV0dXJuIC1FVElNRURPVVQ7DQorCXJldHVybiByZWFkbF9wb2xsX3RpbWVv
dXRfYXRvbWljKHB0ciwgcmVzdWx0LA0KKwkJCQkJICgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSks
DQorCQkJCQkgZGVsYXksIHdhaXQpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBfX2luaXQgeGRiY19i
aW9zX2hhbmRvZmYodm9pZCkNCi0tIA0KMS45LjENCg==

