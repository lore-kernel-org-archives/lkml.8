Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81FDC35653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE08207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u3AJW8nL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgBUKXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:23:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22070 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726989AbgBUKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:23:36 -0500
X-UUID: 6798f4fe02bf40f89f3db807883827f0-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9GF943aZdupXgIlWbr1tM9dp52aP/OtDRXFu16nBKsU=;
        b=u3AJW8nLcjG4YYRvG+aYOWurkYxWQrMb9Q6bFv2Edoq+9llIMsJn3ZjZP1011vNZw8o8HfizgaiksK29NQHvWSrBXZmQSCiaGDUxvmDf4rt8TseCiGDJ/AwhFqr4hx7pBArZk9p0VLI8Mue2K47ZgRYPcIjcWiACtcBsR/g1h+Q=;
X-UUID: 6798f4fe02bf40f89f3db807883827f0-20200221
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 339315032; Fri, 21 Feb 2020 18:23:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 18:22:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Feb 2020 18:22:44 +0800
Message-ID: <1582280608.19053.27.camel@mtkswgap22>
Subject: Re: [PATCH v7 0/7] Add basic SoC support for mt6765
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Loda Chou <loda.chou@mediatek.com>,
        "Fabien Parent" <fparent@baylibre.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        "Will Deacon" <will@kernel.org>, <linux-clk@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 21 Feb 2020 18:23:28 +0800
In-Reply-To: <158213769281.184098.14491216159423631295@swboyd.mtv.corp.google.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
         <158155109134.184098.10100489231587620578@swboyd.mtv.corp.google.com>
         <bf5e1a64-1aaa-e1e0-00bf-c0e750dd27ed@gmail.com>
         <1581999138.19053.21.camel@mtkswgap22>
         <2c6728a5-7789-4ca2-a173-67df57fe5f1e@gmail.com>
         <158213769281.184098.14491216159423631295@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FDD232F52A5E189BADF5D5BF6B5B255DDCAC9D3340344A6748231A437ADA98A62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UXVvdGluZyBNYXR0aGlhcyBCcnVnZ2VyIGFuZCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+IFF1b3Rp
bmcgTWF0dGhpYXMgQnJ1Z2dlciAoMjAyMC0wMi0xOCAwODo0NTo0MikNCj4gPiANCj4gPiBPbiAx
OC8wMi8yMDIwIDA1OjEyLCBNYWNwYXVsIExpbiB3cm90ZToNCj4gPiA+IE9uIFNhdCwgMjAyMC0w
Mi0xNSBhdCAwMjo0NyArMDEwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gSGkgU3RlcGhlbiwNCj4gPiA+IA0KPiA+ID4+IEhpIFN0ZXBoZW4sDQo+ID4gPj4NCj4gPiA+
PiBPbiAxMy8wMi8yMDIwIDAwOjQ0LCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gPj4+IFF1b3Rp
bmcgTWFjcGF1bCBMaW4gKDIwMjAtMDItMDcgMDE6MjA6NDMpDQo+ID4gPj4+PiBUaGlzIHBhdGNo
IGFkZHMgYmFzaWMgU29DIHN1cHBvcnQgZm9yIE1lZGlhdGVrJ3MgbmV3IDgtY29yZSBTb0MsDQo+
ID4gPj4+PiBNVDY3NjUsIHdoaWNoIGlzIG1haW5seSBmb3Igc21hcnRwaG9uZSBhcHBsaWNhdGlv
bi4NCj4gPiA+Pj4NCj4gPiA+Pj4gQ2xvY2sgcGF0Y2hlcyBsb29rIE9LIHRvIG1lLiBDYW4geW91
IHJlc2VuZCB0aGVtIHdpdGhvdXQgdGhlIGRlZmNvbmZpZw0KPiA+ID4+PiBhbmQgZHRzIHBhdGNo
ZXMgYW5kIGFkZHJlc3MgTWF0dGhpYXMnIHF1ZXN0aW9uPw0KPiA+ID4+Pg0KPiA+ID4+DQo+ID4g
Pj4gSSdtIG5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB5b3UuIERvIHlvdSBwcmVmZXIgdG8gaGF2
ZSBqdXN0IHRoZSBjbG9jayBwYXJ0cw0KPiA+ID4+IHNlbmQgYXMgYW4gaW5kZXBlbmRlbnQgdmVy
c2lvbiBzbyB0aGF0IHlvdSBjYW4gZWFzaWVyIGFwcGx5IHRoZSBwYXRjaGVzIHRvIHlvdXINCj4g
PiA+PiB0cmVlPw0KPiA+ID4+DQo+ID4gPj4gUGF0Y2ggMiwgNSwgNiBhbmQgNyBzaG91bGQgZ28g
dGhyb3VnaCBteSB0cmVlLg0KPiA+ID4+IFNvIGRvIHlvdSB3YW50IGEgc2VyaWVzIHdpdGggcGF0
Y2hlcyAxLCAzIGFuZCA0Pw0KPiA+ID4+DQo+ID4gPj4gUmVnYXJkcywNCj4gPiA+PiBNYXR0aGlh
cw0KPiA+ID4gDQo+ID4gPiBZdXAsIEkndmUgZ290IGEgbGl0dGxlIGJpdCBjb25mdXNlZCwgdG9v
Lg0KPiA+ID4gU2hvdWxkIEkgc2VwYXJhdGUgYW5kIHJlc2VuZCB0aGVzZSBwYXRjaGVzIGludG8g
MiBwYXRjaCBzZXRzPw0KPiA+ID4gVGhlIDFzdCBwYXRjaCBzZXQgaW5jbHVkZXMgIzEsICMzLCBh
bmQgIzQ/DQo+ID4gPiBBbmQgdGhlIG90aGVyIGluY2x1ZGVzICMyLCAjNSwgIzYsIGFuZCAjNz8N
Cj4gPiA+IA0KPiA+IA0KPiA+IFllcyBwbGVhc2UgZG8gc28uIEkgdGhpbmsgdGhhdCdzIHdoYXQg
U3RlcGhlbiByZWZlcnJlZCB0by4NCj4gPiANCj4gDQo+IElmIHRob3NlIGFyZSB0aGUgb25lcyB0
aGF0IGFyZW4ndCBkdHMgb3IgZGVmY29uZmlnIHBhdGNoZXMgc291bmRzIGdvb2QNCj4gdG8gbWUu
DQoNCkhlcmUgY29tZXMgdGhlIHNwaWx0IHBhdGNoIHNldHMuDQoxLiBbTmV3XSBBZGQgYmFzaWMg
Y2xvY2sgc3VwcG9ydCBmb3IgbXQ2NzY1Lg0KICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L2NvdmVyLzExMzk1OTk3Lw0KMi4gW1BBVENIIHY4XSBBZGQgYmFzaWMgU29DIHN1cHBvcnQgZm9y
IG10Njc2NQ0KICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMzk2MDE5Lw0K
ICBCdXQgaXQncyBhIGxpdHRsZSBiaXQgc3RyYW5nZSBJIGNhbm5vdCBmaW5kIHBhdGNoIHY4J3Mg
Y292ZXItbGV0dGVyDQogIGluIHBhdGNod29yay4gT25seSByZWNvcmRzIHdoaWNoIHBhdGNoZXMg
aGFzIGJlZW4gdGFrZW4gZnJvbSB2Ny4NCiAgSWYgcmVzZW5kIGNvdmVyLWxldHRlciBpcyByZXF1
aXJlZCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNClJlZ2FyZHMsDQpNYWNwYXVsIExpbg0K

