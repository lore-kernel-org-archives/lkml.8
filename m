Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111E420639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="AFDBS4+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgHYIW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:22:26 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:40257
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgHYIWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFebFEf3cLr583LAiYqoqzwtPij4SGottvjrCNE/PUzi39meJRA5bXY9nPqb+GQ7nhTOQvaiWE4AEFd0kpT7g8AXmVmZ1cqe6lLNdXs5bg8O5olDd7/Rd3jxrUMJHE1fyfiYRo5C26uBBM/MUJwPfrAW3eZhOitENgBOhi+ruY+UVWJzic3W+Oq5YFsIUQ+GEEngKehR0kHdv9K/wOKT8kJDAPmYVKsn3kqZP+mY/O+E3cn0lwsr1CNTzOnLxpBIN/T5vEZVQ/H+5CenyRdBttVzBBjvWSzESxyB94AuN7LVZ1TyIuAJQ0y2PXMlHKXniVQLfjF/APzmpGOhae1GgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OdrVh1i1J7k5sepOy2HQBkQYZCXdmfuL5SQwaXL2dw=;
 b=bIgsihn4wR5GKehgLVl3tQUvYr5K+OF3AWJlRIr0jrUf7ME5X0Cp702vwCUSUCjohCYZo1sLef+8F7wNoBuCmJkpFLKrV/Thy0vS8ZTdawiuYOsIIqBtGnCJbFm0sgm4umHLPOj/A9fz2H66/3ol/ZfxAJuk0iwKLwH3PDXY0gZMJbax2OIN9w6YpqKZsMkoffnbS1dbK/lpmAuy7vus5GDQTwS4Np1uicH6ukU9YRgUGMGI4zbZH3W4FMjRj+xF7FLBOwe97QGF0ZMgjjMOe2zzbj9bdgVIHPeBtGFDkC6AHyhDjZzubGzeLtLJjuO7Ea2WZkk/ka7R2md9XcAPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OdrVh1i1J7k5sepOy2HQBkQYZCXdmfuL5SQwaXL2dw=;
 b=AFDBS4+maA3CeTs/lLe5Xg9Vc292lCrrLxqh5QB5FIwI/i284k376k6Abe6CbFhrzfwqsZR7fsF3jGb9rgUUCIKICIzxPWm69AgqAr3/OxHHLNugj7OT9QYSSEOlmEoCnNXUKfvAbw71DMIu3P/F4tvy78Alee0NJ1FcnTGvKbk=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2474.eurprd03.prod.outlook.com (2603:10a6:3:6a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Tue, 25 Aug 2020 08:22:18 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 08:22:18 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align regulator
 names with schema
Thread-Topic: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Thread-Index: AQHWeknSKDZwJ6TG4kKPN+CgQ8rFoqlIY7aAgAAJkYCAAAVqAIAAAZMAgAAIzwA=
Date:   Tue, 25 Aug 2020 08:22:18 +0000
Message-ID: <3018d638b5753e629ebdb6a25973aeff7e446720.camel@fi.rohmeurope.com>
References: <20200824190701.8447-1-krzk@kernel.org>
         <20200824190701.8447-3-krzk@kernel.org>
         <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
         <20200825072537.GA5914@kozik-lap> <20200825074500.GA19323@kozik-lap>
         <20200825075038.GA10148@kozik-lap>
In-Reply-To: <20200825075038.GA10148@kozik-lap>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7660cffb-a123-4424-9991-08d848cffb39
x-ms-traffictypediagnostic: HE1PR0301MB2474:
x-microsoft-antispam-prvs: <HE1PR0301MB24749394F1B215CA2646F4F2AD570@HE1PR0301MB2474.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4V04EokFfhpp90NOGg9S26VFAHyncal3nEJQ5fU8gDuiJVOYc1LFVMUkViZxDX2QidzwFerxlpPw5BfaZ1KWRJWOQhgohW8Fxvkm5VwGGuV29FDuINWOMfVNJOmsVby8iwT6FJo66nT/zJShL/wZjiLp3JcuqmOkQ+OUDH6Ws1p58X7Ogaj3Xx0VYEp9QCrTwmqL7hrlWv3cCBtze6QQ1efuc+C+PSfHyfjm3E2PoXEXubqjciUkJwCuz4zivq0lO8zXmm5oC2XXroCkZtcPdoG0PEWRjWjOxp/kXFx5WZI6xk8j8t/4ThABmpdL8elyHVUW3ni+c1d3deIsZeBqEPdd64EgcRMJAkpT5Qdq3lU+PEYc8Hx9jv/35c9w3zf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(136003)(376002)(83380400001)(66476007)(6512007)(71200400001)(66946007)(66446008)(26005)(478600001)(186003)(66556008)(2616005)(76116006)(4326008)(54906003)(64756008)(8676002)(7416002)(316002)(8936002)(2906002)(6486002)(110136005)(3450700001)(6506007)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: a0eNTMDt9ooO0PYtdbsFPuRG3LpYzEwUuNKEzxqT7d49cKvEspwGz/vllrn1kb8KXl4BasM1GmULFxcmJRhqU1hdzs1NRiRHKlMW+y2T4u5MbhDevrXh8AVraC1XgC7fcq63wXeA3VelWiq7RDznYSOhrc9clKviW0hndf/dqHbWIXGqbRAOTK7RIZzY4NKCnMkh3vTVzM/S0Qcd1Zvwsfix27HhiUiQuwMRq3GSo5R6IDfD9j5AL5y80nnU86V8ahiHqBvE8kXoDj3988loYz8ePcw73uu435VB3DpkbwStGQQDIWLWXLKnC1kF8nU6rsZhidCnjOwEE0C/otmiBj+IhXzeLLDIpTh3dNzwmmp057EtY2PJaXYvERVTvgjv+Dr1ecl+tz2UlwHUoEANnTumWnTraeAqn2DwDgT8rcXWAhMuDaBGNEyumqHuO0ojn3T9Gf/8uO/cOikwKWHxMfarm/HzK3xAYSezmtNxyt0BFn6xoUT682c4lIzCghqExXSSNKVF62AFJG1kWQlWjPhejDk+uOKns5KJXhMNIno3yrUeWW/aavQoRDF4DwM0U1+gPKVhHPZe7DHUnMooDwrjonVVtUIj9ibv2usAAuPHT0hW0zV9yUAIr/HoPpvSh7jcIbf21/EPrSCfMAx0Hw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B579BB338DAB74699D1A1FAD4D60B3D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7660cffb-a123-4424-9991-08d848cffb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 08:22:18.0802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRfKlk0bqHa3Z36hqd7uTUxjojb3XwSLwgjoo+WbUY7Dk1sq3N4XbLkwdEzbs+YJFd13GWKXFONMe6glrMkmzJk+tafC+qJVZ7grrF+L8NErFN2dcDi5RTXVEcHfjULO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQpPbiBUdWUsIDIwMjAtMDgtMjUgYXQgMDk6NTAgKzAyMDAsIGty
emtAa2VybmVsLm9yZyB3cm90ZToNCj4gT24gVHVlLCBBdWcgMjUsIDIwMjAgYXQgMDk6NDU6MDBB
TSArMDIwMCwga3J6a0BrZXJuZWwub3JnIHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXVnIDI1LCAyMDIw
IGF0IDA5OjI1OjM3QU0gKzAyMDAsIGtyemtAa2VybmVsLm9yZyB3cm90ZToNCj4gPiA+IE9uIFR1
ZSwgQXVnIDI1LCAyMDIwIGF0IDA2OjUxOjMzQU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3Jv
dGU6DQo+ID4gPiA+IEhlbGxvIEtyenlzenRvZiwNCj4gPiA+ID4gDQo+ID4gPiA+IEp1c3Qgc29t
ZSBxdWVzdGlvbnMgLSBwbGVhc2UgaWdub3JlIGlmIEkgbWlzdW5kZXJzdG9vZCB0aGUNCj4gPiA+
ID4gaW1wYWN0IG9mDQo+ID4gPiA+IHRoZSBjaGFuZ2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBN
b24sIDIwMjAtMDgtMjQgYXQgMjE6MDYgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6
DQo+ID4gPiA+ID4gRGV2aWNlIHRyZWUgc2NoZW1hIGV4cGVjdHMgcmVndWxhdG9yIG5hbWVzIHRv
IGJlDQo+ID4gPiA+ID4gbG93ZXJjYXNlLiAgVGhpcw0KPiA+ID4gPiA+IGZpeGVzDQo+ID4gPiA+
ID4gZHRic19jaGVjayB3YXJuaW5ncyBsaWtlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICAgICBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZGRyNC1ldmsuZHQueWFtbDogDQo+
ID4gPiA+ID4gcG1pY0A0YjoNCj4gPiA+ID4gPiByZWd1bGF0b3JzOkxETzE6cmVndWxhdG9yLW5h
bWU6MDogJ0xETzEnIGRvZXMgbm90IG1hdGNoDQo+ID4gPiA+ID4gJ15sZG9bMS02XSQnDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
a0BrZXJuZWwub3JnPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICAuLi4vYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMgICAgfCAyMg0KPiA+ID4gPiA+ICsrKysrKysrKy0t
LS0tLQ0KPiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZGRyNC0NCj4gPiA+ID4g
PiBldmsuZHRzDQo+ID4gPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW4tZGRyNC1ldmsuZHRzDQo+ID4gPiA+ID4gaW5kZXggYTFlNTQ4M2RiYmJlLi4yOTljYWVkNWQ0
NmUgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1uLWRkcjQtZXZrLmR0cw0KPiA+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMNCj4gPiA+ID4gPiBAQCAtNjAsNyArNjAsNyBA
QA0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgCQlyZWd1bGF0b3JzIHsNCj4gPiA+ID4gPiAgCQkJ
YnVjazFfcmVnOiBCVUNLMSB7DQo+ID4gPiA+ID4gLQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJCVUNL
MSI7DQo+ID4gPiA+ID4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJidWNrMSI7DQo+ID4gPiA+IA0K
PiA+ID4gPiBJIGFtIG5vdCBhZ2FpbnN0IHRoaXMgY2hhbmdlIGJ1dCBJIHdvdWxkIGV4cGVjdCBz
ZWVpbmcgc29tZQ0KPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiBwYXRjaGVzIHRvbz8gSSBndWVzcyB0
aGlzIHdpbGwgY2hhbmdlIHRoZSByZWd1bGF0b3IgbmFtZSBpbg0KPiA+ID4gPiByZWd1bGF0b3IN
Cj4gPiA+ID4gY29yZSwgcmlnaHQ/IFNvIG1heWJlIEkgYW0gbWlzdGFrZW4gYnV0IGl0IGxvb2tz
IHRvIG1lIHRoaXMNCj4gPiA+ID4gY2hhbmdlIGlzDQo+ID4gPiA+IHZpc2libGUgaW4gc3VwcGxp
ZXJzLCBzeXNmcyBhbmQgZGVidWdmcyB0b28/IFRodXMgY2hhbmdpbmcgdGhpcw0KPiA+ID4gPiBz
b3VuZHMNCj4gPiA+ID4gYSBiaXQgbGlrZSBhc2tpbmcgZm9yIGEgbm9zZSBibGVlZCA6KSBBbSBJ
IHJpZ2h0IHRoYXQgdGhlDQo+ID4gPiA+IGltcGFjdCBvZg0KPiA+ID4gPiB0aGlzIGNoYW5nZSBo
YXMgYmVlbiB0aG9yb3VnaGx5IHRlc3RlZD8gQXJlIHRoZXJlIGFueSBvdGhlcg0KPiA+ID4gPiBw
YXRjaGVzDQo+ID4gPiA+ICh0aGF0IEkgaGF2ZSBub3Qgc2VlbikgcmVsYXRlZCB0byB0aGlzIGNo
YW5nZT8NCj4gPiA+IA0KPiA+ID4gT2gsIGNyYXAsIHRoZSBuYW1lcyBvZiByZWd1bGF0b3JzIGlu
IHRoZSBkcml2ZXIgYXJlIGxvd2VyY2FzZSwNCj4gPiA+IGJ1dCB0aGV5DQo+ID4gPiB1c2Ugb2Zf
bWF0Y2hfcHRyIGZvciB1cHBlciBjYXNlLiBTZXJpb3VzbHksIHdoeSBtYWtpbmcgYSBiaW5kaW5n
DQo+ID4gPiB3aGljaA0KPiA+ID4gaXMgY29udHJhZGljdG9yeSB0byB0aGUgZHJpdmVyIGltcGxl
bWVudGF0aW9uIG9uIHRoZSBmaXJzdCBkYXk/DQo+ID4gPiANCj4gPiA+IFRoZSBkcml2ZXIgZ29l
cyB3aXRoIGJpbmRpbmcsIHJpZ2h0PyBPbmUgZXhwZWN0cyB1cHBlcmNhc2UsIG90aGVyDQo+ID4g
PiBsb3dlcmNhc2UuLi4NCj4gPiA+IA0KPiA+ID4gQW5kIHRlbGwgbWUsIHdoYXQgaXMgbm93IHRo
ZSBBQkk/IFRoZSBiaW5kaW5nIG9yIHRoZSBpbmNvcnJlY3QNCj4gPiA+IGltcGxlbWVudGF0aW9u
Pw0KPiA+IA0KPiA+IFdhaXQsIG15IG1pc3Rha2UuIEkgZ290IGNvbmZ1c2VkIGJ5IG15IG93biBj
aGFuZ2UuIFRoZSBub2RlIG5hbWUNCj4gPiBzdGF5cw0KPiA+IHRoZSBzYW1lLCBzbyBvZl9tYXRj
aCB3aWxsIGJlIGNvcnJlY3QuDQoNClllcy4gSSB0aGluayBzbyB0b28uIE1hdGNoIHdpbGwgc3Rp
bGwgd29yayBhcyBlYXJsZXIuDQoNCj4gPiANCj4gPiBUaGUgZHJpdmVyIGludGVybmFsbHkgYWxy
ZWFkeSB1c2VzIGxvd2VyY2FzZSBuYW1lcy4NCg0KWWVwLiBJIHdhcyBzaW1wbHkgdGhpbmtpbmcg
dGhhdCBpZiBhbnlvbmUgaGFzIGJlZW4gc3BlY2lmeWluZyB0aGUNCnJlZ3VsYXRvcnMgYXMgc3Vw
cGxpZXJzIGJ5IG5hbWUgLSB0aGVuIHRoaXMgY2hhbmdlIHdpbGwgY2hhbmdlIHRoaW5ncw0KKGFz
IGlzIHNlZW4gZm9yIExETzUpLiBBZGRpdGlvbmFsbHksIGlmIGFueSB1c2VyLXNwYWNlIFNXIGhh
cyBiZWVuDQpyZWFkaW5nIHRoZSByZWd1bGF0b3Igc3RhdGVzIGZyb20gc3lzZnMgLSB0aGVuIHRo
ZXNlIG5hbWVzIHdpbGwgYWxzbw0KY2hhbmdlIHRoZSBzeXNmcy4gRGVidWdmcyBjaGFuZ2UgaXMg
aG9wZWZ1bGx5IG5vdCBzdWNoIGEgYmlnIGRlYWwuDQoNCldoZXRoZXIgdGhpcyByZWFsbHkgYnJl
YWtzIGFueXRoaW5nIGlzIGJleW9uZCBteSBrbm93bGVkZ2UgYXMgSSBkb24ndA0KZXZlbiBoYXZl
IHRoaXMgYm9hcmQuIEFueXdheXMsIEkgdGhpbmsgdGhhdCBieSBtaW5pbXVtIHRoZSBjb21taXQN
Cm1lc3NhZ2Ugc2hvdWxkIHBvaW50IG91dCB0aGF0IHRoaXMgY2hhbmdlIHdpbGwgYmUgdmlzaWJs
ZSBvdXRzaWRlIERUUw0KYW5kIHRoZSBCRDcxOHg3IGRyaXZlciAtIHVwIHRvIHRoZSB1c2VyLXNw
YWNlLg0KDQo+ID4gDQo+ID4gRXZlcnl0aGluZyBsb29rcyBnb29kLiBJIHdpbGwganVzdCBkb3Vi
bGUgY2hlY2sgd2hldGhlciB0aGUNCj4gPiBjb25zdHJhaW50cw0KPiA+IGRpZCBub3QgY2hhbmdl
IG9uIHRoZSBib2FyZCBhZnRlciBib290Lg0KPiANCj4gQ29uc3RyYWludHMgbG9vayBnb29kLg0K
PiANCj4gPiA+ID4gPiAgCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0NCj4gPiA+ID4gPiA8
NzAwMDAwPjsNCj4gPiA+ID4gPiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0NCj4gPiA+
ID4gPiA8MTMwMDAwMD47DQo+ID4gPiA+ID4gIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gPiA+
ID4gPiBAQCAtNjksNyArNjksNyBAQA0KPiA+ID4gPiA+ICAJCQl9Ow0KPiA+ID4gPiA+ICANCj4g
PiA+ID4gPiAgCQkJYnVjazJfcmVnOiBCVUNLMiB7DQo+ID4gPiA+ID4gLQkJCQlyZWd1bGF0b3It
bmFtZSA9ICJCVUNLMiI7DQo+ID4gPiA+ID4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJidWNrMiI7
DQo+ID4gPiA+ID4gIAkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9DQo+ID4gPiA+ID4gPDcw
MDAwMD47DQo+ID4gPiA+ID4gIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9DQo+ID4gPiA+
ID4gPDEzMDAwMDA+Ow0KPiA+ID4gPiA+ICAJCQkJcmVndWxhdG9yLWJvb3Qtb247DQo+ID4gPiA+
ID4gQEAgLTc5LDE0ICs3OSwxNCBAQA0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgCQkJYnVjazNf
cmVnOiBCVUNLMyB7DQo+ID4gPiA+ID4gIAkJCQkvLyBCVUNLNSBpbiBkYXRhc2hlZXQNCj4gPiA+
ID4gPiAtCQkJCXJlZ3VsYXRvci1uYW1lID0gIkJVQ0szIjsNCj4gPiA+ID4gPiArCQkJCXJlZ3Vs
YXRvci1uYW1lID0gImJ1Y2szIjsNCj4gPiA+ID4gPiAgCQkJCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0NCj4gPiA+ID4gPiA8NzAwMDAwPjsNCj4gPiA+ID4gPiAgCQkJCXJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0NCj4gPiA+ID4gPiA8MTM1MDAwMD47DQo+ID4gPiA+ID4gIAkJCX07DQo+ID4g
PiA+ID4gIA0KPiA+ID4gPiA+ICAJCQlidWNrNF9yZWc6IEJVQ0s0IHsNCj4gPiA+ID4gPiAgCQkJ
CS8vIEJVQ0s2IGluIGRhdGFzaGVldA0KPiA+ID4gPiA+IC0JCQkJcmVndWxhdG9yLW5hbWUgPSAi
QlVDSzQiOw0KPiA+ID4gPiA+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAiYnVjazQiOw0KPiA+ID4g
PiA+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPQ0KPiA+ID4gPiA+IDwzMDAwMDAwPjsN
Cj4gPiA+ID4gPiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0NCj4gPiA+ID4gPiA8MzMw
MDAwMD47DQo+ID4gPiA+ID4gIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gPiA+ID4gPiBAQCAt
OTUsNyArOTUsNyBAQA0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgCQkJYnVjazVfcmVnOiBCVUNL
NSB7DQo+ID4gPiA+ID4gIAkJCQkvLyBCVUNLNyBpbiBkYXRhc2hlZXQNCj4gPiA+ID4gPiAtCQkJ
CXJlZ3VsYXRvci1uYW1lID0gIkJVQ0s1IjsNCj4gPiA+ID4gPiArCQkJCXJlZ3VsYXRvci1uYW1l
ID0gImJ1Y2s1IjsNCj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQgSSBzZWUgaW4gYmQ3MTh4Ny1yZWd1
bGF0b3IuYyBmb3IgTERPNiBkZXNjIGlzOg0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgLyogTERPNiBpcyBzdXBwbGllZCBieSBidWNrNSAqLw0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAuc3VwcGx5X25hbWUgPSAiYnVjazUiLA0KPiA+ID4gPiANCj4g
PiA+ID4gU28sIGlzIHRoaXMgY2hhbmdlIGdvaW5nIHRvIGNoYW5nZSB0aGUgc3VwcGx5LWNoYWlu
IGZvciB0aGUNCj4gPiA+ID4gYm9hcmQ/IElzDQo+ID4gPiA+IHRoaXMgaW50ZW5kZWQ/IChPciBh
bSBJIG1pc3Rha2VuIG9uIHdoYXQgaXMgdGhlIGltcGFjdCBvZg0KPiA+ID4gPiByZWd1bGF0b3It
DQo+ID4gPiA+IG5hbWUgcHJvcGVydHk/KQ0KPiA+IA0KPiA+IEdvb2QgcG9pbnQsIGxldCBtZSBj
aGVjayB0aGUgc3VwcGxpZXMuDQo+IA0KPiBUaGlzIHBhdGNoIGFjdHVhbGx5IGZpeGVzIHRoZSBz
dXBwbGllcyB3aGljaCBiZWZvcmUgd2VyZSBub3Qgd29ya2luZw0KPiBiZWNhdXNlIG9mIGNhc2Ug
bWlzbWF0Y2guDQo+IEJlZm9yZToNCj4gDQo+ICByZWd1bGF0b3IgICAgICAgICAgICAgICAgICAg
ICAgdXNlIG9wZW4gYnlwYXNzICBvcG1vZGUgdm9sdGFnZQ0KPiBjdXJyZW50ICAgICBtaW4gICAg
IG1heA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICByZWd1bGF0b3It
ZHVtbXkgICAgICAgICAgICAgICAgICA0ICAgIDUgICAgICAwDQo+IHVua25vd24gICAgIDBtViAg
ICAgMG1BICAgICAwbVYgICAgIDBtVg0KPiAgICAgTERPNiAgICAgICAgICAgICAgICAgICAgICAg
ICAgMSAgICAwICAgICAgMA0KPiB1bmtub3duICAxMjAwbVYgICAgIDBtQSAgIDkwMG1WICAxODAw
bVYNCj4gIEJVQ0sxICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgICAgMCAgICAgIDANCj4g
dW5rbm93biAgIDg1MG1WICAgICAwbUEgICA3MDBtViAgMTMwMG1WDQo+ICBCVUNLMiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAyICAgIDEgICAgICAwDQo+IHVua25vd24gIDEwMDBtViAgICAg
MG1BICAgNzAwbVYgIDEzMDBtVg0KPiAgICAgY3B1MC0NCj4gY3B1ICAgICAgICAgICAgICAgICAg
ICAgIDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwbUEgIDEwMDBtDQo+IFYgIDEw
MDBtVg0KPiAgQlVDSzMgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSAgICAwICAgICAgMA0K
PiB1bmtub3duICAgOTc1bVYgICAgIDBtQSAgIDcwMG1WICAxMzUwbVYNCj4gIEJVQ0s0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDEgICAgMCAgICAgIDANCj4gdW5rbm93biAgMzMwMG1WICAg
ICAwbUEgIDMwMDBtViAgMzMwMG1WDQo+ICBCVUNLNSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAxICAgIDAgICAgICAwDQo+IHVua25vd24gIDE4MDBtViAgICAgMG1BICAxNjA1bVYgIDE5OTVt
Vg0KPiAgQlVDSzYgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSAgICAwICAgICAgMA0KPiB1
bmtub3duICAxMjAwbVYgICAgIDBtQSAgIDgwMG1WICAxNDAwbVYNCj4gIExETzEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDEgICAgMCAgICAgIDANCj4gdW5rbm93biAgMTgwMG1WICAgICAw
bUEgIDE2MDBtViAgMTkwMG1WDQo+ICBMRE8yICAgICAgICAgICAgICAgICAgICAgICAgICAgICAx
ICAgIDAgICAgICAwDQo+IHVua25vd24gICA4MDBtViAgICAgMG1BICAgODAwbVYgICA5MDBtVg0K
PiAgTERPMyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSAgICAwICAgICAgMA0KPiB1bmtu
b3duICAxODAwbVYgICAgIDBtQSAgMTgwMG1WICAzMzAwbVYNCj4gIExETzQgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDEgICAgMCAgICAgIDANCj4gdW5rbm93biAgIDkwMG1WICAgICAwbUEg
ICA5MDBtViAgMTgwMG1WDQo+ICBsZG81ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxICAg
IDQgICAgICAwDQo+IHVua25vd24gIDE4MDBtViAgICAgMG1BICAxODAwbVYgIDE4MDBtVg0KPiAN
Cj4gDQo+IA0KPiBBZnRlcjoNCj4gIHJlZ3VsYXRvciAgICAgICAgICAgICAgICAgICAgICB1c2Ug
b3BlbiBieXBhc3MgIG9wbW9kZSB2b2x0YWdlDQo+IGN1cnJlbnQgICAgIG1pbiAgICAgbWF4DQo+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gYnVjazEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMSAgICAwICAgICAgMA0KPiB1bmtub3duICAgODUwbVYgICAgIDBtQSAg
IDcwMG1WICAxMzAwbVYNCj4gIGJ1Y2syICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIgICAg
MSAgICAgIDANCj4gdW5rbm93biAgIDg1MG1WICAgICAwbUEgICA3MDBtViAgMTMwMG1WDQo+ICAg
ICBjcHUwLQ0KPiBjcHUgICAgICAgICAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDBtQSAgIDg1MG0NCj4gViAgIDg1MG1WDQo+ICBidWNrMyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAxICAgIDAgICAgICAwDQo+IHVua25vd24gICA5NzVtViAgICAgMG1B
ICAgNzAwbVYgIDEzNTBtVg0KPiAgYnVjazQgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSAg
ICAwICAgICAgMA0KPiB1bmtub3duICAzMzAwbVYgICAgIDBtQSAgMzAwMG1WICAzMzAwbVYNCj4g
IGJ1Y2s1ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIgICAgMSAgICAgIDANCj4gdW5rbm93
biAgMTgwMG1WICAgICAwbUEgIDE2MDVtViAgMTk5NW1WDQo+ICAgICBsZG82ICAgICAgICAgICAg
ICAgICAgICAgICAgICAxICAgIDAgICAgICAwIA0KDQpUaGF0IHdhcyBteSBwb2ludCA6KSBCZWZv
cmUgdGhpcyBjb21taXQgdGhlIHN5c3RlbSBoYXMgYWN0ZWQNCmRpZmZlcmVudGx5IC0gZWl0aGVy
IGJ5IGFjY2lkZW50IG9yIGJ5IHB1cnBvc2UuIEluIGFueSBjYXNlLCB0aGUgRFRTDQpjaGFuZ2Ug
d2lsbCBjaGFuZ2Ugc3VwcGx5IGxvZ2ljIGFuZCB0aGlzIHNob3VsZCBwcm9iYWJseSBiZSBtZW50
aW9uZWQNCmluIGNvbW1pdCBsb2cgdG8gaGVscCBiaXNlY3RpbmcgcG9zc2libGUgaXNzdWVzIDop
DQoNCkJ1dCBhcyBJIHNhaWQsIEkgYW0gbm90IG9wcG9zZWQgdG8gdGhpcyBjaGFuZ2UgLSBJIGFt
IG1lcmVseSBzb21ld2hhdA0KY2F1dGlvdXMgd2l0aCBjaGFuZ2VzIGxpa2UgdGhpcy4NCg0KQmVz
dCByZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQo=
