Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB65EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F542173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgG3Srq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:47:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:18465 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbgG3Srp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:47:45 -0400
IronPort-SDR: 9kXpmd0Ma2jrHnN8nXkY51O0jdhlpdBQlJUsEzcbuvAuLjK1ueHMCl33pUn0Cr9PL3AFhm6wnN
 As1viLWr4cGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150867136"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="150867136"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 11:47:37 -0700
IronPort-SDR: X0Nk7gZeqlbu/6fBMYsNRreBKQToDHfLl6lnSFVd2vH/b0D9O8N2oWStMXoC7nuL7uL7SD6w7C
 nTGlppexixog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="490764404"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2020 11:47:37 -0700
Received: from bgsmsx606.gar.corp.intel.com (10.67.234.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jul 2020 11:47:37 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 BGSMSX606.gar.corp.intel.com (10.67.234.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jul 2020 00:17:33 +0530
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 30 Jul 2020 21:47:32 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: RE: [char-misc-next V2] mei: hdcp: fix mei_hdcp_verify_mprime() input
 paramter
Thread-Topic: [char-misc-next V2] mei: hdcp: fix mei_hdcp_verify_mprime()
 input paramter
Thread-Index: AQHWZj+AeNrJc/C6xECcUY2K3Gkftqkf47mAgACNfHCAAAV/kA==
Date:   Thu, 30 Jul 2020 18:47:32 +0000
Message-ID: <1c5bc674286a4f52afd78b1248945fd6@intel.com>
References: <20200730070258.3361503-1-tomas.winkler@intel.com>
 <787ef32c-b10d-5fb7-786f-2825180e1b88@embeddedor.com>
 <feab8fb8fe1b4fcca385da217c6ba7a9@intel.com>
In-Reply-To: <feab8fb8fe1b4fcca385da217c6ba7a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gSGkgVG9tYXMsDQo+ID4NCj4gPiBPbiA3LzMwLzIwIDAyOjAyLCBUb21hcyBXaW5rbGVy
IHdyb3RlOg0KPiA+ID4gd2lyZWRfY21kX3JlcGVhdGVyX2F1dGhfc3RyZWFtX3JlcV9pbiBoYXMg
YSB2YXJpYWJsZSBsZW5ndGggYXJyYXkgYXQNCj4gPiA+IHRoZSBlbmQuIHdlIHVzZSBzdHJ1Y3Rf
c2l6ZSgpIG92ZXJmbG93IG1hY3JvIHRvIGRldGVybWluZSB0aGUgc2l6ZQ0KPiA+ID4gZm9yIHRo
ZSBhbGxvY2F0aW9uIGFuZCBzZW5kaW5nIHNpemUuDQo+ID4gPg0KPiA+DQo+ID4gTXkgY29tbWVu
dHMgaGVyZToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzY2Yzk5NTBjLWVmNTQt
NDIzZS00NjdmLQ0KPiA+IDM4YTlmN2FmYjM4NEBlbWJlZGRlZG9yLmNvbS8NCj4gU3RyYW5nZSwg
IGl0IGhhdmVuJ3QgbGFuZGVkIGluIG15IG1haWxib3gNCj4gDQo+IA0KPiA+IHN0aWxsIHN0YW5k
Li4uDQo+IA0KPiANCj4gMS4gSSBkb24ndCB0aGluayBpdCBzaG91bGQgZ28gdG8gc3RhYmxlLCB0
cnVlICB0aGVyZSB3YXMgYnVnIGJ1dCBpdCB3YXNuJ3QNCj4gdHJpZ2dlcmVkIGJlY2F1c2UgdGhl
cmUgaXMgb25seSBvbmUgc3RyZWFtLg0KDQoNCkknbSBjaGFuZ2luZyBteSBtaW5kIG9uIHRoYXQs
IHRoaXMgaXMgYSBwcmV0dHkgc2VjdXJpdHkgaXNzdWUsIGl0IHNob3VsZCBiZSBmaXhlZCBpbiBz
dGFibGUuIA0KDQo+IDIuIEluIGFueSBjYXNlIGlmIHdlIHdhbnQgdG8gYmFja3BvcnQgdG8gc3Rh
YmxlLCB0aGFuIGFsbCB0aG9zZSBmYW5jeSBvdmVyZmxvdw0KPiBtYWNyb3MgYXJlIG5vdCB0aGVy
ZSB5ZXQsIG5lZWQgdG8gcmV3cml0ZSB0aGUgcGF0Y2guDQo+IDIuIFdlIGNhbm5vdCBmbGV4X2Fy
cmF5X3NpemUoKSBhcyB0aGUgc3RyZWFtcyBpbiBoZGNwX3BvcnRfZGF0YSBpcyBub3QgYW4NCj4g
YXJyYXksIEknbSBub3QgZ29pbmcgdG8gY2hhbmdlIGl0IGluIHRoaXMgcGF0Y2guDQoNCkxhc3Qs
IGZvcmdvdCB0byB0aGFua3MgeW91IGZvciB5b3VyIHBlcnNpc3RlbnQgYW5kIHRob3JvdWdobHkg
cmV2aWV3LiANCiANCj4gPg0KPiA+ID4gRml4ZXM6IGM1Njk2N2Q2NzRlMyAobWVpOiBoZGNwOiBS
ZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5IHdpdGgNCj4gPiA+IGZsZXhpYmxlLWFycmF5IG1lbWJl
cikNCj4gPiA+IEZpeGVzOiBjNTY5NjdkNjc0ZTMgKG1laTogaGRjcDogUmVwbGFjZSBvbmUtZWxl
bWVudCBhcnJheSB3aXRoDQo+ID4gPiBmbGV4aWJsZS1hcnJheSBtZW1iZXIpDQo+IA0KPiA+IFlv
dSBoYXZlIHJlcGVhdGVkIHRoZSBzYW1lIGNvbW1pdCB0d2ljZSwgYWJvdmUuDQo+IFdpbGwgZml4
DQo+ICBBbHNvLCBhIEZpeGVzIHRhZyBmb3IgdGhlDQo+IA0KPiA+IGNvbW1pdCBmcm9tIEZlYiAy
MDE5IHRoYXQgSSB0YWxrIGFib3V0IGhlcmU6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC82NmM5OTUwYy1lZjU0LTQyM2UtNDY3Zi0NCj4gPiAzOGE5ZjdhZmIzODRAZW1iZWRkZWRv
ci5jb20vDQo+IFdpbGwgYWRkDQo+ID4gc2hvdWxkIGJlIGluY2x1ZGVkIGluIHRoaXMgY2hhbmdl
bG9nIHRleHQuDQo+ID4NCj4gPiAtLQ0KPiA+IEd1c3Rhdm8NCj4gPg0KPiA+ID4gQ2M6IFJhbWFs
aW5nYW0gQyA8cmFtYWxpbmdhbS5jQGludGVsLmNvbT4NCj4gPiA+IENjOiBHdXN0YXZvIEEuIFIu
IFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUb21h
cyBXaW5rbGVyIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gVjI6
IENoZWNrIGZvciBhbGxvY2F0aW9uIGZhaWx1cmUuDQo+ID4gPiAgZHJpdmVycy9taXNjL21laS9o
ZGNwL21laV9oZGNwLmMgfCA0MA0KPiA+ID4gKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25z
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlf
aGRjcC5jDQo+ID4gPiBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gPiBp
bmRleCBkMWQzZTAyNWNhMGUuLmYxMjA1ZTAwNjBkYiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21pc2MvbWVp
L2hkY3AvbWVpX2hkY3AuYw0KPiA+ID4gQEAgLTU0NiwzOCArNTQ2LDQ2IEBAIHN0YXRpYyBpbnQg
bWVpX2hkY3BfdmVyaWZ5X21wcmltZShzdHJ1Y3QNCj4gPiA+IGRldmljZQ0KPiA+ICpkZXYsDQo+
ID4gPiAgCQkJCSAgc3RydWN0IGhkY3BfcG9ydF9kYXRhICpkYXRhLA0KPiA+ID4gIAkJCQkgIHN0
cnVjdCBoZGNwMl9yZXBfc3RyZWFtX3JlYWR5DQo+ID4gKnN0cmVhbV9yZWFkeSkgIHsNCj4gPiA+
IC0Jc3RydWN0IHdpcmVkX2NtZF9yZXBlYXRlcl9hdXRoX3N0cmVhbV9yZXFfaW4NCj4gPiA+IC0J
CQkJCXZlcmlmeV9tcHJpbWVfaW4gPSB7IHsgMCB9IH07DQo+ID4gPiArCXN0cnVjdCB3aXJlZF9j
bWRfcmVwZWF0ZXJfYXV0aF9zdHJlYW1fcmVxX2luICp2ZXJpZnlfbXByaW1lX2luOw0KPiA+ID4g
IAlzdHJ1Y3Qgd2lyZWRfY21kX3JlcGVhdGVyX2F1dGhfc3RyZWFtX3JlcV9vdXQNCj4gPiA+ICAJ
CQkJCXZlcmlmeV9tcHJpbWVfb3V0ID0geyB7IDAgfSB9Ow0KPiA+ID4gIAlzdHJ1Y3QgbWVpX2Ns
X2RldmljZSAqY2xkZXY7DQo+ID4gPiAgCXNzaXplX3QgYnl0ZTsNCj4gPiA+ICsJc2l6ZV90IGNt
ZF9zaXplOw0KPiA+ID4NCj4gPiA+ICAJaWYgKCFkZXYgfHwgIXN0cmVhbV9yZWFkeSB8fCAhZGF0
YSkNCj4gPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+ICAJY2xkZXYgPSB0b19t
ZWlfY2xfZGV2aWNlKGRldik7DQo+ID4gPg0KPiA+ID4gLQl2ZXJpZnlfbXByaW1lX2luLmhlYWRl
ci5hcGlfdmVyc2lvbiA9IEhEQ1BfQVBJX1ZFUlNJT047DQo+ID4gPiAtCXZlcmlmeV9tcHJpbWVf
aW4uaGVhZGVyLmNvbW1hbmRfaWQgPQ0KPiA+IFdJUkVEX1JFUEVBVEVSX0FVVEhfU1RSRUFNX1JF
UTsNCj4gPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5oZWFkZXIuc3RhdHVzID0gTUVfSERDUF9TVEFU
VVNfU1VDQ0VTUzsNCj4gPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5oZWFkZXIuYnVmZmVyX2xlbiA9
DQo+ID4gPiArCWNtZF9zaXplID0gc3RydWN0X3NpemUodmVyaWZ5X21wcmltZV9pbiwgc3RyZWFt
cywgZGF0YS0+ayk7DQo+ID4gPiArCWlmIChjbWRfc2l6ZSA9PSBTSVpFX01BWCkNCj4gPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ID4gKw0KPiA+ID4gKwl2ZXJpZnlfbXByaW1lX2luID0ga3ph
bGxvYyhjbWRfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiArCWlmICghdmVyaWZ5X21wcmltZV9p
bikNCj4gPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gKw0KPiA+ID4gKwl2ZXJpZnlfbXBy
aW1lX2luLT5oZWFkZXIuYXBpX3ZlcnNpb24gPSBIRENQX0FQSV9WRVJTSU9OOw0KPiA+ID4gKwl2
ZXJpZnlfbXByaW1lX2luLT5oZWFkZXIuY29tbWFuZF9pZCA9DQo+ID4gV0lSRURfUkVQRUFURVJf
QVVUSF9TVFJFQU1fUkVROw0KPiA+ID4gKwl2ZXJpZnlfbXByaW1lX2luLT5oZWFkZXIuc3RhdHVz
ID0gTUVfSERDUF9TVEFUVVNfU1VDQ0VTUzsNCj4gPiA+ICsJdmVyaWZ5X21wcmltZV9pbi0+aGVh
ZGVyLmJ1ZmZlcl9sZW4gPQ0KPiA+ID4NCj4gPiAJV0lSRURfQ01EX0JVRl9MRU5fUkVQRUFURVJf
QVVUSF9TVFJFQU1fUkVRX01JTl9JTjsNCj4gPiA+DQo+ID4gPiAtCXZlcmlmeV9tcHJpbWVfaW4u
cG9ydC5pbnRlZ3JhdGVkX3BvcnRfdHlwZSA9IGRhdGEtPnBvcnRfdHlwZTsNCj4gPiA+IC0JdmVy
aWZ5X21wcmltZV9pbi5wb3J0LnBoeXNpY2FsX3BvcnQgPSAodTgpZGF0YS0+ZndfZGRpOw0KPiA+
ID4gLQl2ZXJpZnlfbXByaW1lX2luLnBvcnQuYXR0YWNoZWRfdHJhbnNjb2RlciA9ICh1OClkYXRh
LT5md190YzsNCj4gPiA+ICsJdmVyaWZ5X21wcmltZV9pbi0+cG9ydC5pbnRlZ3JhdGVkX3BvcnRf
dHlwZSA9IGRhdGEtPnBvcnRfdHlwZTsNCj4gPiA+ICsJdmVyaWZ5X21wcmltZV9pbi0+cG9ydC5w
aHlzaWNhbF9wb3J0ID0gKHU4KWRhdGEtPmZ3X2RkaTsNCj4gPiA+ICsJdmVyaWZ5X21wcmltZV9p
bi0+cG9ydC5hdHRhY2hlZF90cmFuc2NvZGVyID0gKHU4KWRhdGEtPmZ3X3RjOw0KPiA+ID4gKw0K
PiA+ID4gKwltZW1jcHkodmVyaWZ5X21wcmltZV9pbi0+bV9wcmltZSwgc3RyZWFtX3JlYWR5LT5t
X3ByaW1lLA0KPiA+IEhEQ1BfMl8yX01QUklNRV9MRU4pOw0KPiA+ID4gKwlkcm1faGRjcF9jcHVf
dG9fYmUyNCh2ZXJpZnlfbXByaW1lX2luLT5zZXFfbnVtX20sIGRhdGEtDQo+ID4gPnNlcV9udW1f
bSk7DQo+ID4gPg0KPiA+ID4gLQltZW1jcHkodmVyaWZ5X21wcmltZV9pbi5tX3ByaW1lLCBzdHJl
YW1fcmVhZHktPm1fcHJpbWUsDQo+ID4gPiAtCSAgICAgICBIRENQXzJfMl9NUFJJTUVfTEVOKTsN
Cj4gPiA+IC0JZHJtX2hkY3BfY3B1X3RvX2JlMjQodmVyaWZ5X21wcmltZV9pbi5zZXFfbnVtX20s
IGRhdGEtDQo+ID4gPnNlcV9udW1fbSk7DQo+ID4gPiAtCW1lbWNweSh2ZXJpZnlfbXByaW1lX2lu
LnN0cmVhbXMsIGRhdGEtPnN0cmVhbXMsDQo+ID4gPiArCW1lbWNweSh2ZXJpZnlfbXByaW1lX2lu
LT5zdHJlYW1zLCBkYXRhLT5zdHJlYW1zLA0KPiA+ID4gIAkgICAgICAgYXJyYXlfc2l6ZShkYXRh
LT5rLCBzaXplb2YoKmRhdGEtPnN0cmVhbXMpKSk7DQo+ID4gPg0KPiA+ID4gLQl2ZXJpZnlfbXBy
aW1lX2luLmsgPSBjcHVfdG9fYmUxNihkYXRhLT5rKTsNCj4gPiA+ICsJdmVyaWZ5X21wcmltZV9p
bi0+ayA9IGNwdV90b19iZTE2KGRhdGEtPmspOw0KPiA+ID4NCj4gPiA+IC0JYnl0ZSA9IG1laV9j
bGRldl9zZW5kKGNsZGV2LCAodTggKikmdmVyaWZ5X21wcmltZV9pbiwNCj4gPiA+IC0JCQkgICAg
ICBzaXplb2YodmVyaWZ5X21wcmltZV9pbikpOw0KPiA+ID4gKwlieXRlID0gbWVpX2NsZGV2X3Nl
bmQoY2xkZXYsICh1OCAqKSZ2ZXJpZnlfbXByaW1lX2luLCBjbWRfc2l6ZSk7DQo+ID4gPiArCWtm
cmVlKHZlcmlmeV9tcHJpbWVfaW4pOw0KPiA+ID4gIAlpZiAoYnl0ZSA8IDApIHsNCj4gPiA+ICAJ
CWRldl9kYmcoZGV2LCAibWVpX2NsZGV2X3NlbmQgZmFpbGVkLiAlemRcbiIsIGJ5dGUpOw0KPiA+
ID4gIAkJcmV0dXJuIGJ5dGU7DQo+ID4gPg0K
