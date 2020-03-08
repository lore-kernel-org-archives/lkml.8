Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45A0C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F613206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hPhl5TmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCHKxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbgCHKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:08 -0400
X-UUID: aedaf8e80a9d47f488ebba9dfabe1ca8-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VNxu4N+sL8Y+MzbMsqUqt3FdmiLX1P8n7M4pclhKAa4=;
        b=hPhl5TmTFmI8y1xBYGQd9Art2A100sz1HvtHtswm711oMZbZpjPpJdiXhHsWCH4NCB6k9HEcUfkMDU328Wv8IHHUMMt5JeDm3ytxWIeV64OZd2GBHKgA8eUO+AF5swGI0jrwxPy66zJIFAvMJFL+XZ4nRYF+1GcrYz6EGNfugzw=;
X-UUID: aedaf8e80a9d47f488ebba9dfabe1ca8-20200308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 210657906; Sun, 08 Mar 2020 18:53:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:51:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:58 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v5 05/13] soc: mediatek: cmdq: return send msg error code
Date:   Sun, 8 Mar 2020 18:52:47 +0800
Message-ID: <1583664775-19382-6-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV0dXJuIGVycm9yIGNvZGUgdG8gY2xpZW50IGlmIHNlbmQgbWVzc2FnZSBmYWlsLA0Kc28gdGhh
dCBjbGllbnQgaGFzIGNoYW5jZSB0byBlcnJvciBoYW5kbGluZy4NCg0KU2lnbmVkLW9mZi1ieTog
RGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KRml4ZXM6IDU3
NmYxYjRiYzgwMiAoInNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBDTURRIGhlbHBlciIpDQpS
ZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgNCArKystDQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KaW5kZXggMmUxYmM1MTM1NjliLi45OGYyM2JhM2JhNDcgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0zNTEsNyArMzUxLDkgQEAgaW50IGNt
ZHFfcGt0X2ZsdXNoX2FzeW5jKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBjbWRxX2FzeW5jX2ZsdXNo
X2NiIGNiLA0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2xpZW50LT5sb2NrLCBmbGFncyk7
DQogCX0NCiANCi0JbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFuLCBwa3QpOw0KKwllcnIg
PSBtYm94X3NlbmRfbWVzc2FnZShjbGllbnQtPmNoYW4sIHBrdCk7DQorCWlmIChlcnIgPCAwKQ0K
KwkJcmV0dXJuIGVycjsNCiAJLyogV2UgY2FuIHNlbmQgbmV4dCBwYWNrZXQgaW1tZWRpYXRlbHks
IHNvIGp1c3QgY2FsbCB0eGRvbmUuICovDQogCW1ib3hfY2xpZW50X3R4ZG9uZShjbGllbnQtPmNo
YW4sIDApOw0KIA0KLS0gDQoyLjE4LjANCg==

