Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393A7207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgETMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:01:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2079 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgETMBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:01:48 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 64AB07AEC28EAF21D1F4;
        Wed, 20 May 2020 20:01:45 +0800 (CST)
Received: from DGGEMI421-HUB.china.huawei.com (10.1.199.150) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 20 May 2020 20:01:44 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.191]) by
 dggemi421-hub.china.huawei.com ([10.1.199.150]) with mapi id 14.03.0487.000;
 Wed, 20 May 2020 20:01:38 +0800
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
Thread-Index: AQHWLhsB19zOKbhSok+Mjvon7Zb2Y6iv78fAgABQKwCAAIyLcP//jOuAgACGTEA=
Date:   Wed, 20 May 2020 12:01:37 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24B2155@DGGEMI525-MBS.china.huawei.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-9-bigeasy@linutronix.de>
 <B926444035E5E2439431908E3842AFD24AFEC5@DGGEMI525-MBS.china.huawei.com>
 <20200520102634.pin4mzyytmfqtuo2@linutronix.de>
 <B926444035E5E2439431908E3842AFD24B2058@DGGEMI525-MBS.china.huawei.com>
 <20200520115741.wy2qnmauxmjtrrzj@linutronix.de>
In-Reply-To: <20200520115741.wy2qnmauxmjtrrzj@linutronix.de>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDgvOF0gbW0venN3YXA6IFVzZSBsb2NhbCBsb2NrIHRvIHBy
b3RlY3QgcGVyLUNQVSBkYXRhDQo+IA0KPiBPbiAyMDIwLTA1LTIwIDExOjEzOjMxIFsrMDAwMF0s
IFNvbmcgQmFvIEh1YSB3cm90ZToNCj4gPiBGb3IgZXhhbXBsZSwgb24gY3B1MSwgb25jZSB5b3Ug
YmVnaW4gdG8gY29tcHJlc3MsIHlvdSBob2xkIHRoZSBwZXJjcHUNCj4gYWNvbXAtY3R4IGFuZCBw
ZXJjcHUgZGVzdGluYXRpb24gYnVmZmVyIG9mIENQVTEsIHRoZSBiZWxvdyBjb2RlIG1ha2VzIHN1
cmUNCj4geW91IGdldCB0aGUgYWNvbXAgYW5kIGRzdG1lbSBmcm9tIHRoZSBzYW1lIGNvcmUgYnkg
ZGlzYWJsaW5nIHByZWVtcHRpb24NCj4gd2l0aCBnZXRfY3B1X3ZhciBhbmQgcHV0X2NwdV92YXI6
DQo+ID4gZHN0ID0gZ2V0X2NwdV92YXIoenN3YXBfZHN0bWVtKTsNCj4gPiBhY29tcF9jdHggPSAq
dGhpc19jcHVfcHRyKGVudHJ5LT5wb29sLT5hY29tcF9jdHgpOw0KPiA+IHB1dF9jcHVfdmFyKHpz
d2FwX2RzdG1lbSk7DQo+ID4NCj4gPiB0aGVuIHRoZXJlIGFyZSB0d28gY2FzZXM6DQo+ID4NCj4g
PiAxLiBhZnRlciBnZXR0aW5nIGRzdCBhbmQgYWNvbXBfY3R4IG9mIGNwdTEsIHlvdSBtaWdodCBh
bHdheXMgd29yayBpbiBjcHUxLA0KPiB0aGUgbXV0ZXggaW4gcGVyLWNwdSBhY29tcC1jdHggd2ls
bCBndWFyYW50ZWUgdHdvIGNvbXByZXNzaW9ucyB3b24ndCBkbyBhdA0KPiB0aGUgc2FtZSBjb3Jl
IGluIHBhcmFsbGVsLCBhbmQgaXQgYWxzbyBtYWtlcyBjZXJ0YWluIGNvbXByZXNzaW9uIGFuZA0K
PiBkZWNvbXByZXNzaW9uIHdvbid0IGRvIGF0IHRoZSBzYW1lIGNvcmUgaW4gcGFyYWxsZWwuIEV2
ZXJ5dGhpbmcgaXMgbGlrZSBiZWZvcmUuDQo+IA0KPiBGb3IgcmVhZGFiaWxpdHkgSSBzdWdnZXN0
IG5vdCB0byBtaXggcGVyLUNQVSBhbmQgcGVyLUNUWCB2YXJpYWJsZXMgbGlrZSB0aGF0LiBJZg0K
PiB6c3dhcF9kc3RtZW0gaXMgcHJvdGVjdGVkIGJ5IHRoZSBtdXRleCwgcGxlYXNlIG1ha2UgaXQg
cGFydCBvZiBhY29tcF9jdHguDQo+IA0KDQpZZXAuIGl0IHNlZW1zIHRoaXMgd2lsbCBhdm9pZCB0
aGUgZnVydGhlciBleHBsYW5hdGlvbnMgdG8gbW9yZSBwZW9wbGUgd2hvIHdpbGwgcmVhZCB0aGUg
Y29kZSA6LSkNCg0KPiBTZWJhc3RpYW4NCg0KQmFycnkNCg0K
