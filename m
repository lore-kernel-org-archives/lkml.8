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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26285C2D0E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68FD2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ov+rb94F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgIJIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:30:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24474 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730358AbgIJIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:43 -0400
X-UUID: 4b14aed620984003b8f9042eae41b42d-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o9gRtfphL7oKzKpDTA0u+KvZoZmDOCuBnG5TsFQzD7k=;
        b=ov+rb94FRihrrIkSN8UEbnNJqmo2SJiH70Eqv9K/afekkbmWocscsa51bdhFhaSqiX8J6xWVHkeyZQHlMHGPMW4QIuwFnULjovZ5QPTfzNbinwap1h+AeymHMYmG3PtKSMwVKrtbHMdHXApqclZolCDOpS7vAWTGboj+Glygn7E=;
X-UUID: 4b14aed620984003b8f9042eae41b42d-20200910
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1558554770; Thu, 10 Sep 2020 16:24:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:08 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:07 +0800
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
Subject: [PATCH RESEND v3 07/11] usb: isp1760-hcd: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:48 +0800
Message-ID: <1599726112-4439-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AE382C1EA462680E25491CE36EF7D6C38BC8928087A10E97E194B6FC703E2C2E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djM6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2lzcDE3NjAvaXNwMTc2MC1oY2Qu
YyB8IDIwICsrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9pc3AxNzYw
L2lzcDE3NjAtaGNkLmMgYi9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCmluZGV4
IGRkNzRhYjdhLi4zM2FlNjU2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaXNwMTc2MC9pc3Ax
NzYwLWhjZC5jDQorKysgYi9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCkBAIC0y
Miw2ICsyMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9p
b3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgvdGltZXIu
aD4NCiAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KQEAgLTM4MCwxOCArMzgxLDE1IEBAIHN0
YXRpYyBpbnQgaGFuZHNoYWtlKHN0cnVjdCB1c2JfaGNkICpoY2QsIHUzMiByZWcsDQogCQkgICAg
ICB1MzIgbWFzaywgdTMyIGRvbmUsIGludCB1c2VjKQ0KIHsNCiAJdTMyIHJlc3VsdDsNCisJaW50
IHJldDsNCisNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhoY2QtPnJlZ3MgKyBy
ZWcsIHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJl
c3VsdCA9PSBVMzJfTUFYKSwgMSwgdXNlYyk7DQorCWlmIChyZXN1bHQgPT0gVTMyX01BWCkNCisJ
CXJldHVybiAtRU5PREVWOw0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWdfcmVhZDMyKGhjZC0+
cmVncywgcmVnKTsNCi0JCWlmIChyZXN1bHQgPT0gfjApDQotCQkJcmV0dXJuIC1FTk9ERVY7DQot
CQlyZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsN
Ci0JCXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1
cm4gLUVUSU1FRE9VVDsNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyogcmVzZXQgYSBub24tcnVu
bmluZyAoU1RTX0hBTFQgPT0gMSkgY29udHJvbGxlciAqLw0KLS0gDQoxLjkuMQ0K

