Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB3C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2982070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rSYzHfCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGQDGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:06:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30662 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726234AbgGQDGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:06:04 -0400
X-UUID: e61b82272dfa4509bbb73bac49c1678c-20200717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t9o2FdJXwcbqzGRSqC/DhbwRSqIgmv4tqx6/dVxqFvg=;
        b=rSYzHfCOTv/Pf9Suanvu3zVeZ06JVQFFCjuFqnmF+7nyNfzngS82L3R/CCS0g6HzEY7woVvXKk6PpJUgOeL4ChZIR5cFpiydKaxf6ee2fSKG/gUTcsDCKsuRw9uvMMi0EeDH0N2CFcXoXxTGZAu16qwcGoN4iXkePrkCzV9Iqro=;
X-UUID: e61b82272dfa4509bbb73bac49c1678c-20200717
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <huihui.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2073904000; Fri, 17 Jul 2020 11:06:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Jul 2020 11:05:07 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jul 2020 11:05:04 +0800
From:   Huihui Wang <huihui.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, huihui wang <huihui.wang@mediatek.com>
Subject: [PATCH v1 1/2] dt-bindings: dma: mediatek: mark useless items as decrepted
Date:   Fri, 17 Jul 2020 11:02:03 +0800
Message-ID: <20200717030203.14872-2-huihui.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200717030203.14872-1-huihui.wang@mediatek.com>
References: <20200717030203.14872-1-huihui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3238CAB02A174EE6A9E2CA063F0BC6AC39A032DEDA1D383A4A48265D72AAF93E2000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogaHVpaHVpIHdhbmcgPGh1aWh1aS53YW5nQG1lZGlhdGVrLmNvbT4NCg0KQmVjYXVzZSB3
ZSBtb3ZlIGRtYSBhZGRyZXNzIGJpdHMgY29uZmlnIHRvIG10ay11YXJ0LWFwZG1hLmMsDQppdCBp
cyB1bm5lY2Vzc2FyeSB0byBiZSBjb25maWd1cmVkIGluIGRldmljZSB0cmVlLg0KVXBkYXRlIHRo
ZSBkb2N1bWVudCBhdCB0aGUgc2FtZSB0aW1lLg0KDQpTaWduZWQtb2ZmLWJ5OiBodWlodWkgd2Fu
ZyA8aHVpaHVpLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvZG1hL210ay11YXJ0LWFwZG1hLnR4dCAgICAgICAgfCAxMSArKysrKy0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay11YXJ0LWFwZG1hLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLXVhcnQtYXBkbWEu
dHh0DQppbmRleCAyMTE3ZGIwY2U0ZjIuLjkyNmM4NmIyMWU4YyAxMDA2NDQNCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLXVhcnQtYXBkbWEudHh0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay11YXJ0LWFwZG1hLnR4
dA0KQEAgLTIsOCArMiw5IEBADQogDQogUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGli
bGUgc2hvdWxkIGNvbnRhaW46DQotICAqICJtZWRpYXRlayxtdDI3MTItdWFydC1kbWEiIGZvciBN
VDI3MTIgY29tcGF0aWJsZSBBUERNQQ0KLSAgKiAibWVkaWF0ZWssbXQ2NTc3LXVhcnQtZG1hIiBm
b3IgTVQ2NTc3IGFuZCBhbGwgb2YgdGhlIGFib3ZlDQorICAqICJtZWRpYXRlayxtdDI3MTItdWFy
dC1kbWEiIGZvciBNZWRpYVRlayBNVDI3MTINCisgICogIm1lZGlhdGVrLG10NjU3Ny11YXJ0LWRt
YSIgZm9yIE1lZGlhVGVrIE1UNjU3Nw0KKyAgKiAibWVkaWF0ZWssbXQ2Nzc5LXVhcnQtZG1hIiBm
b3IgTWVkaWFUZWsgTVQ2Nzc5DQogDQogLSByZWc6IFRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIEFQ
RE1BIHJlZ2lzdGVyIGJhbmsuDQogDQpAQCAtMTYsMTMgKzE3LDEyIEBAIFJlcXVpcmVkIHByb3Bl
cnRpZXM6DQogICBTZWUgLi4vY2xvY2tzL2Nsb2NrLWJpbmRpbmdzLnR4dCBmb3IgZGV0YWlscy4N
CiAtIGNsb2NrLW5hbWVzOiBUaGUgQVBETUEgY2xvY2sgZm9yIHJlZ2lzdGVyIGFjY2Vzc2VzDQog
DQotLSBtZWRpYXRlayxkbWEtMzNiaXRzOiBQcmVzZW50IGlmIHRoZSBETUEgcmVxdWlyZXMgc3Vw
cG9ydA0KKy0gbWVkaWF0ZWssZG1hLTMzYml0czogUHJlc2VudCBpZiB0aGUgRE1BIHJlcXVpcmVz
IHN1cHBvcnQgKGRlcHJlY2F0ZWQpDQogDQogRXhhbXBsZXM6DQogDQogCWFwZG1hOiBkbWEtY29u
dHJvbGxlckAxMTAwMDQwMCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi11YXJ0
LWRtYSIsDQotCQkJICAgICAibWVkaWF0ZWssbXQ2NTc3LXVhcnQtZG1hIjsNCisJCWNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ2Nzc5LXVhcnQtZG1hIjsNCiAJCXJlZyA9IDwwIDB4MTEwMDA0MDAg
MCAweDgwPiwNCiAJCSAgICAgIDwwIDB4MTEwMDA0ODAgMCAweDgwPiwNCiAJCSAgICAgIDwwIDB4
MTEwMDA1MDAgMCAweDgwPiwNCkBAIC01MCw2ICs1MCw1IEBAIEV4YW1wbGVzOg0KIAkJZG1hLXJl
cXVlc3RzID0gPDEyPjsNCiAJCWNsb2NrcyA9IDwmcGVyaWNmZyBDTEtfUEVSSV9BUF9ETUE+Ow0K
IAkJY2xvY2stbmFtZXMgPSAiYXBkbWEiOw0KLQkJbWVkaWF0ZWssZG1hLTMzYml0czsNCiAJCSNk
bWEtY2VsbHMgPSA8MT47DQogCX07DQotLSANCjIuMTguMA0K

