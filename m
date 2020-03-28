Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D8C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E26A206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/IzdN/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgC1MHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:07:20 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:1601
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgC1MHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:07:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hezhyDnLO38uHZV3MdhooTdwRAGJmI5vgQfYIh1JLFYfBumcpCii59J/KZtSPzXZignmXtJmhatjFtDOs1yQNveHKIIaSX2qNGdfSjn9r8NQ2+3KR8wFaHZhaOp5L/OEwMhDCcTCpLPYwRDQztVmPdeTv69IKskTD5AJ0R0i6M1sEWC51Pg2+abUUvwjyDTRvHU29HdMQ0EGl8ISH2iyCELNdmNo39WnrrWJfcC8lWg5Rb+jr2st6K6JZlpSIRefGea/gCdi6nLeLU9oevB0Xr4nvtGOFZORqCbcnyiZ7b7/hhRN23ZqBE+LGr97kt1UkiJWZhJqqBv/HbIK0IKQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoY8QAaOpmt3mDdPHl2rTvWl0qAUsZFv0J/msLhRr3A=;
 b=Zasc2GUuhZFstEX1rJrAUk8CiGVMvd2r0iH/br+immwlJxW4Bu/q1z6OezWWO68vGenOgwyMi1Wi3mGUpq6+qBFQh/h5RPhPR8K1oOOF+h20fsntoOZw2OoUz5SzSe2xlVnUIDSTBJd7SEtfZIeqKIjSzpK6+dJEi3FG7U2N3kzOgh1Kj/CFFkMbD0Zt3sRz5dBa4lBnw8C7JsX1+GxnQ4mb641GaKlsZEV1s6JE4dscE8mCnFFUgPndHTV1faoYI1glocfHcMyXt5ecQgd0flFyYuQ4/Pp/6zxDXJgNLoodrjvrofbqnYab7hRZ0Uh4iu9l3G84+V2N3fw5LUkwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoY8QAaOpmt3mDdPHl2rTvWl0qAUsZFv0J/msLhRr3A=;
 b=O/IzdN/kHQZ11GtFU59/Wq6bSg20mmqsKAyV1GFZ68bpHMX6LN+zy+MqIrnEpA20CLxSCpJZoBdraDjH5PxHBgrHl5pC39bw/UF/3kvnRlZyKJKPRwhZ1ClcUt+Uc3OM4DePU1zu2cdNIN4iLXHoWbwEXahIkpWhTZtPdcjO1go=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3884.eurprd04.prod.outlook.com (52.134.71.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Sat, 28 Mar 2020 12:07:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2835.025; Sat, 28 Mar 2020
 12:07:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
CC:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: i.MX8MN Errors on 5.6-RC7
Thread-Topic: i.MX8MN Errors on 5.6-RC7
Thread-Index: AQHWBKuViOa/vuBTwkqHT9gRBvnGdKhd5Ing
Date:   Sat, 28 Mar 2020 12:07:15 +0000
Message-ID: <DB3PR0402MB39160D3F0D03B968B7CBE25AF5CD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
In-Reply-To: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e78e4010-d7bb-4138-715d-08d7d3108e1d
x-ms-traffictypediagnostic: DB3PR0402MB3884:|DB3PR0402MB3884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3884BDA6638183E4D779C1B8F5CD0@DB3PR0402MB3884.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(55016002)(44832011)(5660300002)(33656002)(54906003)(316002)(186003)(26005)(7416002)(110136005)(64756008)(66446008)(86362001)(81166006)(66556008)(9686003)(8676002)(76116006)(2906002)(81156014)(52536014)(6506007)(8936002)(66946007)(4326008)(66476007)(478600001)(7696005)(71200400001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvrRvq2UzBcbXsHUVsuJucIn+I/Cq22m2o2303aS0NmGBNkktt+omi/Xl6uSa9bYeHdQwPv0CVLgP5FSgTITDwbecSuHcgvfvo/tDuAzV82khrWsPTw5tk2sLT1LqNPp9IktXFGgc4VMMM4lZeEmVd04IPAJ/x7/+exL12/BVHx6CjWgvmIy1RQduj6mTvEc1jjKtQtYwpBsXC/fJLD0rCn0d9U+vDr32Awp3anOIkjJkwegRn5Nsp6wbnLX/WRj6I2qG80CmUSFJI69HfYn3K2YYXxDJ05gJhjzqsZG2Di2RN/HVKiug8NOIje//oaJibSk9mQElEJ++xGsRo3AwYaiuWw/ee+UbyYzKGo33tF7Dbw2f9xZa4smc8pXpLw/4j9LJO4c+xV8YVHd/n1ekQmy0W1DsFpShEfvB79W8tn6mNQ8kr7D7N25burYpaBh
x-ms-exchange-antispam-messagedata: 6oa+mqmV4zWy4pMUk59U580Ssj//YMaVilnJzBMbHK8B2T+ALBuBPsznjsW1+Yq09AeMXdXHkFSyQWw1Jn1LP1WqVMm1BdNF8+5o/b0i9eX/CNiGWvzDWuy3NB986U3LRWUyiyXMqfhbH5v08C36Ew==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78e4010-d7bb-4138-715d-08d7d3108e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 12:07:15.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDKSVam23zX7JnsJD8wMR9wtfA4Frlf+3NgWEbEU2yLRUyyU3CnjAWBw6RhFW+xU5ceNgDQJdHIhyPNSHGVHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFkYW0NCg0KPiBTdWJqZWN0OiBpLk1YOE1OIEVycm9ycyBvbiA1LjYtUkM3DQo+IA0KPiBJ
IGFtIGdldHRpbmcgYSBmZXcgZXJyb3JzIG9uIHRoZSBpLk1YOE1OOg0KPiANCj4gWyAgICAwLjAw
MDM2OF0gRmFpbGVkIHRvIGdldCBjbG9jayBmb3IgL3RpbWVyQDMwNmEwMDAwDQo+IFsgICAgMC4w
MDAzODBdIEZhaWxlZCB0byBpbml0aWFsaXplICcvdGltZXJAMzA2YTAwMDAnOiAtMjINCj4gWyAg
ICA3LjIwMzQ0N10gY2FhbSAzMDkwMDAwMC5jYWFtOiBGYWlsZWQgdG8gZ2V0IGNsayAnaXBnJzog
LTINCj4gWyAgICA3LjMzNDc0MV0gY2FhbSAzMDkwMDAwMC5jYWFtOiBGYWlsZWQgdG8gcmVxdWVz
dCBhbGwgbmVjZXNzYXJ5IGNsb2Nrcw0KPiBbICAgIDcuNDM4NjUxXSBjYWFtOiBwcm9iZSBvZiAz
MDkwMDAwMC5jYWFtIGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+IFsgICAgNy44NTQxOTNdIGlteC1j
cHVmcmVxLWR0OiBwcm9iZSBvZiBpbXgtY3B1ZnJlcS1kdCBmYWlsZWQgd2l0aCBlcnJvciAtMg0K
PiANCj4gSSB3YXMgY3VyaW91cyB0byBrbm93IGlmIGFueW9uZSBlbHNlIGlzIHNlZWluZyBzaW1p
bGFyIGVycm9ycy4gIEkgYWxyZWFkeQ0KPiBzdWJtaXR0ZWQgYSBwcm9wb3NlZCBmaXggZm9yIGEg
RE1BIHRpbWVvdXQgKG5vdCBzaG93biBoZXJlKSB3aGljaA0KPiBtYXRjaGVkIHdvcmsgYWxyZWFk
eSBkb25lIG9uIGkuTVg4TVEgYW5kIGkuTVg4TU0uDQo+IA0KPiBJIGFtIG5vdCBzZWVpbmcgaHVn
ZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIDhNTSBhbmQgOE1OIGluIHRoZSBub2RlcyB3aGljaA0KPiBh
ZGRyZXNzIHRoZSB0aW1lciwgY2FhbSBvciBpbXgtY3B1ZnJlcS1kdC4NCj4gDQo+IElmIGFueW9u
ZSBoYXMgYW55IHN1Z2dlc3Rpb25zLCBJJ2QgbG92ZSB0byB0cnkgdGhlbS4NCg0KV2hpY2ggYm9h
cmQgZGlkIHlvdSB0cnk/IEkganVzdCBydW4gaXQgb24gaS5NWDhNTi1FVksgYm9hcmQsIG5vIHN1
Y2ggZmFpbHVyZToNCg0Kcm9vdEBpbXg4bW5ldms6fiMgdW5hbWUgLWENCkxpbnV4IGlteDhtbmV2
ayA1LjYuMC1yYzcgIzYyMSBTTVAgUFJFRU1QVCBTYXQgTWFyIDI4IDE5OjU2OjMwIENTVCAyMDIw
IGFhcmNoNjQgYWFyY2g2NCBhYXJjaDY0IEdOVS9MaW51eA0Kcm9vdEBpbXg4bW5ldms6fiMgZG1l
c2cgfCBncmVwIGZhaWwNClsgICAgMC43MTkzNTNdIGlteC1zZG1hIDMwMmIwMDAwLmRtYS1jb250
cm9sbGVyOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgaW14L3NkbWEvc2RtYS1pbXg3ZC5iaW4g
ZmFpbGVkIHdpdGggZXJyb3IgLTINClsgICAgMC45NDEzMDRdIGNhbGxpbmcgIG5ldF9mYWlsb3Zl
cl9pbml0KzB4MC8weDggQCAxDQpbICAgIDAuOTQxMzEwXSBpbml0Y2FsbCBuZXRfZmFpbG92ZXJf
aW5pdCsweDAvMHg4IHJldHVybmVkIDAgYWZ0ZXIgMCB1c2Vjcw0KWyAgICAxLjEzNTg4NV0gY2Fs
bGluZyAgZmFpbG92ZXJfaW5pdCsweDAvMHgyNCBAIDENClsgICAgMS4xMzU4OTddIGluaXRjYWxs
IGZhaWxvdmVyX2luaXQrMHgwLzB4MjQgcmV0dXJuZWQgMCBhZnRlciA2IHVzZWNzDQpyb290QGlt
eDhtbmV2azp+Iw0KDQpUaGFua3MsDQpBbnNvbg0K
