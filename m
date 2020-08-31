Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C0FC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7432D20707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="KbMm92/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHaFaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:30:08 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:51422
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgHaFaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:30:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b22NKGwdXCJmZW4T8ayBtJovIg6OGzFIrCEPLTxt1spyY1x1CTt5YHh1TAYdOUEDdu0Wt/YfomRVHuzR2dBtP5e9TTIMRiX+1xP1M4jeYr6PmJP6b5vfJDLcZQUpbsYPZ3252J3miLGWCKrpBCWGAWwdFExHvmSm4Tdfxfq4JYn1NXtEVOD/LZTQXGEBWOdJjmtIqccnVWFnRSaS6MfO+HRrMqUCSwwfZMejaRASikufwiXJdSGMJry1TWgSot182WmzociG7s0fXhWXZV2CdglRSn4JkUvjRKNM1thLtasQWVQCnl6jRIidMiQ8VfPyI+mhNJ9OsAScJhC4W2LYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuIhBKsS32sDuz65JCLD3NF/IO7hnmriQ7ZJ+t2NASg=;
 b=oIdIGB3wx/MODY4ynrGvEKxd5+L+yc+RU9eMUnSKhiBML/73eiXKIIV/jlZGAbeAK6DD/b71m8T6hAuRnxXzVp9dUHI8FRyPvr8HrHVDxJ+9j9wA+N3G5+wZrTIgWnQmBUxZDdBo/+QEJzfNBzth3cBiAZf1f1Up8ChiH4eYj59s3Q10vz9ieS50vBwuqWdsgrEDTOo0BOnypkxuCCLsNoI+6id8Non0qRb7Lclcbog00zVcoNIH8xaWsQNsxtWoBXcdcas+VXZRUBQLRFLPYWZY2r0z6VDraX5bvYR8zc5no+PMjA1KuSozZrzbfWIkEOqzlR2bjQGl4XxSPJdRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuIhBKsS32sDuz65JCLD3NF/IO7hnmriQ7ZJ+t2NASg=;
 b=KbMm92/tzNytiKD2VvdbB8Tt4RpGPG3d8k4B6baBxGXOIBa1k99yFL/2oKJ0X9V88J7wCCW86AIMzBx24ZcsAotdsNIvN+8Zzyp5oj/FmySS3leJtGjmLDjJFbDAujZtWlNUj7xxxwJ67bT7dp59d4LTHC0VrceZM7z6Eo4htEk=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2171.eurprd03.prod.outlook.com (2603:10a6:3:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Mon, 31 Aug 2020 05:30:02 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 05:30:02 +0000
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
Subject: Re: [PATCH v2 08/19] arm64: dts: imx8mm-evk: Add 32.768 kHz clock to
 PMIC
Thread-Topic: [PATCH v2 08/19] arm64: dts: imx8mm-evk: Add 32.768 kHz clock to
 PMIC
Thread-Index: AQHWfVs3qYAjSZXoH0mZ365PL1Fx96lRtNYA
Date:   Mon, 31 Aug 2020 05:30:02 +0000
Message-ID: <3fa98bbdc9aaa60d9fefa9034cd23441713b2e85.camel@fi.rohmeurope.com>
References: <20200828164750.10377-1-krzk@kernel.org>
         <20200828164750.10377-9-krzk@kernel.org>
In-Reply-To: <20200828164750.10377-9-krzk@kernel.org>
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
x-ms-office365-filtering-correlation-id: 77614314-ff6c-46cf-d4c6-08d84d6ee95a
x-ms-traffictypediagnostic: HE1PR0301MB2171:
x-microsoft-antispam-prvs: <HE1PR0301MB2171355911C37A62737E3231AD510@HE1PR0301MB2171.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +uenvtESHIiBNf3zloAkNaUaaq0g/giAz+DYw5ZjQAkjU3XhD/RiyIf7ZSYSicQPgcfw2eZX2oiXwpt7t7+sqDy3meby/MxGHS8NS/pNPDqNXcSqoW9uzax504sGeY+R6TCkeimUKhcDspP2mIuIPlnNIuEHu506k0dwUqaWCgtRnwoEOcangizw0MZo7vNai583yrXFy0ZOwC61LdgqMHFYmENasndTSqc3KjUWFEUF+m2xCkA7K87q7yI1FyNpCHFxtf+BoUMxwZZBUNMK6gHDKATYJSPEEs6+UyyNSAScMzwfAgJzfr9T4ztvzRIRP6uG2N8owKY3zC7aHQQ9Ur+aGNbfPFNyLgzDnFrWrcmJ43z7Xym4hwZ6teaAqTeKpIB0IbLLUlHjvPckDKTJlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39840400004)(376002)(396003)(66476007)(2906002)(64756008)(478600001)(6506007)(71200400001)(66446008)(6486002)(5660300002)(2616005)(76116006)(26005)(186003)(8676002)(83380400001)(8936002)(66946007)(3450700001)(86362001)(66556008)(7416002)(4744005)(6512007)(316002)(110136005)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WdfdoyQafJ+igjIGEf2RaVrH7a4QzIaq8L7jtJ5Q7O29yfhbdUvw8Nuy8zPN9Jdx6mstfz7R6b9u10MqRx7UP6kmUKLw6k/R/zhHCl18vEqZR7MVoV735/p2g8Hawo4NJxxutA8TCngAQeMRHg+OUkfXsKO1Y+zwOqzRT8Md1gWt6K2XngXTZ4HiLtxeD9V6lWv8RGdZYt4PdcQZ6UDzwRgav3PQizTQ1OIdM2W1UulxDvLkj79YDJZEh4OkeQOSsPazn2amn0LwSfSpmqxmdyCWqKGmGaM2rzFA6o8zc4APJ10iwG6yZLa0k7KsRq5RIdZTMJmypjcPAy8mko3ztUmfcXhrnisHTmzSGqNQvHjtOq6mrGMlGWlfZU0uA592Z9MLRM6XV0ZNxbSVKb7Cp97giHE/qYFfftDrOULnF4AQy57oN1Og/YGFlRswze8I9zV6ohdycVQaqRqMfIuo0JdDAUcGmNvC3GpDL69ORKN2igUdIo7xeuDsIua/4HhC7FZ32TDqhyXW7EX36FaeZHKCbI1YQHR2r5fmzyTTPnvhBIm9y2kJpGqMR/2QZrMnmaFdOYRBL1faX/S+gzyBXL7Axsym7jUk93i0ngnPtbtGmvB367ROjUrwVCLpO+IFe39FmBpzeHPz9/2J0bzHHg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E8AD64092C9294B96DAAF233D46A5F4@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77614314-ff6c-46cf-d4c6-08d84d6ee95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 05:30:02.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwBBlYioCr+wm6yVvJrN+wdFT0uzlSSXvFbp2zgndNtpNYJ23OZaMALFOB01xElJEIdPRVgsvczqRKdRB90xhW37zSY567xB/087MdeMmBoGirXJmYpT0ls7hNt70VEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDgtMjggYXQgMTg6NDcgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IFRoZSBST0hNIEJENzE4NDcgUE1JQyBoYXMgYSAzMi43Njgga0h6IGNsb2NrLiAg
QWRkaW5nIG5lY2Vzc2FyeQ0KPiBwYXJlbnQNCj4gYWxsb3dzIHRvIHByb2JlIHRoZSBiZDcxOHg3
IGNsb2NrIGRyaXZlciBmaXhpbmcgYm9vdCBlcnJvcnM6DQo+IA0KPiAgICAgYmQ3MTh4eC1jbGsg
YmQ3MTg0Ny1jbGsuMS5hdXRvOiBObyBwYXJlbnQgY2xrIGZvdW5kDQo+ICAgICBiZDcxOHh4LWNs
azogcHJvYmUgb2YgYmQ3MTg0Ny1jbGsuMS5hdXRvIGZhaWxlZCB3aXRoIGVycm9yIC0yMg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0K
DQpGV0lXOg0KQWNrZWQtQnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJv
aG1ldXJvcGUuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLWV2ay5kdHMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0tZXZrLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsu
ZHRzDQo+IGluZGV4IDNjYjhiNmJjYjY1Ny4uMDExNWYwN2JiYzlkIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cw0KPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cw0KPiBAQCAtMTQ5LDYgKzE0
OSwxMCBAQA0KPiAgCQlpbnRlcnJ1cHRzID0gPDMgR1BJT19BQ1RJVkVfTE9XPjsNCj4gIAkJcm9o
bSxyZXNldC1zbnZzLXBvd2VyZWQ7DQo+ICANCj4gKwkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiAr
CQljbG9ja3MgPSA8Jm9zY18zMmsgMD47DQo+ICsJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJjbGst
MzJrLW91dCI7DQo+ICsNCj4gIAkJcmVndWxhdG9ycyB7DQo+ICAJCQlidWNrMV9yZWc6IEJVQ0sx
IHsNCj4gIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJidWNrMSI7DQoNCg==
