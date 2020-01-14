Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDFDC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A59214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="As+5sVBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgANCnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:43:46 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:52046
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728802AbgANCnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:43:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmIEfe037f2CLExMn+nMsSfhIbpwGp/s+dgUfNHaOuYRy5DdixjnOovHOCtFiDNdb/xoQE2UwBEiC+jMdHTjPbinxFzELqfhcCrgHRH/5xH/ha855dFHmLKZEx1p8MezLJrawIClszVDJorx1mzTibtnxSqk9l+7w/vwZZhsAqsbryKt2zBy92eq+7DzMh1c7jGpSfDHxZOMkvQpT53eIgZk44w9rvs9Ig8t6mNq6eob/Z7PKkSNIiSLXSX76/Mf8fdjkXoCYMXaTLUUMEcixKRbQ/cIuyMsTs+u4OQuik/yTpMx4drcL1ahrHgR2+4yZy2d5qdNFeIMkTcHuYjgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPmbW6KAivRvd5IiC7RXVkzsHpfbRjBW0T+iQhI423I=;
 b=EmD7cy1y6f62WQaiOGL4B7+2yLbaBVqrpo6oPmDkHY1kNF5r7Z87YjDZ6cCRVtRczCDce9uu3QPgQk6L9tS8pGcojN22KGPaC3q0KqWw+S4ufi7Evgdzl3AdW+oCphqZJLg+p67pB+izjJ4HKkx2l56tEiLoz9nqYN0gogHSUQLZ0UUnt3bo8D1WxMTvO9igh9AKaRIjXz50BVnr9oNHNFKiGFeGLDZIZRs2pfdzaU1WE9ub3E1baOJHJuVNDmUHFLoadSKWF72whe2ZlpmttxfovLeUganAtmJ2argCFRj5bBbuDhJmEFcEQt1qnPC1ErInFi+THuZsSpMlMayBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPmbW6KAivRvd5IiC7RXVkzsHpfbRjBW0T+iQhI423I=;
 b=As+5sVBkYZzDT3QNe3OCuEnpDtKOKHFPG4LeUGr7qy/QyD+HJc0mV2JDFzGXShnNVJPTdij/jHJjTG9/ItLPNakFUJyUajbeDMHQ/sl7sMyTEnPC5pPpLRNf4VH7eHkItlwUXm+NlkPETxjDSy4TIzgAyDKCwuL+b9hDDRWvbgA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4457.eurprd04.prod.outlook.com (52.135.141.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 02:43:42 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 02:43:42 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Topic: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP
 INTMUX interrupt multiplexer
Thread-Index: AQHVyeDroUXufH5Iq0+ZDldne7GnO6fpFh8AgABbg+A=
Date:   Tue, 14 Jan 2020 02:43:41 +0000
Message-ID: <DB7PR04MB461863B36162325EF1BB6251E6340@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1578899321-1365-1-git-send-email-qiangqing.zhang@nxp.com>
 <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
 <20200113210344.GA4615@bogus>
In-Reply-To: <20200113210344.GA4615@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6dfb955-7e77-47a3-2ec1-08d7989b9144
x-ms-traffictypediagnostic: DB7PR04MB4457:|DB7PR04MB4457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4457EDAC714B6FE2AD298DB1E6340@DB7PR04MB4457.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(2906002)(4326008)(81156014)(9686003)(8936002)(86362001)(5660300002)(81166006)(6916009)(8676002)(55016002)(53546011)(6506007)(7696005)(66476007)(478600001)(33656002)(71200400001)(45080400002)(7416002)(54906003)(66446008)(64756008)(66946007)(66556008)(316002)(26005)(76116006)(52536014)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4457;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P//FCuBOTAB89Hrz+Jc3SUceNFMBWL8yVtf+4nKZ2iWQ9B5s4zxO7McNuSv7ThHMQK/7VTpnZNx3oxNdnU9722L+DBWnmsXrQCh5XiIjQWM7Kqk9CQRt24FQ+xGED3XSwrb4jBLMqWvwt+CJzEBdW9YtvQR764aKc5Ptlc4MWOmG1byvMtOAAkVC2a+shWngqBiDPWyQsb85P9U7oOJZO50IrlzBUyf9m+3JBPmiv/k4PfySyRk1tW3KmJkhnd41wMUPNo31+UtrvJamVEJQf98FOfF7rFPAjfrqVUHLJt57UX127Nkl8jRXfMHO0iwS8CMdDAOm+MgPMWMQz+x+MRZl1LQLUh2l6OzBlH5LoAReKRcjSBVbAXfrvfylUVscCvUyxt6JVDDVVMtwRdIUv8YQIguEd7KOpc216uLuPUl5nGLxCK3waHbIs3EN5OYRmBZamJErkEMPYFrqw2TGjl0F0UuX3qu6KDx4P03qN4Y/m44yP5IdlYowd9+0X8kT+P5EsPSXXnEOfcXHHBtLCtEhOIfauV8uQLrhcsv3nhDX2OCv4Kim7i0mh6acgCqRhGcQpt0c4b1TyHA1Kq/BNw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dfb955-7e77-47a3-2ec1-08d7989b9144
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 02:43:41.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9XlFJNWIGbF2+waoq3SSbJKNO4Ra6wim2RDvbBRUJPVunPpxOzzpIePbQS5VUAKQhBfGcb1+hF5ZBrgKBdqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jHUwjE0yNUgNTowNA0KPiBUbzogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqYXNv
bkBsYWtlZGFlbW9uLm5ldDsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtYXJrLnJ1dGxhbmRAYXJt
LmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5j
b20+OyBBbmR5IER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjQgUkVTRU5EIDEvMl0gZHQtYmluZGluZ3MvaXJxOiBhZGQgYmluZGluZyBmb3IgTlhQDQo+
IElOVE1VWCBpbnRlcnJ1cHQgbXVsdGlwbGV4ZXINCj4gDQo+IE9uIE1vbiwgSmFuIDEzLCAyMDIw
IGF0IDAzOjA4OjQwUE0gKzA4MDAsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPiBUaGlzIHBhdGNo
IGFkZHMgdGhlIERUIGJpbmRpbmdzIGZvciB0aGUgTlhQIElOVE1VWCBpbnRlcnJ1cHQNCj4gPiBt
dWx0aXBsZXhlciBmb3IgaS5NWDggZmFtaWx5IFNvQ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGludG11eC55YW1sICAgICAgfCA3NyArKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LnlhbWwNCj4gDQo+IFBsZWFzZSBydW4g
J21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGZpeCB0aGUgZXJyb3JzOg0KPiANCj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpbnRt
dXgueWFtbDoNCj4gd2hpbGUgc2Nhbm5pbmcgZm9yIHRoZSBuZXh0IHRva2VuIGZvdW5kIGNoYXJh
Y3RlciB0aGF0IGNhbm5vdCBzdGFydCBhbnkgdG9rZW4NCj4gICBpbiAiPHVuaWNvZGUgc3RyaW5n
PiIsIGxpbmUgNjAsIGNvbHVtbiAxDQpHb3QgaXQuIFdpbGwga2VlcCBpbiBtaW5kLiBUaGFua3Mu
DQoNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LnlhDQo+ID4gbWwNCj4gPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9m
c2wsaW50bXV4LnlhDQo+ID4gbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNGRiYTUzMmZlMGJkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9m
c2wsaW50bXUNCj4gPiArKysgeC55YW1sDQo+ID4gQEAgLTAsMCArMSw3NyBAQA0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEu
Mg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVl
Lm9yZyUyRnNjaGVtYXMlMkZpbnRlcnJ1cHQtY29udHJvbGxlciUyRmZzbCUyQ2ludG11eC55YW1s
JTIzJmENCj4gbQ0KPiA+DQo+ICtwO2RhdGE9MDIlN0MwMSU3Q3FpYW5ncWluZy56aGFuZyU0MG54
cC5jb20lN0NkYzI0NDNkYzExMTE0OTgwNWM3DQo+IDIwOGQ3DQo+ID4NCj4gKzk4NmMxNTdmJTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzE0NTQ2DQo+IDIy
OTE5MzQNCj4gPg0KPiArNDkyJmFtcDtzZGF0YT1BbzRpdWoyRDQ4S0FlQyUyRnZRdkpxVVV4R0pF
alNZMEh5TDVabFQyWHJTcmclM0QmDQo+IGFtcDtyZQ0KPiA+ICtzZXJ2ZWQ9MA0KPiA+ICskc2No
ZW1hOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRm1ldGEtc2NoZW1h
cyUyRmNvcmUueWFtbCUyMyZhbXA7ZGF0YT0wMiU3QzAxJTdDcWlhDQo+IG5ncWluZw0KPiA+DQo+
ICsuemhhbmclNDBueHAuY29tJTdDZGMyNDQzZGMxMTExNDk4MDVjNzIwOGQ3OTg2YzE1N2YlN0M2
ODZlYTFkM2INCj4gYzJiNGM2DQo+ID4NCj4gK2ZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2
MzcxNDU0NjIyOTE5MzQ0OTImYW1wO3NkYXRhPVlvSGINCj4gVE81QzhObHENCj4gPiArWVlvV1RO
dWZhSXhudmR0UFVaYUt6dndLNDlJOVpkYyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ICsNCj4gPiAr
dGl0bGU6IEZyZWVzY2FsZSBJTlRNVVggaW50ZXJydXB0IG11bHRpcGxleGVyDQo+ID4gKw0KPiA+
ICttYWludGFpbmVyczoNCj4gPiArICAtIE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+DQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBpdGVt
czoNCj4gPiArICAgICAgY29uc3Q6IGZzbCxpbXgtaW50bXV4DQo+ID4gKw0KPiA+ICsgIHJlZzoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAg
ICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDgNCj4gPiArICAgIGRlc2NyaXB0aW9u
OiB8DQo+ID4gKyAgICAgIFNob3VsZCBjb250YWluIHRoZSBwYXJlbnQgaW50ZXJydXB0IGxpbmVz
ICh1cCB0byA4KSB1c2VkIHRvIG11bHRpcGxleA0KPiA+ICsgICAgICB0aGUgaW5wdXQgaW50ZXJy
dXB0cy4NCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0LWNvbnRyb2xsZXI6IHRydWUNCj4gPiArDQo+
ID4gKyAgJyNpbnRlcnJ1cHQtY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDINCj4gPiArDQo+ID4g
KyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOiBp
cGcgY2xvY2suDQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+
ID4gKyAgICAgIGNvbnN0OiBpcGcNCj4gPiArDQo+ID4gKyAgZnNsLGludG11eF9jaGFuczoNCj4g
DQo+IERvbid0IHVzZSAnXycgaW4gcHJvcGVydHkgbmFtZXMuDQpHb3QgaXQuDQoNCj4gSXMgdGhp
cyBhbnkgZGlmZmVyZW50IGZyb20gdGhlIGxlbmd0aCBvZiAnaW50ZXJydXB0cycgd2hpY2ggeW91
IGNhbiBjb3VudD8NCkEgYml0IGRpZmZlcmVudC4gU3VjaCBhcywgdGhlIGxlbmd0aCBvZiAnaW50
ZXJydXB0cycgaXMgOCwgYnV0IHdlIGNhbiBzZXQgZnNsLGludG11eF9jaGFucyB2YWx1ZSBpcyA0
LiBUaGF0IG1lYW5zIHRoZXJlIGFyZSA4IGNoYW5uZWxzLCBidXQgYWN0dWFsbHkgd2Ugb25seSB1
c2UgNCBjaGFubmVscy4NCklmIHlvdSB0aGluayB0aGlzIG1ha2Ugbm8gc2Vuc2UsIGR1ZSB0byB3
ZSBjYW4gYXNzaWduIDQgaXRlbXMgZm9yICdpbnRlcnJ1cHRzJyB0byBnZXQgdGhlIHNhbWUgcmVz
dWx0LiBTbyB3ZSBjYW4gY291bnQgdGhlIGxlbmd0aCBvZiAnaW50ZXJydXB0cycgdG8gZ2V0IHRo
ZSBjaGFubmVscyBjb25maWd1cmVkLCB0aGVuIHRoaXMgcHJvcGVydHkgaXMgbm8gbmVlZC4NCldo
aWNoIG9uZSBkbyB5b3UgdGhpbmsgaXMgYmV0dGVyPyANCgkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDE2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KCQkJICAgICA8R0lDX1NQSSAxNyBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwNCgkJCSAgICAgPEdJQ19TUEkgMTggSVJRX1RZUEVfTEVWRUxfSElHSD4sDQoJ
CQkgICAgIDxHSUNfU1BJIDE5IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KCQkJICAgICA8R0lDX1NQ
SSAyMCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCgkJCSAgICAgPEdJQ19TUEkgMjEgSVJRX1RZUEVf
TEVWRUxfSElHSD4sDQoJCQkgICAgIDxHSUNfU1BJIDIyIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
CQkJICAgICA8R0lDX1NQSSAyMyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCgkJZnNsLGludG11eF9j
aGFucyA9IDw0PjsNCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgVGhlIG51bWJlciBv
ZiBjaGFubmVscyB1c2VkIGZvciBpbnRlcnJ1cHQgc291cmNlLiBUaGUgTWF4aW11bQ0KPiB2YWx1
ZSBpcyA4Lg0KPiA+ICsgICAgICBJZiB0aGlzIHByb3BlcnR5IGlzIG5vdCBzZXQgaW4gRFQgdGhl
biBkcml2ZXIgdXNlcyAxIGNoYW5uZWwgYnkgZGVmYXVsdC4NCj4gPiArDQo+ID4gK3JlcXVpcmVk
Og0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRz
DQo+ID4gKyAgLSBpbnRlcnJ1cHQtY29udHJvbGxlcg0KPiA+ICsgIC0gJyNpbnRlcnJ1cHQtY2Vs
bHMnDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAtIGNsb2NrLW5hbWUNCj4gPiArICAtIGZzbCxp
bnRtdXhfY2hhbnMNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+
ICsNCj4gPiArRXhhbXBsZToNCj4gPiArDQo+ID4gKwlpbnRtdXhAMzc0MDAwMDAgew0KPiANCj4g
aW50ZXJydXB0LWNvbnRyb2xsZXJALi4uDQo+IA0KPiA+ICsJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eC1pbnRtdXgiOw0KPiA+ICsJCXJlZyA9IDwweDM3NDAwMDAwIDB4MTAwMD47DQo+ID4gKwkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDE2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkgICAg
IDxHSUNfU1BJIDE3IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkgICAgIDxHSUNfU1BJ
IDE4IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkgICAgIDxHSUNfU1BJIDE5IElSUV9U
WVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkgICAgIDxHSUNfU1BJIDIwIElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KPiA+ICsJCQkgICAgIDxHSUNfU1BJIDIxIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
PiA+ICsJCQkgICAgIDxHSUNfU1BJIDIyIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsJCQkg
ICAgIDxHSUNfU1BJIDIzIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCWludGVycnVwdC1j
b250cm9sbGVyOw0KPiA+ICsJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47DQo+ID4gKwkJY2xvY2tz
ID0gPCZjbGsgSU1YOFFNX0NNNDBfSVBHX0NMSz47DQo+ID4gKwkJY2xvY2stbmFtZXMgPSAiaXBn
IjsNCj4gPiArCQlmc2wsaW50bXV4X2NoYW5zID0gPDg+Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4g
LS0NCj4gPiAyLjE3LjENCj4gPg0K
