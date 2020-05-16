Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900D82065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgEPOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 10:47:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:30525 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgEPOro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 10:47:44 -0400
IronPort-SDR: 31F+ocGR0+ZvC8+wJBOXiGht+TKxMk9Nz02gmffTSGqepy9Uw2E+UjXAIBxkK+YUAzolwaCf0J
 vkEqM6rgRg4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 07:47:44 -0700
IronPort-SDR: rqwkQ6MFAbHlJLc5tUrGJ0anEOwZmDNYpGm8atU4HKFqjbNTQRoqanzY2doi7gOqg5BubK6nnN
 o48Fj2d1/Kcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="372965421"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2020 07:47:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.248]) with mapi id 14.03.0439.000;
 Sat, 16 May 2020 07:47:43 -0700
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
Thread-Index: AQHWIw2S9gwrq1Tja0uhU2CYrRqdxaiqzPCAgAAO3DI=
Date:   Sat, 16 May 2020 14:47:42 +0000
Message-ID: <1138B55F-89DD-4ABA-98C2-61D2ED961764@intel.com>
References: <20200505184648.2264-1-tony.luck@intel.com>,<20200516065431.GB25771@zn.tnic>
In-Reply-To: <20200516065431.GB25771@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaXMgb25seSBvbmUgYWN0dWFsIG1hY2hpbmUgY2hlY2suIEJ1dCB0aGUgVk1NIHNpbXVs
YXRlcyBhIHNlY29uZCBtYWNoaW5lIGNoZWNrIHRvIHRoZSBndWVzdCB3aGVuIHRoZSBndWVzdCB0
cmllcyB0byBhY2Nlc3MgdGhlIHBvaXNvbmVkIHBhZ2UuDQoNClRoZSBzdGFjayB0cmFjZSB3YXMg
ZnJvbSBKdWUuIEkgZGlkbuKAmXQgdHJ5IHRvIGNoZWNrIGl0LiBCdXQgaXQgbG9va2VkIHJlYXNv
bmFibGUgdGhhdCBMaW51eCB3b3VsZCBmbHVzaCB0aGUgY2FjaGUgZm9yIGEgcGFnZSB0aGF0IGlz
IHRyYW5zaXRpb25pbmcgZnJvbSBjYWNoZWFibGUgdG8gdW5jYWNoZWFibGUuDQoNClNlbnQgZnJv
bSBteSBpUGhvbmUNCg0KPiBPbiBNYXkgMTUsIDIwMjAsIGF0IDIzOjU0LCBCb3Jpc2xhdiBQZXRr
b3YgPGJwQGFsaWVuOC5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUdWUsIE1heSAwNSwgMjAyMCBh
dCAxMTo0Njo0OEFNIC0wNzAwLCBUb255IEx1Y2sgd3JvdGU6DQo+PiBBbiBpbnRlcmVzdGluZyB0
aGluZyBoYXBwZW5lZCB3aGVuIGEgZ3Vlc3QgTGludXggaW5zdGFuY2UgdG9vaw0KPj4gYSBtYWNo
aW5lIGNoZWNrLiBUaGUgVk1NIHVubWFwcGVkIHRoZSBiYWQgcGFnZSBmcm9tIGd1ZXN0IHBoeXNp
Y2FsDQo+PiBzcGFjZSBhbmQgcGFzc2VkIHRoZSBtYWNoaW5lIGNoZWNrIHRvIHRoZSBndWVzdC4N
Cj4+IA0KPj4gTGludXggdG9vayBhbGwgdGhlIG5vcm1hbCBhY3Rpb25zIHRvIG9mZmxpbmUgdGhl
IHBhZ2UgZnJvbSB0aGUgcHJvY2Vzcw0KPj4gdGhhdCB3YXMgdXNpbmcgaXQuIEJ1dCB0aGVuIGd1
ZXN0IExpbnV4IGNyYXNoZWQgYmVjYXVzZSBpdCBzYWlkIHRoZXJlDQo+PiB3YXMgYSBzZWNvbmQg
bWFjaGluZSBjaGVjayBpbnNpZGUgdGhlIGtlcm5lbCB3aXRoIHRoaXMgc3RhY2sgdHJhY2U6DQo+
PiANCj4+IGRvX21lbW9yeV9mYWlsdXJlDQo+PiAgICBzZXRfbWNlX25vc3BlYw0KPj4gICAgICAg
ICBzZXRfbWVtb3J5X3VjDQo+PiAgICAgICAgICAgICAgX3NldF9tZW1vcnlfdWMNCj4+ICAgICAg
ICAgICAgICAgICAgIGNoYW5nZV9wYWdlX2F0dHJfc2V0X2Nscg0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICBjcGFfZmx1c2gNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbGZsdXNo
X2NhY2hlX3JhbmdlX29wdA0KPiANCj4gTWF5YmUgSSBkb24ndCBzZWUgaXQgYnV0IGhvdyBjYW4g
Y2xmbHVzaF9jYWNoZV9yYW5nZV9vcHQoKSBjYWxsDQo+IGNwYV9mbHVzaCgpID8NCj4gDQo+PiBU
aGlzIHdhcyBvZGQsIGJlY2F1c2UgYSBDTEZMVVNIIGluc3RydWN0aW9uIHNob3VsZG4ndCByYWlz
ZSBhIG1hY2hpbmUNCj4+IGNoZWNrIChpdCBpc24ndCBjb25zdW1pbmcgdGhlIGRhdGEpLiBGdXJ0
aGVyIGludmVzdGlnYXRpb24gc2hvd2VkIHRoYXQNCj4+IHRoZSBWTU0gaGFkIHBhc3NlZCBpbiBh
bm90aGVyIG1hY2hpbmUgY2hlY2sgYmVjYXVzZSBpcyBhcHBlYXJlZCB0aGF0IHRoZQ0KPj4gZ3Vl
c3Qgd2FzIGFjY2Vzc2luZyB0aGUgYmFkIHBhZ2UuDQo+IA0KPiBUaGlzIGlzIHdoZXJlIHlvdSBs
b3N0IG1lIC0gaWYgdGhlIFZNTSB1bm1hcHMgdGhlIHBhZ2UgZHVyaW5nIHRoZSBmaXJzdA0KPiBN
Q0UsIGhvdyBjYW4gdGhlIGd1ZXN0IGV2ZW4gYXR0ZW1wdCB0byB0b3VjaCBpdCBhbmQgZG8gdGhp
cyBzdGFjayB0cmFjZQ0KPiBhYm92ZT8NCj4gDQo+IC9tZSBpcyBjb25mdXNlZC4NCj4gDQo+IC0t
IA0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtl
cm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=
