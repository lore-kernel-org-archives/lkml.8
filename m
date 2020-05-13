Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C842CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D994D206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EujlaFy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgEMJFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:05:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30959 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730603AbgEMJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:05:47 -0400
X-UUID: 1c94421455df4e59b215e8ab80cba6f8-20200513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5D8WCKWhqtUmM0QZKWnoCy74fM9ScjwQw/X1UTYKKjQ=;
        b=EujlaFy5m20lUy8K644gzWZF6PcKjM4OVXTQivTdUy5lse8kQyCNMk1s54WcZ3EsKU7EYtu5O/IMoxLjc7whnNX6LgOz8OZdOEAX8kkpxAiBl+MbsFRi10XEecygkmG88a1L3DyuqLljeBna+0OxqyUfd2q1SsrfsDcxE2MK0tA=;
X-UUID: 1c94421455df4e59b215e8ab80cba6f8-20200513
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1888924811; Wed, 13 May 2020 17:05:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 May 2020 17:05:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 May 2020 17:05:41 +0800
Message-ID: <1589360744.14554.10.camel@mtksdccf07>
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
Date:   Wed, 13 May 2020 17:05:44 +0800
In-Reply-To: <CACT4Y+Zv3rCZs8z56NHM0hHWMwQr_2AT8nx0vUigzMG2v3Rt8Q@mail.gmail.com>
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
         <CACT4Y+YWNwTSoheJhc3nMdQi9m719F3PzpGo3TfRY3zAg9EwuQ@mail.gmail.com>
         <CACT4Y+bO1Zg_jgFHbOWgp7fLAADOQ_-AZmjEHz0WG7=oyOt4Gg@mail.gmail.com>
         <1589203771.21284.22.camel@mtksdccf07>
         <CACT4Y+aOkuH6Dn+L+wv1qVOLgXyCY_Ck4hecAMw3DgyBgC9qHw@mail.gmail.com>
         <1589254720.19238.36.camel@mtksdccf07>
         <CACT4Y+aibZEBR-3bos3ox5Tuu48TnHC20mDDN0AkWeRUKrT0aw@mail.gmail.com>
         <1589334472.19238.44.camel@mtksdccf07>
         <CACT4Y+Zv3rCZs8z56NHM0hHWMwQr_2AT8nx0vUigzMG2v3Rt8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDA4OjUxICswMjAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGth
