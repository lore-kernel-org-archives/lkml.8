Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9FDC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2620836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgD3T7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:59:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:19811 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgD3T7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:59:07 -0400
IronPort-SDR: IIGg+zsTns2nfPnwHZsArttq5Re+6NfhyTU6C64tcsX9H8egrq2TdPxGMTyrZ02+vYgqWq9NfK
 4WRsSBNBy8cg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 12:59:05 -0700
IronPort-SDR: s1mjBUu/ajRwjZ3ZpNgANTVYmxk6oLFeP0VXuFISLP9/D38GZlsNzWaTxlfq4vHTzFC9hmPVwR
 WLJx4yNqwbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="248370687"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
  by fmsmga007.fm.intel.com with ESMTP; 30 Apr 2020 12:59:04 -0700
Received: from irsmsx103.ger.corp.intel.com ([169.254.3.44]) by
 IRSMSX153.ger.corp.intel.com ([169.254.9.216]) with mapi id 14.03.0439.000;
 Thu, 30 Apr 2020 20:49:37 +0100
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/1] Add IMR driver for Keem Bay
Thread-Topic: [PATCH 0/1] Add IMR driver for Keem Bay
Thread-Index: AQHWF/bwdmCqRgB2xEunJAxCAmyaOqiSEEGA
Date:   Thu, 30 Apr 2020 19:49:36 +0000
Message-ID: <d3f045b05c83d0eca1d5498587493ca485e0a1a0.camel@intel.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
In-Reply-To: <cover.1587485099.git.daniele.alessandrelli@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.22.135]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6BF041FE16A394DA13BF5020330A280@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTIxIGF0IDE3OjM2ICswMTAwLCBEYW5pZWxlIEFsZXNzYW5kcmVsbGkg
d3JvdGU6DQo+IFRoZSBmb2xsb3dpbmcgaXMgYSBwYXRjaCBmb3IgYSBuZXcgSW50ZWwgTW92aWRp
dXMgU29DLCBjb2RlLW5hbWVkDQo+IEtlZW0NCj4gQmF5Lg0KPiANCj4gS2VlbSBCYXkgbmVlZHMg
YSBkcml2ZXIgdG8gZGlzYWJsZSB0aGUgSXNvbGF0ZWQgTWVtb3J5IFJlZ2lvbiAoSU1SKQ0KPiBz
ZXQgdXAgYnkgdGhlIFNvQyBib290bG9hZGVyIGR1cmluZyBlYXJseSBib290Lg0KPiANCj4gSWYg
c3VjaCBhbiBJTVIgaXMgbm90IGRpc2FibGVkIGFuZCBzb21lIGRldmljZSB0cmllcyB0byBhY2Nl
c3MgaXQsDQo+IHRoZSBzeXN0ZW0gd2lsbCByZWJvb3QuDQo+IA0KPiBTaW5jZSB0aGlzIGRyaXZl
ciBpcyBTb0Mtc3BlY2lmaWMgYW5kIEtlZW0gQmF5IGlzIGEgbmV3IFNvQywgSSB3YXMNCj4gdW5z
dXJlIG9mIHdoZXJlIHRvIHB1dCB0aGlzIGRyaXZlci4gSW4gdGhlIGVuZCBJIGRlY2lkZWQgdG8g
Y3JlYXRlIGENCj4gbmV3ICdrZWVtYmF5JyBkaXJlY3RvcnkgaW4gJ2RyaXZlcnMvc29jJy4gSSBo
b3BlIHRoYXQncyByZWFzb25hYmxlLA0KPiBpZg0KPiBub3QsIGp1c3QgbGV0IG1lIGtub3cuDQo+
IA0KPiANCj4gRGFuaWVsZSBBbGVzc2FuZHJlbGxpICgxKToNCj4gICBzb2M6IGtlZW1iYXk6IEFk
ZCBLZWVtIEJheSBJTVIgZHJpdmVyDQo+IA0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDUgKysrKw0KPiAgZHJpdmVycy9zb2MvS2NvbmZpZyAgICAgICAgICAgICAgIHwg
IDEgKw0KPiAgZHJpdmVycy9zb2MvTWFrZWZpbGUgICAgICAgICAgICAgIHwgIDEgKw0KPiAgZHJp
dmVycy9zb2Mva2VlbWJheS9LY29uZmlnICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysNCj4g
IGRyaXZlcnMvc29jL2tlZW1iYXkvTWFrZWZpbGUgICAgICB8ICA1ICsrKysNCj4gIGRyaXZlcnMv
c29jL2tlZW1iYXkva2VlbWJheS1pbXIuYyB8IDQwDQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL2tlZW1iYXkvS2NvbmZpZw0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvc29jL2tlZW1iYXkvTWFrZWZpbGUNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3NvYy9rZWVtYmF5L2tlZW1iYXktaW1yLmMNCj4gDQoNCkFkZGluZyBzb21lIG1v
cmUgcGVvcGxlIChBcm5kIGFuZCBsaW51eC1hcm0ta2VybmVsIE1MKSBpbiBDQyBpbiB0aGUNCmhv
cGUgb2YgZ2V0dGluZyBzb21lIGd1aWRhbmNlIG9uIGhvdyB0byBoYXZlIHRoaXMgcGF0Y2ggbWVy
Z2VkLg0KDQpJJ20gYSBub3ZpY2UsIHNvIEkgd29uZGVyIGlmIHRoZSBsYWNrIG9mIGZlZWRiYWNr
IGlzIGJlY2F1c2UgSSdtIGRvaW5nDQpzb21ldGhpbmcgd3Jvbmcgb3IgaWYgSSBqdXN0IHNlbnQg
dGhlIGluaXRpYWwgZW1haWwgdG8gdGhlIHdyb25nIHBlb3BsZQ0KLyBNTC4NCg0KSSdkIGFwcHJl
Y2lhdGUgYW55IGhlbHAgeW91IGNhbiBwcm92aWRlLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgUmVzZWFyY2ggYW5k
IERldmVsb3BtZW50IElyZWxhbmQgTGltaXRlZApSZWdpc3RlcmVkIGluIElyZWxhbmQKUmVnaXN0
ZXJlZCBPZmZpY2U6IENvbGxpbnN0b3duIEluZHVzdHJpYWwgUGFyaywgTGVpeGxpcCwgQ291bnR5
IEtpbGRhcmUKUmVnaXN0ZXJlZCBOdW1iZXI6IDMwODI2MwoKClRoaXMgZS1tYWlsIGFuZCBhbnkg
YXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvciB0aGUgc29s
ZQp1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmlldyBvciBkaXN0cmli
dXRpb24gYnkgb3RoZXJzIGlzCnN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZQpzZW5kZXIgYW5kIGRlbGV0
ZSBhbGwgY29waWVzLgo=

