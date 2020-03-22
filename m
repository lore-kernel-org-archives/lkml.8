Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A5C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 05:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A2A20724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 05:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HC1xDNlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCVFIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 01:08:37 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:17164 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCVFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 01:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584853716; x=1616389716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b00lT/mOaCdiIWpbkqB91fDaLdIPPP2mZJZvNnR7X28=;
  b=HC1xDNlr2FU47IkNVo89kZEUx5Xx7RFqLAbiNsAvRq+nXHqgYxXed+PY
   9hQE3b+N+2bvkZPITnA5yJleUmcX0wrMVdr024cssDCo6mpf4aqWi59pj
   wnbNJdUBvvYTswivEfgOZsBeNynyUu3nyBrBjBuK8RkBcE06B8ZLnKx+r
   c=;
IronPort-SDR: Wd3P7IVQDJiCXHfh+KeQJf5RA2cA045m9rVbd8fGdSgKpJzYIvBoe0fXJ5vJpG6/aSxVF/+8sr
 j/moW2nCioew==
X-IronPort-AV: E=Sophos;i="5.72,291,1580774400"; 
   d="scan'208";a="23627141"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Mar 2020 05:08:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 09685A22D1;
        Sun, 22 Mar 2020 05:08:21 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Mar 2020 05:08:21 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 22 Mar 2020 05:08:21 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.006;
 Sun, 22 Mar 2020 05:08:21 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Balbir" <sblbir@amazon.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Index: AQHWAAfn6i+PyJUPFk+FYFtSBQE7cw==
Date:   Sun, 22 Mar 2020 05:08:20 +0000
Message-ID: <99ef5eec8502a7b53eee362063b9b2252a5a47da.camel@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com>
         <87imj19o13.fsf@nanos.tec.linutronix.de>
         <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com>
         <8736a3456r.fsf@nanos.tec.linutronix.de>
