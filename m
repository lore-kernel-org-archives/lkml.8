Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D773C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3952D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAMSDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:03:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:64408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgAMSDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:03:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 10:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="224966825"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2020 10:03:03 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jan 2020 10:03:03 -0800
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.176]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.66]) with mapi id 14.03.0439.000;
 Mon, 13 Jan 2020 10:03:03 -0800
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "yu.chen.surf@gmail.com" <yu.chen.surf@gmail.com>
CC:     "andy@infradead.org" <andy@infradead.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] platform/x86: Add support for Uncore frequency
 control
Thread-Topic: [PATCH v2 1/2] platform/x86: Add support for Uncore frequency
 control
Thread-Index: AQHVyjuyCLsJKviD70yz0ANGAu3SRQ==
Date:   Mon, 13 Jan 2020 18:03:02 +0000
Message-ID: <3fc777da692d107a75ad648de4be5bbfa927d2be.camel@intel.com>
References: <20200113035917.1419452-1-srinivas.pandruvada@linux.intel.com>
         <CADjb_WQkq0R8eCNvZgtjytc3dcn9_65pzCt9brYZHo6ATy5wuw@mail.gmail.com>
In-Reply-To: <CADjb_WQkq0R8eCNvZgtjytc3dcn9_65pzCt9brYZHo6ATy5wuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 (3.34.2-1.fc31) 
x-originating-ip: [10.54.75.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <075C8C8BE924844787788BAC5BAF002C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlbnl1LA0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGluZy4NCg0KT24gTW9uLCAyMDIwLTAx
LTEzIGF0IDE1OjAwICswODAwLCBZdSBDaGVuIHdyb3RlOg0KPiBIaSBTcmluaXZhcywNCj4gT24g
TW9uLCBKYW4gMTMsIDIwMjAgYXQgMTE6NTkgQU0gU3Jpbml2YXMgUGFuZHJ1dmFkYQ0KPiA8c3Jp
bml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+ICsNCj4gPiArLyog
Q29tbW9uIGZ1bmN0aW9uIHRvIHNldCBtaW4vbWF4IHJhdGlvcyB0byBiZSB1c2VkIGJ5IHN5c2Zz
DQo+ID4gY2FsbGJhY2tzICovDQo+ID4gK3N0YXRpYyBpbnQgdW5jb3JlX3dyaXRlX3JhdGlvKHN0
cnVjdCB1bmNvcmVfZGF0YSAqZGF0YSwgdW5zaWduZWQNCj4gPiBpbnQgaW5wdXQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHNldF9tYXgpDQo+ID4gK3sNCj4gPiArICAg
ICAgIGludCByZXQ7DQo+ID4gKyAgICAgICB1NjQgY2FwOw0KPiA+ICsNCj4gPiArICAgICAgIG11
dGV4X2xvY2soJnVuY29yZV9sb2NrKTsNCj4gPiArDQo+ID4gKyAgICAgICBpbnB1dCAvPSBVTkNP
UkVfRlJFUV9LSFpfTVVMVElQTElFUjsNCj4gPiArICAgICAgIGlmICghaW5wdXQgfHwgaW5wdXQg
PiAweDdGKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gKyAgICAg
ICAgICAgICAgIGdvdG8gZmluaXNoX3dyaXRlOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgICAgIHJkbXNybChNU1JfVU5DT1JFX1JBVElPX0xJTUlULCBjYXApOw0KPiBTaG91bGQgaXQg
YmUgcmRtc3JsX29uX2NwdSgpPw0KWWVzLiBGaXhlZCBhbmQgc2VudCB1cGRhdGUuDQoNClRoYW5r
cywNClNyaW5pdmFzDQoNCj4gDQo+IFRoYW5rcywNCj4gQ2hlbnl1DQo=
