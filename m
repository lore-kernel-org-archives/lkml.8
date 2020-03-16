Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58340C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D8D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yq91vj1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgCPBLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:11:31 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:51905
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729300AbgCPBLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:11:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxLwFyuKwjXIMUEAnByQguk2021Tz75MOg8+A68BewzEv8Bc0vSrthnLmhjvsAkV/orljg0gfzNNsaMqUkOpa9oyXTRbHq0H7PLErAo8/k48mm4Pf7xJdUbW/4srmeQXghhWI3QcVvQMIGo42+h0GFIG3RnRjI1sjiMszP14izkCwi2AQnnFc/HXCIw9jR4/7g4rBTWyv+yBQpFeZ4RVi7Lvj0NatlTIlMkuQI0IDa4TUnvCRtP9F8/XdCO8WIBxZOcnMupu1iq8JJPu4rlTPSrJzygM+9ctI4ZpCQnPw2bJiFOUiXg1sEg8THOHlYtU+bA+PIQB8HBb3oDtvA+SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1HpxRK+MNtZHq1wd+4aIty+nAj6PZnFRViZVByFHFY=;
 b=RtH14Cu8F3So3WIih86VgdHbM5zZk5GJcdsUFTM9btkvuv+n8hmIuDFHJcPJJ7r4Lt0xLDi+PXXznKyWZGLx79ropqRfG7uFrn+Udrrx9IKbDVphaloJhZnF3oPCsqkDBTMJw4Ba2OgEdUXT89+pi4vXtyagr1XKbj1bkdgLy2NxH4MdZOYaRhtN/vFzu6e0c1D1fLe90IOFDY0muWvfFsKjVFL/Z9Vzfkb0wMlWMPT2+bCTJS7+lXG4WYla21gqfUFKnMRU7bPrHqvNP7I5JoEbgOa8wD+KG7wQU18Zm9gBndxZnZoj7phgbo7evqerjjxNIyLwmmNrG8xsGe5MYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1HpxRK+MNtZHq1wd+4aIty+nAj6PZnFRViZVByFHFY=;
 b=Yq91vj1IWYwn/pTxPzQJ8QtAX8w1MH+xHOrWifkz5MH0du4YEsSd/pkWcLWxL9Lr+hEkNoX02tk76OBqmeLFfRhEe3VKaOmzNlgKPKK9TPaLVuZs6MtelR9X6tD0iPjLt6aX2rWBFnnS2BzwSRAIrxOcxJ8EG63GZbuLF0u8i2k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Mon, 16 Mar 2020 01:11:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 01:11:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Thread-Topic: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Thread-Index: AQHV9rog8X+te2Dr9ESU0H5E6tZlYqhKcC2AgAAB2oA=
Date:   Mon, 16 Mar 2020 01:11:22 +0000
Message-ID: <DB3PR0402MB3916A1240047954022FB4632F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583830337-23889-1-git-send-email-Anson.Huang@nxp.com>
 <20200316010416.GI17221@dragon>
