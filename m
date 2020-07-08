Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C303C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0967F20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U8jV8Ium"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgGHFQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:16:54 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:43236
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbgGHFQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0OJsGwrdlfuXN1FcY6NKMPWZTEqJ7Rq37fV5qPEwi0h/YYFlTTS/+BsMxdUnWok18BT82F9I5BQtMvEb+bSdBf9V6Z5EZcXtJh2Cd5sJ84s6luq1PbzJPSrnMm9g7h+UEIMiGauMli8vJh1gGJgxzXCEBBaUqdSL7dVOS26t86Y58lx3WkLz/OLCn8qBvZXonvXz9ZNfpRkWeN5xt22G9a9WOY5Ce7ZJJ0pezbKKZpt8TS6inS9NwNPkxJlOwgZylhFZWbjpyGBhkAMCvdJG+GmJzlGsKLDuhrrn4zRBgNNnsyXjVaD/s6oufM9aaSPOecJcmgEk6rUOHQGQ7QKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW8hEE9TLqjTXoCtESvnPcH5deEMf/BN1vrPCu/UPO4=;
 b=TSU6iSK7QV6+qkMy0srhYP5au2gdwTXz/1YbH+SK0mGXc1xpW72UavYds8YbnOwqAMlr5ePT5Ke7Eh/mKUS6QD98V1DZVZSBciMqeLfhY2qJvanTBg+HevQin4KzQnrO31+j0ad5Y+eet8GipBLBip+hLTHvtVKnk7IPMcqwwMImgYftaPVuQab4UmbUzgWF5jVpZ/RxwGmT5OJFEwOXlpSfdTW5nMJV5IP9KZdKwBPOofgvAnUnlJft9cpEVbQoc92DtyulM1tq+Lv6zPsz2fv2E8YqtrZn85k9L6jdxx5PRdUP7FlATmmM4uE5q4SrbW2nTso9GwW2WFrgMoWCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW8hEE9TLqjTXoCtESvnPcH5deEMf/BN1vrPCu/UPO4=;
 b=U8jV8Iuml+XpTGlsGFs1YiiXGN6UgxH6nKQ8eFmVIjxd/WmgGhxAoIMxwNMOF43B2Fv9h/+Ox3LUBlOaCRVukW8rn69qauaMtLnxhp1kcjhMGjJULv+zagPSaMHO9X4L/7NwrrUcB1Nps696nrMXbd/624GuYrvE61CW3XhZKDU=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB6406.eurprd04.prod.outlook.com
 (2603:10a6:20b:f2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 05:16:47 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 05:16:47 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5 3/3] ARM: imx6plus: optionally enable
 internal routing of clk_enet_ref
Thread-Topic: [EXT] Re: [PATCH v5 3/3] ARM: imx6plus: optionally enable
 internal routing of clk_enet_ref
Thread-Index: AQHWUMBIY0/PmQIJzUKZXhlXPuzWDKj3d74AgAGaMECAABAPAIAA5FDQgACP3wCAABQBAIAAAHAAgADT71CAAMRlgIAAwTvA
Date:   Wed, 8 Jul 2020 05:16:47 +0000
Message-ID: <AM6PR0402MB360755E7721F28A2CE30DFE6FF670@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200702175352.19223-1-TheSven73@gmail.com>
 <20200702175352.19223-3-TheSven73@gmail.com>
 <CAOMZO5DxUeXH8ZYxmKynA7xO3uF6SP_Kt-g=8MPgsF7tqkRvAA@mail.gmail.com>
 <CAGngYiXGXDqCZeJme026uz5FjU56UojmQFFiJ5_CZ_AywdQiEw@mail.gmail.com>
 <AM6PR0402MB360781DA3F738C2DF445E821FF680@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiWc8rNVEPC-8GK1yH4zXx7tgR9gseYaopu9GWDnSG1oyg@mail.gmail.com>
 <AM6PR0402MB36073F63D2DE2646B4F71081FF690@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5ATv9o197pH4O-7DV-ftsP7gGVuF1+r-sGd2j44x+n-Ug@mail.gmail.com>
 <CAGngYiVeNQits4CXiXmN2ZBWyoN32zqUYtaxKCqwtKztm-Ky8A@mail.gmail.com>
 <CAGngYiX9Hx413BX-rgaaUjD9umS9hGg=gMLbM+QmdyEt2Nut5A@mail.gmail.com>
 <AM6PR0402MB36078DBF3B7737B1C3F032AAFF660@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiU7HEyZXYN4GxM=w83g1O-NVsmSwvPrbeY6=UxSUW8vCg@mail.gmail.com>
