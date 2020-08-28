Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7313220825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZNdyNElr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgH1FlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:41:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30136 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727051AbgH1FlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:41:05 -0400
X-UUID: fcf9e7709a3948b2b5b0060f9f91ca3a-20200828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iXto2y2wqv9kDE8ePfeBHaSsPNfu5Li6KjEDRiU/flg=;
        b=ZNdyNElr6xzksfrcZShtbM5XAYNCHPZ0zjqI9WpkB8CqwjlSNEolP+gDE9Xw1vwaziYF7folmloWq93Nlyce+xOTmi5v86D89dla9PgpcEytX2NCugzWYDxE2Tm67hk8aWPxybCOwXJZgTU5vA6uoegSda51qTHMg68lqLs+v+8=;
X-UUID: fcf9e7709a3948b2b5b0060f9f91ca3a-20200828
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1292017797; Fri, 28 Aug 2020 13:41:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Aug 2020 13:40:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Aug 2020 13:41:00 +0800
From:   Freddy Hsin <freddy.hsin@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Saravana Kannan <saravanak@google.com>,
        <chang-an.chen@mediatek.com>, Baolin Wang <baolin.wang7@gmail.com>,
        <wsd_upstream@mediatek.com>, <kuohong.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, Freddy Hsin <freddy.hsin@mediatek.com>
Subject: [PATCH v1 1/1] timer: mt6873: remove COMPILE_TEST condition for MTK timer
Date:   Fri, 28 Aug 2020 13:40:56 +0800
Message-ID: <1598593256-6719-2-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1598593256-6719-1-git-send-email-freddy.hsin@mediatek.com>
References: <1598593256-6719-1-git-send-email-freddy.hsin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVRLIHRpbWVyIGRyaXZlciBjYW4gd29yayBvbiBNVEsgcGxhdGZvcm0gbm9ybWFsbHksIHNvIHJl
bW92ZQ0KdGhlIHJlZHVuZGFudCBjb25kaXRpb24gZm9yIE1US19USU1FUg0KDQpTaWduZWQtb2Zm
LWJ5OiBGcmVkZHkgSHNpbiA8ZnJlZGR5LmhzaW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9jbG9ja3NvdXJjZS9LY29uZmlnIHwgICAgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJj
ZS9LY29uZmlnIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnDQppbmRleCA5MTQxODM4Li4x
ZWM1ZDk0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnDQorKysgYi9k
cml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcNCkBAIC00NzIsNyArNDcyLDcgQEAgY29uZmlnIFNZ
U19TVVBQT1JUU19TSF9DTVQNCiAJYm9vbA0KIA0KIGNvbmZpZyBNVEtfVElNRVINCi0JYm9vbCAi
TWVkaWF0ZWsgdGltZXIgZHJpdmVyIiBpZiBDT01QSUxFX1RFU1QNCisJYm9vbCAiTWVkaWF0ZWsg
dGltZXIgZHJpdmVyIg0KIAlkZXBlbmRzIG9uIEhBU19JT01FTQ0KIAlzZWxlY3QgVElNRVJfT0YN
CiAJc2VsZWN0IENMS1NSQ19NTUlPDQotLSANCjEuNy45LjUNCg==

