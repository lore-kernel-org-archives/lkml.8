Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95AC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D69206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MDZToudB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgBUJwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:52:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:23893 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726989AbgBUJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:52:35 -0500
X-UUID: 2e534da1a58c42bda6f01e4e9cc0387f-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d/WFlzDa3S2eOt2IkKMzp95187HzPikccPGAx6OY+ks=;
        b=MDZToudBH8ip+Ztx5jNMegXDvOZNGAMvN2YSA9j7SdkhRJA9toKJyYU091jbnDz6+3yP6cNlVwJtPsKicJWXzb4O55PPaVCnZtN/ztpJCfVf0DdMR7N4kNm545HiUcexjsajfF1U1lCZ4mfdvBpW1SHGkBnZjqGIvymKT/7rNto=;
X-UUID: 2e534da1a58c42bda6f01e4e9cc0387f-20200221
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 946751563; Fri, 21 Feb 2020 17:52:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 17:51:43 +0800
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
Subject: [PATCH 0/5] Add basic clock support for mt6765
Date:   Fri, 21 Feb 2020 17:52:17 +0800
Message-ID: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXQgYWRkcyBiYXNpYyBjbG9jayBzdXBwb3J0IGZvciBNZWRpYXRlaydzIG5l
dyA4LWNvcmUgU29DLA0KTVQ2NzY1LCB3aGljaCBpcyBtYWlubHkgZm9yIHNtYXJ0cGhvbmUgYXBw
bGljYXRpb24uIFdoaWNoIGhhcyBiZWVuDQpzcGxpdCBmcm9tIHByZXZpb3VzIHBhdGNoIHNldCB2
NzogQWRkIGJhc2ljIFNvQyBzdXBwb3J0IGZvciBtdDY3NjUuDQoNCiAgaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9jb3Zlci8xMTM3MDEwNS8NCg0KQ2hhbmdlcyBpbiB0aGlzIHBhdGNoIHNl
dDoNCjEuIFRha2UgcGF0Y2hlcyAjMSwgIzMsICM0IGZyb20gb3JpZ2luIHBhdGNoIHNldC4NCiAg
LSBbdjcsMS83XSBkdC1iaW5kaW5nczogY2xvY2s6IG1lZGlhdGVrOiBkb2N1bWVudCBjbGsgYmlu
ZGluZ3MgZm9yDQogICAgTWVkaWF0ZWsgTVQ2NzY1IFNvQw0KICAtIFt2NywzLzddIGNsazogbWVk
aWF0ZWs6IGFkZCBtdDY3NjUgY2xvY2sgSURzDQogIC0gW3Y3LDQvN10gY2xrOiBtZWRpYXRlazog
QWRkIE1UNjc2NSBjbG9jayBzdXBwb3J0DQoyLiBTcGxpdCBvcmlnaW4gcGF0Y2ggIzEgaW50byAz
IHBhdGNoZXM6DQogIC0gW1BBVENIIDEvNV0gZHQtYmluZGluZ3M6IGNsb2NrOiBtZWRpYXRlazog
ZG9jdW1lbnQgY2xrIGJpbmRpbmdzIGZvcg0KICAgIE1lZGlhdGVrIE1UNjc2NSBTb0MNCiAgLSBb
UEFUQ0ggMi81XSBkdC1iaW5kaW5nczogY2xvY2s6IG1lZGlhdGVrOiBkb2N1bWVudCBjbGsgYmlu
ZGluZ3MNCiAgICBtaXBpMGEgZm9yIE1lZGlhdGVrIE1UNjc2NSBTb0MNCiAgLSBbUEFUQ0ggMy81
XSBkdC1iaW5kaW5nczogY2xvY2s6IG1lZGlhdGVrOiBkb2N1bWVudCBjbGsgYmluZGluZ3MgDQog
ICAgdmNvZGVjc3lzIGZvciBNZWRpYXRlayBNVDY3NjUgU29DDQoNCk1hY3BhdWwgTGluICgzKToN
CiAgZHQtYmluZGluZ3M6IGNsb2NrOiBtZWRpYXRlazogZG9jdW1lbnQgY2xrIGJpbmRpbmdzIGZv
ciBNZWRpYXRlaw0KICAgIE1UNjc2NSBTb0MNCiAgZHQtYmluZGluZ3M6IGNsb2NrOiBtZWRpYXRl
azogZG9jdW1lbnQgY2xrIGJpbmRpbmdzIG1pcGkwYSBmb3INCiAgICBNZWRpYXRlayBNVDY3NjUg
U29DDQogIGR0LWJpbmRpbmdzOiBjbG9jazogbWVkaWF0ZWs6IGRvY3VtZW50IGNsayBiaW5kaW5n
cyB2Y29kZWNzeXMgZm9yDQogICAgTWVkaWF0ZWsgTVQ2NzY1IFNvQw0KDQpNYXJzIENoZW5nICgx
KToNCiAgY2xrOiBtZWRpYXRlazogYWRkIG10Njc2NSBjbG9jayBJRHMNCg0KT3dlbiBDaGVuICgx
KToNCiAgY2xrOiBtZWRpYXRlazogQWRkIE1UNjc2NSBjbG9jayBzdXBwb3J0DQoNCiAuLi4vYXJt
L21lZGlhdGVrL21lZGlhdGVrLGFwbWl4ZWRzeXMudHh0ICAgICAgfCAgIDEgKw0KIC4uLi9iaW5k
aW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXVkc3lzLnR4dCB8ICAgMSArDQogLi4uL2JpbmRp
bmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxjYW1zeXMudHh0IHwgICAxICsNCiAuLi4vYmluZGlu
Z3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltZ3N5cy50eHQgfCAgIDEgKw0KIC4uLi9hcm0vbWVk
aWF0ZWsvbWVkaWF0ZWssaW5mcmFjZmcudHh0ICAgICAgICB8ICAgMSArDQogLi4uL2JpbmRpbmdz
L2FybS9tZWRpYXRlay9tZWRpYXRlayxtaXBpMGEudHh0IHwgIDI4ICsNCiAuLi4vYmluZGluZ3Mv
YXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnR4dCAgfCAgIDEgKw0KIC4uLi9hcm0vbWVkaWF0
ZWsvbWVkaWF0ZWsscGVyaWNmZy50eHQgICAgICAgICB8ICAgMSArDQogLi4uL2FybS9tZWRpYXRl
ay9tZWRpYXRlayx0b3Bja2dlbi50eHQgICAgICAgIHwgICAxICsNCiAuLi4vYXJtL21lZGlhdGVr
L21lZGlhdGVrLHZjb2RlY3N5cy50eHQgICAgICAgfCAgMjcgKw0KIGRyaXZlcnMvY2xrL21lZGlh
dGVrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICA4NiArKw0KIGRyaXZlcnMvY2xrL21lZGlh
dGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgNyArDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS1hdWRpby5jICAgICAgIHwgMTAwICsrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS1jYW0uYyAgICAgICAgIHwgIDc0ICsrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS1pbWcuYyAgICAgICAgIHwgIDcwICsrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS1taXBpMGEuYyAgICAgIHwgIDY4ICsrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS1tbS5jICAgICAgICAgIHwgIDk2ICsrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS12Y29kZWMuYyAgICAgIHwgIDcwICsrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc2NS5jICAgICAgICAgICAgIHwgOTUyICsrKysrKysrKysrKysrKysrKw0KIGlu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svbXQ2NzY1LWNsay5oICAgICAgICB8IDMxMyArKysrKysN
CiAyMCBmaWxlcyBjaGFuZ2VkLCAxODk5IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxtaXBpMGEudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssdmNvZGVjc3lzLnR4dA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ2NzY1LWF1ZGlvLmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1jYW0uYw0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ2NzY1LWltZy5jDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NjUtbWlwaTBh
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1t
bS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NjUt
dmNvZGVjLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10
Njc2NS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svbXQ2
NzY1LWNsay5oDQoNCi0tIA0KMi4xOC4wDQo=

