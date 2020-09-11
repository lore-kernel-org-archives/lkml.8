Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68D0C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9863B2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pSCpWroG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKHpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:45:31 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:51684
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgIKHpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:45:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdeBdlarMKYzcATVklsxUdfnKzjW835pQk8yLbMs038HXr0qeHnwVpVUO4UQAblhGupBQB4czS5T5JHZ3YlT2E+JOeIL+TZmvpu+0kIqPK6wIebG7zonOhIejDZIPzRGZRjQ2INuINqjUg21UCmZqAydiVgeTi8zChWaZSf+rYvbwycayPxkete8qEv+Cj11YriKljPH3z3pM2w8oVDvhpwRSsfCH8Oga+rpHNGHn22MsdWRjIyZibVWJrmppsJpJ9gAizD9yU/v4Q++DyaUs5T7imU/R8pL6JFV+O0CqyKb98GS7JKLpY6Kpk0yG8w1T+QXcFZ3dYlTRpcwcvFcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzzF3d+naNcoCH+2mA4QgpgFoHst4/YYWYJKkPK12Y=;
 b=BFyFdFEZINdhaYxi1H6UDQNtftb+IpXZqXVGKsxj42VchCBfbXhhFUZo/mlzfSQnEZyNvx4CuQCKa9ViLjcfVHXz+1pv4m9M3X2pGGwtwyaBoKffDTEAP6GJujERnJgyR3ZJ0xanxkwDkOg5fulX5q7WiPCyN5zPGZsVl/3nU6OohC0l3P8ifsDhMfqb1DfwbxlzoeVQ9JJ79gqPBOGymxp3ilivfRlTpGuyBq5pAcT8yVkUFHEKoB9c9Xm0fpoUNgk91u+msMW44fXS+cQe5dxApvCc8309SouVO1OU7fsH+Q8SaTVNM3W2uhEUQbN7FPX7fYmQnYPeUcedIoe92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzzF3d+naNcoCH+2mA4QgpgFoHst4/YYWYJKkPK12Y=;
 b=pSCpWroGZUiVeSQKygQO5VwNgO2XBgWY+QUuJvcHdHUiTLtNlBkQ1hoALlTpBXZAkp3juVx3OYZvyd+30TSnnUnN4nMhnk3SmYS+bQvG7OebqQPYqR7eQlcHxlVTV58gMpTfVdlfcL3W3Wr9OgkTRYR8mOqU/aeW+n6K4at1gEM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5081.eurprd04.prod.outlook.com (2603:10a6:10:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 07:45:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 07:45:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Topic: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Index: AQHWh+zixFG3ZA2vEE+pWR2QJLTxVqljCBCAgAAGg4A=
Date:   Fri, 11 Sep 2020 07:45:20 +0000
Message-ID: <DB6PR0402MB276056780BC661041A5D604C88240@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
 <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [58.208.208.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f53e0e8-5b38-473a-ae70-08d85626a256
x-ms-traffictypediagnostic: DB7PR04MB5081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5081CD1CB4DB63FB2D81016588240@DB7PR04MB5081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0x3MkZYE4xd4vfFoKSdK01d6LPSM3FYLzwUQW8zE9xZkTv6TEjz+vmXnHqnZW8M1FrJ2NENaCKJrYkm9OTNquEWFIDSahqSFzauhJ1JzTXk2I0HKl5Vk3AaWcG08NaU+Dyt/cG0728dkgjNmJbnZEMh59gsNPPLhyEZqF4PajRInY+ob7kdndCOFRWz6oFMBuTC6VGj9FhWjFnDAutkkA6vhFBvlfmd+9oesrV8swFp+C2revDb9wTEd3PbDe+NTTk5xqWYlThE3Z0qFu2JulyiEOZKzBNLFT3NyLbHeOfT0Lt1Izj3FZwYCwwzK9gQ5gmYRDfTWQ9jPNeXDJLyKH08r2np88/uDWB14BmZ+Rxhuefr3mWUHyrngBJKzpEWxoHvgAdpNKoXrq7Wv0EHgLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(5660300002)(110136005)(8676002)(6506007)(8936002)(55016002)(71200400001)(9686003)(2906002)(316002)(478600001)(52536014)(54906003)(4326008)(966005)(86362001)(66946007)(44832011)(7696005)(76116006)(66556008)(64756008)(33656002)(66476007)(186003)(26005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M4pHqmbqdqDj0ybLJpX8lyJWjJIFQEVxuBO0KuSS3H2nvBbPRuBhdeKPd1y8TVvzmQpIiAQcWfWZGrL5gcvx9hNdJaGg+qg+omGM1DJ1RCb+mnB0lwYLFmsylAIE4og/31MTYVPIi8aZzY5LExWzR07QdKdt116bFUuIIsBNlq2lVcgJ+V5onOose94SYsGo3lpHqT/m5VTj/g8OQcWCtsN0/1UFZhCsTTcNMJlFbatqEAMW/YPCYf3DRRnZqLP+fXy7SavXKnBpZuaRoCiuCuV10z7He92GUSy2ChjGCXutkXeP/e4RSKxqCzAxvQxZ3gi9cuY8pzat2d2eQ77l2j4PtkmNJE9YH2lfB4rH+96p6gZBiOf++H7eOlmSIKmSlQqhdSn0ZAefJvCbFVl0Myzb2o6Rm5Zl8h5/VxSbiUeljvwW3PItF7HgGjpKDFY0AX59JHlgDxBniPAax/3zTn2ih8IlStTaJmldQF+Wtk8TXuBf5BttID6cb/qbviU1ZdYW7HWOxfvvwv4KqdD9mvL9QLLaVYR/F2dBR+KjJTBVmk26hRFTCVUKnkC8Q7C1tJdd5ZJ0Df8WBMz6Uask/pBTuaxPHBFIypL2EkXIj76bE4J4pCICTgrlKW+UsID1zmP9PkwC1mH+2fWB9ftJew==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f53e0e8-5b38-473a-ae70-08d85626a256
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 07:45:20.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJX/tWHkApqWC1Ktqo59TQnK9ZwRxW2zCCPf2ONK8Z4kbNSrRvT+jfYds6Q4SXz01PzaYW6RCHkYvwYWznuIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IGZzbDogYWRkIGkuTVg3VUxQ
IFBNQyBiaW5kaW5nIGRvYw0KPiANCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMSwgMjAyMCAxMTozMSBBTQ0KPiA+DQo+
ID4gQWRkIGkuTVg3VUxQIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbGxlciBiaW5kaW5nIGRvYw0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlhbWwgICB8
IDMzDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvaW14N3VscC1wbWMueWFtbA0KPiANCj4gSSB3
b25kZXIgaWYgd2UgY2FuIG1lcmdlIGl0IGludG8gdGhlIGV4aXN0IGlteDd1bHAgcG0gYmluZGlu
ZyBkb2MuDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2ZzbCxpbXg3dWxwLXBtLnlhbWwNCg0KTm90IHN1cmUgYWJvdXQgdGhpcy4NCg0KPiANCj4gPg0K
PiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlhbWwNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzNhMzFkODdkZDYyDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKw0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlhbWwNCj4gPiBAQCAtMCwwICsxLDMzIEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArJVlBTUwgMS4y
DQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9m
cmVlc2NhbGUvaW14N3VscC1wbWMueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRy
ZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogaS5NWDdV
TFAgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sbGVyKFBNQykgRGV2aWNlIFRyZWUgQmluZGluZ3MN
Cj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4g
KyAgICBpdGVtczoNCj4gPiArICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14
N3VscC1wbWMtbTQNCj4gPiArICAgICAgICAgIC0gZnNsLGlteDd1bHAtcG1jLWE3DQo+IA0KPiBD
YW4gd2UgY2hhbmdlIHRvIHRoZSBleGlzdCBuYW1pbmcgcGF0dGVybiB3aGljaCBhbHNvIGFsaWdu
IHdpdGggSFcNCj4gcmVmZXJlbmNlIG1hbnVhbD8NCj4gZS5nLg0KPiBmc2wsaW14N3VscC1wbWMw
DQo+IGZzbCxpbXg3dWxwLXBtYzENCg0KVGhpcyB3YXMgcmVqZWN0ZWQgYnkgU2hhd24gYmVmb3Jl
Lg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTM5MDU5MS8NCg0KVGhhbmtz
LA0KUGVuZy4NCg0KPiANCj4gQWxpZ25lZCB3aXRoOg0KPiBmc2wsaW14N3VscC1zbWMxDQo+IGZz
bCxpbXg3dWxwLXBjYzINCj4gZnNsLGlteDd1bHAtc2NnMQ0KPiANCj4gUmVnYXJkcw0KPiBBaXNo
ZW5nDQo+IA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsN
Cj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiAr
DQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6
DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBwbWMwOiBwbWMtbTRANDEwYTEwMDAgew0KPiA+ICsgICAg
ICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcG1jLW00IjsNCj4gPiArICAgICAgICByZWcg
PSA8MHg0MTBhMTAwMCAweDEwMDA+Ow0KPiA+ICsgICAgfTsNCj4gPiAtLQ0KPiA+IDIuMjguMA0K
DQo=
