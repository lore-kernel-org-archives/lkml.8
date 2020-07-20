Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C64C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2EA20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="V2SczQBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGTIWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:22:23 -0400
Received: from mail4.tencent.com ([183.57.53.109]:33641 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgGTIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:22:19 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id A0DC9725BA;
        Mon, 20 Jul 2020 16:22:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595233334;
        bh=lwg4TpeGg9ByuUekb6wUgoCLff0dKxMDAZZj04QIqoM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=V2SczQBoNPEelTi2k6L4JzozNs5AuNwRVzsqWT9zOSUkDeTv5j8UD4hFh1w41WZNU
         F/CERaQ7EWFoIKZ5PqEoU4albVUbcKL5n6cR4CxtSOtI6jY904UTsE8bGFnfoEVen1
         9mODzq7GpwKsmQ/DbuBt22jRpE3msMCCg2UJpHBo=
Received: from EX-SZ004.tencent.com (10.28.6.25) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 20 Jul
 2020 16:22:14 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ004.tencent.com
 (10.28.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 20 Jul
 2020 16:22:14 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Mon, 20 Jul 2020 16:22:14 +0800
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 10/16] sched: Trivial forced-newidle balancer(Internet
 mail)
Thread-Topic: [RFC PATCH 10/16] sched: Trivial forced-newidle
 balancer(Internet mail)
Thread-Index: AQHWTyYpnBjYC7x930alFUJ4JyvKnakPcZ0AgAAh6ICAABWDgIAACvUAgAAFV4A=
Date:   Mon, 20 Jul 2020 08:22:13 +0000
Message-ID: <23F5F9C5-A554-4697-9B75-ED302E6723D7@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
 <750BB828-1AAE-4DED-A460-CF8ADDE3CFDA@tencent.com>
 <288368e3-9f6b-21bf-287a-f2446073f6fb@linux.intel.com>
 <8082F052-2F52-42D3-B396-18A35A94F26F@tencent.com>
 <5ac7b50a-b422-040c-81f4-eab5bdda477b@linux.intel.com>
In-Reply-To: <5ac7b50a-b422-040c-81f4-eab5bdda477b@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.34]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADB2065204C35D4BA69AD3B92A004D5F@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDIwLCAyMDIwLCBhdCA0OjAzIFBNLCBMaSwgQXVicmV5IDxhdWJyZXkubGlA
bGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjAvNy8yMCAxNToyMywgYmVuYmpp
YW5nKOiSi+W9qikgd3JvdGU6DQo+PiBIaSwgDQo+PiANCj4+PiBPbiBKdWwgMjAsIDIwMjAsIGF0
IDI6MDYgUE0sIExpLCBBdWJyZXkgPGF1YnJleS5saUBsaW51eC5pbnRlbC5jb20gPG1haWx0bzph
dWJyZXkubGlAbGludXguaW50ZWwuY29tPj4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gMjAyMC83LzIw
IDEyOjA2LCBiZW5iamlhbmco6JKL5b2qKSB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+IA0KPj4+Pj4g
T24gSnVsIDEsIDIwMjAsIGF0IDU6MzIgQU0sIFZpbmVldGggUmVtYW5hbiBQaWxsYWkgPHZwaWxs
YWlAZGlnaXRhbG9jZWFuLmNvbSA8bWFpbHRvOnZwaWxsYWlAZGlnaXRhbG9jZWFuLmNvbT4+IHdy
b3RlOg0KPj4+Pj4gDQo+Pj4+PiBGcm9tOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmcgPG1haWx0bzpwZXRlcnpAaW5mcmFkZWFkLm9yZz4+DQo+Pj4+PiANCj4+Pj4+IFdoZW4g
YSBzaWJsaW5nIGlzIGZvcmNlZC1pZGxlIHRvIG1hdGNoIHRoZSBjb3JlLWNvb2tpZTsgc2VhcmNo
IGZvcg0KPj4+Pj4gbWF0Y2hpbmcgdGFza3MgdG8gZmlsbCB0aGUgY29yZS4NCj4+Pj4+IA0KPj4+
Pj4gcmN1X3JlYWRfdW5sb2NrKCkgY2FuIGluY3VyIGFuIGluZnJlcXVlbnQgZGVhZGxvY2sgaW4N
Cj4+Pj4+IHNjaGVkX2NvcmVfYmFsYW5jZSgpLiBGaXggdGhpcyBieSB1c2luZyB0aGUgUkNVLXNj
aGVkIGZsYXZvciBpbnN0ZWFkLg0KPj4+Pj4gDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBa
aWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZyA8bWFpbHRvOnBldGVyekBpbmZy
YWRlYWQub3JnPj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUp
IDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnIDxtYWlsdG86am9lbEBqb2VsZmVybmFuZGVzLm9yZz4+
DQo+Pj4+PiBBY2tlZC1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnIDxt
YWlsdG86cGF1bG1ja0BrZXJuZWwub3JnPj4NCj4+Pj4+IC0tLQ0KPj4+Pj4gaW5jbHVkZS9saW51
eC9zY2hlZC5oIHwgICAxICsNCj4+Pj4+IGtlcm5lbC9zY2hlZC9jb3JlLmMgICB8IDEzMSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+Pj4+IGtlcm5lbC9zY2hl
ZC9pZGxlLmMgICB8ICAgMSArDQo+Pj4+PiBrZXJuZWwvc2NoZWQvc2NoZWQuaCAgfCAgIDYgKysN
Cj4+Pj4+IDQgZmlsZXMgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+Pj4+IA0KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQuaCBiL2luY2x1
ZGUvbGludXgvc2NoZWQuaA0KPj4+Pj4gaW5kZXggM2M4ZGNjNWZmMDM5Li40ZjllZGYwMTNkZjMg
MTAwNjQ0DQo+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4+Pj4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvc2NoZWQuaA0KPj4+Pj4gQEAgLTY4OCw2ICs2ODgsNyBAQCBzdHJ1Y3QgdGFz
a19zdHJ1Y3Qgew0KPj4+Pj4gI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQo+Pj4+PiBzdHJ1Y3Qg
cmJfbm9kZWNvcmVfbm9kZTsNCj4+Pj4+IHVuc2lnbmVkIGxvbmdjb3JlX2Nvb2tpZTsNCj4+Pj4+
ICt1bnNpZ25lZCBpbnRjb3JlX29jY3VwYXRpb247DQo+Pj4+PiAjZW5kaWYNCj4+Pj4+IA0KPj4+
Pj4gI2lmZGVmIENPTkZJR19DR1JPVVBfU0NIRUQNCj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwv
c2NoZWQvY29yZS5jIGIva2VybmVsL3NjaGVkL2NvcmUuYw0KPj4+Pj4gaW5kZXggNGQ2ZDZhNjc4
MDEzLi5mYjllZGIwOWVhZDcgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9rZXJuZWwvc2NoZWQvY29yZS5j
DQo+Pj4+PiArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+Pj4+PiBAQCAtMjAxLDYgKzIwMSwy
MSBAQCBzdGF0aWMgc3RydWN0IHRhc2tfc3RydWN0ICpzY2hlZF9jb3JlX2ZpbmQoc3RydWN0IHJx
ICpycSwgdW5zaWduZWQgbG9uZyBjb29raWUpDQo+Pj4+PiByZXR1cm4gbWF0Y2g7DQo+Pj4+PiB9
DQo+Pj4+PiANCj4+Pj4+ICtzdGF0aWMgc3RydWN0IHRhc2tfc3RydWN0ICpzY2hlZF9jb3JlX25l
eHQoc3RydWN0IHRhc2tfc3RydWN0ICpwLCB1bnNpZ25lZCBsb25nIGNvb2tpZSkNCj4+Pj4+ICt7
DQo+Pj4+PiArc3RydWN0IHJiX25vZGUgKm5vZGUgPSAmcC0+Y29yZV9ub2RlOw0KPj4+Pj4gKw0K
Pj4+Pj4gK25vZGUgPSByYl9uZXh0KG5vZGUpOw0KPj4+Pj4gK2lmICghbm9kZSkNCj4+Pj4+ICty
ZXR1cm4gTlVMTDsNCj4+Pj4+ICsNCj4+Pj4+ICtwID0gY29udGFpbmVyX29mKG5vZGUsIHN0cnVj
dCB0YXNrX3N0cnVjdCwgY29yZV9ub2RlKTsNCj4+Pj4+ICtpZiAocC0+Y29yZV9jb29raWUgIT0g
Y29va2llKQ0KPj4+Pj4gK3JldHVybiBOVUxMOw0KPj4+Pj4gKw0KPj4+Pj4gK3JldHVybiBwOw0K
Pj4+Pj4gK30NCj4+Pj4+ICsNCj4+Pj4+IC8qDQo+Pj4+PiAqIFRoZSBzdGF0aWMta2V5ICsgc3Rv
cC1tYWNoaW5lIHZhcmlhYmxlIGFyZSBuZWVkZWQgc3VjaCB0aGF0Og0KPj4+Pj4gKg0KPj4+Pj4g
QEAgLTQyMzMsNyArNDI0OCw3IEBAIHBpY2tfbmV4dF90YXNrKHN0cnVjdCBycSAqcnEsIHN0cnVj
dCB0YXNrX3N0cnVjdCAqcHJldiwgc3RydWN0IHJxX2ZsYWdzICpyZikNCj4+Pj4+IHN0cnVjdCB0
YXNrX3N0cnVjdCAqbmV4dCwgKm1heCA9IE5VTEw7DQo+Pj4+PiBjb25zdCBzdHJ1Y3Qgc2NoZWRf
Y2xhc3MgKmNsYXNzOw0KPj4+Pj4gY29uc3Qgc3RydWN0IGNwdW1hc2sgKnNtdF9tYXNrOw0KPj4+
Pj4gLWludCBpLCBqLCBjcHU7DQo+Pj4+PiAraW50IGksIGosIGNwdSwgb2NjID0gMDsNCj4+Pj4+
IGJvb2wgbmVlZF9zeW5jOw0KPj4+Pj4gDQo+Pj4+PiBpZiAoIXNjaGVkX2NvcmVfZW5hYmxlZChy
cSkpDQo+Pj4+PiBAQCAtNDMzMiw2ICs0MzQ3LDkgQEAgcGlja19uZXh0X3Rhc2soc3RydWN0IHJx
ICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwcmV2LCBzdHJ1Y3QgcnFfZmxhZ3MgKnJmKQ0KPj4+
Pj4gZ290byBkb25lOw0KPj4+Pj4gfQ0KPj4+Pj4gDQo+Pj4+PiAraWYgKCFpc19pZGxlX3Rhc2so
cCkpDQo+Pj4+PiArb2NjKys7DQo+Pj4+PiArDQo+Pj4+PiBycV9pLT5jb3JlX3BpY2sgPSBwOw0K
Pj4+Pj4gDQo+Pj4+PiAvKg0KPj4+Pj4gQEAgLTQzNTcsNiArNDM3NSw3IEBAIHBpY2tfbmV4dF90
YXNrKHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcHJldiwgc3RydWN0IHJxX2Zs
YWdzICpyZikNCj4+Pj4+IA0KPj4+Pj4gY3B1X3JxKGopLT5jb3JlX3BpY2sgPSBOVUxMOw0KPj4+
Pj4gfQ0KPj4+Pj4gK29jYyA9IDE7DQo+Pj4+PiBnb3RvIGFnYWluOw0KPj4+Pj4gfSBlbHNlIHsN
Cj4+Pj4+IC8qDQo+Pj4+PiBAQCAtNDM5Myw2ICs0NDEyLDggQEAgbmV4dF9jbGFzczo7DQo+Pj4+
PiBpZiAoaXNfaWRsZV90YXNrKHJxX2ktPmNvcmVfcGljaykgJiYgcnFfaS0+bnJfcnVubmluZykN
Cj4+Pj4+IHJxX2ktPmNvcmVfZm9yY2VpZGxlID0gdHJ1ZTsNCj4+Pj4+IA0KPj4+Pj4gK3JxX2kt
PmNvcmVfcGljay0+Y29yZV9vY2N1cGF0aW9uID0gb2NjOw0KPj4+Pj4gKw0KPj4+Pj4gaWYgKGkg
PT0gY3B1KQ0KPj4+Pj4gY29udGludWU7DQo+Pj4+PiANCj4+Pj4+IEBAIC00NDA4LDYgKzQ0Mjks
MTE0IEBAIG5leHRfY2xhc3M6Ow0KPj4+Pj4gcmV0dXJuIG5leHQ7DQo+Pj4+PiB9DQo+Pj4+PiAN
Cj4+Pj4+ICtzdGF0aWMgYm9vbCB0cnlfc3RlYWxfY29va2llKGludCB0aGlzLCBpbnQgdGhhdCkN
Cj4+Pj4+ICt7DQo+Pj4+PiArc3RydWN0IHJxICpkc3QgPSBjcHVfcnEodGhpcyksICpzcmMgPSBj
cHVfcnEodGhhdCk7DQo+Pj4+PiArc3RydWN0IHRhc2tfc3RydWN0ICpwOw0KPj4+Pj4gK3Vuc2ln
bmVkIGxvbmcgY29va2llOw0KPj4+Pj4gK2Jvb2wgc3VjY2VzcyA9IGZhbHNlOw0KPj4+Pj4gKw0K
Pj4+Pj4gK2xvY2FsX2lycV9kaXNhYmxlKCk7DQo+Pj4+PiArZG91YmxlX3JxX2xvY2soZHN0LCBz
cmMpOw0KPj4+Pj4gKw0KPj4+Pj4gK2Nvb2tpZSA9IGRzdC0+Y29yZS0+Y29yZV9jb29raWU7DQo+
Pj4+PiAraWYgKCFjb29raWUpDQo+Pj4+PiArZ290byB1bmxvY2s7DQo+Pj4+PiArDQo+Pj4+PiAr
aWYgKGRzdC0+Y3VyciAhPSBkc3QtPmlkbGUpDQo+Pj4+PiArZ290byB1bmxvY2s7DQo+Pj4+PiAr
DQo+Pj4+PiArcCA9IHNjaGVkX2NvcmVfZmluZChzcmMsIGNvb2tpZSk7DQo+Pj4+PiAraWYgKHAg
PT0gc3JjLT5pZGxlKQ0KPj4+Pj4gK2dvdG8gdW5sb2NrOw0KPj4+Pj4gKw0KPj4+Pj4gK2RvIHsN
Cj4+Pj4+ICtpZiAocCA9PSBzcmMtPmNvcmVfcGljayB8fCBwID09IHNyYy0+Y3VycikNCj4+Pj4+
ICtnb3RvIG5leHQ7DQo+Pj4+PiArDQo+Pj4+PiAraWYgKCFjcHVtYXNrX3Rlc3RfY3B1KHRoaXMs
ICZwLT5jcHVzX21hc2spKQ0KPj4+Pj4gK2dvdG8gbmV4dDsNCj4+Pj4+ICsNCj4+Pj4+ICtpZiAo
cC0+Y29yZV9vY2N1cGF0aW9uID4gZHN0LT5pZGxlLT5jb3JlX29jY3VwYXRpb24pDQo+Pj4+PiAr
Z290byBuZXh0Ow0KPj4+Pj4gKw0KPj4+Pj4gK3AtPm9uX3JxID0gVEFTS19PTl9SUV9NSUdSQVRJ
Tkc7DQo+Pj4+PiArZGVhY3RpdmF0ZV90YXNrKHNyYywgcCwgMCk7DQo+Pj4+PiArc2V0X3Rhc2tf
Y3B1KHAsIHRoaXMpOw0KPj4+Pj4gK2FjdGl2YXRlX3Rhc2soZHN0LCBwLCAwKTsNCj4+Pj4+ICtw
LT5vbl9ycSA9IFRBU0tfT05fUlFfUVVFVUVEOw0KPj4+Pj4gKw0KPj4+Pj4gK3Jlc2NoZWRfY3Vy
cihkc3QpOw0KPj4+Pj4gKw0KPj4+Pj4gK3N1Y2Nlc3MgPSB0cnVlOw0KPj4+Pj4gK2JyZWFrOw0K
Pj4+Pj4gKw0KPj4+Pj4gK25leHQ6DQo+Pj4+PiArcCA9IHNjaGVkX2NvcmVfbmV4dChwLCBjb29r
aWUpOw0KPj4+Pj4gK30gd2hpbGUgKHApOw0KPj4+Pj4gKw0KPj4+Pj4gK3VubG9jazoNCj4+Pj4+
ICtkb3VibGVfcnFfdW5sb2NrKGRzdCwgc3JjKTsNCj4+Pj4+ICtsb2NhbF9pcnFfZW5hYmxlKCk7
DQo+Pj4+PiArDQo+Pj4+PiArcmV0dXJuIHN1Y2Nlc3M7DQo+Pj4+PiArfQ0KPj4+Pj4gKw0KPj4+
Pj4gK3N0YXRpYyBib29sIHN0ZWFsX2Nvb2tpZV90YXNrKGludCBjcHUsIHN0cnVjdCBzY2hlZF9k
b21haW4gKnNkKQ0KPj4+Pj4gK3sNCj4+Pj4+ICtpbnQgaTsNCj4+Pj4+ICsNCj4+Pj4+ICtmb3Jf
ZWFjaF9jcHVfd3JhcChpLCBzY2hlZF9kb21haW5fc3BhbihzZCksIGNwdSkgew0KPj4+PiBTaW5j
ZSAoaSA9PSBjcHUpIHNob3VsZCBiZSBza2lwcGVkLCBzaG91bGQgd2Ugc3RhcnQgaXRlcmF0aW9u
IGF0IGNwdSsxPyBsaWtlLA0KPj4+PiBmb3JfZWFjaF9jcHVfd3JhcChpLCBzY2hlZF9kb21haW5f
c3BhbihzZCksIGNwdSsxKSB7DQo+Pj4+IOKApg0KPj4+PiB9DQo+Pj4+IEluIHRoYXQgd2F5LCB3
ZSBjb3VsZCBhdm9pZCBoaXR0aW5nIGZvbGxvd2luZyBpZihpID09IGNwdSkgYWx3YXlzLg0KPj4+
IA0KPj4+IElNSE8sIHRoaXMgd29uJ3Qgd29yaywgYXMgY3B1aWQgaXMgbm90IGNvbnRpbnVvdXMu
DQo+PiBDcHVpZCBtYXkgYmUgbm90IGNvbnRpbnVvdXMsIGJ1dCBmb3JfZWFjaF9jcHVfd3JhcCgp
IGNvdWxkIGNvdmVyIHRoZSBjYXNlLCBJIHRoaW5rLiA6KQ0KPiANCj4gQW5kIGZvcl9lYWNoX2Nw
dV93cmFwKCkgd2lsbCBzdGlsbCB3cmFwIGFyb3VuZCBhbmQgcGljayBpID09IGNwdSwgZXZlbiB0
aG91Z2ggaXQgc3RhcnRzDQo+IGZyb20gKGNwdSsxKS4uLg0KPiANCj4gVGhhbmtzLA0KPiAtQXVi
cmV5DQpZZXAsIGJ1dCB0aGF04oCZcyB0aGUgbGFzdCBjaG9pY2UsIHdlIG1heSBzdGVhbCB0aGUg
cmlnaHQgdGFzayBpbiBtb3N0IGNhc2VzIHdpdGhvdXQgc2tpcHBpbmcuIA0KSnVzdCBhbiBvcHRp
b24uIDopDQoNCj4gDQo+PiANCj4+PiANCj4+Pj4+ICtpZiAoaSA9PSBjcHUpDQo+Pj4+PiArY29u
dGludWU7DQo+Pj4+PiArDQo+Pj4+PiAraWYgKG5lZWRfcmVzY2hlZCgpKQ0KPj4+Pj4gK2JyZWFr
Ow0KPj4+PiBTaG91bGQgd2UgcmV0dXJuIHRydWUgaGVyZSB0byBhY2NlbGVyYXRlIHRoZSBicmVh
a2luZyBvZiBzY2hlZF9jb3JlX2JhbGFuY2U/IA0KPj4+PiBPdGhlcndpc2UgdGhlIGJyZWFraW5n
IHdvdWxkIGJlIGRlbGF5ZWQgdG8gdGhlIG5leHQgbGV2ZWwgc2QgaXRlcmF0aW9uLg0KQW5kIGNv
dWxkIHlvdSBoYXZlIGEgbG9vayBoZXJlLiA6KQ0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KSmlhbmcg
DQoNCj4+Pj4+ICsNCj4+Pj4+ICtpZiAodHJ5X3N0ZWFsX2Nvb2tpZShjcHUsIGkpKQ0KPj4+Pj4g
K3JldHVybiB0cnVlOw0KPj4+Pj4gK30NCj4+Pj4+ICsNCj4+Pj4+ICtyZXR1cm4gZmFsc2U7DQo+
Pj4+PiArfQ0KPj4+Pj4gKw0KPj4+Pj4gK3N0YXRpYyB2b2lkIHNjaGVkX2NvcmVfYmFsYW5jZShz
dHJ1Y3QgcnEgKnJxKQ0KPj4+Pj4gK3sNCj4+Pj4+ICtzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZDsN
Cj4+Pj4+ICtpbnQgY3B1ID0gY3B1X29mKHJxKTsNCj4+Pj4+ICsNCj4+Pj4+ICtyY3VfcmVhZF9s
b2NrX3NjaGVkKCk7DQo+Pj4+PiArcmF3X3NwaW5fdW5sb2NrX2lycShycV9sb2NrcChycSkpOw0K
Pj4+Pj4gK2Zvcl9lYWNoX2RvbWFpbihjcHUsIHNkKSB7DQo+Pj4+PiAraWYgKCEoc2QtPmZsYWdz
ICYgU0RfTE9BRF9CQUxBTkNFKSkNCj4+Pj4+ICticmVhazsNCj4+Pj4+ICsNCj4+Pj4+ICtpZiAo
bmVlZF9yZXNjaGVkKCkpDQo+Pj4+PiArYnJlYWs7DQo+Pj4+IElmIHJlc2NoZWRlZCBoZXJlLCB3
ZSBtaXNzZWQgdGhlIGNoYW5jZSB0byBkbyBmdXJ0aGVyIGZvcmNlZC1uZXdpZGxlIGJhbGFuY2Us
IA0KPj4+PiBhbmQgdGhlIGlkbGUtY29yZSBjb3VsZCBiZSBpZGxlIGZvciBhIGxvbmcgdGltZSwg
YmVjYXVzZSBsYWNraW5nIG9mIHB1bGxpbmcgY2hhbmNlLg0KPj4+PiBDb3VsZCBpdCBiZSBwb3Nz
aWJsZSB0byBhZGQgYSBuZXcgZm9yY2VkLW5ld2lkbGUgYmFsYW5jZSBjaGFuY2UgaW4gdGFza190
aWNrX2lkbGU/DQo+Pj4+IHdoaWNoIGNvdWxkIG1ha2UgaXQgbW9yZSBlZmZpY2llbnQuDQo+Pj4g
DQo+Pj4gVGhpcyBmbGFnIGluZGljYXRlcyB0aGVyZSBpcyBhbm90aGVyIHRocmVhZCBkZXNlcnZl
cyB0byBydW4sIFNvIEkgZ3Vlc3MgdGhlIGNvcmUgd29uJ3QNCj4+PiBiZSBpZGxlIGZvciBhIGxv
bmcgdGltZS4NCj4+PiANCj4+PiBUaGFua3MsDQo+Pj4gLUF1YnJleQ0KPj4gSW5kZWVkLCB0aGFu
a3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gOikNCj4+IA0KPj4+PiANCj4+Pj4+ICtpZiAoc3RlYWxf
Y29va2llX3Rhc2soY3B1LCBzZCkpDQo+Pj4+PiArYnJlYWs7DQo+Pj4+PiArfQ0KPj4+Pj4gK3Jh
d19zcGluX2xvY2tfaXJxKHJxX2xvY2twKHJxKSk7DQo+Pj4+PiArcmN1X3JlYWRfdW5sb2NrX3Nj
aGVkKCk7DQo+Pj4+PiArfQ0KPj4+Pj4gKw0KPj4+Pj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVShz
dHJ1Y3QgY2FsbGJhY2tfaGVhZCwgY29yZV9iYWxhbmNlX2hlYWQpOw0KPj4+Pj4gKw0KPj4+Pj4g
K3ZvaWQgcXVldWVfY29yZV9iYWxhbmNlKHN0cnVjdCBycSAqcnEpDQo+Pj4+PiArew0KPj4+Pj4g
K2lmICghc2NoZWRfY29yZV9lbmFibGVkKHJxKSkNCj4+Pj4+ICtyZXR1cm47DQo+Pj4+PiArDQo+
Pj4+PiAraWYgKCFycS0+Y29yZS0+Y29yZV9jb29raWUpDQo+Pj4+PiArcmV0dXJuOw0KPj4+Pj4g
Kw0KPj4+Pj4gK2lmICghcnEtPm5yX3J1bm5pbmcpIC8qIG5vdCBmb3JjZWQgaWRsZSAqLw0KPj4+
Pj4gK3JldHVybjsNCj4+Pj4+ICsNCj4+Pj4+ICtxdWV1ZV9iYWxhbmNlX2NhbGxiYWNrKHJxLCAm
cGVyX2NwdShjb3JlX2JhbGFuY2VfaGVhZCwgcnEtPmNwdSksIHNjaGVkX2NvcmVfYmFsYW5jZSk7
DQo+Pj4+PiArfQ0KPj4+Pj4gKw0KPj4+Pj4gI2Vsc2UgLyogIUNPTkZJR19TQ0hFRF9DT1JFICov
DQo+Pj4+PiANCj4+Pj4+IHN0YXRpYyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKg0KPj4+Pj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9zY2hlZC9pZGxlLmMgYi9rZXJuZWwvc2NoZWQvaWRsZS5jDQo+Pj4+PiBp
bmRleCBhOGQ0MGZmYWIwOTcuLmRmZjZiYTIyMGVkNyAxMDA2NDQNCj4+Pj4+IC0tLSBhL2tlcm5l
bC9zY2hlZC9pZGxlLmMNCj4+Pj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9pZGxlLmMNCj4+Pj4+IEBA
IC0zOTUsNiArMzk1LDcgQEAgc3RhdGljIHZvaWQgc2V0X25leHRfdGFza19pZGxlKHN0cnVjdCBy
cSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqbmV4dCwgYm9vbCBmaXINCj4+Pj4+IHsNCj4+Pj4+
IHVwZGF0ZV9pZGxlX2NvcmUocnEpOw0KPj4+Pj4gc2NoZWRzdGF0X2luYyhycS0+c2NoZWRfZ29p
ZGxlKTsNCj4+Pj4+ICtxdWV1ZV9jb3JlX2JhbGFuY2UocnEpOw0KPj4+Pj4gfQ0KPj4+Pj4gDQo+
Pj4+PiAjaWZkZWYgQ09ORklHX1NNUA0KPj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9z
Y2hlZC5oIGIva2VybmVsL3NjaGVkL3NjaGVkLmgNCj4+Pj4+IGluZGV4IDI5M2FhMWFlMDMwOC4u
NDY0NTU5Njc2ZmQyIDEwMDY0NA0KPj4+Pj4gLS0tIGEva2VybmVsL3NjaGVkL3NjaGVkLmgNCj4+
Pj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9zY2hlZC5oDQo+Pj4+PiBAQCAtMTA4OSw2ICsxMDg5LDgg
QEAgc3RhdGljIGlubGluZSByYXdfc3BpbmxvY2tfdCAqcnFfbG9ja3Aoc3RydWN0IHJxICpycSkN
Cj4+Pj4+IGJvb2wgY2ZzX3ByaW9fbGVzcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKmEsIHN0cnVjdCB0
YXNrX3N0cnVjdCAqYik7DQo+Pj4+PiB2b2lkIHNjaGVkX2NvcmVfYWRqdXN0X3NpYmxpbmdfdnJ1
bnRpbWUoaW50IGNwdSwgYm9vbCBjb3Jlc2NoZWRfZW5hYmxlZCk7DQo+Pj4+PiANCj4+Pj4+ICtl
eHRlcm4gdm9pZCBxdWV1ZV9jb3JlX2JhbGFuY2Uoc3RydWN0IHJxICpycSk7DQo+Pj4+PiArDQo+
Pj4+PiAjZWxzZSAvKiAhQ09ORklHX1NDSEVEX0NPUkUgKi8NCj4+Pj4+IA0KPj4+Pj4gc3RhdGlj
IGlubGluZSBib29sIHNjaGVkX2NvcmVfZW5hYmxlZChzdHJ1Y3QgcnEgKnJxKQ0KPj4+Pj4gQEAg
LTExMDEsNiArMTEwMywxMCBAQCBzdGF0aWMgaW5saW5lIHJhd19zcGlubG9ja190ICpycV9sb2Nr
cChzdHJ1Y3QgcnEgKnJxKQ0KPj4+Pj4gcmV0dXJuICZycS0+X19sb2NrOw0KPj4+Pj4gfQ0KPj4+
Pj4gDQo+Pj4+PiArc3RhdGljIGlubGluZSB2b2lkIHF1ZXVlX2NvcmVfYmFsYW5jZShzdHJ1Y3Qg
cnEgKnJxKQ0KPj4+Pj4gK3sNCj4+Pj4+ICt9DQo+Pj4+PiArDQo+Pj4+PiAjZW5kaWYgLyogQ09O
RklHX1NDSEVEX0NPUkUgKi8NCj4+Pj4+IA0KPj4+Pj4gI2lmZGVmIENPTkZJR19TQ0hFRF9TTVQN
Cj4+Pj4+IC0tIA0KPj4+Pj4gMi4xNy4xDQo+PiANCj4gDQo+IA0KDQo=
