Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E076C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 02:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB2E20748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LsKFrte7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYCAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:00:16 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50428 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYCAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587780014; x=1619316014;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=tL421YGoXf0/XNLqGolhDAR7ZcKtVSLcXds/GPTHE+I=;
  b=LsKFrte7/K9aTX8BoXL2L28JxO9HgDhKWTYnoqTVsulQLaef8gOI3/KT
   8xkZjIOyg/oO+n8g3e9vbQ2DuzoN/I3Ei6oH6504CDoz+DTNgCbFczAtz
   UemlssAqVEMMpVs4AGFu9RnMlzIV0WWggBLhXL8ObGVZQfZDt/+1nlehp
   I=;
IronPort-SDR: fGsY4L97XFbNl7zvbZSw29QHtEv403XS2sTeMz0Ed4AuMviGuFJvvsDWAaTb8b8qCXxltMBhbI
 huc212jtYePw==
X-IronPort-AV: E=Sophos;i="5.73,314,1583193600"; 
   d="scan'208";a="31056636"
Subject: Re: [PATCH v4 2/6] arch/x86/kvm: Refactor tlbflush and l1d flush
Thread-Topic: [PATCH v4 2/6] arch/x86/kvm: Refactor tlbflush and l1d flush
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 25 Apr 2020 02:00:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 0D9ACA23F8;
        Sat, 25 Apr 2020 02:00:08 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 25 Apr 2020 02:00:08 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 25 Apr 2020 02:00:07 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Sat, 25 Apr 2020 02:00:07 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWGXe0ZgF6A9jeiEmVmBjXs72EAaiIo1uAgAB0L4A=
Date:   Sat, 25 Apr 2020 02:00:07 +0000
Message-ID: <871aed902ea0932288c47059771aa8624db55907.camel@amazon.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
         <20200423140125.7332-3-sblbir@amazon.com>
         <e500fe9a-5c62-8304-92f1-18a2ee185fe4@amd.com>
