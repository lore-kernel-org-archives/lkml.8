Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E46C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD26020734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mgonyhk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgFBSsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:48:03 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:46749 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591123681; x=1622659681;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=8HyrvPEKZAYGjGOm7LvhNTWe+Tf0b/dodVyIfLJ4I6I=;
  b=mgonyhk62NuoAj4F08qVZq8A+HW7DCooy+VJlEdidEe2/IEIWkUL2YWw
   rN52UAtvFmKjjGgIOoAQLfsBb4x9CjgjR1upAwJCmST/FDQ4WqpNKV8t3
   slKKOilguQdDex7p2PduMyg5es1oMoWGkebthh4I0JuHNrpBgmNkPJv7X
   c=;
IronPort-SDR: QJfZSCVcZfsbttFlBBTLTcNw0ehZp55Rdo8SfyH135HPAUoWGsFV/8eJydrETl16XKM0xcwnRM
 BQyXL/geWspw==
X-IronPort-AV: E=Sophos;i="5.73,465,1583193600"; 
   d="scan'208";a="47942813"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Jun 2020 18:47:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id F0B44A29DC;
        Tue,  2 Jun 2020 18:47:55 +0000 (UTC)
Received: from EX13D21UWA001.ant.amazon.com (10.43.160.154) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 18:47:55 +0000
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13D21UWA001.ant.amazon.com (10.43.160.154) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 18:47:54 +0000
Received: from EX13D02UWC004.ant.amazon.com ([10.43.162.236]) by
 EX13D02UWC004.ant.amazon.com ([10.43.162.236]) with mapi id 15.00.1497.006;
 Tue, 2 Jun 2020 18:47:54 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Topic: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Index: AQHWOQ5TGxQQg3bj90ySVk+Lagzw+A==
