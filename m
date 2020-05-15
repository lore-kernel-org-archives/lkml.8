Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6202065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTD6lx20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgEOF3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:29:13 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:58179
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbgEOF3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4dyKgC+6JqYFLlXspUM4wGZsJVadLnP8fZoou0nbWF1npDxUTwJVL7lAQ3naLjcTzb1bq7+IQLlspAbqrcFUVH+9HiEhP4bQx0n2Ha8RItJ0FjDmoHbt/fGBM2U+EoTx5W22LiYK9ibdTcWcS7woIIQt0OU07hsqa5zcWuCantbEHkydI0SUDXddtViE/jkIIft3XYO5recZqPHDjA9QT6YThxCmrHAiPywFxsRGWbQMDV3kCU9pQjQy7wriLxqINfshcoRsA4J1iWAl/hr/NFn392CoFiGegYpA0qrPCpSWeHcSyk0avb8WEXi05YO6CXLNMr8tZpbj52TEt10ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW/ykwJ834hcVV3D2xnVW2lQuVc37be+HEV7Rm9hNwU=;
 b=gzO0dq3f8KeQd9KA1qfxYJwmEN1WY5Kq2MNIsaRVFBimds9/fMEJOOzxxW9BWMSHSSNvUZU8dJvnRD+t6YN5hcWMeksN2HB0+W9VI6GALhAf2RrvlJ2EmLeDpUYz3SerZMez/W1K6bX1aiE8G4hL9h3vmC19zqFbegeWmMd1rAww6guvpy9XzpvQWPpjrVtBSaLrB04Q18jLZeFbXsRT0ACL/1Xd8uhcM1jEFz5d/Yd4hhYiPVRF7H98V3Ej0F7lYdTCQ+G3rmqmQaSdIj9cG6/Hvr73aZ7MVv7vCJdRJQxS5zvdCwbdNIvaWZYDnuj+zVnqcrIRgiHr+DOaB41ekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW/ykwJ834hcVV3D2xnVW2lQuVc37be+HEV7Rm9hNwU=;
 b=FTD6lx20b69mRRY922dKrsBVb1RwA5VfjTSOTPAT590AG5qAZQ7v5oSBf30bgCjcmG1ovvaE+UySPMOfuH15u9P5EwMiw9LvoPMr5f8fYYvJ900rtEr+VBWyMgpScgllj/vc+L2Avfn2BV+eYl2yjoY/ygvkadONAj/ImQ+b1As=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16)
 by VI1PR04MB5215.eurprd04.prod.outlook.com (2603:10a6:803:59::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Fri, 15 May
 2020 05:29:07 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::fd09:b822:f838:ea61]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::fd09:b822:f838:ea61%8]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 05:29:07 +0000
From:   Poonam Aggrwal <poonam.aggrwal@nxp.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Suram Suram <suram@nxp.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: RE: [PATCH v7 0/6] Add new series Micron SPI NAND devices
Thread-Topic: [PATCH v7 0/6] Add new series Micron SPI NAND devices
Thread-Index: AQHV987J3lW3A1K/zUS/GagqkfFVKqipA06AgAAAeQA=
Date:   Fri, 15 May 2020 05:29:07 +0000
Message-ID: <VI1PR04MB70232F2A753142DE7E0D3A6986BD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
 <CA+G9fYuavikY4yjc+bjnvDGHGwQRs6bf31gUa3gyFzd=0zLR7Q@mail.gmail.com>
