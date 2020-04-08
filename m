Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85826C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E4F20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vRaYiOnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDHAWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:22:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:3875 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgDHAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586305372; x=1617841372;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=iKq3TgYjgw3nZuEk1LMUMf2SykJq/nlJbGMsASxvgv0=;
  b=vRaYiOnT9vp2DUvcQt1dB0w/so0VZXhWgJPlntpK63kKjQ/mzstlUAN3
   rIzwpG6/0L91KXhwucMWL2nzn8e+xhw8QfEbVkISmh5Zk4El6Xaq5aGlO
   qz850IA9n8qyVgzQgMVagyRYzp0/fikBDB9D2+YpqaAXRHLuzKTEDQKZb
   I=;
IronPort-SDR: vZgcunbmelg6GWgKvudrmJgrwnW5YtwkwdKxY3GmOQaLvxPWUVNdxz85bPtbjEIfOIqKUufnAh
 Zm6kZ+hCEMxQ==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="24678441"
Subject: Re: [PATCH v2 2/4] arch/x86: Refactor tlbflush and l1d flush
Thread-Topic: [PATCH v2 2/4] arch/x86: Refactor tlbflush and l1d flush
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 08 Apr 2020 00:22:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id B9778A2924;
        Wed,  8 Apr 2020 00:22:37 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 00:22:37 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 00:22:36 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Wed, 8 Apr 2020 00:22:36 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWC8KQbPxrh5g1r06s48CXbhupeqht/CwAgABj6gA=
Date:   Wed, 8 Apr 2020 00:22:36 +0000
Message-ID: <c0449b6e82cdfa910615da27bbbfa79427c2e913.camel@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
         <20200406031946.11815-3-sblbir@amazon.com> <202004071122.379AB7D@keescook>
