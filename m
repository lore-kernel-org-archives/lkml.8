Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06794C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C789E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f8QOemF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgG0HQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:16:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35255 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727091AbgG0HQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:49 -0400
X-UUID: a4fb24737e4a43cd875755d57ae76d1a-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kMaydL2v9BshbyUReMb3wcjNfslH3HmUZia9G0XRnJc=;
        b=f8QOemF0Ybi/R3Y2gLV5RrHQgGd+/QS0DvA6FC9LbwHengawHYgF+FJWwfSogANP+W+OqSti5+7s1a33onQGtna3AAXxOFSlbAVpbudpfpxOSTqgEBQm1DNSW0SmDrRm32K7zgh6/Btvths5HYA6bSJBIQPp4iCdJTmGtT7yw/U=;
X-UUID: a4fb24737e4a43cd875755d57ae76d1a-20200727
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 32602630; Mon, 27 Jul 2020 15:16:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:43 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 11/11] usb: mtu3: simplify mtu3_req_complete()
Date:   Mon, 27 Jul 2020 15:15:00 +0800
Message-ID: <1595834101-13094-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B2FBB65A761F5069A6267965A8BC72CF8580797430EE14138B9473B4676492382000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGFyZ3VtZW50IHJlcSBkaXJlY3RseSBpbnN0ZWFkIG9mIG1yZXEtPnJlcXVlc3QsIHRoZXkN
CmFyZSB0aGUgc2FtZSB1c2IgcmVxdWVzdC4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvbXR1My9tdHUz
X2dhZGdldC5jIHwgMTcgKysrKysrKy0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210
dTMvbXR1M19nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0KaW5kZXgg
NzNhODUzNi4uMWRlNWM5YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRn
ZXQuYw0KKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jDQpAQCAtMTUsMTUgKzE1
LDEzIEBAIHZvaWQgbXR1M19yZXFfY29tcGxldGUoc3RydWN0IG10dTNfZXAgKm1lcCwNCiBfX3Jl
bGVhc2VzKG1lcC0+bXR1LT5sb2NrKQ0KIF9fYWNxdWlyZXMobWVwLT5tdHUtPmxvY2spDQogew0K
LQlzdHJ1Y3QgbXR1M19yZXF1ZXN0ICptcmVxOw0KLQlzdHJ1Y3QgbXR1MyAqbXR1Ow0KKwlzdHJ1
Y3QgbXR1M19yZXF1ZXN0ICptcmVxID0gdG9fbXR1M19yZXF1ZXN0KHJlcSk7DQorCXN0cnVjdCBt
dHUzICptdHUgPSBtcmVxLT5tdHU7DQogDQotCW1yZXEgPSB0b19tdHUzX3JlcXVlc3QocmVxKTsN
CiAJbGlzdF9kZWwoJm1yZXEtPmxpc3QpOw0KLQlpZiAobXJlcS0+cmVxdWVzdC5zdGF0dXMgPT0g
LUVJTlBST0dSRVNTKQ0KLQkJbXJlcS0+cmVxdWVzdC5zdGF0dXMgPSBzdGF0dXM7DQorCWlmIChy
ZXEtPnN0YXR1cyA9PSAtRUlOUFJPR1JFU1MpDQorCQlyZXEtPnN0YXR1cyA9IHN0YXR1czsNCiAN
Ci0JbXR1ID0gbXJlcS0+bXR1Ow0KIAl0cmFjZV9tdHUzX3JlcV9jb21wbGV0ZShtcmVxKTsNCiAJ
c3Bpbl91bmxvY2soJm10dS0+bG9jayk7DQogDQpAQCAtMzEsMTEgKzI5LDEwIEBAIHZvaWQgbXR1
M19yZXFfY29tcGxldGUoc3RydWN0IG10dTNfZXAgKm1lcCwNCiAJaWYgKG1lcC0+ZXBudW0pDQog
CQl1c2JfZ2FkZ2V0X3VubWFwX3JlcXVlc3QoJm10dS0+ZywgcmVxLCBtZXAtPmlzX2luKTsNCiAN
Ci0JZGV2X2RiZyhtdHUtPmRldiwgIiVzIGNvbXBsZXRlIHJlcTogJXAsIHN0cyAlZCwgJWQvJWRc
biIsIG1lcC0+bmFtZSwNCi0JCXJlcSwgcmVxLT5zdGF0dXMsIG1yZXEtPnJlcXVlc3QuYWN0dWFs
LCBtcmVxLT5yZXF1ZXN0Lmxlbmd0aCk7DQotDQotCXVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVz
dCgmbWVwLT5lcCwgJm1yZXEtPnJlcXVlc3QpOw0KKwlkZXZfZGJnKG10dS0+ZGV2LCAiJXMgY29t
cGxldGUgcmVxOiAlcCwgc3RzICVkLCAlZC8lZFxuIiwNCisJCW1lcC0+bmFtZSwgcmVxLCByZXEt
PnN0YXR1cywgcmVxLT5hY3R1YWwsIHJlcS0+bGVuZ3RoKTsNCiANCisJdXNiX2dhZGdldF9naXZl
YmFja19yZXF1ZXN0KCZtZXAtPmVwLCByZXEpOw0KIAlzcGluX2xvY2soJm10dS0+bG9jayk7DQog
fQ0KIA0KLS0gDQoxLjkuMQ0K

