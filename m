Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029AC2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OeRNBDYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgENV25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:28:57 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:57470 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgENV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589491736; x=1621027736;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Yezbi7AQfUMT0qNCPnMZ02HTQsMDXfrnbbka4Wj1wNY=;
  b=OeRNBDYXsMRXUtI4rsZATK9N5/Mno5ruqpYPcbLb0QvSPmMGkB2xRzQ7
   dCmma5nGH9ZSCF20eLr8YxoNjO0KxYO1R13gDpWMjveahX+QchSWly4BL
   jMPGLH4cPzMkB30pvU8jXKRoPtoDt3ldSnJgIvGH2zQgCtEP6+u/3Qr9J
   s=;
IronPort-SDR: t5l9s8uzYvtD6Vka3vUgGf4wNKI7p32r07c569rdZmpjzjwBLgHPVv4IpskNmqv2iyc8IaPrp8
 cvZeYYmhYAMQ==
X-IronPort-AV: E=Sophos;i="5.73,392,1583193600"; 
   d="scan'208";a="30471394"
Subject: Re: [PATCH v6 5/6] Optionally flush L1D on context switch
Thread-Topic: [PATCH v6 5/6] Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 14 May 2020 21:28:43 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 8C945A238F;
        Thu, 14 May 2020 21:28:39 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 21:28:38 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 21:28:38 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 14 May 2020 21:28:38 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWJm0VV4Hzu4vjckmHwrAVGGHnm6imKUmAgAH3HoA=
Date:   Thu, 14 May 2020 21:28:38 +0000
Message-ID: <6f8299db4170800e9db5b0b7da663e3cf6c5fec5.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
         <20200510014803.12190-6-sblbir@amazon.com>
         <878shv3ldy.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878shv3ldy.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.140]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75863FDFF49CCB4EA870DAD3B7BA9A89@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE3OjI3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8NCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyDQo+IGFuZCBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+IA0KPiANCj4gDQo+IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5jb20+IHdy
