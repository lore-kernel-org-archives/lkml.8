Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5473B208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ST5MhYR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHVIJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:09:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23971 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727087AbgHVIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:29 -0400
X-UUID: a00c4e4c3e094b0199ff615386b2e222-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o9gRtfphL7oKzKpDTA0u+KvZoZmDOCuBnG5TsFQzD7k=;
        b=ST5MhYR+lE5qLUhrAI0Gf125jdUJH+ItqJKMhsURTrXMHH+SZcjqETAiUePJhGCdQ/6mtmCL9fIOvwNbEwlWQYm1HQVSV7xOwgBxAVO1z10sk1TiAAEJZe5AyhGl48dfJzauo9o1vRhmJO+463q1Puti+gDQu0Y+TEb2n+O5s5Y=;
X-UUID: a00c4e4c3e094b0199ff615386b2e222-20200822
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 801532623; Sat, 22 Aug 2020 16:09:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:12 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 07/11] usb: isp1760-hcd: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:49 +0800
Message-ID: <1598083553-31896-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AEC8FC299CA8140D60BC8439E194576E1CD2D22AE5ECB1FB371572798E2F29272000:8
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

