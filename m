Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B98C55194
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA857206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD0DfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:35:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:34469 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgD0DfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:35:04 -0400
IronPort-SDR: gd7h5y0TYFk6bQ1ANGd4P+oWrgy0h5XEeS/2pHj+i3hN+AJ/e6IbMZzKA49da5PgrjUo89GGFP
 9MGhMMZF7fdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 20:35:04 -0700
IronPort-SDR: 4lN3g3wEu3YFhrOsnEp0TYfNeSAOpd48c4eM4BT/P0raYqwC4PiI1XxXxXD3q+k5Y+ci/2Eqfl
 kXrJRgmhkygA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; 
   d="scan'208";a="245962543"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2020 20:35:03 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 20:35:03 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 20:35:03 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.129]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Mon, 27 Apr 2020 11:35:01 +0800
From:   "Ma, Jianpeng" <jianpeng.ma@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: block: remove unused header includes.
Thread-Topic: block: remove unused header includes.
Thread-Index: AdYcP3CXILghGS16Sc6WaotIgRxXX///fKWA//9yTmA=
Date:   Mon, 27 Apr 2020 03:35:00 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C73C55A66@SHSMSX101.ccr.corp.intel.com>
References: <6AA21C22F0A5DA478922644AD2EC308C73C55940@SHSMSX101.ccr.corp.intel.com>
 <768e4398-1789-8dfa-5883-effb566b2f31@infradead.org>
