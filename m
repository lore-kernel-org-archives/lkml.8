Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EDAC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8B0206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 04:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N6WnfoTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgBREM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 23:12:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55043 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbgBREM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 23:12:26 -0500
X-UUID: cdb39c2320e145139c693c85c5567541-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sC1dH8d6p1Sb7KU8Fpm99duFBOtY/J9QQu2NqxSwvKI=;
        b=N6WnfoTKYUPY37LiLGDgStQon8O6ENar205hqs12I6Qs6XflcAJO9zhzPn7ct69epFnjRRxfxi5TNZwEBEyiTpn5UZD3TdJpA5pQ7rGHarmAe0SybGs8tQVoyIaYKe4Zp7xCpGdKdegUXCXDHouQbMYbokyqffS0ujhSWxpXdqY=;
X-UUID: cdb39c2320e145139c693c85c5567541-20200218
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 889799796; Tue, 18 Feb 2020 12:12:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 12:09:51 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Feb 2020 12:11:50 +0800
Message-ID: <1581999138.19053.21.camel@mtkswgap22>
Subject: Re: [PATCH v7 0/7] Add basic SoC support for mt6765
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Evan Green" <evgreen@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        "Joerg Roedel" <jroedel@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "Sean Wang" <Sean.Wang@mediatek.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Date:   Tue, 18 Feb 2020 12:12:18 +0800
In-Reply-To: <bf5e1a64-1aaa-e1e0-00bf-c0e750dd27ed@gmail.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
         <158155109134.184098.10100489231587620578@swboyd.mtv.corp.google.com>
         <bf5e1a64-1aaa-e1e0-00bf-c0e750dd27ed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 84BB3C13CA23C8AB9C9ED080959C0C3F21F3FB9B8B07A59D24DCEF47D5C4BF1C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTAyLTE1IGF0IDAyOjQ3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KDQpIaSBTdGVwaGVuLA0KDQo+IEhpIFN0ZXBoZW4sDQo+IA0KPiBPbiAxMy8wMi8yMDIwIDAw
OjQ0LCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gUXVvdGluZyBNYWNwYXVsIExpbiAoMjAyMC0w
Mi0wNyAwMToyMDo0MykNCj4gPj4gVGhpcyBwYXRjaCBhZGRzIGJhc2ljIFNvQyBzdXBwb3J0IGZv
ciBNZWRpYXRlaydzIG5ldyA4LWNvcmUgU29DLA0KPiA+PiBNVDY3NjUsIHdoaWNoIGlzIG1haW5s
eSBmb3Igc21hcnRwaG9uZSBhcHBsaWNhdGlvbi4NCj4gPiANCj4gPiBDbG9jayBwYXRjaGVzIGxv
b2sgT0sgdG8gbWUuIENhbiB5b3UgcmVzZW5kIHRoZW0gd2l0aG91dCB0aGUgZGVmY29uZmlnDQo+
ID4gYW5kIGR0cyBwYXRjaGVzIGFuZCBhZGRyZXNzIE1hdHRoaWFzJyBxdWVzdGlvbj8NCj4gPiAN
Cj4gDQo+IEknbSBub3Qgc3VyZSBpZiBJIHVuZGVyc3RhbmQgeW91LiBEbyB5b3UgcHJlZmVyIHRv
IGhhdmUganVzdCB0aGUgY2xvY2sgcGFydHMNCj4gc2VuZCBhcyBhbiBpbmRlcGVuZGVudCB2ZXJz
aW9uIHNvIHRoYXQgeW91IGNhbiBlYXNpZXIgYXBwbHkgdGhlIHBhdGNoZXMgdG8geW91cg0KPiB0
cmVlPw0KPiANCj4gUGF0Y2ggMiwgNSwgNiBhbmQgNyBzaG91bGQgZ28gdGhyb3VnaCBteSB0cmVl
Lg0KPiBTbyBkbyB5b3Ugd2FudCBhIHNlcmllcyB3aXRoIHBhdGNoZXMgMSwgMyBhbmQgND8NCj4g
DQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQoNCll1cCwgSSd2ZSBnb3QgYSBsaXR0bGUgYml0IGNv
bmZ1c2VkLCB0b28uDQpTaG91bGQgSSBzZXBhcmF0ZSBhbmQgcmVzZW5kIHRoZXNlIHBhdGNoZXMg
aW50byAyIHBhdGNoIHNldHM/DQpUaGUgMXN0IHBhdGNoIHNldCBpbmNsdWRlcyAjMSwgIzMsIGFu
ZCAjND8NCkFuZCB0aGUgb3RoZXIgaW5jbHVkZXMgIzIsICM1LCAjNiwgYW5kICM3Pw0KDQpSZWdh
cmRzLA0KTWFjcGF1bCBMaW4NCg0K

