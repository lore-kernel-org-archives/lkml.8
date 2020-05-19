Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC10720708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CwEr/lgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgESC0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:26:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11760 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726367AbgESC0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:26:38 -0400
X-UUID: c0dc6b65fe6344d4b38801ea0859a674-20200519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+1T6h4ks8LG74RTkqrEoFP7s8tKRSn96p/OdYqATlnk=;
        b=CwEr/lgMRQcsWV12OU5NpdJX5g/an5AUTivJgbQRzXex6S+3m1n961tjFeQkSvpPfK7EfQdC9W/cgt9dvJufMh+3qKaMKhdAS3x3mnW1zRE3LEr9YjIWsvdGSnRr/KXUgL0wS+KkGZSiaMW6cA2b8dRy30BzPozTz6tj6an2awQ=;
X-UUID: c0dc6b65fe6344d4b38801ea0859a674-20200519
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 588687700; Tue, 19 May 2020 10:26:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 10:26:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 May 2020 10:26:27 +0800
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
Subject: [PATCH v4 4/4] kasan: update documentation for generic kasan
Date:   Tue, 19 May 2020 10:26:26 +0800
Message-ID: <20200519022626.24305-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiB3aWxsIHN1cHBvcnQgdG8gcmVjb3JkIHRoZSBsYXN0IHR3byBjYWxsX3Jj
dSgpIGNhbGwNCnN0YWNrcyBhbmQgcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuIFNvIG5lZWQg
dG8gdXBkYXRlIGRvY3VtZW50YXRpb24uDQoNClNpZ25lZC1vZmYtYnk6IFdhbHRlciBXdSA8d2Fs
dGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2
aXJ0dW96em8uY29tPg0KQ2M6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNj
OiBBbGV4YW5kZXIgUG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBKb25hdGhhbiBD
b3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2Fz
YW4ucnN0IHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgYi9Eb2N1bWVudGF0aW9u
L2Rldi10b29scy9rYXNhbi5yc3QNCmluZGV4IGM2NTJkNzQwNzM1ZC4uZmVkZTQyZTY1MzZiIDEw
MDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0DQorKysgYi9Eb2N1
bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCkBAIC0xOTMsNiArMTkzLDkgQEAgZnVuY3Rp
b24gY2FsbHMgR0NDIGRpcmVjdGx5IGluc2VydHMgdGhlIGNvZGUgdG8gY2hlY2sgdGhlIHNoYWRv
dyBtZW1vcnkuDQogVGhpcyBvcHRpb24gc2lnbmlmaWNhbnRseSBlbmxhcmdlcyBrZXJuZWwgYnV0
IGl0IGdpdmVzIHgxLjEteDIgcGVyZm9ybWFuY2UNCiBib29zdCBvdmVyIG91dGxpbmUgaW5zdHJ1
bWVudGVkIGtlcm5lbC4NCiANCitHZW5lcmljIEtBU0FOIHByaW50cyB1cCB0byAyIGNhbGxfcmN1
KCkgY2FsbCBzdGFja3MgaW4gcmVwb3J0cywgdGhlIGxhc3Qgb25lDQorYW5kIHRoZSBzZWNvbmQg
dG8gbGFzdC4NCisNCiBTb2Z0d2FyZSB0YWctYmFzZWQgS0FTQU4NCiB+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCiANCi0tIA0KMi4xOC4wDQo=