Date:   Tue, 2 Jun 2020 18:47:54 +0000
Message-ID: <AE04B507-C5E2-44D2-9190-41E9BE720F9D@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB80F324960BE34ABC9A6E19483DCD53@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrvu79PbiA1LzMxLzIwLCA5OjQwIFBNLCAiSGVycmVuc2NobWlkdCwgQmVuamFtaW4iIDxiZW5o
QGFtYXpvbi5jb20+IHdyb3RlOg0KDQogICAgT24gU3VuLCAyMDIwLTA1LTMxIGF0IDEyOjA5ICsw
MTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQogICAgPiANCiAgICA+IA0KICAgID4gPiBOb3QgZ3Jl
YXQgaW5kZWVkLiBCdXQgdGhpcyBpcyBub3QsIGFzIGZhciBhcyBJIGNhbiB0ZWxsLCBhIEdJQw0K
ICAgID4gPiBkcml2ZXIgcHJvYmxlbS4NCiAgICA+ID4gDQogICAgPiA+IFRoZSBzZW1hbnRpYyBv
ZiBhY3RpdmF0ZS9kZWFjdGl2YXRlICh3aGljaCBtYXBzIHRvIHN0YXJ0ZWQvc2h1dGRvd24NCiAg
ICA+ID4gaW4gdGhlIElSUSBjb2RlKSBpcyB0aGF0IHRoZSBIVyByZXNvdXJjZXMgZm9yIGEgZ2l2
ZW4gaW50ZXJydXB0IGFyZQ0KICAgID4gPiBvbmx5IGNvbW1pdHRlZCB3aGVuIHRoZSBpbnRlcnJ1
cHQgaXMgYWN0aXZhdGVkLiBUcnlpbmcgdG8gcGVyZm9ybQ0KICAgID4gPiBhY3Rpb25zIGludm9s
dmluZyB0aGUgSFcgb24gYW4gaW50ZXJydXB0IHRoYXQgaXNuJ3QgYWN0aXZlIGNhbm5vdCBiZQ0K
ICAgID4gPiBndWFyYW50ZWVkIHRvIHRha2UgZWZmZWN0Lg0KICAgID4gPiANCiAgICA+ID4gSSdk
IHJhdGhlciBhZGRyZXNzIGl0IGluIHRoZSBjb3JlIGNvZGUsIGJ5IHByZXZlbnRpbmcgc2V0X2Fm
ZmluaXR5IChhbmQNCiAgICA+ID4gcG90ZW50aWFsbHkgb3RoZXJzKSB0byB0YWtlIHBsYWNlIHdo
ZW4gdGhlIGludGVycnVwdCBpcyBub3QgaW4gdGhlDQogICAgPiA+IFNUQVJURUQgc3RhdGUuIFVz
ZXJzcGFjZSB3b3VsZCBnZXQgYW4gZXJyb3IsIHdoaWNoIGlzIHBlcmZlY3RseQ0KICAgID4gPiBs
ZWdpdGltYXRlLCBhbmQgd2hpY2ggaXQgYWxyZWFkeSBoYXMgdG8gZGVhbCB3aXRoIGl0IGZvciBw
bGVudHkgb2YNCiAgICA+ID4gb3RoZXINCiAgICA+ID4gcmVhc29ucy4NCiAgICANCiAgICBTbyBJ
IGZpbmFsbHkgZm91bmQgdGltZSB0byBkaWcgYSBiaXQgaW4gdGhlcmUgOikgQ29kZSBoYXMgY2hh
bmdlZCBhIGJpdA0KICAgIHNpbmNlIGxhc3QgSSBsb29rZWQuIEJ1dCBJIGhhdmUgbWVtb3JpZXMg
b2YgdGhlIHN0YXJ0dXAgY29kZSBtZXNzaW5nDQogICAgYXJvdW5kIHdpdGggdGhlIGFmZmluaXR5
LCBhbmQgaGVyZSBpdCBpcy4gSW4gaXJxX3N0YXJ0dXAoKSA6DQogICAgDQogICAgDQogICAgCQlz
d2l0Y2ggKF9faXJxX3N0YXJ0dXBfbWFuYWdlZChkZXNjLCBhZmYsIGZvcmNlKSkgew0KICAgIAkJ
Y2FzZSBJUlFfU1RBUlRVUF9OT1JNQUw6DQogICAgCQkJcmV0ID0gX19pcnFfc3RhcnR1cChkZXNj
KTsNCiAgICAJCQlpcnFfc2V0dXBfYWZmaW5pdHkoZGVzYyk7DQogICAgCQkJYnJlYWs7DQogICAg
CQljYXNlIElSUV9TVEFSVFVQX01BTkFHRUQ6DQogICAgCQkJaXJxX2RvX3NldF9hZmZpbml0eShk
LCBhZmYsIGZhbHNlKTsNCiAgICAJCQlyZXQgPSBfX2lycV9zdGFydHVwKGRlc2MpOw0KICAgIAkJ
CWJyZWFrOw0KICAgIAkJY2FzZSBJUlFfU1RBUlRVUF9BQk9SVDoNCiAgICAJCQlpcnFkX3NldF9t
YW5hZ2VkX3NodXRkb3duKGQpOw0KICAgIAkJCXJldHVybiAwOw0KICAgIA0KICAgIFNvIHdlIGhh
dmUgdHdvIGNhc2VzIGhlcmUuIE5vcm1hbCBhbmQgbWFuYWdlZC4NCiAgICANCiAgICBJbiB0aGUg
bWFuYWdlZCBjYXNlLCB3ZSBzZXQgdGhlIGFmZmluaXR5IGJlZm9yZSBzdGFydHVwLiBJIGZlZWwg
bGlrZSB5b3VyDQogICAgcGF0Y2ggbWlnaHQgYnJlYWsgdGhhdCBvciBhbSBJIG1pc3Npbmcgc29t
ZXRoaW5nID8NCiAgICANCiAgICBBZGRpdGlvbmFsbHksIHlvdXIgcGF0Y2ggd291bGQgYnJlYWsg
YW55IHVzZXJzcGFjZSBwcm9ncmFtIHRoYXQgZXhwZWN0cyB0bw0KICAgIGJlIGFibGUgdG8gY2hh
bmdlIHRoZSBhZmZpbml0eSBvbiBhbiBpbnRlcnJ1cHQgYmVmb3JlIGl0J3MgYmVlbiBzdGFydGVk
Lg0KICAgIEkgZG9uJ3Qga25vdyBpZiBzdWNoIGEgdGhpbmcgZXhzaXRzIGJ1dCB0aGUgZmFjdCB0
aGF0IHdlIGhpdCB0aGF0IGJ1Zw0KICAgIG1ha2VzIG1lIHRoaW5rIGl0IG1pZ2h0Lg0KICAgIA0K
ICAgIE5vdyBtb3N0IGNvbnRyb2xsZXIgZHJpdmVycyAoYXQgbGVhc3QgdGhhdCBJJ20gZmFtaWxp
YXIgd2l0aCwgd2hpY2ggZG9lc24ndA0KICAgIGluY2x1ZGUgR2lDIGF0IHRoaXMgcG9pbnQpIGNh
biBkZWFsIHdpdGggdGhhdCBqdXN0IGZpbmUuDQogICAgDQogICAgTm93IHRoZXJlJ3MgYWxzbyBh
bm90aGVyIHBvc3NpYmxlIGlzc3VlOg0KICAgIA0KICAgIFlvdXIgcGF0Y2ggY2hlY2tzIGlycWRf
aXNfc3RhcnRlZCgpLiBOb3cgSSBhbHdheXMgbWl4dXAgaXJxZCB2cyBpcnFfc3RhdGUgdGhlc2UN
CiAgICBkYXlzIHNvIEkgbWF5IGJlIHdyb25nIGJ1dCBpcnFfc3RhdGVfc2V0X3N0YXJ0ZWQoKSBp
cyBvbmx5IGRvbmUgaW4gX19pcnFfc3RhcnR1cA0KICAgIHdoaWNoIHdpbGwgKm5vdCogYmUgY2Fs
bGVkIGlmIHRoZSBpbnRlcnJ1cHQgaGFzIE5PQVVUT0VOLg0KICAgIA0KICAgIElzIHRoYXQgb2sg
PyBEbyB3ZSBpbnRlbmQgZm9yIGFmZmluaXR5IHNldHRpbmcgbm90IHRvIHdvcmsgdW50aWwgdGhl
IGZpcnN0DQogICAgZW5hYmxlX2lycSgpIGZvciBzdWNoIGFuIGludGVycnVwdCA/IFdlIGNvdWxk
IGNoZWNrIGFjdGl2YXRlZCBpbnN0ZWFkIG9mDQogICAgc3RhcnRlZCBJIHN1cHBvc2UuIChhZ2Fp
biBwcm92aWRlZCBJIGRpZG4ndCBtaXh1cCB0d28gZGlmZmVyZW50IHRoaW5ncw0KICAgIGJldHdl
ZW4gdGhlIGlycWQgYW5kIHRoZSBpcnFfc3RhdGUgc3R1ZmYpLg0KICAgIA0KICAgIEZvciB0aGVz
ZSByZWFzb25zIG15IGd1dCBmZWVsaW5nIGlzIHdlIHNob3VsZCBqdXN0IGZpeCBHSUMgYXMgQWxp
IHdhbnRlZCB0bw0KICAgIGRvIGluaXRpYWxseS4NCiAgICANCiAgICBUaGUgYmFzaWMgaWRlYSBp
cyBzaW1wbHkgdG8gZGVmZXIgdGhlIEhXIGNvbmZpZ3VyYXRpb24gdW50aWwgdGhlIGludGVycnVw
dA0KICAgIGhhcyBiZWVuIHN0YXJ0ZWQuIEkgZG9uJ3Qgc2VlIHdoeSB0aGF0IHdvdWxkIGJlIGFu
IGlzc3VlLiBIYXZlIHNldF9hZmZpbml0eSBqdXN0DQogICAgc3RvcmUgdGhlIG1hc2sgKGFuZCBh
cHBseSB3aGF0ZXZlciBvdGhlciBzYW5pdHkgY2hlY2tpbmcgaXQgbWlnaHQgd2FudCB0byBkbykN
CiAgICB1bnRpbCB0aGUgaXRuZXJydXB0IGlzIHN0YXJ0ZWQgYW5kIHdoZW4gc3RhcnRlZCwgYXBw
bHkgdGhpbmdzIHRvIEhXLg0KICAgIA0KICAgIEkgbWlnaHQgYmUgbWlzc2luZyBhIHJlYXNvbiB3
aHkgaXQncyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gdGhhdCA6KSBCdXQgSSBkbw0KICAgIGZlZWwg
YSBiaXQgdW5jb21mb3J0YWJsZSB3aXRoIHlvdXIgYXBwcm9hY2guDQogICAgDQpMb29rcyBsaWtl
IHRoZSB4ODYgYXBpYyBzZXRfYWZmaW5pdHkgY2FsbCBleHBsaWNpdGx5IGNoZWNrcyBmb3IgaWYg
aXTigJlzIGFjdGl2YXRlZCBpbiB0aGUgbWFuYWdlZCBjYXNlIHdoaWNoIG1ha2VzIHNlbnNlIGdp
dmVuIHRoZSBjb2RlIEJlbiBwb3N0ZWQgYWJvdmU6DQogICAgICAgICAgLyoNCiAgICAgICAgICAg
KiBDb3JlIGNvZGUgY2FuIGNhbGwgaGVyZSBmb3IgaW5hY3RpdmUgaW50ZXJydXB0cy4gRm9yIGlu
YWN0aXZlDQogICAgICAgICAgICogaW50ZXJydXB0cyB3aGljaCB1c2UgbWFuYWdlZCBvciByZXNl
cnZhdGlvbiBtb2RlIHRoZXJlIGlzIG5vDQogICAgICAgICAgICogcG9pbnQgaW4gZ29pbmcgdGhy
b3VnaCB0aGUgdmVjdG9yIGFzc2lnbm1lbnQgcmlnaHQgbm93IGFzIHRoZQ0KICAgICAgICAgICAq
IGFjdGl2YXRpb24gd2lsbCBhc3NpZ24gYSB2ZWN0b3Igd2hpY2ggZml0cyB0aGUgZGVzdGluYXRp
b24NCiAgICAgICAgICAgKiBjcHVtYXNrLiBMZXQgdGhlIGNvcmUgY29kZSBzdG9yZSB0aGUgZGVz
dGluYXRpb24gbWFzayBhbmQgYmUNCiAgICAgICAgICAgKiBkb25lIHdpdGggaXQuDQogICAgICAg
ICAgICovDQogICAgICAgICAgaWYgKCFpcnFkX2lzX2FjdGl2YXRlZChpcnFkKSAmJg0KICAgICAg
ICAgICAgICAoYXBpY2QtPmlzX21hbmFnZWQgfHwgYXBpY2QtPmNhbl9yZXNlcnZlKSkgICAgDQoN
Ck15IG9yaWdpbmFsIHBhdGNoIHNob3VsZCBjZXJ0YWluIGNoZWNrIGFjdGl2YXRlZCBhbmQgbm90
IGRpc2FibGVkLiBXaXRoIHRoYXQgZG8geW91IHN0aWxsIGhhdmUgcmVzZXJ2YXRpb25zIE1hcmM/
DQoNClRoYW5rcywNCkFsaQ0KDQoNCg0KDQo=
