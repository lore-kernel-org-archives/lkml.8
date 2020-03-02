Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76E6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F6721D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRXOXMml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCBJ66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:58:58 -0500
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:6017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgCBJ65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:58:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUspKe4E1mBl6EgJHVlxvFN2Q+HlQsNudNkygkqWDE5bh91uYSsFLmV40wfsz8aVacpDo1xYe6MH1P+X/jQDfAL4rexD1uSVq0IcGMQyIATAtIz9urCgumUVGINrTAViKu7GWsPn8/6wmAPV51/TwcrKMw3dJlodalIH0+qOA80rAprjsI0WPJFA73zwm/P3WpMvyfd3/P+ISITogP44W6bw5GeMjyl6UJ7knp2PRaS+Ifmz+h/XaKtfFSLojxXvn71LNFh6aD6ucmPee5ZYRD0yyuAf3XcCaRAAr2a2eugO4L6Ml40A7pHwviYOReUCdpiexAKgRgBJ1s7btNsHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlhgFPe5sB4a5YBFOi50EM1LMRozKvVN3u/+SVra8FU=;
 b=bQTQQlqDApcwoeBlYpLjmCSiFLVnrPQRGRobOOgI7XgoDOKXlmdPOB7sbHTjgzylEKFZ5IT2CmyBeS5VMy4nG7uto/vkva/fj6PTPA9PRMOJzE2YuwA49qY3DN4QDxMRtiaEYlYFMRaOYh4pg3pjSwfJwdQaC6jwk1wWLYCI0TXHZxDuFoYr63d6iMtAGtypgPbWvrASkaCtkES49YwKM+yNMzEAIXi3oJWIxvFUxP5mbLPbs50wsXdOWzphoXvFYfgW66DcXptwx6KAJ9aWw6Q0L/BMkDLNW8GbjISdhOwj8ejcDsEAu29QlaT4T0rP2rx80QL2rddsJMBvfHTzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlhgFPe5sB4a5YBFOi50EM1LMRozKvVN3u/+SVra8FU=;
 b=SRXOXMmlv0x/LDb9Gts9e+bo18HznmjuNWZdNJH6/8JfjjM7aOQnS2CLJ9CFa65EkJtNCcZsbeygh//JEbl/WRhCIW5CADqFb7Lp3eO2j9KUah8To07PgwDNtMAqLaCzqBZ5Ip+erehBoGXoUOdTAPTs5UKxDCp9suHJssjJnJQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5907.eurprd04.prod.outlook.com (20.178.202.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 09:58:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:58:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3 2/4] mailbox: imx: restructure code to make easy for
 new MU
Thread-Topic: [PATCH V3 2/4] mailbox: imx: restructure code to make easy for
 new MU
Thread-Index: AQHV7F/D1+t3dxfBAkOPMOPdKAM1H6g1DAcAgAAM5uA=
Date:   Mon, 2 Mar 2020 09:58:52 +0000
Message-ID: <AM0PR04MB4481E7A469C74773C387B00488E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
 <1582692043-683-3-git-send-email-peng.fan@nxp.com>
 <67ebbf3d-d6aa-17fc-5110-eead63c8232d@pengutronix.de>
