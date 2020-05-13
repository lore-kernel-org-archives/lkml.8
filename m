Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2551AC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014B2206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JpFd5ST+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEMCFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:05:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17120 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgEMCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:05:37 -0400
X-UUID: e4d4ff2ba2164878b27d683e16db2781-20200513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=096wrzVA6wz4JNcGHZfNakkofpMPOvUZEm4oZoXOkWA=;
        b=JpFd5ST+NiYzBrl87KFFlDTNDqveUCvA+vVuvt7A2G3TbgSM+QLtSE+veoZ+0LM/ARC16suHNbTXSE7Da1jtgel+7TxDwKur8TInzuxq9AHUjcV8pl863POyHGvKKrpMIFw1SJtqy6LVfH31FgTk36pnjpPZZreMnX7D/uvRAwo=;
X-UUID: e4d4ff2ba2164878b27d683e16db2781-20200513
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1593172682; Wed, 13 May 2020 10:05:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 May 2020 10:05:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 May 2020 10:05:30 +0800
Message-ID: <1589335531.19238.52.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/3] rcu/kasan: record and print call_rcu() call stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 13 May 2020 10:05:31 +0800
In-Reply-To: <CACT4Y+aWNDntO6+Rhn0a-4N1gLOTe5UzYB9m5TnkFxG_L15cXA@mail.gmail.com>
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
         <20200511180527.GZ2869@paulmck-ThinkPad-P72>
         <1589250993.19238.22.camel@mtksdccf07>
         <CACT4Y+b6ZfmZG3YYC_TkoeGaAQjSEKvF4dZ9vHzTx5iokD4zTQ@mail.gmail.com>
         <20200512142541.GD2869@paulmck-ThinkPad-P72>
         <CACT4Y+ZfzLhcG2Wy_iEMB=hJ5k=ib+X-m29jDG2Jcs7S-TPX=w@mail.gmail.com>
         <20200512161422.GG2869@paulmck-ThinkPad-P72>
         <CACT4Y+aWNDntO6+Rhn0a-4N1gLOTe5UzYB9m5TnkFxG_L15cXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTEyIGF0IDE4OjIyICswMjAwLCBEbWl0cnkgVnl1a292IHdyb3RlOg0K
