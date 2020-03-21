Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA2C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E320722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fyXd7zbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCUBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:42:42 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59865 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCUBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584754960; x=1616290960;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=P03uhPdw11jrxl6E82CoGwg+nTsQWcGa0B+WJNlZ+6Q=;
  b=fyXd7zbWLx4SyXb2XgsZ1W9WkFsZrvFI1NScuFtwJRarSpuGfIYyFfUT
   6VuwUXZyEA8pagbu/jFE7sRKAB7+d8FLkhzYkMYNcwSFs6nYm3SEZZEbG
   Ys0EjyLIxQR454AUuq4KkKc7sFwf54qA6qOYQFVtGU6+wHfTTkec8JPiW
   4=;
IronPort-SDR: ajbOZDbqko60UBcFW+ZM097+OI3y1dF3WHVmP2q1KH33IlVNJdrlEMUCrWkHNcuzpmgy6rdCC4
 6CQgKX5w2/hA==
X-IronPort-AV: E=Sophos;i="5.72,286,1580774400"; 
   d="scan'208";a="24240275"
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Mar 2020 01:42:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id EED33A0766;
        Sat, 21 Mar 2020 01:42:35 +0000 (UTC)
Received: from EX13D21UWB001.ant.amazon.com (10.43.161.108) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 21 Mar 2020 01:42:34 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D21UWB001.ant.amazon.com (10.43.161.108) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 21 Mar 2020 01:42:34 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Sat, 21 Mar 2020 01:42:34 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHV+YNfBeR2nut5dUuur/1Y5KcywKhPGnoAgAFvAYCAAN6oAIAA6NAA
Date:   Sat, 21 Mar 2020 01:42:34 +0000
Message-ID: <034a2c0e2cc1bb0f4f7ff9a2c5cbdc269a483a71.camel@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com>
         <87imj19o13.fsf@nanos.tec.linutronix.de>
         <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com>
         <8736a3456r.fsf@nanos.tec.linutronix.de>
