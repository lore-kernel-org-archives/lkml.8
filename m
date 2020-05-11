Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4196EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B8206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgEKSMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:12:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:6615 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgEKSMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:12:33 -0400
IronPort-SDR: xQKPBFSrVMttBXp/YiJKeketEk4VirNoEll0CoUbuBjjtOg1Bv0trQTtA2+CJuIusJuf9M8pZq
 j+OsaTiybSCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 11:12:33 -0700
IronPort-SDR: a5dNAnaZU73+PB47lD7rYy9vZpVDkfMS/Udz9CRvWB+kMJ1Os2WPkMyiKy+p7EzQchQMRHMAbb
 VL4hbgjUHS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="279862110"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 11 May 2020 11:12:33 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 May 2020 11:12:32 -0700
Received: from fmsmsx108.amr.corp.intel.com ([169.254.9.60]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.217]) with mapi id 14.03.0439.000;
 Mon, 11 May 2020 11:12:32 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
CC:     David Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH 1/3] drm/writeback: don't set fence->ops to default
Thread-Topic: [PATCH 1/3] drm/writeback: don't set fence->ops to default
Thread-Index: AQHWJ3Q7yTxcG3nXxUawaG6GrIfCOKijMEEw
Date:   Mon, 11 May 2020 18:12:32 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663010E20F82D@FMSMSX108.amr.corp.intel.com>
References: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogZHJpLWRldmVsIDxkcmktZGV2ZWwt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPkRhbmllbCBWZXR0
ZXINCj5TZW50OiBNb25kYXksIE1heSAxMSwgMjAyMCA1OjEyIEFNDQo+VG86IExLTUwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT47IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+Ow0KPkludGVsIEdy
YXBoaWNzIERldmVsb3BtZW50IDxpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgRFJJ
DQo+RGV2ZWxvcG1lbnQgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBUaG9tYXMg
WmltbWVybWFubg0KPjx0emltbWVybWFubkBzdXNlLmRlPjsgVmV0dGVyLCBEYW5pZWwgPGRhbmll
bC52ZXR0ZXJAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCAxLzNdIGRybS93cml0ZWJhY2s6
IGRvbid0IHNldCBmZW5jZS0+b3BzIHRvIGRlZmF1bHQNCj4NCj5JdCdzIHRoZSBkZWZhdWx0Lg0K
DQpJIGNhbiBnZXQgYmVoaW5kIHRoYXQuIPCfmIoNCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgSi4g
UnVobCA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29tPg0KDQo+U2lnbmVkLW9mZi1ieTogRGFuaWVs
IFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+DQo+Q2M6IE1hYXJ0ZW4gTGFua2hvcnN0
IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+DQo+Q2M6IE1heGltZSBSaXBhcmQg
PG1yaXBhcmRAa2VybmVsLm9yZz4NCj5DYzogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5u
QHN1c2UuZGU+DQo+Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4NCj5DYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KPi0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vZHJt
X3dyaXRlYmFjay5jIHwgMSAtDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fd3JpdGViYWNrLmMNCj5iL2RyaXZlcnMv
Z3B1L2RybS9kcm1fd3JpdGViYWNrLmMNCj5pbmRleCA0M2Q5ZTNiYjNhOTQuLmRjY2Y0NTA0ZjFi
YiAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3dyaXRlYmFjay5jDQo+KysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV93cml0ZWJhY2suYw0KPkBAIC0xMDgsNyArMTA4LDYgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBkbWFfZmVuY2Vfb3BzDQo+ZHJtX3dyaXRlYmFja19mZW5jZV9vcHMg
PSB7DQo+IAkuZ2V0X2RyaXZlcl9uYW1lID0gZHJtX3dyaXRlYmFja19mZW5jZV9nZXRfZHJpdmVy
X25hbWUsDQo+IAkuZ2V0X3RpbWVsaW5lX25hbWUgPSBkcm1fd3JpdGViYWNrX2ZlbmNlX2dldF90
aW1lbGluZV9uYW1lLA0KPiAJLmVuYWJsZV9zaWduYWxpbmcgPSBkcm1fd3JpdGViYWNrX2ZlbmNl
X2VuYWJsZV9zaWduYWxpbmcsDQo+LQkud2FpdCA9IGRtYV9mZW5jZV9kZWZhdWx0X3dhaXQsDQo+
IH07DQo+DQo+IHN0YXRpYyBpbnQgY3JlYXRlX3dyaXRlYmFja19wcm9wZXJ0aWVzKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYpDQo+LS0NCj4yLjI2LjINCj4NCj5fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KPmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj5kcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwNCg==
