Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 02:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AA420715
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 02:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OWbeGp4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgG0CpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 22:45:02 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:21791
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgG0CpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW5vwQLGJEloUel3nc5Qtez4K9wPlWWPv/mecxqCnYUBwqZR87o2ImDsViIPr71iNIU+W6eL8mDtxXbYnrH1nSzNFYi9dbtPSw35aCYZUE7qL0321m9OnlflZ86Sy1BuD/+/Sfqgo3HNTb/UzN9ZoBwoS/r+/q8pVcmHxwHBcRKOUhH448hQMomyk66OkUVsk/frgb+Jp0/Pq+vGOXAiZXQnxMS2krLTlDAajzGhjrXKMV95S36B9WunLZ9mY8ksfMLCZdAsczsnFTNkovD0YcTLxENDjcUR9p/2FQkoVhYRBci4u/iYv9dzw8+XVDLq6nhI4KjGhIX8pzb3hKM6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcDIYke0iPpuHOLt/ghaOT3m1jMm+Yh+XrnkoBQuiTc=;
 b=CctnWgMo2zsOShdVBZXYTJ2FjZBp0F0Ze9n2bGZ+55P5pRJDWpAcymHpOgdhLjqp54V0JnwkkVjIf2hgkAhlFGmhNPNu5Or3JSTbG903Dfa64hyrRa4o659jo7CtV/xF8UzIF46PqZeKFCMsrvkGdZq0uRFj3+C7UJaKYDguH4qZ0Eedi0qjP90GQQCLRfvK1rJc6k9isAfkRLY2vIGg42xVAIg40Y25dM7MJGf3OYDynuHuqEAdjDPs24xr1hDcqE2qZXdCv5ZJAnarHUAYxraPBObwf5VF+z3R8VTmJS9KXyg1jSMTPQpU/mDSzH465rBz9FRGaz4S9GP9g2oUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcDIYke0iPpuHOLt/ghaOT3m1jMm+Yh+XrnkoBQuiTc=;
 b=OWbeGp4rikG3q1fMrtY9JDqswdaRv3a5fLOdrjuPeQ4N5iFguYhnG5fcbB9GMcxh+VigMMfLXOavc7eXih7oMb+dBij1cUL00iojH2ozEo91hOCn+xtqQsMi50Qxmpjr0nxabhck4VmFxQEW9GVvZx/5OqhM8ZxavNQQ946hJHM=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5306.eurprd04.prod.outlook.com (2603:10a6:10:1f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Mon, 27 Jul
 2020 02:44:55 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5%9]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 02:44:55 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/1] irqchip: imx-intmux: implement intmux PM
Thread-Topic: [PATCH V2 1/1] irqchip: imx-intmux: implement intmux PM
Thread-Index: AQHWXj9MF0LBL96DeUir99X7ZJWKqakYTAEAgAJ011A=
Date:   Mon, 27 Jul 2020 02:44:55 +0000
Message-ID: <DB8PR04MB67950EC575602273EDF35DD2E6720@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200720104237.13119-1-qiangqing.zhang@nxp.com>
        <20200720104237.13119-2-qiangqing.zhang@nxp.com>
 <87365fycbz.wl-maz@kernel.org>
