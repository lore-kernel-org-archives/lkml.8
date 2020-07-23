Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D384122B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="RnVAkPKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGWI2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:28:22 -0400
Received: from mail6.tencent.com ([220.249.245.26]:43401 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:28:22 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail6.tencent.com (Postfix) with ESMTP id E65DFCC3E6;
        Thu, 23 Jul 2020 16:29:27 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595492967;
        bh=+kiLaxLMqQPeU3F3oiuEt90+Yk8nnjsFVvVZz1H8DI4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=RnVAkPKAG1khxReRv7JbCbziAkrrKalR0C0httKS7NigJSp2vorupJRMj3vhz1y7K
         d5IpZcALwoK/VEXFoCGv1fOZAjXdDOd+Rb0L0Y05xSerSObXNJ3H8MwuYkMp7D0dw2
         HlxR3aGXuMChchTYRzGjfA8QPnLfONBalrpl+AOQ=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 16:28:19 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 16:28:18 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 23 Jul 2020 16:28:18 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
Thread-Topic: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AIAAv1UAgAAMuwCAAA7NAIAADWQAgAAVDACAACO4AIAABZIAgAAF6gA=
Date:   Thu, 23 Jul 2020 08:28:18 +0000
Message-ID: <A73E4BD3-D742-40E1-9928-B45BC68D1B89@tencent.com>
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
In-Reply-To: <36cce58e-03b3-4d77-dfc5-e3c49f3ecdd8@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BFEF7AAF295AE4D88BB87975E4DD3A8@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDIzLCAyMDIwLCBhdCA0OjA2IFBNLCBMaSwgQXVicmV5IDxhdWJyZXku
bGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvNy8yMyAxNTo0NywgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4+IE9uIEp1bCAyMywgMjAyMCwg
YXQgMTozOSBQTSwgTGksIEF1YnJleSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6
DQo+Pj4gDQo+Pj4gT24gMjAyMC83LzIzIDEyOjIzLCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToN
Cj4+Pj4gSGksDQo+Pj4+PiBPbiBKdWwgMjMsIDIwMjAsIGF0IDExOjM1IEFNLCBMaSwgQXVicmV5
IDxhdWJyZXkubGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gMjAy
MC83LzIzIDEwOjQyLCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+Pj4+
PiANCj4+Pj4+Pj4gT24gSnVsIDIzLCAyMDIwLCBhdCA5OjU3IEFNLCBMaSwgQXVicmV5IDxhdWJy
ZXkubGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDIwMjAv
Ny8yMiAyMjozMiwgYmVuYmppYW5nKOiSi+W9qikgd3JvdGU6DQo+Pj4+Pj4+PiBIaSwNCj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4+IE9uIEp1bCAyMiwgMjAyMCwgYXQgODoxMyBQTSwgTGksIEF1YnJleSA8
YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4g
T24gMjAyMC83LzIyIDE2OjU0LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+Pj4+Pj4g
SGksIEF1YnJleSwNCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBPbiBKdWwgMSwgMjAyMCwgYXQg
NTozMiBBTSwgVmluZWV0aCBSZW1hbmFuIFBpbGxhaSA8dnBpbGxhaUBkaWdpdGFsb2NlYW4uY29t
PiB3cm90ZToNCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gRnJvbTogQXVicmV5IExpIDxhdWJy
ZXkubGlAaW50ZWwuY29tPg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiAtIERvbid0IG1pZ3Jh
dGUgaWYgdGhlcmUgaXMgYSBjb29raWUgbWlzbWF0Y2gNCj4+Pj4+Pj4+Pj4+IExvYWQgYmFsYW5j
ZSB0cmllcyB0byBtb3ZlIHRhc2sgZnJvbSBidXNpZXN0IENQVSB0byB0aGUNCj4+Pj4+Pj4+Pj4+
IGRlc3RpbmF0aW9uIENQVS4gV2hlbiBjb3JlIHNjaGVkdWxpbmcgaXMgZW5hYmxlZCwgaWYgdGhl
DQo+Pj4+Pj4+Pj4+PiB0YXNrJ3MgY29va2llIGRvZXMgbm90IG1hdGNoIHdpdGggdGhlIGRlc3Rp
bmF0aW9uIENQVSdzDQo+Pj4+Pj4+Pj4+PiBjb3JlIGNvb2tpZSwgdGhpcyB0YXNrIHdpbGwgYmUg
c2tpcHBlZCBieSB0aGlzIENQVS4gVGhpcw0KPj4+Pj4+Pj4+Pj4gbWl0aWdhdGVzIHRoZSBmb3Jj
ZWQgaWRsZSB0aW1lIG9uIHRoZSBkZXN0aW5hdGlvbiBDUFUuDQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+Pj4+IC0gU2VsZWN0IGNvb2tpZSBtYXRjaGVkIGlkbGUgQ1BVDQo+Pj4+Pj4+Pj4+PiBJbiB0
aGUgZmFzdCBwYXRoIG9mIHRhc2sgd2FrZXVwLCBzZWxlY3QgdGhlIGZpcnN0IGNvb2tpZSBtYXRj
aGVkDQo+Pj4+Pj4+Pj4+PiBpZGxlIENQVSBpbnN0ZWFkIG9mIHRoZSBmaXJzdCBpZGxlIENQVS4N
Cj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gLSBGaW5kIGNvb2tpZSBtYXRjaGVkIGlkbGVzdCBD
UFUNCj4+Pj4+Pj4+Pj4+IEluIHRoZSBzbG93IHBhdGggb2YgdGFzayB3YWtldXAsIGZpbmQgdGhl
IGlkbGVzdCBDUFUgd2hvc2UgY29yZQ0KPj4+Pj4+Pj4+Pj4gY29va2llIG1hdGNoZXMgd2l0aCB0
YXNrJ3MgY29va2llDQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IC0gRG9uJ3QgbWlncmF0ZSB0
YXNrIGlmIGNvb2tpZSBub3QgbWF0Y2gNCj4+Pj4+Pj4+Pj4+IEZvciB0aGUgTlVNQSBsb2FkIGJh
bGFuY2UsIGRvbid0IG1pZ3JhdGUgdGFzayB0byB0aGUgQ1BVIHdob3NlDQo+Pj4+Pj4+Pj4+PiBj
b3JlIGNvb2tpZSBkb2VzIG5vdCBtYXRjaCB3aXRoIHRhc2sncyBjb29raWUNCj4+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQXVicmV5IExpIDxhdWJyZXkubGlAbGludXgu
aW50ZWwuY29tPg0KPj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVGltIENoZW4gPHRpbS5jLmNo
ZW5AbGludXguaW50ZWwuY29tPg0KPj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmluZWV0aCBS
ZW1hbmFuIFBpbGxhaSA8dnBpbGxhaUBkaWdpdGFsb2NlYW4uY29tPg0KPj4+Pj4+Pj4+Pj4gLS0t
DQo+Pj4+Pj4+Pj4+PiBrZXJuZWwvc2NoZWQvZmFpci5jICB8IDY0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+Pj4+Pj4+Pj4+PiBrZXJuZWwvc2NoZWQvc2No
ZWQuaCB8IDI5ICsrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+Pj4+PiAyIGZpbGVzIGNoYW5n
ZWQsIDg4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3NjaGVkL2Zh
aXIuYw0KPj4+Pj4+Pj4+Pj4gaW5kZXggZDE2OTM5NzY2MzYxLi4zM2RjNGJmMDE4MTcgMTAwNjQ0
DQo+Pj4+Pj4+Pj4+PiAtLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQo+Pj4+Pj4+Pj4+PiArKysg
Yi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+Pj4+Pj4+Pj4+PiBAQCAtMjA1MSw2ICsyMDUxLDE1IEBA
IHN0YXRpYyB2b2lkIHRhc2tfbnVtYV9maW5kX2NwdShzdHJ1Y3QgdGFza19udW1hX2VudiAqZW52
LA0KPj4+Pj4+Pj4+Pj4gCQlpZiAoIWNwdW1hc2tfdGVzdF9jcHUoY3B1LCBlbnYtPnAtPmNwdXNf
cHRyKSkNCj4+Pj4+Pj4+Pj4+IAkJCWNvbnRpbnVlOw0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+
PiArI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+Pj4+Pj4+PiArCQkvKg0KPj4+Pj4+Pj4+
Pj4gKwkJICogU2tpcCB0aGlzIGNwdSBpZiBzb3VyY2UgdGFzaydzIGNvb2tpZSBkb2VzIG5vdCBt
YXRjaA0KPj4+Pj4+Pj4+Pj4gKwkJICogd2l0aCBDUFUncyBjb3JlIGNvb2tpZS4NCj4+Pj4+Pj4+
Pj4+ICsJCSAqLw0KPj4+Pj4+Pj4+Pj4gKwkJaWYgKCFzY2hlZF9jb3JlX2Nvb2tpZV9tYXRjaChj
cHVfcnEoY3B1KSwgZW52LT5wKSkNCj4+Pj4+Pj4+Pj4+ICsJCQljb250aW51ZTsNCj4+Pj4+Pj4+
Pj4+ICsjZW5kaWYNCj4+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4+IAkJZW52LT5kc3RfY3B1ID0g
Y3B1Ow0KPj4+Pj4+Pj4+Pj4gCQlpZiAodGFza19udW1hX2NvbXBhcmUoZW52LCB0YXNraW1wLCBn
cm91cGltcCwgbWF5bW92ZSkpDQo+Pj4+Pj4+Pj4+PiAJCQlicmVhazsNCj4+Pj4+Pj4+Pj4+IEBA
IC01OTYzLDExICs1OTcyLDE3IEBAIGZpbmRfaWRsZXN0X2dyb3VwX2NwdShzdHJ1Y3Qgc2NoZWRf
Z3JvdXAgKmdyb3VwLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCB0aGlzDQo+Pj4+Pj4+Pj4+
PiANCj4+Pj4+Pj4+Pj4+IAkvKiBUcmF2ZXJzZSBvbmx5IHRoZSBhbGxvd2VkIENQVXMgKi8NCj4+
Pj4+Pj4+Pj4+IAlmb3JfZWFjaF9jcHVfYW5kKGksIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApLCBw
LT5jcHVzX3B0cikgew0KPj4+Pj4+Pj4+Pj4gKwkJc3RydWN0IHJxICpycSA9IGNwdV9ycShpKTsN
Cj4+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NPUkUNCj4+
Pj4+Pj4+Pj4+ICsJCWlmICghc2NoZWRfY29yZV9jb29raWVfbWF0Y2gocnEsIHApKQ0KPj4+Pj4+
Pj4+Pj4gKwkJCWNvbnRpbnVlOw0KPj4+Pj4+Pj4+Pj4gKyNlbmRpZg0KPj4+Pj4+Pj4+Pj4gKw0K
Pj4+Pj4+Pj4+Pj4gCQlpZiAoc2NoZWRfaWRsZV9jcHUoaSkpDQo+Pj4+Pj4+Pj4+PiAJCQlyZXR1
cm4gaTsNCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gCQlpZiAoYXZhaWxhYmxlX2lkbGVfY3B1
KGkpKSB7DQo+Pj4+Pj4+Pj4+PiAtCQkJc3RydWN0IHJxICpycSA9IGNwdV9ycShpKTsNCj4+Pj4+
Pj4+Pj4+IAkJCXN0cnVjdCBjcHVpZGxlX3N0YXRlICppZGxlID0gaWRsZV9nZXRfc3RhdGUocnEp
Ow0KPj4+Pj4+Pj4+Pj4gCQkJaWYgKGlkbGUgJiYgaWRsZS0+ZXhpdF9sYXRlbmN5IDwgbWluX2V4
aXRfbGF0ZW5jeSkgew0KPj4+Pj4+Pj4+Pj4gCQkJCS8qDQo+Pj4+Pj4+Pj4+PiBAQCAtNjIyNCw4
ICs2MjM5LDE4IEBAIHN0YXRpYyBpbnQgc2VsZWN0X2lkbGVfY3B1KHN0cnVjdCB0YXNrX3N0cnVj
dCAqcCwgc3RydWN0IHNjaGVkX2RvbWFpbiAqc2QsIGludCB0DQo+Pj4+Pj4+Pj4+PiAJZm9yX2Vh
Y2hfY3B1X3dyYXAoY3B1LCBjcHVzLCB0YXJnZXQpIHsNCj4+Pj4+Pj4+Pj4+IAkJaWYgKCEtLW5y
KQ0KPj4+Pj4+Pj4+Pj4gCQkJcmV0dXJuIC0xOw0KPj4+Pj4+Pj4+Pj4gLQkJaWYgKGF2YWlsYWJs
ZV9pZGxlX2NwdShjcHUpIHx8IHNjaGVkX2lkbGVfY3B1KGNwdSkpDQo+Pj4+Pj4+Pj4+PiAtCQkJ
YnJlYWs7DQo+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+PiArCQlpZiAoYXZhaWxhYmxlX2lkbGVf
Y3B1KGNwdSkgfHwgc2NoZWRfaWRsZV9jcHUoY3B1KSkgew0KPj4+Pj4+Pj4+Pj4gKyNpZmRlZiBD
T05GSUdfU0NIRURfQ09SRQ0KPj4+Pj4+Pj4+Pj4gKwkJCS8qDQo+Pj4+Pj4+Pj4+PiArCQkJICog
SWYgQ29yZSBTY2hlZHVsaW5nIGlzIGVuYWJsZWQsIHNlbGVjdCB0aGlzIGNwdQ0KPj4+Pj4+Pj4+
Pj4gKwkJCSAqIG9ubHkgaWYgdGhlIHByb2Nlc3MgY29va2llIG1hdGNoZXMgY29yZSBjb29raWUu
DQo+Pj4+Pj4+Pj4+PiArCQkJICovDQo+Pj4+Pj4+Pj4+PiArCQkJaWYgKHNjaGVkX2NvcmVfZW5h
YmxlZChjcHVfcnEoY3B1KSkgJiYNCj4+Pj4+Pj4+Pj4+ICsJCQkgICAgcC0+Y29yZV9jb29raWUg
PT0gY3B1X3JxKGNwdSktPmNvcmUtPmNvcmVfY29va2llKQ0KPj4+Pj4+Pj4+PiBXaHkgbm90IGFs
c28gYWRkIHNpbWlsYXIgbG9naWMgaW4gc2VsZWN0X2lkbGVfc210IHRvIHJlZHVjZSBmb3JjZWQt
aWRsZT8gOikNCj4+Pj4+Pj4+PiBXZSBoaXQgc2VsZWN0X2lkbGVfc210IGFmdGVyIHdlIHNjYW5l
ZCB0aGUgZW50aXJlIExMQyBkb21haW4gZm9yIGlkbGUgY29yZXMNCj4+Pj4+Pj4+PiBhbmQgaWRs
ZSBjcHVzIGFuZCBmYWlsZWQsc28gSU1ITywgYW4gaWRsZSBzbXQgaXMgcHJvYmFibHkgYSBnb29k
IGNob2ljZSB1bmRlcg0KPj4+Pj4+Pj4+IHRoaXMgc2NlbmFyaW8uDQo+Pj4+Pj4+PiANCj4+Pj4+
Pj4+IEFGQUlDLCBzZWxlY3RpbmcgaWRsZSBzaWJsaW5nIHdpdGggdW5tYXRjaGVkIGNvb2tpZSB3
aWxsIGNhdXNlIHVubmVjZXNzYXJ5IGZvcmVkLWlkbGUsIHVuZmFpcm5lc3MgYW5kIGxhdGVuY3ks
IGNvbXBhcmVkIHRvIGNob29zaW5nICp0YXJnZXQqIGNwdS4NCj4+Pj4+Pj4gQ2hvb3NpbmcgdGFy
Z2V0IGNwdSBjb3VsZCBpbmNyZWFzZSB0aGUgcnVubmFibGUgdGFzayBudW1iZXIgb24gdGhlIHRh
cmdldCBydW5xdWV1ZSwgdGhpcw0KPj4+Pj4+PiBjb3VsZCB0cmlnZ2VyIGJ1c2llc3QtPm5yX3J1
bm5pbmcgPiAxIGxvZ2ljIGFuZCBtYWtlcyB0aGUgaWRsZSBzaWJsaW5nIHRyeWluZyB0byBwdWxs
IGJ1dA0KPj4+Pj4+PiBub3Qgc3VjY2VzcyhkdWUgdG8gY29va2llIG5vdCBtYXRjaCkuIFB1dHRp
bmcgdGFzayB0byB0aGUgaWRsZSBzaWJsaW5nIGlzIHJlbGF0aXZlbHkgc3RhYmxlIElNSE8uDQo+
Pj4+Pj4gDQo+Pj4+Pj4gSeKAmW0gYWZyYWlkIHRoYXQgKnVuc3VjY2Vzc2Z1bCogcHVsbGluZ3Mg
YmV0d2VlbiBzbXRzIHdvdWxkIG5vdCByZXN1bHQgaW4gdW5zdGFibGVuZXNzLCBiZWNhdXNlDQo+
Pj4+Pj4gdGhlIGxvYWQtYmFsYW5jZSBhbHdheXMgZG8gcGVyaW9kaWNseSAsIGFuZCB1bnN1Y2Nl
c3MgbWVhbnMgbm90aGluZyBoYXBwZW4uDQo+Pj4+PiB1bnN1Y2Nlc3MgcHVsbGluZyBtZWFucyBt
b3JlIHVubmVjZXNzYXJ5IG92ZXJoZWFkIGluIGxvYWQgYmFsYW5jZS4NCj4+Pj4+IA0KPj4+Pj4+
IE9uIHRoZSBjb250cmFyeSwgdW5tYXRjaGVkIHNpYmxpbmcgdGFza3MgcnVubmluZyBjb25jdXJy
ZW50bHkgY291bGQgYnJpbmcgZm9yY2VkLWlkbGUgdG8gZWFjaCBvdGhlciByZXBlYXRlZGx5LA0K
Pj4+Pj4+IFdoaWNoIGlzIG1vcmUgdW5zdGFibGUsIGFuZCBtb3JlIGNvc3RseSB3aGVuIHBpY2tf
bmV4dF90YXNrIGZvciBhbGwgc2libGluZ3MuDQo+Pj4+PiBOb3Qgd29yc2UgdGhhbiB0d28gdGFz
a3MgcGluZy1wb25nIG9uIHRoZSBzYW1lIHRhcmdldCBydW4gcXVldWUgSSBndWVzcywgYW5kIGJl
dHRlciBpZg0KPj4+Pj4gLSB0YXNrMShjb29raWUgQSkgaXMgcnVubmluZyBvbiB0aGUgdGFyZ2V0
LCBhbmQgdGFzazIoY29va2llIEIpIGluIHRoZSBydW5xdWV1ZSwNCj4+Pj4+IC0gdGFzazMoY29v
a2llIEIpIGNvbWluZw0KPj4+Pj4gDQo+Pj4+PiBJZiB0YXNrMyBjaG9vc2VzIHRhcmdldCdzIHNp
YmxpbmcsIGl0IGNvdWxkIGhhdmUgYSBjaGFuY2UgdG8gcnVuIGNvbmN1cnJlbnRseSB3aXRoIHRh
c2syLg0KPj4+Pj4gQnV0IGlmIHRhc2szIGNob29zZXMgdGFyZ2V0LCBpdCB3aWxsIHdhaXQgZm9y
IG5leHQgcHVsbGluZyBsdWNrIG9mIGxvYWQgYmFsYW5jZXINCj4+Pj4gVGhhdOKAmXMgbW9yZSBp
bnRlcmVzdGluZy4gOikNCj4+Pj4gRGlzdHJpYnV0aW5nIGRpZmZlcmVudCBjb29raWUgdGFza3Mg
b250byBkaWZmZXJlbnQgY3B1cyhvciBjcHVzZXRzKSBjb3VsZCBiZSB0aGUgKmlkZWFsIHN0YWJs
ZSBzdGF0dXMqIHdlIHdhbnQsIGFzIEkgdW5kZXJzdG9vZC4NCj4+Pj4gRGlmZmVyZW50IGNvb2tp
ZSB0YXNrcyBydW5uaW5nIG9uIHNpYmxpbmcgc210cyBjb3VsZCBodXJ0IHBlcmZvcm1hbmNlLCBh
bmQgdGhhdCBzaG91bGQgYmUgYXZvaWRlZCB3aXRoIGJlc3QgZWZmb3J0Lg0KPj4+IFdlIGFscmVh
ZHkgdHJpZWQgdG8gYXZvaWQgd2hlbiB3ZSBzY2FuIGlkbGUgY29yZXMgYW5kIGlkbGUgY3B1cyBp
biBsbGMgZG9tYWluLg0KPj4gDQo+PiBJ4oCZbSBhZnJhaWQgdGhhdOKAmXMgbm90IGVub3VnaCBl
aXRoZXIsIDopDQo+PiAxLiBTY2FubmluZyBJZGxlIGNwdXMgaXMgbm90IGEgZnVsbCBzY2FuLCB0
aGVyZSBpcyBsaW1pdCBhY2NvcmRpbmcgdG8gc2NhbiBjb3N0Lg0KPj4gMi4gVGhhdCdzIG9ubHkg
dHJ5aW5nIGF0IHRoZSAqY29yZS9jcHUqIGxldmVsLCAqU01UKiBsZXZlbCBzaG91bGQgYmUgY29u
c2lkZXJlZCB0b28uIA0KPj4gDQo+Pj4gDQo+Pj4+IEZvciBhYm92ZSBjYXNlLCBzZWxlY3Rpbmcg
aWRsZSBzaWJsaW5nIGNwdSBjYW4gaW1wcm92ZSB0aGUgY29uY3VycmVuY3kgaW5kZWVkLCBidXQg
aXQgZGVjcmVhc2UgdGhlIGltYmFsYW5jZSBmb3IgbG9hZC1iYWxhbmNlci4NCj4+Pj4gSW4gdGhh
dCBjYXNlLCBsb2FkLWJhbGFuY2VyIGNvdWxkIG5vdCBub3RpY2UgdGhlIGltYmFsYW5jZSwgYW5k
IHdvdWxkIGRvIG5vdGhpbmcgdG8gaW1wcm92ZSB0aGUgdW5tYXRjaGVkIHNpdHVhdGlvbi4NCj4+
Pj4gT24gdGhlIGNvbnRyYXJ5LCBjaG9vc2luZyB0aGUgKnRhcmdldCogY3B1IGNvdWxkIGVuaGFu
Y2UgdGhlIGltYmFsYW5jZSwgYW5kIGxvYWQtYmFsYW5jZXIgY291bGQgdHJ5IHRvIHB1bGwgdW5t
YXRjaGVkIHRhc2sgYXdheSwNCj4+PiBQdWxsaW5nIGF3YXkgdG8gd2hlcmUgbmVlZHMgYW5vdGhl
ciBidW5jaCBvZiBlbGFib3JhdGlvbi4NCj4+IA0KPj4gU3RpbGwgd2l0aCB0aGUgU01UMiszdGFz
a3MgY2FzZSwgDQo+PiBpZiAqaWRsZSBzaWJsaW5nKiBjaG9zZW4sIA0KPj4gU210MeKAmXMgbG9h
ZCA9IHRhc2sxK3Rhc2syLCBzbXQy4oCZcyBsb2FkID0gdGFzazMuIFRhc2szIHdpbGwgcnVuIGlu
dGVybWl0dGVudGx5IGJlY2F1c2Ugb2YgZm9yY2VkLWlkbGUsIA0KPj4gc28gc210MuKAmXMgcmVh
bCBsb2FkIGNvdWxkIGxvdyBlbm91Z2gsIHRoYXQgaXQgY291bGQgbm90IGJlIHB1bGxlZCBhd2F5
IGZvcmV2ZXIuIFRoYXTigJlzIGluZGVlZCBhIHN0YWJsZSBzdGF0ZSwgDQo+PiBidXQgd2l0aCBw
ZXJmb3JtYW5jZSBhdCBhIGRpc2NvdW50LiANCj4+IA0KPj4gSWYgKnRhcmdldCBzaWJsaW5nKiBj
aG9zZSwNCj4+IFNtdDHigJlzIGxvYWQgPSB0YXNrMSt0YXNrMit0YXNrMywgc210MuKAmXMgbG9h
ZD0wLiBJdOKAmXMgYSBvYnZpb3VzIGltYmFsYW5jZSwgYW5kIGxvYWQtYmFsYW5jZXIgd2lsbCBw
aWNrIGEgdGFzayB0byBwdWxsLA0KPj4gMS4gSWYgdGFzazEoY29va2llIEEpIHBpY2tlZCwgdGhh
dOKAmXMgZG9uZSBmb3IgZ29vZC4NCj4+IDIuIElmIHRhc2syKGNvb2tpZSBCKSBvciB0YXNrMyhj
b29raWUgQikgcGlja2VkLCB0aGF04oCZcyBvayB0b28sIHRoZSByZXN0IHRhc2soY29va2llIEIp
IGNvdWxkIGJlIHB1bGxlZCBhd2F5IGF0IG5leHQgYmFsYW5jZShtYXliZSBuZWVkIHRvIGltcHJv
dmUgdGhlIHB1bGxpbmcgdG8gdGVuZCB0byBwdWxsIG1hdGNoZWQgdGFzayBtb3JlIGFnZ3Jlc3Np
dmVseSkuDQo+PiBBbmQgdGhlbiwgd2UgbWF5IHJlYWNoIGEgbW9yZSBzdGFibGUgc3RhdGUgKmds
b2JhbGx5KiB3aXRob3V0IHBlcmZvcm1hbmNlIGRpc2NvdW50Lg0KPiANCj4gSSdtIG5vdCBzdXJl
IHdoYXQgeW91IG1lYW4gcHVsbGVkIGF3YXksDQpJIG1lYW4gcHVsbGVkIGF3YXkgYnkgb3RoZXIg
Y3B1cywgbWF5IGJlIHRyaWdnZXJlZCBieSBpZGxlIGJhbGFuY2Ugb3IgcGVyaW9kaWMgYmFsYW5j
ZSBvbiBvdGhlciBjcHVzLg0KDQo+IC0gaWYgeW91IG1lYW4gcHVsbGVkIGF3YXkgZnJvbSB0aGlz
IGNvcmUsIGNvb2tpZUEgaW4gaWRsZSBzaWJsaW5nIGNhc2UgY2FuIGJlDQo+ICBwdWxsZWQgYXdh
eSB0b28uDQpZZXAsIGNvb2tpZUEodGFzazEpIGluIGlkbGUgc2libGluZyBjYXNlIGNvdWxkIGJl
IHB1bGxlZCBhd2F5LCBidXQgDQpjb29raWVCKHRhc2szKSBvbiB0aGUgc210MiBjb3VsZCBuZXZl
ciBnZXQgdGhlIGNoYW5jZSBiZWluZyBwdWxsZWQNCmF3YXkodW5sZXNzIGJlaW5nIHdha2VuIHVw
KS4gDQpJZiBjb29raWVBKHRhc2sxKSBmYWlsZWQgYmVpbmcgcHVsbGVkKGNvb2tpZUIodGFzazIp
IG9uIHNtdDEgbWF5IGJlIHB1bGxlZCwNCjUwJSBjaGFuY2UpLCBjb29raWVBKHRhc2sxKSBhbmQg
Y29va2llQih0YXNrMykgd291bGQgcmVhY2ggdGhlIHN0YWJsZSBzdGF0ZQ0Kd2l0aCBwZXJmb3Jt
YW5jZSBkaXNjb3VudC4NCg0KVGh4Lg0KUmVnYXJkcywNCkppYW5nDQoNCj4gLSBhbmQgaWYgeW91
IG1lYW4gcHVsbGVkIGF3YXkgYnV0IHdpdGhpbiB0aGlzIGNvcmUsIEkgZ3Vlc3MgY29va2llQiBp
biB0YXJnZXQNCj4gIHNpYmxpbmcgY2FzZSBjYW4ndCBiZSBwdWxsZWQgYXdheSBlaXRoZXIsIGFz
IG5yX3J1bm5pbmcgZGlmZmVyZW5jZSA9IDENCg0KDQoNCj4gDQo+IFRoYW5rcywNCj4gLUF1YnJl
eQ0KDQo=