In-Reply-To: <8736a3456r.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE20504C1585604084D5C2D3E41E1A96@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTIwIGF0IDEyOjQ5ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEJhbGJpciwNCj4gDQo+ICJTaW5naCwgQmFsYmlyIiA8c2JsYmlyQGFtYXpvbi5jb20+IHdy
aXRlczoNCj4gPiBPbiBUaHUsIDIwMjAtMDMtMTkgYXQgMDE6MzggKzAxMDAsIFRob21hcyBHbGVp
eG5lciB3cm90ZToNCj4gPiA+IFdoYXQncyB0aGUgcG9pbnQ/IFRoZSBhdHRhY2sgc3VyZmFjZSBp
cyB0aGUgTDFEIGNvbnRlbnQgb2YgdGhlIHNjaGVkdWxlZA0KPiA+ID4gb3V0IHRhc2suIElmIHRo
ZSBtYWxpY2lvdXMgdGFzayBzY2hlZHVsZXMgb3V0LCB0aGVuIHdoeSB3b3VsZCB5b3UgY2FyZT8N
Cj4gPiA+IA0KPiA+ID4gSSBtaWdodCBiZSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IEFGQUlDVCB0
aGlzIGlzIGJleW9uZCBwYXJhbm9pYS4NCj4gPiA+IA0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlcmUg
YXJlIHR3byBjYXNlcw0KPiA+IA0KPiA+IDEuIFRhc2sgd2l0aCBpbXBvcnRhbnQgZGF0YSBzY2hl
ZHVsZXMgb3V0DQo+ID4gMi4gTWFsaWNpb3VzIHRhc2sgc2NoZWR1bGVzIGluDQo+ID4gDQo+ID4g
VGhlc2UgcGF0Y2hlcyBhZGRyZXNzIDEsIGJ1dCBjYWxsIG91dCBjYXNlICMyDQo+IA0KPiBUaGUg
cG9pbnQgaXMgaWYgdGhlIHZpY3RpbSB0YXNrIHNjaGVkdWxlcyBvdXQsIHRoZW4gdGhlcmUgaXMg
bm8gcmVhc29uDQo+IHRvIGZsdXNoIEwxRCBpbW1lZGlhdGVseSBpbiBjb250ZXh0IHN3aXRjaC4g
SWYgdGhhdCBqdXN0IHNjaGVkdWxlcyBhDQo+IGtlcm5lbCB0aHJlYWQgYW5kIHRoZW4gZ29lcyBi
YWNrIHRvIHRoZSB0YXNrLCB0aGVuIHRoZXJlIGlzIG5vIHBvaW50DQo+IHVubGVzcyB5b3UgZG8g
bm90IGV2ZW4gdHJ1c3QgdGhlIGtlcm5lbCB0aHJlYWQuDQoNCkEgc3dpdGNoIHRvIGEga2VybmVs
IHRocmVhZCB3aWxsIG5vdCBjYWxsIHN3aXRjaF9tbSwgd2lsbCBpdCA/IEF0IGxlYXN0IGl0IHVz
ZWQgbm90IHRvLi4uDQoNCj4gPiA+ID4gMy4gVGhlcmUgaXMgYSBmYWxsYmFjayBzb2Z0d2FyZSBM
MUQgbG9hZCwgc2ltaWxhciB0byB3aGF0IEwxVEYgZG9lcywgYnV0DQo+ID4gPiA+ICAgICB3ZSBk
b24ndCBwcmVmZXRjaCB0aGUgVExCLCBpcyB0aGF0IHN1ZmZpY2llbnQ/DQo+ID4gPiANCj4gPiA+
IElmIHdlIGdvIHRoZXJlLCB0aGVuIHRoZSBLVk0gTDFEIGZsdXNoIGNvZGUgd2FudHMgdG8gbW92
ZSBpbnRvIGdlbmVyYWwNCj4gPiA+IHg4NiBjb2RlLg0KPiA+IA0KPiA+IE9LLi4gd2UgY2FuIGRl
ZmluaXRlbHkgY29uc2lkZXIgcmV1c2luZyBjb2RlLCBidXQgSSB0aGluayB0aGUgS1ZNIGJpdHMg
cmVxdWlyZQ0KPiA+IHRsYiBwcmVmZXRjaGluZywgSUlVQyBiZWZvcmUgY2FjaGUgZmx1c2ggdG8g
bmVnYXRlIGFueSBiYWQgdHJhbnNsYXRpb25zDQo+ID4gYXNzb2NpYXRlZCB3aXRoIGFuIEwxVEYg
ZmF1bHQsIGJ1dCB0aGUgY29kZS9jb21tZW50cyBhcmUgbm90IGNsZWFyIG9uIHRoZSBuZWVkDQo+
ID4gdG8gZG8gc28uDQo+IA0KPiBJIGZvcmdvdCB0aGUgZ29yeSBkZXRhaWxzIGJ5IG5vdywgYnV0
IGhhdmluZyB0d28gZW50cnkgcG9pbnRzIG9yIGENCj4gY29uZGl0aW9uYWwgYW5kIHNoYXJlIHRo
ZSByZXN0IChwYWdlIGFsbG9jYXRpb24gZXRjLikgaXMgZGVmaW5pdGVseQ0KPiBiZXR0ZXIgdGhh
biB0d28gc2xpZ2h0bHkgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uIHdoaWNoIGJhc2ljYWxseSBk
byB0aGUgc2FtZSB0aGluZy4NCj4gDQo+ID4gPiA+ICt2b2lkIGVuYWJsZV9sMWRfZmx1c2hfZm9y
X3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAg
IHN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIGlmIChzdGF0aWNf
Y3B1X2hhcyhYODZfRkVBVFVSRV9GTFVTSF9MMUQpKQ0KPiA+ID4gPiArICAgICAgICAgICAgIGdv
dG8gZG9uZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBtdXRleF9sb2NrKCZsMWRfZmx1c2hf
bXV0ZXgpOw0KPiA+ID4gPiArICAgICBpZiAobDFkX2ZsdXNoX3BhZ2VzKQ0KPiA+ID4gPiArICAg
ICAgICAgICAgIGdvdG8gZG9uZTsNCj4gPiA+ID4gKyAgICAgLyoNCj4gPiA+ID4gKyAgICAgICog
VGhlc2UgcGFnZXMgYXJlIG5ldmVyIGZyZWVkLCB3ZSB1c2UgdGhlIHNhbWUNCj4gPiA+ID4gKyAg
ICAgICogc2V0IG9mIHBhZ2VzIGFjcm9zcyBtdWx0aXBsZSBwcm9jZXNzZXMvY29udGV4dHMNCj4g
PiA+ID4gKyAgICAgICovDQo+ID4gPiA+ICsgICAgIHBhZ2UgPSBhbGxvY19wYWdlcyhHRlBfS0VS
TkVMIHwgX19HRlBfWkVSTywgTDFEX0NBQ0hFX09SREVSKTsNCj4gPiA+ID4gKyAgICAgaWYgKCFw
YWdlKQ0KPiA+ID4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAgICBsMWRfZmx1c2hfcGFnZXMgPSBwYWdlX2FkZHJlc3MocGFnZSk7DQo+ID4gPiA+ICsgICAg
IC8qIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byB3b3JyeSBhYm91dCBLU00gKi8NCj4gPiA+IA0K
PiA+ID4gV2h5IG5vdD8gRXZlbiBpZiBpdCB3b3VsZG4ndCBiZSBuZWNlc3Nhcnkgd2h5IHdvdWxk
IHdlIGNhcmUgYXMgdGhpcyBpcyBhDQo+ID4gPiBvbmNlIHBlciBib290IG9wZXJhdGlvbiBpbiBm
dWxseSBwcmVlbXB0aWJsZSBjb2RlLg0KPiA+IA0KPiA+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB5
b3VyIHF1ZXN0aW9uLCBJIHdhcyBzdGF0aW5nIHRoYXQgZXZlbiBpZiBLU00gd2FzDQo+ID4gcnVu
bmluZywgaXQgd291bGQgbm90IGltcGFjdCB1cyAod2l0aCBkZWR1cCksIGFzIHdlJ2Qgc3RpbGwg
YmUgd3JpdGluZyBvdXQgMHMNCj4gPiB0byB0aGUgY2FjaGUgbGluZSBpbiB0aGUgZmFsbGJhY2sg
Y2FzZS4NCj4gDQo+IEkgcHJvYmFibHkgY29uZnVzZWQgbXlzZWxmIHZzLiB0aGUgY29tbWVudCBp
biB0aGUgVk1YIGNvZGUsIGJ1dCB0aGF0DQo+IG1lbnRpb25zIG5lc3RlZCB2aXJ0LiBOZWVkcyBh
dCBsZWFzdCBzb21lIGNvbnNpZGVyYXRpb24gd2hlbiB3ZSByZXVzZQ0KPiB0aGF0IGNvZGUuDQo+
IA0KPiA+ID4gPiAgIHZvaWQgc3dpdGNoX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsIHN0cnVj
dCBtbV9zdHJ1Y3QgKm5leHQsDQo+ID4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IHRhc2tfc3Ry
dWN0ICp0c2spDQo+ID4gPiA+ICAgew0KPiA+ID4gPiBAQCAtNDMzLDYgKzUxOSw4IEBAIHZvaWQg
c3dpdGNoX21tX2lycXNfb2ZmKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsIHN0cnVjdA0KPiA+ID4g
PiBtbV9zdHJ1Y3QgKm5leHQsDQo+ID4gPiA+ICAgICAgICAgICAgICAgIHRyYWNlX3RsYl9mbHVz
aF9yY3VpZGxlKFRMQl9GTFVTSF9PTl9UQVNLX1NXSVRDSCwgMCk7DQo+ID4gPiA+ICAgICAgICB9
DQo+ID4gPiA+IA0KPiA+ID4gPiArICAgICBsMWRfZmx1c2gobmV4dCwgdHNrKTsNCj4gPiA+IA0K
PiA+ID4gVGhpcyBpcyByZWFsbHkgdGhlIHdyb25nIHBsYWNlLiBZb3Ugd2FudCB0byBkbyB0aGF0
Og0KPiA+ID4gDQo+ID4gPiAgICAxKSBKdXN0IGJlZm9yZSByZXR1cm4gdG8gdXNlciBzcGFjZQ0K
PiA+ID4gICAgMikgV2hlbiBlbnRlcmluZyBhIGd1ZXN0DQo+ID4gPiANCj4gPiA+IGFuZCBvbmx5
IHdoZW4gdGhlIHByZXZpb3VzbHkgcnVubmluZyB1c2VyIHNwYWNlIHRhc2sgd2FzIHRoZSBvbmUg
d2hpY2gNCj4gPiA+IHJlcXVlc3RlZCB0aGlzIG1hc3NpdmUgcHJvdGVjdGlvbi4NCj4gPiA+IA0K
PiA+IA0KPiA+IENhc2VzIDEgYW5kIDIgYXJlIGhhbmRsZWQgdmlhDQo+ID4gDQo+ID4gMS4gU1dB
UEdTIGZpeGVzL3dvcmsgYXJvdW5kcyAodW5sZXNzIEkgbWlzdW5kZXJzdG9vZCB5b3VyIHN1Z2dl
c3Rpb24pDQo+IA0KPiBIb3cgc28/IFNXQVBHUyBtaXRpZ2F0aW9uIGRvZXMgbm90IGZsdXNoIEwx
RC4gSXQgbWVyaWx5IHNlcmlhbGl6ZXMgU1dBUEdTLg0KDQo+ID4gMi4gTDFURiBmYXVsdCBoYW5k
bGluZw0KPiA+IA0KPiA+IFRoaXMgbWVjaGFuaXNtIGFsbG93cyBmb3IgZmx1c2hpbmcgbm90IHJl
c3RyaWN0ZWQgdG8gMSBvciAyLCB0aGUgaWRlYSBpcyB0bw0KPiA+IGltbWVkaWF0ZWx5IGZsdXNo
IEwxRCBmb3IgcGFyYW5vaWQgcHJvY2Vzc2VzIG9uIG1tIHN3aXRjaC4NCj4gDQo+IFdoeT8gVG8g
cHJvdGVjdCB0aGUgdmljdGltIHRhc2sgYWdhaW5zdCB0aGUgbWFsaWNpb3VzIGtlcm5lbD8NCg0K
TW9zdGx5IG1hbGljaW91cyBvdGhlciB0YXNrcyBmb3IgdXMuIEFzIEkgc2FpZCwgSSBkb24ndCB0
aGluayBzd2l0Y2hfbW0NCmlzIGNhbGxlZCBvbiBzd2l0Y2hpbmcgdG8gYSBrZXJuZWwgdGhyZWFk
IGFuZCBpcyBkZWZpbml0ZWx5IGEgY29sZGVyDQpwYXRoIHRoYW4gdGhlIHJldHVybiB0byB1c2Vy
c3BhY2UsIHNvIGl0IGZlbHQgbGlrZSB0aGUgcmlnaHQgcGxhY2UgdG8NCnB1dCB0aGlzLCBidXQg
SSBkb24ndCBtaW5kIGlmIHlvdSBwcmVmZXIgaXQgZWxzZXdoZXJlIGFzIGxvbmcgYXMgaXQNCmRv
ZXMgdGhlIGpvYiB3aGljaCBpcyB0byBwcmV2ZW50IHRhc2sgQiB0byBzbm9vcCB0YXNrIEEgZGF0
YS4NCg0KPiBUaGUgTDFEIGNvbnRlbnQgb2YgdGhlIHZpY3RpbSBpcyBlbmRhbmdlcmVkIGluIHRo
ZSBmb2xsb3dpbmcgY2FzZToNCj4gDQo+ICAgICB2aWN0aW0gb3V0IC0+IGF0dGFja2VyIGluDQo+
IA0KPiBUaGUgYXR0YWNrZXIgY2FuIGVpdGhlciBydW4gaW4gdXNlciBzcGFjZSBvciBpbiBndWVz
dCBtb2RlLiBTbyB0aGUgZmx1c2gNCj4gaXMgb25seSBpbnRlcmVzdGluZyB3aGVuIHRoZSBhdHRh
Y2tlciBhY3R1YWxseSBnb2VzIGJhY2sgdG8gdXNlciBzcGFjZQ0KPiBvciByZWVudGVycyB0aGUg
Z3Vlc3QuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGlzIGNvbXBsZXRlbHkgdW5pbnRlcmVzdGluZzoN
Cj4gDQo+ICAgICB2aWN0aW0gb3V0IC0+IGtlcm5lbCB0aHJlYWQgaW4vb3V0IC0+IHZpY3RpbSBp
bg0KDQpTdXJlIGJ1dCB3aWxsIHRoYXQgY2FsbCBzd2l0Y2hfbW0gdG8gYmUgY2FsbGVkID8NCg0K
PiBFdmVuIHRoaXMgaXMgdW5pbnRlcmVzdGluZzoNCj4gDQo+ICAgICB2aWN0aW0gaW4gLT4gYXR0
YWNrZXIgaW4gKHN0YXlzIGluIGtlcm5lbCwgZS5nLiB3YWl0cyBmb3IgZGF0YSkgLT4NCj4gICAg
IGF0dGFja2VyIG91dCAtPiB2aWN0aW0gaW4NCg0KSSBkb24ndCBnZXQgdGhpcyAuLi4gaG93IGRv
IHlvdSBnZXQgYXR0YWNrZXJfaW4gd2l0aG91dCB2aWN0aW1fb3V0DQpmaXJzdCA/IEluIHdoaWNo
IGNhc2UgeW91IGhhdmUgYSB2aWN0aW1fb3V0IC0+IGF0dGFja2VyX2luIHRyYW5zaXRpb24NCndo
aWNoIGlzIHdoYXQgd2UgYXJlIHRyeWluZyB0byBwcm90ZWN0Lg0KDQpJIHN0aWxsIHRoaW5rIGZs
dXNoaW5nIHRoZSAiaGlnaCB2YWx1ZSIgcHJvY2VzcyBMMUQgb24gc3dpdGNoX21tIG91dCBpcw0K
dGhlIHdheSB0byBnbyBoZXJlLi4uDQoNCj4gU28gdGhlIHBvaW50IHdoZXJlIHlvdSB3YW50IHRv
IGZsdXNoIGNvbmRpdGlvbmFsbHkgaXMgd2hlbiB0aGUgYXR0YWNrZXINCj4gbGVhdmVzIGtlcm5l
bCBzcGFjZSBlaXRoZXIgdG8gdXNlciBtb2RlIG9yIGd1ZXN0IG1vZGUuDQo+IA0KPiBTbyBpZiB0
aGUgdmljdGltIHNjaGVkdWxlcyBvdXQgaXQgc2V0cyBhIHBlciBjcHUgcmVxdWVzdCB0byBmbHVz
aCBMMUQNCj4gb24gdGhlIGJvcmRlcnMuDQo+IA0KPiBBbmQgdGhlbiB5b3UgaGF2ZSBvbiByZXR1
cm4gdG8gdXNlcjoNCj4gDQo+ICAgICBpZiAodGhpc19jcHVfZmx1c2hfbDFkKCkpDQo+ICAgICAg
ICAgZmx1c2hfbDFkKCkNCj4gDQo+IGFuZCBpbiBrdm06DQo+IA0KPiAgICAgaWYgKHRoaXNfY3B1
X2ZsdXNoX2wxZCgpIHx8IEwxVEZfZmx1c2hfTDFEKQ0KPiAgICAgICAgIGZsdXNoX2wxZCgpDQo+
IA0KPiBUaGUgcmVxdWVzdCBkb2VzOg0KPiANCj4gICAgIGlmICghdGhpc19jcHVfcmVhZChsMWRf
Zmx1c2hfZm9yX3Rhc2spKQ0KPiAgICAgICAgIHRoaXNfY3B1X3dyaXRlKGwxZF9mbHVzaF9mb3Jf
dGFzaywgY3VycmVudCkNCj4gDQo+IFRoZSBjaGVjayBkb2VzOg0KPiANCj4gICAgIHAgPSB0aGlz
X2NwdV9yZWFkKGwxZF9mbHVzaF9mb3JfdGFzayk7DQo+ICAgICBpZiAocCkgew0KPiAgICAgICAg
IHRoaXNfY3B1X3dyaXRlKGwxZF9mbHVzaF9mb3JfdGFzaywgTlVMTCk7DQo+ICAgICAgICAgcmV0
dXJuIHAgIT0gY3VycmVudDsNCj4gICAgIH0NCj4gICAgIHJldHVybiBmYWxzZTsNCj4gDQo+IEht
bT8NCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0KPiANCj4gICAgICAgICAgICAg
ICAgIA0K
