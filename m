Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A6E20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BOIL1Rth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHMMtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:49:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45107 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726658AbgHMMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:49:04 -0400
X-UUID: f4c7400723df461b99ba43db2a1c039f-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aaE6HcSMNBLCW8HhXQtINfxBXNzqkMSqUtGQrGAVPSM=;
        b=BOIL1Rthkq9dh/cIjPy+2394BryYEPZfVPl/p+WsDexLcm3qgQzNuBPsL0vAbg37mWo9/dLo2BbPnRGsW8DFgSdQLfM7yeckhVTy/TqVPueTsFo02M+ubzkfdnErZR0RGBMNia4m2X8yPfKS1hN2oImOc4oPWc9W6sKsqNaEzNA=;
X-UUID: f4c7400723df461b99ba43db2a1c039f-20200813
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 388844126; Thu, 13 Aug 2020 20:48:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 20:48:55 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 20:48:57 +0800
Message-ID: <1597322937.9999.42.camel@mtksdccf07>
Subject: Re: [PATCH 1/5] timer: kasan: record and print timer stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 13 Aug 2020 20:48:57 +0800
In-Reply-To: <87d03ulqbp.fsf@nanos.tec.linutronix.de>
References: <20200810072313.529-1-walter-zh.wu@mediatek.com>
         <87d03ulqbp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQpQbGVhc2UgaWdub3JlIG15IHByZXZpb3VzIG1haWwuIFRoYW5rcy4NCg0K
