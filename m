Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C32C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84496207DE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qLCWArRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHJH2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:28:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13530 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725894AbgHJH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:28:53 -0400
X-UUID: 664afc6c40cf4209a5f22d6ad54708c7-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fNYSYPr/EUtrb5AE0HZcFt+MO/QDfADl7kGfo3uCntY=;
        b=qLCWArRYBL/s6QmwRwC3W+F72p9XtzECtMFBScH4yYdUFvvN7ueXYRBWMcoF4CFretyV4ITarA4dV9LFynSRAuCN4ZU2AhLtYeDkwK4XxC9bF9pduJVsvFzwAjq5YBzzdLx4TvJF/uLP6pINCabHP7X22ThUj0g396i28XdQ4lg=;
X-UUID: 664afc6c40cf4209a5f22d6ad54708c7-20200810
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1679514413; Mon, 10 Aug 2020 15:28:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 15:28:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 15:28:46 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH 5/5] kasan: update documentation for generic KASAN
Date:   Mon, 10 Aug 2020 15:28:47 +0800
Message-ID: <20200810072847.921-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiBzdXBwb3J0IHRvIHJlY29yZCB0aGUgbGFzdCB0d28gdGltZXIgYW5kIHdv
cmtxdWV1ZQ0Kc3RhY2tzIGFuZCBwcmludCB0aGVtIGluIEtBU0FOIHJlcG9ydC4gU28gdGhhdCBu
ZWVkIHRvIHVwZGF0ZQ0KZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1
IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJp
bmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29t
Pg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IEpvbmF0
aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQotLS0NCiBEb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rYXNhbi5yc3QgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2Fz
YW4ucnN0IGIvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0DQppbmRleCBmZWRlNDJl
NjUzNmIuLjVhNGM1ZGE4YmRhOCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xz
L2thc2FuLnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0DQpAQCAt
MTkzLDggKzE5Myw4IEBAIGZ1bmN0aW9uIGNhbGxzIEdDQyBkaXJlY3RseSBpbnNlcnRzIHRoZSBj
b2RlIHRvIGNoZWNrIHRoZSBzaGFkb3cgbWVtb3J5Lg0KIFRoaXMgb3B0aW9uIHNpZ25pZmljYW50
bHkgZW5sYXJnZXMga2VybmVsIGJ1dCBpdCBnaXZlcyB4MS4xLXgyIHBlcmZvcm1hbmNlDQogYm9v
c3Qgb3ZlciBvdXRsaW5lIGluc3RydW1lbnRlZCBrZXJuZWwuDQogDQotR2VuZXJpYyBLQVNBTiBw
cmludHMgdXAgdG8gMiBjYWxsX3JjdSgpIGNhbGwgc3RhY2tzIGluIHJlcG9ydHMsIHRoZSBsYXN0
IG9uZQ0KLWFuZCB0aGUgc2Vjb25kIHRvIGxhc3QuDQorR2VuZXJpYyBLQVNBTiBwcmludHMgdXAg
dG8gMiBjYWxsX3JjdSgpIGNhbGwgc3RhY2tzLCB0aW1lciBxdWV1ZWluZyBzdGFja3MsDQorYW5k
IHdvcmtxdWV1ZSBxdWV1ZWluZyBzdGFja3MgaW4gcmVwb3J0cywgdGhlIGxhc3Qgb25lIGFuZCB0
aGUgc2Vjb25kIHRvIGxhc3QuDQogDQogU29mdHdhcmUgdGFnLWJhc2VkIEtBU0FODQogfn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQotLSANCjIuMTguMA0K

