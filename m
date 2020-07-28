Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B893EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4320786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRCbNKcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgG1Jgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:36:36 -0400
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:43650
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728199AbgG1Jgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCaV3uP2aWdlctHnasOUVh9uQ4DcCEKD+z3AIGyrRGJTL/vEMQxisZkFWaJmj5I1Hj2MfZA6dAXmbhu9VnZnvCu9VHvlLtyan8FOqqULvNfz27DxsHpa7CgiwntCwoclCbBQJIFAyG+5bA4p4+mKZBnRsX7MfTHi9YR7YU9SO67eRiEdZM+aN5u+D98maJEcL0A1hrfL6D1LmRMe/9y9b9hxhy0eQCMp14w+eAptn7c8Rh59iXoeMiBtSy6oRtFFSAKnz6vf9yehrpQvK4RvUJoO+YIxdchCB/bk9Rj7kbZlMw0O2nTWJpP8qCIbEukwGPl/uGo0Q5kfKMZXpCVuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOr4JTVekaWYini6xYceK0+d8LqB8ngW//QO8gle7eM=;
 b=ORBp7pRabxoA90ADsUiXScEMy1NlKVAo1TklGmWlz4HBi0iy/4sfrccy+92TesFk+/4liCXkmvN2b1IC4BrR1m7W21Fo0rq0+4GWVRFVMOsa8c50rnKb/HZidaJr+GPy2NM+19RL8fpn46NtF79VCE+tNAm37s5tolIhHE8m95oBwBumOwaOeGNbVdpSRc4dv+RfTdQnIwI269Nb+NPfRHyNT3roBOxk6nN41LlqpLMwMglD+iWTwbJMeZB6msrhhT8DSbIKYZ+qBLsVP5RmnC4utWwiyLjaCFclxYd0k8uTN3k99B09uuNpbAFJp7/2nfGepH5eaMd8/nJwcOtSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOr4JTVekaWYini6xYceK0+d8LqB8ngW//QO8gle7eM=;
 b=jRCbNKcZV+7AgWmba+JAJAyToAXgJbBqnQ8MwcTcMyGJKd+EQ/W17rnjinAwg2ChQs2FlPm3QVpTHKyYtlcJPht+d2nSCv5KgXuWEWeVyL2+PDEBKE9lqjzLBrW5R8qPWQibEHcIfdpGX1dpN7aH6rgIkmKXqdVI7NMX4bLP7s8=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 09:36:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:36:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early boot
Thread-Topic: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early
 boot
Thread-Index: AQHWYY4eiJ2SF2lCSU+quq5ttXjJ16ka/gOAgAAAWJCAABTmgIAAFqiggAFz5oCAAAW9cIAAAlmAgAAb3FA=
Date:   Tue, 28 Jul 2020 09:36:29 +0000
Message-ID: <DB6PR0402MB27607A931913DE24FEFA0D1488730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
 <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727075441.lgscydoj3txupeay@pengutronix.de>
 <DB6PR0402MB27605640244CE751317E6DE888720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200728072651.zcflghll4wa7rm55@pengutronix.de>
 <DB6PR0402MB27603441BEE037ECCB3F021088730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200728075547.u7bk22xnmu5jjpoo@pengutronix.de>
