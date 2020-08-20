Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D9FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E5F2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k21RXt0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgHTLgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:36:32 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:65115 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730515AbgHTLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:51 -0400
X-UUID: 92eb2cefcc3245b8b3d6ac66e0a18bbe-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j1FJVeRcQs/rSkPb2rqMyqS7k33Dl5D8u5KqKPyupk0=;
        b=k21RXt0SsjOzvIbW+lWMGWvlyW/LXMiGg4YL4mHByhe0B9zPemU5vxJJKvnyHOCOPcmieqFjLaDuo2aY7Ave+U9rjRpdOA0SuNZywlxsrOWY9VOhA/e8ftYMBZ1iosEYOdo2/Pkgv0USe7wD/XhGwf3v1U1r62WWn+gryr7vNWg=;
X-UUID: 92eb2cefcc3245b8b3d6ac66e0a18bbe-20200820
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2045521470; Thu, 20 Aug 2020 19:32:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:21 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 03/11] usb: gadget: bdc: prefer pointer dereference to pointer type
Date:   Thu, 20 Aug 2020 19:30:38 +0800
Message-ID: <1597923046-12535-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CCD8B9BA7298DE2119E2D27779CF308B4D8A81F0B8FF3AB8C30114730CC229892000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHJlZmVyIGt6YWxsb2Moc2l6ZW9mKCpiZF90YWJsZSkuLi4pIG92ZXINCmt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCBiZF90YWJsZSkNCg0KQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21h
aWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KLS0tDQp2MjogYWRkIENjIEZsb3JpYW4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19lcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9i
ZGMvYmRjX2VwLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KaW5kZXgg
ZmFmZGM5Zi4uNzY0NjNkZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkY19lcC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KQEAg
LTE0Nyw3ICsxNDcsNyBAQCBzdGF0aWMgaW50IGVwX2JkX2xpc3RfYWxsb2Moc3RydWN0IGJkY19l
cCAqZXApDQogCS8qIEFsbG9jYXRlIG1lbW9yeSBmb3IgZWFjaCB0YWJsZSAqLw0KIAlmb3IgKGlu
ZGV4ID0gMDsgaW5kZXggPCBudW1fdGFiczsgaW5kZXgrKykgew0KIAkJLyogQWxsb2NhdGUgbWVt
b3J5IGZvciBiZF90YWJsZSBzdHJ1Y3R1cmUgKi8NCi0JCWJkX3RhYmxlID0ga3phbGxvYyhzaXpl
b2Yoc3RydWN0IGJkX3RhYmxlKSwgR0ZQX0FUT01JQyk7DQorCQliZF90YWJsZSA9IGt6YWxsb2Mo
c2l6ZW9mKCpiZF90YWJsZSksIEdGUF9BVE9NSUMpOw0KIAkJaWYgKCFiZF90YWJsZSkNCiAJCQln
b3RvIGZhaWw7DQogDQotLSANCjEuOS4xDQo=

