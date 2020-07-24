Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96204C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6176220714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="RWR1lp4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGXB0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:26:30 -0400
Received: from mail6.tencent.com ([220.249.245.26]:47531 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgGXB02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:26:28 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail6.tencent.com (Postfix) with ESMTP id 64142CC392;
        Fri, 24 Jul 2020 09:27:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595554053;
        bh=HqaGB3n6pZC7G7BFX/FQgqUmVP0qra9Aryl7K6t4znc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=RWR1lp4Hbsvw82T5IgyWuvI0jbnTIgvXGwQr9Sd6V0zTjJjovlqVwUS587k5F9rAC
         cH/3OwrL3IC86OgYBsWbh4c0UGQdd6CRWMvjZevSZOnD4fipU9KZddUU540ZReBT4O
         pK5kC9ZNF26Cah2JzRLMXBBlM1HJ/KHRF+0/paso=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 24 Jul
 2020 09:26:24 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 24 Jul
 2020 09:26:24 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Fri, 24 Jul 2020 09:26:24 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
CC:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
Thread-Topic: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AIAAv1UAgAAMuwCAAA7NAIAADWQAgAAVDACAACO4AIAABZIAgAAF6gCAAP+1gIAAHMmA
Date:   Fri, 24 Jul 2020 01:26:24 +0000
Message-ID: <F6F57D2C-90B2-49E5-8684-3F300A15B605@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
 <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
 <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
 <5C71B460-8DC3-44AF-A75E-68BB2E33686B@tencent.com>
 <589382b3-709e-17a6-d693-05ebd3998336@linux.intel.com>
 <897E5117-8A78-4CE3-8514-3577C4474775@tencent.com>
 <6ab8a001-ae5e-e484-c571-90d6931004e7@linux.intel.com>
 <96A765D7-7FD3-40EB-873B-0F9365569490@tencent.com>
 <a4533d7f-41b0-3477-0316-0e2df55cbe9c@linux.intel.com>
 <325B98A4-9135-4138-AFED-ADFC3560D917@tencent.com>
 <36cce58e-03b3-4d77-dfc5-e3c49f3ecdd8@linux.intel.com>
 <A73E4BD3-D742-40E1-9928-B45BC68D1B89@tencent.com>
 <CAERHkrseWGsQ7Vw1Sb4A+PB6XFeeuTj4d1nH70kadRFRXLQLsg@mail.gmail.com>
In-Reply-To: <CAERHkrseWGsQ7Vw1Sb4A+PB6XFeeuTj4d1nH70kadRFRXLQLsg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.198]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB0D7BC493C42429368BF888B685620@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDI0LCAyMDIwLCBhdCA3OjQzIEFNLCBBdWJyZXkgTGkgPGF1YnJleS5p
bnRlbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMjMsIDIwMjAgYXQgNDoy
OCBQTSBiZW5iamlhbmco6JKL5b2qKSA8YmVuYmppYW5nQHRlbmNlbnQuY29tPiB3cm90ZToNCj4+
IA0KPj4gSGksDQo+PiANCj4+PiBPbiBKdWwgMjMsIDIwMjAsIGF0IDQ6MDYgUE0sIExpLCBBdWJy
ZXkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDIwMjAv
Ny8yMyAxNTo0NywgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+IEhpLA0KPj4+PiANCj4+
Pj4+IE9uIEp1bCAyMywgMjAyMCwgYXQgMTozOSBQTSwgTGksIEF1YnJleSA8YXVicmV5LmxpQGxp
bnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIDIwMjAvNy8yMyAxMjoyMywg
YmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4gSGksDQo+Pj4+Pj4+IE9uIEp1bCAyMywg
MjAyMCwgYXQgMTE6MzUgQU0sIExpLCBBdWJyZXkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20+
IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gMjAyMC83LzIzIDEwOjQyLCBiZW5iamlhbmco
6JKL5b2qKSB3cm90ZToNCj4+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gSnVs
IDIzLCAyMDIwLCBhdCA5OjU3IEFNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlAbGludXguaW50ZWwu
Y29tPiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiAyMDIwLzcvMjIgMjI6MzIsIGJl
bmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+Pj4+PiBIaSwNCj4+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4+PiBPbiBKdWwgMjIsIDIwMjAsIGF0IDg6MTMgUE0sIExpLCBBdWJyZXkgPGF1YnJleS5s
aUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBPbiAy
MDIwLzcvMjIgMTY6NTQsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+IEhp
LCBBdWJyZXksDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IE9uIEp1bCAxLCAyMDIwLCBh
dCA1OjMyIEFNLCBWaW5lZXRoIFJlbWFuYW4gUGlsbGFpIDx2cGlsbGFpQGRpZ2l0YWxvY2Vhbi5j
b20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gRnJvbTogQXVicmV5IExp
IDxhdWJyZXkubGlAaW50ZWwuY29tPg0KPj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gLSBE
b24ndCBtaWdyYXRlIGlmIHRoZXJlIGlzIGEgY29va2llIG1pc21hdGNoDQo+Pj4+Pj4+Pj4+Pj4+
IExvYWQgYmFsYW5jZSB0cmllcyB0byBtb3ZlIHRhc2sgZnJvbSBidXNpZXN0IENQVSB0byB0aGUN
Cj4+Pj4+Pj4+Pj4+Pj4gZGVzdGluYXRpb24gQ1BVLiBXaGVuIGNvcmUgc2NoZWR1bGluZyBpcyBl
bmFibGVkLCBpZiB0aGUNCj4+Pj4+Pj4+Pj4+Pj4gdGFzaydzIGNvb2tpZSBkb2VzIG5vdCBtYXRj
aCB3aXRoIHRoZSBkZXN0aW5hdGlvbiBDUFUncw0KPj4+Pj4+Pj4+Pj4+PiBjb3JlIGNvb2tpZSwg
dGhpcyB0YXNrIHdpbGwgYmUgc2tpcHBlZCBieSB0aGlzIENQVS4gVGhpcw0KPj4+Pj4+Pj4+Pj4+
PiBtaXRpZ2F0ZXMgdGhlIGZvcmNlZCBpZGxlIHRpbWUgb24gdGhlIGRlc3RpbmF0aW9uIENQVS4N
Cj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+IC0gU2VsZWN0IGNvb2tpZSBtYXRjaGVkIGlk
bGUgQ1BVDQo+Pj4+Pj4+Pj4+Pj4+IEluIHRoZSBmYXN0IHBhdGggb2YgdGFzayB3YWtldXAsIHNl
bGVjdCB0aGUgZmlyc3QgY29va2llIG1hdGNoZWQNCj4+Pj4+Pj4+Pj4+Pj4gaWRsZSBDUFUgaW5z
dGVhZCBvZiB0aGUgZmlyc3QgaWRsZSBDUFUuDQo+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+
PiAtIEZpbmQgY29va2llIG1hdGNoZWQgaWRsZXN0IENQVQ0KPj4+Pj4+Pj4+Pj4+PiBJbiB0aGUg
c2xvdyBwYXRoIG9mIHRhc2sgd2FrZXVwLCBmaW5kIHRoZSBpZGxlc3QgQ1BVIHdob3NlIGNvcmUN
Cj4+Pj4+Pj4+Pj4+Pj4gY29va2llIG1hdGNoZXMgd2l0aCB0YXNrJ3MgY29va2llDQo+Pj4+Pj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+PiAtIERvbid0IG1pZ3JhdGUgdGFzayBpZiBjb29raWUgbm90
IG1hdGNoDQo+Pj4+Pj4+Pj4+Pj4+IEZvciB0aGUgTlVNQSBsb2FkIGJhbGFuY2UsIGRvbid0IG1p
Z3JhdGUgdGFzayB0byB0aGUgQ1BVIHdob3NlDQo+Pj4+Pj4+Pj4+Pj4+IGNvcmUgY29va2llIGRv
ZXMgbm90IG1hdGNoIHdpdGggdGFzaydzIGNvb2tpZQ0KPj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQXVicmV5IExpIDxhdWJyZXkubGlAbGludXguaW50ZWwuY29t
Pg0KPj4+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51
eC5pbnRlbC5jb20+DQo+Pj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZpbmVldGggUmVtYW5h
biBQaWxsYWkgPHZwaWxsYWlAZGlnaXRhbG9jZWFuLmNvbT4NCj4+Pj4+Pj4+Pj4+Pj4gLS0tDQo+
Pj4+Pj4+Pj4+Pj4+IGtlcm5lbC9zY2hlZC9mYWlyLmMgIHwgNjQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+Pj4+Pj4+Pj4+Pj4ga2VybmVsL3NjaGVkL3Nj
aGVkLmggfCAyOSArKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+Pj4+Pj4+PiAyIGZpbGVzIGNo
YW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9z
Y2hlZC9mYWlyLmMNCj4+Pj4+Pj4+Pj4+Pj4gaW5kZXggZDE2OTM5NzY2MzYxLi4zM2RjNGJmMDE4
MTcgMTAwNjQ0DQo+Pj4+Pj4+Pj4+Pj4+IC0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+Pj4+
Pj4+Pj4+Pj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+Pj4+Pj4+Pj4+PiBAQCAtMjA1
MSw2ICsyMDUxLDE1IEBAIHN0YXRpYyB2b2lkIHRhc2tfbnVtYV9maW5kX2NwdShzdHJ1Y3QgdGFz
a19udW1hX2VudiAqZW52LA0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgIGlmICghY3B1bWFza190
ZXN0X2NwdShjcHUsIGVudi0+cC0+Y3B1c19wdHIpKQ0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgY29udGludWU7DQo+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+PiArI2lmZGVm
IENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgIC8qDQo+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgICAgICAqIFNraXAgdGhpcyBjcHUgaWYgc291cmNlIHRhc2sncyBjb29r
aWUgZG9lcyBub3QgbWF0Y2gNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICogd2l0aCBDUFUn
cyBjb3JlIGNvb2tpZS4NCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICovDQo+Pj4+Pj4+Pj4+
Pj4+ICsgICAgICAgICAgIGlmICghc2NoZWRfY29yZV9jb29raWVfbWF0Y2goY3B1X3JxKGNwdSks
IGVudi0+cCkpDQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+
Pj4+Pj4+Pj4+Pj4+ICsjZW5kaWYNCj4+Pj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4+PiAgICAg
ICAgICAgIGVudi0+ZHN0X2NwdSA9IGNwdTsNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICBpZiAo
dGFza19udW1hX2NvbXBhcmUoZW52LCB0YXNraW1wLCBncm91cGltcCwgbWF5bW92ZSkpDQo+Pj4+
Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4+Pj4+Pj4+Pj4gQEAgLTU5
NjMsMTEgKzU5NzIsMTcgQEAgZmluZF9pZGxlc3RfZ3JvdXBfY3B1KHN0cnVjdCBzY2hlZF9ncm91
cCAqZ3JvdXAsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IHRoaXMNCj4+Pj4+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4+Pj4+ICAgIC8qIFRyYXZlcnNlIG9ubHkgdGhlIGFsbG93ZWQgQ1BVcyAqLw0K
Pj4+Pj4+Pj4+Pj4+PiAgICBmb3JfZWFjaF9jcHVfYW5kKGksIHNjaGVkX2dyb3VwX3NwYW4oZ3Jv
dXApLCBwLT5jcHVzX3B0cikgew0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICBzdHJ1Y3QgcnEg
KnJxID0gY3B1X3JxKGkpOw0KPj4+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+Pj4+ICsjaWZkZWYg
Q09ORklHX1NDSEVEX0NPUkUNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgaWYgKCFzY2hlZF9j
b3JlX2Nvb2tpZV9tYXRjaChycSwgcCkpDQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+Pj4+Pj4+Pj4+Pj4+ICsjZW5kaWYNCj4+Pj4+Pj4+Pj4+Pj4gKw0KPj4+
Pj4+Pj4+Pj4+PiAgICAgICAgICAgIGlmIChzY2hlZF9pZGxlX2NwdShpKSkNCj4+Pj4+Pj4+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgIHJldHVybiBpOw0KPj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+
Pj4+Pj4gICAgICAgICAgICBpZiAoYXZhaWxhYmxlX2lkbGVfY3B1KGkpKSB7DQo+Pj4+Pj4+Pj4+
Pj4+IC0gICAgICAgICAgICAgICAgICAgc3RydWN0IHJxICpycSA9IGNwdV9ycShpKTsNCj4+Pj4+
Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjcHVpZGxlX3N0YXRlICppZGxlID0g
aWRsZV9nZXRfc3RhdGUocnEpOw0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgaWYg
KGlkbGUgJiYgaWRsZS0+ZXhpdF9sYXRlbmN5IDwgbWluX2V4aXRfbGF0ZW5jeSkgew0KPj4+Pj4+
Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKg0KPj4+Pj4+Pj4+Pj4+PiBAQCAt
NjIyNCw4ICs2MjM5LDE4IEBAIHN0YXRpYyBpbnQgc2VsZWN0X2lkbGVfY3B1KHN0cnVjdCB0YXNr
X3N0cnVjdCAqcCwgc3RydWN0IHNjaGVkX2RvbWFpbiAqc2QsIGludCB0DQo+Pj4+Pj4+Pj4+Pj4+
ICAgIGZvcl9lYWNoX2NwdV93cmFwKGNwdSwgY3B1cywgdGFyZ2V0KSB7DQo+Pj4+Pj4+Pj4+Pj4+
ICAgICAgICAgICAgaWYgKCEtLW5yKQ0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC0xOw0KPj4+Pj4+Pj4+Pj4+PiAtICAgICAgICAgICBpZiAoYXZhaWxhYmxlX2lkbGVf
Y3B1KGNwdSkgfHwgc2NoZWRfaWRsZV9jcHUoY3B1KSkNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4+Pj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAg
ICAgICBpZiAoYXZhaWxhYmxlX2lkbGVfY3B1KGNwdSkgfHwgc2NoZWRfaWRsZV9jcHUoY3B1KSkg
ew0KPj4+Pj4+Pj4+Pj4+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+Pj4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgLyoNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgKiBJZiBDb3JlIFNjaGVkdWxpbmcgaXMgZW5hYmxlZCwgc2VsZWN0IHRoaXMgY3B1DQo+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICogb25seSBpZiB0aGUgcHJvY2VzcyBjb29r
aWUgbWF0Y2hlcyBjb3JlIGNvb2tpZS4NCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgKi8NCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICBpZiAoc2NoZWRfY29yZV9l
bmFibGVkKGNwdV9ycShjcHUpKSAmJg0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICBwLT5jb3JlX2Nvb2tpZSA9PSBjcHVfcnEoY3B1KS0+Y29yZS0+Y29yZV9jb29raWUpDQo+
Pj4+Pj4+Pj4+Pj4gV2h5IG5vdCBhbHNvIGFkZCBzaW1pbGFyIGxvZ2ljIGluIHNlbGVjdF9pZGxl
X3NtdCB0byByZWR1Y2UgZm9yY2VkLWlkbGU/IDopDQo+Pj4+Pj4+Pj4+PiBXZSBoaXQgc2VsZWN0
X2lkbGVfc210IGFmdGVyIHdlIHNjYW5lZCB0aGUgZW50aXJlIExMQyBkb21haW4gZm9yIGlkbGUg
Y29yZXMNCj4+Pj4+Pj4+Pj4+IGFuZCBpZGxlIGNwdXMgYW5kIGZhaWxlZCxzbyBJTUhPLCBhbiBp
ZGxlIHNtdCBpcyBwcm9iYWJseSBhIGdvb2QgY2hvaWNlIHVuZGVyDQo+Pj4+Pj4+Pj4+PiB0aGlz
IHNjZW5hcmlvLg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gQUZBSUMsIHNlbGVjdGluZyBpZGxl
IHNpYmxpbmcgd2l0aCB1bm1hdGNoZWQgY29va2llIHdpbGwgY2F1c2UgdW5uZWNlc3NhcnkgZm9y
ZWQtaWRsZSwgdW5mYWlybmVzcyBhbmQgbGF0ZW5jeSwgY29tcGFyZWQgdG8gY2hvb3NpbmcgKnRh
cmdldCogY3B1Lg0KPj4+Pj4+Pj4+IENob29zaW5nIHRhcmdldCBjcHUgY291bGQgaW5jcmVhc2Ug
dGhlIHJ1bm5hYmxlIHRhc2sgbnVtYmVyIG9uIHRoZSB0YXJnZXQgcnVucXVldWUsIHRoaXMNCj4+
Pj4+Pj4+PiBjb3VsZCB0cmlnZ2VyIGJ1c2llc3QtPm5yX3J1bm5pbmcgPiAxIGxvZ2ljIGFuZCBt
YWtlcyB0aGUgaWRsZSBzaWJsaW5nIHRyeWluZyB0byBwdWxsIGJ1dA0KPj4+Pj4+Pj4+IG5vdCBz
dWNjZXNzKGR1ZSB0byBjb29raWUgbm90IG1hdGNoKS4gUHV0dGluZyB0YXNrIHRvIHRoZSBpZGxl
IHNpYmxpbmcgaXMgcmVsYXRpdmVseSBzdGFibGUgSU1ITy4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4g
SeKAmW0gYWZyYWlkIHRoYXQgKnVuc3VjY2Vzc2Z1bCogcHVsbGluZ3MgYmV0d2VlbiBzbXRzIHdv
dWxkIG5vdCByZXN1bHQgaW4gdW5zdGFibGVuZXNzLCBiZWNhdXNlDQo+Pj4+Pj4+PiB0aGUgbG9h
ZC1iYWxhbmNlIGFsd2F5cyBkbyBwZXJpb2RpY2x5ICwgYW5kIHVuc3VjY2VzcyBtZWFucyBub3Ro
aW5nIGhhcHBlbi4NCj4+Pj4+Pj4gdW5zdWNjZXNzIHB1bGxpbmcgbWVhbnMgbW9yZSB1bm5lY2Vz
c2FyeSBvdmVyaGVhZCBpbiBsb2FkIGJhbGFuY2UuDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gdGhl
IGNvbnRyYXJ5LCB1bm1hdGNoZWQgc2libGluZyB0YXNrcyBydW5uaW5nIGNvbmN1cnJlbnRseSBj
b3VsZCBicmluZyBmb3JjZWQtaWRsZSB0byBlYWNoIG90aGVyIHJlcGVhdGVkbHksDQo+Pj4+Pj4+
PiBXaGljaCBpcyBtb3JlIHVuc3RhYmxlLCBhbmQgbW9yZSBjb3N0bHkgd2hlbiBwaWNrX25leHRf
dGFzayBmb3IgYWxsIHNpYmxpbmdzLg0KPj4+Pj4+PiBOb3Qgd29yc2UgdGhhbiB0d28gdGFza3Mg
cGluZy1wb25nIG9uIHRoZSBzYW1lIHRhcmdldCBydW4gcXVldWUgSSBndWVzcywgYW5kIGJldHRl
ciBpZg0KPj4+Pj4+PiAtIHRhc2sxKGNvb2tpZSBBKSBpcyBydW5uaW5nIG9uIHRoZSB0YXJnZXQs
IGFuZCB0YXNrMihjb29raWUgQikgaW4gdGhlIHJ1bnF1ZXVlLA0KPj4+Pj4+PiAtIHRhc2szKGNv
b2tpZSBCKSBjb21pbmcNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IElmIHRhc2szIGNob29zZXMgdGFyZ2V0
J3Mgc2libGluZywgaXQgY291bGQgaGF2ZSBhIGNoYW5jZSB0byBydW4gY29uY3VycmVudGx5IHdp
dGggdGFzazIuDQo+Pj4+Pj4+IEJ1dCBpZiB0YXNrMyBjaG9vc2VzIHRhcmdldCwgaXQgd2lsbCB3
YWl0IGZvciBuZXh0IHB1bGxpbmcgbHVjayBvZiBsb2FkIGJhbGFuY2VyDQo+Pj4+Pj4gVGhhdOKA
mXMgbW9yZSBpbnRlcmVzdGluZy4gOikNCj4+Pj4+PiBEaXN0cmlidXRpbmcgZGlmZmVyZW50IGNv
b2tpZSB0YXNrcyBvbnRvIGRpZmZlcmVudCBjcHVzKG9yIGNwdXNldHMpIGNvdWxkIGJlIHRoZSAq
aWRlYWwgc3RhYmxlIHN0YXR1cyogd2Ugd2FudCwgYXMgSSB1bmRlcnN0b29kLg0KPj4+Pj4+IERp
ZmZlcmVudCBjb29raWUgdGFza3MgcnVubmluZyBvbiBzaWJsaW5nIHNtdHMgY291bGQgaHVydCBw
ZXJmb3JtYW5jZSwgYW5kIHRoYXQgc2hvdWxkIGJlIGF2b2lkZWQgd2l0aCBiZXN0IGVmZm9ydC4N
Cj4+Pj4+IFdlIGFscmVhZHkgdHJpZWQgdG8gYXZvaWQgd2hlbiB3ZSBzY2FuIGlkbGUgY29yZXMg
YW5kIGlkbGUgY3B1cyBpbiBsbGMgZG9tYWluLg0KPj4+PiANCj4+Pj4gSeKAmW0gYWZyYWlkIHRo
YXTigJlzIG5vdCBlbm91Z2ggZWl0aGVyLCA6KQ0KPj4+PiAxLiBTY2FubmluZyBJZGxlIGNwdXMg
aXMgbm90IGEgZnVsbCBzY2FuLCB0aGVyZSBpcyBsaW1pdCBhY2NvcmRpbmcgdG8gc2NhbiBjb3N0
Lg0KPj4+PiAyLiBUaGF0J3Mgb25seSB0cnlpbmcgYXQgdGhlICpjb3JlL2NwdSogbGV2ZWwsICpT
TVQqIGxldmVsIHNob3VsZCBiZSBjb25zaWRlcmVkIHRvby4NCj4+Pj4gDQo+Pj4+PiANCj4+Pj4+
PiBGb3IgYWJvdmUgY2FzZSwgc2VsZWN0aW5nIGlkbGUgc2libGluZyBjcHUgY2FuIGltcHJvdmUg
dGhlIGNvbmN1cnJlbmN5IGluZGVlZCwgYnV0IGl0IGRlY3JlYXNlIHRoZSBpbWJhbGFuY2UgZm9y
IGxvYWQtYmFsYW5jZXIuDQo+Pj4+Pj4gSW4gdGhhdCBjYXNlLCBsb2FkLWJhbGFuY2VyIGNvdWxk
IG5vdCBub3RpY2UgdGhlIGltYmFsYW5jZSwgYW5kIHdvdWxkIGRvIG5vdGhpbmcgdG8gaW1wcm92
ZSB0aGUgdW5tYXRjaGVkIHNpdHVhdGlvbi4NCj4+Pj4+PiBPbiB0aGUgY29udHJhcnksIGNob29z
aW5nIHRoZSAqdGFyZ2V0KiBjcHUgY291bGQgZW5oYW5jZSB0aGUgaW1iYWxhbmNlLCBhbmQgbG9h
ZC1iYWxhbmNlciBjb3VsZCB0cnkgdG8gcHVsbCB1bm1hdGNoZWQgdGFzayBhd2F5LA0KPj4+Pj4g
UHVsbGluZyBhd2F5IHRvIHdoZXJlIG5lZWRzIGFub3RoZXIgYnVuY2ggb2YgZWxhYm9yYXRpb24u
DQo+Pj4+IA0KPj4+PiBTdGlsbCB3aXRoIHRoZSBTTVQyKzN0YXNrcyBjYXNlLA0KPj4+PiBpZiAq
aWRsZSBzaWJsaW5nKiBjaG9zZW4sDQo+Pj4+IFNtdDHigJlzIGxvYWQgPSB0YXNrMSt0YXNrMiwg
c210MuKAmXMgbG9hZCA9IHRhc2szLiBUYXNrMyB3aWxsIHJ1biBpbnRlcm1pdHRlbnRseSBiZWNh
dXNlIG9mIGZvcmNlZC1pZGxlLA0KPj4+PiBzbyBzbXQy4oCZcyByZWFsIGxvYWQgY291bGQgbG93
IGVub3VnaCwgdGhhdCBpdCBjb3VsZCBub3QgYmUgcHVsbGVkIGF3YXkgZm9yZXZlci4gVGhhdOKA
mXMgaW5kZWVkIGEgc3RhYmxlIHN0YXRlLA0KPj4+PiBidXQgd2l0aCBwZXJmb3JtYW5jZSBhdCBh
IGRpc2NvdW50Lg0KPj4+PiANCj4+Pj4gSWYgKnRhcmdldCBzaWJsaW5nKiBjaG9zZSwNCj4+Pj4g
U210MeKAmXMgbG9hZCA9IHRhc2sxK3Rhc2syK3Rhc2szLCBzbXQy4oCZcyBsb2FkPTAuIEl04oCZ
cyBhIG9idmlvdXMgaW1iYWxhbmNlLCBhbmQgbG9hZC1iYWxhbmNlciB3aWxsIHBpY2sgYSB0YXNr
IHRvIHB1bGwsDQo+Pj4+IDEuIElmIHRhc2sxKGNvb2tpZSBBKSBwaWNrZWQsIHRoYXTigJlzIGRv
bmUgZm9yIGdvb2QuDQo+Pj4+IDIuIElmIHRhc2syKGNvb2tpZSBCKSBvciB0YXNrMyhjb29raWUg
QikgcGlja2VkLCB0aGF04oCZcyBvayB0b28sIHRoZSByZXN0IHRhc2soY29va2llIEIpIGNvdWxk
IGJlIHB1bGxlZCBhd2F5IGF0IG5leHQgYmFsYW5jZShtYXliZSBuZWVkIHRvIGltcHJvdmUgdGhl
IHB1bGxpbmcgdG8gdGVuZCB0byBwdWxsIG1hdGNoZWQgdGFzayBtb3JlIGFnZ3Jlc3NpdmVseSku
DQo+Pj4+IEFuZCB0aGVuLCB3ZSBtYXkgcmVhY2ggYSBtb3JlIHN0YWJsZSBzdGF0ZSAqZ2xvYmFs
bHkqIHdpdGhvdXQgcGVyZm9ybWFuY2UgZGlzY291bnQuDQo+Pj4gDQo+Pj4gSSdtIG5vdCBzdXJl
IHdoYXQgeW91IG1lYW4gcHVsbGVkIGF3YXksDQo+PiBJIG1lYW4gcHVsbGVkIGF3YXkgYnkgb3Ro
ZXIgY3B1cywgbWF5IGJlIHRyaWdnZXJlZCBieSBpZGxlIGJhbGFuY2Ugb3IgcGVyaW9kaWMgYmFs
YW5jZSBvbiBvdGhlciBjcHVzLg0KPj4gDQo+Pj4gLSBpZiB5b3UgbWVhbiBwdWxsZWQgYXdheSBm
cm9tIHRoaXMgY29yZSwgY29va2llQSBpbiBpZGxlIHNpYmxpbmcgY2FzZSBjYW4gYmUNCj4+PiBw
dWxsZWQgYXdheSB0b28uDQo+PiBZZXAsIGNvb2tpZUEodGFzazEpIGluIGlkbGUgc2libGluZyBj
YXNlIGNvdWxkIGJlIHB1bGxlZCBhd2F5LCBidXQNCj4+IGNvb2tpZUIodGFzazMpIG9uIHRoZSBz
bXQyIGNvdWxkIG5ldmVyIGdldCB0aGUgY2hhbmNlIGJlaW5nIHB1bGxlZA0KPj4gYXdheSh1bmxl
c3MgYmVpbmcgd2FrZW4gdXApLg0KPj4gSWYgY29va2llQSh0YXNrMSkgZmFpbGVkIGJlaW5nIHB1
bGxlZChjb29raWVCKHRhc2syKSBvbiBzbXQxIG1heSBiZSBwdWxsZWQsDQo+PiA1MCUgY2hhbmNl
KSwgY29va2llQSh0YXNrMSkgYW5kIGNvb2tpZUIodGFzazMpIHdvdWxkIHJlYWNoIHRoZSBzdGFi
bGUgc3RhdGUNCj4+IHdpdGggcGVyZm9ybWFuY2UgZGlzY291bnQuDQo+PiANCj4gSWYgeW91IG1l
YW50IHB1bGxlZCBhd2F5IGZyb20gdGhpcyBjb3JlLCBJIGRpZG4ndCBzZWUgaG93IHR3byBjYXNl
cyBhcmUNCj4gZGlmZmVyZW50IGVpdGhlci4gRm9yIGV4YW1wbGUsIHdoZW4gdGFzazIoY29va2ll
QikgcnVucyBvbiBTTVQxLCB0YXNrMw0KPiBjb29raWViIGNhbiBiZSBwdWxsZWQgdG8gU01UMi4g
YW5kIHdoZW4gdGFzazEoY29va2llQSkgc3dpdGNoIG9udG8gU01UMSwNCj4gdGFzazIoY29va2ll
QikgY2FuIGJlIHB1bGxlZCBhd2F5IGJ5IG90aGVyIGNwdXMsIHRvby4NClRoYXTigJlzIHRoZSBj
YXNlIG9ubHkgaWYgU01UMuKAmXMgcHVsbGluZyBoYXBwZW5zIHdoZW4gdGFzazIoY29va2llQikg
aXMgcnVubmluZw0Kb24gU01UMSwgd2hpY2ggZGVwZW5kcyBvbiwNCjEuIFNtdDIgbm90IGVudGVy
aW5nIHRpY2tsZXNzIG9yIG5vaHpfYmFsYW5jZXJfa2ljayBwaWNrcyBzbXQyIGJlZm9yZSBvdGhl
cg0KY3B14oCZcyBwdWxsaW5nLCBtYXkgYmUgdW5saWtlbHkuIDopDQoyLiBUYXNrMShjb29raWVB
KSBpcyBub3QgcnVubmluZyBvbiBTTVQxLg0Kb3RoZXJ3aXNlIGl0IHdvdWxkIGJlIHRoZSBjYXNl
IEkgZGVzY3JpYmVkIGFib3ZlLiAgDQoNCkJlc2lkZXMsIGZvciBvdGhlciBjYXNlcywgbGlrZSBz
bXQyKzJ0YXNrKENvb2tpZUErQ29va2llQiksIHBpY2tpbmcgKnRhcmdldCoNCmNwdSBpbnN0ZWFk
IG9mICppZGxlIHNpYmxpbmcqIGNvdWxkIGJlIG1vcmUgaGVscGZ1bCB0byByZWFjaCB0aGUgZ2xv
YmFsIHN0YWJsZQ0Kc3RhdHVzKGRpc3RyaWJ1dGUgZGlmZmVyZW50IGNvb2tpZXMgb250byBkaWZm
ZXJlbnQgY29yZXMpLiANCg0KVGh4Lg0KUmVnYXJkLA0KSmlhbmcNCg0KPiANCj4gVGhhbmtzLA0K
PiAtQXVicmV5DQoNCg==