In-Reply-To: <e500fe9a-5c62-8304-92f1-18a2ee185fe4@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <59453AADE751974EA8C3A1D86F2C8E62@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTI0IGF0IDE0OjA0IC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2Fu
aXphdGlvbi4gRG8gbm90DQo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQo+IA0KPiANCj4gDQo+IE9uIDQvMjMvMjAgOTowMSBBTSwgQmFsYmlyIFNpbmdoIHdyb3Rl
Og0KPiA+IFJlZmFjdG9yIHRoZSBleGlzdGluZyBhc3NlbWJseSBiaXRzIGludG8gc21hbGxlciBo
ZWxwZXIgZnVuY3Rpb25zDQo+ID4gYW5kIGFsc28gYWJzdHJhY3QgTDFEX0ZMVVNIIGludG8gYSBo
ZWxwZXIgZnVuY3Rpb24uIFVzZSB0aGVzZQ0KPiA+IGZ1bmN0aW9ucyBpbiBrdm0gZm9yIEwxRCBm
bHVzaGluZy4NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9u
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaCB8
ICAzICsrDQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvbDFkX2ZsdXNoLmMgICAgICAgfCA1NCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBhcmNoL3g4Ni9rdm0vdm14L3ZteC5j
ICAgICAgICAgICAgfCAyOSArKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA2MCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY2FjaGVmbHVzaC5oDQo+ID4gYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9jYWNoZWZsdXNoLmgNCj4gPiBpbmRleCBiYWM1NmZjZDk3OTAuLjIxY2MzYjI4ZmE2
MyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgNCj4g
PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgNCj4gPiBAQCAtOCw3ICs4
LDEwIEBADQo+ID4gDQo+ID4gICAjZGVmaW5lIEwxRF9DQUNIRV9PUkRFUiA0DQo+ID4gICB2b2lk
IGNsZmx1c2hfY2FjaGVfcmFuZ2Uodm9pZCAqYWRkciwgdW5zaWduZWQgaW50IHNpemUpOw0KPiA+
ICt2b2lkIGwxZF9mbHVzaF9wb3B1bGF0ZV90bGIodm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKTsNCj4g
PiAgIHZvaWQgKmwxZF9mbHVzaF9hbGxvY19wYWdlcyh2b2lkKTsNCj4gPiAgIHZvaWQgbDFkX2Zs
dXNoX2NsZWFudXBfcGFnZXModm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKTsNCj4gPiArdm9pZCBsMWRf
Zmx1c2hfc3codm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKTsNCj4gPiAraW50IGwxZF9mbHVzaF9odyh2
b2lkKTsNCj4gPiANCj4gPiAgICNlbmRpZiAvKiBfQVNNX1g4Nl9DQUNIRUZMVVNIX0ggKi8NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5jIGIvYXJjaC94ODYva2Vy
bmVsL2wxZF9mbHVzaC5jDQo+ID4gaW5kZXggZDYwNTg3OGM4ZjI4Li41ODcxNzk0Zjg5MGQgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5jDQo+ID4gKysrIGIvYXJj
aC94ODYva2VybmVsL2wxZF9mbHVzaC5jDQo+ID4gQEAgLTM0LDMgKzM0LDU3IEBAIHZvaWQgbDFk
X2ZsdXNoX2NsZWFudXBfcGFnZXModm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKQ0KPiA+ICAgICAgIGZy
ZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcpbDFkX2ZsdXNoX3BhZ2VzLCBMMURfQ0FDSEVfT1JERVIp
Ow0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwobDFkX2ZsdXNoX2NsZWFudXBfcGFn
ZXMpOw0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogTm90IGFsbCB1c2VycyBvZiBsMWQgZmx1c2gg
d291bGQgd2FudCB0byBwb3B1bGF0ZSB0aGUgVExCIGZpcnN0DQo+ID4gKyAqIHNwbGl0IG91dCB0
aGUgZnVuY3Rpb24gc28gdGhhdCBjYWxsZXJzIGNhbiBvcHRpb25hbGx5IGZsdXNoIHRoZSBMMUQN
Cj4gPiArICogY2FjaGUgdmlhIHN3IHdpdGhvdXQgcHJlZmV0Y2hpbmcgdGhlIFRMQi4NCj4gPiAr
ICovDQo+ID4gK3ZvaWQgbDFkX2ZsdXNoX3BvcHVsYXRlX3RsYih2b2lkICpsMWRfZmx1c2hfcGFn
ZXMpDQo+ID4gK3sNCj4gPiArICAgICBpbnQgc2l6ZSA9IFBBR0VfU0laRSA8PCBMMURfQ0FDSEVf
T1JERVI7DQo+ID4gKw0KPiA+ICsgICAgIGFzbSB2b2xhdGlsZSgNCj4gPiArICAgICAgICAgICAg
IC8qIEZpcnN0IGVuc3VyZSB0aGUgcGFnZXMgYXJlIGluIHRoZSBUTEIgKi8NCj4gPiArICAgICAg
ICAgICAgICJ4b3JsICAgJSVlYXgsICUlZWF4XG4iDQo+ID4gKyAgICAgICAgICAgICAiLkxwb3B1
bGF0ZV90bGI6XG5cdCINCj4gPiArICAgICAgICAgICAgICJtb3Z6YmwgKCVbZmx1c2hfcGFnZXNd
LCAlJSIgX0FTTV9BWCAiKSwgJSVlY3hcblx0Ig0KPiA+ICsgICAgICAgICAgICAgImFkZGwgICAk
NDA5NiwgJSVlYXhcblx0Ig0KPiA+ICsgICAgICAgICAgICAgImNtcGwgICAlJWVheCwgJVtzaXpl
XVxuXHQiDQo+ID4gKyAgICAgICAgICAgICAiam5lICAgIC5McG9wdWxhdGVfdGxiXG5cdCINCj4g
PiArICAgICAgICAgICAgICJ4b3JsICAgJSVlYXgsICUlZWF4XG5cdCINCj4gPiArICAgICAgICAg
ICAgICJjcHVpZFxuXHQiDQo+ID4gKyAgICAgICAgICAgICA6OiBbZmx1c2hfcGFnZXNdICJyIiAo
bDFkX2ZsdXNoX3BhZ2VzKSwNCj4gPiArICAgICAgICAgICAgICAgICBbc2l6ZV0gInIiIChzaXpl
KQ0KPiA+ICsgICAgICAgICAgICAgOiAiZWF4IiwgImVieCIsICJlY3giLCAiZWR4Iik7DQo+ID4g
K30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwobDFkX2ZsdXNoX3BvcHVsYXRlX3RsYik7DQo+ID4g
Kw0KPiA+ICtpbnQgbDFkX2ZsdXNoX2h3KHZvaWQpDQo+ID4gK3sNCj4gPiArICAgICBpZiAoc3Rh
dGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfRkxVU0hfTDFEKSkgew0KPiA+ICsgICAgICAgICAgICAg
d3Jtc3JsKE1TUl9JQTMyX0ZMVVNIX0NNRCwgTDFEX0ZMVVNIKTsNCj4gPiArICAgICAgICAgICAg
IHJldHVybiAwOw0KPiA+ICsgICAgIH0NCj4gPiArICAgICByZXR1cm4gLUVOT1RTVVBQOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGwxZF9mbHVzaF9odyk7DQo+ID4gKw0KPiA+ICt2
b2lkIGwxZF9mbHVzaF9zdyh2b2lkICpsMWRfZmx1c2hfcGFnZXMpDQo+ID4gK3sNCj4gPiArICAg
ICBpbnQgc2l6ZSA9IFBBR0VfU0laRSA8PCBMMURfQ0FDSEVfT1JERVI7DQo+ID4gKw0KPiA+ICsg
ICAgIGFzbSB2b2xhdGlsZSgNCj4gPiArICAgICAgICAgICAgICAgICAgICAgLyogRmlsbCB0aGUg
Y2FjaGUgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgInhvcmwgICAlJWVheCwgJSVlYXhc
biINCj4gPiArICAgICAgICAgICAgICAgICAgICAgIi5MZmlsbF9jYWNoZTpcbiINCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgIm1vdnpibCAoJVtmbHVzaF9wYWdlc10sICUlIiBfQVNNX0FYICIp
LCAlJWVjeFxuXHQiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICJhZGRsICAgJDY0LCAlJWVh
eFxuXHQiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICJjbXBsICAgJSVlYXgsICVbc2l6ZV1c
blx0Ig0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAiam5lICAgIC5MZmlsbF9jYWNoZVxuXHQi
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICJsZmVuY2VcbiINCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgOjogW2ZsdXNoX3BhZ2VzXSAiciIgKGwxZF9mbHVzaF9wYWdlcyksDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIFtzaXplXSAiciIgKHNpemUpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIDogImVheCIsICJlY3giKTsNCj4gPiArfQ0KPiANCj4gSWYgdGhlIGFuc3dlciB0byBt
eSBwcmV2aW91cyBxdWVzdGlvbiBpbiBwYXRjaCAxLzYgYWJvdXQgdGhlIGFsbG9jYXRpb24NCj4g
YmVpbmcgdHdpY2UgdGhlIHNpemUgaXMgeWVzLCB0aGVuIGNvdWxkIHlvdSBhbGxvY2F0ZSB0aGUg
Zmx1c2ggcGFnZXMgdGhlDQo+IHNhbWUgc2l6ZSBhcyB0aGUgY2FjaGUgYW5kIGp1c3Qgd3JpdGUg
aXQgdHdpY2U/IFdvdWxkbid0IHRoYXQgYWNjb21wbGlzaA0KPiB0aGUgc2FtZSBnb2FsIGFuZCBw
cm92aWRlIGEgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgd2l0aCAobW9zdGx5KSBub3cNCj4gcHJl
c2VudCBMMUQgZW50cmllcyBvZiB0aGUgZmx1c2ggcGFnZXM/IEFsc28sIGNhbid0IHlvdSB1bnJv
bGwgdGhpcyBsb29wIGENCj4gYml0IGFuZCBvcGVyYXRlIG9uIG11bHRpcGxlIGVudHJpZXMgaW4g
ZWFjaCBsb29wLCByZWR1Y2luZyB0aGUgb3ZlcmFsbA0KPiBsb29waW5nIGNvbXBhcmVzIGFuZCBq
dW1wcyBhcyBhbiBvcHRpbWl6YXRpb24/DQo+IA0KDQpZZXMsIEkgaGF2ZSBzb21lIG9wdGlvbnMg
c3VnZ2VzdGVkIGluIG15IGFuc3dlciB0byB5b3VyIHF1ZXN0aW9uIGluIDEvNi4gRm9yDQpub3cg
SSBkZWNpZGVkIHRvIHN0aWNrIHdpdGggdGhlIGFsZ29yaXRobSBhbHJlYWR5IHByZXNlbnQsIGJ1
dCB3ZSBjb3VsZA0KZGVmaW5pdGVseSBvcHRpbWl6ZSBpdA0KDQpCYWxiaXINCg0KPiBUaGFua3Ms
DQo+IFRvbQ0KPiANCg==
