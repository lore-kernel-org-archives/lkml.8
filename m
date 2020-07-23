Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9684C20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="YWb2Ug22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGWEYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:24:02 -0400
Received: from mail4.tencent.com ([183.57.53.109]:51745 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGWEYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:24:01 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id 38FF8724AF;
        Thu, 23 Jul 2020 12:23:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595478236;
        bh=beF4uDCsUn8VAWBlxvMz29uabazmIL+ejFQYBdpbvhY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=YWb2Ug22fsFklZhKlgGX4zl1ct20xmuBBm3iLoUnNTKG3iJr/VdfxXzNxoSTeks9J
         92Lwqn038qS9pzvKB6h2ijbhrgOXSNTnMy+j1P5pzF/FhWFrYULqXOnf+z8E+J0hQw
         mJEdPbg8ReJisvD1b5kzG9vKMfHzAdgL+TiwC0r0=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 12:23:56 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 12:23:55 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 23 Jul 2020 12:23:52 +0800
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
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AIAAv1UAgAAMuwCAAA7NAIAADWQA
Date:   Thu, 23 Jul 2020 04:23:52 +0000
Message-ID: <96A765D7-7FD3-40EB-873B-0F9365569490@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
 <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
 <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
 <5C71B460-8DC3-44AF-A75E-68BB2E33686B@tencent.com>
 <589382b3-709e-17a6-d693-05ebd3998336@linux.intel.com>
 <897E5117-8A78-4CE3-8514-3577C4474775@tencent.com>
 <6ab8a001-ae5e-e484-c571-90d6931004e7@linux.intel.com>
In-Reply-To: <6ab8a001-ae5e-e484-c571-90d6931004e7@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.34]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB1029841D3EDB47B4EB847B4232EAEC@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQo+IE9uIEp1bCAyMywgMjAyMCwgYXQgMTE6MzUgQU0sIExpLCBBdWJyZXkgPGF1YnJleS5s
aUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyMC83LzIzIDEwOjQyLCBiZW5i
amlhbmco6JKL5b2qKSB3cm90ZToNCj4+IEhpLA0KPj4gDQo+Pj4gT24gSnVsIDIzLCAyMDIwLCBh
dCA5OjU3IEFNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlAbGludXguaW50ZWwuY29tPiB3cm90ZToN
Cj4+PiANCj4+PiBPbiAyMDIwLzcvMjIgMjI6MzIsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0K
Pj4+PiBIaSwNCj4+Pj4gDQo+Pj4+PiBPbiBKdWwgMjIsIDIwMjAsIGF0IDg6MTMgUE0sIExpLCBB
dWJyZXkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBP
biAyMDIwLzcvMjIgMTY6NTQsIGJlbmJqaWFuZyjokovlvaopIHdyb3RlOg0KPj4+Pj4+IEhpLCBB
dWJyZXksDQo+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEp1bCAxLCAyMDIwLCBhdCA1OjMyIEFNLCBWaW5l
ZXRoIFJlbWFuYW4gUGlsbGFpIDx2cGlsbGFpQGRpZ2l0YWxvY2Vhbi5jb20+IHdyb3RlOg0KPj4+
Pj4+PiANCj4+Pj4+Pj4gRnJvbTogQXVicmV5IExpIDxhdWJyZXkubGlAaW50ZWwuY29tPg0KPj4+
Pj4+PiANCj4+Pj4+Pj4gLSBEb24ndCBtaWdyYXRlIGlmIHRoZXJlIGlzIGEgY29va2llIG1pc21h
dGNoDQo+Pj4+Pj4+ICBMb2FkIGJhbGFuY2UgdHJpZXMgdG8gbW92ZSB0YXNrIGZyb20gYnVzaWVz
dCBDUFUgdG8gdGhlDQo+Pj4+Pj4+ICBkZXN0aW5hdGlvbiBDUFUuIFdoZW4gY29yZSBzY2hlZHVs
aW5nIGlzIGVuYWJsZWQsIGlmIHRoZQ0KPj4+Pj4+PiAgdGFzaydzIGNvb2tpZSBkb2VzIG5vdCBt
YXRjaCB3aXRoIHRoZSBkZXN0aW5hdGlvbiBDUFUncw0KPj4+Pj4+PiAgY29yZSBjb29raWUsIHRo
aXMgdGFzayB3aWxsIGJlIHNraXBwZWQgYnkgdGhpcyBDUFUuIFRoaXMNCj4+Pj4+Pj4gIG1pdGln
YXRlcyB0aGUgZm9yY2VkIGlkbGUgdGltZSBvbiB0aGUgZGVzdGluYXRpb24gQ1BVLg0KPj4+Pj4+
PiANCj4+Pj4+Pj4gLSBTZWxlY3QgY29va2llIG1hdGNoZWQgaWRsZSBDUFUNCj4+Pj4+Pj4gIElu
IHRoZSBmYXN0IHBhdGggb2YgdGFzayB3YWtldXAsIHNlbGVjdCB0aGUgZmlyc3QgY29va2llIG1h
dGNoZWQNCj4+Pj4+Pj4gIGlkbGUgQ1BVIGluc3RlYWQgb2YgdGhlIGZpcnN0IGlkbGUgQ1BVLg0K
Pj4+Pj4+PiANCj4+Pj4+Pj4gLSBGaW5kIGNvb2tpZSBtYXRjaGVkIGlkbGVzdCBDUFUNCj4+Pj4+
Pj4gIEluIHRoZSBzbG93IHBhdGggb2YgdGFzayB3YWtldXAsIGZpbmQgdGhlIGlkbGVzdCBDUFUg
d2hvc2UgY29yZQ0KPj4+Pj4+PiAgY29va2llIG1hdGNoZXMgd2l0aCB0YXNrJ3MgY29va2llDQo+
Pj4+Pj4+IA0KPj4+Pj4+PiAtIERvbid0IG1pZ3JhdGUgdGFzayBpZiBjb29raWUgbm90IG1hdGNo
DQo+Pj4+Pj4+ICBGb3IgdGhlIE5VTUEgbG9hZCBiYWxhbmNlLCBkb24ndCBtaWdyYXRlIHRhc2sg
dG8gdGhlIENQVSB3aG9zZQ0KPj4+Pj4+PiAgY29yZSBjb29raWUgZG9lcyBub3QgbWF0Y2ggd2l0
aCB0YXNrJ3MgY29va2llDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBdWJyZXkg
TGkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRp
bSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogVmluZWV0aCBSZW1hbmFuIFBpbGxhaSA8dnBpbGxhaUBkaWdpdGFsb2NlYW4uY29tPg0KPj4+
Pj4+PiAtLS0NCj4+Pj4+Pj4ga2VybmVsL3NjaGVkL2ZhaXIuYyAgfCA2NCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+Pj4+PiBrZXJuZWwvc2NoZWQvc2No
ZWQuaCB8IDI5ICsrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+IDIgZmlsZXMgY2hhbmdlZCwg
ODggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IGRpZmYg
LS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+Pj4+
PiBpbmRleCBkMTY5Mzk3NjYzNjEuLjMzZGM0YmYwMTgxNyAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEv
a2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+Pj4+PiArKysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+
Pj4+Pj4+IEBAIC0yMDUxLDYgKzIwNTEsMTUgQEAgc3RhdGljIHZvaWQgdGFza19udW1hX2ZpbmRf
Y3B1KHN0cnVjdCB0YXNrX251bWFfZW52ICplbnYsDQo+Pj4+Pj4+IAkJaWYgKCFjcHVtYXNrX3Rl
c3RfY3B1KGNwdSwgZW52LT5wLT5jcHVzX3B0cikpDQo+Pj4+Pj4+IAkJCWNvbnRpbnVlOw0KPj4+
Pj4+PiANCj4+Pj4+Pj4gKyNpZmRlZiBDT05GSUdfU0NIRURfQ09SRQ0KPj4+Pj4+PiArCQkvKg0K
Pj4+Pj4+PiArCQkgKiBTa2lwIHRoaXMgY3B1IGlmIHNvdXJjZSB0YXNrJ3MgY29va2llIGRvZXMg
bm90IG1hdGNoDQo+Pj4+Pj4+ICsJCSAqIHdpdGggQ1BVJ3MgY29yZSBjb29raWUuDQo+Pj4+Pj4+
ICsJCSAqLw0KPj4+Pj4+PiArCQlpZiAoIXNjaGVkX2NvcmVfY29va2llX21hdGNoKGNwdV9ycShj
cHUpLCBlbnYtPnApKQ0KPj4+Pj4+PiArCQkJY29udGludWU7DQo+Pj4+Pj4+ICsjZW5kaWYNCj4+
Pj4+Pj4gKw0KPj4+Pj4+PiAJCWVudi0+ZHN0X2NwdSA9IGNwdTsNCj4+Pj4+Pj4gCQlpZiAodGFz
a19udW1hX2NvbXBhcmUoZW52LCB0YXNraW1wLCBncm91cGltcCwgbWF5bW92ZSkpDQo+Pj4+Pj4+
IAkJCWJyZWFrOw0KPj4+Pj4+PiBAQCAtNTk2MywxMSArNTk3MiwxNyBAQCBmaW5kX2lkbGVzdF9n
cm91cF9jcHUoc3RydWN0IHNjaGVkX2dyb3VwICpncm91cCwgc3RydWN0IHRhc2tfc3RydWN0ICpw
LCBpbnQgdGhpcw0KPj4+Pj4+PiANCj4+Pj4+Pj4gCS8qIFRyYXZlcnNlIG9ubHkgdGhlIGFsbG93
ZWQgQ1BVcyAqLw0KPj4+Pj4+PiAJZm9yX2VhY2hfY3B1X2FuZChpLCBzY2hlZF9ncm91cF9zcGFu
KGdyb3VwKSwgcC0+Y3B1c19wdHIpIHsNCj4+Pj4+Pj4gKwkJc3RydWN0IHJxICpycSA9IGNwdV9y
cShpKTsNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+
Pj4+ICsJCWlmICghc2NoZWRfY29yZV9jb29raWVfbWF0Y2gocnEsIHApKQ0KPj4+Pj4+PiArCQkJ
Y29udGludWU7DQo+Pj4+Pj4+ICsjZW5kaWYNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiAJCWlmIChzY2hl
ZF9pZGxlX2NwdShpKSkNCj4+Pj4+Pj4gCQkJcmV0dXJuIGk7DQo+Pj4+Pj4+IA0KPj4+Pj4+PiAJ
CWlmIChhdmFpbGFibGVfaWRsZV9jcHUoaSkpIHsNCj4+Pj4+Pj4gLQkJCXN0cnVjdCBycSAqcnEg
PSBjcHVfcnEoaSk7DQo+Pj4+Pj4+IAkJCXN0cnVjdCBjcHVpZGxlX3N0YXRlICppZGxlID0gaWRs
ZV9nZXRfc3RhdGUocnEpOw0KPj4+Pj4+PiAJCQlpZiAoaWRsZSAmJiBpZGxlLT5leGl0X2xhdGVu
Y3kgPCBtaW5fZXhpdF9sYXRlbmN5KSB7DQo+Pj4+Pj4+IAkJCQkvKg0KPj4+Pj4+PiBAQCAtNjIy
NCw4ICs2MjM5LDE4IEBAIHN0YXRpYyBpbnQgc2VsZWN0X2lkbGVfY3B1KHN0cnVjdCB0YXNrX3N0
cnVjdCAqcCwgc3RydWN0IHNjaGVkX2RvbWFpbiAqc2QsIGludCB0DQo+Pj4+Pj4+IAlmb3JfZWFj
aF9jcHVfd3JhcChjcHUsIGNwdXMsIHRhcmdldCkgew0KPj4+Pj4+PiAJCWlmICghLS1ucikNCj4+
Pj4+Pj4gCQkJcmV0dXJuIC0xOw0KPj4+Pj4+PiAtCQlpZiAoYXZhaWxhYmxlX2lkbGVfY3B1KGNw
dSkgfHwgc2NoZWRfaWRsZV9jcHUoY3B1KSkNCj4+Pj4+Pj4gLQkJCWJyZWFrOw0KPj4+Pj4+PiAr
DQo+Pj4+Pj4+ICsJCWlmIChhdmFpbGFibGVfaWRsZV9jcHUoY3B1KSB8fCBzY2hlZF9pZGxlX2Nw
dShjcHUpKSB7DQo+Pj4+Pj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NPUkUNCj4+Pj4+Pj4gKwkJ
CS8qDQo+Pj4+Pj4+ICsJCQkgKiBJZiBDb3JlIFNjaGVkdWxpbmcgaXMgZW5hYmxlZCwgc2VsZWN0
IHRoaXMgY3B1DQo+Pj4+Pj4+ICsJCQkgKiBvbmx5IGlmIHRoZSBwcm9jZXNzIGNvb2tpZSBtYXRj
aGVzIGNvcmUgY29va2llLg0KPj4+Pj4+PiArCQkJICovDQo+Pj4+Pj4+ICsJCQlpZiAoc2NoZWRf
Y29yZV9lbmFibGVkKGNwdV9ycShjcHUpKSAmJg0KPj4+Pj4+PiArCQkJICAgIHAtPmNvcmVfY29v
a2llID09IGNwdV9ycShjcHUpLT5jb3JlLT5jb3JlX2Nvb2tpZSkNCj4+Pj4+PiBXaHkgbm90IGFs
c28gYWRkIHNpbWlsYXIgbG9naWMgaW4gc2VsZWN0X2lkbGVfc210IHRvIHJlZHVjZSBmb3JjZWQt
aWRsZT8gOikNCj4+Pj4+IFdlIGhpdCBzZWxlY3RfaWRsZV9zbXQgYWZ0ZXIgd2Ugc2NhbmVkIHRo
ZSBlbnRpcmUgTExDIGRvbWFpbiBmb3IgaWRsZSBjb3Jlcw0KPj4+Pj4gYW5kIGlkbGUgY3B1cyBh
bmQgZmFpbGVkLHNvIElNSE8sIGFuIGlkbGUgc210IGlzIHByb2JhYmx5IGEgZ29vZCBjaG9pY2Ug
dW5kZXINCj4+Pj4+IHRoaXMgc2NlbmFyaW8uDQo+Pj4+IA0KPj4+PiBBRkFJQywgc2VsZWN0aW5n
IGlkbGUgc2libGluZyB3aXRoIHVubWF0Y2hlZCBjb29raWUgd2lsbCBjYXVzZSB1bm5lY2Vzc2Fy
eSBmb3JlZC1pZGxlLCB1bmZhaXJuZXNzIGFuZCBsYXRlbmN5LCBjb21wYXJlZCB0byBjaG9vc2lu
ZyAqdGFyZ2V0KiBjcHUuDQo+Pj4gQ2hvb3NpbmcgdGFyZ2V0IGNwdSBjb3VsZCBpbmNyZWFzZSB0
aGUgcnVubmFibGUgdGFzayBudW1iZXIgb24gdGhlIHRhcmdldCBydW5xdWV1ZSwgdGhpcw0KPj4+
IGNvdWxkIHRyaWdnZXIgYnVzaWVzdC0+bnJfcnVubmluZyA+IDEgbG9naWMgYW5kIG1ha2VzIHRo
ZSBpZGxlIHNpYmxpbmcgdHJ5aW5nIHRvIHB1bGwgYnV0DQo+Pj4gbm90IHN1Y2Nlc3MoZHVlIHRv
IGNvb2tpZSBub3QgbWF0Y2gpLiBQdXR0aW5nIHRhc2sgdG8gdGhlIGlkbGUgc2libGluZyBpcyBy
ZWxhdGl2ZWx5IHN0YWJsZSBJTUhPLg0KPj4gDQo+PiBJ4oCZbSBhZnJhaWQgdGhhdCAqdW5zdWNj
ZXNzZnVsKiBwdWxsaW5ncyBiZXR3ZWVuIHNtdHMgd291bGQgbm90IHJlc3VsdCBpbiB1bnN0YWJs
ZW5lc3MsIGJlY2F1c2UNCj4+IHRoZSBsb2FkLWJhbGFuY2UgYWx3YXlzIGRvIHBlcmlvZGljbHkg
LCBhbmQgdW5zdWNjZXNzIG1lYW5zIG5vdGhpbmcgaGFwcGVuLg0KPiB1bnN1Y2Nlc3MgcHVsbGlu
ZyBtZWFucyBtb3JlIHVubmVjZXNzYXJ5IG92ZXJoZWFkIGluIGxvYWQgYmFsYW5jZS4NCj4gDQo+
PiBPbiB0aGUgY29udHJhcnksIHVubWF0Y2hlZCBzaWJsaW5nIHRhc2tzIHJ1bm5pbmcgY29uY3Vy
cmVudGx5IGNvdWxkIGJyaW5nIGZvcmNlZC1pZGxlIHRvIGVhY2ggb3RoZXIgcmVwZWF0ZWRseSwN
Cj4+IFdoaWNoIGlzIG1vcmUgdW5zdGFibGUsIGFuZCBtb3JlIGNvc3RseSB3aGVuIHBpY2tfbmV4
dF90YXNrIGZvciBhbGwgc2libGluZ3MuDQo+IE5vdCB3b3JzZSB0aGFuIHR3byB0YXNrcyBwaW5n
LXBvbmcgb24gdGhlIHNhbWUgdGFyZ2V0IHJ1biBxdWV1ZSBJIGd1ZXNzLCBhbmQgYmV0dGVyIGlm
DQo+IC0gdGFzazEoY29va2llIEEpIGlzIHJ1bm5pbmcgb24gdGhlIHRhcmdldCwgYW5kIHRhc2sy
KGNvb2tpZSBCKSBpbiB0aGUgcnVucXVldWUsDQo+IC0gdGFzazMoY29va2llIEIpIGNvbWluZw0K
PiANCj4gSWYgdGFzazMgY2hvb3NlcyB0YXJnZXQncyBzaWJsaW5nLCBpdCBjb3VsZCBoYXZlIGEg
Y2hhbmNlIHRvIHJ1biBjb25jdXJyZW50bHkgd2l0aCB0YXNrMi4NCj4gQnV0IGlmIHRhc2szIGNo
b29zZXMgdGFyZ2V0LCBpdCB3aWxsIHdhaXQgZm9yIG5leHQgcHVsbGluZyBsdWNrIG9mIGxvYWQg
YmFsYW5jZXINClRoYXTigJlzIG1vcmUgaW50ZXJlc3RpbmcuIDopDQpEaXN0cmlidXRpbmcgZGlm
ZmVyZW50IGNvb2tpZSB0YXNrcyBvbnRvIGRpZmZlcmVudCBjcHVzKG9yIGNwdXNldHMpIGNvdWxk
IGJlIHRoZSAqaWRlYWwgc3RhYmxlIHN0YXR1cyogd2Ugd2FudCwgYXMgSSB1bmRlcnN0b29kLg0K
RGlmZmVyZW50IGNvb2tpZSB0YXNrcyBydW5uaW5nIG9uIHNpYmxpbmcgc210cyBjb3VsZCBodXJ0
IHBlcmZvcm1hbmNlLCBhbmQgdGhhdCBzaG91bGQgYmUgYXZvaWRlZCB3aXRoIGJlc3QgZWZmb3J0
Lg0KRm9yIGFib3ZlIGNhc2UsIHNlbGVjdGluZyBpZGxlIHNpYmxpbmcgY3B1IGNhbiBpbXByb3Zl
IHRoZSBjb25jdXJyZW5jeSBpbmRlZWQsIGJ1dCBpdCBkZWNyZWFzZSB0aGUgaW1iYWxhbmNlIGZv
ciBsb2FkLWJhbGFuY2VyLg0KSW4gdGhhdCBjYXNlLCBsb2FkLWJhbGFuY2VyIGNvdWxkIG5vdCBu
b3RpY2UgdGhlIGltYmFsYW5jZSwgYW5kIHdvdWxkIGRvIG5vdGhpbmcgdG8gaW1wcm92ZSB0aGUg
dW5tYXRjaGVkIHNpdHVhdGlvbi4NCk9uIHRoZSBjb250cmFyeSwgY2hvb3NpbmcgdGhlICp0YXJn
ZXQqIGNwdSBjb3VsZCBlbmhhbmNlIHRoZSBpbWJhbGFuY2UsIGFuZCBsb2FkLWJhbGFuY2VyIGNv
dWxkIHRyeSB0byBwdWxsIHVubWF0Y2hlZCB0YXNrIGF3YXksDQp3aGljaCBjb3VsZCBpbXByb3Zl
IHRoZSB1bm1hdGNoZWQgc2l0dWF0aW9uIGFuZCBiZSBoZWxwZnVsIHRvIHJlYWNoIHRoZSAqaWRl
YWwgc3RhYmxlIHN0YXR1cyouIE1heWJlIHRoYXTigJlzIHdoYXQgd2UgZXhwZWN0LiA6KQ0KDQpU
aHguDQpSZWdhcmRzLA0KSmlhbmcNCg0KPiANCj4gVGhhbmtzLA0KPiAtQXVicmV5DQo+IA0KPj4g
SW4gY29uc2lkZXJhdGlvbiBvZiBjdXJyZW50bHkgbG9hZC1iYWxhbmNlIGJlaW5nIG5vdCBmdWxs
eSBhd2FyZSBvZiBjb3JlLXNjaGVkdWxpbmcsIGFuZCBjYW4gbm90IGltcHJvdmUNCj4+IHRoZSAq
dW5tYXRjaGVkIHNpYmxpbmcqIGNhc2UsIHRoZSAqZmluZF9pZGxlc3RfKiogZW50cnkgc2hvdWxk
IHRyeSBpdHMgYmVzdCB0byBhdm9pZCB0aGUgY2FzZSwgSU1ITy4NCj4gDQo+PiBBbHNvLCBqdXN0
IGFuIGFkdmljZSBhbmQgIGFuIG9wdGlvbi4gOikNCj4+IA0KPj4gVGh4Lg0KPj4gUmVnYXJkcywN
Cj4+IEppYW5nICANCj4+IA0KPj4+IA0KPj4+PiBCZXNpZGVzLCBjaG9vc2luZyAqdGFyZ2V0KiBj
cHUgbWF5IGJlIG1vcmUgY2FjaGUgZnJpZW5kbHkuIFNvIElNSE8sICp0YXJnZXQqIGNwdSBtYXkg
YmUgYSBiZXR0ZXIgY2hvaWNlIGlmIGNvb2tpZSBub3QgbWF0Y2gsIGluc3RlYWQgb2YgaWRsZSBz
aWJsaW5nLg0KPj4+IEknbSBub3Qgc3VyZSBpZiBpdCdzIG1vcmUgY2FjaGUgZnJpZW5kbHkgYXMg
dGhlIHRhcmdldCBpcyBidXN5LCBhbmQgdGhlIGNvbWluZyB0YXNrDQo+Pj4gaXMgYSBjb29raWUg
dW5tYXRjaGVkIHRhc2suDQoNCg==
