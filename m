Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5AEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253FC20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895720AbgDOJjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:39:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55090 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895690AbgDOJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:39:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-26-3LtwRS6zPnGStZcChf9l-A-1; Wed, 15 Apr 2020 10:39:30 +0100
X-MC-Unique: 3LtwRS6zPnGStZcChf9l-A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 10:39:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Apr 2020 10:39:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Bernard Zhao <bernard@vivo.com>
CC:     Alex Sierra <alex.sierra@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        "Maling list - DRI developers" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "kernel@vivo.com" <kernel@vivo.com>, Huang Rui <ray.huang@amd.com>,
        "Kent Russell" <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: RE: [PATCH] Optimized division operation to shift operation
Thread-Topic: [PATCH] Optimized division operation to shift operation
Thread-Index: AQHWEvuQwS1rXduVrE2yfaZDBTuKn6h57U6g
Date:   Wed, 15 Apr 2020 09:39:29 +0000
Message-ID: <e891ca9944774cbdba577982f0bc7738@AcuMS.aculab.com>
References: <1586864113-30682-1-git-send-email-bernard@vivo.com>
 <CADnq5_Phca3L-HGOQz0DPBoARHgwcJRK_a7-WmeFMPkrPWeOeg@mail.gmail.com>
 <87lfmx5h72.fsf@intel.com> <b5ffc6b7-bfa5-0827-a267-4e8c20027982@amd.com>
In-Reply-To: <b5ffc6b7-bfa5-0827-a267-4e8c20027982@amd.com>
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

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZw0KPiBTZW50OiAxNSBBcHJpbCAyMDIwIDA4OjU3DQo+IEFt
IDE1LjA0LjIwIHVtIDA5OjQxIHNjaHJpZWIgSmFuaSBOaWt1bGE6DQo+ID4gT24gVHVlLCAxNCBB
cHIgMjAyMCwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
PiBPbiBUdWUsIEFwciAxNCwgMjAyMCBhdCA5OjA1IEFNIEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2
aXZvLmNvbT4gd3JvdGU6DQo+ID4+PiBPbiBzb21lIHByb2Nlc3NvcnMsIHRoZSAvIG9wZXJhdGUg
d2lsbCBjYWxsIHRoZSBjb21waWxlcmBzIGRpdiBsaWIsDQo+ID4+PiB3aGljaCBpcyBsb3cgZWZm
aWNpZW50LCBXZSBjYW4gcmVwbGFjZSB0aGUgLyBvcGVyYXRpb24gd2l0aCBzaGlmdCwNCj4gPj4+
IHNvIHRoYXQgd2UgY2FuIHJlcGxhY2UgdGhlIGNhbGwgb2YgdGhlIGRpdmlzaW9uIGxpYnJhcnkg
d2l0aCBvbmUNCj4gPj4+IHNoaWZ0IGFzc2VtYmx5IGluc3RydWN0aW9uLg0KPiA+IFRoaXMgd2Fz
IGFwcGxpZWQgYWxyZWFkeSwgYW5kIGl0J3Mgbm90IGluIGEgZHJpdmVyIEkgbG9vayBhZnRlci4u
LiBidXQNCj4gPiB0byBtZSB0aGlzIGZlZWxzIGxpa2Ugc29tZXRoaW5nIHRoYXQgcmVhbGx5IHNo
b3VsZCBiZQ0KPiA+IGp1c3RpZmllZC4gVXNpbmcgPj4gaW5zdGVhZCBvZiAvIGZvciBtdWx0aXBs
ZXMgb2YgMiBkaXZpc2lvbiBtYXR0ZXJlZCAyMA0KPiA+IHllYXJzIGFnbywgSSdkIGJlIHN1cnBy
aXNlZCBpZiBpdCBzdGlsbCBkaWQgb24gbW9kZXJuIGNvbXBpbGVycy4NCj4gDQo+IEkgaGF2ZSBz
aW1pbGFyIHdvcnJpZXMsIGVzcGVjaWFsbHkgc2luY2Ugd2UgcmVwbGFjZSB0aGUgIi8gKDQgKiAy
KSIgd2l0aA0KPiAiPj4gMyIgaXQncyBtYWtpbmcgdGhlIGNvZGUganVzdCBhIGJpdCBsZXNzIHJl
YWRhYmxlLg0KPiANCj4gQW5kIHRoYXQgdGhlIGNvZGUgcnVucyBleGFjdGx5IG9uY2Ugd2hpbGUg
bG9hZGluZyB0aGUgZHJpdmVyIGFuZCBwdXNoaW5nDQo+IHRoZSBmaXJtd2FyZSBpbnRvIHRoZSBo
YXJkd2FyZS4gU28gcGVyZm9ybWFuY2UgaXMgY29tcGxldGVseSBpcnJlbGV2YW50DQo+IGhlcmUu
DQoNCkZvcmNlIHRoZSBkaXZpc2lvbiB0byBiZSB1bnNpZ25lZCBhbmQgdGhlIGNvbXBpbGVyIHdp
bGwgdXNlIGEgc2hpZnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

