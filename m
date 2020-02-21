Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE69C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A117E206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z4hJsZzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgBUJwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:52:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40966 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728112AbgBUJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:52:44 -0500
X-UUID: 9fb8f3eba6bf417a97cf3fdcc6ec24bb-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BrZcb3r5iiNqUF/+IfFU/CLqa5IbDW64XUPBanNrNKQ=;
        b=Z4hJsZzp5xGzAlTQJmcKQ32AhhktdpHqZPyz7C76WdeFcZeA3pVU6qCpD6RgvkScrNeYQOJcIIlEoZSMXo7NuTJfj2833IOetO7WAFMxhCCywA+5jXqjUthbD9fJpBk09M25s1kve/KPc/08KKhuxZjEV9E2zZz0/FS8Q+IS0co=;
X-UUID: 9fb8f3eba6bf417a97cf3fdcc6ec24bb-20200221
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 266834368; Fri, 21 Feb 2020 17:52:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 17:53:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Feb 2020 17:52:59 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Evan Green" <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH 3/5] dt-bindings: clock: mediatek: document clk bindings vcodecsys for Mediatek MT6765 SoC
Date:   Fri, 21 Feb 2020 17:52:20 +0800
Message-ID: <1582278742-1626-4-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHZjb2RlY3N5cy4N
Cg0KU2lnbmVkLW9mZi1ieTogTWFycyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBPd2VuIENoZW4gPG93ZW4uY2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQt
b2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L2FybS9tZWRpYXRlay9tZWRpYXRlayx2Y29kZWNzeXMudHh0ICAgICAgIHwgMjcgKysrKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssdmNvZGVjc3lzLnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayx2Y29kZWNzeXMudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayx2Y29k
ZWNzeXMudHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5jODc3
YmNjMWE1YzUNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssdmNvZGVjc3lzLnR4dA0KQEAgLTAsMCArMSwy
NyBAQA0KK01lZGlhdGVrIHZjb2RlY3N5cyBjb250cm9sbGVyDQorPT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KKw0KK1RoZSBNZWRpYXRlayB2Y29kZWNzeXMgY29udHJvbGxlciBwcm92aWRl
cyB2YXJpb3VzIGNsb2NrcyB0byB0aGUgc3lzdGVtLg0KKw0KK1JlcXVpcmVkIFByb3BlcnRpZXM6
DQorDQorLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9mOg0KKwktICJtZWRpYXRlayxtdDY3
NjUtdmNvZGVjc3lzIiwgInN5c2NvbiINCistICNjbG9jay1jZWxsczogTXVzdCBiZSAxDQorDQor
VGhlIHZjb2RlY3N5cyBjb250cm9sbGVyIHVzZXMgdGhlIGNvbW1vbiBjbGsgYmluZGluZyBmcm9t
DQorRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdz
LnR4dA0KK1RoZSBhdmFpbGFibGUgY2xvY2tzIGFyZSBkZWZpbmVkIGluIGR0LWJpbmRpbmdzL2Ns
b2NrL210Ki1jbGsuaC4NCisNCitUaGUgdmNvZGVjc3lzIGNvbnRyb2xsZXIgYWxzbyB1c2VzIHRo
ZSBjb21tb24gcG93ZXIgZG9tYWluIGZyb20NCitEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQNCitUaGUgYXZhaWxhYmxlIHBvd2VyIGRvYW1p
bnMgYXJlIGRlZmluZWQgaW4gZHQtYmluZGluZ3MvcG93ZXIvbXQqLXBvd2VyLmguDQorDQorRXhh
bXBsZToNCisNCit2ZW5jX2djb246IGNsb2NrLWNvbnRyb2xsZXJAMTcwMDAwMDAgew0KKwljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10Njc2NS12Y29kZWNzeXMiLCAic3lzY29uIjsNCisJcmVnID0g
PDAgMHgxNzAwMDAwMCAwIDB4MTAwMDA+Ow0KKwlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ2
NzY1X1BPV0VSX0RPTUFJTl9WQ09ERUM+Ow0KKwkjY2xvY2stY2VsbHMgPSA8MT47DQorfTsNCi0t
IA0KMi4xOC4wDQo=

