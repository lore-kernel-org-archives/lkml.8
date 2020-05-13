Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43058C47076
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E9206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IZpjxncN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgEMJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:22:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20198 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727118AbgEMJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:22:58 -0400
X-UUID: fa62bc129b964dadb0262935d116b170-20200513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=22zgrRi/oC9kwqIZbeIKNy00cAVePxq0U9heHWhbe+s=;
        b=IZpjxncNWXK3xwFx41z+SfE4GNDiAZeE5in/eI1Q31Ldj7bL1R3To1A3JJCLQf3m5rWKlhOv5/hJr9e7chLVkHCYzFkMsJKtOZBn4Y2b4AuQNvq9q4uYjnwznEgHxg0ZdBv+83jKm4wWo2bbYudzu0YZNj0/1pkJbfXBduJRFZ4=;
X-UUID: fa62bc129b964dadb0262935d116b170-20200513
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1650932209; Wed, 13 May 2020 17:22:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 May 2020 17:22:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 May 2020 17:22:48 +0800
Message-ID: <1589361771.15912.3.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/3] rcu/kasan: record and print call_rcu() call stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 13 May 2020 17:22:51 +0800
In-Reply-To: <CACT4Y+ZycfHeP5xqqkihRHx-aOoBhN9XdhUmzCdTfaYPXTCzAA@mail.gmail.com>
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
         <CACT4Y+YWNwTSoheJhc3nMdQi9m719F3PzpGo3TfRY3zAg9EwuQ@mail.gmail.com>
         <CACT4Y+bO1Zg_jgFHbOWgp7fLAADOQ_-AZmjEHz0WG7=oyOt4Gg@mail.gmail.com>
         <1589203771.21284.22.camel@mtksdccf07>
         <CACT4Y+aOkuH6Dn+L+wv1qVOLgXyCY_Ck4hecAMw3DgyBgC9qHw@mail.gmail.com>
         <1589254720.19238.36.camel@mtksdccf07>
         <CACT4Y+aibZEBR-3bos3ox5Tuu48TnHC20mDDN0AkWeRUKrT0aw@mail.gmail.com>
         <1589334472.19238.44.camel@mtksdccf07>
         <CACT4Y+Zv3rCZs8z56NHM0hHWMwQr_2AT8nx0vUigzMG2v3Rt8Q@mail.gmail.com>
         <1589360744.14554.10.camel@mtksdccf07>
         <CACT4Y+ZycfHeP5xqqkihRHx-aOoBhN9XdhUmzCdTfaYPXTCzAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDExOjE2ICswMjAwLCBEbWl0cnkgVnl1a292IHdyb3RlOg0K
