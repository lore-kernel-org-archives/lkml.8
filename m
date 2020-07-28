Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48D3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FCE2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgG1WBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:01:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:1427 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgG1WBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:01:07 -0400
IronPort-SDR: SZ9wRwkSo0sq4xYgjHK6FQk5ZcleowXB/AfBQQwxDRkXJLvYQeEzpPbpH/BmlDycCi2wkeAA3z
 OYL1mricVjcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="139341358"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="139341358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 15:01:06 -0700
IronPort-SDR: Z1QvbzjxWbxHeEyp3882YLz58Pbm7gcj4wAy/caTXO8CyttBoJOOJdkPPLewfd363NE3Q6/BPq
 LB9cCpT9nG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="304009848"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2020 15:01:06 -0700
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 15:01:05 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 01:01:03 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 29 Jul 2020 01:01:02 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: RE: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Topic: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Index: AQHWZSfolBoy0+Wd50OY4DSCzkXDIakdV1+AgAAxzgA=
Date:   Tue, 28 Jul 2020 22:01:02 +0000
Message-ID: <8ec7601780b542c2bc0168e03749ec0e@intel.com>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
 <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
In-Reply-To: <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI5
LCAyMDIwIDAwOjU3DQo+IFRvOiBXaW5rbGVyLCBUb21hcyA8dG9tYXMud2lua2xlckBpbnRlbC5j
b20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBDYzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIDxn
dXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjLW5leHRdIFJl
dmVydCAibWVpOiBoZGNwOiBSZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5DQo+IHdpdGggZmxleGli
bGUtYXJyYXkgbWVtYmVyIg0KPiANCj4gSGkgVG9tYXMsDQo+IA0KPiBPbiA3LzI4LzIwIDE2OjQx
LCBUb21hcyBXaW5rbGVyIHdyb3RlOg0KPiA+IEdyZWcgcGxlYXNlIHJldmVydCwgdGhpcyBjb21t
aXQgaXQgY2hhbmdlcyBzaXplIG9mIHN0cnVjdA0KPiA+IHdpcmVkX2NtZF9yZXBlYXRlcl9hdXRo
X3N0cmVhbV9yZXFfaW4sIHRoaXMgaXMgbm90IHdoYXQgZmlybXdhcmUgaXMNCj4gPiBleHBlY3Rp
bmcuDQo+IA0KPiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHdoYXQncyB0aGUgZmlybXdhcmUgZXhw
ZWN0aW5nLCBleGFjdGx5Pw0Kc3RydWN0IHdpcmVkX2NtZF9yZXBlYXRlcl9hdXRoX3N0cmVhbV9y
ZXFfaW4gew0KICAtCXN0cnVjdCBoZGNwMl9zdHJlYW1pZF90eXBlCXN0cmVhbXNbMV07DQogICsg
CXN0cnVjdCBoZGNwMl9zdHJlYW1pZF90eXBlCXN0cmVhbXNbXTsNCn0NCg0KQnV0IHRoZW4geW91
IGhhdmUsIHdoaWNoIHlvdSBoYXZlbid0IGNoYW5nZWQgdG8gKyAxDQpieXRlID0gbWVpX2NsZGV2
X3NlbmQoY2xkZXYsICh1OCAqKSZ2ZXJpZnlfbXByaW1lX2luLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKHZlcmlmeV9tcHJpbWVfaW4pKTsNCg0KQnV0IHRoYXQncyBub3Qg
dGhlIG1ham9yIHBvaW50LiBQb2ludCBpcyB0aGF0IHdlIHNob3VsZCBiZSBhYmxlIHRvIHJldmll
dw0KYW5kIHRlc3QgdGhlIGNvZGUgYmVmb3JlIGl0IGlzIG1lcmdlZC4gIFlvdSBoYXZlbid0IHJ1
biBpdCwgcmlnaHQ/IA0KVGhlcmUgaXMgTUFJTlRBSU5FUlMgZmlsZSBmb3IgYSByZWFzb24uIA0K
DQoNCj4gDQo+IFRoYW5rcw0KPiAtLQ0KPiBHdXN0YXZvDQo+IA0KPiA+IEkgcmVhbGx5IGRvIG5v
dCBhcHByZWNpYXRlIHRoYXQgdGhlIGNvZGUgaXMgYnlwYXNzaW5nIGRyaXZlciBtYWludGFuZXIN
Cj4gPiByZXZpZXcsIEkgdGhpbmsgdGhpcyBpcyBhIG1pbmltdW0gd2UgY2FuIGFzayBmb3IsIHRo
aXMgaXMgbm90IGZvciBhDQo+ID4gZmlyc3QgdGltZS4NCj4gPg0KPiA+IFRoaXMgcmV2ZXJ0cyBj
b21taXQgYzU2OTY3ZDY3NGUzNjFlYmU3MTZlNjY5OTJlM2M1MzMyYjI1YWMxZi4NCj4gPg0KPiA+
IENjOiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+ID4gU2ln
bmVkLW9mZi1ieTogVG9tYXMgV2lua2xlciA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jIHwgMiArLQ0KPiA+IGRy
aXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oIHwgMiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiA+IGIvZHJpdmVycy9taXNjL21l
aS9oZGNwL21laV9oZGNwLmMNCj4gPiBpbmRleCBkMWQzZTAyNWNhMGUuLmU2YzNkYzU5NTYxNyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5jDQo+ID4gQEAgLTU3Miw3ICs1NzIs
NyBAQCBzdGF0aWMgaW50IG1laV9oZGNwX3ZlcmlmeV9tcHJpbWUoc3RydWN0IGRldmljZQ0KPiAq
ZGV2LA0KPiA+ICAJICAgICAgIEhEQ1BfMl8yX01QUklNRV9MRU4pOw0KPiA+ICAJZHJtX2hkY3Bf
Y3B1X3RvX2JlMjQodmVyaWZ5X21wcmltZV9pbi5zZXFfbnVtX20sIGRhdGEtDQo+ID5zZXFfbnVt
X20pOw0KPiA+ICAJbWVtY3B5KHZlcmlmeV9tcHJpbWVfaW4uc3RyZWFtcywgZGF0YS0+c3RyZWFt
cywNCj4gPiAtCSAgICAgICBhcnJheV9zaXplKGRhdGEtPmssIHNpemVvZigqZGF0YS0+c3RyZWFt
cykpKTsNCj4gPiArCSAgICAgICAoZGF0YS0+ayAqIHNpemVvZihzdHJ1Y3QgaGRjcDJfc3RyZWFt
aWRfdHlwZSkpKTsNCj4gPg0KPiA+ICAJdmVyaWZ5X21wcmltZV9pbi5rID0gY3B1X3RvX2JlMTYo
ZGF0YS0+ayk7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9oZGNwL21l
aV9oZGNwLmgNCj4gPiBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oDQo+ID4gaW5k
ZXggODM0NzU3ZjVlMDcyLi4xOGZmYzc3M2ZhMTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9t
aXNjL21laS9oZGNwL21laV9oZGNwLmgNCj4gPiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2hkY3Av
bWVpX2hkY3AuaA0KPiA+IEBAIC0zNTgsNyArMzU4LDcgQEAgc3RydWN0IHdpcmVkX2NtZF9yZXBl
YXRlcl9hdXRoX3N0cmVhbV9yZXFfaW4gew0KPiA+ICAJdTgNCj4gCXNlcV9udW1fbVtIRENQXzJf
Ml9TRVFfTlVNX0xFTl07DQo+ID4gIAl1OAkJCQltX3ByaW1lW0hEQ1BfMl8yX01QUklNRV9MRU5d
Ow0KPiA+ICAJX19iZTE2CQkJCWs7DQo+ID4gLQlzdHJ1Y3QgaGRjcDJfc3RyZWFtaWRfdHlwZQlz
dHJlYW1zW107DQo+ID4gKwlzdHJ1Y3QgaGRjcDJfc3RyZWFtaWRfdHlwZQlzdHJlYW1zWzFdOw0K
PiA+ICB9IF9fcGFja2VkOw0KPiA+DQo+ID4gIHN0cnVjdCB3aXJlZF9jbWRfcmVwZWF0ZXJfYXV0
aF9zdHJlYW1fcmVxX291dCB7DQo+ID4NCg==
