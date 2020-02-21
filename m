Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F5DC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA50208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cVQnwZyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgBUG4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:56:08 -0500
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:36193
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgBUG4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:56:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX4Rfq5RUMD/41HxAy8HtbfjQSwgYHMv64bAUZf6D8iT7IOPnP6NcIDQlvTJLoynXyvpixyZYEY/2Mq9shKxIAO80aZ5i72rlr/cCi/NzeN5G1ptd14otZ4C6tOraaAnEY2eI/sLMkS+9aoosHlAdLP7KImxsMTCV+Wpx7Hnxo6A2bf2IBhJ4cV+UmJO7G9jbuDwYQefT198dt2PquuW2bWRER00osG81JLCwaYdiqz5AHYQelE3IfcHMfz7q99fpoBq3IO0DJqlWxJjVM63us7RJ3TBz+ApZX5wlxeGZEUx/tIr+A8ftv25yL9lWpkODMM/cCsyQJP32x0b9yWtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCYNwBGMxy+6QRNTEjtgQiKAcWl5qkWtNmqhfbDCp6Q=;
 b=j6x24AYrFQm+PGwKX9YILpK3uTik/ivJ9eKqFANgnmcy8YzhbrEizCDS2Ns8mJfOnT3cVxPBw8x9RR/n0zZNqW0qIheeemOrEhKh6vCdTCfu6FAWQb46jNCOxTE8SFYy9B0xq6pOyJVf7lcQGs3Hidn2zURf6gTFWUvtVrOof9wi7FWjTg4jfVlorpSV4tUgj9wkSvile2N/Z2bvNoPvdypNT/QwIKRFMXpt+TiHOBKEwhFqV1yJYOo2ZAyrFhzmJitP079W2ouYfopESjUcnEzezLKKcYuGoYpzTxfhd1PgsShJHPjqeYuOXIoh30oVsis8cwvet0W1OrPUan4dPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCYNwBGMxy+6QRNTEjtgQiKAcWl5qkWtNmqhfbDCp6Q=;
 b=cVQnwZyKt1Vld3TrvBgAT8xEWbYitiyI1LYFssIDqqc4ZCRQ/HGZgaFmeVc3/18IR6bhxHIi/6Y5P7v0cmn4HxGsNlKzNfp7cLtokL0xyYAL7jY4PzkPyrop9l6Dlzi1UHS4Hzzr7LgwcI05w/7yIcOE0KkYm0moQ1rgkKPukC0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 21 Feb 2020 06:56:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 06:56:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Thread-Topic: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Thread-Index: AQHV5vbmWntOo1W/0E+zZvFdhH2I6KglOM8AgAAASJA=