In-Reply-To: <768e4398-1789-8dfa-5883-effb566b2f31@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAyNywgMjAyMCAxMTowNiBB
TQ0KPiBUbzogTWEsIEppYW5wZW5nIDxqaWFucGVuZy5tYUBpbnRlbC5jb20+OyBDaHJpc3RvcGgg
SGVsbHdpZw0KPiA8aGNoQGluZnJhZGVhZC5vcmc+DQo+IENjOiBheGJvZUBrZXJuZWwuZGs7IFdp
bGxpYW1zLCBEYW4gSiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IGJsb2NrOiByZW1vdmUgdW51c2VkIGhl
YWRlciBpbmNsdWRlcy4NCj4gDQo+IEhpLA0KPiANCj4gT24gNC8yNi8yMCA3OjU2IFBNLCBNYSwg
SmlhbnBlbmcgd3JvdGU6DQo+ID4gVGhpcyB1c2VkIGRlaGVhZGVyKGdpdEBnaXRsYWIuY29tOmVz
ci9kZWhlYWRlci5naXQpIHRvIHByb2R1Y2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFu
cGVuZyBNYSA8amlhbnBlbmcubWFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBibG9jay9iYWRi
bG9ja3MuYyAgICAgICAgfCAgNiAtLS0tLS0NCj4gPiAgYmxvY2svYmZxLWNncm91cC5jICAgICAg
IHwgMTAgLS0tLS0tLS0tLQ0KPiA+ICBibG9jay9iZnEtaW9zY2hlZC5jICAgICAgfCAxMyAtLS0t
LS0tLS0tLS0tDQo+ID4gIGJsb2NrL2Jpby1pbnRlZ3JpdHkuYyAgICB8ICA2IC0tLS0tLQ0KPiA+
ICBibG9jay9iaW8uYyAgICAgICAgICAgICAgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KPiA+ICBibG9j
ay9ibGstY2dyb3VwLmMgICAgICAgfCAxMCAtLS0tLS0tLS0tDQo+ID4gIGJsb2NrL2Jsay1jb3Jl
LmMgICAgICAgICB8IDI0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBibG9jay9ibGst
ZXhlYy5jICAgICAgICAgfCAgNSAtLS0tLQ0KPiA+ICBibG9jay9ibGstZmx1c2guYyAgICAgICAg
fCAxMCAtLS0tLS0tLS0tDQo+ID4gIGJsb2NrL2Jsay1pbnRlZ3JpdHkuYyAgICB8ICA2IC0tLS0t
LQ0KPiA+ICBibG9jay9ibGstaW9jLmMgICAgICAgICAgfCAgNyAtLS0tLS0tDQo+ID4gIGJsb2Nr
L2Jsay1saWIuYyAgICAgICAgICB8ICA1IC0tLS0tDQo+ID4gIGJsb2NrL2Jsay1tYXAuYyAgICAg
ICAgICB8ICA0IC0tLS0NCj4gPiAgYmxvY2svYmxrLW1lcmdlLmMgICAgICAgIHwgIDUgLS0tLS0N
Cj4gPiAgYmxvY2svYmxrLW1xLWNwdW1hcC5jICAgIHwgIDggLS0tLS0tLS0NCj4gPiAgYmxvY2sv
YmxrLW1xLWRlYnVnZnMuYyAgIHwgIDYgLS0tLS0tDQo+ID4gIGJsb2NrL2Jsay1tcS1wY2kuYyAg
ICAgICB8ICA0IC0tLS0NCj4gPiAgYmxvY2svYmxrLW1xLXJkbWEuYyAgICAgIHwgIDEgLQ0KPiA+
ICBibG9jay9ibGstbXEtc2NoZWQuYyAgICAgfCAgNyAtLS0tLS0tDQo+ID4gIGJsb2NrL2Jsay1t
cS1zeXNmcy5jICAgICB8IDE1ICstLS0tLS0tLS0tLS0tLQ0KPiA+ICBibG9jay9ibGstbXEtdGFn
LmMgICAgICAgfCAgNSAtLS0tLQ0KPiA+ICBibG9jay9ibGstbXEtdmlydGlvLmMgICAgfCAgNCAt
LS0tDQo+ID4gIGJsb2NrL2Jsay1tcS5jICAgICAgICAgICB8IDIyIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiAgYmxvY2svYmxrLXBtLmMgICAgICAgICAgIHwgIDQgLS0tLQ0KPiA+ICBibG9j
ay9ibGstc2V0dGluZ3MuYyAgICAgfCAgOCAtLS0tLS0tLQ0KPiA+ICBibG9jay9ibGstc29mdGly
cS5jICAgICAgfCAgNiAtLS0tLS0NCj4gPiAgYmxvY2svYmxrLXN0YXQuYyAgICAgICAgIHwgIDUg
LS0tLS0NCj4gPiAgYmxvY2svYmxrLXN5c2ZzLmMgICAgICAgIHwgIDkgLS0tLS0tLS0tDQo+ID4g
IGJsb2NrL2Jsay10aHJvdHRsZS5jICAgICB8ICA1IC0tLS0tDQo+ID4gIGJsb2NrL2Jsay10aW1l
b3V0LmMgICAgICB8ICA1IC0tLS0tDQo+ID4gIGJsb2NrL2Jsay13YnQuYyAgICAgICAgICB8ICA2
IC0tLS0tLQ0KPiA+ICBibG9jay9ibGstem9uZWQuYyAgICAgICAgfCAgNyAtLS0tLS0tDQo+ID4g
IGJsb2NrL2JvdW5jZS5jICAgICAgICAgICB8IDE1IC0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBibG9j
ay9ic2ctbGliLmMgICAgICAgICAgfCAgNSAtLS0tLQ0KPiA+ICBibG9jay9ic2cuYyAgICAgICAg
ICAgICAgfCAxMSAtLS0tLS0tLS0tLQ0KPiA+ICBibG9jay9jbWRsaW5lLXBhcnNlci5jICAgfCAg
MSAtDQo+ID4gIGJsb2NrL2VsZXZhdG9yLmMgICAgICAgICB8IDE1IC0tLS0tLS0tLS0tLS0tLQ0K
PiA+ICBibG9jay9nZW5oZC5jICAgICAgICAgICAgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KPiA+ICBi
bG9jay9pb2N0bC5jICAgICAgICAgICAgfCAgOCAtLS0tLS0tLQ0KPiA+ICBibG9jay9pb3ByaW8u
YyAgICAgICAgICAgfCAxMSAtLS0tLS0tLS0tLQ0KPiA+ICBibG9jay9reWJlci1pb3NjaGVkLmMg
ICAgfCAgOSAtLS0tLS0tLS0NCj4gPiAgYmxvY2svbXEtZGVhZGxpbmUuYyAgICAgIHwgMTQgLS0t
LS0tLS0tLS0tLS0NCj4gPiAgYmxvY2svcGFydGl0aW9ucy9hbWlnYS5jIHwgIDEgLQ0KPiA+ICBi
bG9jay9wYXJ0aXRpb25zL2NvcmUuYyAgfCAgNCAtLS0tDQo+ID4gIGJsb2NrL3BhcnRpdGlvbnMv
ZWZpLmMgICB8ICAzIC0tLQ0KPiA+ICBibG9jay9wYXJ0aXRpb25zL2thcm1hLmMgfCAgMSAtDQo+
ID4gIGJsb2NrL3BhcnRpdGlvbnMvbGRtLmMgICB8ICA0IC0tLS0NCj4gPiAgYmxvY2svcGFydGl0
aW9ucy9tYWMuYyAgIHwgIDEgLQ0KPiA+ICBibG9jay9zY3NpX2lvY3RsLmMgICAgICAgfCAxNCAt
LS0tLS0tLS0tLS0tLQ0KPiA+ICBibG9jay9zZWQtb3BhbC5jICAgICAgICAgfCAgOSAtLS0tLS0t
LS0NCj4gPiAgYmxvY2svdDEwLXBpLmMgICAgICAgICAgIHwgIDEgLQ0KPiA+ICBmcy9ibG9ja19k
ZXYuYyAgICAgICAgICAgfCAxNiAtLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDUyIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA0MDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYmxvY2svYmFkYmxvY2tzLmMgYi9ibG9jay9iYWRibG9ja3MuYyBpbmRleA0KPiA+IDJlNWY1
Njk3ZGIzNS4uNGU0ZWIwZmM5ZWI5IDEwMDY0NA0KPiA+IC0tLSBhL2Jsb2NrL2JhZGJsb2Nrcy5j
DQo+ID4gKysrIGIvYmxvY2svYmFkYmxvY2tzLmMNCj4gPiBAQCAtOCwxMiArOCw2IEBADQo+ID4g
ICAqLw0KPiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9iYWRibG9ja3MuaD4NCj4gPiAtI2luY2x1
ZGUgPGxpbnV4L3NlcWxvY2suaD4NCj4gDQo+IGFib3ZlIGlzIHVzZWQgYnk6DQo+IAlzZXEgPSBy
ZWFkX3NlcWJlZ2luKCZiYi0+bG9jayk7DQo+IA0KPiA+IC0jaW5jbHVkZSA8bGludXgvZGV2aWNl
Lmg+DQo+IA0KPiAJc3RydWN0IGRldmljZSBpcyB1c2VkIGluIHRoaXMgc291cmNlIGZpbGUuDQo+
IA0KPiA+IC0jaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ID4gLSNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCj4gPiAtI2luY2x1ZGUgPGxpbnV4L3N0ZGRlZi5oPg0KPiANCj4gCU5VTEwgaXMg
dXNlZCBpbiB0aGlzIHNvdXJjZSBmaWxlLg0KPiANCj4gPiAtI2luY2x1ZGUgPGxpbnV4L3R5cGVz
Lmg+DQo+IA0KPiAJc2VjdG9yX3QgaXMgdXNlZCBpbiB0aGlzIHNvdXJjZSBmaWxlLg0KPiANCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPg0KPiA+ICAvKioNCj4gDQo+IA0KPiANCj4g
Q2FuIHlvdSBleHBsYWluIHRoZSBjcml0ZXJpYSB0aGF0ICdkZWhlYWRlcicgdXNlIHRvIGRlY2lk
ZSB0aGF0IGEgaGVhZGVyIGZpbGUgY2FuDQo+IGJlIHJlbW92ZWQ/DQo+IA0KRGVoZWFkZXIgaXRl
cmF0b3IgcmVtb3ZlIHRoZSAjaW5jbHVkZSBhbmQgZG8gbWFrZS4gSWYgbm8gZmFpbCBtZWFuIHRo
aXMgI2luY2x1ZGUgY2FuIHJlbW92ZS4gDQoNCj4gQW5kIGFyZSB5b3UgYXdhcmUgb2YgcnVsZSAj
MSBpbiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0LWNoZWNrbGlzdC5yc3Q6DQo+IA0KPiAx
KSBJZiB5b3UgdXNlIGEgZmFjaWxpdHkgdGhlbiAjaW5jbHVkZSB0aGUgZmlsZSB0aGF0IGRlZmlu
ZXMvZGVjbGFyZXMNCj4gICAgdGhhdCBmYWNpbGl0eS4gIERvbid0IGRlcGVuZCBvbiBvdGhlciBo
ZWFkZXIgZmlsZXMgcHVsbGluZyBpbiBvbmVzDQo+ICAgIHRoYXQgeW91IHVzZS4NCj4gDQpJcyB0
aGlzIHJ1bGUgbWVhbiBmb3IgI2lmZGVmIGNhc2U/DQoNCkppYW5wZW5nLg0KPiANCj4gDQo+IC0t
DQo+IH5SYW5keQ0KDQo=
