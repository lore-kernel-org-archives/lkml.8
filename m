Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A974C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="aF5ymyb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgGMLyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:54:01 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com ([40.107.8.131]:19854
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729594AbgGMLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdwWzLcDO+Oz9WhWtfUJ63HzlvwrzMhQgLRoQCCC80j5FHGrZPan5d3znjULt/+GWt5xM73EZDm1aZYB3Vx1/SYjppFLY4Xk1Fx/uMxzMVdcBJNDtOAqWqF2LsPkG4IgHmL6J85/CtGvuVc5Sa/abcoHWqyX1qJ9mC8FdFKiioxgMTMwbnOWNqSQvSNg7st2OfzEn/fJ9iJWlXU8Sjm0LZ+jGtLnfcuT64FRBDN/qNpwMUa/zRNXEXOFii+tiNKmicNLMvE+fgArCbc0whwk54aqy5nKY7lYKxb+f6eOgPV4Pz51wD4qG35nVI4DJuNbrAWZY78NFIu8JozIYWG74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdsE6j6dUjw3aV9Rc0azsl7B5uTW+zuUl6suh82K40A=;
 b=nUHRAVNcXeVemtOUjRminvZK+LKH4PYN4iOFyIEgGAxXP3WGvxv6d6DBj+L9wVD1HSV46Wcu49uivMR0iJmfl318zmIC3ysbHsX3toKVDQLGaG193W03qm2LzhbIYpj2OzGgAopnIxTBbGyJ9Nmyxu9yW13zfQw/I7Ff4i6i0HHJw7HyJ2F5F37s3nnk//EUijRUj1Gbi+ObwTcqy2vhQdHO6/nwYOuQQNK75ygsn6lWBSeqKKi10ANksBIWwupTpzGEovuDHISJege/TGuZ/E54MPr0sPvhQglfl7WcJBbivDva5kxYBdrLHd6VTX4wwWdGmGKxCbImrdJFPJUyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdsE6j6dUjw3aV9Rc0azsl7B5uTW+zuUl6suh82K40A=;
 b=aF5ymyb60iBxbTWwTu0Oumkh/Gd9AXk5rwnl5I+UtYTwzvdTQGq6zjVhVVWAwnD+EI398f7iSw2HmFM4B52Ka8OYeXtrUwAAR/5aLCE0WiZabcrQIvAeHLrLrsdPvPcEtgBPVYfLIS3npnhXdZaIYhDuhcDMrd7OCi+lK3MM7dg=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM7PR05MB7058.eurprd05.prod.outlook.com (2603:10a6:20b:1ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 11:53:56 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 11:53:56 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Topic: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Index: AQHWVr15sZvxLwnO3E+b+KcqajdLWakFR14AgAAjuQA=
Date:   Mon, 13 Jul 2020 11:53:56 +0000
Message-ID: <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
         <20200710132423.497230-3-philippe.schenker@toradex.com>
         <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
In-Reply-To: <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b14ada26-8e83-4170-d27e-08d827236c6c
x-ms-traffictypediagnostic: AM7PR05MB7058:
x-microsoft-antispam-prvs: <AM7PR05MB705850D253279F80E277989DF4600@AM7PR05MB7058.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ij+W7air9s/kEB2bArfX9ruaDuswsR35GLwV5RfPYjsXZmkK+L4f5TP3Vc+0gm4lCWlnEAp4NUgqk7Rx4eMO+tB63Licr71chFxcaR7OdLSFjzSEjiofAv42K+XgTJc0WsXMOoByxdTwX7PxS8hItfjdjI9Wv72694tRkFa+Y0YiVtEz0uf10CgycdrZC3IavQ7p+8x57cdXrrXxBWNfxO9vH0v32exhYfuD6woJhRG0F0EaYB8dpVjscDDsy1LAItpjbGoEtdUp0+u8eJgTWQAbvzkl9YavYlGHLjR4EIldB5etO/g5LO4MfhiVvlUHlL42rrU3cucLeG7YBHegJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(66446008)(4326008)(26005)(316002)(64756008)(6512007)(71200400001)(8676002)(8936002)(186003)(83380400001)(6486002)(86362001)(2616005)(44832011)(478600001)(110136005)(66556008)(66476007)(54906003)(66946007)(2906002)(6506007)(91956017)(76116006)(53546011)(7416002)(36756003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Mdzd/gmYKCYCzcxe6ig3G9lIZfBd68xSmlZUPhvfkCROo2QxmO2bPksZNkeMbpaPKJkfAjMwqUlrfldw6XFP1G+d2WItlytCjMKsb/fhJ8itpg7XCSyepxpaKBn+YQoJEqmIqCNlpq/q/zXf7IqL65/rKpSw+Re9SYs1eJq6UlNp4nnQHZpG9r5zO8Zzk79z5nBOchtur7xwcoX1vSnQZi9Ri8OaJgd0zAeYjwSUW/By7lnKz2FpIG7iRiVV3yn/NqXoTAmgVn6T8kWXneRSPz975LxY3ioHmp7dX6dr+j6nzbrzBYueOLQNFgEwsCWofcKK1ArJ0npuSYAeYMngHVq5IKGWZ0xA2bP7C4C4O2eqjMq9uGk7a0YNdE2qeqcqw5pbvzuPCpWdNk+6bqEC17us/tQtJ0dF/4pN4GxNnrd74OL3GW44kjIQXN2a37kK2sr2CSffzz/vPerkwDTEiqLGKys9CtJwLYraebUgcvQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8064FA273BFAA841AC63E113A8B17019@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14ada26-8e83-4170-d27e-08d827236c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 11:53:56.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Fp7GyqaXroRjWYG7iARvmKmMa98peHMkPdSYm0ArwUyhNc18lP+QlFus1GvyJcMdJhP7tWtixOf288d8baiGkUgtRlTRjIu1RqBZcrisFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB7058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTEzIGF0IDExOjQ2ICswMjAwLCBBaG1hZCBGYXRvdW0gd3JvdGU6DQo+
IEhlbGxvIFBoaWxpcHBlLA0KPiANCj4gT24gNy8xMC8yMCAzOjI0IFBNLCBQaGlsaXBwZSBTY2hl
bmtlciB3cm90ZToNCj4gPiBTaW5jZSB0aGUgcnVudGltZS1wbSB3YWtldXAgYnVnIHdhcyBmaXhl
ZCBpbg0KPiA+IGRyaXZlcnMvdXNiL2NoaXBpZGVhL2NvcmUuYyB1c2IgZHVhbC1yb2xlIGhvc3Qv
ZGV2aWNlIHN3aXRjaGluZyBpcw0KPiA+IHdvcmtpbmcuIFNvIG1ha2UgdXNlIG9mIGl0Lg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtl
ckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiAgYXJjaC9hcm0vYm9vdC9k
dHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDkgKysrKysrKysrDQo+ID4gIGFyY2gvYXJt
L2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpICAgICAgICAgfCA0ICsrLS0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+
ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gaW5k
ZXggOTc2MDEzNzVmMjY0Li5kYjU2YTUzMmEzNGEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gPiBAQCAtMjAsNiArMjAsMTQgQEAg
Y2xrMTZtOiBjbGsxNm0gew0KPiA+ICAJCWNsb2NrLWZyZXF1ZW5jeSA9IDwxNjAwMDAwMD47DQo+
ID4gIAl9Ow0KPiA+ICANCj4gPiArCWV4dGNvbl91c2JjX2RldDogdXNiY19kZXQgew0KPiA+ICsJ
CWNvbXBhdGlibGUgPSAibGludXgsZXh0Y29uLXVzYi1ncGlvIjsNCj4gDQo+IEFjY29yZGluZyB0
byA0NjAyZjNiZmYyNjYgKCJ1c2I6IGNvbW1vbjogYWRkIFVTQiBHUElPIGJhc2VkIGNvbm5lY3Rp
b24NCj4gZGV0ZWN0aW9uIGRyaXZlciIpOg0KPiAidGhlIG9sZCB3YXkgdXNpbmcgZXh0Y29uIHRv
IHN1cHBvcnQgVVNCIER1YWwtUm9sZSBzd2l0Y2ggaXMgbm93DQo+IGRlcHJlY2F0ZWQNCj4gIHdo
ZW4gdXNlIFR5cGUtQiBjb25uZWN0b3IuIg0KPiANCj4gSGF2ZSB5b3UgY29uc2lkZXJlZCB1c2lu
ZyBhIGNvbXBhdGlibGUgPSAiZ3Bpby11c2ItYi1jb25uZWN0b3IiIGNoaWxkDQo+IG5vZGUgaW5z
dGVhZD8NCj4gDQo+IENoZWVycywNCj4gQWhtYWQNCg0KVGhhbmtzIGZvciB0aGUgSGludCBBaG1h
ZCwNCg0KSSBhbHJlYWR5IHRyaWVkIGFuZCBqdXN0IG5vdyB0cmllZCBhZ2FpbiBidXQgaXQgZG9l
c24ndCB3b3JrIG9uIG91cg0KaGFyZHdhcmUuIEFyZSB5b3Ugc3VyZSB0aGlzIHdvcmtzIHdpdGgg
Y2hpcGlkZWEgZHJpdmVyPw0KDQpTaG91bGQgdGhpcyBuZXcgdXNiLWNvbm5lY3RvciBzdHVmZiB3
b3JrIGluIGdlbmVyYWwgd2l0aCBldmVyeSBvbGQNCmRyaXZlcj8NCg0KUGhpbGlwcGUNCg0KPiAN
Cj4gPiArCQlpZC1ncGlvID0gPCZncGlvNyAxNCBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiArCQlw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJCXBpbmN0cmwtMCA9IDwmcGluY3RybF91
c2JjX2RldD47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArDQo+ID4gIAlncGlvLWtleXMgew0KPiA+
ICAJCWNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4gPiAgCQlwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiA+IEBAIC0xNzQsNiArMTgyLDcgQEAgJnVhcnQzIHsNCj4gPiAgfTsNCj4gPiAg
DQo+ID4gICZ1c2JvdGcxIHsNCj4gPiArCWV4dGNvbiA9IDwwPiwgPCZleHRjb25fdXNiY19kZXQ+
Ow0KPiA+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ID4gaW5kZXggZTE4ZTg5ZGVjODc5Li5jYWVhOTBk
MjQyMWYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0
c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiA+IEBA
IC00NTcsNyArNDU3LDcgQEAgJnVhcnQzIHsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICZ1c2JvdGcx
IHsNCj4gPiAtCWRyX21vZGUgPSAiaG9zdCI7DQo+ID4gKwlkcl9tb2RlID0gIm90ZyI7DQo+ID4g
IH07DQo+ID4gIA0KPiA+ICAmdXNkaGMxIHsNCj4gPiBAQCAtNDg2LDcgKzQ4Niw3IEBAICZ1c2Ro
YzMgew0KPiA+ICAmaW9tdXhjIHsNCj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
ID4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZ3BpbzEgJnBpbmN0cmxfZ3BpbzIgJnBpbmN0cmxf
Z3BpbzMNCj4gPiAmcGluY3RybF9ncGlvNA0KPiA+IC0JCSAgICAgJnBpbmN0cmxfZ3BpbzcgJnBp
bmN0cmxfdXNiY19kZXQ+Ow0KPiA+ICsJCSAgICAgJnBpbmN0cmxfZ3Bpbzc+Ow0KPiA+ICANCj4g
PiAgCXBpbmN0cmxfZ3BpbzE6IGdwaW8xLWdycCB7DQo+ID4gIAkJZnNsLHBpbnMgPSA8DQo+ID4g
DQo=
