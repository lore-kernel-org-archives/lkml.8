Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB36206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IOAHgTi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgENHnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:43:39 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53671 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgENHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589442218; x=1620978218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wT4qOuj8Q9WmQhlnoAklk0PVnDme75ztxit48VsCt4Y=;
  b=IOAHgTi8LGHycwV603tFt666pLOVvh2wz8EVw3GgSUswfb2kIaRB9HTo
   8LJN2lwrOxb8dFAJvCpJpz/ygCqmG0zszsKIXTYsdZ63bST9EAifNY8dv
   HH6vkv6jPtIRlRShVD+j7iTNWPYCZ/7e7XnYQlGup171e4HCMMwWPDYaR
   A=;
IronPort-SDR: F4+iKVRbkwTG8vJQ5avP4DJw0g+vHrBVu9ciSr0yArblAjVPd1p4fQehfAVxc36pUTjuZL4S1n
 agaKAUHu68ow==
X-IronPort-AV: E=Sophos;i="5.73,390,1583193600"; 
   d="scan'208";a="43309552"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 May 2020 07:43:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 9708F223842;
        Thu, 14 May 2020 07:43:35 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 07:43:35 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 07:43:34 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 14 May 2020 07:43:34 +0000
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
Subject: Re:  [PATCH v6 5/6] Optionally flush L1D on context switch
Thread-Topic: [PATCH v6 5/6] Optionally flush L1D on context switch
Thread-Index: AQHWKcNfmceK11Or5k6H65l76p1aOw==
Date:   Thu, 14 May 2020 07:43:34 +0000
Message-ID: <c51109f10f6572f5cf60d2693f84ff8e65c7804a.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
         <20200510014803.12190-6-sblbir@amazon.com>
         <875zcz3j47.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zcz3j47.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8BDD1642743C40A94B0AE4AAF84B4C@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE4OjE2ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5jb20+IHdyaXRlczoNCj4gDQo+IFRoaXMg
