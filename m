Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C29CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED361207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="laLUNXZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgHTL3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:29:05 -0400
Received: from mail4.tencent.com ([183.57.53.109]:43756 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbgHTL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:28:12 -0400
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
        by mail4.tencent.com (Postfix) with ESMTP id 67A217249F;
        Thu, 20 Aug 2020 19:28:02 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597922882;
        bh=I/oYr/T/0H5D9VWIuwOWKoQwA59WpLS7xeepw0fj0dc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=laLUNXZFl+UdOkcz48g94GsIM4+mHJ4fUubm+/ScqsWsjYZFN56zFnR5vbLIss+uA
         g89SalXJG9REaLu77SLKhhn5IZF8EnPAnQw5XqibJgvQxzzboZMwXwjesBDZOL+S+m
         ybMNgebbHWMpBY6oNYsuzT0pN8nLXcUFssatTCZc=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 20 Aug
 2020 19:28:02 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 20 Aug
 2020 19:28:02 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 20 Aug 2020 19:27:59 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
Thread-Topic: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gIAA/wuAgAC/bYCAAQDpAIAB6mEAgAVOvgCAADR0AIADDqgAgAAFTwCAAA4SAIAAKm2AgAAH5ICAAJvdgIAAe4UAgABA4AA=
Date:   Thu, 20 Aug 2020 11:27:59 +0000
Message-ID: <D80F1584-F569-4CEE-8DCC-7841CF7E159F@tencent.com>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
 <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
 <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
 <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com>
 <4964e359-afc5-a256-4950-853a9485eeff@arm.com>
 <70236E62-AA36-48C1-9382-86353649253C@tencent.com>
 <3a1047fc-a86a-014a-b17a-eae71f669da1@arm.com>
 <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com>
 <55f04582-69d6-aeb4-85be-3e46a3b15beb@arm.com>
 <755BFAD0-9072-4D73-9CD7-AF4F74A79D21@tencent.com>
 <729675a2-b083-4211-62c0-f7ed7f483ae2@arm.com>
 <CAKfTPtATf94n4t6EnB5_76ygox26xd9EwvEHiv5cGN=E9BdLgg@mail.gmail.com>
 <bb7456af-6a4d-874c-e635-8d21e1ab3efc@arm.com>
 <A8E52241-0206-447D-9EA0-699F8F82AFAB@tencent.com>
 <CAKfTPtBiZHwkhCkMQs9iOF=eBLgubsJkARN5zOKZzmfo_jTJzg@mail.gmail.com>
 <3A85DD77-2A4B-466F-A1F4-1BF2AF02CF58@tencent.com>
 <CAKfTPtATpDB+ihpMf854nTdDfy4Bw_BU=21PRHVczEcE42271Q@mail.gmail.com>
In-Reply-To: <CAKfTPtATpDB+ihpMf854nTdDfy4Bw_BU=21PRHVczEcE42271Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.28]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F785BBE6AA358444B0A0BC9E54833196@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDIwLCAyMDIwLCBhdCAzOjM1IFBNLCBWaW5jZW50IEd1aXR0b3QgPHZpbmNl
bnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAgQXVnIDIwMjAg
YXQgMDI6MTMsIGJlbmJqaWFuZyjokovlvaopIDxiZW5iamlhbmdAdGVuY2VudC5jb20+IHdyb3Rl
Og0KPj4gDQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAxOSwgMjAyMCwgYXQgMTA6NTUgUE0sIFZpbmNl
bnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFdlZCwgMTkgQXVnIDIwMjAgYXQgMTY6MjcsIGJlbmJqaWFuZyjokovlvaopIDxiZW5iamlh
bmdAdGVuY2VudC5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gQXVn
IDE5LCAyMDIwLCBhdCA3OjU1IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5u
QGFybS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiAxOS8wOC8yMDIwIDEzOjA1LCBWaW5j
ZW50IEd1aXR0b3Qgd3JvdGU6DQo+Pj4+Pj4gT24gV2VkLCAxOSBBdWcgMjAyMCBhdCAxMjo0Niwg
RGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IE9uIDE3LzA4LzIwMjAgMTQ6MDUsIGJlbmJqaWFuZyjokovlvaopIHdyb3Rl
Og0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBBdWcgMTcsIDIwMjAsIGF0IDQ6
NTcgUE0sIERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gMTQvMDgvMjAyMCAwMTo1NSwgYmVuYmppYW5nKOiS
i+W9qikgd3JvdGU6DQo+Pj4+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IE9u
IEF1ZyAxMywgMjAyMCwgYXQgMjozOSBBTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dl
bWFubkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gT24gMTIvMDgv
MjAyMCAwNToxOSwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4gSGksDQo+
Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IE9uIEF1ZyAxMSwgMjAyMCwgYXQgMTE6NTQgUE0s
IERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6DQo+Pj4+
Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+PiBPbiAxMS8wOC8yMDIwIDAyOjQxLCBiZW5iamlhbmco
6JKL5b2qKSB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4+Pj4+Pj4gT24gQXVnIDEwLCAyMDIwLCBhdCA5OjI0IFBNLCBEaWV0bWFyIEVnZ2VtYW5u
IDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+Pj4+Pj4+IE9uIDA2LzA4LzIwMjAgMTc6NTIsIGJlbmJqaWFuZyjokovlvaopIHdyb3Rl
Og0KPj4+Pj4+Pj4+Pj4+Pj4+PiBIaSwNCj4+Pj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBPbiBBdWcgNiwgMjAyMCwgYXQgOToyOSBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1h
ci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4gT24gMDMvMDgvMjAyMCAxMzoyNiwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+IE9uIEF1ZyAzLCAyMDIwLCBhdCA0OjE2IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFy
LmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gT24gMDEvMDgvMjAyMCAwNDozMiwgSmlhbmcgQmlhbyB3cm90ZToNCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IEZyb206IEppYW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5jZW50LmNvbT4N
Cj4+Pj4+Pj4gDQo+Pj4+Pj4+IFsuLi5dDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IEFyZSB5b3Ugc3Vy
ZSBhYm91dCB0aGlzPw0KPj4+Pj4+Pj4gWWVzLiA6KQ0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IFRo
ZSBtYXRoIGlzIHRlbGxpbmcgbWUgZm9yIHRoZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBpZGxl
IHRhc2s6ICAgICAgKDMgLyAoMTAyNCArIDEwMjQgKyAzKSleKC0xKSAqIDRtcyA9IDI3MzVtcw0K
Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IG5vcm1hbCB0YXNrOiAoMTAyNCAvICgxMDI0ICsgMTAyNCAr
IDMpKV4oLTEpICogNG1zID0gICAgOG1zDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gKDRtcyAtIDI1
MCBIeikNCj4+Pj4+Pj4+IE15IHRpY2sgaXMgMW1zIC0gMTAwMEhaLCB3aGljaCBzZWVtcyByZWFz
b25hYmxlIGZvciA2MDBtcz8gOikNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9LLCBJIHNlZS4NCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IEJ1dCBoZXJlIHRoZSBkaWZmZXJlbnQgc2NoZWQgc2xpY2VzIChjaGVja19w
cmVlbXB0X3RpY2soKS0+DQo+Pj4+Pj4+IHNjaGVkX3NsaWNlKCkpIGJldHdlZW4gbm9ybWFsIHRh
c2tzIGFuZCB0aGUgaWRsZSB0YXNrIHBsYXkgYSByb2xlIHRvLg0KPj4+Pj4+PiANCj4+Pj4+Pj4g
Tm9ybWFsIHRhc2tzIGdldCB+M21zIHdoZXJlYXMgdGhlIGlkbGUgdGFzayBnZXRzIDwwLjAxbXMu
DQo+Pj4+Pj4gDQo+Pj4+Pj4gSW4gZmFjdCB0aGF0IGRlcGVuZHMgb24gdGhlIG51bWJlciBvZiBD
UFVzIG9uIHRoZSBzeXN0ZW0NCj4+Pj4+PiA6c3lzY3RsX3NjaGVkX2xhdGVuY3kgPSA2bXMgKiAo
MSArIGlsb2cobmNwdXMpKSAuIE9uIGEgOCBjb3JlcyBzeXN0ZW0sDQo+Pj4+Pj4gbm9ybWFsIHRh
c2sgd2lsbCBydW4gYXJvdW5kIDEybXMgaW4gb25lIHNob290IGFuZCB0aGUgaWRsZSB0YXNrIHN0
aWxsDQo+Pj4+Pj4gb25lIHRpY2sgcGVyaW9kDQo+Pj4+PiANCj4+Pj4+IFRydWUuIFRoaXMgaXMg
b24gYSBzaW5nbGUgQ1BVLg0KPj4+PiBBZ3JlZS4gOikNCj4+Pj4gDQo+Pj4+PiANCj4+Pj4+PiBB
bHNvLCB5b3UgY2FuIGluY3JlYXNlIGV2ZW4gbW9yZSB0aGUgcGVyaW9kIGJldHdlZW4gMiBydW5z
IG9mIGlkbGUNCj4+Pj4+PiB0YXNrIGJ5IHVzaW5nIGNncm91cHMgYW5kIG1pbiBzaGFyZXMgdmFs
dWUgOiAyDQo+Pj4+PiANCj4+Pj4+IEFoIHllcywgbWF5YmUgdGhpcyBpcyB3aGF0IEppYW5nIHdh
bnRzIHRvIGRvIHRoZW4/IElmIGhpcyBydW50aW1lIGRvZXMNCj4+Pj4+IG5vdCBoYXZlIG90aGVy
IHJlcXVpcmVtZW50cyBwcmV2ZW50aW5nIHRoaXMuDQo+Pj4+IFRoYXQgY291bGQgd29yayBmb3Ig
aW5jcmVhc2luZyB0aGUgcGVyaW9kIGJldHdlZW4gMiBydW5zLiBCdXQgY291bGQgbm90DQo+Pj4+
IHJlZHVjZSB0aGUgc2luZ2xlIHJ1bnRpbWUgb2YgaWRsZSB0YXNrIEkgZ3Vlc3MsIHdoaWNoIG1l
YW5zIG5vcm1hbCB0YXNrDQo+Pj4+IGNvdWxkIGhhdmUgMS10aWNrIHNjaGVkdWxlIGxhdGVuY3kg
YmVjYXVzZSBvZiBpZGxlIHRhc2suDQo+Pj4gDQo+Pj4gWWVzLiAgQW4gaWRsZSB0YXNrIHdpbGwg
cHJlZW1wdCBhbiBhbHdheXMgcnVubmluZyB0YXNrIGR1cmluZyAxIHRpY2sNCj4+PiBldmVyeSA2
ODBtcy4gQnV0IGFsc28geW91IHNob3VsZCBrZWVwIGluIG1pbmQgdGhhdCBhIHdha2luZyBub3Jt
YWwNCj4+PiB0YXNrIHdpbGwgcHJlZW1wdCB0aGUgaWRsZSB0YXNrIGltbWVkaWF0ZWx5IHdoaWNo
IG1lYW5zIHRoYXQgaXQgd2lsbA0KPj4+IG5vdCBhZGQgc2NoZWR1bGluZyBsYXRlbmN5IHRvIGEg
bm9ybWFsIHRhc2sgYnV0ICJzdGVhbCIgMC4xNCUgb2YNCj4+PiBub3JtYWwgdGFzayB0aHJvdWdo
cHV0ICgxLzY4MCkgYXQgbW9zdA0KPj4gVGhhdOKAmXMgdHJ1ZS4gQnV0IGluIHRoZSBWTSBjYXNl
LCB3aGVuIFZNIGFyZSBidXN5KE1XQUlUIHBhc3N0aHJvdWdoDQo+PiBvciBydW5uaW5nIGNwdSBl
YXRpbmcgd29ya3MpLCB0aGUgMS10aWNrIHNjaGVkdWxpbmcgbGF0ZW5jeSBjb3VsZCBiZQ0KPj4g
ZGV0ZWN0ZWQgYnkgY3ljbGljdGVzdCBydW5uaW5nIGluIHRoZSBWTS4NCj4+IA0KPj4gT1RPSCwg
d2UgY29tcGVuc2F0ZSB2cnVudGltZSBpbiBwbGFjZV9lbnRpdHkoKSB0byBib290IHdha2luZw0K
Pj4gd2l0aG91dCBkaXN0aW5ndWlzaCBTQ0hFRF9JRExFIHRhc2ssIGRvIHlvdSB0aGluayBpdOKA
mXMgbmVjZXNzYXJ5IHRvDQo+PiBkbyB0aGF0PyBsaWtlDQo+PiANCj4+IC0tLSBhL2tlcm5lbC9z
Y2hlZC9mYWlyLmMNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+IEBAIC00MTE1LDcg
KzQxMTUsNyBAQCBwbGFjZV9lbnRpdHkoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2No
ZWRfZW50aXR5ICpzZSwgaW50IGluaXRpYWwpDQo+PiAgICAgICAgICAgICAgICB2cnVudGltZSAr
PSBzY2hlZF92c2xpY2UoY2ZzX3JxLCBzZSk7DQo+PiANCj4+ICAgICAgICAvKiBzbGVlcHMgdXAg
dG8gYSBzaW5nbGUgbGF0ZW5jeSBkb24ndCBjb3VudC4gKi8NCj4+IC0gICAgICAgaWYgKCFpbml0
aWFsKSB7DQo+PiArICAgICAgIGlmICghaW5pdGlhbCAmJiBsaWtlbHkoIXRhc2tfaGFzX2lkbGVf
cG9saWN5KHRhc2tfb2Yoc2UpKSkpIHsNCj4+ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
dGhyZXNoID0gc3lzY3RsX3NjaGVkX2xhdGVuY3k7DQo+IA0KPiBZZWFoLCB0aGlzIGlzIGEgZ29v
ZCBpbXByb3ZlbWVudC4NClRoYW5rcywgSeKAmWxsIHNlbmQgYSBwYXRjaCBmb3IgdGhhdC4gOikN
Cg0KPiBEb2VzIGl0IHNvbHZlIHlvdXIgcHJvYmxlbSA/DQo+IA0KTm90IGV4YWN0bHkuIDopICBJ
IHdvbmRlciBpZiB3ZSBjYW4gbWFrZSBTQ0hFRF9JRExFIG1vcmUgcHVyZShoYXJtbGVzcyk/DQpP
ciBpbnRyb2R1Y2UgYSBzd2l0Y2gob3IgZmxhZykgdG8gY29udHJvbCBpdCwgYW5kIG1ha2UgaXQg
YXZhaWxhYmxlIGZvciBjYXNlcyBsaWtlIHVzLg0KDQpUaGFua3MgYSBsb3QuDQpSZWdhcmRzLA0K
SmlhbmcNCg0KPj4gDQo+Pj4gDQo+Pj4+IE9UT0gsIGNncm91cHMoc2hhcmVzKSBjb3VsZCBpbnRy
b2R1Y2UgZXh0cmEgY29tcGxleGl0eS4gOikNCj4+Pj4gDQo+Pj4+IEkgd29uZGVyIGlmIHRoZXJl
4oCZcyBhbnkgcG9zc2liaWxpdHkgdG8gbWFrZSBTQ0hFRF9JRExFc+KAmSBwcmlvcml0aWVzIGFi
c29sdXRlbHkNCj4+Pj4gbG93ZXIgdGhhbiBTQ0hFRF9OT1JNQUwoT1RIRVIpLCB3aGljaCBtZWFu
cyBubyB3ZWlnaHRzL3NoYXJlcw0KPj4+PiBmb3IgdGhlbSwgYW5kIHRoZXkgcnVuIG9ubHkgd2hl
biBubyBvdGhlciB0YXNr4oCZcyBydW5uYWJsZS4NCj4+Pj4gSSBndWVzcyB0aGVyZSBtYXkgYmUg
cHJpb3JpdHkgaW52ZXJzaW9uIGlzc3VlIGlmIHdlIGRvIHRoYXQuIEJ1dCBtYXliZSB3ZQ0KPj4+
IA0KPj4+IEV4YWN0bHksIHRoYXQncyB3aHkgd2UgbXVzdCBlbnN1cmUgYSBtaW5pbXVtIHJ1bm5p
bmcgdGltZSBmb3Igc2NoZWRfaWRsZSB0YXNrDQo+PiANCj4+IFN0aWxsIGZvciBWTSBjYXNlLCBk
aWZmZXJlbnQgVk1zIGhhdmUgYmVlbiBtdWNoIGlzb2xhdGVkIGZyb20gZWFjaCBvdGhlciwNCj4+
IHByaW9yaXR5IGludmVyc2lvbiBpc3N1ZSBjb3VsZCBiZSB2ZXJ5IHJhcmUsIHdl4oCZcmUgdHJ5
aW5nIHRvIG1ha2Ugb2ZmbGluZSB0YXNrcw0KPj4gYWJzb3VsdGx5IGhhcm1sZXNzIHRvIG9ubGlu
ZSB0YXNrcy4gOikNCj4+IA0KPj4gVGhhbmtzIGEgbG90IGZvciB5b3VyIHRpbWUuDQo+PiBSZWdh
cmRzLA0KPj4gSmlhbmcNCj4+IA0KPj4+IA0KPj4+PiBjb3VsZCBhdm9pZCBpdCBieSBsb2FkLWJh
bGFuY2UgbW9yZSBhZ2dyZXNzaXZlbHksIG9yIGl0KHByaW9yaXR5IGludmVyc2lvbikNCj4+Pj4g
Y291bGQgYmUgaWdub3JlZCBpbiBzb21lIHNwZWNpYWwgY2FzZS4NCg0K
