Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3BBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07EE2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W4d4mS/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgEVCCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:02:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52239 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgEVCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:02:15 -0400
X-UUID: 7421c5cce6cf45d086d0431ffc9b90f3-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qIWtxoGuZ5P6mO49eH/CrXHztmv7j3tYchUpE2BMWOE=;
        b=W4d4mS/lmhxkiGXUku7OiRPcT+PtShkiyBU8ll5t8mWZfJBWYwtCJVK436oJiJF766jBshnlD/DLQB4VKr1W82iwuR4u08y5qbrsc2596txEJ8u7PEhDvh+LwavCy5hx1Jl4ZIEIb2WSENR0+YSMdI+/xZlyqney+VETXWo6QKo=;
X-UUID: 7421c5cce6cf45d086d0431ffc9b90f3-20200522
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 944133403; Fri, 22 May 2020 10:02:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 10:02:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 10:02:12 +0800
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
Subject: [PATCH v6 4/4] kasan: update documentation for generic kasan
Date:   Fri, 22 May 2020 10:02:12 +0800
Message-ID: <20200522020212.23460-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 96CB23A265DA29919D6ADF75D54BB85AE65E7498DE570CC72449AA74EB4B50CD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiB3aWxsIHN1cHBvcnQgdG8gcmVjb3JkIHRoZSBsYXN0IHR3byBjYWxsX3Jj
dSgpIGNhbGwgc3RhY2tzDQphbmQgcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuIFNvIHRoYXQg
bmVlZCB0byB1cGRhdGUgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1
IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJp
bmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29t
Pg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IEpvbmF0
aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQotLS0NCiBEb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rYXNhbi5yc3QgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCBiL0RvY3VtZW50
YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KaW5kZXggYzY1MmQ3NDA3MzVkLi5mZWRlNDJlNjUz
NmIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KQEAgLTE5Myw2ICsxOTMsOSBAQCBm
dW5jdGlvbiBjYWxscyBHQ0MgZGlyZWN0bHkgaW5zZXJ0cyB0aGUgY29kZSB0byBjaGVjayB0aGUg
c2hhZG93IG1lbW9yeS4NCiBUaGlzIG9wdGlvbiBzaWduaWZpY2FudGx5IGVubGFyZ2VzIGtlcm5l
bCBidXQgaXQgZ2l2ZXMgeDEuMS14MiBwZXJmb3JtYW5jZQ0KIGJvb3N0IG92ZXIgb3V0bGluZSBp
bnN0cnVtZW50ZWQga2VybmVsLg0KIA0KK0dlbmVyaWMgS0FTQU4gcHJpbnRzIHVwIHRvIDIgY2Fs
bF9yY3UoKSBjYWxsIHN0YWNrcyBpbiByZXBvcnRzLCB0aGUgbGFzdCBvbmUNCithbmQgdGhlIHNl
Y29uZCB0byBsYXN0Lg0KKw0KIFNvZnR3YXJlIHRhZy1iYXNlZCBLQVNBTg0KIH5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KIA0KLS0gDQoyLjE4LjANCg==

