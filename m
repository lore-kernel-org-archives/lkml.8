Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EE5C3404E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBD924655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fu58/or8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBRXYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:24:11 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51434 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgBRXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:24:11 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C7A8D886BF;
        Wed, 19 Feb 2020 12:24:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582068247;
        bh=6t+e/RsRgfdAcDmlsU3QxJ2+V7OGhdSiiYQ3RKAgTrU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=fu58/or8zFopa5G2lRK5pnNUMXagVElGNLXNjFJm2qCuYqlF/Mc1JP07naK2BOnri
         Opv/r93DN3AC2kLQX9G5OBEZl4jDCmRLs4YPtFrgJWGN4BfLVNjEtercDBfY6M4jRC
         rR7MQ5hm2XlKRoHSobuyDkFsnhFMqb1q9mQj8eJkCA0RpGelJ5ZLhBF6QycTKa3U2W
         Mq7NYR7K2icmF59xb+GcBZSN14u5VXfwVanxRZh2v7RcIY0wfAGo1sMb+YI71drM0l
         ztREwU2jPJZe1Ciuo8GgAXQKcdTVt/qIR0EzrMjDuKSJqnnhAw3uVDwPQVzlnPEnjz
         THY6eXYNwo2KA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4c72160001>; Wed, 19 Feb 2020 12:24:06 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Feb 2020 12:24:07 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Wed, 19 Feb 2020 12:24:07 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: Document adt7475
 bypass-attenuator property
Thread-Topic: [PATCH 2/5] dt-bindings: hwmon: Document adt7475
 bypass-attenuator property
Thread-Index: AQHV5eyMFqQvqYyHpEKmw/ncMf3GS6ggjRyAgAAH0QCAACpSAA==
Date:   Tue, 18 Feb 2020 23:24:07 +0000
Message-ID: <c933b9341a90717fa87e3b862fcfa89799accfca.camel@alliedtelesis.co.nz>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
         <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
         <20200218202439.GA4617@bogus>
         <5d081c13807da1b64060ed56460a47d459ac3e55.camel@alliedtelesis.co.nz>
