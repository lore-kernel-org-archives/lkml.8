Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B9C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E9C2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IwIsVSdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDZDyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:54:39 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:39398
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgDZDyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 23:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqrupCWvrV5Yca3Cx6wgxt5Ao8BEHATMywqBjWQnvLhrSddBBrPw7JwBulvLGR4OvRqOQ6JJ4mT7J0eJuTdRs+Klqaa6DwOv8F5ncsnNij/uchJJQuKIs3ZA7UoBhjYYjfkxr2mG8PFaxpQHkxVOLH5fZ4oVLU1mYiqcuhruDsaeWqO23XUkLY/6X8nFvw+jBNljIzo6F7BuBu+4i3a834+Xu0U4XD8mMxscqkfgcWoknRJYjG3JaOCVUY7pM3tPSOhe7ZMiIC36C/HfMPHpVuShBvLieZFWEIx52pLXJagrirsvB/tYlJ4ZLMGlSdT3wX5TE8LaeUpdxO+7wUxL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxPF0cO5ibrbvdqUW2Bs/B7h3XnwrSxxTOKeDeSUcsY=;
 b=Q+zdMBHXbUG4HaXX+6Go/9n8lZpOsO3yL4sQNmb30dNZe7rpD8s2flfXXQXF6cARTR247/xgWrOoSUbb+EbYv3Uf2Js5f/0aWPJ4O2oojKZMumaXJUKpt1lH6voNi/whCMjrLqN3kQ5XNlrI4p4Py98AbjxrQsHQ5qQiTXjgHPszP0HfcsdnzidRniUbINRFY0JZch0rC6YszxNyRApZVQRqzAf6SAuFdycF3YdJaA6iME2ZrvIC1LMJBRgGO2nh1JoXxl5vLygdtevfrmnAo13SJ6g1RDV1HV299m78LiVE+Xp1PJohnWOZglDU+0iq4YAhO7tfg2Z3gZbL85DsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxPF0cO5ibrbvdqUW2Bs/B7h3XnwrSxxTOKeDeSUcsY=;
 b=IwIsVSdWKXuDaUD8b2XfVlDFSdUSXDxeqLyFQjXrQHtQ+/CUjVti+zv8Yci1CHKp5gSjjuz6ZyAQVcwBZg+FwJ2hU5wLinCAbUqVM0vo9y2b5fiACSwULCs8C7FTVdmWsIX4Hb2JBABHYa9Dve4qhbA4+ZM0j/thnpwCTu2W1eE=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5478.eurprd04.prod.outlook.com (2603:10a6:20b:97::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 03:54:32 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 03:54:32 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 02/10] clk: imx8m: drop clk_hw_set_parent for A53
