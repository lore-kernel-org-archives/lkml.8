Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687ECC11D01
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291D9208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EUzR1pE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBTHqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:46:20 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:41614
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbgBTHqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:46:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/6N2MShVlhVaLXrmVEQUY6Hi6lY+TYY/41BOCwZ3bO8+9Js+/T96LNBd0ODOZMLLOO/c6QInvaWPree33kCsa4FrAZ37XkXKtINXT/QniMujDT4Byq8yD+XDe0cT8rX2myxuCipjBtbiP31ea20r+GHHtnAHS/xgtI8shPggGGSXpiRYYhI9MB1KZeh0UWxtHtMWzal6HWCR63xzIbxBqXZpmF4ZtFZrl3TrrfohWUcTCS1qEUmfRmJLzLZTI1gSwkI3VyAACl1EFwBzWJJcXb18SJ8TRiTRP3FrKWbKorYLssmuj97i2wS83yA/va/lKQYwTn7xOvKUVg9qmn69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leREqLmgPqTFhzWCXfhPjWrK1kHBpcOgD1wqwIrvk1Y=;
 b=e+6iNch5r8ay5Nt6VRIGVXKDA1nwXErmqpXyz6IY/rdYle82eULN6DtTB5xnwm+bW8ydO8+2Ehrnd09/9LeSGfhe9XNu744fO5c9cx34sm8f6MLnQvOkJm3nynWJeFQHo7Hdk0BxjhewhxLRNgAYVMemGm1AfxKGsDQKjOg+VWaBmr1XrXlqs3Ymcm5cgcP8WN0JEpbZojuRj8TTcxm8cnGLLB+mMFg85pP2nITivItLRd0A4hE7gNP2iJ6hMcJ6HYLN1rwk7eijFX9PvvnM+eXfxaRBYVTcxhJw6jK4nIbYLj+sDHVOnWvI2AgkJDPwBbHn/YbQVNkkZKSukuUKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leREqLmgPqTFhzWCXfhPjWrK1kHBpcOgD1wqwIrvk1Y=;
 b=EUzR1pE7Hl73MA+9MdHsn7iY/uDR5ATc2GA2QoGLovbLtDyqk0UPV9LcgImUx+BZSjHl9341M/epXMul4MVAydHd2nsPDgrN+2779ZR1Y3ZSPRhHNuWE+EsU/4yDZa3KQRlOyiHEowxK2plrs0M9sifSh4RGfyjSbtsvgqz/Css=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5219.eurprd04.prod.outlook.com (20.177.42.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 07:46:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 07:46:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Subject: RE: [PATCH V4 1/2] firmware: imx: add dummy functions
Thread-Topic: [PATCH V4 1/2] firmware: imx: add dummy functions
Thread-Index: AQHV57c69tAonJSx8UC66CYpr4wwt6gjs7AAgAAAUkA=
Date:   Thu, 20 Feb 2020 07:46:13 +0000
Message-ID: <AM0PR04MB44817C5B222428272F48FE0088130@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
 <1582179843-14375-2-git-send-email-peng.fan@nxp.com>
 <a5134838-53d4-97f0-d126-b94164871763@nxp.com>
In-Reply-To: <a5134838-53d4-97f0-d126-b94164871763@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abecfbca-4728-4b65-d7ef-08d7b5d8f60f
x-ms-traffictypediagnostic: AM0PR04MB5219:|AM0PR04MB5219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB52196A7CACC66B9FF5E1F75488130@AM0PR04MB5219.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(33656002)(26005)(6506007)(2906002)(5660300002)(76116006)(86362001)(44832011)(8936002)(53546011)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(52536014)(478600001)(9686003)(81156014)(55016002)(71200400001)(8676002)(81166006)(4326008)(316002)(54906003)(7696005)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5219;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H0Au8osANIaib63IU157mE1LEGeaNxy5yrivuMGS7B6LTgpmQ4GMuPnA105M3GLsTRAiM/IWvVNo0KvoGlOK6bU+TjYNL9zPZzEXtKkiOK/rY9O0tpAQCSB+dpjZ1x02gXr0M6b6BVt3HDYkwmq1tnnZSCB7r4vJlYHrNYhYNYhFW7kAjwTfWqSrpTSeat6CUp9jrsnTFmqftE0BihVya5iD44EyD0bHtK/M0n9V9+Cq9zEcTowEiyFxbdh2vWi/nNvEN1FCIJYZoVF5o45E0P8d23msheju3awL5r2MeiSyYANvUIiBIWwBPzwlFUzk50o9y5RTbtZM2eLJVAL9qglbSfId8mEpHVhRVj/TLc+M4TBJogIKQgPWXj8yH2IJZ3yvO3PUw/ubf3FHlvpmIYaNqj7j8mMPk9kPYmSKcvEk4lWSAcdW7DI8ZBAygMCM
x-ms-exchange-antispam-messagedata: H7NyWUjaEMVseKZA4RbZj3k4h5t1sG44aWhWPpyzIunx+VQAtvljss96DsUpQIcpi5VykFD9DoThUalhjWVAakbwQHUoE2jNQIlpSSYXyD+BkUqIXYXawrdq3Vr+YgwQpT0B1r1r9V9HEi6voIto1A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abecfbca-4728-4b65-d7ef-08d7b5d8f60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 07:46:14.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaM7jF8nwJ3hzcCYHPXdOU8SA+DrnkQpemk0Mi25IR2gPTx72X38faCjKeGcCVAyKCNbLDY3m+M3q/ozH/ahrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAxLzJdIGZpcm13YXJlOiBpbXg6IGFkZCBkdW1t
eSBmdW5jdGlvbnMNCj4gDQo+IE9uIDIwLjAyLjIwMjAgMDg6MjQsIFBlbmcgRmFuIHdyb3RlOg0K
PiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gSU1YX1NDVV9T
T0MgY291bGQgYmUgZW5hYmxlZCB3aXRoIENPTVBJTEVfVEVTVCwgaG93ZXZlciB0aGVyZSBpcyBu
bw0KPiA+IGR1bW15IGZ1bmN0aW9ucyB3aGVuIENPTkZJR19JTVhfU0NVIG5vdCBkZWZpbmVkLiBU
aGVuIHRoZXJlIHdpbGwgYmUNCj4gPiBidWlsZCBmYWlsdXJlLg0KPiA+DQo+ID4gU28gYWRkIGR1
bW15IGZ1bmN0aW9ucyB0byBhdm9pZCBidWlsZCBmYWlsdXJlIGZvciBDT01QSUxFX1RFU1QNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmggICAgICB8IDEzICsrKysr
KysrKysrKysNCj4gPiAgIGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oICAgICAgfCAy
MiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lt
eC9zdmMvbWlzYy5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFu
Z2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9maXJtd2FyZS9pbXgvaXBjLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L2lw
Yy5oDQo+ID4gaW5kZXggNjMxMmM4Y2IwODRhLi4zMDQ3NTA4MmY0NzIgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L2Zpcm13YXJlL2lteC9pcGMuaA0KPiA+IEBAIC0zNSw2ICszNSw3IEBAIHN0cnVjdCBpbXhf
c2NfcnBjX21zZyB7DQo+ID4gICAJdWludDhfdCBmdW5jOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICsj
aWZkZWYgQ09ORklHX0lNWF9TQ1UNCj4gPiAgIC8qDQo+ID4gICAgKiBUaGlzIGlzIGFuIGZ1bmN0
aW9uIHRvIHNlbmQgYW4gUlBDIG1lc3NhZ2Ugb3ZlciBhbiBJUEMgY2hhbm5lbC4NCj4gPiAgICAq
IEl0IGlzIGNhbGxlZCBieSBjbGllbnQtc2lkZSBTQ0ZXIEFQSSBmdW5jdGlvbiBzaGltcy4NCj4g
PiBAQCAtNTYsNCArNTcsMTYgQEAgaW50IGlteF9zY3VfY2FsbF9ycGMoc3RydWN0IGlteF9zY19p
cGMgKmlwYywgdm9pZA0KPiAqbXNnLCBib29sIGhhdmVfcmVzcCk7DQo+ID4gICAgKiBAcmV0dXJu
IFJldHVybnMgYW4gZXJyb3IgY29kZSAoMCA9IHN1Y2Nlc3MsIGZhaWxlZCBpZiA8IDApDQo+ID4g
ICAgKi8NCj4gPiAgIGludCBpbXhfc2N1X2dldF9oYW5kbGUoc3RydWN0IGlteF9zY19pcGMgKipp
cGMpOw0KPiA+ICsjZWxzZQ0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBpbXhfc2N1X2NhbGxfcnBj
KHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHZvaWQgKm1zZywNCj4gPiArCQkJCSAgIGJvb2wgaGF2
ZV9yZXNwKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW5saW5lIGludCBpbXhfc2N1X2dldF9oYW5kbGUoc3RydWN0IGlteF9zY19p
cGMgKippcGMpIHsNCj4gPiArCXJldHVybiAtRU5PVFNVUFA7DQo+ID4gK30NCj4gPiArI2VuZGlm
DQo+ID4gICAjZW5kaWYgLyogX1NDX0lQQ19IICovDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lt
eC9zY2kuaA0KPiA+IGluZGV4IDE3YmE0ZTQwNTEyOS4uN2VhODc1YjE4NmUzIDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4gPiBAQCAtMTYsOCArMTYsMzAgQEANCj4gPiAg
ICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaD4NCj4gPiAgICNpbmNsdWRl
IDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3BtLmg+DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19J
TVhfU0NVDQo+ID4gICBpbnQgaW14X3NjdV9lbmFibGVfZ2VuZXJhbF9pcnFfY2hhbm5lbChzdHJ1
Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICAgaW50IGlteF9zY3VfaXJxX3JlZ2lzdGVyX25vdGlmaWVy
KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpOw0KPiA+ICAgaW50IGlteF9zY3VfaXJxX3VucmVn
aXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7DQo+ID4gICBpbnQgaW14
X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdyb3VwLCB1MzIgbWFzaywgdTggZW5hYmxlKTsNCj4g
PiArI2Vsc2UNCj4gPiArc3RhdGljIGlubGluZSBpbnQgaW14X3NjdV9lbmFibGVfZ2VuZXJhbF9p
cnFfY2hhbm5lbChzdHJ1Y3QgZGV2aWNlDQo+ID4gKypkZXYpIHsNCj4gPiArCXJldHVybiAtRU5P
VFNVUFA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGlteF9zY3VfaXJx
X3JlZ2lzdGVyX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jaw0KPiA+ICsqbmIpIHsNCj4g
PiArCXJldHVybiAtRU5PVFNVUFA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUg
aW50IGlteF9zY3VfaXJxX3VucmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0DQo+ID4gK25vdGlmaWVy
X2Jsb2NrICpuYikgew0KPiA+ICsJcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGlubGluZSBpbnQgaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdyb3VwLCB1
MzIgbWFzaywgdTgNCj4gPiArZW5hYmxlKSB7DQo+ID4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+
ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICAgI2VuZGlmIC8qIF9TQ19TQ0lfSCAqLw0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oDQo+ID4gYi9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oDQo+ID4gaW5kZXggMDMxZGQ0ZDNjNzY2
Li4zZjRhMGY1MjZiNzMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9p
bXgvc3ZjL21pc2MuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9t
aXNjLmgNCj4gPiBAQCAtNDYsNiArNDYsNyBAQCBlbnVtIGlteF9taXNjX2Z1bmMgew0KPiA+ICAg
ICogQ29udHJvbCBGdW5jdGlvbnMNCj4gPiAgICAqLw0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdf
SU1YX1NDVQ0KPiA+ICAgaW50IGlteF9zY19taXNjX3NldF9jb250cm9sKHN0cnVjdCBpbXhfc2Nf
aXBjICppcGMsIHUzMiByZXNvdXJjZSwNCj4gPiAgIAkJCSAgICB1OCBjdHJsLCB1MzIgdmFsKTsN
Cj4gPg0KPiA+IEBAIC01NCw1ICs1NSwyMyBAQCBpbnQgaW14X3NjX21pc2NfZ2V0X2NvbnRyb2wo
c3RydWN0IGlteF9zY19pcGMgKmlwYywNCj4gPiB1MzIgcmVzb3VyY2UsDQo+ID4NCj4gPiAgIGlu
dCBpbXhfc2NfcG1fY3B1X3N0YXJ0KHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUzMiByZXNvdXJj
ZSwNCj4gPiAgIAkJCWJvb2wgZW5hYmxlLCB1NjQgcGh5c19hZGRyKTsNCj4gPiArI2Vsc2UNCj4g
RnVuY3Rpb25zIGZvciBkdW1teSBjYXNlIGJlbG93IHNob3VsZCBiZSBzdGF0aWMgaW5saW5lLg0K
DQpPcHBzLiBGb3Jnb3QgdG8gYWRkIHRoZXNlIHRocmVlLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+
ID4gK2ludCBpbXhfc2NfbWlzY19zZXRfY29udHJvbChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1
MzIgcmVzb3VyY2UsDQo+ID4gKwkJCSAgICB1OCBjdHJsLCB1MzIgdmFsKQ0KPiA+ICt7DQo+ID4g
KwlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgaW14X3NjX21pc2Nf
Z2V0X2NvbnRyb2woc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTMyIHJlc291cmNlLA0KPiA+ICsJ
CQkgICAgdTggY3RybCwgdTMyICp2YWwpDQo+ID4gK3sNCj4gPiArCXJldHVybiAtRU5PVFNVUFA7
DQo+ID4gK30NCj4gPg0KPiA+ICtpbnQgaW14X3NjX3BtX2NwdV9zdGFydChzdHJ1Y3QgaW14X3Nj
X2lwYyAqaXBjLCB1MzIgcmVzb3VyY2UsDQo+ID4gKwkJCWJvb2wgZW5hYmxlLCB1NjQgcGh5c19h
ZGRyKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICt9DQo+ID4gKyNlbmRp
Zg0KPiA+ICAgI2VuZGlmIC8qIF9TQ19NSVNDX0FQSV9IICovDQo+IA0KDQo=
