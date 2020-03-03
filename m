Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC61C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541CB20873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mxq2Qlly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgCCK7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:59:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58843 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728997AbgCCK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:59:08 -0500
X-UUID: 6d615449cff748039ec5737dcba619b3-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kifZaGetXK2dzqmjkrlt+tzZFVDWnSdx6q8HZB4siVk=;
        b=Mxq2QllyU3tw36s2vTaR59j3iuoaP/3WGBqThw29dbD/QGx2S9Rzy4Gpf4CczXkf+C5n/NdMmg7Q1yEmLYyNvM0FfMXQFUzk+vbAZOICRMOcWujHsvSemu13/M3SKeVkBVoDAnjWjVerS0INYwgm8LSLjPla9/qXOENWhORV9Ag=;
X-UUID: 6d615449cff748039ec5737dcba619b3-20200303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 689657969; Tue, 03 Mar 2020 18:59:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 19:00:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:58:11 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        "CK Hu" <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v4 05/13] soc: mediatek: cmdq: return send msg error code
Date:   Tue, 3 Mar 2020 18:58:37 +0800
Message-ID: <1583233125-7827-6-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
NmYxYjRiYzgwMiAoInNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBDTURRIGhlbHBlciIpDQot
LS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDQgKysrLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDJlMWJjNTEzNTY5Yi4uOThmMjNiYTNi
YTQ3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMN
CisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMzUxLDcg
KzM1MSw5IEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
Y21kcV9hc3luY19mbHVzaF9jYiBjYiwNCiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNsaWVu
dC0+bG9jaywgZmxhZ3MpOw0KIAl9DQogDQotCW1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hh
biwgcGt0KTsNCisJZXJyID0gbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFuLCBwa3QpOw0K
KwlpZiAoZXJyIDwgMCkNCisJCXJldHVybiBlcnI7DQogCS8qIFdlIGNhbiBzZW5kIG5leHQgcGFj
a2V0IGltbWVkaWF0ZWx5LCBzbyBqdXN0IGNhbGwgdHhkb25lLiAqLw0KIAltYm94X2NsaWVudF90
eGRvbmUoY2xpZW50LT5jaGFuLCAwKTsNCiANCi0tIA0KMi4xOC4wDQo=

