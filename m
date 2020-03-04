Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709BFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501212072A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgCDP0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:26:05 -0500
Received: from mx-relay77-hz1.antispameurope.com ([94.100.132.239]:56792 "EHLO
        mx-relay77-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729568AbgCDP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:26:04 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 10:26:04 EST
Received: from mailgw1.iis.fraunhofer.de ([153.96.172.4]) by mx-relay77-hz1.antispameurope.com;
 Wed, 04 Mar 2020 16:20:00 +0100
Received: from mail.iis.fraunhofer.de (mail01.iis.fhg.de [153.96.171.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.iis.fraunhofer.de (Postfix) with ESMTPS id 9E2F82400083;
        Wed,  4 Mar 2020 16:19:56 +0100 (CET)
Received: from mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) by
 mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 4 Mar 2020 16:19:56 +0100
Received: from mail01.iis.fhg.de ([fe80::fd91:8c2a:e4a5:e74e]) by
 mail01.iis.fhg.de ([fe80::fd91:8c2a:e4a5:e74e%12]) with mapi id
 15.00.1395.000; Wed, 4 Mar 2020 16:19:56 +0100
From:   "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
To:     "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "hjk@linutronix.de" <hjk@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH 2/2] uio: Prefer MSI(X) interrupts in PCI drivers
Thread-Topic: [PATCH 2/2] uio: Prefer MSI(X) interrupts in PCI drivers
Thread-Index: AQHTPqe0AewtzyOB0kiu6siMSnXwqaLWtAAAgAABSQCAABKaAIAV3VwAgAACLgCFUTs3gA==
Date:   Wed, 4 Mar 2020 15:19:55 +0000
Message-ID: <9ba3cdd6d330486a91cb5c376f012b5b963c4eae.camel@iis-extern.fraunhofer.de>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
         <1507296804.2915.16.camel@iis-extern.fraunhofer.de>
         <20171006134550.GA1626@kroah.com>
         <1507297826.2915.18.camel@iis-extern.fraunhofer.de>
         <20171006075700.587a5e22@xeon-e3> <20171020125044.GA8634@kroah.com>
         <1508504312.3128.23.camel@iis-extern.fraunhofer.de>
In-Reply-To: <1508504312.3128.23.camel@iis-extern.fraunhofer.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [153.96.171.210]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7AB6DFC20E36C47BA570DC2F3116EC5@iis.fhg.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-cloud-security-sender: manuel.stahl@iis-extern.fraunhofer.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay77-hz1.antispameurope.com with C3591600930
X-cloud-security-connect: mailgw1.iis.fraunhofer.de[153.96.172.4], TLS=1, IP=153.96.172.4
X-cloud-security: scantime:.3309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0Kc28gc29tZWhvdyB0aGlzIGRpc2N1c3Npb24gc3RvcHBlZCB3aXRob3V0IGFu
eSBpbnN0cnVjdGlvbnMgaG93IHRvIHByb2NlZWQuDQpJIHRoaW5rIHRoaXMga2luZCBvZiBkcml2
ZXIgaGVscHMgZXZlcnkgRlBHQSBkZXZlbG9wZXIgdG8gaW50ZXJmYWNlIGhpcyBkZXNpZ24gdmlh
IFBDSWUgdG8gYSBMaW51eCBQQy4NClNvIGlmIHRoZXJlIGlzIGFueSBjaGFuY2UgdG8gZ2V0IHRo
aXMgY29kZSBtZXJnZWQsIEknbSBnbGFkIHRvIHJlYmFzZSB0aGlzIG9udG8gdGhlIGxhdGVzdCBr
ZXJuZWwgcmVsZWFzZS4NCg0KQmVzdCByZWdhcmRzLA0KTWFudWVsIFN0YWhsDQoNCk9uIEZyLCAy
MDE3LTEwLTIwIGF0IDE0OjU4ICswMjAwLCBNYW51ZWwgU3RhaGwgd3JvdGU6DQo+IEhpIEdyZWcs
DQo+IA0KPiBpdCBqdXN0IHVzZXMgTVNJLVggb3IgTVNJIHdoZW4gYXZhaWxhYmxlIGFuZCBmYWxs
cyBiYWNrIHRvIGxlZ2FjeSBJUlEgb3RoZXJ3aXNlLg0KPiANCj4gUmVnYXJkcywNCj4gTWFudWVs
DQo+IA0KPiBPbiBGciwgMjAxNy0xMC0yMCBhdCAxNDo1MCArMDIwMCwgZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmcgd3JvdGU6DQo+ID4gT24gRnJpLCBPY3QgMDYsIDIwMTcgYXQgMDc6NTc6MDBB
TSAtMDcwMCwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDYgT2N0IDIw
MTcgMTM6NTA6NDQgKzAwMDANCj4gPiA+ICJTdGFobCwgTWFudWVsIiA8bWFudWVsLnN0YWhsQGlp
cy1leHRlcm4uZnJhdW5ob2Zlci5kZT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gTVNJKFgpIGlu
dGVycnVwdHMgYXJlIG5vdCBzaGFyZWQgYmV0d2VlbiBkZXZpY2VzLiBTbyB3aGVuIGF2YWlsYWJs
ZQ0KPiA+ID4gPiB0aG9zZSBzaG91bGQgYmUgcHJlZmVycmVkIG92ZXIgbGVnYWN5IGludGVycnVw
dHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYW51ZWwgU3RhaGwgPG1hbnVl
bC5zdGFobEBpaXMuZnJhdW5ob2Zlci5kZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L3Vpby91aW9fcGNpX2RtZW1fZ2VuaXJxLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0NCj4gPiA+ID4gIGRyaXZlcnMvdWlvL3Vpb19wY2lfZ2VuZXJpYy5jICAgICB8IDI0ICsrKysr
KysrKysrKysrKysrKy0tLS0tLQ0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRp
b25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gVGhlIGxhc3QgdGltZSBJIHRy
aWVkIHRvIGRvIE1TSS1YIHdpdGggcGNpLWdlbmVyaWMgaXQgZ290IHJlamVjdGVkDQo+ID4gPiBi
eSB0aGUgbWFpbnRhaW5lci4NCj4gPiANCj4gPiBIbSwgeWVhaCwgdGhpcyB3b3VsZCBicmVhayB1
c2VycyB0b2RheSB0aGF0IGRvIG5vdCBoYXZlIG1zaS14LCByaWdodD8NCj4gPiANCj4gPiBOb3Qg
Z29vZCwgTWFudWVsLCBob3cgd2VsbCBkaWQgeW91IHRlc3QgdGhpcz8NCj4gPiANCj4gPiB0aGFu
a3MsDQo+ID4gDQo+ID4gZ3JlZyBrLWgNCg==
