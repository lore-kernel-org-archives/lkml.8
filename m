Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046BE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b/cuiUVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgERGbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:31:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32329 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726876AbgERGbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:31:20 -0400
X-UUID: e71d4076d699494fb2225b6f20ae1b95-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=opBrR/j4yNpYI9GLAoGb+LP86AmZJLpZ4GTLHbq+76M=;
        b=b/cuiUVMCTMRmlXe+Do/1NeASFeflcaguasracDFK8kUWDP+LRb09NKC3We9UHhKA7BmuHxcl027NCG5TqYjl5/Z3lM2Be7DY/LImtdPW2K5oAXVyLrzE6oN/jmN4nFl5yhZtrKO9TAH/p7J19G9LnEjqIZB4vXiNeGxjgywP48=;
X-UUID: e71d4076d699494fb2225b6f20ae1b95-20200518
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 332144935; Mon, 18 May 2020 14:31:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 14:31:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 14:31:15 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 4/4] kasan: update documentation for generic kasan
Date:   Mon, 18 May 2020 14:31:15 +0800
Message-ID: <20200518063115.4827-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ED675643220DB99B8C2E7E6E1D9CE046C7ED0213B08C9DA93969DC6F10C244012000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiB3aWxsIHN1cHBvcnQgdG8gcmVjb3JkIHRoZSBsYXN0IHR3byBjYWxsX3Jj
dSgpIGNhbGwNCnN0YWNrcyBhbmQgcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuIHNvIHdlIHVw
ZGF0ZSBkb2N1bWVudGF0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16
aC53dUBtZWRpYXRlay5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVv
enpvLmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpDYzogQWxl
eGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogSm9uYXRoYW4gQ29yYmV0
IDxjb3JiZXRAbHduLm5ldD4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJz
dCB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IGIvRG9jdW1lbnRhdGlvbi9kZXYt
dG9vbHMva2FzYW4ucnN0DQppbmRleCBjNjUyZDc0MDczNWQuLmZlZGU0MmU2NTM2YiAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0DQpAQCAtMTkzLDYgKzE5Myw5IEBAIGZ1bmN0aW9uIGNh
bGxzIEdDQyBkaXJlY3RseSBpbnNlcnRzIHRoZSBjb2RlIHRvIGNoZWNrIHRoZSBzaGFkb3cgbWVt
b3J5Lg0KIFRoaXMgb3B0aW9uIHNpZ25pZmljYW50bHkgZW5sYXJnZXMga2VybmVsIGJ1dCBpdCBn
aXZlcyB4MS4xLXgyIHBlcmZvcm1hbmNlDQogYm9vc3Qgb3ZlciBvdXRsaW5lIGluc3RydW1lbnRl
ZCBrZXJuZWwuDQogDQorR2VuZXJpYyBLQVNBTiBwcmludHMgdXAgdG8gMiBjYWxsX3JjdSgpIGNh
bGwgc3RhY2tzIGluIHJlcG9ydHMsIHRoZSBsYXN0IG9uZQ0KK2FuZCB0aGUgc2Vjb25kIHRvIGxh
c3QuDQorDQogU29mdHdhcmUgdGFnLWJhc2VkIEtBU0FODQogfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+DQogDQotLSANCjIuMTguMA0K

