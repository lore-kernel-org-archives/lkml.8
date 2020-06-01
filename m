Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B063EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8509220772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="llUAbYy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFAClM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:41:12 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:34182 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgFAClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590979270; x=1622515270;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=TltawOQQY80cO1c2Km92kR007GNJdrez0Cda0l2On4I=;
  b=llUAbYy5N60Ob10/96XH2j7IS34Q0xy9xii0FDSsvLFqyBZ3PE2rgk5p
   4aYPUY6QU1yiJvEOcxzboQkFioKx3C1QoI2SjMXxck6NLEdQycpyTgQCJ
   ZplkHSt5EV8DNBHSgj1vyUOd073UrEMDAr6ZnqqhmmEZjFXa/djRiJNqw
   E=;
IronPort-SDR: QXzEuie2ebNPVhf0YRsfjs3PmNkASVT8hIlc7CcFYobdLQaBDOBuaceiVdRl4JrisoTlMnnqW9
 d0DXCAP4KVJA==
X-IronPort-AV: E=Sophos;i="5.73,459,1583193600"; 
   d="scan'208";a="33497482"
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Topic: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 01 Jun 2020 02:40:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 50FE8A07B4;
        Mon,  1 Jun 2020 02:40:56 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 1 Jun 2020 02:40:55 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 1 Jun 2020 02:40:55 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.006;
 Mon, 1 Jun 2020 02:40:55 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "Saidi, Ali" <alisaidi@amazon.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Thread-Index: AQHWNbXPXXyA301h2EGDe5vwb83/i6jA2SaAgAEzUYCAAQRAgA==
Date:   Mon, 1 Jun 2020 02:40:55 +0000
Message-ID: <37e55e71faf76dc3db76d89c20c1bdfff942e380.camel@amazon.com>
References: <20200529015501.15771-1-alisaidi@amazon.com>
         <8c3be990888ecfb7cca9503853dc4aac@kernel.org>
         <2C4F431F-8140-4C82-B4BD-E51DE618FC08@amazon.com>
         <20200530174929.7bf6d5d7@why> <eed907d48de84c96e3ceb27c1ed6f622@kernel.org>
