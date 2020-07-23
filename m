Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96417C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA73208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="auENynE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGWHrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:47:15 -0400
Received: from mail6.tencent.com ([220.249.245.26]:48567 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:47:14 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail6.tencent.com (Postfix) with ESMTP id CD833CC36B;
        Thu, 23 Jul 2020 15:48:12 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595490492;
        bh=kVBr1n9A8MinQNWKarXGwM/oWNqybgGSFI43Ru3P1zc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=auENynE7T7fmn/xPdTH6o3qE9owGZthDrhRQHHMaRG45saKylrxRsryG2+bbvz3HW
         mM6vMHKNmgnXtkLAJlaaXcRsaDFbc27bmETDHw3xVDVJmsu+73udNiGTNRIfWU8FgC
         bM4mJbJ1MK1dqsY7VPOcTWzT5wlQOL77lfLZOUyg=
Received: from EX-SZ004.tencent.com (10.28.6.25) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 15:47:04 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ004.tencent.com
 (10.28.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 15:47:03 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 23 Jul 2020 15:47:03 +0800
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
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AIAAv1UAgAAMuwCAAA7NAIAADWQAgAAVDACAACO4AA==
Date:   Thu, 23 Jul 2020 07:47:03 +0000
Message-ID: <325B98A4-9135-4138-AFED-ADFC3560D917@tencent.com>
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
In-Reply-To: <a4533d7f-41b0-3477-0316-0e2df55cbe9c@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE10A35E010F9C4D99518C80E81F904B@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDIzLCAyMDIwLCBhdCAxOjM5IFBNLCBMaSwgQXVicmV5IDxhdWJyZXku
bGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvNy8yMyAxMjoyMywgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwNCj4+PiBPbiBKdWwgMjMsIDIwMjAsIGF0IDEx
OjM1IEFNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+
PiANCj4+PiBPbiAyMDIwLzcvMjMgMTA6NDIsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+
PiBIaSwNCj4+Pj4gDQo+Pj4+PiBPbiBKdWwgMjMsIDIwMjAsIGF0IDk6NTcgQU0sIExpLCBBdWJy
ZXkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiAy
MDIwLzcvMjIgMjI6MzIsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+IEhpLA0KPj4+
Pj4+IA0KPj4+Pj4+PiBPbiBKdWwgMjIsIDIwMjAsIGF0IDg6MTMgUE0sIExpLCBBdWJyZXkgPGF1
YnJleS5saUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gMjAy
MC83LzIyIDE2OjU0LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4+Pj4+IEhpLCBBdWJy
ZXksDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBKdWwgMSwgMjAyMCwgYXQgNTozMiBBTSwgVmlu
ZWV0aCBSZW1hbmFuIFBpbGxhaSA8dnBpbGxhaUBkaWdpdGFsb2NlYW4uY29tPiB3cm90ZToNCj4+
Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBGcm9tOiBBdWJyZXkgTGkgPGF1YnJleS5saUBpbnRlbC5jb20+
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gLSBEb24ndCBtaWdyYXRlIGlmIHRoZXJlIGlzIGEgY29v
a2llIG1pc21hdGNoDQo+Pj4+Pj4+Pj4gTG9hZCBiYWxhbmNlIHRyaWVzIHRvIG1vdmUgdGFzayBm
cm9tIGJ1c2llc3QgQ1BVIHRvIHRoZQ0KPj4+Pj4+Pj4+IGRlc3RpbmF0aW9uIENQVS4gV2hlbiBj
b3JlIHNjaGVkdWxpbmcgaXMgZW5hYmxlZCwgaWYgdGhlDQo+Pj4+Pj4+Pj4gdGFzaydzIGNvb2tp
ZSBkb2VzIG5vdCBtYXRjaCB3aXRoIHRoZSBkZXN0aW5hdGlvbiBDUFUncw0KPj4+Pj4+Pj4+IGNv
cmUgY29va2llLCB0aGlzIHRhc2sgd2lsbCBiZSBza2lwcGVkIGJ5IHRoaXMgQ1BVLiBUaGlzDQo+
Pj4+Pj4+Pj4gbWl0aWdhdGVzIHRoZSBmb3JjZWQgaWRsZSB0aW1lIG9uIHRoZSBkZXN0aW5hdGlv
biBDUFUuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gLSBTZWxlY3QgY29va2llIG1hdGNoZWQgaWRs
ZSBDUFUNCj4+Pj4+Pj4+PiBJbiB0aGUgZmFzdCBwYXRoIG9mIHRhc2sgd2FrZXVwLCBzZWxlY3Qg
dGhlIGZpcnN0IGNvb2tpZSBtYXRjaGVkDQo+Pj4+Pj4+Pj4gaWRsZSBDUFUgaW5zdGVhZCBvZiB0
aGUgZmlyc3QgaWRsZSBDUFUuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gLSBGaW5kIGNvb2tpZSBt
YXRjaGVkIGlkbGVzdCBDUFUNCj4+Pj4+Pj4+PiBJbiB0aGUgc2xvdyBwYXRoIG9mIHRhc2sgd2Fr
ZXVwLCBmaW5kIHRoZSBpZGxlc3QgQ1BVIHdob3NlIGNvcmUNCj4+Pj4+Pj4+PiBjb29raWUgbWF0
Y2hlcyB3aXRoIHRhc2sncyBjb29raWUNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiAtIERvbid0IG1p
Z3JhdGUgdGFzayBpZiBjb29raWUgbm90IG1hdGNoDQo+Pj4+Pj4+Pj4gRm9yIHRoZSBOVU1BIGxv
YWQgYmFsYW5jZSwgZG9uJ3QgbWlncmF0ZSB0YXNrIHRvIHRoZSBDUFUgd2hvc2UNCj4+Pj4+Pj4+
PiBjb3JlIGNvb2tpZSBkb2VzIG5vdCBtYXRjaCB3aXRoIHRhc2sncyBjb29raWUNCj4+Pj4+Pj4+
PiANCj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBdWJyZXkgTGkgPGF1YnJleS5saUBsaW51eC5p
bnRlbC5jb20+DQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVGltIENoZW4gPHRpbS5jLmNoZW5A
bGludXguaW50ZWwuY29tPg0KPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZpbmVldGggUmVtYW5h
biBQaWxsYWkgPHZwaWxsYWlAZGlnaXRhbG9jZWFuLmNvbT4NCj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+
Pj4+PiBrZXJuZWwvc2NoZWQvZmFpci5jICB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+Pj4+Pj4+Pj4ga2VybmVsL3NjaGVkL3NjaGVkLmggfCAyOSAr
KysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0
IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+Pj4+Pj4+PiBp
bmRleCBkMTY5Mzk3NjYzNjEuLjMzZGM0YmYwMTgxNyAxMDA2NDQNCj4+Pj4+Pj4+PiAtLS0gYS9r
ZXJuZWwvc2NoZWQvZmFpci5jDQo+Pj4+Pj4+Pj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0K
Pj4+Pj4+Pj4+IEBAIC0yMDUxLDYgKzIwNTEsMTUgQEAgc3RhdGljIHZvaWQgdGFza19udW1hX2Zp
bmRfY3B1KHN0cnVjdCB0YXNrX251bWFfZW52ICplbnYsDQo+Pj4+Pj4+Pj4gCQlpZiAoIWNwdW1h
c2tfdGVzdF9jcHUoY3B1LCBlbnYtPnAtPmNwdXNfcHRyKSkNCj4+Pj4+Pj4+PiAJCQljb250aW51
ZTsNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+
Pj4+Pj4gKwkJLyoNCj4+Pj4+Pj4+PiArCQkgKiBTa2lwIHRoaXMgY3B1IGlmIHNvdXJjZSB0YXNr
J3MgY29va2llIGRvZXMgbm90IG1hdGNoDQo+Pj4+Pj4+Pj4gKwkJICogd2l0aCBDUFUncyBjb3Jl
IGNvb2tpZS4NCj4+Pj4+Pj4+PiArCQkgKi8NCj4+Pj4+Pj4+PiArCQlpZiAoIXNjaGVkX2NvcmVf
Y29va2llX21hdGNoKGNwdV9ycShjcHUpLCBlbnYtPnApKQ0KPj4+Pj4+Pj4+ICsJCQljb250aW51
ZTsNCj4+Pj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+IAkJZW52LT5kc3Rf
Y3B1ID0gY3B1Ow0KPj4+Pj4+Pj4+IAkJaWYgKHRhc2tfbnVtYV9jb21wYXJlKGVudiwgdGFza2lt
cCwgZ3JvdXBpbXAsIG1heW1vdmUpKQ0KPj4+Pj4+Pj4+IAkJCWJyZWFrOw0KPj4+Pj4+Pj4+IEBA
IC01OTYzLDExICs1OTcyLDE3IEBAIGZpbmRfaWRsZXN0X2dyb3VwX2NwdShzdHJ1Y3Qgc2NoZWRf
Z3JvdXAgKmdyb3VwLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCB0aGlzDQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gCS8qIFRyYXZlcnNlIG9ubHkgdGhlIGFsbG93ZWQgQ1BVcyAqLw0KPj4+Pj4+
Pj4+IAlmb3JfZWFjaF9jcHVfYW5kKGksIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApLCBwLT5jcHVz
X3B0cikgew0KPj4+Pj4+Pj4+ICsJCXN0cnVjdCBycSAqcnEgPSBjcHVfcnEoaSk7DQo+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NPUkUNCj4+Pj4+Pj4+PiArCQlp
ZiAoIXNjaGVkX2NvcmVfY29va2llX21hdGNoKHJxLCBwKSkNCj4+Pj4+Pj4+PiArCQkJY29udGlu
dWU7DQo+Pj4+Pj4+Pj4gKyNlbmRpZg0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiAJCWlmIChzY2hl
ZF9pZGxlX2NwdShpKSkNCj4+Pj4+Pj4+PiAJCQlyZXR1cm4gaTsNCj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+PiAJCWlmIChhdmFpbGFibGVfaWRsZV9jcHUoaSkpIHsNCj4+Pj4+Pj4+PiAtCQkJc3RydWN0
IHJxICpycSA9IGNwdV9ycShpKTsNCj4+Pj4+Pj4+PiAJCQlzdHJ1Y3QgY3B1aWRsZV9zdGF0ZSAq
aWRsZSA9IGlkbGVfZ2V0X3N0YXRlKHJxKTsNCj4+Pj4+Pj4+PiAJCQlpZiAoaWRsZSAmJiBpZGxl
LT5leGl0X2xhdGVuY3kgPCBtaW5fZXhpdF9sYXRlbmN5KSB7DQo+Pj4+Pj4+Pj4gCQkJCS8qDQo+
Pj4+Pj4+Pj4gQEAgLTYyMjQsOCArNjIzOSwxOCBAQCBzdGF0aWMgaW50IHNlbGVjdF9pZGxlX2Nw
dShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBzY2hlZF9kb21haW4gKnNkLCBpbnQgdA0K
Pj4+Pj4+Pj4+IAlmb3JfZWFjaF9jcHVfd3JhcChjcHUsIGNwdXMsIHRhcmdldCkgew0KPj4+Pj4+
Pj4+IAkJaWYgKCEtLW5yKQ0KPj4+Pj4+Pj4+IAkJCXJldHVybiAtMTsNCj4+Pj4+Pj4+PiAtCQlp
ZiAoYXZhaWxhYmxlX2lkbGVfY3B1KGNwdSkgfHwgc2NoZWRfaWRsZV9jcHUoY3B1KSkNCj4+Pj4+
Pj4+PiAtCQkJYnJlYWs7DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICsJCWlmIChhdmFpbGFibGVf
aWRsZV9jcHUoY3B1KSB8fCBzY2hlZF9pZGxlX2NwdShjcHUpKSB7DQo+Pj4+Pj4+Pj4gKyNpZmRl
ZiBDT05GSUdfU0NIRURfQ09SRQ0KPj4+Pj4+Pj4+ICsJCQkvKg0KPj4+Pj4+Pj4+ICsJCQkgKiBJ
ZiBDb3JlIFNjaGVkdWxpbmcgaXMgZW5hYmxlZCwgc2VsZWN0IHRoaXMgY3B1DQo+Pj4+Pj4+Pj4g
KwkJCSAqIG9ubHkgaWYgdGhlIHByb2Nlc3MgY29va2llIG1hdGNoZXMgY29yZSBjb29raWUuDQo+
Pj4+Pj4+Pj4gKwkJCSAqLw0KPj4+Pj4+Pj4+ICsJCQlpZiAoc2NoZWRfY29yZV9lbmFibGVkKGNw
dV9ycShjcHUpKSAmJg0KPj4+Pj4+Pj4+ICsJCQkgICAgcC0+Y29yZV9jb29raWUgPT0gY3B1X3Jx
KGNwdSktPmNvcmUtPmNvcmVfY29va2llKQ0KPj4+Pj4+Pj4gV2h5IG5vdCBhbHNvIGFkZCBzaW1p
bGFyIGxvZ2ljIGluIHNlbGVjdF9pZGxlX3NtdCB0byByZWR1Y2UgZm9yY2VkLWlkbGU/IDopDQo+
Pj4+Pj4+IFdlIGhpdCBzZWxlY3RfaWRsZV9zbXQgYWZ0ZXIgd2Ugc2NhbmVkIHRoZSBlbnRpcmUg
TExDIGRvbWFpbiBmb3IgaWRsZSBjb3Jlcw0KPj4+Pj4+PiBhbmQgaWRsZSBjcHVzIGFuZCBmYWls
ZWQsc28gSU1ITywgYW4gaWRsZSBzbXQgaXMgcHJvYmFibHkgYSBnb29kIGNob2ljZSB1bmRlcg0K
Pj4+Pj4+PiB0aGlzIHNjZW5hcmlvLg0KPj4+Pj4+IA0KPj4+Pj4+IEFGQUlDLCBzZWxlY3Rpbmcg
aWRsZSBzaWJsaW5nIHdpdGggdW5tYXRjaGVkIGNvb2tpZSB3aWxsIGNhdXNlIHVubmVjZXNzYXJ5
IGZvcmVkLWlkbGUsIHVuZmFpcm5lc3MgYW5kIGxhdGVuY3ksIGNvbXBhcmVkIHRvIGNob29zaW5n
ICp0YXJnZXQqIGNwdS4NCj4+Pj4+IENob29zaW5nIHRhcmdldCBjcHUgY291bGQgaW5jcmVhc2Ug
dGhlIHJ1bm5hYmxlIHRhc2sgbnVtYmVyIG9uIHRoZSB0YXJnZXQgcnVucXVldWUsIHRoaXMNCj4+
Pj4+IGNvdWxkIHRyaWdnZXIgYnVzaWVzdC0+bnJfcnVubmluZyA+IDEgbG9naWMgYW5kIG1ha2Vz
IHRoZSBpZGxlIHNpYmxpbmcgdHJ5aW5nIHRvIHB1bGwgYnV0DQo+Pj4+PiBub3Qgc3VjY2Vzcyhk
dWUgdG8gY29va2llIG5vdCBtYXRjaCkuIFB1dHRpbmcgdGFzayB0byB0aGUgaWRsZSBzaWJsaW5n
IGlzIHJlbGF0aXZlbHkgc3RhYmxlIElNSE8uDQo+Pj4+IA0KPj4+PiBJ4oCZbSBhZnJhaWQgdGhh
dCAqdW5zdWNjZXNzZnVsKiBwdWxsaW5ncyBiZXR3ZWVuIHNtdHMgd291bGQgbm90IHJlc3VsdCBp
biB1bnN0YWJsZW5lc3MsIGJlY2F1c2UNCj4+Pj4gdGhlIGxvYWQtYmFsYW5jZSBhbHdheXMgZG8g
cGVyaW9kaWNseSAsIGFuZCB1bnN1Y2Nlc3MgbWVhbnMgbm90aGluZyBoYXBwZW4uDQo+Pj4gdW5z
dWNjZXNzIHB1bGxpbmcgbWVhbnMgbW9yZSB1bm5lY2Vzc2FyeSBvdmVyaGVhZCBpbiBsb2FkIGJh
bGFuY2UuDQo+Pj4gDQo+Pj4+IE9uIHRoZSBjb250cmFyeSwgdW5tYXRjaGVkIHNpYmxpbmcgdGFz
a3MgcnVubmluZyBjb25jdXJyZW50bHkgY291bGQgYnJpbmcgZm9yY2VkLWlkbGUgdG8gZWFjaCBv
dGhlciByZXBlYXRlZGx5LA0KPj4+PiBXaGljaCBpcyBtb3JlIHVuc3RhYmxlLCBhbmQgbW9yZSBj
b3N0bHkgd2hlbiBwaWNrX25leHRfdGFzayBmb3IgYWxsIHNpYmxpbmdzLg0KPj4+IE5vdCB3b3Jz
ZSB0aGFuIHR3byB0YXNrcyBwaW5nLXBvbmcgb24gdGhlIHNhbWUgdGFyZ2V0IHJ1biBxdWV1ZSBJ
IGd1ZXNzLCBhbmQgYmV0dGVyIGlmDQo+Pj4gLSB0YXNrMShjb29raWUgQSkgaXMgcnVubmluZyBv
biB0aGUgdGFyZ2V0LCBhbmQgdGFzazIoY29va2llIEIpIGluIHRoZSBydW5xdWV1ZSwNCj4+PiAt
IHRhc2szKGNvb2tpZSBCKSBjb21pbmcNCj4+PiANCj4+PiBJZiB0YXNrMyBjaG9vc2VzIHRhcmdl
dCdzIHNpYmxpbmcsIGl0IGNvdWxkIGhhdmUgYSBjaGFuY2UgdG8gcnVuIGNvbmN1cnJlbnRseSB3
aXRoIHRhc2syLg0KPj4+IEJ1dCBpZiB0YXNrMyBjaG9vc2VzIHRhcmdldCwgaXQgd2lsbCB3YWl0
IGZvciBuZXh0IHB1bGxpbmcgbHVjayBvZiBsb2FkIGJhbGFuY2VyDQo+PiBUaGF04oCZcyBtb3Jl
IGludGVyZXN0aW5nLiA6KQ0KPj4gRGlzdHJpYnV0aW5nIGRpZmZlcmVudCBjb29raWUgdGFza3Mg
b250byBkaWZmZXJlbnQgY3B1cyhvciBjcHVzZXRzKSBjb3VsZCBiZSB0aGUgKmlkZWFsIHN0YWJs
ZSBzdGF0dXMqIHdlIHdhbnQsIGFzIEkgdW5kZXJzdG9vZC4NCj4+IERpZmZlcmVudCBjb29raWUg
dGFza3MgcnVubmluZyBvbiBzaWJsaW5nIHNtdHMgY291bGQgaHVydCBwZXJmb3JtYW5jZSwgYW5k
IHRoYXQgc2hvdWxkIGJlIGF2b2lkZWQgd2l0aCBiZXN0IGVmZm9ydC4NCj4gV2UgYWxyZWFkeSB0
cmllZCB0byBhdm9pZCB3aGVuIHdlIHNjYW4gaWRsZSBjb3JlcyBhbmQgaWRsZSBjcHVzIGluIGxs
YyBkb21haW4uDQoNCknigJltIGFmcmFpZCB0aGF04oCZcyBub3QgZW5vdWdoIGVpdGhlciwgOikN
CjEuIFNjYW5uaW5nIElkbGUgY3B1cyBpcyBub3QgYSBmdWxsIHNjYW4sIHRoZXJlIGlzIGxpbWl0
IGFjY29yZGluZyB0byBzY2FuIGNvc3QuDQoyLiBUaGF0J3Mgb25seSB0cnlpbmcgYXQgdGhlICpj
b3JlL2NwdSogbGV2ZWwsICpTTVQqIGxldmVsIHNob3VsZCBiZSBjb25zaWRlcmVkIHRvby4gDQoN
Cj4gDQo+PiBGb3IgYWJvdmUgY2FzZSwgc2VsZWN0aW5nIGlkbGUgc2libGluZyBjcHUgY2FuIGlt
cHJvdmUgdGhlIGNvbmN1cnJlbmN5IGluZGVlZCwgYnV0IGl0IGRlY3JlYXNlIHRoZSBpbWJhbGFu
Y2UgZm9yIGxvYWQtYmFsYW5jZXIuDQo+PiBJbiB0aGF0IGNhc2UsIGxvYWQtYmFsYW5jZXIgY291
bGQgbm90IG5vdGljZSB0aGUgaW1iYWxhbmNlLCBhbmQgd291bGQgZG8gbm90aGluZyB0byBpbXBy
b3ZlIHRoZSB1bm1hdGNoZWQgc2l0dWF0aW9uLg0KPj4gT24gdGhlIGNvbnRyYXJ5LCBjaG9vc2lu
ZyB0aGUgKnRhcmdldCogY3B1IGNvdWxkIGVuaGFuY2UgdGhlIGltYmFsYW5jZSwgYW5kIGxvYWQt
YmFsYW5jZXIgY291bGQgdHJ5IHRvIHB1bGwgdW5tYXRjaGVkIHRhc2sgYXdheSwNCj4gUHVsbGlu
ZyBhd2F5IHRvIHdoZXJlIG5lZWRzIGFub3RoZXIgYnVuY2ggb2YgZWxhYm9yYXRpb24uDQoNClN0
aWxsIHdpdGggdGhlIFNNVDIrM3Rhc2tzIGNhc2UsIA0KaWYgKmlkbGUgc2libGluZyogY2hvc2Vu
LCANClNtdDHigJlzIGxvYWQgPSB0YXNrMSt0YXNrMiwgc210MuKAmXMgbG9hZCA9IHRhc2szLiBU
YXNrMyB3aWxsIHJ1biBpbnRlcm1pdHRlbnRseSBiZWNhdXNlIG9mIGZvcmNlZC1pZGxlLCANCnNv
IHNtdDLigJlzIHJlYWwgbG9hZCBjb3VsZCBsb3cgZW5vdWdoLCB0aGF0IGl0IGNvdWxkIG5vdCBi
ZSBwdWxsZWQgYXdheSBmb3JldmVyLiBUaGF04oCZcyBpbmRlZWQgYSBzdGFibGUgc3RhdGUsIA0K
YnV0IHdpdGggcGVyZm9ybWFuY2UgYXQgYSBkaXNjb3VudC4gDQoNCklmICp0YXJnZXQgc2libGlu
ZyogY2hvc2UsDQpTbXQx4oCZcyBsb2FkID0gdGFzazErdGFzazIrdGFzazMsIHNtdDLigJlzIGxv
YWQ9MC4gSXTigJlzIGEgb2J2aW91cyBpbWJhbGFuY2UsIGFuZCBsb2FkLWJhbGFuY2VyIHdpbGwg
cGljayBhIHRhc2sgdG8gcHVsbCwNCjEuIElmIHRhc2sxKGNvb2tpZSBBKSBwaWNrZWQsIHRoYXTi
gJlzIGRvbmUgZm9yIGdvb2QuDQoyLiBJZiB0YXNrMihjb29raWUgQikgb3IgdGFzazMoY29va2ll
IEIpIHBpY2tlZCwgdGhhdOKAmXMgb2sgdG9vLCB0aGUgcmVzdCB0YXNrKGNvb2tpZSBCKSBjb3Vs
ZCBiZSBwdWxsZWQgYXdheSBhdCBuZXh0IGJhbGFuY2UobWF5YmUgbmVlZCB0byBpbXByb3ZlIHRo
ZSBwdWxsaW5nIHRvIHRlbmQgdG8gcHVsbCBtYXRjaGVkIHRhc2sgbW9yZSBhZ2dyZXNzaXZlbHkp
Lg0KQW5kIHRoZW4sIHdlIG1heSByZWFjaCBhIG1vcmUgc3RhYmxlIHN0YXRlICpnbG9iYWxseSog
d2l0aG91dCBwZXJmb3JtYW5jZSBkaXNjb3VudC4NCg0KSU1ITywgbWF5YmUgd3JvbmcuIDotKQ0K
DQpUaHguDQpSZWdhcmRzLA0KSmlhbmcgDQoNCj4+IHdoaWNoIGNvdWxkIGltcHJvdmUgdGhlIHVu
bWF0Y2hlZCBzaXR1YXRpb24gYW5kIGJlIGhlbHBmdWwgdG8gcmVhY2ggdGhlICppZGVhbCBzdGFi
bGUgc3RhdHVzKi4gTWF5YmUgdGhhdOKAmXMgd2hhdCB3ZSBleHBlY3QuIDopDQo+PiANCj4gSWYg
d2UgbGltaXQgdG8gdGhpcyBvbmUtY29yZSB0d28tc2libGluZyB0aHJlZS10YXNrcyBjYXNlLCBj
aG9vc2luZyB0aGUgaWRsZSBzaWJsaW5nIGlzIHRoZSBpZGVhbCBzdGFibGUNCj4gc3RhdHVzLCBh
cyBpdCBzYXZlcyBvbmUgbHVja3kgbG9hZCBiYWxhbmNlciBwdWxsaW5nIGFuZCB0YXNrIG1pZ3Jh
dGlvbi4NCj4gDQo+IFRoYW5rcywNCj4gLUF1YnJleQ0KDQo=
