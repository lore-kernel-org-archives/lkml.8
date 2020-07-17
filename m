Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11348C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D412C20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JMkB2sgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGQKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:48:16 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:37006
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgGQKsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:48:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZpRQt77V9UrRrmFYq6JjxiLf5KnWrojpgjYZxHTzmebG+wC7ymbysMgDlwGi9J4Zn1Q8p3PcGEHh48FE4Tnc6wJA63zub7c94C9iMKTRBKPQZ9E5GgOULEKAbY3n+d3tVOSV68osoVkN1G3K6DpGrYWtvid6WhH3Tszu1QOnC0Ch8D+02zYzkF6STBQnP1+ikmjt5Q0PxtSk47oq0+J9n68VMsAg2zawseboA6/0zz6iCrIRwvJerX8NqJ3Dq1ovH2ihuyH2ZL0tW4bcSC8qy82ZwlTideEoKIHeBPN4VsU3NoxpCsJ6vFhidFeUIJdmNSMBQ674f051ewEfZg/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6iwVbliYh+cEJ751cF0XkuG05XXKIOEwhVL2HPKOKs=;
 b=lqgc0t0s3iSXGiKorEQmp5S2D3At8TKL1m0/naS9T0p1PscZsWGvAuBiGhThGZ+m50Y+u9zJYuKp6YGvYlz69uZ8KTt11hTRGoI44bleUZe8k8bVcTc0iSI5JDHtjCwVXS641z/rrKQYuXsZ2ErlMKLfTQKPiLvyDq4WvvONJDEdhuAi7MEfJ5qs95t1kb4YO4SoUEN9OaMlzWmb1x9pJ7pyOCHMvFknCcHdmJxh51tWchID/tKg3yUw6XlzzJl3XD4QlqUtTo8HoXhOucSMSfiw9WjW13y5NJFd8UPF0aHGO4rUT5BEjaQQFmfgz7o5crO3ANECkJWgcmAos38t3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6iwVbliYh+cEJ751cF0XkuG05XXKIOEwhVL2HPKOKs=;
 b=JMkB2sgvJT7VH8HCCvSEohAItRRHgLRbLOCgo/uZImqtIYK6iMnEFWuYjc83zk6wrLYmBjdzfy8M4YgMI4rPjgIhX5dO52aerC7S71H1Al0M76+IuXHcD4lMSBqJ0tBWFLBa1WdFWuVIkBexN/xc8hOw2w5NmT8C46oSMvS/zys=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4954.eurprd04.prod.outlook.com (2603:10a6:10:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 17 Jul
 2020 10:48:10 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 10:48:10 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.or" 
        <linux-arm-kernel@lists.infradead.or>
Subject: RE: [PATCH 2/2] irqchip: imx-intmux: add runtime PM support
Thread-Topic: [PATCH 2/2] irqchip: imx-intmux: add runtime PM support
Thread-Index: AQHWW2Srpx/rAxUlZUOWjjf4WLoHgakLegSAgAAbr+A=
Date:   Fri, 17 Jul 2020 10:48:10 +0000
Message-ID: <DB8PR04MB6795CCB81EDCB4A3E7663D29E67C0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
 <20200716193244.31090-3-qiangqing.zhang@nxp.com>
 <7fa10b6173147f57034b2ed95a19ca4f@kernel.org>
In-Reply-To: <7fa10b6173147f57034b2ed95a19ca4f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b8d6043-4a08-4f7c-cb5c-08d82a3ee5dd
x-ms-traffictypediagnostic: DB7PR04MB4954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB495481963A4DD190973BE5F8E67C0@DB7PR04MB4954.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PA3mhd+r5HWzeze7v8Taa1lkjrVDG6NXY7eSkrVwEP23ZCnX8g67iqEQZ7/aRaqfiUf+Gp7nNrhLwEj6stis4+mC2/CAxKR0xt2HRrRa2XnnguG3MdopUcWMn0m/BInEbJaYU9cPmOmzVyGj2HV9UxjHA5oL/ZntgqelAtt6PzVymrzqrsfzVCEXqARr0tiK9cis4fSxV+QA898efEEWo1gzjY9EMt+6AxogOw2SdPJdZBHuPKH60WEsJeFcu+MztGVBbuUgGGCBkEF2Ea0JS3x1BZUMy6lvc3yOt/VNl+nMAGFHdag3ZDc3fNWvzeDYKeCsABmwMacIcLxOOjoXUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(55016002)(71200400001)(83380400001)(7696005)(33656002)(66476007)(9686003)(66556008)(66446008)(86362001)(66946007)(64756008)(54906003)(8676002)(8936002)(76116006)(186003)(53546011)(52536014)(478600001)(2906002)(6506007)(26005)(316002)(5660300002)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vhZIin23ZWe0YjYxo4Yj6sHNWiJKmPT+gvPHbk1ZgXwYYQYNyLUo0NRNXkzG8OPYeYVDQw+V7A5V0eoESl/bcd29KGNcaN/ag6EtSwnDPJWwZ4UBf1eOOSIbC2SYLuSOFQlcZRWG1q74+/f20ffhQoUaYa64g28EsgSEo3r/MUOQ8t49Li92+50Frs6JkK2tl/oUEQrQL48YH10nO3GkUyo1YE14tiBV4Hv3tOznjZy8swRfLgjLKa65keLUcD01FX69dTBEAOO7+L79Xlob19wMh0qKNkjDkr9SiUnQVSCusdjcqbhUb1AE1b8pXYz0z0IdtMDbYASdRlDdOkenmMKHg8aGM2G1vjsg6+qe3hDYG1SRsqYdTU5sClhnGnMOpRAR8dMQ6E+y0c8DtH+xEXfEpzDj60Z0Ez5PGc623U8tMVE4VEPAunrLsZ/502HqvxwCN9ly3WXwv79WW+7iyhg70umrO6ehGqFGBGAEhhg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8d6043-4a08-4f7c-cb5c-08d82a3ee5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 10:48:10.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/d6CMBs+l+3yMBIw2lHCj80Rz+zLv3azf+oUlVmtDDFPNFWil+S8JiZrJ9P10sdBIZnIbZEmEPQWWuB8ZsjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jfUwjE3yNUgMTY6NTgNCj4gVG86IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiB0Z2x4QGxpbnV0cm9uaXguZGU7
IGphc29uQGxha2VkYWVtb24ubmV0OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi8yXSBpcnFjaGlwOiBpbXgtaW50bXV4OiBhZGQgcnVudGltZSBQTSBz
dXBwb3J0DQo+IA0KPiBPbiAyMDIwLTA3LTE2IDIwOjMyLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+
ID4gQWRkIHJ1bnRpbWUgUE0gc3VwcG9ydCBmb3IgaW50bXV4IGludGVycnVwdCBjb250cm9sbGVy
Lg0KPiANCj4gU2FtZSBhcyB0aGUgcHJldmlvdXMgcGF0Y2guIFRoZSBjaGFuZ2VzIGFyZSBzaWdu
aWZpY2FudCBlbm91Z2ggdGhhdCB5b3UgbmVlZA0KPiB0byB3cml0ZSBhIHByb3BlciBjaGFuZ2Ug
bG9nLg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5n
LnpoYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWlu
dG11eC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pbnRtdXguYw0KPiA+IGIvZHJpdmVycy9p
cnFjaGlwL2lycS1pbXgtaW50bXV4LmMNCj4gPiBpbmRleCA2MDk1Zjc2YzRmMGQuLmE2MzE4MTVj
N2JiNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pbnRtdXguYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWludG11eC5jDQo+ID4gQEAgLTUzLDYg
KzUzLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4NCj4gPiAgI2RlZmluZSBDSEFO
SUVSKG4pCSgweDEwICsgKDB4NDAgKiBuKSkNCj4gPiAgI2RlZmluZSBDSEFOSVBSKG4pCSgweDIw
ICsgKDB4NDAgKiBuKSkNCj4gPiBAQCAtNjAsNiArNjEsNyBAQA0KPiA+ICAjZGVmaW5lIENIQU5f
TUFYX05VTQkJMHg4DQo+ID4NCj4gPiAgc3RydWN0IGludG11eF9pcnFjaGlwX2RhdGEgew0KPiA+
ICsJc3RydWN0IGlycV9jaGlwCQljaGlwOw0KPiA+ICAJaW50CQkJY2hhbmlkeDsNCj4gPiAgCWlu
dAkJCWlycTsNCj4gPiAgCXN0cnVjdCBpcnFfZG9tYWluCSpkb21haW47DQo+ID4gQEAgLTEyMyw4
ICsxMjUsMTAgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBpbXhfaW50bXV4X2lycV9jaGlwID0g
ew0KPiA+IHN0YXRpYyBpbnQgaW14X2ludG11eF9pcnFfbWFwKHN0cnVjdCBpcnFfZG9tYWluICpo
LCB1bnNpZ25lZCBpbnQgaXJxLA0KPiA+ICAJCQkgICAgICBpcnFfaHdfbnVtYmVyX3QgaHdpcnEp
DQo+ID4gIHsNCj4gPiAtCWlycV9zZXRfY2hpcF9kYXRhKGlycSwgaC0+aG9zdF9kYXRhKTsNCj4g
PiAtCWlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcihpcnEsICZpbXhfaW50bXV4X2lycV9jaGlwLA0K
PiA+IGhhbmRsZV9sZXZlbF9pcnEpOw0KPiA+ICsJc3RydWN0IGludG11eF9pcnFjaGlwX2RhdGEg
KmRhdGEgPSBoLT5ob3N0X2RhdGE7DQo+ID4gKw0KPiA+ICsJaXJxX3NldF9jaGlwX2RhdGEoaXJx
LCBkYXRhKTsNCj4gPiArCWlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcihpcnEsICZkYXRhLT5jaGlw
LCBoYW5kbGVfbGV2ZWxfaXJxKTsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBA
QCAtMjQ0LDYgKzI0OCwxMCBAQCBzdGF0aWMgaW50IGlteF9pbnRtdXhfcHJvYmUoc3RydWN0DQo+
ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gIAkJCXJldHVybiAtRU5PTUVNOw0K
PiA+ICAJfQ0KPiA+DQo+ID4gKwlwbV9ydW50aW1lX2dldF9ub3Jlc3VtZSgmcGRldi0+ZGV2KTsN
Cj4gPiArCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgmcGRldi0+ZGV2KTsNCj4gPiArCXBtX3J1bnRp
bWVfZW5hYmxlKCZwZGV2LT5kZXYpOw0KPiA+ICsNCj4gPiAgCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZShkYXRhLT5pcGdfY2xrKTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIGlwZyBjbGs6ICVkXG4iLCByZXQpOyBAQA0KPiA+
IC0yNTEsNiArMjU5LDggQEAgc3RhdGljIGludCBpbXhfaW50bXV4X3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikNCj4gPiAgCX0NCj4gPg0KPiA+ICAJZm9yIChpID0gMDsg
aSA8IGNoYW5udW07IGkrKykgew0KPiA+ICsJCWRhdGEtPmlycWNoaXBfZGF0YVtpXS5jaGlwID0g
aW14X2ludG11eF9pcnFfY2hpcDsNCj4gPiArCQlkYXRhLT5pcnFjaGlwX2RhdGFbaV0uY2hpcC5w
YXJlbnRfZGV2aWNlID0gJnBkZXYtPmRldjsNCj4gDQo+IEF0IHNvbWUgcG9pbnQsIHdlIHdpbGwg
aGF2ZSB0byBmaW5kIGEgd2F5IHRvIHRocm93IHRoZSBwYXJlbnRfZGV2aWNlIHRoaW5nIG91dA0K
PiBvZiB0aGUgaXJxX2NoaXAgc3RydWN0dXJlLiBUaGlzIHRoaW5nIGlzIGEgbGlhYmlsaXR5Lg0K
PiBOb3RoaW5nIHlvdSBjYW4gZG8gYWJvdXQgaXQgZm9yIG5vdyB0aG91Z2guDQo+IA0KPiA+ICAJ
CWRhdGEtPmlycWNoaXBfZGF0YVtpXS5jaGFuaWR4ID0gaTsNCj4gPg0KPiA+ICAJCWRhdGEtPmly
cWNoaXBfZGF0YVtpXS5pcnEgPSBpcnFfb2ZfcGFyc2VfYW5kX21hcChucCwgaSk7IEBAIC0yNzks
Ng0KPiA+ICsyODksMTIgQEAgc3RhdGljIGludCBpbXhfaW50bXV4X3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikNCj4gPg0KPiA+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEo
cGRldiwgZGF0YSk7DQo+ID4NCj4gPiArCS8qDQo+ID4gKwkgKiBMZXQgcG1fcnVudGltZV9wdXQo
KSBkaXNhYmxlIGNsb2NrLg0KPiA+ICsJICogSWYgQ09ORklHX1BNIGlzIG5vdCBlbmFibGVkLCB0
aGUgY2xvY2sgd2lsbCBzdGF5IHBvd2VyZWQuDQo+ID4gKwkgKi8NCj4gPiArCXBtX3J1bnRpbWVf
cHV0KCZwZGV2LT5kZXYpOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICBvdXQ6DQo+ID4g
IAljbGtfZGlzYWJsZV91bnByZXBhcmUoZGF0YS0+aXBnX2Nsayk7DQo+ID4gQEAgLTMwMCw3ICsz
MTYsNyBAQCBzdGF0aWMgaW50IGlteF9pbnRtdXhfcmVtb3ZlKHN0cnVjdA0KPiA+IHBsYXRmb3Jt
X2RldmljZQ0KPiA+ICpwZGV2KQ0KPiA+ICAJCWlycV9kb21haW5fcmVtb3ZlKGRhdGEtPmlycWNo
aXBfZGF0YVtpXS5kb21haW4pOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZGF0YS0+aXBnX2Nsayk7DQo+ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRl
dik7DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gQEAgLTMyMiw3ICszMzgsNyBA
QCBzdGF0aWMgdm9pZCBpbXhfaW50bXV4X3Jlc3RvcmVfcmVncyhzdHJ1Y3QNCj4gPiBpbnRtdXhf
ZGF0YSAqZGF0YSkNCj4gPiAgCQl3cml0ZWxfcmVsYXhlZChkYXRhLT5zYXZlZF9yZWdbaV0sIGRh
dGEtPnJlZ3MgKyBDSEFOSUVSKGkpKTsgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50IGlteF9pbnRt
dXhfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3N0YXRpYyBpbnQgaW14X2ludG11
eF9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1
Y3QgaW50bXV4X2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPg0KPiA+IEBA
IC0zMzIsNyArMzQ4LDcgQEAgc3RhdGljIGludCBpbXhfaW50bXV4X3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50
IGlteF9pbnRtdXhfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArc3RhdGljIGludCBp
bXhfaW50bXV4X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQo+IFlvdSBq
dXN0IGludHJvZHVjZWQgdGhlc2UgdHdvIGZ1bmN0aW9ucywgYW5kIHJlbmFtZSB0aGVtIGltbWVk
aWF0ZWx5Pw0KPiANCj4gPiAgew0KPiA+ICAJc3RydWN0IGludG11eF9kYXRhICpkYXRhID0gZGV2
X2dldF9kcnZkYXRhKGRldik7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IEBAIC0zNDksNyArMzY1LDEw
IEBAIHN0YXRpYyBpbnQgaW14X2ludG11eF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+
ICNlbmRpZg0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBpbXhfaW50
bXV4X3BtX29wcyA9IHsNCj4gPiAtCVNFVF9OT0lSUV9TWVNURU1fU0xFRVBfUE1fT1BTKGlteF9p
bnRtdXhfc3VzcGVuZCwNCj4gaW14X2ludG11eF9yZXN1bWUpDQo+ID4gKwlTRVRfTk9JUlFfU1lT
VEVNX1NMRUVQX1BNX09QUyhwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQsDQo+ID4gKwkJCQkgICAg
ICBwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSkNCj4gPiArCVNFVF9SVU5USU1FX1BNX09QUyhpbXhf
aW50bXV4X3J1bnRpbWVfc3VzcGVuZCwNCj4gPiArCQkJICAgaW14X2ludG11eF9ydW50aW1lX3Jl
c3VtZSwgTlVMTCkNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBpbXhfaW50bXV4X2lkW10gPSB7DQo+IA0KPiBJIHRoaW5rIHlvdSdkIG1pZ2h0IGFz
IHdlbGwgc3F1YXNoIHRoZSB0d28gcGF0Y2hlcyB0b2dldGhlci4NCj4gU3BsaXR0aW5nIHRoZSB0
d28gc2VydmVzIGxpdHRsZSBwdXJwb3NlLg0KDQpUaGFua3MgTWFyYyBmb3IgeW91ciBraW5kbHkg
cmV2aWV3LCBJIHdpbGwgaW1wcm92ZSBhbGwgZm9sbG93aW5nIHlvdXIgY29tbWVudHMgaW4gbmV4
dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gVGhhbmtzLA0KPiAN
Cj4gICAgICAgICAgTS4NCj4gLS0NCj4gSmF6eiBpcyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMg
ZnVubnkuLi4NCg==
