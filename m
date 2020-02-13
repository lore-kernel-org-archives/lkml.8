Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B94C3B186
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0D217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dP3atqsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgBMCzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:55:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57589 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729333AbgBMCzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:55:33 -0500
X-UUID: 48ed1d30c34048a29e148fc5056adcad-20200213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LJDuwYzpSPlqh0Fy0uu3RaMajNEpsKJmu5DTiLeNbr0=;
        b=dP3atqsdr8isl/3fG9CbmsLXUBkSVfcUAhffChV7bxLeR0VkGn3LR37zpJajdbydwpc2TnMPwrPn9pKXDqKisXu/adAQ/GK65nO6PuS8BXEhZrALgcGBlSRoJj6vBtjA/Yy1Wfs8lBwHrtC4SuxQwOtah02d/3QEOv3IgAw6xT0=;
X-UUID: 48ed1d30c34048a29e148fc5056adcad-20200213
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 748311156; Thu, 13 Feb 2020 10:55:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Feb 2020 10:56:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Feb 2020 10:54:23 +0800
Message-ID: <1581562527.19053.18.camel@mtkswgap22>
Subject: Re: [PATCH v7 5/7] soc: mediatek: add MT6765 scpsys and subdomain
 support
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Wendell Lin =?UTF-8?Q?=28=E6=9E=97=E7=90=A6=E8=80=80=29?= 
        <Wendell.Lin@mediatek.com>, Weiyi Lu <Weiyi.Lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        ";Ryder Lee" <Ryder.Lee@mediatek.com>,
        Morven-CF Yeh <Morven-CF.Yeh@mediatek.com>,
        Kevin-CW Chen <Kevin-CW.Chen@mediatek.com>,
        Albert-ZL Huang <Albert-ZL.Huang@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Evan Green" <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Date:   Thu, 13 Feb 2020 10:55:27 +0800
In-Reply-To: <c704bdab-8489-0b54-59de-401bc4ab24e6@gmail.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
         <1581067250-12744-6-git-send-email-macpaul.lin@mediatek.com>
         <c704bdab-8489-0b54-59de-401bc4ab24e6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAyLTA5IGF0IDIyOjI2ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPg0KPiBPbiAwNy8wMi8yMDIwIDEwOjIwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4gPiBGcm9t
OiBNYXJzIENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBUaGlzIGFk
ZHMgc2Nwc3lzIHN1cHBvcnQgZm9yIE1UNjc2NQ0KPiA+IEFkZCBzdWJkb21haW4gc3VwcG9ydCBm
b3IgTVQ2NzY1Og0KPiA+IGlzcCwgbW0sIGNvbm5zeXMsIG1mZywgYW5kIGNhbS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNYXJzIENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBPd2VuIENoZW4gPG93ZW4uY2hlbkBtZWRpYXRlay5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIHwgMTMwICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMwIGluc2Vy
dGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXNjcHN5cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQo+ID4gaW5kZXgg
ZjY2OWQzNzU0NjI3Li45OTQwYzZkMTMyMjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXNjcHN5cy5jDQo+ID4gQEAgLTE1LDYgKzE1LDcgQEANCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9wb3dlci9tdDI3MDEtcG93ZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3Bvd2VyL210MjcxMi1wb3dlci5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93
ZXIvbXQ2NzY1LXBvd2VyLmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDY3
OTctcG93ZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210NzYyMi1wb3dl
ci5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ3NjIzYS1wb3dlci5oPg0K
PiA+IEBAIC03NDksNiArNzUwLDEyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNjcF9zdWJkb21h
aW4gc2NwX3N1YmRvbWFpbl9tdDI3MTJbXSA9IHsNCj4gPiAgCXtNVDI3MTJfUE9XRVJfRE9NQUlO
X01GR19TQzIsIE1UMjcxMl9QT1dFUl9ET01BSU5fTUZHX1NDM30sDQo+ID4gIH07DQo+ID4gIA0K
PiA+ICsvKg0KPiA+ICsgKiBNVDY3NjUgcG93ZXIgZG9tYWluIHN1cHBvcnQNCj4gPiArICovDQo+
ID4gKyNkZWZpbmUgU1BNX1BXUl9TVEFUVVNfTVQ2NzY1CQkJMHgwMTgwDQo+ID4gKyNkZWZpbmUg
U1BNX1BXUl9TVEFUVVNfMk5EX01UNjc2NQkJMHgwMTg0DQo+ID4gKw0KPiANCj4gVGhlIG9mZnNl
dHMgYXJlIHRoZSBzYW1lIGFzIGZvciBNVDY3OTcuIENvdWxkIHdlIHJlbmFtZSB0aGUgZGVmaW5l
IHRvIHNvbWV0aGluZw0KPiBnZW5lcmljIGFuZCBtb3ZlIGl0IHVwIGFuZCBwdXQgaXQganVzdCB1
bmRlciBTUE1fUFdSX1NUQVRVU18yTkQ/IFByb2JhYmx5IGFzIGENCj4gc2VwYXJhdGUgcGF0Y2gu
DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCkxvb3AgbW9yZSByZWxhdGVkIG93bmVy
cyBpbiB0aGlzIG1haWwgbG9vcC4NCg0KQWZ0ZXIgY2hlY2sgaXQgd2l0aCBvdXIgY2xvY2sgZHJp
dmVyIG93bmVycywgdGhlcmUgYXJlIGRpZmZlcmVudA0KZ2VuZXJhdGlvbnMgb2YgY2xvY2sgSVBz
LiBCZWNhdXNlIGRpZmZlcmVudCBzbWFydCBwaG9uZSBjaGlwcyByZXF1aXJlDQpkaWZmZXJlbnQg
Y29zdC1mdW5jdGlvbiBvcmllbnRlZCBkZXNpZ24sIGV2ZW4gdGhleSB1c2UgdGhlIHNhbWUNCmdl
bmVyYXRpb24gb2YgY2xvY2sgSVBzLCBtaWdodCBub3QgaGF2ZSB0aGUgc2FtZSBvZmZzZXRzLiBU
YWtlIE1UNjc2NQ0KYW5kIE1UNjc5NyBmb3IgZXhhbXBsZSwgdGhlIGxpc3RlZCBvZmZzZXRzIGFy
ZSBqdXN0IGNvaW5jaWRlbmNlLg0KDQpPdXIgY2xvY2sgZHJpdmVyIG93bmVycyB3aWxsIHdvcmsg
b24gdGhpcyB0byBzdW1tYXJpemUgdGhlIGNvbW1vbiBvZmZzZXQNCnBhcnRzIGZvciBlYWNoIGdl
bmVyYXRpb25zLCBidXQgYXQgdGhpcyBtb21lbnQsIHdlIHN1Z2dlc3QganVzdCBzZXBhcmF0ZQ0K
dGhlIGZpbGVzIGZvciBtdDY3OTcgYW5kIG10Njc2NS4gQ29tbW9ubHkgdXNlZCBoZWFkZXIgc2hv
dWxkIGJlIGNvbWUNCndpdGggdGhlIG5leHQgY2hpcCB3aGljaCBjbG9jayBJUCBqdXN0IHRoZSBz
YW1lIGdlbmVyYXRpb24gb2YgbXQ2Nzk3IG9yDQptdDY3NjUuDQoNClRoYW5rcw0KTWFjcGF1bCBM
aW4NCg0KDQo=

