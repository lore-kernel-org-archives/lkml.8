Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBB5C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E583221D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBRSBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:01:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:61234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRSBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:01:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 10:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="229545068"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 18 Feb 2020 10:01:38 -0800
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 10:01:38 -0800
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.129]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.29]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 10:01:37 -0800
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "s.zharkoff@gmail.com" <s.zharkoff@gmail.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC:     "airlied@redhat.com" <airlied@redhat.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>
Subject: Re: lockup on boot -- drm/i915/display: Force the state compute
 phase once to enable PSR
Thread-Topic: lockup on boot -- drm/i915/display: Force the state compute
 phase once to enable PSR
Thread-Index: AQHV5lFoC6T9MFo/lE+Y1qx4cXwPi6ghxJcA
Date:   Tue, 18 Feb 2020 18:01:37 +0000
Message-ID: <eb191e966bb4065239d413fd904684de24d37789.camel@intel.com>
References: <20200217200942.GA2433@light.dominikbrodowski.net>
         <20200217220852.55cbac43@collabora.com>
         <20200218114821.GA2240@light.dominikbrodowski.net>
In-Reply-To: <20200218114821.GA2240@light.dominikbrodowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.14.232]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DA84107666A674F8E93A51113551788@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KWWVzIHRoaXMgcGF0Y2ggaGFzIGEgaXNzdWUgYW5kIHdlIGhhdmUgYSBmaXgsIEknbSB0
cnlpbmcgdG8gZmluZA0Kc29tZW9uZSB0byByZXZpZXcgaXQsIG1vcmUgaW5mb3JtYXRpb246IA0K
aHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pbnRlbC9pc3N1ZXMvMTE1MQ0KDQpP
biBUdWUsIDIwMjAtMDItMTggYXQgMTI6NDggKzAxMDAsIERvbWluaWsgQnJvZG93c2tpIHdyb3Rl
Og0KPiBPbiBNb24sIEZlYiAxNywgMjAyMCBhdCAxMDowODo1MlBNICswMTAwLCBCb3JpcyBCcmV6
aWxsb24gd3JvdGU6DQo+ID4gT24gTW9uLCAxNyBGZWIgMjAyMCAyMTowOTo0MiArMDEwMA0KPiA+
IERvbWluaWsgQnJvZG93c2tpIDxsaW51eEBkb21pbmlrYnJvZG93c2tpLm5ldD4gd3JvdGU6DQo+
ID4gDQo+ID4gPiBPbiBteSBvbGQgRGVsbCBYUFMgMTMgbGFwdG9wIHdpdGgNCj4gPiA+IA0KPiA+
ID4gMDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gQnJvYWR3ZWxsLVUgSG9z
dCBCcmlkZ2UNCj4gPiA+IC1PUEkgKHJldiAwOSkNCj4gPiA+IDAwOjAyLjAgVkdBIGNvbXBhdGli
bGUgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gSEQgR3JhcGhpY3MNCj4gPiA+IDU1MDAg
KHJldiAwOSkgKHByb2ctaWYgMDAgW1ZHQSBjb250cm9sbGVyXSkNCj4gPiA+IA0KPiA+ID4gYm9v
dGluZyA1LjYtcmMxIGFuZCAtcmMyIGZhaWxzIGFmdGVyIHRoZSBkbWVzZyBsaW5lDQo+ID4gPiAN
Cj4gPiA+IAlmYjA6IHN3aXRjaGluZyB0byBpbnRlbGRybWZiIGZyb20gc2ltcGxlDQo+ID4gPiAN
Cj4gPiA+IHdoaWxlIHRoZSBuZXh0IGxpbmVzIHNob3VsZCBiZSBzb21ldGhpbmcgbGlrZSAodjUu
NSk6DQo+ID4gPiANCj4gPiA+IAlDb25zb2xlOiBzd2l0Y2hpbmcgdG8gY29sb3VyIGR1bW15IGRl
dmljZSA4MHgyNQ0KPiA+ID4gCWk5MTUgMDAwMDowMDowMi4wOiB2Z2FhcmI6IGRlYWN0aXZhdGUg
dmdhIGNvbnNvbGUNCj4gPiA+IAlbZHJtXSBBQ1BJIEJJT1MgcmVxdWVzdHMgYW4gZXhjZXNzaXZl
IHNsZWVwIG9mIDI1MDAwIG1zLCB1c2luZw0KPiA+ID4gMTUwMCBtcyBpbnN0ZWFkDQo+ID4gPiAJ
W2RybV0gU3VwcG9ydHMgdmJsYW5rIHRpbWVzdGFtcCBjYWNoaW5nIFJldiAyICgyMS4xMC4yMDEz
KS4NCj4gPiA+IAlbZHJtXSBEcml2ZXIgc3VwcG9ydHMgcHJlY2lzZSB2YmxhbmsgdGltZXN0YW1w
IHF1ZXJ5Lg0KPiA+ID4gCWk5MTUgMDAwMDowMDowMi4wOiB2Z2FhcmI6IGNoYW5nZWQgVkdBIGRl
Y29kZXM6DQo+ID4gPiBvbGRkZWNvZGVzPWlvK21lbSxkZWNvZGVzPWlvK21lbTpvd25zPWlvK21l
bQ0KPiA+ID4gDQo+ID4gPiBBIGdpdCBiaXNlY3QgbGVhZCB0bw0KPiA+ID4gDQo+ID4gPiAJY29t
bWl0IGI4NmQ4OTU1MjRhYiAoImRybS9icmlkZ2U6IEFkZCBhbiAtPmF0b21pY19jaGVjaygpDQo+
ID4gPiBob29rIikNCj4gPiANCj4gPiBUaGlzIGNvbW1pdCBoYXMgYmVlbiByZXZlcnRlZDogeW91
IHNob3VsZCBpZ25vcmUgYW55IGZhaWx1cmVzDQo+ID4gYmV0d2Vlbg0KPiA+IGI4NmQ4OTU1MjRh
YiAoImRybS9icmlkZ2U6IEFkZCBhbiAtPmF0b21pY19jaGVjaygpIGhvb2siKSBhbmQNCj4gPiAw
OTkxMjYzNTIzMDMgKCJSZXZlcnQgImRybS9icmlkZ2U6IEFkZCBhIGRybV9icmlkZ2Vfc3RhdGUg
b2JqZWN0IikuDQo+IA0KPiBBIG5ldyBiaXNlY3Qgbm93IHBvaW50cyB0bw0KPiANCj4gCTYwYzZh
MTRiNDg5YiAoImRybS9pOTE1L2Rpc3BsYXk6IEZvcmNlIHRoZSBzdGF0ZSBjb21wdXRlIHBoYXNl
DQo+IAlvbmNlIHRvIGVuYWJsZSBQU1IiKS4NCj4gDQo+IFBsZWFzZSBub3RlIHRoYXQgYmlzZWN0
aW5nIHRoaXMgaXMgcXVpdGUgYSBoYXNzbGUsIGluIHBhcnRpY3VsYXIgZHVlDQo+IHRvDQo+IHZh
cmlvdXMgcmV2ZXJ0cyBpbiBiZXR3ZWVuIGFuZCBiYWNrLW1lcmdlcyAoc3VjaCBhcyBlYzAyN2Iz
M2M4YmIsDQo+IHdoaWNoIGhhcw0KPiB0d28gcGFyZW50cyBpbiAiYmFkIiBzdGF0ZSkuIEFzIDYw
YzZhMTRiNDg5YiBkb2VzIG5vdCByZXZlcnQgY2xlYW5seSwNCj4gSQ0KPiBjYW4ndCB0ZXN0IGEg
cmV2ZXJ0IG9uIHRvcCBvZiA1LjYtcmMyLg0KPiANCj4gVGhhbmtzLA0KPiAJRG9taW5paw0K
