Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0189F20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vt+iYdA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgFWJAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:00:53 -0400
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:17153
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731756AbgFWJAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM3terVNFSVJ0yQixWNa0iFtTDn/oKaEKoBtf1eLAb35//Y/ndXJpWqlLiY1na7OrLIsVRfut+BxPzWlRf/KK/Rm4CUhq/gziQ7H/pjugBBNhQJHEf10/hDfowvWIZcnvuSJx/61DuOOm2Nl+wyUSTr72zOvBoxLq1UrFsiER9T/LwmX0hoQP8OSBHxEsiDpk7OdTZ21pm044DEoh/G8YL8GPhdAlI0sw36x0G5P870pqJUvzgNKas9WPk/33TeZOSA8s45bETkeHxyenlmB/TB81BlsMD/jp/3+eefEAaC1TqVWotiTTJUCJtYJivV6zOqD9itCEH8QVSu75C2t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj98DZoAXuzJ2v6pwYQ4vVSBD8e28soc8KxoVQk2tkY=;
 b=gnNThla31JaasYxNsxfIdm1yCmbUbvoUlHhDumN90PxR8QD8DjVRwmK9FdeM9v94m9eQvPOLfVZN8p2+LwXBLm3J9LAnO2JAU52jJN55PSJaD151hs1nW0aCu/SJQSabQvLyH27i6Tr9hjTzVXetYENalzPfz8hfFVWZQ4TLskBfbsEoQQDxmOcuoUP2DWJ1TqUG6YRklqjlx5aKdIw00SYzPJGbw0E1XbLzwJArLXl7BZdE3XxLuI6GoE9f8F7+gHce8Sq8YoJNO+IQBpH90t3SQh3MDnOTGL6DgKNvBVmMTiPt/tQKofKLBy4dHe3HIKXSPyLvlLsKSmSK1RUYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj98DZoAXuzJ2v6pwYQ4vVSBD8e28soc8KxoVQk2tkY=;
 b=Vt+iYdA6b2rO+8GZHF+QBYkQi8GIJIxvyW2jieXCsNjui/3KRk6/JQJnpCVYOVS8e1iNa+u7Ss6dvr6Zq7e74ygUn2gTyZc/RgFeXCGVKnwgbtynceoH5tljGZAjfP1LlnmWGJP/JROc7+H+kjVRI4Na5TXXYFjBYOenNL2CPl8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6152.eurprd04.prod.outlook.com (2603:10a6:20b:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 09:00:47 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 09:00:47 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAIADPk4AgASxvPCAAFrbAIAAAT6w
Date:   Tue, 23 Jun 2020 09:00:47 +0000
Message-ID: <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
In-Reply-To: <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b99b2759-12eb-464f-dee2-08d81753eb8d
x-ms-traffictypediagnostic: AM6PR04MB6152:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6152658F8C787BF09997DFD480940@AM6PR04MB6152.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Le/H/tyrqKMB3eP+26doAdIR8RwrK1gLkLwfTRbRwma5xgtEB9diA/P1NM+vxG5giEICsLfvnHw/0yqyKEoQu7ii3/QcdldtlsGmyhYdL9yZUlUEwC4ugYmWxtcK3gqFGu/HFLET10L8SgBmyAhKbAUfPXAR3ujN/Ev9tlWh67ppjE2sAA27yaU09SbFMF/v3y2k/QIJol/4+bxTrcJQ7ULEL/k3sOohRMXw+AU6GF3xd0LtrrmF5nHxiWFg0flhU0MpfhPWWtkSfANBEv0qzgULzCy9Kn6kOHTvFt85SSk1SRxu50HJDUoL322PZXGpalALDfJyM+xCg94UBxu8ycRcr7tdr004FZFpTfjii2GuX8jJYrwD8pCaKZy1tU2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(7696005)(33656002)(66446008)(66946007)(66556008)(64756008)(26005)(76116006)(66476007)(53546011)(186003)(2906002)(86362001)(6506007)(71200400001)(44832011)(478600001)(8936002)(316002)(5660300002)(83380400001)(4326008)(8676002)(52536014)(110136005)(55016002)(7416002)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2nrhVAOY71Vo+IfLvHOQD4dfYdqh8sPpPBDSKY9vYrjPAxM2KLQfJOg4/7W2CpgBBn8RQCM/UrwO+NF0sDhEOAb4kwMe7IGwEI82FiiUdgaa/Pxrrwf9+pog6v38oxxewhqg6Hy27nrN26aywAttsaHbDbucR3Z7ipbFSDPMlFS221HDwPl9XjPi2/jYGFbXo/V8wX3CDtCt6Om0eifxGkcLj22WGpveFdlDOm90DFc6dcu+bjV2+wxX2fAHW8LCiHU0QJXPthDktq9Si3OQQohhHsXch4Fs8U2ha93jFg6oPbwEdTkTeT5ElngwMCibHOBgaj545Ym1wVEmktppGH/Gl4XEnyD2d5w5rwMIRR1jnVU2l1FTapORuzaQfvav24ODDhpz6ij/pvWrBFSEOAk1E3Y8Nm98gM8QN6Oix0lrIOJhc8ArfgNawkZFJRSJn1ByRBO9toPM48cGsXUgP3Vsz/sMlAh4jABTBYqxOJg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99b2759-12eb-464f-dee2-08d81753eb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 09:00:47.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCj5YFU76je14EbwbiGJZz87bt/PayfN7iMLBgTFsxknX0VIeBH0keWMXv0OGALHClDPd8i4L2MkQh5NY1aQCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjMsIDIwMjAgNDozNCBQTQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDMvOV0gY2xr
OiBpbXg6IFN1cHBvcnQgYnVpbGRpbmcgU0NVIGNsb2NrIGRyaXZlciBhcw0KPiBtb2R1bGUNCj4g
DQo+IFF1b3RpbmcgQWlzaGVuZyBEb25nICgyMDIwLTA2LTIyIDIwOjQyOjE5KQ0KPiA+ID4gRnJv
bTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogU2F0dXJkYXks
IEp1bmUgMjAsIDIwMjAgMTE6MjggQU0NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85
XSBjbGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiA+IGRyaXZlciBhcyBt
b2R1bGUNCj4gPiA+DQo+ID4gPiBRdW90aW5nIEFpc2hlbmcgRG9uZyAoMjAyMC0wNi0xNyAxODo1
ODo1MSkNCj4gPiA+ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4N
Cj4gPiA+ID4gPiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0gbXhjLWNsay1zY3Uu
bw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IExpa2UgaS5NWCBwaW5jdHJsLCBJJ20gbm90IHN1
cmUgaWYgaXQncyByZWFsbHkgbmVjZXNzYXJ5IHRvDQo+ID4gPiA+ID4gPiBidWlsZCBjb3JlIGxp
YnJhcmllcyBhcyBtb2R1bGVzLiBQcm9iYWJseSB0aGUgc2ltcGxlc3Qgd2F5IGlzDQo+ID4gPiA+
ID4gPiBvbmx5IGJ1aWxkaW5nIHBsYXRmb3JtIGRyaXZlcnMgcGFydCBhcyBtb2R1bGUuIEFuZCBs
ZWF2ZSB0aG9zZQ0KPiA+ID4gPiA+ID4gY29yZSBsaWJyYXJpZXMNCj4gPiA+IGJ1aWx0IGluIGtl
cm5lbC4NCj4gPiA+ID4gPiA+IFRoaXMgbWF5IG1ha2UgdGhlIGNvZGUgYSBiaXQgY2xlYW5lci4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaWxsIGRpc2N1c3MgdGhpcyB3aXRo
IExpbmFybyBndXlzIGFib3V0IGl0LCBwcmV2aW91cw0KPiA+ID4gPiA+IHJlcXVpcmVtZW50IEkg
cmVjZWl2ZWQgaXMgYWxsIFNvQyBzcGVjaWZpYyBtb2R1bGVzIG5lZWQgdG8gYmUgYnVpbHQgYXMN
Cj4gbW9kdWxlLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE9rYXkuIEFGQUlLIGl0J3Mg
bm90IGNvbmZsaWN0Lg0KPiA+ID4gPiBZb3Ugc3RpbGwgbWFrZSBkcml2ZXJzIGludG8gbW9kdWxl
cy4NCj4gPiA+ID4gT25seSBkaWZmZXJlbmNlIGlzIGZvciB0aG9zZSBjb21tb24gbGlicmFyaWVz
IHBhcnQsIHdlIGRvbid0DQo+ID4gPiA+IGNvbnZlcnQgdGhlbSBpbnRvIG1vZHVsZSBXaGljaCBp
cyBsZXNzIG1lYW5pbmdsZXNzLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdoYXQgaXMgdGhlIGJl
bmVmaXQgb2YgbWFraW5nIHRoZSBjb3JlIHBhcnQgb2YgdGhlIFNvQyBkcml2ZXIgbm90IGEgbW9k
dWxlPw0KPiA+DQo+ID4gVXN1YWxseSB3ZSBjb3VsZCB0cnkgdG8gYnVpbGQgaXQgYXMgbW9kdWxl
IGlmIGl0J3Mgbm90IGhhcmQuDQo+ID4NCj4gPiBPbmUgcXVlc3Rpb24gaXMgc29tZXRpbWVzIHRo
b3NlIGNvcmUgcGFydCBhcmUgc2hhcmVkIHdpdGggc29tZSBwbGF0Zm9ybXMNCj4gd2hpY2ggY2Fu
J3QgYnVpbHQgYXMgbW9kdWxlLg0KPiA+IEZvciBpLk1YIGNhc2UsIGl0J3MgbWFpbmx5IHBhdGNo
IDQ6DQo+ID4gW1YyLDQvOV0gY2xrOiBpbXg6IFN1cHBvcnQgYnVpbGRpbmcgaS5NWCBjb21tb24g
Y2xvY2sgZHJpdmVyIGFzIG1vZHVsZQ0KPiA+DQo+ID4NCj4gPiBUaG9zZSBsaWJyYXJpZXMgYXJl
IGFsc28gdXNlZCBieSBpLk1YNiY3IHdoaWNoIGNhbid0IGJ1aWxkIGFzIG1vZHVsZS4NCj4gPiBT
byB3ZSBuZWVkIGFuIGV4dHJhIHdvcmthcm91bmQgcGF0Y2ggdG8gZm9yY2VseSAnc2VsZWN0JyBp
dCB1bmRlcg0KPiA+IGFyY2gvYXJtL21hY2gtaW14L0tjb25maWcgW1YyLDIvOV0gQVJNOiBpbXg6
IFNlbGVjdCBNWENfQ0xLIGZvcg0KPiA+IEFSQ0hfTVhDDQo+ID4gVGhlbiB0aGUgdXNlcnMgY2Fu
J3QgY29uZmlndXJlIGl0IGFzIG1vZHVsZSBpbiBvcmRlciB0byBub3QgYnJlYWsgYnVpbGQuDQo+
ID4NCj4gPiBJZiBidWlsZC1pbiB0aG9zZSBjb21tb24gbGlicmFyaWVzLCB0aGUgaW1wbGVtZW50
YXRpb24gY291bGQgYmUgYSBiaXQgZWFzaWVyDQo+IGFuZCBjbGVhbmVyLg0KPiA+IFNvIEknbSBu
b3Qgc3VyZSBpZiB3ZSBzdGlsbCBoYXZlIHRvIGJ1aWxkIHRoZW0gYXMgbW9kdWxlLg0KPiA+IEhv
dyB3b3VsZCB5b3Ugc3VnZ2VzdCBmb3Igc3VjaCBjYXNlPw0KPiANCj4gU3RvcCB1c2luZyAnc2Vs
ZWN0IE1YQ19DTEsnIHdoZW4gcmVxdWlyaW5nIHRoZSBjb3JlIGxpYnJhcnkgY29kZT8NCj4gSW5z
dGVhZCwgbWFrZSBpdCBhICdkZXBlbmRzJyBhbmQgdGhlbiB0aGF0IHdpbGwgbWFrZSBkZXBlbmRp
bmcgbW9kdWxlcyAoaS5lLiB0aGUNCj4gU29DIGZpbGVzKSB0aGF0IHdhbnQgdG8gYmUgYnVpbHRp
biBmb3JjZSB0aGUgY29yZSBtb2R1bGUgdG8gYmUgYnVpbHRpbiB0b28uIE90aGVyDQo+IG1vZHVs
YXIgY29uZmlncyB0aGF0IGRlcGVuZCBvbiB0aGUgY29yZSB3aWxsIHN0aWxsIGJlIG1vZHVsYXIu
DQo+IA0KDQpJdCBzZWVtcyBub3Qgd29yay4NClBhdGNoIDQgYWxyZWFkeSBjaGFuZ2VzIGl0IHRv
IGRlcGVuZCBvbiBBUkNIX01YQyB3aGljaCBjYW4gb25seSBiZSAnWScuDQpbVjIsNC85XSBjbGs6
IGlteDogU3VwcG9ydCBidWlsZGluZyBpLk1YIGNvbW1vbiBjbG9jayBkcml2ZXIgYXMgbW9kdWxl
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L0tjb25maWcgYi9kcml2ZXJzL2Nsay9pbXgv
S2NvbmZpZw0KaW5kZXggZGVkMDY0My4uNjc4MTEzYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xr
L2lteC9LY29uZmlnDQorKysgYi9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZw0KQEAgLTEsOCArMSw4
IEBAIA0KICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCiAjIGNvbW1vbiBjbG9j
ayBzdXBwb3J0IGZvciBOWFAgaS5NWCBTb0MgZmFtaWx5Lg0KIGNvbmZpZyBNWENfQ0xLDQotCWJv
b2wNCi0JZGVmX2Jvb2wgQVJDSF9NWEMNCisJdHJpc3RhdGUgIklNWCBjbG9jayINCisJZGVwZW5k
cyBvbiBBUkNIX01YQw0KDQpCdXQgdXNlciBjYW4gc3RpbGwgc2V0IE1YQ19DTEsgdG8gYmUgbSwg
ZWl0aGVyIHZpYSBtYWtlIG1lbnVjb25maWcgb3IgZGVmY29uZmlnLg0KDQpMb29rcyBsaWtlIG9u
bHkgc2VsZWN0IGl0IGluIGFyY2ggS2NvbmZpZyBpbiBQYXRjaCAyLCB0aGVyZSB3aWxsIGJlIG5v
IGlzc3VlLg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtaW14L0tjb25maWcgYi9hcmNoL2Fy
bS9tYWNoLWlteC9LY29uZmlnDQppbmRleCBlN2Q3YjkwLi40N2IxMGQyIDEwMDY0NA0KLS0tIGEv
YXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZw0KKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZp
Zw0KQEAgLTQsNiArNCw3IEBAICBtZW51Y29uZmlnIEFSQ0hfTVhDDQogCWRlcGVuZHMgb24gQVJD
SF9NVUxUSV9WNF9WNSB8fCBBUkNIX01VTFRJX1Y2X1Y3IHx8IEFSTV9TSU5HTEVfQVJNVjdNDQog
CXNlbGVjdCBBUkNIX1NVUFBPUlRTX0JJR19FTkRJQU4NCiAJc2VsZWN0IENMS1NSQ19JTVhfR1BU
DQorCXNlbGVjdCBNWENfQ0xLDQogCXNlbGVjdCBHRU5FUklDX0lSUV9DSElQDQogCXNlbGVjdCBH
UElPTElCDQogCXNlbGVjdCBQSU5DVFJMDQoNCj4gSSBkb24ndCBrbm93IHdoeSBhbiBhcmNoaXRl
Y3R1cmUgaXMgc2VsZWN0aW5nIHRoZSBjbGsgY29kZSBhdCBhbGwgdG8gYmUgaG9uZXN0Lg0KPiBU
aGF0IGNhbiBiZSBtb3ZlZCB0byB0aGUgZGVmY29uZmlnIGluc3RlYWQgb2YgaW4gdGhlIGFyY2hp
dGVjdHVyZSBLY29uZmlnIGFuZA0KPiB0aGVuIHlvdSBkb24ndCBnZXQgYSB3b3JraW5nIHN5c3Rl
bSB1bmxlc3MgeW91IHNlbGVjdCB0aGUgTVhDX0NMSyBjb25maWcgZnJvbQ0KPiB0aGUgY29uZmln
dXJhdG9yIHRvb2wgKG1lbnVjb25maWcsIG5jb25maWcsIGV0Yy4pIFNvIEFSQ0hfTVhDIHNob3Vs
ZG4ndCBiZSBpbg0KPiB0aGlzIGRpc2N1c3Npb24gYW5kIHRoZSBjb3JlIG1vZHVsZSBzaG91bGQg
YmUgc2VsZWN0YWJsZSBieSB0aGUgY29uZmlndXJhdG9yDQo+IGFuZCB0aGF0IHNob3VsZCBiZSB0
cmlzdGF0ZSBhbmQgYWxsIFNvQyBtb2R1bGVzIHNob3VsZCBkZXBlbmQgb24gdGhhdCBjb3JlDQo+
IGxpYnJhcnkgbW9kdWxlIGFuZCBiZSBzZWxlY3RhYmxlIHRvbyBhbmQgdGhvc2UgS2NvbmZpZ3Mg
Y2FuIGJlIHRyaXN0YXRlIG9yIGJvb2wuDQoNCkkgZ3Vlc3MgaXQgaXMgYmVjYXVzZSB3ZSBkaWRu
J3QgaGF2ZSByZXF1aXJlbWVudHMgdG8gbWFrZSBtaW5pbXVtIGJvb3RpbmcgcmVxdWlyZWQNCmRy
aXZlcnMgdG8gYmUgYnVpbHQgYXMgbW9kdWxlIGJlZm9yZS4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
