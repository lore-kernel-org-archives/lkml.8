Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5205C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BE92076C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rj/559xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYBt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 21:49:28 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57504 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYBt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 21:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587779368; x=1619315368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TNGDwjN/KA3qXS69rgpOe1AwkRhBkDAIyTgpQ/Anz/I=;
  b=rj/559xrbGi1M6VgdpS3uNbtQ5vrzPKdMmUwmEF7XWLmYo7c3axmNGgD
   CXNGa+QZtA5ZiS2H5PuJxSXuzXAjERtC+ZP/s3yL5HRcIhSAsMvx/D15q
   JzhxHLeyZAmhKGHLSQ0LthqQ6WR2hDF5eGFd/wjBQsn9r0yXMvTcvH5Yn
   M=;
IronPort-SDR: sMQsEtecHO/bEqKNbU7cMU7AHNw6n+pJS1ta7SBRMoTpObU9nYekyWeWs8MO1wKc33FpJiyVJY
 EjAXZf5oga5w==
X-IronPort-AV: E=Sophos;i="5.73,314,1583193600"; 
   d="scan'208";a="39386269"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Apr 2020 01:49:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id A3614A27C6;
        Sat, 25 Apr 2020 01:49:21 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 25 Apr 2020 01:49:21 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 25 Apr 2020 01:49:20 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Sat, 25 Apr 2020 01:49:20 +0000
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
Thread-Index: AQHWGqO9uySqPyunLEWB26nlla6sNA==
Date:   Sat, 25 Apr 2020 01:49:20 +0000
Message-ID: <dc40ceb1e6ff29f90b2579deba5ad107fe1fe905.camel@amazon.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
         <20200423140125.7332-2-sblbir@amazon.com>
         <c45c0539-dd48-0e6c-5bb4-22d905b778aa@amd.com>