In-Reply-To: <202004071122.379AB7D@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.155]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD0AFC3A0B55C84DAB686C6F5EFF26C8@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTA3IGF0IDExOjI1IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IA0K
PiBPbiBNb24sIEFwciAwNiwgMjAyMCBhdCAwMToxOTo0NFBNICsxMDAwLCBCYWxiaXIgU2luZ2gg
d3JvdGU6DQo+ID4gUmVmYWN0b3IgdGhlIGV4aXN0aW5nIGFzc2VtYmx5IGJpdHMgaW50byBzbWFs
bGVyIGhlbHBlciBmdW5jdGlvbnMNCj4gPiBhbmQgYWxzbyBhYnN0cmFjdCBMMURfRkxVU0ggaW50
byBhIGhlbHBlciBmdW5jdGlvbi4gVXNlIHRoZXNlDQo+ID4gZnVuY3Rpb25zIGluIGt2bSBmb3Ig
TDFEIGZsdXNoaW5nLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGJpciBTaW5naCA8c2Js
YmlyQGFtYXpvbi5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hl
Zmx1c2guaCB8ICAzICsrDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9sMWRfZmx1c2guYyAgICAgICB8
IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgYXJjaC94ODYva3ZtL3Zt
eC92bXguYyAgICAgICAgICAgIHwgMzEgKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAzIGZpbGVz
IGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgNCj4gPiBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaA0KPiA+IGluZGV4IDY0MTlhNGNlZjBlOC4uNjZh
NDZkYjdhYWRkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1
c2guaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaA0KPiA+IEBA
IC0xMCw1ICsxMCw4IEBADQo+ID4gIHZvaWQgY2xmbHVzaF9jYWNoZV9yYW5nZSh2b2lkICphZGRy
LCB1bnNpZ25lZCBpbnQgc2l6ZSk7DQo+ID4gIHZvaWQgKmFsbG9jX2wxZF9mbHVzaF9wYWdlcyh2
b2lkKTsNCj4gPiAgdm9pZCBjbGVhbnVwX2wxZF9mbHVzaF9wYWdlcyh2b2lkICpsMWRfZmx1c2hf
cGFnZXMpOw0KPiA+ICt2b2lkIHBvcHVsYXRlX3RsYl93aXRoX2ZsdXNoX3BhZ2VzKHZvaWQgKmwx
ZF9mbHVzaF9wYWdlcyk7DQo+ID4gK3ZvaWQgZmx1c2hfbDFkX2NhY2hlX3N3KHZvaWQgKmwxZF9m
bHVzaF9wYWdlcyk7DQo+ID4gK2ludCBmbHVzaF9sMWRfY2FjaGVfaHcodm9pZCk7DQo+ID4gDQo+
ID4gICNlbmRpZiAvKiBfQVNNX1g4Nl9DQUNIRUZMVVNIX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5jIGIvYXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5j
DQo+ID4gaW5kZXggMDVmMzc1YzMzNDIzLi42MDQ5OWY3NzMwNDYgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYva2VybmVsL2wxZF9mbHVzaC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2wx
ZF9mbHVzaC5jDQo+ID4gQEAgLTM0LDMgKzM0LDUyIEBAIHZvaWQgY2xlYW51cF9sMWRfZmx1c2hf
cGFnZXModm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKQ0KPiA+ICAgICAgIGZyZWVfcGFnZXMoKHVuc2ln
bmVkIGxvbmcpbDFkX2ZsdXNoX3BhZ2VzLCBMMURfQ0FDSEVfT1JERVIpOw0KPiA+ICB9DQo+ID4g
IEVYUE9SVF9TWU1CT0xfR1BMKGNsZWFudXBfbDFkX2ZsdXNoX3BhZ2VzKTsNCj4gPiArDQo+ID4g
K3ZvaWQgcG9wdWxhdGVfdGxiX3dpdGhfZmx1c2hfcGFnZXModm9pZCAqbDFkX2ZsdXNoX3BhZ2Vz
KQ0KPiA+ICt7DQo+ID4gKyAgICAgaW50IHNpemUgPSBQQUdFX1NJWkUgPDwgTDFEX0NBQ0hFX09S
REVSOw0KPiA+ICsNCj4gPiArICAgICBhc20gdm9sYXRpbGUoDQo+ID4gKyAgICAgICAgICAgICAv
KiBGaXJzdCBlbnN1cmUgdGhlIHBhZ2VzIGFyZSBpbiB0aGUgVExCICovDQo+ID4gKyAgICAgICAg
ICAgICAieG9ybCAgICUlZWF4LCAlJWVheFxuIg0KPiA+ICsgICAgICAgICAgICAgIi5McG9wdWxh
dGVfdGxiOlxuXHQiDQo+ID4gKyAgICAgICAgICAgICAibW92emJsICglW2ZsdXNoX3BhZ2VzXSwg
JSUiIF9BU01fQVggIiksICUlZWN4XG5cdCINCj4gPiArICAgICAgICAgICAgICJhZGRsICAgJDQw
OTYsICUlZWF4XG5cdCINCj4gPiArICAgICAgICAgICAgICJjbXBsICAgJSVlYXgsICVbc2l6ZV1c
blx0Ig0KPiA+ICsgICAgICAgICAgICAgImpuZSAgICAuTHBvcHVsYXRlX3RsYlxuXHQiDQo+ID4g
KyAgICAgICAgICAgICAieG9ybCAgICUlZWF4LCAlJWVheFxuXHQiDQo+ID4gKyAgICAgICAgICAg
ICAiY3B1aWRcblx0Ig0KPiA+ICsgICAgICAgICAgICAgOjogW2ZsdXNoX3BhZ2VzXSAiciIgKGwx
ZF9mbHVzaF9wYWdlcyksDQo+ID4gKyAgICAgICAgICAgICAgICAgW3NpemVdICJyIiAoc2l6ZSkN
Cj4gPiArICAgICAgICAgICAgIDogImVheCIsICJlYngiLCAiZWN4IiwgImVkeCIpOw0KPiA+ICt9
DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHBvcHVsYXRlX3RsYl93aXRoX2ZsdXNoX3BhZ2VzKTsN
Cj4gPiArDQo+ID4gK2ludCBmbHVzaF9sMWRfY2FjaGVfaHcodm9pZCkNCj4gPiArew0KPiA+ICsg
ICAgIGlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9GTFVTSF9MMUQpKSB7DQo+ID4gKyAg
ICAgICAgICAgICB3cm1zcmwoTVNSX0lBMzJfRkxVU0hfQ01ELCBMMURfRkxVU0gpOw0KPiA+ICsg
ICAgICAgICAgICAgcmV0dXJuIDE7DQo+ID4gKyAgICAgfQ0KPiA+ICsgICAgIHJldHVybiAwOw0K
PiA+ICt9DQo+IA0KPiBUaGlzIHJldHVybiB2YWx1ZSBpcyBiYWNrd2FyZHMgZnJvbSB0aGUga2Vy
bmVsJ3Mgbm9ybWFsIHVzZSBvZiAiaW50Ii4gSQ0KPiB3b3VsZCBleHBlY3QgMCB0byBtZWFuICJz
dWNjZXNzIiBhbmQgbm9uLXplcm8gdG8gbWVhbiAiZmFpbHVyZSIuIEhvdw0KPiBhYm91dDoNCj4g
DQo+IGludCBmbHVzaF9sMWRfY2FjaGVfaHcodm9pZCkNCj4gew0KPiAgICAgIGlmIChzdGF0aWNf
Y3B1X2hhcyhYODZfRkVBVFVSRV9GTFVTSF9MMUQpKSB7DQo+ICAgICAgICAgICAgICB3cm1zcmwo
TVNSX0lBMzJfRkxVU0hfQ01ELCBMMURfRkxVU0gpOw0KPiAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ICAgICAgfQ0KPiAgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+IH0NCj4gDQoNCldpbGwgZG8N
Cg0KPiANCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoZmx1c2hfbDFkX2NhY2hlX2h3KTsNCj4gPiAr
DQo+ID4gK3ZvaWQgZmx1c2hfbDFkX2NhY2hlX3N3KHZvaWQgKmwxZF9mbHVzaF9wYWdlcykNCj4g
PiArew0KPiA+ICsgICAgIGludCBzaXplID0gUEFHRV9TSVpFIDw8IEwxRF9DQUNIRV9PUkRFUjsN
Cj4gPiArDQo+ID4gKyAgICAgYXNtIHZvbGF0aWxlKA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAvKiBGaWxsIHRoZSBjYWNoZSAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAieG9ybCAg
ICUlZWF4LCAlJWVheFxuIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAiLkxmaWxsX2NhY2hl
OlxuIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAibW92emJsICglW2ZsdXNoX3BhZ2VzXSwg
JSUiIF9BU01fQVggIiksICUlZWN4XG5cdCINCj4gPiArICAgICAgICAgICAgICAgICAgICAgImFk
ZGwgICAkNjQsICUlZWF4XG5cdCINCj4gPiArICAgICAgICAgICAgICAgICAgICAgImNtcGwgICAl
JWVheCwgJVtzaXplXVxuXHQiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICJqbmUgICAgLkxm
aWxsX2NhY2hlXG5cdCINCj4gPiArICAgICAgICAgICAgICAgICAgICAgImxmZW5jZVxuIg0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICA6OiBbZmx1c2hfcGFnZXNdICJyIiAobDFkX2ZsdXNoX3Bh
Z2VzKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgW3NpemVdICJyIiAoc2l6ZSkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgOiAiZWF4IiwgImVjeCIpOw0KPiA+ICt9DQo+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKGZsdXNoX2wxZF9jYWNoZV9zdyk7DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jDQo+ID4gaW5kZXggMjA5
ZTYzNzk4NDM1Li4yOWRjNWE1YmI2YWIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva3ZtL3Zt
eC92bXguYw0KPiA+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gPiBAQCAtNTk1Niw4
ICs1OTU2LDYgQEAgc3RhdGljIGludCB2bXhfaGFuZGxlX2V4aXQoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LA0KPiA+ICAgKi8NCj4gPiAgc3RhdGljIHZvaWQgdm14X2wxZF9mbHVzaChzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUpDQo+ID4gIHsNCj4gPiAtICAgICBpbnQgc2l6ZSA9IFBBR0VfU0laRSA8PCBM
MURfQ0FDSEVfT1JERVI7DQo+ID4gLQ0KPiA+ICAgICAgIC8qDQo+ID4gICAgICAgICogVGhpcyBj
b2RlIGlzIG9ubHkgZXhlY3V0ZWQgd2hlbiB0aGUgdGhlIGZsdXNoIG1vZGUgaXMgJ2NvbmQnIG9y
DQo+ID4gICAgICAgICogJ2Fsd2F5cycNCj4gPiBAQCAtNTk4NiwzMiArNTk4NCwxMyBAQCBzdGF0
aWMgdm9pZCB2bXhfbDFkX2ZsdXNoKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gPiANCj4gPiAg
ICAgICB2Y3B1LT5zdGF0LmwxZF9mbHVzaCsrOw0KPiA+IA0KPiA+IC0gICAgIGlmIChzdGF0aWNf
Y3B1X2hhcyhYODZfRkVBVFVSRV9GTFVTSF9MMUQpKSB7DQo+ID4gLSAgICAgICAgICAgICB3cm1z
cmwoTVNSX0lBMzJfRkxVU0hfQ01ELCBMMURfRkxVU0gpOw0KPiA+ICsgICAgIGlmIChmbHVzaF9s
MWRfY2FjaGVfaHcoKSkNCj4gPiAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiAtICAgICB9DQo+
IA0KPiBUaGVuIHRoaXMgYmVjb21lczoNCj4gDQo+ICAgICAgICAgaWYgKGZsdXNoX2wxZF9jYWNo
ZV9odygpID09IDApDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAoT3IgY2hhbmdl
IGl0IHRvIGEgImJvb2wiIHdpdGggYW5kIHVzZSB0cnVlL2ZhbHNlIGFuZCBsZWF2ZSB0aGUgYWJv
dmUNCj4gY2FsbCBhcy1pcy4pDQo+IA0KPiBFaXRoZXIgd2F5Og0KPiANCj4gUmV2aWV3ZWQtYnk6
IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiANCg0KVGhhbmtzLA0KQmFsYmly
IFNpbmdoLg0KDQo=
