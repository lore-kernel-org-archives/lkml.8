Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD9FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C031320801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aHHSCwP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgEKKcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:32:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50553 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728209AbgEKKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:32:12 -0400
X-UUID: 389c227b3a9f479087f09aec2c7d96d3-20200511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1U5wzqzVt4EBKPbHjQ+DbeiJr8CenT4487+ft0swDlU=;
        b=aHHSCwP9dy84me30HL8Zv6SGfja9eynXrd9Jq2DJNdg10H8M3BSIRCteS8YlBc5LS0cxRNkF6BpnuPXQVOKH+DNM+j2rTRqTas8M30euWkvA2cuHF0rP41pFn1oNjMQsd2+q3y4rro0DNnxtFFWQinyJplhkUrc6EsA2nL6yqAY=;
X-UUID: 389c227b3a9f479087f09aec2c7d96d3-20200511
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 424622642; Mon, 11 May 2020 18:32:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 May 2020 18:32:04 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 May 2020 18:32:04 +0800
Message-ID: <1589193126.2930.2.camel@mtksdccf07>
Subject: Re: [PATCH v2 0/3] kasan: memorize and print call_rcu stack
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
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 11 May 2020 18:32:06 +0800
In-Reply-To: <CACT4Y+aC4i8cAVFu2-s82RczWCjYMpPVJLwS0OBLELR9qF8SYg@mail.gmail.com>
References: <20200511022359.15063-1-walter-zh.wu@mediatek.com>
         <CACT4Y+aC4i8cAVFu2-s82RczWCjYMpPVJLwS0OBLELR9qF8SYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTExIGF0IDEyOjAxICswMjAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGth
c2FuLWRldiB3cm90ZToNCj4gT24gTW9uLCBNYXkgMTEsIDIwMjAgYXQgNDoyNCBBTSBXYWx0ZXIg
V3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRj
aHNldCBpbXByb3ZlcyBLQVNBTiByZXBvcnRzIGJ5IG1ha2luZyB0aGVtIHRvIGhhdmUNCj4gPiBj
YWxsX3JjdSgpIGNhbGwgc3RhY2sgaW5mb3JtYXRpb24uIEl0IGlzIHVzZWZ1bCBmb3IgcHJvZ3Jh
bW1lcnMNCj4gPiB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtZnJlZSBtZW1vcnkg
aXNzdWUuDQo+IA0KPiBIaSBXYWx0ZXIsDQo+IA0KPiBJIGFtIGxvb2tpbmcgYXQgdGhpcyBub3cu
DQo+IA0KPiBJJ3ZlIHVwbG9hZCB0aGUgY2hhbmdlIHRvIGdlcnJpdCBbMV0NCj4gaHR0cHM6Ly9s
aW51eC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9jL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXgvKy8yNDU4DQo+IA0KPiBJIGFtIG5vdCBjYXBhYmxlIGVub3VnaCB0byBtZWFuaW5nZnVs
bHkgcmV2aWV3IHN1Y2ggY2hhbmdlcyBpbiB0aGlzIGZvcm1hdC4uLg0KPiANCj4gWzFdIGh0dHBz
Oi8vbGludXguZ29vZ2xlc291cmNlLmNvbS9Eb2N1bWVudGF0aW9uDQo+IA0KDQpIaSBEbWl0cnks
DQoNCkkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZCB5b3VyIG1lYW5pbmcsIG91ciBwYXRjaHNldCdz
IGZvcm1hdCBoYXMNCnByb2JsZW0/IG9yPw0KDQoNCj4gDQo+ID4gVGhlIEtBU0FOIHJlcG9ydCB3
YXMgYXMgZm9sbG93cyhjbGVhbmVkIHVwIHNsaWdodGx5KToNCj4gPg0KPiA+IEJVRzogS0FTQU46
IHVzZS1hZnRlci1mcmVlIGluIGthc2FuX3JjdV9yZWNsYWltKzB4NTgvMHg2MA0KPiA+DQo+ID4g
RnJlZWQgYnkgdGFzayAwOg0KPiA+ICBzYXZlX3N0YWNrKzB4MjQvMHg1MA0KPiA+ICBfX2thc2Fu
X3NsYWJfZnJlZSsweDExMC8weDE3OA0KPiA+ICBrYXNhbl9zbGFiX2ZyZWUrMHgxMC8weDE4DQo+
ID4gIGtmcmVlKzB4OTgvMHgyNzANCj4gPiAga2FzYW5fcmN1X3JlY2xhaW0rMHgxYy8weDYwDQo+
ID4gIHJjdV9jb3JlKzB4OGI0LzB4MTBmOA0KPiA+ICByY3VfY29yZV9zaSsweGMvMHgxOA0KPiA+
ICBlZmlfaGVhZGVyX2VuZCsweDIzOC8weGE2Yw0KPiA+DQo+ID4gRmlyc3QgY2FsbF9yY3UoKSBj
YWxsIHN0YWNrOg0KPiA+ICBzYXZlX3N0YWNrKzB4MjQvMHg1MA0KPiA+ICBrYXNhbl9yZWNvcmRf
Y2FsbHJjdSsweGM4LzB4ZDgNCj4gPiAgY2FsbF9yY3UrMHgxOTAvMHg1ODANCj4gPiAga2FzYW5f
cmN1X3VhZisweDFkOC8weDI3OA0KPiA+DQo+ID4gTGFzdCBjYWxsX3JjdSgpIGNhbGwgc3RhY2s6
DQo+ID4gKHN0YWNrIGlzIG5vdCBhdmFpbGFibGUpDQo+ID4NCj4gPiBHZW5lcmljIEtBU0FOIHdp
bGwgcmVjb3JkIGZpcnN0IGFuZCBsYXN0IGNhbGxfcmN1KCkgY2FsbCBzdGFjaw0KPiA+IGFuZCBw
cmludCB0d28gY2FsbF9yY3UoKSBjYWxsIHN0YWNrIGluIEtBU0FOIHJlcG9ydC4NCj4gPg0KPiA+
IFRoaXMgZmVhdHVyZSBkb2Vzbid0IGluY3JlYXNlIHRoZSBjb3N0IG9mIG1lbW9yeSBjb25zdW1w
dGlvbi4gSXQgaXMNCj4gPiBvbmx5IHN1aXRhYmxlIGZvciBnZW5lcmljIEtBU0FOLg0KPiA+DQo+
ID4gWzFdaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xOTg0MzcN
Cj4gPiBbMl1odHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2ZvcnVtLyMhc2VhcmNoaW4va2FzYW4t
ZGV2L2JldHRlciQyMHN0YWNrJDIwdHJhY2VzJDIwZm9yJDIwcmN1JTdDc29ydDpkYXRlL2thc2Fu
LWRldi9LUXNqVF84OGhERS83ck5VWnByUkJnQUoNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjI6
DQo+ID4gLSByZW1vdmUgbmV3IGNvbmZpZyBvcHRpb24sIGRlZmF1bHQgZW5hYmxlIGl0IGluIGdl
bmVyaWMgS0FTQU4NCj4gPiAtIHRlc3QgdGhpcyBmZWF0dXJlIGluIFNMQUIvU0xVQiwgaXQgaXMg
cGFzcy4NCj4gPiAtIG1vZGlmeSBtYWNybyB0byBiZSBtb3JlIGNsZWFybHkNCj4gPiAtIG1vZGlm
eSBkb2N1bWVudGF0aW9uDQo+ID4NCj4gPiBXYWx0ZXIgV3UgKDMpOg0KPiA+IHJjdS9rYXNhbjog
cmVjb3JkIGFuZCBwcmludCBjYWxsX3JjdSgpIGNhbGwgc3RhY2sNCj4gPiBrYXNhbjogcmVjb3Jk
IGFuZCBwcmludCB0aGUgZnJlZSB0cmFjaw0KPiA+IGthc2FuOiB1cGRhdGUgZG9jdW1lbnRhdGlv
biBmb3IgZ2VuZXJpYyBrYXNhbg0KPiA+DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2Fz
YW4ucnN0IHwgIDYgKysrKysrDQo+ID4gaW5jbHVkZS9saW51eC9rYXNhbi5oICAgICAgICAgICAg
IHwgIDIgKysNCj4gPiBrZXJuZWwvcmN1L3RyZWUuYyAgICAgICAgICAgICAgICAgfCAgNCArKysr
DQo+ID4gbGliL0tjb25maWcua2FzYW4gICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gPiBtbS9r
YXNhbi9jb21tb24uYyAgICAgICAgICAgICAgICAgfCAyNiArKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+IG1tL2thc2FuL2dlbmVyaWMuYyAgICAgICAgICAgICAgICB8IDUwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gbW0va2FzYW4v
a2FzYW4uaCAgICAgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiBtbS9rYXNhbi9yZXBvcnQuYyAgICAgICAgICAgICAgICAgfCA0NyArKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IG1tL2thc2FuL3RhZ3MuYyAgICAg
ICAgICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiA5IGZpbGVzIGNoYW5nZWQsIDE0OSBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IC0tDQo+ID4gWW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBh
cmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3VwcyAia2FzYW4tZGV2IiBncm91cC4NCj4g
PiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWls
cyBmcm9tIGl0LCBzZW5kIGFuIGVtYWlsIHRvIGthc2FuLWRldit1bnN1YnNjcmliZUBnb29nbGVn
cm91cHMuY29tLg0KPiA+IFRvIHZpZXcgdGhpcyBkaXNjdXNzaW9uIG9uIHRoZSB3ZWIgdmlzaXQg
aHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lkL2thc2FuLWRldi8yMDIwMDUxMTAyMjM1
OS4xNTA2My0xLXdhbHRlci16aC53dSU0MG1lZGlhdGVrLmNvbS4NCj4gDQoNCg==

