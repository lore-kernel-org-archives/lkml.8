Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77109C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFBB2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8BLmWwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGBFuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:50:51 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:43550
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgGBFuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:50:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNuyti5PdB2ZKh/KTPWt2CwHfWkK6GazvA/q8EZhbSaY0fRAN+7eR7plvhcW6UAMV09xov8T2uJ0PPJwAV/xIunt240FRpiC7DrRv0g7QeqsqHeMYtGlF3gNHc0F2hUbU6Hd6WtimCDdpQnS3exQECypS8yshpd3zyLDjIcz+OoE4p9aLxrUC8AQJoBF/MtruiZ37tUIUAs7CEhUsJtSVfNMKCbJMeMjeKSAbkLIP/P3nO1w/b4HPErFRGKVBFY6b/1sQXa1jPh3DEFszy80FHB0UGzEQDNS6HWosSgLMENGZuySPjvkOjZRsa4sLFuCNQdl/OdIsVKLBbj16eJ/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HkG0RdLWHxv9BQnuIe7H+ZSgybt50O6KCeb2w1n4Jg=;
 b=hbpafHv1nvTLdrc4Qt49ZkHziE0/saibl4vBYFd896iOabHH1UNhbFs1UVC0PML2NsldU4Fe/kWK1PNgab0ikipDvvP2uobYu1j0LTLIgIkn6nR2Zn8hAlXcOuFtzZAsnsuyfQbO0qSu8DC3QQUs0me9ZweLNgKKkL/cZiF5iNXI7XWWV1E5a5ESKNQZ4bp8rwa1GOdPB22qUgmhvPlhZ0f9aKwsJmS3HESo0+GQ9q00u2c9CmKEU26MIfVpo+eGzhGdYz6TsCDL0aMXz97rfK8O0QPv+fR11ucLYeDJqpYnQxhGqEpm/i4ZZYr2TUlRpinS/23uUcDSdk/Vp1pPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HkG0RdLWHxv9BQnuIe7H+ZSgybt50O6KCeb2w1n4Jg=;
 b=X8BLmWwMLIbX8qxxA/+LS317UrrFjNav8ybroCDXEczePT1THTKxqT4d4kGzaJvv8S80K6UPPtTPHhLFB2qkV7T1ojlGVmy2dzFCaUU2kAXyU/YDTjgc4U5mED1JZkiBZrLy7BArPex8nMzbJFY9S6ytEiGLgYeaOse4KlZeXgA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10) by AM6PR04MB5974.eurprd04.prod.outlook.com
 (2603:10a6:20b:9b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 05:50:46 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f%4]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 05:50:46 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock
 driver as module
Thread-Topic: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock
 driver as module
Thread-Index: AQHWUBcDN5O6DfQk0Eys1lXp/0IDLKjznleAgAAHjECAAB1eAIAABPhw
Date:   Thu, 2 Jul 2020 05:50:46 +0000
Message-ID: <AM6PR0402MB3911FBEE757FAB1D2ADDF192F56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-6-git-send-email-Anson.Huang@nxp.com>
 <CAA+hA=T1+F-oTfWdV22ztUT3Ru-dFPDzhC7aJsdj0R3yP4wzbA@mail.gmail.com>
 <DB3PR0402MB3916713CC9AF95251A3A2BFAF56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=RqvRVm9c635NXFQSeDekBPz9DU=eP4+LrBQpRR=-swZw@mail.gmail.com>
