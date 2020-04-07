Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E113BC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA24C2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDGV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:26:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53197 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgDGV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:26:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-52-92QqPk1OMtCG-Q0ygmijTQ-1; Tue, 07 Apr 2020 22:25:57 +0100
X-MC-Unique: 92QqPk1OMtCG-Q0ygmijTQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 7 Apr 2020 22:25:56 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 7 Apr 2020 22:25:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kenny@panix.com" <kenny@panix.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "thellstrom@vmware.com" <thellstrom@vmware.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dcovelli@vmware.com" <dcovelli@vmware.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: RE: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Thread-Topic: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Thread-Index: AQHWDM13xoy91raOhkKuBOKktFSrAahuK2jQ
Date:   Tue, 7 Apr 2020 21:25:56 +0000
Message-ID: <23787a63b28744b1906c4d4b6209b6af@AcuMS.aculab.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
In-Reply-To: <20200407111007.352324393@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMDcgQXByaWwgMjAyMCAxMjowMw0KPiANCj4g
SXQgdHVybnMgb3V0IHRoYXQgd2l0aCBTcGxpdC1Mb2NrLURldGVjdCBlbmFibGVkIChkZWZhdWx0
KSBhbnkgVk1YDQo+IGh5cGVydmlzb3IgbmVlZHMgYXQgbGVhc3QgYSBsaXR0bGUgbW9kaWZpY2F0
aW9uIGluIG9yZGVyIHRvIG5vdCBibGluZGx5DQo+IGluamVjdCB0aGUgI0FDIGludG8gdGhlIGd1
ZXN0IHdpdGhvdXQgdGhlIGd1ZXN0IGJlaW5nIHJlYWR5IGZvciBpdC4NCj4gDQo+IFNpbmNlIHRo
ZXJlIGlzIG5vIHRlbGxpbmcgd2hpY2ggbW9kdWxlIGltcGxlbWVudHMgYSBoeXBlcnZpc29yLCBz
Y2FuDQo+IGFsbCBvdXQtb2YtdHJlZSBtb2R1bGVzJyB0ZXh0IGFuZCBsb29rIGZvciBWTVggaW5z
dHJ1Y3Rpb25zIGFuZCByZWZ1c2UNCj4gdG8gbG9hZCBpdCB3aGVuIFNMRCBpcyBlbmFibGVkIChk
ZWZhdWx0KSBhbmQgdGhlIG1vZHVsZSBpc24ndCBtYXJrZWQNCj4gJ3NsZF9zYWZlJy4NCi4uLg0K
PiArCXdoaWxlICh0ZXh0IDwgdGV4dF9lbmQpIHsNCj4gKwkJa2VybmVsX2luc25faW5pdCgmaW5z
biwgdGV4dCwgdGV4dF9lbmQgLSB0ZXh0KTsNCj4gKwkJaW5zbl9nZXRfbGVuZ3RoKCZpbnNuKTsN
Cj4gKw0KPiArCQlpZiAoV0FSTl9PTl9PTkNFKCFpbnNuX2NvbXBsZXRlKCZpbnNuKSkpIHsNCj4g
KwkJCXByX2VycigiTW9kdWxlIHRleHQgbWFsZm9ybWVkOiAlc1xuIiwgbW9kLT5uYW1lKTsNCj4g
KwkJCXJldHVybiAtRU5PRVhFQzsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICghYWxsb3dfdm14ICYm
IGluc25faXNfdm14KCZpbnNuKSkgew0KPiArCQkJcHJfZXJyKCJNb2R1bGUgaGFzIFZNWCBpbnN0
cnVjdGlvbnMgYW5kIGlzIG5vdCBtYXJrZWQgJ3NsZF9zYWZlJywgYm9vdCB3aXRoOg0KPiAnc3Bs
aXRfbG9ja19kZXRlY3Q9b2ZmJzogJXNcbiIsIG1vZC0+bmFtZSk7DQo+ICsJCQlyZXR1cm4gLUVO
T0VYRUM7DQo+ICsJCX0NCj4gKw0KPiArCQl0ZXh0ICs9IGluc24ubGVuZ3RoOw0KPiArCX0NCg0K
VGhlcmUgaXMgYSBzbGlnaHQgZmxhdyBpbiB0aGUgYWJvdmUuDQpBIG1hbGljaW91cyBtb2R1bGUg
Y2FuIGhpZGUgdGhlIHJlcXVpcmVkIGluc3RydWN0aW9uIGJ5IGp1bXBpbmcgaW50byB0aGUNCm1p
ZGRsZSBvZiBhIGxvbmcgaW5zdHJ1Y3Rpb24uDQoNCkV2ZW4gY2hlY2tpbmcgYnJhbmNoIHRhcmdl
dHMgaGl0IGluc3RydWN0aW9uIGJhcnJpZXJzIGlzbid0IGVub3VnaCwNCmFuIGluZGlyZWN0IGp1
bXAgY291bGQgYmUgdXNlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

