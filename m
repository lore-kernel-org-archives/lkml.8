Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667AC47409
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598752070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="S6dAZ1r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgA2Xw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:52:58 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46264 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgA2Xw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:52:58 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A95AF891AA;
        Thu, 30 Jan 2020 12:52:54 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580341974;
        bh=PTdksFoM/7SQ5czBIotje9MiignV7b05HggnglFtQc4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=S6dAZ1r18b6INCasDmgP7mvqNyWu0bdI97O/XabFH7vwHdYX1Q9Ls1kEXQ5hEgtRk
         hPG+2TlNfLqiwomzCLaiounXZhVldSdPksyh2Tlt9mxE0IEqtpYTX18ss6+3J1YXP+
         A4r8wL2rgcrrU/faYsO2YzHCTURwF9QgvfG6k5zYNk/EmusNXQzk2fICre9oxEDEUU
         5pGJpb391liuRGVGC+AB4Vv4zlKQavvQN7AE0kty47neB0tGyiupn8i4cBh0JtREVJ
         vzRJR8/NQqPz2fRdikuNMR6HoMTIGnypQiLWgAmDsfWlupfdTfm5daWS6eqYpShGQD
         LteyulR2bdVoQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e321ad60000>; Thu, 30 Jan 2020 12:52:54 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Thu, 30 Jan 2020 12:52:49 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Thu, 30 Jan 2020 12:52:49 +1300
From:   Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Thread-Topic: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Thread-Index: AQHV1JVtwGwHv/A/qEeLHCGfFZLcOaf9zzQAgAJnaoCAANkQgIAAa6QA
Date:   Wed, 29 Jan 2020 23:52:49 +0000
Message-ID: <b6829b7582fd777babcad066f7b4c5c3684e4919.camel@alliedtelesis.co.nz>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
         <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
         <20200127154800.GA7023@bogus>
         <b1d669567b5f9f00dfb5d6dab89262f68c5523f1.camel@alliedtelesis.co.nz>
         <CAL_Jsq+UZvX-Avz7mA=RmhNU3hjKd2se1KODfGt9dfdbn_ACKQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+UZvX-Avz7mA=RmhNU3hjKd2se1KODfGt9dfdbn_ACKQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:25:ae22:bff:fe77:dd09]
Content-Type: text/plain; charset="utf-8"
Content-ID: <565BC1698FBA41449B65E6A86B2784B9@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTI5IGF0IDExOjI3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBKYW4gMjgsIDIwMjAgYXQgMTA6MzAgUE0gTG9nYW4gU2hhdw0KPiA8TG9nYW4uU2hh
d0BhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjAtMDEt
MjcgYXQgMDk6NDggLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBKYW4g
MjcsIDIwMjAgYXQgMTE6MTA6MTRBTSArMTMwMCwgTG9nYW4gU2hhdyB3cm90ZToNCj4gPiA+ID4g
QWRkZWQgYSBuZXcgZmlsZSBkb2N1bWVudGluZyB0aGUgYWR0NzQ3NSBkZXZpY2V0cmVlIGFuZCBh
ZGRlZA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZm91cg0KPiA+ID4gPiBuZXcgcHJvcGVydGllcyB0
byBpdC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIFNoYXcgPGxvZ2Fu
LnNoYXdAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICsgIGJ5cGFz
cy1hdHRlbnVhdG9yLWluMDoNCj4gPiA+IA0KPiA+ID4gTmVlZHMgYSB2ZW5kb3IgcHJlZml4IGFu
ZCBhIHR5cGUgcmVmLg0KPiA+IA0KPiA+IEFkaSAoQW5hbG9nIERldmljZXMpIHNvbGQgdGhlIEFE
VCBwcm9kdWN0IGxpbmUgKGFtb25nc3Qgb3RoZXINCj4gPiB0aGluZ3MpDQo+ID4gdG8gT24gU2Vt
aWNvbmR1Y3Rvci4gQXMgY2hhbmdpbmcgdGhlIHZlbmRvciBvZiB0aGVzZSBjaGlwcyAoaW4NCj4g
PiBjb2RlKQ0KPiA+IHdvdWxkIGJyZWFrIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHNob3VsZCB3
ZSBrZWVwIHRoZSB2ZW5kb3IgYXMNCj4gPiBhZGk/DQo+IA0KPiBZZXMuIEl0IHNob3VsZCBtYXRj
aCB3aGF0J3MgdXNlZCBpbiB0aGUgY29tcGF0aWJsZSBzdHJpbmcocykuDQo+IA0KPiA+IFRvIGNv
bmZpcm0sIHdvdWxkIHRoaXMgbWFrZSB0aGUgcHJvcGVydHkgImFkaSxhZHQ3NDc2LGJ5cGFzcy0N
Cj4gPiBhdHRlbnVhdG9yLWluMCI/DQo+ID4gDQo+ID4gU28gdXNlZCBpbiBjb25qdW5jdGlvbiB3
aXRoIHBhdHRlcm5Qcm9wZXJ0aWVzIHlvdSB3b3VsZCBlbmQgdXAgd2l0aA0KPiA+IHNvbWV0aGlu
ZyBsaWtlOg0KPiA+IA0KPiA+ICJhZGksKGFkdDc0NzN8YWR0NzQ3NXxhZHQ3NDc2fGFkdDc0OTAp
LGJ5cGFzcy1hdHRlbnVhdG9yLWluWzAxMzRdIg0KPiANCj4gTm8gZm9yIHRoZSBwYXJ0ICMncy4g
SnVzdCBhZGQgJ2FkaSwnLiBNYXliZSB5b3UgdGhvdWdodCBmb3IgdHlwZSByZWYNCj4gdGhhdCdz
IHdoYXQgSSBtZWFudD8gQSB0eXBlIHJlZiBpczoNCj4gDQo+ICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KDQpZZXMsIEkgd2FzIGEgbGl0dGxlIGNvbmZ1c2Vk
IGJ1dCBub3cgSSBhbSBvbiB0aGUgcmlnaHQgdHJhY2suDQo=