In-Reply-To: <CAA+hA=RqvRVm9c635NXFQSeDekBPz9DU=eP4+LrBQpRR=-swZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d72e4ee-f889-4801-c3a9-08d81e4bddc1
x-ms-traffictypediagnostic: AM6PR04MB5974:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5974EFC09D425BDF906AADE0F56D0@AM6PR04MB5974.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJIog6vgnWpbK3tQGgvvLy73XfVnz7jy+ddyl+FCeJYQZCwXw6Nr1uwx/us3cnI88e54ZIlN0+NvgP4ZAfHL7qLTTzm1EoI/k/361wnyPXVkELLVbtN9p6alpv7hzQ9j4cthhiZ33YeWiIOIBs1yKPv9Xe3PwWy6a5UHNbqH4uf4Annv3dbzprY3PUkXTrMT7olBR08CE4PSRxdUjnciev9a3J3yIHR1RYclCBsbvhzg1VMTkNuSvU0EmseO/yW6ygxQDcIri2EfcU6La2wDiV8Jv51cwZFeFCVFVbQ8ruEDdDfb5CuQZF7cRmi5ZXFtYRxiOiHpZGIq/tO1E+cVkhYFD0fA/UjosiwrKFtIC98I05q4vUHn/TXvBjIDGVzu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(8676002)(66946007)(55016002)(9686003)(4326008)(8936002)(52536014)(66556008)(66476007)(64756008)(7696005)(76116006)(54906003)(110136005)(44832011)(6506007)(478600001)(66446008)(316002)(86362001)(26005)(53546011)(33656002)(71200400001)(7416002)(5660300002)(2906002)(186003)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ihE1CN5fQLqn+adJFeAM4Qnn1EAlc60xw6SDUNmHtHRdpNbSENvoX5cY/Tf+jigHUBV+1akoSkvJtPCaz5nT6R8GuCZ52kBmkYMp4YvQg6LtMAl+L3kuejMvTMbsxhh2O57FKkaEl4EdPF0jnJy7KnqVZ1zjH2dwGJO5BBI/w7JH1lf/2tk7yV3pooVBZ2BWvx57KyEPu8mmKIiCKYeeo68Q0Wgj9siY+91Jw5UW08g7jpmX9RQMx8fEx25Id9CEO50QPyp363QGoV08wnB+bSFbuBPQMdVIj78BMzG/Er7PM2tzHdOGXUtb2TgMU90uACSIFO35eekCsIBPcmqCFrIksey9GC/xVcDRL8TuPq366VuZG5hfSYx+rJWu5zewiCUjA0qJ3Lgy7NUKiqan8NTzt4a+XjLHbwipg2ST8c6ngCE//RP9cpHs/q7e726RXF5jfUkBvjcFEZyLqBiGa16+S6UXxytgFzYywkhOZCbY6831PEwHzZpDY/gqz8P5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3911.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72e4ee-f889-4801-c3a9-08d81e4bddc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 05:50:46.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6g3kkL6HJI8fYG34EDCcM7qg6E5BgBPmPjuHt9c1KodRnKP00RRHhqtVYrAgspD6YD+ta2KS7Fp8hp31m2tjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCA1LzVdIGNsazogaW14OHF4cDogU3VwcG9ydCBi
dWlsZGluZyBpLk1YOFFYUCBjbG9jaw0KPiBkcml2ZXIgYXMgbW9kdWxlDQo+IA0KPiBPbiBUaHUs
IEp1bCAyLCAyMDIwIGF0IDExOjU1IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29t
Pg0KPiB3cm90ZToNCj4gWy4uLl0NCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICByZXR1cm4g
cGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZpbXg4cXhwX2xwY2dfY2xrX2RyaXZlcik7DQo+ID4g
PiA+ICt9DQo+ID4gPiA+ICtkZXZpY2VfaW5pdGNhbGwoaW14OHF4cF9scGNnX2Nsa19pbml0KTsN
Cj4gPiA+DQo+ID4gPiBBbnkgcmVhc29uIHRvIGNoYW5nZSB0byBkZXZpY2VfaW5pdGNhbGwgd2hp
Y2ggbG9va3MgYSBiaXQgc3RyYW5nZT8NCj4gPiA+IElzIGl0IGJlY2F1c2UgdGhlIGZvbGxvd2lu
ZyBsaW5lPw0KPiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0gY2xrLWlteC1zY3Uu
byBjbGstaW14LWxwY2ctc2N1Lm8NCj4gPiA+IEJ1dCBpdCBsb29rcyB0byBtZSB0aGV5J3JlIHN0
aWxsIHR3byBtb2R1bGVzLiBBcmVuJ3QgdGhleT8NCj4gPg0KPiA+IEl0IGlzIHN1Z2dlc3RlZCBi
eSBBcm5kIHRvIE5PVCB1c2UgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoKSwgaW4gb3JkZXINCj4g
PiB0byBzdXBwb3J0IG1vZHVsZSB1bmxvYWQsIGFsdGhvdWdoIHRoZSBjbG9jayBkcml2ZXIgbm9y
bWFsbHkgZG9lcyBOT1QNCj4gPiBzdXBwb3J0IHJlbW92ZSwgYnV0IGl0IGlzIGJldHRlciB0byBm
b2xsb3cgdGhlIHJpZ2h0IHdheS4NCj4gPg0KPiANCj4gQnkgZXhwYW5kaW5nIGJ1aWx0aW5fcGxh
dGZvcm1fZHJpdmVyKCkgbWFyY3JvLCB5b3Ugd2lsbCBmaW5kIHlvdXIgcGF0Y2ggaXMNCj4gZXhh
Y3RseSBkb2luZyB0aGUgc2FtZSB0aGluZyBhcyBidWlsZGluX3BsYXRmb3JtX2RyaXZlcigpIHdo
aWNoIG9iaXZvdXNseSBpcw0KPiB1bm5lY2Nlc2FyeS4NCj4gDQo+ICNkZWZpbmUgYnVpbHRpbl9w
bGF0Zm9ybV9kcml2ZXIoX19wbGF0Zm9ybV9kcml2ZXIpIFwNCj4gICAgICAgICBidWlsdGluX2Ry
aXZlcihfX3BsYXRmb3JtX2RyaXZlciwgcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKSAjZGVmaW5l
DQo+IGJ1aWx0aW5fZHJpdmVyKF9fZHJpdmVyLCBfX3JlZ2lzdGVyLCAuLi4pIFwNCj4gDQo+IHN0
YXRpYyBpbnQgX19pbml0IF9fZHJpdmVyIyNfaW5pdCh2b2lkKSBcIHsgXA0KPiAgICAgICAgIHJl
dHVybiBfX3JlZ2lzdGVyKCYoX19kcml2ZXIpICwgIyNfX1ZBX0FSR1NfXyk7IFwgfSBcDQo+IGRl
dmljZV9pbml0Y2FsbChfX2RyaXZlciMjX2luaXQpOw0KPiANCj4gSWYgd2Ugd2FudCB0byBzdXBw
b3J0IHVubG9hZCwgd2UgbmVlZCBhIC5yZW1vdmUoKSBjYWxsYmFjayBhcyBjdXJyZW50IGNsb2Nr
cw0KPiBhcmUgbm90IGFsbG9jYXRlZCBieSBkZXZtXygpLg0KPiBJZiBkb24ndCBzdXBwb3J0LCAg
d2UgcHJvYmFibHkgY2FuIHVzZSBidWlsdGluX3BsYXRmb3JtX2RyaXZlcigpIGZpcnN0IGFuZA0K
PiBzd2l0Y2ggdG8gbW9kdWxlX3BsYXRmb3JtX2RyaXZlcigpIGluIHRoZSBmdXR1cmUgb25jZSB0
aGUgZHJpdmVyIHN1cHBvcnRzDQo+IHJlbGVhc2UgcmVzb3VyY2UgcHJvcGVybHkuDQo+IA0KDQpZ
ZXMsIHRoYXQgaXMgd2h5IEkgdXNlIHRoZSBkZXZpY2VfaW5pdGNhbGwoKSB0byBtYWtlIGl0IGV4
YWN0bHkgc2FtZSBhcyBidWlsdGluX2RyaXZlcigpLA0KYW5kIGFsc28geWVzIHRoYXQgaS5NWCBj
bG9jayBkcml2ZXIgZG9lcyBOT1Qgc3VwcG9ydCBtb2R1bGUgdW5sb2FkLCBzbyAucmVtb3ZlKCkN
CmlzIE5PVCBpbXBsZW1lbnRlZCwgSSBhbSBmaW5lIHdpdGggZWl0aGVyIHdheSwganVzdCB0cnkg
dG8gYWRkcmVzcyBBcm5kJ3MgY29tbWVudC4NCg0KSGksIEFybmQNCglXaGF0IGRvIHlvdSB0aGlu
az8gRG8geW91IGFncmVlIHRvIGtlZXAgdXNpbmcgdGhlIGJ1aWx0aW5fZHJpdmVyKCk/DQoNClRo
YW5rcywNCkFuc29uDQo=