cGFydDoNCj4gDQo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ByY3RsLmgNCj4gPiArKysg
Yi9pbmNsdWRlL3VhcGkvbGludXgvcHJjdGwuaA0KPiA+IEBAIC0yMzgsNCArMjM4LDggQEAgc3Ry
dWN0IHByY3RsX21tX21hcCB7DQo+ID4gICNkZWZpbmUgUFJfU0VUX0lPX0ZMVVNIRVIgICAgICAg
ICAgICA1Nw0KPiA+ICAjZGVmaW5lIFBSX0dFVF9JT19GTFVTSEVSICAgICAgICAgICAgNTgNCj4g
PiANCj4gPiArLyogRmx1c2ggTDFEIG9uIGNvbnRleHQgc3dpdGNoIChtbSkgKi8NCj4gPiArI2Rl
ZmluZSBQUl9TRVRfTDFEX0ZMVVNIICAgICAgICAgICAgIDU5DQo+ID4gKyNkZWZpbmUgUFJfR0VU
X0wxRF9GTFVTSCAgICAgICAgICAgICA2MA0KPiANCj4gLi4uDQo+IA0KPiA+IEBAIC0yNTE0LDYg
KzI1MjQsMTYgQEAgU1lTQ0FMTF9ERUZJTkU1KHByY3RsLCBpbnQsIG9wdGlvbiwgdW5zaWduZWQN
Cj4gPiBsb25nLCBhcmcyLCB1bnNpZ25lZCBsb25nLCBhcmczLA0KPiA+IA0KPiA+ICAgICAgICAg
ICAgICAgZXJyb3IgPSAoY3VycmVudC0+ZmxhZ3MgJiBQUl9JT19GTFVTSEVSKSA9PQ0KPiA+IFBS
X0lPX0ZMVVNIRVI7DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBjYXNlIFBS
X1NFVF9MMURfRkxVU0g6DQo+ID4gKyAgICAgICAgICAgICBpZiAoYXJnMyB8fCBhcmc0IHx8IGFy
ZzUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAg
ICAgICAgICAgZXJyb3IgPSBhcmNoX3ByY3RsX2wxZF9mbHVzaF9zZXQobWUsIGFyZzIpOw0KPiA+
ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgY2FzZSBQUl9HRVRfTDFEX0ZMVVNIOg0K
PiA+ICsgICAgICAgICAgICAgaWYgKGFyZzIgfHwgYXJnMyB8fCBhcmc0IHx8IGFyZzUpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICAg
ZXJyb3IgPSBhcmNoX3ByY3RsX2wxZF9mbHVzaF9nZXQobWUpOw0KPiA+ICsgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gICAgICAgZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICAgIGVycm9yID0gLUVJ
TlZBTDsNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiANCj4gd2FudHMgdG8gYmUgc3BsaXQg
aW50byBhIHNlcGFyYXRlIHBhdGNoLCByZWFsbHkuIFRoZW4gd2UgZ2V0IGEgcHJvcGVyDQo+IHN1
YmplY3QgbGluZXMgd2l0aCBwcm9wZXIgc3Vic3lzdGVtIHByZWZpeGVzLiBUaGlzIHBhcnQgYWxz
byBsYWNrcyBhDQo+IGRlc2NyaXB0aW9uIGluIERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS8g
YW5kIGZ1bmN0aW9uIHByb3RvdHlwZXMNCj4gZm9yDQo+IHRoZSBhcmNoX3ByY3RsKiBmdW5jdGlv
bnMuDQo+IA0KPiBCdXQgbG9va2luZyBhdCB0aGlzIGRlZXBlciAoeWVzIEkgc2hvdWxkIGhhdmUg
bm90aWNlZCBlYXJsaWVyKToNCj4gDQo+ICAgICBXaHkgZG8gd2UgbmVlZCB5ZXQgYW5vdGhlciBQ
UkNUTD8NCj4gDQo+IFdlIGFscmVhZHkgaGF2ZSBQUl9TRVRfU1BFQ1VMQVRJT05fQ1RSTC9QUl9H
RVRfU1BFQ1VMQVRJT05fQ1RSTC4gVGhhdA0KPiBMMUQgZmx1c2ggdGhpbmd5IGZpdHMgaW50byB0
aGlzIGNhdGVnb3J5LCByaWdodD8NCg0KSXQgZG9lcywgSSB0aG91Z2h0IGFib3V0IGl0IGZvciBh
IHdoaWxlIHdoZW4gSSB3YXMgY2hhbmdpbmcgdGhlIGNvZGUgYW5kDQpsZWZ0IGl0IGFzaWRlIGJl
Y2F1c2UsIGxvb2tpbmcgYXQgdGhlIGRlZmluaXRpb24NCg0KMSAgICBQUl9TUEVDX0VOQUJMRSAg
ICAgICAgIFRoZSBzcGVjdWxhdGlvbiBmZWF0dXJlIGlzIGVuYWJsZWQsDQptaXRpZ2F0aW9uIGlz
IGRpc2FibGVkLg0KMiAgICBQUl9TUEVDX0RJU0FCTEUgICAgICAgIFRoZSBzcGVjdWxhdGlvbiBm
ZWF0dXJlIGlzIGRpc2FibGVkLA0KbWl0aWdhdGlvbiBpcyBlbmFibGVkLg0KDQpXaXRoIEwxRCBm
bHVzaCwgdGhlcmUgaXMgbm8gb3ZlcnJpZGluZyBvZiB0aGUgZmVhdHVyZSBhcyBzdWNoIChhcyBp
bg0KZW5hYmxlIHdoZW4gdGhlIG1pdGlnYXRpb24gaXMgZGlzYWJsZWQgYW5kIHZpY2UtdmVyc2Ep
LiBJIGFtIGhhcHB5IHRvDQpyZWNvbnNpZGVyIG15IGluaXRpYWwgdGhvdWdodCB0aG91Z2guDQoN
Cg0KPiANCj4gVGhpcyBtYWtlcyBldmVuIG1vcmUgc2Vuc2UgaWYgeW91IHRoaW5rIGFib3V0IHRo
ZSBzZWNvbmQgdXNlIGNhc2UgZm9yDQo+IEwxRCBmbHVzaCwgaS5lLiB0aGUgZmx1c2ggd2hlbiBh
IHVudHJ1c3RlZCB0YXNrIGNvbWVzIGluLiBJZiB3ZSBldmVyDQo+IHdhbnQgdG8gc3VwcG9ydCB0
aGF0IGNhc2UgdGhlbiB0aGlzIHdpbGwgYmUgaW1wb3NlZCBieSBzZWNjb21wIGFuZA0KPiB0aGVu
DQo+IHdlJ2QgbmVlZCB5ZXQgYW5vdGhlciBpbnRlcmZhY2UgdGhlcmUuDQo+IA0KDQpZZXAsIEkg
c2VlIHdoYXQgeW91IG1lYW4NCg0KDQo+IEFuZCBmb3IgdGhpcyByZWFzb24gd2Ugc2hvdWxkIGFs
c28gbmFtZSB0aGF0IGN1cnJlbnQgb3B0LWluIHRoaW5neToNCj4gTDFEX0ZMVVNIX09VVCBpbiB0
aGUgcHJjdGwgYW5kIGFsc28gZm9yIHRoZSBUSUYgYml0cy4NCj4gDQo+IEhtbT8gS2Vlcz8NCj4g
DQo+IEkndmUgYXBwbGllZCB0aGUgZmlyc3QgNCBwYXRjaGVzIHRvOg0KPiANCj4gICBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgeDg2
L21tDQo+IA0KPiBzbyB0aGUgcG9saXNoaW5nIEkgZGlkIGdldHMgcHJlc2VydmVkIGFuZCB5b3Ug
ZG9uJ3QgaGF2ZSB0byByZXNlbmQgdGhlDQo+IHdob2xlIHBpbGUuDQo+IA0KDQpUaGFua3MsIEkg
dGhpbmsgeW91ciBjaGFuZ2UgdG8gcGF0Y2ggNiBtYWtlcyBzZW5zZSBhcyB3ZWxsLiBMZXQgbWUN
CnJlc3BpbiB0aGlzIGJhc2VkIG9uIHdoYXQgeW91IHRoaW5rIG9mIHRoZSBhcmd1bWVudCBhYm92
ZQ0KDQpCYWxiaXINCg0K