c2FuLWRldiB3cm90ZToNCj4gT24gV2VkLCBNYXkgMTMsIDIwMjAgYXQgMzo0OCBBTSBXYWx0ZXIg
V3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IEFyZSB5b3Ug
c3VyZSBpdCB3aWxsIGluY3JlYXNlIG9iamVjdCBzaXplPw0KPiA+ID4gPiA+IEkgdGhpbmsgd2Ug
b3ZlcmxhcCBrYXNhbl9mcmVlX21ldGEgd2l0aCB0aGUgb2JqZWN0IGFzIHdlbGwuIFRoZSBvbmx5
DQo+ID4gPiA+ID4gY2FzZSB3ZSBkb24ndCBvdmVybGFwIGthc2FuX2ZyZWVfbWV0YSB3aXRoIHRo
ZSBvYmplY3QgYXJlDQo+ID4gPiA+ID4gU0xBQl9UWVBFU0FGRV9CWV9SQ1UgfHwgY2FjaGUtPmN0
b3IuIEJ1dCB0aGVzZSBhcmUgcmFyZSBhbmQgaXQgc2hvdWxkDQo+ID4gPiA+ID4gb25seSBhZmZl
Y3Qgc21hbGwgb2JqZWN0cyB3aXRoIHNtYWxsIHJlZHpvbmVzLg0KPiA+ID4gPiA+IEFuZCBJIHRo
aW5rIG5vdyB3ZSBzaW1wbHkgaGF2ZSBhIGJ1ZyBmb3IgdGhlc2Ugb2JqZWN0cywgd2UgY2hlY2sN
Cj4gPiA+ID4gPiBLQVNBTl9LTUFMTE9DX0ZSRUUgYW5kIHRoZW4gYXNzdW1lIG9iamVjdCBjb250
YWlucyBmcmVlIHN0YWNrLCBidXQgZm9yDQo+ID4gPiA+ID4gb2JqZWN0cyB3aXRoIGN0b3IsIHRo
ZXkgc3RpbGwgY29udGFpbiBsaXZlIG9iamVjdCBkYXRhLCB3ZSBkb24ndCBzdG9yZQ0KPiA+ID4g
PiA+IGZyZWUgc3RhY2sgaW4gdGhlbS4NCj4gPiA+ID4gPiBTdWNoIG9iamVjdHMgY2FuIGJlIGJv
dGggZnJlZSBhbmQgc3RpbGwgY29udGFpbiB1c2VyIGRhdGEuDQo+ID4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gT3ZlcmxheSBrYXNhbl9mcmVlX21ldGEuIEkgc2VlLiBidXQgb3ZlcmxheSBpdCBv
bmx5IHdoZW4gdGhlIG9iamVjdCB3YXMNCj4gPiA+ID4gZnJlZWQuIGthc2FuX2ZyZWVfbWV0YSB3
aWxsIGJlIHVzZWQgdW50aWwgZnJlZSBvYmplY3QuDQo+ID4gPiA+IDEpLiBXaGVuIHB1dCBvYmpl
Y3QgaW50byBxdWFyYW50aW5lLCBpdCBuZWVkIGthc2FuX2ZyZWVfbWV0YS4NCj4gPiA+ID4gMiku
IFdoZW4gdGhlIG9iamVjdCBleGl0IGZyb20gcXVhcmFudGluZSwgaXQgbmVlZCBrYXNhbl9mcmVl
X21ldGENCj4gPiA+ID4NCj4gPiA+ID4gSWYgd2UgY2hvb3NlIHRvIG92ZXJsYXkga2FzYW5fZnJl
ZV9tZXRhLCB0aGVuIHRoZSBmcmVlIHN0YWNrIHdpbGwgYmUNCj4gPiA+ID4gc3RvcmVkIHZlcnkg
bGF0ZS4gSXQgbWF5IGhhcyBubyBmcmVlIHN0YWNrIGluIHJlcG9ydC4NCj4gPiA+DQo+ID4gPiBT
b3JyeSwgSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uDQo+ID4gPg0KPiA+ID4gV2h5
IHdpbGwgaXQgYmUgc3RvcmVkIHRvbyBsYXRlPw0KPiA+ID4gSW4gX19rYXNhbl9zbGFiX2ZyZWUo
KSBwdXR0aW5nIGludG8gcXVhcmFudGluZSBhbmQgcmVjb3JkaW5nIGZyZWUNCj4gPiA+IHN0YWNr
IGFyZSBsaXRlcmFsbHkgYWRqYWNlbnQgbGluZXMgb2YgY29kZToNCj4gPiA+DQo+ID4gPiBzdGF0
aWMgYm9vbCBfX2thc2FuX3NsYWJfZnJlZShzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUsIHZvaWQg
Km9iamVjdCwNCj4gPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgaXAsIGJvb2wgcXVhcmFudGluZSkN
Cj4gPiA+IHsNCj4gPiA+ICAgICAuLi4NCj4gPiA+ICAgICBrYXNhbl9zZXRfZnJlZV9pbmZvKGNh
Y2hlLCBvYmplY3QsIHRhZyk7DQo+ID4gPiAgICAgcXVhcmFudGluZV9wdXQoZ2V0X2ZyZWVfaW5m
byhjYWNoZSwgb2JqZWN0KSwgY2FjaGUpOw0KPiA+ID4NCj4gPiA+DQo+ID4gPiBKdXN0IHRvIG1h
a2Ugc3VyZSwgd2hhdCBJIG1lYW50IGlzIHRoYXQgd2UgYWRkIGZyZWVfdHJhY2sgdG8ga2FzYW5f
ZnJlZV9tZXRhOg0KPiA+ID4NCj4gPiA+IHN0cnVjdCBrYXNhbl9mcmVlX21ldGEgew0KPiA+ID4g
ICAgIHN0cnVjdCBxbGlzdF9ub2RlIHF1YXJhbnRpbmVfbGluazsNCj4gPiA+ICsgIHN0cnVjdCBr
YXNhbl90cmFjayBmcmVlX3RyYWNrOw0KPiA+ID4gfTsNCj4gPiA+DQo+ID4NCj4gPiBXaGVuIEkg
c2VlIGFib3ZlIHN0cnVjdCBrYXNhbl9mcmVlX21ldGEsIEkga25vdyB3aHkgeW91IGRvbid0IHVu
ZGVyc3RhbmQNCj4gPiBteSBtZWFuaW5nLCBiZWNhdXNlIEkgdGhvdWdodCB5b3Ugd2VyZSBnb2lu
ZyB0byBvdmVybGF5IHRoZQ0KPiA+IHF1YXJhbnRpbmVfbGluayBieSBmcmVlX3RyYWNrLCBidXQg
aXQgc2VlbXMgbGlrZSB0byBhZGQgZnJlZV90cmFjayB0bw0KPiA+IGthc2FuX2ZyZWVfbWV0YS4g
RG9lcyBpdCBlbmxhcmdlIG1ldGEtZGF0YSBzaXplPw0KPiANCj4gSSB3b3VsZCBhc3N1bWUgaXQg
c2hvdWxkIG5vdCBpbmNyZWFzZSBtZXRhLWRhdGEgc2l6ZS4gSW4gYm90aCBjYXNlcyB3ZQ0KPiBz
dG9yZSBleGFjdGx5IHRoZSBzYW1lIGluZm9ybWF0aW9uIGluc2lkZSBvZiB0aGUgb2JqZWN0OiBx
dWFyYW50aW5lDQo+IGxpbmsgYW5kIGZyZWUgdHJhY2suDQo+IEkgc2VlIGl0IG1vcmUgYXMgYSBx
dWVzdGlvbiBvZiBjb2RlIG9yZ2FuaXphdGlvbi4gV2UgYWxyZWFkeSBoYXZlIGENCj4gY29uY2Vw
dCBvZiAidGhpcyBkYXRhIGlzIHBsYWNlZCBpbnNpZGUgb2YgdGhlIGZyZWVkIG9iamVjdCIsIHdl
DQo+IGFscmVhZHkgaGF2ZSBhIG5hbWUgZm9yIGl0IChrYXNhbl9mcmVlX21ldGEpLCB3ZSBhbHJl
YWR5IGhhdmUgY29kZSB0bw0KPiBjaG9vc2Ugd2hlcmUgdG8gcGxhY2UgaXQsIHdlIGFscmVhZHkg
aGF2ZSBoZWxwZXIgZnVuY3Rpb25zIHRvIGFjY2Vzcw0KPiBpdC4gQW5kIHlvdXIgY2hhbmdlIGVm
ZmVjdGl2ZWx5IGR1cGxpY2F0ZXMgYWxsIG9mIHRoaXMgdG8gcGxhY2UgdGhlDQo+IGZyZWUgdHJh
Y2suDQo+IA0KDQpJIHdhbnQgdG8gbWFrZSBhIHN1bW1hcnkuIFdoaWNoIG9mIHRoZSBmb2xsb3dp
bmcgaXMgdGhlIGFwcHJvYWNoIHdlDQp3YW50PyBvciBpZiBJIGhhdmUgc29tZSBtaXN1bmRlcnN0
YW5kaW5ncywgcGxlYXNlIGhlbHAgbWUgdG8gY29ycmVjdC4NClRoYW5rcy4NCg0KMSkgRm9yIGRp
ZmZlcmVudCBvYmplY3QsIHRoZW4gaXQgd2lsbCBoYXMgdHdvIHdheXMuDQoxLmEpIFdoZW4gb2Jq
ZWN0IGFyZSBMQUJfVFlQRVNBRkVfQllfUkNVIHx8IGNhY2hlLT5jdG9yLCB0aGVuIHN0b3JlIGZy
ZWUNCnN0YWNrIGludG8gZnJlZSB0cmFjayBvZiBzdHJ1Y3Qga2FzYW5fZnJlZV9tZXRhLg0KMi5i
KSBFeGNlcHQgMS5hKSwgc3RvcmUgZnJlZSBzdGFjayBpbnRvIGZyZWVkIG9iamVjdC4NCg0Kb3IN
Cg0KMikgV2UgYWx3YXlzIHN0b3JlIGZyZWUgc3RhY2sgaW50byBmcmVlIHRyYWNrIG9mIHN0cnVj
dCBrYXNhbl9mcmVlX21ldGENCg0KDQo+ID4gPiBBbmQgSSB0aGluayBpdHMgbGlmZS10aW1lIGFu
ZCBldmVyeXRoaW5nIHNob3VsZCBiZSBleGFjdGx5IHdoYXQgd2UgbmVlZC4NCj4gPiA+DQo+ID4g
PiBBbHNvIGl0IHNob3VsZCBoZWxwIHRvIGZpeCB0aGUgcHJvYmxlbSB3aXRoIGN0b3JzOiBrYXNh
bl9mcmVlX21ldGEgaXMNCj4gPiA+IGFscmVhZHkgYWxsb2NhdGVkIG9uIHRoZSBzaWRlIGZvciBz
dWNoIG9iamVjdHMsIGFuZCB0aGF0J3MgZXhhY3RseQ0KPiA+ID4gd2hhdCB3ZSBuZWVkIGZvciBv
YmplY3RzIHdpdGggY3RvcidzLg0KPiA+DQo+ID4gSSBzZWUuDQo+IA0KDQo=

