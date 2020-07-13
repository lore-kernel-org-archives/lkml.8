Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EE8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42532206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F39RfS2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgGMDbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:31:16 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25052 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726261AbgGMDbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:31:16 -0400
X-UUID: 202c5ae90e964ac088e2b85650f63f05-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JuW3jP9J1lIS5V8IiLWPSVxE4HCb/Oj2hKarwYDEQFg=;
        b=F39RfS2lfJlj5/DOJsZj+DHVxj3HTSsLROaSSuBi7UWZUekcJT4E7Y+irMlgdN6aO0s7OSpVXIt3I0tBG06qyFllSZad8TQgOXiDXOT9ARLQSskcdtYhypuYKYLabLBx1jRAFRhIjsO8+XMQbXe2MJEkBZWXBeCp2I0nAysh+yg=;
X-UUID: 202c5ae90e964ac088e2b85650f63f05-20200713
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 666783389; Mon, 13 Jul 2020 11:31:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Jul 2020 11:31:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 11:31:09 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v2 PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify code
Date:   Mon, 13 Jul 2020 11:30:17 +0800
Message-ID: <1594611017-4535-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 68E0EF0317ACCA01D29A26B236ED2441F27383EAF5EEF084C4683CE8F0DE3D5E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dCgpIHRvIHBvbGwgcmVnaXN0ZXIgc3RhdHVzDQoNCkNjOiBG
bG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IENo
dW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjIgY2hhbmdlcywg
c3VnZ2VzdGVkIGJ5IFN0ZXBoZW46DQogIDEuIHVzZSB1bnNpZ25lZCBpbnQgaW5zdGVhZCBvZiBp
bnQgZm9yIEB1c2VjIHBhcmFtZXRlcg0KICAyLiBhZGQgZGV2X2xvZygpIGJhY2sNCiAgMy4gZHJv
cCAiRXJyIiBpbiBlcnJvciBsb2cNCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2Jk
Y19jb3JlLmMgfCAyNiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfY29yZS5jDQppbmRleCAwMmEzYTc3Li41M2RjY2IxIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KQEAgLTEyLDYgKzEyLDcgQEANCiAjaW5jbHVkZSA8bGlu
dXgvc3BpbmxvY2suaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiAj
aW5jbHVkZSA8bGludXgvaW9wb3J0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQogI2luY2x1
ZGUgPGxpbnV4L2xpc3QuaD4NCkBAIC0yOSwyNCArMzAsMTkgQEANCiAjaW5jbHVkZSAiYmRjX2Ri
Zy5oIg0KIA0KIC8qIFBvbGwgdGlsbCBjb250cm9sbGVyIHN0YXR1cyBpcyBub3QgT0lQICovDQot
c3RhdGljIGludCBwb2xsX29pcChzdHJ1Y3QgYmRjICpiZGMsIGludCB1c2VjKQ0KK3N0YXRpYyBp
bnQgcG9sbF9vaXAoc3RydWN0IGJkYyAqYmRjLCB1MzIgdXNlYykNCiB7DQogCXUzMiBzdGF0dXM7
DQotCS8qIFBvbGwgdGlsbCBTVFMhPSBPSVAgKi8NCi0Jd2hpbGUgKHVzZWMpIHsNCi0JCXN0YXR1
cyA9IGJkY19yZWFkbChiZGMtPnJlZ3MsIEJEQ19CRENTQyk7DQotCQlpZiAoQkRDX0NTVFMoc3Rh
dHVzKSAhPSBCRENfT0lQKSB7DQotCQkJZGV2X2RiZyhiZGMtPmRldiwNCi0JCQkJInBvbGxfb2lw
IGNvbXBsZXRlIHN0YXR1cz0lZCIsDQotCQkJCUJEQ19DU1RTKHN0YXR1cykpOw0KLQkJCXJldHVy
biAwOw0KLQkJfQ0KLQkJdWRlbGF5KDEwKTsNCi0JCXVzZWMgLT0gMTA7DQotCX0NCi0JZGV2X2Vy
cihiZGMtPmRldiwgIkVycjogb3BlcmF0aW9uIHRpbWVkb3V0IEJEQ1NDOiAweCUwOHhcbiIsIHN0
YXR1cyk7DQorCWludCByZXQ7DQogDQotCXJldHVybiAtRVRJTUVET1VUOw0KKwlyZXQgPSByZWFk
bF9wb2xsX3RpbWVvdXQoYmRjLT5yZWdzICsgQkRDX0JEQ1NDLCBzdGF0dXMsDQorCQkoQkRDX0NT
VFMoc3RhdHVzKSAhPSBCRENfT0lQKSwgMTAsIHVzZWMpOw0KKwlpZiAocmV0KQ0KKwkJZGV2X2Vy
cihiZGMtPmRldiwgIm9wZXJhdGlvbiB0aW1lZG91dCBCRENTQzogMHglMDh4XG4iLCBzdGF0dXMp
Ow0KKwllbHNlDQorCQlkZXZfZGJnKGJkYy0+ZGV2LCAiJXMgY29tcGxldGUgc3RhdHVzPSVkIiwg
X19mdW5jX18sIEJEQ19DU1RTKHN0YXR1cykpOw0KKw0KKwlyZXR1cm4gcmV0Ow0KIH0NCiANCiAv
KiBTdG9wIHRoZSBCREMgY29udHJvbGxlciAqLw0KLS0gDQoxLjkuMQ0K

