Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70785C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8FE20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="s7LY4Ffx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEOJ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:59:15 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:6038
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbgEOJ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsVXkb4YDuZ2iSYF0PkT8FK4PMixIVuKjmlahZMrKZTk4jgw0ZmkQ6xdepj5Ahr0+nLDmilA9aXzjsMORKJExptL9csVkWH3F73ypBY/r1sFf10jgJB9j7WOzKw0unFXFjJmtH7xUx+i6SweLSomWqx0iHPQT9VD5cHoNxTr8ucEp/IpsIcmgpWnx2SsQVNE5zZNL1InfaU51yLBsQQCZDud6j8+RLqimQ8swS+ftTFsvs3SRNNzzOnUFpNcZezaPTwnJACwIzj6d+wjYEsyxnsYT1sNi4WrNOwMkPoVSOMc+oIcDNJVeHyinsuKHv+x+gH3P74E9zG0TTRSSge5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrD/4LTASHEk8e7zWZ8WifeCAtecqAtM5HFTAqbk3Pk=;
 b=Z/mZz8m6TLBzqwNnP6ptg9eEBV11bdX0K1z8duxVtZIFPdesB7MNx9PEHJhz1HFOVL+67mBgUF3CM7aDsZ3G4NwQmdffGIgJIa/QWmzLg8MPdnjh0uw7pRuxsD4Q3UA43XDeK5+RKVgWWdFzTM94co1EqI/vVtbwN9JWGSnEqgDgTfVEvbWOot0QiyyNS5P6JSRZeUXOML7QCB5dpheFMZPEKDsI6SQy2Y+Wwpl85z3Jb5BDYkyrb/hWoVZJHtN18BaE5TBsB7CyHOR7OoksuAsh41x/Fwjbnm1OOSwN/KMZCO7RgsWJplo3bWuWEM2DIJTNNQbgiANpRHzRVa6FBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrD/4LTASHEk8e7zWZ8WifeCAtecqAtM5HFTAqbk3Pk=;
 b=s7LY4FfxnpImB55DOiqp0l4bdkep9e3e5USghiQCa4azHKuzDb5Eil2vHAeB5XMIGe2P/9PRrt3Syu7GX+TEvNlnQNNpB/HnhuZltex7/ejw/LpPeBHaXH7bvIpfJcmM9kqKFIW7vKCaAasq00W2ed+oOifVFKEanZizLR6nmIM=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB5853.namprd08.prod.outlook.com (2603:10b6:208:11c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 09:59:08 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::986c:ed7d:5eed:def9]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::986c:ed7d:5eed:def9%7]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 09:59:07 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Poonam Aggrwal <poonam.aggrwal@nxp.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Suram Suram <suram@nxp.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: RE: [EXT] Re: [PATCH v7 0/6] Add new series Micron SPI NAND devices
Thread-Topic: [EXT] Re: [PATCH v7 0/6] Add new series Micron SPI NAND devices
Thread-Index: AQHWKnl/b82m9mbS6EeR28LlwMzm7Kiono6AgAAiwQCAACAKUA==
Date:   Fri, 15 May 2020 09:59:07 +0000
Message-ID: <MN2PR08MB63973E068B6EF744AEE43246B8BD0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
        <CA+G9fYuavikY4yjc+bjnvDGHGwQRs6bf31gUa3gyFzd=0zLR7Q@mail.gmail.com>
        <VI1PR04MB70232F2A753142DE7E0D3A6986BD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20200515093330.7e3b2911@xps13>
