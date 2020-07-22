Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D0C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FE820729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Oj+MFCr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgGVHwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:52:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22238 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726895AbgGVHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:48 -0400
X-UUID: 12d826cbb69c465a822a3bdc72cd5e9d-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CzXt417YZnXp+qjSl1yfPPQkC34rFngVIJsdn7hXNvo=;
        b=Oj+MFCr61Z9eVqR9p9toHWG4sjS+ge/IpQOiZwdHAWmntMDx2/perapmmSNYthbmqHtuDWZiUMckvkh098MSwkjzU1B7So1MSWy1jhC03wskpHV4D90QG7V12tzZ5ybIfPjCuI/nDa2ROYQm5LouDwNMajhzxFgNgEBH8ewcEmw=;
X-UUID: 12d826cbb69c465a822a3bdc72cd5e9d-20200722
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1757700144; Wed, 22 Jul 2020 15:52:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:38 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5/7] usb: gadget: r8a66597: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:13 +0800
Message-ID: <1595404275-8449-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D92B4937737A2A49E37ED71097E5A8B9967C95846982E2A375FDC7CCE8515C882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvcjhhNjY1OTctdWRjLmMgfCA2ICsr
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3I4YTY2NTk3LXVkYy5jIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9yOGE2NjU5Ny11ZGMuYw0KaW5kZXggNTM3MDk0YjQuLjg5NmMx
YTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3I4YTY2NTk3LXVkYy5jDQor
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3I4YTY2NTk3LXVkYy5jDQpAQCAtMTgyNywxMCAr
MTgyNyw4IEBAIHN0YXRpYyB2b2lkIG5vcF9jb21wbGV0aW9uKHN0cnVjdCB1c2JfZXAgKmVwLCBz
dHJ1Y3QgdXNiX3JlcXVlc3QgKnIpDQogc3RhdGljIGludCByOGE2NjU5N19zdWRtYWNfaW9yZW1h
cChzdHJ1Y3QgcjhhNjY1OTcgKnI4YTY2NTk3LA0KIAkJCQkJICBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIHsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQotDQotCXJlcyA9IHBsYXRm
b3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJzdWRtYWMiKTsN
Ci0JcjhhNjY1OTctPnN1ZG1hY19yZWcgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRl
diwgcmVzKTsNCisJcjhhNjY1OTctPnN1ZG1hY19yZWcgPQ0KKwkJZGV2bV9wbGF0Zm9ybV9pb3Jl
bWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAic3VkbWFjIik7DQogCXJldHVybiBQVFJfRVJSX09S
X1pFUk8ocjhhNjY1OTctPnN1ZG1hY19yZWcpOw0KIH0NCiANCi0tIA0KMS45LjENCg==

