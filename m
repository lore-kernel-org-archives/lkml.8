Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB153C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0520663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mCn2bYSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQBpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:45:14 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:41686
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgCQBpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD0Xpsy4OhE7/CyIklzMVJhdU2AgoIym9mGGJMAY01f5NCBt7b7AO0+ivqGOeKyBdQBNCE0Hsad9ApQnZdrB9GId7KVfy0FxwniNNaHD0OZ3sECwY9pzyWpFfwmCeaETqorOVV1qf1rDXF2BLmKBrLsLLvkYOhxRcgM/Cr/2zsgYEhCxHqWz1vHDF5NdLeaeK3Ds0LeAHuTymUX4hDOAEqwgBeszz9RPJMxhFtP6olK9cxJX1qjXXHMs5XWn9V+91yg+GTyMUzPzIcAyOm8jB+Xe+BlcEUnnwwckqXbx2bNbI2zbnqEOB8SwM7PQsn9Rtds+6gdtr+AYq9jPUHVCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW3+Odaf1iLEWM8kf5EuD3yQ7/qEMdSYqWfQUdRU1xQ=;
 b=lb2s3z6LBPLNhxYY0uiLJNZbbZ3dtGQSOitQ0xMBl1/eid5y3fH4Yq+mKqFIjpPD8py6wsV77i7JLD9CRxzDyJCLUCb5kadyMSRKxfEDtyBFEvYH7y8qWvf7MDr2mL2LVIoQLcbwMw/BSEHGgP/no0YgmiZB7dsGuMd8F+h/BARYiPnYIEXY7c9tTgfAVffrdI/R8ZcCMxI3s4tCnBcLNxNVH6rIBkaOv6DeGOvdKOk1DNHarKDNz23zvELT4a72Qx1sXXQtXesyGuFgSfO0F9/qFQZt+jh0lh93l1VSRQi+0l+WgyRZy0fcwIFSCJrHAYEriKIQniJuF1QPOaXaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW3+Odaf1iLEWM8kf5EuD3yQ7/qEMdSYqWfQUdRU1xQ=;
 b=mCn2bYSIv0mrR4ezVFon1in31+uj6Yfa0mKGKphRtPAPobwZH9r2s3kKwKfFk/rB1bWxqM1ruoTZwX+sbs8lcRn40vKXEc8oRUdIqDY4c16PnsIE9XNnIh0UKNwgTUxd6ZNmx5hS1neM41rJ5Ip+2DcrvlNMw6tR2yBC6y0fKk8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5124.eurprd04.prod.outlook.com (20.177.40.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 17 Mar 2020 01:44:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 01:44:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: Makefile: build arm64 device tree
Thread-Topic: [PATCH] ARM: dts: Makefile: build arm64 device tree
Thread-Index: AQHV+OjclUu1XSl6U0KqPUg7uT17oKhGURQAgAAk21CABZMmQA==
Date:   Tue, 17 Mar 2020 01:44:30 +0000
Message-ID: <AM0PR04MB44812054118E892BEFFACD7F88F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1584070314-26495-1-git-send-email-peng.fan@nxp.com>
 <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
 <AM0PR04MB4481CD81915F8A9FB115A97788FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481CD81915F8A9FB115A97788FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 149ca1ee-b85e-48e9-6cd8-08d7ca14bc57
x-ms-traffictypediagnostic: AM0PR04MB5124:|AM0PR04MB5124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5124F5176D52F8278EE9A31788F60@AM0PR04MB5124.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(71200400001)(9686003)(6916009)(8936002)(33656002)(26005)(8676002)(81156014)(186003)(4326008)(54906003)(55016002)(53546011)(86362001)(6506007)(81166006)(44832011)(316002)(7696005)(66446008)(66476007)(66556008)(64756008)(66946007)(76116006)(5660300002)(52536014)(2906002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5124;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBCaNNAGI8LNLNXbIhTgCPf7d+UJVyUAyWPYk6n/3Hq7cSAegzf80yUOFhwaJKQQZjco5iwKql1GzL3tsK0ZXvDTBlqFWZx8eIAG87j81u0gT2jEbXELYcEFln87jfspYR2aT+nVn/9XWN0pzw00zQ5Zu69gwIOW+1Qd+hpOTabs9s42WcqEF0guWa1awRdMJ7urYbhznGaOrAjUzfQXlIKmv1z9zcZ0porOk5/lfaaLmmDtc+A1eN8Z3KP0pGr0on8WACDYDMRnHcXBrnomTMvJTpmTjlnwffarNBLID0PmaVKSZoN201HtEdNcnqTxFZlZQoje7n2byQERvHfi+4FVQi6l4bLVAm4IjlPo32Te5QW8GE6+HeZPhb6/ohakLTpyKLzjghIvnCBvoGXBUxPmZu2sdMZxrkQSRzlXmgEvM+scfF601p+K6Zn4js5L
x-ms-exchange-antispam-messagedata: 9jVoL6gT8AD84g13+gp2DPhVjhKI7fucVXXk6GxVksI9Z1yxOf+1zZ7K/KWvag2/s4DTvOw8mAApkphh4j6Vqv5cUOp6Wvpf4AHZqYSJdpTKJgYxNlvGT5WhwRDTcz38CCTMi3JVmGzg81cYtz2X+g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149ca1ee-b85e-48e9-6cd8-08d7ca14bc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 01:44:30.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhxjnV6Qy3VPG2CavLjkSM1F1uZ1forFR0DHad3InXR017HXLoMuH5ghv2veIKnHbTa5ptxRq58OxM5E1eKRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBBUk06IGR0czogTWFrZWZpbGU6IGJ1
aWxkIGFybTY0IGRldmljZSB0cmVlDQo+IA0KPiBIaSBBcm5kLA0KPiANCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBBUk06IGR0czogTWFrZWZpbGU6IGJ1aWxkIGFybTY0IGRldmljZSB0cmVlDQo+
ID4NCj4gPiBPbiBGcmksIE1hciAxMywgMjAyMCBhdCA0OjM4IEFNIDxwZW5nLmZhbkBueHAuY29t
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPiA+DQo+ID4gPiBUbyBzdXBwb3J0IGFhcmNoMzIgbW9kZSBsaW51eCBvbiBhYXJjaDY0IGhh
cmR3YXJlLCB3ZSBuZWVkIGJ1aWxkIHRoZQ0KPiA+ID4gZGV2aWNlIHRyZWUsIHNvIGluY2x1ZGUg
dGhlIGFybTY0IGRldmljZSB0cmVlIHBhdGguDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPg0KPiA+IFRoZXJlIGFy
ZSBhIGZldyBvdGhlciBwbGF0Zm9ybXMgd2l0aCBzaW1pbGFyIHJlcXVpcmVtZW50cywgaW4NCj4g
PiBwYXJ0aWN1bGFyIGJjbTI4MzcsIHNvIG1heWJlIHRyeSBkb2luZyBpdCB0aGUgc2FtZSB3YXkg
dGhleSBkbywgc2VlDQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9icm9hZGNvbS9iY20yODM3LXJw
aS0zLWIuZHRzDQo+ID4NCj4gPiA+IFYxOg0KPiA+ID4gIFRoaXMgaXMganVzdCB0aGUgZGV2aWNl
IHRyZWUgcGFydC4gQmVzaWRlcyB0aGlzLCAgSSBhbSBub3Qgc3VyZQ0KPiA+ID4gd2hldGhlciBu
ZWVkIHRvIGNyZWF0ZSBhIHN0YW5kYWxvbmUgZGVmY29uZmlnIHVuZGVyIGFybTMyICBmb3INCj4g
PiA+IGFhcmNoMzIgbW9kZSBsaW51eCBvbiBhYXJjaDY0IGhhcmR3YXJlLCBvciB1c2UgbXVsdGlf
djdfZGVmY29uZmlnLg0KPiA+ID4gIG11bHRpX3Y3X2RlZmNvbmZpZyBzaG91bGQgYmUgb2ssIG5l
ZWQgdG8gaW5jbHVkZSBMUEFFIGNvbmZpZy4NCj4gPg0KPiA+IEknZCByYXRoZXIgbm90IGhhdmUg
YSBzdGFuZGFsb25lIGRlZmNvbmZpZyBmb3IgaXQsIGdpdmVuIHRoYXQgd2UgaGF2ZQ0KPiA+IGEg
c2luZ2xlIGRlZmNvbmZpZyBmb3IgYWxsIGFybXY2L2FybXY3L2FybXY3aGYgaS5teCBtYWNoaW5l
cy4NCj4gPg0KPiA+IFRoZXJlIHdhcyBhIHN1Z2dlc3Rpb24gdG8gdXNlIGEgZnJhZ21lbnQgZm9y
IGVuYWJsaW5nIGFuIExQQUUNCj4gPiBtdWx0aV92N19kZWZjb25maWcgcmVjZW50bHksIHdoaWNo
IEkgdGhpbmsgaXMgc3RpbGwgdW5kZXIgZGlzY3Vzc2lvbg0KPiA+IGJ1dCBzaG91bGQgYWxzbyBo
ZWxwIGhlcmUsIGJvdGggd2l0aCBpbXhfdjZfdjdfZGVmY29uZmlnIGFuZA0KPiBtdWx0aV92N19k
ZWZjb25maWcuDQo+ID4NCj4gPiBDYW4geW91IHJlbWluZCB1cyB3aHkgdGhpcyBwbGF0Zm9ybSBu
ZWVkcyBMUEFFPyBJcyBpdCBvbmx5IG5lZWRlZCB0bw0KPiA+IHN1cHBvcnQgbW9yZSB0aGFuIDRH
QiBvZiBSQU0sIG9yIHNvbWV0aGluZyBlbHNlIG9uIHRvcCBvZiB0aGF0Pw0KPiANCj4gQ3VycmVu
dGx5IEkgb25seSB0ZXN0ZWQgTFBBRSBlbmFibGVkIGFybTMyIGtlcm5lbCwgSSdsbCBnaXZlIGEg
dHJ5IHdpdGggTFBBRQ0KPiBkaXNhYmxlZCBsYXRlci4NCg0KVGVzdGVkIHdpdGggaW14X3Y2X3Y3
X2RlZmNvbmZpZyB3aXRob3V0IExQQUUsIHNtcCBib290cyB1cCB3aXRoIG5mc3Jvb3QuDQoNClRo
YW5rcywNClBlbmcuDQoNCj4gDQo+IFRoYW5rcywNCj4gUGVuZy4NCj4gPiBOb3RlIHRoYXQgdXNl
cnMgdGhhdCBhY3R1YWxseSBoYXZlIDRHQiBvciBtb3JlIG9uIGkubXg4IHNob3VsZCByZWFsbHkN
Cj4gPiBydW4gYSA2NC1iaXQga2VybmVsIGFueXdheSwgZXZlbiBpZiB0aGV5IHByZWZlciB1c2lu
ZyAzMi1iaXQgdXNlciBzcGFjZS4NCj4gPg0KPiA+IFR1cm5pbmcgb24gTFBBRSBub3Qgb25seSBk
aXNhYmxlcyBpbXgzIGFuZCBpbXg1IGJ1dCBhbHNvIHRoZSBDb3J0ZXgtQTkNCj4gPiBiYXNlZA0K
PiA+IGlteDYgdmFyaWFudHMuDQo+ID4NCj4gPiAgICAgICBBcm5kDQo=
