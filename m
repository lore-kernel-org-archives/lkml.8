Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541FFC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D69E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CtqkSsjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgG0G20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:28:26 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:47172
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgG0G2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTZaeKR8g7RbTd9s4r5OFpMBzQgd+u6RmnEuFaLICB1HHFt5GzXw0uIJBJFS2AUy7OajIkdHVSNpyB4zxXnv0Ivq5rO1VjFyQVgUKay0y/8vPLEG1Q8dyVcV4+s1TkgFQocdMVjbvmJmzF1u4z3u8HukCRh3sqFy1Gh2Z0yHgNiQXxYJ9wiyzxnvjLRP0otNSN/rapi1Sm2dZBD5wUM4RMt+LrfKXO5vAiCzXlqWsYA8S1Lvtfmc9u5ncyx7ZkJxoUMyLl/ive9Jt13KR6eLVifRopk2S6BE+1b48J/tkJ69Sc9I4uFPz19jsurRt5Yuz7KwP1uOdEE8RGdtU2oLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1bGtu1I81KG2zjmMZaeQOPhN4wOHp+3b0hFNotK1tc=;
 b=CD67xep2HRq4jJQvyvh3COk4DaWRQ77/g1vMhE1tnjJtowID6lOBjUEBd76HGLl0IF6I2r7/8VbVitqRVCxZsPptS7I9HKRmZcxnXbfeNHgZUOcOOO+hlWUR9r05EOJjZmtyzxX4RMS+0NLIJdT0lXK/bqVOcmA8hq7OZ82d/kJ0oYXvySqpZ4DHT1SW7hekHQ8p/PA2QM4B499+lo6dlvtcId/RdJWieqqN7h44YvLgIgaDHnvpC+ISSYVU5LFUELBpLbcuxmreLWjcBFvNyP4GdHxS0RsJ9z9XxeKrvfytAR2HuuZPZs23VDiwUDsqSFrbe9vMd5hVwIVNqdUDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1bGtu1I81KG2zjmMZaeQOPhN4wOHp+3b0hFNotK1tc=;
 b=CtqkSsjUauYK5GTLg9uKnwr3uGo3IMPqFLFKsoqwRZbbBzA/ILfJyz5vjHv/Y0Y/DK73CBUq0TexEcIoMEuRvSge+cjDPfUTQFQlcRL8gflIfc5Jd7YV07OOFJ7miKqFWBN5s/AcG7CIF3c57fjhDDdAqg+REOQIigvTkxOOxNo=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 06:28:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:28:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Thread-Topic: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Thread-Index: AQHWYY4mj2fkhyJv70m2EtieoGp7X6ka+c2AgAAA2pA=
Date:   Mon, 27 Jul 2020 06:28:20 +0000
Message-ID: <DB6PR0402MB27601C875FF5F1E02DBF5C6488720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-4-peng.fan@nxp.com>
 <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
