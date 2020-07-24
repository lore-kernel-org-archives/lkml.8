Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7906C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC188206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="HHXzTG0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXC37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:29:59 -0400
Received: from mail6.tencent.com ([220.249.245.26]:55105 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgGXC36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:29:58 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail6.tencent.com (Postfix) with ESMTP id C06BBCC174;
        Fri, 24 Jul 2020 10:30:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595557833;
        bh=KNc9jKQirz6Sv259rMS0LyqA39d1F0MdWko1cXMhW4I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=HHXzTG0AlUhlMPOTzFpxC48u4G8Jk5DYB3nNMghyVOL7SeNz8IM96CKs2nsx4YAa1
         v2lJtZIq17KAJDH6a9upcwNL8i9TjiZzVCfjL3cfLvypPhrDCVXbNkZVtPl6qIOOh3
         +YIOhZgyXc2AHlnZ33inPFyGyuFUvtSBwfXFFBOY=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 24 Jul
 2020 10:29:25 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 24 Jul
 2020 10:29:24 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Fri, 24 Jul 2020 10:29:24 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Aubrey Li <aubrey.intel@gmail.com>,
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
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AIAAv1UAgAAMuwCAAA7NAIAADWQAgAAVDACAACO4AIAABZIAgAAF6gCAAP+1gIAAHMmAgAAK0ICAAAbLgA==
Date:   Fri, 24 Jul 2020 02:29:24 +0000
Message-ID: <0B3518AC-3F4A-4E89-974A-E7DFD446D7C2@tencent.com>
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
 <F6F57D2C-90B2-49E5-8684-3F300A15B605@tencent.com>
 <9d2a6233-57a4-4970-c615-43bd05ea9da3@linux.intel.com>
In-Reply-To: <9d2a6233-57a4-4970-c615-43bd05ea9da3@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.198]
Content-Type: text/plain; charset="utf-8"
Content-ID: <907AD94A90D75E41BBCD14D96F2FB3E5@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDI0LCAyMDIwLCBhdCAxMDowNSBBTSwgTGksIEF1YnJleSA8YXVicmV5
LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAyMDIwLzcvMjQgOToyNiwgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4+IE9uIEp1bCAyNCwgMjAyMCwg
YXQgNzo0MyBBTSwgQXVicmV5IExpIDxhdWJyZXkuaW50ZWxAZ21haWwuY29tPiB3cm90ZToNCj4+
PiANCj4+PiBPbiBUaHUsIEp1bCAyMywgMjAyMCBhdCA0OjI4IFBNIGJlbmJqaWFuZyjokovlvaop
IDxiZW5iamlhbmdAdGVuY2VudC5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gSGksDQo+Pj4+IA0K
Pj4+Pj4gT24gSnVsIDIzLCAyMDIwLCBhdCA0OjA2IFBNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlA
bGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gMjAyMC83LzIzIDE1OjQ3
LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+Pj4+PiANCj4+Pj4+Pj4g
T24gSnVsIDIzLCAyMDIwLCBhdCAxOjM5IFBNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlAbGludXgu
aW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDIwMjAvNy8yMyAxMjoyMywg
YmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+PiBIaSwNCj4+Pj4+Pj4+PiBPbiBKdWwg
MjMsIDIwMjAsIGF0IDExOjM1IEFNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlAbGludXguaW50ZWwu
Y29tPiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiAyMDIwLzcvMjMgMTA6NDIsIGJl
bmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+Pj4+PiBIaSwNCj4+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4+PiBPbiBKdWwgMjMsIDIwMjAsIGF0IDk6NTcgQU0sIExpLCBBdWJyZXkgPGF1YnJleS5s
aUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBPbiAy
MDIwLzcvMjIgMjI6MzIsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+IEhp
LA0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+PiBPbiBKdWwgMjIsIDIwMjAsIGF0IDg6MTMg
UE0sIExpLCBBdWJyZXkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4+
Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gT24gMjAyMC83LzIyIDE2OjU0LCBiZW5iamlhbmco6JKL
5b2qKSB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4+IEhpLCBBdWJyZXksDQo+Pj4+Pj4+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+Pj4+Pj4+PiBPbiBKdWwgMSwgMjAyMCwgYXQgNTozMiBBTSwgVmluZWV0aCBSZW1h
bmFuIFBpbGxhaSA8dnBpbGxhaUBkaWdpdGFsb2NlYW4uY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiBGcm9tOiBBdWJyZXkgTGkgPGF1YnJleS5saUBpbnRlbC5j
b20+DQo+Pj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+Pj4gLSBEb24ndCBtaWdyYXRlIGlm
IHRoZXJlIGlzIGEgY29va2llIG1pc21hdGNoDQo+Pj4+Pj4+Pj4+Pj4+Pj4gTG9hZCBiYWxhbmNl
IHRyaWVzIHRvIG1vdmUgdGFzayBmcm9tIGJ1c2llc3QgQ1BVIHRvIHRoZQ0KPj4+Pj4+Pj4+Pj4+
Pj4+IGRlc3RpbmF0aW9uIENQVS4gV2hlbiBjb3JlIHNjaGVkdWxpbmcgaXMgZW5hYmxlZCwgaWYg
dGhlDQo+Pj4+Pj4+Pj4+Pj4+Pj4gdGFzaydzIGNvb2tpZSBkb2VzIG5vdCBtYXRjaCB3aXRoIHRo
ZSBkZXN0aW5hdGlvbiBDUFUncw0KPj4+Pj4+Pj4+Pj4+Pj4+IGNvcmUgY29va2llLCB0aGlzIHRh
c2sgd2lsbCBiZSBza2lwcGVkIGJ5IHRoaXMgQ1BVLiBUaGlzDQo+Pj4+Pj4+Pj4+Pj4+Pj4gbWl0
aWdhdGVzIHRoZSBmb3JjZWQgaWRsZSB0aW1lIG9uIHRoZSBkZXN0aW5hdGlvbiBDUFUuDQo+Pj4+
Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+Pj4gLSBTZWxlY3QgY29va2llIG1hdGNoZWQgaWRs
ZSBDUFUNCj4+Pj4+Pj4+Pj4+Pj4+PiBJbiB0aGUgZmFzdCBwYXRoIG9mIHRhc2sgd2FrZXVwLCBz
ZWxlY3QgdGhlIGZpcnN0IGNvb2tpZSBtYXRjaGVkDQo+Pj4+Pj4+Pj4+Pj4+Pj4gaWRsZSBDUFUg
aW5zdGVhZCBvZiB0aGUgZmlyc3QgaWRsZSBDUFUuDQo+Pj4+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+Pj4+Pj4gLSBGaW5kIGNvb2tpZSBtYXRjaGVkIGlkbGVzdCBDUFUNCj4+Pj4+Pj4+Pj4+Pj4+
PiBJbiB0aGUgc2xvdyBwYXRoIG9mIHRhc2sgd2FrZXVwLCBmaW5kIHRoZSBpZGxlc3QgQ1BVIHdo
b3NlIGNvcmUNCj4+Pj4+Pj4+Pj4+Pj4+PiBjb29raWUgbWF0Y2hlcyB3aXRoIHRhc2sncyBjb29r
aWUNCj4+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiAtIERvbid0IG1pZ3JhdGUgdGFz
ayBpZiBjb29raWUgbm90IG1hdGNoDQo+Pj4+Pj4+Pj4+Pj4+Pj4gRm9yIHRoZSBOVU1BIGxvYWQg
YmFsYW5jZSwgZG9uJ3QgbWlncmF0ZSB0YXNrIHRvIHRoZSBDUFUgd2hvc2UNCj4+Pj4+Pj4+Pj4+
Pj4+PiBjb3JlIGNvb2tpZSBkb2VzIG5vdCBtYXRjaCB3aXRoIHRhc2sncyBjb29raWUNCj4+Pj4+
Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBdWJyZXkgTGkgPGF1
YnJleS5saUBsaW51eC5pbnRlbC5jb20+DQo+Pj4+Pj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
VGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPg0KPj4+Pj4+Pj4+Pj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZpbmVldGggUmVtYW5hbiBQaWxsYWkgPHZwaWxsYWlAZGlnaXRhbG9jZWFu
LmNvbT4NCj4+Pj4+Pj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+Pj4+Pj4+PiBrZXJuZWwvc2NoZWQv
ZmFpci5jICB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
DQo+Pj4+Pj4+Pj4+Pj4+Pj4ga2VybmVsL3NjaGVkL3NjaGVkLmggfCAyOSArKysrKysrKysrKysr
KysrKysrKw0KPj4+Pj4+Pj4+Pj4+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiBkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+Pj4+
Pj4+Pj4+Pj4+PiBpbmRleCBkMTY5Mzk3NjYzNjEuLjMzZGM0YmYwMTgxNyAxMDA2NDQNCj4+Pj4+
Pj4+Pj4+Pj4+PiAtLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQo+Pj4+Pj4+Pj4+Pj4+Pj4gKysr
IGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+Pj4+Pj4+Pj4+Pj4+IEBAIC0yMDUxLDYgKzIwNTEs
MTUgQEAgc3RhdGljIHZvaWQgdGFza19udW1hX2ZpbmRfY3B1KHN0cnVjdCB0YXNrX251bWFfZW52
ICplbnYsDQo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgIGlmICghY3B1bWFza190ZXN0X2NwdShj
cHUsIGVudi0+cC0+Y3B1c19wdHIpKQ0KPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPj4+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+Pj4+ICsjaWZkZWYgQ09O
RklHX1NDSEVEX0NPUkUNCj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAvKg0KPj4+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgICAgICAqIFNraXAgdGhpcyBjcHUgaWYgc291cmNlIHRhc2sncyBjb29r
aWUgZG9lcyBub3QgbWF0Y2gNCj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgKiB3aXRoIENQ
VSdzIGNvcmUgY29va2llLg0KPj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAqLw0KPj4+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgICAgIGlmICghc2NoZWRfY29yZV9jb29raWVfbWF0Y2goY3B1X3Jx
KGNwdSksIGVudi0+cCkpDQo+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCj4+Pj4+Pj4+Pj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+
Pj4+Pj4+Pj4+ICAgICAgICAgICBlbnYtPmRzdF9jcHUgPSBjcHU7DQo+Pj4+Pj4+Pj4+Pj4+Pj4g
ICAgICAgICAgIGlmICh0YXNrX251bWFfY29tcGFyZShlbnYsIHRhc2tpbXAsIGdyb3VwaW1wLCBt
YXltb3ZlKSkNCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4+
Pj4+Pj4+Pj4+PiBAQCAtNTk2MywxMSArNTk3MiwxNyBAQCBmaW5kX2lkbGVzdF9ncm91cF9jcHUo
c3RydWN0IHNjaGVkX2dyb3VwICpncm91cCwgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgdGhp
cw0KPj4+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+Pj4+ICAgLyogVHJhdmVyc2Ugb25seSB0
aGUgYWxsb3dlZCBDUFVzICovDQo+Pj4+Pj4+Pj4+Pj4+Pj4gICBmb3JfZWFjaF9jcHVfYW5kKGks
IHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApLCBwLT5jcHVzX3B0cikgew0KPj4+Pj4+Pj4+Pj4+Pj4+
ICsgICAgICAgICAgIHN0cnVjdCBycSAqcnEgPSBjcHVfcnEoaSk7DQo+Pj4+Pj4+Pj4+Pj4+Pj4g
Kw0KPj4+Pj4+Pj4+Pj4+Pj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NPUkUNCj4+Pj4+Pj4+Pj4+
Pj4+PiArICAgICAgICAgICBpZiAoIXNjaGVkX2NvcmVfY29va2llX21hdGNoKHJxLCBwKSkNCj4+
Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+Pj4+Pj4+Pj4+
Pj4+ICsjZW5kaWYNCj4+Pj4+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAg
IGlmIChzY2hlZF9pZGxlX2NwdShpKSkNCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAg
ICByZXR1cm4gaTsNCj4+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAg
aWYgKGF2YWlsYWJsZV9pZGxlX2NwdShpKSkgew0KPj4+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgICAg
ICAgICAgICAgc3RydWN0IHJxICpycSA9IGNwdV9ycShpKTsNCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgY3B1aWRsZV9zdGF0ZSAqaWRsZSA9IGlkbGVfZ2V0X3N0YXRl
KHJxKTsNCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICBpZiAoaWRsZSAmJiBpZGxl
LT5leGl0X2xhdGVuY3kgPCBtaW5fZXhpdF9sYXRlbmN5KSB7DQo+Pj4+Pj4+Pj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAvKg0KPj4+Pj4+Pj4+Pj4+Pj4+IEBAIC02MjI0LDggKzYy
MzksMTggQEAgc3RhdGljIGludCBzZWxlY3RfaWRsZV9jcHUoc3RydWN0IHRhc2tfc3RydWN0ICpw
LCBzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCwgaW50IHQNCj4+Pj4+Pj4+Pj4+Pj4+PiAgIGZvcl9l
YWNoX2NwdV93cmFwKGNwdSwgY3B1cywgdGFyZ2V0KSB7DQo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAg
ICAgIGlmICghLS1ucikNCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4g
LTE7DQo+Pj4+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAgICAgaWYgKGF2YWlsYWJsZV9pZGxlX2NwdShj
cHUpIHx8IHNjaGVkX2lkbGVfY3B1KGNwdSkpDQo+Pj4+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4+Pj4+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAg
ICAgICAgaWYgKGF2YWlsYWJsZV9pZGxlX2NwdShjcHUpIHx8IHNjaGVkX2lkbGVfY3B1KGNwdSkp
IHsNCj4+Pj4+Pj4+Pj4+Pj4+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+Pj4+Pj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAvKg0KPj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICogSWYgQ29yZSBTY2hlZHVsaW5nIGlzIGVuYWJsZWQsIHNlbGVjdCB0aGlzIGNw
dQ0KPj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICogb25seSBpZiB0aGUgcHJv
Y2VzcyBjb29raWUgbWF0Y2hlcyBjb3JlIGNvb2tpZS4NCj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAqLw0KPj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgaWYg
KHNjaGVkX2NvcmVfZW5hYmxlZChjcHVfcnEoY3B1KSkgJiYNCj4+Pj4+Pj4+Pj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICBwLT5jb3JlX2Nvb2tpZSA9PSBjcHVfcnEoY3B1KS0+Y29yZS0+
Y29yZV9jb29raWUpDQo+Pj4+Pj4+Pj4+Pj4+PiBXaHkgbm90IGFsc28gYWRkIHNpbWlsYXIgbG9n
aWMgaW4gc2VsZWN0X2lkbGVfc210IHRvIHJlZHVjZSBmb3JjZWQtaWRsZT8gOikNCj4+Pj4+Pj4+
Pj4+Pj4gV2UgaGl0IHNlbGVjdF9pZGxlX3NtdCBhZnRlciB3ZSBzY2FuZWQgdGhlIGVudGlyZSBM
TEMgZG9tYWluIGZvciBpZGxlIGNvcmVzDQo+Pj4+Pj4+Pj4+Pj4+IGFuZCBpZGxlIGNwdXMgYW5k
IGZhaWxlZCxzbyBJTUhPLCBhbiBpZGxlIHNtdCBpcyBwcm9iYWJseSBhIGdvb2QgY2hvaWNlIHVu
ZGVyDQo+Pj4+Pj4+Pj4+Pj4+IHRoaXMgc2NlbmFyaW8uDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+Pj4gQUZBSUMsIHNlbGVjdGluZyBpZGxlIHNpYmxpbmcgd2l0aCB1bm1hdGNoZWQgY29va2ll
IHdpbGwgY2F1c2UgdW5uZWNlc3NhcnkgZm9yZWQtaWRsZSwgdW5mYWlybmVzcyBhbmQgbGF0ZW5j
eSwgY29tcGFyZWQgdG8gY2hvb3NpbmcgKnRhcmdldCogY3B1Lg0KPj4+Pj4+Pj4+Pj4gQ2hvb3Np
bmcgdGFyZ2V0IGNwdSBjb3VsZCBpbmNyZWFzZSB0aGUgcnVubmFibGUgdGFzayBudW1iZXIgb24g
dGhlIHRhcmdldCBydW5xdWV1ZSwgdGhpcw0KPj4+Pj4+Pj4+Pj4gY291bGQgdHJpZ2dlciBidXNp
ZXN0LT5ucl9ydW5uaW5nID4gMSBsb2dpYyBhbmQgbWFrZXMgdGhlIGlkbGUgc2libGluZyB0cnlp
bmcgdG8gcHVsbCBidXQNCj4+Pj4+Pj4+Pj4+IG5vdCBzdWNjZXNzKGR1ZSB0byBjb29raWUgbm90
IG1hdGNoKS4gUHV0dGluZyB0YXNrIHRvIHRoZSBpZGxlIHNpYmxpbmcgaXMgcmVsYXRpdmVseSBz
dGFibGUgSU1ITy4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IEnigJltIGFmcmFpZCB0aGF0ICp1
bnN1Y2Nlc3NmdWwqIHB1bGxpbmdzIGJldHdlZW4gc210cyB3b3VsZCBub3QgcmVzdWx0IGluIHVu
c3RhYmxlbmVzcywgYmVjYXVzZQ0KPj4+Pj4+Pj4+PiB0aGUgbG9hZC1iYWxhbmNlIGFsd2F5cyBk
byBwZXJpb2RpY2x5ICwgYW5kIHVuc3VjY2VzcyBtZWFucyBub3RoaW5nIGhhcHBlbi4NCj4+Pj4+
Pj4+PiB1bnN1Y2Nlc3MgcHVsbGluZyBtZWFucyBtb3JlIHVubmVjZXNzYXJ5IG92ZXJoZWFkIGlu
IGxvYWQgYmFsYW5jZS4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gT24gdGhlIGNvbnRyYXJ5LCB1
bm1hdGNoZWQgc2libGluZyB0YXNrcyBydW5uaW5nIGNvbmN1cnJlbnRseSBjb3VsZCBicmluZyBm
b3JjZWQtaWRsZSB0byBlYWNoIG90aGVyIHJlcGVhdGVkbHksDQo+Pj4+Pj4+Pj4+IFdoaWNoIGlz
IG1vcmUgdW5zdGFibGUsIGFuZCBtb3JlIGNvc3RseSB3aGVuIHBpY2tfbmV4dF90YXNrIGZvciBh
bGwgc2libGluZ3MuDQo+Pj4+Pj4+Pj4gTm90IHdvcnNlIHRoYW4gdHdvIHRhc2tzIHBpbmctcG9u
ZyBvbiB0aGUgc2FtZSB0YXJnZXQgcnVuIHF1ZXVlIEkgZ3Vlc3MsIGFuZCBiZXR0ZXIgaWYNCj4+
Pj4+Pj4+PiAtIHRhc2sxKGNvb2tpZSBBKSBpcyBydW5uaW5nIG9uIHRoZSB0YXJnZXQsIGFuZCB0
YXNrMihjb29raWUgQikgaW4gdGhlIHJ1bnF1ZXVlLA0KPj4+Pj4+Pj4+IC0gdGFzazMoY29va2ll
IEIpIGNvbWluZw0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IElmIHRhc2szIGNob29zZXMgdGFyZ2V0
J3Mgc2libGluZywgaXQgY291bGQgaGF2ZSBhIGNoYW5jZSB0byBydW4gY29uY3VycmVudGx5IHdp
dGggdGFzazIuDQo+Pj4+Pj4+Pj4gQnV0IGlmIHRhc2szIGNob29zZXMgdGFyZ2V0LCBpdCB3aWxs
IHdhaXQgZm9yIG5leHQgcHVsbGluZyBsdWNrIG9mIGxvYWQgYmFsYW5jZXINCj4+Pj4+Pj4+IFRo
YXTigJlzIG1vcmUgaW50ZXJlc3RpbmcuIDopDQo+Pj4+Pj4+PiBEaXN0cmlidXRpbmcgZGlmZmVy
ZW50IGNvb2tpZSB0YXNrcyBvbnRvIGRpZmZlcmVudCBjcHVzKG9yIGNwdXNldHMpIGNvdWxkIGJl
IHRoZSAqaWRlYWwgc3RhYmxlIHN0YXR1cyogd2Ugd2FudCwgYXMgSSB1bmRlcnN0b29kLg0KPj4+
Pj4+Pj4gRGlmZmVyZW50IGNvb2tpZSB0YXNrcyBydW5uaW5nIG9uIHNpYmxpbmcgc210cyBjb3Vs
ZCBodXJ0IHBlcmZvcm1hbmNlLCBhbmQgdGhhdCBzaG91bGQgYmUgYXZvaWRlZCB3aXRoIGJlc3Qg
ZWZmb3J0Lg0KPj4+Pj4+PiBXZSBhbHJlYWR5IHRyaWVkIHRvIGF2b2lkIHdoZW4gd2Ugc2NhbiBp
ZGxlIGNvcmVzIGFuZCBpZGxlIGNwdXMgaW4gbGxjIGRvbWFpbi4NCj4+Pj4+PiANCj4+Pj4+PiBJ
4oCZbSBhZnJhaWQgdGhhdOKAmXMgbm90IGVub3VnaCBlaXRoZXIsIDopDQo+Pj4+Pj4gMS4gU2Nh
bm5pbmcgSWRsZSBjcHVzIGlzIG5vdCBhIGZ1bGwgc2NhbiwgdGhlcmUgaXMgbGltaXQgYWNjb3Jk
aW5nIHRvIHNjYW4gY29zdC4NCj4+Pj4+PiAyLiBUaGF0J3Mgb25seSB0cnlpbmcgYXQgdGhlICpj
b3JlL2NwdSogbGV2ZWwsICpTTVQqIGxldmVsIHNob3VsZCBiZSBjb25zaWRlcmVkIHRvby4NCj4+
Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBGb3IgYWJvdmUgY2FzZSwgc2VsZWN0aW5nIGlkbGUg
c2libGluZyBjcHUgY2FuIGltcHJvdmUgdGhlIGNvbmN1cnJlbmN5IGluZGVlZCwgYnV0IGl0IGRl
Y3JlYXNlIHRoZSBpbWJhbGFuY2UgZm9yIGxvYWQtYmFsYW5jZXIuDQo+Pj4+Pj4+PiBJbiB0aGF0
IGNhc2UsIGxvYWQtYmFsYW5jZXIgY291bGQgbm90IG5vdGljZSB0aGUgaW1iYWxhbmNlLCBhbmQg
d291bGQgZG8gbm90aGluZyB0byBpbXByb3ZlIHRoZSB1bm1hdGNoZWQgc2l0dWF0aW9uLg0KPj4+
Pj4+Pj4gT24gdGhlIGNvbnRyYXJ5LCBjaG9vc2luZyB0aGUgKnRhcmdldCogY3B1IGNvdWxkIGVu
aGFuY2UgdGhlIGltYmFsYW5jZSwgYW5kIGxvYWQtYmFsYW5jZXIgY291bGQgdHJ5IHRvIHB1bGwg
dW5tYXRjaGVkIHRhc2sgYXdheSwNCj4+Pj4+Pj4gUHVsbGluZyBhd2F5IHRvIHdoZXJlIG5lZWRz
IGFub3RoZXIgYnVuY2ggb2YgZWxhYm9yYXRpb24uDQo+Pj4+Pj4gDQo+Pj4+Pj4gU3RpbGwgd2l0
aCB0aGUgU01UMiszdGFza3MgY2FzZSwNCj4+Pj4+PiBpZiAqaWRsZSBzaWJsaW5nKiBjaG9zZW4s
DQo+Pj4+Pj4gU210MeKAmXMgbG9hZCA9IHRhc2sxK3Rhc2syLCBzbXQy4oCZcyBsb2FkID0gdGFz
azMuIFRhc2szIHdpbGwgcnVuIGludGVybWl0dGVudGx5IGJlY2F1c2Ugb2YgZm9yY2VkLWlkbGUs
DQo+Pj4+Pj4gc28gc210MuKAmXMgcmVhbCBsb2FkIGNvdWxkIGxvdyBlbm91Z2gsIHRoYXQgaXQg
Y291bGQgbm90IGJlIHB1bGxlZCBhd2F5IGZvcmV2ZXIuIFRoYXTigJlzIGluZGVlZCBhIHN0YWJs
ZSBzdGF0ZSwNCj4+Pj4+PiBidXQgd2l0aCBwZXJmb3JtYW5jZSBhdCBhIGRpc2NvdW50Lg0KPj4+
Pj4+IA0KPj4+Pj4+IElmICp0YXJnZXQgc2libGluZyogY2hvc2UsDQo+Pj4+Pj4gU210MeKAmXMg
bG9hZCA9IHRhc2sxK3Rhc2syK3Rhc2szLCBzbXQy4oCZcyBsb2FkPTAuIEl04oCZcyBhIG9idmlv
dXMgaW1iYWxhbmNlLCBhbmQgbG9hZC1iYWxhbmNlciB3aWxsIHBpY2sgYSB0YXNrIHRvIHB1bGws
DQo+Pj4+Pj4gMS4gSWYgdGFzazEoY29va2llIEEpIHBpY2tlZCwgdGhhdOKAmXMgZG9uZSBmb3Ig
Z29vZC4NCj4+Pj4+PiAyLiBJZiB0YXNrMihjb29raWUgQikgb3IgdGFzazMoY29va2llIEIpIHBp
Y2tlZCwgdGhhdOKAmXMgb2sgdG9vLCB0aGUgcmVzdCB0YXNrKGNvb2tpZSBCKSBjb3VsZCBiZSBw
dWxsZWQgYXdheSBhdCBuZXh0IGJhbGFuY2UobWF5YmUgbmVlZCB0byBpbXByb3ZlIHRoZSBwdWxs
aW5nIHRvIHRlbmQgdG8gcHVsbCBtYXRjaGVkIHRhc2sgbW9yZSBhZ2dyZXNzaXZlbHkpLg0KPj4+
Pj4+IEFuZCB0aGVuLCB3ZSBtYXkgcmVhY2ggYSBtb3JlIHN0YWJsZSBzdGF0ZSAqZ2xvYmFsbHkq
IHdpdGhvdXQgcGVyZm9ybWFuY2UgZGlzY291bnQuDQo+Pj4+PiANCj4+Pj4+IEknbSBub3Qgc3Vy
ZSB3aGF0IHlvdSBtZWFuIHB1bGxlZCBhd2F5LA0KPj4+PiBJIG1lYW4gcHVsbGVkIGF3YXkgYnkg
b3RoZXIgY3B1cywgbWF5IGJlIHRyaWdnZXJlZCBieSBpZGxlIGJhbGFuY2Ugb3IgcGVyaW9kaWMg
YmFsYW5jZSBvbiBvdGhlciBjcHVzLg0KPj4+PiANCj4+Pj4+IC0gaWYgeW91IG1lYW4gcHVsbGVk
IGF3YXkgZnJvbSB0aGlzIGNvcmUsIGNvb2tpZUEgaW4gaWRsZSBzaWJsaW5nIGNhc2UgY2FuIGJl
DQo+Pj4+PiBwdWxsZWQgYXdheSB0b28uDQo+Pj4+IFllcCwgY29va2llQSh0YXNrMSkgaW4gaWRs
ZSBzaWJsaW5nIGNhc2UgY291bGQgYmUgcHVsbGVkIGF3YXksIGJ1dA0KPj4+PiBjb29raWVCKHRh
c2szKSBvbiB0aGUgc210MiBjb3VsZCBuZXZlciBnZXQgdGhlIGNoYW5jZSBiZWluZyBwdWxsZWQN
Cj4+Pj4gYXdheSh1bmxlc3MgYmVpbmcgd2FrZW4gdXApLg0KPj4+PiBJZiBjb29raWVBKHRhc2sx
KSBmYWlsZWQgYmVpbmcgcHVsbGVkKGNvb2tpZUIodGFzazIpIG9uIHNtdDEgbWF5IGJlIHB1bGxl
ZCwNCj4+Pj4gNTAlIGNoYW5jZSksIGNvb2tpZUEodGFzazEpIGFuZCBjb29raWVCKHRhc2szKSB3
b3VsZCByZWFjaCB0aGUgc3RhYmxlIHN0YXRlDQo+Pj4+IHdpdGggcGVyZm9ybWFuY2UgZGlzY291
bnQuDQo+Pj4+IA0KPj4+IElmIHlvdSBtZWFudCBwdWxsZWQgYXdheSBmcm9tIHRoaXMgY29yZSwg
SSBkaWRuJ3Qgc2VlIGhvdyB0d28gY2FzZXMgYXJlDQo+Pj4gZGlmZmVyZW50IGVpdGhlci4gRm9y
IGV4YW1wbGUsIHdoZW4gdGFzazIoY29va2llQikgcnVucyBvbiBTTVQxLCB0YXNrMw0KPj4+IGNv
b2tpZWIgY2FuIGJlIHB1bGxlZCB0byBTTVQyLiBhbmQgd2hlbiB0YXNrMShjb29raWVBKSBzd2l0
Y2ggb250byBTTVQxLA0KPj4+IHRhc2syKGNvb2tpZUIpIGNhbiBiZSBwdWxsZWQgYXdheSBieSBv
dGhlciBjcHVzLCB0b28uDQo+PiBUaGF04oCZcyB0aGUgY2FzZSBvbmx5IGlmIFNNVDLigJlzIHB1
bGxpbmcgaGFwcGVucyB3aGVuIHRhc2syKGNvb2tpZUIpIGlzIHJ1bm5pbmcNCj4+IG9uIFNNVDEs
IHdoaWNoIGRlcGVuZHMgb24sDQo+PiAxLiBTbXQyIG5vdCBlbnRlcmluZyB0aWNrbGVzcyBvciBu
b2h6X2JhbGFuY2VyX2tpY2sgcGlja3Mgc210MiBiZWZvcmUgb3RoZXINCj4+IGNwdeKAmXMgcHVs
bGluZywgbWF5IGJlIHVubGlrZWx5LiA6KQ0KPj4gMi4gVGFzazEoY29va2llQSkgaXMgbm90IHJ1
bm5pbmcgb24gU01UMS4NCj4+IG90aGVyd2lzZSBpdCB3b3VsZCBiZSB0aGUgY2FzZSBJIGRlc2Ny
aWJlZCBhYm92ZS4gIA0KPj4gDQo+PiBCZXNpZGVzLCBmb3Igb3RoZXIgY2FzZXMsIGxpa2Ugc210
MisydGFzayhDb29raWVBK0Nvb2tpZUIpLCBwaWNraW5nICp0YXJnZXQqDQo+PiBjcHUgaW5zdGVh
ZCBvZiAqaWRsZSBzaWJsaW5nKiBjb3VsZCBiZSBtb3JlIGhlbHBmdWwgdG8gcmVhY2ggdGhlIGds
b2JhbCBzdGFibGUNCj4+IHN0YXR1cyhkaXN0cmlidXRlIGRpZmZlcmVudCBjb29raWVzIG9udG8g
ZGlmZmVyZW50IGNvcmVzKS4gDQo+PiBJZiB0aGUgdGFzayBudW1iZXIgb2YgdHdvIGNvb2tpZXMg
aGFzIGEgYmlnIGRpZmZlcmVuY2UsIHRoZW4gZGlzdHJpYnV0aW5nDQo+IGRpZmZlcmVudCBjb29r
aWVzIG9udG8gZGlmZmVyZW50IGNvcmVzIGxlYWRzIHRvIGEgYmlnIGltYmFsYW5jZSwgdGhhdCBz
dGF0ZSBtYXkNCj4gYmUgc3RhYmxlIGJ1dCBub3QgYW4gb3B0aW1hbCBzdGF0ZSwgSSBndWVzcyB0
aGF0J3Mgd2h5IGNvcmUgcnVuIHF1ZXVlIGRvZXMNCj4gbm90IHJlZnVzZSBkaWZmZXJlbnQgY29v
a2llcyBvbnRvIGl0cyByYiB0cmVlLg0KVGhhdOKAmXMgdGhlIG92ZXJjb21taXQgY2FzZSwgaW4g
d2hpY2ggY2FzZSBkaXN0cmlidXRpbmcgaXMgbm90IHBvc3NpYmxlLCBhbmQgd291bGQNCmZhbGxi
YWNrIHRvIHRoZSAqbG9jYWwgc3RhYmxlIHN0YXR1cyooYXMgd2hhdCBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGRvZXMpIHRvby4NCg0KSWYgdGhlIHRvdGFsIHRhc2sgbnVtYmVyIGlzIG5vdCBvdmVy
Y29tbWl0LCBkaXN0cmlidXRpbmcgY291bGQgd29yay4gOikNCg0KPiANCj4gSSB0aGluayBJIHVu
ZGVyc3RhbmQgeW91ciBjb25jZXJuIGJ1dCBJTUhPIEknbSBub3QgY29udmluY2VkIGFkZGluZyBj
b29raWUgbWF0Y2gNCj4gaW4gaWRsZSBTTVQgc2VsZWN0aW9uIGlzIGEgYmVzdCBjaG9pY2UsIGlm
IHlvdSBoYXZlIHNvbWUgcGVyZm9ybWFuY2UgZGF0YSBvZiB5b3VyDQo+IHdvcmtsb2FkLCB0aGF0
IHdpbGwgYmUgdmVyeSBoZWxwZnVsIHRvIHVuZGVyc3RhbmQgdGhlIGNhc2UuDQpHb3QgaXQsIEni
gJlsbCB0cnkgbGF0ZXIuICANCg0KPiANCj4gSWYgZGlzdHJpYnV0aW5nIGRpZmZlcmVudCBjb29r
aWVzIG9udG8gZGlmZmVyZW50IGNvcmVzIGlzIGEgaGFyZCByZXF1aXJlbWVudCBmcm9tDQo+IHlv
dXIgc2lkZSwgeW91IGFyZSB3ZWxjb21lIHRvIHN1Ym1pdCBhIHBhdGNoIHRvIHNlZSBvdGhlcnMg
b3Bpbmlvbi4NCg0KVGhhbmtzIGZvciB5b3VyIHBhdGllbmNlLiBJZiBwb3NzaWJsZSwgY291bGQg
eW91IHBsZWFzZSBsb29wIG1lIGluIGZvciBmdXR1cmUNCmRpc2N1c3Npb25zIGFib3V0IGNvcmUt
c2NoZWR1bGluZy4gDQoNClRoeC4NClJlZ2FyZCwNCkppYW5nDQoNCj4gDQo+IFRoYW5rcywNCj4g
LUF1YnJleQ0KDQo=