In-Reply-To: <CA+G9fYuavikY4yjc+bjnvDGHGwQRs6bf31gUa3gyFzd=0zLR7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [182.64.26.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5afd596c-34c7-49c7-ee65-08d7f890e377
x-ms-traffictypediagnostic: VI1PR04MB5215:|VI1PR04MB5215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52153DCEE063DA765AD6C9A886BD0@VI1PR04MB5215.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GqOECZvk9PzgTXKzYlG4py8RRSGxcFaD3X8EBnpRno5GNvhXcBaUbNg4Sop7SkpO4WqYtMAfH7lOyYJAJknFFVNFq04IN2ab2g35QnxsVrouesRjq3lCBBzrT+zNxJ7z/bjgcwztQ8p1HRDagquIbfsbT0E2uwqNRtQfzazKxjvD8QC5XaK/EiC+4fywX+N0TgO6VVLvZYGeIi9dXa+pp5GGaVfX/9yg0PaiULFYz6Z1948jxKLYSBUiGSab6IswZla2ycRggUMNdE2GyfrRrtLOX9JbUDTyDcKizQVerqAlIxznJYhuLyEQeFveu/WIdZkm8UcowhXK4yop5bEK858VxkUPmC7R9AYhqa//7zqOmzplZrgIpBQDnquMOOFqGkUU7gXDpVy27la8SSZZCuQeGh2IhzCaQDKZve0F/QiFdTFpBi3HEBJ/DR9fa9k2wl2YAhybvTxKYeRjgBwu1TAH8ixIJ5S69m6qQ/piUNK2UJpGAbiN7Mgo6bFN/ddF6l98sMAOASE/Y1hS5X5ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7023.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(6506007)(52536014)(966005)(44832011)(86362001)(7416002)(83080400001)(4326008)(54906003)(33656002)(478600001)(7696005)(5660300002)(71200400001)(76116006)(6636002)(110136005)(186003)(53546011)(55016002)(8936002)(2906002)(66946007)(9686003)(66476007)(316002)(66446008)(64756008)(45080400002)(26005)(8676002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: khx2VJOeGIyQA2Mj8W+lhsh2ICOJuWDTElF4pDcnl3QYhgciXI65SCVpxVlyl2Sm35Ls4E0C1V8pVjnmrQ1fRo6sT9n38sBwdGICnAthWW12JGavm8tyPBCcgpf4lLO5HHPHbwuyVYDRXMckrIcTAt9WNFTabqkJ6sDYVsm19HmUlysIueqoX/r5an38BKTSgUYxoTKb5KRJTQvcpMiB5hxgsdM0HmBFrSG7Bs1LZGYQbjPSdHUQekpb1Ow1lbMzvPOvjITaid1YpouAl18gPOKbTQh/0AxRn9jxweN8J1/sg69DdLMyiFzFpzMzzr41l499lXetyW57RnVoqDFO0OuKnoYPllWemeJvT8IBz2tQIC7S/Xet4pkg4os3qXdVnurVdcs6ACNgA6FM3Bg1coKOMXlgSeR+aMkMPhJd+3VDrXsheiTxUWs4kBCaThP4URJlbpK5iYvAee9ygl4qYWlaLqZm8/CQx6ElE34ttWg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afd596c-34c7-49c7-ee65-08d7f890e377
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 05:29:07.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVOo/15LBwcT/DTxcDkWcVqewdkN3JWFekBPGY1WzDasIxCFse4Ic3kpe69SIpRKAeKeKBT+BsC8tRcUkDenmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIEFzaGlzaC4NCg0KUmVnYXJkcw0KUG9vbmFtDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTmFyZXNoIEthbWJvanUgPG5hcmVzaC5rYW1ib2p1QGxpbmFyby5v
cmc+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDE1LCAyMDIwIDEwOjU3IEFNDQo+IFRvOiBzaGl2YS5s
aW51eHdvcmtzQGdtYWlsLmNvbTsgTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGlu
LmNvbT47DQo+IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0K
PiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47IFZpZ25lc2ggUmFnaGF2
ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGNvbGxhYm9yYS5jb20+Ow0KPiBDaHVhbmhvbmcgR3VvIDxnY2g5ODEyMTNAZ21haWwuY29t
PjsgRnJpZWRlciBTY2hyZW1wZg0KPiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPjsgbGlu
dXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IG9wZW4gbGlzdCA8bGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+OyBQb29uYW0gQWdncndhbCA8cG9vbmFtLmFnZ3J3YWxAbnhwLmNvbT47
DQo+IFN1cmFtIFN1cmFtIDxzdXJhbUBueHAuY29tPjsgbGtmdC10cmlhZ2VAbGlzdHMubGluYXJv
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDAvNl0gQWRkIG5ldyBzZXJpZXMgTWljcm9u
IFNQSSBOQU5EIGRldmljZXMNCj4gDQo+IE9uIFdlZCwgMTEgTWFyIDIwMjAgYXQgMjM6MjgsIDxz
aGl2YS5saW51eHdvcmtzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBTaGl2YW11
cnRoeSBTaGFzdHJpIDxzc2hpdmFtdXJ0aHlAbWljcm9uLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2hzZXQgaXMgZm9yIHRoZSBuZXcgc2VyaWVzIG9mIE1pY3JvbiBTUEkgTkFORCBkZXZpY2VzLCBh
bmQNCj4gPiB0aGUgZm9sbG93aW5nIGxpbmtzIGFyZSB0aGVpciBkYXRhc2hlZXRzLg0KPiANCj4g
V2hpbGUgYm9vdCBOWFAgbHMyMDg4IGRldmljZSB3aXRoIG1haW5saW5lIGtlcm5lbCB0aGUgZm9s
bG93aW5nIG5hbmQgd2FybmluZw0KPiBub3RpY2VkLiBIb3cgY3JpdGljYWwgdGhpcyB3YXJuaW5n
ID8NCj4gDQo+IFsgICAgMS4zNTc3MjJdIG5hbmQ6IGRldmljZSBmb3VuZCwgTWFudWZhY3R1cmVy
IElEOiAweDJjLCBDaGlwIElEOiAweDQ4DQo+IFsgICAgMS4zNjQwODVdIG5hbmQ6IE1pY3JvbiBN
VDI5RjE2RzA4QUJBQ0FXUA0KPiBbICAgIDEuMzY4MTgxXSBuYW5kOiAyMDQ4IE1pQiwgU0xDLCBl
cmFzZSBzaXplOiA1MTIgS2lCLCBwYWdlIHNpemU6DQo+IDQwOTYsIE9PQiBzaXplOiAyMjQNCj4g
WyAgICAxLjM3NTkzMl0gbmFuZDogV0FSTklORzogNTMwMDAwMDAwLmZsYXNoOiB0aGUgRUNDIHVz
ZWQgb24geW91cg0KPiBzeXN0ZW0gaXMgdG9vIHdlYWsgY29tcGFyZWQgdG8gdGhlIG9uZSByZXF1
aXJlZCBieSB0aGUgTkFORCBjaGlwDQo+IA0KPiBbICAgIDEuMzg4NzY3XSBCYWQgYmxvY2sgdGFi
bGUgZm91bmQgYXQgcGFnZSA1MjQxNjAsIHZlcnNpb24gMHgwMQ0KPiBbICAgIDEuMzk2ODMzXSBC
YWQgYmxvY2sgdGFibGUgZm91bmQgYXQgcGFnZSA1MjQwMzIsIHZlcnNpb24gMHgwMQ0KPiBbICAg
IDEuNDAzNzgxXSBuYW5kX3JlYWRfYmJ0OiBiYWQgYmxvY2sgYXQgMHgwMDAwMDJkMDAwMDANCj4g
WyAgICAxLjQwODkyMV0gbmFuZF9yZWFkX2JidDogYmFkIGJsb2NrIGF0IDB4MDAwMDAyZDgwMDAw
DQo+IFsgICAgMS40MTQ3NTBdIGZzbCxpZmMtbmFuZCA1MzAwMDAwMDAubmFuZDogSUZDIE5BTkQg
ZGV2aWNlIGF0DQo+IDB4NTMwMDAwMDAwLCBiYW5rIDINCj4gDQo+IA0KPiBGdWxsIHRlc3QgbG9n
LA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZxYS0NCj4gcmVwb3J0cy5saW5hcm8ub3JnJTJGbGtmdCUyRmxpbnV4LW1h
aW5saW5lLW9lJTJGYnVpbGQlMkZ2NS43LXJjNS01NS0NCj4gZzFhZTdlZmIzODg1NCUyRnRlc3Ry
dW4lMkYxODI1NCUyRmxvZyZhbXA7ZGF0YT0wMiU3QzAxJTdDcG9vbmFtLg0KPiBhZ2dyd2FsJTQw
bnhwLmNvbSU3QzE0NmY2MzRjODY5ZjRjNzBiYWExMDhkN2Y4OTA5ZmZiJTdDNjg2ZWExZDNiYzIN
Cj4gYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyNTExNzIzNTQ2MzgyOTgmYW1w
O3NkYXRhPSUyQg0KPiBKaHMlMkZiOTIlMkJBNTZXellkSGUlMkJCaFhXZmprOGZlQ0dBRnYlMkJS
ekZLQzlQTSUzRCZhbXA7cmVzZQ0KPiBydmVkPTANCj4gDQo+IC0gTmFyZXNoDQo=
