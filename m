Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8777BC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6370D20707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="UyGzwzHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgHaF1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:27:34 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:28463
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgHaF1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4nrW7EbEj2baYEOG/DguM1Wt1pUpzj0QjNDSt7pL4r0JtjmijylUpGLTndv/qm2NXb9y4z2E6eAQtiRMMQePfZdEtAluuo34G6wyh6GYec6zF4/flTTHRwxQfRA33n+KQV/5Zn/Y7A6lyBK0w4JXCr10e6tCIYEQgVo2bryiUGQWjybJwwz/8q8vvLO/n2zgMGDyXbyibi6+btKv1G7FEwSutjKYfdggMmmurNZb0LjsDKbxxQyl9uLyBu0Lcc5JygfHO1UMnkAcXORRpvZv+VWHCWveYfH6GPnD9OjpHrViyQLS5ATLuitkmWCOJ34ugWQCjrqcZW/gwPpP67DVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1NjVwpG0/bqEsjr8fUZLA7UPZ25fpXOilWDBB6BSvo=;
 b=fbfTnvt1yDs0kzyfiB8vmpdgE4ICP6B84f6wJiNMzUd1ayVtYBML1f/3nRFEQfsl8PCYrbZizLFrMJr6KwET5LjGgAXzhr0SpkRRNFfNdD8+thpQJXz0dj0wv+ZK7jTHh97KDEHgfXRADexcjWIfSwFbBhFSxyvBTUWnGOv88ef6x/+AQ2zi7pvzVXjzw+8zHwesFFyu4Gayekh7wP5ipyklrYoI+eyCpJKMU0TNvrLx7GfDT8Tpi2iQv1U1WlILMKE3RZHhNEfgUHbB6PTuPvwrUakSq2T4A1ixu0Z3ygjRjobBR6VhKdqMsOxRrwec3aljLcThhac0Z8bw6ZizBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1NjVwpG0/bqEsjr8fUZLA7UPZ25fpXOilWDBB6BSvo=;
 b=UyGzwzHIfN1D0By819AB4qYQHzt8lf41OUwZrLDEi0tZo2phKv8ZJt27A3Lw3kSCLeL1qzmGn3U6x8eG33x6FrDTLxGHgRvDlSogJebS6M9pKxk/1ZieNysQEwcimsfdeklPBMfVlnZlU0sPrqaUOlqetORXnJlzdynGHbn2KTw=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2171.eurprd03.prod.outlook.com (2603:10a6:3:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Mon, 31 Aug 2020 05:27:27 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 05:27:27 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>
Subject: Re: [PATCH v2 11/19] arm64: dts: imx8mn-ddr4-evk: Align regulator
 names with schema
Thread-Topic: [PATCH v2 11/19] arm64: dts: imx8mn-ddr4-evk: Align regulator
 names with schema
Thread-Index: AQHWfVtANiMBr6KdbUCGUBkJMGxrFqlRtBwA
Date:   Mon, 31 Aug 2020 05:27:26 +0000
Message-ID: <751b3933df6efde5ca9ad4148ddef8588459cd21.camel@fi.rohmeurope.com>
References: <20200828164750.10377-1-krzk@kernel.org>
         <20200828164750.10377-12-krzk@kernel.org>
In-Reply-To: <20200828164750.10377-12-krzk@kernel.org>
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
x-ms-office365-filtering-correlation-id: cbe334ae-4b6b-4383-1720-08d84d6e8c8e
x-ms-traffictypediagnostic: HE1PR0301MB2171:
x-microsoft-antispam-prvs: <HE1PR0301MB217154150E241C7981BB7A18AD510@HE1PR0301MB2171.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISKjuhEI4XumeqOSFYWCsT+nGf6yR3j3LEv1XWuFSGmyrRgGKrTpHkkCvBAYas+Dx45J1hpGJpRGP730UQLMVApcf+XS9bixS7S9jUWCupVBuDpjwinhuVJDWVBvswbSr9GHh1yY/jmbq5JQNVXR5508X9LNscPvdAWEhNyvuDlpWb8CwjbJ2qv+YSLia9hQ1ws+YyQaMisggL0oLsqEStd92wI/z07BOCuEi9RulTGKdzAJi5GH87K9fD6PuNKeqAyCkBKeAh35uV9jQjN1bAmyNziJOvjQHqF3ltKCxaJphl6PVppESbMIgcEg+E8huXvUjeEzIgxwa25A8+nnVszedMIvtLTm0xs3/H05UVIM9OipKevhYe1KIV9dvMr2J533BTaWqduhwiKn6PzRSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39840400004)(136003)(366004)(346002)(86362001)(66556008)(3450700001)(66946007)(316002)(6512007)(7416002)(110136005)(64756008)(6506007)(478600001)(66476007)(2906002)(76116006)(26005)(186003)(8936002)(8676002)(83380400001)(71200400001)(6486002)(5660300002)(2616005)(66446008)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aEzu3ZdMYj8JBzrBwcZhNCOni+CTTeIUAlJSizv4kkx4kZ3oAntBg7JMH1vsmDG9A5X/Ur1AdTjYapYmGy1hXNjvfTC1y1YwpZSlcv6Pm1BcuvNKckKVgUnqDGRDiCWSFSypsUv0LjbQV8h0+YVk6jNxp1zZVgiaO273mFZiw5w1zkvdIwkNijActosqSTDmJReDkTsfN1x+kiOe35MkGvaj0TMUstNJ4j18f3BvyLeK8y//t5u9Tmiib/72RODDsQHc7aKbHeez4izL51QgaKph8ImuangquSXlZdLO24Vnzn/mSYcM+ZvUEVHUXC7np2+Nk27PCyPm4laaVKo18WZICazju1P2lzq+kUE7u1OcraeXkcvh06jK10hu/ZojV6+Y/yqlENH6Maq7qkWcmnvyCAFrb//qCAGGVCQ2tVci0YRwR2Sou/WGcjTsxTW3sCWN1Mb+6e0GGr528k5aAjsDFM3ekHrBBqvJHGNWmyMZWHqwavDF3dVPeYYigbnPV8FZpZnW/t7yqrTH1r37xtCpa1J3khuK8LXIcgIzf4eJ7yLV0op98Al1Bg432N+pBHI7Scz2FlQcuS6IA/3d+ADqZMLdqC7CO/0FaFWZCkMEHO4/bmwEe/poDN8hGVzIMWt2aP4pdW4xNoIBsevSyw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <320CBFF8EACA6D4C8F6161629EA048B7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe334ae-4b6b-4383-1720-08d84d6e8c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 05:27:27.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfUm+vFtlpaeRf1GYQ6duRIWoz1Wm4EvmWPeJ/0ht0jrJD6zkxrTxExefX6bkJbbKu8SVc+0A+pXc1aJwwZ2Bii6RK+FiB5EzTgJaCr8Katmi1lgHRestEQ5livpy3uQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDgtMjggYXQgMTg6NDcgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IERldmljZSB0cmVlIHNjaGVtYSBleHBlY3RzIHJlZ3VsYXRvciBuYW1lcyB0byBi
ZSBsb3dlcmNhc2UuICBDaGFuZ2luZw0KPiB0bw0KPiBsb3dlcmNhc2UgaGFzIG11bHRpcGxlIGVm
ZmVjdHM6DQo+IDEuIExETzYgc3VwcGx5IGlzIG5vdyBwcm9wZXJseSBjb25maWd1cmVkLCBiZWNh
dXNlIHJlZ3VsYXRvciBkcml2ZXINCj4gICAgbG9va3MgZm9yIHN1cHBsaWVzIGJ5IGxvd2VyY2Fz
ZSBuYW1lLA0KPiAyLiBVc2VyLXZpc2libGUgbmFtZXMgdmlhIHN5c2ZzIG9yIGRlYnVnZnMgYXJl
IG5vdyBsb3dlcmNhc2UsDQo+IDIuIGR0YnNfY2hlY2sgd2FybmluZ3MgYXJlIGZpeGVkOg0KPiAN
Cj4gICAgIHBtaWNANGI6IHJlZ3VsYXRvcnM6TERPMTpyZWd1bGF0b3ItbmFtZTowOiAnTERPMScg
ZG9lcyBub3QgbWF0Y2gNCj4gJ15sZG9bMS02XSQnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQoNCkZXSVc6DQpBY2tlZC1CeTogTWF0
dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoNCj4gLS0t
DQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMgICAgfCAyMiAr
KysrKysrKystLS0tLS0NCj4gLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW4tZGRyNC1ldmsuZHRzDQo+IGluZGV4IDNhYzhmOWQzYzM3Mi4uOGY3
MTU1NzE2Yzg0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW4tZGRyNC1ldmsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbi1kZHI0LWV2ay5kdHMNCj4gQEAgLTYwLDcgKzYwLDcgQEANCj4gIA0KPiAgCQlyZWd1
bGF0b3JzIHsNCj4gIAkJCWJ1Y2sxX3JlZzogQlVDSzEgew0KPiAtCQkJCXJlZ3VsYXRvci1uYW1l
ID0gIkJVQ0sxIjsNCj4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJidWNrMSI7DQo+ICAJCQkJcmVn
dWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NzAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItbWF4LW1p
Y3Jvdm9sdCA9IDwxMzAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gQEAgLTY5
LDcgKzY5LDcgQEANCj4gIAkJCX07DQo+ICANCj4gIAkJCWJ1Y2syX3JlZzogQlVDSzIgew0KPiAt
CQkJCXJlZ3VsYXRvci1uYW1lID0gIkJVQ0syIjsNCj4gKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJi
dWNrMiI7DQo+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NzAwMDAwPjsNCj4gIAkJ
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMzAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3It
Ym9vdC1vbjsNCj4gQEAgLTc5LDE0ICs3OSwxNCBAQA0KPiAgDQo+ICAJCQlidWNrM19yZWc6IEJV
Q0szIHsNCj4gIAkJCQkvLyBCVUNLNSBpbiBkYXRhc2hlZXQNCj4gLQkJCQlyZWd1bGF0b3ItbmFt
ZSA9ICJCVUNLMyI7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAiYnVjazMiOw0KPiAgCQkJCXJl
Z3VsYXRvci1taW4tbWljcm92b2x0ID0gPDcwMDAwMD47DQo+ICAJCQkJcmVndWxhdG9yLW1heC1t
aWNyb3ZvbHQgPSA8MTM1MDAwMD47DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlidWNrNF9yZWc6IEJV
Q0s0IHsNCj4gIAkJCQkvLyBCVUNLNiBpbiBkYXRhc2hlZXQNCj4gLQkJCQlyZWd1bGF0b3ItbmFt
ZSA9ICJCVUNLNCI7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAiYnVjazQiOw0KPiAgCQkJCXJl
Z3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMwMDAwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1ib290LW9uOw0KPiBAQCAt
OTUsNyArOTUsNyBAQA0KPiAgDQo+ICAJCQlidWNrNV9yZWc6IEJVQ0s1IHsNCj4gIAkJCQkvLyBC
VUNLNyBpbiBkYXRhc2hlZXQNCj4gLQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJCVUNLNSI7DQo+ICsJ
CQkJcmVndWxhdG9yLW5hbWUgPSAiYnVjazUiOw0KPiAgCQkJCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDE2MDUwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE5OTUw
MDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1ib290LW9uOw0KPiBAQCAtMTA0LDcgKzEwNCw3IEBADQo+
ICANCj4gIAkJCWJ1Y2s2X3JlZzogQlVDSzYgew0KPiAgCQkJCS8vIEJVQ0s4IGluIGRhdGFzaGVl
dA0KPiAtCQkJCXJlZ3VsYXRvci1uYW1lID0gIkJVQ0s2IjsNCj4gKwkJCQlyZWd1bGF0b3ItbmFt
ZSA9ICJidWNrNiI7DQo+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsN
Cj4gIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxNDAwMDAwPjsNCj4gIAkJCQlyZWd1
bGF0b3ItYm9vdC1vbjsNCj4gQEAgLTExMiw3ICsxMTIsNyBAQA0KPiAgCQkJfTsNCj4gIA0KPiAg
CQkJbGRvMV9yZWc6IExETzEgew0KPiAtCQkJCXJlZ3VsYXRvci1uYW1lID0gIkxETzEiOw0KPiAr
CQkJCXJlZ3VsYXRvci1uYW1lID0gImxkbzEiOw0KPiAgCQkJCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDE2MDAwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAw
MDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1ib290LW9uOw0KPiBAQCAtMTIwLDcgKzEyMCw3IEBADQo+
ICAJCQl9Ow0KPiAgDQo+ICAJCQlsZG8yX3JlZzogTERPMiB7DQo+IC0JCQkJcmVndWxhdG9yLW5h
bWUgPSAiTERPMiI7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAibGRvMiI7DQo+ICAJCQkJcmVn
dWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItbWF4LW1p
Y3Jvdm9sdCA9IDw5MDAwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1ib290LW9uOw0KPiBAQCAtMTI4
LDcgKzEyOCw3IEBADQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlsZG8zX3JlZzogTERPMyB7DQo+IC0J
CQkJcmVndWxhdG9yLW5hbWUgPSAiTERPMyI7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAibGRv
MyI7DQo+ICAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47DQo+ICAJCQkJ
cmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ICAJCQkJcmVndWxhdG9yLWJv
b3Qtb247DQo+IEBAIC0xMzYsNyArMTM2LDcgQEANCj4gIAkJCX07DQo+ICANCj4gIAkJCWxkbzRf
cmVnOiBMRE80IHsNCj4gLQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJMRE80IjsNCj4gKwkJCQlyZWd1
bGF0b3ItbmFtZSA9ICJsZG80IjsNCj4gIAkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw5
MDAwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KPiAg
CQkJCXJlZ3VsYXRvci1ib290LW9uOw0KPiBAQCAtMTQ0LDcgKzE0NCw3IEBADQo+ICAJCQl9Ow0K
PiAgDQo+ICAJCQlsZG82X3JlZzogTERPNiB7DQo+IC0JCQkJcmVndWxhdG9yLW5hbWUgPSAiTERP
NiI7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAibGRvNiI7DQo+ICAJCQkJcmVndWxhdG9yLW1p
bi1taWNyb3ZvbHQgPSA8OTAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9
IDwxODAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCg0K
