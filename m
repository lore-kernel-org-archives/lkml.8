Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C199DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF7225AB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgGNRyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:54:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:13340 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgGNRyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:54:37 -0400
IronPort-SDR: wM+WtKBTeCIuFxqDUDF4mLZxvxW6DgWczpiHO7+8EOI0QbvOcYzb0s8Dc4LNEIQTuoU2k2AoYz
 D+wOytbIoBdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210533039"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="210533039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 10:54:36 -0700
IronPort-SDR: iZk/rxCC3rzNRoOB4NzHwKAoWtZZirYPJJ85/rxtl+w8AWIRasKY2q/gY0XU5opM1Zo8Rd965/
 22gf/F2nqZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="285834839"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2020 10:54:36 -0700
Received: from hasmsx601.ger.corp.intel.com (10.184.107.141) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 10:54:34 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX601.ger.corp.intel.com (10.184.107.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jul 2020 20:54:32 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Tue, 14 Jul 2020 20:54:32 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] mei: Avoid the use of one-element arrays
Thread-Topic: [PATCH][next] mei: Avoid the use of one-element arrays
Thread-Index: AQHWWgYBVMvTEO76bk+MJBte9XQfr6kHWu4Q
Date:   Tue, 14 Jul 2020 17:54:32 +0000
Message-ID: <fe3b8d4a4eb04ead83ffcefe12fd218e@intel.com>
References: <20200714174644.GA30158@embeddedor>
In-Reply-To: <20200714174644.GA30158@embeddedor>
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