In-Reply-To: <8736a3456r.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.219]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C62385010ECC364AA36B731BF6000FB8@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTIwIGF0IDEyOjQ5ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBCYWxiaXIsDQo+IA0KPiAiU2luZ2gsIEJhbGJpciIgPHNibGJpckBhbWF6b24uY29t
PiB3cml0ZXM6DQo+ID4gT24gVGh1LCAyMDIwLTAzLTE5IGF0IDAxOjM4ICswMTAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+ID4gPiBXaGF0J3MgdGhlIHBvaW50PyBUaGUgYXR0YWNrIHN1cmZh
Y2UgaXMgdGhlIEwxRCBjb250ZW50IG9mIHRoZSBzY2hlZHVsZWQNCj4gPiA+IG91dCB0YXNrLiBJ
ZiB0aGUgbWFsaWNpb3VzIHRhc2sgc2NoZWR1bGVzIG91dCwgdGhlbiB3aHkgd291bGQgeW91IGNh
cmU/DQo+ID4gPiANCj4gPiA+IEkgbWlnaHQgYmUgbWlzc2luZyBzb21ldGhpbmcsIGJ1dCBBRkFJ
Q1QgdGhpcyBpcyBiZXlvbmQgcGFyYW5vaWEuDQo+ID4gPiANCj4gPiANCj4gPiBJIHRoaW5rIHRo
ZXJlIGFyZSB0d28gY2FzZXMNCj4gPiANCj4gPiAxLiBUYXNrIHdpdGggaW1wb3J0YW50IGRhdGEg
c2NoZWR1bGVzIG91dA0KPiA+IDIuIE1hbGljaW91cyB0YXNrIHNjaGVkdWxlcyBpbg0KPiA+IA0K
PiA+IFRoZXNlIHBhdGNoZXMgYWRkcmVzcyAxLCBidXQgY2FsbCBvdXQgY2FzZSAjMg0KPiANCj4g
VGhlIHBvaW50IGlzIGlmIHRoZSB2aWN0aW0gdGFzayBzY2hlZHVsZXMgb3V0LCB0aGVuIHRoZXJl
IGlzIG5vIHJlYXNvbg0KPiB0byBmbHVzaCBMMUQgaW1tZWRpYXRlbHkgaW4gY29udGV4dCBzd2l0
Y2guIElmIHRoYXQganVzdCBzY2hlZHVsZXMgYQ0KPiBrZXJuZWwgdGhyZWFkIGFuZCB0aGVuIGdv
ZXMgYmFjayB0byB0aGUgdGFzaywgdGhlbiB0aGVyZSBpcyBubyBwb2ludA0KPiB1bmxlc3MgeW91
IGRvIG5vdCBldmVuIHRydXN0IHRoZSBrZXJuZWwgdGhyZWFkLg0KDQpZZXMsIHRoZSBpbXBsZW1l
bnRhdGlvbiB0cmllcyB0byBkbyB0aGF0IGJ5IHRyYWNraW5nIHN3aXRjaF9tbSgpLiANCg0KPiAN
Cj4gPiA+ID4gMy4gVGhlcmUgaXMgYSBmYWxsYmFjayBzb2Z0d2FyZSBMMUQgbG9hZCwgc2ltaWxh
ciB0byB3aGF0IEwxVEYgZG9lcywNCj4gPiA+ID4gYnV0DQo+ID4gPiA+ICAgIHdlIGRvbid0IHBy
ZWZldGNoIHRoZSBUTEIsIGlzIHRoYXQgc3VmZmljaWVudD8NCj4gPiA+IA0KPiA+ID4gSWYgd2Ug
Z28gdGhlcmUsIHRoZW4gdGhlIEtWTSBMMUQgZmx1c2ggY29kZSB3YW50cyB0byBtb3ZlIGludG8g
Z2VuZXJhbA0KPiA+ID4geDg2IGNvZGUuDQo+ID4gDQo+ID4gT0suLiB3ZSBjYW4gZGVmaW5pdGVs
eSBjb25zaWRlciByZXVzaW5nIGNvZGUsIGJ1dCBJIHRoaW5rIHRoZSBLVk0gYml0cw0KPiA+IHJl
cXVpcmUNCj4gPiB0bGIgcHJlZmV0Y2hpbmcsIElJVUMgYmVmb3JlIGNhY2hlIGZsdXNoIHRvIG5l
Z2F0ZSBhbnkgYmFkIHRyYW5zbGF0aW9ucw0KPiA+IGFzc29jaWF0ZWQgd2l0aCBhbiBMMVRGIGZh
dWx0LCBidXQgdGhlIGNvZGUvY29tbWVudHMgYXJlIG5vdCBjbGVhciBvbiB0aGUNCj4gPiBuZWVk
DQo+ID4gdG8gZG8gc28uDQo+IA0KPiBJIGZvcmdvdCB0aGUgZ29yeSBkZXRhaWxzIGJ5IG5vdywg
YnV0IGhhdmluZyB0d28gZW50cnkgcG9pbnRzIG9yIGENCj4gY29uZGl0aW9uYWwgYW5kIHNoYXJl
IHRoZSByZXN0IChwYWdlIGFsbG9jYXRpb24gZXRjLikgaXMgZGVmaW5pdGVseQ0KPiBiZXR0ZXIg
dGhhbiB0d28gc2xpZ2h0bHkgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uIHdoaWNoIGJhc2ljYWxs
eSBkbyB0aGUNCj4gc2FtZSB0aGluZy4NCg0KT0ssIEkgY2FuIHRyeSBhbmQgZGVkdXAgdGhlbSB0
byB0aGUgZXh0ZW50IHBvc3NpYmxlLCBidXQgcGxlYXNlIGRvIHJlbWVtYmVyDQp0aGF0IA0KDQox
LiBLVk0gaXMgdXN1YWxseSBsb2FkZWQgYXMgYSBtb2R1bGUNCjIuIEtWTSBpcyBvcHRpb25hbA0K
DQpXZSBjYW4gc2hhcmUgY29kZSwgYnkgcHV0dGluZyB0aGUgY29tbW9uIGJpdHMgaW4gdGhlIGNv
cmUga2VybmVsLg0KDQo+IA0KPiA+ID4gPiArdm9pZCBlbmFibGVfbDFkX2ZsdXNoX2Zvcl90YXNr
KHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgICBzdHJ1
Y3QgcGFnZSAqcGFnZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBpZiAoc3RhdGljX2NwdV9o
YXMoWDg2X0ZFQVRVUkVfRkxVU0hfTDFEKSkNCj4gPiA+ID4gKyAgICAgICAgICAgICBnb3RvIGRv
bmU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgbXV0ZXhfbG9jaygmbDFkX2ZsdXNoX211dGV4
KTsNCj4gPiA+ID4gKyAgICAgaWYgKGwxZF9mbHVzaF9wYWdlcykNCj4gPiA+ID4gKyAgICAgICAg
ICAgICBnb3RvIGRvbmU7DQo+ID4gPiA+ICsgICAgIC8qDQo+ID4gPiA+ICsgICAgICAqIFRoZXNl
IHBhZ2VzIGFyZSBuZXZlciBmcmVlZCwgd2UgdXNlIHRoZSBzYW1lDQo+ID4gPiA+ICsgICAgICAq
IHNldCBvZiBwYWdlcyBhY3Jvc3MgbXVsdGlwbGUgcHJvY2Vzc2VzL2NvbnRleHRzDQo+ID4gPiA+
ICsgICAgICAqLw0KPiA+ID4gPiArICAgICBwYWdlID0gYWxsb2NfcGFnZXMoR0ZQX0tFUk5FTCB8
IF9fR0ZQX1pFUk8sIEwxRF9DQUNIRV9PUkRFUik7DQo+ID4gPiA+ICsgICAgIGlmICghcGFnZSkN
Cj4gPiA+ID4gKyAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAg
bDFkX2ZsdXNoX3BhZ2VzID0gcGFnZV9hZGRyZXNzKHBhZ2UpOw0KPiA+ID4gPiArICAgICAvKiBJ
IGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gd29ycnkgYWJvdXQgS1NNICovDQo+ID4gPiANCj4gPiA+
IFdoeSBub3Q/IEV2ZW4gaWYgaXQgd291bGRuJ3QgYmUgbmVjZXNzYXJ5IHdoeSB3b3VsZCB3ZSBj
YXJlIGFzIHRoaXMgaXMgYQ0KPiA+ID4gb25jZSBwZXIgYm9vdCBvcGVyYXRpb24gaW4gZnVsbHkg
cHJlZW1wdGlibGUgY29kZS4NCj4gPiANCj4gPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgeW91ciBx
dWVzdGlvbiwgSSB3YXMgc3RhdGluZyB0aGF0IGV2ZW4gaWYgS1NNIHdhcw0KPiA+IHJ1bm5pbmcs
IGl0IHdvdWxkIG5vdCBpbXBhY3QgdXMgKHdpdGggZGVkdXApLCBhcyB3ZSdkIHN0aWxsIGJlIHdy
aXRpbmcgb3V0DQo+ID4gMHMNCj4gPiB0byB0aGUgY2FjaGUgbGluZSBpbiB0aGUgZmFsbGJhY2sg
Y2FzZS4NCj4gDQo+IEkgcHJvYmFibHkgY29uZnVzZWQgbXlzZWxmIHZzLiB0aGUgY29tbWVudCBp
biB0aGUgVk1YIGNvZGUsIGJ1dCB0aGF0DQo+IG1lbnRpb25zIG5lc3RlZCB2aXJ0LiBOZWVkcyBh
dCBsZWFzdCBzb21lIGNvbnNpZGVyYXRpb24gd2hlbiB3ZSByZXVzZQ0KPiB0aGF0IGNvZGUuDQoN
ClllcywgZGVmaW5pdGVseSENCg0KPiANCj4gPiA+ID4gIHZvaWQgc3dpdGNoX21tKHN0cnVjdCBt
bV9zdHJ1Y3QgKnByZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm5leHQsDQo+ID4gPiA+ICAgICAgICAg
ICAgICBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykNCj4gPiA+ID4gIHsNCj4gPiA+ID4gQEAgLTQz
Myw2ICs1MTksOCBAQCB2b2lkIHN3aXRjaF9tbV9pcnFzX29mZihzdHJ1Y3QgbW1fc3RydWN0ICpw
cmV2LA0KPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gbW1fc3RydWN0ICpuZXh0LA0KPiA+ID4gPiAg
ICAgICAgICAgICAgIHRyYWNlX3RsYl9mbHVzaF9yY3VpZGxlKFRMQl9GTFVTSF9PTl9UQVNLX1NX
SVRDSCwgMCk7DQo+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4gDQo+ID4gPiA+ICsgICAgIGwxZF9m
bHVzaChuZXh0LCB0c2spOw0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIHJlYWxseSB0aGUgd3Jvbmcg
cGxhY2UuIFlvdSB3YW50IHRvIGRvIHRoYXQ6DQo+ID4gPiANCj4gPiA+ICAgMSkgSnVzdCBiZWZv
cmUgcmV0dXJuIHRvIHVzZXIgc3BhY2UNCj4gPiA+ICAgMikgV2hlbiBlbnRlcmluZyBhIGd1ZXN0
DQo+ID4gPiANCj4gPiA+IGFuZCBvbmx5IHdoZW4gdGhlIHByZXZpb3VzbHkgcnVubmluZyB1c2Vy
IHNwYWNlIHRhc2sgd2FzIHRoZSBvbmUgd2hpY2gNCj4gPiA+IHJlcXVlc3RlZCB0aGlzIG1hc3Np
dmUgcHJvdGVjdGlvbi4NCj4gPiA+IA0KPiA+IA0KPiA+IENhc2VzIDEgYW5kIDIgYXJlIGhhbmRs
ZWQgdmlhDQo+ID4gDQo+ID4gMS4gU1dBUEdTIGZpeGVzL3dvcmsgYXJvdW5kcyAodW5sZXNzIEkg
bWlzdW5kZXJzdG9vZCB5b3VyIHN1Z2dlc3Rpb24pDQo+IA0KPiBIb3cgc28/IFNXQVBHUyBtaXRp
Z2F0aW9uIGRvZXMgbm90IGZsdXNoIEwxRC4gSXQgbWVyaWx5IHNlcmlhbGl6ZXMgU1dBUEdTLg0K
DQpTb3JyeSwgbXkgYmFkLCBJIHdhcyB0aGlua2luZyBNRFNfQ0xFQVIgKHZpYSB2ZXJ3KSwgd2hp
Y2ggZG9lcyBmbHVzaCBvdXQNCnRoaW5ncywgd2hpY2ggSSBzdXNwZWN0IHNob3VsZCBiZSBzdWZm
aWNpZW50IGZyb20gYSByZXR1cm4gdG8gdXNlci9zaWduYWwNCmhhbmRsaW5nLCBldGMgcGVyc3Bl
Y3RpdmUuIFJpZ2h0IG5vdywgcmVhZGluZyB0aHJvdWdoIA0KaHR0cHM6Ly9zb2Z0d2FyZS5pbnRl
bC5jb20vc2VjdXJpdHktc29mdHdhcmUtZ3VpZGFuY2UvaW5zaWdodHMvZGVlcC1kaXZlLXNub29w
LWFzc2lzdGVkLWwxLWRhdGEtc2FtcGxpbmcNCiwgaXQgZG9lcyBzZWVtIGxpa2Ugd2UgbmVlZCB0
aGlzIGR1cmluZyBhIGNvbnRleHQgc3dpdGNoLCBzcGVjaWZpY2FsbHkgc2luY2UgYQ0KZGlydHkg
Y2FjaGUgbGluZSBjYW4gY2F1c2Ugc25vb3BlZCByZWFkcyBmb3IgdGhlIGF0dGFja2VyIHRvIGxl
YWsgZGF0YS4gQW0gSQ0KbWlzc2luZyBhbnl0aGluZz8NCg0KPiANCj4gPiAyLiBMMVRGIGZhdWx0
IGhhbmRsaW5nDQo+ID4gDQo+ID4gVGhpcyBtZWNoYW5pc20gYWxsb3dzIGZvciBmbHVzaGluZyBu
b3QgcmVzdHJpY3RlZCB0byAxIG9yIDIsIHRoZSBpZGVhIGlzDQo+ID4gdG8NCj4gPiBpbW1lZGlh
dGVseSBmbHVzaCBMMUQgZm9yIHBhcmFub2lkIHByb2Nlc3NlcyBvbiBtbSBzd2l0Y2guDQo+IA0K
PiBXaHk/IFRvIHByb3RlY3QgdGhlIHZpY3RpbSB0YXNrIGFnYWluc3QgdGhlIG1hbGljaW91cyBr
ZXJuZWw/DQo+IA0KPiBUaGUgTDFEIGNvbnRlbnQgb2YgdGhlIHZpY3RpbSBpcyBlbmRhbmdlcmVk
IGluIHRoZSBmb2xsb3dpbmcgY2FzZToNCj4gDQo+ICAgICB2aWN0aW0gb3V0IC0+IGF0dGFja2Vy
IGluDQo+IA0KPiBUaGUgYXR0YWNrZXIgY2FuIGVpdGhlciBydW4gaW4gdXNlciBzcGFjZSBvciBp
biBndWVzdCBtb2RlLiBTbyB0aGUgZmx1c2gNCj4gaXMgb25seSBpbnRlcmVzdGluZyB3aGVuIHRo
ZSBhdHRhY2tlciBhY3R1YWxseSBnb2VzIGJhY2sgdG8gdXNlciBzcGFjZQ0KPiBvciByZWVudGVy
cyB0aGUgZ3Vlc3QuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGlzIGNvbXBsZXRlbHkgdW5pbnRlcmVz
dGluZzoNCj4gDQo+ICAgICB2aWN0aW0gb3V0IC0+IGtlcm5lbCB0aHJlYWQgaW4vb3V0IC0+IHZp
Y3RpbSBpbg0KPiANCj4gRXZlbiB0aGlzIGlzIHVuaW50ZXJlc3Rpbmc6DQo+IA0KPiAgICAgdmlj
dGltIGluIC0+IGF0dGFja2VyIGluIChzdGF5cyBpbiBrZXJuZWwsIGUuZy4gd2FpdHMgZm9yIGRh
dGEpIC0+DQo+ICAgICBhdHRhY2tlciBvdXQgLT4gdmljdGltIGluDQo+IA0KDQpOb3QgZnJvbSB3
aGF0IEkgdW5kZXJzdGFuZCBmcm9tIHRoZSBsaW5rIGFib3ZlLCB0aGUgYXR0YWNrIGlzIGEgZnVu
Y3Rpb24gb2YNCndoYXQgY2FuIGJlIHNub29wZWQgYnkgYW5vdGhlciBjb3JlL3RocmVhZCBhbmQg
dGhhdCBpcyBhIGZ1bmN0aW9uIG9mIHdoYXQNCm1vZGlmaWVkIHNlY3JldHMgYXJlIGluIHRoZSBj
YWNoZSBsaW5lL3N0b3JlIGJ1ZmZlci4NCg0KDQo+IFNvIHRoZSBwb2ludCB3aGVyZSB5b3Ugd2Fu
dCB0byBmbHVzaCBjb25kaXRpb25hbGx5IGlzIHdoZW4gdGhlIGF0dGFja2VyDQo+IGxlYXZlcyBr
ZXJuZWwgc3BhY2UgZWl0aGVyIHRvIHVzZXIgbW9kZSBvciBndWVzdCBtb2RlLg0KPiANCj4gU28g
aWYgdGhlIHZpY3RpbSBzY2hlZHVsZXMgb3V0IGl0IHNldHMgYSBwZXIgY3B1IHJlcXVlc3QgdG8g
Zmx1c2ggTDFEDQo+IG9uIHRoZSBib3JkZXJzLg0KPiANCj4gQW5kIHRoZW4geW91IGhhdmUgb24g
cmV0dXJuIHRvIHVzZXI6DQo+IA0KPiAgICAgaWYgKHRoaXNfY3B1X2ZsdXNoX2wxZCgpKQ0KPiAg
ICAgICAgIGZsdXNoX2wxZCgpDQo+IA0KPiBhbmQgaW4ga3ZtOg0KPiANCj4gICAgIGlmICh0aGlz
X2NwdV9mbHVzaF9sMWQoKSB8fCBMMVRGX2ZsdXNoX0wxRCkNCj4gICAgICAgICBmbHVzaF9sMWQo
KQ0KPiANCj4gVGhlIHJlcXVlc3QgZG9lczoNCj4gDQo+ICAgICBpZiAoIXRoaXNfY3B1X3JlYWQo
bDFkX2ZsdXNoX2Zvcl90YXNrKSkNCj4gICAgICAgICB0aGlzX2NwdV93cml0ZShsMWRfZmx1c2hf
Zm9yX3Rhc2ssIGN1cnJlbnQpDQo+IA0KPiBUaGUgY2hlY2sgZG9lczoNCj4gDQo+ICAgICBwID0g
dGhpc19jcHVfcmVhZChsMWRfZmx1c2hfZm9yX3Rhc2spOw0KPiAgICAgaWYgKHApIHsNCj4gICAg
ICAgICB0aGlzX2NwdV93cml0ZShsMWRfZmx1c2hfZm9yX3Rhc2ssIE5VTEwpOw0KPiAgICAgICAg
IHJldHVybiBwICE9IGN1cnJlbnQ7DQo+ICAgICB9DQo+ICAgICByZXR1cm4gZmFsc2U7DQo+IA0K
PiBIbW0/DQoNCk9uIHJldHVybiB0byB1c2VyLCB3ZSBhbHJlYWR5IHVzZSBWRVJXICh2ZXJ3KSwg
YnV0IGp1c3QgcmV0dXJuIHRvIHVzZXINCnByb3RlY3Rpb24gaXMgbm90IHN1ZmZpY2llbnQgSU1I
Ty4gQmFzZWQgb24gdGhlIGxpbmsgYWJvdmUsIHdlIG5lZWQgdG8gY2xlYXINCnRoZSBMMUQgY2Fj
aGUgYmVmb3JlIGl0IGNhbiBiZSBzbm9vcGVkLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsDQpC
YWxiaXIgU2luZ2gNCg0K
