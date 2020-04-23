Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE64C55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946C92076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BK9x/DNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDWKxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:53:42 -0400
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:9889
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgDWKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:53:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCRQomvGpQk1QYKau2n+XSJBfqLcFaEvLz8EnFOyu7cTqAslVZSvXA5kaC4wEGgFfTInQbGVqiA7srhKsO6LJAMuyB7Yaxj2YbFSN/GGwczIUS7B6L6wf14FTbaBfjZS9mT3Qvp11iMREcOEkvsk3f4K/GYjRhp9Dj/pYVLGaYXVawvoV7WFc20Ya9l+47tJvrQGg6TIYrHhcQWIGpaiK5RYXj95u9z3HcZIrHouTT16/4FugGvAhmA+jXkHKufpIYDmOarTECwOOaZNG7Qo90N0rtqOwSbk8YqX3hua8ITQs/P+4qTNNK0NDBEAYx/npjfg0RgjPDerNnh0K5QKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6riY0DyntUrHz4LaSMdllRqrkaOnS98cV37+6F4LP0=;
 b=Wdy60ETr/ZtMPQLlvrnq6b72ph6nvyxO6kDC/L05G0+GMXMbT1a0oYakO8cdHc+p21yOMnB1xQKbSvZeKl16fIOoKbWUXR7gKLcpgGYtwrtIwSpw09qtNsT+Du72RUmYbvRCGrIQKKhZFjcRlLQYTQ/k9wuC5xmlcEIiVEHpCuWIuI0UAG6ulCUGabyHRUK5MbVvhOHJF+SezfgeQI0Yhr3k/YJHnV9u675z/MTi4SB2MqPk/6ew44DgA6uQBYulGYP2vjatAMGwA5EdUOA0R16QKOGCIef6C29/Dpm9J16f0i8kQeAWiOkOyc9PtzZgFtIRaCOd5ZAzTsIHaXKz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6riY0DyntUrHz4LaSMdllRqrkaOnS98cV37+6F4LP0=;
 b=BK9x/DNVvtYavmiNjQ3UGChsXAixt0WSI9Lc6gZ7gcbLnbuKJ72PtqI9ALjxSI4b/VKtgFNjcCfMq2x+qbaF5bO3Rgbiw5Kbz3oaD/N4sKpRuQzCWMJczrU6sRostYowxUXs4H8ljwe+iWDtB6RDo3ZRGUB3tyL+IROyDyF8lnk=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2712.eurprd04.prod.outlook.com (2603:10a6:4:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:53:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 10:53:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Topic: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Index: AQHWGTz1S3ryZr4eI06QzGNLele1k6iGhU2AgAACxjA=
Date:   Thu, 23 Apr 2020 10:53:37 +0000
Message-ID: <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9978d410-e856-4e8d-ae8b-08d7e77493c5
x-ms-traffictypediagnostic: DB6PR0402MB2712:|DB6PR0402MB2712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2712BA657479F72170D82EAE88D30@DB6PR0402MB2712.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(7696005)(8676002)(66556008)(64756008)(71200400001)(81156014)(52536014)(66446008)(66946007)(76116006)(66476007)(5660300002)(2906002)(26005)(86362001)(6506007)(478600001)(316002)(33656002)(54906003)(8936002)(4326008)(44832011)(9686003)(55016002)(186003)(110136005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCTit5i8VsH+hzTgrTxkUqlEL+r2vhGkqYoKyp9035N9QHHYdqNh/3dVrLoLC7D0PPCCcYIQ77tdv8FQV9gGtJh+0pi+jxCzp+avkiFjjcB5h0kK0P1Fyz2MnISl5pLWZNfccwp2mLc/Ba2nSn6v0Au+6FO3GSjBzxm2uI/x78fTbWLOBv7d8x3JHfYXG37pNkUzyr06IHwQd6/5lqHJwp0T6G2yfklC/awLoFG0xIsYnnI6E8QpucOa6OfDGYEkUc0Dgp6IPKbaaIQ4YLrT2Emxfoq8BexoePBO6+0V+0JpL5T8wiZfr+lPMfiVnJU+g9B/YRe08Ul10KObBbovwIRShJfq4K337rVLmAFi3xClhp9Lc1boRzNpE2QhQoIVV9izmohF+z51TFKGn9IS5f8SnSzOimjEAS9DfqZ6zz742CNtLWtb/HxXeVsohZcz
x-ms-exchange-antispam-messagedata: 08zg3xPOK/PycDsMeLVXj1qYcX6k1KvxDhQCQOwdqa979kCVYKjRr8IShovSxwU/CU0LQD1y6yv0UwarQknroFDLsDV4PfuvB0mwxEOZ7v/TYixG2utwLtXH/vP/2PoOvZ9/BGe8ZJcOIZOeakLKWw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9978d410-e856-4e8d-ae8b-08d7e77493c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:53:37.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZjtPZZ4+rj6dEqZTDABcqzI1cst5tVPScgbBHh1hR9JsmkX5x/SZiXLLRScOd69SRxUcU8UzisNEXYt99P2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IGlteDogaW50cm9kdWNlIGlteF9jbGtfaHdfY3Jp
dGljYWwNCj4gDQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDI6NTIgUE0NCj4gPg0KPiA+IFRvIGkuTVg4TSBT
b0MsIHRoZXJlIGlzIGFuIGNhc2UgaXMgd2hlbiBydW5uaW5nIGR1YWwgT1NlcyB3aXRoDQo+ID4g
aHlwZXJ2aXNvciwgdGhlIGNsayBvZiB0aGUgaGFyZHdhcmUgdGhhdCBwYXNzdGhyb3VnaCB0byB0
aGUgMm5kIE9TDQo+ID4gbmVlZHMgdG8gYmUgc2V0dXAgYnkgMXN0IExpbnV4IE9TLg0KPiA+IFNv
IGRldGVjdCBjbG9jay1jcml0aWNhbCBmcm9tIGNjbSBub2RlIGFuZCBlbmFibGUgdGhlIGNsb2Nr
cyB0byBsZXQNCj4gPiB0aGUgMm5kIE9TIGNvdWxkIHVzZSB0aGUgaGFyZHdhcmUgd2l0aG91dCB0
b3VjaCBDQ00gbW9kdWxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL2lteC9jbGsuYyB8IDE5ICsr
KysrKysrKysrKysrKysrKysgIGRyaXZlcnMvY2xrL2lteC9jbGsuaA0KPiA+IHwgIDENCj4gPiAr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGsuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYyBpbmRl
eA0KPiA+IDg3YWI4ZGIzZDI4Mi4uZWM3ZDQyMjU0MGMxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvY2xrL2lteC9jbGsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0KPiA+IEBA
IC0xNzcsMyArMTc3LDIyIEBAIHN0YXRpYyBpbnQgX19pbml0IGlteF9jbGtfZGlzYWJsZV91YXJ0
KHZvaWQpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICBsYXRlX2luaXRjYWxsX3N5bmMo
aW14X2Nsa19kaXNhYmxlX3VhcnQpOw0KPiA+ICsNCj4gPiAraW50IGlteF9jbGtfaHdfY3JpdGlj
YWwoc3RydWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0IGNsa19odyAqIGNvbnN0DQo+ID4gK2h3
c1tdKSB7DQo+ID4gKwlzdHJ1Y3QgcHJvcGVydHkgKnByb3A7DQo+ID4gKwljb25zdCBfX2JlMzIg
KmN1cjsNCj4gPiArCXUzMiBpZHg7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICgh
bnAgfHwgIWh3cykNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlvZl9wcm9w
ZXJ0eV9mb3JfZWFjaF91MzIobnAsICJjbG9jay1jcml0aWNhbCIsIHByb3AsIGN1ciwgaWR4KSB7
DQo+IA0KPiBJcyB0aGVyZSBhIGJpbmRpbmcgZm9yIGl0IGFscmVhZHk/DQoNCkkgdGhpbmsgY2xv
Y2stY3JpdGljYWwgaXMgYSBjb21tb24gYmluZGluZ3M/IFNlZSBvZl9jbGtfZGV0ZWN0X2NyaXRp
Y2FsLg0KUGxlYXNlIHJldmlldyB3aGV0aGVyIHRoaXMgYXBwcm9hY2ggaXMgYWNjZXB0YWJsZSwg
aWYgZG8NCm5lZWQgYmluZGluZ3MsIEkgY291bGQgYWRkIHRoYXQgaW4gdjIuDQoNClRoYW5rcywN
ClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMNCj4gQWlzaGVuZw0KPiANCj4gPiArCQlyZXQgPSBjbGtf
cHJlcGFyZV9lbmFibGUoaHdzW2lkeF0tPmNsayk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJ
cmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmggYi9kcml2ZXJzL2Nsay9pbXgvY2xr
LmggaW5kZXgNCj4gPiBkNGVhMTYwOWJjYjcuLjcwMWQ3NDQwZjk4YyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgN
Cj4gPiBAQCAtOSw2ICs5LDcgQEAgZXh0ZXJuIHNwaW5sb2NrX3QgaW14X2NjbV9sb2NrOw0KPiA+
DQo+ID4gIHZvaWQgaW14X2NoZWNrX2Nsb2NrcyhzdHJ1Y3QgY2xrICpjbGtzW10sIHVuc2lnbmVk
IGludCBjb3VudCk7ICB2b2lkDQo+ID4gaW14X2NoZWNrX2Nsa19od3Moc3RydWN0IGNsa19odyAq
Y2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpOw0KPiA+ICtpbnQgaW14X2Nsa19od19jcml0aWNh
bChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBzdHJ1Y3QgY2xrX2h3ICogY29uc3QNCj4gPiAraHdz
W10pOw0KPiA+ICB2b2lkIGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2NrcyhzdHJ1Y3QgY2xrICoqIGNv
bnN0IGNsa3NbXSk7ICB2b2lkDQo+ID4gaW14X21tZGNfbWFza19oYW5kc2hha2Uodm9pZCBfX2lv
bWVtICpjY21fYmFzZSwgdW5zaWduZWQgaW50IGNobik7DQo+ID4gdm9pZCBpbXhfdW5yZWdpc3Rl
cl9jbG9ja3Moc3RydWN0IGNsayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpOw0KPiA+IC0t
DQo+ID4gMi4xNi40DQoNCg==
