Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5208722314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="ig2B4+wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:59:16 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:6208
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbgAUO7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:59:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahQUBf8rDaltCG6vWZZAA4s5J+2aG6mLz3uQz3tYy4dN9eUA/xrbSUnF8+8qAlystZVT6kLMRc4LRx2C9S6bkVtcHOKBdrNIlIHuydmQAkmlnio2nVKCDIXJpNIbxo+lqheFwE4rlK5e2+5IjDdttgJpzd2RE5B12/zekMjatcW1a81ygo26mT881tWQYaYgl+SD/c774A/IrHhnDXJuywQg1h0SsJh4ZjPcTWLeKDH3teOrriJbsWwfTGB1QyXlzL8AR2Wlk1ru/IkNXDAy64Gp0s34e3EBKnsFm8UfLq8ziK9M5nATQftioP84z5AK7t14LJZmqdiBnEQjqFmGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJk72w5um95NHsIL3MOUskAZaEZkA47EM2M2z5LJTss=;
 b=mfX1A5wcZcBuD5b+dBVouTOz/mdbKPEEsbFSSrWP8LNtOT6hkfWDEe6r0GTiBVCmJr7E4DTaFZ4hngQnnYDaomVfK0YrgnLpf9spQOLmzWb339eZEKdvCcck4ML4Oxv+COd0du3c2cxjgvAA4hmDVlFc0INGSS1J0+CjFon0m0kniw9ezoSBm9mgi/je8+exLfvxcfEr4sNmd3BjJsUHJjX9YLrXGsvDK8v4z7XyHH8rHm8hdOUk8gN4CYsUJGtL3wry3Pr1Wl01B6BDaKrXvxR4qQsdi61qken5DUEi/tw627MVzWK+WAHh1ZTh/A4MDAQ+vr0QE+KjJPaUwDTtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJk72w5um95NHsIL3MOUskAZaEZkA47EM2M2z5LJTss=;
 b=ig2B4+wN24Vq6/ZprXI6d37x6bI2G0BGjI3fmvjxk89hbR5JSEW0jarDAxx/CPRcZIoYgyiVJygweTuH6p+ADRzQnY6byGTOv4dlSE1QCnkbHh1Tk2a700ka7bphfjHqvTK6RF/ksKUhJUKMq+W4aplnUj/piIxcGw/OSyxFh3I=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (52.132.170.74) by
 MN2SPR01MB0045.namprd08.prod.outlook.com (20.179.223.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 14:59:12 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::61af:ed8:e19b:cb6a]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::61af:ed8:e19b:cb6a%3]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 14:59:12 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shivamurthy Shastri <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH 3/4] mtd: spinand: Add M70A series Micron SPI
 NAND devices
Thread-Topic: [EXT] Re: [PATCH 3/4] mtd: spinand: Add M70A series Micron SPI
 NAND devices
Thread-Index: AQHVz3qxhHT4F5gqHEqpiIf5nVR3gqfzXyrAgAHClgCAAAH50A==
Date:   Tue, 21 Jan 2020 14:59:11 +0000
Message-ID: <MN2PR08MB6397EE91C508B6DA2263F3D6B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
        <20200119145432.10405-4-sshivamurthy@micron.com>
        <20200120111626.7cb2f6c5@xps13>
        <MN2PR08MB6397062A37D39287E820A0D8B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
 <20200121144034.05a8f49d@xps13>
