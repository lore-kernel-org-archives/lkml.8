Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9EC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE620738
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="HgpKqJid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgCKRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:33:49 -0400
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:13594
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgCKRds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqgdoSPvPd6gDO7S1yw8ErmHh23MiGNtL8Mm7lcSOyEqAfSv7MH755pCqrsD+qUAP8EBlhKjzUVnp8At/RNJkEgiCtSqyUfDPsmQ/TuktQWZ6m2vW55pGrIfSpwBxmo2lGeVaeaqczvfAKNgo+sc2LZsLuLsa+EaLyanzJIXKLzqh97O48FAGeRuu/Dg+iUYcVAR1IhFjKbExM6mKJpGq7YLeDv5wElA4NJlkTe51LKrTIJPxzb8qzhCFKX+Cz2vURtythgmo6FTqRQVhDG/vU5MQBfh6USpNUKYj3NIMhTV3KLQmXnbRyc3DOBXq/mFeAPOVxH0cLxi6EjaYNbHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWhV3jmCXxDWPeTdzbQSVVspoCjPdH5Uq6CkBDOgp2I=;
 b=IDqI9uZpJ7K/EaIUIQaZ/USb1bMLC3z2eQ4uuN2egf92CChP44vXpXsAXhdKP1K1KO1db3fnlgfep3OrmBKMs/4TDIcphiWGS8xGTd8oixRYcusy87tIcatqfTBRkB8cVt56AamaCl9tOPyIa3c7QhEn6QYAgy+xwOy79OXHDAr3CYXcZzBLlaARU7ICX4cCQokmbRkOOvg3o1RjH8RUSUP9K0TtldJIMxt0CJ9V7HPm02euyMLwdcvFdIMNckD+Q066l6KSBIjoC4ZWJY5/xS2Bzgz9eeBvKX2mxAWlJovtWQ4QDsuQv8yEBpSxDwS6z5iCV735exj2rJocAnNhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWhV3jmCXxDWPeTdzbQSVVspoCjPdH5Uq6CkBDOgp2I=;
 b=HgpKqJidu2Y5W9A4SSYggtF8GPBLusJKaLkvEUm/BYcGIbjaGtRqgP0hgdd39fMNt1/Tq/ZdCDWyMv0m+xsL64geXxN+DzAnBOT89YeS8OxttuJ20VFhWS9dao4U0syp2Sb2rExscHzB19Bv+UTEJCItIrKzVlIk19x4Zz4XueY=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB5936.namprd08.prod.outlook.com (2603:10b6:208:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 11 Mar
 2020 17:33:41 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4%4]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 17:33:41 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH v6 0/6] Add new series Micron SPI NAND devices
Thread-Topic: [EXT] Re: [PATCH v6 0/6] Add new series Micron SPI NAND devices
Thread-Index: AQHV97yqdMFOd0WUj0Kd2FcGzJVvLKhDpJ6Q
Date:   Wed, 11 Mar 2020 17:33:41 +0000
Message-ID: <MN2PR08MB6397BAEC050EF2C1A9CE8CDAB8FC0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
 <20200311164932.23cc7a42@xps13>
