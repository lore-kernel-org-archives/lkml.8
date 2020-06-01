Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7603C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9E72073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFAQc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:32:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:47272 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAQc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:32:57 -0400
IronPort-SDR: cAxwpuJ9FUmOnw0Q1N7EIBcBhjy68GjRvtSFuNYUlFH3uMr73E6f9Nbf4k/soWEmPDKU4EBsSR
 6T8H7bRrvj5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:32:56 -0700
IronPort-SDR: YfEKp5EI6Gtqh/ad/1dxFJHg8fn670cYhNd44FJvFaEhv7EjhpgqbFq/NyMRIZWME+A7kDt8N9
 H5JFBlfu+VDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="444347897"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2020 09:32:56 -0700
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 09:32:55 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jun 2020 19:32:53 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Mon, 1 Jun 2020 19:32:53 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Dorian Stoll <dorian.stoll@tmsp.io>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: me: Add itouch device IDs for SPT / ICP
Thread-Topic: [PATCH] mei: me: Add itouch device IDs for SPT / ICP
Thread-Index: AQHWOC5DxbJKJY4NZEyE7jjAFJ52tKjD8m1A
Date:   Mon, 1 Jun 2020 16:32:53 +0000
Message-ID: <b22a353f4d4f47df9676c9572b6ac773@intel.com>
References: <20200601155954.764558-1-dorian.stoll@tmsp.io>
In-Reply-To: <20200601155954.764558-1-dorian.stoll@tmsp.io>
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

