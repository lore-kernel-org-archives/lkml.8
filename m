Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF10EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B53207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgE0NbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:31:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:37540 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbgE0NbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:31:08 -0400
IronPort-SDR: cPr9QEJLajX/OmnHfYwi59HqP9Q4ImQD3cCisdynpcicI/5abbWh/CjhzaTQH5h/chdJg7htRU
 NjQcF5w1peOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 06:31:07 -0700
IronPort-SDR: 4g+EGdLViyE/BApCoQKwJjbe0Yuq38StjiFfHVLHkOPvOI/nr56g4SXtsrYICTFRC86UljUwFd
 do+tWTf2yXZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="414204425"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2020 06:31:05 -0700
Received: from irsmsx103.ger.corp.intel.com ([169.254.3.180]) by
 IRSMSX104.ger.corp.intel.com ([169.254.5.58]) with mapi id 14.03.0439.000;
 Wed, 27 May 2020 14:31:04 +0100
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniele.alessandrelli@linux.intel.com" 
        <daniele.alessandrelli@linux.intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Thread-Topic: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Thread-Index: AQHWNCsR19Q+ykCgXk+PO11ypSMwbA==
Date:   Wed, 27 May 2020 13:31:04 +0000
Message-ID: <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
         <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
         <20200501081002.GA1055721@kroah.com>
         <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
         <20200524212851.GG1192@bug>
         <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
