Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F3BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCC82076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ImSM/DOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgIJIcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:32:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22256 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730386AbgIJIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:34 -0400
X-UUID: 8a453c210c5846adb62cae5a4badafcf-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=n+pceR4RMgmAMEAt4bZLKvLzwP+bC0iCUPc31NQ9+9s=;
        b=ImSM/DOG0HuougE7y2Iw0kLbkvBSDrLp0w3PiAWAaJoHLFYJOcHJ9+IM8EzFtOp6xq9o21XQhgXgfW4Fyq5DyuKYFcf4ugNrigbKdeBMBPhMJXnm030ui//nkStYY/dgz8udDldPiuCDwDK6Y0EFQ3jN2tnBXmrhkVP6oAUm1wQ=;
X-UUID: 8a453c210c5846adb62cae5a4badafcf-20200910
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1609855164; Thu, 10 Sep 2020 16:23:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:23:58 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:23:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH RESEND v3 01/11] usb: early: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:42 +0800
Message-ID: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3CEDF1C9E1989338AB07B01DC590B9649CEE54B7EB8B0190A82F837BF91D34932000:8
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

