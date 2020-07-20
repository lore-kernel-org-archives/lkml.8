Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09DEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD120691
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="Ka6Z/X+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgGTEOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:14:11 -0400
Received: from mail4.tencent.com ([183.57.53.109]:39304 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGTEOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:14:10 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 00:14:07 EDT
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id C2DA87220E;
        Mon, 20 Jul 2020 12:06:17 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595217977;
        bh=pUSsFIP7Z5tAJ1uz3XPO07xHR2JEmwLiUa+UeOeAejc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Ka6Z/X+FRMiteMO3Eu+OsezMPZ1pD9Q51oMo5KCdIVHjBnbx1A897F/q6OFTKul/o
         /jfa39rM834UymGjkBZMcBqrWSqWXC9M2YJtW8NSnkmR4jjG/wT9C0vFoirxxJtRSz
         FZFN7SiEGISMnMIrm4yCyAHHsYJ4mdx9Qsc4QCt8=
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 20 Jul
 2020 12:06:17 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ005.tencent.com
 (10.28.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 20 Jul
 2020 12:06:17 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Mon, 20 Jul 2020 12:06:17 +0800
From:   =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
CC:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
Thread-Index: AQHWTyYpnBjYC7x930alFUJ4JyvKnakPcZ0A
Date:   Mon, 20 Jul 2020 04:06:17 +0000
Message-ID: <750BB828-1AAE-4DED-A460-CF8ADDE3CFDA@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.34]
Content-Type: text/plain; charset="utf-8"
Content-ID: <91A29E622F3B844A917AC15E764C0710@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gSnVsIDEsIDIwMjAsIGF0IDU6MzIgQU0sIFZpbmVldGggUmVtYW5hbiBQaWxs
YWkgPHZwaWxsYWlAZGlnaXRhbG9jZWFuLmNvbT4gd3JvdGU6DQo+IA0KPiBGcm9tOiBQZXRlciBa
aWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IA0KPiBXaGVuIGEgc2libGluZyBpcyBm
b3JjZWQtaWRsZSB0byBtYXRjaCB0aGUgY29yZS1jb29raWU7IHNlYXJjaCBmb3INCj4gbWF0Y2hp
bmcgdGFza3MgdG8gZmlsbCB0aGUgY29yZS4NCj4gDQo+IHJjdV9yZWFkX3VubG9jaygpIGNhbiBp
bmN1ciBhbiBpbmZyZXF1ZW50IGRlYWRsb2NrIGluDQo+IHNjaGVkX2NvcmVfYmFsYW5jZSgpLiBG
aXggdGhpcyBieSB1c2luZyB0aGUgUkNVLXNjaGVkIGZsYXZvciBpbnN0ZWFkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
DQo+IFNpZ25lZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUpIDxqb2VsQGpvZWxmZXJu
YW5kZXMub3JnPg0KPiBBY2tlZC1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwu
b3JnPg0KPiAtLS0NCj4gaW5jbHVkZS9saW51eC9zY2hlZC5oIHwgICAxICsNCj4ga2VybmVsL3Nj
aGVkL2NvcmUuYyAgIHwgMTMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiBrZXJuZWwvc2NoZWQvaWRsZS5jICAgfCAgIDEgKw0KPiBrZXJuZWwvc2NoZWQvc2No
ZWQuaCAgfCAgIDYgKysNCj4gNCBmaWxlcyBjaGFuZ2VkLCAxMzggaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQuaCBiL2lu
Y2x1ZGUvbGludXgvc2NoZWQuaA0KPiBpbmRleCAzYzhkY2M1ZmYwMzkuLjRmOWVkZjAxM2RmMyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2hlZC5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvc2NoZWQuaA0KPiBAQCAtNjg4LDYgKzY4OCw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCB7DQo+
ICNpZmRlZiBDT05GSUdfU0NIRURfQ09SRQ0KPiAJc3RydWN0IHJiX25vZGUJCQljb3JlX25vZGU7
DQo+IAl1bnNpZ25lZCBsb25nCQkJY29yZV9jb29raWU7DQo+ICsJdW5zaWduZWQgaW50CQkJY29y
ZV9vY2N1cGF0aW9uOw0KPiAjZW5kaWYNCj4gDQo+ICNpZmRlZiBDT05GSUdfQ0dST1VQX1NDSEVE
DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY29yZS5jIGIva2VybmVsL3NjaGVkL2NvcmUu
Yw0KPiBpbmRleCA0ZDZkNmE2NzgwMTMuLmZiOWVkYjA5ZWFkNyAxMDA2NDQNCj4gLS0tIGEva2Vy
bmVsL3NjaGVkL2NvcmUuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IEBAIC0yMDEs
NiArMjAxLDIxIEBAIHN0YXRpYyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnNjaGVkX2NvcmVfZmluZChz
dHJ1Y3QgcnEgKnJxLCB1bnNpZ25lZCBsb25nIGNvb2tpZSkNCj4gCXJldHVybiBtYXRjaDsNCj4g
fQ0KPiANCj4gK3N0YXRpYyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnNjaGVkX2NvcmVfbmV4dChzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnAsIHVuc2lnbmVkIGxvbmcgY29va2llKQ0KPiArew0KPiArCXN0cnVj
dCByYl9ub2RlICpub2RlID0gJnAtPmNvcmVfbm9kZTsNCj4gKw0KPiArCW5vZGUgPSByYl9uZXh0
KG5vZGUpOw0KPiArCWlmICghbm9kZSkNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsNCj4gKwlwID0g
Y29udGFpbmVyX29mKG5vZGUsIHN0cnVjdCB0YXNrX3N0cnVjdCwgY29yZV9ub2RlKTsNCj4gKwlp
ZiAocC0+Y29yZV9jb29raWUgIT0gY29va2llKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0KPiAr
CXJldHVybiBwOw0KPiArfQ0KPiArDQo+IC8qDQo+ICAqIFRoZSBzdGF0aWMta2V5ICsgc3RvcC1t
YWNoaW5lIHZhcmlhYmxlIGFyZSBuZWVkZWQgc3VjaCB0aGF0Og0KPiAgKg0KPiBAQCAtNDIzMyw3
ICs0MjQ4LDcgQEAgcGlja19uZXh0X3Rhc2soc3RydWN0IHJxICpycSwgc3RydWN0IHRhc2tfc3Ry
dWN0ICpwcmV2LCBzdHJ1Y3QgcnFfZmxhZ3MgKnJmKQ0KPiAJc3RydWN0IHRhc2tfc3RydWN0ICpu
ZXh0LCAqbWF4ID0gTlVMTDsNCj4gCWNvbnN0IHN0cnVjdCBzY2hlZF9jbGFzcyAqY2xhc3M7DQo+
IAljb25zdCBzdHJ1Y3QgY3B1bWFzayAqc210X21hc2s7DQo+IC0JaW50IGksIGosIGNwdTsNCj4g
KwlpbnQgaSwgaiwgY3B1LCBvY2MgPSAwOw0KPiAJYm9vbCBuZWVkX3N5bmM7DQo+IA0KPiAJaWYg
KCFzY2hlZF9jb3JlX2VuYWJsZWQocnEpKQ0KPiBAQCAtNDMzMiw2ICs0MzQ3LDkgQEAgcGlja19u
ZXh0X3Rhc2soc3RydWN0IHJxICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwcmV2LCBzdHJ1Y3Qg
cnFfZmxhZ3MgKnJmKQ0KPiAJCQkJZ290byBkb25lOw0KPiAJCQl9DQo+IA0KPiArCQkJaWYgKCFp
c19pZGxlX3Rhc2socCkpDQo+ICsJCQkJb2NjKys7DQo+ICsNCj4gCQkJcnFfaS0+Y29yZV9waWNr
ID0gcDsNCj4gDQo+IAkJCS8qDQo+IEBAIC00MzU3LDYgKzQzNzUsNyBAQCBwaWNrX25leHRfdGFz
ayhzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnByZXYsIHN0cnVjdCBycV9mbGFn
cyAqcmYpDQo+IA0KPiAJCQkJCQljcHVfcnEoaiktPmNvcmVfcGljayA9IE5VTEw7DQo+IAkJCQkJ
fQ0KPiArCQkJCQlvY2MgPSAxOw0KPiAJCQkJCWdvdG8gYWdhaW47DQo+IAkJCQl9IGVsc2Ugew0K
PiAJCQkJCS8qDQo+IEBAIC00MzkzLDYgKzQ0MTIsOCBAQCBuZXh0X2NsYXNzOjsNCj4gCQlpZiAo
aXNfaWRsZV90YXNrKHJxX2ktPmNvcmVfcGljaykgJiYgcnFfaS0+bnJfcnVubmluZykNCj4gCQkJ
cnFfaS0+Y29yZV9mb3JjZWlkbGUgPSB0cnVlOw0KPiANCj4gKwkJcnFfaS0+Y29yZV9waWNrLT5j
b3JlX29jY3VwYXRpb24gPSBvY2M7DQo+ICsNCj4gCQlpZiAoaSA9PSBjcHUpDQo+IAkJCWNvbnRp
bnVlOw0KPiANCj4gQEAgLTQ0MDgsNiArNDQyOSwxMTQgQEAgbmV4dF9jbGFzczo7DQo+IAlyZXR1
cm4gbmV4dDsNCj4gfQ0KPiANCj4gK3N0YXRpYyBib29sIHRyeV9zdGVhbF9jb29raWUoaW50IHRo
aXMsIGludCB0aGF0KQ0KPiArew0KPiArCXN0cnVjdCBycSAqZHN0ID0gY3B1X3JxKHRoaXMpLCAq
c3JjID0gY3B1X3JxKHRoYXQpOw0KPiArCXN0cnVjdCB0YXNrX3N0cnVjdCAqcDsNCj4gKwl1bnNp
Z25lZCBsb25nIGNvb2tpZTsNCj4gKwlib29sIHN1Y2Nlc3MgPSBmYWxzZTsNCj4gKw0KPiArCWxv
Y2FsX2lycV9kaXNhYmxlKCk7DQo+ICsJZG91YmxlX3JxX2xvY2soZHN0LCBzcmMpOw0KPiArDQo+
ICsJY29va2llID0gZHN0LT5jb3JlLT5jb3JlX2Nvb2tpZTsNCj4gKwlpZiAoIWNvb2tpZSkNCj4g
KwkJZ290byB1bmxvY2s7DQo+ICsNCj4gKwlpZiAoZHN0LT5jdXJyICE9IGRzdC0+aWRsZSkNCj4g
KwkJZ290byB1bmxvY2s7DQo+ICsNCj4gKwlwID0gc2NoZWRfY29yZV9maW5kKHNyYywgY29va2ll
KTsNCj4gKwlpZiAocCA9PSBzcmMtPmlkbGUpDQo+ICsJCWdvdG8gdW5sb2NrOw0KPiArDQo+ICsJ
ZG8gew0KPiArCQlpZiAocCA9PSBzcmMtPmNvcmVfcGljayB8fCBwID09IHNyYy0+Y3VycikNCj4g
KwkJCWdvdG8gbmV4dDsNCj4gKw0KPiArCQlpZiAoIWNwdW1hc2tfdGVzdF9jcHUodGhpcywgJnAt
PmNwdXNfbWFzaykpDQo+ICsJCQlnb3RvIG5leHQ7DQo+ICsNCj4gKwkJaWYgKHAtPmNvcmVfb2Nj
dXBhdGlvbiA+IGRzdC0+aWRsZS0+Y29yZV9vY2N1cGF0aW9uKQ0KPiArCQkJZ290byBuZXh0Ow0K
PiArDQo+ICsJCXAtPm9uX3JxID0gVEFTS19PTl9SUV9NSUdSQVRJTkc7DQo+ICsJCWRlYWN0aXZh
dGVfdGFzayhzcmMsIHAsIDApOw0KPiArCQlzZXRfdGFza19jcHUocCwgdGhpcyk7DQo+ICsJCWFj
dGl2YXRlX3Rhc2soZHN0LCBwLCAwKTsNCj4gKwkJcC0+b25fcnEgPSBUQVNLX09OX1JRX1FVRVVF
RDsNCj4gKw0KPiArCQlyZXNjaGVkX2N1cnIoZHN0KTsNCj4gKw0KPiArCQlzdWNjZXNzID0gdHJ1
ZTsNCj4gKwkJYnJlYWs7DQo+ICsNCj4gK25leHQ6DQo+ICsJCXAgPSBzY2hlZF9jb3JlX25leHQo
cCwgY29va2llKTsNCj4gKwl9IHdoaWxlIChwKTsNCj4gKw0KPiArdW5sb2NrOg0KPiArCWRvdWJs
ZV9ycV91bmxvY2soZHN0LCBzcmMpOw0KPiArCWxvY2FsX2lycV9lbmFibGUoKTsNCj4gKw0KPiAr
CXJldHVybiBzdWNjZXNzOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgYm9vbCBzdGVhbF9jb29raWVf
dGFzayhpbnQgY3B1LCBzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCkNCj4gK3sNCj4gKwlpbnQgaTsN
Cj4gKw0KPiArCWZvcl9lYWNoX2NwdV93cmFwKGksIHNjaGVkX2RvbWFpbl9zcGFuKHNkKSwgY3B1
KSB7DQpTaW5jZSAoaSA9PSBjcHUpIHNob3VsZCBiZSBza2lwcGVkLCBzaG91bGQgd2Ugc3RhcnQg
aXRlcmF0aW9uIGF0IGNwdSsxPyBsaWtlLA0KCWZvcl9lYWNoX2NwdV93cmFwKGksIHNjaGVkX2Rv
bWFpbl9zcGFuKHNkKSwgY3B1KzEpIHsNCgkJ4oCmDQoJfQ0KSW4gdGhhdCB3YXksIHdlIGNvdWxk
IGF2b2lkIGhpdHRpbmcgZm9sbG93aW5nIGlmKGkgPT0gY3B1KSBhbHdheXMuDQo+ICsJCWlmIChp
ID09IGNwdSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWlmIChuZWVkX3Jlc2NoZWQoKSkN
Cj4gKwkJCWJyZWFrOw0KU2hvdWxkIHdlIHJldHVybiB0cnVlIGhlcmUgdG8gYWNjZWxlcmF0ZSB0
aGUgYnJlYWtpbmcgb2Ygc2NoZWRfY29yZV9iYWxhbmNlPyANCk90aGVyd2lzZSB0aGUgYnJlYWtp
bmcgd291bGQgYmUgZGVsYXllZCB0byB0aGUgbmV4dCBsZXZlbCBzZCBpdGVyYXRpb24uDQo+ICsN
Cj4gKwkJaWYgKHRyeV9zdGVhbF9jb29raWUoY3B1LCBpKSkNCj4gKwkJCXJldHVybiB0cnVlOw0K
PiArCX0NCj4gKw0KPiArCXJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQg
c2NoZWRfY29yZV9iYWxhbmNlKHN0cnVjdCBycSAqcnEpDQo+ICt7DQo+ICsJc3RydWN0IHNjaGVk
X2RvbWFpbiAqc2Q7DQo+ICsJaW50IGNwdSA9IGNwdV9vZihycSk7DQo+ICsNCj4gKwlyY3VfcmVh
ZF9sb2NrX3NjaGVkKCk7DQo+ICsJcmF3X3NwaW5fdW5sb2NrX2lycShycV9sb2NrcChycSkpOw0K
PiArCWZvcl9lYWNoX2RvbWFpbihjcHUsIHNkKSB7DQo+ICsJCWlmICghKHNkLT5mbGFncyAmIFNE
X0xPQURfQkFMQU5DRSkpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCQlpZiAobmVlZF9yZXNjaGVk
KCkpDQo+ICsJCQlicmVhazsNCklmIHJlc2NoZWRlZCBoZXJlLCB3ZSBtaXNzZWQgdGhlIGNoYW5j
ZSB0byBkbyBmdXJ0aGVyIGZvcmNlZC1uZXdpZGxlIGJhbGFuY2UsIA0KYW5kIHRoZSBpZGxlLWNv
cmUgY291bGQgYmUgaWRsZSBmb3IgYSBsb25nIHRpbWUsIGJlY2F1c2UgbGFja2luZyBvZiBwdWxs
aW5nIGNoYW5jZS4NCkNvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGFkZCBhIG5ldyBmb3JjZWQtbmV3
aWRsZSBiYWxhbmNlIGNoYW5jZSBpbiB0YXNrX3RpY2tfaWRsZT8NCndoaWNoIGNvdWxkIG1ha2Ug
aXQgbW9yZSBlZmZpY2llbnQuDQoNCj4gKwkJaWYgKHN0ZWFsX2Nvb2tpZV90YXNrKGNwdSwgc2Qp
KQ0KPiArCQkJYnJlYWs7DQo+ICsJfQ0KPiArCXJhd19zcGluX2xvY2tfaXJxKHJxX2xvY2twKHJx
KSk7DQo+ICsJcmN1X3JlYWRfdW5sb2NrX3NjaGVkKCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBE
RUZJTkVfUEVSX0NQVShzdHJ1Y3QgY2FsbGJhY2tfaGVhZCwgY29yZV9iYWxhbmNlX2hlYWQpOw0K
PiArDQo+ICt2b2lkIHF1ZXVlX2NvcmVfYmFsYW5jZShzdHJ1Y3QgcnEgKnJxKQ0KPiArew0KPiAr
CWlmICghc2NoZWRfY29yZV9lbmFibGVkKHJxKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYg
KCFycS0+Y29yZS0+Y29yZV9jb29raWUpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmICghcnEt
Pm5yX3J1bm5pbmcpIC8qIG5vdCBmb3JjZWQgaWRsZSAqLw0KPiArCQlyZXR1cm47DQo+ICsNCj4g
KwlxdWV1ZV9iYWxhbmNlX2NhbGxiYWNrKHJxLCAmcGVyX2NwdShjb3JlX2JhbGFuY2VfaGVhZCwg
cnEtPmNwdSksIHNjaGVkX2NvcmVfYmFsYW5jZSk7DQo+ICt9DQo+ICsNCj4gI2Vsc2UgLyogIUNP
TkZJR19TQ0hFRF9DT1JFICovDQo+IA0KPiBzdGF0aWMgc3RydWN0IHRhc2tfc3RydWN0ICoNCj4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9pZGxlLmMgYi9rZXJuZWwvc2NoZWQvaWRsZS5jDQo+
IGluZGV4IGE4ZDQwZmZhYjA5Ny4uZGZmNmJhMjIwZWQ3IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
c2NoZWQvaWRsZS5jDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9pZGxlLmMNCj4gQEAgLTM5NSw2ICsz
OTUsNyBAQCBzdGF0aWMgdm9pZCBzZXRfbmV4dF90YXNrX2lkbGUoc3RydWN0IHJxICpycSwgc3Ry
dWN0IHRhc2tfc3RydWN0ICpuZXh0LCBib29sIGZpcg0KPiB7DQo+IAl1cGRhdGVfaWRsZV9jb3Jl
KHJxKTsNCj4gCXNjaGVkc3RhdF9pbmMocnEtPnNjaGVkX2dvaWRsZSk7DQo+ICsJcXVldWVfY29y
ZV9iYWxhbmNlKHJxKTsNCj4gfQ0KPiANCj4gI2lmZGVmIENPTkZJR19TTVANCj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9zY2hlZC9zY2hlZC5oIGIva2VybmVsL3NjaGVkL3NjaGVkLmgNCj4gaW5kZXgg
MjkzYWExYWUwMzA4Li40NjQ1NTk2NzZmZDIgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9zY2hlZC9z
Y2hlZC5oDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9zY2hlZC5oDQo+IEBAIC0xMDg5LDYgKzEwODks
OCBAQCBzdGF0aWMgaW5saW5lIHJhd19zcGlubG9ja190ICpycV9sb2NrcChzdHJ1Y3QgcnEgKnJx
KQ0KPiBib29sIGNmc19wcmlvX2xlc3Moc3RydWN0IHRhc2tfc3RydWN0ICphLCBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKmIpOw0KPiB2b2lkIHNjaGVkX2NvcmVfYWRqdXN0X3NpYmxpbmdfdnJ1bnRpbWUo
aW50IGNwdSwgYm9vbCBjb3Jlc2NoZWRfZW5hYmxlZCk7DQo+IA0KPiArZXh0ZXJuIHZvaWQgcXVl
dWVfY29yZV9iYWxhbmNlKHN0cnVjdCBycSAqcnEpOw0KPiArDQo+ICNlbHNlIC8qICFDT05GSUdf
U0NIRURfQ09SRSAqLw0KPiANCj4gc3RhdGljIGlubGluZSBib29sIHNjaGVkX2NvcmVfZW5hYmxl
ZChzdHJ1Y3QgcnEgKnJxKQ0KPiBAQCAtMTEwMSw2ICsxMTAzLDEwIEBAIHN0YXRpYyBpbmxpbmUg
cmF3X3NwaW5sb2NrX3QgKnJxX2xvY2twKHN0cnVjdCBycSAqcnEpDQo+IAlyZXR1cm4gJnJxLT5f
X2xvY2s7DQo+IH0NCj4gDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgcXVldWVfY29yZV9iYWxhbmNl
KHN0cnVjdCBycSAqcnEpDQo+ICt7DQo+ICt9DQo+ICsNCj4gI2VuZGlmIC8qIENPTkZJR19TQ0hF
RF9DT1JFICovDQo+IA0KPiAjaWZkZWYgQ09ORklHX1NDSEVEX1NNVA0KPiAtLSANCj4gMi4xNy4x
DQo+IA0KPiANCg0K
