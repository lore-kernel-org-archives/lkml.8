Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EAD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="je7glhU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgHSOaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:30:16 -0400
Received: from mail6.tencent.com ([220.249.245.26]:41147 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgHSOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:30:08 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail6.tencent.com (Postfix) with ESMTP id 035B0CC323;
        Wed, 19 Aug 2020 22:28:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597847332;
        bh=ad35se09KmoGo62Lj1l9PnnISBr/UpC32oJWdq4Q7WU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=je7glhU7Pqcfzna8uM5zp+s1DaNVSBIHCXF3KNeObBi/3eUbX4TC2QzGbw/dPaIOC
         LQd66H6d3+ozOyWZvqODashY9hDwvTxko0m6YoRqKCF1y2amFmZVV7DatZZBevkveb
         BNAHAIzfvGtjdONxx9LfPgB1cpr5n1m5IouwIaCI=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 19 Aug
 2020 22:27:36 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 19 Aug
 2020 22:27:35 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 19 Aug 2020 22:27:35 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gIAA/wuAgAC/bYCAAQDpAIAB6mEAgAVOvgCAADR0AIADDqgAgAAFTwCAAA4SAIAAKm2A
Date:   Wed, 19 Aug 2020 14:27:35 +0000
Message-ID: <A8E52241-0206-447D-9EA0-699F8F82AFAB@tencent.com>
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
In-Reply-To: <bb7456af-6a4d-874c-e635-8d21e1ab3efc@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.105]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B87FADEC6DE62A4CB932221C703BBDE9@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDE5LCAyMDIwLCBhdCA3OjU1IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTkvMDgvMjAyMCAxMzowNSwg
VmluY2VudCBHdWl0dG90IHdyb3RlOg0KPj4gT24gV2VkLCAxOSBBdWcgMjAyMCBhdCAxMjo0Niwg
RGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiAxNy8wOC8yMDIwIDE0OjA1LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4g
DQo+Pj4+IA0KPj4+Pj4gT24gQXVnIDE3LCAyMDIwLCBhdCA0OjU3IFBNLCBEaWV0bWFyIEVnZ2Vt
YW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiAx
NC8wOC8yMDIwIDAxOjU1LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+
Pj4+PiANCj4+Pj4+Pj4gT24gQXVnIDEzLCAyMDIwLCBhdCAyOjM5IEFNLCBEaWV0bWFyIEVnZ2Vt
YW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4g
T24gMTIvMDgvMjAyMCAwNToxOSwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+PiBI
aSwNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IE9uIEF1ZyAxMSwgMjAyMCwgYXQgMTE6NTQgUE0sIERp
ZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+
Pj4gDQo+Pj4+Pj4+Pj4gT24gMTEvMDgvMjAyMCAwMjo0MSwgYmVuYmppYW5nKOiSi+W9qikgd3Jv
dGU6DQo+Pj4+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IE9uIEF1ZyAxMCwg
MjAyMCwgYXQgOToyNCBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0u
Y29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gT24gMDYvMDgvMjAyMCAxNzo1
MiwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4gSGksDQo+Pj4+Pj4+Pj4+
Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IE9uIEF1ZyA2LCAyMDIwLCBhdCA5OjI5IFBNLCBEaWV0bWFyIEVn
Z2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+Pj4+Pj4gT24gMDMvMDgvMjAyMCAxMzoyNiwgYmVuYmppYW5nKOiSi+W9qikgd3Jv
dGU6DQo+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+Pj4+IE9u
IEF1ZyAzLCAyMDIwLCBhdCA0OjE2IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2Vt
YW5uQGFybS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+Pj4+IE9u
IDAxLzA4LzIwMjAgMDQ6MzIsIEppYW5nIEJpYW8gd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4+Pj4+IEZy
b206IEppYW5nIEJpYW8gPGJlbmJqaWFuZ0B0ZW5jZW50LmNvbT4NCj4+PiANCj4+PiBbLi4uXQ0K
Pj4+IA0KPj4+Pj4gQXJlIHlvdSBzdXJlIGFib3V0IHRoaXM/DQo+Pj4+IFllcy4gOikNCj4+Pj4+
IA0KPj4+Pj4gVGhlIG1hdGggaXMgdGVsbGluZyBtZSBmb3IgdGhlOg0KPj4+Pj4gDQo+Pj4+PiBp
ZGxlIHRhc2s6ICAgICAgKDMgLyAoMTAyNCArIDEwMjQgKyAzKSleKC0xKSAqIDRtcyA9IDI3MzVt
cw0KPj4+Pj4gDQo+Pj4+PiBub3JtYWwgdGFzazogKDEwMjQgLyAoMTAyNCArIDEwMjQgKyAzKSle
KC0xKSAqIDRtcyA9ICAgIDhtcw0KPj4+Pj4gDQo+Pj4+PiAoNG1zIC0gMjUwIEh6KQ0KPj4+PiBN
eSB0aWNrIGlzIDFtcyAtIDEwMDBIWiwgd2hpY2ggc2VlbXMgcmVhc29uYWJsZSBmb3IgNjAwbXM/
IDopDQo+Pj4gDQo+Pj4gT0ssIEkgc2VlLg0KPj4+IA0KPj4+IEJ1dCBoZXJlIHRoZSBkaWZmZXJl
bnQgc2NoZWQgc2xpY2VzIChjaGVja19wcmVlbXB0X3RpY2soKS0+DQo+Pj4gc2NoZWRfc2xpY2Uo
KSkgYmV0d2VlbiBub3JtYWwgdGFza3MgYW5kIHRoZSBpZGxlIHRhc2sgcGxheSBhIHJvbGUgdG8u
DQo+Pj4gDQo+Pj4gTm9ybWFsIHRhc2tzIGdldCB+M21zIHdoZXJlYXMgdGhlIGlkbGUgdGFzayBn
ZXRzIDwwLjAxbXMuDQo+PiANCj4+IEluIGZhY3QgdGhhdCBkZXBlbmRzIG9uIHRoZSBudW1iZXIg
b2YgQ1BVcyBvbiB0aGUgc3lzdGVtDQo+PiA6c3lzY3RsX3NjaGVkX2xhdGVuY3kgPSA2bXMgKiAo
MSArIGlsb2cobmNwdXMpKSAuIE9uIGEgOCBjb3JlcyBzeXN0ZW0sDQo+PiBub3JtYWwgdGFzayB3
aWxsIHJ1biBhcm91bmQgMTJtcyBpbiBvbmUgc2hvb3QgYW5kIHRoZSBpZGxlIHRhc2sgc3RpbGwN
Cj4+IG9uZSB0aWNrIHBlcmlvZA0KPiANCj4gVHJ1ZS4gVGhpcyBpcyBvbiBhIHNpbmdsZSBDUFUu
DQpBZ3JlZS4gOikNCg0KPiANCj4+IEFsc28sIHlvdSBjYW4gaW5jcmVhc2UgZXZlbiBtb3JlIHRo
ZSBwZXJpb2QgYmV0d2VlbiAyIHJ1bnMgb2YgaWRsZQ0KPj4gdGFzayBieSB1c2luZyBjZ3JvdXBz
IGFuZCBtaW4gc2hhcmVzIHZhbHVlIDogMg0KPiANCj4gQWggeWVzLCBtYXliZSB0aGlzIGlzIHdo
YXQgSmlhbmcgd2FudHMgdG8gZG8gdGhlbj8gSWYgaGlzIHJ1bnRpbWUgZG9lcw0KPiBub3QgaGF2
ZSBvdGhlciByZXF1aXJlbWVudHMgcHJldmVudGluZyB0aGlzLg0KVGhhdCBjb3VsZCB3b3JrIGZv
ciBpbmNyZWFzaW5nIHRoZSBwZXJpb2QgYmV0d2VlbiAyIHJ1bnMuIEJ1dCBjb3VsZCBub3QNCnJl
ZHVjZSB0aGUgc2luZ2xlIHJ1bnRpbWUgb2YgaWRsZSB0YXNrIEkgZ3Vlc3MsIHdoaWNoIG1lYW5z
IG5vcm1hbCB0YXNrDQpjb3VsZCBoYXZlIDEtdGljayBzY2hlZHVsZSBsYXRlbmN5IGJlY2F1c2Ug
b2YgaWRsZSB0YXNrLiANCk9UT0gsIGNncm91cHMoc2hhcmVzKSBjb3VsZCBpbnRyb2R1Y2UgZXh0
cmEgY29tcGxleGl0eS4gOikgIA0KDQpJIHdvbmRlciBpZiB0aGVyZeKAmXMgYW55IHBvc3NpYmls
aXR5IHRvIG1ha2UgU0NIRURfSURMRXPigJkgcHJpb3JpdGllcyBhYnNvbHV0ZWx5DQpsb3dlciB0
aGFuIFNDSEVEX05PUk1BTChPVEhFUiksIHdoaWNoIG1lYW5zIG5vIHdlaWdodHMvc2hhcmVzDQpm
b3IgdGhlbSwgYW5kIHRoZXkgcnVuIG9ubHkgd2hlbiBubyBvdGhlciB0YXNr4oCZcyBydW5uYWJs
ZS4NCkkgZ3Vlc3MgdGhlcmUgbWF5IGJlIHByaW9yaXR5IGludmVyc2lvbiBpc3N1ZSBpZiB3ZSBk
byB0aGF0LiBCdXQgbWF5YmUgd2UNCmNvdWxkIGF2b2lkIGl0IGJ5IGxvYWQtYmFsYW5jZSBtb3Jl
IGFnZ3Jlc3NpdmVseSwgb3IgaXQocHJpb3JpdHkgaW52ZXJzaW9uKQ0KY291bGQgYmUgaWdub3Jl
ZCBpbiBzb21lIHNwZWNpYWwgY2FzZS4NCg0KVGh4LiANClJlZ2FyZCwNCkppYW5nDQogDQo+IA0K
PiBbLi4uXQ0KDQo=
