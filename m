Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759FBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A46F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Op/JHAlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEDXOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:14:21 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:12896 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588634058; x=1620170058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qxj1UFUyVk0EBluS09TcRYX6lQL6X8g+/NB8vRqEYN4=;
  b=Op/JHAloORuHqwLMMJgDcbmll2jTiSCzuK3mdzcxs0NAij+3lEaS+TDh
   RglLIpaEV5So31yk9UzdSFI3Lc4gngXOwTPWB6lIjlJp7JCB9ZTbulqZg
   eP9I8dPNAaDf3qNibauz6ALR23mzn0XoyW9RmxLtnctrCJAMfyLlAO6fD
   k=;
IronPort-SDR: h3RCabMknRwz+Szcuqd3+0wwXi09c8zhJ2S1vH6VsGwrvIjvU4BAVb5CwDaJQZiv46sywSH7QU
 wd8tgreHeGog==
X-IronPort-AV: E=Sophos;i="5.73,353,1583193600"; 
   d="scan'208";a="28731405"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 04 May 2020 23:14:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 133D6A1DF2;
        Mon,  4 May 2020 23:14:04 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 23:14:03 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 23:14:03 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Mon, 4 May 2020 23:14:03 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re:  [PATCH v5 5/6] Optionally flush L1D on context switch
Thread-Topic: [PATCH v5 5/6] Optionally flush L1D on context switch
Thread-Index: AQHWImmz9cA1utSEl0uwJA78h0j54w==
Date:   Mon, 4 May 2020 23:14:03 +0000
Message-ID: <90f552183ae9e0df1c58789ec7df5c4d1b01c350.camel@amazon.com>
References: <20200504041343.9651-1-sblbir@amazon.com>
         <20200504041343.9651-6-sblbir@amazon.com> <202005041135.764E9DD7@keescook>