aXRlczoNCj4gDQo+ID4gSW1wbGVtZW50IGEgbWVjaGFuaXNtIHRvIHNlbGVjdGl2ZWx5IGZsdXNo
IHRoZSBMMUQgY2FjaGUuIFRoZSBnb2FsDQo+ID4gaXMgdG8NCj4gPiBhbGxvdyB0YXNrcyB0aGF0
IGFyZSBwYXJhbm9pZCBkdWUgdG8gdGhlIHJlY2VudCBzbm9vcCBhc3Npc3RlZCBkYXRhDQo+ID4g
c2FtcGxpbmcNCj4gPiB2dWxuZXJhYmlsaXRlcywgdG8gZmx1c2ggdGhlaXIgTDFEIG9uIGJlaW5n
IHN3aXRjaGVkIG91dC4gIFRoaXMNCj4gPiBwcm90ZWN0cw0KPiA+IHRoZWlyIGRhdGEgZnJvbSBi
ZWluZyBzbm9vcGVkIG9yIGxlYWtlZCB2aWEgc2lkZSBjaGFubmVscyBhZnRlciB0aGUNCj4gPiB0
YXNrDQo+ID4gaGFzIGNvbnRleHQgc3dpdGNoZWQgb3V0Lg0KPiA+IA0KPiA+IFRoZXJlIGFyZSB0
d28gc2NlbmFyaW9zIHdlIG1pZ2h0IHdhbnQgdG8gcHJvdGVjdCBhZ2FpbnN0LCBhIHRhc2sNCj4g
PiBsZWF2aW5nDQo+ID4gdGhlIENQVSB3aXRoIGRhdGEgc3RpbGwgaW4gTDFEICh3aGljaCBpcyB0
aGUgbWFpbiBjb25jZXJuIG9mIHRoaXMNCj4gPiBwYXRjaCksDQo+ID4gdGhlIHNlY29uZCBzY2Vu
YXJpbyBpcyBhIG1hbGljaW91cyB0YXNrIGNvbWluZyBpbiAobm90IHNvIHdlbGwNCj4gPiB0cnVz
dGVkKQ0KPiA+IGZvciB3aGljaCB3ZSB3YW50IHRvIGNsZWFuIHVwIHRoZSBjYWNoZSBiZWZvcmUg
aXQgc3RhcnRzLiBPbmx5IHRoZQ0KPiA+IGNhc2UNCj4gPiBmb3IgdGhlIGZvcm1lciBpcyBhZGRy
ZXNzZWQuDQo+ID4gDQo+ID4gQSBuZXcgdGhyZWFkX2luZm8gZmxhZyBUSUZfU1BFQ19GTFVTSF9M
MUQgaXMgYWRkZWQgdG8gdHJhY2sgdGFza3MNCj4gPiB3aGljaA0KPiA+IG9wdC1pbnRvIEwxRCBm
bHVzaGluZy4gY3B1X3RsYnN0YXRlLmxhc3RfdXNlcl9tbV9zcGVjIGlzIHVzZWQgdG8NCj4gPiBj
b252ZXJ0DQo+ID4gdGhlIFRJRiBmbGFncyBpbnRvIG1tIHN0YXRlIChwZXIgY3B1IHZpYSBsYXN0
X3VzZXJfbW1fc3BlYykgaW4NCj4gPiBjb25kX21pdGlnYXRpb24oKSwgd2hpY2ggdGhlbiB1c2Vk
IHRvIGRvIGRlY2lkZSB3aGVuIHRvIGNhbGwNCj4gPiBmbHVzaF9sMWQoKS4NCj4gPiANCj4gPiBB
ZGQgcHJjdGwoKSdzIHRvIG9wdC1pbiB0byB0aGUgTDFEIGNhY2hlIG9uIGNvbnRleHQgc3dpdGNo
IG91dCwgdGhlDQo+ID4gZXhpc3RpbmcgbWVjaGFuaXNtcyBvZiB0cmFja2luZyBwcmV2X21tIHZp
YSBjcHVfdGxic3RhdGUgaXMNCj4gPiByZXVzZWQgdG8gdHJhY2sgc3RhdGUgb2YgdGhlIHRhc2tz
IGFuZCB0byBmbHVzaCB0aGUgTDFEIGNhY2hlLg0KPiA+IFRoZSBwcmN0bCBpbnRlcmZhY2UgaXMg
Z2VuZXJpYyBhbmQgY2FuIGJlIHBvcnRlZCBvdmVyIHRvIG90aGVyDQo+ID4gYXJjaGl0ZWN0dXJl
cy4NCj4gPiANCj4gPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJv
bml4LmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oIHwgIDcgKysr
Ky0NCj4gPiAgYXJjaC94ODYvbW0vdGxiLmMgICAgICAgICAgICAgICAgICB8IDQ0DQo+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGluY2x1ZGUvdWFwaS9saW51eC9wcmN0
bC5oICAgICAgICAgfCAgNCArKysNCj4gPiAga2VybmVsL3N5cy5jICAgICAgICAgICAgICAgICAg
ICAgICB8IDIwICsrKysrKysrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaA0KPiA+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGhy
ZWFkX2luZm8uaA0KPiA+IGluZGV4IDhkZThjZWNjYjhiYy4uNjdkZTY5M2Q5YmExIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCj4gPiArKysgYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oDQo+ID4gQEAgLTg0LDcgKzg0LDcgQEAg
c3RydWN0IHRocmVhZF9pbmZvIHsNCj4gPiAgI2RlZmluZSBUSUZfU1lTQ0FMTF9BVURJVCAgICA3
ICAgICAgIC8qIHN5c2NhbGwgYXVkaXRpbmcgYWN0aXZlICovDQo+ID4gICNkZWZpbmUgVElGX1NF
Q0NPTVAgICAgICAgICAgOCAgICAgICAvKiBzZWN1cmUgY29tcHV0aW5nICovDQo+ID4gICNkZWZp
bmUgVElGX1NQRUNfSUIgICAgICAgICAgOSAgICAgICAvKiBJbmRpcmVjdCBicmFuY2ggc3BlY3Vs
YXRpb24NCj4gPiBtaXRpZ2F0aW9uICovDQo+ID4gLSNkZWZpbmUgVElGX1NQRUNfRk9SQ0VfVVBE
QVRFICAgICAgICAxMCAgICAgIC8qIEZvcmNlIHNwZWN1bGF0aW9uDQo+ID4gTVNSIHVwZGF0ZSBp
biBjb250ZXh0IHN3aXRjaCAqLw0KPiA+ICsjZGVmaW5lIFRJRl9TUEVDX0ZMVVNIX0wxRCAgIDEw
ICAgICAgLyogRmx1c2ggTDFEIG9uIG1tIHN3aXRjaGVzDQo+ID4gKHByb2Nlc3NlcykgKi8NCj4g
PiAgI2RlZmluZSBUSUZfVVNFUl9SRVRVUk5fTk9USUZZICAgICAgIDExICAgICAgLyogbm90aWZ5
IGtlcm5lbCBvZg0KPiA+IHVzZXJzcGFjZSByZXR1cm4gKi8NCj4gPiAgI2RlZmluZSBUSUZfVVBS
T0JFICAgICAgICAgICAxMiAgICAgIC8qIGJyZWFrcG9pbnRlZCBvcg0KPiA+IHNpbmdsZXN0ZXBw
aW5nICovDQo+ID4gICNkZWZpbmUgVElGX1BBVENIX1BFTkRJTkcgICAgMTMgICAgICAvKiBwZW5k
aW5nIGxpdmUgcGF0Y2hpbmcNCj4gPiB1cGRhdGUgKi8NCj4gPiBAQCAtOTYsNiArOTYsNyBAQCBz
dHJ1Y3QgdGhyZWFkX2luZm8gew0KPiA+ICAjZGVmaW5lIFRJRl9NRU1ESUUgICAgICAgICAgIDIw
ICAgICAgLyogaXMgdGVybWluYXRpbmcgZHVlIHRvIE9PTQ0KPiA+IGtpbGxlciAqLw0KPiA+ICAj
ZGVmaW5lIFRJRl9QT0xMSU5HX05SRkxBRyAgIDIxICAgICAgLyogaWRsZSBpcyBwb2xsaW5nIGZv
cg0KPiA+IFRJRl9ORUVEX1JFU0NIRUQgKi8NCj4gPiAgI2RlZmluZSBUSUZfSU9fQklUTUFQICAg
ICAgICAgICAgICAgIDIyICAgICAgLyogdXNlcyBJL08gYml0bWFwICovDQo+ID4gKyNkZWZpbmUg
VElGX1NQRUNfRk9SQ0VfVVBEQVRFICAgICAgICAyMyAgICAgIC8qIEZvcmNlIHNwZWN1bGF0aW9u
DQo+ID4gTVNSIHVwZGF0ZSBpbiBjb250ZXh0IHN3aXRjaCAqLw0KPiA+ICAjZGVmaW5lIFRJRl9G
T1JDRURfVEYgICAgICAgICAgICAgICAgMjQgICAgICAvKiB0cnVlIGlmIFRGIGluDQo+ID4gZWZs
YWdzIGFydGlmaWNpYWxseSAqLw0KPiA+ICAjZGVmaW5lIFRJRl9CTE9DS1NURVAgICAgICAgICAg
ICAgICAgMjUgICAgICAvKiBzZXQgd2hlbiB3ZSB3YW50DQo+ID4gREVCVUdDVExNU1JfQlRGICov
DQo+ID4gICNkZWZpbmUgVElGX0xBWllfTU1VX1VQREFURVMgMjcgICAgICAvKiB0YXNrIGlzIHVw
ZGF0aW5nIHRoZSBtbXUNCj4gPiBsYXppbHkgKi8NCj4gPiBAQCAtMTMyLDYgKzEzMyw3IEBAIHN0
cnVjdCB0aHJlYWRfaW5mbyB7DQo+ID4gICNkZWZpbmUgX1RJRl9BRERSMzIgICAgICAgICAgKDEg
PDwgVElGX0FERFIzMikNCj4gPiAgI2RlZmluZSBfVElGX1gzMiAgICAgICAgICAgICAoMSA8PCBU
SUZfWDMyKQ0KPiA+ICAjZGVmaW5lIF9USUZfRlNDSEVDSyAgICAgICAgICgxIDw8IFRJRl9GU0NI
RUNLKQ0KPiA+ICsjZGVmaW5lIF9USUZfU1BFQ19GTFVTSF9MMUQgICgxIDw8IFRJRl9TUEVDX0ZM
VVNIX0wxRCkNCj4gDQo+IEJhaC4gVGhlc2UgZGVmaW5lcyBhcmUgb3JkZXJlZCBpbiB0aGUgc2Ft
ZSB3YXkgYXMgdGhlIFRJRiBkZWZpbmVzLi4uLg0KPiANCj4gPiAgLyoNCj4gPiAtICogQml0cyB0
byBtYW5nbGUgdGhlIFRJRl9TUEVDX0lCIHN0YXRlIGludG8gdGhlIG1tIHBvaW50ZXIgd2hpY2gN
Cj4gPiBpcw0KPiA+ICsgKiBCaXRzIHRvIG1hbmdsZSB0aGUgVElGX1NQRUNfKiBzdGF0ZSBpbnRv
IHRoZSBtbSBwb2ludGVyIHdoaWNoIGlzDQo+ID4gICAqIHN0b3JlZCBpbiBjcHVfdGxiX3N0YXRl
Lmxhc3RfdXNlcl9tbV9zcGVjLg0KPiA+ICAgKi8NCj4gPiAgI2RlZmluZSBMQVNUX1VTRVJfTU1f
SUJQQiAgICAweDFVTA0KPiA+IC0jZGVmaW5lIExBU1RfVVNFUl9NTV9TUEVDX01BU0sgICAgICAg
KExBU1RfVVNFUl9NTV9JQlBCKQ0KPiA+ICsjZGVmaW5lIExBU1RfVVNFUl9NTV9MMURfRkxVU0gg
ICAgICAgMHgyVUwNCj4gPiArI2RlZmluZSBMQVNUX1VTRVJfTU1fU1BFQ19NQVNLICAgICAgIChM
QVNUX1VTRVJfTU1fSUJQQiB8DQo+ID4gTEFTVF9VU0VSX01NX0wxRF9GTFVTSCkNCj4gDQo+IFlv
dSBsb3N0DQo+IA0KPiArICAgICAgIEJVSUxEX0JVR19PTihUSUZfU1BFQ19GTFVTSF9MMUQgIT0g
VElGX1NQRUNfSUIgKyAxKTsNCj4gDQo+IGZyb20gcGF0Y2ggSSBnYXZlIHlvdS4NCg0KDQpPb3Bz
Li4gSSdsbCBmaXggdXAgYm90aCBhbmQgcmVkbyBwYXRjaCA1LzYsIGJ5IHNwbGl0dGluZyBpdCB1
cCwgaW50bw0KaW50ZXJmYWNlIHZzIGZsdXNoIGJpdHMNCg0KVGhhbmtzLA0KQmFsYmlyIFNpbmdo
Lg0K
