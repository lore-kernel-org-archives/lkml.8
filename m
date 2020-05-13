Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9857EC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0E0206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DU2MZ9ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbgEMBr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 21:47:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21674 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728228AbgEMBr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 21:47:59 -0400
X-UUID: d39001488b2a45ac8a5bd4504e47d692-20200513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=o7JP9AdWJu6YlfE0C1p8Mhx9/TUpPDMGmCuMKKblwlg=;
        b=DU2MZ9wwW3qTu8oDQZT66TASPYtZnA3M+g0rBEm5DPeLR+nbeftLSdI9LC+6LJPtZL6OOWWhSi8IQgw552WtpJx3PgTiBrCVRe8EOlfj3oaM6IOtp+97/iDJBf+E4NSlbUptIaYs7rkz4ot4HJ1sV2Gc11KUXjr/BwQxYneb6bA=;
X-UUID: d39001488b2a45ac8a5bd4504e47d692-20200513
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2033237458; Wed, 13 May 2020 09:47:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 May 2020 09:47:52 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 May 2020 09:47:52 +0800
Message-ID: <1589334472.19238.44.camel@mtksdccf07>
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
Date:   Wed, 13 May 2020 09:47:52 +0800
In-Reply-To: <CACT4Y+aibZEBR-3bos3ox5Tuu48TnHC20mDDN0AkWeRUKrT0aw@mail.gmail.com>
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
         <CACT4Y+YWNwTSoheJhc3nMdQi9m719F3PzpGo3TfRY3zAg9EwuQ@mail.gmail.com>
         <CACT4Y+bO1Zg_jgFHbOWgp7fLAADOQ_-AZmjEHz0WG7=oyOt4Gg@mail.gmail.com>
         <1589203771.21284.22.camel@mtksdccf07>
         <CACT4Y+aOkuH6Dn+L+wv1qVOLgXyCY_Ck4hecAMw3DgyBgC9qHw@mail.gmail.com>
         <1589254720.19238.36.camel@mtksdccf07>
         <CACT4Y+aibZEBR-3bos3ox5Tuu48TnHC20mDDN0AkWeRUKrT0aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTEyIGF0IDE2OjAzICswMjAwLCBEbWl0cnkgVnl1a292IHdyb3RlOg0K
