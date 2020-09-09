Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F292080C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="el//Aoxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgIIHfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:35:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725984AbgIIHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:35:15 -0400
X-UUID: dddadd983f3f4196a4af8df4884e3e9d-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5egQoq8hPPAkOfF/INbEfBKiZv1N/+035QYwraMLsRk=;
        b=el//Aoxao95yTm8wnv403A4xzYHMlR0hveFSTK8XF4kV81rQMrKR7Na0/RJu0dNDUHfxg3bX8TiLDmIX9HuyNHsoWkNtpKb98HlsPVCPfUe1Gx6WGNAsbJ8vNjlfVc3QMs2E9sCzYuhVPx/ViVJ1MVquXKYB/qVqiUuRAGrL7zA=;
X-UUID: dddadd983f3f4196a4af8df4884e3e9d-20200909
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 526614121; Wed, 09 Sep 2020 15:35:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 15:35:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 15:35:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Bin Liu <b-liu@ti.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 03/11] usb: gadget: bdc: prefer pointer dereference to pointer type
Date:   Wed, 9 Sep 2020 15:32:54 +0800
Message-ID: <1599636782-7654-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AE9BD659DFC8EA67435F8B7B61D7C588BBF055194C28253F8DD20026BD007F602000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHJlZmVyIGt6YWxsb2Moc2l6ZW9mKCpiZF90YWJsZSkuLi4pIG92ZXINCmt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCBiZF90YWJsZSkNCg0KQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21h
aWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29t
Pg0KLS0tDQp2MzogYWRkIGFja2VkLWJ5IEZsb3JpYW4NCg0KdjI6IGFkZCBDYyBGbG9yaWFuDQot
LS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2VwLmMNCmluZGV4IGZhZmRjOWYuLjc2NDYzZGUgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2VwLmMNCkBAIC0xNDcsNyArMTQ3LDcgQEAgc3RhdGljIGludCBlcF9iZF9s
aXN0X2FsbG9jKHN0cnVjdCBiZGNfZXAgKmVwKQ0KIAkvKiBBbGxvY2F0ZSBtZW1vcnkgZm9yIGVh
Y2ggdGFibGUgKi8NCiAJZm9yIChpbmRleCA9IDA7IGluZGV4IDwgbnVtX3RhYnM7IGluZGV4Kysp
IHsNCiAJCS8qIEFsbG9jYXRlIG1lbW9yeSBmb3IgYmRfdGFibGUgc3RydWN0dXJlICovDQotCQli
ZF90YWJsZSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBiZF90YWJsZSksIEdGUF9BVE9NSUMpOw0K
KwkJYmRfdGFibGUgPSBremFsbG9jKHNpemVvZigqYmRfdGFibGUpLCBHRlBfQVRPTUlDKTsNCiAJ
CWlmICghYmRfdGFibGUpDQogCQkJZ290byBmYWlsOw0KIA0KLS0gDQoxLjkuMQ0K

