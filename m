Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330BAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14409207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgETLNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:13:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETLNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:13:42 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E03853142281D6A3D371;
        Wed, 20 May 2020 19:13:39 +0800 (CST)
Received: from DGGEMI421-HUB.china.huawei.com (10.1.199.150) by
 dggemi405-hub.china.huawei.com (10.3.17.143) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 20 May 2020 19:13:39 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.191]) by
 dggemi421-hub.china.huawei.com ([10.1.199.150]) with mapi id 14.03.0487.000;
 Wed, 20 May 2020 19:13:32 +0800
From:   Song Bao Hua <song.bao.hua@hisilicon.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Thread-Topic: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Thread-Index: AQHWLhsB19zOKbhSok+Mjvon7Zb2Y6iv78fAgABQKwCAAIyLcA==
Date:   Wed, 20 May 2020 11:13:31 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24B2058@DGGEMI525-MBS.china.huawei.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-9-bigeasy@linutronix.de>
 <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
 <20200520102634.pin4mzyytmfqtuo2@linutronix.de>
In-Reply-To: <20200520102634.pin4mzyytmfqtuo2@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.151]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMDIwLTA1LTE5IDIxOjQ2OjA2IFsrMDAwMF0sIFNvbmcgQmFvIEh1YSB3cm90ZToNCj4g
PiBIaSBMdWlzLA0KPiA+IEluIHRoZSBiZWxvdyBwYXRjaCwgaW4gb3JkZXIgdG8gdXNlIHRoZSBh
Y29tcCBBUElzIHRvIGxldmVyYWdlIHRoZSBwb3dlciBvZg0KPiBoYXJkd2FyZSBjb21wcmVzc29y
cy4gSSBoYXZlIG1vdmVkIHRvIG11dGV4Og0KPiA+IGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4
LWNyeXB0by12Z2VyJm09MTU4OTQxMjg1ODMwMzAyJnc9Mg0KPiA+IGh0dHBzOi8vbWFyYy5pbmZv
Lz9sPWxpbnV4LWNyeXB0by12Z2VyJm09MTU4OTQxMjg3OTMwMzExJnc9Mg0KPiA+DQo+ID4gc28g
b25jZSB3ZSBnZXQgc29tZSBwcm9ncmVzcyBvbiB0aGF0IG9uZSwgSSBndWVzcyB3ZSBkb24ndCBu
ZWVkIGEgc3BlY2lhbA0KPiBwYXRjaCBmb3IgUlQgYW55IG1vcmUuDQo+IA0KPiBJZiB5b3UgY29u
dmVydCB0aGlzIHdheSBmcm9tIHRoZSBjdXJyZW50IGNvbmNlcHQgdGhlbiB3ZSBjb3VsZCBkcm9w
IGl0IGZyb20NCj4gdGhlIHNlcmllcy4NCj4gVGhlIHNlY29uZCBwYXRjaCBzaG93cyB0aGUgZm9s
bG93aW5nIGh1bms6DQo+IA0KPiB8QEAgLTEwNzUsMTEgKzExMjQsMjAgQEAgc3RhdGljIGludCB6
c3dhcF9mcm9udHN3YXBfc3RvcmUodW5zaWduZWQNCj4gdHlwZSwNCj4gfHBnb2ZmX3Qgb2Zmc2V0
LA0KPiB8DQo+IHwgCS8qIGNvbXByZXNzICovDQo+IHwgCWRzdCA9IGdldF9jcHVfdmFyKHpzd2Fw
X2RzdG1lbSk7DQo+IHwJYWNvbXBfY3R4ID0gKnRoaXNfY3B1X3B0cihlbnRyeS0+cG9vbC0+YWNv
bXBfY3R4KTsNCj4gfAlwdXRfY3B1X3Zhcih6c3dhcF9kc3RtZW0pOw0KPiANCj4gU28gaGVyZSB5
b3UgZ2V0IHBlci1DUFUgdmVyc2lvbiBvZiBgZHN0JyBhbmQgYGFjb21wX2N0eCcgYW5kIHRoZW4g
YWxsb3cNCj4gcHJlZW1wdGlvbiBhZ2Fpbi4NCj4gDQo+IHwJbXV0ZXhfbG9jaygmYWNvbXBfY3R4
LT5tdXRleCk7DQo+IHwNCj4gfAlzcmMgPSBrbWFwKHBhZ2UpOw0KPiB8CXNnX2luaXRfb25lKCZp
bnB1dCwgc3JjLCBQQUdFX1NJWkUpOw0KPiB8CS8qIHpzd2FwX2RzdG1lbSBpcyBvZiBzaXplIChQ
QUdFX1NJWkUgKiAyKS4gUmVmbGVjdCBzYW1lIGluIHNnX2xpc3QgKi8NCj4gfAlzZ19pbml0X29u
ZSgmb3V0cHV0LCBkc3QsIFBBR0VfU0laRSAqIDIpOw0KPiANCj4gYW5kIGhlcmUgeW91IHVzZSBg
ZHN0JyBhbmQgYGFjb21wX2N0eCcgYWZ0ZXIgdGhlIHByZWVtcHRfZGlzYWJsZSgpIGhhcyBiZWVu
DQo+IGRyb3BwZWQgc28gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3UgdXNlZCBnZXRfY3B1X3Zh
cigpLiBJdCBpcyBlaXRoZXINCj4gcHJvdGVjdGVkIGJ5IHRoZSBtdXRleCBhbmQgZG9lc24ndCBy
ZXF1aXJlIGdldF9jcHVfdmFyKCkgb3IgaXQgaXNuJ3QgKGFuZA0KPiBzaG91bGQgaGF2ZSBhZGRp
dGlvbmFsIHByb3RlY3Rpb24pLg0KDQpUaGUgb2xkIGNvZGUgd2FzIGxpa2U6DQpGb3IgZWFjaCBj
cHUsIHRoZXJlIGlzIG9uZSBwZXJjcHUgY29tcCBhbmQgb25lIHBlcmNwdSBwYWdlcyBmb3IgY29t
cHJlc3Npb24gZGVzdGluYXRpb24gLSB6c3dhcF9kc3RtZW0uDQpGb3IgZXhhbXBsZSwgb24gY3B1
MSwgb25jZSB5b3UgYmVnaW4gdG8gY29tcHJlc3MsIHlvdSBob2xkIHRoZSBwZXJjcHUgY29tcCBh
bmQgcGVyY3B1IGRlc3RpbmF0aW9uIGJ1ZmZlci4gTWVhbndoaWxlLCBwcmVlbXB0aW9uIGlzIGRp
c2FibGVkLiBTbyBkZWNvbXByZXNzaW9uIHdvbid0IGJlIGFibGUgdG8gd29yayBhdCB0aGUgc2Ft
ZSBjb3JlIGluIHBhcmFsbGVsLiBBbmQgdHdvIGNvbXByZXNzaW9ucyB3b24ndCBiZSBhYmxlIHRv
IGRvIGF0IHRoZSBzYW1lIGNvcmUgaW4gcGFyYWxsZWwgYXMgd2VsbC4gQXQgdGhlIHNhbWUgdGlt
ZSwgdGhlIHRocmVhZCB3b24ndCBiZSBhYmxlIHRvIG1pZ3JhdGUgdG8gYW5vdGhlciBjb3JlLiBP
dGhlciBjb3JlcyBtaWdodCBjYW4gZG8gY29tcHJlc3Npb24vZGVjb21wcmVzc2lvbiBpbiBwYXJh
bGxlbA0KDQpUaGUgbmV3IGNvZGUgaXMgbGlrZToNCkZvciBlYWNoIGNwdSwgdGhlcmUgaXMgc3Rp
bGwgb25lIHBlcmNwdSBhY29tcC1jdHggYW5kIG9uZSBwZXJjcHUgcGFnZXMgZm9yIGNvbXByZXNz
aW9uIGRlc3RpbmF0aW9uLiBIZXJlIGFjb21wIHJlcGxhY2VzIGNvbXAsIGFuZCBhY29tcCByZXF1
aXJlcyBzbGVlcCBkdXJpbmcgY29tcHJlc3NpbmcgYW5kIGRlY29tcHJlc3NpbmcuDQpGb3IgZXhh
bXBsZSwgb24gY3B1MSwgb25jZSB5b3UgYmVnaW4gdG8gY29tcHJlc3MsIHlvdSBob2xkIHRoZSBw
ZXJjcHUgYWNvbXAtY3R4IGFuZCBwZXJjcHUgZGVzdGluYXRpb24gYnVmZmVyIG9mIENQVTEsIHRo
ZSBiZWxvdyBjb2RlIG1ha2VzIHN1cmUgeW91IGdldCB0aGUgYWNvbXAgYW5kIGRzdG1lbSBmcm9t
IHRoZSBzYW1lIGNvcmUgYnkgZGlzYWJsaW5nIHByZWVtcHRpb24gd2l0aCBnZXRfY3B1X3ZhciBh
bmQgcHV0X2NwdV92YXI6DQpkc3QgPSBnZXRfY3B1X3Zhcih6c3dhcF9kc3RtZW0pOw0KYWNvbXBf
Y3R4ID0gKnRoaXNfY3B1X3B0cihlbnRyeS0+cG9vbC0+YWNvbXBfY3R4KTsNCnB1dF9jcHVfdmFy
KHpzd2FwX2RzdG1lbSk7DQoNCnRoZW4gdGhlcmUgYXJlIHR3byBjYXNlczoNCg0KMS4gYWZ0ZXIg
Z2V0dGluZyBkc3QgYW5kIGFjb21wX2N0eCBvZiBjcHUxLCB5b3UgbWlnaHQgYWx3YXlzIHdvcmsg
aW4gY3B1MSwgdGhlIG11dGV4IGluIHBlci1jcHUgYWNvbXAtY3R4IHdpbGwgZ3VhcmFudGVlIHR3
byBjb21wcmVzc2lvbnMgd29uJ3QgZG8gYXQgdGhlIHNhbWUgY29yZSBpbiBwYXJhbGxlbCwgYW5k
IGl0IGFsc28gbWFrZXMgY2VydGFpbiBjb21wcmVzc2lvbiBhbmQgZGVjb21wcmVzc2lvbiB3b24n
dCBkbyBhdCB0aGUgc2FtZSBjb3JlIGluIHBhcmFsbGVsLiBFdmVyeXRoaW5nIGlzIGxpa2UgYmVm
b3JlLg0KDQoyLiBhZnRlciBnZXR0aW5nIGRzdCBhbmQgYWNvbXBfY3R4IG9mIGNwdTEsIHlvdSBt
aWdodCBtaWdyYXRlIHRvIGNwdTIsIGJ1dCBldmVuIHlvdSBtb3ZlIHRvIGNwdTIsIHlvdSBhcmUg
c3RpbGwgaG9sZGluZyB0aGUgbXV0ZXggb2YgY3B1MSdzIGFjb21wLWN0eC4NCklmIGF0IHRoYXQg
dGltZSwgY3B1MSBoYXMgYW5vdGhlciByZXF1ZXN0IHRvIGRvIGNvbXByZXNzaW9uLCBpdCB3aWxs
IGJlIGJsb2NrZWQgYnkgdGhlIG11dGV4IGhlbGQgYnkgY3B1Mi4NCklmIGF0IHRoYXQgdGltZSwg
Y3B1MSB3YW50cyB0byBkbyBkZWNvbXByZXNzaW9uLCBpdCB3aWwgYmUgYmxvY2tlZCBieSB0aGUg
bXV0ZXggaGVsZCBieSBjcHUyLg0KDQpFdmVyeXRoaW5nIGlzIGxpa2UgYmVmb3JlLiBObyBtYXR0
ZXIgd2hpY2ggY29yZSB5b3UgaGF2ZSBtaWdyYXRlZCB0bywgb25jZSB5b3UgaG9sZCB0aGUgbXV0
ZXggb2YgY29yZSBOLCBhbm90aGVyIGNvbXByZXNzaW9uL2RlY29tcHJlc3Npb24gd2hvIHdhbnRz
IHRvIGhvbGQgdGhlIG11dGV4IG9mIGNvcmUgTiB3aWxsIGJlIGJsb2NrZWQuIFNvIG1vc3RseSwg
aWYgeW91IGhhdmUgTSBjb3JlcywgeW91IGNhbiBkbyBNIGNvbXByZXNzaW9uL2RlY29tcHJlc3Np
b24gaW4gcGFyYWxsZWwgbGlrZSBiZWZvcmUuDQoNCk15IGJhc2ljIGlkZWEgaXMga2VlcGluZyB0
aGUgd29yayBtb2RlbCB1bmNoYW5nZWQgbGlrZSBiZWZvcmUuDQoNCj4gDQo+IHwJYWNvbXBfcmVx
dWVzdF9zZXRfcGFyYW1zKGFjb21wX2N0eC0+cmVxLCAmaW5wdXQsICZvdXRwdXQsDQo+IFBBR0Vf
U0laRSwgZGxlbik7DQo+IHwJcmV0ID0gY3J5cHRvX3dhaXRfcmVxKGNyeXB0b19hY29tcF9jb21w
cmVzcyhhY29tcF9jdHgtPnJlcSksDQo+ICZhY29tcF9jdHgtPndhaXQpOw0KPiB8CWRsZW4gPSBh
Y29tcF9jdHgtPnJlcS0+ZGxlbjsNCj4gfAlrdW5tYXAocGFnZSk7DQo+IHwNCj4gfCAJaWYgKHJl
dCkgew0KPiB8IAkJcmV0ID0gLUVJTlZBTDsNCj4gfCAJCWdvdG8gcHV0X2RzdG1lbTsNCj4gfA0K
PiANCj4gU2ViYXN0aWFuDQoNCkJhcnJ5DQoNCg==