Date:   Fri, 21 Feb 2020 06:56:02 +0000
Message-ID: <AM0PR04MB4481C4C811F139665AB1C54088120@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <20200221065140.mn4wxk5c2xayqwan@pengutronix.de>
In-Reply-To: <20200221065140.mn4wxk5c2xayqwan@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50cfaa3f-4088-4a62-d2f8-08d7b69b1d39
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB571580E5932F938307A8C29B88120@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(189003)(199004)(9686003)(5660300002)(33656002)(6506007)(316002)(966005)(26005)(71200400001)(54906003)(478600001)(186003)(2906002)(81156014)(81166006)(44832011)(4326008)(8676002)(8936002)(76116006)(7416002)(66446008)(64756008)(66476007)(55016002)(52536014)(66556008)(7696005)(86362001)(6916009)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwidBodEsdF0ProV8tw0DKu0PXDeHE6fyvMHrCcmlkfpAqvRwEWE3zq5i6QC+jCSu8zOe3T9aH+yt9O1q/MQHSTyoaWJreTQuC8+QkEM2/q11Fb/WsHSBEn6j/KdLV6T9h0vZ6QYiza3vrk0i9iQhuGbbbx7T/58/Q8FbyL9ok0J7Rhfw530i2+NTH/ufClD0jWQ3FcoOfLImUvTHxUVd5/WnL3sRNLmlfCKVRORDWp8VINXKn4b/pQwQfvmlI4/tXcSNdH8DAiGhmnW0rH5mBS4iEU3+WTqPlw1HAqkuEa1+o2YH9hj85NS3nRBECeqTnLKJkHswJFB32sMcOTQ6GdgsSVnl3n/eucGV3DMz3KUSmoTZsOVtWFy+1F0z7kORcuh7b1Zaio4U1kPBPQEN/1VtL0GJoF6U15cofHJOSDCNGyueZvZGRCSGYo8uzMA5nF822a8Q4Kv1sVNMQb6ix4o6uGXs2KuQak+M0ocVAl0zRoJ5gQhimmKxqsfw6NstyBG2k1HXB18H+Bubqk63A==
x-ms-exchange-antispam-messagedata: VUr1+mXj/5cNs9yaLrs8xC4gq5RO+Qnb4IQ7FY246lksWGv+e3qrrlPaF6Jlf+AhJzR0zbiJArvjSkABIVlbpabGytmNGbqqC7rGsPhbvcfLmiUul8zcdplUDNn8biMbDd93CsB3/v9k49q5IMW/+g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cfaa3f-4088-4a62-d2f8-08d7b69b1d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 06:56:02.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIDK8aUikJHRFNZXKvMxoI2cY3gc6jNHER9e78rFD++x1R8DlOp7KHwzcVwzk11ENIYL8OKmLMCbFXI7AisXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvOV0gcmVtb3RlcHJvYzogaW14
X3Jwcm9jOiBzdXBwb3J0IGkuTVg4LzhNLzdVTFANCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBpIGNh
bid0IGFwcGx5IHlvdXIgcGF0Y2hlcyBvbiBrZXJuZWwgbWFzdGVyIEhFQUQuIERvIEkgbmVlZCBz
b21lIGV4dHJhcz8NCg0KVGhlIHBhdGNoc2V0IGlzIGJhc2VkIG9uIFNoYXduJ3MgZm9yLW5leHQg
YnJhbmNoLiBXaXRoIExvaWMnIFY0IHBhdGNoDQphcHBsaWVkIGFzIHNob3dlZCBpbiBjb3Zlci1s
ZXR0ZXIuDQoNCj4gDQo+IFBsZWFzZSBhZGQgbWUgdG8gQ0MgZm9yIHRoaXMgZHJpdmVyIG5leHQg
dGltZS4NCg0KSSB1c2VkIGdldF9tYWludGFpbmVyLnBsIHRvIGdldCB0aGUgdG8vY2MgbGlzdC4g
V2lsbCBhZGQgeW91IGluIHYyLCBidXQgbWF5DQpkZWxheSBmb3IgYSB3aGlsZSwgc2luZSBlYXJs
eSBib290IHN0dWZmIG5vdCBzZXR0bGUgZG93biB1bnRpbCBub3cuDQoNClRoYW5rcywNClBlbmcu
DQoNCj4gDQo+IE9uIFdlZCwgRmViIDE5LCAyMDIwIGF0IDAzOjI3OjM2UE0gKzA4MDAsIHBlbmcu
ZmFuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4NCj4gPiBUaGlzIHBhdGNoc2V0IGFpbSB0byByZXBsYWNlIE5YUCB2ZW5kb3IgaW14X3Jw
bXNnLmMgZHJpdmVyLg0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldCBpcyB0ZXN0ZWQgd2l0aCBMb2lj
IFBBTExBUkRZJ3MgcGF0Y2gNCj4gPiAicmVtb3RlcHJvYzogYWRkIHN1cHBvcnQgZm9yIGNvLXBy
b2Nlc3NvciBsb2FkZWQgYW5kIGJvb3RlZCBiZWZvcmUNCj4ga2VybmVsIg0KPiA+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEyNjU4NjkvLA0KPiA+IGFuZCBpbnNwcmllZCBm
cm9tIHN0J3MgcmVtb3RlcHJvYyBlYXJseSBib290IHN1cHBvcnQuDQo+ID4gU2luY2UgTG9pYydz
IHBhdGNoIGlzIHN0aWxsIHVuZGVyIHJldmlldywganVzdCBleHBlY3QgeW91ciBjb21tZW50cyA6
KQ0KPiA+DQo+ID4gUGF0Y2ggWzEsMl0vOTogZHQtYmluZGluZ3MgY29udmVydCB0byBqc29uIGFu
ZCBuZXcgU29DIHN1cHBvcnQgUGF0Y2gNCj4gPiAzLzk6IHNraXAgZmlybXdhcmUgbG9hZCB3aGVu
IHJlY292ZXJ5LiBUbyBpLk1YOCwgZmlybXdhcmUgaXMgbm90DQo+ID4gICAgICAgICAgICBoYW5k
bGVkIGJ5IExpbnV4Lg0KPiA+DQo+ID4gUGF0Y2ggWzQtOV0vOTogaS5NWCBzcGVjaWZpYyBwYXJ0
IHRvIHN1cHBvcnQgcnBtc2cvdmlydGlvIHdpdGggbWJveC4NCj4gPiAgICAgICBiZWNhdXNlIE5Y
UCByZWxlYXNlIGltYWdlIG5vdCBoYXZlIHJlc291cmUgdGFibGUsIHNvIGFkZCByZXNvdXJjZQ0K
PiA+ICAgICAgIHRhYmxlIGluIGR0cw0KPiA+DQo+ID4gTXkgdGVzdCBkdHMgZGlmZiBmb3IgaS5N
WDhRWFAgTUVLLCBidXQgSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoc2V0IGZvcg0KPiA+IGkuTVg4
UVhQIE1FSywgaS5NWDhNTSBFVkssIGkuTVg3VUxQIEVWSzoNCj4gPg0KPiA+ICsNCj4gPiArCWlt
eDh4LWNtNCB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1jbTQiOw0KPiA+ICsJ
CXJzcmMtdGFibGUgPSA8DQo+ID4gKwkJCTB4MSAweDIgMHgwIDB4MCAweDE4IDB4NWMNCj4gPiAr
CQkJMw0KPiA+ICsJCQkvKmZ3X3JzY192ZGV2Ki8NCj4gPiArCQkJNyAwIDEgMCAwIDB4MjAwDQo+
ID4gKwkJCS8qZndfcnNjX3ZkZXZfdnJpbmcqLw0KPiA+ICsJCQkweDkwMDAwMDAwIDQwOTYgMjU2
IDEgMA0KPiA+ICsJCQkweDkwMDA4MDAwIDQwOTYgMjU2IDIgMA0KPiA+ICsJCQkzDQo+ID4gKwkJ
CS8qZndfcnNjX3ZkZXYqLw0KPiA+ICsJCQk3IDEgMSAwIDAgMHgyMDANCj4gPiArCQkJLypmd19y
c2NfdmRldl92cmluZyovDQo+ID4gKwkJCTB4OTAwMTAwMDAgNDA5NiAyNTYgMSAwDQo+ID4gKwkJ
CTB4OTAwMTgwMDAgNDA5NiAyNTYgMiAwDQo+ID4gKwkJPjsNCj4gPiArCQllYXJseS1ib290ZWQ7
DQo+ID4gKwkJbWJveC1uYW1lcyA9ICJ0eCIsICJyeCIsICJyeGRiIjsNCj4gPiArCQltYm94ZXMg
PSA8JmxzaW9fbXU1IDAgMQ0KPiA+ICsJCQkgICZsc2lvX211NSAxIDENCj4gPiArCQkJICAmbHNp
b19tdTUgMyAxPjsNCj4gPiArCQltdWItcGFydGl0aW9uID0gPDM+Ow0KPiA+ICsJCW1lbW9yeS1y
ZWdpb24gPSA8JnZkZXYwdnJpbmcwPiwgPCZ2ZGV2MHZyaW5nMT4sDQo+IDwmdmRldjBidWZmZXI+
LA0KPiA+ICsJCQkJPCZ2ZGV2MXZyaW5nMD4sIDwmdmRldjF2cmluZzE+LCA8JnZkZXYwYnVmZmVy
PjsNCj4gPiArCX07DQo+ID4gKw0KPiA+ICsJcmVzZXJ2ZWQtbWVtb3J5IHsNCj4gPiArCQkjYWRk
cmVzcy1jZWxscyA9IDwyPjsNCj4gPiArCQkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArCQlyYW5n
ZXM7DQo+ID4gKw0KPiA+ICsJCXZkZXYwdnJpbmcwOiB2ZGV2MHZyaW5nMEA5MDAwMDAwMCB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wi
Ow0KPiA+ICsJCQlyZWcgPSA8MCAweDkwMDAwMDAwIDAgMHg4MDAwPjsNCj4gPiArCQkJbm8tbWFw
Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZkZXYwdnJpbmcxOiB2ZGV2MHZyaW5nMUA5MDAw
ODAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaGFyZWQt
ZG1hLXBvb2wiOw0KPiA+ICsJCQlyZWcgPSA8MCAweDkwMDA4MDAwIDAgMHg4MDAwPjsNCj4gPiAr
CQkJbm8tbWFwOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZkZXYxdnJpbmcwOiB2ZGV2MXZy
aW5nMEA5MDAxMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJzaGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsJCQlyZWcgPSA8MCAweDkwMDEwMDAwIDAgMHg4MDAw
PjsNCj4gPiArCQkJbm8tbWFwOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZkZXYxdnJpbmcx
OiB2ZGV2MXZyaW5nMUA5MDAxODAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsJCQlyZWcgPSA8MCAweDkwMDE4MDAw
IDAgMHg4MDAwPjsNCj4gPiArCQkJbm8tbWFwOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZk
ZXYwYnVmZmVyOiB2ZGV2MGJ1ZmZlciB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJzaGFyZWQtZG1hLXBvb2wiOw0KPiA+ICsJCQlyZWcgPSA8MCAweDkwNDAwMDAw
IDAgMHgxMDAwMDA+Ow0KPiA+ICsJCQluby1tYXA7DQo+ID4gKwkJfTsNCj4gPiArCX07DQo+ID4g
Kw0KPiA+DQo+ID4gUGVuZyBGYW4gKDkpOg0KPiA+ICAgZHQtYmluZGluZ3M6IHJlbW90ZXByb2M6
IENvbnZlcnQgaW14LXJwcm9jIHRvIGpzb24tc2NoZW1hDQo+ID4gICBkdC1iaW5kaW5nczogcmVt
b3RlcHJvYzogaW14LXJwcm9jOiBzdXBwb3J0IGkuTVhbOCw4TSw3VUxQXQ0KPiA+ICAgcmVtb3Rl
cHJvYzogYWRkIHN1cHBvcnQgdG8gc2tpcCBmaXJtd2FyZSBsb2FkIHdoZW4gcmVjb3ZlcnkNCj4g
PiAgIHJlbW90ZXByb2M6IGlteF9ycHJvYzogc3VycG9ydCBlYXJseSBib290ZWQgcmVtb3RlIHBy
b2Nlc3Nvcg0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBwYXJzZSBlYXJseS1ib290ZWQg
cHJvcGVydHkNCj4gPiAgIHJlbW90ZXByb2M6IGlteF9wcm9jOiBlbmFibGUgdmlydGlvL21haWxi
b3gNCj4gPiAgIHJlbW90ZXByb2M6IGlteF9ycHJvYzogYWRkIGkuTVg4UU0vUVhQDQo+ID4gICBy
ZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBvcnQgaS5NWDdVTFANCj4gPiAgIHJlbW90ZXByb2M6
IGlteF9ycHJvYzogYWRkIGkuTVg4TU0gc3VwcG9ydA0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3JlbW90ZXByb2MvaW14LXJwcm9jLnR4dCAgIHwgIDMzIC0tDQo+ID4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvaW14LXJwcm9jLnlhbWwgIHwgIDk1ICsrKysr
DQo+ID4gIGRyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYyAgICAgICAgICAgICAgICAgICAg
IHwgNDU1DQo+ICsrKysrKysrKysrKysrKysrKystLQ0KPiA+ICBkcml2ZXJzL3JlbW90ZXByb2Mv
cmVtb3RlcHJvY19jb3JlLmMgICAgICAgICAgICAgICB8ICAxOSArLQ0KPiA+ICBpbmNsdWRlL2xp
bnV4L3JlbW90ZXByb2MuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIDUg
ZmlsZXMgY2hhbmdlZCwgNTMxIGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKSAgZGVsZXRl
IG1vZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90
ZXByb2MvaW14LXJwcm9jLnR4dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9pbXgtcnByb2MueWFtbA0KPiA+
DQo+ID4gLS0NCj4gPiAyLjE2LjQNCj4gPg0KPiA+DQo+ID4NCj4gDQo+IC0tDQo+IFBlbmd1dHJv
bml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+IHwNCj4gU3RldWVyd2FsZGVy
IFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gaHR0cDovL3d3dy5wZW5ndXRyb25p
eC5kZS8gIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwg
UGhvbmU6DQo+ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVp
bSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo=
