Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9873CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D80D206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgEQBw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 21:52:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:8025 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgEQBw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 21:52:26 -0400
IronPort-SDR: iEAIomVaZFHUExutoetpKoTBr7CHEgFKU+xYTJClnyhnw9ukgx1FbZin0s3qZtQowTBKjPOT4P
 iXIqjy3XLdRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 18:52:26 -0700
IronPort-SDR: vaL/bMD+QHFxT58e17+m0TMhZyY6BHxik++w/hPTcPw1JiUB3GP0P3fs/NY76BxKi8jipDZwbD
 LNinNcKYyYRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,401,1583222400"; 
   d="scan'208";a="281625857"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2020 18:52:26 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 May 2020 18:52:25 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.25]) with mapi id 14.03.0439.000;
 Sat, 16 May 2020 18:52:25 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Thread-Topic: [PATCH] x86/mm: Don't try to change poison pages to
 uncacheable in a guest
Thread-Index: AQHWIw2S9gwrq1Tja0uhU2CYrRqdxaiqzPCAgAAO3DKAAHl6gIAAtZYA
Date:   Sun, 17 May 2020 01:52:25 +0000
Message-ID: <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
References: <20200516150229.GB19372@zn.tnic>
In-Reply-To: <20200516150229.GB19372@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE9221FD2D70B747ADB95FA0A0C5228E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QnV0IHRoZSBndWVzdCBpc27igJl0IGxpa2VseSB0byBkbyB0aGUgcmlnaHQgdGhpbmcgd2l0aCBh
IHBhZ2UgZmF1bHQuIFRoZSBndWVzdCBqdXN0IGFjY2Vzc2VkIGEgcGFnZSB0aGF0IGl0IGtub3dz
IGlzIHBvaXNvbmVkIChWTU0ganVzdCB0b2xkIGl0IG9uY2UgdGhhdCBpdCB3YXMgcG9pc29uZWQp
LiBUaGVyZSBpcyBubyByZWFzb24gdGhhdCB0aGUgVk1NIHNob3VsZCBsZXQgdGhlIGd1ZXN0IGFj
dHVhbGx5IHRvdWNoIHRoZSBwb2lzb24gYSBzZWNvbmQgdGltZS4gQnV0IGlmIHRoZSBndWVzdCBk
b2VzLCB0aGVuIHRoZSBndWVzdCBzaG91bGQgZ2V0IHRoZSBleHBlY3RlZCByZXNwb25zZS4gIEku
ZS4gYW5vdGhlciBtYWNoaW5lIGNoZWNrLg0KDQpTZW50IGZyb20gbXkgaVBob25lDQoNCj4gT24g
TWF5IDE2LCAyMDIwLCBhdCAwODowMywgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+IHdy
b3RlOg0KPiANCj4g77u/T24gU2F0LCBNYXkgMTYsIDIwMjAgYXQgMDI6NDc6NDJQTSArMDAwMCwg
THVjaywgVG9ueSB3cm90ZToNCj4+IFRoZXJlIGlzIG9ubHkgb25lIGFjdHVhbCBtYWNoaW5lIGNo
ZWNrLiBCdXQgdGhlIFZNTSBzaW11bGF0ZXMgYSBzZWNvbmQNCj4+IG1hY2hpbmUgY2hlY2sgdG8g
dGhlIGd1ZXN0IHdoZW4gdGhlIGd1ZXN0IHRyaWVzIHRvIGFjY2VzcyB0aGUgcG9pc29uZWQNCj4+
IHBhZ2UuDQo+IA0KPiBJZiB0aGUgVk1NIHVubWFwcyB0aGUgYmFkIHBhZ2UsIHdoeSBkb2Vzbid0
IHRoZSBndWVzdCBnZXQgYSAjUEYgaW5zdGVhZA0KPiBpbmplY3RlZCBieSB0aGUgVk1NIGluc3Rl
YWQgb2YgbGF0dGVyIGluamVjdGluZyBhIHNlY29uZCAjTUNFPw0KPiANCj4gSWYgdGhlIGd1ZXN0
IHRyaWVzIHRvIGFjY2VzcyBhbiB1bm1hcHBlZCBwYWdlLCBpdCBzaG91bGQgZ2V0IGEgI1BGLCBJ
J2QNCj4gZXhwZWN0Lg0KPiANCj4gLS0gDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0K
PiANCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0
dGUNCg==
