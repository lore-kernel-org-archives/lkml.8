Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB629C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A692A2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bALeau/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgFRCF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:05:57 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:19376
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731134AbgFRCFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLPyji93jyO23iI+T2+ZD7ElKdf9OaIOpiXRLqeoKAeU0WXOTiqwUlfDay0ZsV8k45+JjVuoDVXGp3kq3CcfcvUom5STOLOn2DwkKzEcngUCDzUXDLO/EdZNGfO/vLr235ndzg1wE1MHjzqfRPVSFbYy5BdOYMjBxSEQG/xGruUvqg66sFk/fAi4O8TEmpg2B+XmqjWzTwYkLnCkZn3x4xzl4nJPqrKzomYbH3GicqzepYolpq4V+vVZhqACwqJjjhG/9Qbw+p54HMhAXJeW6LRdZkhESGAD2Xk/BLekv1a6bV6qy8u7HFjLP2liF96rYNxOw/K7M0TUgrvHWRJrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSNH2mMh3G5tum97EB9osVdPq/42PdoRyV50sl1zWWs=;
 b=dvQ7PgmL01/vjUyDHy95wbGXSRr/kAyIOpmFcTECH8ZBGdMktEr2q9hEOzEDNwOC+bTPciczpylFtVoF2RlePu1AT6KMYIlS9KXDD2IuHilQVYh3VuPlXFpcOukT8STFZg1DNNneM0flRCRFs4VEaX7K3/AkyPiXUQ6PZSIGtopexruxhdcbTdUSJ3z3415cSH9yy3exPnz7lROP2CkcFOrmJOsuJ242z/DS1i891oS6Leuj5Qiv979HMo/ePK+ZhCyk1MYH0WPmIg3/abopfF6x+lmjP/e9ThO6bfKK0hQTqHT5lsUhc8RmHPEYfAtImAvhWFGKo+twmaxH1HWhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSNH2mMh3G5tum97EB9osVdPq/42PdoRyV50sl1zWWs=;
 b=bALeau/bLHtNzpNTLrLKTXrfZda1PlLbZ3x7qa+ISRMBoBS0fx8mVf7xS0z5UCqnYd9+hFV4nAFCzVJZKiYuMvTrfpZf5+lS/50qWnldDg8K+0x/T+NC/WNx7CsKeiLcfoQ+FGgGcMdoRRAZSK+sHAfEm9mJtI1Pc/ca83krGAU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5000.eurprd04.prod.outlook.com (2603:10a6:20b:7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 02:05:37 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 02:05:37 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/9] clk: composite: Export clk_hw_register_composite()
Thread-Topic: [PATCH V2 1/9] clk: composite: Export
 clk_hw_register_composite()
