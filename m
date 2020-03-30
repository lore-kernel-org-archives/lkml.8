Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF2DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F538206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Yj3EKfqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgC3BOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:14:02 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:42851 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgC3BOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585530841; x=1617066841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bHirlSaOnlkr4MhM+2h8bgaq8bwuzARgsALW27WJBYY=;
  b=Yj3EKfqErbkt57Ba2ckDB/1hhVFoSMlUakmS14n2W1D12ue1JPnDXYE5
   HwdcS0uMBEqLsFj3+QOrgh31HSzlZmzNPUnXFqdBzmGSzLm+zcbDFP9uQ
   y5Gin9ShlZOibZ0lV9FWwU475Zq1/POhcQD46F4OQyXexy/rfKKPxIZiy
   g=;
IronPort-SDR: HH/i3QegBncWAjc3SiXzC54btnTyCH9p4vume3o2MpgQ77GLrEgBMdFA9IH7Zs0JSiTGP9NgxJ
 bXp2QZI3Lg1w==
X-IronPort-AV: E=Sophos;i="5.72,322,1580774400"; 
   d="scan'208";a="23646605"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 30 Mar 2020 01:13:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 57282A269B;
        Mon, 30 Mar 2020 01:13:47 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Mar 2020 01:13:46 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Mar 2020 01:13:46 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Mon, 30 Mar 2020 01:13:46 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v2 0/4] arch/x86: Optionally flush L1D on context
 switch
Thread-Topic: [RFC PATCH v2 0/4] arch/x86: Optionally flush L1D on context
 switch
