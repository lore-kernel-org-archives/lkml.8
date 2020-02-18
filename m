Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF3C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50B220718
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="h8nQi9ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBRAn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:43:28 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49006 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgBRAn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:43:28 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42A63886BF;
        Tue, 18 Feb 2020 13:43:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581986605;
        bh=zSqmj9z4syWa1mZi2IDxwOGDgTVddHMN91zqYwl7yOQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=h8nQi9epoQFB0RyqKb4mqHHOwruSRRrPCrcWL7bVfwNRXA07Z7sv/f561kUXbDM8g
         XPdpP4Da5JqlGYaPRF95s2a7hRjD5uyfLB9jeKTu1oBBpL6YyBrc9W0qpo0a6rZt8d
         nxdeV0wEzaAyfkOUydv7c8R4lcXILWG7fcNAVmpNlrHmwO+/73V7+4XuIIlS2TVqMs
         CMetOjW+p5jWjBEOM2bPWnD1ARcHnegHUeUcQOqP+Z7JShrRdt/xufzUmktWe+gmg8
         v5wbcN0oMQTkXp3uadBcxBZ0wY22fkq81R3g9VKUrVPh2IgtRDaaYR+UKNhA+Vja1U
         A5ncB3FCLFT7w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b332c0000>; Tue, 18 Feb 2020 13:43:24 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb 2020 13:43:23 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 18 Feb 2020 13:43:23 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/5] hwmon: (adt7475) attenuator bypass and pwm invert
Thread-Topic: [PATCH 0/5] hwmon: (adt7475) attenuator bypass and pwm invert
Thread-Index: AQHV5eyMmRsbp5UKV0O/MB4CTfzg6qgfQBSAgAAC/AA=
Date:   Tue, 18 Feb 2020 00:43:22 +0000
Message-ID: <a131f52c0270067e7e3ab97ac44d1fb6a65ecbb0.camel@alliedtelesis.co.nz>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
         <bb029a57-e7d2-c35c-f2e2-276e2373787b@roeck-us.net>
In-Reply-To: <bb029a57-e7d2-c35c-f2e2-276e2373787b@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:cd0e:b78d:99a2:dcbf]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D02190703D2D024FAF624A50F6ABFFA1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTE3IGF0IDE2OjMyIC0wODAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiAyLzE3LzIwIDM6NDYgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+ID4gSSd2ZSBwaWNr
ZWQgdXAgTG9nYW4ncyBjaGFuZ2VzWzFdIGFuZCBhbSBjb21iaW5pbmcgdGhlbSB3aXRoIGFuIG9s
ZCBzZXJpZXMgb2YNCj4gPiBtaW5lWzJdIHRvIGhvcGVmdWxseSBnZXQgdGhlbSBib3RoIG92ZXIg
dGhlIGxpbmUuDQo+ID4gDQo+IA0KPiBObyBjaGFuZ2UgbG9nIGFuZC9vciBoaXN0b3J5LCBzbyBJ
IGd1ZXNzIHlvdXIgZXhwZWN0YXRpb24gaXMgdGhhdCBpdCB3aWxsIGJlIHVwDQo+IHRvIG1lIHRv
IGZpZ3VyZSBvdXQgd2hhdCBtYXkgaGF2ZSBjaGFuZ2VkIGFuZCBpZiBwcmV2aW91cyBjb21tZW50
cyBoYXZlIGJlZW4NCj4gYWRkcmVzc2VkIG9yIG5vdC4NCj4gDQo+IEd1ZW50ZXINCg0KWWVhaCBz
b3JyeSBhYm91dCB0aGF0LiBJIGdvdCBhcyBmYXIgYXMgImlzIHRoaXMgdjMgb2YgTG9nYW4ncyBz
ZXJpZXMgb3INCnYxIG9mIGEgbmV3IHNlcmllcyIgYW5kIGp1bXBlZCB0aGUgZ3VuLg0KDQpDaGFu
Z2VzIHNpbmNlIExvZ2FuJ3Mgc2VyaWVzLg0KLSBNb3ZlIGV4aXN0aW5nIGR0LWJpbmRpbmcgaW4g
cGF0Y2ggMS81Lg0KLSBOZXcgZHQtYmluZGluZ3MgaW4gcGF0Y2ggMi81IGFuZCAzLzUNCi0gUGF0
Y2ggNC81Og0KLS0gbW92ZSBjb25maWcyIHRvIHN0cnVjdCBhZHQ3NDc1X2RhdGENCi0tIHNldF9w
cm9wZXJ0eV9iaXQoKSBuZXcgaGVscGVyIGZ1bmN0aW9uIHRvIHNldC9jbGVhciBiaXQgYmFzZWQg
b24gZHQNCnByb3BlcnR5IHZhbHVlLg0KLS0gcmVuYW1lIHRvIHVzZSBsb2FkX2F0dGVudWF0b3Jz
KCkNCi0gUGF0Y2ggNS81IHJld29yayBvbGRlciBwYXRjaCBvbiB0b3Agb2YgdGhpcyBzZXJpZXMu
DQoNCj4gDQo+ID4gVGhpcyBzZXJpZXMgdXBkYXRlcyB0aGUgYmluZGluZyBkb2N1bWVudGF0aW9u
IGZvciB0aGUgYWR0NzQ3NSBhbmQgYWRkcyB0d28gbmV3DQo+ID4gc2V0cyBvZiBwcm9wZXJ0aWVz
Lg0KPiA+IA0KPiA+IFsxXSAtIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWh3bW9uLzIw
MTkxMjE5MDMzMjEzLjMwMzY0LTEtbG9nYW4uc2hhd0BhbGxpZWR0ZWxlc2lzLmNvLm56Lw0KPiA+
IFsyXSAtIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWh3bW9uLzIwMTgxMTA3MDQwMDEw
LjI3NDM2LTEtY2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Lw0KPiA+IA0KPiA+IENo
cmlzIFBhY2toYW0gKDIpOg0KPiA+ICAgIGR0LWJpbmRpbmdzOiBod21vbjogRG9jdW1lbnQgYWR0
NzQ3NSBpbnZlcnQtcHdtIHByb3BlcnR5DQo+ID4gICAgaHdtb246IChhZHQ3NDc1KSBBZGQgc3Vw
cG9ydCBmb3IgaW52ZXJ0aW5nIHB3bSBvdXRwdXQNCj4gPiANCj4gPiBMb2dhbiBTaGF3ICgzKToN
Cj4gPiAgICBkdC1iaW5kaW5nczogaHdtb246IERvY3VtZW50IGFkdDc0NzUgYmluZGluZw0KPiA+
ICAgIGR0LWJpbmRpbmdzOiBod21vbjogRG9jdW1lbnQgYWR0NzQ3NSBieXBhc3MtYXR0ZW51YXRv
ciBwcm9wZXJ0eQ0KPiA+ICAgIGh3bW9uOiAoYWR0NzQ3NSkgQWRkIGF0dGVudWF0b3IgYnlwYXNz
IHN1cHBvcnQNCj4gPiANCj4gPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0
NzUueWFtbCAgICB8ICA4MiArKysrKysrKysrKysrKw0KPiA+ICAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwgIHwgICA4IC0tDQo+ID4gICBkcml2ZXJzL2h3bW9u
L2FkdDc0NzUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxMDAgKysrKysrKysrKysrKysrKyst
DQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDE3OSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+ID4gDQo+IA0KPiANCg==
