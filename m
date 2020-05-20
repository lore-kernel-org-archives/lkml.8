Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642EEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434E0207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I7uLrec0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgETArb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:47:31 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3458 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589935650; x=1621471650;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=X/ckMTm6DagFws+fgX1faFpSPzIF3DucNoEn8weBuyo=;
  b=I7uLrec0Xalpo4n/NQUlnBc+WmfPpUasx+smBW3pnK4ENF+rZblRF5O0
   yWTaQs6Zcr3REffrR4GHfrqfk1wJSZk/xsDmarjkmgGnic8EWJgmA+gVE
   +fVMojPBqy+dG2/PoGtMAVh471UFWU3G6saOUojR3p3qfhN1EEq341g8T
   8=;
IronPort-SDR: A0JlgZVp7ZmZCqPbiZNe/UGepZ/OL/GEy6bzxI/M9lhcAjVXFCB7yL6hroJ0+T2ShdGNW4s6IC
 e0lVsBO2RPog==
X-IronPort-AV: E=Sophos;i="5.73,412,1583193600"; 
   d="scan'208";a="44534246"
Subject: Re: [PATCH v2 4/4] arch/x86: Add L1D flushing Documentation
Thread-Topic: [PATCH v2 4/4] arch/x86: Add L1D flushing Documentation
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 May 2020 00:47:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id A5014A20D5;
        Wed, 20 May 2020 00:47:24 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 May 2020 00:47:24 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 May 2020 00:47:23 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Wed, 20 May 2020 00:47:23 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWC8KTBtatWwah2kid46QoFKC446ivz/CAgACY/YA=
Date:   Wed, 20 May 2020 00:47:23 +0000
Message-ID: <fc9bc2f25fa082865d1b5ec98bfd7d02fe7cf00d.camel@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
         <20200406031946.11815-5-sblbir@amazon.com>
         <5def424d-c7d5-c6fa-60b9-363f6bca6bc6@infradead.org>
