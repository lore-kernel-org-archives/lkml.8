Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C25C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AE920732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aZVaBHnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCWAh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 20:37:56 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:60872 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgCWAhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 20:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584923874; x=1616459874;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=eC6GiOWyrV8K8nGwvhxY8RkctZWCYShOErC7ULjrp2o=;
  b=aZVaBHnSTTsKjUy0AdqF4BefzmzHZrmFhNoTbedGa6jwSQWKNgaPuXeW
   kKCmXRjaYXeht+g/gnZdssQFbuWkCKcwxP7wMECeZKdCPsifTlRlqJppH
   e8V3on6tv1FPJwPY0YmtLUgKhMwpvUpubhRH/EcspaO5m4wv7wPZ7qAEz
   A=;
IronPort-SDR: tnaYsqehyIe+z0lJ0hRwG4DXuUyKiBLC56X6AWCBcvn4B2IZtb+kIlfTvGnSl9v0v5iQNlEpxP
 3r2Kj6DgUCcw==
X-IronPort-AV: E=Sophos;i="5.72,294,1580774400"; 
   d="scan'208";a="22411668"
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Mar 2020 00:37:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id C9F96A2803;
        Mon, 23 Mar 2020 00:37:39 +0000 (UTC)
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Mar 2020 00:37:38 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D21UWB003.ant.amazon.com (10.43.161.212) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 00:37:38 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Mon, 23 Mar 2020 00:37:38 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHV+YNfBeR2nut5dUuur/1Y5KcywKhPGnoAgAFvAYCAAN6oAIAA6NAAgACMiQCAAoXEgA==
Date:   Mon, 23 Mar 2020 00:37:38 +0000
Message-ID: <7f8c5bc895c9f40c443bcb48e4e0e8cb2b4366fe.camel@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com>
         <87imj19o13.fsf@nanos.tec.linutronix.de>
         <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com>
         <8736a3456r.fsf@nanos.tec.linutronix.de>
         <034a2c0e2cc1bb0f4f7ff9a2c5cbdc269a483a71.camel@amazon.com>
         <87d096rpjn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d096rpjn.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.244]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0F95E6E29406C41A725A8C845B8F04F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcywNCg0KT24gU2F0LCAyMDIwLTAzLTIxIGF0IDExOjA1ICswMTAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+IA0KPiANCj4gQmFsYmlyLA0KPiANCj4gIlNpbmdoLCBCYWxiaXIi