PiBPbiBUdWUsIE1heSAxMiwgMjAyMCBhdCA1OjM4IEFNIFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiBBcmUgeW91IHN1cmUgaXQgd2lsbCBpbmNyZWFz
ZSBvYmplY3Qgc2l6ZT8NCj4gPiA+IEkgdGhpbmsgd2Ugb3ZlcmxhcCBrYXNhbl9mcmVlX21ldGEg
d2l0aCB0aGUgb2JqZWN0IGFzIHdlbGwuIFRoZSBvbmx5DQo+ID4gPiBjYXNlIHdlIGRvbid0IG92
ZXJsYXAga2FzYW5fZnJlZV9tZXRhIHdpdGggdGhlIG9iamVjdCBhcmUNCj4gPiA+IFNMQUJfVFlQ
RVNBRkVfQllfUkNVIHx8IGNhY2hlLT5jdG9yLiBCdXQgdGhlc2UgYXJlIHJhcmUgYW5kIGl0IHNo
b3VsZA0KPiA+ID4gb25seSBhZmZlY3Qgc21hbGwgb2JqZWN0cyB3aXRoIHNtYWxsIHJlZHpvbmVz
Lg0KPiA+ID4gQW5kIEkgdGhpbmsgbm93IHdlIHNpbXBseSBoYXZlIGEgYnVnIGZvciB0aGVzZSBv
YmplY3RzLCB3ZSBjaGVjaw0KPiA+ID4gS0FTQU5fS01BTExPQ19GUkVFIGFuZCB0aGVuIGFzc3Vt
ZSBvYmplY3QgY29udGFpbnMgZnJlZSBzdGFjaywgYnV0IGZvcg0KPiA+ID4gb2JqZWN0cyB3aXRo
IGN0b3IsIHRoZXkgc3RpbGwgY29udGFpbiBsaXZlIG9iamVjdCBkYXRhLCB3ZSBkb24ndCBzdG9y
ZQ0KPiA+ID4gZnJlZSBzdGFjayBpbiB0aGVtLg0KPiA+ID4gU3VjaCBvYmplY3RzIGNhbiBiZSBi
b3RoIGZyZWUgYW5kIHN0aWxsIGNvbnRhaW4gdXNlciBkYXRhLg0KPiA+ID4NCj4gPg0KPiA+IE92
ZXJsYXkga2FzYW5fZnJlZV9tZXRhLiBJIHNlZS4gYnV0IG92ZXJsYXkgaXQgb25seSB3aGVuIHRo
ZSBvYmplY3Qgd2FzDQo+ID4gZnJlZWQuIGthc2FuX2ZyZWVfbWV0YSB3aWxsIGJlIHVzZWQgdW50
aWwgZnJlZSBvYmplY3QuDQo+ID4gMSkuIFdoZW4gcHV0IG9iamVjdCBpbnRvIHF1YXJhbnRpbmUs
IGl0IG5lZWQga2FzYW5fZnJlZV9tZXRhLg0KPiA+IDIpLiBXaGVuIHRoZSBvYmplY3QgZXhpdCBm
cm9tIHF1YXJhbnRpbmUsIGl0IG5lZWQga2FzYW5fZnJlZV9tZXRhDQo+ID4NCj4gPiBJZiB3ZSBj
aG9vc2UgdG8gb3ZlcmxheSBrYXNhbl9mcmVlX21ldGEsIHRoZW4gdGhlIGZyZWUgc3RhY2sgd2ls
bCBiZQ0KPiA+IHN0b3JlZCB2ZXJ5IGxhdGUuIEl0IG1heSBoYXMgbm8gZnJlZSBzdGFjayBpbiBy
ZXBvcnQuDQo+IA0KPiBTb3JyeSwgSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uDQo+
IA0KPiBXaHkgd2lsbCBpdCBiZSBzdG9yZWQgdG9vIGxhdGU/DQo+IEluIF9fa2FzYW5fc2xhYl9m
cmVlKCkgcHV0dGluZyBpbnRvIHF1YXJhbnRpbmUgYW5kIHJlY29yZGluZyBmcmVlDQo+IHN0YWNr
IGFyZSBsaXRlcmFsbHkgYWRqYWNlbnQgbGluZXMgb2YgY29kZToNCj4gDQo+IHN0YXRpYyBib29s
IF9fa2FzYW5fc2xhYl9mcmVlKHN0cnVjdCBrbWVtX2NhY2hlICpjYWNoZSwgdm9pZCAqb2JqZWN0
LA0KPiAgICAgICB1bnNpZ25lZCBsb25nIGlwLCBib29sIHF1YXJhbnRpbmUpDQo+IHsNCj4gICAg
IC4uLg0KPiAgICAga2FzYW5fc2V0X2ZyZWVfaW5mbyhjYWNoZSwgb2JqZWN0LCB0YWcpOw0KPiAg
ICAgcXVhcmFudGluZV9wdXQoZ2V0X2ZyZWVfaW5mbyhjYWNoZSwgb2JqZWN0KSwgY2FjaGUpOw0K
PiANCj4gDQo+IEp1c3QgdG8gbWFrZSBzdXJlLCB3aGF0IEkgbWVhbnQgaXMgdGhhdCB3ZSBhZGQg
ZnJlZV90cmFjayB0byBrYXNhbl9mcmVlX21ldGE6DQo+IA0KPiBzdHJ1Y3Qga2FzYW5fZnJlZV9t
ZXRhIHsNCj4gICAgIHN0cnVjdCBxbGlzdF9ub2RlIHF1YXJhbnRpbmVfbGluazsNCj4gKyAgc3Ry
dWN0IGthc2FuX3RyYWNrIGZyZWVfdHJhY2s7DQo+IH07DQo+IA0KDQpXaGVuIEkgc2VlIGFib3Zl
IHN0cnVjdCBrYXNhbl9mcmVlX21ldGEsIEkga25vdyB3aHkgeW91IGRvbid0IHVuZGVyc3RhbmQN
Cm15IG1lYW5pbmcsIGJlY2F1c2UgSSB0aG91Z2h0IHlvdSB3ZXJlIGdvaW5nIHRvIG92ZXJsYXkg
dGhlDQpxdWFyYW50aW5lX2xpbmsgYnkgZnJlZV90cmFjaywgYnV0IGl0IHNlZW1zIGxpa2UgdG8g
YWRkIGZyZWVfdHJhY2sgdG8NCmthc2FuX2ZyZWVfbWV0YS4gRG9lcyBpdCBlbmxhcmdlIG1ldGEt
ZGF0YSBzaXplPw0KDQo+IEFuZCBJIHRoaW5rIGl0cyBsaWZlLXRpbWUgYW5kIGV2ZXJ5dGhpbmcg
c2hvdWxkIGJlIGV4YWN0bHkgd2hhdCB3ZSBuZWVkLg0KPiANCj4gQWxzbyBpdCBzaG91bGQgaGVs
cCB0byBmaXggdGhlIHByb2JsZW0gd2l0aCBjdG9yczoga2FzYW5fZnJlZV9tZXRhIGlzDQo+IGFs
cmVhZHkgYWxsb2NhdGVkIG9uIHRoZSBzaWRlIGZvciBzdWNoIG9iamVjdHMsIGFuZCB0aGF0J3Mg
ZXhhY3RseQ0KPiB3aGF0IHdlIG5lZWQgZm9yIG9iamVjdHMgd2l0aCBjdG9yJ3MuDQoNCkkgc2Vl
Lg0KDQoNCg==

