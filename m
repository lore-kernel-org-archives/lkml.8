Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C313DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FAE2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="h0DD8RBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHTANu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:13:50 -0400
Received: from mail6.tencent.com ([220.249.245.26]:55002 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgHTANq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:13:46 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail6.tencent.com (Postfix) with ESMTP id F2274CC0E4;
        Thu, 20 Aug 2020 08:14:57 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597882498;
        bh=pHuwCrLe1sBhm51cikXT2DxdNdb9NoGJcRejdWLGfL4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=h0DD8RBq+1TFM3zr20/mzenLOQIBXiPdGN+VvXJVk+/G4GTneql6Da26FzrsM3MaE
         K7XRcDVgTdQZjAxrlvABS4uNTMfbF5m1VqqkVzuZv9vN9zlNvqfUYJ9eFmDwhQOClv
         ak0Cp3tLkURMLUxlFPninBMGbd2fsf/tUi6evbo4=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 20 Aug
 2020 08:13:42 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 20 Aug
 2020 08:13:41 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 20 Aug 2020 08:13:41 +0800
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
Thread-Index: AQHWZ6wckGsZD+WUv0OJdOJkfcOxRKklh1uAgAA1DACABNlRgIAAJ90AgAYgFwCAAL04gIAA/wuAgAC/bYCAAQDpAIAB6mEAgAVOvgCAADR0AIADDqgAgAAFTwCAAA4SAIAAKm2AgAAH5ICAAJvdgA==
Date:   Thu, 20 Aug 2020 00:13:41 +0000
Message-ID: <3A85DD77-2A4B-466F-A1F4-1BF2AF02CF58@tencent.com>
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
In-Reply-To: <CAKfTPtBiZHwkhCkMQs9iOF=eBLgubsJkARN5zOKZzmfo_jTJzg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3A8FBEAB9AFC14199A586421B71A731@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDE5LCAyMDIwLCBhdCAxMDo1NSBQTSwgVmluY2VudCBHdWl0dG90IDx2aW5j
ZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDE5IEF1ZyAyMDIw
IGF0IDE2OjI3LCBiZW5iamlhbmco6JKL5b2qKSA8YmVuYmppYW5nQHRlbmNlbnQuY29tPiB3cm90
ZToNCj4+IA0KPj4gDQo+PiANCj4+PiBPbiBBdWcgMTksIDIwMjAsIGF0IDc6NTUgUE0sIERpZXRt
YXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gMTkvMDgvMjAyMCAxMzowNSwgVmluY2VudCBHdWl0dG90IHdyb3RlOg0KPj4+PiBPbiBXZWQs
IDE5IEF1ZyAyMDIwIGF0IDEyOjQ2LCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5u
QGFybS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiAxNy8wOC8yMDIwIDE0OjA1LCBiZW5i
amlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+Pj4gT24gQXVnIDE3
LCAyMDIwLCBhdCA0OjU3IFBNLCBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0bWFyLmVnZ2VtYW5uQGFy
bS5jb20+IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gMTQvMDgvMjAyMCAwMTo1NSwgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+PiBIaSwNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
IE9uIEF1ZyAxMywgMjAyMCwgYXQgMjozOSBBTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5l
Z2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiAxMi8wOC8y
MDIwIDA1OjE5LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+Pj4+Pj4gSGksDQo+Pj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gT24gQXVnIDExLCAyMDIwLCBhdCAxMTo1NCBQTSwgRGlldG1h
ciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+Pj4gT24gMTEvMDgvMjAyMCAwMjo0MSwgYmVuYmppYW5nKOiSi+W9qikgd3Jv
dGU6DQo+Pj4+Pj4+Pj4+Pj4gSGksDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IE9uIEF1
ZyAxMCwgMjAyMCwgYXQgOToyNCBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFu
bkBhcm0uY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IE9uIDA2LzA4
LzIwMjAgMTc6NTIsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+Pj4gSGks
DQo+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiBPbiBBdWcgNiwgMjAyMCwgYXQgOToy
OSBQTSwgRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPiB3cm90ZToN
Cj4+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiBPbiAwMy8wOC8yMDIwIDEzOjI2LCBi
ZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gT24gQXVnIDMsIDIwMjAsIGF0IDQ6MTYgUE0sIERpZXRt
YXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4+
Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IE9uIDAxLzA4LzIwMjAgMDQ6MzIsIEppYW5nIEJp
YW8gd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gRnJvbTogSmlhbmcgQmlhbyA8YmVuYmppYW5n
QHRlbmNlbnQuY29tPg0KPj4+Pj4gDQo+Pj4+PiBbLi4uXQ0KPj4+Pj4gDQo+Pj4+Pj4+IEFyZSB5
b3Ugc3VyZSBhYm91dCB0aGlzPw0KPj4+Pj4+IFllcy4gOikNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRo
ZSBtYXRoIGlzIHRlbGxpbmcgbWUgZm9yIHRoZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IGlkbGUgdGFz
azogICAgICAoMyAvICgxMDI0ICsgMTAyNCArIDMpKV4oLTEpICogNG1zID0gMjczNW1zDQo+Pj4+
Pj4+IA0KPj4+Pj4+PiBub3JtYWwgdGFzazogKDEwMjQgLyAoMTAyNCArIDEwMjQgKyAzKSleKC0x
KSAqIDRtcyA9ICAgIDhtcw0KPj4+Pj4+PiANCj4+Pj4+Pj4gKDRtcyAtIDI1MCBIeikNCj4+Pj4+
PiBNeSB0aWNrIGlzIDFtcyAtIDEwMDBIWiwgd2hpY2ggc2VlbXMgcmVhc29uYWJsZSBmb3IgNjAw
bXM/IDopDQo+Pj4+PiANCj4+Pj4+IE9LLCBJIHNlZS4NCj4+Pj4+IA0KPj4+Pj4gQnV0IGhlcmUg
dGhlIGRpZmZlcmVudCBzY2hlZCBzbGljZXMgKGNoZWNrX3ByZWVtcHRfdGljaygpLT4NCj4+Pj4+
IHNjaGVkX3NsaWNlKCkpIGJldHdlZW4gbm9ybWFsIHRhc2tzIGFuZCB0aGUgaWRsZSB0YXNrIHBs
YXkgYSByb2xlIHRvLg0KPj4+Pj4gDQo+Pj4+PiBOb3JtYWwgdGFza3MgZ2V0IH4zbXMgd2hlcmVh
cyB0aGUgaWRsZSB0YXNrIGdldHMgPDAuMDFtcy4NCj4+Pj4gDQo+Pj4+IEluIGZhY3QgdGhhdCBk
ZXBlbmRzIG9uIHRoZSBudW1iZXIgb2YgQ1BVcyBvbiB0aGUgc3lzdGVtDQo+Pj4+IDpzeXNjdGxf
c2NoZWRfbGF0ZW5jeSA9IDZtcyAqICgxICsgaWxvZyhuY3B1cykpIC4gT24gYSA4IGNvcmVzIHN5
c3RlbSwNCj4+Pj4gbm9ybWFsIHRhc2sgd2lsbCBydW4gYXJvdW5kIDEybXMgaW4gb25lIHNob290
IGFuZCB0aGUgaWRsZSB0YXNrIHN0aWxsDQo+Pj4+IG9uZSB0aWNrIHBlcmlvZA0KPj4+IA0KPj4+
IFRydWUuIFRoaXMgaXMgb24gYSBzaW5nbGUgQ1BVLg0KPj4gQWdyZWUuIDopDQo+PiANCj4+PiAN
Cj4+Pj4gQWxzbywgeW91IGNhbiBpbmNyZWFzZSBldmVuIG1vcmUgdGhlIHBlcmlvZCBiZXR3ZWVu
IDIgcnVucyBvZiBpZGxlDQo+Pj4+IHRhc2sgYnkgdXNpbmcgY2dyb3VwcyBhbmQgbWluIHNoYXJl
cyB2YWx1ZSA6IDINCj4+PiANCj4+PiBBaCB5ZXMsIG1heWJlIHRoaXMgaXMgd2hhdCBKaWFuZyB3
YW50cyB0byBkbyB0aGVuPyBJZiBoaXMgcnVudGltZSBkb2VzDQo+Pj4gbm90IGhhdmUgb3RoZXIg
cmVxdWlyZW1lbnRzIHByZXZlbnRpbmcgdGhpcy4NCj4+IFRoYXQgY291bGQgd29yayBmb3IgaW5j
cmVhc2luZyB0aGUgcGVyaW9kIGJldHdlZW4gMiBydW5zLiBCdXQgY291bGQgbm90DQo+PiByZWR1
Y2UgdGhlIHNpbmdsZSBydW50aW1lIG9mIGlkbGUgdGFzayBJIGd1ZXNzLCB3aGljaCBtZWFucyBu
b3JtYWwgdGFzaw0KPj4gY291bGQgaGF2ZSAxLXRpY2sgc2NoZWR1bGUgbGF0ZW5jeSBiZWNhdXNl
IG9mIGlkbGUgdGFzay4NCj4gDQo+IFllcy4gIEFuIGlkbGUgdGFzayB3aWxsIHByZWVtcHQgYW4g
YWx3YXlzIHJ1bm5pbmcgdGFzayBkdXJpbmcgMSB0aWNrDQo+IGV2ZXJ5IDY4MG1zLiBCdXQgYWxz
byB5b3Ugc2hvdWxkIGtlZXAgaW4gbWluZCB0aGF0IGEgd2FraW5nIG5vcm1hbA0KPiB0YXNrIHdp
bGwgcHJlZW1wdCB0aGUgaWRsZSB0YXNrIGltbWVkaWF0ZWx5IHdoaWNoIG1lYW5zIHRoYXQgaXQg
d2lsbA0KPiBub3QgYWRkIHNjaGVkdWxpbmcgbGF0ZW5jeSB0byBhIG5vcm1hbCB0YXNrIGJ1dCAi
c3RlYWwiIDAuMTQlIG9mDQo+IG5vcm1hbCB0YXNrIHRocm91Z2hwdXQgKDEvNjgwKSBhdCBtb3N0
DQpUaGF04oCZcyB0cnVlLiBCdXQgaW4gdGhlIFZNIGNhc2UsIHdoZW4gVk0gYXJlIGJ1c3koTVdB
SVQgcGFzc3Rocm91Z2gNCm9yIHJ1bm5pbmcgY3B1IGVhdGluZyB3b3JrcyksIHRoZSAxLXRpY2sg
c2NoZWR1bGluZyBsYXRlbmN5IGNvdWxkIGJlDQpkZXRlY3RlZCBieSBjeWNsaWN0ZXN0IHJ1bm5p
bmcgaW4gdGhlIFZNLg0KDQpPVE9ILCB3ZSBjb21wZW5zYXRlIHZydW50aW1lIGluIHBsYWNlX2Vu
dGl0eSgpIHRvIGJvb3Qgd2FraW5nDQp3aXRob3V0IGRpc3Rpbmd1aXNoIFNDSEVEX0lETEUgdGFz
aywgZG8geW91IHRoaW5rIGl04oCZcyBuZWNlc3NhcnkgdG8NCmRvIHRoYXQ/IGxpa2UNCg0KLS0t
IGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KQEAgLTQx
MTUsNyArNDExNSw3IEBAIHBsYWNlX2VudGl0eShzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEsIHN0cnVj
dCBzY2hlZF9lbnRpdHkgKnNlLCBpbnQgaW5pdGlhbCkNCiAgICAgICAgICAgICAgICB2cnVudGlt
ZSArPSBzY2hlZF92c2xpY2UoY2ZzX3JxLCBzZSk7DQoNCiAgICAgICAgLyogc2xlZXBzIHVwIHRv
IGEgc2luZ2xlIGxhdGVuY3kgZG9uJ3QgY291bnQuICovDQotICAgICAgIGlmICghaW5pdGlhbCkg
ew0KKyAgICAgICBpZiAoIWluaXRpYWwgJiYgbGlrZWx5KCF0YXNrX2hhc19pZGxlX3BvbGljeSh0
YXNrX29mKHNlKSkpKSB7DQogICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyB0aHJlc2ggPSBz
eXNjdGxfc2NoZWRfbGF0ZW5jeTsNCg0KPiANCj4+IE9UT0gsIGNncm91cHMoc2hhcmVzKSBjb3Vs
ZCBpbnRyb2R1Y2UgZXh0cmEgY29tcGxleGl0eS4gOikNCj4+IA0KPj4gSSB3b25kZXIgaWYgdGhl
cmXigJlzIGFueSBwb3NzaWJpbGl0eSB0byBtYWtlIFNDSEVEX0lETEVz4oCZIHByaW9yaXRpZXMg
YWJzb2x1dGVseQ0KPj4gbG93ZXIgdGhhbiBTQ0hFRF9OT1JNQUwoT1RIRVIpLCB3aGljaCBtZWFu
cyBubyB3ZWlnaHRzL3NoYXJlcw0KPj4gZm9yIHRoZW0sIGFuZCB0aGV5IHJ1biBvbmx5IHdoZW4g
bm8gb3RoZXIgdGFza+KAmXMgcnVubmFibGUuDQo+PiBJIGd1ZXNzIHRoZXJlIG1heSBiZSBwcmlv
cml0eSBpbnZlcnNpb24gaXNzdWUgaWYgd2UgZG8gdGhhdC4gQnV0IG1heWJlIHdlDQo+IA0KPiBF
eGFjdGx5LCB0aGF0J3Mgd2h5IHdlIG11c3QgZW5zdXJlIGEgbWluaW11bSBydW5uaW5nIHRpbWUg
Zm9yIHNjaGVkX2lkbGUgdGFzaw0KDQpTdGlsbCBmb3IgVk0gY2FzZSwgZGlmZmVyZW50IFZNcyBo
YXZlIGJlZW4gbXVjaCBpc29sYXRlZCBmcm9tIGVhY2ggb3RoZXIsDQpwcmlvcml0eSBpbnZlcnNp
b24gaXNzdWUgY291bGQgYmUgdmVyeSByYXJlLCB3ZeKAmXJlIHRyeWluZyB0byBtYWtlIG9mZmxp
bmUgdGFza3MNCmFic291bHRseSBoYXJtbGVzcyB0byBvbmxpbmUgdGFza3MuIDopDQoNClRoYW5r
cyBhIGxvdCBmb3IgeW91ciB0aW1lLg0KUmVnYXJkcywNCkppYW5nDQoNCj4gDQo+PiBjb3VsZCBh
dm9pZCBpdCBieSBsb2FkLWJhbGFuY2UgbW9yZSBhZ2dyZXNzaXZlbHksIG9yIGl0KHByaW9yaXR5
IGludmVyc2lvbikNCj4+IGNvdWxkIGJlIGlnbm9yZWQgaW4gc29tZSBzcGVjaWFsIGNhc2UuDQo+
PiANCj4+PiANCg0K
