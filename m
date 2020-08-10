Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E442078D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I8jCLxoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHJObb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:31:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34995 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgHJOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:31:30 -0400
X-UUID: 11580f1edfbc424b8638dfc7aa78a283-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mciTdbGtLyle7sIBwwbHIL1yNy/ps2mp3cRnP7R9hZE=;
        b=I8jCLxoz7Hqqx4/bGh0J114d1VMfStQylMFYJQbg4xZ3BXN0ZBElYdArAU2b50yjTQvV7qFWPnjHavlvMF8B/o/1TR5Xa//+Ic/uLj0/YvuSOaxJCw/JjZyVGxQdUZErfknNekuQeszFbK3C3FqUpQFk5PpTMNAnW73vKN8xiFA=;
X-UUID: 11580f1edfbc424b8638dfc7aa78a283-20200810
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1849710283; Mon, 10 Aug 2020 22:31:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 22:31:19 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 22:31:19 +0800
Message-ID: <1597069882.13160.23.camel@mtksdccf07>
Subject: Re: [PATCH 0/5] kasan: add workqueue and timer stack for generic
 KASAN
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tejun Heo" <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 10 Aug 2020 22:31:22 +0800
In-Reply-To: <20200810124430.GA5307@lca.pw>
References: <20200810072115.429-1-walter-zh.wu@mediatek.com>
         <B873B364-FF03-4819-8F9C-79F3C4EF47CE@lca.pw>
         <1597060257.13160.11.camel@mtksdccf07> <20200810124430.GA5307@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8A3A2465FDA3BD14C3B68297CF0BBCE39CBA5A54C6BEEBE1128F4E5F8A7680C72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTEwIGF0IDA4OjQ0IC0wNDAwLCBRaWFuIENhaSB3cm90ZToNCj4gT24g