In-Reply-To: <20200316010416.GI17221@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28bd9f67-1629-47c9-e1fe-08d7c946f140
x-ms-traffictypediagnostic: DB3PR0402MB3881:|DB3PR0402MB3881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3881E47B61343375F99B97DAF5F90@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(55016002)(52536014)(4326008)(5660300002)(7696005)(9686003)(316002)(54906003)(44832011)(6506007)(8676002)(81156014)(81166006)(86362001)(6916009)(478600001)(33656002)(186003)(71200400001)(2906002)(26005)(66946007)(66446008)(76116006)(66476007)(64756008)(66556008)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MpZunEo5lAnYq8WNv/JN+J59jvtMyHvBARdZTJAf751AYPh+PzlbE2A2FG8AQHKG7fTSeosqx0IqA1Q2RC204jOpYGltF0DyK8s/PiLxYcfwr1Aa3iB/v9sN2HNFZ8OnOKivMtqWAmeAhWf/SAMbmqGZ/8KMdw+ysGkhCLhZdLhODA/xi3ZqMdV5cHHeZ+SRIIDjhPbWbievf15aF11gRAaes2oqlOkE4IERrhjnQfkCYLqpjol5XTfFYfNMPDU9uaFtoN/frPZb6ey20q4UgzOIhg7N7CPC6XN4+NGCBcA3IRo0ZC52S2vSr8k3o8ntGgAJo3sK296seYGshgl6z46A8dI/nmLgcgBT35FaHEmb3ukSNXPGUNSAk6DlFGg2UXokRKhaZGCYhxTdoEcyveszVlimxNj4VK3fys2VapuifWgxIgxD1vsU5UAqmIwZ39RHnzMRCOC0NvwbnHteivATZTt6UvotnLq8Us/1u0=
x-ms-exchange-antispam-messagedata: Bv/ae3uyyom7r3IFK74Z9LOdz9QPM0EJihoFHD5dFudUWkog4gQAYz2Ws2lNWUB7iHHQQCoCrBFkSeiGBvtE4+i1yM/aTpZ1Tv/5Wun/c1ksLBHWXFMAuZfD+Y6zzBu7IHwIlgOHgcfK++fGqg6hJQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bd9f67-1629-47c9-e1fe-08d7c946f140
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 01:11:22.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWz1JSPLnLEpntlePsWZ1hQSva/feQhRkpER6WI07Y5ywtQT48a1yyskA3CDpiTJkOLvC+Q2e7AgMIGavbRAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGFybTY0OiBkdHM6IGlteDhx
eHAtbWVrOiBTb3J0IGxhYmVscyBhbHBoYWJldGljYWxseQ0KPiANCj4gT24gVHVlLCBNYXIgMTAs
IDIwMjAgYXQgMDQ6NTI6MTZQTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gU29ydCB0
aGUgbGFiZWxzIGFscGhhYmV0aWNhbGx5IGZvciBjb25zaXN0ZW5jeS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gSXQgZG9l
c24ndCBhcHBseSB0byBteSBicmFuY2guDQoNCkkgd2lsbCByZWJhc2UgaXQgYW5kIHJlc2VuZCB0
aGUgcGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MsDQpBbnNvbg0KDQoNCj4gDQo+IFNoYXduDQo+IA0K
PiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLW1lay5k
dHMgfCA2MCArKysrKysrKysrKysrLS0tLS0NCj4gLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzMCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLW1lay5kdHMNCj4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLW1lay5kdHMNCj4gPiBpbmRleCAx
MzQ2MGEzLi4yZWQ3YWJhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiA+IEBAIC0zMCwyOSArMzAsOCBAQA0KPiA+ICAJfTsN
Cj4gPiAgfTsNCj4gPg0KPiA+IC0mYWRtYV9scHVhcnQwIHsNCj4gPiAtCXBpbmN0cmwtbmFtZXMg
PSAiZGVmYXVsdCI7DQo+ID4gLQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfbHB1YXJ0MD47DQo+ID4g
LQlzdGF0dXMgPSAib2theSI7DQo+ID4gLX07DQo+ID4gLQ0KPiA+IC0mZmVjMSB7DQo+ID4gLQlw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+IC0JcGluY3RybC0wID0gPCZwaW5jdHJsX2Zl
YzE+Ow0KPiA+IC0JcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPiA+IC0JcGh5LWhhbmRsZSA9IDwm
ZXRocGh5MD47DQo+ID4gLQlmc2wsbWFnaWMtcGFja2V0Ow0KPiA+ICsmYWRtYV9kc3Agew0KPiA+
ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+IC0NCj4gPiAtCW1kaW8gew0KPiA+IC0JCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiA+IC0JCSNzaXplLWNlbGxzID0gPDA+Ow0KPiA+IC0NCj4gPiAtCQll
dGhwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+ID4gLQkJCWNvbXBhdGlibGUgPSAiZXRoZXJuZXQt
cGh5LWllZWU4MDIuMy1jMjIiOw0KPiA+IC0JCQlyZWcgPSA8MD47DQo+ID4gLQkJfTsNCj4gPiAt
CX07DQo+ID4gIH07DQo+ID4NCj4gPiAgJmFkbWFfaTJjMSB7DQo+ID4gQEAgLTEzMSw2ICsxMTAs
MzUgQEANCj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiArJmFkbWFfbHB1YXJ0MCB7DQo+ID4g
KwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJs
X2xwdWFydDA+Ow0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
JmZlYzEgew0KPiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArCXBpbmN0cmwt
MCA9IDwmcGluY3RybF9mZWMxPjsNCj4gPiArCXBoeS1tb2RlID0gInJnbWlpLWlkIjsNCj4gPiAr
CXBoeS1oYW5kbGUgPSA8JmV0aHBoeTA+Ow0KPiA+ICsJZnNsLG1hZ2ljLXBhY2tldDsNCj4gPiAr
CXN0YXR1cyA9ICJva2F5IjsNCj4gPiArDQo+ID4gKwltZGlvIHsNCj4gPiArCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4gPiArCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKwkJZXRo
cGh5MDogZXRoZXJuZXQtcGh5QDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gImV0aGVybmV0LXBo
eS1pZWVlODAyLjMtYzIyIjsNCj4gPiArCQkJcmVnID0gPDA+Ow0KPiA+ICsJCX07DQo+ID4gKwl9
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnNjdV9rZXkgew0KPiA+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgJnVzZGhjMSB7DQo+ID4gIAlhc3NpZ25lZC1jbG9ja3Mg
PSA8JmNsayBJTVhfQ09OTl9TREhDMF9DTEs+Ow0KPiA+ICAJYXNzaWduZWQtY2xvY2stcmF0ZXMg
PSA8MjAwMDAwMDAwPjsNCj4gPiBAQCAtMjI5LDExICsyMzcsMyBAQA0KPiA+ICAJCT47DQo+ID4g
IAl9Ow0KPiA+ICB9Ow0KPiA+IC0NCj4gPiAtJmFkbWFfZHNwIHsNCj4gPiAtCXN0YXR1cyA9ICJv
a2F5IjsNCj4gPiAtfTsNCj4gPiAtDQo+ID4gLSZzY3Vfa2V5IHsNCj4gPiAtCXN0YXR1cyA9ICJv
a2F5IjsNCj4gPiAtfTsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==
