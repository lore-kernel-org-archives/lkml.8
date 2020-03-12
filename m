Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02254C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB65D20737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WXCgrUwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbgCLFD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:03:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37829 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387676AbgCLFD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:03:58 -0400
X-UUID: 478dd462c20f46619b06cde0ca3267d9-20200312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EiH9wliZJ7SlCOgjGr1o9krpwAx0Yhk57Jmk6JMcvtA=;
        b=WXCgrUwvwPckPJtrgli7CI1U5PziZL60rSUU1If/uRKOocJn2Bf7DiMVvg1bW13c5lC7uTkCP6KBN8KunoFOwNYhV1Mnb0qSB42mvG7PgydgKaDLk6l7YrlSI6ZMLBgFkx1DDTSfkPPFRz16ibhCCTruDcXwWLcaJdzXQN2W9pU=;
X-UUID: 478dd462c20f46619b06cde0ca3267d9-20200312
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1488432028; Thu, 12 Mar 2020 13:03:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Mar 2020 13:02:47 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Mar 2020 13:02:55 +0800
Message-ID: <1583989425.17522.29.camel@mtksdccf07>
Subject: Re: [PATCH -next] kasan: fix -Wstringop-overflow warning
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Thu, 12 Mar 2020 13:03:45 +0800
In-Reply-To: <20200311163800.a264d4ec8f26cca7bb5046fb@linux-foundation.org>
References: <20200311134244.13016-1-walter-zh.wu@mediatek.com>
         <20200311163800.a264d4ec8f26cca7bb5046fb@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTExIGF0IDE2OjM4IC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBXZWQsIDExIE1hciAyMDIwIDIxOjQyOjQ0ICswODAwIFdhbHRlciBXdSA8d2FsdGVyLXpo
Lnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IENvbXBpbGluZyB3aXRoIGdjYy05LjIu
MSBwb2ludHMgb3V0IGJlbG93IHdhcm5pbmdzLg0KPiA+IA0KPiA+IEluIGZ1bmN0aW9uICdtZW1t
b3ZlJywNCj4gPiAgICAgaW5saW5lZCBmcm9tICdrbWFsbG9jX21lbW1vdmVfaW52YWxpZF9zaXpl
JyBhdCBsaWIvdGVzdF9rYXNhbi5jOjMwMToyOg0KPiA+IGluY2x1ZGUvbGludXgvc3RyaW5nLmg6
NDQxOjk6IHdhcm5pbmc6ICdfX2J1aWx0aW5fbWVtbW92ZScgc3BlY2lmaWVkDQo+ID4gYm91bmQg
MTg0NDY3NDQwNzM3MDk1NTE2MTQgZXhjZWVkcyBtYXhpbXVtIG9iamVjdCBzaXplDQo+ID4gOTIy
MzM3MjAzNjg1NDc3NTgwNyBbLVdzdHJpbmdvcC1vdmVyZmxvdz1dDQo+ID4gDQo+ID4gV2h5IGdl
bmVyYXRlIHRoaXMgd2FybmluZ3M/DQo+ID4gQmVjYXVzZSBvdXIgdGVzdCBmdW5jdGlvbiBkZWxp
YmVyYXRlbHkgcGFzcyBhIG5lZ2F0aXZlIG51bWJlciBpbiBtZW1tb3ZlKCksDQo+ID4gc28gd2Ug
bmVlZCB0byBtYWtlIGl0ICJ2b2xhdGlsZSIgc28gdGhhdCBjb21waWxlciBkb2Vzbid0IHNlZSBp
dC4NCj4gPiANCj4gPiAuLi4NCj4gPg0KPiA+IC0tLSBhL2xpYi90ZXN0X2thc2FuLmMNCj4gPiAr
KysgYi9saWIvdGVzdF9rYXNhbi5jDQo+ID4gQEAgLTI4OSw2ICsyODksNyBAQCBzdGF0aWMgbm9p
bmxpbmUgdm9pZCBfX2luaXQga21hbGxvY19tZW1tb3ZlX2ludmFsaWRfc2l6ZSh2b2lkKQ0KPiA+
ICB7DQo+ID4gIAljaGFyICpwdHI7DQo+ID4gIAlzaXplX3Qgc2l6ZSA9IDY0Ow0KPiA+ICsJdm9s
YXRpbGUgc2l6ZV90IGludmFsaWRfc2l6ZSA9IC0yOw0KPiA+ICANCj4gPiAgCXByX2luZm8oImlu
dmFsaWQgc2l6ZSBpbiBtZW1tb3ZlXG4iKTsNCj4gPiAgCXB0ciA9IGttYWxsb2Moc2l6ZSwgR0ZQ
X0tFUk5FTCk7DQo+ID4gQEAgLTI5OCw3ICsyOTksNyBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBf
X2luaXQga21hbGxvY19tZW1tb3ZlX2ludmFsaWRfc2l6ZSh2b2lkKQ0KPiA+ICAJfQ0KPiA+ICAN
Cj4gPiAgCW1lbXNldCgoY2hhciAqKXB0ciwgMCwgNjQpOw0KPiA+IC0JbWVtbW92ZSgoY2hhciAq
KXB0ciwgKGNoYXIgKilwdHIgKyA0LCAtMik7DQo+ID4gKwltZW1tb3ZlKChjaGFyICopcHRyLCAo
Y2hhciAqKXB0ciArIDQsIGludmFsaWRfc2l6ZSk7DQo+ID4gIAlrZnJlZShwdHIpOw0KPiA+ICB9
DQo+IA0KPiBIdWguICBXaHkgZG9lcyB0aGlzIHRyaWNrIHN1cHByZXNzIHRoZSB3YXJuaW5nPw0K
PiANCldlIHJlYWQgYmVsb3cgdGhlIGRvY3VtZW50LCBzbyB3ZSB0cnkgdG8gdmVyaWZ5IHdoZXRo
ZXIgaXQgaXMgd29yayBmb3INCmFub3RoZXIgY2hlY2tpbmcuIEFmdGVyIHdlIGNoYW5nZWQgdGhl
IGNvZGUsIEl0IGlzIG9rLg0KDQpodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjLTku
Mi4wL2djYy9XYXJuaW5nLU9wdGlvbnMuaHRtbCNXYXJuaW5nLU9wdGlvbnMNCiJUaGV5IGRvIG5v
dCBvY2N1ciBmb3IgdmFyaWFibGVzIG9yIGVsZW1lbnRzIGRlY2xhcmVkIHZvbGF0aWxlLiBCZWNh
dXNlDQp0aGVzZSB3YXJuaW5ncyBkZXBlbmQgb24gb3B0aW1pemF0aW9uLCB0aGUgZXhhY3QgdmFy
aWFibGVzIG9yIGVsZW1lbnRzDQpmb3Igd2hpY2ggdGhlcmUgYXJlIHdhcm5pbmdzIGRlcGVuZHMg
b24gdGhlIHByZWNpc2Ugb3B0aW1pemF0aW9uIG9wdGlvbnMNCmFuZCB2ZXJzaW9uIG9mIEdDQyB1
c2VkLiINCg0KPiBEbyB3ZSBoYXZlIGFueSBndWFyYW50ZWUgdGhhdCB0aGlzIGl0IHdpbGwgY29u
dGl1ZSB0byB3b3JrIGluIGZ1dHVyZQ0KPiBnY2Mncz8NCj4gDQpTb3JyeSwgSSBhbSBub3QgY29t
cGlsZXIgZXhwZXJ0LCBzbyBJIGNhbid0IGd1YXJhbnRlZSBnY2Mgd2lsbCBub3QNCm1vZGlmeSB0
aGUgcnVsZSwgYnV0IGF0IGxlYXN0IGl0IGlzIHdvcmsgYmVmb3JlIGdjYy05Lg0KPiANCg0K