In-Reply-To: <20200728075547.u7bk22xnmu5jjpoo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e1ac6b6-61c4-496b-83c0-08d832d9b4cf
x-ms-traffictypediagnostic: DB7PR04MB4490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB449035BF30D2B4157F5E382C88730@DB7PR04MB4490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSCUi8Dja8iIevrTbOWFwxJUXwK6TIPismryN9WMfa4HMumYGY22dQjWP7QJWaCv9RvhwXlPxSRVEIgsNqi6q1X35TVwyOlfz2yyxVUSHoFSNO1mkOk75JqWvi/06pDkolklvBNbLVyloNIcnz6Wp/TWJ3IYjvIvA52Ec75VTHkQZn9sEwQHaVf6lCKrbWQbFR8cg1vozFn3sye+L3ww0pg/iC91qLG6CU2LR5zXB5NYlxWAcgFpUauAP6LSN1Oh0c913ih0XX9jCXMBT/EaLeBSzx18yx3tAohy5TA2GbIN/piJ+VnX8jiOqkzuKfLYiJBMJXTFWaUqXlr7dlRUBE/ND4aU4yTWxY53oEN5fzwwzYKM0Zn/OGDq9k/+7dxLttj+MtNqj3OffUpTvUcqsLzzu3bhkEHLOeAHjLFX78q3s6RY8ilxrXRao9yFNJHTOm1Ulmpfc5cZHUOAYlfsmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(966005)(186003)(44832011)(478600001)(52536014)(6916009)(71200400001)(5660300002)(4326008)(316002)(7696005)(6506007)(7416002)(54906003)(26005)(33656002)(8676002)(55016002)(2906002)(86362001)(8936002)(9686003)(83080400001)(76116006)(66556008)(66476007)(64756008)(66446008)(66946007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2rKgnmkA8NO5AvC7ERfIjnlSX2NALASe3pL1mkksaqrWt1oIdQTz1z8UReZcwTj88LJx++T5f/dsFg4lqi2x5Ogax34QosQ34scmKzR43YawI+Lg/i2vFzmMqmdIwugu3kYBeoucpWbCVqzcnFCkqCROY3OAd1chBiC5Xyf2QUoYwHiNedJttWJ7g/3hh79CIdSzrhaUq/Ovj3SRKZ9DjgAR912rO7hkdt3NCSlQ3pi9VLIHPTQP/wHBWA6HJYDOglzk2n/5++pp4oacqEj4GBT/6YNfQRL4ge2bzxyxxg42u6a4RWdNWh1wv0u9laMdQzNDkFjuCTJpXgbEtOhFtfvq41YGMUzh4c3dMRHS8OY5QxLGxvzVkihjGcoFdMJmenRSra/rSC3JhFD0QsgutLTxXUEYhwLfTk6/j29pbuW593wGaJ+/PYSBEPBJ6GgHJM2Lzb/YWG14R8imUqRLrdKkDkTIOp927fLbJn2wa//u+QcpIdCUT+AEukfYW3Ow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1ac6b6-61c4-496b-83c0-08d832d9b4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 09:36:29.4266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHksP1/hgiJB16bD9+be16GXe6RmqXyAyzNSP3HaJpdmIg4KBP8tXpVBGhK732LftrTDa52tOhfMeHBkr6LfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEwXSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBv
cnQgaU1YOE0gYW5kIGVhcmx5DQo+IGJvb3QNCj4gDQo+IE9uIFR1ZSwgSnVsIDI4LCAyMDIwIGF0
IDA3OjUwOjA0QU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCAwMC8xMF0gcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBzdXBwb3J0IGlNWDhNIGFuZA0KPiA+
ID4gZWFybHkgYm9vdA0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDA5OjE4
OjMxQU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMDAvMTBdIHJlbW90ZXByb2M6IGlteF9ycHJvYzogc3VwcG9ydCBpTVg4TQ0KPiA+ID4gPiA+
IGFuZCBlYXJseSBib290DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBNb24sIEp1bCAyNywgMjAy
MCBhdCAwNjo0NDozMkFNICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiA+ID4gPiA+IEhpIE9s
ZWtzaWosDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAw
LzEwXSByZW1vdGVwcm9jOiBpbXhfcnByb2M6IHN1cHBvcnQNCj4gPiA+ID4gPiA+ID4gaU1YOE0g
YW5kIGVhcmx5IGJvb3QNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI0LCAyMDIwIGF0IDA0OjA4OjAzUE0g
KzA4MDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2hzZXQgaXMg
dG8gc3VwcG9ydCBpLk1YOE1RL00gY29wcm9jIGJvb3RlZCBiZWZvcmUNCj4gbGludXguDQo+ID4g
PiA+ID4gPiA+ID4gU2luY2UgaS5NWDhNUS9NIHdhcyBub3Qgc3VwcG9ydGVkLCBzZXZlcmFsIHBh
dGNoZXMgYXJlDQo+ID4gPiA+ID4gPiA+ID4gbmVlZGVkIHRvIGZpcnN0IHN1cHBvcnQgdGhlIHBs
YXRmb3JtLCB0aGVuIHN1cHBvcnQgZWFybHkgYm9vdA0KPiBjYXNlLg0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gSSBpbnRlbmRlZCB0byBpbmNsdWRlZCBpLk1YOFFNL1FYUCwgYnV0
IHRoYXQgd291bGQNCj4gPiA+ID4gPiA+ID4gPiBpbnRyb2R1Y2UgYSBsYXJnZSBwYXRjaHNldCwg
c28gbm90IGluY2x1ZGVkLiBCdXQgdGhlDQo+ID4gPiA+ID4gPiA+ID4gY2xrL3N5c2NvbiBvcHRp
b25hbCBwYXRjaCBmb3IgaS5NWDhRTS9RWFAgd2FzIHN0aWxsIGtlcHQgaGVyZSB0bw0KPiBhdm9p
ZCByZWJhc2UgZXJyb3IuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFRoYW5rIHlvdSBm
b3IgeW91ciB3b3JrLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBDYW4geW91IHBsZWFz
ZSBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgYmlnIHBpY3R1cmUgb2YNCj4gPiA+ID4g
PiA+ID4gdGhpcw0KPiA+ID4gd29yay4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSWYg
SSBzZWUgaXQgY29ycmVjdGx5LCB3ZSBoYXZlIGhlcmUgc3VwcG9ydCBmb3IgaS5NWDhNTSwNCj4g
PiA+ID4gPiA+ID4gd2hpY2ggc2VlbXMgdG8gYmUgYWJsZSB0byBmdWxseSBjb250cm9sIENvcnRl
eCBNNCAoZW5hYmxlIENQVQ0KPiBjb3JlLCBldGMuLi4pLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IFllcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEluIHRoaXMgY2FzZSwgSSB3b3VsZCByZWNv
bW1lbmQgdG8gbWFpbmxpbmUgdGhlIGkuTVg4TU0gcGFydA0KPiA+ID4gPiA+IGZpcnN0L3NlcGFy
YXRlbHkuDQo+ID4gPiA+DQo+ID4gPiA+IE9ubHkgdGhlIGxhc3QgcGF0Y2ggaXMgdG8gc3VwcG9y
dCBlYXJseWJvb3QsIGFsbCBvdGhlcnMgaXMgaW14OG1tIHBhcnQuDQo+ID4gPg0KPiA+ID4gb2sN
Cj4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gQW5kIG90aGVy
IGNhc2UsIHdoZXJlIHJlbW90ZXByb2MgaXMgcnVubmluZyBvbiBhcHBsaWNhdGlvbg0KPiA+ID4g
PiA+ID4gPiBwcm9jZXNzb3IgYW5kIGNhbid0IG9yIHNob3VsZCBub3QgdG91Y2ggTTQgKGkuTVg3
VUxQLA0KPiA+ID4gPiA+ID4gPiBpLk1YOFFNL1FYUC4uKS4gU2luY2UgTTQgcHJvdmlkZXMgc29t
ZSBmdW5jdGlvbmFsaXR5LCB5b3UNCj4gPiA+ID4gPiA+ID4gYXJlIHRyeWluZyB0byByZXVzZSBy
ZW1vdGVwcm9jIGZyYW1ld29yayB0byBnZXQgcmVzb3VyY2UNCj4gPiA+ID4gPiA+ID4gdGFibGUg
cHJlc2VudCBpbiBFTEYgaGVhZGVyIGFuZCB0byBkeW5hbWljYWxseSBsb2FkIHRoaW5ncy4NCj4g
PiA+ID4gPiA+ID4gRm9yIHNvbWUgcmVhc29ucyB0aGlzIGhlYWRlciBwcm92aWRlcyBtb3JlIGlu
Zm9ybWF0aW9uIHRoZW4NCj4gPiA+ID4gPiA+ID4gbmVlZGVkLCBzbyB5b3UgYXJlIGNoYW5naW5n
IHRoZSBFTEYgcGFyc2VyIGluIHRoZSBrZXJuZWwNCj4gPiA+ID4gPiB0byB3b3JrYXJvdW5kIGl0
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE5vdCBleGFjdGx5Lg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IEZvciBpLk1YOE1NLCB3ZSBzdXBwb3J0IHR3byBjYXNlcy4gTTQga2lja2VkIGJ5
IFUtQm9vdCwgTTQNCj4gPiA+ID4gPiA+IGtpY2tlZCBieQ0KPiA+ID4gPiA+IExpbnV4IHJlbW90
ZXByb2MuDQo+ID4gPiA+ID4gPiBGb3IgaS5NWDhRTS9RWFAsIHRoZSB0eXBpY2FsIHVzZWNhc2Ug
aXMgTTQga2lja2VkIGJ5IFNDRlcsIGJ1dA0KPiA+ID4gPiA+ID4gd2Ugd2lsbCBhbHNvIGFkZCBN
NCBraWNrZWQgYnkgTGludXggcmVtb3RlcHJvYy4NCj4gPiA+ID4gPiA+IEZvciBpLk1YN1VMUCwg
SSB3b3VsZCBvbmx5IHN1cHBvcnQgTTQgZHVhbCBib290IGNhc2UsIE00DQo+ID4gPiA+ID4gPiBj
b250cm9sDQo+ID4gPiA+ID4gZXZlcnl0aGluZy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZyb20g
Y3VycmVudCBzdGF0ZSBvZiBkaXNjdXNzaW9uLCBpJ20gbm90IHN1cmUgd2hhdCByb2xlIHBsYXlz
DQo+ID4gPiA+ID4gcmVtb3RlcHJvYyBpbiB0aGUgc2NlbmFyaW8gd2hlcmUgTTQgaXMgc3RhcnRl
ZCBiZWZvcmUgbGludXguDQo+ID4gPiA+ID4gRXNwZWNpYWxseSBpZiB3ZSBhcmUgbm90IHVzaW5n
IHJlc291cmNlIHRhYmxlLg0KPiA+ID4gPg0KPiA+ID4gPiBXZSBhcmUgdXNpbmcgcmVzb3VyY2Ug
dGFibGUgZnJvbSBhbiBhZGRyZXNzLCBub3QgaW4gZWxmIGZpbGUuDQo+ID4gPiA+IFRoaXMgaXMg
dGhlIG5ldyBmZWF0dXJlIGluIExpbnV4LW5leHQgdG8gc3VwcG9ydCBjb3Byb2MgYm9vdGVkIGVh
cmx5Lg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUgcmVhc29uIHRoZSBjaGFu
Z2UgdGhlIGVsZiBwYXJzZXIgaXMgdGhhdCB3aGVuIE00IGVsZiBpcw0KPiA+ID4gPiA+ID4gbG9h
ZGVkIGJ5IExpbnV4IHJlbW90ZXByb2MsIEl0IHVzZSBtZW1zZXQgdG8gY2xlYXIgYXJlYS4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFRoZSB1c2Ugb2YgbWVtc2V0LCBkZXBlbmRzIG9uIEVMRiBmb3Jt
YXQuIEZpeC9jaGFuZ2UgdGhlIGxpbmtlcg0KPiA+ID4gPiA+IHNjcmlwdCBvbiB5b3VyIGZpcm13
YXJlIGFuZCBtZW1zZXQgd2lsbCBiZSBuZXZlciBjYWxsZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IEhvd2V2ZXIgd2UgdXNlIGlvcmVtYXAsIG1lbXNldCBvbiBBUk02NCB3aWxsIHJlcG9ydCBj
cmFzaCB0bw0KPiA+ID4gPiA+ID4gZGV2aWNlIG5HblJFIG1lbW9yeS4gQW5kIHdlIGNvdWxkIG5v
dCB1c2UgaW9yZW1hcF93YyB0byBUQ00NCj4gPiA+ID4gPiA+IGFyZWEsIHNpbmNlIGl0IGNvdWxk
IGhhdmUgZGF0YSBjb3JyZWN0bHkgd3JpdHRlbiBpbnRvIFRDTS4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEkgaGF2ZSBzdHJvbmcgZmVlbGluZywgdGhhdCB3ZSBhcmUgdGFsa2luZyBhYm91dCBiYWRs
eSBvciBub3QNCj4gPiA+ID4gPiBwcm9wZXJseSBmb3JtYXR0ZWQgRUxGIGJpbmFyeS4gSSB3b3Vs
ZCBwcmVmZXIgdG8gZG91YmxlIGNoZWNrDQo+ID4gPiA+ID4gaXQsIGJlZm9yZSB3ZSB3aWxsIGFw
cGx5IGZpeGVzIG9uIHdyb25nIHBsYWNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBNYWludGFp
bmVyIG5vdCB3YW5uYSB0byBkcm9wIG1lbXNldCBpbiBjb21tb24gY29kZSwgYW5kIFRJDQo+ID4g
PiA+ID4gPiBndXlzIHN1Z2dlc3QgYWRkIGkuTVggc3BlY2lmaWMgZWxmIHN0dWZmLiBTbyBJIGFk
ZCBlbGYgaGFuZGxlciBpbiBpLk1YDQo+IGNvZGUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHRo
aW5rLCByZW1vdmluZyBtZW1zZXQgbWF5IGRhbWFnZSBjdXJyZW50IHVzZXJzIG9mIGlteF9ycHJv
Yw0KPiBkcml2ZXIuDQo+ID4gPiA+ID4gU2luY2UsIGxpa2UgSSBzYWlkOiB0aGUgdXNlIG9mIG1l
bXNldCBkZXBlbmRzIG9uIEVMRiBmb3JtYXQuDQo+ID4gPiA+DQo+ID4gPiA+IEluIG15IGVsZiBm
aWxlLCB0aGUgbGFzdCBQVF9MT0FEIGNvbnRhaW5zIGRhdGEvYnNzL2hlYXAvc3RhY2suDQo+ID4g
PiA+IEknbGwgY2hlY2sgd2l0aCBvdXIgTUNVIGd1eXMsIHdlIG9ubHkgbmVlZCB0aGUgc3BlY2lm
aWMgZGF0YSBsb2FkZWQuDQo+ID4gPiA+DQo+ID4gPiA+IEVsZiBmaWxlIHR5cGUgaXMgRVhFQyAo
RXhlY3V0YWJsZSBmaWxlKSBFbnRyeSBwb2ludCAweDFmZmUwMzU1DQo+ID4gPiA+IFRoZXJlIGFy
ZSAzIHByb2dyYW0gaGVhZGVycywgc3RhcnRpbmcgYXQgb2Zmc2V0IDUyDQo+ID4gPiA+DQo+ID4g
PiA+IFByb2dyYW0gSGVhZGVyczoNCj4gPiA+ID4gICBUeXBlICAgICAgICAgICBPZmZzZXQgICBW
aXJ0QWRkciAgIFBoeXNBZGRyICAgRmlsZVNpeiBNZW1TaXoNCj4gPiA+IEZsZyBBbGlnbg0KPiA+
ID4gPiAgIExPQUQgICAgICAgICAgIDB4MDEwMDAwIDB4MWZmZTAwMDAgMHgxZmZlMDAwMCAweDAw
MjQwDQo+IDB4MDAyNDANCj4gPiA+IFIgICAweDEwMDAwDQo+ID4gPiA+ICAgTE9BRCAgICAgICAg
ICAgMHgwMTAyNDAgMHgxZmZlMDI0MCAweDFmZmUwMjQwIDB4MDNlOTANCj4gMHgwM2U5MA0KPiA+
ID4gUldFIDB4MTAwMDANCj4gPiA+ID4gICBMT0FEICAgICAgICAgICAweDAyMDAwMCAweDIwMDAw
MDAwIDB4MWZmZTQwZDAgMHgwMDA2OA0KPiAweDBhZDAwDQo+ID4gPiBSVyAgMHgxMDAwMA0KPiA+
ID4gPg0KPiA+ID4gPiAgU2VjdGlvbiB0byBTZWdtZW50IG1hcHBpbmc6DQo+ID4gPiA+ICAgU2Vn
bWVudCBTZWN0aW9ucy4uLg0KPiA+ID4gPiAgICAwMCAgICAgLmludGVycnVwdHMNCj4gPiA+ID4g
ICAgMDEgICAgIC5yZXNvdXJjZV90YWJsZSAudGV4dCAuQVJNIC5pbml0X2FycmF5IC5maW5pX2Fy
cmF5DQo+ID4gPiA+ICAgIDAyICAgICAuZGF0YSAuYnNzIC5oZWFwIC5zdGFjaw0KPiA+ID4NCj4g
PiA+IEhlcmUgaXMgYW4gZXhhbXBsZSBvZiBmb3JtYXR0aW5nIEVMRiBmb3IgcmVtb3RlcHJvYzoN
Cj4gPiA+IGh0dHBzOi8vZ2l0LnBlbmd1dHJvbml4LmRlL2NnaXQvb3JlL09TRUxBUy5CU1AtUGVu
Z3V0cm9uaXgtRHVhbEtpdC90DQo+ID4gPiByZWUvbG9jDQo+ID4gPiBhbF9zcmMvcmVtb3RlcHJv
Yy1lbGYvbGlua2VyLmxkDQo+ID4gPiBodHRwczovL2dpdC5wZW5ndXRyb25peC5kZS9jZ2l0L29y
ZS9PU0VMQVMuQlNQLVBlbmd1dHJvbml4LUR1YWxLaXQvdA0KPiA+ID4gcmVlL2xvYw0KPiA+ID4g
YWxfc3JjL3JlbW90ZXByb2MtZWxmL2lteDdtNC5TDQo+ID4gPg0KPiA+ID4gSW4gdGhpcyBleGFt
cGxlIEkgcGFjayBsaW51eCBpbiB0byByZW1vdGVwcm9jIGVsZiBpbWFnZSBhbmQgc3RhcnQNCj4g
PiA+IGxpbnV4IG9uDQo+ID4gPiBpbXg3ZC1tNCBwYXJ0Lg0KPiA+ID4gV2lsbCBiZSBpbnRlcmVz
dGluZyBpZiB5b3UgY2FuIGRvIHRoZSBzYW1lIG9uIGlteDgqIFNvQ3MgOykNCj4gPg0KPiA+IElu
IE5YUCByZWxlYXNlLCB0aGUgbTQgZWxmIGZpbGVzIGhhdmUgZGF0YS9ic3MvaGVhcC9zdGFjayBp
biB0aGUgc2FtZQ0KPiA+IGRhdGEgYXJlYSwgc28gdGhlIGxpbmtlciBtZXJnZWQgdGhlbSBpbnRv
IG9uZSBzZWdtZW50IGFuZCBjYXVzZSBtZW1zeg0KPiA+ID4gZmlsZXN6Lg0KPiA+DQo+ID4gSSB0
aGluayBJIG5lZWQgdG8gcHJvcG9zZSBwbGF0Zm9ybSBzcGVjaWZpYyBlbGYgbWVtc2V0L21lbWNw
eSwgc3VjaCBhcw0KPiA+IHJwcm9jX2VsZl9tZW1jcHksIHJwcm9jX2VsZl9tZW1zZXQsDQo+ID4N
Cj4gPiBUbyBpLk1YLCBuZWVkIHVzZSBtZW1zZXRfaW8gYW5kIG1lbWNweV90b2lvLCB0YWtpbmcg
VENNIGFzIGRldmljZQ0KPiA+IG1lbW9yeS4NCj4gPg0KPiA+IE5vdGU6IG1lbXNldCB3aXRob3V0
IGlvIHdpbGwgY2F1c2UgYWJvcnQgd2hlbiBtZW1zej5maWxlc3ouDQo+ID4gU28gdXNlIG1lbXNl
dF9pbyBpcyBzYWZlLg0KPiANCj4gU291bmRzIGdvb2QsIGkgd291bGQgcHJlZmVyIHRoaXMgd2F5
Lg0KDQpKdXN0IHNlbnQgb3V0LCBwbGVhc2UgaGVscCByZXZpZXcgdGhlcmUuDQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNjg4NzUxLw0KaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMTY4ODc1My8NCg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiAtLQ0K
PiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IFN0
ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAgICB8DQo+IGh0dHA6Ly93d3cu
cGVuZ3V0cm9uaXguZGUvICB8DQo+IDMxMTM3IEhpbGRlc2hlaW0sIEdlcm1hbnkgICAgICAgICAg
ICAgICAgICB8IFBob25lOg0KPiArNDktNTEyMS0yMDY5MTctMCAgICB8DQo+IEFtdHNnZXJpY2h0
IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDoNCj4gKzQ5LTUxMjEtMjA2OTE3
LTU1NTUgfA0K