In-Reply-To: <20200515093330.7e3b2911@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjViM2UwODUtOTY5Mi0xMWVhLWIxZWMtOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XGI1YjNlMDg3LTk2OTItMTFlYS1iMWVjLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iMzYzNCIgdD0iMTMyMzQwMTAzNDU2MjQ3NTc2IiBoPSJ0cWZLZ1YxSXJ4OHFZc1E4bEt6WDVLYzR3R1E9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIQUFBQUFZVHd4NG55cldBV09PVkhZNnJEeWJZNDVVZGpxc1BKc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFCQUFBQTl2bFBrZ0FBQUFBQUFBQUFBQUFBQUE9PSIvPjwvbWV0YT4=
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [165.225.81.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21ba42cd-ec45-4090-4aa2-08d7f8b69be6
x-ms-traffictypediagnostic: MN2PR08MB5853:
x-microsoft-antispam-prvs: <MN2PR08MB5853A9EEFF91A24384A83B91B8BD0@MN2PR08MB5853.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWm3ioO/6QPAPm9WeaSy9DOSOxaWd3IlGbQQiFgHDJu7Fhh4Gp3zZiMglrJwKflgHd8Gk3WgXzV4fwuAhH0VOhWgxwwV1LQHPWkX8mGHPt5HwdWblB+e/hUbYucgBElJICdn22wOYs+N6JzN9wFkHgKHh6sm9YimjCnk+gf+g1zyKZvSfysCPi4ZLYEkY1f2884WryiWM+JH33ydPH5n2ZOZfOj5VFsR74w3mxSH1bS8li9XHrcxws3G+ccGtKCjFS/nQUkfxJ+pjs4zAABqdA6kK+0lhWvPmrBgW8zU/i13TPPogwHlRkHw/6YDZJrBQ5T2kL5xZgiRReDf4CUyzoIZdTdx9QV307MxVuiv/+pm+UIZ8ho4+gJQuoxQhYSR6fHodOIfsaOlnaC+rlhdXQ2STBkjK+ae+QPTEaaj3GBME/ytovMjcCCrBWp25ocoTog34du+5mFsr8SQKxHhWY9GQ21FmMmpMdNz+FkJv8cuuETuEUPNTR7SSYmzjLF4+VSP1sycv4NeqBNDbgyKYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR08MB6397.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(86362001)(8936002)(4326008)(83080400001)(7696005)(110136005)(8676002)(5660300002)(54906003)(66574014)(76116006)(71200400001)(186003)(66476007)(53546011)(316002)(55236004)(66556008)(66946007)(478600001)(6506007)(52536014)(26005)(45080400002)(966005)(64756008)(66446008)(7416002)(9686003)(33656002)(55016002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SvMDh+zMHZrC7qlbqZ3RzCLMkeeNGmVcbBHzcTal2e6FlVjzlDqJJx0iZsp+HJuCghsE+YuE1hvOtrK0PhX30fG40rAF372Vr91XXQwCq39V/CkKlwknaQYTvHY6WETNspW+h4MGN1H0XKUqwC4AIiHD5FjqwZQ4ueGU/3cs+IC28bR8SU6zOctYC3XoDS2YNm/NLJI8Q3zG/NFd4KfOQ3oz/9r9dMYxvL0TM+4hNCiL0FxRcHyMI0ZYUETKXKvujltyOkPW5/OMkQrvn+LeyytUSH+AWtjmTHwsr1uetx8vjCkG7Oz/tszVCj0Sa/U3S2J/wbUvsO86xTWcunl9FtLvimSQK5QwG4YhrFKwTwIwBQhQVaq35PxiHSvEIneW/nuQ0GiPx5tFJD0eS2xIIcQzx5fB8JB+I7jaJ8PGsAtaGNbsMfqDI7MuoZffkRA3XWbeFCjoU7zmUmfuZBbn4iSCvoIbkzT813hBfpoH3YE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ba42cd-ec45-4090-4aa2-08d7f8b69be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 09:59:07.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp2juuvviZCZswHjxeSHJG9xykOVRk66IG9Zgph+nQ5vbVctuJcF3iS/a8CauOrMNklqJhW9+y4uU0bgnl6GUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmFyZXNoIGFuZCBQb29uYW0sDQoNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NyAw
LzZdIEFkZCBuZXcgc2VyaWVzIE1pY3JvbiBTUEkgTkFORCBkZXZpY2VzDQo+IA0KPiBIaSBQb29u
YW0sDQo+IA0KPiBQb29uYW0gQWdncndhbCA8cG9vbmFtLmFnZ3J3YWxAbnhwLmNvbT4gd3JvdGUg
b24gRnJpLCAxNSBNYXkgMjAyMA0KPiAwNToyOTowNyArMDAwMDoNCj4gDQo+ID4gQWRkaW5nIEFz
aGlzaC4NCj4gPg0KPiA+IFJlZ2FyZHMNCj4gPiBQb29uYW0NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE5hcmVzaCBLYW1ib2p1IDxuYXJlc2gua2Ft
Ym9qdUBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogRnJpZGF5LCBNYXkgMTUsIDIwMjAgMTA6NTcg
QU0NCj4gPiA+IFRvOiBzaGl2YS5saW51eHdvcmtzQGdtYWlsLmNvbTsgTWlxdWVsIFJheW5hbA0K
PiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47DQo+ID4gPiBTaGl2YW11cnRoeSBTaGFzdHJp
IDxzc2hpdmFtdXJ0aHlAbWljcm9uLmNvbT4NCj4gPiA+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIg
PHJpY2hhcmRAbm9kLmF0PjsgVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiA+ID4gPHZpZ25lc2hyQHRp
LmNvbT47IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+Ow0K
PiA+ID4gQ2h1YW5ob25nIEd1byA8Z2NoOTgxMjEzQGdtYWlsLmNvbT47IEZyaWVkZXIgU2NocmVt
cGYNCj4gPiA+IDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+OyBsaW51eC1tdGRAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgb3Blbg0KPiBsaXN0IDxsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBQb29uYW0gQWdncndhbA0KPiA8cG9vbmFtLmFnZ3J3YWxAbnhwLmNvbT47DQo+
ID4gPiBTdXJhbSBTdXJhbSA8c3VyYW1AbnhwLmNvbT47IGxrZnQtdHJpYWdlQGxpc3RzLmxpbmFy
by5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMC82XSBBZGQgbmV3IHNlcmllcyBN
aWNyb24gU1BJIE5BTkQgZGV2aWNlcw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMTEgTWFyIDIwMjAg
YXQgMjM6MjgsIDxzaGl2YS5saW51eHdvcmtzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29t
Pg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoc2V0IGlzIGZvciB0aGUgbmV3IHNlcmllcyBv
ZiBNaWNyb24gU1BJIE5BTkQgZGV2aWNlcywgYW5kDQo+ID4gPiA+IHRoZSBmb2xsb3dpbmcgbGlu
a3MgYXJlIHRoZWlyIGRhdGFzaGVldHMuDQo+ID4gPg0KPiA+ID4gV2hpbGUgYm9vdCBOWFAgbHMy
MDg4IGRldmljZSB3aXRoIG1haW5saW5lIGtlcm5lbCB0aGUgZm9sbG93aW5nIG5hbmQNCj4gd2Fy
bmluZw0KPiA+ID4gbm90aWNlZC4gSG93IGNyaXRpY2FsIHRoaXMgd2FybmluZyA/DQo+IA0KPiBB
cmUgeW91IHN1cmUgdGhpcyBpcyB0aGUgcmlnaHQgdGhyZWFkPyBTaGl2YW11cnRoeSBhZGRlZCBT
UEktTkFORA0KPiBzdXBwb3J0LCB5b3UgYXJlIHRhbGtpbmcgYWJvdXQgYSByYXcgTkFORCBkZXZp
Y2UuDQo+ID4gPg0KPiA+ID4gWyAgICAxLjM1NzcyMl0gbmFuZDogZGV2aWNlIGZvdW5kLCBNYW51
ZmFjdHVyZXIgSUQ6IDB4MmMsIENoaXAgSUQ6IDB4NDgNCj4gPiA+IFsgICAgMS4zNjQwODVdIG5h
bmQ6IE1pY3JvbiBNVDI5RjE2RzA4QUJBQ0FXUA0KPiA+ID4gWyAgICAxLjM2ODE4MV0gbmFuZDog
MjA0OCBNaUIsIFNMQywgZXJhc2Ugc2l6ZTogNTEyIEtpQiwgcGFnZSBzaXplOg0KPiA+ID4gNDA5
NiwgT09CIHNpemU6IDIyNA0KPiA+ID4gWyAgICAxLjM3NTkzMl0gbmFuZDogV0FSTklORzogNTMw
MDAwMDAwLmZsYXNoOiB0aGUgRUNDIHVzZWQgb24geW91cg0KPiA+ID4gc3lzdGVtIGlzIHRvbyB3
ZWFrIGNvbXBhcmVkIHRvIHRoZSBvbmUgcmVxdWlyZWQgYnkgdGhlIE5BTkQgY2hpcA0KPiANCj4g
SWYgeW91IGFyZSB0YWxraW5nIGFib3V0IHRoaXMgb25lLCBpdCBpcyBwcmV0dHkgc2VsZiBleHBs
YW5hdG9yeTogdGhlDQo+IE5BTkQgY2hpcCByZXF1aXJlcyBhIG1pbmltdW0gY29ycmVjdGlvbiB3
aGljaCBpcyBub3QgYWNoaWV2ZWQgaGVyZS4NCj4gRWl0aGVyIGJlY2F1c2UgdGhlIEVDQyBlbmdp
bmUgY2Fubm90IHJlYWNoIHRoZSByZXF1ZXN0ZWQgYW1vdW50ICh5b3UNCj4gY2Fubm90IGRvIGFu
eXRoaW5nKSBvciBiZWNhdXNlIHlvdSByZXF1ZXN0ZWQgYSB0b28gbG93IGNvcnJlY3Rpb24gd2l0
aA0KPiBEVCBwcm9wZXJ0aWVzLg0KPiANCg0KTWluaW11bSByZXF1aXJlZCBFQ0MgZm9yIHRoaXMg
ZGV2aWNlIGlzIDgtYml0LiBCZWxvdyBpcyB0aGUgZGF0YXNoZWV0IGZvciB5b3VyIHJlZmVyZW5j
ZS4NCg0KaHR0cHM6Ly93d3cubWljcm9uLmNvbS8tL21lZGlhL2NsaWVudC9nbG9iYWwvZG9jdW1l
bnRzL3Byb2R1Y3RzL2RhdGEtc2hlZXQvbmFuZC1mbGFzaC83MC1zZXJpZXMvbTcyYV9wcm9kdWN0
aW9uX2RhdGFzaGVldF9yZXZnLnBkZj9yZXY9YmIwYTRiYTA0YTFmNDBmOThlMjlkYzYyNGQxNzhk
ZDgNCg0KDQo+ID4gPg0KPiA+ID4gWyAgICAxLjM4ODc2N10gQmFkIGJsb2NrIHRhYmxlIGZvdW5k
IGF0IHBhZ2UgNTI0MTYwLCB2ZXJzaW9uIDB4MDENCj4gPiA+IFsgICAgMS4zOTY4MzNdIEJhZCBi
bG9jayB0YWJsZSBmb3VuZCBhdCBwYWdlIDUyNDAzMiwgdmVyc2lvbiAweDAxDQo+ID4gPiBbICAg
IDEuNDAzNzgxXSBuYW5kX3JlYWRfYmJ0OiBiYWQgYmxvY2sgYXQgMHgwMDAwMDJkMDAwMDANCj4g
PiA+IFsgICAgMS40MDg5MjFdIG5hbmRfcmVhZF9iYnQ6IGJhZCBibG9jayBhdCAweDAwMDAwMmQ4
MDAwMA0KPiA+ID4gWyAgICAxLjQxNDc1MF0gZnNsLGlmYy1uYW5kIDUzMDAwMDAwMC5uYW5kOiBJ
RkMgTkFORCBkZXZpY2UgYXQNCj4gPiA+IDB4NTMwMDAwMDAwLCBiYW5rIDINCj4gPiA+DQo+ID4g
Pg0KPiA+ID4gRnVsbCB0ZXN0IGxvZywNCj4gPiA+DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnFhLQ0KPiA+ID4gcmVw
b3J0cy5saW5hcm8ub3JnJTJGbGtmdCUyRmxpbnV4LW1haW5saW5lLW9lJTJGYnVpbGQlMkZ2NS43
LXJjNS01NS0NCj4gPiA+DQo+IGcxYWU3ZWZiMzg4NTQlMkZ0ZXN0cnVuJTJGMTgyNTQlMkZsb2cm
YW1wO2RhdGE9MDIlN0MwMSU3Q3Bvb25hDQo+IG0uDQo+ID4gPg0KPiBhZ2dyd2FsJTQwbnhwLmNv
bSU3QzE0NmY2MzRjODY5ZjRjNzBiYWExMDhkN2Y4OTA5ZmZiJTdDNjg2ZWExZDNiYw0KPiAyDQo+
ID4gPg0KPiBiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzI1MTE3MjM1NDYzODI5
OCZhbXA7c2RhdGE9JTJCDQo+ID4gPg0KPiBKaHMlMkZiOTIlMkJBNTZXellkSGUlMkJCaFhXZmpr
OGZlQ0dBRnYlMkJSekZLQzlQTSUzRCZhbXA7cg0KPiBlc2UNCj4gPiA+IHJ2ZWQ9MA0KPiA+ID4N
Cj4gPiA+IC0gTmFyZXNoDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg0KVGhhbmtzLA0KU2hp
dmENCg==
