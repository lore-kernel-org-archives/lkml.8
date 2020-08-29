Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9918EC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E80B207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH2BL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:11:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:32974 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgH2BL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 21:11:28 -0400
IronPort-SDR: PZYg/HrWfTJ0uNuNnb3vePgYd+QtD4KaxETCS4gXaqv7KUkzuz+dsJVFP9E6+Uec5uSQRrUls6
 Rnxk8ZFJUMgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="221007537"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="221007537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 18:11:26 -0700
IronPort-SDR: 8XKr402pDMeWK7gEmQD5xxksZ4Ahvm4WNu5HdK4b4iIc2+2Ue8RLNHxZTUaChm8mBFjg67LmMY
 PwhzpuBP9gVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="282549523"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2020 18:11:26 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Aug 2020 18:10:52 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Aug 2020 18:10:52 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.136]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.84]) with mapi id 14.03.0439.000;
 Fri, 28 Aug 2020 18:10:52 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "airlied@linux.ie" <airlied@linux.ie>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        "Laxminarayan Bharadiya, Pankaj" 
        <pankaj.laxminarayan.bharadiya@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/display: fix uninitialized variable
Thread-Topic: [PATCH] drm/i915/display: fix uninitialized variable
Thread-Index: AQHWezZyFQ6O6CxC8EepYMeUJRKygKlOwiWA
Date:   Sat, 29 Aug 2020 01:10:51 +0000
Message-ID: <3a93ddc0727676afc8878ca11d0afbebe8e5e4ab.camel@intel.com>
References: <20200825232057.31601-1-trix@redhat.com>
In-Reply-To: <20200825232057.31601-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.240.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA13B763D4D41D4BB2E7EE3CFF27B0EC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVzdCBtZXJnZWQgdGhlIGZpcnN0IHBhdGNoIHRoYXQgZml4ZWQgdGhpcyBpc3N1ZSwgdGhhbmtz
IGFueXdheXMuDQoNCjIwMzRjMjEyOWJjNGE5MWQ0NzE4MTVkNGRjN2EyYTY5ZWFhNTMzOGQgLSBk
cm0vaTkxNS9kaXNwbGF5OiBFbnN1cmUgdGhhdCByZXQgaXMgYWx3YXlzIGluaXRpYWxpemVkIGlu
IGljbF9jb21ib19waHlfdmVyaWZ5X3N0YXRlDQoNCg0KT24gVHVlLCAyMDIwLTA4LTI1IGF0IDE2
OjIwIC0wNzAwLCB0cml4QHJlZGhhdC5jb20gd3JvdGU6DQo+IEZyb206IFRvbSBSaXggPA0KPiB0
cml4QHJlZGhhdC5jb20NCj4gPg0KPiANCj4gY2xhbmcgc3RhdGljIGFuYWx5c2lzIGZsYWdzIHRo
aXMgZXJyb3INCj4gDQo+IGludGVsX2NvbWJvX3BoeS5jOjI2ODo3OiB3YXJuaW5nOiBUaGUgbGVm
dCBleHByZXNzaW9uIG9mIHRoZQ0KPiAgIGNvbXBvdW5kIGFzc2lnbm1lbnQgaXMgYW4gdW5pbml0
aWFsaXplZCB2YWx1ZS4NCj4gICBUaGUgY29tcHV0ZWQgdmFsdWUgd2lsbCBhbHNvIGJlIGdhcmJh
Z2UNCj4gICAgICAgICAgICAgICAgIHJldCAmPSBjaGVja19waHlfcmVnKC4uLg0KPiAgICAgICAg
ICAgICAgICAgfn5+IF4NCj4gDQo+IHJldCBoYXMgbm8gaW5pdGlhbCB2YWx1ZXMsIGluIGljbF9j
b21ib19waHlfdmVyaWZ5X3N0YXRlKCkgcmV0IGlzDQo+IHNldCBieSB0aGUgbmV4dCBzdGF0bWVu
dCBhbmQgdGhlbiB1cGRhdGVkIGJ5IHNpbWlsYXIgJj0gbG9naWMuDQo+IA0KPiBCZWNhdXNlIHRo
ZSBjaGVja19waHlfcmVxKCkgYXJlIG9ubHkgcmVnaXN0ZXIgcmVhZHMsIHJlb3JkZXIgdGhlDQo+
IHN0YXRlbWVudHMuDQo+IA0KPiBGaXhlczogMjM5YmVmNjc2ZDhlICgiZHJtL2k5MTUvZGlzcGxh
eTogSW1wbGVtZW50IG5ldyBjb21ibyBwaHkgaW5pdGlhbGl6YXRpb24gc3RlcCIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFRvbSBSaXggPA0KPiB0cml4QHJlZGhhdC5jb20NCj4gPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfY29tYm9fcGh5LmMgfCA0ICsrLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jb21ib19waHku
YyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfY29tYm9fcGh5LmMNCj4gaW5k
ZXggNjk2OGRlNGYzNDc3Li43NjIyZWY2NmM5ODcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfY29tYm9fcGh5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9jb21ib19waHkuYw0KPiBAQCAtMjY0LDYgKzI2NCw4IEBA
IHN0YXRpYyBib29sIGljbF9jb21ib19waHlfdmVyaWZ5X3N0YXRlKHN0cnVjdCBkcm1faTkxNV9w
cml2YXRlICpkZXZfcHJpdiwNCj4gIAlpZiAoIWljbF9jb21ib19waHlfZW5hYmxlZChkZXZfcHJp
diwgcGh5KSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+ICsJcmV0ID0gY25sX3ZlcmlmeV9w
cm9jbW9uX3JlZl92YWx1ZXMoZGV2X3ByaXYsIHBoeSk7DQo+ICsNCj4gIAlpZiAoSU5URUxfR0VO
KGRldl9wcml2KSA+PSAxMikgew0KPiAgCQlyZXQgJj0gY2hlY2tfcGh5X3JlZyhkZXZfcHJpdiwg
cGh5LCBJQ0xfUE9SVF9UWF9EVzhfTE4wKHBoeSksDQo+ICAJCQkJICAgICBJQ0xfUE9SVF9UWF9E
VzhfT0RDQ19DTEtfU0VMIHwNCj4gQEAgLTI3Niw4ICsyNzgsNiBAQCBzdGF0aWMgYm9vbCBpY2xf
Y29tYm9fcGh5X3ZlcmlmeV9zdGF0ZShzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqZGV2X3ByaXYs
DQo+ICAJCQkJICAgICBEQ0NfTU9ERV9TRUxFQ1RfQ09OVElOVU9TTFkpOw0KPiAgCX0NCj4gIA0K
PiAtCXJldCA9IGNubF92ZXJpZnlfcHJvY21vbl9yZWZfdmFsdWVzKGRldl9wcml2LCBwaHkpOw0K
PiAtDQo+ICAJaWYgKHBoeV9pc19tYXN0ZXIoZGV2X3ByaXYsIHBoeSkpIHsNCj4gIAkJcmV0ICY9
IGNoZWNrX3BoeV9yZWcoZGV2X3ByaXYsIHBoeSwgSUNMX1BPUlRfQ09NUF9EVzgocGh5KSwNCj4g
IAkJCQkgICAgIElSRUZHRU4sIElSRUZHRU4pOw0KPiANCg==
