Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2652224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t43ETIaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHGMwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:52:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58663 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgHGMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:52:15 -0400
X-UUID: e2ce0aac34324cc4a86a3828c652b6b6-20200807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mztOhQW0Qq5rF36HzmEccKSTcbg3ytjmt1H64T/6/Fw=;
        b=t43ETIajGTKqWq9hYaCkVJTGesRh7ItdyoZ5aolm8/57Bkziyzfy2U/u0+7RQ/71pJm1ciMTVPc/wZWSKBavBMSfIbvpGSIAXSK0wEbevV3U+goJryIqUHkpJH8K1ORfEOyD3EBY7WxDrIZ4mv7iGA6hJRkut9rMbz0+uB7Vi4c=;
X-UUID: e2ce0aac34324cc4a86a3828c652b6b6-20200807
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2053474008; Fri, 07 Aug 2020 20:52:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Aug 2020 20:52:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Aug 2020 20:52:07 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, Daniel Palmer <daniel@0x0f.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH 0/2] irqchip: irq-mt58xx: Add mt58xx series interrupt
Date:   Fri, 7 Aug 2020 20:52:04 +0800
Message-ID: <20200807125204.2739-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <654a81dcefb3024d762ff338d4bd7f14@kernel.org>
References: <654a81dcefb3024d762ff338d4bd7f14@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCg0KPiBPbiAyMDIwLTA4LTA2IDE1
OjU4LCBEYW5pZWwgUGFsbWVyIHdyb3RlOg0KPiA+IEhpIE1hcmstUEssDQo+ID4gDQo+ID4gT24g
VGh1LCA2IEF1ZyAyMDIwIGF0IDIzOjA4LCBNYXJrLVBLIFRzYWkgPG1hcmstcGsudHNhaUBtZWRp
YXRlay5jb20+IA0KPiA+IHdyb3RlOg0KPiA+PiA+IERvIHlvdSBrbm93IGlmIGl0IHdvdWxkIGJl
IHBvc3NpYmxlIHRvIGNvbmZpcm0gaWYgdGhleSBhcmUNCj4gPj4gPiB0aGUNCj4gPj4gPiBzYW1l
IHRoaW5nPyBNZWRpYVRlayBib3VnaHQgTVN0YXIgYSBmZXcgeWVhcnMgYWdvIHNvIGl0IHNlZW1z
IGxpa2VseQ0KPiA+PiA+IGJ1dCBJIGhhdmUgbm8gaGFyZCBpbmZvcm1hdGlvbi4NCj4gPj4gPg0K
PiA+PiANCj4gPj4gWWVzLCBpdCdzIGZvciB0aGUgc2FtZSBpbnRlcnJ1cHQgY29udHJvbGxlciBJ
UC4NCj4gPiANCj4gPiBUaGF0J3MgZ29vZCBuZXdzLiA6KQ0KPiA+IA0KPiA+PiA+IElmIHRoZXkg
YXJlIHRoZSBzYW1lIHRoaW5nIGNvdWxkIHdlIHdvcmsgb24gbWFraW5nIG9uZSBzZXJpZXMgdGhh
dA0KPiA+PiA+IHN1cHBvcnRzIGJvdGggdXNlIGNhc2VzPw0KPiA+PiANCj4gPj4gU3VyZSwgYW5k
IEkgdGhpbmsgdGhlIGlycSBjb250cm9sbGVyIGRyaXZlciBzaG91bGQgc3VwcG9ydCBib3RoIHVz
ZSANCj4gPj4gY2FzZXMuDQo+ID4+IFNvIGhvdyBhYm91dCBrZWVwIHRoZSBNVEsgdmVyc2lvbiBk
cml2ZXI/DQo+ID4gDQo+ID4gSSdtIGZpbmUgd2l0aCB0aGF0LiBNYXliZSB5b3UgY2FuIHB1c2gg
dGhlIE1USyB2ZXJzaW9uIGFuZCBJIGNhbiBzZW5kDQo+ID4gYSBzbWFsbCBwYXRjaCBhZnRlciB0
aGF0IHRvIGFkZCB0aGUgc21hbGwgYml0cyBJIG5lZWQ/DQo+IA0KPiBJbiB0aGUgaW50ZXJlc3Qg
b2YgYmVpbmcgdmVuZG9yIGFnbm9zdGljLCBwbGVhc2UgcmVuYW1lIHRoZSBwcm9wZXJ0aWVzDQo+
IHN1Y2ggYXMgbWVkaWF0ZWssaXJxcy1tYXAtcmFuZ2UgdG8gc29tZXRoaW5nIGxlc3MgYnJhbmQt
c3BlY2lmaWMuDQo+IFRoZSBjb21wYXRpYmxlIHN0cmluZyBzaG91bGQgYmUgZW5vdWdoLg0KDQpJ
IGNhbid0IGZpbmQgdGhlIHN1aXRhYmxlIHByb3BlcnR5IGluIHN0YW5kYXJkIG9uZXMgdGhhdCBt
YXRjaCB0aGUgY3VzdG9tDQpwcm9wZXJ0aWVzIGhlcmUuDQpBbmQgdGhlIHZlbmRvciBwcmVmaXhl
ZCBydWxlIGlzIGRlc2NyaWJlZCBpbiBbMV0uDQoNClRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciBp
cyBmaXJzdCB1c2VkIGluIE1zdGFyIFRWIFNvQ3MuDQpOb3cgaXQncyB1c2VkIGluIE1USyBUViBh
bmQgU2lnbWFzdGFyIFNvQ3MuDQpTbyBJIHRoaW5rIE1zdGFyIHByZWZpeGVkIHdvdWxkIG1ha2Ug
bW9yZSBzZW5zZS4NCkkgd2lsbCByZW5hbWUgdGhlIGRyaXZlciBpbnRvIG1zdGFyLWludGMsIGFu
ZCBNVEsgd2lsbCBtYWludGFpbiB0aGlzIGRyaXZlci4NCg0KWzFdIGh0dHBzOi8vd3d3Lmtlcm5l
bC5vcmcvZG9jL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9ib290aW5nLXdpdGhvdXQtb2YudHh0