In-Reply-To: <202005041135.764E9DD7@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.194]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7EE8DCC8A6173469E0FC7CE673302F1@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTA0IGF0IDExOjM5IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IA0K
PiBPbiBNb24sIE1heSAwNCwgMjAyMCBhdCAwMjoxMzo0MlBNICsxMDAwLCBCYWxiaXIgU2luZ2gg
d3JvdGU6DQo+ID4gSW1wbGVtZW50IGEgbWVjaGFuaXNtIHRvIHNlbGVjdGl2ZWx5IGZsdXNoIHRo
ZSBMMUQgY2FjaGUuIFRoZSBnb2FsDQo+ID4gaXMgdG8NCj4gPiBhbGxvdyB0YXNrcyB0aGF0IGFy
ZSBwYXJhbm9pZCBkdWUgdG8gdGhlIHJlY2VudCBzbm9vcCBhc3Npc3RlZCBkYXRhDQo+ID4gc2Ft
cGxpbmcNCj4gPiB2dWxuZXJhYmlsaXRlcywgdG8gZmx1c2ggdGhlaXIgTDFEIG9uIGJlaW5nIHN3
aXRjaGVkIG91dC4gIFRoaXMNCj4gPiBwcm90ZWN0cw0KPiA+IHRoZWlyIGRhdGEgZnJvbSBiZWlu
ZyBzbm9vcGVkIG9yIGxlYWtlZCB2aWEgc2lkZSBjaGFubmVscyBhZnRlciB0aGUNCj4gPiB0YXNr
DQo+ID4gaGFzIGNvbnRleHQgc3dpdGNoZWQgb3V0Lg0KPiA+IA0KPiA+IFRoZXJlIGFyZSB0d28g
c2NlbmFyaW9zIHdlIG1pZ2h0IHdhbnQgdG8gcHJvdGVjdCBhZ2FpbnN0LCBhIHRhc2sNCj4gPiBs
ZWF2aW5nDQo+ID4gdGhlIENQVSB3aXRoIGRhdGEgc3RpbGwgaW4gTDFEICh3aGljaCBpcyB0aGUg
bWFpbiBjb25jZXJuIG9mIHRoaXMNCj4gPiBwYXRjaCksDQo+ID4gdGhlIHNlY29uZCBzY2VuYXJp
byBpcyBhIG1hbGljaW91cyB0YXNrIGNvbWluZyBpbiAobm90IHNvIHdlbGwNCj4gPiB0cnVzdGVk
KQ0KPiA+IGZvciB3aGljaCB3ZSB3YW50IHRvIGNsZWFuIHVwIHRoZSBjYWNoZSBiZWZvcmUgaXQg
c3RhcnRzLiBPbmx5IHRoZQ0KPiA+IGNhc2UNCj4gPiBmb3IgdGhlIGZvcm1lciBpcyBhZGRyZXNz
ZWQuDQo+ID4gDQo+ID4gQSBuZXcgdGhyZWFkX2luZm8gZmxhZyBUSUZfU1BFQ19GTFVTSF9MMUQg
aXMgYWRkZWQgdG8gdHJhY2sgdGFza3MNCj4gPiB3aGljaA0KPiA+IG9wdC1pbnRvIEwxRCBmbHVz
aGluZy4gY3B1X3RsYnN0YXRlLmxhc3RfdXNlcl9tbV9zcGVjIGlzIHVzZWQgdG8NCj4gPiBjb252
ZXJ0DQo+ID4gdGhlIFRJRiBmbGFncyBpbnRvIG1tIHN0YXRlIChwZXIgY3B1IHZpYSBsYXN0X3Vz
ZXJfbW1fc3BlYykgaW4NCj4gPiBjb25kX21pdGlnYXRpb24oKSwgd2hpY2ggdGhlbiB1c2VkIHRv
IGRvIGRlY2lkZSB3aGVuIHRvIGNhbGwNCj4gPiBmbHVzaF9sMWQoKS4NCj4gPiANCj4gPiBBZGQg
cHJjdGwoKSdzIHRvIG9wdC1pbiB0byB0aGUgTDFEIGNhY2hlIG9uIGNvbnRleHQgc3dpdGNoIG91
dCwgdGhlDQo+ID4gZXhpc3RpbmcgbWVjaGFuaXNtcyBvZiB0cmFja2luZyBwcmV2X21tIHZpYSBj
cHVfdGxic3RhdGUgaXMNCj4gPiByZXVzZWQgdG8gdHJhY2sgc3RhdGUgb2YgdGhlIHRhc2tzIGFu
ZCB0byBmbHVzaCB0aGUgTDFEIGNhY2hlLg0KPiA+IFRoZSBwcmN0bCBpbnRlcmZhY2UgaXMgZ2Vu
ZXJpYyBhbmQgY2FuIGJlIHBvcnRlZCBvdmVyIHRvIG90aGVyDQo+ID4gYXJjaGl0ZWN0dXJlcy4N
Cj4gPiANCj4gPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oIHwgIDcgKysrKy0N
Cj4gPiAgYXJjaC94ODYvbW0vdGxiLmMgICAgICAgICAgICAgICAgICB8IDQ0DQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGluY2x1ZGUvdWFwaS9saW51eC9wcmN0bC5o
ICAgICAgICAgfCAgNCArKysNCj4gPiAga2VybmVsL3N5cy5jICAgICAgICAgICAgICAgICAgICAg
ICB8IDIwICsrKysrKysrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGhyZWFkX2luZm8uaA0KPiA+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGhyZWFk
X2luZm8uaA0KPiA+IGluZGV4IDhkZThjZWNjYjhiYy4uNjdkZTY5M2Q5YmExIDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCj4gPiArKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oDQo+ID4gQEAgLTg0LDcgKzg0LDcgQEAgc3Ry
dWN0IHRocmVhZF9pbmZvIHsNCj4gPiAgI2RlZmluZSBUSUZfU1lTQ0FMTF9BVURJVCAgICA3ICAg
ICAgIC8qIHN5c2NhbGwgYXVkaXRpbmcgYWN0aXZlICovDQo+ID4gICNkZWZpbmUgVElGX1NFQ0NP
TVAgICAgICAgICAgOCAgICAgICAvKiBzZWN1cmUgY29tcHV0aW5nICovDQo+ID4gICNkZWZpbmUg
VElGX1NQRUNfSUIgICAgICAgICAgOSAgICAgICAvKiBJbmRpcmVjdCBicmFuY2ggc3BlY3VsYXRp
b24NCj4gPiBtaXRpZ2F0aW9uICovDQo+ID4gLSNkZWZpbmUgVElGX1NQRUNfRk9SQ0VfVVBEQVRF
ICAgICAgICAxMCAgICAgIC8qIEZvcmNlIHNwZWN1bGF0aW9uDQo+ID4gTVNSIHVwZGF0ZSBpbiBj
b250ZXh0IHN3aXRjaCAqLw0KPiA+ICsjZGVmaW5lIFRJRl9TUEVDX0ZMVVNIX0wxRCAgIDEwICAg
ICAgLyogRmx1c2ggTDFEIG9uIG1tIHN3aXRjaGVzDQo+ID4gKHByb2Nlc3NlcykgKi8NCj4gPiAg
I2RlZmluZSBUSUZfVVNFUl9SRVRVUk5fTk9USUZZICAgICAgIDExICAgICAgLyogbm90aWZ5IGtl
cm5lbCBvZg0KPiA+IHVzZXJzcGFjZSByZXR1cm4gKi8NCj4gPiAgI2RlZmluZSBUSUZfVVBST0JF
ICAgICAgICAgICAxMiAgICAgIC8qIGJyZWFrcG9pbnRlZCBvcg0KPiA+IHNpbmdsZXN0ZXBwaW5n
ICovDQo+ID4gICNkZWZpbmUgVElGX1BBVENIX1BFTkRJTkcgICAgMTMgICAgICAvKiBwZW5kaW5n
IGxpdmUgcGF0Y2hpbmcNCj4gPiB1cGRhdGUgKi8NCj4gPiBAQCAtOTYsNiArOTYsNyBAQCBzdHJ1
Y3QgdGhyZWFkX2luZm8gew0KPiA+ICAjZGVmaW5lIFRJRl9NRU1ESUUgICAgICAgICAgIDIwICAg
ICAgLyogaXMgdGVybWluYXRpbmcgZHVlIHRvIE9PTQ0KPiA+IGtpbGxlciAqLw0KPiA+ICAjZGVm
aW5lIFRJRl9QT0xMSU5HX05SRkxBRyAgIDIxICAgICAgLyogaWRsZSBpcyBwb2xsaW5nIGZvcg0K
PiA+IFRJRl9ORUVEX1JFU0NIRUQgKi8NCj4gPiAgI2RlZmluZSBUSUZfSU9fQklUTUFQICAgICAg
ICAgICAgICAgIDIyICAgICAgLyogdXNlcyBJL08gYml0bWFwICovDQo+ID4gKyNkZWZpbmUgVElG
X1NQRUNfRk9SQ0VfVVBEQVRFICAgICAgICAyMyAgICAgIC8qIEZvcmNlIHNwZWN1bGF0aW9uDQo+
ID4gTVNSIHVwZGF0ZSBpbiBjb250ZXh0IHN3aXRjaCAqLw0KPiA+ICAjZGVmaW5lIFRJRl9GT1JD
RURfVEYgICAgICAgICAgICAgICAgMjQgICAgICAvKiB0cnVlIGlmIFRGIGluDQo+ID4gZWZsYWdz
IGFydGlmaWNpYWxseSAqLw0KPiA+ICAjZGVmaW5lIFRJRl9CTE9DS1NURVAgICAgICAgICAgICAg
ICAgMjUgICAgICAvKiBzZXQgd2hlbiB3ZSB3YW50DQo+ID4gREVCVUdDVExNU1JfQlRGICovDQo+
ID4gICNkZWZpbmUgVElGX0xBWllfTU1VX1VQREFURVMgMjcgICAgICAvKiB0YXNrIGlzIHVwZGF0
aW5nIHRoZSBtbXUNCj4gPiBsYXppbHkgKi8NCj4gPiBAQCAtMTMyLDYgKzEzMyw3IEBAIHN0cnVj
dCB0aHJlYWRfaW5mbyB7DQo+ID4gICNkZWZpbmUgX1RJRl9BRERSMzIgICAgICAgICAgKDEgPDwg
VElGX0FERFIzMikNCj4gPiAgI2RlZmluZSBfVElGX1gzMiAgICAgICAgICAgICAoMSA8PCBUSUZf
WDMyKQ0KPiA+ICAjZGVmaW5lIF9USUZfRlNDSEVDSyAgICAgICAgICgxIDw8IFRJRl9GU0NIRUNL
KQ0KPiA+ICsjZGVmaW5lIF9USUZfU1BFQ19GTFVTSF9MMUQgICgxIDw8IFRJRl9TUEVDX0ZMVVNI
X0wxRCkNCj4gPiANCj4gPiAgLyogV29yayB0byBkbyBiZWZvcmUgaW52b2tpbmcgdGhlIGFjdHVh
bCBzeXNjYWxsLiAqLw0KPiA+ICAjZGVmaW5lIF9USUZfV09SS19TWVNDQUxMX0VOVFJZICAgICAg
XA0KPiA+IEBAIC0yMzUsNiArMjM3LDkgQEAgc3RhdGljIGlubGluZSBpbnQgYXJjaF93aXRoaW5f
c3RhY2tfZnJhbWVzKGNvbnN0DQo+ID4gdm9pZCAqIGNvbnN0IHN0YWNrLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBjdXJyZW50X3RocmVhZF9pbmZvKCktPnN0YXR1cyAmIFRTX0NPTVBB
VCkNCj4gPiAgI2VuZGlmDQo+ID4gDQo+ID4gK2V4dGVybiBpbnQgYXJjaF9wcmN0bF9sMWRfZmx1
c2hfc2V0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLA0KPiA+IHVuc2lnbmVkIGxvbmcgZW5hYmxl
KTsNCj4gPiArZXh0ZXJuIGludCBhcmNoX3ByY3RsX2wxZF9mbHVzaF9nZXQoc3RydWN0IHRhc2tf
c3RydWN0ICp0c2spOw0KPiA+ICsNCj4gPiAgZXh0ZXJuIHZvaWQgYXJjaF90YXNrX2NhY2hlX2lu
aXQodm9pZCk7DQo+ID4gIGV4dGVybiBpbnQgYXJjaF9kdXBfdGFza19zdHJ1Y3Qoc3RydWN0IHRh
c2tfc3RydWN0ICpkc3QsIHN0cnVjdA0KPiA+IHRhc2tfc3RydWN0ICpzcmMpOw0KPiA+ICBleHRl
cm4gdm9pZCBhcmNoX3JlbGVhc2VfdGFza19zdHJ1Y3Qoc3RydWN0IHRhc2tfc3RydWN0ICp0c2sp
Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS90bGIuYyBiL2FyY2gveDg2L21tL3RsYi5j
DQo+ID4gaW5kZXggMTAwNTZiOGQ4ZjAxLi43ZWE5YmM5ZTA4OWYgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYvbW0vdGxiLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS90bGIuYw0KPiA+IEBAIC0x
Myw2ICsxMyw3IEBADQo+ID4gICNpbmNsdWRlIDxhc20vbW11X2NvbnRleHQuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGFzbS9ub3NwZWMtYnJhbmNoLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vY2FjaGUuaD4N
Cj4gPiArI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vYXBp
Yy5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL3V2L3V2Lmg+DQo+ID4gDQo+ID4gQEAgLTQzLDExICs0
NCwxMiBAQA0KPiA+ICAgKi8NCj4gPiANCj4gPiAgLyoNCj4gPiAtICogQml0cyB0byBtYW5nbGUg
dGhlIFRJRl9TUEVDX0lCIHN0YXRlIGludG8gdGhlIG1tIHBvaW50ZXIgd2hpY2gNCj4gPiBpcw0K
PiA+ICsgKiBCaXRzIHRvIG1hbmdsZSB0aGUgVElGX1NQRUNfKiBzdGF0ZSBpbnRvIHRoZSBtbSBw
b2ludGVyIHdoaWNoIGlzDQo+ID4gICAqIHN0b3JlZCBpbiBjcHVfdGxiX3N0YXRlLmxhc3RfdXNl
cl9tbV9zcGVjLg0KPiA+ICAgKi8NCj4gPiAgI2RlZmluZSBMQVNUX1VTRVJfTU1fSUJQQiAgICAw
eDFVTA0KPiA+IC0jZGVmaW5lIExBU1RfVVNFUl9NTV9TUEVDX01BU0sgICAgICAgKExBU1RfVVNF
Ul9NTV9JQlBCKQ0KPiA+ICsjZGVmaW5lIExBU1RfVVNFUl9NTV9MMURfRkxVU0ggICAgICAgMHgy
VUwNCj4gPiArI2RlZmluZSBMQVNUX1VTRVJfTU1fU1BFQ19NQVNLICAgICAgIChMQVNUX1VTRVJf
TU1fSUJQQiB8DQo+ID4gTEFTVF9VU0VSX01NX0wxRF9GTFVTSCkNCj4gPiANCj4gPiAgLyoNCj4g
PiAgICogVGhlIHg4NiBmZWF0dXJlIGlzIGNhbGxlZCBQQ0lEIChQcm9jZXNzIENvbnRleHQgSURl
bnRpZmllcikuIEl0DQo+ID4gaXMgc2ltaWxhcg0KPiA+IEBAIC0zMDgsNiArMzEwLDM1IEBAIHZv
aWQgbGVhdmVfbW0oaW50IGNwdSkNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChsZWF2
ZV9tbSk7DQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgZW5hYmxlX2wxZF9mbHVzaF9mb3JfdGFzayhz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykNCj4gPiArew0KPiA+ICsgICAgIGludCByZXQgPSBsMWRf
Zmx1c2hfaW5pdF9vbmNlKCk7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICsg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IEFtIEkgcmVhZGluZyBjb3JyZWN0bHkgKGlu
IHRoZSB2NSBkZWx0YSkgdGhhdCB3aXRoDQo+IGwxZF9mbHVzaF9pbml0X29uY2UoKQ0KPiBub3cg
dGVzdGluZyBmb3IgSW50ZWwgQ1BVcywgaXQgbWVhbnMgcHJvY2Vzc2VzIG9uIG5vbi1JbnRlbCB4
ODYgQ1BVcw0KPiBjYW4ndCB1c2UgdGhlIHByY3RsKCkgZmVhdHVyZSBhcyBhIGRlZmVuc2UtaW4t
ZGVwdGggdG8gcG90ZW50aWFsDQo+IGZ1dHVyZQ0KPiBMMUQgY2FjaGUgc2lkZS1jaGFubmVsIGZs
YXdzPw0KDQoNClllcywgeW91IGFyZSByaWdodCwgSSB3YW50ZWQgdG8gYWRkIGl0IGhlcmUgdG8g
YWRkcmVzcyBUb20ncyBjb25jZXJuLA0KYnV0IGdvaW5nIGZvcndhcmQgd2UgY291bGQgZG8gd2hh
dCB5b3UndmUgc3VnZ2VzdGVkIG9yIGV2ZW4gY3B1X2RldiB3b3JrDQpmb3IgdGhlIHJpZ2h0IGFs
Z29yaXRobSBwZXIgY3B1IHZlbmRvci9kZXZpY2UuDQoNCklkZWFsbHkgd2UgaGF2ZSB0aGUgY2Fj
aGUgc2l6ZSBpbmZvcm1hdGlvbiBpbiBvdXIgeDg2X2NwdWluZm8gc3RydWN0dXJlDQphdCB0aGUg
dGltZSBvZiBkaXNjb3ZlcnksIGJ1dCB3ZSBvdmVyd3JpdGUgaXQgd2l0aCB0aGUgc2l6ZSBvZiB0
aGUNCmxhcmdlc3QgY2FjaGUsIHNvIHdlIGNvdWxkIGRlZmluaXRlbHkgZml4IHRob3NlIGJpdHMu
DQoNCkkgc3VnZ2VzdCB3ZSBtb3ZlIGZvcndhcmQgdGhpcyBzZXJpZXMgYW5kIGFkZCBzdXBwb3J0
IGZvciBvdGhlciB2ZW5kb3JzDQphcyBhIGZvbGxvdyB1cC4gV2hhdCBkbyB5b3UgdGhpbms/DQoN
CkJhbGJpciBTaW5naC4NCg0KDQo+IA0KPiBXaHkgY2FuJ3QgdGhlIEwxRF9DQUNIRV9PUkRFUiBq
dXN0IGdldCBzZXQgZHluYW1pY2FsbHkgYmFzZWQgb24gQ1BVPw0KPiANCj4gPiArDQo+ID4gKyAg
ICAgc2V0X3RpX3RocmVhZF9mbGFnKCZ0c2stPnRocmVhZF9pbmZvLCBUSUZfU1BFQ19GTFVTSF9M
MUQpOw0KPiA+ICsgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gDQo+IC0tDQo+IEtlZXMgQ29v
aw0K
