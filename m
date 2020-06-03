Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05779C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAA020823
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgFCMaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:30:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:6777 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCMaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:30:18 -0400
IronPort-SDR: mzLxJgDCc1jin961NoBpKHKKI3RXCCcIssvl2/EeWvFJHJQl7GOHRfnWkQhpcT4fV3ZQKUqHLc
 YVYIwP/odX2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 05:30:18 -0700
IronPort-SDR: JVUYKk74Vv4yFnMsCovo0oLQfyJSMv/RS1AwGoX0JoTMrqMlNgbE2WU/dkGPNcS7y+7o/AoWVS
 RhLTcjNSQB3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="378091067"
Received: from irsmsx108.ger.corp.intel.com ([163.33.3.3])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2020 05:30:16 -0700
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.48]) by
 IRSMSX108.ger.corp.intel.com ([169.254.11.35]) with mapi id 14.03.0439.000;
 Wed, 3 Jun 2020 13:30:15 +0100
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 01/13] tools/libperf: introduce notion of static
 polled file descriptors
Thread-Topic: [PATCH v6 01/13] tools/libperf: introduce notion of static
 polled file descriptors
Thread-Index: AQHWOZufBHuZt2+nWEeHvmY9kWmS3KjGuYOAgAAGMoCAABJP0A==
Date:   Wed, 3 Jun 2020 12:30:15 +0000
Message-ID: <363DA0ED52042842948283D2FC38E464B4151F86@IRSMSX106.ger.corp.intel.com>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
 <40643542-6676-e0bc-2d10-165dfde41e29@linux.intel.com>
 <33c91520-7040-bd6b-b176-004ddbec2a63@intel.com>
 <b04311d6-b1c6-d625-b227-9ae4f4370626@linux.intel.com>
 <eb31a2a4-ab3b-54a7-2d5a-51457f78394e@intel.com>
In-Reply-To: <eb31a2a4-ab3b-54a7-2d5a-51457f78394e@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSHVudGVyLCBBZHJpYW4g
PGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMywgMjAy
MCAzOjI0IFBNDQo+IFRvOiBBbGV4ZXkgQnVkYW5rb3YgPGFsZXhleS5idWRhbmtvdkBsaW51eC5p
bnRlbC5jb20+DQo+IENjOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9y
Zz47IEppcmkgT2xzYQ0KPiA8am9sc2FAcmVkaGF0LmNvbT47IE5hbWh5dW5nIEtpbSA8bmFtaHl1
bmdAa2VybmVsLm9yZz47IEFsZXhhbmRlcg0KPiBTaGlzaGtpbiA8YWxleGFuZGVyLnNoaXNoa2lu
QGxpbnV4LmludGVsLmNvbT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9y
Zz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgQW5kaSBLbGVlbg0KPiA8YWtAbGlu
dXguaW50ZWwuY29tPjsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAxLzEzXSB0b29scy9saWJwZXJmOiBpbnRyb2R1
Y2Ugbm90aW9uIG9mIHN0YXRpYyBwb2xsZWQNCj4gZmlsZSBkZXNjcmlwdG9ycw0KPiANCj4gT24g
My8wNi8yMCAzOjAxIHBtLCBBbGV4ZXkgQnVkYW5rb3Ygd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4g
PiBPbiAwMy4wNi4yMDIwIDE0OjM4LCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+PiBPbiAxLzA2
LzIwIDExOjA1IHBtLCBBbGV4ZXkgQnVkYW5rb3Ygd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gSW1wbGVt
ZW50IGFkZGluZyBvZiBmaWxlIGRlc2NyaXB0b3JzIGJ5IGZkYXJyYXlfX2FkZF9zdGF0KCkgdG8N
Cj4gPj4+IGZpeC1zaXplZCAoY3VycmVudGx5IDEpIHN0YXRfZW50cmllcyBhcnJheSBsb2NhdGVk
IGF0IHN0cnVjdCBmZGFycmF5Lg0KPiA+Pj4gQXBwZW5kIGFkZGVkIGZpbGUgZGVzY3JpcHRvcnMg
dG8gdGhlIGFycmF5IHVzZWQgYnkgcG9sbCgpIHN5c2NhbGwNCj4gPj4+IGR1cmluZyBmZGFycmF5
X19wb2xsKCkgY2FsbC4gQ29weSBwb2xsKCkgcmVzdWx0IG9mIHRoZSBhZGRlZA0KPiA+Pj4gZGVz
Y3JpcHRvcnMgZnJvbSB0aGUgYXJyYXkgYmFjayB0byB0aGUgc3RvcmFnZSBmb3Igc2VwYXJhdGUg
YW5hbHlzaXMuDQo+ID4+DQo+ID4+IFdoeSBub3QgaW5zdGVhZCBjYWxsIGV2bGlzdF9fYWRkX3Bv
bGxmZCgpIGJlZm9yZSBvdGhlciBmZHMgYXJlIGFkZGVkLA0KPiA+PiBzbyB0aGUgZmRhLT5lbnRy
aWVzW10gcG9zaXRpb24gaXMgYWx3YXlzIGZpeGVkLiBUaGVuIHRoaXMgcGF0Y2ggaXMgbm90DQo+
IG5lZWRlZC4NCj4gPg0KPiA+IEl0IHRoZW4gd2lsbCBibG9jayBldmVudCBjb25zdW1wdGlvbiBs
b29wLCBhdCBsZWFzdCBpbiByZWNvcmQgbW9kZSwNCj4gPiBkdWUgdG8gY2hhbmdlIHNpbiBpbml0
aWFsIGFzc3VtcHRpb25zIGJlaGluZCBmZGFycmF5X19maWx0ZXIoKS4gU28NCj4gPiBleHRlbnNp
b24gb2YgdGhlIEFQSSB3aXRoICdzdGF0aWMnIGZkcyBsb29rcyBzYWZlciB3LnIudC4gcG9zc2li
bGUNCj4gPiBmdW5jdGlvbmFsIHJlZ3Jlc3Npb25zIGF0IHRoZSBzYW1lIHRpbWUgZXh0ZW5kaW5n
IHRoZSBBUEkgd2l0aCBhYmlsaXR5DQo+ID4gdG8gYXRvbWljYWxseSB3YWl0IGZvciAocG9sbCgp
KSBub3Qgb25seSBldmVudCBmZHMgYnV0IGFsc28gYW55IG90aGVyIGZkcw0KPiBkdXJpbmcgbW9u
aXRvcmluZy4NCj4gDQo+IFNvIG1ha2UgZmRhcnJheV9fZmlsdGVyKCkgcmV0dXJuIHRoZSBudW1i
ZXIgb2YgZmlsdGVyYWJsZSBmZHMgcmVtYWluaW5nLg0KPiANCg0KDQpPciBwZXJoYXBzIHNpbXBs
ZXIsIGNvbXBhcmUgdGhlIHJldHVybiB2YWx1ZSB0byB0aGUgbnVtYmVyIG9mIGZkcyB0aGF0IGFy
ZSBrbm93biBub3QgdG8gYmUgZmlsdGVyYWJsZQ0K
