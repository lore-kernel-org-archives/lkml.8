Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E9C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C67206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kU2cMA3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgAaCxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:53:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58287 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727777AbgAaCxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:53:52 -0500
X-UUID: 2ed2632f77c344a2a0c204df28cb0362-20200131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=J/YS9xrz7SE39sg55EiuDt9slMVYOmJaP+90r0kGMF8=;
        b=kU2cMA3os+/I6YXPqwB3/BHr2hvZiLyvU2Lj+5VvB8TH8KSVmTqGsWBo8WkSqev0Fo5qa5lCyQIDWwweOUrgjZzbKq6msuR9cHtm2SEB4ldme0hpsCOJXOmL4s7fTazW5y3IVtZk1Sb42cy/+JsG7g5lQYKgsQGWtP4Otbog4FI=;
X-UUID: 2ed2632f77c344a2a0c204df28cb0362-20200131
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 646680630; Fri, 31 Jan 2020 10:53:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 Jan 2020 10:53:02 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 31 Jan 2020 10:51:23 +0800
Message-ID: <1580439225.11126.34.camel@mtksdccf07>
Subject: Re: [PATCH v4 2/2] kasan: add test for invalid size in memmove
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 31 Jan 2020 10:53:45 +0800
In-Reply-To: <20200130181613.1bfb8df8e73a280512cab8ef@linux-foundation.org>
References: <20191112065313.7060-1-walter-zh.wu@mediatek.com>
         <619b898f-f9c2-1185-5ea7-b9bf21924942@virtuozzo.com>
         <1580355838.11126.5.camel@mtksdccf07>
         <20200130181613.1bfb8df8e73a280512cab8ef@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTMwIGF0IDE4OjE2IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUaHUsIDMwIEphbiAyMDIwIDExOjQzOjU4ICswODAwIFdhbHRlciBXdSA8d2FsdGVyLXpo
Lnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIEZyaSwgMjAxOS0xMS0yMiBhdCAw
NjoyMSArMDgwMCwgQW5kcmV5IFJ5YWJpbmluIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiAxMS8x
Mi8xOSA5OjUzIEFNLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+ID4gPiA+IFRlc3QgbmVnYXRpdmUgc2l6
ZSBpbiBtZW1tb3ZlIGluIG9yZGVyIHRvIHZlcmlmeSB3aGV0aGVyIGl0IGNvcnJlY3RseQ0KPiA+
ID4gPiBnZXQgS0FTQU4gcmVwb3J0Lg0KPiA+ID4gPiANCj4gPiA+ID4gQ2FzdGluZyBuZWdhdGl2
ZSBudW1iZXJzIHRvIHNpemVfdCB3b3VsZCBpbmRlZWQgdHVybiB1cCBhcyBhIGxhcmdlDQo+ID4g
PiA+IHNpemVfdCwgc28gaXQgd2lsbCBoYXZlIG91dC1vZi1ib3VuZHMgYnVnIGFuZCBiZSBkZXRl
Y3RlZCBieSBLQVNBTi4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdhbHRlciBX
dSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IERtaXRy
eSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6
IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQo+ID4gDQo+ID4gSGkg
QW5kcmV5LCBEbWl0cnksIEFuZHJldywNCj4gPiANCj4gPiBXb3VsZCB5b3UgdGVsbCBtZSB3aHkg
dGhpcyBwYXRjaC1zZXRzIGRvbid0IG1lcmdlIGludG8gbGludXgtbmV4dCB0cmVlPw0KPiA+IFdl
IGxvc3Qgc29tZXRoaW5nPw0KPiA+IA0KPiANCj4gSW4gcmVzcG9uc2UgdG8gWzEvMl0gQW5kcmV5
IHNhaWQgIlNvIGxldCdzIGtlZXAgdGhpcyBjb2RlIGFzIHRoaXMiIGFuZA0KPiB5b3Ugc2FpZCAi
SSB3aWxsIHNlbmQgYSBuZXcgdjUgcGF0Y2ggdG9tb3Jyb3ciLiAgU28gd2UncmUgYXdhaXRpbmcg
YSB2NQ0KPiBwYXRjaHNldD8NCj4gDQoNCkhpIEFuZHJldywNCg0KVGhlIFsxLzJdIHBhdGNoIGRp
c2N1c3Npb24gc2hvd3MgYmVsb3cuIFRoYW5rcyBmb3IgRGltaXRyeSBoZWxwIHRvDQpleHBsYWlu
IGl0LiBTbyB0aGF0IHY0IHBhdGNoc2V0IGdvdCBBbmRyZXkncyBzaWduYXR1cmUuIEJlY2F1c2Ug
SSBzZWUNCkFuZHJleSBzYWlkICJCdXQgSSBzZWUgeW91IHBvaW50IG5vdy4gTm8gb2JqZWN0aW9u
cyB0byB0aGUgcGF0Y2ggaW4gdGhhdA0KY2FzZS4iDQoNCkBBbmRyZXksIGlmIEkgaGF2ZSBhbiBp
bmNvcnJlY3QgdW5kZXJzdGFuZGluZywgcGxlYXNlIGxldCBtZSBrbm93LiANClRoYW5rcyBmb3Ig
eW91ciBoZWxwLg0KDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8xMS8yMS8xMDE5DQpodHRw
czovL2xrbWwub3JnL2xrbWwvMjAxOS8xMS8yMS8xMDIwDQoNCg0KV2FsdGVyDQo=

