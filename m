Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E106CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0F2206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="I9QQOotY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgHKAlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:41:47 -0400
Received: from mail4.tencent.com ([183.57.53.109]:44077 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgHKAlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:41:46 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail4.tencent.com (Postfix) with ESMTP id 9FEF6724FE;
        Tue, 11 Aug 2020 08:41:40 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597106500;
        bh=G4JnkUHTyj02K+7or1qaTwf+Cxp0ypLty1xtgGAZ1rg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=I9QQOotYbGr8iHUMO7ao8b39g9gwXz8ttMRyKwtEKRuX8QKzFws4ZZ25Y0e9EZr9D
         qEZi6AbCHmoe9RIsXV1K5+eAkrUrlRoXzv4dtWFPJV9gtYZA23CHWFM/16RmVj8chK
         zxhOErbfwXS9tswXBMvqqM7Xbgf9d6XgqOHVjmEs=
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 11 Aug
 2020 08:41:40 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ006.tencent.com
 (10.28.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 11 Aug
 2020 08:41:40 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Tue, 11 Aug 2020 08:41:40 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
Thread-Topic: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gA==
Date:   Tue, 11 Aug 2020 00:41:40 +0000
Message-ID: <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
 <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
 <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
In-Reply-To: <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.28]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4909AB641F541D4FBFE2511C2F9AE391@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gQXVnIDEwLCAyMDIwLCBhdCA5OjI0IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxk
aWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMDYvMDgvMjAyMCAxNzo1
MiwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwgDQo+PiANCj4+PiBPbiBBdWcgNiwg
MjAyMCwgYXQgOToyOSBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0u
Y29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAwMy8wOC8yMDIwIDEzOjI2LCBiZW5iamlhbmco6JKL
5b2qKSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gQXVnIDMsIDIwMjAsIGF0IDQ6MTYg
UE0sIERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6DQo+
Pj4+PiANCj4+Pj4+IE9uIDAxLzA4LzIwMjAgMDQ6MzIsIEppYW5nIEJpYW8gd3JvdGU6DQo+Pj4+
Pj4gRnJvbTogSmlhbmcgQmlhbyA8YmVuYmppYW5nQHRlbmNlbnQuY29tPg0KPiANCj4gWy4uLl0N
Cj4gDQo+Pj4gSG93IHdvdWxkIHlvdSBkZWFsIHdpdGggc2UncyByZXByZXNlbnRpbmcgdGFza2dy
b3VwcyB3aGljaCBjb250YWluDQo+Pj4gU0NIRURfSURMRSBhbmQgU0NIRURfTk9STUFMIHRhc2tz
IG9yIG90aGVyIHRhc2tncm91cHMgZG9pbmcgdGhhdD8NCj4+IEnigJltIG5vdCBzdXJlIEkgZ2V0
IHRoZSBwb2ludC4gOikgSG93IGFib3V0IHRoZSBmb2xsb3dpbmcgcGF0Y2gsDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4g
aW5kZXggMDRmYThkYmNmYTRkLi44NzE1ZjAzZWQ2ZDcgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwv
c2NoZWQvZmFpci5jDQo+PiArKysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+PiBAQCAtMjk5NCw2
ICsyOTk0LDkgQEAgYWNjb3VudF9lbnRpdHlfZW5xdWV1ZShzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEs
IHN0cnVjdCBzY2hlZF9lbnRpdHkgKnNlKQ0KPj4gICAgICAgICAgICAgICAgbGlzdF9hZGQoJnNl
LT5ncm91cF9ub2RlLCAmcnEtPmNmc190YXNrcyk7DQo+PiAgICAgICAgfQ0KPj4gI2VuZGlmDQo+
PiArICAgICAgIGlmICh0YXNrX2hhc19pZGxlX3BvbGljeSh0YXNrX29mKHNlKSkpDQo+PiArICAg
ICAgICAgICAgICAgY2ZzX3JxLT5pZGxlX25yX3J1bm5pbmcrKzsNCj4+ICsNCj4+ICAgICAgICBj
ZnNfcnEtPm5yX3J1bm5pbmcrKzsNCj4+IH0NCj4+IA0KPj4gQEAgLTMwMDcsNiArMzAxMCw5IEBA
IGFjY291bnRfZW50aXR5X2RlcXVldWUoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2No
ZWRfZW50aXR5ICpzZSkNCj4+ICAgICAgICAgICAgICAgIGxpc3RfZGVsX2luaXQoJnNlLT5ncm91
cF9ub2RlKTsNCj4+ICAgICAgICB9DQo+PiAjZW5kaWYNCj4+ICsgICAgICAgaWYgKHRhc2tfaGFz
X2lkbGVfcG9saWN5KHRhc2tfb2Yoc2UpKSkNCj4+ICsgICAgICAgICAgICAgICBjZnNfcnEtPmlk
bGVfbnJfcnVubmluZy0tOw0KPj4gKw0KPj4gICAgICAgIGNmc19ycS0+bnJfcnVubmluZy0tOw0K
Pj4gfQ0KPj4gDQo+PiBAQCAtNDUyNyw3ICs0NTMzLDcgQEAgZW50aXR5X3RpY2soc3RydWN0IGNm
c19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpjdXJyLCBpbnQgcXVldWVkKQ0KPj4g
ICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gI2VuZGlmDQo+PiANCj4+IC0gICAgICAgaWYgKGNm
c19ycS0+bnJfcnVubmluZyA+IDEpDQo+PiArICAgICAgIGlmIChjZnNfcnEtPm5yX3J1bm5pbmcg
PiBjZnNfcnEtPmlkbGVfbnJfcnVubmluZyArIDEgJiYNCj4+ICsgICAgICAgICAgIGNmc19ycS0+
aF9ucl9ydW5uaW5nIC0gY2ZzX3JxLT5pZGxlX2hfbnJfcnVubmluZyA+IGNmc19ycS0+aWRsZV9u
cl9ydW5uaW5nICsgMSkNCj4+ICAgICAgICAgICAgICAgIGNoZWNrX3ByZWVtcHRfdGljayhjZnNf
cnEsIGN1cnIpOw0KPj4gfQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3NjaGVk
LmggYi9rZXJuZWwvc2NoZWQvc2NoZWQuaA0KPj4gaW5kZXggODc3ZmIwOGViMWIwLi40MDEwOTAz
OTNlMDkgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvc2NoZWQvc2NoZWQuaA0KPj4gKysrIGIva2Vy
bmVsL3NjaGVkL3NjaGVkLmgNCj4+IEBAIC01MDAsNiArNTAwLDcgQEAgc3RydWN0IGNmc19iYW5k
d2lkdGggeyB9Ow0KPj4gc3RydWN0IGNmc19ycSB7DQo+PiAgICAgICAgc3RydWN0IGxvYWRfd2Vp
Z2h0ICAgICAgbG9hZDsNCj4+ICAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBucl9ydW5u
aW5nOw0KPj4gKyAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBpZGxlX25yX3J1bm5pbmc7
DQo+PiAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgaF9ucl9ydW5uaW5nOyAgICAgIC8q
IFNDSEVEX3tOT1JNQUwsQkFUQ0gsSURMRX0gKi8NCj4+ICAgICAgICB1bnNpZ25lZCBpbnQgICAg
ICAgICAgICBpZGxlX2hfbnJfcnVubmluZzsgLyogU0NIRURfSURMRSAqLw0KPiANCj4gICAgICAg
ICAvDQo+ICAgICAgIC8gfCAgXA0KPiAgICAgIEEgIG4wIGkwDQo+ICAgICAvIFwNCj4gICAgbjEg
aTENCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyB3aWxsIHdvcmsuIEUuZy4gdGhlIHBhdGNoIHdv
dWxkIHByZXZlbnQgdGljaw0KPiBwcmVlbXB0aW9uIGJldHdlZW4gJ0EnIGFuZCAnbjAnIG9uICcv
JyBhcyB3ZWxsDQo+IA0KPiAoMyA+IDEgKyAxKSAmJiAoNCAtIDIgPiAxICsgMSkNCj4gDQo+IFlv
dSBhbHNvIGhhdmUgdG8gbWFrZSBzdXJlIHRoYXQgYSBTQ0hFRF9JRExFIHRhc2sgY2FuIHRpY2sg
cHJlZW1wdA0KPiBhbm90aGVyIFNDSEVEX0lETEUgdGFzay4NCg0KVGhhdOKAmXMgcmlnaHQuIDop
DQoNCj4gDQo+Pj4+IEnigJltIG5vdCBzdXJlIGlmIGl04oCZcyBvayB0byBkbyB0aGF0LCBiZWNh
dXNlIHRoZSBJRExFIGNsYXNzIHNlZW1zIG5vdCB0byBiZSBzbw0KPj4+PiBwdXJlIHRoYXQgY291
bGQgdG9sZXJhdGUgc3RhcnZpbmcuDQo+Pj4gDQo+Pj4gTm90IHN1cmUgSSB1bmRlcnN0YW5kIGJ1
dCBpZGxlX3NjaGVkX2NsYXNzIGlzIG5vdCB0aGUgc2FtZSBhcyBTQ0hFRF9JRExFDQo+Pj4gKHBv
bGljeSk/DQo+PiBUaGUgY2FzZSBpcyB0aGF0IHdlIG5lZWQgdGFza3MobG93IHByaW9yaXR5LCBj
YWxsZWQgb2ZmbGluZSB0YXNrcykgdG8gdXRpbGl6ZSB0aGUNCj4+IHNwYXJlIGNwdSBsZWZ0IGJ5
IENGUyBTQ0hFRF9OT1JNQUwgdGFza3MoY2FsbGVkIG9ubGluZSB0YXNrcykgd2l0aG91dA0KPj4g
aW50ZXJmZXJpbmcgdGhlIG9ubGluZSB0YXNrcy4gDQo+PiBPZmZsaW5lIHRhc2tzIG9ubHkgcnVu
IHdoZW4gdGhlcmXigJlzIG5vIHJ1bm5hYmxlIG9ubGluZSB0YXNrcywgYW5kIG9mZmxpbmUgdGFz
a3MNCj4+IG5ldmVyIHByZWVtcHQgb25saW5lIHRhc2tzLg0KPj4gVGhlIFNDSEVEX0lETEUgcG9s
aWN5IHNlZW1zIG5vdCB0byBiZSBhYmxlZCB0byBiZSBxdWFsaWZpZWQgZm9yIHRoYXQgcmVxdWly
ZW1lbnQsDQo+PiBiZWNhdXNlIGl0IGhhcyBhIHdlaWdodCgzKSwgZXZlbiB0aG91Z2ggaXTigJlz
IHNtYWxsLCBidXQgaXQgY2FuIHN0aWxsIHByZWVtcHQgb25saW5lDQo+PiB0YXNrcyBjb25zaWRl
cmluZyB0aGUgZmFpcm5lc3MuIEluIHRoYXQgd2F5LCBvZmZsaW5lIHRhc2tzIG9mIFNDSEVEX0lE
TEUgcG9saWN5DQo+PiBjb3VsZCBpbnRlcmZlcmUgdGhlIG9ubGluZSB0YXNrcy4NCj4gDQo+IEJl
Y2F1c2Ugb2YgdGhpcyB2ZXJ5IHNtYWxsIHdlaWdodCAod2VpZ2h0PTMpLCBjb21wYXJlZCB0byBh
IFNDSEVEX05PUk1BTA0KPiBuaWNlIDAgdGFzayAod2VpZ2h0PTEwMjQpLCBhIFNDSEVEX0lETEUg
dGFzayBpcyBwZW5hbGl6ZWQgYnkgYSBodWdlDQo+IHNlLT52cnVudGltZSB2YWx1ZSAoMTAyNC8z
IGhpZ2hlciB0aGFuIGZvciBhIFNDSEVEX05PUk1BTCBuaWNlIDAgdGFzaykuDQo+IFRoaXMgc2hv
dWxkIG1ha2Ugc3VyZSBpdCBkb2Vzbid0IHRpY2sgcHJlZW1wdCBhIFNDSEVEX05PUk1BTCBuaWNl
IDAgdGFzay4NCkNvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBob3cgdGhlIGh1Z2UgcGVuYWxpemF0
aW9uIG9mIHZydW50aW1lKDEwMjQvMykgY291bGQNCm1ha2Ugc3VyZSBTQ0hFRF9JRExFIG5vdCB0
aWNrIHByZWVtcHRpbmcgU0NIRURfTk9STUFMIG5pY2UgMCB0YXNrPw0KDQpUaGFua3MgYSBsb3Qu
DQoNClJlZ2FyZHMsDQpKaWFuZw0KDQo+IA0KPiBJdCdzIGRpZmZlcmVudCB3aGVuIHRoZSBTQ0hF
RF9OT1JNQUwgdGFzayBoYXMgbmljZSAxOSAod2VpZ2h0PTE1KSBidXQNCj4gdGhhdCdzIHBhcnQg
b2YgdGhlIENGUyBkZXNpZ24uDQo+IA0KPj4gT24gdGhlIG90aGVyIGhhbmQsIGlkbGVfc2NoZWRf
Y2xhc3Mgc2VlbXMgbm90IHRvIGJlIHF1YWxpZmllZCBlaXRoZXIuIEl04oCZcyB0b28NCj4+IHNp
bXBsZSBhbmQgb25seSB1c2VkIGZvciBwZXItY3B1IGlkbGUgdGFzayBjdXJyZW50bHkuDQo+IA0K
PiBZZWFoLCBsZWF2ZSB0aGlzIGZvciB0aGUgcnEtPmlkbGUgdGFzayAoc3dhcHBlci9YKS4NCkdv
dCBpdC4NCg0KPiANCj4+Pj4gV2UgbmVlZCBhbiBhYnNvbHV0ZWx5IGxvdyBwcmlvcml0eSBjbGFz
cyB0aGF0IGNvdWxkIHRvbGVyYXRlIHN0YXJ2aW5nLCB3aGljaA0KPj4+PiBjb3VsZCBiZSB1c2Vk
IHRvIGNvLWxvY2F0ZSBvZmZsaW5lIHRhc2tzLiBCdXQgSURMRSBjbGFzcyBzZWVtcyB0byBiZSBu
b3QNCj4+Pj4gKmxvdyogZW5vdWdoLCBpZiBjb25zaWRlcmluZyB0aGUgZmFpcm5lc3Mgb2YgQ0ZT
LCBhbmQgSURMRSBjbGFzcyBzdGlsbCBoYXMgYQ0KPj4+PiB3ZWlnaHQuDQo+IA0KPiBVbmRlcnN0
b29kLiBCdXQgdGhpcyAodGljaykgcHJlZW1wdGlvbiBzaG91bGQgaGFwcGVuIGV4dHJlbWVseSBy
YXJlbHksDQo+IGVzcGVjaWFsbHkgaWYgeW91IGhhdmUgU0NIRURfTk9STUFMIG5pY2UgMCB0YXNr
cywgcmlnaHQ/DQoNCg==
