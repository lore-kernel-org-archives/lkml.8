Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A734FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831BD207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KBrNikgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgHTFrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19665 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726816AbgHTFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:29 -0400
X-UUID: 080af2902ba74367a6c0a80d9558996f-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5pxribR31CQgQe+IviHaDK7ktNuAA4Cab7Sch7ArcjM=;
        b=KBrNikgWV4IKuXgKogvdVnFWhh1I2Oj9EN3UMX4Yjm7MrzTX4IKzy/CLe7LeY04eNWBkUZAOkig4BAcRjXR1j03d4lR11ZuHszM+5dBImrYxhrJKHDkYWSzD3viCcMONJ4mj3KgFoJ4DxYgX/2CheiPRnBD7q5y1QpVDd7FFbIE=;
X-UUID: 080af2902ba74367a6c0a80d9558996f-20200820
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 971521580; Thu, 20 Aug 2020 13:47:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:19 +0800
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
Subject: [PATCH v2 11/11] iopoll: update kerneldoc of read_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:49 +0800
Message-ID: <1597902349-8998-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4F991CF82A38C68CA192172E4EC36B0DFACED774C5C72F2BD52F1522178F17102000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXJndW1lbnRzIGRlc2NyaXB0aW9uIG9mIHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIGlmIG91
dCBvZiBkYXRlLA0KdXBkYXRlIGl0Lg0KDQpDYzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KdjI6IG5ldyBwYXRjaCwgc3VnZ2VzdGVkIGJ5IEFsYW4NCi0tLQ0K
IGluY2x1ZGUvbGludXgvaW9wb2xsLmggfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9p
b3BvbGwuaCBiL2luY2x1ZGUvbGludXgvaW9wb2xsLmgNCmluZGV4IGJjODlhYzYuLjJjODg2MGUg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2lvcG9sbC5oDQorKysgYi9pbmNsdWRlL2xpbnV4
L2lvcG9sbC5oDQpAQCAtNjAsOCArNjAsNyBAQA0KIC8qKg0KICAqIHJlYWRfcG9sbF90aW1lb3V0
X2F0b21pYyAtIFBlcmlvZGljYWxseSBwb2xsIGFuIGFkZHJlc3MgdW50aWwgYSBjb25kaXRpb24g
aXMNCiAgKiAJCQkJbWV0IG9yIGEgdGltZW91dCBvY2N1cnMNCi0gKiBAb3A6IGFjY2Vzc29yIGZ1
bmN0aW9uICh0YWtlcyBAYWRkciBhcyBpdHMgb25seSBhcmd1bWVudCkNCi0gKiBAYWRkcjogQWRk
cmVzcyB0byBwb2xsDQorICogQG9wOiBhY2Nlc3NvciBmdW5jdGlvbiAodGFrZXMgQGFyZ3MgYXMg
aXRzIGFyZ3VtZW50cykNCiAgKiBAdmFsOiBWYXJpYWJsZSB0byByZWFkIHRoZSB2YWx1ZSBpbnRv
DQogICogQGNvbmQ6IEJyZWFrIGNvbmRpdGlvbiAodXN1YWxseSBpbnZvbHZpbmcgQHZhbCkNCiAg
KiBAZGVsYXlfdXM6IFRpbWUgdG8gdWRlbGF5IGJldHdlZW4gcmVhZHMgaW4gdXMgKDAgdGlnaHQt
bG9vcHMpLiAgU2hvdWxkDQpAQCAtNjksNiArNjgsNyBAQA0KICAqICAgICAgICAgICAgRG9jdW1l
bnRhdGlvbi90aW1lcnMvdGltZXJzLWhvd3RvLnJzdCkuDQogICogQHRpbWVvdXRfdXM6IFRpbWVv
dXQgaW4gdXMsIDAgbWVhbnMgbmV2ZXIgdGltZW91dA0KICAqIEBkZWxheV9iZWZvcmVfcmVhZDog
aWYgaXQgaXMgdHJ1ZSwgZGVsYXkgQGRlbGF5X3VzIGJlZm9yZSByZWFkLg0KKyAqIEBhcmdzOiBh
cmd1bWVudHMgZm9yIEBvcCBwb2xsDQogICoNCiAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBhbmQg
LUVUSU1FRE9VVCB1cG9uIGEgdGltZW91dC4gSW4gZWl0aGVyDQogICogY2FzZSwgdGhlIGxhc3Qg
cmVhZCB2YWx1ZSBhdCBAYXJncyBpcyBzdG9yZWQgaW4gQHZhbC4NCi0tIA0KMS45LjENCg==