PiBPbiBUdWUsIE1heSAxMiwgMjAyMCBhdCA2OjE0IFBNIFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxt
Y2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gVGhpcyBmZWF0dXJlIHdpbGwg
cmVjb3JkIGZpcnN0IGFuZCBsYXN0IGNhbGxfcmN1KCkgY2FsbCBzdGFjayBhbmQNCj4gPiA+ID4g
PiA+ID4gPiBwcmludCB0d28gY2FsbF9yY3UoKSBjYWxsIHN0YWNrIGluIEtBU0FOIHJlcG9ydC4N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gU3VwcG9zZSB0aGF0IGEgZ2l2ZW4gcmN1X2hl
YWQgc3RydWN0dXJlIGlzIHBhc3NlZCB0byBjYWxsX3JjdSgpLCB0aGVuDQo+ID4gPiA+ID4gPiA+
IHRoZSBncmFjZSBwZXJpb2QgZWxhcHNlcywgdGhlIGNhbGxiYWNrIGlzIGludm9rZWQsIGFuZCB0
aGUgZW5jbG9zaW5nDQo+ID4gPiA+ID4gPiA+IGRhdGEgc3RydWN0dXJlIGlzIGZyZWVkLiAgQnV0
IHRoZW4gdGhhdCBzYW1lIHJlZ2lvbiBvZiBtZW1vcnkgaXMNCj4gPiA+ID4gPiA+ID4gaW1tZWRp
YXRlbHkgcmVhbGxvY2F0ZWQgYXMgdGhlIHNhbWUgdHlwZSBvZiBzdHJ1Y3R1cmUgYW5kIGFnYWlu
DQo+ID4gPiA+ID4gPiA+IHBhc3NlZCB0byBjYWxsX3JjdSgpLCBhbmQgdGhhdCB0aGlzIGN5Y2xl
IHJlcGVhdHMgc2V2ZXJhbCB0aW1lcy4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gV291
bGQgdGhlIGZpcnN0IGNhbGwgc3RhY2sgZm9yZXZlciBiZSBhc3NvY2lhdGVkIHdpdGggdGhlIGZp
cnN0DQo+ID4gPiA+ID4gPiA+IGNhbGxfcmN1KCkgaW4gdGhpcyBzZXJpZXM/ICBJZiBzbywgd291
bGRuJ3QgdGhlIGxhc3QgdHdvIHVzdWFsbHkNCj4gPiA+ID4gPiA+ID4gYmUgdGhlIG1vc3QgdXNl
ZnVsPyAgT3IgYW0gSSB1bmNsZWFyIG9uIHRoZSB1c2UgY2FzZT8NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IDIgcG9pbnRzIGhlcmU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAxLiBXaXRoIEtBU0FOIHRo
ZSBvYmplY3Qgd29uJ3QgYmUgaW1tZWRpYXRlbHkgcmVhbGxvY2F0ZWQuIEtBU0FOIGhhcw0KPiA+
ID4gPiA+ICdxdWFyYW50aW5lJyB0byBkZWxheSByZXVzZSBvZiBoZWFwIG9iamVjdHMuIEl0IGlz
IGFzc3VtZWQgdGhhdCB0aGUNCj4gPiA+ID4gPiBvYmplY3QgaXMgc3RpbGwgaW4gcXVhcmFudGlu
ZSB3aGVuIHdlIGRldGVjdCBhIHVzZS1hZnRlci1mcmVlLiBJbiBzdWNoDQo+ID4gPiA+ID4gYSBj
YXNlIHdlIHdpbGwgaGF2ZSBwcm9wZXIgY2FsbF9yY3Ugc3RhY2tzIGFzIHdlbGwuDQo+ID4gPiA+
ID4gSXQgaXMgcG9zc2libGUgdGhhdCB0aGUgb2JqZWN0IGlzIG5vdCBpbiBxdWFyYW50aW5lIGFs
cmVhZHkgYW5kIHdhcw0KPiA+ID4gPiA+IHJldXNlZCBzZXZlcmFsIHRpbWVzIChxdWFyYW50aW5l
IGlzIG5vdCBpbmZpbml0ZSksIGJ1dCB0aGVuIEtBU0FOIHdpbGwNCj4gPiA+ID4gPiByZXBvcnQg
bm9uLXNlbnNlIHN0YWNrcyBmb3IgYWxsb2NhdGlvbi9mcmVlIGFzIHdlbGwuIFNvIHdyb25nIGNh
bGxfcmN1DQo+ID4gPiA+ID4gc3RhY2tzIGFyZSBsZXNzIG9mIGEgcHJvYmxlbSBpbiBzdWNoIGNh
c2VzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gMi4gV2Ugd291bGQgbGlrZSB0byBtZW1vcml6ZSAy
IGxhc3QgY2FsbF9yY3Ugc3RhY2tzIHJlZ2FyZGxlc3MsIGJ1dCB3ZQ0KPiA+ID4gPiA+IGp1c3Qg
ZG9uJ3QgaGF2ZSBhIGdvb2QgcGxhY2UgZm9yIHRoZSBpbmRleCAoYml0IHdoaWNoIG9mIHRoZSAy
IGlzIHRoZQ0KPiA+ID4gPiA+IG9uZSB0byBvdmVyd3JpdGUpLiBQcm9iYWJseSBjb3VsZCBzaG92
ZSBpdCBpbnRvIHNvbWUgZXhpc3RpbmcgZmllbGQsDQo+ID4gPiA+ID4gYnV0IHRoZW4gd2lsbCBy
ZXF1aXJlIGF0b21pYyBvcGVyYXRpb25zLCBldGMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBOb2Jv
ZHkga25vd3MgaG93IHdlbGwvYmFkIGl0IHdpbGwgd29yay4gSSB0aGluayB3ZSBuZWVkIHRvIGdl
dCB0aGUNCj4gPiA+ID4gPiBmaXJzdCB2ZXJzaW9uIGluLCBkZXBsb3kgb24gc3l6Ym90LCBhY2N1
bXVsYXRlIHNvbWUgYmFzZSBvZiBleGFtcGxlDQo+ID4gPiA+ID4gcmVwb3J0cyBhbmQgaXRlcmF0
ZSBmcm9tIHRoZXJlLg0KPiA+ID4gPg0KPiA+ID4gPiBJZiBJIHVuZGVyc3Rvb2QgdGhlIHN0YWNr
LWluZGV4IHBvaW50IGJlbG93LCB3aHkgbm90IGp1c3QgbW92ZSB0aGUNCj4gPiA+ID4gcHJldmlv
dXMgc3RhY2ttIGluZGV4IHRvIGNsb2JiZXIgdGhlIHByZXZpb3VzLXRvLXByZXZpb3VzIHN0YWNr
IGluZGV4LA0KPiA+ID4gPiB0aGVuIHB1dCB0aGUgY3VycmVudCBzdGFjayBpbmRleCBpbnRvIHRo
ZSBzcG90IHRodXMgb3BlbmVkIHVwPw0KPiA+ID4NCj4gPiA+IFdlIGRvbid0IGhhdmUgYW55IGlu
ZGV4IGluIHRoaXMgY2hhbmdlIChkb24ndCBoYXZlIG1lbW9yeSBmb3Igc3VjaCBpbmRleCkuDQo+
ID4gPiBUaGUgcHNldWRvIGNvZGUgaXMiDQo+ID4gPg0KPiA+ID4gdTMyIGF1eF9zdGFja3NbMl07
IC8vID0gezAsMH0NCj4gPiA+DQo+ID4gPiBpZiAoYXV4X3N0YWNrc1swXSAhPSAwKQ0KPiA+ID4g
ICAgIGF1eF9zdGFja3NbMF0gPSBzdGFjazsNCj4gPiA+IGVsc2UNCj4gPiA+ICAgIGF1eF9zdGFj
a3NbMV0gPSBzdGFjazsNCj4gPg0KPiA+IEkgd2FzIHRoaW5raW5nIGluIHRlcm1zIG9mIHNvbWV0
aGluZyBsaWtlIHRoaXM6DQo+ID4NCj4gPiB1MzIgYXV4X3N0YWNrc1syXTsgLy8gPSB7MCwwfQ0K
PiA+DQo+ID4gaWYgKGF1eF9zdGFja3NbMF0gIT0gMCkgew0KPiA+ICAgICBhdXhfc3RhY2tzWzBd
ID0gc3RhY2s7DQo+ID4gfSBlbHNlIHsNCj4gPiAgICBpZiAoYXV4X3N0YWNrc1sxXSkNCj4gPiAg
ICAgICAgIGF1eF9zdGFja3NbMF0gPSBhdXhfc3RhY2tzWzFdOw0KPiA+ICAgIGF1eF9zdGFja3Nb
MV0gPSBzdGFjazsNCj4gPiB9DQo+ID4NCj4gPiBXaGV0aGVyIHRoaXMgYWN0dWFsbHkgbWFrZXMg
c2Vuc2UgaW4gcmVhbCBsaWZlLCBJIGhhdmUgbm8gaWRlYS4NCj4gPiBUaGUgdGhlb3J5IGlzIHRo
YXQgeW91IHdhbnQgdGhlIGxhc3QgdHdvIHN0YWNrcy4gIEhvd2V2ZXIsIGlmIHRoZXNlDQo+ID4g
ZWxlbWVudHMgZ2V0IGNsZWFyZWQgYXQga2ZyZWUoKSB0aW1lLCB0aGVuIEkgY291bGQgZWFzaWx5
IGJlbGlldmUgdGhhdA0KPiA+IHRoZSBhcHByb2FjaCB5b3UgYWxyZWFkeSBoYXZlIChmaXJzdCBh
bmQgbGFzdCkgaXMgdGhlIHdheSB0byBnby4NCj4gPg0KPiA+IEp1c3QgYXNraW5nIHRoZSBxdWVz
dGlvbiwgbm90IGFyZ3VpbmcgZm9yIGEgY2hhbmdlIQ0KPiANCj4gT2gsIHRoaXMgaXMgc28gb2J2
aW91cy4uLiBpbiBoaW5kc2lnaHQhIDopDQo+IA0KPiBXYWx0ZXIsIHdoYXQgZG8geW91IHRoaW5r
Pw0KPiANCg0KdTMyIGF1eF9zdGFja3NbMl07IC8vID0gezAsMH0NCg0KaWYgKGF1eF9zdGFja3Nb
MF0gIT0gMCkgew0KICAgICBhdXhfc3RhY2tzWzBdID0gc3RhY2s7DQp9IGVsc2Ugew0KICAgIGlm
IChhdXhfc3RhY2tzWzFdKQ0KICAgICAgICAgYXV4X3N0YWNrc1swXSA9IGF1eF9zdGFja3NbMV07
DQogICAgYXV4X3N0YWNrc1sxXSA9IHN0YWNrOw0KfQ0KDQpIbW0uLi53aHkgSSB0aGluayBpdCB3
aWxsIGFsd2F5cyBjb3ZlciBhdXhfc3RhY2tzWzBdIGFmdGVyIGF1eF9zdGFja3NbMF0NCmhhcyBz
dGFjaywgaXQgc2hvdWxkIG5vdCByZWNvcmQgbGFzdCB0d28gc3RhY2tzPw0KDQpIb3cgYWJvdXQg
dGhpczoNCg0KdTMyIGF1eF9zdGFja3NbMl07IC8vID0gezAsMH0NCg0KaWYgKGF1eF9zdGFja3Nb
MV0pDQogICAgYXV4X3N0YWNrc1swXSA9IGF1eF9zdGFja3NbMV07DQphdXhfc3RhY2tzWzFdID0g
c3RhY2s7DQoNCj4gSSB3b3VsZCBkbyB0aGlzLiBJIHRoaW5rIGxhdHRlciBzdGFja3MgYXJlIGdl
bmVyYWxseSBtb3JlIGludGVyZXN0aW5nDQo+IHdydCBzaGVkZGluZyBsaWdodCBvbiBhIGJ1Zy4g
VGhlIGZpcnN0IHN0YWNrIG1heSBldmVuIGJlICJzdGF0aWNhbGx5DQo+IGtub3duIiAoZS5nLiBp
ZiBvYmplY3QgaXMgYWx3YXlzIHF1ZXVlZCBpbnRvIGEgd29ya3F1ZXVlIGZvciBzb21lIGxhenkN
Cj4gaW5pdGlhbGl6YXRpb24gZHVyaW5nIGNvbnN0cnVjdGlvbikuDQoNCkkgdGhpbmsgaXQgbWFr
ZSBtb3JlIHNlbnNlIHRvIHJlY29yZCBsYXR0ZXIgc3RhY2ssIHRvby4NCg0KVGhhbmtzIGZvciB5
b3VyIGFuZCBQYXVsJ3Mgc3VnZ2VzdGlvbi4NCg0KDQo=