In-Reply-To: <CAGngYiU7HEyZXYN4GxM=w83g1O-NVsmSwvPrbeY6=UxSUW8vCg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3867cd0-3ef5-4105-a5fb-08d822fe1cf6
x-ms-traffictypediagnostic: AM6PR04MB6406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6406E0378FDCD122A88C54C1FF670@AM6PR04MB6406.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9f/cqGYq+8poHzPYO7egm90OrF/AwUM+bE4jj/wP/PckfX8Wv1OzviHOy/KZNNKNZ6J5YGfjXI4YT/2FY3COxC5pkYdL7q4viO3DGXW4SpMPliSmwXkckzWcme/biQ2ElstxsF+BIVosY9Njxf6qu7UCzDgxlqwjmz3SEPttY3kf2LrL981L10Ur6aa+DHH8wBUolJ77uRhS946m0oHhym9bMtgD7YxsxbuQ2//k2S//Ub/5D91GjHpVW/aQgLY4i0EA2zdcgEU08SOn/91fgY5G6xLa0LAtXxMyK2FNK0TAjw6AMxS0KEkCrk3oR6hhtIR2lXLc2RXXN5obLGPU163f1o4aQE25lrDo7zNuh7H5HUjLXMuUNiN3ij7PNjd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(26005)(186003)(4326008)(2906002)(8936002)(8676002)(55016002)(9686003)(6916009)(7696005)(33656002)(86362001)(6506007)(71200400001)(478600001)(83380400001)(76116006)(66476007)(54906003)(66556008)(52536014)(5660300002)(66946007)(66446008)(64756008)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EEsx97sUVim8+SuNr8LIokwXjY62eDQ/H4GaRmThLMdmyhYvPP7PtN38CBzsDD7w0DptHQGmGVz07iPiSvHyAYSkFK1dKh4Pp8NExvrgef8+XY+/v/fBQnpGScpuOhyD+LVgfjvk09jQEGnjpMpwbrXvXb+Qfh8acPuF4juOzu8fFMKASmRvnvcMVtL3+XHLm1j95dtxqac6Zp6Q2JzSYB6VH9S6JXtb74c/ablADrT1/OOoJdFxG5rYVUbrRibd5okCdQAQWaww8PPl9qyjA8iSsDFgvJCWz0jl22ckm1mIQjjuOPlJAHv6qt23N69JU515HilGbt2CqXZ5aWjZ/oG51INJpZre1oJmiYdulpx727MseS1jiUaQNnuyTZFPYcehYsyi+fDa/VBJQ5MeZF7384VkMJhoOthCb4t+bzM0IZRO3F1flC6m5HUzdDpERoModAsMJoxGvGewhD1+pYmU12GucbA/o8koZtbf3NI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3867cd0-3ef5-4105-a5fb-08d822fe1cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 05:16:47.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHUXCVoLELnfOdLG5TKdlwsMeVSLZBEt4baczJXQi2wjCFk7zNgs0BYDqKCwndL4Njxpzt3mz19JIQNYM8XV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3ZlbiBWYW4gQXNicm9lY2sgPHRoZXN2ZW43M0BnbWFpbC5jb20+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgNywgMjAyMCAxMToyMSBQTQ0KPiBBbmR5LCBGYWJpbywNCj4gDQo+IFNvdW5kcyBs
aWtlIHdlIG5vdyBoYXZlIGEgc29sdXRpb24gd2hpY2ggbWFrZXMgbG9naWNhbCBzZW5zZSwgYWx0
aG91Z2ggaXQNCj4gcmVxdWlyZXMgY2hhbmdlcyBhbmQgYWRkaXRpb25zIHRvIGRyaXZlcnMvY2xr
L2lteC8uIEJlZm9yZSBJIGNyZWF0ZSBhIHBhdGNoLA0KPiBjYW4geW91IHJlYWQgdGhlIHBsYW4g
YmVsb3cgYW5kIGNoZWNrIHRoYXQgaXQgbWFrZXMgc2Vuc2UsIHBsZWFzZT8NCj4gDQo+IFByb2Js
ZW0NCj4gPT09PT09PQ0KPiBPbiB0aGUgaW14NnEgcGx1cywgdGhlIE5YUCBodyBkZXNpZ25lcnMg
aW50cm9kdWNlZCBhbiBhbHRlcm5hdGl2ZSB3YXkgdG8NCj4gY2xvY2sgdGhlIGJ1aWx0LWluIGV0
aGVybmV0IChGRUMpLiBPbmUgc2luZ2xlIGN1c3RvbWVyIChhcmNocm9uaXgpIHNlZW1zIHRvIGJl
DQo+IGN1cnJlbnRseSB1c2luZyB0aGlzIGZ1bmN0aW9uYWxpdHksIGFuZCB3b3VsZCBsaWtlIHRv
IGFkZCBtYWlubGluZSBzdXBwb3J0Lg0KPiANCj4gQ2hhbmdpbmcgdGhlIGV0aGVybmV0IChGRUMp
IGRyaXZlciBhcHBlYXJzIGlsbG9naWNhbCwgYXMgdGhpcyBjaGFuZ2UgaXMNCj4gdW5yZWxhdGVk
IHRvIHRoZSBGRUMgaXRzZWxmOiBmdW5kYW1lbnRhbGx5LCBpdCdzIGEgY2xvY2sgdHJlZSBjaGFu
Z2UuDQo+IA0KPiBXZSBhbHNvIG5lZWQgdG8gcHJldmVudCBicmVha2luZyBleGlzdGluZyBib2Fy
ZHMgd2l0aCBtaXMtY29uZmlndXJlZCBGRUMNCj4gY2xvY2tpbmc6DQo+IA0KPiBTb21lIGJvYXJk
IGRlc2lnbmVycyBpbmRpY2F0ZSBpbiB0aGUgZGV2aWNldHJlZSB0aGF0IEVORVRfUkVGX0NMSyBp
cw0KPiBjb25uZWN0ZWQgdG8gdGhlIEZFQyBwdHAgY2xvY2ssIGJ1dCBpbiByZWFsaXR5LCB0aGV5
IGFyZSBwcm92aWRpbmcgYW4gdW5yZWxhdGVkDQo+IGV4dGVybmFsIGNsb2NrIHRocm91Z2ggdGhl
IHBhZC4gVGhpcyB3aWxsIHdvcmsgaW4gbWFueSBjYXNlcywgYmVjYXVzZSB0aGUgRkVDDQo+IGRy
aXZlciBkb2VzIG5vdCByZWFsbHkgY2FyZSB3aGVyZSBpdHMgUFRQIGNsb2NrIGNvbWVzIGZyb20s
IGFuZCB0aGUgZW5ldCByZWYNCj4gY2xvY2sgaXMgc2V0IHVwIHRvIG1pcnJvciB0aGUgZXh0ZXJu
YWwgY2xrIGZyZXF1ZW5jeSBieSB0aGUgTlhQIFUtQm9vdCBmb3JrLg0KPiANCj4gUHJvcG9zZWQg
Y2hhbmdlcyBtdXN0IG5vdCBicmVhayB0aGVzZSBjYXNlcy4NCj4gDQo+IFByb3Bvc2VkIFNvbHV0
aW9uDQo+ID09PT09PT09PT09PT09PT09DQo+IE9uIG5vbi1wbHVzIGlteDZxIHRoZXJlIGFyZSBu
byBjaGFuZ2VzLiBPbiBpbXg2cSBwbHVzIGhvd2V2ZXI6DQo+IA0KPiBDcmVhdGUgdHdvIG5ldyBj
bG9ja3MgKG1hY19ndHggYW5kIHBhZCkgYW5kIGEgbmV3IGNsb2NrIG11eDoNCj4gDQo+ICAgZW5l
dF9yZWYtby0tLS0tLS0tLT5wYWQtLS0tLT58IFwNCj4gICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgIHwgIHwNCj4gICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgIHxNMXwtLS0tbWFj
X2d0eCAtLS0gdG8gRkVDDQo+ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICB8ICB8DQo+
ICAgICAgICAgICAgby0tLS0tLS0tLS0tLS0tLS0tLS18Xy8NCj4gDQo+IFRoZSBkZWZhdWx0cyAo
aW5kaWNhdGVkIHdpdGggIj4iKSBhcmUgY2FyZWZ1bGx5IGNob3Nlbiwgc28gdGhlc2UgY2hhbmdl
cyB3aWxsDQo+IG5vdCBicmVhayBhbnkgZXhpc3RpbmcgcGx1cyBkZXNpZ25zLg0KPiANCj4gV2Ug
dGhlbiB0aWUgdGhlIGd0eCBjbG9jayB0byB0aGUgRkVDIGRyaXZlciBwdHAgY2xvY2ssIGxpa2Ug
c286DQo+IA0KPiBpbiBpbXg2cXAuZHRzaToNCj4gJmZlYyB7DQo+ICAgICBjbG9ja3MgPSA8JmNs
a3MgSU1YNlFETF9DTEtfRU5FVD4sDQo+ICAgICAgICAgPCZjbGtzIElNWDZRRExfQ0xLX0VORVQ+
LA0KPiAgICAgICAgIDwmY2xrcyBJTVg2UURMX0NMS19NQUNfR1RYPjsNCj4gfTsNCj4gDQo+IE11
eCBNMSBpcyBjb250cm9sbGVkIGJ5IEdQUjVbOV0uIFRoaXMgbXV4IGNhbiBqdXN0IHdyaXRlIHRv
IHRoZSBHUFI1DQo+IG1lbW9yeSBhZGRyZXNzLiBIb3dldmVyLCB0aGUgR1BSIHJlZ2lzdGVycyBh
cmUgYWxyZWFkeSBleHBvc2VkIGFzIGEgbXV4DQo+IGNvbnRyb2xsZXIgY29tcGF0aWJsZSA9ICJt
bWlvLW11eCIuIFRoaXMgbXV4IGRvZXMgY3VycmVudGx5IG5vdCB1c2UgR1BSNS4NCj4gDQo+IFNv
IHdlIGhhdmUgdG8gbWFrZSBhIGNob2ljZSBoZXJlOiB3cml0ZSBzdHJhaWdodCB0byB0aGUgbWVt
b3J5IGFkZHJlc3MNCj4gKGVhc3kpLCBvciBjcmVhdGUgYSBuZXcgY2xvY2sgbXV4IHR5cGUsIHdo
aWNoIHVzZXMgYW4gdW5kZXJseWluZyBtdXgNCj4gY29udHJvbGxlci4NCj4gDQo+IFdoZW4gdGhh
dCBpcyBkb25lLCBib2FyZCBkZXNpZ25lcnMgY2FuIGNob29zZSBiZXR3ZWVuOg0KPiANCj4gMS4g
aW50ZXJuYWwgY2xvY2tpbmcgKEdUWCBjbG9jayByb3V0ZWQgaW50ZXJuYWxseSkNCj4gDQo+ICZm
ZWMgew0KPiAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZjbGtzIElNWDZRRExfQ0xLX01BQ19HVFg+
Ow0KPiAgICAgYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrcyBJTVg2UURMX0NMS19FTkVU
X1JFRj47IH07DQoNClRoZSBvbmUgaXMgb3VyIHJlcXVpcmVtZW50IHRoYXQgZ3R4IGlzIGZyb20g
aW50ZXJuYWwgcGxsIGFuZCBvbmx5IGZvcg0KNnFwIGJvYXJkcy4gSXQgaXMgcmVxdWlyZWQgdG8g
c2V0IGluIGJvYXJkIGR0cyBmaWxlIGR1ZSB0byBkZXBlbmRzIG9uIGJvYXJkDQpkZXNpZ24uDQoN
CkhlcmUgYWxzbyBuZWVkIHRvIGFzc2lnbiBlbmV0X3JlZiBjbGsgcmF0ZSB0byAxMjVNaHouDQo+
IA0KPiAyLiBleHRlcm5hbCBjbG9ja2luZyAoR1RYIGNsb2NrIGZyb20gcGFkLCBwYWQgY29ubmVj
dGVkIHRvIGVuZXRfcmVmLA0KPiAgICB0eXBpY2FsbHkgdmlhIEdQSU9fMTYpLiBUaGlzIGlzIHRo
ZSBkZWZhdWx0IGFuZCBkb2VzIG5vdCBuZWVkIHRvIGJlDQo+IHByZXNlbnQuDQo+IA0KPiAmZmVj
IHsNCj4gICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19NQUNfR1RYPjsN
Cj4gICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsa3MgSU1YNlFETF9DTEtfUEFEPjsg
fTsNCj4gDQpBcyBhYm92ZSwgaGVyZSBhbHNvIG5lZWQgdG8gYXNzaWduIHRoZSBlbmV0X3JlZiBj
bGsgcmF0ZSB0byAxMjVNaHouDQpUaGUgY2xrIHRyZWU6DQpQbGw2IC0+IGVuZXRfcmVmIC0+IGNs
a19wYWQgLT4gbWFjX2d0eA0KUGxsNiAtPiBlbmV0X3JlZiAtPiBjbGtfcGFkIC0+IHJvdXRlIGJh
Y2sgdG8gc3VwcGx5IGNsayBmb3IgcHRwDQoNCj4gDQo+IDMuIGV4dGVybmFsIGNsb2NraW5nIChH
VFggY2xvY2sgZnJvbSBwYWQsIHBhZCBjb25uZWN0ZWQgdG8gZXh0ZXJuYWwgUEhZDQo+ICAgIGNs
b2NrIG9yIGV4dGVybmFsIG9zY2lsbGF0b3IpLg0KPiANCj4gcGh5X29zYzogb3NjaWxsYXRvciB7
DQo+ICNjbG9jay1jZWxscyA9IDwwPjsNCj4gY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+
IGNsb2NrLWZyZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQo+IH07DQo+IA0KPiAmZmVjIHsNCj4gICAg
IGNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19FTkVUPiwNCj4gICAgICAgICA8JmNsa3MgSU1Y
NlFETF9DTEtfRU5FVD4sDQo+ICAgICAgICAgPCZwaHlfb3NjPjsNCj4gfTsNCg==
