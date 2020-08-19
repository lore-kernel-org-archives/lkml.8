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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6273D206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ICRwMgfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHSMnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:43:22 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58310 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728260AbgHSMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:42:59 -0400
X-UUID: d6dcb45d2c964e748082d129705fe6a1-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UosKRjGpZIhdI5RMhf5vCV5EcbtKc40dysbwHo6gzZY=;
        b=ICRwMgfrUYZEEjXEbR+6oV6/iugn2d0c4XQRiNj+dpS/OusKkF6pWR9Gk8YJQirmZCSq+cYMPQv3fbOVOk9+aqhEtEEy1+N5AEpSrwU6Mo9RZ5tHikhMjJvhaODSshS8l8YlkoYTeejcK12bLUiUl5x0gdZROr3rHIv+GhJHhAM=;
X-UUID: d6dcb45d2c964e748082d129705fe6a1-20200819
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1878511258; Wed, 19 Aug 2020 20:42:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:48 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/10] usb: isp1760-hcd: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:41:02 +0800
Message-ID: <1597840865-26631-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 17313833DAD51A68B7DE4830FA2EF9A95C5D248D526DC3860607DA067257611B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2lzcDE3NjAvaXNwMTc2MC1oY2QuYyB8IDIwICsrKysrKysrKy0tLS0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMgYi9kcml2ZXJz
L3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCmluZGV4IGRkNzRhYjdhLi4zM2FlNjU2IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy91c2IvaXNwMTc2MC9pc3AxNzYwLWhjZC5jDQorKysgYi9kcml2ZXJz
L3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCkBAIC0yMiw2ICsyMiw3IEBADQogI2luY2x1ZGUg
PGxpbnV4L2RlYnVnZnMuaD4NCiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRl
IDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgvdGltZXIuaD4NCiAjaW5jbHVkZSA8YXNtL3VuYWxp
Z25lZC5oPg0KQEAgLTM4MCwxOCArMzgxLDE1IEBAIHN0YXRpYyBpbnQgaGFuZHNoYWtlKHN0cnVj
dCB1c2JfaGNkICpoY2QsIHUzMiByZWcsDQogCQkgICAgICB1MzIgbWFzaywgdTMyIGRvbmUsIGlu
dCB1c2VjKQ0KIHsNCiAJdTMyIHJlc3VsdDsNCisJaW50IHJldDsNCisNCisJcmV0ID0gcmVhZGxf
cG9sbF90aW1lb3V0X2F0b21pYyhoY2QtPnJlZ3MgKyByZWcsIHJlc3VsdCwNCisJCQkJCSgocmVz
dWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3VsdCA9PSBVMzJfTUFYKSwgMSwgdXNl
Yyk7DQorCWlmIChyZXN1bHQgPT0gVTMyX01BWCkNCisJCXJldHVybiAtRU5PREVWOw0KIA0KLQlk
byB7DQotCQlyZXN1bHQgPSByZWdfcmVhZDMyKGhjZC0+cmVncywgcmVnKTsNCi0JCWlmIChyZXN1
bHQgPT0gfjApDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCQlyZXN1bHQgJj0gbWFzazsNCi0JCWlm
IChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsNCi0JCXVkZWxheSgxKTsNCi0JCXVzZWMt
LTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0dXJu
IHJldDsNCiB9DQogDQogLyogcmVzZXQgYSBub24tcnVubmluZyAoU1RTX0hBTFQgPT0gMSkgY29u
dHJvbGxlciAqLw0KLS0gDQoxLjkuMQ0K

