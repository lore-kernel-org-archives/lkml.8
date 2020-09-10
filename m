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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57571C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26072076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WUGjKqHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgIJI1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:27:00 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35086 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730415AbgIJIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:37 -0400
X-UUID: 81ce557efefa4b81b14a5bbf3e039ab4-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1f1GqktsmoCBBHY58Mnms9zF6E9zoWUyHkZ1qxBjj5A=;
        b=WUGjKqHF/rU4d0DaafZU4+Eropte60wAguG6gICrKcnl11XoVXNd6ewqk10l/rej3xM5y+d8nhh2MS40GyCKZ5wMkNz2JjGunhxtAEBl8si//z9QN4bYeh5OWD89sCtJfJ578m0ex+R31i1hrcHhA0g40/IPkVhQ+A4ID8Uq/nc=;
X-UUID: 81ce557efefa4b81b14a5bbf3e039ab4-20200910
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 284505523; Thu, 10 Sep 2020 16:24:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:15 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:13 +0800
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
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH RESEND v3 11/11] iopoll: update kerneldoc of read_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:52 +0800
Message-ID: <1599726112-4439-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 678F10287C6AD8F68C030FC275638F71D4820C79F8C8E8D12FB532F6D55A8D832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXJndW1lbnRzIGRlc2NyaXB0aW9uIG9mIHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIGlzIG91
dCBvZiBkYXRlLA0KdXBkYXRlIGl0Lg0KDQpDYzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KdjM6IGZpeCB0eXBvIGluIGNvbW1pdCBtZXNzYWdlIHN1Z2dlc3Rl
ZCBieSBTZXJnZWkNCg0KdjI6IG5ldyBwYXRjaCwgc3VnZ2VzdGVkIGJ5IEFsYW4NCi0tLQ0KIGlu
Y2x1ZGUvbGludXgvaW9wb2xsLmggfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb3Bv
bGwuaCBiL2luY2x1ZGUvbGludXgvaW9wb2xsLmgNCmluZGV4IGJjODlhYzYuLjJjODg2MGUgMTAw
NjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2lvcG9sbC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2lv
cG9sbC5oDQpAQCAtNjAsOCArNjAsNyBAQA0KIC8qKg0KICAqIHJlYWRfcG9sbF90aW1lb3V0X2F0
b21pYyAtIFBlcmlvZGljYWxseSBwb2xsIGFuIGFkZHJlc3MgdW50aWwgYSBjb25kaXRpb24gaXMN
CiAgKiAJCQkJbWV0IG9yIGEgdGltZW91dCBvY2N1cnMNCi0gKiBAb3A6IGFjY2Vzc29yIGZ1bmN0
aW9uICh0YWtlcyBAYWRkciBhcyBpdHMgb25seSBhcmd1bWVudCkNCi0gKiBAYWRkcjogQWRkcmVz
cyB0byBwb2xsDQorICogQG9wOiBhY2Nlc3NvciBmdW5jdGlvbiAodGFrZXMgQGFyZ3MgYXMgaXRz
IGFyZ3VtZW50cykNCiAgKiBAdmFsOiBWYXJpYWJsZSB0byByZWFkIHRoZSB2YWx1ZSBpbnRvDQog
ICogQGNvbmQ6IEJyZWFrIGNvbmRpdGlvbiAodXN1YWxseSBpbnZvbHZpbmcgQHZhbCkNCiAgKiBA
ZGVsYXlfdXM6IFRpbWUgdG8gdWRlbGF5IGJldHdlZW4gcmVhZHMgaW4gdXMgKDAgdGlnaHQtbG9v
cHMpLiAgU2hvdWxkDQpAQCAtNjksNiArNjgsNyBAQA0KICAqICAgICAgICAgICAgRG9jdW1lbnRh
dGlvbi90aW1lcnMvdGltZXJzLWhvd3RvLnJzdCkuDQogICogQHRpbWVvdXRfdXM6IFRpbWVvdXQg
aW4gdXMsIDAgbWVhbnMgbmV2ZXIgdGltZW91dA0KICAqIEBkZWxheV9iZWZvcmVfcmVhZDogaWYg
aXQgaXMgdHJ1ZSwgZGVsYXkgQGRlbGF5X3VzIGJlZm9yZSByZWFkLg0KKyAqIEBhcmdzOiBhcmd1
bWVudHMgZm9yIEBvcCBwb2xsDQogICoNCiAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBhbmQgLUVU
SU1FRE9VVCB1cG9uIGEgdGltZW91dC4gSW4gZWl0aGVyDQogICogY2FzZSwgdGhlIGxhc3QgcmVh
ZCB2YWx1ZSBhdCBAYXJncyBpcyBzdG9yZWQgaW4gQHZhbC4NCi0tIA0KMS45LjENCg==