In-Reply-To: <87365fycbz.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af1586c4-0587-4240-ef34-08d831d70bca
x-ms-traffictypediagnostic: DB7PR04MB5306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB53060E7FFCC7EA3CFD66FF11E6720@DB7PR04MB5306.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1ZZkpOEInlb/EmDQM6BBYwSpIW/67CEwAeJ4DijAdIH+kfqEpGyQIOkMBs6dS1hLAP5/RD7S5ZFApgze6W2tdB42BarBIqt0pTGzmySVsEnuNNxWvC16J0RKIraejCsLaU2CMmMvZXDOsfw0NSfilulueW8IReNXpiyUT2l8R5aeejCsrmFLckGIlJ9vRL8il8k3CZRgQW+tAJLzS+t5I0Zw+8W4z2o1BHbuRtsN6yfqVHMhvDyYVWlSPxyV7k1PqIWPRjNnK/jJeeCn6imCDKih9/yVj59buH+gElJFJQZRtK5Rx1XfxPPNWWd0dHa51Z9igvXfKvKmSqSJKK15Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(54906003)(86362001)(33656002)(186003)(52536014)(9686003)(76116006)(83380400001)(6916009)(5660300002)(7696005)(26005)(8936002)(53546011)(55016002)(6506007)(4326008)(316002)(478600001)(8676002)(2906002)(66446008)(66476007)(64756008)(66556008)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IaEIQxP2fcqgpXkFCDhKpEN6dFb/eyV/N3D6B1xZGGof8cyBJ0e41QLE3FWkhgQXy8l7z3cCRu6OtQvXXWqX4wKKNO7hCtdsdCd2fsndJAIIQtJ6+wDJhzcCg/e92bNN/t2nQDwbyeL4VUuhE1ErnyRsuJ74A1JgkdBbBq+hZDyLn0Vuf1vI2D8QcMR1So74xv/R5hE3mh4urMMOtijarTI4o1ODiwAXfj98c2yk9EzmdcUS2wdh8LwzEGkN/EmkQY5lTMVHge4bHyXKDRLefv07a8AIOmx9akXR7nTDCfcCd2htp9MMWxyGxfV8pewte8fgy6QOUxJULnX9Qv3DzMszxtZEXVV0qO1Wu2FEap4FSlLf7GmbAjdFpSeZQeT+kni1/r9jgDbd7/64ZD5xIKRZkOKCu/CAcAH3ty5Kp7HFKB/ZBtruxJBWam95BA0cF0hbtT7J8H7lWcVZAZrp7S/MG963qWcG1uU/6C1gw7U=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1586c4-0587-4240-ef34-08d831d70bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 02:44:55.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGhkes2slvQqTWF/yl2aWjTHwycX0uEiF1afbjpmvXMScdbYs74u/wQc+KrmafZDhP3OgnAl3ciL+BcylJ6suA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jfUwjI1yNUgMjE6MDUNCj4gVG86IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiB0Z2x4QGxpbnV0cm9uaXguZGU7
IGphc29uQGxha2VkYWVtb24ubmV0OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAxLzFdIGlycWNoaXA6IGlteC1pbnRt
dXg6IGltcGxlbWVudCBpbnRtdXggUE0NCj4gDQo+IE9uIE1vbiwgMjAgSnVsIDIwMjAgMTE6NDI6
MzcgKzAxMDAsDQo+IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gV2hlbiBzeXN0ZW0gc3VzcGVuZGVkLCB3ZSBjb3VsZCBleHBsaWNpdGx5IGRp
c2FibGUgY2xvY2sgdG8gc2F2ZSBwb3dlci4NCj4gPiBBbmQgd2UgbmVlZCBzYXZlIHJlZ2lzdGVy
cycgc3RhdGUgc2luY2UgaXQgY291bGQgYmUgbG9zdCBhZnRlciBwb3dlcg0KPiA+IG9mZi4NCj4g
Pg0KPiA+IEltcGxlbWVudCBQTSB3aGljaCB3aWxsOg0KPiA+IDEpIFdpdGhvdXQgQ09ORklHX1BN
LCBjbG9jayBpcyBhbHdheXMgb24gYWZ0ZXIgcHJvYmUgc3RhZ2UuDQo+ID4gMikgV2l0aCBDT05G
SUdfUE0sIGNsb2NrIGlzIG9mZiBhZnRlciBwcm9iZSBzdGFnZS4NCj4gPiAzKSBEaXNhYmxlIGNs
b2NrIGFuZCBzYXZlIHJlZ2lzdGVycycgc3RhdGUgd2hlbiBkbyBzeXN0ZW0gc3VzcGVuZCBhbmQN
Cj4gPiBlbmFibGUgY2xvY2sgYW5kIHJlc3RvcmUgcmVnaXN0ZXJzJyBzdGF0ZSB3aGlsZSBzeXN0
ZW0gcmVzdW1lLg0KPiA+IDQpIE1ha2UgUG93ZXIgRG9tYWluIGZyYW1ld29yayBiZSBhYmxlIHRv
IHNodXRkb3duIHRoZSBjb3JyZXNwb25kaW5nDQo+ID4gcG93ZXIgZG9tYWluIG9mIHRoaXMgZGV2
aWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFpoYW5nIDxxaWFuZ3Fpbmcuemhh
bmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtaW50bXV4
LmMgfCA3MA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWludG11eC5jDQo+ID4gYi9kcml2ZXJz
L2lycWNoaXAvaXJxLWlteC1pbnRtdXguYw0KPiA+IGluZGV4IGMyNzU3N2M4MTEyNi4uNTk3MTYw
M2NjNjA3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWludG11eC5j
DQo+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtaW50bXV4LmMNCj4gPiBAQCAtNTMs
NiArNTMsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPg0KPiA+ICAjZGVmaW5lIENI
QU5JRVIobikJKDB4MTAgKyAoMHg0MCAqIG4pKQ0KPiA+ICAjZGVmaW5lIENIQU5JUFIobikJKDB4
MjAgKyAoMHg0MCAqIG4pKQ0KPiA+IEBAIC02MCw2ICs2MSw3IEBADQo+ID4gICNkZWZpbmUgQ0hB
Tl9NQVhfTlVNCQkweDgNCj4gPg0KPiA+ICBzdHJ1Y3QgaW50bXV4X2lycWNoaXBfZGF0YSB7DQo+
ID4gKwlzdHJ1Y3QgaXJxX2NoaXAJCWNoaXA7DQo+ID4gIAlpbnQJCQljaGFuaWR4Ow0KPiA+ICAJ
aW50CQkJaXJxOw0KPiA+ICAJc3RydWN0IGlycV9kb21haW4JKmRvbWFpbjsNCj4gPiBAQCAtNzAs
NiArNzIsNyBAQCBzdHJ1Y3QgaW50bXV4X2RhdGEgew0KPiA+ICAJdm9pZCBfX2lvbWVtCQkJKnJl
Z3M7DQo+ID4gIAlzdHJ1Y3QgY2xrCQkJKmlwZ19jbGs7DQo+ID4gIAlpbnQJCQkJY2hhbm51bTsN
Cj4gPiArCXUzMgkJCQkqc2F2ZWRfcmVnOw0KPiA+ICAJc3RydWN0IGludG11eF9pcnFjaGlwX2Rh
dGEJaXJxY2hpcF9kYXRhW107DQo+ID4gIH07DQo+ID4NCj4gPiBAQCAtMTIwLDggKzEyMywxMCBA
QCBzdGF0aWMgc3RydWN0IGlycV9jaGlwIGlteF9pbnRtdXhfaXJxX2NoaXAgPSB7DQo+ID4gc3Rh
dGljIGludCBpbXhfaW50bXV4X2lycV9tYXAoc3RydWN0IGlycV9kb21haW4gKmgsIHVuc2lnbmVk
IGludCBpcnEsDQo+ID4gIAkJCSAgICAgIGlycV9od19udW1iZXJfdCBod2lycSkNCj4gPiAgew0K
PiA+IC0JaXJxX3NldF9jaGlwX2RhdGEoaXJxLCBoLT5ob3N0X2RhdGEpOw0KPiA+IC0JaXJxX3Nl
dF9jaGlwX2FuZF9oYW5kbGVyKGlycSwgJmlteF9pbnRtdXhfaXJxX2NoaXAsIGhhbmRsZV9sZXZl
bF9pcnEpOw0KPiA+ICsJc3RydWN0IGludG11eF9pcnFjaGlwX2RhdGEgKmRhdGEgPSBoLT5ob3N0
X2RhdGE7DQo+ID4gKw0KPiA+ICsJaXJxX3NldF9jaGlwX2RhdGEoaXJxLCBkYXRhKTsNCj4gPiAr
CWlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcihpcnEsICZkYXRhLT5jaGlwLCBoYW5kbGVfbGV2ZWxf
aXJxKTsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBAQCAtMjMyLDYgKzIzNywx
OSBAQCBzdGF0aWMgaW50IGlteF9pbnRtdXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiAqcGRldikNCj4gPiAgCWRhdGEtPmNoYW5udW0gPSBjaGFubnVtOw0KPiA+ICAJcmF3X3NwaW5f
bG9ja19pbml0KCZkYXRhLT5sb2NrKTsNCj4gPg0KPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklH
X1BNKSkgew0KPiA+ICsJCS8qIHNhdmUgQ0hBTklFUiByZWdpc3RlciAqLw0KPiA+ICsJCWRhdGEt
PnNhdmVkX3JlZyA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LA0KPiA+ICsJCQkJCSAgICAgICBz
aXplb2YodW5zaWduZWQgaW50KSAqIGNoYW5udW0sDQo+IA0KPiBUaGlzIGlzbid0IGNvbnNpc3Rl
bnQgd2l0aCB0aGUgdHlwZSBvZiBkYXRhLT5zYXZlZF9yZWcuIENvbnNpZGVyIHVzaW5nDQo+IHNp
emVvZigqZGF0YS0+c2F2ZWRfcmVnKSwgd2hpY2ggaXMgZ3VhcmFudGVlZCB0byBiZSB0aGUgcmln
aHQgdHlwZS4NCg0KU29ycnkgZm9yIG15IG1pc3Rha2UsIEkgZm9yZ290IHRvIG1vZGlmeSB0aGlz
IHVuaXQuDQoNCj4gSXQgYWxzbyBiZWdzIHRoZSBxdWVzdGlvbjogc2luY2UgdGhpcyBzYXZlZF9y
ZWcgYXJyYXkgaXMgYWxsb2NhdGVkIG9uIGEgcGVyDQo+IGNoYW5uZWwgYmFzaXMsIHdoeSBkb24n
dCB5b3UgaGF2ZSBhIHBlci1jaGFubmVsIGFkZGl0aW9uYWwgdTMyIGluIHRoZQ0KPiBpbnRtdXhf
aXJxY2hpcF9kYXRhIHN0cnVjdHVyZSBpbnN0ZWFkPyBUaGlzIHdvdWxkIHNpZGVzdGVwIHRoaXMg
ZXh0cmENCj4gYWxsb2NhdGlvbiBhbHRvZ2V0aGVyLg0KDQpZZXMsIHRoaXMgbWFrZSBzZW5zZS4g
VGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gVGhhbmtzLA0KPiANCj4g
CU0uDQo+IA0KPiAtLQ0KPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVz
cyBpcyBub3QgcG9zc2libGUuDQo=
