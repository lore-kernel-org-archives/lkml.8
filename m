Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E71D208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fofP4O1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGCCi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:38:29 -0400
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:9910
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgGCCi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:38:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7rXAV20NxjtFdalRPLmLu2S4VIF4f2deagEEAotFSxrAO3hDZwkvtOG0zZMZ4V9KTWzqiajpnlAwpfMr8Frv3unYn0iJZawOhRUnkOtur8MIK1uHof8yALbj19Hq5LRBbQfw0+VQfCNM1bPiZzKevTZzU0h0bL96oXhVJavcL3OqrQRaKyJ/ONo5zhtcOHAcHGRNPN6E9pUyfAp1FO6mWM8dhgwtVNO2zqzmXj0QbQgax4XPIuN1yzodEKUeceo7/lpnRQlbVSYQbBeCqsWYZjglqk6ouzEtLRhaFIioXwpG/M5wQqQk1AvYCZUGUwfxjBJpCIC497I7n2B/jhW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGL1nJzkH1tAdeS8rRYR1YfVe01GChXSNvfXAIbeh/U=;
 b=FESAS9ZN+RwSeblhaHd5WLrDXZ4xFtynN4ncXG3wFDLN9uEpacBB6fUnvS0tg9NhnoYwCcRCUFudpGoLZQZHUrLbls5lxcL4KOC/eflMQ2VnYxmZ1fxs/FOi6sUMVt4TsK55sWsIciS1j82kl7lY6T+ov4iZBMZWfkxRmBONg9tYBLfYsaMnZuUof7Xkr6rOXoKofDh98g3qSCGClj8TJkYDvPCNz7ZtGWBGrMyQMi38QSKLoFzt2jbAgw/qhIIBwtJXTB8hcsTXTUKMYrGB1n+GVgMZggFiU06wn1qJ7nEF5Z9laDnrrCKSo4p8PlXdM+JdTWvmQ9a8J0hLzDG3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGL1nJzkH1tAdeS8rRYR1YfVe01GChXSNvfXAIbeh/U=;
 b=fofP4O1Jfco0FLONNzJbxQsCfaEuupmbSr3Ka7a1fAaNmptnxWuASDyS8mHz82QdxMmPoHFgK+jKZmlP+lXbA6Cb7fkRc6d99GwGXmEsEyRjalj0vSGYACvLEnH+sF0N3mSbrRA1LIWfqUbY4JsguTpnMhKp0+YmUtmVJNLhMxQ=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3551.eurprd04.prod.outlook.com (2603:10a6:803:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 02:38:22 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 02:38:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        John Lee <john.lee@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 1/4] regulator: pca9450: add pca9450 pmic driver
Thread-Topic: [PATCH v1 1/4] regulator: pca9450: add pca9450 pmic driver
Thread-Index: AQHWLeZz8tn7jgrUZ0i5ETOY7Ab/8Kj0dj6AgADdunA=
Date:   Fri, 3 Jul 2020 02:38:21 +0000
Message-ID: <VE1PR04MB66384243FA576A12E8A61E03896A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
 <1589925907-9195-2-git-send-email-yibin.gong@nxp.com>
 <5224b8d2-177e-7cc0-24dc-2454fd553b1b@kontron.de>