In-Reply-To: <5def424d-c7d5-c6fa-60b9-363f6bca6bc6@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFBBED2A1FBA17459853E791DB97C90C@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTE5IGF0IDA4OjM5IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IA0KPiBIaS0tDQo+IA0KPiBDb21tZW50cyBiZWxvdy4gU29ycnkgYWJvdXQgdGhlIGRlbGF5Lg0K
PiANCj4gT24gNC81LzIwIDg6MTkgUE0sIEJhbGJpciBTaW5naCB3cm90ZToNCj4gPiBBZGQgZG9j
dW1lbnRhdGlvbiBvZiBsMWQgZmx1c2hpbmcsIGV4cGxhaW4gdGhlIG5lZWQgZm9yIHRoZQ0KPiA+
IGZlYXR1cmUgYW5kIGhvdyBpdCBjYW4gYmUgdXNlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vaW5kZXgucnN0ICAgfCAgMSArDQo+ID4gIC4uLi9h
ZG1pbi1ndWlkZS9ody12dWxuL2wxZF9mbHVzaC5yc3QgICAgICAgICB8IDQwICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vbDFkX2Zs
dXNoLnJzdA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1
bG4vbDFkX2ZsdXNoLnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHctdnVsbi9sMWRf
Zmx1c2gucnN0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjczZWU5ZTQ5MWE3NA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vbDFkX2ZsdXNoLnJzdA0KPiA+IEBAIC0wLDAgKzEsNDAg
QEANCj4gPiArTDFEIEZsdXNoaW5nIGZvciB0aGUgcGFyYW5vaWQNCj4gPiArPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4gPiArDQo+ID4gK1dpdGggYW4gaW5jcmVhc2luZyBudW1iZXIg
b2YgdnVsbmVyYWJpbGl0aWVzIGJlaW5nIHJlcG9ydGVkIGFyb3VuZCBkYXRhDQo+ID4gK2xlYWtz
IGZyb20gTDFELCBhIG5ldyB1c2VyIHNwYWNlIG1lY2hhbmlzbSB0byBmbHVzaCB0aGUgTDFEIGNh
Y2hlIG9uDQo+ID4gK2NvbnRleHQgc3dpdGNoIGlzIGFkZGVkIHRvIHRoZSBrZXJuZWwuIFRoaXMg
c2hvdWxkIGhlbHAgYWRkcmVzcw0KPiA+ICtDVkUtMjAyMC0wNTUwIGFuZCBmb3IgcGFyYW5vaWQg
YXBwbGljYXRpb25zLCBrZWVwIHRoZW0gc2FmZSBmcm9tIGFueQ0KPiA+ICt5ZXQgdG8gYmUgZGlz
Y292ZXJlZCB2dWxuZXJhYmlsaXRpZXMsIHJlbGF0ZWQgdG8gbGVha3MgZnJvbSB0aGUgTDFEDQo+
ID4gK2NhY2hlLg0KPiA+ICsNCj4gPiArVGFza3MgY2FuIG9wdCBpbiB0byB0aGlzIG1lY2hhbmlz
bSBieSB1c2luZyBhbiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMNCj4gPiArcHJjdGwgKHg4NiBvbmx5
IGF0IHRoZSBtb21lbnQpLg0KPiA+ICsNCj4gPiArUmVsYXRlZCBDVkVTDQo+IA0KPiAgICAgICAg
ICAgIENWRXMNCj4gDQo+ID4gKy0tLS0tLS0tLS0tLQ0KPiA+ICtBdCB0aGUgcHJlc2VudCBtb21l
bnQsIHRoZSBmb2xsb3dpbmcgQ1ZFcyBjYW4gYmUgYWRkcmVzc2VkIGJ5IHRoaXMNCj4gPiArbWVj
aGFuaXNtDQo+ID4gKw0KPiA+ICsgICAgPT09PT09PT09PT09PSAgICAgICA9PT09PT09PT09PT09
PT09PT09PT09PT0gICAgID09PT09PT09PT09PT09PT09PQ0KPiA+ICsgICAgQ1ZFLTIwMjAtMDU1
MCAgICAgICBJbXByb3BlciBEYXRhIEZvcndhcmRpbmcgICAgIE9TIHJlbGF0ZWQgYXNwZWN0cw0K
PiA+ICsgICAgPT09PT09PT09PT09PSAgICAgICA9PT09PT09PT09PT09PT09PT09PT09PT0gICAg
ID09PT09PT09PT09PT09PT09PQ0KPiA+ICsNCj4gPiArVXNhZ2UgR3VpZGVsaW5lcw0KPiA+ICst
LS0tLS0tLS0tLS0tLS0tDQo+ID4gK0FwcGxpY2F0aW9ucyBjYW4gY2FsbCBgYGFyY2hfcHJjdGwo
MilgYCB3aXRoIG9uZSBvZiB0aGVzZSB0d28gYXJndW1lbnRzDQo+IA0KPiBlbmQgYWJvdmUgc2Vu
dGVuY2Ugd2l0aCBwZXJpb2Qgb3IgY29sb24gKGNvbG9uIG1pZ2h0IHJlcXVpcmUgdGhlIGZvbGxv
d2luZw0KPiBidWxsZXQgaXRlbXMgdG8gYmUgaW5kZW50ZWQgLS0gSSdtIG5vdCBzdXJlIGFib3V0
IHRoYXQpLg0KDQpJJ2xsIHRha2UgYSBsb29rDQoNCj4gDQo+ID4gKw0KPiA+ICsxLiBBUkNIX1NF
VF9MMURfRkxVU0ggLSBmbHVzaCB0aGUgTDFEIGNhY2hlIG9uIGNvbnRleHQgc3dpdGNoIChvdXQp
DQo+ID4gKzIuIEFSQ0hfR0VUX0wxRF9GTFVTSCAtIGdldCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0
aGUgTDFEIGNhY2hlIGZsdXNoLCByZXR1cm5zIDENCj4gPiArICAgaWYgc2V0IGFuZCAwIGlmIG5v
dCBzZXQuDQo+ID4gKw0KPiA+ICsqKk5PVEUqKjogVGhlIGZlYXR1cmUgaXMgZGlzYWJsZWQgYnkg
ZGVmYXVsdCwgYXBwbGljYXRpb25zIHRvIG5lZWQgdG8gc3BlY2lmaWNhbGx5DQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVsdDsgYXBwbGljYXRpb25z
IG5lZWQgdG8NCj4gDQo+ID4gK29wdCBpbnRvIHRoZSBmZWF0dXJlIHRvIGVuYWJsZSBpdC4NCj4g
PiArDQo+ID4gK01pdGlnYXRpb24NCj4gPiArLS0tLS0tLS0tLQ0KPiA+ICtXaGVuIEFSQ0hfU0VU
X0wxRF9GTFVTSCBpcyBlbmFibGVkIGZvciBhIHRhc2ssIG9uIHN3aXRjaGluZyB0YXNrcyAod2hl
bg0KPiA+ICt0aGUgYWRkcmVzcyBzcGFjZSBjaGFuZ2VzKSwgYSBmbHVzaCBvZiB0aGUgTDFEIGNh
Y2hlIGlzIHBlcmZvcm1lZCBmb3INCj4gPiArdGhlIHRhc2sgd2hlbiBpdCBsZWF2ZXMgdGhlIENQ
VS4gSWYgdGhlIHVuZGVybHlpbmcgQ1BVIHN1cHBvcnRzIEwxRA0KPiA+ICtmbHVzaGluZyBpbiBo
YXJkd2FyZSwgdGhlIGhhcmR3YXJlIG1lY2hhbmlzbSBpcyB1c2VkLCBvdGhlcndpc2UgYSBzb2Z0
d2FyZQ0KPiA+ICtmYWxsYmFjaywgc2ltaWxhciB0byB0aGUgbWVjaGFuaXNtIHVzZWQgYnkgTDFU
RiBpcyB1c2VkLg0KPiA+IA0KPiANCg0KSSdsbCB3b3JrIG9uIHRoZXNlIGFuZCB1cGRhdGUgYmFz
ZWQgb24gbW9yZSBmZWVkYmFjayBvbiB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzLg0KDQpCYWxiaXIg
U2luZ2guDQoNCg==