In-Reply-To: <5d081c13807da1b64060ed56460a47d459ac3e55.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:bdbc:9a4b:8324:c013]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D8687BE1AAA14B9C8003E1918339B8@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTE5IGF0IDA5OjUyICsxMzAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0K
PiBPbiBUdWUsIDIwMjAtMDItMTggYXQgMTQ6MjQgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiA+IE9uIFR1ZSwgMTggRmViIDIwMjAgMTI6NDY6NTQgKzEzMDAsIENocmlzIFBhY2toYW0gd3Jv
dGU6DQo+ID4gPiANCj4gPiA+IEZyb206IExvZ2FuIFNoYXcgPGxvZ2FuLnNoYXdAYWxsaWVkdGVs
ZXNpcy5jby5uej4NCj4gPiA+IA0KPiA+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHRoZSBieXBh
c3MtYXR0ZW51YXRvci1pblswLTRdIHByb3BlcnR5Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBMb2dhbiBTaGF3IDxsb2dhbi5zaGF3QGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMu
Y28ubno+DQo+ID4gPiAtLS0NCj4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9h
ZHQ3NDc1LnlhbWwgICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+IA0KPiA+IE15IGJvdCBmb3VuZCBl
cnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiA+
IA0KPiA+IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0NzUueWFtbDogcGF0dGVyblByb3BlcnRpZXM6
XmJ5cGFzcy1hdHRlbnVhdG9yLWluWzAtNF0kOm1heGltdW06IEZhbHNlIHNjaGVtYSBkb2VzIG5v
dCBhbGxvdyAxDQo+ID4gL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4LWR0LXJldmlldy9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sOiBwYXR0ZXJuUHJv
cGVydGllczpeYnlwYXNzLWF0dGVudWF0b3ItaW5bMC00XSQ6bWluaW11bTogRmFsc2Ugc2NoZW1h
IGRvZXMgbm90IGFsbG93IDANCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
TWFrZWZpbGU6MTI6IHJlY2lwZSBmb3IgdGFyZ2V0ICdEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaHdtb24vYWR0NzQ3NS5leGFtcGxlLmR0cycgZmFpbGVkDQo+ID4gbWFrZVsxXTog
KioqIFtEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS5leGFt
cGxlLmR0c10gRXJyb3IgMQ0KPiA+IE1ha2VmaWxlOjEyNjM6IHJlY2lwZSBmb3IgdGFyZ2V0ICdk
dF9iaW5kaW5nX2NoZWNrJyBmYWlsZWQNCj4gPiBtYWtlOiAqKiogW2R0X2JpbmRpbmdfY2hlY2td
IEVycm9yIDINCj4gPiANCj4gDQo+IEkgc3RpbGwgbXVzdCBiZSBkb2luZyBzb21ldGhpbmcgd3Jv
bmcuIEkgZGlkIHJ1biANCj4gDQo+ICAgbWFrZSBtcnByb3Blcg0KPiAgIG1ha2UgQVJDSD1hcm0g
ZGVmY29uZmlnDQo+ICAgbWFrZSBBUkNIPWFybSBkdF9iaW5kaW5nX2NoZWNrIERUX1NDSEVNQV9G
SUxFUz1Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1s
DQo+IA0KPiB3aGljaCBwYXNzZXMgd2l0aG91dCBlcnJvci4NCj4gDQo+IFdoZW4gSSBydW4gDQo+
IA0KPiAgIG1ha2UgbXJwcm9wZXINCj4gICBtYWtlIEFSQ0g9YXJtIGRlZmNvbmZpZw0KPiAgIG1h
a2UgQVJDSD1hcm0gZHRfYmluZGluZ19jaGVjaw0KPiANCj4gSSBnZXQgZXJyb3JzIGluIHVucmVs
YXRlZCBmaWxlcw0KPiANCj4gZS5nLg0KPiANCj4gICAvaG9tZS9jaHJpc3Avc3JjL2xpbnV4L0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hbGx3aW5uZXIsc3VuNGktYTEw
LWFwYjEtY2xrLnlhbWw6IEFkZGl0aW9uYWwgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdk
ZXByZWNhdGVkJyB3YXMgdW5leHBlY3RlZCkNCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvTWFrZWZpbGU6MTI6IHJlY2lwZSBmb3IgdGFyZ2V0ICdEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svYWxsd2lubmVyLHN1bjRpLWExMC1hcGIxLWNsay5leGFt
cGxlLmR0cycgZmFpbGVkDQo+ICAgbWFrZVsxXTogKioqIFtEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY2xvY2svYWxsd2lubmVyLHN1bjRpLWExMC1hcGIxLWNsay5leGFtcGxlLmR0
c10gRXJyb3IgMQ0KPiAgIE1ha2VmaWxlOjEyNjI6IHJlY2lwZSBmb3IgdGFyZ2V0ICdkdF9iaW5k
aW5nX2NoZWNrJyBmYWlsZWQNCj4gDQo+IE15IGxvY2FsIGJyYW5jaCBpcyBiYXNlZCBvbiBjb21t
aXQgMGE2NzllMTNlYTMwICgiTWVyZ2UgYnJhbmNoICdmb3ItDQo+IDUuNi1maXhlcycgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RqL2Nncm91cCIpDQo+
IGRvIEkgbmVlZCB0byBiZSBydW5uaW5nIGFnYWluc3Qgc29tZXRoaW5nIGVsc2U/DQo+IA0KDQpB
aCBJIHRoaW5rIEkndmUgZ290IGl0DQoNCnBpcDMgaW5zdGFsbCAtLXVzZXIgZ2l0K2h0dHBzOi8v
Z2l0aHViLmNvbS9kZXZpY2V0cmVlLW9yZy9kdC1zY2hlbWEuZ2l0QG1hc3Rlcg0KDQpMZXQncyBt
ZSBzZWUgdGhlIGVycm9ycy4gTm93IEkganVzdCBuZWVkIHRvIHVuZGVyc3RhbmQgdGhlbSA6KS4N
Cg0KPiA+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEyMzk2OTQNCj4g
PiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdC4NCg==
