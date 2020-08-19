Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762EBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B56B206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Jt8hNIII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHSMnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:43:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16966 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728249AbgHSMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:42:57 -0400
X-UUID: 72b2ab2562354f65bfac6c3da20e97f7-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D88GhKAQOoOoMdP2CcQ1z4Poelnhpyo0MHbY6pqZ5mg=;
        b=Jt8hNIIIVBtbRIrH3NKm2aNXR+j+a73q/G/WmAQxv3pVEfHGw+/LpaXruz9YeJy2x2dt0Ksh7t18yBWFn2gwuOD9oGuaigu5yKet5B64g+vflZOvVAONW5CTjNJFb7kIVcEXM+f6eX/YH6XU5lV/xDd+Fst8XtySVTp8U1v7WWI=;
X-UUID: 72b2ab2562354f65bfac6c3da20e97f7-20200819
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2079135075; Wed, 19 Aug 2020 20:42:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:47 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/10] usb: fotg210-hcd: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:41:01 +0800
Message-ID: <1597840865-26631-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F4E93F279AA6B03AA944F8689A81AD9D167A411882F0CF6059AAE4936108172D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYyB8IDIwICsrKysrKysrKy0tLS0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMgYi9kcml2ZXJzL3VzYi9o
b3N0L2ZvdGcyMTAtaGNkLmMNCmluZGV4IDE5NGRmODIuLjFkOTRmY2YgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QvZm90
ZzIxMC1oY2QuYw0KQEAgLTMyLDYgKzMyLDcgQEANCiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5o
Pg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgv
aW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Nsay5o
Pg0KIA0KICNpbmNsdWRlIDxhc20vYnl0ZW9yZGVyLmg+DQpAQCAtODgzLDE4ICs4ODQsMTUgQEAg
c3RhdGljIGludCBoYW5kc2hha2Uoc3RydWN0IGZvdGcyMTBfaGNkICpmb3RnMjEwLCB2b2lkIF9f
aW9tZW0gKnB0ciwNCiAJCXUzMiBtYXNrLCB1MzIgZG9uZSwgaW50IHVzZWMpDQogew0KIAl1MzIg
cmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSBmb3RnMjEwX3JlYWRs
KGZvdGcyMTAsIHB0cik7DQotCQlpZiAocmVzdWx0ID09IH4odTMyKTApCQkvKiBjYXJkIHJlbW92
ZWQgKi8NCi0JCQlyZXR1cm4gLUVOT0RFVjsNCi0JCXJlc3VsdCAmPSBtYXNrOw0KLQkJaWYgKHJl
c3VsdCA9PSBkb25lKQ0KLQkJCXJldHVybiAwOw0KLQkJdWRlbGF5KDEpOw0KLQkJdXNlYy0tOw0K
LQl9IHdoaWxlICh1c2VjID4gMCk7DQotCXJldHVybiAtRVRJTUVET1VUOw0KKwlyZXQgPSByZWFk
bF9wb2xsX3RpbWVvdXRfYXRvbWljKHB0ciwgcmVzdWx0LA0KKwkJCQkJKChyZXN1bHQgJiBtYXNr
KSA9PSBkb25lIHx8DQorCQkJCQkgcmVzdWx0ID09IFUzMl9NQVgpLCAxLCB1c2VjKTsNCisJaWYg
KHJlc3VsdCA9PSBVMzJfTUFYKQkJLyogY2FyZCByZW1vdmVkICovDQorCQlyZXR1cm4gLUVOT0RF
VjsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyogRm9yY2UgSEMgdG8gaGFsdCBzdGF0ZSBm
cm9tIHVua25vd24gKEVIQ0kgc3BlYyBzZWN0aW9uIDIuMykuDQotLSANCjEuOS4xDQo=

