Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB109C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0298206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895137AbgDOIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:51:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:56510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505533AbgDOIvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:51:22 -0400
IronPort-SDR: M0hU+GiM2e0fZZ8oOxI29n2vLb74PaUj+ikH7HWCcsAM8kp3QYZop9QI2+eaUGp8/0muLNVXRL
 dwEoz65z84ZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:51:20 -0700
IronPort-SDR: xd9uDqMgnkX0scbPhyGHWRupxBViiiK/x+vQT2bmXrZTKg+P4RFZwtcmu8IBNIJOiUdtPVSli7
 J1WvFa/VGang==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="244050165"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2020 01:51:20 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 01:51:20 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 01:51:19 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 16:51:10 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Topic: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Index: AQHWEubNcojyloGV5kG0IsggcRYC46h50o9A//+BuQCAAIvZAA==
Date:   Wed, 15 Apr 2020 08:51:10 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D82066C@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-3-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D82055A@SHSMSX104.ccr.corp.intel.com>
 <85ee7356-dd36-e872-8196-ad44bbc1ad20@linux.intel.com>
In-Reply-To: <85ee7356-dd36-e872-8196-ad44bbc1ad20@linux.intel.com>
Accept-Language: en-US
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

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDE1LCAyMDIwIDQ6MzAgUE0NCj4gDQo+IE9uIDIwMjAvNC8xNSAxNjoxOCwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNSwgMjAyMCAxOjI2IFBNDQo+
ID4+DQo+ID4+IEV4dGVuZCBxaV9zdWJtaXRfc3luYygpIGZ1bmN0aW9uIHRvIHN1cHBvcnQgbXVs
dGlwbGUgZGVzY3JpcHRvcnMuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEphY29iIFBhbjxq
YWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFv
bHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2lv
bW11L2RtYXIuYyAgICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tDQo+ID4+ICAgaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oIHwgIDEgKw0KPiA+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4+DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYXIuYyBiL2RyaXZlcnMvaW9tbXUvZG1h
ci5jDQo+ID4+IGluZGV4IGJiNDIxNzdlMjM2OS4uNjFkMDQ5ZTkxZjg0IDEwMDY0NA0KPiA+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2RtYXIuYw0KPiA+PiArKysgYi9kcml2ZXJzL2lvbW11L2RtYXIu
Yw0KPiA+PiBAQCAtMTE1NywxMiArMTE1NywxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVjbGFp
bV9mcmVlX2Rlc2Moc3RydWN0DQo+ID4+IHFfaW52YWwgKnFpKQ0KPiA+PiAgIAl9DQo+ID4+ICAg
fQ0KPiA+Pg0KPiA+PiAtc3RhdGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1Y3QgaW50ZWxfaW9t
bXUgKmlvbW11LCBpbnQgaW5kZXgpDQo+ID4+ICtzdGF0aWMgaW50IHFpX2NoZWNrX2ZhdWx0KHN0
cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsIGludCBpbmRleCwgaW50DQo+ID4+IHdhaXRfaW5kZXgp
DQo+ID4+ICAgew0KPiA+PiAgIAl1MzIgZmF1bHQ7DQo+ID4+ICAgCWludCBoZWFkLCB0YWlsOw0K
PiA+PiAgIAlzdHJ1Y3QgcV9pbnZhbCAqcWkgPSBpb21tdS0+cWk7DQo+ID4+IC0JaW50IHdhaXRf
aW5kZXggPSAoaW5kZXggKyAxKSAlIFFJX0xFTkdUSDsNCj4gPj4gICAJaW50IHNoaWZ0ID0gcWlf
c2hpZnQoaW9tbXUpOw0KPiA+Pg0KPiA+PiAgIAlpZiAocWktPmRlc2Nfc3RhdHVzW3dhaXRfaW5k
ZXhdID09IFFJX0FCT1JUKQ0KPiA+PiBAQCAtMTIzNCwxMiArMTIzMywxMiBAQCBzdGF0aWMgaW50
IHFpX2NoZWNrX2ZhdWx0KHN0cnVjdCBpbnRlbF9pb21tdQ0KPiA+PiAqaW9tbXUsIGludCBpbmRl
eCkNCj4gPj4gICBpbnQgcWlfc3VibWl0X3N5bmMoc3RydWN0IGludGVsX2lvbW11ICppb21tdSwg
c3RydWN0IHFpX2Rlc2MgKmRlc2MsDQo+ID4+ICAgCQkgICB1bnNpZ25lZCBpbnQgY291bnQsIHVu
c2lnbmVkIGxvbmcgb3B0aW9ucykNCj4gPj4gICB7DQo+ID4+IC0JaW50IHJjOw0KPiA+PiAgIAlz
dHJ1Y3QgcV9pbnZhbCAqcWkgPSBpb21tdS0+cWk7DQo+ID4+IC0JaW50IG9mZnNldCwgc2hpZnQs
IGxlbmd0aDsNCj4gPj4gICAJc3RydWN0IHFpX2Rlc2Mgd2FpdF9kZXNjOw0KPiA+PiAgIAlpbnQg
d2FpdF9pbmRleCwgaW5kZXg7DQo+ID4+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4+ICsJ
aW50IG9mZnNldCwgc2hpZnQ7DQo+ID4+ICsJaW50IHJjLCBpOw0KPiA+Pg0KPiA+PiAgIAlpZiAo
IXFpKQ0KPiA+PiAgIAkJcmV0dXJuIDA7DQo+ID4+IEBAIC0xMjQ4LDMyICsxMjQ3LDQxIEBAIGlu
dCBxaV9zdWJtaXRfc3luYyhzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4gKmlvbW11LA0KPiA+PiBzdHJ1
Y3QgcWlfZGVzYyAqZGVzYywNCj4gPj4gICAJcmMgPSAwOw0KPiA+Pg0KPiA+PiAgIAlyYXdfc3Bp
bl9sb2NrX2lycXNhdmUoJnFpLT5xX2xvY2ssIGZsYWdzKTsNCj4gPj4gLQl3aGlsZSAocWktPmZy
ZWVfY250IDwgMykgew0KPiA+PiArCS8qDQo+ID4+ICsJICogQ2hlY2sgaWYgd2UgaGF2ZSBlbm91
Z2ggZW1wdHkgc2xvdHMgaW4gdGhlIHF1ZXVlIHRvIHN1Ym1pdCwNCj4gPj4gKwkgKiB0aGUgY2Fs
Y3VsYXRpb24gaXMgYmFzZWQgb246DQo+ID4+ICsJICogIyBvZiBkZXNjICsgMSB3YWl0IGRlc2Mg
KyAxIHNwYWNlIGJldHdlZW4gaGVhZCBhbmQgdGFpbA0KPiA+PiArCSAqLw0KPiA+PiArCXdoaWxl
IChxaS0+ZnJlZV9jbnQgPCBjb3VudCArIDIpIHsNCj4gPj4gICAJCXJhd19zcGluX3VubG9ja19p
cnFyZXN0b3JlKCZxaS0+cV9sb2NrLCBmbGFncyk7DQo+ID4+ICAgCQljcHVfcmVsYXgoKTsNCj4g
Pj4gICAJCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmcWktPnFfbG9jaywgZmxhZ3MpOw0KPiA+PiAg
IAl9DQo+ID4+DQo+ID4+ICAgCWluZGV4ID0gcWktPmZyZWVfaGVhZDsNCj4gPj4gLQl3YWl0X2lu
ZGV4ID0gKGluZGV4ICsgMSkgJSBRSV9MRU5HVEg7DQo+ID4+ICsJd2FpdF9pbmRleCA9IChpbmRl
eCArIGNvdW50KSAlIFFJX0xFTkdUSDsNCj4gPj4gICAJc2hpZnQgPSBxaV9zaGlmdChpb21tdSk7
DQo+ID4+IC0JbGVuZ3RoID0gMSA8PCBzaGlmdDsNCj4gPj4NCj4gPj4gLQlxaS0+ZGVzY19zdGF0
dXNbaW5kZXhdID0gcWktPmRlc2Nfc3RhdHVzW3dhaXRfaW5kZXhdID0gUUlfSU5fVVNFOw0KPiA+
PiArCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+ID4+ICsJCW9mZnNldCA9ICgoaW5k
ZXggKyBpKSAlIFFJX0xFTkdUSCkgPDwgc2hpZnQ7DQo+ID4+ICsJCW1lbWNweShxaS0+ZGVzYyAr
IG9mZnNldCwgJmRlc2NbaV0sIDEgPDwgc2hpZnQpOw0KPiA+PiArCQlxaS0+ZGVzY19zdGF0dXNb
KGluZGV4ICsgaSkgJSBRSV9MRU5HVEhdID0gUUlfSU5fVVNFOw0KPiA+PiArCX0NCj4gPiB3aGF0
IGFib3V0IGRvaW5nIG9uZSBtZW1jcHkgYW5kIGxlYXZlIHRoZSBsb29wIG9ubHkgZm9yIHVwZGF0
aW5nDQo+ID4gcWkgc3RhdHVzPw0KPiA+DQo+IA0KPiBPbmUgbWVtY3B5IG1pZ2h0IGNyb3NzIHRo
ZSB0YWJsZSBib3VuZGFyeS4NCj4gDQoNClRoYW5rcy4geW91IGFyZSByaWdodC4NCg==
