Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0309C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A6620709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="JSp0Wq0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbgGVOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:32:48 -0400
Received: from mail6.tencent.com ([220.249.245.26]:54568 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:32:48 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail6.tencent.com (Postfix) with ESMTP id A2D73CC1A2;
        Wed, 22 Jul 2020 22:33:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595428425;
        bh=Z2naWdkIdk8xQP5Mc+tKdcYwTdGtopEZS5kXbnY+tqA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=JSp0Wq0yzkvbD5zWVckKTC9/mh+yD0LmA4rxPcLoiVm5HPPfgNplnzPKw81vwqFdh
         d6VoEhsmkF5HBFdaqdY0quux/C5j38Q5zZ+fMUrSrd24HUyCEWTnObOjwosUZukY+h
         CX/1gN+hT3T6xQ7oWnZxv7dPXlJQIpuNNZedDKF4=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 22:32:37 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 22:32:36 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 22 Jul 2020 22:32:36 +0800
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
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOAgAA3egCAACb+AA==
Date:   Wed, 22 Jul 2020 14:32:36 +0000
Message-ID: <5C71B460-8DC3-44AF-A75E-68BB2E33686B@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
 <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
 <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
In-Reply-To: <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FBA1094C0084643A45171559B324100@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDIyLCAyMDIwLCBhdCA4OjEzIFBNLCBMaSwgQXVicmV5IDxhdWJyZXku
bGlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvNy8yMiAxNjo1NCwgYmVu
YmppYW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwgQXVicmV5LA0KPj4gDQo+Pj4gT24gSnVsIDEs
IDIwMjAsIGF0IDU6MzIgQU0sIFZpbmVldGggUmVtYW5hbiBQaWxsYWkgPHZwaWxsYWlAZGlnaXRh
bG9jZWFuLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gRnJvbTogQXVicmV5IExpIDxhdWJyZXkubGlA
aW50ZWwuY29tPg0KPj4+IA0KPj4+IC0gRG9uJ3QgbWlncmF0ZSBpZiB0aGVyZSBpcyBhIGNvb2tp
ZSBtaXNtYXRjaA0KPj4+ICAgIExvYWQgYmFsYW5jZSB0cmllcyB0byBtb3ZlIHRhc2sgZnJvbSBi
dXNpZXN0IENQVSB0byB0aGUNCj4+PiAgICBkZXN0aW5hdGlvbiBDUFUuIFdoZW4gY29yZSBzY2hl
ZHVsaW5nIGlzIGVuYWJsZWQsIGlmIHRoZQ0KPj4+ICAgIHRhc2sncyBjb29raWUgZG9lcyBub3Qg
bWF0Y2ggd2l0aCB0aGUgZGVzdGluYXRpb24gQ1BVJ3MNCj4+PiAgICBjb3JlIGNvb2tpZSwgdGhp
cyB0YXNrIHdpbGwgYmUgc2tpcHBlZCBieSB0aGlzIENQVS4gVGhpcw0KPj4+ICAgIG1pdGlnYXRl
cyB0aGUgZm9yY2VkIGlkbGUgdGltZSBvbiB0aGUgZGVzdGluYXRpb24gQ1BVLg0KPj4+IA0KPj4+
IC0gU2VsZWN0IGNvb2tpZSBtYXRjaGVkIGlkbGUgQ1BVDQo+Pj4gICAgSW4gdGhlIGZhc3QgcGF0
aCBvZiB0YXNrIHdha2V1cCwgc2VsZWN0IHRoZSBmaXJzdCBjb29raWUgbWF0Y2hlZA0KPj4+ICAg
IGlkbGUgQ1BVIGluc3RlYWQgb2YgdGhlIGZpcnN0IGlkbGUgQ1BVLg0KPj4+IA0KPj4+IC0gRmlu
ZCBjb29raWUgbWF0Y2hlZCBpZGxlc3QgQ1BVDQo+Pj4gICAgSW4gdGhlIHNsb3cgcGF0aCBvZiB0
YXNrIHdha2V1cCwgZmluZCB0aGUgaWRsZXN0IENQVSB3aG9zZSBjb3JlDQo+Pj4gICAgY29va2ll
IG1hdGNoZXMgd2l0aCB0YXNrJ3MgY29va2llDQo+Pj4gDQo+Pj4gLSBEb24ndCBtaWdyYXRlIHRh
c2sgaWYgY29va2llIG5vdCBtYXRjaA0KPj4+ICAgIEZvciB0aGUgTlVNQSBsb2FkIGJhbGFuY2Us
IGRvbid0IG1pZ3JhdGUgdGFzayB0byB0aGUgQ1BVIHdob3NlDQo+Pj4gICAgY29yZSBjb29raWUg
ZG9lcyBub3QgbWF0Y2ggd2l0aCB0YXNrJ3MgY29va2llDQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1i
eTogQXVicmV5IExpIDxhdWJyZXkubGlAbGludXguaW50ZWwuY29tPg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBWaW5lZXRoIFJlbWFuYW4gUGlsbGFpIDx2cGlsbGFpQGRpZ2l0YWxvY2Vhbi5jb20+DQo+
Pj4gLS0tDQo+Pj4ga2VybmVsL3NjaGVkL2ZhaXIuYyAgfCA2NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+IGtlcm5lbC9zY2hlZC9zY2hlZC5oIHwgMjkg
KysrKysrKysrKysrKysrKysrKysNCj4+PiAyIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9m
YWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+Pj4gaW5kZXggZDE2OTM5NzY2MzYxLi4zM2Rj
NGJmMDE4MTcgMTAwNjQ0DQo+Pj4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4+ICsrKyBi
L2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4+PiBAQCAtMjA1MSw2ICsyMDUxLDE1IEBAIHN0YXRpYyB2
b2lkIHRhc2tfbnVtYV9maW5kX2NwdShzdHJ1Y3QgdGFza19udW1hX2VudiAqZW52LA0KPj4+IAkJ
aWYgKCFjcHVtYXNrX3Rlc3RfY3B1KGNwdSwgZW52LT5wLT5jcHVzX3B0cikpDQo+Pj4gCQkJY29u
dGludWU7DQo+Pj4gDQo+Pj4gKyNpZmRlZiBDT05GSUdfU0NIRURfQ09SRQ0KPj4+ICsJCS8qDQo+
Pj4gKwkJICogU2tpcCB0aGlzIGNwdSBpZiBzb3VyY2UgdGFzaydzIGNvb2tpZSBkb2VzIG5vdCBt
YXRjaA0KPj4+ICsJCSAqIHdpdGggQ1BVJ3MgY29yZSBjb29raWUuDQo+Pj4gKwkJICovDQo+Pj4g
KwkJaWYgKCFzY2hlZF9jb3JlX2Nvb2tpZV9tYXRjaChjcHVfcnEoY3B1KSwgZW52LT5wKSkNCj4+
PiArCQkJY29udGludWU7DQo+Pj4gKyNlbmRpZg0KPj4+ICsNCj4+PiAJCWVudi0+ZHN0X2NwdSA9
IGNwdTsNCj4+PiAJCWlmICh0YXNrX251bWFfY29tcGFyZShlbnYsIHRhc2tpbXAsIGdyb3VwaW1w
LCBtYXltb3ZlKSkNCj4+PiAJCQlicmVhazsNCj4+PiBAQCAtNTk2MywxMSArNTk3MiwxNyBAQCBm
aW5kX2lkbGVzdF9ncm91cF9jcHUoc3RydWN0IHNjaGVkX2dyb3VwICpncm91cCwgc3RydWN0IHRh
c2tfc3RydWN0ICpwLCBpbnQgdGhpcw0KPj4+IA0KPj4+IAkvKiBUcmF2ZXJzZSBvbmx5IHRoZSBh
bGxvd2VkIENQVXMgKi8NCj4+PiAJZm9yX2VhY2hfY3B1X2FuZChpLCBzY2hlZF9ncm91cF9zcGFu
KGdyb3VwKSwgcC0+Y3B1c19wdHIpIHsNCj4+PiArCQlzdHJ1Y3QgcnEgKnJxID0gY3B1X3JxKGkp
Ow0KPj4+ICsNCj4+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4gKwkJaWYgKCFzY2hl
ZF9jb3JlX2Nvb2tpZV9tYXRjaChycSwgcCkpDQo+Pj4gKwkJCWNvbnRpbnVlOw0KPj4+ICsjZW5k
aWYNCj4+PiArDQo+Pj4gCQlpZiAoc2NoZWRfaWRsZV9jcHUoaSkpDQo+Pj4gCQkJcmV0dXJuIGk7
DQo+Pj4gDQo+Pj4gCQlpZiAoYXZhaWxhYmxlX2lkbGVfY3B1KGkpKSB7DQo+Pj4gLQkJCXN0cnVj
dCBycSAqcnEgPSBjcHVfcnEoaSk7DQo+Pj4gCQkJc3RydWN0IGNwdWlkbGVfc3RhdGUgKmlkbGUg
PSBpZGxlX2dldF9zdGF0ZShycSk7DQo+Pj4gCQkJaWYgKGlkbGUgJiYgaWRsZS0+ZXhpdF9sYXRl
bmN5IDwgbWluX2V4aXRfbGF0ZW5jeSkgew0KPj4+IAkJCQkvKg0KPj4+IEBAIC02MjI0LDggKzYy
MzksMTggQEAgc3RhdGljIGludCBzZWxlY3RfaWRsZV9jcHUoc3RydWN0IHRhc2tfc3RydWN0ICpw
LCBzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCwgaW50IHQNCj4+PiAJZm9yX2VhY2hfY3B1X3dyYXAo
Y3B1LCBjcHVzLCB0YXJnZXQpIHsNCj4+PiAJCWlmICghLS1ucikNCj4+PiAJCQlyZXR1cm4gLTE7
DQo+Pj4gLQkJaWYgKGF2YWlsYWJsZV9pZGxlX2NwdShjcHUpIHx8IHNjaGVkX2lkbGVfY3B1KGNw
dSkpDQo+Pj4gLQkJCWJyZWFrOw0KPj4+ICsNCj4+PiArCQlpZiAoYXZhaWxhYmxlX2lkbGVfY3B1
KGNwdSkgfHwgc2NoZWRfaWRsZV9jcHUoY3B1KSkgew0KPj4+ICsjaWZkZWYgQ09ORklHX1NDSEVE
X0NPUkUNCj4+PiArCQkJLyoNCj4+PiArCQkJICogSWYgQ29yZSBTY2hlZHVsaW5nIGlzIGVuYWJs
ZWQsIHNlbGVjdCB0aGlzIGNwdQ0KPj4+ICsJCQkgKiBvbmx5IGlmIHRoZSBwcm9jZXNzIGNvb2tp
ZSBtYXRjaGVzIGNvcmUgY29va2llLg0KPj4+ICsJCQkgKi8NCj4+PiArCQkJaWYgKHNjaGVkX2Nv
cmVfZW5hYmxlZChjcHVfcnEoY3B1KSkgJiYNCj4+PiArCQkJICAgIHAtPmNvcmVfY29va2llID09
IGNwdV9ycShjcHUpLT5jb3JlLT5jb3JlX2Nvb2tpZSkNCj4+IFdoeSBub3QgYWxzbyBhZGQgc2lt
aWxhciBsb2dpYyBpbiBzZWxlY3RfaWRsZV9zbXQgdG8gcmVkdWNlIGZvcmNlZC1pZGxlPyA6KQ0K
PiBXZSBoaXQgc2VsZWN0X2lkbGVfc210IGFmdGVyIHdlIHNjYW5lZCB0aGUgZW50aXJlIExMQyBk
b21haW4gZm9yIGlkbGUgY29yZXMNCj4gYW5kIGlkbGUgY3B1cyBhbmQgZmFpbGVkLHNvIElNSE8s
IGFuIGlkbGUgc210IGlzIHByb2JhYmx5IGEgZ29vZCBjaG9pY2UgdW5kZXINCj4gdGhpcyBzY2Vu
YXJpby4NCg0KQUZBSUMsIHNlbGVjdGluZyBpZGxlIHNpYmxpbmcgd2l0aCB1bm1hdGNoZWQgY29v
a2llIHdpbGwgY2F1c2UgdW5uZWNlc3NhcnkgZm9yZWQtaWRsZSwgdW5mYWlybmVzcyBhbmQgbGF0
ZW5jeSwgY29tcGFyZWQgdG8gY2hvb3NpbmcgKnRhcmdldCogY3B1Lg0KQmVzaWRlcywgY2hvb3Np
bmcgKnRhcmdldCogY3B1IG1heSBiZSBtb3JlIGNhY2hlIGZyaWVuZGx5LiBTbyBJTUhPLCAqdGFy
Z2V0KiBjcHUgbWF5IGJlIGEgYmV0dGVyIGNob2ljZSBpZiBjb29raWUgbm90IG1hdGNoLCBpbnN0
ZWFkIG9mIGlkbGUgc2libGluZy4NCg0KPiANCj4+IA0KPj4+ICsjZW5kaWYNCj4+PiArCQkJCWJy
ZWFrOw0KPj4+ICsJCX0NCj4+PiAJfQ0KPj4+IA0KPj4+IAl0aW1lID0gY3B1X2Nsb2NrKHRoaXMp
IC0gdGltZTsNCj4+PiBAQCAtNzYwOSw4ICs3NjM0LDkgQEAgaW50IGNhbl9taWdyYXRlX3Rhc2so
c3RydWN0IHRhc2tfc3RydWN0ICpwLCBzdHJ1Y3QgbGJfZW52ICplbnYpDQo+Pj4gCSAqIFdlIGRv
IG5vdCBtaWdyYXRlIHRhc2tzIHRoYXQgYXJlOg0KPj4+IAkgKiAxKSB0aHJvdHRsZWRfbGJfcGFp
ciwgb3INCj4+PiAJICogMikgY2Fubm90IGJlIG1pZ3JhdGVkIHRvIHRoaXMgQ1BVIGR1ZSB0byBj
cHVzX3B0ciwgb3INCj4+PiAtCSAqIDMpIHJ1bm5pbmcgKG9idmlvdXNseSksIG9yDQo+Pj4gLQkg
KiA0KSBhcmUgY2FjaGUtaG90IG9uIHRoZWlyIGN1cnJlbnQgQ1BVLg0KPj4+ICsJICogMykgdGFz
aydzIGNvb2tpZSBkb2VzIG5vdCBtYXRjaCB3aXRoIHRoaXMgQ1BVJ3MgY29yZSBjb29raWUNCj4+
PiArCSAqIDQpIHJ1bm5pbmcgKG9idmlvdXNseSksIG9yDQo+Pj4gKwkgKiA1KSBhcmUgY2FjaGUt
aG90IG9uIHRoZWlyIGN1cnJlbnQgQ1BVLg0KPj4+IAkgKi8NCj4+PiAJaWYgKHRocm90dGxlZF9s
Yl9wYWlyKHRhc2tfZ3JvdXAocCksIGVudi0+c3JjX2NwdSwgZW52LT5kc3RfY3B1KSkNCj4+PiAJ
CXJldHVybiAwOw0KPj4+IEBAIC03NjQ1LDYgKzc2NzEsMTUgQEAgaW50IGNhbl9taWdyYXRlX3Rh
c2soc3RydWN0IHRhc2tfc3RydWN0ICpwLCBzdHJ1Y3QgbGJfZW52ICplbnYpDQo+Pj4gCQlyZXR1
cm4gMDsNCj4+PiAJfQ0KPj4+IA0KPj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0NPUkUNCj4+PiAr
CS8qDQo+Pj4gKwkgKiBEb24ndCBtaWdyYXRlIHRhc2sgaWYgdGhlIHRhc2sncyBjb29raWUgZG9l
cyBub3QgbWF0Y2gNCj4+PiArCSAqIHdpdGggdGhlIGRlc3RpbmF0aW9uIENQVSdzIGNvcmUgY29v
a2llLg0KPj4+ICsJICovDQo+Pj4gKwlpZiAoIXNjaGVkX2NvcmVfY29va2llX21hdGNoKGNwdV9y
cShlbnYtPmRzdF9jcHUpLCBwKSkNCj4+PiArCQlyZXR1cm4gMDsNCj4+PiArI2VuZGlmDQo+Pj4g
Kw0KPj4+IAkvKiBSZWNvcmQgdGhhdCB3ZSBmb3VuZCBhdGxlYXN0IG9uZSB0YXNrIHRoYXQgY291
bGQgcnVuIG9uIGRzdF9jcHUgKi8NCj4+PiAJZW52LT5mbGFncyAmPSB+TEJGX0FMTF9QSU5ORUQ7
DQo+Pj4gDQo+Pj4gQEAgLTg4NTcsNiArODg5MiwyNSBAQCBmaW5kX2lkbGVzdF9ncm91cChzdHJ1
Y3Qgc2NoZWRfZG9tYWluICpzZCwgc3RydWN0IHRhc2tfc3RydWN0ICpwLA0KPj4+IAkJCQkJcC0+
Y3B1c19wdHIpKQ0KPj4+IAkJCWNvbnRpbnVlOw0KPj4+IA0KPj4+ICsjaWZkZWYgQ09ORklHX1ND
SEVEX0NPUkUNCj4+PiArCQlpZiAoc2NoZWRfY29yZV9lbmFibGVkKGNwdV9ycSh0aGlzX2NwdSkp
KSB7DQo+Pj4gKwkJCWludCBpID0gMDsNCj4+PiArCQkJYm9vbCBjb29raWVfbWF0Y2ggPSBmYWxz
ZTsNCj4+PiArDQo+Pj4gKwkJCWZvcl9lYWNoX2NwdShpLCBzY2hlZF9ncm91cF9zcGFuKGdyb3Vw
KSkgew0KPj4gU2hvdWxkIHdlIGNvbnNpZGVyIHRoZSBwLT5jcHVzX3B0ciBoZXJlPyBsaWtlLA0K
Pj4gCQkJZm9yX2VhY2hfY3B1X2FuZChpLCBzY2hlZF9ncm91cF9zcGFuKGdyb3VwKSwgcC0+Y3B1
c19wdHIgKSB7DQo+IA0KPiBUaGlzIGlzIGFscmVhZHkgY29uc2lkZXJlZCBqdXN0IGFib3ZlICNp
ZmRlZiBDT05GSUdfU0NIRURfQ09SRSwgYnV0IG5vdCBpbmNsdWRlZA0KPiBpbiB0aGUgcGF0Y2gg
ZmlsZS4NCj4gDQo+IFRoYW5rcywNCj4gLUF1YnJleQ0KDQpUaGUgYWJvdmUgY29uc2lkZXJhdGlv
biBpcywNCiA4ODkzICAgICAgICAgICAgICAgICAvKiBTa2lwIG92ZXIgdGhpcyBncm91cCBpZiBp
dCBoYXMgbm8gQ1BVcyBhbGxvd2VkICovDQogODg5NCAgICAgICAgICAgICAgICAgaWYgKCFjcHVt
YXNrX2ludGVyc2VjdHMoc2NoZWRfZ3JvdXBfc3Bhbihncm91cCksDQogODg5NSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcC0+Y3B1c19wdHIpKQ0KIDg4OTYgICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQogODg5Nw0KSXQgb25seSBjb25zaWRlcnMgdGhl
IGNhc2Ugb2YgKnAgaXMgbm90IGFsbG93ZWQgZm9yIHRoZSB3aG9sZSBncm91cCosIHdoaWNoIGlz
IG5vdCBlbm91Z2guDQpJZiggY3B1bWFza19zdWJzZXQocC0+Y3B1c19wdHIsIHNjaGVkX2dyb3Vw
X3NwYW4oZ3JvdXApKSwgdGhlIGZvbGxvd2luZyBzY2hlZF9jb3JlX2Nvb2tpZV9tYXRjaCgpIG1h
eSBjaG9vc2UgYSAqd3Jvbmcobm90IGFsbG93ZWQpKiBjcHUgdG8gbWF0Y2ggY29va2llLiBJbiB0
aGF0IGNhc2UsIHRoZSBtYXRjaGluZyByZXN1bHQgY291bGQgYmUgY29uZnVzaW5nIGFuZCBsZWFk
IHRvIHdyb25nIHJlc3VsdC4NCk9uIHRoZSBvdGhlciBoYW5kLCBjb25zaWRlcmluZyBwLT5jcHVz
X3B0ciBoZXJlIGNvdWxkIHJlZHVjZSB0aGUgbG9vcCB0aW1lcyBhbmQgY29zdCwgaWYgY3B1bWFz
a19hbmQocC0+Y3B1c19wdHIsIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApKSBpcyB0aGUgc3Vic2V0
IG9mIHNjaGVkX2dyb3VwX3NwYW4oZ3JvdXApLg0KDQpUaHguDQpSZWdhcmRzLA0KSmlhbmcNCg0K
PiANCj4+IAkJCQkuLi4NCj4+IAkJCX0NCj4+IFRoeC4NCj4+IFJlZ2FyZHMsDQo+PiBKaWFuZw0K
Pj4gDQo+Pj4gKwkJCQlzdHJ1Y3QgcnEgKnJxID0gY3B1X3JxKGkpOw0KPj4+ICsNCj4+PiArCQkJ
CWlmIChzY2hlZF9jb3JlX2Nvb2tpZV9tYXRjaChycSwgcCkpIHsNCj4+PiArCQkJCQljb29raWVf
bWF0Y2ggPSB0cnVlOw0KPj4+ICsJCQkJCWJyZWFrOw0KPj4+ICsJCQkJfQ0KPj4+ICsJCQl9DQo+
Pj4gKwkJCS8qIFNraXAgb3ZlciB0aGlzIGdyb3VwIGlmIG5vIGNvb2tpZSBtYXRjaGVkICovDQo+
Pj4gKwkJCWlmICghY29va2llX21hdGNoKQ0KPj4+ICsJCQkJY29udGludWU7DQo+Pj4gKwkJfQ0K
Pj4+ICsjZW5kaWYNCj4+PiArDQo+Pj4gCQlsb2NhbF9ncm91cCA9IGNwdW1hc2tfdGVzdF9jcHUo
dGhpc19jcHUsDQo+Pj4gCQkJCQkgICAgICAgc2NoZWRfZ3JvdXBfc3Bhbihncm91cCkpOw0KPj4+
IA0KPj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvc2NoZWQuaCBiL2tlcm5lbC9zY2hlZC9z
Y2hlZC5oDQo+Pj4gaW5kZXggNDY0NTU5Njc2ZmQyLi44NzU3OTZkNDNmY2EgMTAwNjQ0DQo+Pj4g
LS0tIGEva2VybmVsL3NjaGVkL3NjaGVkLmgNCj4+PiArKysgYi9rZXJuZWwvc2NoZWQvc2NoZWQu
aA0KPj4+IEBAIC0xMDg5LDYgKzEwODksMzUgQEAgc3RhdGljIGlubGluZSByYXdfc3BpbmxvY2tf
dCAqcnFfbG9ja3Aoc3RydWN0IHJxICpycSkNCj4+PiBib29sIGNmc19wcmlvX2xlc3Moc3RydWN0
IHRhc2tfc3RydWN0ICphLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmIpOw0KPj4+IHZvaWQgc2NoZWRf
Y29yZV9hZGp1c3Rfc2libGluZ192cnVudGltZShpbnQgY3B1LCBib29sIGNvcmVzY2hlZF9lbmFi
bGVkKTsNCj4+PiANCj4+PiArLyoNCj4+PiArICogSGVscGVyIHRvIGNoZWNrIGlmIHRoZSBDUFUn
cyBjb3JlIGNvb2tpZSBtYXRjaGVzIHdpdGggdGhlIHRhc2sncyBjb29raWUNCj4+PiArICogd2hl
biBjb3JlIHNjaGVkdWxpbmcgaXMgZW5hYmxlZC4NCj4+PiArICogQSBzcGVjaWFsIGNhc2UgaXMg
dGhhdCB0aGUgdGFzaydzIGNvb2tpZSBhbHdheXMgbWF0Y2hlcyB3aXRoIENQVSdzIGNvcmUNCj4+
PiArICogY29va2llIGlmIHRoZSBDUFUgaXMgaW4gYW4gaWRsZSBjb3JlLg0KPj4+ICsgKi8NCj4+
PiArc3RhdGljIGlubGluZSBib29sIHNjaGVkX2NvcmVfY29va2llX21hdGNoKHN0cnVjdCBycSAq
cnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkNCj4+PiArew0KPj4+ICsJYm9vbCBpZGxlX2NvcmUg
PSB0cnVlOw0KPj4+ICsJaW50IGNwdTsNCj4+PiArDQo+Pj4gKwkvKiBJZ25vcmUgY29va2llIG1h
dGNoIGlmIGNvcmUgc2NoZWR1bGVyIGlzIG5vdCBlbmFibGVkIG9uIHRoZSBDUFUuICovDQo+Pj4g
KwlpZiAoIXNjaGVkX2NvcmVfZW5hYmxlZChycSkpDQo+Pj4gKwkJcmV0dXJuIHRydWU7DQo+Pj4g
Kw0KPj4+ICsJZm9yX2VhY2hfY3B1KGNwdSwgY3B1X3NtdF9tYXNrKGNwdV9vZihycSkpKSB7DQo+
Pj4gKwkJaWYgKCFhdmFpbGFibGVfaWRsZV9jcHUoY3B1KSkgew0KPj4+ICsJCQlpZGxlX2NvcmUg
PSBmYWxzZTsNCj4+PiArCQkJYnJlYWs7DQo+Pj4gKwkJfQ0KPj4+ICsJfQ0KPj4+ICsNCj4+PiAr
CS8qDQo+Pj4gKwkgKiBBIENQVSBpbiBhbiBpZGxlIGNvcmUgaXMgYWx3YXlzIHRoZSBiZXN0IGNo
b2ljZSBmb3IgdGFza3Mgd2l0aA0KPj4+ICsJICogY29va2llcy4NCj4+PiArCSAqLw0KPj4+ICsJ
cmV0dXJuIGlkbGVfY29yZSB8fCBycS0+Y29yZS0+Y29yZV9jb29raWUgPT0gcC0+Y29yZV9jb29r
aWU7DQo+Pj4gK30NCj4+PiArDQo+Pj4gZXh0ZXJuIHZvaWQgcXVldWVfY29yZV9iYWxhbmNlKHN0
cnVjdCBycSAqcnEpOw0KPj4+IA0KPj4+ICNlbHNlIC8qICFDT05GSUdfU0NIRURfQ09SRSAqLw0K
Pj4+IC0tIA0KPj4+IDIuMTcuMQ0KDQo=