PiANCj4gVGhlcmUgaXMgYSByZWd1bGFyIG5lZWQgaW4gdGhlIGtlcm5lbCB0byBwcm92aWRlIGEg
d2F5IHRvIGRlY2xhcmUgaGF2aW5nIGENCj4gZHluYW1pY2FsbHkgc2l6ZWQgc2V0IG9mIHRyYWls
aW5nIGVsZW1lbnRzIGluIGEgc3RydWN0dXJlLg0KPiBLZXJuZWwgY29kZSBzaG91bGQgYWx3YXlz
IHVzZSDigJxmbGV4aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZSBjYXNlcw0KPiBv
ciwgYXMgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHJlcGxhY2UgdGhlIG9uZS1lbGVtZW50IGFy
cmF5IHdpdGggYSBzaW1wbGUNCj4gdmFsdWUgdHlwZSB1OCByZXNlcnZlZCBvbmNlIHRoaXMgaXMg
anVzdCBhIHBsYWNlaG9sZGVyIGZvciBhbGlnbm1lbnQuIFRoZSBvbGRlcg0KPiBzdHlsZSBvZiBv
bmUtZWxlbWVudCBvciB6ZXJvLWxlbmd0aCBhcnJheXMgc2hvdWxkIG5vIGxvbmdlciBiZSB1c2Vk
WzJdLg0KPiANCj4gQWxzbywgd2hpbGUgdGhlcmUsIHVzZSB0aGUgcHJlZmVycmVkIGZvcm0gZm9y
IHBhc3NpbmcgYSBzaXplIG9mIGEgc3RydWN0Lg0KPiBUaGUgYWx0ZXJuYXRpdmUgZm9ybSB3aGVy
ZSBzdHJ1Y3QgbmFtZSBpcyBzcGVsbGVkIG91dCBodXJ0cyByZWFkYWJpbGl0eSBhbmQNCj4gaW50
cm9kdWNlcyBhbiBvcHBvcnR1bml0eSBmb3IgYSBidWcgd2hlbiB0aGUgdmFyaWFibGUgdHlwZSBp
cyBjaGFuZ2VkIGJ1dA0KPiB0aGUgY29ycmVzcG9uZGluZyBzaXplb2YgdGhhdCBpcyBwYXNzZWQg
YXMgYXJndW1lbnQgaXMgbm90Lg0KPiANCj4gWzFdIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93
aWtpL0ZsZXhpYmxlX2FycmF5X21lbWJlcg0KPiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL0tTUFAv
bGludXgvaXNzdWVzLzc5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZh
IDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQpJJ20gb2theSB3aXRoIHRoZSBwYXRjaCBidXQgaW4g
dGhpcyBjYXNlIHRoZSBkZXNjcmlwdGlvbiBpcyBhIGJpdCBvZmYuIA0KSW4gdGhpcyBjYXNlIHRo
ZXJlIHdhcyBubyBpbnRlbnRpb24gZm9yIGEgZmxleGlibGUgYXJyYXlzIGl0cyBqdXN0IGEgcmVz
ZXJ2ZWQgZmllbGQuIA0KDQo+IC0tLQ0KPiAgZHJpdmVycy9taXNjL21laS9oYm0uYyB8IDQgKyst
LQ0KPiAgZHJpdmVycy9taXNjL21laS9ody5oICB8IDYgKysrLS0tDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21pc2MvbWVpL2hibS5jIGIvZHJpdmVycy9taXNjL21laS9oYm0uYyBpbmRleA0KPiBh
NDQwOTRjZGJjMzYuLmYwMjBkNTU5NDE1NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL21l
aS9oYm0uYw0KPiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2hibS5jDQo+IEBAIC00MDgsMTQgKzQw
OCwxNCBAQCBzdGF0aWMgaW50IG1laV9oYm1fYWRkX2NsX3Jlc3Aoc3RydWN0IG1laV9kZXZpY2UN
Cj4gKmRldiwgdTggYWRkciwgdTggc3RhdHVzKSAgew0KPiAgCXN0cnVjdCBtZWlfbXNnX2hkciBt
ZWlfaGRyOw0KPiAgCXN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXNwb25zZSByZXNwOw0KPiAtCWNv
bnN0IHNpemVfdCBsZW4gPSBzaXplb2Yoc3RydWN0IGhibV9hZGRfY2xpZW50X3Jlc3BvbnNlKTsN
Cj4gKwljb25zdCBzaXplX3QgbGVuID0gc2l6ZW9mKHJlc3ApOw0KPiAgCWludCByZXQ7DQo+IA0K
PiAgCWRldl9kYmcoZGV2LT5kZXYsICJhZGRpbmcgY2xpZW50IHJlc3BvbnNlXG4iKTsNCj4gDQo+
ICAJbWVpX2hibV9oZHIoJm1laV9oZHIsIGxlbik7DQo+IA0KPiAtCW1lbXNldCgmcmVzcCwgMCwg
c2l6ZW9mKHN0cnVjdCBoYm1fYWRkX2NsaWVudF9yZXNwb25zZSkpOw0KPiArCW1lbXNldCgmcmVz
cCwgMCwgbGVuKTsNCj4gIAlyZXNwLmhibV9jbWQgPSBNRUlfSEJNX0FERF9DTElFTlRfUkVTX0NN
RDsNCj4gIAlyZXNwLm1lX2FkZHIgPSBhZGRyOw0KPiAgCXJlc3Auc3RhdHVzICA9IHN0YXR1czsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaHcuaCBiL2RyaXZlcnMvbWlzYy9tZWkv
aHcuaCBpbmRleA0KPiBiMWE4ZDVlYzg4YjMuLjhjMDI5N2YwZTdmMyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9taXNjL21laS9ody5oDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvaHcuaA0KPiBA
QCAtMzQ2LDEzICszNDYsMTMgQEAgc3RydWN0IGhibV9hZGRfY2xpZW50X3JlcXVlc3Qgew0KPiAg
ICogQGhibV9jbWQ6IGJ1cyBtZXNzYWdlIGNvbW1hbmQgaGVhZGVyDQo+ICAgKiBAbWVfYWRkcjog
YWRkcmVzcyBvZiB0aGUgY2xpZW50IGluIE1FDQo+ICAgKiBAc3RhdHVzOiBpZiBIQk1TX1NVQ0NF
U1MgdGhlbiB0aGUgY2xpZW50IGNhbiBub3cgYWNjZXB0IGNvbm5lY3Rpb25zLg0KPiAtICogQHJl
c2VydmVkOiByZXNlcnZlZA0KPiArICogQHJlc2VydmVkOiByZXNlcnZlZCBmb3IgYWxpZ25tZW50
Lg0KPiAgICovDQo+ICBzdHJ1Y3QgaGJtX2FkZF9jbGllbnRfcmVzcG9uc2Ugew0KPiAgCXU4IGhi
bV9jbWQ7DQo+ICAJdTggbWVfYWRkcjsNCj4gIAl1OCBzdGF0dXM7DQo+IC0JdTggcmVzZXJ2ZWRb
MV07DQo+ICsJdTggcmVzZXJ2ZWQ7DQo+ICB9IF9fcGFja2VkOw0KPiANCj4gIC8qKg0KPiBAQCAt
NDYxLDcgKzQ2MSw3IEBAIHN0cnVjdCBoYm1fbm90aWZpY2F0aW9uIHsNCj4gIAl1OCBoYm1fY21k
Ow0KPiAgCXU4IG1lX2FkZHI7DQo+ICAJdTggaG9zdF9hZGRyOw0KPiAtCXU4IHJlc2VydmVkWzFd
Ow0KPiArCXU4IHJlc2VydmVkOw0KPiAgfSBfX3BhY2tlZDsNCj4gDQo+ICAvKioNCj4gLS0NCj4g
Mi4yNy4wDQoNCg==
