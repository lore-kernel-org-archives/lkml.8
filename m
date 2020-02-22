Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E8C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 02:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDE7206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 02:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBVCBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 21:01:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:45197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgBVCBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 21:01:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 18:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="437139619"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2020 18:01:52 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Feb 2020 18:01:52 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.43]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Fri, 21 Feb 2020 18:01:52 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Alexander Potapenko <glider@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] e1000: Distribute switch variables
 for initialization
Thread-Topic: [Intel-wired-lan] [PATCH] e1000: Distribute switch variables
 for initialization
Thread-Index: AQHV57Y+5dhSGYdeGkOTOhbTCfzrnqgmeD4A
Date:   Sat, 22 Feb 2020 02:01:51 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971F92DA@ORSMSX103.amr.corp.intel.com>
References: <20200220062302.68898-1-keescook@chromium.org>
In-Reply-To: <20200220062302.68898-1-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGludGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5v
cmc+IE9uIEJlaGFsZiBPZg0KPiBLZWVzIENvb2sNCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFy
eSAxOSwgMjAyMCAxMDoyMyBQTQ0KPiBUbzogS2lyc2hlciwgSmVmZnJleSBUIDxqZWZmcmV5LnQu
a2lyc2hlckBpbnRlbC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9y
ZzsgQWxleGFuZGVyIFBvdGFwZW5rbw0KPiA8Z2xpZGVyQGdvb2dsZS5jb20+OyBLZWVzIENvb2sg
PGtlZXNjb29rQGNocm9taXVtLm9yZz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSF0gZTEwMDA6IERpc3RyaWJ1dGUg
c3dpdGNoIHZhcmlhYmxlcyBmb3INCj4gaW5pdGlhbGl6YXRpb24NCj4gDQo+IFZhcmlhYmxlcyBk
ZWNsYXJlZCBpbiBhIHN3aXRjaCBzdGF0ZW1lbnQgYmVmb3JlIGFueSBjYXNlIHN0YXRlbWVudHMN
Cj4gY2Fubm90IGJlIGF1dG9tYXRpY2FsbHkgaW5pdGlhbGl6ZWQgd2l0aCBjb21waWxlciBpbnN0
cnVtZW50YXRpb24gKGFzDQo+IHRoZXkgYXJlIG5vdCBwYXJ0IG9mIGFueSBleGVjdXRpb24gZmxv
dykuIFdpdGggR0NDJ3MgcHJvcG9zZWQgYXV0b21hdGljDQo+IHN0YWNrIHZhcmlhYmxlIGluaXRp
YWxpemF0aW9uIGZlYXR1cmUsIHRoaXMgdHJpZ2dlcnMgYSB3YXJuaW5nIChhbmQgdGhleQ0KPiBk
b24ndCBnZXQgaW5pdGlhbGl6ZWQpLiBDbGFuZydzIGF1dG9tYXRpYyBzdGFjayB2YXJpYWJsZSBp
bml0aWFsaXphdGlvbg0KPiAodmlhIENPTkZJR19JTklUX1NUQUNLX0FMTD15KSBkb2Vzbid0IHRo
cm93IGEgd2FybmluZywgYnV0IGl0IGFsc28NCj4gZG9lc24ndCBpbml0aWFsaXplIHN1Y2ggdmFy
aWFibGVzWzFdLiBOb3RlIHRoYXQgdGhlc2Ugd2FybmluZ3MgKG9yIHNpbGVudA0KPiBza2lwcGlu
ZykgaGFwcGVuIGJlZm9yZSB0aGUgZGVhZC1zdG9yZSBlbGltaW5hdGlvbiBvcHRpbWl6YXRpb24g
cGhhc2UsDQo+IHNvIGV2ZW4gd2hlbiB0aGUgYXV0b21hdGljIGluaXRpYWxpemF0aW9ucyBhcmUg
bGF0ZXIgZWxpZGVkIGluIGZhdm9yIG9mDQo+IGRpcmVjdCBpbml0aWFsaXphdGlvbnMsIHRoZSB3
YXJuaW5ncyByZW1haW4uDQo+IA0KPiBUbyBhdm9pZCB0aGVzZSBwcm9ibGVtcywgbW92ZSBzdWNo
IHZhcmlhYmxlcyBpbnRvIHRoZSAiY2FzZSIgd2hlcmUNCj4gdGhleSdyZSB1c2VkIG9yIGxpZnQg
dGhlbSB1cCBpbnRvIHRoZSBtYWluIGZ1bmN0aW9uIGJvZHkuDQo+IA0KPiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9lMTAwMC9lMTAwMF9tYWluLmM6IEluIGZ1bmN0aW9uDQo+IOKAmGUxMDAw
X3htaXRfZnJhbWXigJk6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwL2UxMDAw
X21haW4uYzozMTQzOjE4OiB3YXJuaW5nOg0KPiBzdGF0ZW1lbnQgd2lsbCBuZXZlciBiZSBleGVj
dXRlZCBbLVdzd2l0Y2gtdW5yZWFjaGFibGVdDQo+ICAzMTQzIHwgICAgIHVuc2lnbmVkIGludCBw
dWxsX3NpemU7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICBefn5+fn5+fn4NCj4gDQo+IFsx
XSBodHRwczovL2J1Z3MubGx2bS5vcmcvc2hvd19idWcuY2dpP2lkPTQ0OTE2DQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMC9lMTAwMF9tYWluLmMgfCAgICA0ICsrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KVGVz
dGVkLWJ5OiBBYXJvbiBCcm93biA8YWFyb24uZi5icm93bkBpbnRlbC5jb20+DQo=