TW9uLCBBdWcgMTAsIDIwMjAgYXQgMDc6NTA6NTdQTSArMDgwMCwgV2FsdGVyIFd1IHdyb3RlOg0K
PiA+IE9uIE1vbiwgMjAyMC0wOC0xMCBhdCAwNzoxOSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6DQo+
ID4gPiANCj4gPiA+ID4gT24gQXVnIDEwLCAyMDIwLCBhdCAzOjIxIEFNLCBXYWx0ZXIgV3UgPHdh
bHRlci16aC53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4g77u/U3l6
Ym90IHJlcG9ydHMgbWFueSBVQUYgaXNzdWVzIGZvciB3b3JrcXVldWUgb3IgdGltZXIsIHNlZSBb
MV0gYW5kIFsyXS4NCj4gPiA+ID4gSW4gc29tZSBvZiB0aGVzZSBhY2Nlc3MvYWxsb2NhdGlvbiBo
YXBwZW5lZCBpbiBwcm9jZXNzX29uZV93b3JrKCksDQo+ID4gPiA+IHdlIHNlZSB0aGUgZnJlZSBz
dGFjayBpcyB1c2VsZXNzIGluIEtBU0FOIHJlcG9ydCwgaXQgZG9lc24ndCBoZWxwDQo+ID4gPiA+
IHByb2dyYW1tZXJzIHRvIHNvbHZlIFVBRiBvbiB3b3JrcXVldWUuIFRoZSBzYW1lIG1heSBzdGFu
ZCBmb3IgdGltZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNoc2V0IGltcHJvdmVzIEtB
U0FOIHJlcG9ydHMgYnkgbWFraW5nIHRoZW0gdG8gaGF2ZSB3b3JrcXVldWUNCj4gPiA+ID4gcXVl
dWVpbmcgc3RhY2sgYW5kIHRpbWVyIHF1ZXVlaW5nIHN0YWNrIGluZm9ybWF0aW9uLiBJdCBpcyB1
c2VmdWwgZm9yDQo+ID4gPiA+IHByb2dyYW1tZXJzIHRvIHNvbHZlIHVzZS1hZnRlci1mcmVlIG9y
IGRvdWJsZS1mcmVlIG1lbW9yeSBpc3N1ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEdlbmVyaWMgS0FT
QU4gd2lsbCByZWNvcmQgdGhlIGxhc3QgdHdvIHdvcmtxdWV1ZSBhbmQgdGltZXIgc3RhY2tzLA0K
PiA+ID4gPiBwcmludCB0aGVtIGluIEtBU0FOIHJlcG9ydC4gSXQgaXMgb25seSBzdWl0YWJsZSBm
b3IgZ2VuZXJpYyBLQVNBTi4NCj4gPiA+ID4gDQo+ID4gPiA+IEluIG9yZGVyIHRvIHByaW50IHRo
ZSBsYXN0IHR3byB3b3JrcXVldWUgYW5kIHRpbWVyIHN0YWNrcywgc28gdGhhdA0KPiA+ID4gPiB3
ZSBhZGQgbmV3IG1lbWJlcnMgaW4gc3RydWN0IGthc2FuX2FsbG9jX21ldGEuDQo+ID4gPiA+IC0g
dHdvIHdvcmtxdWV1ZSBxdWV1ZWluZyB3b3JrIHN0YWNrcywgdG90YWwgc2l6ZSBpcyA4IGJ5dGVz
Lg0KPiA+ID4gPiAtIHR3byB0aW1lciBxdWV1ZWluZyBzdGFja3MsIHRvdGFsIHNpemUgaXMgOCBi
eXRlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9yaWduaWFsIHN0cnVjdCBrYXNhbl9hbGxvY19tZXRh
IHNpemUgaXMgMTYgYnl0ZXMuIEFmdGVyIGFkZCBuZXcNCj4gPiA+ID4gbWVtYmVycywgdGhlbiB0
aGUgc3RydWN0IGthc2FuX2FsbG9jX21ldGEgdG90YWwgc2l6ZSBpcyAzMiBieXRlcywNCj4gPiA+
ID4gSXQgaXMgYSBnb29kIG51bWJlciBvZiBhbGlnbm1lbnQuIExldCBpdCBnZXQgYmV0dGVyIG1l
bW9yeSBjb25zdW1wdGlvbi4NCj4gPiA+IA0KPiA+ID4gR2V0dGluZyBkZWJ1Z2dpbmcgdG9vbHMg
Y29tcGxpY2F0ZWQgc3VyZWx5IGlzIHRoZSBiZXN0IHdheSB0byBraWxsIGl0LiBJIHdvdWxkIGFy
Z3VlIHRoYXQgaXQgb25seSBtYWtlIHNlbnNlIHRvIGNvbXBsaWNhdGUgaXQgaWYgaXQgaXMgdXNl
ZnVsIG1vc3Qgb2YgdGhlIHRpbWUgd2hpY2ggSSBuZXZlciBmZWVsIG9yIGhlYXIgdGhhdCBpcyB0
aGUgY2FzZS4gVGhpcyByZW1pbmRzIG1lIHlvdXIgcmVjZW50IGNhbGxfcmN1KCkgc3RhY2tzIHRo
YXQgbW9zdCBvZiB0aW1lIGp1c3QgbWFrZXMgcGFyc2luZyB0aGUgcmVwb3J0IGN1bWJlcnNvbWUu
IFRodXMsIEkgdXJnZSB0aGlzIGV4ZXJjaXNlIHRvIG92ZXItZW5naW5lZXIgb24gc3BlY2lhbCBj
YXNlcyBuZWVkIHRvIHN0b3AgZW50aXJlbHkuDQo+ID4gPiANCj4gPiANCj4gPiBBIGdvb2QgZGVi
dWcgdG9vbCBpcyB0byBoYXZlIGNvbXBsZXRlIGluZm9ybWF0aW9uIGluIG9yZGVyIHRvIHNvbHZl
DQo+ID4gaXNzdWUuIFdlIHNob3VsZCBmb2N1cyBvbiBpZiBLQVNBTiByZXBvcnRzIGFsd2F5cyBz
aG93IHRoaXMgZGVidWcNCj4gPiBpbmZvcm1hdGlvbiBvciBjcmVhdGUgYSBvcHRpb24gdG8gZGVj
aWRlIGlmIHNob3cgaXQuIEJlY2F1c2UgdGhpcw0KPiA+IGZlYXR1cmUgaXMgRGltaXRyeSdzIHN1
Z2dlc3Rpb24uIHNlZSBbMV0uIFNvIEkgdGhpbmsgaXQgbmVlZCB0byBiZQ0KPiA+IGltcGxlbWVu
dGVkLiBNYXliZSB3ZSBjYW4gd2FpdCBoaXMgcmVzcG9uc2UuIA0KPiA+IA0KPiA+IFsxXWh0dHBz
Oi8vbGttbC5vcmcvbGttbC8yMDIwLzYvMjMvMjU2DQo+IA0KPiBJIGRvbid0IGtub3cgaWYgaXQg
aXMgRG1pdHJ5J3MgcGlwZS1kcmVhbSB3aGljaCBldmVyeSBLQVNBTiByZXBvcnQgd291bGQgZW5h
YmxlDQo+IGRldmVsb3BlcnMgdG8gZml4IGl0IHdpdGhvdXQgcmVwcm9kdWNpbmcgaXQuIEl0IGlz
IGFsd2F5cyBhbiBvbmdvaW5nIHN0cnVnZ2xpbmcNCj4gYmV0d2VlbiB0byBtYWtlIGtlcm5lbCBl
YXNpZXIgdG8gZGVidWcgYW5kIHRoZSB0aGluZ3MgbGVzcyBjdW1iZXJzb21lLg0KPiANCj4gT24g
dGhlIG90aGVyIGhhbmQsIERtaXRyeSdzIHN1Z2dlc3Rpb24gbWFrZXMgc2Vuc2Ugb25seSBpZiB0
aGUgcHJpY2Ugd2UgYXJlDQo+IGdvaW5nIHRvIHBheSBpcyBmYWlyLiBXaXRoIHRoZSBjdXJyZW50
IGRpZmZzdGF0IGFuZCB0aGUgcmVjZW50IGV4cGVyaWVuY2Ugb2YNCj4gY2FsbF9yY3UoKSBzdGFj
a3MgIndhc3RlIiBzY3JlZW4gc3BhY2VzIGFzIGEgaGVhdnkgS0FTQU4gdXNlciBteXNlbGYsIEkg
Y2FuJ3QNCj4gcmVhbGx5IGdldCB0aGF0IGV4Y2l0aW5nIGZvciBwdXNoaW5nIHRoZSBsaW1pdCBh
Z2FpbiBhdCBhbGwuDQo+IA0KDQpJZiB5b3UgYXJlIGNvbmNlcm5lZCB0aGF0IHRoZSByZXBvcnQg
aXMgbG9uZywgbWF5YmUgd2UgY2FuIGNyZWF0ZSBhbg0Kb3B0aW9uIGZvciB0aGUgdXNlciBkZWNp
ZGUgd2hldGhlciBwcmludCB0aGVtIChpbmNsdWRlIGNhbGxfcmN1KS4NClNvIHRoaXMgc2hvdWxk
IHNhdGlzZnkgZXZlcnlvbmU/DQoNCj4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFsxXWh0dHBzOi8v
Z3JvdXBzLmdvb2dsZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lMjJ1c2UtYWZ0ZXIt
ZnJlZSUyMitwcm9jZXNzX29uZV93b3JrDQo+ID4gPiA+IFsyXWh0dHBzOi8vZ3JvdXBzLmdvb2ds
ZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lMjJ1c2UtYWZ0ZXItZnJlZSUyMiUyMGV4
cGlyZV90aW1lcnMNCj4gPiA+ID4gWzNdaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3df
YnVnLmNnaT9pZD0xOTg0MzcNCj4gPiA+ID4gDQo+ID4gPiA+IFdhbHRlciBXdSAoNSk6DQo+ID4g
PiA+IHRpbWVyOiBrYXNhbjogcmVjb3JkIGFuZCBwcmludCB0aW1lciBzdGFjaw0KPiA+ID4gPiB3
b3JrcXVldWU6IGthc2FuOiByZWNvcmQgYW5kIHByaW50IHdvcmtxdWV1ZSBzdGFjaw0KPiA+ID4g
PiBsaWIvdGVzdF9rYXNhbi5jOiBhZGQgdGltZXIgdGVzdCBjYXNlDQo+ID4gPiA+IGxpYi90ZXN0
X2thc2FuLmM6IGFkZCB3b3JrcXVldWUgdGVzdCBjYXNlDQo+ID4gPiA+IGthc2FuOiB1cGRhdGUg
ZG9jdW1lbnRhdGlvbiBmb3IgZ2VuZXJpYyBrYXNhbg0KPiA+ID4gPiANCj4gPiA+ID4gRG9jdW1l
bnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IHwgIDQgKystLQ0KPiA+ID4gPiBpbmNsdWRlL2xp
bnV4L2thc2FuLmggICAgICAgICAgICAgfCAgNCArKysrDQo+ID4gPiA+IGtlcm5lbC90aW1lL3Rp
bWVyLmMgICAgICAgICAgICAgICB8ICAyICsrDQo+ID4gPiA+IGtlcm5lbC93b3JrcXVldWUuYyAg
ICAgICAgICAgICAgICB8ICAzICsrKw0KPiA+ID4gPiBsaWIvdGVzdF9rYXNhbi5jICAgICAgICAg
ICAgICAgICAgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ID4gbW0va2FzYW4vZ2VuZXJpYy5jICAgICAgICAgICAgICAgIHwg
NDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+IG1t
L2thc2FuL2thc2FuLmggICAgICAgICAgICAgICAgICB8ICA2ICsrKysrLQ0KPiA+ID4gPiBtbS9r
YXNhbi9yZXBvcnQuYyAgICAgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gPiA+IDggZmlsZXMgY2hhbmdlZCwgMTM0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+ID4gPiA+IA0KPiA+ID4gPiAtLSANCj4gPiA+ID4gWW91IHJlY2VpdmVkIHRoaXMgbWVz
c2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3VwcyAia2Fz
YW4tZGV2IiBncm91cC4NCj4gPiA+ID4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGdyb3VwIGFu
ZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCBhbiBlbWFpbCB0byBrYXNhbi1k
ZXYrdW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4NCj4gPiA+ID4gVG8gdmlldyB0aGlzIGRp
c2N1c3Npb24gb24gdGhlIHdlYiB2aXNpdCBodHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2QvbXNn
aWQva2FzYW4tZGV2LzIwMjAwODEwMDcyMTE1LjQyOS0xLXdhbHRlci16aC53dSU0MG1lZGlhdGVr
LmNvbS4NCj4gPiANCg0K