In-Reply-To: <20200121144034.05a8f49d@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTM1ZjVhYjAtM2M1ZS0xMWVhLWIxZTMtOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDkzNWY1YWIyLTNjNWUtMTFlYS1iMWUzLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iNTY4OSIgdD0iMTMyMjQwOTIzNDk1NTE1ODM2IiBoPSIwdGVUWGJ1aXVoUjM0a0lUMlZ1eHNFQnNvbWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.80.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38db92d3-5ec8-4b43-821b-08d79e8279b2
x-ms-traffictypediagnostic: MN2SPR01MB0045:|MN2SPR01MB0045:|MN2SPR01MB0045:
x-microsoft-antispam-prvs: <MN2SPR01MB0045D387487F13F2C3E768ABB80D0@MN2SPR01MB0045.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(189003)(52536014)(186003)(4326008)(6506007)(55236004)(7696005)(5660300002)(26005)(8936002)(81156014)(6916009)(2906002)(55016002)(81166006)(9686003)(8676002)(478600001)(316002)(71200400001)(33656002)(54906003)(86362001)(76116006)(66476007)(66446008)(64756008)(66556008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0045;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5gdPq5VeL43b9Mwm3A19+ylR/YWYIdeJWm4fwuE+fx+wTdve41NVT4wB1OrQA1F/FIkNB9uXv3STaWRh9eTW5aW3xYbZ4rYR7xsnJb4TkS5Z6KfCFG2+mZrU7QXLnIzyw7q9Z8Nhf1+xSl9Mgjp3ukMUjGgNdAtoOD4hPpA2RhL0Rg5WdW5Nt0T6igcIGFU6rCuQgf02lNje7pIHztbioqwrpkHSTg1PFsZcDamPFyz/QjGAAeF30L6g6KhdxAFDTWxAkUOXhXiGC2Y/bAJcUXOzxMylP434gBLm3Z5Mz8dQCIz5Wm3p1Oorvv9q6m0UMM+ahlg9eDZ7QKzRonsLFlbw091BUb0IseJ+QwJ5Z5n9dS4uCZ5PDW0huitL+AKe3LnDOk1GRDuEjnMAYsEEiUSd5ByGFQDzo0rgDwflwEIKtsT/Au0M1d/ck8+opCy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38db92d3-5ec8-4b43-821b-08d79e8279b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 14:59:11.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5M43Q0YYvtoVuJTmMUXRjoXQAhTh+aPXVe8N1EXgT2k30sp/pJTk84S4UtU8QUEKMLjNMa455HTP3zFEXO/4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IA0KPiBIaSBTaGl2YW11cnRoeSwNCj4gDQo+ICJTaGl2YW11cnRoeSBT
aGFzdHJpIChzc2hpdmFtdXJ0aHkpIiA8c3NoaXZhbXVydGh5QG1pY3Jvbi5jb20+IHdyb3RlDQo+
IG9uDQo+IFR1ZSwgMjEgSmFuIDIwMjAgMTI6MjM6MjAgKzAwMDA6DQo+IA0KPiA+IEhpIE1pcXVl
bCwNCj4gPg0KPiA+ID4NCj4gPiA+IEhpIFNoaXZhLA0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgcmVt
YXJrIGNvbW1vbiB0byB0aGUgZm91ciBwYXRjaGVzOiB5b3UgbWlzcyB0aGUgJ3YyJyBwcmVmaXgg
aW4NCj4gPiA+IHRoZSBvYmplY3QuDQo+ID4gPg0KPiA+DQo+ID4gU29ycnkgZm9yIHRoaXMgbWlz
dGFrZS4NCj4gPiBJIHJlY29nbml6ZWQgdGhpcyBhZnRlciBzZW5kaW5nIG91dCB0aGUgcGF0Y2hl
cy4NCj4gPg0KPiA+ID4gc2hpdmEubGludXh3b3Jrc0BnbWFpbC5jb20gd3JvdGUgb24gU3VuLCAx
OSBKYW4gMjAyMCAxNTo1NDozMSArMDEwMDoNCj4gPiA+DQo+ID4gPiA+IEZyb206IFNoaXZhbXVy
dGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBB
ZGQgZGV2aWNlIHRhYmxlIGZvciBNNzBBIHNlcmllcyBNaWNyb24gU1BJIE5BTkQgZGV2aWNlcy4N
Cj4gPiA+ID4NCj4gPiA+ID4gV2hpbGUgYXQgaXQsIGRpc2FibGUgdGhlIENvbnRpbnVvdXMgUmVh
ZCBmZWF0dXJlIHdoaWNoIGlzIGVuYWJsZWQgYnkNCj4gPiA+ID4gZGVmYXVsdC4NCj4gPiA+DQo+
ID4gPiBDYW4geW91IHBsZWFzZSBnaXZlIHVzIG1vcmUgZGV0YWlsIG9uIHdoeSB0aGlzIGlzIGFu
IGlzc3VlPw0KPiA+DQo+ID4gIkNvbnRpbnVvdXMgUmVhZCIgaXMgdGhlIG5ldyBmZWF0dXJlIGFk
ZGVkIGJ5IHRoZSBNaWNyb24gZm9yDQo+ID4gTTcwQSBzZXJpZXMgZGV2aWNlcy4gSWYgdGhpcyBm
ZWF0dXJlIGlzIGVuYWJsZWQsIHRoZSBSRUFEIGNvbW1hbmQNCj4gPiBkb2Vzbid0IG91dHB1dCB0
aGUgT09CIGFyZWEuIFRoZSBmb2xsb3dpbmcgc2hvcnQgZGVzY3JpcHRpb24NCj4gPiBkZXNjcmli
ZXMgdGhpcyBmZWF0dXJlLg0KPiA+DQo+ID4gRGVzY3JpcHRpb246DQo+ID4gSWYgdGhlIENvbnRp
bnVvdXMgUmVhZCBmZWF0dXJlIGlzIGVuYWJsZWQsIHRoZSBkZXZpY2UgcHJvdmlkZXMNCj4gPiB0
aGUgY2FwYWJpbGl0eSB0byByZWFkIHRoZSB3aG9sZSBibG9jayB3aXRoIGEgc2luZ2xlIGNvbW1h
bmQuDQo+ID4gSG93ZXZlciwgdGhlIHJlYWQgY29tbWFuZCBkb2Vzbid0IG91dHB1dCB0aGUgT09C
IGFyZWEuDQo+ID4NCj4gPiBSZWFkIGNvbW1hbmQgYmVoYXZpb3IgKGlmIENvbnRpbnVvdXMgUmVh
ZCBlbmFibGVkKToNCj4gPiBUaGUgUkVBRCBDQUNIRSBjb21tYW5kIGRvZXNuJ3QgcmVxdWlyZSB0
aGUgc3RhcnRpbmcgY29sdW1uIGFkZHJlc3MuDQo+ID4gVGhlIGRldmljZSBhbHdheXMgb3V0cHV0
IHRoZSBkYXRhIHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0IGNvbHVtbiBvZiB0aGUNCj4gPiBjYWNo
ZSByZWdpc3RlciwgYW5kIG9uY2UgdGhlIGVuZCBvZiB0aGUgY2FjaGUgcmVnaXN0ZXIgcmVhY2hl
ZCwgdGhlIGRhdGENCj4gPiBvdXRwdXQgY29udGludWVzIHRocm91Z2ggdGhlIG5leHQgcGFnZS4g
V2l0aCB0aGUgY29udGludW91cyByZWFkIG1vZGUsDQo+ID4gaXQgaXMgcG9zc2libGUgdG8gcmVh
ZCBvdXQgdGhlIGVudGlyZSBibG9jayB1c2luZyBhIHNpbmdsZSBSRUFEIGNvbW1hbmQsIGFuZA0K
PiA+IG9uY2UgdGhlIGVuZCBvZiB0aGUgYmxvY2sgcmVhY2hlZCwgdGhlIG91dHB1dCBwaW5zIGJl
Y29tZSBIaWdoLVogc3RhdGUuDQo+IA0KPiBPayBJIHVuZGVyc3RhbmQgYmV0dGVyLiBJbiB0aGlz
IGNhc2UgdGhlcmUgaXMgbm8gbmVlZCB0byBzcGxpdCB0aGlzDQo+IGNvbW1pdCwgaW5zdGVhZCBq
dXN0IHJld29yZCB0aGUgY29tbWl0IGxvZyB0byBzb21ldGhpbmcgbGlrZToNCj4gDQo+IC0tLT44
LS0tDQo+IEFkZCBkZXZpY2UgdGFibGUgZm9yIE03MEEgc2VyaWVzIE1pY3JvbiBTUEktTkFORCBk
ZXZpY2VzLg0KPiANCj4gQXMgb3Bwb3NlZCB0byB0aGUgTTYwQSBzZXJpZXMgYWxyZWFkeSBzdXBw
b3J0ZWQsIE03MEEgcGFydHMgaGF2ZSB0aGUNCj4gIkNvbnRpbnVvdXMgUmVhZCIgZmVhdHVyZSBl
bmFibGVkIGJ5IGRlZmF1bHQgd2hpY2ggZG9lcyBub3QgZml0IHRoZQ0KPiBzdWJzeXN0ZW0gbmVl
ZHMuDQo+IA0KPiA8aGVyZSBleHBsYWluIHRoZSBmZWF0dXJlPi4NCj4gDQo+IEhlbmNlLCB3ZSBk
aXNhYmxlIHRoZSBmZWF0dXJlIGF0IHByb2JlIHRpbWUuDQo+IC0tLTg8LS0tDQo+IA0KDQpTdXJl
LCBJIHdpbGwgY2hhbmdlIGFzIHBlciB5b3VyIHN1Z2dlc3Rpb24uDQoNCj4gSG93ZXZlciwgYmVs
b3csIHlvdSBkaXNhYmxlIHRoaXMgYml0IGZvciBhbGwgdGhlIHBhcnRzLiBJcyB0aGlzIHJlYWxs
eQ0KPiBvaz8gU291bGRuJ3Qgd2UgbWFrZSBpdCBtb3JlIHNwZWNpZmljIHRvIHRoaXMgc2VyaWVz
Pw0KDQpJdCBpcyBvayBiZWNhdXNlIHRoaXMgYml0IGlzIHVudXNlZCBpbiBvdGhlciBzZXJpZXMu
DQoNCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiBTaGFsbCB3ZSBiYWNrcG9ydCBpdCB0byBzdGFibGU/
DQo+ID4NCj4gPiBUaGlzIGlzIG5vdCBhIGJ1ZyBmaXggYW5kIGFwcGxpY2FibGUgb25seSB0byBN
NzBBIHNlcmllcyBkZXZpY2VzLCB0aGVyZSBpcyBubw0KPiA+IG5lZWQgdG8gYmFja3BvcnQuDQo+
ID4gKEZZSSwgdGhlIHByZXZpb3VzbHkgZW5hYmxlZCBkZXZpY2Ugd2FzIE03OUEgc2VyaWVzKQ0K
PiA+DQo+ID4gPg0KPiA+ID4gQXMgYSBydWxlIG9mIHRodW1iLCB3aGVuIHlvdSBzdGFydCBhIHNl
bnRlbmNlIGJ5ICJ3aGlsZSBhdCBpdCIgaW4gYQ0KPiA+ID4gY29tbWl0IG1lc3NhZ2UgYW5kIHRo
aXMgaXMgbm90IGEgdHJpdmlhbCBjaGFuZ2UgOiBzcGxpdCB0aGUgcGF0Y2gsDQo+ID4gPiBwbGVh
c2UuIFVubGVzcyB0aGlzIGlzIHJlYWxseSByZWxhdGVkIGFuZCBpbiB0aGlzIGNhc2UgZXhwbGFp
biBob3cgYW5kDQo+ID4gPiB3aHkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiA+DQo+ID4gT2th
eSwgSSB3aWxsIGV4cGxhaW4gaW4gbXkgbmV4dCB2ZXJzaW9uLg0KPiA+DQo+ID4gPg0KPiA+ID4g
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl2YW11cnRoeSBTaGFzdHJpIDxzc2hpdmFtdXJ0
aHlAbWljcm9uLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Nw
aS9taWNyb24uYyB8IDMxDQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9zcGkvbWljcm9uLmMNCj4gPiA+IGIvZHJp
dmVycy9tdGQvbmFuZC9zcGkvbWljcm9uLmMNCj4gPiA+ID4gaW5kZXggNWZkMWY5MjFlZjEyLi40
NWZjMzdjNThmOGEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL21p
Y3Jvbi5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL21pY3Jvbi5jDQo+ID4g
PiA+IEBAIC0xMzEsNiArMTMxLDI2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpbmFuZF9pbmZv
DQo+ID4gPiBtaWNyb25fc3BpbmFuZF90YWJsZVtdID0gew0KPiA+ID4gPiAgCQkgICAgIDAsDQo+
ID4gPiA+ICAJCSAgICAgU1BJTkFORF9FQ0NJTkZPKCZtaWNyb25fOF9vb2JsYXlvdXQsDQo+ID4g
PiA+ICAJCQkJICAgICBtaWNyb25fOF9lY2NfZ2V0X3N0YXR1cykpLA0KPiA+ID4gPiArCS8qIE03
MEEgNEdiIDMuM1YgKi8NCj4gPiA+ID4gKwlTUElOQU5EX0lORk8oIk1UMjlGNEcwMUFCQUZEIiwg
MHgzNCwNCj4gPiA+ID4gKwkJICAgICBOQU5EX01FTU9SRygxLCA0MDk2LCAyNTYsIDY0LCAyMDQ4
LCA0MCwgMSwgMSwgMSksDQo+ID4gPiA+ICsJCSAgICAgTkFORF9FQ0NSRVEoOCwgNTEyKSwNCj4g
PiA+ID4gKwkJICAgICBTUElOQU5EX0lORk9fT1BfVkFSSUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFu
dHMsDQo+ID4gPiA+ICsJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50cywNCj4gPiA+ID4g
KwkJCQkJICAgICAgJnVwZGF0ZV9jYWNoZV92YXJpYW50cyksDQo+ID4gPiA+ICsJCSAgICAgMCwN
Cj4gPiA+ID4gKwkJICAgICBTUElOQU5EX0VDQ0lORk8oJm1pY3Jvbl84X29vYmxheW91dCwNCj4g
PiA+ID4gKwkJCQkgICAgIG1pY3Jvbl84X2VjY19nZXRfc3RhdHVzKSksDQo+ID4gPiA+ICsJLyog
TTcwQSA0R2IgMS44ViAqLw0KPiA+ID4gPiArCVNQSU5BTkRfSU5GTygiTVQyOUY0RzAxQUJCRkQi
LCAweDM1LA0KPiA+ID4gPiArCQkgICAgIE5BTkRfTUVNT1JHKDEsIDQwOTYsIDI1NiwgNjQsIDIw
NDgsIDQwLCAxLCAxLCAxKSwNCj4gPiA+ID4gKwkJICAgICBOQU5EX0VDQ1JFUSg4LCA1MTIpLA0K
PiA+ID4gPiArCQkgICAgIFNQSU5BTkRfSU5GT19PUF9WQVJJQU5UUygmcmVhZF9jYWNoZV92YXJp
YW50cywNCj4gPiA+ID4gKwkJCQkJICAgICAgJndyaXRlX2NhY2hlX3ZhcmlhbnRzLA0KPiA+ID4g
PiArCQkJCQkgICAgICAmdXBkYXRlX2NhY2hlX3ZhcmlhbnRzKSwNCj4gPiA+ID4gKwkJICAgICAw
LA0KPiA+ID4gPiArCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmbWljcm9uXzhfb29ibGF5b3V0LA0K
PiA+ID4gPiArCQkJCSAgICAgbWljcm9uXzhfZWNjX2dldF9zdGF0dXMpKSwNCj4gPiA+ID4gIH07
DQo+ID4gPiA+DQo+ID4gPiA+ICBzdGF0aWMgaW50IG1pY3Jvbl9zcGluYW5kX2RldGVjdChzdHJ1
Y3Qgc3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQpDQo+ID4gPiA+IEBAIC0xNTMsOCArMTczLDE5IEBA
IHN0YXRpYyBpbnQgbWljcm9uX3NwaW5hbmRfZGV0ZWN0KHN0cnVjdA0KPiA+ID4gc3BpbmFuZF9k
ZXZpY2UgKnNwaW5hbmQpDQo+ID4gPiA+ICAJcmV0dXJuIDE7DQo+ID4gPiA+ICB9DQo+ID4gPiA+
DQo+ID4gPiA+ICtzdGF0aWMgaW50IG1pY3Jvbl9zcGluYW5kX2luaXQoc3RydWN0IHNwaW5hbmRf
ZGV2aWNlICpzcGluYW5kKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCS8qDQo+ID4gPiA+ICsJICog
TTcwQSBkZXZpY2Ugc2VyaWVzIGVuYWJsZSBDb250aW51b3VzIFJlYWQgZmVhdHVyZSBhdCBQb3dl
ci11cCwNCj4gPiA+ID4gKwkgKiB3aGljaCBpcyBub3Qgc3VwcG9ydGVkLiBEaXNhYmxlIHRoaXMg
Yml0IHRvIGF2b2lkIGFueSBwb3NzaWJsZQ0KPiA+ID4gPiArCSAqIGZhaWx1cmUuDQo+ID4gPiA+
ICsJICovDQo+ID4gPiA+ICsJcmV0dXJuIHNwaW5hbmRfdXBkX2NmZyhzcGluYW5kLCBDRkdfUVVB
RF9FTkFCTEUsIDApOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IHNwaW5hbmRfbWFudWZhY3R1cmVyX29wcw0KPiA+ID4gbWljcm9uX3NwaW5hbmRf
bWFudWZfb3BzID0gew0KPiA+ID4gPiAgCS5kZXRlY3QgPSBtaWNyb25fc3BpbmFuZF9kZXRlY3Qs
DQo+ID4gPiA+ICsJLmluaXQgPSBtaWNyb25fc3BpbmFuZF9pbml0LA0KPiA+ID4gPiAgfTsNCj4g
PiA+ID4NCj4gPiA+ID4gIGNvbnN0IHN0cnVjdCBzcGluYW5kX21hbnVmYWN0dXJlciBtaWNyb25f
c3BpbmFuZF9tYW51ZmFjdHVyZXIgPSB7DQo+ID4gPg0KDQpUaGFua3MsDQpTaGl2YQ0K
