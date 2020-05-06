Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792F720714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mcol6PT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEFMB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:01:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3687 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727861AbgEFMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:01:56 -0400
X-UUID: 968fbabcc65544d6a29314853d4acead-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QP0Z6ozRv4E9IF9IdA2oNzT3UIfPRWDRnB6r6crxAtE=;
        b=Mcol6PT9GvCs5XvO8Ips6JJuFzlkDhGq72FAGSFohsSlHlycmRc95K1ng5qmnSPESE+qzorrvTYJRJhOYzAHtMaeouab1L/Wz3GBJM0ux4J/d+Li8yMw/4KOgByxTPYesmaavnU2RQASCX/KfluL3egJyd5MNigqPceO05AC4sM=;
X-UUID: 968fbabcc65544d6a29314853d4acead-20200506
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 12963967; Wed, 06 May 2020 20:01:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 20:01:47 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 20:01:47 +0800
Message-ID: <1588766510.23664.31.camel@mtksdccf07>
Subject: Re: [PATCH 0/3] kasan: memorize and print call_rcu stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
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
Date:   Wed, 6 May 2020 20:01:50 +0800
In-Reply-To: <CACT4Y+atTS6p4b23AH+G9LM-k2gU=kMdkKQdARSboxc-H8CLTQ@mail.gmail.com>
References: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
         <2BF68E83-4611-48B2-A57F-196236399219@lca.pw>
         <1588746219.16219.10.camel@mtksdccf07>
         <CACT4Y+atTS6p4b23AH+G9LM-k2gU=kMdkKQdARSboxc-H8CLTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3E77E78FC4A39AC2C8C02C3404C5BF8283AFF9FF6F48C546033B172E256C57172000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTA2IGF0IDExOjM3ICswMjAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGth
