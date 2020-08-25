Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA96C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CE920782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="W+6NM9A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgHYGXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:23:48 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:29062
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728910AbgHYGXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:23:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANPiE/arf9zyZgzSmn+X5+FlCj2XYLSJ8kdyZrrUPQEywi2FOKjqpvK5+APXlNmg2tqRftOr+nXTPjr/LZgc5cQH6THgaYLHasyVHmpchiQLm1BOeW9StWUtf/63OKIXrXzlguJ4SYyH+RYO8/WId1NjiaX9md/q3Tm4U/dYkULibMUh3cENDMO7uOMZvdDnhJqSvK4CO9cI8jcprHcn5g5TDwF4jWB2v5kiPHkWzh6nhZQpbAWf19nenmdX9S6mvZvr4+X4Tf1X5D+w/sWJXIaXr1/amruq6AXIjHm5Flv4Azn3y5ODvhTLBIoPyAQdk2icAlqJRHUzmU9+dhsb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGUYPdytWs5jTgMyFeXfYZss7n4ulafRNGAIMX2BQ1I=;
 b=LNCMLM9WgL0xHjFY041nbUkbgImyzSgqo09nzalearVwGA9jd5TrE2zf8LRIlzFXOIUAVRkfntvHQEvw9eE3ar5aXuLp4ek0FQR/2V8H8zXDTHFzHLi5zuR5gOmCmVLTdzSBJOTXlGr0fJj3CAoLFOBJKRGRiFJUDiq/McK9N34qq8Mv2cEs0P1lmYtEfn3njnPY9bAO0WW5J0A1X1sHNNNRsf5j9byCzK+0p/7JlCMwe4SlDDgz8+MAt8cvgLNKZE79dEaUDufNHRDxhuQlgNCZm1YREexsIOnwt+O9Hxb9coM9scknx0PDxHzOkKjusba3sT1NWUKJjYhwYZwX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGUYPdytWs5jTgMyFeXfYZss7n4ulafRNGAIMX2BQ1I=;
 b=W+6NM9A+WaGSbuNuZUIC/ePqVQsymAcnrQEvcR4Ir5gkt2ebOGLtg7sjncVFHUF5DL/cO0hWhYbrfufOxZgTeyZDkYFC4n66dYp5d9fWl71YlCo0pgAWA8mmb7SmQ4au1xvswTlBXj4sjONpYoFNQWxBR4hBmWW2SBjRkVAdRvg=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2588.eurprd03.prod.outlook.com (2603:10a6:3:ed::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Tue, 25 Aug 2020 06:23:36 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 06:23:36 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 01/16] dt-bindings: mfd: rohm,bd71847-pmic: Correct clock
 properties requirements
Thread-Topic: [PATCH 01/16] dt-bindings: mfd: rohm,bd71847-pmic: Correct clock
 properties requirements