In-Reply-To: <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.23.181]
Content-Type: text/plain; charset="utf-8"
Content-ID: <429F807DF1B48F48800F02C228FD5FED@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwgUGF2ZWwsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCg0KPiA+ID4gDQo+
ID4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IEkgbmVlZCB0aGlzIGNvZGUgdG8gYmUgcnVuIGVhcmx5
IGF0IGJvb3QsIHNvDQo+ID4gPiBJDQo+ID4gPiBkb24ndCB0aGluayBJIGNhbiBtYWtlIHRoaXMg
YSBtb2R1bGUuDQo+ID4gDQo+ID4gSG93IGVhcmx5IGlzIGVhcmx5IGVub3VnaD8NCg0KQmFzaWNh
bGx5LCBiZWZvcmUgYW55IGRldmljZSB3aXRoIGRpcmVjdCBtZW1vcnkgYWNjZXNzIGlzIGFjdGl2
YXRlZA0KKGJlY2F1c2UgaWYgYW55Ym9keSwgZXhjZXB0IHRoZSBBUk0gQ1BVLCB0cmllcyB0byBh
Y2Nlc3MgdGhhdCBtZW1vcnksDQp0aGUgbWVtb3J5IHByb3RlY3Rpb24gbWVjaGFuaXNtIHdpbGwg
YmUgdHJpZ2dlcmVkIGFuZCBhIHJlYm9vdCB3aWxsDQpoYXBwZW4pLg0KDQo+ID4gDQo+ID4gV2hh
dCBib290bG9hZGVyIGFyZSB5b3UgdXNpbmc/DQoNClUtQm9vdA0KDQo+ID4gDQo+ID4gSSBiZWxp
ZXZlIHlvdSBzaG91bGQgc2ltcGx5IGZpeCB5b3VyIGJvb3Rsb2FkZXIgbm90IHRvIHBhc3MgbG9j
a2VkDQo+ID4gbWVtb3J5IHRvIHRoZSBrZXJuZWwuDQoNClRoZSBib290bG9hZGVyIGlzIGJlaGF2
aW5nIGxpa2UgdGhhdCBmb3Igc2VjdXJpdHkgcmVhc29ucywgc28gd2UnZCBsaWtlDQp0byBhdm9p
ZCBtb2RpZnlpbmcgaXQuIEknbGwgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGJlbG93Lg0KDQo+
ID4gDQo+ID4gQWx0ZXJuYXRpdmVseSwgdGFrZSB0aGF0IG1lbW9yeSBvZmYgdGhlICJtZW1vcnkg
YXZhaWxhYmxlIiBtYXBzLA0KPiA+IGFuZCBvbmx5IHJlLWFkZCBpdCBvbmNlDQo+ID4gaXQgaXMg
dXNhYmxlLg0KPiA+IA0KPiA+IEFueXRoaW5nIGVsc2UgaXMgZGFuZ2Vyb3VzLg0KDQpUaGF0IHNv
dW5kcyBsaWtlIGFuIGludGVyZXN0aW5nIHNvbHV0aW9uLCB0aGFua3MhDQoNCkRvIHlvdSBrbm93
IGFueSBjb2RlIHRoYXQgSSBjYW4gdXNlIGFzIGEgcmVmZXJlbmNlPw0KDQpTaW5jZSwgdGhlIHBy
b3RlY3RlZCBtZW1vcnkgaXMganVzdCBhIGZldyBtZWdhYnl0ZXMgbGFyZ2UsIEkgZ3Vlc3MgdGhh
dA0KaW4gdGhlb3J5IHdlIGNvdWxkIGp1c3QgaGF2ZSBVLUJvb3QgbWFyayBpdCBhcyByZXNlcnZl
ZCBtZW1vcnkgYW5kDQpmb3JnZXQgYWJvdXQgaXQ7IGJ1dCBpZiB0aGVyZSdzIGEgd2F5IHRvIHJl
LWFkZCBpdCBiYWNrIG9uY2UgaW4gTGludXgNCnRoYXQgd291bGQgYmUgZ3JlYXQuDQoNCj4gDQo+
IEFncmVlZCwgdGhpcyBzb3VuZHMgbGlrZSBhbiBpbmNvbXBhdGlibGUgZXh0ZW5zaW9uIG9mIHRo
ZSBib290DQo+IHByb3RvY29sDQo+IHRoYXQgd2Ugc2hvdWxkIG90aGVyd2lzZSBub3QgbWVyZ2Uu
DQo+IA0KPiBIb3dldmVyLCB0aGVyZSBpcyBhbHNvIGEgbG90IG9mIG1pc3NpbmcgaW5mb3JtYXRp
b24gaGVyZSwgYW5kIGl0IGlzDQo+IGFsd2F5cw0KPiBwb3NzaWJsZSB0aGV5IGFyZSB0cnlpbmcg
dG8gc29tZXRoaW5nIGZvciBhIGdvb2QgcmVhc29uLiBBcyBsb25nIGFzDQo+IHRoZQ0KPiBwcm9i
bGVtIHRoYXQgdGhlIGJvb3Rsb2FkZXIgaXMgdHJ5aW5nIHRvIHNvbHZlIGlzIGV4cGxhaW5lZCB3
ZWxsDQo+IGVub3VnaA0KPiBpbiB0aGUgY2hhbmdlbG9nLCB3ZSBjYW4gZGlzY3VzcyBpdCB0byBz
ZWUgaG93IGl0IHNob3VsZCBiZSBkb25lDQo+IHByb3Blcmx5Lg0KDQoNCkFwb2xvZ2llcywgSSBz
aG91bGQgaGF2ZSBwcm92aWRlZCBtb3JlIGluZm9ybWF0aW9uLiBIZXJlIGl0IGlzIDopDQoNCkJh
c2ljYWxseSwgYXQgYm9vdCB0aW1lIFUtQm9vdCBjb2RlIGFuZCBjb3JlIG1lbW9yeSAoLnRleHQs
IC5kYXRhLA0KLmJzcywgZXRjLikgaXMgcHJvdGVjdGVkIGJ5IHRoaXMgSXNvbGF0ZWQgTWVtb3J5
IFJlZ2lvbiAoSU1SKSB3aGljaA0KcHJldmVudHMgYW55IGRldmljZSBvciBwcm9jZXNzaW5nIHVu
aXRzIG90aGVyIHRoYW4gdGhlIEFSTSBDUFUgdG8NCmFjY2Vzcy9tb2RpZnkgdGhlIG1lbW9yeS4N
Cg0KVGhpcyBpcyBkb25lIGZvciBzZWN1cml0eSByZWFzb25zLCB0byByZWR1Y2UgdGhlIHJpc2tz
IHRoYXQgYSBwb3RlbnRpYWwNCmF0dGFja2VyIGNhbiB1c2UgImhpamFja2VkIiBIVyBkZXZpY2Vz
IHRvIGludGVyZmVyZSB3aXRoIHRoZSBib290DQpwcm9jZXNzIChhbmQgYnJlYWsgdGhlIHNlY3Vy
ZSBib290IGZsb3cgaW4gcGxhY2UpLg0KDQpCZWZvcmUgYm9vdGluZyB0aGUgS2VybmVsLCBVLUJv
b3Qgc2V0cyB1cCBhIG5ldyBJTVIgdG8gcHJvdGVjdCB0aGUNCktlcm5lbCBpbWFnZSAoc28gdGhh
dCB0aGUga2VybmVsIGNhbiBiZW5lZml0IG9mIGEgc2ltaWxhciBwcm90ZWN0aW9uKQ0KYW5kIHRo
ZW4gc3RhcnRzIHRoZSBrZXJuZWwsIGRlbGVnYXRpbmcgdG8gdGhlIGtlcm5lbCB0aGUgdGFzayBv
Zg0Kc3dpdGNoaW5nIG9mZiB0aGUgVS1Cb290IElNUi4NCg0KVS1Cb290IGRvZXNuJ3QgdHVybiBv
ZmYgaXRzIG93biBJTVIgYmVjYXVzZSBkb2luZyBzbyB3b3VsZCBsZWF2ZSBhDQoodGlueSkgd2lu
ZG93IGluIHdoaWNoIHRoZSBib290IGV4ZWN1dGlvbiBmbG93IGlzIG5vdCBwcm90ZWN0ZWQuDQoN
CklmIHlvdSBoYXZlIGFueSBhZGRpdGlvbmFsIHF1ZXN0aW9ucyBvciBmZWVkYmFjaywganVzdCBs
ZXQgbWUga25vdy4NCg0KUmVnYXJkcywNCkRhbmllbGUNCg0KDQoNCg0KDQoNCg0KDQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJ
bnRlbCBSZXNlYXJjaCBhbmQgRGV2ZWxvcG1lbnQgSXJlbGFuZCBMaW1pdGVkClJlZ2lzdGVyZWQg
aW4gSXJlbGFuZApSZWdpc3RlcmVkIE9mZmljZTogQ29sbGluc3Rvd24gSW5kdXN0cmlhbCBQYXJr
LCBMZWl4bGlwLCBDb3VudHkgS2lsZGFyZQpSZWdpc3RlcmVkIE51bWJlcjogMzA4MjYzCgoKVGhp
cyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0
ZXJpYWwgZm9yIHRoZSBzb2xlCnVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkg
cmV2aWV3IG9yIGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMKc3RyaWN0bHkgcHJvaGliaXRlZC4g
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhl
CnNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuCg==