In-Reply-To: <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f19ad30-6690-401a-f985-08d831f6417b
x-ms-traffictypediagnostic: DB7PR04MB5084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5084B4C1C3F68E761C5E9BE488720@DB7PR04MB5084.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dog41px9w5VBTsDXwutOEjclDuKhX7qXb5BR8B5CLphNBmCBBvkmo6jgP4KUl/Lx8FqYBowecclKlR0+P8fX37UdacMHiH4RNo6zZSpy1zac1mGwfMO5cOwdAqKlTSh2ltJzTniS1hq/fuFDvm/z5fHuslUPHk8WVxakxp+xbZ3h0YRHA/MoLMhbdRtFDNSMA1uHE3UEt+XtDqdcPoh92Dn4hPYQCZ/n9/wZYTC37Uywmy2IFpc6GX4xuxH4/HMxgYdCGnAxHA1bFh56eQFsWe/t0GunfaNs4eJCtSGAHa4YUWJaXSqSDTBc1UVyBOnDGEAhdHRPnbtkZIjHcY3zDuoTl1QUq8rAX6YUjI3mr9DnVHvOiEtVl0WVmeGTsG7d2WV5bYwhVTMerVJws3fSOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(6916009)(6506007)(9686003)(52536014)(8936002)(478600001)(26005)(5660300002)(316002)(4326008)(186003)(33656002)(54906003)(8676002)(66946007)(66476007)(66556008)(66446008)(64756008)(83080400001)(2906002)(76116006)(86362001)(83380400001)(44832011)(7416002)(7696005)(966005)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hBl3GAZEAacVU4Asimb++hp6tt5Q5t5db+8ja0E9jyNgIvnbYIeq9sPsr/reeyfPhzsDngElGMc2QdNW0uf2vCHyJrhnnVFbQhJqpXqZIVtGBWq3LMuQri4g8y0XVyQOi1eY9pPcQiqkiOmZzsBmtPJQTKlndc7ISX0XB50cwVACu7TSluGKo+TM/fe4BcAPCsIU/2ZEIiWlkNRYMTLzx8X+sUTqFLkzn7u1b3YEL8C0RcotA3tey4MmaNnxTUIn1+E94ydOU2FalghwgnGAeI968ipHZbr0bagFZPgBR0MNlyOinH67rdCOjFVMyIKt85cRbQ2D546PeFWAsqwhXmxhfDZv5a1o1MvN3tPKm2Dljfn/cuY88KieuuZ/kB0jh5L2CETBgOJZYdg0p7ciqgnW2lfw7lGoagFG7ddKxffGhawE4pmuPMsxgBzgc8xChWbBCBhypC7lmyepSIVomJ4nQ9/yJKAPv/U+AFS3bCY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f19ad30-6690-401a-f985-08d831f6417b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 06:28:20.2435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNL4XnYNHxdpkj8hixsfnxTmlzehJJQaMFC21+CHmdZbBg7VecO0NbmeOG04HDhgpXDYzGk/Aq7BVe3Ohk+OVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzEwXSByZW1vdGVwcm9jOiBp
bXg6IHVzZSBkZXZtX2lvcmVtYXANCj4gDQo+IE9uIEZyaSwgSnVsIDI0LCAyMDIwIGF0IDA0OjA4
OjA2UE0gKzA4MDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IFdlIG1pZ2h0IG5lZWQgdG8gbWFwIGFu
IHJlZ2lvbiBtdWx0aXBsZSB0aW1lcywgYmVjYXVlIHRoZSByZWdpb24gbWlnaHQNCj4gPiBiZSBz
aGFyZWQgYmV0d2VlbiByZW1vdGUgcHJvY2Vzc29ycywgc3VjaCBpLk1YOFFNIHdpdGggZHVhbCBN
NCBjb3Jlcy4NCj4gPiBTbyB1c2UgZGV2bV9pb3JlbWFwLCBub3QgZGV2bV9pb3JlbWFwX3Jlc291
cmNlLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgZ2l2ZSBhbiBleGFtcGxlIG9mIHRoaXMga2luZCBv
ZiBzaGFyZWQgcmVzb3VyY2VzIGFuZCBob3cgdGhleQ0KPiBzaG91bGQgYmUgaGFuZGxlZCBieSB0
d28gc2VwYXJhdGUgZGV2aWNlcz8NCg0KVGhpcyBpcyB0byBzaGFyZSB2ZGV2YnVmZmVyIHNwYWNl
LCB0aGVyZSBpcyBhIHZkZXZidWZmZXIgaW4gZGV2aWNlIHRyZWUsIGl0IHdpbGwgYmUNCnNoYXJl
ZCBiZXR3ZWVuIE00XzAgYW5kIE00XzEuDQoNCkZvciB0aGUgYnVmZmVyLCBpdCBpcyBMaW51eCBE
TUEgQVBJIHdpbGwgaGFuZGxlIHRoZSBzcGFjZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4g
PiBSZXZpZXdlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMgfCA1ICsrKy0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jDQo+ID4gYi9kcml2ZXJzL3JlbW90ZXBy
b2MvaW14X3Jwcm9jLmMgaW5kZXggM2IzOTA0ZWJhYzc1Li44MjU5NGE4MDBhMWINCj4gPiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMNCj4gPiArKysgYi9k
cml2ZXJzL3JlbW90ZXByb2MvaW14X3Jwcm9jLmMNCj4gPiBAQCAtMjk2LDkgKzI5NiwxMCBAQCBz
dGF0aWMgaW50IGlteF9ycHJvY19hZGRyX2luaXQoc3RydWN0IGlteF9ycHJvYw0KPiAqcHJpdiwN
Cj4gPiAgCQlpZiAoYiA+PSBJTVg3RF9SUFJPQ19NRU1fTUFYKQ0KPiA+ICAJCQlicmVhazsNCj4g
Pg0KPiA+IC0JCXByaXYtPm1lbVtiXS5jcHVfYWRkciA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgm
cGRldi0+ZGV2LA0KPiAmcmVzKTsNCj4gPiArCQkvKiBOb3QgdXNlIHJlc291cmNlIHZlcnNpb24s
IGJlY2F1c2Ugd2UgbWlnaHQgc2hhcmUgcmVnaW9uKi8NCj4gPiArCQlwcml2LT5tZW1bYl0uY3B1
X2FkZHIgPSBkZXZtX2lvcmVtYXAoJnBkZXYtPmRldiwgcmVzLnN0YXJ0LA0KPiA+ICtyZXNvdXJj
ZV9zaXplKCZyZXMpKTsNCj4gPiAgCQlpZiAoSVNfRVJSKHByaXYtPm1lbVtiXS5jcHVfYWRkcikp
IHsNCj4gPiAtCQkJZGV2X2VycihkZXYsICJkZXZtX2lvcmVtYXBfcmVzb3VyY2UgZmFpbGVkXG4i
KTsNCj4gPiArCQkJZGV2X2VycihkZXYsICJkZXZtX2lvcmVtYXAgJXBSIGZhaWxlZFxuIiwgJnJl
cyk7DQo+ID4gIAkJCWVyciA9IFBUUl9FUlIocHJpdi0+bWVtW2JdLmNwdV9hZGRyKTsNCj4gPiAg
CQkJcmV0dXJuIGVycjsNCj4gPiAgCQl9DQo+ID4gLS0NCj4gPiAyLjE2LjQNCj4gPg0KPiA+DQo+
IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
PiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAgICB8DQo+IGh0
dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUvICB8DQo+IDMxMTM3IEhpbGRlc2hlaW0sIEdlcm1hbnkg
ICAgICAgICAgICAgICAgICB8IFBob25lOg0KPiArNDktNTEyMS0yMDY5MTctMCAgICB8DQo+IEFt
dHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDoNCj4gKzQ5LTUx
MjEtMjA2OTE3LTU1NTUgfA0K
