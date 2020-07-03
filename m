Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008B420771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dxe6UlXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCFxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:53:30 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:24464
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725648AbgGCFx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwX3xSUBwLfIEezi+41sv1Q6emm6HWDDy4TGegGIY+q0EzW/UvC0TfUQqBFhg2AeugIBpcyR7SsoSYglAid2AimMpJ5fpr7S6pPe2QRZ5sRiLcjxClFvv31Jgna0VGwlpo+jcNt08L9bBmjrO/JB82k93iu1AJ62tzhrqOpotcOZ83tdZFKjd1BZhXcnXwMwknJTI12phy+j0SMflkrvyE1NAFmgpBWX2EBR0kHl1tReKdVI/kjzccVfTHXUIAqzD/mbrn9QqMEexBmHE1CEdGQ2QFbYx+d4X1EruMl4mcu5j5UWmg+B4vlIv3GThnJWJx9PSizp1W1qf8b1jlejqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqeDXinSZ1wfqNaAZJEmm3/2nDj2Y4bvkZX/yoUNFhc=;
 b=Uv8l794kGx8ltJnRN2PDbIellTMCBlrJsd1Oc35/ivqoB9BPEa2hEvQyk9H/QL20zejDJEs0xl7di64k6wTB1EqCaL+GV25C8Q2bfUbgWUvs4/GP4Gkjoj/F3j7ZJHhMLH3oxn4uM5SX1gLCAihG6SNUzj7so5iGLRJRV5+iUq2swUlttEcvrG/jXseTSAmbXKwcknxcETvwoaelcowYEw7zJOr0dl3KL9m6Ydv4qxwSmfp9b3O6KBktpQ6o8imBbtDQ4dQ9+ksAtwCJMz0RnC9DtAtl2BSsFQbq11rmewGu5ohQVAr1/F5UeitGyPN63ovq5+nyabQVG0zMpmM+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqeDXinSZ1wfqNaAZJEmm3/2nDj2Y4bvkZX/yoUNFhc=;
 b=Dxe6UlXFVA2PRPqFzm9CIuFtLoQch1NTk139O/m2xeQl3rhKy5tQV6wyPsOuZp38Kh5vzcOSpgNa93DhbQyKtmdncjnQP9nJE8dThaxv9h0ppbXzczK1BVSoiconbj2kF0989IoDWC7w0VTXCCOeFZ8+2MgJw63YFF+sQCcOaWA=
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN7PR13MB2321.namprd13.prod.outlook.com
 (2603:10b6:406:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.12; Fri, 3 Jul
 2020 05:53:23 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::481f:d0dc:9069:2c42]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::481f:d0dc:9069:2c42%3]) with mapi id 15.20.3153.027; Fri, 3 Jul 2020
 05:53:23 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Andreas Schwab <schwab@suse.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        "lollivier@baylibre.com" <lollivier@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
Thread-Topic: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
Thread-Index: AQHWQ9XZeaoAcUonuUqzTiy5jwwbX6jyoJC5gAAXQ4CAArwrkA==
Date:   Fri, 3 Jul 2020 05:53:23 +0000
Message-ID: <BN6PR1301MB2020C5FAA902AC521721319A8C6A0@BN6PR1301MB2020.namprd13.prod.outlook.com>
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
 <mvmftabiklh.fsf@suse.de>
 <CAEn-LTqMAf8vaaMhkX7h7+iY8U8v6JTSpW1FMj+JDr7PaWx1zw@mail.gmail.com>
