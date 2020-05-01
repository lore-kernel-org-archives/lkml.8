Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D3CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C7620643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LAZ14VJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgEADso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:48:44 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:27392 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgEADsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588304923; x=1619840923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9WFDGqkOMXIZrj4o5C2jZsXPqpKY2ILbnwfgDmi1TPU=;
  b=LAZ14VJh8Rb1HPDXrDJKAOJuV/m01GHb8krkcDlYAMr5RPUsecQWV7kq
   lKUYu7xl0cUxEdAkJSyIH7lg1njnZ15AemyKAxREDrmpCTu0auWhvARbg
   u4nDeFMJaE9B3fPSUzI9iWKn4l5quR+GhR8Cu+wULytqFluX73i/G0XAP
   c=;
IronPort-SDR: 281A5/6dqAKu8pa/LoZK13YmaSssrF6kl/RGJnI198kIFThfEnyTkOFF0oAF0mwDXFroT0FOov
 0Ur4wcg4wpbg==
X-IronPort-AV: E=Sophos;i="5.73,338,1583193600"; 
   d="scan'208";a="40597647"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 May 2020 03:48:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 8FD5CA217C;
        Fri,  1 May 2020 03:48:37 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 1 May 2020 03:48:36 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 1 May 2020 03:48:36 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 1 May 2020 03:48:36 +0000
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
Subject: Re:  [PATCH v4 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Thread-Topic: [PATCH v4 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Thread-Index: AQHWGqO9uySqPyunLEWB26nlla6sNKiSoX4A
Date:   Fri, 1 May 2020 03:48:36 +0000
Message-ID: <c6a8fa86551357005a6421159ba628049eade129.camel@amazon.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
         <20200423140125.7332-2-sblbir@amazon.com>
         <c45c0539-dd48-0e6c-5bb4-22d905b778aa@amd.com>
         <dc40ceb1e6ff29f90b2579deba5ad107fe1fe905.camel@amazon.com>
In-Reply-To: <dc40ceb1e6ff29f90b2579deba5ad107fe1fe905.camel@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.215]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB052338634D6348BFDBB078A0E68781@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA0LTI1IGF0IDExOjQ5ICsxMDAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IE9uIEZyaSwgMjAyMC0wNC0yNCBhdCAxMzo1OSAtMDUwMCwgVG9tIExlbmRhY2t5IHdyb3RlOg0K
PiA+IA0KPiA+IE9uIDQvMjMvMjAgOTowMSBBTSwgQmFsYmlyIFNpbmdoIHdyb3RlOg0KPiA+ID4g
U3BsaXQgb3V0IHRoZSBhbGxvY2F0aW9uIGFuZCBmcmVlIHJvdXRpbmVzIHRvIGJlIHVzZWQgaW4g
YSBmb2xsb3cNCj4gPiA+IHVwIHNldCBvZiBwYXRjaGVzICh0byByZXVzZSBmb3IgTDFEIGZsdXNo
aW5nKS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmFsYmlyIFNpbmdoIDxzYmxiaXJA
YW1hem9uLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9t
aXVtLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWZs
dXNoLmggfCAgMyArKysNCj4gPiA+ICAgYXJjaC94ODYva2VybmVsL01ha2VmaWxlICAgICAgICAg
IHwgIDEgKw0KPiA+ID4gICBhcmNoL3g4Ni9rZXJuZWwvbDFkX2ZsdXNoLmMgICAgICAgfCAzNiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgIGFyY2gveDg2L2t2bS92bXgv
dm14LmMgICAgICAgICAgICB8IDI1ICsrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gICA0IGZp
bGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+ID4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5jDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgNCj4gPiA+
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY2FjaGVmbHVzaC5oDQo+ID4gPiBpbmRleCA2M2ZlYWYy
YTVmOTMuLmJhYzU2ZmNkOTc5MCAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2NhY2hlZmx1c2guaA0KPiA+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY2FjaGVm
bHVzaC5oDQo+ID4gPiBAQCAtNiw2ICs2LDkgQEANCj4gPiA+ICAgI2luY2x1ZGUgPGFzbS1nZW5l
cmljL2NhY2hlZmx1c2guaD4NCj4gPiA+ICAgI2luY2x1ZGUgPGFzbS9zcGVjaWFsX2luc25zLmg+
DQo+ID4gPiANCj4gPiA+ICsjZGVmaW5lIEwxRF9DQUNIRV9PUkRFUiA0DQo+ID4gDQo+ID4gU2lu
Y2UgdGhpcyBpcyBiZWNvbWluZyBhIGdlbmVyaWMgZnVuY3Rpb24gbm93LCBzaG91bGRuJ3QgdGhp
cyB2YWx1ZSBiZQ0KPiA+IGJhc2VkIG9uIHRoZSBhY3R1YWwgTDFEIGNhY2hlIHNpemU/IElzIHRo
aXMgdmFsdWUgYmFzZWQgb24gYSAzMktCIGRhdGENCj4gPiBjYWNoZSBhbmQgdGhlIGlkZWEgaXMg
dG8gd3JpdGUgdHdpY2UgdGhlIHNpemUgb2YgdGhlIGNhY2hlIHRvIGJlIHN1cmUgdGhhdA0KPiA+
IGV2ZXJ5IGVudHJ5IGhhcyBiZWVuIHJlcGxhY2VkIC0gd2l0aCB0aGUgc2Vjb25kIDMyS0IgdG8g
Y2F0Y2ggdGhlIG9kZCBsaW5lDQo+ID4gdGhhdCBtaWdodCBub3QgaGF2ZSBiZWVuIHB1bGxlZCBp
bj8NCj4gPiANCj4gDQo+IEN1cnJlbnRseSB0aGUgb25seSB1c2VycyBhcmUgVk1YIEwxVEYgYW5k
IG9wdGlvbmFsIHByY3RsKCkuIEl0IHNob3VsZCBiZQ0KPiBiYXNlZA0KPiBvbiBhY3R1YWwgTDFE
IGNhY2hlIHNpemUsIEkgY2hlY2tlZCBhIGxpdHRsZSBiaXQgYW5kIHRoZSBsYXJnZXN0IEwxRCBj
YWNoZQ0KPiBzaXplIGFjcm9zcyB2YXJpb3VzIHg4NiBiaXRzIGlzIDY0Sy4gc28gdGhlcmUgYXJl
IHRocmVlIG9wdGlvbnMgaGVyZToNCj4gDQo+IDEuIFdlIHJlZmFjdG9yIHRoZSBjb2RlLCB3ZSB3
b3VsZCBuZWVkIHRvIHNhdmUgdGhlIEwxRCBjYWNoZSBzaXplIGFuZCB1c2UNCj4gY3B1X2RldiBj
YWxsYmFja3MgZm9yIEwxRCBmbHVzaA0KPiAyLiBXZSBjYW4gbWFrZSB0aGUgY3VycmVudCBjb2Rl
IGRlcGVuZCBvbiBMMURfRkxVU0ggTVNSIGFuZCBlbmFibGUgaXQgb25seQ0KPiB3aGVuIHRoYXQg
ZmVhdHVyZSBpcyBhdmFpbGFibGUuIFRoZXJlIHdvdWxkIGJlIG5vIHNvZnR3YXJlIGZhbGxiYWNr
LiBUaGVuDQo+IGZvbGxvdyBpdCB1cCB3aXRoICMxDQo+IDMuIFdlIGtlZXAgdGhlIGNvZGUgYXMg
aXMgb24gdGhlIGFzc3VtcHRpb24gdGhhdCBhbGwgb2YgTDFEIDw9IDY0SyBhY3Jvc3MNCj4gdGhl
DQo+IGN1cnJlbnQgcGxhdGZvcm1zIGFuZCB3ZSBkbyAjMSBpbiBhIGZvbGxvd3VwIChzaW5jZSB0
aGUgcHJjdGwgaXMgb3B0aW9uYWwNCj4gYW5kDQo+IHRoZSBvbmx5IG90aGVyIHVzZXIgaXMgdGhl
IFZNWCBjb2RlKS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldywNCj4gQmFsYmlyIFNpbmdo
Lg0KPiANCg0KVG9tLA0KDQpJIGhhdmUgdGhlIGZvbGxvd2luZyBjaGFuZ2VzIHRoYXQgSSB0aGlu
ayB3aWxsIHN1ZmZpY2UgZm9yIG5vdyAodGhlc2UgYXJlIG5vdA0KcHJvcGVybHkgZm9ybWF0dGVk
LCBidXQgeW91IGdldCB0aGUgaWRlYSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9s
MWRfZmx1c2guYyBiL2FyY2gveDg2L2tlcm5lbC9sMWRfZmx1c2guYw0KaW5kZXggYTc1NGI2YzI4
OGE5Li43ZmVjMGNjOGY4NWMgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbDFkX2ZsdXNo
LmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9sMWRfZmx1c2guYw0KQEAgLTkyLDYgKzkyLDkgQEAg
aW50IGwxZF9mbHVzaF9pbml0X29uY2Uodm9pZCkNCiB7DQogICAgICAgIGludCByZXQgPSAwOw0K
IA0KKyAgICAgICBpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5U
RUwpDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCisNCiAgICAgICAgaWYgKHN0
YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0ZMVVNIX0wxRCkgfHwgbDFkX2ZsdXNoX3BhZ2VzKQ0K
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQoNCg0KRG9lcyB0aGF0IHNhdGlzZnkgeW91ciBj
b21tZW50cyBhYm91dCBwYXRjaCAxLzYgYW5kIDIvNiBpbiB0aGUgc2VyaWVzPw0KDQpCYWxiaXIg
U2luZ2guDQo=
