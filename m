Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A47C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7929F20825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="cmpLbqFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgGWCnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:43:05 -0400
Received: from mail4.tencent.com ([183.57.53.109]:45916 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgGWCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:43:04 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail4.tencent.com (Postfix) with ESMTP id 99C9C72537;
        Thu, 23 Jul 2020 10:42:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595472179;
        bh=P7DXuGe7BPTlhzSjRiXo0IJBUne2JAufrISSWucCG9s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=cmpLbqFuVFkr2cNbwzDCa8pPs1ug3E2tJR4vJF5bIRAg0KZQ4yYvHOlgU6f4AlFCr
         7q5s8OdgG35oHE3fAsL8ugJN0BvzZVhL9hKF062qse+8sLu7ks9p17yHqmVwDUAcOE
         Meqf+OArptnzmfYrHyBhpsiosYMA50wGzIOLXr/w=
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 10:42:59 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ006.tencent.com
 (10.28.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Jul
 2020 10:42:59 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Thu, 23 Jul 2020 10:42:59 +0800
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
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AIAAv1UAgAAMuwA=
Date:   Thu, 23 Jul 2020 02:42:58 +0000
Message-ID: <897E5117-8A78-4CE3-8514-3577C4474775@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
 <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
 <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
 <5C71B460-8DC3-44AF-A75E-68BB2E33686B@tencent.com>
 <589382b3-709e-17a6-d693-05ebd3998336@linux.intel.com>
In-Reply-To: <589382b3-709e-17a6-d693-05ebd3998336@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.34]
Content-Type: text/plain; charset="utf-8"
Content-ID: <543B5CEF353EAE448DBE0197D7D60A6D@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDIzLCAyMDIwLCBhdCA5OjU3IEFNLCBMaSwgQXVicmV5IDxhdWJyZXku
bGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvNy8yMiAyMjozMiwgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4+IE9uIEp1bCAyMiwgMjAyMCwg
YXQgODoxMyBQTSwgTGksIEF1YnJleSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6
DQo+Pj4gDQo+Pj4gT24gMjAyMC83LzIyIDE2OjU0LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToN
Cj4+Pj4gSGksIEF1YnJleSwNCj4+Pj4gDQo+Pj4+PiBPbiBKdWwgMSwgMjAyMCwgYXQgNTozMiBB
TSwgVmluZWV0aCBSZW1hbmFuIFBpbGxhaSA8dnBpbGxhaUBkaWdpdGFsb2NlYW4uY29tPiB3cm90
ZToNCj4+Pj4+IA0KPj4+Pj4gRnJvbTogQXVicmV5IExpIDxhdWJyZXkubGlAaW50ZWwuY29tPg0K
Pj4+Pj4gDQo+Pj4+PiAtIERvbid0IG1pZ3JhdGUgaWYgdGhlcmUgaXMgYSBjb29raWUgbWlzbWF0
Y2gNCj4+Pj4+ICAgTG9hZCBiYWxhbmNlIHRyaWVzIHRvIG1vdmUgdGFzayBmcm9tIGJ1c2llc3Qg
Q1BVIHRvIHRoZQ0KPj4+Pj4gICBkZXN0aW5hdGlvbiBDUFUuIFdoZW4gY29yZSBzY2hlZHVsaW5n
IGlzIGVuYWJsZWQsIGlmIHRoZQ0KPj4+Pj4gICB0YXNrJ3MgY29va2llIGRvZXMgbm90IG1hdGNo
IHdpdGggdGhlIGRlc3RpbmF0aW9uIENQVSdzDQo+Pj4+PiAgIGNvcmUgY29va2llLCB0aGlzIHRh
c2sgd2lsbCBiZSBza2lwcGVkIGJ5IHRoaXMgQ1BVLiBUaGlzDQo+Pj4+PiAgIG1pdGlnYXRlcyB0
aGUgZm9yY2VkIGlkbGUgdGltZSBvbiB0aGUgZGVzdGluYXRpb24gQ1BVLg0KPj4+Pj4gDQo+Pj4+
PiAtIFNlbGVjdCBjb29raWUgbWF0Y2hlZCBpZGxlIENQVQ0KPj4+Pj4gICBJbiB0aGUgZmFzdCBw
YXRoIG9mIHRhc2sgd2FrZXVwLCBzZWxlY3QgdGhlIGZpcnN0IGNvb2tpZSBtYXRjaGVkDQo+Pj4+
PiAgIGlkbGUgQ1BVIGluc3RlYWQgb2YgdGhlIGZpcnN0IGlkbGUgQ1BVLg0KPj4+Pj4gDQo+Pj4+
PiAtIEZpbmQgY29va2llIG1hdGNoZWQgaWRsZXN0IENQVQ0KPj4+Pj4gICBJbiB0aGUgc2xvdyBw
YXRoIG9mIHRhc2sgd2FrZXVwLCBmaW5kIHRoZSBpZGxlc3QgQ1BVIHdob3NlIGNvcmUNCj4+Pj4+
ICAgY29va2llIG1hdGNoZXMgd2l0aCB0YXNrJ3MgY29va2llDQo+Pj4+PiANCj4+Pj4+IC0gRG9u
J3QgbWlncmF0ZSB0YXNrIGlmIGNvb2tpZSBub3QgbWF0Y2gNCj4+Pj4+ICAgRm9yIHRoZSBOVU1B
IGxvYWQgYmFsYW5jZSwgZG9uJ3QgbWlncmF0ZSB0YXNrIHRvIHRoZSBDUFUgd2hvc2UNCj4+Pj4+
ICAgY29yZSBjb29raWUgZG9lcyBub3QgbWF0Y2ggd2l0aCB0YXNrJ3MgY29va2llDQo+Pj4+PiAN
Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEF1YnJleSBMaSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNv
bT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVs
LmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZpbmVldGggUmVtYW5hbiBQaWxsYWkgPHZwaWxs
YWlAZGlnaXRhbG9jZWFuLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4ga2VybmVsL3NjaGVkL2ZhaXIu
YyAgfCA2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+
Pj4ga2VybmVsL3NjaGVkL3NjaGVkLmggfCAyOSArKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4g
MiBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pj4g
DQo+Pj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9m
YWlyLmMNCj4+Pj4+IGluZGV4IGQxNjkzOTc2NjM2MS4uMzNkYzRiZjAxODE3IDEwMDY0NA0KPj4+
Pj4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+Pj4gKysrIGIva2VybmVsL3NjaGVkL2Zh
aXIuYw0KPj4+Pj4gQEAgLTIwNTEsNiArMjA1MSwxNSBAQCBzdGF0aWMgdm9pZCB0YXNrX251bWFf
ZmluZF9jcHUoc3RydWN0IHRhc2tfbnVtYV9lbnYgKmVudiwNCj4+Pj4+IAkJaWYgKCFjcHVtYXNr
X3Rlc3RfY3B1KGNwdSwgZW52LT5wLT5jcHVzX3B0cikpDQo+Pj4+PiAJCQljb250aW51ZTsNCj4+
Pj4+IA0KPj4+Pj4gKyNpZmRlZiBDT05GSUdfU0NIRURfQ09SRQ0KPj4+Pj4gKwkJLyoNCj4+Pj4+
ICsJCSAqIFNraXAgdGhpcyBjcHUgaWYgc291cmNlIHRhc2sncyBjb29raWUgZG9lcyBub3QgbWF0
Y2gNCj4+Pj4+ICsJCSAqIHdpdGggQ1BVJ3MgY29yZSBjb29raWUuDQo+Pj4+PiArCQkgKi8NCj4+
Pj4+ICsJCWlmICghc2NoZWRfY29yZV9jb29raWVfbWF0Y2goY3B1X3JxKGNwdSksIGVudi0+cCkp
DQo+Pj4+PiArCQkJY29udGludWU7DQo+Pj4+PiArI2VuZGlmDQo+Pj4+PiArDQo+Pj4+PiAJCWVu
di0+ZHN0X2NwdSA9IGNwdTsNCj4+Pj4+IAkJaWYgKHRhc2tfbnVtYV9jb21wYXJlKGVudiwgdGFz
a2ltcCwgZ3JvdXBpbXAsIG1heW1vdmUpKQ0KPj4+Pj4gCQkJYnJlYWs7DQo+Pj4+PiBAQCAtNTk2
MywxMSArNTk3MiwxNyBAQCBmaW5kX2lkbGVzdF9ncm91cF9jcHUoc3RydWN0IHNjaGVkX2dyb3Vw
ICpncm91cCwgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgdGhpcw0KPj4+Pj4gDQo+Pj4+PiAJ
LyogVHJhdmVyc2Ugb25seSB0aGUgYWxsb3dlZCBDUFVzICovDQo+Pj4+PiAJZm9yX2VhY2hfY3B1
X2FuZChpLCBzY2hlZF9ncm91cF9zcGFuKGdyb3VwKSwgcC0+Y3B1c19wdHIpIHsNCj4+Pj4+ICsJ
CXN0cnVjdCBycSAqcnEgPSBjcHVfcnEoaSk7DQo+Pj4+PiArDQo+Pj4+PiArI2lmZGVmIENPTkZJ
R19TQ0hFRF9DT1JFDQo+Pj4+PiArCQlpZiAoIXNjaGVkX2NvcmVfY29va2llX21hdGNoKHJxLCBw
KSkNCj4+Pj4+ICsJCQljb250aW51ZTsNCj4+Pj4+ICsjZW5kaWYNCj4+Pj4+ICsNCj4+Pj4+IAkJ
aWYgKHNjaGVkX2lkbGVfY3B1KGkpKQ0KPj4+Pj4gCQkJcmV0dXJuIGk7DQo+Pj4+PiANCj4+Pj4+
IAkJaWYgKGF2YWlsYWJsZV9pZGxlX2NwdShpKSkgew0KPj4+Pj4gLQkJCXN0cnVjdCBycSAqcnEg
PSBjcHVfcnEoaSk7DQo+Pj4+PiAJCQlzdHJ1Y3QgY3B1aWRsZV9zdGF0ZSAqaWRsZSA9IGlkbGVf
Z2V0X3N0YXRlKHJxKTsNCj4+Pj4+IAkJCWlmIChpZGxlICYmIGlkbGUtPmV4aXRfbGF0ZW5jeSA8
IG1pbl9leGl0X2xhdGVuY3kpIHsNCj4+Pj4+IAkJCQkvKg0KPj4+Pj4gQEAgLTYyMjQsOCArNjIz
OSwxOCBAQCBzdGF0aWMgaW50IHNlbGVjdF9pZGxlX2NwdShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAs
IHN0cnVjdCBzY2hlZF9kb21haW4gKnNkLCBpbnQgdA0KPj4+Pj4gCWZvcl9lYWNoX2NwdV93cmFw
KGNwdSwgY3B1cywgdGFyZ2V0KSB7DQo+Pj4+PiAJCWlmICghLS1ucikNCj4+Pj4+IAkJCXJldHVy
biAtMTsNCj4+Pj4+IC0JCWlmIChhdmFpbGFibGVfaWRsZV9jcHUoY3B1KSB8fCBzY2hlZF9pZGxl
X2NwdShjcHUpKQ0KPj4+Pj4gLQkJCWJyZWFrOw0KPj4+Pj4gKw0KPj4+Pj4gKwkJaWYgKGF2YWls
YWJsZV9pZGxlX2NwdShjcHUpIHx8IHNjaGVkX2lkbGVfY3B1KGNwdSkpIHsNCj4+Pj4+ICsjaWZk
ZWYgQ09ORklHX1NDSEVEX0NPUkUNCj4+Pj4+ICsJCQkvKg0KPj4+Pj4gKwkJCSAqIElmIENvcmUg
U2NoZWR1bGluZyBpcyBlbmFibGVkLCBzZWxlY3QgdGhpcyBjcHUNCj4+Pj4+ICsJCQkgKiBvbmx5
IGlmIHRoZSBwcm9jZXNzIGNvb2tpZSBtYXRjaGVzIGNvcmUgY29va2llLg0KPj4+Pj4gKwkJCSAq
Lw0KPj4+Pj4gKwkJCWlmIChzY2hlZF9jb3JlX2VuYWJsZWQoY3B1X3JxKGNwdSkpICYmDQo+Pj4+
PiArCQkJICAgIHAtPmNvcmVfY29va2llID09IGNwdV9ycShjcHUpLT5jb3JlLT5jb3JlX2Nvb2tp
ZSkNCj4+Pj4gV2h5IG5vdCBhbHNvIGFkZCBzaW1pbGFyIGxvZ2ljIGluIHNlbGVjdF9pZGxlX3Nt
dCB0byByZWR1Y2UgZm9yY2VkLWlkbGU/IDopDQo+Pj4gV2UgaGl0IHNlbGVjdF9pZGxlX3NtdCBh
ZnRlciB3ZSBzY2FuZWQgdGhlIGVudGlyZSBMTEMgZG9tYWluIGZvciBpZGxlIGNvcmVzDQo+Pj4g
YW5kIGlkbGUgY3B1cyBhbmQgZmFpbGVkLHNvIElNSE8sIGFuIGlkbGUgc210IGlzIHByb2JhYmx5
IGEgZ29vZCBjaG9pY2UgdW5kZXINCj4+PiB0aGlzIHNjZW5hcmlvLg0KPj4gDQo+PiBBRkFJQywg
c2VsZWN0aW5nIGlkbGUgc2libGluZyB3aXRoIHVubWF0Y2hlZCBjb29raWUgd2lsbCBjYXVzZSB1
bm5lY2Vzc2FyeSBmb3JlZC1pZGxlLCB1bmZhaXJuZXNzIGFuZCBsYXRlbmN5LCBjb21wYXJlZCB0
byBjaG9vc2luZyAqdGFyZ2V0KiBjcHUuDQo+IENob29zaW5nIHRhcmdldCBjcHUgY291bGQgaW5j
cmVhc2UgdGhlIHJ1bm5hYmxlIHRhc2sgbnVtYmVyIG9uIHRoZSB0YXJnZXQgcnVucXVldWUsIHRo
aXMNCj4gY291bGQgdHJpZ2dlciBidXNpZXN0LT5ucl9ydW5uaW5nID4gMSBsb2dpYyBhbmQgbWFr
ZXMgdGhlIGlkbGUgc2libGluZyB0cnlpbmcgdG8gcHVsbCBidXQNCj4gbm90IHN1Y2Nlc3MoZHVl
IHRvIGNvb2tpZSBub3QgbWF0Y2gpLiBQdXR0aW5nIHRhc2sgdG8gdGhlIGlkbGUgc2libGluZyBp
cyByZWxhdGl2ZWx5IHN0YWJsZSBJTUhPLg0KDQpJ4oCZbSBhZnJhaWQgdGhhdCAqdW5zdWNjZXNz
ZnVsKiBwdWxsaW5ncyBiZXR3ZWVuIHNtdHMgd291bGQgbm90IHJlc3VsdCBpbiB1bnN0YWJsZW5l
c3MsIGJlY2F1c2UNCnRoZSBsb2FkLWJhbGFuY2UgYWx3YXlzIGRvIHBlcmlvZGljbHkgLCBhbmQg
dW5zdWNjZXNzIG1lYW5zIG5vdGhpbmcgaGFwcGVuLg0KT24gdGhlIGNvbnRyYXJ5LCB1bm1hdGNo
ZWQgc2libGluZyB0YXNrcyBydW5uaW5nIGNvbmN1cnJlbnRseSBjb3VsZCBicmluZyBmb3JjZWQt
aWRsZSB0byBlYWNoIG90aGVyIHJlcGVhdGVkbHksDQpXaGljaCBpcyBtb3JlIHVuc3RhYmxlLCBh
bmQgbW9yZSBjb3N0bHkgd2hlbiBwaWNrX25leHRfdGFzayBmb3IgYWxsIHNpYmxpbmdzLg0KSW4g
Y29uc2lkZXJhdGlvbiBvZiBjdXJyZW50bHkgbG9hZC1iYWxhbmNlIGJlaW5nIG5vdCBmdWxseSBh
d2FyZSBvZiBjb3JlLXNjaGVkdWxpbmcsIGFuZCBjYW4gbm90IGltcHJvdmUNCnRoZSAqdW5tYXRj
aGVkIHNpYmxpbmcqIGNhc2UsIHRoZSAqZmluZF9pZGxlc3RfKiogZW50cnkgc2hvdWxkIHRyeSBp
dHMgYmVzdCB0byBhdm9pZCB0aGUgY2FzZSwgSU1ITy4NCkFsc28sIGp1c3QgYW4gYWR2aWNlIGFu
ZCAgYW4gb3B0aW9uLiA6KQ0KDQpUaHguDQpSZWdhcmRzLA0KSmlhbmcgIA0KDQo+IA0KPj4gQmVz
aWRlcywgY2hvb3NpbmcgKnRhcmdldCogY3B1IG1heSBiZSBtb3JlIGNhY2hlIGZyaWVuZGx5LiBT
byBJTUhPLCAqdGFyZ2V0KiBjcHUgbWF5IGJlIGEgYmV0dGVyIGNob2ljZSBpZiBjb29raWUgbm90
IG1hdGNoLCBpbnN0ZWFkIG9mIGlkbGUgc2libGluZy4NCj4gSSdtIG5vdCBzdXJlIGlmIGl0J3Mg
bW9yZSBjYWNoZSBmcmllbmRseSBhcyB0aGUgdGFyZ2V0IGlzIGJ1c3ksIGFuZCB0aGUgY29taW5n
IHRhc2sNCj4gaXMgYSBjb29raWUgdW5tYXRjaGVkIHRhc2suDQo+IA0KPj4gDQo+Pj4gDQo+Pj4+
IA0KPj4+Pj4gKyNlbmRpZg0KPj4+Pj4gKwkJCQlicmVhazsNCj4+Pj4+ICsJCX0NCj4+Pj4+IAl9
DQo+Pj4+PiANCj4+Pj4+IAl0aW1lID0gY3B1X2Nsb2NrKHRoaXMpIC0gdGltZTsNCj4+Pj4+IEBA
IC03NjA5LDggKzc2MzQsOSBAQCBpbnQgY2FuX21pZ3JhdGVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnAsIHN0cnVjdCBsYl9lbnYgKmVudikNCj4+Pj4+IAkgKiBXZSBkbyBub3QgbWlncmF0ZSB0
YXNrcyB0aGF0IGFyZToNCj4+Pj4+IAkgKiAxKSB0aHJvdHRsZWRfbGJfcGFpciwgb3INCj4+Pj4+
IAkgKiAyKSBjYW5ub3QgYmUgbWlncmF0ZWQgdG8gdGhpcyBDUFUgZHVlIHRvIGNwdXNfcHRyLCBv
cg0KPj4+Pj4gLQkgKiAzKSBydW5uaW5nIChvYnZpb3VzbHkpLCBvcg0KPj4+Pj4gLQkgKiA0KSBh
cmUgY2FjaGUtaG90IG9uIHRoZWlyIGN1cnJlbnQgQ1BVLg0KPj4+Pj4gKwkgKiAzKSB0YXNrJ3Mg
Y29va2llIGRvZXMgbm90IG1hdGNoIHdpdGggdGhpcyBDUFUncyBjb3JlIGNvb2tpZQ0KPj4+Pj4g
KwkgKiA0KSBydW5uaW5nIChvYnZpb3VzbHkpLCBvcg0KPj4+Pj4gKwkgKiA1KSBhcmUgY2FjaGUt
aG90IG9uIHRoZWlyIGN1cnJlbnQgQ1BVLg0KPj4+Pj4gCSAqLw0KPj4+Pj4gCWlmICh0aHJvdHRs
ZWRfbGJfcGFpcih0YXNrX2dyb3VwKHApLCBlbnYtPnNyY19jcHUsIGVudi0+ZHN0X2NwdSkpDQo+
Pj4+PiAJCXJldHVybiAwOw0KPj4+Pj4gQEAgLTc2NDUsNiArNzY3MSwxNSBAQCBpbnQgY2FuX21p
Z3JhdGVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBsYl9lbnYgKmVudikNCj4+
Pj4+IAkJcmV0dXJuIDA7DQo+Pj4+PiAJfQ0KPj4+Pj4gDQo+Pj4+PiArI2lmZGVmIENPTkZJR19T
Q0hFRF9DT1JFDQo+Pj4+PiArCS8qDQo+Pj4+PiArCSAqIERvbid0IG1pZ3JhdGUgdGFzayBpZiB0
aGUgdGFzaydzIGNvb2tpZSBkb2VzIG5vdCBtYXRjaA0KPj4+Pj4gKwkgKiB3aXRoIHRoZSBkZXN0
aW5hdGlvbiBDUFUncyBjb3JlIGNvb2tpZS4NCj4+Pj4+ICsJICovDQo+Pj4+PiArCWlmICghc2No
ZWRfY29yZV9jb29raWVfbWF0Y2goY3B1X3JxKGVudi0+ZHN0X2NwdSksIHApKQ0KPj4+Pj4gKwkJ
cmV0dXJuIDA7DQo+Pj4+PiArI2VuZGlmDQo+Pj4+PiArDQo+Pj4+PiAJLyogUmVjb3JkIHRoYXQg
d2UgZm91bmQgYXRsZWFzdCBvbmUgdGFzayB0aGF0IGNvdWxkIHJ1biBvbiBkc3RfY3B1ICovDQo+
Pj4+PiAJZW52LT5mbGFncyAmPSB+TEJGX0FMTF9QSU5ORUQ7DQo+Pj4+PiANCj4+Pj4+IEBAIC04
ODU3LDYgKzg4OTIsMjUgQEAgZmluZF9pZGxlc3RfZ3JvdXAoc3RydWN0IHNjaGVkX2RvbWFpbiAq
c2QsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwNCj4+Pj4+IAkJCQkJcC0+Y3B1c19wdHIpKQ0KPj4+
Pj4gCQkJY29udGludWU7DQo+Pj4+PiANCj4+Pj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NPUkUN
Cj4+Pj4+ICsJCWlmIChzY2hlZF9jb3JlX2VuYWJsZWQoY3B1X3JxKHRoaXNfY3B1KSkpIHsNCj4+
Pj4+ICsJCQlpbnQgaSA9IDA7DQo+Pj4+PiArCQkJYm9vbCBjb29raWVfbWF0Y2ggPSBmYWxzZTsN
Cj4+Pj4+ICsNCj4+Pj4+ICsJCQlmb3JfZWFjaF9jcHUoaSwgc2NoZWRfZ3JvdXBfc3Bhbihncm91
cCkpIHsNCj4+Pj4gU2hvdWxkIHdlIGNvbnNpZGVyIHRoZSBwLT5jcHVzX3B0ciBoZXJlPyBsaWtl
LA0KPj4+PiAJCQlmb3JfZWFjaF9jcHVfYW5kKGksIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApLCBw
LT5jcHVzX3B0ciApIHsNCj4+PiANCj4+PiBUaGlzIGlzIGFscmVhZHkgY29uc2lkZXJlZCBqdXN0
IGFib3ZlICNpZmRlZiBDT05GSUdfU0NIRURfQ09SRSwgYnV0IG5vdCBpbmNsdWRlZA0KPj4+IGlu
IHRoZSBwYXRjaCBmaWxlLg0KPj4+IA0KPj4+IFRoYW5rcywNCj4+PiAtQXVicmV5DQo+PiANCj4+
IFRoZSBhYm92ZSBjb25zaWRlcmF0aW9uIGlzLA0KPj4gODg5MyAgICAgICAgICAgICAgICAgLyog
U2tpcCBvdmVyIHRoaXMgZ3JvdXAgaWYgaXQgaGFzIG5vIENQVXMgYWxsb3dlZCAqLw0KPj4gODg5
NCAgICAgICAgICAgICAgICAgaWYgKCFjcHVtYXNrX2ludGVyc2VjdHMoc2NoZWRfZ3JvdXBfc3Bh
bihncm91cCksDQo+PiA4ODk1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwLT5jcHVzX3B0cikpDQo+PiA4ODk2ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPj4gODg5Nw0KPj4gSXQgb25seSBjb25zaWRlcnMgdGhlIGNhc2Ugb2YgKnAgaXMgbm90IGFs
bG93ZWQgZm9yIHRoZSB3aG9sZSBncm91cCosIHdoaWNoIGlzIG5vdCBlbm91Z2guDQo+PiBJZigg
Y3B1bWFza19zdWJzZXQocC0+Y3B1c19wdHIsIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApKSwgdGhl
IGZvbGxvd2luZyBzY2hlZF9jb3JlX2Nvb2tpZV9tYXRjaCgpIG1heSBjaG9vc2UgYSAqd3Jvbmco
bm90IGFsbG93ZWQpKiBjcHUgdG8gbWF0Y2ggY29va2llLiBJbiB0aGF0IGNhc2UsIHRoZSBtYXRj
aGluZyByZXN1bHQgY291bGQgYmUgY29uZnVzaW5nIGFuZCBsZWFkIHRvIHdyb25nIHJlc3VsdC4N
Cj4+IE9uIHRoZSBvdGhlciBoYW5kLCBjb25zaWRlcmluZyBwLT5jcHVzX3B0ciBoZXJlIGNvdWxk
IHJlZHVjZSB0aGUgbG9vcCB0aW1lcyBhbmQgY29zdCwgaWYgY3B1bWFza19hbmQocC0+Y3B1c19w
dHIsIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApKSBpcyB0aGUgc3Vic2V0IG9mIHNjaGVkX2dyb3Vw
X3NwYW4oZ3JvdXApLg0KPiANCj4gVGhvdWdoIGZpbmRfaWRsZXN0X2dyb3VwX2NwdSgpIHdpbGwg
Y2hlY2sgcC0+Y3B1c19wdHIgYWdhaW4sIEkgYmVsaWV2ZSB0aGlzIGlzIGEgZ29vZCBjYXRjaCBh
bmQNCj4gc2hvdWxkIGJlIGZpeGVkIGluIHRoZSBuZXh0IGl0ZXJhdGlvbi4NCj4gDQo+IFRoYW5r
cywNCj4gLUF1YnJleQ0KDQo=
