Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C18C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aFxz1yah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHXIOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:14:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23785 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgHXIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:14:39 -0400
X-UUID: 3df8a9808a0645cbb9ff4172bda44e44-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fp5BvuMv6aQW1kwsMMF3iiFeaB50z+78RNwBXksdEww=;
        b=aFxz1yahULKuViUbuEu5f6W4K69DN9zWkFlKCHiOPfFwHNtzrU4lem++Bsi/FuxYWF+R2ymNbztLY2EeVYxYOWCcOREgbjKiXhFNya48JSdYJ7jjiaEvUnmcpsd1ij/iXF6qqZM7cHYq7qoLrK1tSxdEmUKMOfLPxMXO5XfEfFQ=;
X-UUID: 3df8a9808a0645cbb9ff4172bda44e44-20200824
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2082476556; Mon, 24 Aug 2020 16:14:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 16:14:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 16:14:33 +0800
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
Subject: [PATCH v2 6/6] kasan: update documentation for generic kasan
Date:   Mon, 24 Aug 2020 16:14:33 +0800
Message-ID: <20200824081433.25198-1-walter-zh.wu@mediatek.com>
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
dG8gMiBjYWxsX3JjdSgpIGNhbGwgc3RhY2tzLCB0aW1lciBxdWV1ZWluZyBzdGFja3MsDQorb3Ig
d29ya3F1ZXVlIHF1ZXVlaW5nIHN0YWNrcyBpbiByZXBvcnRzLCB0aGUgbGFzdCBvbmUgYW5kIHRo
ZSBzZWNvbmQgdG8gbGFzdC4NCiANCiBTb2Z0d2FyZSB0YWctYmFzZWQgS0FTQU4NCiB+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4NCi0tIA0KMi4xOC4wDQo=

