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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E6FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D3120724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kKfhY7Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHTFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:48:05 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5285 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbgHTFrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:25 -0400
X-UUID: 631f593925db459b9e59044027e18396-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RHGCbFS08BtdpqCBNesTHixiSpL9QLvoov63r+0u9wo=;
        b=kKfhY7NmnRYAYyluPdU7e5id4e0YgVdLgD8aeN/xVPkupFtioXKH/VnHEflEwWldbH6gHZgcyM9D1fKtXorUO9AJmIbsV6bjVa/Il4Os5qAjBxABncoAFNldJbH+yt0iVJQBuGY9WDxbZ1iM3aIGqXTdYsl0innwHIMlAGT2BqE=;
X-UUID: 631f593925db459b9e59044027e18396-20200820
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 42812538; Thu, 20 Aug 2020 13:47:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:13 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 06/11] usb: fotg210-hcd: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:44 +0800
Message-ID: <1597902349-8998-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9BFB2DD1E3BDA123CD88DD4D9DC7D0EFF4F2AFBDA2F62C9A0CBA566532FE42442000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYyB8IDIw
ICsrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAt
aGNkLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCmluZGV4IDE5NGRmODIuLjFk
OTRmY2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYw0KQEAgLTMyLDYgKzMyLDcgQEANCiAjaW5j
bHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQog
I2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KIA0KICNpbmNsdWRlIDxhc20vYnl0ZW9yZGVyLmg+DQpA
QCAtODgzLDE4ICs4ODQsMTUgQEAgc3RhdGljIGludCBoYW5kc2hha2Uoc3RydWN0IGZvdGcyMTBf
aGNkICpmb3RnMjEwLCB2b2lkIF9faW9tZW0gKnB0ciwNCiAJCXUzMiBtYXNrLCB1MzIgZG9uZSwg
aW50IHVzZWMpDQogew0KIAl1MzIgcmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQotCQly
ZXN1bHQgPSBmb3RnMjEwX3JlYWRsKGZvdGcyMTAsIHB0cik7DQotCQlpZiAocmVzdWx0ID09IH4o
dTMyKTApCQkvKiBjYXJkIHJlbW92ZWQgKi8NCi0JCQlyZXR1cm4gLUVOT0RFVjsNCi0JCXJlc3Vs
dCAmPSBtYXNrOw0KLQkJaWYgKHJlc3VsdCA9PSBkb25lKQ0KLQkJCXJldHVybiAwOw0KLQkJdWRl
bGF5KDEpOw0KLQkJdXNlYy0tOw0KLQl9IHdoaWxlICh1c2VjID4gMCk7DQotCXJldHVybiAtRVRJ
TUVET1VUOw0KKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHB0ciwgcmVzdWx0LA0K
KwkJCQkJKChyZXN1bHQgJiBtYXNrKSA9PSBkb25lIHx8DQorCQkJCQkgcmVzdWx0ID09IFUzMl9N
QVgpLCAxLCB1c2VjKTsNCisJaWYgKHJlc3VsdCA9PSBVMzJfTUFYKQkJLyogY2FyZCByZW1vdmVk
ICovDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyogRm9y
Y2UgSEMgdG8gaGFsdCBzdGF0ZSBmcm9tIHVua25vd24gKEVIQ0kgc3BlYyBzZWN0aW9uIDIuMyku
DQotLSANCjEuOS4xDQo=

