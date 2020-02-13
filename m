Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40C8C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c7En8POG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgBMIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:41:22 -0500
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]:20036
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729459AbgBMIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:41:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyFzuYki3xmTI4VWNlDk0WWvMXwYCgdcWp8iJfo/bRwdxUibiN03Izm5EmN3epv4dCPaJe9FGi4zbIE4dtOcW+UaCGIAGE5DFtyIsZlHuT+UR9ll8TYlQu0CJWVGTE5ZMXSJjevp7IBZ+BscCQ+dApPoXjpzK5W2Q2R3UTtNuJsEe3Nwcl4Oeaosz9YP6cHvra0oelYXX1kJGVaGN1UQQPjkDFg6Eev1hBXvYOrwhHTBi1cn3EIteBU5LMw5ctD/XyN7Ae7q9FrzCvgAClmPVDirGFoy+CsVXX6Hqr34JYCLItpiz9tV8VE5GMvgRpxcEHoM6lB1piewcdFx6oyPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S1MvUIiqzlKPMj2vGBQE/JW1NpAv2wx6XaKvTqdkCg=;
 b=EGHYOzb+SqmxLOlhmjsZ2ChoQnyPqyG2utXZ0UU9ywkV55XpsVVlxXAOcBTklhdcyTLynJGhoWY7GkGUWUFZ/e5TeC25FgGGR6aKb9A8VQ+Z4R/g0EJsuNsSOjfwIUNYDcqqXfHKoZDcFfL1yMswOPzcjR7gLDmpYej2EvSw70AzBIZIzv59G/eNIgLuuidu0DUN7Fjy/vnUcBbrhaC6kQdD7cqLS3S2LvD6JvtAkE5lrrx6WwlnM41M/TRZs3v0EK0Oxl3xgUGHOdiq70ph8Tka00tZqsxok7MvBb2m1zVHJXOSGLZaD6fCRO/0vsWCbcwB7Zdx4w+hVTFXdEVXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S1MvUIiqzlKPMj2vGBQE/JW1NpAv2wx6XaKvTqdkCg=;
 b=c7En8POGR9mgYiSlva87/5i4ycwbGRSbIKS08Ajwt64tihYynCRBgzxmT0TRNP+UVVNSOEP/QgaDTQLWOVpbRUmw+0UYe96LFRJ/29Tk1BFwLs0WGVizFden0l04mOtwKdu+/2ZCelN6zkaZ/0/k3iWT+BNMIilpYPXBu35eXSA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Thu, 13 Feb 2020 08:41:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 08:41:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dsterba@suse.com" <dsterba@suse.com>, Peng Fan <peng.fan@nxp.com>,
        "okuno.kohji@jp.panasonic.com" <okuno.kohji@jp.panasonic.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] ARM: imx: Add missing of_node_put()
Thread-Topic: [PATCH V2] ARM: imx: Add missing of_node_put()
Thread-Index: AQHV4jaMGodULu2PXUCnEPn6S7cDiagYx+aAgAAGNxA=
Date:   Thu, 13 Feb 2020 08:41:17 +0000
Message-ID: <DB3PR0402MB3916D1A18B80F35B9F86563CF51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1581574854-9366-1-git-send-email-Anson.Huang@nxp.com>
 <20200213081825.mox35tzizscdk7km@pengutronix.de>
