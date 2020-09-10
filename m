Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327F3C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42AD20872
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qwHNt0hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgIJIbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:31:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:33661 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730400AbgIJIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:36 -0400
X-UUID: fda48862335f4b32a0516abfad076fe2-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mVw3k7m+HfgDDtgies2lv1Zs9zfJ0QocsJ5+s8RXmlU=;
        b=qwHNt0hGWcxf+pjlXCFOt4v4FI2rS+w36mWj6Y9o8BUNKtJyTj06gNViehdKrAfUrEwb1obm80V1VSFclGjfD7gdUEYDlPi0K5XgOCVs/i55Cw4IFzxJG8M9fxQHxsNCf9U4rSpC7gzhVxyOr6IV3KJnDnsHPHxPhQkwt488k6E=;
X-UUID: fda48862335f4b32a0516abfad076fe2-20200910
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1693113807; Thu, 10 Sep 2020 16:24:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:07 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:05 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH RESEND v3 06/11] usb: fotg210-hcd: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:47 +0800
Message-ID: <1599726112-4439-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2157792CED1FA9CBAAC8C672C145BEFB20C5C2929A9E6CCCCF5D75191B6C95362000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djM6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYyB8
IDIwICsrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcy
MTAtaGNkLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCmluZGV4IDE5NGRmODIu
LjFkOTRmY2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCisr
KyBiL2RyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYw0KQEAgLTMyLDYgKzMyLDcgQEANCiAj
aW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+
DQogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KIA0KICNpbmNsdWRlIDxhc20vYnl0ZW9yZGVyLmg+
DQpAQCAtODgzLDE4ICs4ODQsMTUgQEAgc3RhdGljIGludCBoYW5kc2hha2Uoc3RydWN0IGZvdGcy
MTBfaGNkICpmb3RnMjEwLCB2b2lkIF9faW9tZW0gKnB0ciwNCiAJCXUzMiBtYXNrLCB1MzIgZG9u
ZSwgaW50IHVzZWMpDQogew0KIAl1MzIgcmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQot
CQlyZXN1bHQgPSBmb3RnMjEwX3JlYWRsKGZvdGcyMTAsIHB0cik7DQotCQlpZiAocmVzdWx0ID09
IH4odTMyKTApCQkvKiBjYXJkIHJlbW92ZWQgKi8NCi0JCQlyZXR1cm4gLUVOT0RFVjsNCi0JCXJl
c3VsdCAmPSBtYXNrOw0KLQkJaWYgKHJlc3VsdCA9PSBkb25lKQ0KLQkJCXJldHVybiAwOw0KLQkJ
dWRlbGF5KDEpOw0KLQkJdXNlYy0tOw0KLQl9IHdoaWxlICh1c2VjID4gMCk7DQotCXJldHVybiAt
RVRJTUVET1VUOw0KKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHB0ciwgcmVzdWx0
LA0KKwkJCQkJKChyZXN1bHQgJiBtYXNrKSA9PSBkb25lIHx8DQorCQkJCQkgcmVzdWx0ID09IFUz
Ml9NQVgpLCAxLCB1c2VjKTsNCisJaWYgKHJlc3VsdCA9PSBVMzJfTUFYKQkJLyogY2FyZCByZW1v
dmVkICovDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyog
Rm9yY2UgSEMgdG8gaGFsdCBzdGF0ZSBmcm9tIHVua25vd24gKEVIQ0kgc3BlYyBzZWN0aW9uIDIu
MykuDQotLSANCjEuOS4xDQo=