DQpPbiBUaHUsIDIwMjAtMDgtMTMgYXQgMTM6NDggKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90
ZToNCj4gV2FsdGVyLA0KPiANCj4gV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29t
PiB3cml0ZXM6DQo+ID4gVGhpcyBwYXRjaCByZWNvcmRzIHRoZSBsYXN0IHR3byB0aW1lciBxdWV1
ZWluZyBzdGFja3MgYW5kIHByaW50cw0KPiANCj4gIlRoaXMgcGF0Y2giIGlzIHVzZWxlc3MgaW5m
b3JtYXRpb24gYXMgd2UgYWxyZWFkeSBrbm93IGZyb20gdGhlIHN1YmplY3QNCj4gbGluZSB0aGF0
IHRoaXMgaXMgYSBwYXRjaC4NCj4gDQo+IGdpdCBncmVwICdUaGlzIHBhdGNoJyBEb2N1bWVudGF0
aW9uL3Byb2Nlc3MvDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uDQoNCj4gPiB1
cCB0byAyIHRpbWVyIHN0YWNrcyBpbiBLQVNBTiByZXBvcnQuIEl0IGlzIHVzZWZ1bCBmb3IgcHJv
Z3JhbW1lcnMNCj4gPiB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtZnJlZSBtZW1v
cnkgdGltZXIgaXNzdWVzLg0KPiA+DQo+ID4gV2hlbiB0aW1lcl9zZXR1cCgpIG9yIHRpbWVyX3Nl
dHVwX29uX3N0YWNrKCkgaXMgY2FsbGVkLCB0aGVuIGl0DQo+ID4gcHJlcGFyZXMgdG8gdXNlIHRo
aXMgdGltZXIgYW5kIHNldHMgdGltZXIgY2FsbGJhY2ssIHdlIHN0b3JlDQo+ID4gdGhpcyBjYWxs
IHN0YWNrIGluIG9yZGVyIHRvIHByaW50IGl0IGluIEtBU0FOIHJlcG9ydC4NCj4gDQo+IHdlIHN0
b3JlIG5vdGhpbmcuIERvbid0IGltcGVyc29uYXRlIGNvZGUgcGxlYXNlLg0KPiANCj4gQWxzbyBw
bGVhc2Ugc3RydWN0dXJlIHRoZSBjaGFuZ2Vsb2cgaW4gYSB3YXkgdGhhdCBpdCdzIGVhc3kgdG8N
Cj4gdW5kZXJzdGFuZCB3aGF0IHRoaXMgaXMgYWJvdXQgaW5zdGVhZCBvZiB0ZWxsaW5nIGZpcnN0
IHdoYXQgdGhlIHBhdGNoDQo+IGRvZXMgYW5kIHRoZW4gc29tZSBoYWxmIGJha2VuIGluZm9ybWF0
aW9uIHdoeSB0aGlzIGlzIHVzZWZ1bCBmb2xsb3dlZCBieQ0KPiBtb3JlIGluZm9ybWF0aW9uIGFi
b3V0IHdoYXQgaXQgZG9lcy4NCj4gDQo+IFNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiAgIEZv
ciBhbmFseXNpbmcgdXNlIGFmdGVyIGZyZWUgb3IgZG91YmxlIGZyZWUgb2Ygb2JqZWN0cyBpdCBp
cyBoZWxwZnVsDQo+ICAgdG8gcHJlc2VydmUgdXNhZ2UgaGlzdG9yeSB3aGljaCBwb3RlbnRpYWxs
eSBnaXZlcyBhIGhpbnQgYWJvdXQgdGhlDQo+ICAgYWZmZWN0ZWQgY29kZS4NCj4gDQo+ICAgRm9y
IHRpbWVycyBpdCBoYXMgdHVybmVkIG91dCB0byBiZSB1c2VmdWwgdG8gcmVjb3JkIHRoZSBzdGFj
ayB0cmFjZQ0KPiAgIG9mIHRoZSB0aW1lciBpbml0IGNhbGwuIDxBREQgdGVjaG5pY2FsIGV4cGxh
bmF0aW9uIHdoeSB0aGlzIGlzIHVzZWZ1bD4NCj4gIA0KPiAgIFJlY29yZCB0aGUgbW9zdCByZWNl
bnQgdHdvIHRpbWVyIGluaXQgY2FsbHMgaW4gS0FTQU4gd2hpY2ggYXJlIHByaW50ZWQNCj4gICBv
biBmYWlsdXJlIGluIHRoZSBLQVNBTiByZXBvcnQuDQo+IA0KPiBTZWUsIHRoaXMgZ2l2ZXMgYSBj
bGVhciBjb250ZXh0LCBhbiBleHBsYW5hdGlvbiB3aHkgaXQgaXMgdXNlZnVsIGFuZCBhDQo+IGhp
Z2ggbGV2ZWwgZGVzY3JpcHRpb24gb2Ygd2hhdCBpdCBkb2VzLiBUaGUgZGV0YWlscyBhcmUgaW4g
dGhlIHBhdGNoDQo+IGlmc2VsZiBhbmQgZG8gbm90IGhhdmUgdG8gYmUgZXB4bGFpbmVkIGluIHRo
ZSBjaGFuZ2Vsb2cuDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24sIE91ciBwYXRj
aCB3aWxsIHVzZSB0aGlzIGFzIGEgdGVtcGxhdGUgZnJvbQ0Kbm93IG9uLg0KDQo+IEZvciB0aGUg
dGVjaG5pY2FsIGV4cGxhbmF0aW9uIHdoaWNoIHlvdSBuZWVkIHRvIGFkZCwgeW91IHJlYWxseSBu
ZWVkIHRvDQo+IHRlbGwgd2hhdCdzIHRoZSBhZHZhbnRhZ2Ugb3IgYWRkaXRpb25hbCBjb3ZlcmFn
ZSB2cy4gZXhpc3RpbmcgZGVidWcNCj4gZmFjaWxpdGllcyBsaWtlIGRlYnVnb2JqZWN0cy4gSnVz
dCBjbGFpbWluZyB0aGF0IGl0J3MgdXNlZnVsIGRvZXMgbm90DQo+IG1ha2UgYW4gYXJndW1lbnQu
DQo+IA0KDQpXZSBvcmlnaW5hbGx5IHdhbnRlZCBoaW0gdG8gaGF2ZSBzaW1pbGFyIGZ1bmN0aW9u
cy4gTWF5YmUgaGUgY2FuJ3QNCmNvbXBsZXRlbHkgcmVwbGFjZSwgYnV0IEtBU0FOIGNhbiBhdmUg
dGhpcyBhYmlsaXR5Lg0KDQo+IFRoZSBVQUYgcHJvYmxlbSB3aXRoIHRpbWVycyBpcyBuYXN0eSBi
ZWNhdXNlIGlmIHlvdSBmcmVlIGFuIGFjdGl2ZSB0aW1lcg0KPiB0aGVuIGVpdGhlciB0aGUgc29m
dGlycSB3aGljaCBleHBpcmVzIHRoZSB0aW1lciB3aWxsIGNvcnJ1cHQgcG90ZW50aWFsbHkNCj4g
cmV1c2VkIG1lbW9yeSBvciB0aGUgcmV1c2Ugd2lsbCBjb3JydXB0IHRoZSBsaW5rZWQgbGlzdCB3
aGljaCBtYWtlcyB0aGUNCj4gc29mdGlycSBvciBzb21lIHVucmVsYXRlZCBjb2RlIHdoaWNoIGFk
ZHMvcmVtb3ZlcyBhIGRpZmZlcmVudCB0aW1lcg0KPiBleHBsb2RlIGluIHVuZGVidWdnYWJsZSB3
YXlzLiBkZWJ1Z29iamVjdCBwcmV2ZW50cyB0aGF0IGJlY2F1c2UgaXQNCj4gdHJhY2tzIHBlciB0
aW1lciBzdGF0ZSBhbmQgaW52b2tlcyB0aGUgZml4dXAgZnVuY3Rpb24gd2hpY2gga2VlcHMgdGhl
DQo+IHN5c3RlbSBhbGl2ZSBhbmQgYWxzbyB0ZWxscyB5b3UgZXhhY3RseSB3aGVyZSB0aGUgZnJl
ZSBvZiB0aGUgYWN0aXZlDQo+IG9iamVjdCBoYXBwZW5zIHdoaWNoIGlzIHRoZSByZWFsbHkgaW50
ZXJlc3RpbmcgcGxhY2UgdG8gbG9vayBhdC4gVGhlDQo+IGluaXQgZnVuY3Rpb24gaXMgcHJldHR5
IHVuaW50ZXJlc3RpbmcgaW4gdGhhdCBjYXNlIGJlY2F1c2UgeW91IHJlYWxseQ0KPiB3YW50IHRv
IGtub3cgd2hlcmUgdGhlIGZyZWVpbmcgb2YgdGhlIGFjdGl2ZSBvYmplY3QgaGFwcGVucy4NCj4g
DQo+IFNvIGlmIEtBU0FOIGRldGVjdHMgVUFGIGluIHRoZSB0aW1lciBzb2Z0aXJxIHRoZW4gdGhl
IGluaXQgdHJhY2UgaXMgbm90DQo+IGdpdmluZyBhbnkgaW5mb3JtYXRpb24gZXNwZWNpYWxseSBu
b3QgaW4gY2FzZXMgd2hlcmUgdGhlIHRpbWVyIGlzIHBhcnQNCj4gb2YgYSBjb21tb24gYW5kIGZy
ZXF1ZW50bHkgYWxsb2NhdGVkL2ZyZWVkIG90aGVyIGRhdGEgc3RydWN0dXJlLg0KPiANCg0KSSBk
b24ndCBoYXZlIGV4cGVyaWVuY2UgdXNpbmcgdGhpcyB0b29sLCBidXQgSSB3aWxsIHN1cnZleSBp
dC4NCg0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQga2FzYW5fY2FjaGVfc2hyaW5rKHN0cnVjdCBr
bWVtX2NhY2hlICpjYWNoZSkge30NCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIGthc2FuX2NhY2hl
X3NodXRkb3duKHN0cnVjdCBrbWVtX2NhY2hlICpjYWNoZSkge30NCj4gPiAgc3RhdGljIGlubGlu
ZSB2b2lkIGthc2FuX3JlY29yZF9hdXhfc3RhY2sodm9pZCAqcHRyKSB7fQ0KPiA+ICtzdGF0aWMg
aW5saW5lIHZvaWQga2FzYW5fcmVjb3JkX3Rtcl9zdGFjayh2b2lkICpwdHIpIHt9DQo+IA0KPiBE
dWgsIHNvIHlvdSBhcmUgYWRkaW5nIHBlciBvYmplY3QgdHlwZSBmdW5jdGlvbnMgYW5kIHN0b3Jh
Z2U/IFRoYXQncw0KPiBnb2luZyB0byBiZSBhIGh1Z2UgY29weSBhbmQgcGFzdGEgb3JneSBhcyBl
dmVyeSBvYmplY3QgcmVxdWlyZXMgdGhlIHNhbWUNCj4gY29kZSBhbmQgZXh0cmEgc3RvcmFnZSBz
cGFjZS4NCj4gDQo+IFdoeSBub3QganVzdCB1c2luZyBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrKCkg
Zm9yIGFsbCBvZiB0aGlzPw0KPiANCj4gVGhlICdjYWxsX3JjdScgJ3RpbWVyJyAnd2hhdGV2ZXIg
bmV4dCcgcHJpbnRvdXQgaXMgbm90IHJlYWxseSByZXF1aXJlZA0KPiBiZWNhdXNlIHRoZSBzdGFj
ayB0cmFjZSBhbHJlYWR5IHRlbGxzIHlvdSB0aGUgZnVuY3Rpb24gd2hpY2ggd2FzDQo+IGludm9r
ZWQuIElmIFRPUyBpcyBjYWxsX3JjdSgpIG9yIGRvX3RpbWVyX2luaXQoKSB0aGVuIGl0J3MgZW50
aXJlbHkNCj4gY2xlYXIgd2hpY2ggb2JqZWN0IGlzIGFmZmVjdGVkLiBJZiB0aGUgdHdvIGF1eCBy
ZWNvcmRzIGFyZSBub3QgZW5vdWdoDQo+IHRoZW4gbWFraW5nIHRoZSBhcnJheSBsYXJnZXIgaXMg
bm90IHRoZSBlbmQgb2YgdGhlIHdvcmxkLg0KPiANCg0KTXkgcHJldmlvdXMgbWFpbCBzYXkgdGhh
dCB3ZSB3aWxsIHJlLXVzZSBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrKCkgYW5kDQpvbmx5IGhhdmUg
YXV4X3N0YWNrLg0KDQo+ID4gICNlbmRpZiAvKiBDT05GSUdfS0FTQU5fR0VORVJJQyAqLw0KPiA+
ICANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUvdGltZXIuYyBiL2tlcm5lbC90aW1lL3Rp
bWVyLmMNCj4gPiBpbmRleCBhNTIyMWFiYjQ1OTQuLmVmMmRhOWRkZmFjNyAxMDA2NDQNCj4gPiAt
LS0gYS9rZXJuZWwvdGltZS90aW1lci5jDQo+ID4gKysrIGIva2VybmVsL3RpbWUvdGltZXIuYw0K
PiA+IEBAIC03ODMsNiArNzgzLDggQEAgc3RhdGljIHZvaWQgZG9faW5pdF90aW1lcihzdHJ1Y3Qg
dGltZXJfbGlzdCAqdGltZXIsDQo+ID4gIAl0aW1lci0+ZnVuY3Rpb24gPSBmdW5jOw0KPiA+ICAJ
dGltZXItPmZsYWdzID0gZmxhZ3MgfCByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPiA+ICAJbG9j
a2RlcF9pbml0X21hcCgmdGltZXItPmxvY2tkZXBfbWFwLCBuYW1lLCBrZXksIDApOw0KPiA+ICsN
Cj4gPiArCWthc2FuX3JlY29yZF90bXJfc3RhY2sodGltZXIpOw0KPiA+ICB9DQo+IA0KPiBBcmUg
eW91IHN1cmUgdGhpcyBpcyBjb3JyZWN0IGZvciBhbGwgdGltZXJzPw0KPiANCj4gVGhpcyBpcyBh
bHNvIGNhbGxlZCBmb3IgdGltZXJzIHdoaWNoIGFyZSB0ZW1wb3JhcmlseSBhbGxvY2F0ZWQgb24g
c3RhY2sNCj4gYW5kIGZvciB0aW1lcnMgd2hpY2ggYXJlIHN0YXRpY2FsbHkgYWxsb2NhdGVkIGF0
IGNvbXBpbGUgdGltZS4gSG93IGlzDQo+IHRoYXQgc3VwcG9zZWQgdG8gd29yaz8NCj4gDQoNCklm
IEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIEtBU0FOIHJlcG9ydCBoYXZlIHRoaXMgcmVjb3JkIG9u
bHkgZm9yIHNsdWINCnZhcmlhYmxlLiBTbyB3aGF0IHlvdSBzYWlkIHNob3VsZG4ndCBiZSBhIHBy
b2JsZW0uDQoNCj4gVGhlc2Uga2luZCBvZiB0aGluZ3Mgd2FudCB0byBiZSBleHBsYWluZWQgdXBm
cm9udCBhbiBub3QgbGVmdCB0byB0aGUNCj4gcmV2aWV3ZXIgYXMgYW4gZXhlcmNpc2UuDQo+IA0K
DQpTb3JyeSwgTXkgZmF1bHQuIExhdGVyIHdlIHdpbGwgYmUgbW9yZSBjYXV0aW91cyB0byBzZW5k
IHBhdGNoLg0KDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0KDQo=

