Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71743C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43615206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XbDd30vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDGXjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:39:18 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10197 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDGXjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586302757; x=1617838757;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=atnYjxiyKdQFWwXp0PXFdPTtxkh6WFqlWjXNyrLv5sU=;
  b=XbDd30vvRkpwuWUH+/ptes2kd/aVcBmeFvX3fo3jDRGcnXfAM1SAdFLV
   XNfEs8KduHsejv6k3+08f7c478Gjadavz+ojmjP+UKqAqAfyGyaWYX2uG
   jJVWNPHwgh80213nlsKYZlGwcIQ5dLN9zdEZi+tf6G0xt8c/Z5OD9LFYs
   I=;
IronPort-SDR: my4cwCRqMA/z2RwjyvFN1C6ahNSR6snq7AWhsbU/AtAM2UZaayhRuNNBGauPOEs0eU9eSwkyms
 1ZSV36OS7LVg==
X-IronPort-AV: E=Sophos;i="5.72,356,1580774400"; 
   d="scan'208";a="37258086"
Subject: Re: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 07 Apr 2020 23:39:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 16B161A0E81;
        Tue,  7 Apr 2020 23:39:15 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 23:39:14 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 23:39:14 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Tue, 7 Apr 2020 23:39:14 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWC8KR9rJxTIXiWkGqeY4o6Uqz/aht/HqAgABXfYA=
Date:   Tue, 7 Apr 2020 23:39:14 +0000
Message-ID: <728ba30fdc269d4b24c4fb16832e0151e8270cba.camel@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
         <20200406031946.11815-4-sblbir@amazon.com> <202004071125.605F665@keescook>
In-Reply-To: <202004071125.605F665@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <11D50BCF4228804F861678344F60F66D@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTA3IGF0IDExOjI2IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IA0K
PiANCj4gT24gTW9uLCBBcHIgMDYsIDIwMjAgYXQgMDE6MTk6NDVQTSArMTAwMCwgQmFsYmlyIFNp
bmdoIHdyb3RlOg0KPiA+IEltcGxlbWVudCBhIG1lY2hhbmlzbSB0byBzZWxlY3RpdmVseSBmbHVz
aCB0aGUgTDFEIGNhY2hlLiBUaGUgZ29hbCBpcyB0bw0KPiA+IGFsbG93IHRhc2tzIHRoYXQgYXJl
IHBhcmFub2lkIGR1ZSB0byB0aGUgcmVjZW50IHNub29wIGFzc2lzdGVkIGRhdGENCj4gPiBzYW1w
bGluZw0KPiA+IHZ1bG5lcmFiaWxpdGVzLCB0byBmbHVzaCB0aGVpciBMMUQgb24gYmVpbmcgc3dp
dGNoZWQgb3V0LiAgVGhpcyBwcm90ZWN0cw0KPiA+IHRoZWlyIGRhdGEgZnJvbSBiZWluZyBzbm9v
cGVkIG9yIGxlYWtlZCB2aWEgc2lkZSBjaGFubmVscyBhZnRlciB0aGUgdGFzaw0KPiA+IGhhcyBj
b250ZXh0IHN3aXRjaGVkIG91dC4NCj4gPiANCj4gPiBUaGVyZSBhcmUgdHdvIHNjZW5hcmlvcyB3
ZSBtaWdodCB3YW50IHRvIHByb3RlY3QgYWdhaW5zdCwgYSB0YXNrIGxlYXZpbmcNCj4gPiB0aGUg
Q1BVIHdpdGggZGF0YSBzdGlsbCBpbiBMMUQgKHdoaWNoIGlzIHRoZSBtYWluIGNvbmNlcm4gb2Yg
dGhpcyBwYXRjaCksDQo+ID4gdGhlIHNlY29uZCBzY2VuYXJpbyBpcyBhIG1hbGljaW91cyB0YXNr
IGNvbWluZyBpbiAobm90IHNvIHdlbGwgdHJ1c3RlZCkNCj4gPiBmb3Igd2hpY2ggd2Ugd2FudCB0
byBjbGVhbiB1cCB0aGUgY2FjaGUgYmVmb3JlIGl0IHN0YXJ0cy4gT25seSB0aGUgY2FzZQ0KPiA+
IGZvciB0aGUgZm9ybWVyIGlzIGFkZHJlc3NlZC4NCj4gPiANCj4gPiBBZGQgYXJjaCBzcGVjaWZp
YyBwcmN0bCgpJ3MgdG8gb3B0LWluIHRvIHRoZSBMMUQgY2FjaGUgb24gY29udGV4dCBzd2l0Y2gN
Cj4gPiBvdXQsIHRoZSBleGlzdGluZyBtZWNoYW5pc21zIG9mIHRyYWNraW5nIHByZXZfbW0gdmlh
IGNwdV90bGJzdGF0ZSBpcw0KPiA+IHJldXNlZC4gY29uZF9pYnBiKCkgaXMgcmVmYWN0b3JlZCBh
bmQgcmVuYW1lZCBpbnRvIGNvbmRfbWl0aWdhdGlvbigpLg0KPiANCj4gSSBzdGlsbCB0aGluayB0
aGlzIHNob3VsZCBiZSBhIGdlbmVyaWMgcHJjdGwoKS4gSWYgdGhlcmUgaXMgYSBzdHJvbmcNCj4g
cmVhc29uIG5vdCB0byBkbyB0aGlzLCBjYW4gaXQgYmUgZGVzY3JpYmVkIGluIHRoZSBjb21taXQg
bG9nIGhlcmU/DQo+IA0KPiAtS2Vlcw0KPiANCg0KSSBjYW4gbW92ZSB0byBwcmN0bCgpIGlmIHRo
YXQgaXMgd2hhdCB5b3UgcHJlZmVyLCB0aGUgcHJjdGwoKSBjYW4gdGhlbiBkbyBhcmNoDQpzcGVj
aWZpYyB0aGluZ3MuIEkgdGhvdWdodCBpbiBteSBxdWVzdGlvbiBhcm91bmQgd291bGQgb3RoZXIg
YXJjaCdzIGxpa2UgdG8gZG8NCnRoaXMsIEkgZGlkIG5vdCBoZWFyIGFueXRoaW5nIHNwZWNpZmlj
LCBidXQgSSBhbSBoYXBweSB0byBjb252ZXJ0IHRoZQ0KaW50ZXJmYWNlIG92ZXIuDQoNCkJhbGJp
ciBTaW5naC4NCg0KDQo=