c2FuLWRldiB3cm90ZToNCj4gT24gV2VkLCBNYXkgNiwgMjAyMCBhdCA4OjIzIEFNIFdhbHRlciBX
dSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0Y2hz
ZXQgaW1wcm92ZXMgS0FTQU4gcmVwb3J0cyBieSBtYWtpbmcgdGhlbSB0byBoYXZlDQo+ID4gPiA+
IGNhbGxfcmN1KCkgY2FsbCBzdGFjayBpbmZvcm1hdGlvbi4gSXQgaXMgaGVscGZ1bCBmb3IgcHJv
Z3JhbW1lcnMNCj4gPiA+ID4gdG8gc29sdmUgdXNlLWFmdGVyLWZyZWUgb3IgZG91YmxlLWZyZWUg
bWVtb3J5IGlzc3VlLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgS0FTQU4gcmVwb3J0IHdhcyBhcyBm
b2xsb3dzKGNsZWFuZWQgdXAgc2xpZ2h0bHkpOg0KPiA+ID4gPg0KPiA+ID4gPiBCVUc6IEtBU0FO
OiB1c2UtYWZ0ZXItZnJlZSBpbiBrYXNhbl9yY3VfcmVjbGFpbSsweDU4LzB4NjANCj4gPiA+ID4N
Cj4gPiA+ID4gRnJlZWQgYnkgdGFzayAwOg0KPiA+ID4gPiBzYXZlX3N0YWNrKzB4MjQvMHg1MA0K
PiA+ID4gPiBfX2thc2FuX3NsYWJfZnJlZSsweDExMC8weDE3OA0KPiA+ID4gPiBrYXNhbl9zbGFi
X2ZyZWUrMHgxMC8weDE4DQo+ID4gPiA+IGtmcmVlKzB4OTgvMHgyNzANCj4gPiA+ID4ga2FzYW5f
cmN1X3JlY2xhaW0rMHgxYy8weDYwDQo+ID4gPiA+IHJjdV9jb3JlKzB4OGI0LzB4MTBmOA0KPiA+
ID4gPiByY3VfY29yZV9zaSsweGMvMHgxOA0KPiA+ID4gPiBlZmlfaGVhZGVyX2VuZCsweDIzOC8w
eGE2Yw0KPiA+ID4gPg0KPiA+ID4gPiBGaXJzdCBjYWxsX3JjdSgpIGNhbGwgc3RhY2s6DQo+ID4g
PiA+IHNhdmVfc3RhY2srMHgyNC8weDUwDQo+ID4gPiA+IGthc2FuX3JlY29yZF9jYWxscmN1KzB4
YzgvMHhkOA0KPiA+ID4gPiBjYWxsX3JjdSsweDE5MC8weDU4MA0KPiA+ID4gPiBrYXNhbl9yY3Vf
dWFmKzB4MWQ4LzB4Mjc4DQo+ID4gPiA+DQo+ID4gPiA+IExhc3QgY2FsbF9yY3UoKSBjYWxsIHN0
YWNrOg0KPiA+ID4gPiAoc3RhY2sgaXMgbm90IGF2YWlsYWJsZSkNCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gQWRkIG5ldyBDT05GSUcgb3B0aW9uIHRvIHJlY29yZCBmaXJzdCBhbmQgbGFzdCBj
YWxsX3JjdSgpIGNhbGwgc3RhY2sNCj4gPiA+ID4gYW5kIEtBU0FOIHJlcG9ydCBwcmludHMgdHdv
IGNhbGxfcmN1KCkgY2FsbCBzdGFjay4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBvcHRpb24gZG9l
c24ndCBpbmNyZWFzZSB0aGUgY29zdCBvZiBtZW1vcnkgY29uc3VtcHRpb24uIEl0IGlzDQo+ID4g
PiA+IG9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uDQo+ID4gPg0KPiA+ID4gSSBkb27i
gJl0IHVuZGVyc3RhbmQgd2h5IHRoaXMgbmVlZHMgdG8gYmUgYSBLY29uZmlnIG9wdGlvbiBhdCBh
bGwuIElmIGNhbGxfcmN1KCkgc3RhY2tzIGFyZSB1c2VmdWwgaW4gZ2VuZXJhbCwgdGhlbiBqdXN0
IGFsd2F5cyBnYXRoZXIgdGhvc2UgaW5mb3JtYXRpb24uIEhvdyBkbyBkZXZlbG9wZXJzIGp1ZGdl
IGlmIHRoZXkgbmVlZCB0byBzZWxlY3QgdGhpcyBvcHRpb24gb3Igbm90Pw0KPiA+DQo+ID4gQmVj
YXVzZSB3ZSBkb24ndCB3YW50IHRvIGluY3JlYXNlIHNsdWIgbWV0YS1kYXRhIHNpemUsIHNvIGVu
YWJsaW5nIHRoaXMNCj4gPiBvcHRpb24gY2FuIHByaW50IGNhbGxfcmN1KCkgc3RhY2tzLCBidXQg
dGhlIGluLXVzZSBzbHViIG9iamVjdCBkb2Vzbid0DQo+ID4gcHJpbnQgZnJlZSBzdGFjay4gU28g
aWYgaGF2ZSBvdXQtb2YtYm91bmQgaXNzdWUsIHRoZW4gaXQgd2lsbCBub3QgcHJpbnQNCj4gPiBm
cmVlIHN0YWNrLiBJdCBpcyBhIHRyYWRlLW9mZiwgc2VlIFsxXS4NCj4gPg0KPiA+IFsxXSBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5ODQzNw0KPiANCj4gSGkg
V2FsdGVyLA0KPiANCj4gR3JlYXQgeW91IGFyZSB0YWNrbGluZyB0aGlzIQ0KPiANCj4gSSBoYXZl
IHRoZSBzYW1lIGdlbmVyYWwgc2VudGltZW50IGFzIFFpYW4uIEkgd291bGQgZW5hYmxlIHRoaXMN
Cj4gdW5jb25kaXRpb25hbGx5IGJlY2F1c2U6DQo+IA0KPiAxLiBXZSBzdGlsbCBjYW4ndCBnZXQg
Ym90aCByY3Ugc3RhY2sgYW5kIGZyZWUgc3RhY2suIEkgd291bGQgYXNzdW1lDQo+IG1vc3Qga2Vy
bmVsIHRlc3Rpbmcgc3lzdGVtcyBuZWVkIHRvIGVuYWJsZSB0aGlzICh3ZSBkZWZpbml0ZWx5IGVu
YWJsZQ0KPiBvbiBzeXpib3QpLiBUaGlzIG1lYW5zIHdlIGRvIG5vdCBoYXZlIGZyZWUgc3RhY2sg
Zm9yIGFsbG9jYXRpb24NCj4gb2JqZWN0cyBpbiBhbnkgcmVwb3J0cyBjb21pbmcgZnJvbSB0ZXN0
aW5nIHN5c3RlbXMuIFdoaWNoIGdyZWF0bHkNCj4gZGltaW5pc2hlcyB0aGUgdmFsdWUgb2YgdGhl
IG90aGVyIG1vZGUuDQo+IA0KPiAyLiBLZXJuZWwgaXMgdW5kZXJ0ZXN0ZWQuIEludHJvZHVjaW5n
IGFueSBhZGRpdGlvbmFsIGNvbmZpZ3VyYXRpb24NCj4gb3B0aW9ucyBpcyBhIHByb2JsZW0gaW4g
c3VjaCBjb250ZXh0LiBDaGFuY2VzIGFyZSB0aGF0IHNvbWUgb2YgdGhlDQo+IG1vZGVzIGFyZSBu
b3Qgd29ya2luZyBvciB3aWxsIGJyZWFrIGluIGZ1dHVyZS4NCj4gDQo+IDMuIFRoYXQgZnJlZSBz
dGFjayBhY3R1YWxseSBjYXVzZXMgbG90cyBvZiBjb25mdXNpb24gYW5kIEkgbmV2ZXIgZm91bmQN
Cj4gaXQgdXNlZnVsOg0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dp
P2lkPTE5ODQyNQ0KPiBJZiBpdCdzIGEgdmVyeSBkZWxheWVkIFVBRiwgZWl0aGVyIG9uZSBtYXkg
Z2V0IGFub3RoZXIgcmVwb3J0IGZvciB0aGUNCj4gc2FtZSBidWcgd2l0aCBub3Qgc28gZGVsYXll
ZCBVQUYsIG9yIGlmIGl0J3Mgd2F5IHRvbyBkZWxheWVkLCB0aGVuIHRoZQ0KPiBwcmV2aW91cyBm
cmVlIHN0YWNrIGlzIHdyb25nIGFzIHdlbGwuDQo+IA0KPiA0LiBNb3N0IHVzZXJzIGRvbid0IGNh
cmUgdGhhdCBtdWNoIGFib3V0IGRlYnVnZ2luZyB0b29scyB0byBsZWFybg0KPiBldmVyeSBiaXQg
b2YgZXZlcnkgZGVidWdnaW5nIHRvb2wgYW5kIHNwZW5kIHRpbWUgZmluZS10dW5pbmcgaXQgZm9y
DQo+IHRoZWlyIGNvbnRleHQuIE1vc3QgS0FTQU4gdXNlcnMgd29uJ3QgZXZlbiBiZSBhd2FyZSBv
ZiB0aGlzIGNob2ljZSwNCj4gYW5kIHRoZXkgd2lsbCBqdXN0IHVzZSB3aGF0ZXZlciBpcyB0aGUg
ZGVmYXVsdC4NCj4gDQo+IDUuIEVhY2ggY29uZmlndXJhdGlvbiBvcHRpb24gaW5jcmVhc2VzIGlt
cGxlbWVudGF0aW9uIGNvbXBsZXhpdHkuDQo+IA0KPiBXaGF0IHdvdWxkIGhhdmUgdmFsdWUgaXMg
aWYgd2UgZmlndXJlIG91dCBob3cgdG8gbWFrZSBib3RoIG9mIHRoZW0NCj4gd29yayBhdCB0aGUg
c2FtZSB0aW1lIHdpdGhvdXQgaW5jcmVhc2luZyBtZW1vcnkgY29uc3VtcHRpb24uIEJ1dCBJDQo+
IGRvbid0IHNlZSBhbnkgd2F5IHRvIGRvIHRoaXMuDQo+IA0KPiBJIHByb3Bvc2UgdG8gbWFrZSB0
aGlzIHRoZSBvbmx5IG1vZGUuIEkgYW0gc3VyZSBsb3RzIG9mIHVzZXJzIHdpbGwNCj4gZmluZCB0
aGlzIGFkZGl0aW9uYWwgc3RhY2sgdXNlZnVsLCB3aGVyZWFzIHRoZSBmcmVlIHN0YWNrIGlzIGV2
ZW4NCj4gZnJlcXVlbnRseSBjb25mdXNpbmcuDQo+IA0KDQpPay4NCklmIHdlIHdhbnQgdG8gaGF2
ZSBhIGRlZmF1bHQgZW5hYmxpbmcgaXQsIGJ1dCBpdCBzaG91bGQgb25seSB3b3JrIGluDQpnZW5l
cmljIEtBU0FOLCBiZWNhdXNlIHdlIG5lZWQgdG8gZ2V0IG9iamVjdCBzdGF0dXMoYWxsb2NhdGlv
biBvcg0KZnJlZWluZykgZnJvbSBzaGFkb3cgbWVtb3J5LCB0YWctYmFzZWQgS0FTQU4gY2FuJ3Qg
ZG8gaXQuIFNvIHdlIHNob3VsZA0KaGF2ZSBhIGRlZmF1bHQgZW5hYmxpbmcgaXQgaW4gZ2VuZXJp
YyBLQVNBTj8NCg0K