PiBPbiBXZWQsIE1heSAxMywgMjAyMCBhdCAxMTowNSBBTSBXYWx0ZXIgV3UgPHdhbHRlci16aC53
dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCAyMDIwLTA1LTEzIGF0IDA4
OjUxICswMjAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGthc2FuLWRldiB3cm90ZToNCj4gPiA+IE9u
IFdlZCwgTWF5IDEzLCAyMDIwIGF0IDM6NDggQU0gV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVk
aWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gQXJlIHlvdSBzdXJlIGl0IHdpbGwgaW5j
cmVhc2Ugb2JqZWN0IHNpemU/DQo+ID4gPiA+ID4gPiA+IEkgdGhpbmsgd2Ugb3ZlcmxhcCBrYXNh
bl9mcmVlX21ldGEgd2l0aCB0aGUgb2JqZWN0IGFzIHdlbGwuIFRoZSBvbmx5DQo+ID4gPiA+ID4g
PiA+IGNhc2Ugd2UgZG9uJ3Qgb3ZlcmxhcCBrYXNhbl9mcmVlX21ldGEgd2l0aCB0aGUgb2JqZWN0
IGFyZQ0KPiA+ID4gPiA+ID4gPiBTTEFCX1RZUEVTQUZFX0JZX1JDVSB8fCBjYWNoZS0+Y3Rvci4g
QnV0IHRoZXNlIGFyZSByYXJlIGFuZCBpdCBzaG91bGQNCj4gPiA+ID4gPiA+ID4gb25seSBhZmZl
Y3Qgc21hbGwgb2JqZWN0cyB3aXRoIHNtYWxsIHJlZHpvbmVzLg0KPiA+ID4gPiA+ID4gPiBBbmQg
SSB0aGluayBub3cgd2Ugc2ltcGx5IGhhdmUgYSBidWcgZm9yIHRoZXNlIG9iamVjdHMsIHdlIGNo
ZWNrDQo+ID4gPiA+ID4gPiA+IEtBU0FOX0tNQUxMT0NfRlJFRSBhbmQgdGhlbiBhc3N1bWUgb2Jq
ZWN0IGNvbnRhaW5zIGZyZWUgc3RhY2ssIGJ1dCBmb3INCj4gPiA+ID4gPiA+ID4gb2JqZWN0cyB3
aXRoIGN0b3IsIHRoZXkgc3RpbGwgY29udGFpbiBsaXZlIG9iamVjdCBkYXRhLCB3ZSBkb24ndCBz
dG9yZQ0KPiA+ID4gPiA+ID4gPiBmcmVlIHN0YWNrIGluIHRoZW0uDQo+ID4gPiA+ID4gPiA+IFN1
Y2ggb2JqZWN0cyBjYW4gYmUgYm90aCBmcmVlIGFuZCBzdGlsbCBjb250YWluIHVzZXIgZGF0YS4N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPdmVybGF5IGthc2FuX2Zy
ZWVfbWV0YS4gSSBzZWUuIGJ1dCBvdmVybGF5IGl0IG9ubHkgd2hlbiB0aGUgb2JqZWN0IHdhcw0K
PiA+ID4gPiA+ID4gZnJlZWQuIGthc2FuX2ZyZWVfbWV0YSB3aWxsIGJlIHVzZWQgdW50aWwgZnJl
ZSBvYmplY3QuDQo+ID4gPiA+ID4gPiAxKS4gV2hlbiBwdXQgb2JqZWN0IGludG8gcXVhcmFudGlu
ZSwgaXQgbmVlZCBrYXNhbl9mcmVlX21ldGEuDQo+ID4gPiA+ID4gPiAyKS4gV2hlbiB0aGUgb2Jq
ZWN0IGV4aXQgZnJvbSBxdWFyYW50aW5lLCBpdCBuZWVkIGthc2FuX2ZyZWVfbWV0YQ0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IElmIHdlIGNob29zZSB0byBvdmVybGF5IGthc2FuX2ZyZWVfbWV0
YSwgdGhlbiB0aGUgZnJlZSBzdGFjayB3aWxsIGJlDQo+ID4gPiA+ID4gPiBzdG9yZWQgdmVyeSBs
YXRlLiBJdCBtYXkgaGFzIG5vIGZyZWUgc3RhY2sgaW4gcmVwb3J0Lg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gU29ycnksIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gV2h5IHdpbGwgaXQgYmUgc3RvcmVkIHRvbyBsYXRlPw0KPiA+ID4gPiA+IElu
IF9fa2FzYW5fc2xhYl9mcmVlKCkgcHV0dGluZyBpbnRvIHF1YXJhbnRpbmUgYW5kIHJlY29yZGlu
ZyBmcmVlDQo+ID4gPiA+ID4gc3RhY2sgYXJlIGxpdGVyYWxseSBhZGphY2VudCBsaW5lcyBvZiBj
b2RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gc3RhdGljIGJvb2wgX19rYXNhbl9zbGFiX2ZyZWUo
c3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLCB2b2lkICpvYmplY3QsDQo+ID4gPiA+ID4gICAgICAg
dW5zaWduZWQgbG9uZyBpcCwgYm9vbCBxdWFyYW50aW5lKQ0KPiA+ID4gPiA+IHsNCj4gPiA+ID4g
PiAgICAgLi4uDQo+ID4gPiA+ID4gICAgIGthc2FuX3NldF9mcmVlX2luZm8oY2FjaGUsIG9iamVj
dCwgdGFnKTsNCj4gPiA+ID4gPiAgICAgcXVhcmFudGluZV9wdXQoZ2V0X2ZyZWVfaW5mbyhjYWNo
ZSwgb2JqZWN0KSwgY2FjaGUpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBKdXN0
IHRvIG1ha2Ugc3VyZSwgd2hhdCBJIG1lYW50IGlzIHRoYXQgd2UgYWRkIGZyZWVfdHJhY2sgdG8g
a2FzYW5fZnJlZV9tZXRhOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gc3RydWN0IGthc2FuX2ZyZWVf
bWV0YSB7DQo+ID4gPiA+ID4gICAgIHN0cnVjdCBxbGlzdF9ub2RlIHF1YXJhbnRpbmVfbGluazsN
Cj4gPiA+ID4gPiArICBzdHJ1Y3Qga2FzYW5fdHJhY2sgZnJlZV90cmFjazsNCj4gPiA+ID4gPiB9
Ow0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFdoZW4gSSBzZWUgYWJvdmUgc3RydWN0IGth
c2FuX2ZyZWVfbWV0YSwgSSBrbm93IHdoeSB5b3UgZG9uJ3QgdW5kZXJzdGFuZA0KPiA+ID4gPiBt
eSBtZWFuaW5nLCBiZWNhdXNlIEkgdGhvdWdodCB5b3Ugd2VyZSBnb2luZyB0byBvdmVybGF5IHRo
ZQ0KPiA+ID4gPiBxdWFyYW50aW5lX2xpbmsgYnkgZnJlZV90cmFjaywgYnV0IGl0IHNlZW1zIGxp
a2UgdG8gYWRkIGZyZWVfdHJhY2sgdG8NCj4gPiA+ID4ga2FzYW5fZnJlZV9tZXRhLiBEb2VzIGl0
IGVubGFyZ2UgbWV0YS1kYXRhIHNpemU/DQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBhc3N1bWUgaXQg
c2hvdWxkIG5vdCBpbmNyZWFzZSBtZXRhLWRhdGEgc2l6ZS4gSW4gYm90aCBjYXNlcyB3ZQ0KPiA+
ID4gc3RvcmUgZXhhY3RseSB0aGUgc2FtZSBpbmZvcm1hdGlvbiBpbnNpZGUgb2YgdGhlIG9iamVj
dDogcXVhcmFudGluZQ0KPiA+ID4gbGluayBhbmQgZnJlZSB0cmFjay4NCj4gPiA+IEkgc2VlIGl0
IG1vcmUgYXMgYSBxdWVzdGlvbiBvZiBjb2RlIG9yZ2FuaXphdGlvbi4gV2UgYWxyZWFkeSBoYXZl
IGENCj4gPiA+IGNvbmNlcHQgb2YgInRoaXMgZGF0YSBpcyBwbGFjZWQgaW5zaWRlIG9mIHRoZSBm
cmVlZCBvYmplY3QiLCB3ZQ0KPiA+ID4gYWxyZWFkeSBoYXZlIGEgbmFtZSBmb3IgaXQgKGthc2Fu
X2ZyZWVfbWV0YSksIHdlIGFscmVhZHkgaGF2ZSBjb2RlIHRvDQo+ID4gPiBjaG9vc2Ugd2hlcmUg
dG8gcGxhY2UgaXQsIHdlIGFscmVhZHkgaGF2ZSBoZWxwZXIgZnVuY3Rpb25zIHRvIGFjY2Vzcw0K
PiA+ID4gaXQuIEFuZCB5b3VyIGNoYW5nZSBlZmZlY3RpdmVseSBkdXBsaWNhdGVzIGFsbCBvZiB0
aGlzIHRvIHBsYWNlIHRoZQ0KPiA+ID4gZnJlZSB0cmFjay4NCj4gPiA+DQo+ID4NCj4gPiBJIHdh
bnQgdG8gbWFrZSBhIHN1bW1hcnkuIFdoaWNoIG9mIHRoZSBmb2xsb3dpbmcgaXMgdGhlIGFwcHJv
YWNoIHdlDQo+ID4gd2FudD8gb3IgaWYgSSBoYXZlIHNvbWUgbWlzdW5kZXJzdGFuZGluZ3MsIHBs
ZWFzZSBoZWxwIG1lIHRvIGNvcnJlY3QuDQo+ID4gVGhhbmtzLg0KPiA+DQo+ID4gMSkgRm9yIGRp
ZmZlcmVudCBvYmplY3QsIHRoZW4gaXQgd2lsbCBoYXMgdHdvIHdheXMuDQo+ID4gMS5hKSBXaGVu
IG9iamVjdCBhcmUgTEFCX1RZUEVTQUZFX0JZX1JDVSB8fCBjYWNoZS0+Y3RvciwgdGhlbiBzdG9y
ZSBmcmVlDQo+ID4gc3RhY2sgaW50byBmcmVlIHRyYWNrIG9mIHN0cnVjdCBrYXNhbl9mcmVlX21l
dGEuDQo+ID4gMi5iKSBFeGNlcHQgMS5hKSwgc3RvcmUgZnJlZSBzdGFjayBpbnRvIGZyZWVkIG9i
amVjdC4NCj4gPg0KPiA+IG9yDQo+ID4NCj4gPiAyKSBXZSBhbHdheXMgc3RvcmUgZnJlZSBzdGFj
ayBpbnRvIGZyZWUgdHJhY2sgb2Ygc3RydWN0IGthc2FuX2ZyZWVfbWV0YQ0KPiANCj4gSSBtZWFu
dCAyKTogV2UgYWx3YXlzIHN0b3JlIGZyZWUgc3RhY2sgaW50byBmcmVlIHRyYWNrIG9mIHN0cnVj
dA0KPiBrYXNhbl9mcmVlX21ldGEuDQo+IEkgdGhpbmsgaXQgd2lsbCBkbyB0aGUgc2FtZSBhcyBv
dGhlciBvcHRpb25zIGJ1dCBqdXN0IHdpdGggbGVzcyBjb2RlDQo+IChhbmQgc2ltcGxlciBjb2Rl
KS4NCj4gDQo+IE1heWJlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcgaGVyZT8NCj4gDQoNCllvdSBh
cmUgcmlnaHQsIEkgb25seSBtYWtlIGEgZmluYWwgY29uZmlybWF0aW9uIHdpdGggeW91LiBOb3cg
dGhlcmUNCnNob3VsZCBiZSBubyBwcm9ibGVtcywgSSB3aWxsIHRyeSB0byBpbXBsZW1lbnQgaXQu
DQoNClRoYW5rIHlvdSBmb3IgeW91ciBnb29kIHN1Z2dlc3Rpb24uDQoNCj4gDQo+IA0KPiANCj4g
PiA+ID4gPiBBbmQgSSB0aGluayBpdHMgbGlmZS10aW1lIGFuZCBldmVyeXRoaW5nIHNob3VsZCBi
ZSBleGFjdGx5IHdoYXQgd2UgbmVlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFsc28gaXQgc2hv
dWxkIGhlbHAgdG8gZml4IHRoZSBwcm9ibGVtIHdpdGggY3RvcnM6IGthc2FuX2ZyZWVfbWV0YSBp
cw0KPiA+ID4gPiA+IGFscmVhZHkgYWxsb2NhdGVkIG9uIHRoZSBzaWRlIGZvciBzdWNoIG9iamVj
dHMsIGFuZCB0aGF0J3MgZXhhY3RseQ0KPiA+ID4gPiA+IHdoYXQgd2UgbmVlZCBmb3Igb2JqZWN0
cyB3aXRoIGN0b3Incy4NCj4gPiA+ID4NCj4gPiA+ID4gSSBzZWUuDQoNCg==

