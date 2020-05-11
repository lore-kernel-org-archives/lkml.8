Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DC2C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A76F207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RCuxbCE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgEKCcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:32:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729379AbgEKCcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:32:35 -0400
X-UUID: 227923f835d44eaab8c33af54d6c954c-20200511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Q+QJySbZSKJn63iVkOIGiMVFBu2s5kjFXMpG7KKjPkw=;
        b=RCuxbCE7dxHYqABBQ/0hgelavpR1aQ1O8+JFOyuI+N+ksU/ATNy1wNDtaL6F4O3vPFeCuHyjIqLhatxtxG/OILE64c1WFnNm6I81b9l7XSGrEGpFYDTQnfwHD1m6Rr7tDtJI/CwTUaGG28BhsfWCGvjT64fOqr25oaAE5uAdIsg=;
X-UUID: 227923f835d44eaab8c33af54d6c954c-20200511
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1754945740; Mon, 11 May 2020 10:32:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 May 2020 10:32:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 May 2020 10:32:31 +0800
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
Subject: [PATCH v2 3/3] kasan: update documentation for generic kasan
Date:   Mon, 11 May 2020 10:32:31 +0800
Message-ID: <20200511023231.15437-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiB3aWxsIHN1cHBvcnQgdG8gcmVjb3JkIGZpcnN0IGFuZCBsYXN0IGNhbGxf
cmN1KCkgY2FsbA0Kc3RhY2sgYW5kIHByaW50IHRoZW0gaW4gS0FTQU4gcmVwb3J0LiBzbyB3ZSB1
cGRhdGUgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXIt
emgud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1
b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KQ2M6IEFs
ZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IEpvbmF0aGFuIENvcmJl
dCA8Y29yYmV0QGx3bi5uZXQ+DQotLS0NCiBEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5y
c3QgfCA2ICsrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCBiL0RvY3VtZW50YXRpb24v
ZGV2LXRvb2xzL2thc2FuLnJzdA0KaW5kZXggYzY1MmQ3NDA3MzVkLi5kNGVmY2ZkZTlmZmYgMTAw
NjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KQEAgLTE5Myw2ICsxOTMsMTIgQEAgZnVuY3Rp
b24gY2FsbHMgR0NDIGRpcmVjdGx5IGluc2VydHMgdGhlIGNvZGUgdG8gY2hlY2sgdGhlIHNoYWRv
dyBtZW1vcnkuDQogVGhpcyBvcHRpb24gc2lnbmlmaWNhbnRseSBlbmxhcmdlcyBrZXJuZWwgYnV0
IGl0IGdpdmVzIHgxLjEteDIgcGVyZm9ybWFuY2UNCiBib29zdCBvdmVyIG91dGxpbmUgaW5zdHJ1
bWVudGVkIGtlcm5lbC4NCiANCitDdXJyZW50bHkgZ2VuZXJpYyBLQVNBTiBjYW4gcHJpbnQgY2Fs
bF9yY3UoKSBjYWxsIHN0YWNrIGluIEtBU0FOIHJlcG9ydCwgaXQNCitjYW4ndCBpbmNyZWFzZSB0
aGUgY29zdCBvZiBtZW1vcnkgY29uc3VtcHRpb24sIGJ1dCBpdCBoYXMgb25lIGxpbWl0YXRpb25z
Lg0KK0l0IGNhbid0IGdldCBib3RoIGNhbGxfcmN1KCkgY2FsbCBzdGFjayBhbmQgZnJlZSBzdGFj
aywgc28gdGhhdCBpdCBjYW4ndA0KK3ByaW50IGZyZWUgc3RhY2sgZm9yIGFsbG9jYXRpb24gb2Jq
ZWN0cyBpbiBLQVNBTiByZXBvcnQuIFRoaXMgZmVhdHVyZSBpcw0KK29ubHkgc3VpdGFibGUgZm9y
IGdlbmVyaWMgS0FTQU4uDQorDQogU29mdHdhcmUgdGFnLWJhc2VkIEtBU0FODQogfn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+DQogDQotLSANCjIuMTguMA0K