Thread-Index: AQHWeknKF7zhD8z2dUixSNbUKRgNrKlIW/KA
Date:   Tue, 25 Aug 2020 06:23:36 +0000
Message-ID: <b75867fd1c662a83d933ae8f0c4373ba017eb808.camel@fi.rohmeurope.com>
References: <20200824190701.8447-1-krzk@kernel.org>
In-Reply-To: <20200824190701.8447-1-krzk@kernel.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e19692d-76bf-4b38-2b45-08d848bf6646
x-ms-traffictypediagnostic: HE1PR0302MB2588:
x-microsoft-antispam-prvs: <HE1PR0302MB25885AE3B9B19344A4662773AD570@HE1PR0302MB2588.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dSvTySrxoT+wWTzmV9d+Y+ZgSF3peVOhtpfeLbzrdLpRC37lwbAfMheJhBHfeJ9f5vi85qhBQlQK4xKp4LrHCmi5CzhFj9kfuonWA9+q4aew9E+yEkf4lC9TGbFLeG4Cur0P72NnIv+xOrzvw0b9u7bYjxxVYTptMUhIVS3cVaONK1wxbPZXqF37gOqHzXvpXNtAfLAJIRI2xs6qdKbKGhbCCRlgSaF4exu63CKHRqramwTPTOAzDmOaowx3ecMP48Yzdk3sljU4uduP8XxBcHAB7Q35lcGwUQYmKYhFtywI06Fs8p5bbz5eaD7H2+sR6Cmr+xtLp7uL9GKmnaa5O1AfGk/phxQJ4E2j/nThCkO1FzCSmD5YClr45O0UxtzzpZofIZmtXAjQSGjY8k0DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(66556008)(478600001)(2906002)(6512007)(6486002)(110136005)(316002)(66446008)(64756008)(66476007)(2616005)(66946007)(83380400001)(3450700001)(76116006)(71200400001)(7416002)(86362001)(5660300002)(26005)(8936002)(8676002)(186003)(6506007)(921003)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8uY199Cv7TSIpGTZSA+FMRAeNhlbqgOrto9jjaOOaq9FWDhvzcjz1FQI0InEZjsAUkI6Je2vzIeJJwN2nwb2HQYuXhVezWxkxL8efQIrvuw6L8Vkw8LsXEuHjSaQccpa3JnQvQDxnYS8Gp2Bp3PEVvLiLD1KCZkaE4svASVB+cqNyzM3BJTgpdvivQ2++FWHWxPA9GoJyHCUHt1TVXpTLPBHmlwF2C08sb5d01cc7qbT1OV0iBtnsmErZetAZ1kSsP+hB6gRqhJ/01S36FERNaStT/zuAmuWPNrLN8zUIE0RhriB6AL+oWZb8HiaGNqQjSt956ceNKIKo94TAsJ1KvzAQmX1MpuTHJ6f5xIZ7PQCo9QjKQs2nUwYY3OzcbBnS8FqR+1CeJxL3u8C9m2CKfDN3RsC7P5tU1WwyUFDdEUjKnaW2zKWP1Z612v1eigBFcMMlFVlgOI0/Uzp4HbcNJ0Pf96ARX29A1sTXbfMpKixQxV7BN9pRVo5FHzHCxAfyBV8nPewILjzaExZw1QxJQcm6GQZgRWMg+OSu2IMJ6aQ8Z8n+X6PHaXKrspZreTFPICnflSoUzB59Uz4bAOeSE6mL2PRd1oPVl7pe4S7PM2L5FC9hmtQcDBIs7bW3owFEpCAcp+CeF1dA/jbEYy4Mw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <96248C2974A23E4EA92B2A6CDC880321@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e19692d-76bf-4b38-2b45-08d848bf6646
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 06:23:36.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M37XZgAHd5rE0U1MI8Rg/CQ15DS+SBR7jqwlQMRIZANW6bbaMXMhldoYDGw2owOvhoyS2AHNpthDKqCTnaQHC0sF7MyzAX8/HIpi/U+9PLcuBB51ci3NI0bvKC1lDL1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIZWxsbyBLcnp5c3p0b2YsDQoNCk9uIE1vbiwgMjAyMC0wOC0yNCBhdCAyMTowNiArMDIwMCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gVGhlIGlucHV0IGNsb2NrIGFuZCBudW1iZXIg
b2YgY2xvY2sgcHJvdmlkZXIgY2VsbHMgYXJlIG5vdCByZXF1aXJlZA0KPiBmb3INCj4gdGhlIFBN
SUMgdG8gb3BlcmF0ZS4gIFRoZXkgYXJlIG5lZWRlZCBvbmx5IGZvciB0aGUgb3B0aW9uYWwgYmQ3
MTh4Nw0KPiBjbG9jayBkcml2ZXIuDQoNCkkgaGF2ZSBhbHdheXMgZm91bmQgdGhlIERUIGJpbmRp
bmdzIGhhcmQgdG8gZG8uIEkgcXVpdGUgb2Z0ZW4gZW5kIHVwDQpoYXZpbmcgYSBkaWZmZXJlbnQg
dmlldyB3aXRoIFJvYiBzbyBJIHByb2JhYmx5IGNvdWxkIGp1c3Qgc2h1dC11cCBhbmQNCndhdGNo
IGhvdyB0aGlzIGV2b2x2ZXMgOikNCg0KQnV0IGFzIGtlZXBpbmcgbXkgbW91dGggaXMgc28gZGlm
ZmljdWx0Li4uDQoNCi4uLkFsbCBvZiB0aGUgZHJpdmVycyBhcmUgb3B0aW9uYWwuIFRoZSBQTUlD
IGNhbiBwb3dlci1vbiB3aXRob3V0IGFueQ0KZHJpdmVycy4gRHJpdmVycyBhcmUgbW9zdGx5IHVz
ZWQganVzdCBmb3IgZGlzYWJsaW5nIHRoZSB2b2x0YWdlIGZyb20NCmdyYXBoaWNzIGFjY2VsZXJh
dG9yIGJsb2NrIHdoZW4gaXQgaXMgbm90IG5lZWRlZCAob3B0aW9uYWwpLiBPciBzb21lDQpEVlMg
KG9wdGlvbmFsKS4gQnV0IHllcywgbWF5YmUgdGhlIGNsayBkcml2ZXIgaXMgIm1vcmUgb3B0aW9u
YWwiIHRoYW4NCnRoZSByZXN0LiBYRCBTbywgSSBhbSBub3QgYWdhaW5zdCB0aGlzLg0KDQo+IEFk
ZCBhbHNvIGNsb2NrLW91dHB1dC1uYW1lcyBhcyBkcml2ZXIgdGFrZXMgdXNlIG9mIGl0Lg0KPiAN
Cj4gVGhpcyBmaXhlcyBkdGJzX2NoZWNrIHdhcm5pbmdzIGxpa2U6DQo+IA0KPiAgICAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWRkcjQtZXZrLmR0LnlhbWw6IHBtaWNANGI6
DQo+ICdjbG9ja3MnIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCj4gICAgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdC55YW1sOiBwbWljQDRiOg0KPiAnI2Ns
b2NrLWNlbGxzJyBpcyBhIHJlcXVpcmVkIHByb3BlcnR5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTg0Ny1wbWljLnlhbWwgICAgICAgfCA5DQo+ICsr
KysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWZkL3JvaG0sYmQ3MTg0Ny0NCj4gcG1pYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9yb2htLGJkNzE4NDctDQo+IHBtaWMueWFtbA0KPiBpbmRleCA3N2JjY2Ey
ZDQxNGYuLjVkNTMxMDUxYTE1MyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4NDctcG1pYy55YW1sDQo+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcm9obSxiZDcxODQ3LXBtaWMueWFtbA0KPiBA
QCAtMzgsNiArMzgsOSBAQCBwcm9wZXJ0aWVzOg0KPiAgICAiI2Nsb2NrLWNlbGxzIjoNCj4gICAg
ICBjb25zdDogMA0KPiAgDQo+ICsgIGNsb2NrLW91dHB1dC1uYW1lczoNCj4gKyAgICBtYXhJdGVt
czogMQ0KDQpJIGhhZCB0aGlzIGluIG9yaWdpbmFsIGJpbmRpbmcgKHRleHQpIGRvY3VtZW50IHBh
dGNoIHNlcmllcy4gRm9yIHNvbWUNCnJlYXNvbiBpdCB3YXMgbGF0ZXIgZHJvcHBlZC4gVW5mb3J0
dW5hdGVseSBJIGRpZG4ndCBlYXNpbHkgZmluZCBhDQpyZWFzb24gYXMgdG8gd2h5LiBBZGRpbmcg
aXQgYmFjayBub3cgaXMgYWJzb2x1dGVseSBmaW5lIGZvciBtZSB0aG91Z2guDQoNCj4gKw0KPiAg
IyBUaGUgQkQ3MTg0NyBhYmQgQkQ3MTg1MCBzdXBwb3J0IHR3byBkaWZmZXJlbnQgSFcgc3RhdGVz
IGFzIHJlc2V0DQo+IHRhcmdldA0KPiAgIyBzdGF0ZXMuIFN0YXRlcyBhcmUgY2FsbGVkIGFzIFNO
VlMgYW5kIFJFQURZLiBBdCBSRUFEWSBzdGF0ZSBhbGwNCj4gdGhlIFBNSUMNCj4gICMgcG93ZXIg
b3V0cHV0cyBnbyBkb3duIGFuZCBPVFAgaXMgcmVsb2FkLiBBdCB0aGUgU05WUyBzdGF0ZSBhbGwN
Cj4gb3RoZXIgbG9naWMNCj4gQEAgLTExNiwxMiArMTE5LDE0IEBAIHJlcXVpcmVkOg0KPiAgICAt
IGNvbXBhdGlibGUNCj4gICAgLSByZWcNCj4gICAgLSBpbnRlcnJ1cHRzDQo+IC0gIC0gY2xvY2tz
DQo+IC0gIC0gIiNjbG9jay1jZWxscyINCj4gICAgLSByZWd1bGF0b3JzDQo+ICANCj4gIGFkZGl0
aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiAgDQo+ICtkZXBlbmRlbmNpZXM6DQo+ICsgICcjY2xv
Y2stY2VsbHMnOiBbY2xvY2tzXQ0KPiArICBjbG9ja3M6IFsnI2Nsb2NrLWNlbGxzJ10NCg0KVGhp
cyBpcyBuZXcgdG8gbWUuIFBsZWFzZSBlZHVjYXRlIG1lIC0gZG9lcyB0aGlzIHNpbXBseSBtZWFu
IHRoYXQgaWYNCicjY2xvY2stY2VsbHMnIGlzIGdpdmVuLCB0aGVuIGFsc28gdGhlICdjbG9ja3Mn
IG11c3QgYmUgZ2l2ZW4gLSBhbmQgdGhlDQpvdGhlciB3YXkgYXJvdW5kPw0KDQpJZiBzbywgdGhl
bjoNCkFja2VkLUJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVy
b3BlLmNvbT4NCg0KDQoNCi0tDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJz
DQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCksNCml2aWhhcmp1bmxlbmtraSAx
RQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJl
bmUgRGVzY2FydGVzLiBKdXN0IHRoZW4gaGUgdmFuaXNoZWQgfn5+DQoNClNpbW9uIHNheXMgLSBp
biBMYXRpbiBwbGVhc2UuDQoibm9uIGNvZ2l0byBtZSIgZGl4aXQgUmVuZSBEZXNjYXJ0ZSwgZGVp
bmRlIGV2YW5lc2Nhdml0DQoNCihUaGFua3MgZm9yIHRoZSB0cmFuc2xhdGlvbiBTaW1vbikNCg0K