Thread-Index: AQHWAnSRV8t1YBQKFU+upP2/R0lyqahgXAAA
Date:   Mon, 30 Mar 2020 01:13:46 +0000
Message-ID: <87e4bd4e25c81d43abb47d0e2812c21a0478869b.camel@amazon.com>
References: <20200325071101.29556-1-sblbir@amazon.com>
In-Reply-To: <20200325071101.29556-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F38399E83167F4895EF51E1E8CFE0A9@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDE4OjEwICsxMTAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IFRoaXMgcGF0Y2ggaXMgYSBjb250aW51YXRpb24gb2YgUkZDL1BvQyB0byBzdGFydCB0aGUgZGlz
Y3Vzc2lvbiBvbg0KPiBvcHRpb25hbGx5DQo+IGZsdXNoaW5nIEwxRCBjYWNoZS4gIFRoZSBnb2Fs
IGlzIHRvIGFsbG93IHRhc2tzIHRoYXQgYXJlIHBhcmFub2lkIGR1ZSB0byB0aGUNCj4gcmVjZW50
IHNub29wIGFzc2lzdGVkIGRhdGEgc2FtcGxpbmcgdnVsbmVyYWJpbGl0ZXMsIHRvIGZsdXNoIHRo
ZWlyIEwxRCBvbg0KPiBiZWluZw0KPiBzd2l0Y2hlZCBvdXQuICBUaGlzIHByb3RlY3RzIHRoZWly
IGRhdGEgZnJvbSBiZWluZyBzbm9vcGVkIG9yIGxlYWtlZCB2aWENCj4gc2lkZSBjaGFubmVscyBh
ZnRlciB0aGUgdGFzayBoYXMgY29udGV4dCBzd2l0Y2hlZCBvdXQuDQo+IA0KPiBUaGUgcG9pbnRz
IG9mIGRpc2N1c3Npb24vcmV2aWV3IGFyZSAod2l0aCB1cGRhdGVzKToNCj4gDQo+IDEuIERpc2N1
c3MgdGhlIHVzZSBjYXNlIGFuZCB0aGUgcmlnaHQgYXBwcm9hY2ggdG8gYWRkcmVzcyB0aGlzDQo+
IEEuIEdlbmVyYWxseSB0aGVyZSBzZWVtcyB0byBiZSBjb25zZW5zdXMgdGhhdCB3ZSBuZWVkIHRo
aXMNCj4gDQo+IDIuIERvZXMgYW4gYXJjaCBwcmN0bCBhbGxvd2luZyBmb3Igb3B0LWluIGZsdXNo
aW5nIG1ha2Ugc2Vuc2UsIHdvdWxkIG90aGVyDQo+ICAgIGFyY2hlcyBjYXJlIGFib3V0IHNvbWV0
aGluZyBzaW1pbGFyPw0KPiBBLiBXZSBkZWZpbml0ZWx5IGJ1aWxkIHRoaXMgZm9yIHg4NiwgaGF2
ZSBub3QgaGVhcmQgZnJvbSBhbnkgb3RoZXIgYXJjaA0KPiAgICBtYWludGFpbmVycy4gVGhlcmUg
d2FzIHN1Z2dlc3Rpb24gdG8gbWFrZSB0aGlzIGEgcHJjdGwgYW5kIGxldCBlYWNoDQo+ICAgIGFy
Y2ggaW1wbGVtZW50IEwxRCBmbHVzaGluZyBpZiBuZWVkZWQsIHRoZXJlIGlzIG5vIGFyY2ggYWdu
b3N0aWMNCj4gICAgc29mdHdhcmUgTDFEIGZsdXNoLg0KPiANCj4gMy4gVGhlcmUgaXMgYSBmYWxs
YmFjayBzb2Z0d2FyZSBMMUQgbG9hZCwgc2ltaWxhciB0byB3aGF0IEwxVEYgZG9lcywgYnV0DQo+
ICAgIHdlIGRvbid0IHByZWZldGNoIHRoZSBUTEIsIGlzIHRoYXQgc3VmZmljaWVudD8NCj4gQS4g
VGhlcmUgd2FzIG5vIGNvbmNsdXNpb24sIEkgc3VzcGVjdCB3ZSBkb24ndCBuZWVkIHRoaXMNCj4g
DQo+IDQuIFNob3VsZCB3ZSBjb25zaWRlciBjbGVhbmluZyB1cCB0aGUgTDFEIG9uIGFycml2YWwg
b2YgdGFza3M/DQo+IEEuIEZvciBub3csIHdlIHRoaW5rIHRoaXMgY2FzZSBpcyBub3QgdGhlIHBy
aW9yaXR5IGZvciB0aGlzIHBhdGNoc2V0Lg0KPiANCj4gSW4gc3VtbWFyeSwgdGhpcyBpcyBhbiBl
YXJseSBQb0MgdG8gc3RhcnQgdGhlIGRpc2N1c3Npb24gb24gdGhlIG5lZWQgZm9yDQo+IGNvbmRp
dGlvbmFsIEwxRCBmbHVzaGluZyBiYXNlZCBvbiB0aGUgc2VjdXJpdHkgcG9zdHVyZSBvZiB0aGUN
Cj4gYXBwbGljYXRpb24gYW5kIHRoZSBzZW5zaXRpdml0eSBvZiB0aGUgZGF0YSBpdCBoYXMgYWNj
ZXNzIHRvIG9yIG1pZ2h0DQo+IGhhdmUgYWNjZXNzIHRvLg0KPiANCj4gQ2hhbmdlbG9nIHYyOg0K
PiAgLSBSZXVzZSBleGlzdGluZyBjb2RlIGZvciBhbGxvY2F0aW9uIGFuZCBmbHVzaA0KPiAgLSBT
aW1wbGlmeSB0aGUgZ290byBsb2dpYyBpbiB0aGUgYWN0dWFsIGwxZF9mbHVzaCBmdW5jdGlvbg0K
PiAgLSBPcHRpbWl6ZSB0aGUgY29kZSBwYXRoIHdpdGgganVtcCBsYWJlbHMvc3RhdGljIGZ1bmN0
aW9ucw0KPiANCj4gQ2M6IGtlZXNjb29rQGNocm9taXVtLm9yZw0KPiANCj4gQmFsYmlyIFNpbmdo
ICg0KToNCj4gICBhcmNoL3g4Ni9rdm06IFJlZmFjdG9yIGwxZCBmbHVzaCBsaWZlY3ljbGUgbWFu
YWdlbWVudA0KPiAgIGFyY2gveDg2OiBSZWZhY3RvciB0bGJmbHVzaCBhbmQgbDFkIGZsdXNoDQo+
ICAgYXJjaC94ODY6IE9wdGlvbmFsbHkgZmx1c2ggTDFEIG9uIGNvbnRleHQgc3dpdGNoDQo+ICAg
YXJjaC94ODY6IEwxRCBmbHVzaCwgb3B0aW1pemUgdGhlIGNvbnRleHQgc3dpdGNoDQo+IA0KDQpQ
aW5nLCBsb29raW5nIGZvciBjb21tZW50cyBhbmQgY3JpdGljaXNtIG9mIHRoZSBhcHByb2FjaC4g
SSB1bmRlcnN0YW5kIHdpdGgNCnRoZSBtZXJnZSB3aW5kb3cgYXJvdW5kIHRoZSBjb3JuZXIgZXZl
cnlvbmUgaXMgYnVzeS4gVGhlcmUgaXMgYSBidWcgaW4gdGhlIHYyDQpSRkMgc2VyaWVzLCBJIGFt
IGhhcHB5IHRvIHBvc3QgYSB2ZXJzaW9uIHdpdGhvdXQgdGhlIFJGQyBmb3IgYnJvYWRlciB0ZXN0
aW5nDQphbmQgZmVlZGJhY2suDQoNCkkgYW0gcXVpdGUga2VlbiB0byBoZWFyIGFib3V0IHRoZSBp
bnRlcmZhY2UgYW5kIGFueSBjb25jZXJucyB3aXRoIHRoZQ0KYXJjaF9wcmN0bCgpIGludGVyZmFj
ZS4NCg0KQmFsYmlyIFNpbmdoLg0K
