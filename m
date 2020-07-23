Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A8C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DD52080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J4fD4muL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbgGWDkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:40:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52199 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729401AbgGWDkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:40:24 -0400
X-UUID: 737d4f6c68a94867af005257d8e939a5-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ujPNIMbWH3zYMxKQiDHMi/v6JaPz8xZ2W6SlEARO0Ys=;
        b=J4fD4muLZ/CL7RMTPilmr/hjAssMU+spcDNKJkmd775RpvRbGI2yYl5nWFdT0P+1o9bNJ9jDx7+4mf/WR3td9GksCbR1xtZuBU5CCrUiisrGsEC9vPsWgJ09thaIF3H6/ESfcLhgm3Va/CByVG1M5Y4lhyS+kitYIq2gv8Y+AHk=;
X-UUID: 737d4f6c68a94867af005257d8e939a5-20200723
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1838965390; Thu, 23 Jul 2020 11:40:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:40:18 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 11:40:15 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: [PATCH v2 3/4] dt-bindings: mediatek: add compatible for MT6873/8192 pwrap
Date:   Thu, 23 Jul 2020 11:39:59 +0800
Message-ID: <1595475600-23180-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIGR0LWJpbmRpbmcgZG9jdW1lbnRhdGlvbiBvZiBwd3JhcCBmb3IgTWVkaWF0ZWsg
TVQ2ODczLzgxOTINClNvQ3MgUGxhdGZvcm0uDQoNClNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5n
IFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvYy9tZWRpYXRlay9wd3JhcC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dA0KaW5kZXggZWNhYzJiYi4uODA1MWMxNyAxMDA2
NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsv
cHdyYXAudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL3B3cmFwLnR4dA0KQEAgLTIyLDYgKzIyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllcyBp
biBwd3JhcCBkZXZpY2Ugbm9kZS4NCiAJIm1lZGlhdGVrLG10Njc2NS1wd3JhcCIgZm9yIE1UNjc2
NSBTb0NzDQogCSJtZWRpYXRlayxtdDY3NzktcHdyYXAiIGZvciBNVDY3NzkgU29Dcw0KIAkibWVk
aWF0ZWssbXQ2Nzk3LXB3cmFwIiBmb3IgTVQ2Nzk3IFNvQ3MNCisJIm1lZGlhdGVrLG10Njg3My1w
d3JhcCIgZm9yIE1UNjg3My84MTkyIFNvQ3MNCiAJIm1lZGlhdGVrLG10NzYyMi1wd3JhcCIgZm9y
IE1UNzYyMiBTb0NzDQogCSJtZWRpYXRlayxtdDgxMzUtcHdyYXAiIGZvciBNVDgxMzUgU29Dcw0K
IAkibWVkaWF0ZWssbXQ4MTczLXB3cmFwIiBmb3IgTVQ4MTczIFNvQ3MNCi0tIA0KMi42LjQNCg==

