Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF5EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8A520659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YdPweka6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgEFGXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:23:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26639 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728000AbgEFGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:23:50 -0400
X-UUID: f60d58e8e7534651a6dc3844e569535c-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EMtEpkXEvK9nfHRYvG1dhOQ8iE+qMOZdMvGDu7QjaPw=;
        b=YdPweka6yiq9Z0oJweGz75TbXzTe35IsBUdRqukYNHsv0yxMFvv1Opj+CQOXnmyPhPGuDzKMdTHfNsr1zNEPlkwOQ7yG896y0YNldjPLZOKsPLWN4J/UuzpClBN5+X3oCsZ60TAyjxQ08WumGZd68we4aev2p+X94HkCN4+gDKo=;
X-UUID: f60d58e8e7534651a6dc3844e569535c-20200506
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 460470072; Wed, 06 May 2020 14:23:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 14:23:38 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 14:23:34 +0800
Message-ID: <1588746219.16219.10.camel@mtksdccf07>
Subject: Re: [PATCH 0/3] kasan: memorize and print call_rcu stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 6 May 2020 14:23:39 +0800
In-Reply-To: <2BF68E83-4611-48B2-A57F-196236399219@lca.pw>
References: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
         <2BF68E83-4611-48B2-A57F-196236399219@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 42DEFC715D66F1062290FF153DFF6751FECE0CF316B54F13B8825BE6B87E4B562000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTA2IGF0IDAxOjUzIC0wNDAwLCBRaWFuIENhaSB3cm90ZToNCj4gDQo+
ID4gT24gTWF5IDYsIDIwMjAsIGF0IDE6MTkgQU0sIFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBpbXByb3ZlcyBLQVNB
TiByZXBvcnRzIGJ5IG1ha2luZyB0aGVtIHRvIGhhdmUNCj4gPiBjYWxsX3JjdSgpIGNhbGwgc3Rh
Y2sgaW5mb3JtYXRpb24uIEl0IGlzIGhlbHBmdWwgZm9yIHByb2dyYW1tZXJzDQo+ID4gdG8gc29s
dmUgdXNlLWFmdGVyLWZyZWUgb3IgZG91YmxlLWZyZWUgbWVtb3J5IGlzc3VlLg0KPiA+IA0KPiA+
IFRoZSBLQVNBTiByZXBvcnQgd2FzIGFzIGZvbGxvd3MoY2xlYW5lZCB1cCBzbGlnaHRseSk6DQo+
ID4gDQo+ID4gQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4ga2FzYW5fcmN1X3JlY2xhaW0r
MHg1OC8weDYwDQo+ID4gDQo+ID4gRnJlZWQgYnkgdGFzayAwOg0KPiA+IHNhdmVfc3RhY2srMHgy
NC8weDUwDQo+ID4gX19rYXNhbl9zbGFiX2ZyZWUrMHgxMTAvMHgxNzgNCj4gPiBrYXNhbl9zbGFi
X2ZyZWUrMHgxMC8weDE4DQo+ID4ga2ZyZWUrMHg5OC8weDI3MA0KPiA+IGthc2FuX3JjdV9yZWNs
YWltKzB4MWMvMHg2MA0KPiA+IHJjdV9jb3JlKzB4OGI0LzB4MTBmOA0KPiA+IHJjdV9jb3JlX3Np
KzB4Yy8weDE4DQo+ID4gZWZpX2hlYWRlcl9lbmQrMHgyMzgvMHhhNmMNCj4gPiANCj4gPiBGaXJz
dCBjYWxsX3JjdSgpIGNhbGwgc3RhY2s6DQo+ID4gc2F2ZV9zdGFjaysweDI0LzB4NTANCj4gPiBr
YXNhbl9yZWNvcmRfY2FsbHJjdSsweGM4LzB4ZDgNCj4gPiBjYWxsX3JjdSsweDE5MC8weDU4MA0K
PiA+IGthc2FuX3JjdV91YWYrMHgxZDgvMHgyNzgNCj4gPiANCj4gPiBMYXN0IGNhbGxfcmN1KCkg
Y2FsbCBzdGFjazoNCj4gPiAoc3RhY2sgaXMgbm90IGF2YWlsYWJsZSkNCj4gPiANCj4gPiANCj4g
PiBBZGQgbmV3IENPTkZJRyBvcHRpb24gdG8gcmVjb3JkIGZpcnN0IGFuZCBsYXN0IGNhbGxfcmN1
KCkgY2FsbCBzdGFjaw0KPiA+IGFuZCBLQVNBTiByZXBvcnQgcHJpbnRzIHR3byBjYWxsX3JjdSgp
IGNhbGwgc3RhY2suDQo+ID4gDQo+ID4gVGhpcyBvcHRpb24gZG9lc24ndCBpbmNyZWFzZSB0aGUg
Y29zdCBvZiBtZW1vcnkgY29uc3VtcHRpb24uIEl0IGlzDQo+ID4gb25seSBzdWl0YWJsZSBmb3Ig
Z2VuZXJpYyBLQVNBTi4NCj4gDQo+IEkgZG9u4oCZdCB1bmRlcnN0YW5kIHdoeSB0aGlzIG5lZWRz
IHRvIGJlIGEgS2NvbmZpZyBvcHRpb24gYXQgYWxsLiBJZiBjYWxsX3JjdSgpIHN0YWNrcyBhcmUg
dXNlZnVsIGluIGdlbmVyYWwsIHRoZW4ganVzdCBhbHdheXMgZ2F0aGVyIHRob3NlIGluZm9ybWF0
aW9uLiBIb3cgZG8gZGV2ZWxvcGVycyBqdWRnZSBpZiB0aGV5IG5lZWQgdG8gc2VsZWN0IHRoaXMg
b3B0aW9uIG9yIG5vdD8NCg0KQmVjYXVzZSB3ZSBkb24ndCB3YW50IHRvIGluY3JlYXNlIHNsdWIg
bWV0YS1kYXRhIHNpemUsIHNvIGVuYWJsaW5nIHRoaXMNCm9wdGlvbiBjYW4gcHJpbnQgY2FsbF9y
Y3UoKSBzdGFja3MsIGJ1dCB0aGUgaW4tdXNlIHNsdWIgb2JqZWN0IGRvZXNuJ3QNCnByaW50IGZy
ZWUgc3RhY2suIFNvIGlmIGhhdmUgb3V0LW9mLWJvdW5kIGlzc3VlLCB0aGVuIGl0IHdpbGwgbm90
IHByaW50DQpmcmVlIHN0YWNrLiBJdCBpcyBhIHRyYWRlLW9mZiwgc2VlIFsxXS4NCg0KWzFdIGh0
dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4NDM3DQoNClRoYW5r
cw0K