DQoNCj4gVGhlc2UgZGV2aWNlIElEcyBjYW4gYmUgZm91bmQgb24gTWljcm9zb2Z0IFN1cmZhY2Ug
ZGV2aWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERvcmlhbiBTdG9sbCA8ZG9yaWFuLnN0b2xs
QHRtc3AuaW8+DQoNClRoaXMgbmVlZCB0byBiZSBkb25lIGRpZmZlcmVudGx5IGJlY2F1c2Ugb2Yg
dGhlIHNlcnZlciBwbGF0Zm9ybXMgY29uZmxpY3QuDQpJIGhhdmUgcGF0Y2hlcyBmb3IgdGhhdCBJ
IHdpbGwgcG9zdCBzaG9ydCwgdGhvdWdoIHdlIGFyZSBub3Qgb2ZmaWNpYWxseSBzdXBwb3J0aW5n
IHRob3NlIGRldmljZXMgdW5kZXIgTGludXgsIA0KSXQgd2lsbCBiZSBoYXJkIHRvIG1haW50YWlu
LCAgYXMgY3VycmVudGx5IG9uIHRoZSBNUyBzdXJmYWNlIGVuYWJsZXMgaXQgYXMgZmFyIGFzIEkg
a25vdy4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbWlzYy9tZWkvaHctbWUtcmVncy5oIHwgMiArKw0K
PiAgZHJpdmVycy9taXNjL21laS9wY2ktbWUuYyAgICAgfCAyICsrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkv
aHctbWUtcmVncy5oIGIvZHJpdmVycy9taXNjL21laS9ody1tZS0NCj4gcmVncy5oIGluZGV4IDkz
OTI5MzRlM2EwNi4uOTBlN2QzMDIwZmE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVp
L2h3LW1lLXJlZ3MuaA0KPiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2h3LW1lLXJlZ3MuaA0KPiBA
QCAtNTksNiArNTksNyBAQA0KPiANCj4gICNkZWZpbmUgTUVJX0RFVl9JRF9TUFQgICAgICAgIDB4
OUQzQSAgLyogU3VucmlzZSBQb2ludCAqLw0KPiAgI2RlZmluZSBNRUlfREVWX0lEX1NQVF8yICAg
ICAgMHg5RDNCICAvKiBTdW5yaXNlIFBvaW50IDIgKi8NCj4gKyNkZWZpbmUgTUVJX0RFVl9JRF9T
UFRfNCAgICAgIDB4OUQzRSAgLyogU3VucmlzZSBQb2ludCA0IChpVG91Y2gpICovDQo+ICAjZGVm
aW5lIE1FSV9ERVZfSURfU1BUX0ggICAgICAweEExM0EgIC8qIFN1bnJpc2UgUG9pbnQgSCAqLw0K
PiAgI2RlZmluZSBNRUlfREVWX0lEX1NQVF9IXzIgICAgMHhBMTNCICAvKiBTdW5yaXNlIFBvaW50
IEggMiAqLw0KPiANCj4gQEAgLTkwLDYgKzkxLDcgQEANCj4gICNkZWZpbmUgTUVJX0RFVl9JRF9D
REYgICAgICAgIDB4MThEMyAgLyogQ2VkYXIgRm9yayAqLw0KPiANCj4gICNkZWZpbmUgTUVJX0RF
Vl9JRF9JQ1BfTFAgICAgIDB4MzRFMCAgLyogSWNlIExha2UgUG9pbnQgTFAgKi8NCj4gKyNkZWZp
bmUgTUVJX0RFVl9JRF9JQ1BfTFBfNCAgIDB4MzRFNCAgLyogSWNlIExha2UgUG9pbnQgTFAgNCAo
aVRvdWNoKSAqLw0KPiANCj4gICNkZWZpbmUgTUVJX0RFVl9JRF9KU1BfTiAgICAgIDB4NERFMCAg
LyogSmFzcGVyIExha2UgUG9pbnQgTiAqLw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlz
Yy9tZWkvcGNpLW1lLmMgYi9kcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jIGluZGV4DQo+IGExZWQz
NzVmZWQzNy4uNWU2MjFlOTBkOGQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL3Bj
aS1tZS5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvcGNpLW1lLmMNCj4gQEAgLTY4LDYgKzY4
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG1laV9tZV9wY2lfdGJsW10g
PSB7DQo+IA0KPiAgCXtNRUlfUENJX0RFVklDRShNRUlfREVWX0lEX1NQVCwgTUVJX01FX1BDSDhf
Q0ZHKX0sDQo+ICAJe01FSV9QQ0lfREVWSUNFKE1FSV9ERVZfSURfU1BUXzIsIE1FSV9NRV9QQ0g4
X0NGRyl9LA0KPiArCXtNRUlfUENJX0RFVklDRShNRUlfREVWX0lEX1NQVF80LCBNRUlfTUVfUENI
OF9DRkcpfSwNCj4gIAl7TUVJX1BDSV9ERVZJQ0UoTUVJX0RFVl9JRF9TUFRfSCwgTUVJX01FX1BD
SDhfU1BTX0NGRyl9LA0KPiAgCXtNRUlfUENJX0RFVklDRShNRUlfREVWX0lEX1NQVF9IXzIsIE1F
SV9NRV9QQ0g4X1NQU19DRkcpfSwNCj4gIAl7TUVJX1BDSV9ERVZJQ0UoTUVJX0RFVl9JRF9MQkcs
IE1FSV9NRV9QQ0gxMl9TUFNfQ0ZHKX0sDQo+IEBAIC05NCw2ICs5NSw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBtZWlfbWVfcGNpX3RibFtdID0gew0KPiAgCXtNRUlfUENJ
X0RFVklDRShNRUlfREVWX0lEX0NNUF9IXzMsIE1FSV9NRV9QQ0g4X0NGRyl9LA0KPiANCj4gIAl7
TUVJX1BDSV9ERVZJQ0UoTUVJX0RFVl9JRF9JQ1BfTFAsIE1FSV9NRV9QQ0gxMl9DRkcpfSwNCj4g
Kwl7TUVJX1BDSV9ERVZJQ0UoTUVJX0RFVl9JRF9JQ1BfTFBfNCwgTUVJX01FX1BDSDEyX0NGRyl9
LA0KPiANCj4gIAl7TUVJX1BDSV9ERVZJQ0UoTUVJX0RFVl9JRF9UR1BfTFAsIE1FSV9NRV9QQ0gx
NV9DRkcpfSwNCj4gDQo+IC0tDQo+IDIuMjYuMg0KPiANCg0K
