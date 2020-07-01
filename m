Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D16FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FB5206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rEaeYDgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGAH0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:26:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20815 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728134AbgGAH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:26:33 -0400
X-UUID: b323193e43934ad79f4ffc0df7ab6cd6-20200701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VL5d6lLeGopD4HIkyqvfbVptB3CsYRUzy8Dr5Sd2JJU=;
        b=rEaeYDgcXg/lmWlg0FOoLMNem2zKEvZ7ph+/W71AQdx7g/z1n6L7rMBhcUTKbZgYIIPhcPBIqocDBDGPA2F+sN3xhMlXojwhkRz87z2Jkzhmwl9L1YmKoBK3J99Rnq5PyMtGPJDEDpAS63KhkLoYewexRh1EAFG4kkGTZIcRxk8=;
X-UUID: b323193e43934ad79f4ffc0df7ab6cd6-20200701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1125695450; Wed, 01 Jul 2020 15:26:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jul 2020 15:26:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Jul 2020 15:26:25 +0800
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH] clk: Export clk_register_composite() for mediatek's clock kernel module 
Date:   Wed, 1 Jul 2020 15:26:20 +0800
Message-ID: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9D5D81090939DA874C6280A1A0B39A63DE2E4F3CA7B2AE57ECCE36D2AEAF2A502000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYmFzZWQgb24gNS44LXJjMQ0KVGhpcyBwYXRjaCBleHBvcnRzIGNsa19yZWdp
c3Rlcl9jb21wb3NpdGUoKSBhbmQgY29tbW9uIEFQSXMgZnJvbQ0KTWVkaWF0ZWsgY2xvY2sgZHJp
dmVyLiBjbGtfcmVnaXN0ZXJfY29tcG9zaXRlKCkgd2lsbCBiZSB1c2VkIGluDQptZWRpYXRlaydz
IGNsb2NrIGtlcm5lbCBtb2R1bGUsIHNvIGV4cG9ydCBpdCB0byBHUEwgbW9kdWxlcy4NCg0KV2Vu
ZGVsbCBMaW4gKDIpOg0KICBjbGs6IEV4cG9ydCBjbGtfcmVnaXN0ZXJfY29tcG9zaXRlDQogIGNs
azogbWVkaWF0ZWs6IEFkZCBFWFBPUlRfU1lNQk9MIGZvciBrZXJuZWwgbW9kdWxlIHN1cHBvcnQN
Cg0KIGRyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYyAgICB8ICAgIDEgKw0KIGRyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdGsuYyB8ICAgMTMgKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKQ0K

