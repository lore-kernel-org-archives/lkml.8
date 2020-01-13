Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F9C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05C9207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMRjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:39:39 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:50629 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgAMRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:39:39 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-87-OVcAHFbZNfGd3NpnjlTZng-1; Mon, 13 Jan 2020 17:39:36 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 13 Jan 2020 17:39:35 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 Jan 2020 17:39:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'maarten.lankhorst@linux.intel.com'" 
        <maarten.lankhorst@linux.intel.com>,
        "'mripard@kernel.org'" <mripard@kernel.org>,
        "'sean@poorly.run'" <sean@poorly.run>,
        "'airlied@linux.ie'" <airlied@linux.ie>,
        "'daniel@ffwll.ch'" <daniel@ffwll.ch>,
        "'dri-devel@lists.freedesktop.org'" <dri-devel@lists.freedesktop.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: drm_cflush_sg() loops for over 3ms - scheduler not running tasks.
Thread-Topic: drm_cflush_sg() loops for over 3ms - scheduler not running
 tasks.
Thread-Index: AdXKOCs2ei3pAorRT3aL4kNbmbVxww==
Date:   Mon, 13 Jan 2020 17:39:35 +0000
Message-ID: <9451c48fd66b4df0a5ede5391c4e64ef@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: OVcAHFbZNfGd3NpnjlTZng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDEzIEphbnVhcnkgMjAyMCAxNDozNQ0KPiANCj4g
SSd2ZSBiZWVuIGxvb2tpbmcgYXQgd2h5IHNvbWUgUlQgcHJvY2Vzc2VzIGRvbid0IGdldCBzY2hl
ZHVsZWQgcHJvbXB0bHkuDQo+IEluIG15IHRlc3QgdGhlIFJUIHByb2Nlc3MncyBhZmZpbml0eSB0
aWVzIGl0IHRvIGEgc2luZ2xlIGNwdSAodGhpcyBtYXkgbm90IGJlIHN1Y2gNCj4gYSBnb29kIGlk
ZWEgYXMgaXQgc2VlbXMpLg0KPiANCj4gV2hhdCBJJ3ZlIGZvdW5kIGlzIHRoYXQgdGhlIEludGVs
IGk5MTUgZ3JhcGhpY3MgZHJpdmVyIHVzZXMgdGhlICdldmVudHNfdW5ib3VuZCcNCj4ga2VybmVs
IHdvcmtlciB0aHJlYWQgdG8gcGVyaW9kaWNhbGx5IGV4ZWN1dGUgZHJtX2NmbHVzaF9zZygpLg0K
PiAoc2VlIGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2
ZXJzL2dwdS9kcm0vZHJtX2NhY2hlLmMpDQouLi4NCj4gVGhpcyBsb29wIHRha2VzIGFib3V0IDF1
cyBwZXIgaXRlcmF0aW9uIHNwbGl0IGZhaXJseSBldmVubHkgYmV0d2VlbiB3aGF0ZXZlciBpcyBp
bg0KPiBmb3JfZWFjaF9zZ19wYWdlKCkgYW5kIGRybV9jZmx1c2hfcGFnZSgpLg0KPiBXaXRoIGEg
MjU2MHgxNDQwIGRpc3BsYXkgdGhlIGxvb3AgY291bnQgaXMgMzYwMCAoNCBieXRlcy9waXhlbCkg
YW5kIHRoZSB3aG9sZQ0KPiBmdW5jdGlvbiB0YWtlcyBhcm91bmQgMy4zbXMuDQoNCkFjdHVhbGx5
IG5vdCBzZXR0aW5nIHRoZSBjcHUgYWZmaW5pdHkgbWFrZXMgbm8gZGlmZmVyZW5jZS4NClRoZSBw
cm9jZXNzIGlzIHdva2VuIHVwIG9uIHRoZSBjcHUgaXQgbGFzdCByYW4gb24gYW5kIHNpdHMgJ3dh
aXRpbmcnIHVudGlsDQpkcm1fY2ZsdXNoX3NnKCkgZmluaXNoZXMgLSBldmVuIHRob3VnaCB0aGUg
b3RoZXIgY3B1IGJlY29tZSBpZGxlLg0KTm8gc2lnbiBvZiBzY2hlZF9taWdyYXRlX3Rhc2sgZXZl
bnQgJ3N0ZWFsaW5nJyB0aGUgcHJvY2Vzcy4NCg0KRXZlbiB3b3JzZSwgYmVjYXVzZSAndGlja2V0
IGxvY2tzJyBhcmUgdXNlZCBubyBvdGhlciB1c2VyIHByb2Nlc3NlcyBjYW4NCmFjcXVpcmUgdGhl
IHNhbWUgKHVzZXIpIG11dGV4IG9yIGJlIHdva2VuIGZyb20gY3Zfd2FpdCgpIHVudGlsIHRoZQ0K
cHJvY2VzcyBhY3R1YWxseSBydW5zLg0KDQpUaGlzIGlzIGEgNS40LjAtcmM3IGtlcm5lbC4NCkkg
dGhpbmsgSSBzYXcgc29tZSByZWNlbnQgc2NoZWR1bGVyIHBhdGNoZXMsIEkgY2FuIHRyeSB0aGVt
IHVudGlsIEkgY2FuJ3QgYnVpbGQNCndpdGggZ2NjIDQuNy4zIDotKQ0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