Thread-Index: AQHWPjGiuQ2F29kQlUqqseTZxooV6ajcol7ggAAnuICAAOHM0A==
Date:   Thu, 18 Jun 2020 02:05:37 +0000
Message-ID: <AM6PR04MB49660A7940C920A513EC87D3809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-2-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49665E5D93C2FFA8221F8660809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916CD2DEFC64796E7869EEDF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916CD2DEFC64796E7869EEDF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a209fc33-a749-4849-6d9e-08d8132c17f8
x-ms-traffictypediagnostic: AM6PR04MB5000:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB50001CAE4F3A3261489AAC92809B0@AM6PR04MB5000.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZL57wArh20MWZfLHYN6nO7dbnwsgJ1/VeKUZGh3UGK5ppZ5f7juQLdnCgCzhH4UE9p+UHOglsaaK4oQDqJcwU1S0Z3vzWgMfttt63nKQrFw3jtHPYupRt9xqvMAyBz80pd67KvMBK4p0tnSyWr854vDRiZM/u+lOTvCd6HmtrftMKjSywfABOEmFQN6FESXO+z0o9B5fqgIWRKSo7REg0sz1oXsWQTuy1uLe0p4sWUDSv7DoB1x1IRmjtITerMwOrcz9sJZ0Yhwqpgg8IzF2rDmz73SVCspdvzVM39UVe4sKkKFMjL2OOsE2mj0WduXmGie3fNRxJ63RLoJRioEXYINrASrIMJ4TM7Ggbh5tHgJWqsmBp1Zisj8CDRrdRwb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(26005)(2906002)(186003)(66476007)(76116006)(66556008)(33656002)(64756008)(66446008)(110136005)(316002)(5660300002)(9686003)(7696005)(55016002)(66946007)(4326008)(53546011)(83380400001)(478600001)(44832011)(52536014)(8936002)(7416002)(8676002)(6506007)(71200400001)(86362001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lzGpgMXYF7hKjgJBPIMMvA+Y+7WEjZ0LglhimfmHK/cHW2RMgZdUMpHTIrcYoQLmHH5DS0oPcF15/s1i/fcYJYjpT8jdQPDA3jCK2XvRMGjCAzw6b0O+8OSEbCNjZjjpf9eXqki0jOmO47wcoBLnb694+Rp2Xn9pmNK7oNM+8H1NBKGhP2Q1qB7bWlMq59V9zpGcmXNbhpQ+Tvf5dFsApOHtKmhqRJNACiMN7BtTC5h6TpkW4wB604hIC4TIONlT6Xf7Pw7kqO6vNGazSdxoLsSEPpYxdSNJ0Ic0HjlfnQL0ak1xNMuP1FTO0M0z+YbAbcB2FpGw5p9glh+nqJmyRPa5jlL5UE5eMv9XnmB/7Nj+cH+ZkYOrOYCFJ0MFxVDxMiUAGzTHRlHgT0fFPWf9hG+em+nVfriycLQoym/TscI4D296yGw4GPbGZkrhr3pyn/tnAt/3/z2Ck9X2WI22Jg63/TePm8OIWBLOCJ3ECRB5zvlin4Qm3gjeYX9w6Fjp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a209fc33-a749-4849-6d9e-08d8132c17f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 02:05:37.3841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLahkin9Y+PAV9Uf52/nhZFlucBVtYjR6tlDLZzDJI0p5wgP41h8X/V82PYuYn4eqdA3wkF4R4FdTtO7RtmPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDE3LCAyMDIwIDg6MzIgUE0NCj4gDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCBW
MiAxLzldIGNsazogY29tcG9zaXRlOiBFeHBvcnQNCj4gPiBjbGtfaHdfcmVnaXN0ZXJfY29tcG9z
aXRlKCkNCj4gPg0KPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKdW5lIDksIDIwMjAgMzozMiBQTQ0KPiA+ID4NCj4gPiA+
IEV4cG9ydCBjbGtfaHdfcmVnaXN0ZXJfY29tcG9zaXRlKCkgdG8gc3VwcG9ydCB1c2VyIGJ1aWx0
IGFzIG1vZHVsZS4NCj4gPiA+DQo+ID4gPiBFUlJPUjogbW9kcG9zdDogImNsa19od19yZWdpc3Rl
cl9jb21wb3NpdGUiDQo+ID4gPiBbZHJpdmVycy9jbGsvaW14L214Yy1jbGsua29dIHVuZGVmaW5l
ZCENCj4gPiA+IHNjcmlwdHMvTWFrZWZpbGUubW9kcG9zdDoxMTE6IHJlY2lwZSBmb3IgdGFyZ2V0
ICdNb2R1bGUuc3ltdmVycycNCj4gPiA+IGZhaWxlZA0KPiA+ID4gbWFrZVsxXTogKioqIFtNb2R1
bGUuc3ltdmVyc10gRXJyb3IgMQ0KPiA+ID4gbWFrZVsxXTogKioqIERlbGV0aW5nIGZpbGUgJ01v
ZHVsZS5zeW12ZXJzJw0KPiA+ID4gTWFrZWZpbGU6MTM4NDogcmVjaXBlIGZvciB0YXJnZXQgJ21v
ZHVsZXMnIGZhaWxlZA0KPiA+ID4gbWFrZTogKioqIFttb2R1bGVzXSBFcnJvciAyDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+IE5vIGNoYW5nZS4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvY2xr
L2Nsay1jb21wb3NpdGUuYyB8IDEgKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRl
LmMNCj4gPiA+IGIvZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5jIGluZGV4IDczNzZmNTcuLjJk
ZGI1NGYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYw0KPiA+ID4gQEAgLTMyOCw2ICsz
MjgsNyBAQCBzdHJ1Y3QgY2xrX2h3ICpjbGtfaHdfcmVnaXN0ZXJfY29tcG9zaXRlKHN0cnVjdA0K
PiA+ID4gZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gPiAgCQkJCQkgICByYXRl
X2h3LCByYXRlX29wcywgZ2F0ZV9odywNCj4gPiA+ICAJCQkJCSAgIGdhdGVfb3BzLCBmbGFncyk7
DQo+ID4gPiAgfQ0KPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGNsa19od19yZWdpc3Rlcl9jb21w
b3NpdGUpOw0KPiA+ID4NCj4gPiA+ICBzdHJ1Y3QgY2xrX2h3ICpjbGtfaHdfcmVnaXN0ZXJfY29t
cG9zaXRlX3BkYXRhKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+ICAJCQljb25zdCBjaGFyICpu
YW1lLA0KPiA+DQo+ID4gSSBndWVzcyB5b3UnZCBiZXR0ZXIgYWRkIHRoaXMgb25lIGFzIHdlbGwu
DQo+IA0KPiBJIGRpZCBOT1Qgc2VlIHRoaXMgaXMgdXNlZCBpbiB1cHN0cmVhbSBpLk1YIGNsb2Nr
IGRyaXZlciwgZnJvbSBteSB0ZXN0LCBpdCBpcyBub3QNCj4gbmVjZXNzYXJ5IHNvIGZhci4NCj4g
DQoNCk5vcm1hbGx5IHdlIGNvdWxkIGV4cG9ydCB0aGVtIHRvZ2V0aGVyIGluIGNhc2UgaXQgd2ls
bCBiZSB1c2VkIGluIHRoZSBmdXR1cmUgYXNzdW1pbmcgeW91ciBwYXRjaA0KaXMgbWFraW5nIGNs
ay1jb21wb3NpdGUgYmUgYWJsZSB0byBiZSB1c2VkIGJ5IG1vZHVsZXMuDQoNCkFueXdheSwgaXQg
ZGVwZW5kcyBvbiBTdGVwaGVuJ3MgcHJlZmVyZW5jZS4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KIA0K
PiBBbnNvbg0K