In-Reply-To: <c45c0539-dd48-0e6c-5bb4-22d905b778aa@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <790580E9EA41B84AAAD86B1C3CB2DD61@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTI0IGF0IDEzOjU5IC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IA0KPiBPbiA0LzIzLzIwIDk6MDEgQU0sIEJhbGJpciBTaW5naCB3cm90ZToNCj4gPiBTcGxpdCBv
dXQgdGhlIGFsbG9jYXRpb24gYW5kIGZyZWUgcm91dGluZXMgdG8gYmUgdXNlZCBpbiBhIGZvbGxv
dw0KPiA+IHVwIHNldCBvZiBwYXRjaGVzICh0byByZXVzZSBmb3IgTDFEIGZsdXNoaW5nKS4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gPiAt
LS0NCj4gPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaCB8ICAzICsrKw0KPiA+
ICAgYXJjaC94ODYva2VybmVsL01ha2VmaWxlICAgICAgICAgIHwgIDEgKw0KPiA+ICAgYXJjaC94
ODYva2VybmVsL2wxZF9mbHVzaC5jICAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAgYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICAgIHwgMjUgKysr
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMo
KyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2tl
cm5lbC9sMWRfZmx1c2guYw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9jYWNoZWZsdXNoLmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2gu
aA0KPiA+IGluZGV4IDYzZmVhZjJhNWY5My4uYmFjNTZmY2Q5NzkwIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaA0KPiA+ICsrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2NhY2hlZmx1c2guaA0KPiA+IEBAIC02LDYgKzYsOSBAQA0KPiA+ICAgI2luY2x1
ZGUgPGFzbS1nZW5lcmljL2NhY2hlZmx1c2guaD4NCj4gPiAgICNpbmNsdWRlIDxhc20vc3BlY2lh
bF9pbnNucy5oPg0KPiA+IA0KPiA+ICsjZGVmaW5lIEwxRF9DQUNIRV9PUkRFUiA0DQo+IA0KPiBT
aW5jZSB0aGlzIGlzIGJlY29taW5nIGEgZ2VuZXJpYyBmdW5jdGlvbiBub3csIHNob3VsZG4ndCB0
aGlzIHZhbHVlIGJlDQo+IGJhc2VkIG9uIHRoZSBhY3R1YWwgTDFEIGNhY2hlIHNpemU/IElzIHRo
aXMgdmFsdWUgYmFzZWQgb24gYSAzMktCIGRhdGENCj4gY2FjaGUgYW5kIHRoZSBpZGVhIGlzIHRv
IHdyaXRlIHR3aWNlIHRoZSBzaXplIG9mIHRoZSBjYWNoZSB0byBiZSBzdXJlIHRoYXQNCj4gZXZl
cnkgZW50cnkgaGFzIGJlZW4gcmVwbGFjZWQgLSB3aXRoIHRoZSBzZWNvbmQgMzJLQiB0byBjYXRj
aCB0aGUgb2RkIGxpbmUNCj4gdGhhdCBtaWdodCBub3QgaGF2ZSBiZWVuIHB1bGxlZCBpbj8NCj4g
DQoNCkN1cnJlbnRseSB0aGUgb25seSB1c2VycyBhcmUgVk1YIEwxVEYgYW5kIG9wdGlvbmFsIHBy
Y3RsKCkuIEl0IHNob3VsZCBiZSBiYXNlZA0Kb24gYWN0dWFsIEwxRCBjYWNoZSBzaXplLCBJIGNo
ZWNrZWQgYSBsaXR0bGUgYml0IGFuZCB0aGUgbGFyZ2VzdCBMMUQgY2FjaGUNCnNpemUgYWNyb3Nz
IHZhcmlvdXMgeDg2IGJpdHMgaXMgNjRLLiBzbyB0aGVyZSBhcmUgdGhyZWUgb3B0aW9ucyBoZXJl
Og0KDQoxLiBXZSByZWZhY3RvciB0aGUgY29kZSwgd2Ugd291bGQgbmVlZCB0byBzYXZlIHRoZSBM
MUQgY2FjaGUgc2l6ZSBhbmQgdXNlDQpjcHVfZGV2IGNhbGxiYWNrcyBmb3IgTDFEIGZsdXNoDQoy
LiBXZSBjYW4gbWFrZSB0aGUgY3VycmVudCBjb2RlIGRlcGVuZCBvbiBMMURfRkxVU0ggTVNSIGFu
ZCBlbmFibGUgaXQgb25seQ0Kd2hlbiB0aGF0IGZlYXR1cmUgaXMgYXZhaWxhYmxlLiBUaGVyZSB3
b3VsZCBiZSBubyBzb2Z0d2FyZSBmYWxsYmFjay4gVGhlbg0KZm9sbG93IGl0IHVwIHdpdGggIzEN
CjMuIFdlIGtlZXAgdGhlIGNvZGUgYXMgaXMgb24gdGhlIGFzc3VtcHRpb24gdGhhdCBhbGwgb2Yg
TDFEIDw9IDY0SyBhY3Jvc3MgdGhlDQpjdXJyZW50IHBsYXRmb3JtcyBhbmQgd2UgZG8gIzEgaW4g
YSBmb2xsb3d1cCAoc2luY2UgdGhlIHByY3RsIGlzIG9wdGlvbmFsIGFuZA0KdGhlIG9ubHkgb3Ro
ZXIgdXNlciBpcyB0aGUgVk1YIGNvZGUpLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsDQpCYWxi
aXIgU2luZ2guDQoNCg0KDQo+IFRoYW5rcywNCj4gVG9tDQo+IA0KPiA+ICAgdm9pZCBjbGZsdXNo
X2NhY2hlX3JhbmdlKHZvaWQgKmFkZHIsIHVuc2lnbmVkIGludCBzaXplKTsNCj4gPiArdm9pZCAq
bDFkX2ZsdXNoX2FsbG9jX3BhZ2VzKHZvaWQpOw0KPiA+ICt2b2lkIGwxZF9mbHVzaF9jbGVhbnVw
X3BhZ2VzKHZvaWQgKmwxZF9mbHVzaF9wYWdlcyk7DQo+ID4gDQo+ID4gICAjZW5kaWYgLyogX0FT
TV9YODZfQ0FDSEVGTFVTSF9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9N
YWtlZmlsZSBiL2FyY2gveDg2L2tlcm5lbC9NYWtlZmlsZQ0KPiA+IGluZGV4IDkyZTEyNjFlYzRl
Yy4uNDJjMTFjYTg1ZjFjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9NYWtlZmls
ZQ0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9NYWtlZmlsZQ0KPiA+IEBAIC0xNTgsMyArMTU4
LDQgQEAgaWZlcSAoJChDT05GSUdfWDg2XzY0KSx5KQ0KPiA+ICAgZW5kaWYNCj4gPiANCj4gPiAg
IG9iai0kKENPTkZJR19JTUFfU0VDVVJFX0FORF9PUl9UUlVTVEVEX0JPT1QpICAgICAgICArPSBp
bWFfYXJjaC5vDQo+ID4gK29iai15ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKz0gbDFkX2ZsdXNoLm8NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2Vy
bmVsL2wxZF9mbHVzaC5jIGIvYXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5jDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ2MDU4NzhjOGYyOA0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbDFkX2ZsdXNoLmMNCj4g
PiBAQCAtMCwwICsxLDM2IEBADQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tbS5oPg0KPiA+ICsjaW5j
bHVkZSA8YXNtL2NhY2hlZmx1c2guaD4NCj4gPiArDQo+ID4gK3ZvaWQgKmwxZF9mbHVzaF9hbGxv
Y19wYWdlcyh2b2lkKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4g
KyAgICAgdm9pZCAqbDFkX2ZsdXNoX3BhZ2VzID0gTlVMTDsNCj4gPiArICAgICBpbnQgaTsNCj4g
PiArDQo+ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBUaGlzIGFsbG9jYXRpb24gZm9yIGwxZF9m
bHVzaF9wYWdlcyBpcyBub3QgdGllZCB0byBhIFZNL3Rhc2sncw0KPiA+ICsgICAgICAqIGxpZmV0
aW1lIGFuZCBzbyBzaG91bGQgbm90IGJlIGNoYXJnZWQgdG8gYSBtZW1jZy4NCj4gPiArICAgICAg
Ki8NCj4gPiArICAgICBwYWdlID0gYWxsb2NfcGFnZXMoR0ZQX0tFUk5FTCwgTDFEX0NBQ0hFX09S
REVSKTsNCj4gPiArICAgICBpZiAoIXBhZ2UpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gTlVM
TDsNCj4gPiArICAgICBsMWRfZmx1c2hfcGFnZXMgPSBwYWdlX2FkZHJlc3MocGFnZSk7DQo+ID4g
Kw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogSW5pdGlhbGl6ZSBlYWNoIHBhZ2Ugd2l0aCBh
IGRpZmZlcmVudCBwYXR0ZXJuIGluDQo+ID4gKyAgICAgICogb3JkZXIgdG8gcHJvdGVjdCBhZ2Fp
bnN0IEtTTSBpbiB0aGUgbmVzdGVkDQo+ID4gKyAgICAgICogdmlydHVhbGl6YXRpb24gY2FzZS4N
Cj4gPiArICAgICAgKi8NCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgMXUgPDwgTDFEX0NBQ0hF
X09SREVSOyArK2kpIHsNCj4gPiArICAgICAgICAgICAgIG1lbXNldChsMWRfZmx1c2hfcGFnZXMg
KyBpICogUEFHRV9TSVpFLCBpICsgMSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBQQUdFX1NJWkUpOw0KPiA+ICsgICAgIH0NCj4gPiArICAgICByZXR1cm4gbDFkX2ZsdXNoX3Bh
Z2VzOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGwxZF9mbHVzaF9hbGxvY19wYWdl
cyk7DQo+ID4gKw0KPiA+ICt2b2lkIGwxZF9mbHVzaF9jbGVhbnVwX3BhZ2VzKHZvaWQgKmwxZF9m
bHVzaF9wYWdlcykNCj4gPiArew0KPiA+ICsgICAgIGZyZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcp
bDFkX2ZsdXNoX3BhZ2VzLCBMMURfQ0FDSEVfT1JERVIpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9T
WU1CT0xfR1BMKGwxZF9mbHVzaF9jbGVhbnVwX3BhZ2VzKTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gPiBpbmRleCA4
MzA1MDk3NzQ5MGMuLjIyNWFhODIxOWJhYyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jDQo+ID4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYw0KPiA+IEBAIC0yMDMs
MTQgKzIwMywxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4gPiAgICAgICBbVk1FTlRFUl9M
MURfRkxVU0hfTk9UX1JFUVVJUkVEXSA9IHsibm90IHJlcXVpcmVkIiwgZmFsc2V9LA0KPiA+ICAg
fTsNCj4gPiANCj4gPiAtI2RlZmluZSBMMURfQ0FDSEVfT1JERVIgNA0KPiA+ICAgc3RhdGljIHZv
aWQgKnZteF9sMWRfZmx1c2hfcGFnZXM7DQo+ID4gDQo+ID4gICBzdGF0aWMgaW50IHZteF9zZXR1
cF9sMWRfZmx1c2goZW51bSB2bXhfbDFkX2ZsdXNoX3N0YXRlIGwxdGYpDQo+ID4gICB7DQo+ID4g
LSAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4gLSAgICAgdW5zaWduZWQgaW50IGk7DQo+ID4g
LQ0KPiA+ICAgICAgIGlmICghYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX0wxVEYpKSB7DQo+ID4g
ICAgICAgICAgICAgICBsMXRmX3ZteF9taXRpZ2F0aW9uID0gVk1FTlRFUl9MMURfRkxVU0hfTk9U
X1JFUVVJUkVEOw0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gQEAgLTI1MywyNCAr
MjQ5LDkgQEAgc3RhdGljIGludCB2bXhfc2V0dXBfbDFkX2ZsdXNoKGVudW0NCj4gPiB2bXhfbDFk
X2ZsdXNoX3N0YXRlIGwxdGYpDQo+ID4gDQo+ID4gICAgICAgaWYgKGwxdGYgIT0gVk1FTlRFUl9M
MURfRkxVU0hfTkVWRVIgJiYgIXZteF9sMWRfZmx1c2hfcGFnZXMgJiYNCj4gPiAgICAgICAgICAg
IWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9GTFVTSF9MMUQpKSB7DQo+ID4gLSAgICAgICAgICAg
ICAvKg0KPiA+IC0gICAgICAgICAgICAgICogVGhpcyBhbGxvY2F0aW9uIGZvciB2bXhfbDFkX2Zs
dXNoX3BhZ2VzIGlzIG5vdCB0aWVkIHRvIGENCj4gPiBWTQ0KPiA+IC0gICAgICAgICAgICAgICog
bGlmZXRpbWUgYW5kIHNvIHNob3VsZCBub3QgYmUgY2hhcmdlZCB0byBhIG1lbWNnLg0KPiA+IC0g
ICAgICAgICAgICAgICovDQo+ID4gLSAgICAgICAgICAgICBwYWdlID0gYWxsb2NfcGFnZXMoR0ZQ
X0tFUk5FTCwgTDFEX0NBQ0hFX09SREVSKTsNCj4gPiAtICAgICAgICAgICAgIGlmICghcGFnZSkN
Cj4gPiArICAgICAgICAgICAgIHZteF9sMWRfZmx1c2hfcGFnZXMgPSBsMWRfZmx1c2hfYWxsb2Nf
cGFnZXMoKTsNCj4gPiArICAgICAgICAgICAgIGlmICghdm14X2wxZF9mbHVzaF9wYWdlcykNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gLSAgICAgICAgICAg
ICB2bXhfbDFkX2ZsdXNoX3BhZ2VzID0gcGFnZV9hZGRyZXNzKHBhZ2UpOw0KPiA+IC0NCj4gPiAt
ICAgICAgICAgICAgIC8qDQo+ID4gLSAgICAgICAgICAgICAgKiBJbml0aWFsaXplIGVhY2ggcGFn
ZSB3aXRoIGEgZGlmZmVyZW50IHBhdHRlcm4gaW4NCj4gPiAtICAgICAgICAgICAgICAqIG9yZGVy
IHRvIHByb3RlY3QgYWdhaW5zdCBLU00gaW4gdGhlIG5lc3RlZA0KPiA+IC0gICAgICAgICAgICAg
ICogdmlydHVhbGl6YXRpb24gY2FzZS4NCj4gPiAtICAgICAgICAgICAgICAqLw0KPiA+IC0gICAg
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IDF1IDw8IEwxRF9DQUNIRV9PUkRFUjsgKytpKSB7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgIG1lbXNldCh2bXhfbDFkX2ZsdXNoX3BhZ2VzICsgaSAq
IFBBR0VfU0laRSwgaSArIDEsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdF
X1NJWkUpOw0KPiA+IC0gICAgICAgICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPiANCj4gPiAgICAg
ICBsMXRmX3ZteF9taXRpZ2F0aW9uID0gbDF0ZjsNCj4gPiBAQCAtODAyNiw3ICs4MDA3LDcgQEAg
c3RhdGljIHN0cnVjdCBrdm1feDg2X2luaXRfb3BzIHZteF9pbml0X29wcw0KPiA+IF9faW5pdGRh
dGEgPSB7DQo+ID4gICBzdGF0aWMgdm9pZCB2bXhfY2xlYW51cF9sMWRfZmx1c2godm9pZCkNCj4g
PiAgIHsNCj4gPiAgICAgICBpZiAodm14X2wxZF9mbHVzaF9wYWdlcykgew0KPiA+IC0gICAgICAg
ICAgICAgZnJlZV9wYWdlcygodW5zaWduZWQgbG9uZyl2bXhfbDFkX2ZsdXNoX3BhZ2VzLA0KPiA+
IEwxRF9DQUNIRV9PUkRFUik7DQo+ID4gKyAgICAgICAgICAgICBsMWRfZmx1c2hfY2xlYW51cF9w
YWdlcyh2bXhfbDFkX2ZsdXNoX3BhZ2VzKTsNCj4gPiAgICAgICAgICAgICAgIHZteF9sMWRfZmx1
c2hfcGFnZXMgPSBOVUxMOw0KPiA+ICAgICAgIH0NCj4gPiAgICAgICAvKiBSZXN0b3JlIHN0YXRl
IHNvIHN5c2ZzIGlnbm9yZXMgVk1YICovDQo+ID4gDQo=
