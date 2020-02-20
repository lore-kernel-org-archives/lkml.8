Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A78C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157182465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APw4/xWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgBTBgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:36:14 -0500
Received: from mail-vi1eur05on2082.outbound.protection.outlook.com ([40.107.21.82]:1236
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbgBTBgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpMq8G7ISPcvrb6LHrlp0phnoiIjj3H57QwZmmeNLCY+zERKg7IfEMqzJk9uJvIK2hNwA1Li/Mbh9Lgz9UEguj1bzYzGvaJ2lLOIYJHQ6rLLODuGTwwL5PUjTPaeA0c9KWXkDAbWg9UDuuC7RgukOAkZ1lya3SdHY0LYvHnJZZ/gifQhv9DOz4Rf5godJh/dX8bk/NxsOTCLjmU9lpDNfjTvUa1YR+MK0gBK1GhpdUH13CJc6OxJU37PsZQOJl1RnkW+g+RVr2RxS6WdGDtUIP6vZNyz68AtJW7FLHGJtQWSi3/fvD5VzSKAmEgy8FU6M2ABCMNWpw3CIigao339hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d81qYE9zzKV1wCeMOjt64gzr6BVwufA9LzoTTfcT/Ww=;
 b=gSZ+eVSwy1YLQQ92QpRBbJVnHgPMCQCfmZG35TY5RVZP8kRR7EIyXdKMKLHqR2gU2fZCI4zLVxVBqnptvNJU0O7QNBluzbCUN6RIr5a7QoJI6QRPqtlp1BDocThP59qlRlSXqvNrSPGTsZr+HOxfhGjoNfNnswqNcxu3AHnQ8q0avjehZADT2xFmErom40sOlVv4MaD46+34Ywvw8TAxdM3khm2Fw9axmJn+iX43Mp3cXsXZuRESVXSZpC9XOiV0HO2U++9oMRJWiW4Ah9U4NE/LUT/6VLdJR0niaMUYP4s+EvZTanQL3ewVAO8VkUmVxZY5jKud66K+3yW6KyFNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d81qYE9zzKV1wCeMOjt64gzr6BVwufA9LzoTTfcT/Ww=;
 b=APw4/xWaWPOPxGfuv6qdyizbw75gdSDWmFzkbc8Mx8Q2pzWJJDff6gr1dJjBwbehBCjKoPD3ABHGjqPRkoySRk/iP0n/pxkPm9SpoPlz86iMzDX5Iu1jyqZlaK4vMjY3chJvyMwY7Bt+hIT1rwnrkCxDfYE5RubQ3kkNlPxaphw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7105.eurprd04.prod.outlook.com (10.186.130.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 01:36:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 01:36:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Thread-Topic: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Thread-Index: AQHV5vbmWntOo1W/0E+zZvFdhH2I6Kgi1bgAgAB3WRA=
Date:   Thu, 20 Feb 2020 01:36:08 +0000
Message-ID: <AM0PR04MB448114DF702180D0CF0553A688130@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <CANLsYkzeAyGhYqewGaHfd-myW5EzE83WUOwAbKwTP-34pbUR-w@mail.gmail.com>
In-Reply-To: <CANLsYkzeAyGhYqewGaHfd-myW5EzE83WUOwAbKwTP-34pbUR-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbd73047-1f8a-4862-41eb-08d7b5a54273
x-ms-traffictypediagnostic: AM0PR04MB7105:|AM0PR04MB7105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB71050B28F76D772BEFE73E7788130@AM0PR04MB7105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(9686003)(186003)(66946007)(316002)(52536014)(76116006)(966005)(86362001)(44832011)(5660300002)(55016002)(33656002)(71200400001)(6506007)(8936002)(54906003)(2906002)(8676002)(81156014)(81166006)(64756008)(4326008)(26005)(6916009)(66446008)(7416002)(45080400002)(66476007)(66556008)(478600001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7105;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uV8N8pFAuxcSjz/a3+8/DTE6NE6FHgpPIzZfxoAHmM8ZGzgOTicnRWVvJAAKRDUrUxIloAMpwoj0feL8oMFqd/hc6dbf8ytpL5MDEx3UQSPyFpIKg6oVakc26Ww9iP2uRI2PARxCeWAbIQfGCELaWB/WhFzqON+3LGyHcgYJyIf9sK2NQgIlBhRNmVnOMtW1maGu1y4gs1plLya+oTDTJY66ui97yQbyTLrnw94Vo5MBpcOmFcO2Qkk8Q2b4vvYcOwjcQVk0phWRNjmQBRF10aRRyvINIC4+d2fe2jEIKFxMbMSuXlmVI5cQ5c02yE3fQtYtxK9cCqeNh0HZhecJKrl44uy3H5pHoH+L2bac0nFme4VohRle9FCOYBHuv+TOOE5mqaZEGiSGaqQ9ns2+CfhMfmludP2npaoWo81qBlSsca2KsZjb0AxCojBSTdqSef9zhk7Qm5whXXGMxhEa6OPcv8VvAvLozl7zCnG3Sgd+oB70UTLLuJgmIfcrMQk5/Pszi5rFiPCzgc4BYY0s5iAmMtqPqXLKd+J5+RJIqEnN46NDCSaTOWMQhMGVAqis3tI0yFM1fgjj4cJVGU8/GT4n18mzKlrYBkMVbY8JNIP7MpCBZuXd8/qWnWBqa8Qn
x-ms-exchange-antispam-messagedata: fE9nh/imgTYaI3GmvN0ugpIDWiUp1hSdeYRUIdrazDb1cCG53w+jDL/zvujj3MQFdhpWd/BCZJMyjdLBsiZgsLWM+0R4JUskolrF0wwjRYqj2Oa3LmyB82JD9Df3Z2vcXyWkI3OcLY2X2RsMgAL1/Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd73047-1f8a-4862-41eb-08d7b5a54273
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 01:36:08.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhgf2oThR0nCEOtqhzhkt/oa/J25ZaQBtUbgvWAotYRX3kEPsvtjRMHFFZk6Kq8brKhqpnpBw24AIl7Z32tBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvOV0gcmVtb3RlcHJvYzogaW14
X3Jwcm9jOiBzdXBwb3J0IGkuTVg4LzhNLzdVTFANCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBX
ZWQsIDE5IEZlYiAyMDIwIGF0IDAwOjMzLCA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2hzZXQgYWltIHRvIHJlcGxhY2UgTlhQIHZlbmRvciBpbXhfcnBtc2cuYyBkcml2ZXIuDQo+IA0K
PiBZb3UgbWVhbiByZW1vdGVwcm9jL2lteF9ycHJvYy5jID8gIFVwc3RyZWFtIHJwbXNnL2lteF9y
cG1zZy5jIGRvZXNuJ3QNCj4gZXhpc3QuDQoNCmlteF9ycG1zZy5jIG9ubHkgaW4gTlhQIHZlbmRv
ciB0cmVlLiBUaGlzIHBhY2hzZXQgaXMgdG8gdXNlIGlteF9ycHJvYy5jIGZvcg0KcnBtc2cvdmly
dGlvIGZ1bmN0aW9ucyBmb3IgaS5NWCBTb0MuDQoNCj4gDQo+ID4NCj4gPiBUaGlzIHBhdGNoc2V0
IGlzIHRlc3RlZCB3aXRoIExvaWMgUEFMTEFSRFkncyBwYXRjaA0KPiA+ICJyZW1vdGVwcm9jOiBh
ZGQgc3VwcG9ydCBmb3IgY28tcHJvY2Vzc29yIGxvYWRlZCBhbmQgYm9vdGVkIGJlZm9yZQ0KPiBr
ZXJuZWwiDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiA+DQo+IGh3b3JrLmtlcm5lbC5vcmclMkZwYXRj
aCUyRjExMjY1ODY5JTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZW5nLmYNCj4gYW4lNDBuDQo+ID4N
Cj4geHAuY29tJTdDZTFjYjE5ZTUzNWExNGI2M2QwZGEwOGQ3YjU2OGZkNTYlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkNCj4gMmNkOTljNWMNCj4gPg0KPiAzMDE2MzUlN0MwJTdDMCU3QzYzNzE3NzMzNDgz
OTQ5NzgzMiZhbXA7c2RhdGE9YUtRJTJCdWxjbzYzYmENCj4gWVQlMkJEWkRrMA0KPiA+IFZMdDFO
cGtOdWhyWTNzc3hpUkNPY3JNJTNEJmFtcDtyZXNlcnZlZD0wLA0KPiA+IGFuZCBpbnNwcmllZCBm
cm9tIHN0J3MgcmVtb3RlcHJvYyBlYXJseSBib290IHN1cHBvcnQuDQo+ID4gU2luY2UgTG9pYydz
IHBhdGNoIGlzIHN0aWxsIHVuZGVyIHJldmlldywganVzdCBleHBlY3QgeW91ciBjb21tZW50cyA6
KQ0KPiANCj4gRGlkIHlvdSBiYXNlIHlvdXIgd29yayBvbiB0b3Agb2YgTG9pYydzIGJlY2F1c2Ug
eW91ciBNQ1UgZmlybXdhcmUgaXMgYWx3YXlzDQo+IGxvYWRlZCBieSB0aGUgYm9vdGxvYWRlcj8g
DQoNCkkgb25seSB0b29rIExvaWMncyBlYXJseS1ib290IHBhdGNoIGFzIGJhc2UgYW5kIGFwcGx5
IG15IHBhdGNoc2V0Lg0KDQpUaGUgbWN1IGZpcm13YXJlIGN1cnJlbnRseSBvbmx5IGxvYWRlZCBi
eSBib290bG9hZGVyIG9yIHN5c3RlbSBjb250cm9sbGVyIGZpcm13YXJlLg0KTlhQIHJlbGVhc2Vk
IG1jdSBmaXJtd2FyZSBub3Qgc3VwcG9ydCBiZWluZyBsb2FkZWQgYnkgTGludXggcmVtb3RlcHJv
Yy4NCg0KIElmIG5vdCBwbGVhc2Ugc2VuZCBhbm90aGVyIHJldmlzaW9uIG9mIHlvdXIgd29yaw0K
PiB3aXRob3V0IGVhcmx5IGJvb3Qgc3VwcG9ydC4gIFdoZW4gd2UgaGF2ZSBhIGNsZWFyIHZpZXcg
b24gaG93IHRvIHByb2NlZWQNCj4gd2l0aCB0aGUgZWFybHkgYm9vdCBzdXBwb3J0IHlvdSBjYW4g
c2VuZCBhbm90aGVyIHNldCB0byBlbmFibGUgdGhhdC4NCg0KSSdsbCB3YWl0IHlvdXIgbmV3IHBh
dGNoIGZvciBlYXJseSBib290IGluIHJlbW90ZXByb2MtY29yZS4gVGhlbiBJJ2xsIHJlYmFzZQ0K
YW5kIHNlbmQgYSBuZXcgdmVyc2lvbi4gU2luY2UgSSBpbnRyb2R1Y2UgYmlnIGNoYW5nZXMgdG8g
aW14X3Jwcm9jLmMsIHNvDQpJJ2xsIHNlZSB3aGV0aGVyIGFueSBjb21tZW50cyB0aGVyZS4NCg0K
VGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBNYXRoaWV1DQo+IA0KPiA+DQo+ID4g
UGF0Y2ggWzEsMl0vOTogZHQtYmluZGluZ3MgY29udmVydCB0byBqc29uIGFuZCBuZXcgU29DIHN1
cHBvcnQgUGF0Y2gNCj4gPiAzLzk6IHNraXAgZmlybXdhcmUgbG9hZCB3aGVuIHJlY292ZXJ5LiBU
byBpLk1YOCwgZmlybXdhcmUgaXMgbm90DQo+ID4gICAgICAgICAgICBoYW5kbGVkIGJ5IExpbnV4
Lg0KPiA+DQo+ID4gUGF0Y2ggWzQtOV0vOTogaS5NWCBzcGVjaWZpYyBwYXJ0IHRvIHN1cHBvcnQg
cnBtc2cvdmlydGlvIHdpdGggbWJveC4NCj4gPiAgICAgICBiZWNhdXNlIE5YUCByZWxlYXNlIGlt
YWdlIG5vdCBoYXZlIHJlc291cmUgdGFibGUsIHNvIGFkZCByZXNvdXJjZQ0KPiA+ICAgICAgIHRh
YmxlIGluIGR0cw0KPiA+DQo+ID4gTXkgdGVzdCBkdHMgZGlmZiBmb3IgaS5NWDhRWFAgTUVLLCBi
dXQgSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoc2V0IGZvcg0KPiA+IGkuTVg4UVhQIE1FSywgaS5N
WDhNTSBFVkssIGkuTVg3VUxQIEVWSzoNCj4gPg0KPiA+ICsNCj4gPiArICAgICAgIGlteDh4LWNt
NCB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtY200IjsN
Cj4gPiArICAgICAgICAgICAgICAgcnNyYy10YWJsZSA9IDwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAweDEgMHgyIDB4MCAweDAgMHgxOCAweDVjDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgMw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qZndfcnNjX3ZkZXYqLw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIDcgMCAxIDAgMCAweDIwMA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIC8qZndfcnNjX3ZkZXZfdnJpbmcqLw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIDB4OTAwMDAwMDAgNDA5NiAyNTYgMSAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgMHg5MDAwODAwMCA0MDk2IDI1NiAyIDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAz
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLypmd19yc2NfdmRldiovDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgNyAxIDEgMCAwIDB4MjAwDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgLypmd19yc2NfdmRldl92cmluZyovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
MHg5MDAxMDAwMCA0MDk2IDI1NiAxIDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAweDkw
MDE4MDAwIDQwOTYgMjU2IDIgMA0KPiA+ICsgICAgICAgICAgICAgICA+Ow0KPiA+ICsgICAgICAg
ICAgICAgICBlYXJseS1ib290ZWQ7DQo+ID4gKyAgICAgICAgICAgICAgIG1ib3gtbmFtZXMgPSAi
dHgiLCAicngiLCAicnhkYiI7DQo+ID4gKyAgICAgICAgICAgICAgIG1ib3hlcyA9IDwmbHNpb19t
dTUgMCAxDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAmbHNpb19tdTUgMSAxDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAmbHNpb19tdTUgMyAxPjsNCj4gPiArICAgICAgICAg
ICAgICAgbXViLXBhcnRpdGlvbiA9IDwzPjsNCj4gPiArICAgICAgICAgICAgICAgbWVtb3J5LXJl
Z2lvbiA9IDwmdmRldjB2cmluZzA+LCA8JnZkZXYwdnJpbmcxPiwNCj4gPCZ2ZGV2MGJ1ZmZlcj4s
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnZkZXYxdnJpbmcwPiwgPCZ2
ZGV2MXZyaW5nMT4sDQo+IDwmdmRldjBidWZmZXI+Ow0KPiA+ICsgICAgICAgfTsNCj4gPiArDQo+
ID4gKyAgICAgICByZXNlcnZlZC1tZW1vcnkgew0KPiA+ICsgICAgICAgICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+
ID4gKyAgICAgICAgICAgICAgIHJhbmdlczsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHZk
ZXYwdnJpbmcwOiB2ZGV2MHZyaW5nMEA5MDAwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJlZyA9IDwwIDB4OTAwMDAwMDAgMCAweDgwMDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIG5vLW1hcDsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICAgIHZkZXYwdnJpbmcxOiB2ZGV2MHZyaW5nMUA5MDAwODAwMCB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4OTAwMDgwMDAgMCAweDgwMDA+
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG5vLW1hcDsNCj4gPiArICAgICAgICAgICAg
ICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHZkZXYxdnJpbmcwOiB2ZGV2MXZyaW5n
MEA5MDAxMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJz
aGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4
OTAwMTAwMDAgMCAweDgwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG5vLW1hcDsN
Cj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHZkZXYx
dnJpbmcxOiB2ZGV2MXZyaW5nMUA5MDAxODAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJlZyA9IDwwIDB4OTAwMTgwMDAgMCAweDgwMDA+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIG5vLW1hcDsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIHZkZXYwYnVmZmVyOiB2ZGV2MGJ1ZmZlciB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4OTA0MDAwMDAgMCAweDEwMDAwMD47DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+
ICsgICAgICAgfTsNCj4gPiArDQo+ID4NCj4gPiBQZW5nIEZhbiAoOSk6DQo+ID4gICBkdC1iaW5k
aW5nczogcmVtb3RlcHJvYzogQ29udmVydCBpbXgtcnByb2MgdG8ganNvbi1zY2hlbWENCj4gPiAg
IGR0LWJpbmRpbmdzOiByZW1vdGVwcm9jOiBpbXgtcnByb2M6IHN1cHBvcnQgaS5NWFs4LDhNLDdV
TFBdDQo+ID4gICByZW1vdGVwcm9jOiBhZGQgc3VwcG9ydCB0byBza2lwIGZpcm13YXJlIGxvYWQg
d2hlbiByZWNvdmVyeQ0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBzdXJwb3J0IGVhcmx5
IGJvb3RlZCByZW1vdGUgcHJvY2Vzc29yDQo+ID4gICByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHBh
cnNlIGVhcmx5LWJvb3RlZCBwcm9wZXJ0eQ0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Byb2M6IGVu
YWJsZSB2aXJ0aW8vbWFpbGJveA0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBhZGQgaS5N
WDhRTS9RWFANCj4gPiAgIHJlbW90ZXByb2M6IGlteF9ycHJvYzogc3VwcG9ydCBpLk1YN1VMUA0K
PiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBhZGQgaS5NWDhNTSBzdXBwb3J0DQo+ID4NCj4g
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9pbXgtcnByb2MudHh0ICAgfCAg
MzMgLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9pbXgtcnByb2Mu
eWFtbCAgfCAgOTUgKysrKysNCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jICAg
ICAgICAgICAgICAgICAgICAgfCA0NTUNCj4gKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGRy
aXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYyAgICAgICAgICAgICAgIHwgIDE5ICst
DQo+ID4gIGluY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAxICsNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA1MzEgaW5zZXJ0aW9ucygrKSwgNzIgZGVs
ZXRpb25zKC0pICBkZWxldGUgbW9kZQ0KPiA+IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9pbXgtcnByb2MudHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL2lt
eC1ycHJvYy55YW1sDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQo=
