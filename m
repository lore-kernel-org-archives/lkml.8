Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D99C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0BC2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="MhiVp2uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgHYGvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:51:40 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:35680
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbgHYGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtFmm2GUa0NqhF5/y0iASz4j2WXGw7+aAwUQ81rtwnkyMHJrCZKVd6Ahij568OAj+V4cA4w6y/coR5aucs8NJlZc32F1hdBzdbjUEEX4y1F2k4qke2p6l74At+KLFICZ/uq6YHqKIJy15zWYJ71xcp8g8dsFoBMKmRciYmfQobB44bFmJWAyG5wcPao/NtDSl3Am9I2kuQPjaBqgvn5BjyqZpoUHjieR3ybbom6RHHMhpirGA9T92pjh+saJAKKX3B2ijNKzgQiLCTOIrZU0gHdMyhjxQo0I/ksURKcoHolu4BZnhtwMoZdvhXqOoodutzBRo5HEEz3SNkpzpdBodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImM6DIYX0r2z9CmaNABp/M4Z9LB7QUB+e993laO9wfo=;
 b=mW4EN36S2aMyAH4Xnx2JbeGMHeBbMtq8qecjakNVtSkvg7e2wosaSf38aeHobwriMc0xIrzZt0kAo7NEJuVjTXG+Qve7R5ma2dbEs4tB2msreC0BJTTiIoyEu6P016eYuKxbxRhX78Z3bqFvEmE8LC+egF5Dx+2JSAiwPjS22FqoXMnC8cOMJDFgXpMkQVfMrqaUOU2kjhroIba2orxACVeQOAPOTrZlt4baFA5ynv3CyDojsDknGGp8oz1YBmFeearDBuZPXdbRPBp6SYzYXkntY11Sw5FdqKVP/ES7jh3ACp53F2V4W7eTs9G1zTtW1kLmvI2V8lqVhaTuPVrq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImM6DIYX0r2z9CmaNABp/M4Z9LB7QUB+e993laO9wfo=;
 b=MhiVp2uqPzcD8v7JpqJGZlKglCoauMKQtd2nqtH4zDUlLNGavrbBHpZo+FRpr81q/Ru7KW/GGO7Vo+wZc3xFEzC/z1VuWwZ6rIWgwk+LcFPzfUJvwPSBjm5OHnrodcjeJklsvS2aQZQoyVwj387TUEvE1angIIJ8N6SuScGj8Vk=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2761.eurprd03.prod.outlook.com (2603:10a6:3:f0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Tue, 25 Aug 2020 06:51:33 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 06:51:33 +0000
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
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align regulator
 names with schema
Thread-Topic: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Thread-Index: AQHWeknSKDZwJ6TG4kKPN+CgQ8rFoqlIY7aA
Date:   Tue, 25 Aug 2020 06:51:33 +0000
Message-ID: <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
References: <20200824190701.8447-1-krzk@kernel.org>
         <20200824190701.8447-3-krzk@kernel.org>
In-Reply-To: <20200824190701.8447-3-krzk@kernel.org>
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
x-ms-office365-filtering-correlation-id: 20fefdd0-5d9c-4aab-0c80-08d848c34dcb
x-ms-traffictypediagnostic: HE1PR0302MB2761:
x-microsoft-antispam-prvs: <HE1PR0302MB2761DA9CB3D3BF9F08886E8AAD570@HE1PR0302MB2761.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiiuacgEG8yezxCtc+tbuMa5XHTLXD3UZ7yigD2JF9Q6YG632oSVGG62pMKnO/xvg/HPbZ/L87FL6atSj+RsES33gtbh3RLPD0K1ynQ7oVzRifyFZlLgIlBTkdmfbvgsYr87xfzdFLZL8piOoSQtwnrMAqV70w7f0UxFMJ6ysgau0mn45ZQ3DdwDm2T/Ce4zC2G6LZNFrV7OtY5iaUYWezN4pqt6i5gf2oQWSGNyNNY/6X2UOesDDtvPDNwHkaKsQR1Ao9HF2QQC9ZMPIYPYhvWvwuLRSOlSK6R4vp50GJzkIUet9q9XEc/M/qOriau+wd5xwm/ID6zLaxdc8W7ngWqrf9PgIHek5h1mJFYeg4gDfLleQ/zWTmN0tv8A3atUXUfnIbDEgWzk4cL+DPPGHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(6486002)(478600001)(2616005)(86362001)(186003)(26005)(5660300002)(7416002)(6506007)(316002)(8936002)(66556008)(3450700001)(6512007)(71200400001)(66446008)(64756008)(66476007)(66946007)(76116006)(8676002)(110136005)(83380400001)(2906002)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JFMoHjX2V0MQcuYDMClJzXBrOj0rmEraW+GdDwQcWqjdX/WXxBq4Q/qlLEAW++WvzK/ShP1VUx/kQbkfgAkBENjxuiPOmspiftQ+YOoKCPc7YiOTln1jjImZEotNzQPFqWz67yyvUYE+wRKXSnKrldLDUu1tbDMIWaYwQ0Itjh5uGXaIuPQE1L7w9m9EnP/fPaOocV8PsBqAES2FRrtU4bxAq/MN6b7ABxbxt6BayoE5KkXnO67YpcV0bHm5fepr6VwbwgWsvtBXocj3lckrsc1yy3ftZJaQtSiS70Ln7GiiiDTEs3124rMKFCLyA/LPWt6BTof3ZlgSVeoSrihAni+ickIpYgvMb8AR+pWKAks6Bu8yO3060NKesEtgNCUkf16GfXBPArRERAwuoTradnl93eO3f3Rq1AxvEEK1uW3QjOsB3+ERfZ2MByJLEMD1bKqyJVeMosqJSJuY79oca146rnVLnSTIO7/VeDzUhlPUHJ8GqP9/tEl3QZsCT2d2D4XE7+CWEa8UNS3kush1jwqlmpG73gnUvh7Cno5rZpnmmFEWgKyYo3b2/uswuiLUdLvtCcMlXsMzrjGmRDsmI+wRKlonRirEUUHtiOwtwEm/CYFsb6gGg4CXR00RQ9ci/SqGjeD75BXf4OvV3Gi1Mw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A58FAF577ED39742859C2E9D3C43271D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fefdd0-5d9c-4aab-0c80-08d848c34dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 06:51:33.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kbNBjPfE/CitspfST5gxk3HXyVvMycEdp0jRz+Ss0x6ybhOGC0lH6s9neqlqJTdsvGE+1gdl6cxUroHkmzHU9/TWQ07r8G8hICiuBplRGWKftnHIai5sX8T0NtC3WQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQpKdXN0IHNvbWUgcXVlc3Rpb25zIC0gcGxlYXNlIGlnbm9yZSBp
ZiBJIG1pc3VuZGVyc3Rvb2QgdGhlIGltcGFjdCBvZg0KdGhlIGNoYW5nZS4NCg0KT24gTW9uLCAy
MDIwLTA4LTI0IGF0IDIxOjA2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBE
ZXZpY2UgdHJlZSBzY2hlbWEgZXhwZWN0cyByZWd1bGF0b3IgbmFtZXMgdG8gYmUgbG93ZXJjYXNl
LiAgVGhpcw0KPiBmaXhlcw0KPiBkdGJzX2NoZWNrIHdhcm5pbmdzIGxpa2U6DQo+IA0KPiAgICAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWRkcjQtZXZrLmR0LnlhbWw6IHBt
aWNANGI6DQo+IHJlZ3VsYXRvcnM6TERPMTpyZWd1bGF0b3ItbmFtZTowOiAnTERPMScgZG9lcyBu
b3QgbWF0Y2ggJ15sZG9bMS02XSQnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bW4tZGRyNC1ldmsuZHRzICAgIHwgMjIgKysrKysrKysrLS0tLS0tDQo+IC0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZGRyNC1l
dmsuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWRkcjQtZXZr
LmR0cw0KPiBpbmRleCBhMWU1NDgzZGJiYmUuLjI5OWNhZWQ1ZDQ2ZSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWRkcjQtZXZrLmR0cw0KPiArKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZGRyNC1ldmsuZHRzDQo+IEBA
IC02MCw3ICs2MCw3IEBADQo+ICANCj4gIAkJcmVndWxhdG9ycyB7DQo+ICAJCQlidWNrMV9yZWc6
IEJVQ0sxIHsNCj4gLQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJCVUNLMSI7DQo+ICsJCQkJcmVndWxh
dG9yLW5hbWUgPSAiYnVjazEiOw0KDQpJIGFtIG5vdCBhZ2FpbnN0IHRoaXMgY2hhbmdlIGJ1dCBJ
IHdvdWxkIGV4cGVjdCBzZWVpbmcgc29tZSBvdGhlcg0KcGF0Y2hlcyB0b28/IEkgZ3Vlc3MgdGhp
cyB3aWxsIGNoYW5nZSB0aGUgcmVndWxhdG9yIG5hbWUgaW4gcmVndWxhdG9yDQpjb3JlLCByaWdo
dD8gU28gbWF5YmUgSSBhbSBtaXN0YWtlbiBidXQgaXQgbG9va3MgdG8gbWUgdGhpcyBjaGFuZ2Ug
aXMNCnZpc2libGUgaW4gc3VwcGxpZXJzLCBzeXNmcyBhbmQgZGVidWdmcyB0b28/IFRodXMgY2hh
bmdpbmcgdGhpcyBzb3VuZHMNCmEgYml0IGxpa2UgYXNraW5nIGZvciBhIG5vc2UgYmxlZWQgOikg
QW0gSSByaWdodCB0aGF0IHRoZSBpbXBhY3Qgb2YNCnRoaXMgY2hhbmdlIGhhcyBiZWVuIHRob3Jv
dWdobHkgdGVzdGVkPyBBcmUgdGhlcmUgYW55IG90aGVyIHBhdGNoZXMNCih0aGF0IEkgaGF2ZSBu
b3Qgc2VlbikgcmVsYXRlZCB0byB0aGlzIGNoYW5nZT8NCg0KPiAgCQkJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDcwMDAwMD47DQo+ICAJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8
MTMwMDAwMD47DQo+ICAJCQkJcmVndWxhdG9yLWJvb3Qtb247DQo+IEBAIC02OSw3ICs2OSw3IEBA
DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlidWNrMl9yZWc6IEJVQ0syIHsNCj4gLQkJCQlyZWd1bGF0
b3ItbmFtZSA9ICJCVUNLMiI7DQo+ICsJCQkJcmVndWxhdG9yLW5hbWUgPSAiYnVjazIiOw0KPiAg
CQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDcwMDAwMD47DQo+ICAJCQkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MTMwMDAwMD47DQo+ICAJCQkJcmVndWxhdG9yLWJvb3Qtb247DQo+
IEBAIC03OSwxNCArNzksMTQgQEANCj4gIA0KPiAgCQkJYnVjazNfcmVnOiBCVUNLMyB7DQo+ICAJ
CQkJLy8gQlVDSzUgaW4gZGF0YXNoZWV0DQo+IC0JCQkJcmVndWxhdG9yLW5hbWUgPSAiQlVDSzMi
Ow0KPiArCQkJCXJlZ3VsYXRvci1uYW1lID0gImJ1Y2szIjsNCj4gIAkJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDw3MDAwMDA+Ow0KPiAgCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0g
PDEzNTAwMDA+Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJYnVjazRfcmVnOiBCVUNLNCB7DQo+ICAJ
CQkJLy8gQlVDSzYgaW4gZGF0YXNoZWV0DQo+IC0JCQkJcmVndWxhdG9yLW5hbWUgPSAiQlVDSzQi
Ow0KPiArCQkJCXJlZ3VsYXRvci1uYW1lID0gImJ1Y2s0IjsNCj4gIAkJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDwzMDAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9
IDwzMzAwMDAwPjsNCj4gIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gQEAgLTk1LDcgKzk1LDcg
QEANCj4gIA0KPiAgCQkJYnVjazVfcmVnOiBCVUNLNSB7DQo+ICAJCQkJLy8gQlVDSzcgaW4gZGF0
YXNoZWV0DQo+IC0JCQkJcmVndWxhdG9yLW5hbWUgPSAiQlVDSzUiOw0KPiArCQkJCXJlZ3VsYXRv
ci1uYW1lID0gImJ1Y2s1IjsNCg0KV2hhdCBJIHNlZSBpbiBiZDcxOHg3LXJlZ3VsYXRvci5jIGZv
ciBMRE82IGRlc2MgaXM6DQoNCiAgICAgICAgICAgICAgICAgICAgICAgIC8qIExETzYgaXMgc3Vw
cGxpZWQgYnkgYnVjazUgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgIC5zdXBwbHlfbmFtZSA9
ICJidWNrNSIsDQoNClNvLCBpcyB0aGlzIGNoYW5nZSBnb2luZyB0byBjaGFuZ2UgdGhlIHN1cHBs
eS1jaGFpbiBmb3IgdGhlIGJvYXJkPyBJcw0KdGhpcyBpbnRlbmRlZD8gKE9yIGFtIEkgbWlzdGFr
ZW4gb24gd2hhdCBpcyB0aGUgaW1wYWN0IG9mIHJlZ3VsYXRvci0NCm5hbWUgcHJvcGVydHk/KQ0K
DQpCZXN0IFJlZ2FyZHMNCglNYXR0aSBWYWl0dGluZW4NCg==
