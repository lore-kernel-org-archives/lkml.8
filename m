Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA92C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B89206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A70grOx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBUJws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:52:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1625 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728171AbgBUJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:52:44 -0500
X-UUID: 6bb28f5c8a264f0ba6d9b1cdfc35bc4d-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sd75wbeZl+AV0Luow8F4QTQlXnc6UMRhjSi0P4K7nFg=;
        b=A70grOx+Vgj+VOdsTBy58oI74c5gqB5wwLspHPdrT3yNrMltljskQ3fYmqfTOqDoUp02v4VDhms68JJWpyS2dik+Vh9u4+y6SfUxZktNCoGMXW04digB7AVIeocDArwGZsZKvOUJvZsDOJbusWVaJAWW8GiwiTtc1tcE/5Qu0wQ=;
X-UUID: 6bb28f5c8a264f0ba6d9b1cdfc35bc4d-20200221
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1557108463; Fri, 21 Feb 2020 17:52:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 17:51:49 +0800
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
        Evan Green <evgreen@chromium.org>,
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
Subject: [PATCH 2/5] dt-bindings: clock: mediatek: document clk bindings mipi0a for Mediatek MT6765 SoC
Date:   Fri, 21 Feb 2020 17:52:19 +0800
Message-ID: <1582278742-1626-3-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6EF3A2C9A3E4B05AF86BEA1F7204146E58EE0C656601566BA5EB8AEA4259B1CB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIG1pcGkwYS4NCg0K
U2lnbmVkLW9mZi1ieTogTWFycyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBPd2VuIENoZW4gPG93ZW4uY2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtaXBpMGEudHh0IHwgMjggKysrKysrKysrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVk
aWF0ZWssbWlwaTBhLnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtaXBpMGEudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtaXBpMGEudHh0DQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi44YmU1OTc4ZjM4OGQNCi0t
LSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
bWVkaWF0ZWsvbWVkaWF0ZWssbWlwaTBhLnR4dA0KQEAgLTAsMCArMSwyOCBAQA0KK01lZGlhdGVr
IG1pcGkwYSAobWlwaV9yeF9hbmFfY3NpMGEpIGNvbnRyb2xsZXINCis9PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQorDQorVGhlIE1lZGlhdGVrIG1pcGkwYSBjb250cm9sbGVyIHByb3ZpZGVz
IHZhcmlvdXMgY2xvY2tzDQordG8gdGhlIHN5c3RlbS4NCisNCitSZXF1aXJlZCBQcm9wZXJ0aWVz
Og0KKw0KKy0gY29tcGF0aWJsZTogU2hvdWxkIGJlIG9uZSBvZjoNCisJLSAibWVkaWF0ZWssbXQ2
NzY1LW1pcGkwYSIsICJzeXNjb24iDQorLSAjY2xvY2stY2VsbHM6IE11c3QgYmUgMQ0KKw0KK1Ro
ZSBtaXBpMGEgY29udHJvbGxlciB1c2VzIHRoZSBjb21tb24gY2xrIGJpbmRpbmcgZnJvbQ0KK0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9jbG9jay1iaW5kaW5ncy50eHQN
CitUaGUgYXZhaWxhYmxlIGNsb2NrcyBhcmUgZGVmaW5lZCBpbiBkdC1iaW5kaW5ncy9jbG9jay9t
dCotY2xrLmguDQorDQorVGhlIG1pcGkwYSBjb250cm9sbGVyIGFsc28gdXNlcyB0aGUgY29tbW9u
IHBvd2VyIGRvbWFpbiBmcm9tDQorRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9tZWRpYXRlay9zY3BzeXMudHh0DQorVGhlIGF2YWlsYWJsZSBwb3dlciBkb2FtaW5zIGFyZSBk
ZWZpbmVkIGluIGR0LWJpbmRpbmdzL3Bvd2VyL210Ki1wb3dlci5oLg0KKw0KK0V4YW1wbGU6DQor
DQorbWlwaTBhOiBjbG9jay1jb250cm9sbGVyQDExYzEwMDAwIHsNCisJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDY3NjUtbWlwaTBhIiwgInN5c2NvbiI7DQorCXJlZyA9IDwwIDB4MTFjMTAwMDAg
MCAweDEwMDA+Ow0KKwlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ2NzY1X1BPV0VSX0RPTUFJ
Tl9DQU0+Ow0KKwkjY2xvY2stY2VsbHMgPSA8MT47DQorfTsNCi0tIA0KMi4xOC4wDQo=