In-Reply-To: <CAEn-LTqMAf8vaaMhkX7h7+iY8U8v6JTSpW1FMj+JDr7PaWx1zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=sifive.com;
x-originating-ip: [110.5.74.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dcdf353-2032-40eb-07d6-08d81f1565e6
x-ms-traffictypediagnostic: BN7PR13MB2321:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR13MB23215D369C23DC6FCBC595078C6A0@BN7PR13MB2321.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPK8FP6yXpOV9XXzo/aOU4dx93bG3jGIaC76kK7+jsoR3Q/IAHvIvWQlghpcpYdOFBzoySk8rf3tH0328mR1aNLhadXqfDTVJlsrqIzq4lke+HmHtYiojNSYUDfp1Gi3AVguCGsWhVFkMre7zaEftSH+3IincqtWLzuNMDotDQ6qHXW0j2PKOJfeczKkVytJippdYey/e56GK0oA7vA/ViRsxUlxm2YvsrjkMQYWMtoAt862yQXxO/ibWPqA0naVr2VCPsChGWsJz66zRra2e44J916QoKZHLL3uhOgAtQqrOJCdAtDsjPvZXVe2KEcoZVY9C71bb+mlEYBZ/o66feHfWahAIVLpHusrAlEaiP8lE+7B0rnbvvFASXCnweuvnhbvrriOHR+NIg75xjWSAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(376002)(396003)(366004)(39840400004)(346002)(136003)(26005)(186003)(55016002)(66946007)(66476007)(66556008)(66446008)(71200400001)(76116006)(64756008)(110136005)(54906003)(316002)(7696005)(6506007)(83380400001)(53546011)(4326008)(86362001)(33656002)(2906002)(5660300002)(966005)(478600001)(9686003)(8936002)(44832011)(8676002)(52536014)(7416002)(83080400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1dwJyGME8GXxRjoLfzp8g++hCu96yi2zpzlQDzh6Vh388BuvgMKQi1C0CVldRjtre6uZ0GWii4X7vpoXqTg2Lbgu0JXUZbdBBm6ibQ0cam7+5wH4QiP/694fqVam9xGqweV5c6uUJXCKoA6wYDKoiWYyBFAYuzvGFMoigTjFH/l3EZUODd7PYedUDNbdt59jDeoKOq1LQnH7+csmoNcQDjuFE6jwlhEXYhf5v5WPu4RXrRugnQBOizGQ74WU9OVPyhlg8/y1N39O/Qaiccdh+lYRVqyv5ZhediL6KmV7nBICEPVDuQCqLVayEsgJjtoU/7aUkhocIsVP3qbSx4MZvDs7jNa0byXL3cOcRn50p4eG4PMRz0K9yaeul3p3IkMaqe+kn8BfdwmQvVH7g/1isXRSHcnA6jY6c6zl7YvDenPPMi9KopFOiyfioeOsg+empb8/CrwntdCkPJO+moRuN56sdqbrPhqcFphUkYs85j0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcdf353-2032-40eb-07d6-08d81f1565e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:53:23.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqgS2msbNZ4y0Hze3Fi1vM+JcHlsYrzLq/zYMi9FdyNpZzR/VJvyMzYaYCvfCZxqJ81/SeKy6tnPXkVFi2Qtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR13MB2321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBBYmR1cmFjaG1hbm92
IDxkYXZpZC5hYmR1cmFjaG1hbm92QGdtYWlsLmNvbT4NCj4gU2VudDogMDEgSnVseSAyMDIwIDE3
OjM0DQo+IFRvOiBBbmRyZWFzIFNjaHdhYiA8c2Nod2FiQHN1c2UuZGU+DQo+IENjOiBZYXNoIFNo
YWggPHlhc2guc2hhaEBzaWZpdmUuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEFs
YmVydA0KPiBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1PjsgQXRpc2ggUGF0cmEgPGF0aXNoLnBh
dHJhQHdkYy5jb20+OyBBbnVwDQo+IFBhdGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPjsgbG9sbGl2
aWVyQGJheWxpYnJlLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgTGlzdCA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEdyZWVuIFdhbg0KPiA8Z3JlZW4ud2FuQHNp
Zml2ZS5jb20+OyBTYWNoaW4gR2hhZGkgPHNhY2hpbi5naGFkaUBzaWZpdmUuY29tPjsNCj4gcm9i
aCtkdEBrZXJuZWwub3JnOyBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPjsNCj4g
ZGVlcGEua2VybmVsQGdtYWlsLmNvbTsgUGF1bCBXYWxtc2xleSAoIFNpZml2ZSkNCj4gPHBhdWwu
d2FsbXNsZXlAc2lmaXZlLmNvbT47IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbT47DQo+IGxpbnV4LXJpc2N2IDxsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3Jn
PjsgQmluIE1lbmcNCj4gPGJtZW5nLmNuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAwLzNdIER5bmFtaWMgQ1BVIGZyZXF1ZW5jeSBzd2l0Y2hpbmcgZm9yIHRoZSBIaUZpdmUNCj4g
DQo+IFtFeHRlcm5hbCBFbWFpbF0gRG8gbm90IGNsaWNrIGxpbmtzIG9yIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgcmVjb2duaXplIHRoZQ0KPiBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPiANCj4gT24gV2VkLCBKdWwgMSwgMjAyMCBhdCAxOjQxIFBNIEFuZHJlYXMgU2Nod2Fi
IDxzY2h3YWJAc3VzZS5kZT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBKdW4gMTYgMjAyMCwgWWFzaCBT
aGFoIHdyb3RlOg0KPiA+DQo+ID4gPiBUaGUgcGF0Y2ggc2VyaWVzIGFkZHMgdGhlIHN1cHBvcnQg
Zm9yIGR5bmFtaWMgQ1BVIGZyZXF1ZW5jeQ0KPiA+ID4gc3dpdGNoaW5nIGZvciBGVTU0MC1DMDAw
IFNvQyBvbiB0aGUgSGlGaXZlIFVubGVhc2hlZCBib2FyZC4gQWxsIHRoZQ0KPiA+ID4gcGF0Y2hl
cyBhcmUgYmFzZWQgb24gUGF1bCBXYWxtc2xleSdzIHdvcmsuDQo+ID4gPg0KPiA+ID4gVGhpcyBz
ZXJpZXMgaXMgYmFzZWQgb24gTGludXggdjUuNyBhbmQgdGVzdGVkIG9uIEhpRml2ZSB1bmxlYXNo
ZWQgYm9hcmQuDQo+ID4NCj4gPiBJJ20gdXNpbmcgdGhhdCBwYXRjaCB3aXRoIDUuNy41Lg0KPiA+
DQo+ID4gSXQgYXBwZWFycyB0byBpbnRlcmZlciB3aXRoIHNlcmlhbCBvdXRwdXQgd2hlbiB1c2lu
ZyB0aGUgb25kZW1hbmQNCj4gPiBnb3Zlcm5vci4NCj4gDQo+IEkgZG8gcmVjYWxsIHRoYXQgdXNl
cnNwYWNlIGdvdmVybm9yIGlzIHRoZSBvbmx5IG9uZSBzdXBwb3J0ZWQgYnV0IHRoaXMgbWlnaHQN
Cj4gaGF2ZSBjaGFuZ2VkIGJlZm9yZSB0aGlzIHBhdGNoIHdhcyBwb3N0ZWQuDQo+IA0KPiBZYXNo
LCBkbyB5b3UgaGF2ZSBtb3JlIGRldGFpbHM/DQoNClllcywgeW91IGFyZSByaWdodC4gVGhlIHVz
ZXJzcGFjZSBnb3Zlcm5vciBpcyB0aGUgb25seSBvbmUgc3VwcG9ydGVkLg0KDQotIFlhc2gNCg0K
PiANCj4gPg0KPiA+IEkgYWxzbyBzZWUgc29mdCBsb2NrdXBzIHdoZW4gdXNpbmcgdGhlIHBlcmZv
cm1hbmNlIGdvdmVybm9yOg0KPiA+DQo+ID4gWyAgMTAxLjU4NzUyN10gcmN1OiBJTkZPOiByY3Vf
c2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUNCj4gPiBbICAxMDEuNTkyMzIyXSByY3U6
ICAgICAwLS4uLiE6ICg5MzIgdGlja3MgdGhpcyBHUCkNCj4gaWRsZT0xMWEvMS8weDQwMDAwMDAw
MDAwMDAwMDQgc29mdGlycT00MzAxLzQzMDEgZnFzPTQNCj4gPiBbICAxMDEuNjAxNDMyXSAgKHQ9
NjAwMSBqaWZmaWVzIGc9NDAxNyBxPTg1OSkgWyAgMTAxLjYwNTUxNF0gcmN1Og0KPiA+IHJjdV9z
Y2hlZCBrdGhyZWFkIHN0YXJ2ZWQgZm9yIDU5ODQgamlmZmllcyEgZzQwMTcgZjB4MA0KPiA+IFJD
VV9HUF9XQUlUX0ZRUyg1KSAtPnN0YXRlPTB4MCAtPmNwdT0yIFsgIDEwMS42MTU0OTRdIHJjdTog
UkNVIGdyYWNlLQ0KPiBwZXJpb2Qga3RocmVhZCBzdGFjayBkdW1wOg0KPiA+IFsgIDEwMS42MjA1
MzBdIHJjdV9zY2hlZCAgICAgICBSICBydW5uaW5nIHRhc2sgICAgICAgIDAgICAgMTAgICAgICAy
IDB4MDAwMDAwMDANCj4gPiBbICAxMDEuNjI3NTYwXSBDYWxsIFRyYWNlOg0KPiA+IFsgIDEwMS42
MzAwMDRdIFs8ZmZmZmZmZTAwMDg1YTdlMj5dIF9fc2NoZWR1bGUrMHgyNWMvMHg2MTYgWw0KPiA+
IDEwMS42MzUyMDVdIFs8ZmZmZmZmZTAwMDg1YWJkZT5dIHNjaGVkdWxlKzB4NDIvMHhiMiBbICAx
MDEuNjQwMDcwXQ0KPiA+IFs8ZmZmZmZmZTAwMDg1ZDBiYT5dIHNjaGVkdWxlX3RpbWVvdXQrMHg1
Ni8weGI4IFsgIDEwMS42NDU2MjZdDQo+ID4gWzxmZmZmZmZlMDAwMjYzYzM0Pl0gcmN1X2dwX2Zx
c19sb29wKzB4MjA4LzB4MjQ4IFsgIDEwMS42NTEyNjZdDQo+ID4gWzxmZmZmZmZlMDAwMjY2NmRl
Pl0gcmN1X2dwX2t0aHJlYWQrMHhjMi8weGNjIFsgIDEwMS42NTY2NTFdDQo+ID4gWzxmZmZmZmZl
MDAwMjI2NTRlPl0ga3RocmVhZCsweGRhLzB4ZWMgWyAgMTAxLjY2MTQyNl0NCj4gPiBbPGZmZmZm
ZmUwMDAyMDE0MGE+XSByZXRfZnJvbV9leGNlcHRpb24rMHgwLzB4YyBbICAxMDEuNjY2OTc3XSBU
YXNrDQo+ID4gZHVtcCBmb3IgQ1BVIDA6DQo+ID4gWyAgMTAxLjY3MDE4N10gbG9vcDAgICAgICAg
ICAgIFIgIHJ1bm5pbmcgdGFzayAgICAgICAgMCAgIDY1NSAgICAgIDIgMHgwMDAwMDAwOA0KPiA+
IFsgIDEwMS42NzcyMThdIENhbGwgVHJhY2U6DQo+ID4gWyAgMTAxLjY3OTY1N10gWzxmZmZmZmZl
MDAwMjAyOGFlPl0gd2Fsa19zdGFja2ZyYW1lKzB4MC8weGFhIFsNCj4gPiAxMDEuNjg1MDM2XSBb
PGZmZmZmZmUwMDAyMDJiNzY+XSBzaG93X3N0YWNrKzB4MmEvMHgzNCBbICAxMDEuNjkwMDc0XQ0K
PiA+IFs8ZmZmZmZmZTAwMDIzMTliMD5dIHNjaGVkX3Nob3dfdGFzay5wYXJ0LjArMHhjMi8weGQy
IFsgIDEwMS42OTYxNTRdDQo+ID4gWzxmZmZmZmZlMDAwMjJiYjljPl0gc2NoZWRfc2hvd190YXNr
KzB4NjQvMHg2NiBbICAxMDEuNzAxNjE4XQ0KPiA+IFs8ZmZmZmZmZTAwMDIzMWFmZT5dIGR1bXBf
Y3B1X3Rhc2srMHgzZS8weDQ4IFsgIDEwMS43MDY5MTZdDQo+ID4gWzxmZmZmZmZlMDAwMjY3NzYy
Pl0gcmN1X2R1bXBfY3B1X3N0YWNrcysweDk0LzB4Y2UgWyAgMTAxLjcxMjczMV0NCj4gPiBbPGZm
ZmZmZmUwMDAyNjMxZjY+XSBwcmludF9jcHVfc3RhbGwrMHgxMTYvMHgxOGEgWyAgMTAxLjcxODM3
NV0NCj4gPiBbPGZmZmZmZmUwMDAyNjRhNDY+XSBjaGVja19jcHVfc3RhbGwrMHhjYy8weDFhMiBb
ICAxMDEuNzIzOTI5XQ0KPiA+IFs8ZmZmZmZmZTAwMDI2NGI1Mj5dIHJjdV9wZW5kaW5nLmNvbnN0
cHJvcC4wKzB4MzYvMHhhYSBbICAxMDEuNzMwMDk0XQ0KPiA+IFs8ZmZmZmZmZTAwMDI2NmFiMj5d
IHJjdV9zY2hlZF9jbG9ja19pcnErMHhhNi8weGVhIFsgIDEwMS43MzU5MTNdDQo+ID4gWzxmZmZm
ZmZlMDAwMjZkMWJlPl0gdXBkYXRlX3Byb2Nlc3NfdGltZXMrMHgxZS8weDQyIFsgIDEwMS43NDE4
MjFdDQo+ID4gWzxmZmZmZmZlMDAwMjc5M2JjPl0gdGlja19zY2hlZF9oYW5kbGUrMHgyNi8weDUy
IFsgIDEwMS43NDc0NTZdDQo+ID4gWzxmZmZmZmZlMDAwMjc5OGZlPl0gdGlja19zY2hlZF90aW1l
cisweDZhLzB4ZDAgWyAgMTAxLjc1MzAxNV0NCj4gPiBbPGZmZmZmZmUwMDAyNmQ5YmU+XSBfX3J1
bl9ocnRpbWVyLmNvbnN0cHJvcC4wKzB4NTAvMHhlOA0KPiA+IFsgIDEwMS43NTkzNTNdIFs8ZmZm
ZmZmZTAwMDI2ZGE5ZT5dIF9faHJ0aW1lcl9ydW5fcXVldWVzKzB4NDgvMHg2YyBbDQo+ID4gMTAx
Ljc2NTI1NF0gWzxmZmZmZmZlMDAwMjZlNDEwPl0gaHJ0aW1lcl9pbnRlcnJ1cHQrMHhjYS8weDFk
NCBbDQo+ID4gMTAxLjc3MDk4NV0gWzxmZmZmZmZlMDAwNmNlZWY4Pl0gcmlzY3ZfdGltZXJfaW50
ZXJydXB0KzB4MzIvMHgzYSBbDQo+ID4gMTAxLjc3Njk3Nl0gWzxmZmZmZmZlMDAwODVlMTdjPl0g
ZG9fSVJRKzB4YTQvMHhiOCBbICAxMDEuNzgxNjYzXQ0KPiA+IFs8ZmZmZmZmZTAwMDIwMTQwYT5d
IHJldF9mcm9tX2V4Y2VwdGlvbisweDAvMHhjDQo+ID4NCj4gPiBBbmRyZWFzLg0KPiA+DQo+ID4g
LS0NCj4gPiBBbmRyZWFzIFNjaHdhYiwgU1VTRSBMYWJzLCBzY2h3YWJAc3VzZS5kZSBHUEcgS2V5
IGZpbmdlcnByaW50ID0gMDE5Ng0KPiA+IEJBRDggMUNFOSAxOTcwIEY0QkUgIDE3NDggRTRENCA4
OEUzIDBFRUEgQjlENyAiQW5kIG5vdyBmb3Igc29tZXRoaW5nDQo+ID4gY29tcGxldGVseSBkaWZm
ZXJlbnQuIg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1yaXNjdkBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1yaXNjdg0K