In-Reply-To: <20200311164932.23cc7a42@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzE1YWU1ODctNjNiZS0xMWVhLWIxZWEtOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDcxNWFlNTg5LTYzYmUtMTFlYS1iMWVhLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iMjM0MSIgdD0iMTMyMjg0MjE2MTk1MDkyMTM1IiBoPSJOVHVwYk54WXdxbU5kaURRQ3ZIdkV5eFFMV009IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIQUFBQUNuRHJNenkvZlZBU3VBZ3YreE1QZGZLNENDLzdFdzkxOEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFCQUFBQUlTQjI1d0FBQUFBQUFBQUFBQUFBQUE9PSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.86.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc52d287-c8bf-445c-0c44-08d7c5e2576c
x-ms-traffictypediagnostic: MN2PR08MB5936:|MN2PR08MB5936:|MN2PR08MB5936:
x-microsoft-antispam-prvs: <MN2PR08MB5936EB61C70B962F6D849135B8FC0@MN2PR08MB5936.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(199004)(5660300002)(478600001)(966005)(2906002)(55236004)(7696005)(54906003)(81156014)(71200400001)(6506007)(8676002)(86362001)(81166006)(9686003)(110136005)(55016002)(4326008)(66446008)(64756008)(66556008)(66476007)(33656002)(316002)(66946007)(52536014)(26005)(76116006)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5936;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjykihFX52q5/+Ha6jc1Jo9JnTpH0SMm9xiJZoFBGFLtF80HAG6jaCL7jHoM3Iw/Gfk5jcr5sFhnpwPYVX37TdaBLXsZ1JxyhBqc+OL4hvOMefBal6VmoMrO8lPKMfQbuHMcLFrsYItRI7Wr437+XATF4FXuAbQdR6w9JP7yGo3UP6TnF/jPdHbH8xiCHOQNcABLew+Ncd8/ch6BnaZtFnYJuniAUbcU5CFILs8IpbS8vyxi2gDGVZLA78YrIwQ3GzMyZqo9v03wd6rKYd2NcNYJbKemYyXI7D6bgdAExYQ2DPuuKhZSUOjywDDmcdbXdv4gYzfhx/XOri2BeY/8n0fX8tG2T5VIqNBrKthgHSAig1MOR9vyvBNck0wGLqDK93KgViwdnpAR4BBNM6H+xlYSFPZ98xZv4Zr+Zbfpaiu8Qzjvx4rJ8GjCPwOqp+7X04b6ZHzDwVaMajSDNScmWeAXnT9PSkq4mVKDQlQPCGiCZvods8mOcu01+vXY/oFIQMigDEK3UDdsKBAxpzviHQ==
x-ms-exchange-antispam-messagedata: 2ZBuwFxcJEFwmmZyzSSOOKQvIfHhMD547fYrnXroDtdnIeJ/j9GIhOFgwXsCGO3D4r5kV4fMVFxyG4dPfvWvuDrS9ZhMr0GhPdPdJLxMolM4w5yz+Htvy0w+Z0LH6hZxkNVbvNXsyCWaWFle+oH2lA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc52d287-c8bf-445c-0c44-08d7c5e2576c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 17:33:41.5138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wS1E46hHTeYaRZz3O9+xUMD8ZcHGjoKZHoa5i2uMc7KdayuK07Y4w57pSIxtoxV6ap0zu8ydt5GXNSJ0teYf3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IA0KPiBIaSBTaGl2YSwNCj4gDQo+IHNoaXZhLmxpbnV4d29ya3NAZ21h
aWwuY29tIHdyb3RlIG9uIE1vbiwgIDkgTWFyIDIwMjAgMTI6NTI6MjQgKzAxMDA6DQo+IA0KPiA+
IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0KPiA+
DQo+ID4gVGhpcyBwYXRjaHNldCBpcyBmb3IgdGhlIG5ldyBzZXJpZXMgb2YgTWljcm9uIFNQSSBO
QU5EIGRldmljZXMsIGFuZCB0aGUNCj4gPiBmb2xsb3dpbmcgbGlua3MgYXJlIHRoZWlyIGRhdGFz
aGVldHMuDQo+ID4NCj4gPiBNNzhBOg0KPiA+IFsxXSBodHRwczovL3d3dy5taWNyb24uY29tL34v
bWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtDQo+IHNoZWV0L25hbmQtZmxhc2gvNzAtc2Vy
aWVzL203OGFfMWdiXzN2X25hbmRfc3BpLnBkZg0KPiA+IFsyXSBodHRwczovL3d3dy5taWNyb24u
Y29tL34vbWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtDQo+IHNoZWV0L25hbmQtZmxhc2gv
NzAtc2VyaWVzL203OGFfMWdiXzFfOHZfbmFuZF9zcGkucGRmDQo+ID4NCj4gPiBNNzlBOg0KPiA+
IFszXSBodHRwczovL3d3dy5taWNyb24uY29tL34vbWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2Rh
dGEtDQo+IHNoZWV0L25hbmQtZmxhc2gvNzAtc2VyaWVzL203OWFfMmdiXzFfOHZfbmFuZF9zcGku
cGRmDQo+ID4gWzRdIGh0dHBzOi8vd3d3Lm1pY3Jvbi5jb20vfi9tZWRpYS9kb2N1bWVudHMvcHJv
ZHVjdHMvZGF0YS0NCj4gc2hlZXQvbmFuZC1mbGFzaC83MC1zZXJpZXMvbTc5YV9kZHBfNGdiXzN2
X25hbmRfc3BpLnBkZg0KPiA+DQo+ID4gTTcwQToNCj4gPiBbNV0gaHR0cHM6Ly93d3cubWljcm9u
LmNvbS9+L21lZGlhL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLQ0KPiBzaGVldC9uYW5kLWZsYXNo
LzcwLXNlcmllcy9tNzBhXzRnYl8zdl9uYW5kX3NwaS5wZGYNCj4gPiBbNl0gaHR0cHM6Ly93d3cu
bWljcm9uLmNvbS9+L21lZGlhL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLQ0KPiBzaGVldC9uYW5k
LWZsYXNoLzcwLXNlcmllcy9tNzBhXzRnYl8xXzh2X25hbmRfc3BpLnBkZg0KPiA+IFs3XSBodHRw
czovL3d3dy5taWNyb24uY29tL34vbWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtDQo+IHNo
ZWV0L25hbmQtZmxhc2gvNzAtc2VyaWVzL203MGFfZGRwXzhnYl8zdl9uYW5kX3NwaS5wZGYNCj4g
PiBbOF0gaHR0cHM6Ly93d3cubWljcm9uLmNvbS9+L21lZGlhL2RvY3VtZW50cy9wcm9kdWN0cy9k
YXRhLQ0KPiBzaGVldC9uYW5kLWZsYXNoLzcwLXNlcmllcy9tNzBhX2RkcF84Z2JfMV84dl9uYW5k
X3NwaS5wZGYNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjU6DQo+ID4gLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPg0KPiA+IDEuIFJlYmFzZWQgc2VyaWVzIHRvIHY1LjYtcmMxLg0KPiANCj4gSSBhbSB2
ZXJ5IHNvcnJ5IGJ1dCBhY3R1YWxseSBJIGhhZCBpc3N1ZXMgYXBwbHlpbmcgYWxsIHlvdXIgcGF0
Y2hlcyBub3QNCj4gYmVjYXVzZSB0aGV5IHdlcmUgbm90IGJhc2VkIG9uIHY1LjYtcmMxLCBidXQg
YmVjYXVzZSBzaW5jZSB0aGVuIEkNCj4gYXBwbGllZCBhIHBhdGNoIGNoYW5naW5nIHRoZSBkZXRl
Y3Rpb24gdGhhdCBjaGFuZ2VkIHRoZSBjb250ZW50IG9mIGENCj4gbG90IG9mIHN0cnVjdHVyZXMg
KGluY2x1ZGluZyBpbiBNaWNyb24ncyBwYXRjaGVzKS4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIHJl
YmFzZSBhZ2FpbiBvbiB0b3Agb2YgdGhlIGN1cnJlbnQgbmFuZC9uZXh0PyBJIGFtIHZlcnkNCj4g
c29ycnkgZm9yIHRoaXMgZXh0cmEgd29yaywgdGhpcyBpcyBteSBtaXN0YWtlLg0KPiANCj4gSGVh
ZCBzaG91bGQgYmU6DQo+IA0KPiAJYTVkNTNhZDI2YThiICgibXRkOiByYXduYW5kOiBicmNtbmFu
ZDogQWRkIHN1cHBvcnQgZm9yIGZsYXNoLWVkdQ0KPiBmb3IgZG1hIHRyYW5zZmVycyIpDQo+IA0K
PiBBbmQgdGhlIGN1bHByaXQgY29tbWl0IGlzOg0KPiANCj4gCWYxNTQxNzczYWY0OSAoIm10ZDog
c3BpbmFuZDogcmV3b3JrIGRldGVjdCBwcm9jZWR1cmUgZm9yIGRpZmZlcmVudA0KPiBSRUFEX0lE
IG9wZXJhdGlvbiIpDQoNCg0KSSB3aWxsIHJlYmFzZSBhbmQgc2VuZCB0aGUgcGF0Y2hlcy4NCk1l
YW53aGlsZSwgdGhlcmUgd2lsbCBiZSBzbWFsbCBjb2RlIGNoYW5nZSBiZWNhdXNlIG9mIHRoZSBS
RUFEX0lEIHBhdGNoLg0KDQpEbyBJIG5lZWQgdG8gZHJvcCBSZXZpZXdlZC1ieSBmcm9tIEJvcmlz
Pw0KDQpUaGFua3MsDQpTaGl2YQ0K