In-Reply-To: <67ebbf3d-d6aa-17fc-5110-eead63c8232d@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69750752-07d9-4703-c1a8-08d7be90503c
x-ms-traffictypediagnostic: AM0PR04MB5907:|AM0PR04MB5907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5907F7465B97E658991C709E88E70@AM0PR04MB5907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(9686003)(316002)(478600001)(76116006)(45080400002)(4326008)(7696005)(55016002)(8936002)(53546011)(54906003)(33656002)(186003)(6506007)(110136005)(81156014)(8676002)(81166006)(26005)(52536014)(86362001)(2906002)(5660300002)(15650500001)(66946007)(66556008)(64756008)(966005)(66476007)(66446008)(44832011)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5907;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKprHsYJq6SGI8EZGrIjhiMxa9/ARHaSoFxVAkuoZFVAxdeibnMjH1dJ+Bd/mjxYOyu9QAUWK7+BxNfEzF0pA/wqXU4C79lrq7974lzz2nIFXgZF1g2s8PsFbHavugfI/RblDeCPZnG9fv2ttrWolmK9gCZUVh0gKO8/novNQeE7QR20NHQbFpV96s+TOe+HxFSt/NitFZKiSWnaDW9PYAuYKGLn7Yf0EuQrX+vbc2xReCZe0oA26vK+VNp7jwfS8Tto6xYovg4xgPvbjMZkdWSQHPWwMRLsW8Qlx+Tw109RSezqD5lXW3QiLcSf2f1VCHPaHAFyUPKwJZMqcBv+f/KKvxjWEQ/fZsF6iclV1CMfZghusauA3xUK97mRaRRkzs2lo6td8Y6FoMboq6g3X1s6oDJq5ONDDt39B0fznjUOAWRfadCYMVkr862COAw8yc5xRXvY23QIZuX3SoUEuweC7djCCeUySVAqr8KKunJ0TNqLKL3A7i5vUIYcnXZSirVoDQyTbaTDIT2hcxTbbQ==
x-ms-exchange-antispam-messagedata: pS3VgG0QHCRm0ySM55bsLZv4S2r6Z5xxN54i+q1Ghp20x1D+sLdqUJBj6jCa4aUkipJB7mGCmNNvthKLH34dTRUNIAF7bgiWtDH4J/b6sZGnAvYj9aMomp/Q/KOV91HpHwqntZ6NRFr6hM5vam0uUg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69750752-07d9-4703-c1a8-08d7be90503c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 09:58:52.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01D0Vlx8rcllXkxcp/dqYYcIqUk4zSN/NaAW7cvrFKqHSw4/p3f66hqehPWEinzaxI9tglqBZ+NjHdXFUX62hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDIvNF0gbWFpbGJveDogaW14
OiByZXN0cnVjdHVyZSBjb2RlIHRvIG1ha2UgZWFzeSBmb3INCj4gbmV3IE1VDQo+IA0KPiBIaSBQ
ZW5nLA0KPiANCj4gT24gMjYuMDIuMjAgMDU6NDAsIHBlbmcuZmFuQG54cC5jb20gd3JvdGU6DQo+
ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgaW14X211
X2dlbmVyaWNfdHggZm9yIGRhdGEgc2VuZCBhbmQgaW14X211X2dlbmVyaWNfcnggZm9yDQo+ID4g
aW50ZXJydXB0IGRhdGEgcmVjZWl2ZS4NCj4gPiBBZGQgJ3R5cGUnIGZvciBNVSB0eXBlLg0KPiA+
DQo+ID4gV2l0aCB0aGVzZSwgaXQgd2lsbCBiZSBhIGJpdCBlYXN5IHRvIGludHJvZHVjZSBpLk1Y
OC84WCBTQ1UgdHlwZSBNVQ0KPiA+IGRlZGljYXRlZCB0byBjb21tdW5pY2F0ZSB3aXRoIFNDVS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+DQo+ID4gVjM6DQo+ID4gICBOZXcgcGF0Y2gsIHJlc3RydWN0dXJlIGNvZGUuDQo+
ID4NCj4gPiAgIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIHwgMTAwDQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDY3IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4gYi9kcml2ZXJzL21haWxib3gvaW14
LW1haWxib3guYyBpbmRleCAyY2RjZGM1ZjExMTkuLjkwMWEzNDMxZmRiNQ0KPiA+IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiBAQCAtMzYsNyArMzYsMTcgQEAgZW51bSBpbXhf
bXVfY2hhbl90eXBlIHsNCj4gPiAgIAlJTVhfTVVfVFlQRV9SWERCLAkvKiBSeCBkb29yYmVsbCAq
Lw0KPiA+ICAgfTsNCj4gPg0KPiA+ICtlbnVtIGlteF9tdV90eXBlIHsNCj4gPiArCUlNWF9NVV9U
WVBFX0dFTkVSSUMsDQo+ID4gK307DQo+IA0KPiBJIGFzc3VtZSB0aGlzIGVudW0gaXMgbm90IG5l
ZWRlZCwgc2VlIG15IG5leHQgZW1haWwNCg0KVGhpcyBpcyB0byBqdXN0IGRpZmZlcmVudGlhdGUg
d2l0aCBTQ1UgTVUsIG9rLCB3aWxsIGNoZWNrIHlvdXIgbmV4dCBlbWFpbC4NClRoZW4gYmFjayBp
ZiBhbnl0aGluZyBJIG5vdCBmb2xsb3cgdXAuDQoNCj4gPiArc3RydWN0IGlteF9tdV9wcml2Ow0K
PiA+ICtzdHJ1Y3QgaW14X211X2Nvbl9wcml2Ow0KPiA+ICsNCj4gPiAgIHN0cnVjdCBpbXhfbXVf
ZGNmZyB7DQo+ID4gKwllbnVtIGlteF9tdV90eXBlIHR5cGU7DQo+ID4gKwlpbnQgKCp0eCkoc3Ry
dWN0IGlteF9tdV9wcml2ICpwcml2LCBzdHJ1Y3QgaW14X211X2Nvbl9wcml2ICpjcCwgdm9pZA0K
PiAqZGF0YSk7DQo+ID4gKwlpbnQgKCpyeCkoc3RydWN0IGlteF9tdV9wcml2ICpwcml2LCBzdHJ1
Y3QgaW14X211X2Nvbl9wcml2ICpjcCk7DQo+ID4gICAJdTMyCXhUUls0XTsJCS8qIFRyYW5zbWl0
IFJlZ2lzdGVycyAqLw0KPiA+ICAgCXUzMgl4UlJbNF07CQkvKiBSZWNlaXZlIFJlZ2lzdGVycyAq
Lw0KPiA+ICAgCXUzMgl4U1I7CQkvKiBTdGF0dXMgUmVnaXN0ZXIgKi8NCj4gPiBAQCAtNjcsMjAg
Kzc3LDYgQEAgc3RydWN0IGlteF9tdV9wcml2IHsNCj4gPiAgIAlib29sCQkJc2lkZV9iOw0KPiA+
ICAgfTsNCj4gPg0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGlteF9tdV9kY2ZnIGlteF9tdV9j
ZmdfaW14NnN4ID0gew0KPiA+IC0JLnhUUgk9IHsweDAsIDB4NCwgMHg4LCAweGN9LA0KPiA+IC0J
LnhSUgk9IHsweDEwLCAweDE0LCAweDE4LCAweDFjfSwNCj4gPiAtCS54U1IJPSAweDIwLA0KPiA+
IC0JLnhDUgk9IDB4MjQsDQo+ID4gLX07DQo+ID4gLQ0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0
IGlteF9tdV9kY2ZnIGlteF9tdV9jZmdfaW14N3VscCA9IHsNCj4gPiAtCS54VFIJPSB7MHgyMCwg
MHgyNCwgMHgyOCwgMHgyY30sDQo+ID4gLQkueFJSCT0gezB4NDAsIDB4NDQsIDB4NDgsIDB4NGN9
LA0KPiA+IC0JLnhTUgk9IDB4NjAsDQo+ID4gLQkueENSCT0gMHg2NCwNCj4gPiAtfTsNCj4gDQo+
IFBsZWFzZSwgZG8gbm90IG1vdmUgaXQuDQoNCk9rLiBUaGVuIEkgbmVlZCB0byBhZGQgaW14X211
X2dlbmVyaWNfdHggcHJvdG90eXBlIGFib3ZlIHRoZQ0KdXBwZXIgdHdvLg0KDQpUaGFua3MsDQpQ
ZW5nLg0KDQo+IA0KPiA+ICAgc3RhdGljIHN0cnVjdCBpbXhfbXVfcHJpdiAqdG9faW14X211X3By
aXYoc3RydWN0IG1ib3hfY29udHJvbGxlcg0KPiAqbWJveCkNCj4gPiAgIHsNCj4gPiAgIAlyZXR1
cm4gY29udGFpbmVyX29mKG1ib3gsIHN0cnVjdCBpbXhfbXVfcHJpdiwgbWJveCk7IEBAIC0xMTEs
Ng0KPiA+ICsxMDcsNDAgQEAgc3RhdGljIHUzMiBpbXhfbXVfeGNyX3JtdyhzdHJ1Y3QgaW14X211
X3ByaXYgKnByaXYsIHUzMiBzZXQsDQo+IHUzMiBjbHIpDQo+ID4gICAJcmV0dXJuIHZhbDsNCj4g
PiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGlteF9tdV9nZW5lcmljX3R4KHN0cnVjdCBpbXhf
bXVfcHJpdiAqcHJpdiwNCj4gPiArCQkJICAgICBzdHJ1Y3QgaW14X211X2Nvbl9wcml2ICpjcCwN
Cj4gPiArCQkJICAgICB2b2lkICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwl1MzIgKmFyZyA9IGRhdGE7
DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChjcC0+dHlwZSkgew0KPiA+ICsJY2FzZSBJTVhfTVVfVFlQ
RV9UWDoNCj4gPiArCQlpbXhfbXVfd3JpdGUocHJpdiwgKmFyZywgcHJpdi0+ZGNmZy0+eFRSW2Nw
LT5pZHhdKTsNCj4gPiArCQlpbXhfbXVfeGNyX3Jtdyhwcml2LCBJTVhfTVVfeENSX1RJRW4oY3At
PmlkeCksIDApOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBJTVhfTVVfVFlQRV9UWERCOg0K
PiA+ICsJCWlteF9tdV94Y3Jfcm13KHByaXYsIElNWF9NVV94Q1JfR0lSbihjcC0+aWR4KSwgMCk7
DQo+ID4gKwkJdGFza2xldF9zY2hlZHVsZSgmY3AtPnR4ZGJfdGFza2xldCk7DQo+ID4gKwkJYnJl
YWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCWRldl93YXJuX3JhdGVsaW1pdGVkKHByaXYtPmRl
diwgIlNlbmQgZGF0YSBvbiB3cm9uZyBjaGFubmVsDQo+IHR5cGU6ICVkXG4iLCBjcC0+dHlwZSk7
DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgaW14X211X2dlbmVyaWNfcngoc3RydWN0
IGlteF9tdV9wcml2ICpwcml2LA0KPiA+ICsJCQkgICAgIHN0cnVjdCBpbXhfbXVfY29uX3ByaXYg
KmNwKQ0KPiA+ICt7DQo+ID4gKwl1MzIgZGF0Ow0KPiA+ICsNCj4gPiArCWRhdCA9IGlteF9tdV9y
ZWFkKHByaXYsIHByaXYtPmRjZmctPnhSUltjcC0+aWR4XSk7DQo+ID4gKwltYm94X2NoYW5fcmVj
ZWl2ZWRfZGF0YShjcC0+Y2hhbiwgKHZvaWQgKikmZGF0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGlteF9tdV90eGRiX3Rhc2tsZXQo
dW5zaWduZWQgbG9uZyBkYXRhKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBpbXhfbXVfY29uX3By
aXYgKmNwID0gKHN0cnVjdCBpbXhfbXVfY29uX3ByaXYgKilkYXRhOyBAQA0KPiA+IC0xMjMsNyAr
MTUzLDcgQEAgc3RhdGljIGlycXJldHVybl90IGlteF9tdV9pc3IoaW50IGlycSwgdm9pZCAqcCkN
Cj4gPiAgIAlzdHJ1Y3QgbWJveF9jaGFuICpjaGFuID0gcDsNCj4gPiAgIAlzdHJ1Y3QgaW14X211
X3ByaXYgKnByaXYgPSB0b19pbXhfbXVfcHJpdihjaGFuLT5tYm94KTsNCj4gPiAgIAlzdHJ1Y3Qg
aW14X211X2Nvbl9wcml2ICpjcCA9IGNoYW4tPmNvbl9wcml2Ow0KPiA+IC0JdTMyIHZhbCwgY3Ry
bCwgZGF0Ow0KPiA+ICsJdTMyIHZhbCwgY3RybDsNCj4gPg0KPiA+ICAgCWN0cmwgPSBpbXhfbXVf
cmVhZChwcml2LCBwcml2LT5kY2ZnLT54Q1IpOw0KPiA+ICAgCXZhbCA9IGlteF9tdV9yZWFkKHBy
aXYsIHByaXYtPmRjZmctPnhTUik7IEBAIC0xNTIsOCArMTgyLDcgQEANCj4gPiBzdGF0aWMgaXJx
cmV0dXJuX3QgaW14X211X2lzcihpbnQgaXJxLCB2b2lkICpwKQ0KPiA+ICAgCQlpbXhfbXVfeGNy
X3Jtdyhwcml2LCAwLCBJTVhfTVVfeENSX1RJRW4oY3AtPmlkeCkpOw0KPiA+ICAgCQltYm94X2No
YW5fdHhkb25lKGNoYW4sIDApOw0KPiA+ICAgCX0gZWxzZSBpZiAodmFsID09IElNWF9NVV94U1Jf
UkZuKGNwLT5pZHgpKSB7DQo+ID4gLQkJZGF0ID0gaW14X211X3JlYWQocHJpdiwgcHJpdi0+ZGNm
Zy0+eFJSW2NwLT5pZHhdKTsNCj4gPiAtCQltYm94X2NoYW5fcmVjZWl2ZWRfZGF0YShjaGFuLCAo
dm9pZCAqKSZkYXQpOw0KPiA+ICsJCXByaXYtPmRjZmctPnJ4KHByaXYsIGNwKTsNCj4gPiAgIAl9
IGVsc2UgaWYgKHZhbCA9PSBJTVhfTVVfeFNSX0dJUG4oY3AtPmlkeCkpIHsNCj4gPiAgIAkJaW14
X211X3dyaXRlKHByaXYsIElNWF9NVV94U1JfR0lQbihjcC0+aWR4KSwNCj4gcHJpdi0+ZGNmZy0+
eFNSKTsNCj4gPiAgIAkJbWJveF9jaGFuX3JlY2VpdmVkX2RhdGEoY2hhbiwgTlVMTCk7IEBAIC0x
NjksMjMgKzE5OCw4DQo+IEBAIHN0YXRpYw0KPiA+IGludCBpbXhfbXVfc2VuZF9kYXRhKHN0cnVj
dCBtYm94X2NoYW4gKmNoYW4sIHZvaWQgKmRhdGEpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGlt
eF9tdV9wcml2ICpwcml2ID0gdG9faW14X211X3ByaXYoY2hhbi0+bWJveCk7DQo+ID4gICAJc3Ry
dWN0IGlteF9tdV9jb25fcHJpdiAqY3AgPSBjaGFuLT5jb25fcHJpdjsNCj4gPiAtCXUzMiAqYXJn
ID0gZGF0YTsNCj4gPiAtDQo+ID4gLQlzd2l0Y2ggKGNwLT50eXBlKSB7DQo+ID4gLQljYXNlIElN
WF9NVV9UWVBFX1RYOg0KPiA+IC0JCWlteF9tdV93cml0ZShwcml2LCAqYXJnLCBwcml2LT5kY2Zn
LT54VFJbY3AtPmlkeF0pOw0KPiA+IC0JCWlteF9tdV94Y3Jfcm13KHByaXYsIElNWF9NVV94Q1Jf
VElFbihjcC0+aWR4KSwgMCk7DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQljYXNlIElNWF9NVV9UWVBF
X1RYREI6DQo+ID4gLQkJaW14X211X3hjcl9ybXcocHJpdiwgSU1YX01VX3hDUl9HSVJuKGNwLT5p
ZHgpLCAwKTsNCj4gPiAtCQl0YXNrbGV0X3NjaGVkdWxlKCZjcC0+dHhkYl90YXNrbGV0KTsNCj4g
PiAtCQlicmVhazsNCj4gPiAtCWRlZmF1bHQ6DQo+ID4gLQkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQo
cHJpdi0+ZGV2LCAiU2VuZCBkYXRhIG9uIHdyb25nIGNoYW5uZWwNCj4gdHlwZTogJWRcbiIsIGNw
LT50eXBlKTsNCj4gPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAtCX0NCj4gPg0KPiA+IC0JcmV0
dXJuIDA7DQo+ID4gKwlyZXR1cm4gcHJpdi0+ZGNmZy0+dHgocHJpdiwgY3AsIGRhdGEpOw0KPiA+
ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IGlteF9tdV9zdGFydHVwKHN0cnVjdCBtYm94X2No
YW4gKmNoYW4pIEBAIC0zNjcsNiArMzgxLDI2DQo+ID4gQEAgc3RhdGljIGludCBpbXhfbXVfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4g
ICB9DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfbXVfZGNmZyBpbXhfbXVfY2Zn
X2lteDZzeCA9IHsNCj4gPiArCS50eXBlCT0gSU1YX01VX1RZUEVfR0VORVJJQywNCj4gPiArCS50
eAk9IGlteF9tdV9nZW5lcmljX3R4LA0KPiA+ICsJLnJ4CT0gaW14X211X2dlbmVyaWNfcngsDQo+
ID4gKwkueFRSCT0gezB4MCwgMHg0LCAweDgsIDB4Y30sDQo+ID4gKwkueFJSCT0gezB4MTAsIDB4
MTQsIDB4MTgsIDB4MWN9LA0KPiA+ICsJLnhTUgk9IDB4MjAsDQo+ID4gKwkueENSCT0gMHgyNCwN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X211X2RjZmcgaW14
X211X2NmZ19pbXg3dWxwID0gew0KPiA+ICsJLnR5cGUJPSBJTVhfTVVfVFlQRV9HRU5FUklDLA0K
PiA+ICsJLnR4CT0gaW14X211X2dlbmVyaWNfdHgsDQo+ID4gKwkucngJPSBpbXhfbXVfZ2VuZXJp
Y19yeCwNCj4gPiArCS54VFIJPSB7MHgyMCwgMHgyNCwgMHgyOCwgMHgyY30sDQo+ID4gKwkueFJS
CT0gezB4NDAsIDB4NDQsIDB4NDgsIDB4NGN9LA0KPiA+ICsJLnhTUgk9IDB4NjAsDQo+ID4gKwku
eENSCT0gMHg2NCwNCj4gPiArfTsNCj4gPiArDQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBpbXhfbXVfZHRfaWRzW10gPSB7DQo+ID4gICAJeyAuY29tcGF0aWJsZSA9ICJm
c2wsaW14N3VscC1tdSIsIC5kYXRhID0gJmlteF9tdV9jZmdfaW14N3VscCB9LA0KPiA+ICAgCXsg
LmNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1tdSIsIC5kYXRhID0gJmlteF9tdV9jZmdfaW14NnN4
IH0sDQo+ID4NCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gT2xla3NpaiBSZW1wZWwNCj4gDQo+IC0t
DQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+IHwNCj4g
SW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9l
dXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3
d3cucA0KPiBlbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZW5nLmZhbiU0MG54
cC5jb20lN0NjZjY2MGMNCj4gMzkwOWUxNDEyOGU2NWYwOGQ3YmU4OTg5MDUlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSUNCj4gN0MwJTdDMCU3QzYzNzE4NzM3MDIyNDk2NzU1NCZh
bXA7c2RhdGE9WmRnSUd1enBuaFgxbGlRTzRLbUN0WHgNCj4gampnJTJCbkRKb1B6ZTRwZlZYSUFp
ZyUzRCZhbXA7cmVzZXJ2ZWQ9MCAgfA0KPiBQZWluZXIgU3RyLiA2LTgsIDMxMTM3IEhpbGRlc2hl
aW0sIEdlcm1hbnkgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTANCj4gfA0KPiBBbXRzZ2VyaWNo
dCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6DQo+ICs0OS01MTIxLTIwNjkx
Ny01NTU1IHwNCg==
