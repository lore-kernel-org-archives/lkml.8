Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4EBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3500920838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="lV/y3ajF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgHNEER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:04:17 -0400
Received: from mail6.tencent.com ([220.249.245.26]:52255 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgHNEEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 00:04:16 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail6.tencent.com (Postfix) with ESMTP id AE5ABCC383;
        Fri, 14 Aug 2020 12:05:27 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597377927;
        bh=POMwCnmlFW1ypXxgfcCrOws6JgEaV+LFPwiYwHQDQEg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=lV/y3ajFvTrld2onRsXxqXZv2pwqnaxuG5+jsLbrcmXdie2E9vOW5+05Uz30xnTfz
         ZKp+y5a6ujVwlXTgcE8uB67TonlINUwzrk0n3G1fGiUusYibN3WnxZTrDqKcEaRxAj
         IQe5vv0rJAFaPYNLxvDMNoxkhPJ8M/BkAQ04Raxw=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 12:04:13 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 14 Aug
 2020 12:04:13 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Fri, 14 Aug 2020 12:04:10 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thomas Glexiner" <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Subhra Mazumdar" <subhra.mazumdar@oracle.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
Thread-Topic: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
Thread-Index: AQHWTyYIdUbfm2uvOEagav1FxQIttakluk8AgACOfACAAkvVAIAHH5EAgAPAXACAAWIeAIAAWUGAgAFOmgCAABOzAIAAKUkA
Date:   Fri, 14 Aug 2020 04:04:09 +0000
Message-ID: <18263ED7-88B3-4DED-9714-55D9D2EB69D9@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
 <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
 <20200812230850.GA3511387@google.com>
 <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
 <FAC73DE7-BAE0-42D3-BE9A-227C12275C34@tencent.com>
 <89d973d1-1302-17a6-c647-ea7c538c2747@linux.intel.com>
In-Reply-To: <89d973d1-1302-17a6-c647-ea7c538c2747@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.15]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0DB8D3AE476CA4482FF27A94208A7F2@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDE0LCAyMDIwLCBhdCA5OjM2IEFNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlA
bGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvOC8xNCA4OjI2LCBiZW5iamlh
bmco6JKL5b2qKSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXVnIDEzLCAyMDIwLCBhdCAxMjoy
OCBQTSwgTGksIEF1YnJleSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gMjAyMC84LzEzIDc6MDgsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+PiBPbiBX
ZWQsIEF1ZyAxMiwgMjAyMCBhdCAxMDowMToyNEFNICswODAwLCBMaSwgQXVicmV5IHdyb3RlOg0K
Pj4+Pj4gSGkgSm9lbCwNCj4+Pj4+IA0KPj4+Pj4gT24gMjAyMC84LzEwIDA6NDQsIEpvZWwgRmVy
bmFuZGVzIHdyb3RlOg0KPj4+Pj4+IEhpIEF1YnJleSwNCj4+Pj4+PiANCj4+Pj4+PiBBcG9sb2dp
ZXMgZm9yIHJlcGx5aW5nIGxhdGUgYXMgSSB3YXMgc3RpbGwgbG9va2luZyBpbnRvIHRoZSBkZXRh
aWxzLg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFdlZCwgQXVnIDA1LCAyMDIwIGF0IDExOjU3OjIwQU0g
KzA4MDAsIExpLCBBdWJyZXkgd3JvdGU6DQo+Pj4+Pj4gWy4uLl0NCj4+Pj4+Pj4gKy8qDQo+Pj4+
Pj4+ICsgKiBDb3JlIHNjaGVkdWxpbmcgcG9saWN5Og0KPj4+Pj4+PiArICogLSBDT1JFX1NDSEVE
X0RJU0FCTEVEOiBjb3JlIHNjaGVkdWxpbmcgaXMgZGlzYWJsZWQuDQo+Pj4+Pj4+ICsgKiAtIENP
UkVfQ09PS0lFX01BVENIOiB0YXNrcyB3aXRoIHNhbWUgY29va2llIGNhbiBydW4NCj4+Pj4+Pj4g
KyAqICAgICAgICAgICAgICAgICAgICAgb24gdGhlIHNhbWUgY29yZSBjb25jdXJyZW50bHkuDQo+
Pj4+Pj4+ICsgKiAtIENPUkVfQ09PS0lFX1RSVVNUOiB0cnVzdGVkIHRhc2sgY2FuIHJ1biB3aXRo
IGtlcm5lbA0KPj4+Pj4+PiAJCQl0aHJlYWQgb24gdGhlIHNhbWUgY29yZSBjb25jdXJyZW50bHku
IA0KPj4+Pj4+PiArICogLSBDT1JFX0NPT0tJRV9MT05FTFk6IHRhc2tzIHdpdGggY29va2llIGNh
biBydW4gb25seQ0KPj4+Pj4+PiArICogICAgICAgICAgICAgICAgICAgICB3aXRoIGlkbGUgdGhy
ZWFkIG9uIHRoZSBzYW1lIGNvcmUuDQo+Pj4+Pj4+ICsgKi8NCj4+Pj4+Pj4gK2VudW0gY29yZXNj
aGVkX3BvbGljeSB7DQo+Pj4+Pj4+ICsgICAgICAgQ09SRV9TQ0hFRF9ESVNBQkxFRCwNCj4+Pj4+
Pj4gKyAgICAgICBDT1JFX1NDSEVEX0NPT0tJRV9NQVRDSCwNCj4+Pj4+Pj4gKwlDT1JFX1NDSEVE
X0NPT0tJRV9UUlVTVCwNCj4+Pj4+Pj4gKyAgICAgICBDT1JFX1NDSEVEX0NPT0tJRV9MT05FTFks
DQo+Pj4+Pj4+ICt9Ow0KPj4+Pj4+PiANCj4+Pj4+Pj4gV2UgY2FuIHNldCBwb2xpY3kgdG8gQ09S
RV9DT09LSUVfVFJVU1Qgb2YgdXBlcmYgY2dyb3VwIGFuZCBmaXggdGhpcyBraW5kDQo+Pj4+Pj4+
IG9mIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24uIE5vdCBzdXJlIGlmIHRoaXMgc291bmRzIGF0dHJh
Y3RpdmU/DQo+Pj4+Pj4gDQo+Pj4+Pj4gSW5zdGVhZCBvZiB0aGlzLCBJIHRoaW5rIGl0IGNhbiBi
ZSBzb21ldGhpbmcgc2ltcGxlciBJTUhPOg0KPj4+Pj4+IA0KPj4+Pj4+IDEuIENvbnNpZGVyIGFs
bCBjb29raWUtMCB0YXNrIGFzIHRydXN0ZWQuIChFdmVuIHJpZ2h0IG5vdywgaWYgeW91IGFwcGx5
IHRoZQ0KPj4+Pj4+ICBjb3JlLXNjaGVkdWxpbmcgcGF0Y2hzZXQsIHN1Y2ggdGFza3Mgd2lsbCBz
aGFyZSBhIGNvcmUgYW5kIHNuaWZmIG9uIGVhY2gNCj4+Pj4+PiAgb3RoZXIuIFNvIGxldCB1cyBu
b3QgcHJldGVuZCB0aGF0IHN1Y2ggdGFza3MgYXJlIG5vdCB0cnVzdGVkKS4NCj4+Pj4+PiANCj4+
Pj4+PiAyLiBBbGwga2VybmVsIHRocmVhZHMgYW5kIGlkbGUgdGFzayB3b3VsZCBoYXZlIGEgY29v
a2llIDAgKHNvIHRoYXQgd2lsbCBjb3Zlcg0KPj4+Pj4+ICBrc29mdGlycWQgcmVwb3J0ZWQgaW4g
eW91ciBvcmlnaW5hbCBpc3N1ZSkuDQo+Pj4+Pj4gDQo+Pj4+Pj4gMy4gQWRkIGEgY29uZmlnIG9w
dGlvbiAoQ09ORklHX1NDSEVEX0NPUkVfREVGQVVMVF9UQVNLU19VTlRSVVNURUQpLiBEZWZhdWx0
DQo+Pj4+Pj4gIGVuYWJsZSBpdC4gU2V0dGluZyB0aGlzIG9wdGlvbiB3b3VsZCB0YWcgYWxsIHRh
c2tzIHRoYXQgYXJlIGZvcmtlZCBmcm9tIGENCj4+Pj4+PiAgY29va2llLTAgdGFzayB3aXRoIHRo
ZWlyIG93biBjb29raWUuIExhdGVyIG9uLCBzdWNoIHRhc2tzIGNhbiBiZSBhZGRlZCB0bw0KPj4+
Pj4+ICBhIGdyb3VwLiBUaGlzIGNvdmVyJ3MgUGV0ZXJaJ3MgYXNrIGFib3V0IGhhdmluZyAnZGVm
YXVsdCB1bnRydXN0ZWQnKS4NCj4+Pj4+PiAgKFVzZXJzIGxpa2UgQ2hyb21lT1MgdGhhdCBkb24n
dCB3YW50IHRvIHVzZXJzcGFjZSBzeXN0ZW0gcHJvY2Vzc2VzIHRvIGJlDQo+Pj4+Pj4gIHRhZ2dl
ZCBjYW4gZGlzYWJsZSB0aGlzIG9wdGlvbiBzbyBzdWNoIHRhc2tzIHdpbGwgYmUgY29va2llLTAp
Lg0KPj4+Pj4+IA0KPj4+Pj4+IDQuIEFsbG93IHByY3RsL2Nncm91cCBpbnRlcmZhY2VzIHRvIGNy
ZWF0ZSBncm91cHMgb2YgdGFza3MgYW5kIG92ZXJyaWRlIHRoZQ0KPj4+Pj4+ICBhYm92ZSBiZWhh
dmlvcnMuDQo+Pj4+PiANCj4+Pj4+IEhvdyBkb2VzIHVwZXJmIGluIGEgY2dyb3VwIHdvcmsgd2l0
aCBrc29mdGlycWQ/IEFyZSB5b3Ugc3VnZ2VzdGluZyBJIHNldCB1cGVyZidzDQo+Pj4+PiBjb29r
aWUgdG8gYmUgY29va2llLTAgdmlhIHByY3RsPw0KPj4+PiANCj4+Pj4gWWVzLCBidXQgbGV0IG1l
IHRyeSB0byB1bmRlcnN0YW5kIGJldHRlci4gVGhlcmUgYXJlIDIgcHJvYmxlbXMgaGVyZSBJIHRo
aW5rOg0KPj4+PiANCj4+Pj4gMS4ga3NvZnRpcnFkIGdldHRpbmcgaWRsZWQgd2hlbiBIVCBpcyB0
dXJuZWQgb24sIGJlY2F1c2UgdXBlcmYgaXMgc2hhcmluZyBhDQo+Pj4+IGNvcmUgd2l0aCBpdDog
VGhpcyBzaG91bGQgbm90IGJlIGFueSB3b3JzZSB0aGFuIFNNVCBPRkYsIGJlY2F1c2UgZXZlbiBT
TVQgT0ZGDQo+Pj4+IHdvdWxkIGFsc28gcmVkdWNlIGtzb2Z0aXJxZCdzIENQVSB0aW1lIGp1c3Qg
Y29yZSBzY2hlZCBpcyBkb2luZy4gU3VyZQ0KPj4+PiBjb3JlLXNjaGVkdWxpbmcgYWRkcyBzb21l
IG92ZXJoZWFkIHdpdGggSVBJcyBidXQgc3VjaCBhIGh1Z2UgZHJvcCBvZiBwZXJmIGlzDQo+Pj4+
IHN0cmFuZ2UuIFBldGVyIGFueSB0aG91Z2h0cyBvbiB0aGF0Pw0KPj4+PiANCj4+Pj4gMi4gSW50
ZXJmYWNlOiBUbyBzb2x2ZSB0aGUgcGVyZm9ybWFuY2UgcHJvYmxlbSwgeW91IGFyZSBzYXlpbmcg
eW91IHdhbnQgdXBlcmYNCj4+Pj4gdG8gc2hhcmUgYSBjb3JlIHdpdGgga3NvZnRpcnFkIHNvIHRo
YXQgaXQgaXMgbm90IGZvcmNlZCBpbnRvIGlkbGUuICBXaHkgbm90DQo+Pj4+IGp1c3Qga2VlcCB1
cGVyZiBvdXQgb2YgdGhlIGNncm91cD8NCj4+PiANCj4+PiBJIGd1ZXNzIHRoaXMgaXMgdW5hY2Nl
cHRhYmxlIGZvciB3aG8gcnVucyB0aGVpciBhcHBzIGluIGNvbnRhaW5lciBhbmQgdm0uDQo+PiBJ
TUhPLCAganVzdCBhcyBKb2VsIHByb3Bvc2VkLCANCj4+IDEuIENvbnNpZGVyIGFsbCBjb29raWUt
MCB0YXNrIGFzIHRydXN0ZWQuDQo+PiAyLiBBbGwga2VybmVsIHRocmVhZHMgYW5kIGlkbGUgdGFz
ayB3b3VsZCBoYXZlIGEgY29va2llIDAgDQo+PiBJbiB0aGF0IHdheSwgYWxsIHRhc2tzIHdpdGgg
Y29va2llcyhpbmNsdWRpbmcgdXBlcmYgaW4gYSBjZ3JvdXApIGNvdWxkIHJ1bg0KPj4gY29uY3Vy
cmVudGx5IHdpdGgga2VybmVsIHRocmVhZHMuDQo+PiBUaGF0IGNvdWxkIGJlIGEgZ29vZCBzb2x1
dGlvbiBmb3IgdGhlIGlzc3VlLiA6KQ0KPiANCj4gRnJvbSB1cGVyZiBwb2ludCBvZiByZXZpZXcs
IGl0IGNhbiB0cnVzdCBjb29raWUtMChJIGFzc3VtZSB3ZSBzdGlsbCBuZWVkDQo+IHNvbWUgbW9k
aWZpY2F0aW9ucyB0byBjaGFuZ2UgY29va2llLW1hdGNoIHRvIGNvb2tpZS1jb21wYXRpYmxlIHRv
IGFsbG93DQo+IFpFUk8gYW5kIE5PTlpFUk8gcnVuIHRvZ2V0aGVyKS4NCj4gDQo+IEJ1dCBmcm9t
IGtlcm5lbCB0aHJlYWQgcG9pbnQgb2YgcmV2aWV3LCBpdCBjYW4gTk9UIHRydXN0IHVwZXJmLCB1
bmxlc3MNCj4gd2Ugc2V0IHVwZXJmJ3MgY29va2llIHRvIDAuDQpUaGF04oCZcyByaWdodC4gOikN
CkNvdWxkIHdlIHNldCB0aGUgY29va2llIG9mIGNncm91cCB3aGVyZSB1cGVyZiBsaWVzIHRvIDA/
DQoNClRoeC4NClJlZ2FyZHMsDQpKaWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+IC1BdWJyZXkNCj4g
DQoNCg==
