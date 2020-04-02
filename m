Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C230EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917C2206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TEG4Lp1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbgDBWYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:24:06 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:19154 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585866246; x=1617402246;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=M/fTHiiTfTqWAYDRfIup3tvNO526R1ZSWUN4QpIFN68=;
  b=TEG4Lp1UiLN2XNXpCtkOrYGTX3TAfBc9o2qKo8vif/QIOuXGFD6DpWWz
   74fclfBx3v284H+IKdU6FwO4CgGR65kMPQMIg29uR6FRgoj6pusZtdujH
   ClpN+E95iSyW8qMML5/u8XB7aPMSWr5p3Hrp/8bciaEiUmN49nymSCaoE
   Y=;
IronPort-SDR: CNp7QJexbmMmslgKbUccPTyyFqhl1WLPv4UA9skLgqkA8lkpkviQnda+3aVsHgzNcWV5R8wXvb
 W1EYbMoXm1mg==
X-IronPort-AV: E=Sophos;i="5.72,337,1580774400"; 
   d="scan'208";a="23907680"
Subject: Re: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Apr 2020 22:23:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 0E2C028833F;
        Thu,  2 Apr 2020 22:23:51 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Apr 2020 22:23:50 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 22:23:50 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 2 Apr 2020 22:23:50 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWCLef4bwaosvK0kiEVSQik6PTPKhmROgAgAAGOQCAAANggIAAD/uAgAAK1AA=
Date:   Thu, 2 Apr 2020 22:23:50 +0000
Message-ID: <efd011693768994a40fade46d858dbf14384b538.camel@amazon.com>
References: <20200402062401.29856-1-sblbir@amazon.com>
         <20200402201328.zqnxwaetpk4ubg56@treble>
         <31c9720eff18ce167378e9a0017dcd73e0552164.camel@amazon.com>
         <20200402204749.33ulub5jx66dktxg@treble>
         <875zehmujm.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zehmujm.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.90]
Content-Type: text/plain; charset="utf-8"
Content-ID: <21808619CF4E2D45A69E6BD493A42BCC@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTAyIGF0IDIzOjQ1ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90DQo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+IA0KPiANCj4gDQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29t
PiB3cml0ZXM6DQo+ID4gT24gVGh1LCBBcHIgMDIsIDIwMjAgYXQgMDg6MzU6NDZQTSArMDAwMCwg
U2luZ2gsIEJhbGJpciB3cm90ZToNCj4gPiA+IFllcywgdGhhdCBDVkUgdGhlIG1vdGl2YXRpb24s
IHRoZSBtaXRpZ2F0aW9uIGZvciBDVkUtMjAyMC0wNTUwIGRvZXMNCj4gPiA+IHN1Z2dlc3QNCj4g
PiA+IGZsdXNoaW5nIHRoZSBjYWNoZSBvbiBjb250ZXh0IHN3aXRjaC4gQnV0IGluIGdlbmVyYWws
IGFzIHdlIGJlZ2luIHRvDQo+ID4gPiBmaW5kIG1vcmUNCj4gPiA+IHdheXMgb2YgZXZpY3Rpbmcg
ZGF0YSBvciBzbm9wcGluZyBkYXRhLCBhIGdlbmVyaWMgbWVjaGFuaXNtIGlzIG1vcmUNCj4gPiA+
IHVzZWZ1bCBhbmQNCj4gPiA+IHRoYXQgaXMgd2h5IEkgYW0gbWFraW5nIGl0IGFuIG9wdC1pbi4N
Cj4gPiANCj4gPiBPay4gIEkgdGhpbmsgaXQgd291bGQgYmUgYSBnb29kIGlkZWEgdG8gZXhwYW5k
IG9uIHRoYXQganVzdGlmaWNhdGlvbg0KPiA+IG1vcmUgcHJlY2lzZWx5IGluIHRoZSBjb21taXQg
bWVzc2FnZS4gIFRoYXQgd291bGQgaGVscCBib3RoIHJldmlld2VycyBvZg0KPiA+IHRoZSBjb2Rl
IGFuZCB1c2VycyBvZiB0aGUgbmV3IG9wdGlvbiB1bmRlcnN0YW5kIHdoYXQgbGV2ZWwgb2YgcGFy
YW5vaWENCj4gPiB0aGV5J3JlIG9wdGluZyBpbiB0byA6LSkNCj4gDQo+IFRoZSBjb21taXQgbWVz
c2FnZSBpcyBtb3N0bHkgdXNlZnVsIGZvciByZXZpZXdlcnMgYW5kIHBlb3BsZSB3aG8gaGF2ZSB0
bw0KPiBkbyBjb2RlIGFyY2hlYW9sb2d5Lg0KPiANCj4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9ody12dWxuLyBoYXMgcGxlbnR5IG9mIHNwYWNlIHRvIGhvc3QgYQ0KPiBkb2N1bWVudCB3aXRo
IGV4cGxhbmF0aW9ucy4gcGFyYW5vaWEucnN0IGNvbWVzIHRvIG15IG1pbmQuIDopDQoNCkkgaG9w
ZSBwZW9wbGUgZG9uJ3QgZ28gbG9va2luZyBmb3IgYWxpZW5zIGluIHRoZXJlIDopIEknbGwgd3Jp
dGUgdXAgc29tZQ0KZG9jdW1lbnRhdGlvbiBpZiB0aGF0IGhlbHBzLCBzdGFydGluZyB3aXRoIHNv
bWV0aGluZyBzaW1wbGUuDQoNCkJhbGJpcg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAgICAgICAg
IHRnbHgNCj4gDQo=
