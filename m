Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6663EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A9C206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D4y2Wt2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgFAFLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:11:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61164 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgFAFLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:11:18 -0400
X-UUID: 7834e9f67cc342dd8eaacb6655bc76b2-20200601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mSnY8KhqyWrchwEP6pw4hG/od6FJgo3wLIYoRyPzhfE=;
        b=D4y2Wt2kItSi47C01eQHHv66LTeaD0rn8P4b6LNPEyhuGnF1InSqOToJSt2GdadI87jgrkp2VDF6Plwxgv+N/jizrl4cDSFfFgj2LkwFcf3HBNaKlpGFiG3dFpNldh9FqudqCfqKbByQltePgJSqg6+OmglSgPfX0vTUpXC1VV0=;
X-UUID: 7834e9f67cc342dd8eaacb6655bc76b2-20200601
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1839970914; Mon, 01 Jun 2020 13:11:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Jun 2020 13:11:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Jun 2020 13:11:06 +0800
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
Subject: [PATCH v7 4/4] kasan: update documentation for generic kasan
Date:   Mon, 1 Jun 2020 13:11:11 +0800
Message-ID: <20200601051111.1359-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AD8C74DB6C0C24E053BEBE0CB306A11DA5F9CA9F00D17BE39A5608DC48F6A5BF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiB3aWxsIHN1cHBvcnQgdG8gcmVjb3JkIHRoZSBsYXN0IHR3byBjYWxsX3Jj
dSgpIGNhbGwgc3RhY2tzDQphbmQgcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuIFNvIHRoYXQg
bmVlZCB0byB1cGRhdGUgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1
IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYW5kLXRlc3RlZC1ieTogRG1p
dHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBLb25v
dmFsb3YgPGFuZHJleWtudmxAZ29vZ2xlLmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFi
aW5pbkB2aXJ0dW96em8uY29tPg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29n
bGUuY29tPg0KQ2M6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQotLS0NCiBEb2N1
bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2th
c2FuLnJzdCBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KaW5kZXggYzY1MmQ3
NDA3MzVkLi5mZWRlNDJlNjUzNmIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rYXNhbi5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KQEAg
LTE5Myw2ICsxOTMsOSBAQCBmdW5jdGlvbiBjYWxscyBHQ0MgZGlyZWN0bHkgaW5zZXJ0cyB0aGUg
Y29kZSB0byBjaGVjayB0aGUgc2hhZG93IG1lbW9yeS4NCiBUaGlzIG9wdGlvbiBzaWduaWZpY2Fu
dGx5IGVubGFyZ2VzIGtlcm5lbCBidXQgaXQgZ2l2ZXMgeDEuMS14MiBwZXJmb3JtYW5jZQ0KIGJv
b3N0IG92ZXIgb3V0bGluZSBpbnN0cnVtZW50ZWQga2VybmVsLg0KIA0KK0dlbmVyaWMgS0FTQU4g
cHJpbnRzIHVwIHRvIDIgY2FsbF9yY3UoKSBjYWxsIHN0YWNrcyBpbiByZXBvcnRzLCB0aGUgbGFz
dCBvbmUNCithbmQgdGhlIHNlY29uZCB0byBsYXN0Lg0KKw0KIFNvZnR3YXJlIHRhZy1iYXNlZCBL
QVNBTg0KIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KIA0KLS0gDQoyLjE4LjANCg==

