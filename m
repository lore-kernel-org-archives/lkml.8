Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C39C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE3B20723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgC1Lf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:35:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:24929 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgC1Lf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:35:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-125-qkvo3uitO7qMlqKi_GfSRQ-1; Sat, 28 Mar 2020 11:35:18 +0000
X-MC-Unique: qkvo3uitO7qMlqKi_GfSRQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 28 Mar 2020 11:35:18 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 28 Mar 2020 11:35:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
Subject: RE: [PATCH v2] perf synthetic-events: save 4kb from 2 stack frames
Thread-Topic: [PATCH v2] perf synthetic-events: save 4kb from 2 stack frames
Thread-Index: AQHWBF1ClmZ8kVMsgU+5XAp+2PSCVahd4QHg
Date:   Sat, 28 Mar 2020 11:35:18 +0000
Message-ID: <44d864708b824179896928ad0b35b4e9@AcuMS.aculab.com>
References: <20200327172914.28603-1-irogers@google.com>
In-Reply-To: <20200327172914.28603-1-irogers@google.com>
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

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAyNyBNYXJjaCAyMDIwIDE3OjI5DQo+IA0KPiBSZXVz
ZSBhbiBleGlzdGluZyBjaGFyIGJ1ZmZlciB0byBhdm9pZCB0d28gUEFUSF9NQVggc2l6ZWQgY2hh
ciBidWZmZXJzLg0KPiBSZWR1Y2VzIHN0YWNrIGZyYW1lIHNpemVzIGJ5IDRrYi4NCg0KSXQncyB1
c2Vyc3BhY2UsIGl0IHJlYWxseSBkb2Vzbid0IG1hdHRlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