Thread-Topic: [PATCH V2 02/10] clk: imx8m: drop clk_hw_set_parent for A53
Thread-Index: AQHV+Fi7h9gjE1v5bESNTMZ7t/IAMqiLC02w
Date:   Sun, 26 Apr 2020 03:54:32 +0000
Message-ID: <AM6PR04MB49667AF484D4609B5B5436B080AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5da8c593-d347-4968-2c35-08d7e9958718
x-ms-traffictypediagnostic: AM6PR04MB5478:|AM6PR04MB5478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB547852724203415DEC7ADCAC80AE0@AM6PR04MB5478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(9686003)(110136005)(4326008)(55016002)(7416002)(186003)(8676002)(86362001)(5660300002)(52536014)(6506007)(7696005)(44832011)(6636002)(2906002)(54906003)(66476007)(66946007)(316002)(478600001)(64756008)(66556008)(8936002)(66446008)(33656002)(81156014)(76116006)(26005)(71200400001)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLPhHnnn7zuCtBAWsaY7JOfOIHmF83cYPe6LG3UP2wi3NQQ0oelF7kfY5d+rXrTd/hMUoKHqrwVPvy9mZh18nk1NSgE2+Uiu67VcZ4k0M2VsBr3ZmjaZQ/Sv8g/Rv2ftHECRGResQ97b8o+mofw4K/ESXamgq/PanLNkhjFKnzcfheMM5dnEp87hBo6zW+RamZshoc453x8Ek4UZ70KnF8+gaiEKKUBJnp5VMQzF1L40kWnQDBeoZ3LAgHx6M0Ia7HG880IBdokKidparEah/tiodVRn+l59BExm/gGJ7exJ2SyPp5nApvttFHFiapiIS6MCLbpe8RAw6MAiJNFVAX86r8DEXC68VO56sGLwFMYPCRMtKaICnZvohYXUcNWWSm5JPeGQ3hxlun5ephqIOn/sojgCGvlnSSQNDnLEIWgo1rHFG35u87X2SINzwrT9/PLLKe79dYgUgt96KJR49AeZvLIY579w80ox7XMsxLMWDoz0I2xqflIHz2tEPTUX
x-ms-exchange-antispam-messagedata: 6UO+mXJbtNh3Qxie+qkJBeJMZyr6u0oMckjhm/wnUzYMiCuiiUUH7EDOsxgrd8awyna4qfBEmWThQ6eEHtbJW2IV/xtHG3MtSZTiS3XBA0hVfDDvaXitdaEI9cN8ynT1hpLktVRHaekNZt38aKM/0G953sBQTMzOAEG+7N1O5vzYgIeeKIG+5Xi3Xh5858P9qQMGKOtzogJylijgWNx/Dh+SK+ENslwBIaCiTJk8lsHk15NO1WprFgUthRjGc8doN8+l/aURz6/UhvzH1Y+MKllxfUGwlkZVfxS1frggemdcy0gmE6ghbqJDKQSHax80sfBZ2CqlnPjePjhrjAA9uzTfQi+k6cLjvbOHooW8uqciYxuSDm6WDnYpXozcfZsqGrnK66XTTzr4I/uhQzzeWHZPTF+RIAa1keG26JSYz05mIe2tkch+1wNbxMoT/mWaZ3x5JD2XatxDQcdB3llkuMSlSkuCRXhM6NdgcMZfB8bCJYNwq7xrSSvp4/Cms0ndPHpW7g9HlV/2AbWj1u5DZ5qLvXxZiYSXE/minAWA6vWGDBaNEexnbsNHHK14AAm5MB9cZxC82kDGFoBcGXtFTeuTD/77tTiGpVxH+tQqKNhRaxky32A6kw8CWF+mhsbOkXeiDif95flzilbQoR5n7f6GlMzzWvZmEehqYvYN9VQTAhTTSRSb11xfMGklrMo+5k+/5RGaWiPD2UwSkug/M32WwbTp6WjC+6qIgriXJSEMeCMQltLUpoTtK3eGAdF+PMNn6PW3GdYGgUR7VtqDcHz6ldMM8H0Lcl7/DywbC60=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da8c593-d347-4968-2c35-08d7e9958718
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 03:54:32.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x94cnUCKR8dunjxcCfn1OyDUlV0JQZUEOLQS++PANtUU8cizGKM4ADPOCvDLXqD3zoVNAZe2U14/ZmOQd3PSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEyLCAyMDIwIDY6MjAgUE0NCj4gDQo+IFRoZSBwYXJlbnQgc2V0dGluZ3MgaGF2ZSBiZWVu
IG1vdmVkIHRvIGR0c2ksIHdlIG5vIG5lZWQgdG8gc2V0IHBhcmVudCBoZXJlLiBBbmQNCj4gY2xr
X2h3X3NldF9wYXJlbnQgd2lsbCB0cmlnZ2VyIGxvY2tkZXAgd2FybmluZywgYmVjYXVzZSB0aGlz
IGFwaSBub3QgaGF2ZQ0KPiBwcmVwYXJlX2xvY2suDQo+IA0KPiBSZXBvcnRlZC1ieTogTGVvbmFy
ZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCkZvciB0aGUgcGF0Y2g6DQpSZXZpZXdlZC1ieTog
RG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KQlRXLCBXaGF0IGtpbmQgb2Yg
bG9ja2RlcCB3YXJuaW5nPyANCkRvIHlvdSBtZWFuIGl0J3MgZ2VuZXJpYyBpc3N1ZSB0aGF0IHdl
IGNhbid0IHVzZSBjbGtfaHdfc2V0X3BhcmVudCBpbiBjbG9jayBkcml2ZXI/DQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMgfCAzIC0t
LQ0KPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYyB8IDMgLS0tDQo+ICBkcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDhtcC5jIHwgMyAtLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1x
LmMgfCAzIC0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jIGIvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg4bW0uYyBpbmRleA0KPiA5MjU2NzA0MzhmMjMuLjU0MzUwNDJhMDZlMyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYw0KPiArKysgYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDhtbS5jDQo+IEBAIC02MTQsOSArNjE0LDYgQEAgc3RhdGljIGludCBpbXg4
bW1fY2xvY2tzX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQkJ
CSAgIGh3c1tJTVg4TU1fQVJNX1BMTF9PVVRdLT5jbGssDQo+ICAJCQkJCSAgIGh3c1tJTVg4TU1f
Q0xLX0E1M19ESVZdLT5jbGspOw0KPiANCj4gLQljbGtfaHdfc2V0X3BhcmVudChod3NbSU1YOE1N
X0NMS19BNTNfU1JDXSwNCj4gaHdzW0lNWDhNTV9TWVNfUExMMV84MDBNXSk7DQo+IC0JY2xrX2h3
X3NldF9wYXJlbnQoaHdzW0lNWDhNTV9DTEtfQTUzX0NPUkVdLA0KPiBod3NbSU1YOE1NX0FSTV9Q
TExfT1VUXSk7DQo+IC0NCj4gIAlpbXhfY2hlY2tfY2xrX2h3cyhod3MsIElNWDhNTV9DTEtfRU5E
KTsNCj4gDQo+ICAJcmV0ID0gb2ZfY2xrX2FkZF9od19wcm92aWRlcihucCwgb2ZfY2xrX2h3X29u
ZWNlbGxfZ2V0LCBjbGtfaHdfZGF0YSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgv
Y2xrLWlteDhtbi5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYyBpbmRleA0KPiAwYmM3
MDcwMjM1YmQuLjZjYWM2Y2EwM2UxMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Ns
ay1pbXg4bW4uYw0KPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jDQo+IEBAIC01
NjUsOSArNTY1LDYgQEAgc3RhdGljIGludCBpbXg4bW5fY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJCQkJCSAgIGh3c1tJTVg4TU5fQVJNX1BMTF9PVVRd
LT5jbGssDQo+ICAJCQkJCSAgIGh3c1tJTVg4TU5fQ0xLX0E1M19ESVZdLT5jbGspOw0KPiANCj4g
LQljbGtfaHdfc2V0X3BhcmVudChod3NbSU1YOE1OX0NMS19BNTNfU1JDXSwNCj4gaHdzW0lNWDhN
Tl9TWVNfUExMMV84MDBNXSk7DQo+IC0JY2xrX2h3X3NldF9wYXJlbnQoaHdzW0lNWDhNTl9DTEtf
QTUzX0NPUkVdLA0KPiBod3NbSU1YOE1OX0FSTV9QTExfT1VUXSk7DQo+IC0NCj4gIAlpbXhfY2hl
Y2tfY2xrX2h3cyhod3MsIElNWDhNTl9DTEtfRU5EKTsNCj4gDQo+ICAJcmV0ID0gb2ZfY2xrX2Fk
ZF9od19wcm92aWRlcihucCwgb2ZfY2xrX2h3X29uZWNlbGxfZ2V0LCBjbGtfaHdfZGF0YSk7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jIGIvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4bXAuYyBpbmRleA0KPiA0MTQ2OWUyY2MzZGUuLmUwNWVjNTZkZjI4NSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYw0KPiArKysgYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhtcC5jDQo+IEBAIC03MzUsOSArNzM1LDYgQEAgc3RhdGljIGludCBp
bXg4bXBfY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJ
CQkJCSAgICAgaHdzW0lNWDhNUF9BUk1fUExMX09VVF0tPmNsaywNCj4gIAkJCQkJICAgICBod3Nb
SU1YOE1QX0NMS19BNTNfRElWXS0+Y2xrKTsNCj4gDQo+IC0JY2xrX2h3X3NldF9wYXJlbnQoaHdz
W0lNWDhNUF9DTEtfQTUzX1NSQ10sDQo+IGh3c1tJTVg4TVBfU1lTX1BMTDFfODAwTV0pOw0KPiAt
CWNsa19od19zZXRfcGFyZW50KGh3c1tJTVg4TVBfQ0xLX0E1M19DT1JFXSwNCj4gaHdzW0lNWDhN
UF9BUk1fUExMX09VVF0pOw0KPiAtDQo+ICAJaW14X2NoZWNrX2Nsa19od3MoaHdzLCBJTVg4TVBf
Q0xLX0VORCk7DQo+IA0KPiAgCW9mX2Nsa19hZGRfaHdfcHJvdmlkZXIobnAsIG9mX2Nsa19od19v
bmVjZWxsX2dldCwgY2xrX2h3X2RhdGEpOyBkaWZmDQo+IC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg4bXEuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMgaW5kZXgNCj4gZmRj
NjhkYjY4ZGU1Li4yMDFjN2JiYjIwMWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1xLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYw0KPiBAQCAt
NTk5LDkgKzU5OSw2IEBAIHN0YXRpYyBpbnQgaW14OG1xX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCQkJCQkgICBod3NbSU1YOE1RX0FSTV9QTExfT1VU
XS0+Y2xrLA0KPiAgCQkJCQkgICBod3NbSU1YOE1RX0NMS19BNTNfRElWXS0+Y2xrKTsNCj4gDQo+
IC0JY2xrX2h3X3NldF9wYXJlbnQoaHdzW0lNWDhNUV9DTEtfQTUzX1NSQ10sDQo+IGh3c1tJTVg4
TVFfU1lTMV9QTExfODAwTV0pOw0KPiAtCWNsa19od19zZXRfcGFyZW50KGh3c1tJTVg4TVFfQ0xL
X0E1M19DT1JFXSwNCj4gaHdzW0lNWDhNUV9BUk1fUExMX09VVF0pOw0KPiAtDQo+ICAJaW14X2No
ZWNrX2Nsa19od3MoaHdzLCBJTVg4TVFfQ0xLX0VORCk7DQo+IA0KPiAgCWVyciA9IG9mX2Nsa19h
ZGRfaHdfcHJvdmlkZXIobnAsIG9mX2Nsa19od19vbmVjZWxsX2dldCwgY2xrX2h3X2RhdGEpOw0K
PiAtLQ0KPiAyLjE2LjQNCg0K