IDxzYmxiaXJAYW1hem9uLmNvbT4gd3JpdGVzOg0KPiA+IE9uIEZyaSwgMjAyMC0wMy0yMCBhdCAx
Mjo0OSArMDEwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+ID4gSSBmb3Jnb3QgdGhlIGdv
cnkgZGV0YWlscyBieSBub3csIGJ1dCBoYXZpbmcgdHdvIGVudHJ5IHBvaW50cyBvciBhDQo+ID4g
PiBjb25kaXRpb25hbCBhbmQgc2hhcmUgdGhlIHJlc3QgKHBhZ2UgYWxsb2NhdGlvbiBldGMuKSBp
cyBkZWZpbml0ZWx5DQo+ID4gPiBiZXR0ZXIgdGhhbiB0d28gc2xpZ2h0bHkgZGlmZmVyZW50IGlt
cGxlbWVudGF0aW9uIHdoaWNoIGJhc2ljYWxseSBkbyB0aGUNCj4gPiA+IHNhbWUgdGhpbmcuDQo+
ID4gDQo+ID4gT0ssIEkgY2FuIHRyeSBhbmQgZGVkdXAgdGhlbSB0byB0aGUgZXh0ZW50IHBvc3Np
YmxlLCBidXQgcGxlYXNlIGRvDQo+ID4gcmVtZW1iZXINCj4gPiB0aGF0DQo+ID4gDQo+ID4gMS4g
S1ZNIGlzIHVzdWFsbHkgbG9hZGVkIGFzIGEgbW9kdWxlDQo+ID4gMi4gS1ZNIGlzIG9wdGlvbmFs
DQo+ID4gDQo+ID4gV2UgY2FuIHNoYXJlIGNvZGUsIGJ5IHB1dHRpbmcgdGhlIGNvbW1vbiBiaXRz
IGluIHRoZSBjb3JlIGtlcm5lbC4NCj4gDQo+IE9idmlvdXNseSBzby4NCj4gDQo+ID4gPiA+IDEu
IFNXQVBHUyBmaXhlcy93b3JrIGFyb3VuZHMgKHVubGVzcyBJIG1pc3VuZGVyc3Rvb2QgeW91ciBz
dWdnZXN0aW9uKQ0KPiA+ID4gDQo+ID4gPiBIb3cgc28/IFNXQVBHUyBtaXRpZ2F0aW9uIGRvZXMg
bm90IGZsdXNoIEwxRC4gSXQgbWVyaWx5IHNlcmlhbGl6ZXMNCj4gPiA+IFNXQVBHUy4NCj4gPiAN
Cj4gPiBTb3JyeSwgbXkgYmFkLCBJIHdhcyB0aGlua2luZyBNRFNfQ0xFQVIgKHZpYSB2ZXJ3KSwg
d2hpY2ggZG9lcyBmbHVzaCBvdXQNCj4gPiB0aGluZ3MsIHdoaWNoIEkgc3VzcGVjdCBzaG91bGQg
YmUgc3VmZmljaWVudCBmcm9tIGEgcmV0dXJuIHRvIHVzZXIvc2lnbmFsDQo+ID4gaGFuZGxpbmcs
IGV0YyBwZXJzcGVjdGl2ZS4NCj4gDQo+IE1EUyBpcyBhZmZlY3Rpbmcgc3RvcmUgYnVmZmVycywg
ZmlsbCBidWZmZXJzIGFuZCBsb2FkIHBvcnRzLiBEaWZmZXJlbnQNCj4gc3RvcnkuDQo+IA0KDQpZ
ZXMsIHdoYXQgZ2V0cyBtZSBpcyB0aGF0IGFzIHBlciAoDQpodHRwczovL3NvZnR3YXJlLmludGVs
LmNvbS9zZWN1cml0eS1zb2Z0d2FyZS1ndWlkYW5jZS9pbnNpZ2h0cy9kZWVwLWRpdmUtaW50ZWwt
YW5hbHlzaXMtbWljcm9hcmNoaXRlY3R1cmFsLWRhdGEtc2FtcGxpbmcNCikgaXQgc2F5cywgIlRo
ZSBWRVJXIGluc3RydWN0aW9uIGFuZCBMMURfRkxVU0ggY29tbWFuZCB3aWxsIG92ZXJ3cml0ZSB0
aGUNCnN0b3JlIGJ1ZmZlciB2YWx1ZSBmb3IgdGhlIGN1cnJlbnQgbG9naWNhbCBwcm9jZXNzb3Ig
b24gcHJvY2Vzc29ycyBhZmZlY3RlZCBieQ0KTVNCRFMiLiBJbiBteSBtaW5kLCB0aGlzIG1ha2Vz
IFZFUlcgdGhlIHNhbWUgYXMgTDFEX0ZMVVNIIGFuZCBoZW5jZSB0aGUNCmFzc3VtcHRpb24sIGl0
IGNvdWxkIGJlIHRoYXQgTDFEX0ZMVVNIIGlzIGEgc3VwZXJzZXQsIGJ1dCBpdCdzIG5vdCBjbGVh
ciBhbmQgSQ0KY2FuJ3Qgc2VlbSB0byBmaW5kIGFueSBvdGhlciBmb3JtIG9mIGRvY3VtZW50YXRp
b24gb24gdGhlIE1TUnMgYW5kIG1pY3JvY29kZS4NCg0KPiA+IFJpZ2h0IG5vdywgcmVhZGluZyB0
aHJvdWdoDQo+ID4gDQpodHRwczovL3NvZnR3YXJlLmludGVsLmNvbS9zZWN1cml0eS1zb2Z0d2Fy
ZS1ndWlkYW5jZS9pbnNpZ2h0cy9kZWVwLWRpdmUtc25vb3AtYXNzaXN0ZWQtbDEtZGF0YS1zYW1w
bGluZw0KPiA+ICwgaXQgZG9lcyBzZWVtIGxpa2Ugd2UgbmVlZCB0aGlzIGR1cmluZyBhIGNvbnRl
eHQgc3dpdGNoLCBzcGVjaWZpY2FsbHkNCj4gPiBzaW5jZSBhDQo+ID4gZGlydHkgY2FjaGUgbGlu
ZSBjYW4gY2F1c2Ugc25vb3BlZCByZWFkcyBmb3IgdGhlIGF0dGFja2VyIHRvIGxlYWsgZGF0YS4g
QW0NCj4gPiBJDQo+ID4gbWlzc2luZyBhbnl0aGluZz8NCj4gDQo+IFllcy4gVGhlIHdheSB0aGlz
IGdvZXMgaXM6DQo+IA0KPiBDUFUwICAgICAgICAgICAgICAgICAgIENQVTENCj4gDQo+IHZpY3Rp
bTENCj4gIHN0b3JlIHNlY3JpdA0KPiAgICAgICAgICAgICAgICAgICAgICAgICB2aWN0aW0yDQo+
IGF0dGFja2VyICAgICAgICAgICAgICAgICAgcmVhZCBzZWNyaXQNCj4gDQo+IE5vdyBpZiBMMUQg
aXMgZmx1c2hlZCBvbiBDUFUwIGJlZm9yZSBhdHRhY2tlciByZWFjaGVzIHVzZXIgc3BhY2UsDQo+
IGkuZS4gcmVhY2hlcyB0aGUgYXR0YWNrIGNvZGUsIHRoZW4gdGhlcmUgaXMgbm90aGluZyB0byBz
ZWUuIEZyb20gdGhlDQo+IGxpbms6DQo+IA0KPiAgIFNpbWlsYXIgdG8gdGhlIEwxVEYgVk1NIG1p
dGlnYXRpb25zLCBzbm9vcC1hc3Npc3RlZCBMMUQgc2FtcGxpbmcgY2FuIGJlDQo+ICAgbWl0aWdh
dGVkIGJ5IGZsdXNoaW5nIHRoZSBMMUQgY2FjaGUgYmV0d2VlbiB3aGVuIHNlY3JldHMgYXJlIGFj
Y2Vzc2VkDQo+ICAgYW5kIHdoZW4gcG9zc2libHkgbWFsaWNpb3VzIHNvZnR3YXJlIHJ1bnMgb24g
dGhlIHNhbWUgY29yZS4NCj4gDQo+IFNvIHRoZSBpbXBvcnRhbnQgcG9pbnQgaXMgdG8gZmx1c2gg
X2JlZm9yZV8gdGhlIGF0dGFjayBjb2RlIHJ1bnMgd2hpY2gNCj4gaW52b2x2ZXMgZ29pbmcgYmFj
ayB0byB1c2VyIHNwYWNlIG9yIGd1ZXN0IG1vZGUuDQoNCkkgdGhpbmsgdGhlcmUgaXMgYSBtb3Jl
IGdlbmVyaWMgY2FzZSB3aXRoIEhUIHlvdSd2ZSBoaWdobGlnaHRlZCBiZWxvdw0KDQo+IA0KPiA+
ID4gRXZlbiB0aGlzIGlzIHVuaW50ZXJlc3Rpbmc6DQo+ID4gPiANCj4gPiA+ICAgICB2aWN0aW0g
aW4gLT4gYXR0YWNrZXIgaW4gKHN0YXlzIGluIGtlcm5lbCwgZS5nLiB3YWl0cyBmb3IgZGF0YSkg
LT4NCj4gPiA+ICAgICBhdHRhY2tlciBvdXQgLT4gdmljdGltIGluDQo+ID4gPiANCj4gPiANCj4g
PiBOb3QgZnJvbSB3aGF0IEkgdW5kZXJzdGFuZCBmcm9tIHRoZSBsaW5rIGFib3ZlLCB0aGUgYXR0
YWNrIGlzIGEgZnVuY3Rpb24NCj4gPiBvZg0KPiA+IHdoYXQgY2FuIGJlIHNub29wZWQgYnkgYW5v
dGhlciBjb3JlL3RocmVhZCBhbmQgdGhhdCBpcyBhIGZ1bmN0aW9uIG9mIHdoYXQNCj4gPiBtb2Rp
ZmllZCBzZWNyZXRzIGFyZSBpbiB0aGUgY2FjaGUgbGluZS9zdG9yZSBidWZmZXIuDQo+IA0KPiBG
b3JnZXQgSFQuIFRoYXQncyBub3QgZml4YWJsZSBieSBhbnkgZmx1c2hpbmcgc2ltcGx5IGJlY2F1
c2UgdGhlcmUgaXMgbm8NCj4gc2NoZWR1bGluZyBpbnZvbHZlZC4NCj4gDQo+IENQVTAgIEhUMCAg
ICAgICAgICBDUFUwIEhUMSAgICAgICAgICAgICBDUFUxDQo+IA0KPiB2aWN0aW0xICAgICAgICAg
ICAgYXR0YWNrZXINCj4gIHN0b3JlIHNlY3JpdA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdmljdGltMg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZWFkIHNlY3JpdA0KPiANCj4gPiBPbiByZXR1cm4gdG8gdXNlciwgd2UgYWxy
ZWFkeSB1c2UgVkVSVyAodmVydyksIGJ1dCBqdXN0IHJldHVybiB0byB1c2VyDQo+ID4gcHJvdGVj
dGlvbiBpcyBub3Qgc3VmZmljaWVudCBJTUhPLiBCYXNlZCBvbiB0aGUgbGluayBhYm92ZSwgd2Ug
bmVlZCB0bw0KPiA+IGNsZWFyDQo+ID4gdGhlIEwxRCBjYWNoZSBiZWZvcmUgaXQgY2FuIGJlIHNu
b29wZWQuDQo+IA0KPiBBZ2Fpbi4gRmx1c2ggaXMgcmVxdWlyZWQgYmV0d2VlbiBzdG9yZSBhbmQg
YXR0YWNrZXIgcnVubmluZyBhdHRhY2sNCj4gY29kZS4gVGhlIGF0dGFja2VyIF9jYW5ub3RfIHJ1
biBhdHRhY2sgY29kZSB3aGlsZSBpdCBpcyBpbiB0aGUga2VybmVsIHNvDQo+IGZsdXNoaW5nIEwx
RCBvbiBjb250ZXh0IHN3aXRjaCBpcyBqdXN0IHZvb2Rvby4NCj4gDQo+IElmIHlvdSB3YW50IHRv
IGN1cmUgdGhlIEhUIGNhc2Ugd2l0aCBjb3JlIHNjaGVkdWxpbmcgdGhlbiB0aGUgc2NlbmFyaW8N
Cj4gbG9va3MgbGlrZSB0aGlzOg0KPiANCj4gQ1BVMCAgSFQwICAgICAgICAgIENQVTAgSFQxICAg
ICAgICAgICAgIENQVTENCj4gDQo+IHZpY3RpbTEgICAgICAgICAgICBJRExFDQo+ICBzdG9yZSBz
ZWNyaXQNCj4gLT4gSURMRQ0KPiAgICAgICAgICAgICAgICAgICAgYXR0YWNrZXIgaW4gICAgICAg
ICAgdmljdGltMg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZWFkIHNlY3JpdA0KPiANCj4gQW5kIHllcywgdGhlcmUgdGhlIGNvbnRleHQgc3dpdGNoIGZsdXNo
IG9uIEhUMCBwcmV2ZW50cyBpdC4gU28gdGhpcyBjYW4NCj4gYmUgcGFydCBvZiBhIGNvcmUgc2No
ZWR1bGluZyBiYXNlZCBtaXRpZ2F0aW9uIG9yIGhhbmRsZWQgdmlhIGEgcGVyIGNvcmUNCj4gZmx1
c2ggcmVxdWVzdC4NCj4gDQo+IEJ1dCBIVCBpcyBhdHRhY2thYmxlIGluIHNvIG1hbnkgd2F5cyAu
Li4NCg0KSSB0aGluayB0aGUgcmVhc29uIHlvdSBwcmVmZXIgZXhpdCB0byB1c2VyIGFzIG9wcG9z
ZWQgdG8gc3dpdGNoX21tIChzd2l0Y2hpbmcNCnRhc2sgZ3JvdXBzL3RocmVhZHMpIGlzIHRoYXQg
aXQncyBsb3dlciBvdmVyaGVhZCwgdGhlIHJlYXNvbiBJIHByZWZlciBzd2l0Y2gNCm1tIGlzIA0K
DQoxLiBUaGUgb3ZlcmhlYWQgaXMgbm90IGZvciBhbGwgdGFza3MsIHRoZSBzZWxlY3Rpb24gb2Yg
TDFEIGZsdXNoIGlzIG9wdGlvbmFsDQoyLiBJdCdzIG1vcmUgZ2VuZXJpYyBhbmQgZG9lcyBub3Qg
bWFrZSBzcGVjaWZpYyBhc3N1bXB0aW9ucw0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAg
ICAgdGdseA0KDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldywNCkJhbGJpciBTaW5naC4NCg==
