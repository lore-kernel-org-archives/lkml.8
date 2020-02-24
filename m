Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F99C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733120828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:03:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43260 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbgBXQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:03:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-165-GCRGvgq5PuayjL5fff0xdw-1; Mon, 24 Feb 2020 16:03:25 +0000
X-MC-Unique: GCRGvgq5PuayjL5fff0xdw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 24 Feb 2020 16:03:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 24 Feb 2020 16:03:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <irogers@google.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Thread-Index: AQHV6tcUuLM+xYY6ZEGXR+PNFoTxX6gqgYIg
Date:   Mon, 24 Feb 2020 16:03:24 +0000
Message-ID: <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com>
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
 <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
In-Reply-To: <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
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

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAyNCBGZWJydWFyeSAyMDIwIDA1OjU2DQo+IE9uIFN1
biwgRmViIDIzLCAyMDIwIGF0IDExOjM1IEFNIE5pY2sgRGVzYXVsbmllcnMNCj4gPG5pY2suZGVz
YXVsbmllcnNAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IENsYW5nIHdhcm5zOg0KPiA+DQo+
ID4gdXRpbC9ibG9jay1pbmZvLmM6Mjk4OjE4OiBlcnJvcjogcmVzdWx0IG9mIGNvbXBhcmlzb24g
YWdhaW5zdCBhIHN0cmluZw0KPiA+IGxpdGVyYWwgaXMgdW5zcGVjaWZpZWQgKHVzZSBhbiBleHBs
aWNpdCBzdHJpbmcgY29tcGFyaXNvbiBmdW5jdGlvbg0KPiA+IGluc3RlYWQpIFstV2Vycm9yLC1X
c3RyaW5nLWNvbXBhcmVdDQo+ID4gICAgICAgICBpZiAoKHN0YXJ0X2xpbmUgIT0gU1JDTElORV9V
TktOT1dOKSAmJiAoZW5kX2xpbmUgIT0gU1JDTElORV9VTktOT1dOKSkgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIF4gIH5+fn5+fn5+fn5+fn5+fg0KPiA+IHV0aWwvYmxvY2staW5mby5j
OjI5ODo1MTogZXJyb3I6IHJlc3VsdCBvZiBjb21wYXJpc29uIGFnYWluc3QgYSBzdHJpbmcNCj4g
PiBsaXRlcmFsIGlzIHVuc3BlY2lmaWVkICh1c2UgYW4gZXhwbGljaXQgc3RyaW5nIGNvbXBhcmlz
b24gZnVuY3Rpb24NCj4gPiBpbnN0ZWFkKSBbLVdlcnJvciwtV3N0cmluZy1jb21wYXJlXQ0KPiA+
ICAgICAgICAgaWYgKChzdGFydF9saW5lICE9IFNSQ0xJTkVfVU5LTk9XTikgJiYgKGVuZF9saW5l
ICE9IFNSQ0xJTkVfVU5LTk9XTikpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeICB+fn5+fn5+fn5+fn5+fn4NCj4gPiB1dGls
L2Jsb2NrLWluZm8uYzoyOTg6MTg6IGVycm9yOiByZXN1bHQgb2YgY29tcGFyaXNvbiBhZ2FpbnN0
IGEgc3RyaW5nDQo+ID4gbGl0ZXJhbCBpcyB1bnNwZWNpZmllZCAodXNlIGFuIGV4cGxpY2l0IHN0
cmluZw0KPiA+IGNvbXBhcmlzb24gZnVuY3Rpb24gaW5zdGVhZCkgWy1XZXJyb3IsLVdzdHJpbmct
Y29tcGFyZV0NCj4gPiAgICAgICAgIGlmICgoc3RhcnRfbGluZSAhPSBTUkNMSU5FX1VOS05PV04p
ICYmIChlbmRfbGluZSAhPSBTUkNMSU5FX1VOS05PV04pKSB7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgXiAgfn5+fn5+fn5+fn5+fn5+DQo+ID4gdXRpbC9ibG9jay1pbmZvLmM6Mjk4OjUx
OiBlcnJvcjogcmVzdWx0IG9mIGNvbXBhcmlzb24gYWdhaW5zdCBhIHN0cmluZw0KPiA+IGxpdGVy
YWwgaXMgdW5zcGVjaWZpZWQgKHVzZSBhbiBleHBsaWNpdCBzdHJpbmcgY29tcGFyaXNvbiBmdW5j
dGlvbg0KPiA+IGluc3RlYWQpIFstV2Vycm9yLC1Xc3RyaW5nLWNvbXBhcmVdDQo+ID4gICAgICAg
ICBpZiAoKHN0YXJ0X2xpbmUgIT0gU1JDTElORV9VTktOT1dOKSAmJiAoZW5kX2xpbmUgIT0gU1JD
TElORV9VTktOT1dOKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4gIH5+fn5+fn5+fn5+fn5+fg0KPiA+IHV0aWwvbWFwLmM6
NDM0OjE1OiBlcnJvcjogcmVzdWx0IG9mIGNvbXBhcmlzb24gYWdhaW5zdCBhIHN0cmluZyBsaXRl
cmFsDQo+ID4gaXMgdW5zcGVjaWZpZWQgKHVzZSBhbiBleHBsaWNpdCBzdHJpbmcgY29tcGFyaXNv
biBmdW5jdGlvbiBpbnN0ZWFkKQ0KPiA+IFstV2Vycm9yLC1Xc3RyaW5nLWNvbXBhcmVdDQo+ID4g
ICAgICAgICAgICAgICAgIGlmIChzcmNsaW5lICE9IFNSQ0xJTkVfVU5LTk9XTikNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXiAgfn5+fn5+fn5+fn5+fn5+DQo+ID4NCj4gPiBMaW5r
OiBodHRwczovL2dpdGh1Yi5jb20vQ2xhbmdCdWlsdExpbnV4L2xpbnV4L2lzc3Vlcy85MDANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuaWNrLmRlc2F1bG5pZXJzQGdtYWls
LmNvbT4NCj4gPiAtLS0NCj4gPiBOb3RlOiB3YXMgZ2VuZXJhdGVkIG9mZiBvZiBtYWlubGluZTsg
Y2FuIHJlYmFzZSBvbiAtbmV4dCBpZiBpdCBkb2Vzbid0DQo+ID4gYXBwbHkgY2xlYW5seS4NCj4g
DQo+IExvb2tzIGdvb2QgdG8gbWUuIFNvbWUgbW9yZSBjb250ZXh0Og0KPiBodHRwczovL2NsYW5n
Lmxsdm0ub3JnL2RvY3MvRGlhZ25vc3RpY3NSZWZlcmVuY2UuaHRtbCN3c3RyaW5nLWNvbXBhcmUN
Cj4gVGhlIHNwZWMgc2F5czoNCj4gSi4xIFVuc3BlY2lmaWVkIGJlaGF2aW9yDQo+IFRoZSBmb2xs
b3dpbmcgYXJlIHVuc3BlY2lmaWVkOg0KPiAuLiBXaGV0aGVyIHR3byBzdHJpbmcgbGl0ZXJhbHMg
cmVzdWx0IGluIGRpc3RpbmN0IGFycmF5cyAoNi40LjUpLg0KDQpKdXN0IGNoYW5nZSB0aGUgKHBy
b2JhYmxlKToNCiNkZWZpbmUgU1JDTElORV9VTktOT1dOICJ1bmtub3duIg0Kd2l0aA0Kc3RhdGlj
IGNvbnN0IGNoYXIgU1JDX0xJTkVfVU5LTk9XTltdID0gInVuayI7DQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