In-Reply-To: <eed907d48de84c96e3ceb27c1ed6f622@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.140]
Content-Type: text/plain; charset="utf-8"
Content-ID: <579C4899EC03054D91EF4ED83B1F1AAC@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTMxIGF0IDEyOjA5ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IA0KPiANCj4gPiBOb3QgZ3JlYXQgaW5kZWVkLiBCdXQgdGhpcyBpcyBub3QsIGFzIGZhciBhcyBJ
IGNhbiB0ZWxsLCBhIEdJQw0KPiA+IGRyaXZlciBwcm9ibGVtLg0KPiA+IA0KPiA+IFRoZSBzZW1h
bnRpYyBvZiBhY3RpdmF0ZS9kZWFjdGl2YXRlICh3aGljaCBtYXBzIHRvIHN0YXJ0ZWQvc2h1dGRv
d24NCj4gPiBpbiB0aGUgSVJRIGNvZGUpIGlzIHRoYXQgdGhlIEhXIHJlc291cmNlcyBmb3IgYSBn
aXZlbiBpbnRlcnJ1cHQgYXJlDQo+ID4gb25seSBjb21taXR0ZWQgd2hlbiB0aGUgaW50ZXJydXB0
IGlzIGFjdGl2YXRlZC4gVHJ5aW5nIHRvIHBlcmZvcm0NCj4gPiBhY3Rpb25zIGludm9sdmluZyB0
aGUgSFcgb24gYW4gaW50ZXJydXB0IHRoYXQgaXNuJ3QgYWN0aXZlIGNhbm5vdCBiZQ0KPiA+IGd1
YXJhbnRlZWQgdG8gdGFrZSBlZmZlY3QuDQo+ID4gDQo+ID4gSSdkIHJhdGhlciBhZGRyZXNzIGl0
IGluIHRoZSBjb3JlIGNvZGUsIGJ5IHByZXZlbnRpbmcgc2V0X2FmZmluaXR5IChhbmQNCj4gPiBw
b3RlbnRpYWxseSBvdGhlcnMpIHRvIHRha2UgcGxhY2Ugd2hlbiB0aGUgaW50ZXJydXB0IGlzIG5v
dCBpbiB0aGUNCj4gPiBTVEFSVEVEIHN0YXRlLiBVc2Vyc3BhY2Ugd291bGQgZ2V0IGFuIGVycm9y
LCB3aGljaCBpcyBwZXJmZWN0bHkNCj4gPiBsZWdpdGltYXRlLCBhbmQgd2hpY2ggaXQgYWxyZWFk
eSBoYXMgdG8gZGVhbCB3aXRoIGl0IGZvciBwbGVudHkgb2YNCj4gPiBvdGhlcg0KPiA+IHJlYXNv
bnMuDQoNClNvIEkgZmluYWxseSBmb3VuZCB0aW1lIHRvIGRpZyBhIGJpdCBpbiB0aGVyZSA6KSBD
b2RlIGhhcyBjaGFuZ2VkIGEgYml0DQpzaW5jZSBsYXN0IEkgbG9va2VkLiBCdXQgSSBoYXZlIG1l
bW9yaWVzIG9mIHRoZSBzdGFydHVwIGNvZGUgbWVzc2luZw0KYXJvdW5kIHdpdGggdGhlIGFmZmlu
aXR5LCBhbmQgaGVyZSBpdCBpcy4gSW4gaXJxX3N0YXJ0dXAoKSA6DQoNCg0KCQlzd2l0Y2ggKF9f
aXJxX3N0YXJ0dXBfbWFuYWdlZChkZXNjLCBhZmYsIGZvcmNlKSkgew0KCQljYXNlIElSUV9TVEFS
VFVQX05PUk1BTDoNCgkJCXJldCA9IF9faXJxX3N0YXJ0dXAoZGVzYyk7DQoJCQlpcnFfc2V0dXBf
YWZmaW5pdHkoZGVzYyk7DQoJCQlicmVhazsNCgkJY2FzZSBJUlFfU1RBUlRVUF9NQU5BR0VEOg0K
CQkJaXJxX2RvX3NldF9hZmZpbml0eShkLCBhZmYsIGZhbHNlKTsNCgkJCXJldCA9IF9faXJxX3N0
YXJ0dXAoZGVzYyk7DQoJCQlicmVhazsNCgkJY2FzZSBJUlFfU1RBUlRVUF9BQk9SVDoNCgkJCWly
cWRfc2V0X21hbmFnZWRfc2h1dGRvd24oZCk7DQoJCQlyZXR1cm4gMDsNCg0KU28gd2UgaGF2ZSB0
d28gY2FzZXMgaGVyZS4gTm9ybWFsIGFuZCBtYW5hZ2VkLg0KDQpJbiB0aGUgbWFuYWdlZCBjYXNl
LCB3ZSBzZXQgdGhlIGFmZmluaXR5IGJlZm9yZSBzdGFydHVwLiBJIGZlZWwgbGlrZSB5b3VyDQpw
YXRjaCBtaWdodCBicmVhayB0aGF0IG9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KDQpBZGRp
dGlvbmFsbHksIHlvdXIgcGF0Y2ggd291bGQgYnJlYWsgYW55IHVzZXJzcGFjZSBwcm9ncmFtIHRo
YXQgZXhwZWN0cyB0bw0KYmUgYWJsZSB0byBjaGFuZ2UgdGhlIGFmZmluaXR5IG9uIGFuIGludGVy
cnVwdCBiZWZvcmUgaXQncyBiZWVuIHN0YXJ0ZWQuDQpJIGRvbid0IGtub3cgaWYgc3VjaCBhIHRo
aW5nIGV4c2l0cyBidXQgdGhlIGZhY3QgdGhhdCB3ZSBoaXQgdGhhdCBidWcNCm1ha2VzIG1lIHRo
aW5rIGl0IG1pZ2h0Lg0KDQpOb3cgbW9zdCBjb250cm9sbGVyIGRyaXZlcnMgKGF0IGxlYXN0IHRo
YXQgSSdtIGZhbWlsaWFyIHdpdGgsIHdoaWNoIGRvZXNuJ3QNCmluY2x1ZGUgR2lDIGF0IHRoaXMg
cG9pbnQpIGNhbiBkZWFsIHdpdGggdGhhdCBqdXN0IGZpbmUuDQoNCk5vdyB0aGVyZSdzIGFsc28g
YW5vdGhlciBwb3NzaWJsZSBpc3N1ZToNCg0KWW91ciBwYXRjaCBjaGVja3MgaXJxZF9pc19zdGFy
dGVkKCkuIE5vdyBJIGFsd2F5cyBtaXh1cCBpcnFkIHZzIGlycV9zdGF0ZSB0aGVzZQ0KZGF5cyBz
byBJIG1heSBiZSB3cm9uZyBidXQgaXJxX3N0YXRlX3NldF9zdGFydGVkKCkgaXMgb25seSBkb25l
IGluIF9faXJxX3N0YXJ0dXANCndoaWNoIHdpbGwgKm5vdCogYmUgY2FsbGVkIGlmIHRoZSBpbnRl
cnJ1cHQgaGFzIE5PQVVUT0VOLg0KDQpJcyB0aGF0IG9rID8gRG8gd2UgaW50ZW5kIGZvciBhZmZp
bml0eSBzZXR0aW5nIG5vdCB0byB3b3JrIHVudGlsIHRoZSBmaXJzdA0KZW5hYmxlX2lycSgpIGZv
ciBzdWNoIGFuIGludGVycnVwdCA/IFdlIGNvdWxkIGNoZWNrIGFjdGl2YXRlZCBpbnN0ZWFkIG9m
DQpzdGFydGVkIEkgc3VwcG9zZS4gKGFnYWluIHByb3ZpZGVkIEkgZGlkbid0IG1peHVwIHR3byBk
aWZmZXJlbnQgdGhpbmdzDQpiZXR3ZWVuIHRoZSBpcnFkIGFuZCB0aGUgaXJxX3N0YXRlIHN0dWZm
KS4NCg0KRm9yIHRoZXNlIHJlYXNvbnMgbXkgZ3V0IGZlZWxpbmcgaXMgd2Ugc2hvdWxkIGp1c3Qg
Zml4IEdJQyBhcyBBbGkgd2FudGVkIHRvDQpkbyBpbml0aWFsbHkuDQoNClRoZSBiYXNpYyBpZGVh
IGlzIHNpbXBseSB0byBkZWZlciB0aGUgSFcgY29uZmlndXJhdGlvbiB1bnRpbCB0aGUgaW50ZXJy
dXB0DQpoYXMgYmVlbiBzdGFydGVkLiBJIGRvbid0IHNlZSB3aHkgdGhhdCB3b3VsZCBiZSBhbiBp
c3N1ZS4gSGF2ZSBzZXRfYWZmaW5pdHkganVzdA0Kc3RvcmUgdGhlIG1hc2sgKGFuZCBhcHBseSB3
aGF0ZXZlciBvdGhlciBzYW5pdHkgY2hlY2tpbmcgaXQgbWlnaHQgd2FudCB0byBkbykNCnVudGls
IHRoZSBpdG5lcnJ1cHQgaXMgc3RhcnRlZCBhbmQgd2hlbiBzdGFydGVkLCBhcHBseSB0aGluZ3Mg
dG8gSFcuDQoNCkkgbWlnaHQgYmUgbWlzc2luZyBhIHJlYXNvbiB3aHkgaXQncyBtb3JlIGNvbXBs
aWNhdGVkIHRoYW4gdGhhdCA6KSBCdXQgSSBkbw0KZmVlbCBhIGJpdCB1bmNvbWZvcnRhYmxlIHdp
dGggeW91ciBhcHByb2FjaC4NCg0KQ2hlZXJzLA0KQmVuLg0KDQo=
