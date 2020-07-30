Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8765AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6356220663
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgG3SgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:36:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:22245 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3SgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:36:11 -0400
IronPort-SDR: nrPRqev7whKHfj5ZqWhp5bKNTO+v9wfsU5j7lTCTb0e7CvRu6CC9pCR4zwGbPmrGV7sDVmIFd7
 tLVEaLo/4zqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151640033"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="151640033"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 11:36:09 -0700
IronPort-SDR: xy3i0RKfOri4g/7K2MD/fVD1dvUQmXvgUtVdjFJok1grsM/0yWvJOptwTKHEPstyChA2D9qWGC
 uxlUYnFejZQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="274295426"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2020 11:36:09 -0700
Received: from bgsmsx604.gar.corp.intel.com (10.67.234.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jul 2020 11:36:09 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 BGSMSX604.gar.corp.intel.com (10.67.234.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jul 2020 00:06:05 +0530
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 30 Jul 2020 21:36:03 +0300
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
Thread-Index: AQHWZj+AeNrJc/C6xECcUY2K3Gkftqkf47mAgACNfHA=
Date:   Thu, 30 Jul 2020 18:36:03 +0000
Message-ID: <feab8fb8fe1b4fcca385da217c6ba7a9@intel.com>
References: <20200730070258.3361503-1-tomas.winkler@intel.com>
 <787ef32c-b10d-5fb7-786f-2825180e1b88@embeddedor.com>
In-Reply-To: <787ef32c-b10d-5fb7-786f-2825180e1b88@embeddedor.com>
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

PiBIaSBUb21hcywNCj4gDQo+IE9uIDcvMzAvMjAgMDI6MDIsIFRvbWFzIFdpbmtsZXIgd3JvdGU6
DQo+ID4gd2lyZWRfY21kX3JlcGVhdGVyX2F1dGhfc3RyZWFtX3JlcV9pbiBoYXMgYSB2YXJpYWJs
ZSBsZW5ndGggYXJyYXkgYXQNCj4gPiB0aGUgZW5kLiB3ZSB1c2Ugc3RydWN0X3NpemUoKSBvdmVy
ZmxvdyBtYWNybyB0byBkZXRlcm1pbmUgdGhlIHNpemUgZm9yDQo+ID4gdGhlIGFsbG9jYXRpb24g
YW5kIHNlbmRpbmcgc2l6ZS4NCj4gPg0KPiANCj4gTXkgY29tbWVudHMgaGVyZToNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82NmM5OTUwYy1lZjU0LTQyM2UtNDY3Zi0NCj4gMzhhOWY3
YWZiMzg0QGVtYmVkZGVkb3IuY29tLw0KU3RyYW5nZSwgIGl0IGhhdmVuJ3QgbGFuZGVkIGluIG15
IG1haWxib3ggDQoNCg0KPiBzdGlsbCBzdGFuZC4uLg0KDQoNCjEuIEkgZG9uJ3QgdGhpbmsgaXQg
c2hvdWxkIGdvIHRvIHN0YWJsZSwgdHJ1ZSAgdGhlcmUgd2FzIGJ1ZyBidXQgaXQgd2Fzbid0IHRy
aWdnZXJlZCBiZWNhdXNlIHRoZXJlIGlzIG9ubHkgb25lIHN0cmVhbS4NCjIuIEluIGFueSBjYXNl
IGlmIHdlIHdhbnQgdG8gYmFja3BvcnQgdG8gc3RhYmxlLCB0aGFuIGFsbCB0aG9zZSBmYW5jeSBv
dmVyZmxvdyBtYWNyb3MgYXJlIG5vdCB0aGVyZSB5ZXQsIG5lZWQgdG8gcmV3cml0ZSB0aGUgcGF0
Y2guDQoyLiBXZSBjYW5ub3QgZmxleF9hcnJheV9zaXplKCkgYXMgdGhlIHN0cmVhbXMgaW4gaGRj
cF9wb3J0X2RhdGEgaXMgbm90IGFuIGFycmF5LCBJJ20gbm90IGdvaW5nIHRvIGNoYW5nZSBpdCBp
biB0aGlzIHBhdGNoLiANCg0KPiANCj4gPiBGaXhlczogYzU2OTY3ZDY3NGUzIChtZWk6IGhkY3A6
IFJlcGxhY2Ugb25lLWVsZW1lbnQgYXJyYXkgd2l0aA0KPiA+IGZsZXhpYmxlLWFycmF5IG1lbWJl
cikNCj4gPiBGaXhlczogYzU2OTY3ZDY3NGUzIChtZWk6IGhkY3A6IFJlcGxhY2Ugb25lLWVsZW1l
bnQgYXJyYXkgd2l0aA0KPiA+IGZsZXhpYmxlLWFycmF5IG1lbWJlcikNCg0KPiBZb3UgaGF2ZSBy
ZXBlYXRlZCB0aGUgc2FtZSBjb21taXQgdHdpY2UsIGFib3ZlLg0KV2lsbCBmaXggDQogQWxzbywg
YSBGaXhlcyB0YWcgZm9yIHRoZQ0KDQo+IGNvbW1pdCBmcm9tIEZlYiAyMDE5IHRoYXQgSSB0YWxr
IGFib3V0IGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNjZjOTk1MGMtZWY1
NC00MjNlLTQ2N2YtDQo+IDM4YTlmN2FmYjM4NEBlbWJlZGRlZG9yLmNvbS8NCldpbGwgYWRkIA0K
PiBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhpcyBjaGFuZ2Vsb2cgdGV4dC4NCj4gDQo+IC0tDQo+
IEd1c3Rhdm8NCj4gDQo+ID4gQ2M6IFJhbWFsaW5nYW0gQyA8cmFtYWxpbmdhbS5jQGludGVsLmNv
bT4NCj4gPiBDYzogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+IFYyOiBDaGVjayBmb3IgYWxsb2NhdGlvbiBmYWlsdXJlLg0KPiA+ICBk
cml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYyB8IDQwDQo+ID4gKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkv
aGRjcC9tZWlfaGRjcC5jDQo+ID4gYi9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0K
PiA+IGluZGV4IGQxZDNlMDI1Y2EwZS4uZjEyMDVlMDA2MGRiIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL21l
aS9oZGNwL21laV9oZGNwLmMNCj4gPiBAQCAtNTQ2LDM4ICs1NDYsNDYgQEAgc3RhdGljIGludCBt
ZWlfaGRjcF92ZXJpZnlfbXByaW1lKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwNCj4gPiAgCQkJCSAg
c3RydWN0IGhkY3BfcG9ydF9kYXRhICpkYXRhLA0KPiA+ICAJCQkJICBzdHJ1Y3QgaGRjcDJfcmVw
X3N0cmVhbV9yZWFkeQ0KPiAqc3RyZWFtX3JlYWR5KSAgew0KPiA+IC0Jc3RydWN0IHdpcmVkX2Nt
ZF9yZXBlYXRlcl9hdXRoX3N0cmVhbV9yZXFfaW4NCj4gPiAtCQkJCQl2ZXJpZnlfbXByaW1lX2lu
ID0geyB7IDAgfSB9Ow0KPiA+ICsJc3RydWN0IHdpcmVkX2NtZF9yZXBlYXRlcl9hdXRoX3N0cmVh
bV9yZXFfaW4gKnZlcmlmeV9tcHJpbWVfaW47DQo+ID4gIAlzdHJ1Y3Qgd2lyZWRfY21kX3JlcGVh
dGVyX2F1dGhfc3RyZWFtX3JlcV9vdXQNCj4gPiAgCQkJCQl2ZXJpZnlfbXByaW1lX291dCA9IHsg
eyAwIH0gfTsNCj4gPiAgCXN0cnVjdCBtZWlfY2xfZGV2aWNlICpjbGRldjsNCj4gPiAgCXNzaXpl
X3QgYnl0ZTsNCj4gPiArCXNpemVfdCBjbWRfc2l6ZTsNCj4gPg0KPiA+ICAJaWYgKCFkZXYgfHwg
IXN0cmVhbV9yZWFkeSB8fCAhZGF0YSkNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+
ICAJY2xkZXYgPSB0b19tZWlfY2xfZGV2aWNlKGRldik7DQo+ID4NCj4gPiAtCXZlcmlmeV9tcHJp
bWVfaW4uaGVhZGVyLmFwaV92ZXJzaW9uID0gSERDUF9BUElfVkVSU0lPTjsNCj4gPiAtCXZlcmlm
eV9tcHJpbWVfaW4uaGVhZGVyLmNvbW1hbmRfaWQgPQ0KPiBXSVJFRF9SRVBFQVRFUl9BVVRIX1NU
UkVBTV9SRVE7DQo+ID4gLQl2ZXJpZnlfbXByaW1lX2luLmhlYWRlci5zdGF0dXMgPSBNRV9IRENQ
X1NUQVRVU19TVUNDRVNTOw0KPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5oZWFkZXIuYnVmZmVyX2xl
biA9DQo+ID4gKwljbWRfc2l6ZSA9IHN0cnVjdF9zaXplKHZlcmlmeV9tcHJpbWVfaW4sIHN0cmVh
bXMsIGRhdGEtPmspOw0KPiA+ICsJaWYgKGNtZF9zaXplID09IFNJWkVfTUFYKQ0KPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCXZlcmlmeV9tcHJpbWVfaW4gPSBremFsbG9jKGNt
ZF9zaXplLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghdmVyaWZ5X21wcmltZV9pbikNCj4gPiAr
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwl2ZXJpZnlfbXByaW1lX2luLT5oZWFkZXIu
YXBpX3ZlcnNpb24gPSBIRENQX0FQSV9WRVJTSU9OOw0KPiA+ICsJdmVyaWZ5X21wcmltZV9pbi0+
aGVhZGVyLmNvbW1hbmRfaWQgPQ0KPiBXSVJFRF9SRVBFQVRFUl9BVVRIX1NUUkVBTV9SRVE7DQo+
ID4gKwl2ZXJpZnlfbXByaW1lX2luLT5oZWFkZXIuc3RhdHVzID0gTUVfSERDUF9TVEFUVVNfU1VD
Q0VTUzsNCj4gPiArCXZlcmlmeV9tcHJpbWVfaW4tPmhlYWRlci5idWZmZXJfbGVuID0NCj4gPg0K
PiAJV0lSRURfQ01EX0JVRl9MRU5fUkVQRUFURVJfQVVUSF9TVFJFQU1fUkVRX01JTl9JTjsNCj4g
Pg0KPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5wb3J0LmludGVncmF0ZWRfcG9ydF90eXBlID0gZGF0
YS0+cG9ydF90eXBlOw0KPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5wb3J0LnBoeXNpY2FsX3BvcnQg
PSAodTgpZGF0YS0+ZndfZGRpOw0KPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5wb3J0LmF0dGFjaGVk
X3RyYW5zY29kZXIgPSAodTgpZGF0YS0+ZndfdGM7DQo+ID4gKwl2ZXJpZnlfbXByaW1lX2luLT5w
b3J0LmludGVncmF0ZWRfcG9ydF90eXBlID0gZGF0YS0+cG9ydF90eXBlOw0KPiA+ICsJdmVyaWZ5
X21wcmltZV9pbi0+cG9ydC5waHlzaWNhbF9wb3J0ID0gKHU4KWRhdGEtPmZ3X2RkaTsNCj4gPiAr
CXZlcmlmeV9tcHJpbWVfaW4tPnBvcnQuYXR0YWNoZWRfdHJhbnNjb2RlciA9ICh1OClkYXRhLT5m
d190YzsNCj4gPiArDQo+ID4gKwltZW1jcHkodmVyaWZ5X21wcmltZV9pbi0+bV9wcmltZSwgc3Ry
ZWFtX3JlYWR5LT5tX3ByaW1lLA0KPiBIRENQXzJfMl9NUFJJTUVfTEVOKTsNCj4gPiArCWRybV9o
ZGNwX2NwdV90b19iZTI0KHZlcmlmeV9tcHJpbWVfaW4tPnNlcV9udW1fbSwgZGF0YS0NCj4gPnNl
cV9udW1fbSk7DQo+ID4NCj4gPiAtCW1lbWNweSh2ZXJpZnlfbXByaW1lX2luLm1fcHJpbWUsIHN0
cmVhbV9yZWFkeS0+bV9wcmltZSwNCj4gPiAtCSAgICAgICBIRENQXzJfMl9NUFJJTUVfTEVOKTsN
Cj4gPiAtCWRybV9oZGNwX2NwdV90b19iZTI0KHZlcmlmeV9tcHJpbWVfaW4uc2VxX251bV9tLCBk
YXRhLQ0KPiA+c2VxX251bV9tKTsNCj4gPiAtCW1lbWNweSh2ZXJpZnlfbXByaW1lX2luLnN0cmVh
bXMsIGRhdGEtPnN0cmVhbXMsDQo+ID4gKwltZW1jcHkodmVyaWZ5X21wcmltZV9pbi0+c3RyZWFt
cywgZGF0YS0+c3RyZWFtcywNCj4gPiAgCSAgICAgICBhcnJheV9zaXplKGRhdGEtPmssIHNpemVv
ZigqZGF0YS0+c3RyZWFtcykpKTsNCj4gPg0KPiA+IC0JdmVyaWZ5X21wcmltZV9pbi5rID0gY3B1
X3RvX2JlMTYoZGF0YS0+ayk7DQo+ID4gKwl2ZXJpZnlfbXByaW1lX2luLT5rID0gY3B1X3RvX2Jl
MTYoZGF0YS0+ayk7DQo+ID4NCj4gPiAtCWJ5dGUgPSBtZWlfY2xkZXZfc2VuZChjbGRldiwgKHU4
ICopJnZlcmlmeV9tcHJpbWVfaW4sDQo+ID4gLQkJCSAgICAgIHNpemVvZih2ZXJpZnlfbXByaW1l
X2luKSk7DQo+ID4gKwlieXRlID0gbWVpX2NsZGV2X3NlbmQoY2xkZXYsICh1OCAqKSZ2ZXJpZnlf
bXByaW1lX2luLCBjbWRfc2l6ZSk7DQo+ID4gKwlrZnJlZSh2ZXJpZnlfbXByaW1lX2luKTsNCj4g
PiAgCWlmIChieXRlIDwgMCkgew0KPiA+ICAJCWRldl9kYmcoZGV2LCAibWVpX2NsZGV2X3NlbmQg
ZmFpbGVkLiAlemRcbiIsIGJ5dGUpOw0KPiA+ICAJCXJldHVybiBieXRlOw0KPiA+DQo=
