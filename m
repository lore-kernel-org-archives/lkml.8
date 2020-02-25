Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8D5C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgBYJfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:35:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:34742 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729130AbgBYJfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:35:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-139-XFybLFxQPiu5Cqco6NpUCA-1; Tue, 25 Feb 2020 09:35:28 +0000
X-MC-Unique: XFybLFxQPiu5Cqco6NpUCA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Feb 2020 09:35:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Feb 2020 09:35:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        John Keeping <john@metanate.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf: fix -Wstring-compare
Thread-Topic: [PATCH] perf: fix -Wstring-compare
Thread-Index: AQHV6tcUuLM+xYY6ZEGXR+PNFoTxX6gqgYIggABl+niAAL+1kA==
Date:   Tue, 25 Feb 2020 09:35:27 +0000
Message-ID: <7fe0ca3e6fb64ca59986584fffa824e6@AcuMS.aculab.com>
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
 <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
 <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com>
 <CAP-5=fXO+YMO9asspqYdvXATZONCbBYMGbdVNU_3+W3BdeunGg@mail.gmail.com>
 <CAKwvOdko+Qb=h_Pm=oFUnsiBg7Am9u=Z83g8cNyY1QZQS=Mh7g@mail.gmail.com>
In-Reply-To: <CAKwvOdko+Qb=h_Pm=oFUnsiBg7Am9u=Z83g8cNyY1QZQS=Mh7g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyNCBGZWJydWFyeSAyMDIwIDIyOjA2DQo+
IE9uIE1vbiwgRmViIDI0LCAyMDIwIGF0IDEwOjIwIEFNICdJYW4gUm9nZXJzJyB2aWEgQ2xhbmcg
QnVpbHQgTGludXgNCj4gPGNsYW5nLWJ1aWx0LWxpbnV4QGdvb2dsZWdyb3Vwcy5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gT24gTW9uLCBGZWIgMjQsIDIwMjAgYXQgODowMyBBTSBEYXZpZCBMYWlnaHQg
PERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBGcm9tOiBJYW4g
Um9nZXJzDQo+ID4gPiA+IFNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjAgMDU6NTYNCj4gPiA+ID4gT24g
U3VuLCBGZWIgMjMsIDIwMjAgYXQgMTE6MzUgQU0gTmljayBEZXNhdWxuaWVycw0KPiA+ID4gPiA8
bmljay5kZXNhdWxuaWVyc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
Q2xhbmcgd2FybnM6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiB1dGlsL2Jsb2NrLWluZm8uYzoyOTg6
MTg6IGVycm9yOiByZXN1bHQgb2YgY29tcGFyaXNvbiBhZ2FpbnN0IGEgc3RyaW5nDQo+ID4gPiA+
ID4gbGl0ZXJhbCBpcyB1bnNwZWNpZmllZCAodXNlIGFuIGV4cGxpY2l0IHN0cmluZyBjb21wYXJp
c29uIGZ1bmN0aW9uDQo+ID4gPiA+ID4gaW5zdGVhZCkgWy1XZXJyb3IsLVdzdHJpbmctY29tcGFy
ZV0NCj4gPiA+ID4gPiAgICAgICAgIGlmICgoc3RhcnRfbGluZSAhPSBTUkNMSU5FX1VOS05PV04p
ICYmIChlbmRfbGluZSAhPSBTUkNMSU5FX1VOS05PV04pKSB7DQo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgXiAgfn5+fn5+fn5+fn5+fn5+DQo+ID4gPiA+ID4gdXRpbC9ibG9jay1p
bmZvLmM6Mjk4OjUxOiBlcnJvcjogcmVzdWx0IG9mIGNvbXBhcmlzb24gYWdhaW5zdCBhIHN0cmlu
Zw0KPiA+ID4gPiA+IGxpdGVyYWwgaXMgdW5zcGVjaWZpZWQgKHVzZSBhbiBleHBsaWNpdCBzdHJp
bmcgY29tcGFyaXNvbiBmdW5jdGlvbg0KPiA+ID4gPiA+IGluc3RlYWQpIFstV2Vycm9yLC1Xc3Ry
aW5nLWNvbXBhcmVdDQo+ID4gPiA+ID4gICAgICAgICBpZiAoKHN0YXJ0X2xpbmUgIT0gU1JDTElO
RV9VTktOT1dOKSAmJiAoZW5kX2xpbmUgIT0gU1JDTElORV9VTktOT1dOKSkgew0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4gIH5+fn5+fn5+fn5+fn5+fg0KPiA+ID4gPiA+IHV0aWwvYmxvY2staW5mby5jOjI5ODoxODog
ZXJyb3I6IHJlc3VsdCBvZiBjb21wYXJpc29uIGFnYWluc3QgYSBzdHJpbmcNCj4gPiA+ID4gPiBs
aXRlcmFsIGlzIHVuc3BlY2lmaWVkICh1c2UgYW4gZXhwbGljaXQgc3RyaW5nDQo+ID4gPiA+ID4g
Y29tcGFyaXNvbiBmdW5jdGlvbiBpbnN0ZWFkKSBbLVdlcnJvciwtV3N0cmluZy1jb21wYXJlXQ0K
PiA+ID4gPiA+ICAgICAgICAgaWYgKChzdGFydF9saW5lICE9IFNSQ0xJTkVfVU5LTk9XTikgJiYg
KGVuZF9saW5lICE9IFNSQ0xJTkVfVU5LTk9XTikpIHsNCj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBeICB+fn5+fn5+fn5+fn5+fn4NCj4gPiA+ID4gPiB1dGlsL2Jsb2NrLWluZm8u
YzoyOTg6NTE6IGVycm9yOiByZXN1bHQgb2YgY29tcGFyaXNvbiBhZ2FpbnN0IGEgc3RyaW5nDQo+
ID4gPiA+ID4gbGl0ZXJhbCBpcyB1bnNwZWNpZmllZCAodXNlIGFuIGV4cGxpY2l0IHN0cmluZyBj
b21wYXJpc29uIGZ1bmN0aW9uDQo+ID4gPiA+ID4gaW5zdGVhZCkgWy1XZXJyb3IsLVdzdHJpbmct
Y29tcGFyZV0NCj4gPiA+ID4gPiAgICAgICAgIGlmICgoc3RhcnRfbGluZSAhPSBTUkNMSU5FX1VO
S05PV04pICYmIChlbmRfbGluZSAhPSBTUkNMSU5FX1VOS05PV04pKSB7DQo+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXiAg
fn5+fn5+fn5+fn5+fn5+DQo+ID4gPiA+ID4gdXRpbC9tYXAuYzo0MzQ6MTU6IGVycm9yOiByZXN1
bHQgb2YgY29tcGFyaXNvbiBhZ2FpbnN0IGEgc3RyaW5nIGxpdGVyYWwNCj4gPiA+ID4gPiBpcyB1
bnNwZWNpZmllZCAodXNlIGFuIGV4cGxpY2l0IHN0cmluZyBjb21wYXJpc29uIGZ1bmN0aW9uIGlu
c3RlYWQpDQo+ID4gPiA+ID4gWy1XZXJyb3IsLVdzdHJpbmctY29tcGFyZV0NCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgaWYgKHNyY2xpbmUgIT0gU1JDTElORV9VTktOT1dOKQ0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeICB+fn5+fn5+fn5+fn5+fn4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGlu
dXgvaXNzdWVzLzkwMA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE5pY2sgRGVzYXVsbmllcnMg
PG5pY2suZGVzYXVsbmllcnNAZ21haWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IE5v
dGU6IHdhcyBnZW5lcmF0ZWQgb2ZmIG9mIG1haW5saW5lOyBjYW4gcmViYXNlIG9uIC1uZXh0IGlm
IGl0IGRvZXNuJ3QNCj4gPiA+ID4gPiBhcHBseSBjbGVhbmx5Lg0KPiA+DQo+ID4gUmV2aWV3ZWQt
Ynk6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gPg0KPiA+ID4gPiBMb29rcyBn
b29kIHRvIG1lLiBTb21lIG1vcmUgY29udGV4dDoNCj4gPiA+ID4gaHR0cHM6Ly9jbGFuZy5sbHZt
Lm9yZy9kb2NzL0RpYWdub3N0aWNzUmVmZXJlbmNlLmh0bWwjd3N0cmluZy1jb21wYXJlDQo+ID4g
PiA+IFRoZSBzcGVjIHNheXM6DQo+ID4gPiA+IEouMSBVbnNwZWNpZmllZCBiZWhhdmlvcg0KPiA+
ID4gPiBUaGUgZm9sbG93aW5nIGFyZSB1bnNwZWNpZmllZDoNCj4gPiA+ID4gLi4gV2hldGhlciB0
d28gc3RyaW5nIGxpdGVyYWxzIHJlc3VsdCBpbiBkaXN0aW5jdCBhcnJheXMgKDYuNC41KS4NCj4g
PiA+DQo+ID4gPiBKdXN0IGNoYW5nZSB0aGUgKHByb2JhYmxlKToNCj4gPiA+ICNkZWZpbmUgU1JD
TElORV9VTktOT1dOICJ1bmtub3duIg0KPiA+ID4gd2l0aA0KPiA+ID4gc3RhdGljIGNvbnN0IGNo
YXIgU1JDX0xJTkVfVU5LTk9XTltdID0gInVuayI7DQo+ID4gPg0KPiA+ID4gICAgICAgICBEYXZp
ZA0KPiA+DQo+ID4NCj4gPiBUaGUgU1JDTElORV9VTktOT1dOIGlzIHVzZWQgdG8gY29udmV5IGlu
Zm9ybWF0aW9uLiBIYXZpbmcgbXVsdGlwbGUNCj4gPiBkaXN0aW5jdCBwb2ludGVycyAoc3RhdGlj
KSB3b3VsZCBtZWFuIHRoZSBjb21waWxlciBjb3VsZCBsaWtlbHkgcmVtb3ZlDQo+ID4gYWxsIGNv
bXBhcmlzb25zIGFzIHRoZSBjb21waWxlciBjb3VsZCBwcm92ZSB0aGF0IHBvaW50ZXIgaXMgbmV2
ZXINCj4gPiByZXR1cm5lZCBieSBhIGZ1bmN0aW9uIC0gaWUgY29tcGFyaXNvbnMgYXJlIGVpdGhl
ciBrbm93biB0byBiZSB0cnVlDQo+ID4gKCE9KSBvciBmYWxzZSAoPT0pLg0KPiANCj4gSSB3b3Vs
ZG4ndCBkZWZpbmUgYSBzdGF0aWMgc3RyaW5nIGluIGEgaGVhZGVyLiAgVGhvdWdoIEkgY291bGQ6
DQo+IDEuIGZvcndhcmQgZGVjbGFyZSBpdCBpbiB0aGUgaGVhZGVyIHdpdGggZXh0ZXJuIGxpbmth
Z2UuDQo+IDIuIGRlZmluZSBpdCBpbiAqb25lKiAuYyBzb3VyY2UgZmlsZS4NCj4gDQo+IFRob3Vn
aHRzIG9uIHRoYXQgdnMgdGhlIGN1cnJlbnQgYXBwcm9hY2g/DQoNClRoZSBzdHJpbmcgY29tcGFy
ZXMgYXJlIGp1c3Qgc3R1cGlkLg0KSWYgdGhlICdmYWtlJyBzdHJpbmdzIGFyZSBub3QgcHJpbnRl
ZCB5b3UgY291bGQgdXNlOg0KI2RlZmluZSBTUkNMSU5FX1VOS05PV04gKChjb25zdCBjaGFyICop
MSkNCg0KT3RoZXJ3aXNlIGRlZmluaW5nIHRoZSBzdHJpbmdzIGluIG9uZSBvZiB0aGUgQyBmaWxl
cyBpcyBiZXR0ZXIuDQpSZWx5aW5nIG9uIHRoZSBsaW5rZXIgdG8gbWVyZ2UgdGhlIHN0cmluZ3Mg
ZnJvbSBkaWZmZXJlbnQgY29tcGlsYXRpb24NCnVuaXRzIGlzIHNvIGJyb2tlbi4uLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

