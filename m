Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A12EC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB2220674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgATKvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:51:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43439 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgATKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:51:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-77-UQ1tz0pqPPOA0jnC9SlVCQ-1; Mon, 20 Jan 2020 10:51:08 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 10:51:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jan 2020 10:51:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
        'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Topic: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkAAAO3PAAAmXEggAAKDBAAAAvfesAABpyOAAABDBiAA7uyIgAAB3Sgw
Date:   Mon, 20 Jan 2020 10:51:07 +0000
Message-ID: <512f01b3e4cd4c3fa26ce767466fec21@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
 <20200114115906.22f952ff@gandalf.local.home>
 <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
 <20200114124812.4d5355ae@gandalf.local.home>
 <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
 <20200115081830.036ade4e@gandalf.local.home>
 <9f98b2dd807941a3b85d217815a4d9aa@AcuMS.aculab.com>
 <20200115103049.06600f6e@gandalf.local.home>
 <ab54668ad13d48da8aa43f955631ef9e@AcuMS.aculab.com>
 <26b2f8f7-b11f-0df0-5260-a232e1d5bf1a@arm.com>
In-Reply-To: <26b2f8f7-b11f-0df0-5260-a232e1d5bf1a@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UQ1tz0pqPPOA0jnC9SlVCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGlldG1hciBFZ2dlbWFubg0KPiBTZW50OiAyMCBKYW51YXJ5IDIwMjAgMDk6MzkNCi4u
DQo+ID4gSSBndWVzcyB0aGlzIG9ubHkgJ2dpdmVzIGF3YXknIGV4dHJhIFJUIHByb2Nlc3Nlcy4N
Cj4gPiBSYXRoZXIgdGhhbiAnc3RlYWxpbmcnIHRoZW0gLSB3aGljaCBpcyB3aGF0IEkgbmVlZC4N
Cj4gDQo+IElzbid0IHBhcnQgb2YgdGhlIHByb2JsZW0gdGhhdCBSVCBkb2Vzbid0IG1haW50YWlu
DQo+IGNwLT5wcmlfdG9fY3B1W0NQVVBSSV9JRExFXSAoQ1BVUFJJX0lETEUgPSAwKS4NCj4gDQo+
IFNvIHB1c2gvcHVsbCAoZmluZF9sb3dlc3RfcnEoKSkgbmV2ZXIgcmV0dXJucyBhIG1hc2sgb2Yg
aWRsZSBDUFVzLg0KPiANCj4gVGhlcmUgd2FzDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MTQxNTI2MDMyNy0zMDQ2NS0yLWdpdC1zZW5kLWVtYWlsLXBhbmcueHVubGVpQGxpbmFyby5vcmcN
Cj4gaW4gMjAxNCBidXQgaXQgZGlkbid0IGdvIG1haW5saW5lLg0KPiANCj4gVGhlcmUgd2FzIGEg
c2ltaWxhciBxdWVzdGlvbiBpbiBOb3YgbGFzdCB5ZWFyOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci9DSDJQUjE5TUIzODk2QUZFMUQxM0FEODhBMTcxNjA4NjBGQzcwMEBDSDJQUjE5
TUIzODk2Lm5hbXByZDE5LnByb2Qub3V0bG9vay5jb20NCg0KVGhleSBhcmUgcHJvYmFibHkgYWxs
IHJlbGF0ZWQuDQpNeSBicmFpbiBkb2Vzbid0IGhhdmUgc3BhY2UgdG8gY29tcGxldGVseSAnZ3Jv
aycgdGhlIHNjaGVkdWxlciB3aXRob3V0IHNvbWV0aGluZw0KZWxzZSBiZWluZyBwdXNoZWQgb3V0
IG9mIHRoZSBtYWluIGNhY2hlLg0KDQpJIGJldCB0aGVyZSBhcmUgb3RoZXIgY2FzZXMgd2hlcmUg
aXQgZGVjaWRlcyB0byBydW4gYSBwcm9jZXNzIG9uIGEgY3B1IHRoYXQNCmlzIHJ1bm5pbmcgYSBw
cm9jZXNzIHRoYXQgaXMgYm91bmQgdG8gdGhhdCBjcHUgd2hpbGUgdGhlcmUgYXJlIG90aGVyIGlk
bGUgY3B1Lg0KDQpQYXJ0aWFsbHkgYmVjYXVzZSB0aGUgcHJvYmxlbSBpcyAnaGFyZCcsIGdldHRp
bmcgaXQgYW55d2hlcmUgbmVhciAncmlnaHQnDQpmb3IgTlVNQSBzeXN0ZW1zIHdpdGggbG90cyBv
ZiBjcHVzIHdpdGhvdXQgdXNpbmcgYWxsIHRoZSBwcm9jZXNzaW5nDQpwb3dlciBqdXN0IGRlY2lk
aW5nIHdoYXQgdG8gcnVuIGlzIHByb2JhYmx5IGltcG9zc2libGUuDQpIb3dldmVyIGZhc3RlciBk
ZWNpc2lvbnMgY2FuIHByb2JhYmx5IGJlIG1hZGUgd2l0aCAnc2xpZ2h0bHkgc3RhbGUnIGRhdGEg
dGhhdA0KZ2V0IGNvcnJlY3RlZCBsYXRlciBpZiB0aGV5IGFyZSBpbmNvcnJlY3QuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