In-Reply-To: <20200213081825.mox35tzizscdk7km@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c48139a-67bb-49ec-2a26-08d7b0607e3d
x-ms-traffictypediagnostic: DB3PR0402MB3850:|DB3PR0402MB3850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB385047A3E252D7BAEE7F9217F51A0@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(478600001)(55016002)(7416002)(6506007)(81156014)(8676002)(7696005)(81166006)(8936002)(86362001)(2906002)(64756008)(316002)(9686003)(54906003)(52536014)(6916009)(76116006)(44832011)(4326008)(66556008)(5660300002)(66446008)(66476007)(71200400001)(66946007)(186003)(26005)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9T6EKZBAC5m7m/RqrBFU5Id8EPvbXW15M/+yh5pJiYYdPJkLM5vQGFNYX8IqY2REqOIML71HgjrKUovnGM7Ywggo+XAGAIND6w66YK56Rh42PcWwblEivsB+nSMjgwMvPeGcd7yELHIFEgUbGHlEEtmUZWIp1+etmPExjLhVAilYS54y2Xf8hY4BQVY5INHN4hGDIiTCV5N2gOuJBfj3M2YQVM1FgmzMwskHUyo2CnaNNTVlNsqB3hq+wQW/y/YzxBLOcG44H/VKJ/X8wBXwhCGpY4A9RAhTZPo1n/UJii6WdXxSvViVI1kizK7YvN70EOT6fQqYFhvReNLSL4d3L30RqLUyJLy95/gc9KZA3OuhiXkPGf+gpYBsGLUHIGQXxDlOEtif2gyHSMMqg7YXCoXuZ34Hj6iYzWPImYqCE/4w0ujsisRhu6pp6CqBeRHQ
x-ms-exchange-antispam-messagedata: IrchKLeE3R6WSb95TxK+C6goBqT7UnQGA0T9kzSPB9NC3yK6GUMABC2hrrZVQNu6PYi8kAUTDROqarnlAt7b33ZoiU6WFIS7DlCqWI/IRhJ33N9u3Nzb8ImVoHF7+Oc1nTZ1Zqw2P2Fup1YXvYmYfw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c48139a-67bb-49ec-2a26-08d7b0607e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 08:41:17.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygZQN8vaEfal8pKvMbPWHI2PFgNzCKpd7SBYEAiOZUBXE05InIkDv5WeddllE+p9raX1jvKDP2ct5LbBoLQzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIEFSTTogaW14OiBBZGQgbWlzc2lu
ZyBvZl9ub2RlX3B1dCgpDQo+IA0KPiBPbiBUaHUsIEZlYiAxMywgMjAyMCBhdCAwMjoyMDo1NFBN
ICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBBZnRlciBmaW5pc2hpbmcgdXNpbmcgZGV2
aWNlIG5vZGUgZ290IGZyb20gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoKSwNCj4gPiBvZl9ub2Rl
X3B1dCgpIG5lZWRzIHRvIGJlIGNhbGxlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2Ug
VjE6DQo+ID4gCS0gY29ycmVjdCBzb21lIG9mX25vZGVfcHV0KCkgcGxhY2UgdG8gbWFrZSBzdXJl
IGl0IGlzIHNhZmUgdG8gYmUgcHV0Lg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9h
bmF0b3AuYyAgICAgfCAzICsrKw0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9ncGMuYyAgICAgICAg
fCAxICsNCj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvcGxhdHNtcC5jICAgIHwgMSArDQo+ID4gIGFy
Y2gvYXJtL21hY2gtaW14L3BtLWlteDYuYyAgICB8IDIgKysNCj4gPiAgYXJjaC9hcm0vbWFjaC1p
bXgvcG0taW14N3VscC5jIHwgMSArDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvYW5hdG9wLmMgYi9h
cmNoL2FybS9tYWNoLWlteC9hbmF0b3AuYw0KPiA+IGluZGV4IDhmYjY4YzAuLjU5ODU3MzEgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1pbXgvYW5hdG9wLmMNCj4gPiArKysgYi9hcmNo
L2FybS9tYWNoLWlteC9hbmF0b3AuYw0KPiA+IEBAIC0xMzUsNiArMTM1LDcgQEAgdm9pZCBfX2lu
aXQgaW14X2luaXRfcmV2aXNpb25fZnJvbV9hbmF0b3Aodm9pZCkNCj4gPiAgCQkJdm9pZCBfX2lv
bWVtICpzcmNfYmFzZTsNCj4gPiAgCQkJdTMyIHNibXIyOw0KPiA+DQo+ID4gKwkJCW9mX25vZGVf
cHV0KG5wKTsNCj4gPiAgCQkJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxM
LA0KPiA+ICAJCQkJCQkgICAgICJmc2wsaW14NnVsLXNyYyIpOw0KPiA+ICAJCQlzcmNfYmFzZSA9
IG9mX2lvbWFwKG5wLCAwKTsNCj4gPiBAQCAtMTUyLDYgKzE1Myw4IEBAIHZvaWQgX19pbml0IGlt
eF9pbml0X3JldmlzaW9uX2Zyb21fYW5hdG9wKHZvaWQpDQo+ID4NCj4gPiAgCW14Y19zZXRfY3B1
X3R5cGUoZGlncHJvZyA+PiAxNiAmIDB4ZmYpOw0KPiA+ICAJaW14X3NldF9zb2NfcmV2aXNpb24o
cmV2aXNpb24pOw0KPiA+ICsNCj4gPiArCW9mX25vZGVfcHV0KG5wKTsNCj4gPiAgfQ0KPiANCj4g
SXQgd291bGQgYmUgYSBiaXQgbW9yZSBuYXR1cmFsIGhlcmUgSU1ITyB0byBpbnRyb2R1Y2UgYSBz
ZWNvbmQgc3RydWN0DQo+IGRldmljZV9ub2RlICogdmFyaWFibGUgZm9yIHRoZSBmc2wsaW14NnVs
LXNyYyBkZXZpY2UuIFRoZW4gZWFjaCBvZl9ub2RlX3B1dA0KPiB3b3VsZCBiZWxvbmcgdG8gZXhh
Y3RseSBvbmUgb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoKS4NCj4gKE5vdyB0aGUgb2Zfbm9kZV9w
dXQoKSBpbiBsaW5lIDE1NyBmcmVlcyB0aGUgZnNsLGlteDZ1bC1zcmMgb24gaS5NWDZVTEwgYW5k
DQo+IGZzbCxpbXg2cS1hbmF0b3Agb24gdGhlIG90aGVycy4pDQoNCk1ha2Ugc2Vuc2UsIHBsZWFz
ZSBoZWxwIHJldmlldyBWMy4NClRoYW5rcywNCkFuc29uDQo=
