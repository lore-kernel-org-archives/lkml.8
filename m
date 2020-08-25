Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4F7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A0E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eS/4hTLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHYCCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:02:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbgHYCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:02:15 -0400
X-UUID: df1774462e404d7ebe32eb71e825ac0c-20200825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9sZ1Q2VJIj3D6DYv93PbNUEMzsMoXEFwRyYq2J0814A=;
        b=eS/4hTLSwSIlOSRdtmlkPcp10xhkBJIWzxLyocPknHUVExR6agIKJhUSC6Bf7It1N/LRzRlTLvF2n46A2IAAEJx8h6GtIYLV5ynqXKNVA0qq6LD6eXbmHZNW5lmjT37kOAFfSBvAAz4gE3iQG/ilInAUNH3AOFnnP88FyBrzfEI=;
X-UUID: df1774462e404d7ebe32eb71e825ac0c-20200825
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1653110723; Tue, 25 Aug 2020 10:02:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 10:02:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Aug 2020 10:02:09 +0800
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
Subject: [PATCH v3 6/6] kasan: update documentation for generic kasan
Date:   Tue, 25 Aug 2020 10:02:08 +0800
Message-ID: <20200825020208.28950-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FF79C89B95B5EEC808E61E9DE96777FD0981D12178444CA2009311433735FC3A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiBhbHNvIHN1cHBvcnRzIHRvIHJlY29yZCB0aGUgbGFzdCB0d28gdGltZXIg
YW5kIHdvcmtxdWV1ZQ0Kc3RhY2tzIGFuZCBwcmludCB0aGVtIGluIEtBU0FOIHJlcG9ydC4gU28g
dGhhdCBuZWVkIHRvIHVwZGF0ZQ0KZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2Fs
dGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KU3VnZ2VzdGVkLWJ5OiBNYXJjbyBF
bHZlciA8ZWx2ZXJAZ29vZ2xlLmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2
aXJ0dW96em8uY29tPg0KQ2M6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNj
OiBBbGV4YW5kZXIgUG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBKb25hdGhhbiBD
b3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KLS0tDQoNCnYzOg0KLSBUaGFua3MgZm9yIE1hY3JvIHN1
Z2dlc3Rpb24NCg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IHwgNSAr
KystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgYi9Eb2N1bWVu
dGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCmluZGV4IDM4ZmQ1NjgxZmFkZS4uNjk4Y2NiNjVl
NjM0IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCkBAIC0xOTAsOCArMTkwLDkgQEAg
ZnVuY3Rpb24gY2FsbHMgR0NDIGRpcmVjdGx5IGluc2VydHMgdGhlIGNvZGUgdG8gY2hlY2sgdGhl
IHNoYWRvdyBtZW1vcnkuDQogVGhpcyBvcHRpb24gc2lnbmlmaWNhbnRseSBlbmxhcmdlcyBrZXJu
ZWwgYnV0IGl0IGdpdmVzIHgxLjEteDIgcGVyZm9ybWFuY2UNCiBib29zdCBvdmVyIG91dGxpbmUg
aW5zdHJ1bWVudGVkIGtlcm5lbC4NCiANCi1HZW5lcmljIEtBU0FOIHByaW50cyB1cCB0byAyIGNh
bGxfcmN1KCkgY2FsbCBzdGFja3MgaW4gcmVwb3J0cywgdGhlIGxhc3Qgb25lDQotYW5kIHRoZSBz
ZWNvbmQgdG8gbGFzdC4NCitHZW5lcmljIEtBU0FOIGFsc28gcmVwb3J0cyB0aGUgbGFzdCAyIGNh
bGwgc3RhY2tzIHRvIGNyZWF0aW9uIG9mIHdvcmsgdGhhdA0KK3BvdGVudGlhbGx5IGhhcyBhY2Nl
c3MgdG8gYW4gb2JqZWN0LiBDYWxsIHN0YWNrcyBmb3IgdGhlIGZvbGxvd2luZyBhcmUgc2hvd246
DQorY2FsbF9yY3UoKSwgdGltZXIgYW5kIHdvcmtxdWV1ZSBxdWV1aW5nLg0KIA0KIFNvZnR3YXJl
IHRhZy1iYXNlZCBLQVNBTg0KIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KLS0gDQoyLjE4LjAN
Cg==

