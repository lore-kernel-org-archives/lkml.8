Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D40AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB1D207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HImQAotZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgETMjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:39:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64451 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbgETMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:39:55 -0400
X-UUID: 5270448b006646d4879475dd6e2e2308-20200520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qIWtxoGuZ5P6mO49eH/CrXHztmv7j3tYchUpE2BMWOE=;
        b=HImQAotZvxIugtxKGRZUqyNfAMNzmUGg+kHxsyHV+gJkrfRDukizdLuMP2ssx4ggsY8iB+vCwTWTiu7bnbfUOxEPB1NAStFPDxfpbn0rKnxhLSyTQqIwitFNZCgb+SxG6EDm0xAid5Ntn9E/yrSFMGJS6l8PfqJnM1hKqC9vCOU=;
X-UUID: 5270448b006646d4879475dd6e2e2308-20200520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 164112740; Wed, 20 May 2020 20:39:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 May 2020 20:39:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 May 2020 20:39:50 +0800
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
Subject: [PATCH v5 4/4] kasan: update documentation for generic kasan
Date:   Wed, 20 May 2020 20:39:48 +0800
Message-ID: <20200520123948.4069-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 53A25556DB809A33935C8E07C4C4E7616D5CC73601E447850F8F6E6A8049B3E22000:8
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

