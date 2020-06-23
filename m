Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFE1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E6F20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgFWRR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:17:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:28336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732565AbgFWRRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:17:55 -0400
IronPort-SDR: 9vqZfI0SZ+AV4l6+U2HwLSPxCVc/c/MKAIbjbBYSbl7mS9wjtnVaWi6x2Lk2ZuJictftKwIH65
 wuffWg91Q9hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="228828330"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="228828330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 10:17:55 -0700
IronPort-SDR: QqJOeT9Ei1y49YUi5dh4v8TuAU11k60a35NCukR6LXeFi3OiPX3gWHG4qGXQ4O6d1hIpEWe+27
 B7la9SXRCINg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="263385039"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2020 10:17:55 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jun 2020 10:17:54 -0700
Received: from bgsmsx109.gar.corp.intel.com (10.223.4.211) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jun 2020 10:17:54 -0700
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.234]) by
 BGSMSX109.gar.corp.intel.com ([169.254.10.57]) with mapi id 14.03.0439.000;
 Tue, 23 Jun 2020 22:47:53 +0530
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Brian Norris <computersforpeace@gmail.com>
CC:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/thermal: tmon: include pthread and time headers
 in tmon.h
Thread-Topic: [PATCH] tools/thermal: tmon: include pthread and time headers
 in tmon.h
Thread-Index: AQHWRQMzxp7pT+i6D0m0f8CbMSxYSajdUOOAgAkoLXA=
Date:   Tue, 23 Jun 2020 17:17:53 +0000
Message-ID: <3C3E65E75D9910479323816378A812E7417797A2@BGSMSX104.gar.corp.intel.com>
References: <20200617235809.6817-1-mmayer@broadcom.com>
 <f5e160e0-ac4f-8c14-d06e-38f859690ff9@gmail.com>
In-Reply-To: <f5e160e0-ac4f-8c14-d06e-38f859690ff9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGbG9yaWFuIEZhaW5lbGxpIDxm
LmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTgsIDIwMjAgODoy
MyBBTQ0KPiBUbzogTWFya3VzIE1heWVyIDxtYXJrdXMubWF5ZXJAYnJvYWRjb20uY29tPjsgRGFu
aWVsIExlemNhbm8NCj4gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBQYXduaWthciwgU3Vt
ZWV0IFINCj4gPHN1bWVldC5yLnBhd25pa2FyQGludGVsLmNvbT47IFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+OyBCcmlhbg0KPiBOb3JyaXMgPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWls
LmNvbT4NCj4gQ2M6IEJyb2FkY29tIEtlcm5lbCBMaXN0IDxiY20ta2VybmVsLWZlZWRiYWNrLWxp
c3RAYnJvYWRjb20uY29tPjsgTGludXgNCj4gS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdG9vbHMvdGhlcm1h
bDogdG1vbjogaW5jbHVkZSBwdGhyZWFkIGFuZCB0aW1lIGhlYWRlcnMNCj4gaW4gdG1vbi5oDQo+
IA0KPiANCj4gDQo+IE9uIDYvMTcvMjAyMCA0OjU4IFBNLCBNYXJrdXMgTWF5ZXIgd3JvdGU6DQo+
ID4gSW5jbHVkZSBzeXMvdGltZS5oIGFuZCBwdGhyZWFkLmggaW4gdG1vbi5oLCBzbyB0aGF0IHR5
cGVzDQo+ID4gInB0aHJlYWRfbXV0ZXhfdCIgYW5kICJzdHJ1Y3QgdGltZXZhbCB0diIgYXJlIGtu
b3duIHdoZW4gdG1vbi5oDQo+ID4gcmVmZXJlbmNlcyB0aGVtLg0KPiA+DQo+ID4gV2l0aG91dCB0
aGVzZSBoZWFkZXJzLCBjb21waWxpbmcgdG1vbiBhZ2FpbnN0IG11c2wtbGliYyB3aWxsIGZhaWwg
d2l0aA0KPiA+IHRoZXNlIGVycm9yczoNCj4gPg0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBz
eXNmcy5jOjMxOjA6DQo+ID4gdG1vbi5oOjQ3Ojg6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSAn
cHRocmVhZF9tdXRleF90Jw0KPiA+ICBleHRlcm4gcHRocmVhZF9tdXRleF90IGlucHV0X2xvY2s7
DQo+ID4gICAgICAgICBefn5+fn5+fn5+fn5+fn4NCj4gPiBtYWtlWzNdOiAqKiogWzxidWlsdGlu
Pjogc3lzZnMub10gRXJyb3IgMQ0KPiA+IG1ha2VbM106ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uDQo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHR1aS5jOjMxOjA6DQo+ID4g
dG1vbi5oOjU0OjE3OiBlcnJvcjogZmllbGQgJ3R2JyBoYXMgaW5jb21wbGV0ZSB0eXBlDQo+ID4g
ICBzdHJ1Y3QgdGltZXZhbCB0djsNCj4gPiAgICAgICAgICAgICAgICAgIF5+DQo+ID4gbWFrZVsz
XTogKioqIFs8YnVpbHRpbj46IHR1aS5vXSBFcnJvciAxDQo+ID4gbWFrZVsyXTogKioqIFtNYWtl
ZmlsZTo4MzogdG1vbl0gRXJyb3IgMg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFya3VzIE1h
eWVyIDxtbWF5ZXJAYnJvYWRjb20uY29tPg0KPiANCj4gQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVs
bGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KPiAtLQ0KPiBGbG9yaWFuDQoNClJldmlld2VkLWJ5
OiBTdW1lZXQgUGF3bmlrYXIgPHN1bWVldC5yLnBhd25pa2FyQGludGVsLmNvbT4NCg0KVGhhbmtz
LA0KU3VtZWV0Lg0K
