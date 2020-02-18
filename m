Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56403C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A72176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vIwJHjF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBRUwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:52:49 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50971 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRUwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:52:47 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CB835886BF;
        Wed, 19 Feb 2020 09:52:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582059163;
        bh=4egHpKgT+4LXnwngLND9OvDY8VtHWdGYltij5t6j280=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=vIwJHjF0uJPbGB9yfs6nAYR96yACPVW5xHKUdJ9nWNDiaGsrXrHXO+7v12TvEDJv8
         H2DwV0ONI0DDIGOSU0TbQOUa4zIl+wjnMPZht6mPzYaNT8zo6Rt9f6eTQ10SGCzaXt
         2/YspLs7YXRk02d7JzYU0rcJcGBWsuDrmhembmfeGDYqN000KSdOYLq5VPIhwEgJ50
         Dlvgrf42MFtoKsTC094xtYU11q8rhnO2vJoi8jf7ODN2j/0xjYSfIHGzwUBdWWJYA5
         fppat3eLAJE01gfmfKNmyFKl/jI68fXVY+o80cPnXSDSyudMQtdGOixYR3HUF7OMLB
         qZOu0+aZEgZng==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4c4e9a0000>; Wed, 19 Feb 2020 09:52:42 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Feb 2020 09:52:38 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Wed, 19 Feb 2020 09:52:38 +1300
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
Thread-Index: AQHV5eyMFqQvqYyHpEKmw/ncMf3GS6ggjRyAgAAH0QA=
Date:   Tue, 18 Feb 2020 20:52:38 +0000
Message-ID: <5d081c13807da1b64060ed56460a47d459ac3e55.camel@alliedtelesis.co.nz>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
         <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
         <20200218202439.GA4617@bogus>
In-Reply-To: <20200218202439.GA4617@bogus>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:bdbc:9a4b:8324:c013]
Content-Type: text/plain; charset="utf-8"
Content-ID: <87DA75A0459E96489199DC59FE83B310@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTE4IGF0IDE0OjI0IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCAxOCBGZWIgMjAyMCAxMjo0Njo1NCArMTMwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToN
Cj4gPiANCj4gPiBGcm9tOiBMb2dhbiBTaGF3IDxsb2dhbi5zaGF3QGFsbGllZHRlbGVzaXMuY28u
bno+DQo+ID4gDQo+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHRoZSBieXBhc3MtYXR0ZW51YXRv
ci1pblswLTRdIHByb3BlcnR5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIFNoYXcg
PGxvZ2FuLnNoYXdAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gLS0tDQo+
ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0NzUueWFtbCAgICAgICAgICB8
IDEzICsrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykN
Cj4gPiANCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5n
X2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4LWR0
LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55
YW1sOiBwYXR0ZXJuUHJvcGVydGllczpeYnlwYXNzLWF0dGVudWF0b3ItaW5bMC00XSQ6bWF4aW11
bTogRmFsc2Ugc2NoZW1hIGRvZXMgbm90IGFsbG93IDENCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xp
bnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0
NzQ3NS55YW1sOiBwYXR0ZXJuUHJvcGVydGllczpeYnlwYXNzLWF0dGVudWF0b3ItaW5bMC00XSQ6
bWluaW11bTogRmFsc2Ugc2NoZW1hIGRvZXMgbm90IGFsbG93IDANCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL01ha2VmaWxlOjEyOiByZWNpcGUgZm9yIHRhcmdldCAnRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0NzUuZXhhbXBsZS5kdHMnIGZh
aWxlZA0KPiBtYWtlWzFdOiAqKiogW0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9o
d21vbi9hZHQ3NDc1LmV4YW1wbGUuZHRzXSBFcnJvciAxDQo+IE1ha2VmaWxlOjEyNjM6IHJlY2lw
ZSBmb3IgdGFyZ2V0ICdkdF9iaW5kaW5nX2NoZWNrJyBmYWlsZWQNCj4gbWFrZTogKioqIFtkdF9i
aW5kaW5nX2NoZWNrXSBFcnJvciAyDQo+IA0KDQpJIHN0aWxsIG11c3QgYmUgZG9pbmcgc29tZXRo
aW5nIHdyb25nLiBJIGRpZCBydW4gDQoNCiAgbWFrZSBtcnByb3Blcg0KICBtYWtlIEFSQ0g9YXJt
IGRlZmNvbmZpZw0KICBtYWtlIEFSQ0g9YXJtIGR0X2JpbmRpbmdfY2hlY2sgRFRfU0NIRU1BX0ZJ
TEVTPURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnlhbWwN
Cg0Kd2hpY2ggcGFzc2VzIHdpdGhvdXQgZXJyb3IuDQoNCldoZW4gSSBydW4gDQoNCiAgbWFrZSBt
cnByb3Blcg0KICBtYWtlIEFSQ0g9YXJtIGRlZmNvbmZpZw0KICBtYWtlIEFSQ0g9YXJtIGR0X2Jp
bmRpbmdfY2hlY2sNCg0KSSBnZXQgZXJyb3JzIGluIHVucmVsYXRlZCBmaWxlcw0KDQplLmcuDQoN
CiAgL2hvbWUvY2hyaXNwL3NyYy9saW51eC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY2xvY2svYWxsd2lubmVyLHN1bjRpLWExMC1hcGIxLWNsay55YW1sOiBBZGRpdGlvbmFsIHBy
b3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgnZGVwcmVjYXRlZCcgd2FzIHVuZXhwZWN0ZWQpDQog
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZToxMjogcmVjaXBlIGZv
ciB0YXJnZXQgJ0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hbGx3aW5u
ZXIsc3VuNGktYTEwLWFwYjEtY2xrLmV4YW1wbGUuZHRzJyBmYWlsZWQNCiAgbWFrZVsxXTogKioq
IFtEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYWxsd2lubmVyLHN1bjRp
LWExMC1hcGIxLWNsay5leGFtcGxlLmR0c10gRXJyb3IgMQ0KICBNYWtlZmlsZToxMjYyOiByZWNp
cGUgZm9yIHRhcmdldCAnZHRfYmluZGluZ19jaGVjaycgZmFpbGVkDQoNCk15IGxvY2FsIGJyYW5j
aCBpcyBiYXNlZCBvbiBjb21taXQgMGE2NzllMTNlYTMwICgiTWVyZ2UgYnJhbmNoICdmb3ItDQo1
LjYtZml4ZXMnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90ai9jZ3JvdXAiKQ0KZG8gSSBuZWVkIHRvIGJlIHJ1bm5pbmcgYWdhaW5zdCBzb21ldGhpbmcg
ZWxzZT8NCg0KPiBTZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMjM5Njk0
DQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0K
