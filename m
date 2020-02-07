Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E61C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1EA20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AmU+xApi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgBGJXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:23:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:16154 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727317AbgBGJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:23:41 -0500
X-UUID: 538250e99a084d5c8fc314afd030e7c6-20200207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3Tkr6e9rb/dUfTV13i8VM6oxiTD9zYHT6ieIpP2gK9I=;
        b=AmU+xApihU6SPN+CtZ0W7/2xqIHTGu/kniXiKfJPS7XbvyetXNsnpvYVFrxuQXEcwncOm1Lz6JNHvY8h0+rt2EmlXnXuDfRDaK7baLUXX/TKRRKJX2IxUUCszxW9VrHgjezuhzvHdeCPMG5hvkApJRu1PaGs+VT+qUMRFQPL88k=;
X-UUID: 538250e99a084d5c8fc314afd030e7c6-20200207
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 216090181; Fri, 07 Feb 2020 17:23:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Feb 2020 17:24:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Feb 2020 17:22:58 +0800
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
Subject: [PATCH v7 2/7] dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
Date:   Fri, 7 Feb 2020 17:20:45 +0800
Message-ID: <1581067250-12744-3-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFycyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQoNClRoaXMgcGF0Y2gg
YWRkcyBNVDY3NjUgc21pIGJpbmRpbmcgZG9jdW1lbnQNCg0KU2lnbmVkLW9mZi1ieTogTWFycyBD
aGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBPd2VuIENoZW4g
PG93ZW4uY2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFj
cGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5l
bC5vcmc+DQotLS0NCiAuLi4vYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNt
aS1jb21tb24udHh0ICAgICAgICAgIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVt
b3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9u
LnR4dA0KaW5kZXggYjQ3OGFkZTRkYTY1Li4zZjk2ZDFlNzY4ZWEgMTAwNjQ0DQotLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVr
LHNtaS1jb21tb24udHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0DQpAQCAtMTgsNiArMTgs
NyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0gY29tcGF0aWJsZSA6IG11c3QgYmUgb25lIG9m
IDoNCiAJIm1lZGlhdGVrLG10MjcwMS1zbWktY29tbW9uIg0KIAkibWVkaWF0ZWssbXQyNzEyLXNt
aS1jb21tb24iDQorCSJtZWRpYXRlayxtdDY3NjUtc21pLWNvbW1vbiIsICJzeXNjb24iDQogCSJt
ZWRpYXRlayxtdDc2MjMtc21pLWNvbW1vbiIsICJtZWRpYXRlayxtdDI3MDEtc21pLWNvbW1vbiIN
CiAJIm1lZGlhdGVrLG10ODE3My1zbWktY29tbW9uIg0KIAkibWVkaWF0ZWssbXQ4MTgzLXNtaS1j
b21tb24iDQotLSANCjIuMTguMA0K

