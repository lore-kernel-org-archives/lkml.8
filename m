Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A802C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0605C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgC3Xmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:42:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:16165 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgC3Xmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:42:38 -0400
IronPort-SDR: RIBBxEKRhbXQaElimVgJWbBQ9z/NDzpoxl5fG4lkPJzabpeOyiAfK8ljKEcIEjzWledaWiLGpi
 Dh8hwIp/7VBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 16:42:38 -0700
IronPort-SDR: ny+5fObO39vAyUykM6CNJF0YhetZcr2MhqCisd5T8TLBd4c/OqUgE7lomcuK3NZo4B+tgk/o2/
 /+NFIxbThMew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; 
   d="scan'208";a="359329029"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2020 16:42:38 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 16:42:37 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.165]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.134]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 16:42:37 -0700
From:   "Park, Kyung Min" <kyung.min.park@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
Thread-Topic: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
Thread-Index: AQHV/m3yCORYmsI3CkqI0RgzexuEG6hRVwmAgABeFgCAAMawAIAAGecAgAAJR4CADz1qwA==
Date:   Mon, 30 Mar 2020 23:42:37 +0000
Message-ID: <3658BA65DD26AF4BA909BEB2C6DF6181A2A63C6A@ORSMSX102.amr.corp.intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
 <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
 <CALCETrWJ88CaGmij_NNysRjUQ6LPwwbPnMy1YPdKnM-cFDueSw@mail.gmail.com>
 <877dzf4a8v.fsf@nanos.tec.linutronix.de>
 <CALCETrUxOd6P-Yh78qjmOYnh9jY0ggeb4vB=coVjMjthXMTREg@mail.gmail.com>
 <87zhcaobjt.fsf@nanos.tec.linutronix.de>
 <CALCETrU9ucYrXxfDddgkKaP2-NBfmhqrFG51EiC6LWHOu0JaPQ@mail.gmail.com>
In-Reply-To: <CALCETrU9ucYrXxfDddgkKaP2-NBfmhqrFG51EiC6LWHOu0JaPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keS9UaG9tYXMsDQoNCiBPbiBGcmksIE1hciAyMCwgMjAyMCBhdCA0OjIzIFBNIFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gPg0KPiA+IEFuZHkgTHV0
b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiB3cml0ZXM6DQo+ID4NCj4gPiA+IE9uIEZyaSwgTWFy
IDIwLCAyMDIwIGF0IDM6MDAgQU0gVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
DQo+IHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5v
cmc+IHdyaXRlczoNCj4gPiA+PiA+IE9uIFRodSwgTWFyIDE5LCAyMDIwIGF0IDk6MTMgUE0gS3l1
bmcgTWluIFBhcmsNCj4gPGt5dW5nLm1pbi5wYXJrQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPj4g
Pj4gIHZvaWQgdXNlX3RzY19kZWxheSh2b2lkKQ0KPiA+ID4+ID4+ICB7DQo+ID4gPj4gPj4gLSAg
ICAgICBpZiAoZGVsYXlfZm4gPT0gZGVsYXlfbG9vcCkNCj4gPiA+PiA+PiArICAgICAgIGlmIChz
dGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9XQUlUUEtHKSkgew0KPiA+ID4+ID4+ICsgICAgICAg
ICAgICAgICBkZWxheV9oYWx0X2ZuID0gZGVsYXlfaGFsdF90cGF1c2U7DQo+ID4gPj4gPj4gKyAg
ICAgICAgICAgICAgIGRlbGF5X2ZuID0gZGVsYXlfaGFsdDsNCj4gPiA+PiA+PiArICAgICAgIH0g
ZWxzZSBpZiAoZGVsYXlfZm4gPT0gZGVsYXlfbG9vcCkgew0KPiA+ID4+ID4+ICAgICAgICAgICAg
ICAgICBkZWxheV9mbiA9IGRlbGF5X3RzYzsNCj4gPiA+PiA+PiArICAgICAgIH0NCj4gPiA+PiA+
PiAgfQ0KPiA+ID4+ID4NCj4gPiA+PiA+IFRoaXMgaXMgYW4gb2RkIHdheSB0byBkaXNwYXRjaDog
eW91J3JlIHVzaW5nIHN0YXRpY19jcHVfaGFzKCksDQo+ID4gPj4gPiBidXQgeW91J3JlIHVzaW5n
IGl0IG9uY2UgdG8gcG9wdWxhdGUgYSBmdW5jdGlvbiBwb2ludGVyLiAgV2h5IG5vdA0KPiA+ID4+
ID4ganVzdCBwdXQgdGhlIHN0YXRpY19jcHVfaGFzKCkgZGlyZWN0bHkgaW50byBkZWxheV9oYWx0
KCkgYW5kDQo+ID4gPj4gPiBvcGVuLWNvZGUgdGhlIHRocmVlIHZhcmlhbnRzPw0KPiA+ID4+DQo+
ID4gPj4gVHdvOiBtd2FpdHggYW5kIHRwYXVzZS4NCj4gPiA+DQo+ID4gPiBJIHdhcyBpbWFnaW5p
bmcgdGhlcmUgd291bGQgYWxzbyBiZSBhIHZhcmlhbnQgZm9yIHN5c3RlbXMgd2l0aCBuZWl0aGVy
DQo+IGZlYXR1cmUuDQo+ID4NCj4gPiBPaCBJIHNlZSwgeW91IHdhbnQgdG8gZ2V0IHJpZCBvZiBi
b3RoIGZ1bmN0aW9uIHBvaW50ZXJzLiBUaGF0J3MgdHJpY2t5Lg0KPiA+DQo+ID4gVGhlIGJvb3Qg
dGltZSBmdW5jdGlvbiBpcyBkZWxheV9sb29wKCkgd2hpY2ggaXMgdXNpbmcgdGhlIG1hZ2ljICgx
IDw8DQo+ID4gMTIpIGJvb3QgdGltZSB2YWx1ZSB1bnRpbCBjYWxpYnJhdGlvbiBpbiBvbmUgd2F5
IG9yIHRoZSBvdGhlciBoYXBwZW5zDQo+ID4gYW5kIHNvbWV0aGluZyBjYWxscyB1c2VfdHNjX2Rl
bGF5KCkgb3IgdXNlX213YWl0eF9kZWxheSgpLiBZZXMsIHRoYXQncw0KPiA+IGFsbCBob3JyaWJs
ZSBidXQgWDg2X0ZFQVRVUkVfVFNDIGlzIHVudXNhYmxlIGZvciB0aGlzLg0KPiA+DQo+ID4gTGV0
IG1lIHRoaW5rIGFib3V0IGl0Lg0KPiANCj4gVGhpcyBpcyBkZWZpbml0ZWx5IG5vdCB3b3J0aCBv
dmVyb3B0aW1pemluZy4gIEl0J3MgYSAqZGVsYXkqIGZ1bmN0aW9uDQo+IC0tIHRoZSByZXRwb2xp
bmUgaXNuJ3QgZ29pbmcgdG8ga2lsbCB1cyA6KQ0KDQpTaW5jZSB0aGUgdXNlX3RzY19kZWxheSgp
IGlzIHVzZWQganVzdCBvbmNlIGluIF9faW5pdCB0c2NfaW5pdCgpLCANCmhvdyBhYm91dCBhZGRp
bmcgIl9faW5pdCIgdG8gdGhlIHVzZV90c2NfZGVsYXkoKSBhbmQga2VlcCB0aGVzZSBmdW5jdGlv
biBwb2ludGVycz8NCg==