In-Reply-To: <5224b8d2-177e-7cc0-24dc-2454fd553b1b@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35c6425d-d3d1-426f-09ca-08d81efa2746
x-ms-traffictypediagnostic: VI1PR0402MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3551F242A26FA4AB8C5688E4896A0@VI1PR0402MB3551.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwWT+w2w8n0WzHH1hcIWINGkFGGzpV8lB9AsBCbF06/rx/0AaoVpr+tzBsYtp3UO/z6xYl3NzgLcDa62RRYVpLDWDezbvmzpKrqoU1g0DSLD/SwhwU92gyBzClvmZm+Ih41kYYDkfkiWunKOXHjHSCGiFwmCXWlNaapziZYNQ50lH7YTpJqkUlHPhyTC9it6tanLl7YMuO3CtpJjwt3CjLO5KHD/RnzAsOPgle1X+PEfLeEtWJ8XSHRNpvsKF7Hd3QmHfzjaTV3E+Gca2xpEmS1zkTba7aAdO7/f/o1ofSxXa/21XhNzs9hHVERHJ7CusgHPFUylAKrkR8OLYN9lu62dX0id6vjzIX23L5PlObn32Alh93913SjaoyBhgYr7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(54906003)(83380400001)(6636002)(7696005)(52536014)(2906002)(498600001)(86362001)(64756008)(66446008)(76116006)(66476007)(66556008)(66946007)(26005)(110136005)(71200400001)(186003)(8936002)(33656002)(6506007)(53546011)(7416002)(9686003)(5660300002)(8676002)(55016002)(4326008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /cBg66aFyw24b2OnkFRCErGvXf96o5hgkhcQrBUWOtBoKHqplDMlVjzRNCFI+GVKVep5PKtQm1VB0MMfnMrnmKbI0MlnJsFCMkBsyS5Mg/jcNKSXYc+bo6Oyifzj4tKEyyHYg38DjERCdUm4R/c5l9T+BS2Dakzboxx2GZzXrDpX3s3TTgY76PW1NYwGkD5k2ZetZRz78h48B217+DsxZ0nXAAv8qgJQb9mZRdufT506y+wAbWqHZs9sVZusjjJoACKllGCipBJqwPO2xQtj7aj21T8ldGnVTaE5JbGzTQCMbFvZJ65RmM/kor0sOBsTcWQ0bKKYauze6Wc1cAxI5rZfSL56evNvwVJktaMtYxD4IPxxUiOkISJ7PVr+QA1QoovL2+UYtwOJNJpE434853u98KYiGVERJAzHlN7kZIfkn6c03qTjnPBpOhxExTmRXRLmC5K+abjvUiXmnccsNdctZFfh0OGsP9kkXRB3IEUCf87wDC7Hxa8j1e058vPu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c6425d-d3d1-426f-09ca-08d81efa2746
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 02:38:22.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8FbOgwUO8B4uI9D3fb7nq1dzpcbjF8WYdQnGjgMStlE4fxZdPqsmuQt+Xb9+uypVtvGxj6mP8g2RaJDopHZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC8wNy8wMiAyMDowNSBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+IHdyb3RlOg0KPiBIaSBSb2JpbiwNCj4gDQo+IE9uIDIwLjA1LjIwIDAwOjA1LCBS
b2JpbiBHb25nIHdyb3RlOg0KPiA+IEFkZCBOWFAgcGNhOTQ1MCBwbWljIGRyaXZlci4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gDQo+
IEkgcmViYXNlZCBhbmQgYXBwbGllZCBvbiB2NS44LXJjMyBhbiB0ZXN0ZWQgdGhpcyB3aXRoIG91
ciBpLk1YOE1NIGJvYXJkIHdpdGgNCj4gUENBOTQ1MEEuIEl0IHNlZW1zIHRvIHdvcmsgZmluZS4g
QmVsb3cgeW91IGNhbiBmaW5kIHNvbWUgY29tbWVudHMuDQpHbGFkIHRvIGhlYXIgdGhhdCwgdGhh
bmtzIDopDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX29wcyBwY2E5NDUwX2xkb19yZWd1
bGF0b3Jfb3BzID0gew0KPiA+ICsJLmVuYWJsZSA9IHJlZ3VsYXRvcl9lbmFibGVfcmVnbWFwLA0K
PiA+ICsJLmRpc2FibGUgPSByZWd1bGF0b3JfZGlzYWJsZV9yZWdtYXAsDQo+ID4gKwkuaXNfZW5h
YmxlZCA9IHJlZ3VsYXRvcl9pc19lbmFibGVkX3JlZ21hcCwNCj4gPiArCS5saXN0X3ZvbHRhZ2Ug
PSByZWd1bGF0b3JfbGlzdF92b2x0YWdlX2xpbmVhcl9yYW5nZSwNCj4gPiArCS5zZXRfdm9sdGFn
ZV9zZWwgPSByZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Vfc2VsX3JlZ21hcCwNCj4gPiArCS5nZXRfdm9s
dGFnZV9zZWwgPSByZWd1bGF0b3JfZ2V0X3ZvbHRhZ2Vfc2VsX3JlZ21hcCwgfTsNCj4gPiArDQo+
ID4gKy8qDQo+ID4gKyAqIEJVQ0sxLzIvMw0KPiA+ICsgKiAwLjYwIHRvIDIuMTg3NVYgKDEyLjVt
ViBzdGVwKQ0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCByZWd1bGF0b3JfbGlu
ZWFyX3JhbmdlIHBjYTk0NTBfZHZzX2J1Y2tfdm9sdHNbXSA9IHsNCj4gPiArCVJFR1VMQVRPUl9M
SU5FQVJfUkFOR0UoNjAwMDAwLCAgMHgwMCwgMHg3RiwgMTI1MDApLCB9Ow0KPiANCj4gV2l0aCB0
aGUgbGF0ZXN0IGtlcm5lbCAodjUuOC1yYykgdGhpcyBkb2Vzbid0IGNvbXBpbGUgYW55bW9yZSBi
ZWNhdXNlIG9mDQo+IDYwYWI3ZjQxNTNiNiAoInJlZ3VsYXRvcjogdXNlIGxpbmVhcl9yYW5nZXMg
aGVscGVyIikuIA0KWWVzLCBJJ2xsIHJlYmFzZSBpdCBsYXRlci4NCj4gPiArCXJldCA9IG9mX3By
b3BlcnR5X3JlYWRfdTMyKG5wLCBwcm9wLCAmdXYpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJ
CWlmIChyZXQgIT0gLUVJTlZBTCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQlyZXR1cm4g
MDsNCj4gPiArCX0NCj4gDQo+IEkgdGhpbmsgdGhpcyBuZXN0ZWQgY29uZGl0aW9uIGlzIGVhc2ll
ciB0byByZWFkIGxpa2UgdGhpczoNCk9rYXksIHdpbGwgZml4IGl0IGluIHYyLiANCg0KPiBpZiAo
cmV0ICYmIHJldCA9PSAtRUlOVkFMKQ0KPiAJcmV0dXJuIDA7DQo+IGVsc2UgaWYgKHJldCkNCj4g
CXJldHVybiByZXQ7DQo+IA0KPiA+ICsJew0KPiA+ICsJCS5kZXNjID0gew0KPiA+ICsJCQkubmFt
ZSA9ICJidWNrNCIsDQo+ID4gKwkJCS5vZl9tYXRjaCA9IG9mX21hdGNoX3B0cigiQlVDSzQiKSwN
Cj4gPiArCQkJLnJlZ3VsYXRvcnNfbm9kZSA9IG9mX21hdGNoX3B0cigicmVndWxhdG9ycyIpLA0K
PiA+ICsJCQkuaWQgPSBQQ0E5NDUwX0JVQ0s0LA0KPiA+ICsJCQkub3BzID0gJnBjYTk0NTBfYnVj
a19yZWd1bGF0b3Jfb3BzLA0KPiA+ICsJCQkudHlwZSA9IFJFR1VMQVRPUl9WT0xUQUdFLA0KPiA+
ICsJCQkubl92b2x0YWdlcyA9IFBDQTk0NTBfQlVDSzRfVk9MVEFHRV9OVU0sDQo+ID4gKwkJCS5s
aW5lYXJfcmFuZ2VzID0gcGNhOTQ1MF9idWNrX3ZvbHRzLA0KPiA+ICsJCQkubl9saW5lYXJfcmFu
Z2VzID0gQVJSQVlfU0laRShwY2E5NDUwX2J1Y2tfdm9sdHMpLA0KPiA+ICsJCQkudnNlbF9yZWcg
PSBQQ0E5NDUwX1JFR19CVUNLNE9VVCwNCj4gPiArCQkJLnZzZWxfbWFzayA9IEJVQ0s0T1VUX01B
U0ssDQo+ID4gKwkJCS5lbmFibGVfcmVnID0gUENBOTQ1MF9SRUdfQlVDSzRDVFJMLA0KPiA+ICsJ
CQkuZW5hYmxlX21hc2sgPSBCVUNLNF9FTk1PREVfTUFTSywNCj4gPiArCQkJLm93bmVyID0gVEhJ
U19NT0RVTEUsDQo+ID4gKwkJfSwNCj4gPiArCX0sDQo+IA0KPiBUaGUgZGVzY3JpcHRpb24gZm9y
IGJ1Y2s0IGlzIGFkZGVkIHR3aWNlIGhlcmUuDQpZZXMsIHdpbGwgcmVtb3ZlIGl0Lg0KPiA+ICsv
Kg0KPiA+ICsgKiBCdWNrMyByZW1vdmVkIG9uIFBDQTk0NTBCIGFuZCBjb25uZWNlZCB3aXRoIEJ1
Y2sxIGludGVybmFsIGZvcg0KPiA+ICtkdWFsIHBoYXNlDQo+IA0KPiBNaXNzaW5nICd0JyBpbiBj
b25uZWN0ZWQNCldpbGwgY29ycmVjdCBpdC4NCg0KPiA+ICsJLyogVW5tYXNrIGFsbCBpbnRlcnJ1
cHQgZXhjZXB0IFBXUk9OL1dET0cvUlNWRCAqLw0KPiA+ICsJcmV0ID0gcmVnbWFwX3VwZGF0ZV9i
aXRzKHBjYTk0NTAtPnJlZ21hcCwgUENBOTQ1MF9SRUdfSU5UMV9NU0ssDQo+ID4gKwkJCQlJUlFf
VlJfRkxUMSB8IElSUV9WUl9GTFQyIHwgSVJRX0xPV1ZTWVMgfA0KPiA+ICsJCQkJSVJRX1RIRVJN
XzEwNSB8IElSUV9USEVSTV8xMjUsDQo+ID4gKwkJCQlJUlFfUFdST04gfCBJUlFfV0RPR0IgfCBJ
UlFfUlNWRCk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycigmaTJjLT5kZXYsICJV
bm1hc2sgaXJxIGVycm9yXG4iKTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiANCj4g
V2hhdCBhYm91dCBhZGRpbmcgYSBwcmludCB3aGVuIHRoZSBwcm9iZSBoYXMgc3VjY2VlZGVkPyBP
dGhlcndpc2Ugd2UgZG9uJ3QNCj4gc2VlIGFueXRoaW5nIGFib3V0IHRoZSBkcml2ZXIgaW4gdGhl
IGxvZywgd2hlbiBpdCBwcm9iZWQgc3VjY2Vzc2Z1bGx5LiBNYXliZQ0KPiBzb21ldGhpbmcgbGlr
ZToNCj4gDQo+IGRldl9pbmZvKCZpMmMtPmRldiwgInByb2JlZFxuIik7DQo+IA0KPiB3aGljaCB3
aWxsIHJlc3VsdCBpbiB0aGUgZm9sbG93aW5nIG1lc3NhZ2U6DQo+IA0KPiBueHAtcGNhOTQ1MCAw
LTAwMjU6IHByb2JlZA0KPg0KT2theSwgd2lsbCBhZGQgaXQgZm9yIG5vdGljZS4NCg0K
