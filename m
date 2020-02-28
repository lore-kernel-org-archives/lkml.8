Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F280C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED35C246B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WIKrN8Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgB1NpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59345 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726981AbgB1NpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:10 -0500
X-UUID: f2d6b9132802458caae2f315ebfe2906-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J3RECQ0d49qohwUAI6HrEdpeiz9kkXmR7Kg62M4vxiA=;
        b=WIKrN8Q5YrtZkjMaotXjbdYt2BR25mFI1vbgi60EqB9IQv/poEt2hggUOfgQ/OcfnO3HsrAdtkMp031hL9td9rLAiRiLaeZsUf5XHx2KmRWp8p2YiKxGgDq7nkx5QWP195MoTO+mXN2wnVB/uLrQUIroBJF9Ag1es95uukr7Knk=;
X-UUID: f2d6b9132802458caae2f315ebfe2906-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1824332077; Fri, 28 Feb 2020 21:45:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:45:04 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 05/13] soc: mediatek: cmdq: return send msg error code
Date:   Fri, 28 Feb 2020 21:44:13 +0800
Message-ID: <1582897461-15105-7-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV0dXJuIGVycm9yIGNvZGUgdG8gY2xpZW50IGlmIHNlbmQgbWVzc2FnZSBmYWlsLA0Kc28gdGhh
dCBjbGllbnQgaGFzIGNoYW5jZSB0byBlcnJvciBoYW5kbGluZy4NCg0KRml4ZXM6IDU3NmYxYjRi
YzgwMiAoInNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBDTURRIGhlbHBlciIpDQpTaWduZWQt
b2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDQgKystLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCAyZTFiYzUxMzU2OWIuLjA2OTg2MTJk
ZTVhZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTM1MSwx
MSArMzUxLDExIEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNs
aWVudC0+bG9jaywgZmxhZ3MpOw0KIAl9DQogDQotCW1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+
Y2hhbiwgcGt0KTsNCisJZXJyID0gbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFuLCBwa3Qp
Ow0KIAkvKiBXZSBjYW4gc2VuZCBuZXh0IHBhY2tldCBpbW1lZGlhdGVseSwgc28ganVzdCBjYWxs
IHR4ZG9uZS4gKi8NCiAJbWJveF9jbGllbnRfdHhkb25lKGNsaWVudC0+Y2hhbiwgMCk7DQogDQot
CXJldHVybiAwOw0KKwlyZXR1cm4gZXJyOw0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Zs
dXNoX2FzeW5jKTsNCiANCi0tIA0KMi4xOC4wDQo=

