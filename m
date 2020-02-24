Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9249FC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E672072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xtf4SjEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBXNdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:33:13 -0500
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:8633
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgBXNdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:33:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BynWcjsSomhShlGPmU+tWcXHIi4NqZUGXQcEA25s02ZgfbAhImuQEUINMW7RW5pu+fL8cjnuTFOJhUvOODmlug648NmEfn3QViTiBQeQUME7VQB+yQykyVHKHaQ2ORDOyQET9vNlD0S1L7KhbvgnrccOeF7y3eDac+tpMOlHpIVvXvan1mqKYflwpzOE4QyfkNNLje9lWU415umutApjhQUTxSAUCQEhkpXo5qXpgvvyyxbwQwEFw5F8qA9YRKguH+cyyclJ1nEOG0pceymQj+tPAcEp+lxKPsl48LoleMlxLDbdRxq4ZI92vVCWZfZHZj3TUMUClHq67srjRhRvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf1e1fDu0nnFBJ43yE/zmdOe+j46m54QAtVsv4iELF0=;
 b=f6C8PoUAUqvvKc6UUFBRWJKFCHUxWMk+zUI6RQpZEKlu2+abtVFCXRf5EZKEsLKeeGPLVGumRR9aBlXwJIetPGT3xAkMaN6NBNN7TnJeugc4FNlgll/0CQjzddNVmEZBAIkh50dbSkvyZ6dMPh8n7wmQbAuw0oTm8NphqGLbDXBKYP0XvildAoSNjPrkOE0TF4qlMUb2bgs/+VEzt6AkUaz5MF/+ZzP8Fy/D3n8NSs0qQVlZlqVCP095A9TPdMCKUDmR8wLy/13fkL/Si698BVnN0ddfsFhgH9omglxU49imyWcA2gTUsyT6JH1RFeNlsJq1jI2fWxZa37eCaV9o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf1e1fDu0nnFBJ43yE/zmdOe+j46m54QAtVsv4iELF0=;
 b=Xtf4SjEOMs2ekLmgOLqJFMHEdtiWOQaAhi1lEk0OTS+Lrg6ACevjXs7SD+sx9NuOTOHwRA7I0he6PZtscArADLYQIuX3gJvKa13fYBx2qCQDNDujf1ElKhu6mK0u6F+dxx5lbjQu7honM1ABnnHMt8Sor5WUJNhv4KD+MeXzoZo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5649.eurprd04.prod.outlook.com (20.178.118.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 13:33:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 13:33:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/3] dt-bindings: mailbox: imx-mu: add fsl,scu property
Thread-Topic: [PATCH 1/3] dt-bindings: mailbox: imx-mu: add fsl,scu property
Thread-Index: AQHV6wzeG6eIrs0DOUmKutB9M5XB8agqUGiAgAACRTA=
Date:   Mon, 24 Feb 2020 13:33:07 +0000
Message-ID: <AM0PR04MB4481FF0A89B56963AF525B7A88EC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
 <1582546474-21721-2-git-send-email-peng.fan@nxp.com>
 <ad6b8ee4-f5c5-dc44-b06e-d265101ce5ad@pengutronix.de>
In-Reply-To: <ad6b8ee4-f5c5-dc44-b06e-d265101ce5ad@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [222.93.164.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e853f4ce-82bc-47bf-affe-08d7b92e1552
x-ms-traffictypediagnostic: AM0PR04MB5649:|AM0PR04MB5649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB56491072ACF84CB18103E8B088EC0@AM0PR04MB5649.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(52536014)(76116006)(64756008)(66446008)(2906002)(66946007)(33656002)(71200400001)(66476007)(66556008)(966005)(81166006)(81156014)(8936002)(478600001)(45080400002)(86362001)(7696005)(44832011)(54906003)(186003)(26005)(55016002)(8676002)(9686003)(6636002)(316002)(15650500001)(110136005)(53546011)(7416002)(4326008)(6506007)(5660300002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5649;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebg8HB91PLxKfS7T2rPb/iDRnBru8vMEuBaIOHDxWOYodV5ZureWvBaJNx0Kj0lQll5Iw/7sQl28ZggyJY5xPRyeb+8gaCutgA+KkJBAejsLlPpcJz0QduT+5sBI8RrS0IXqao/dPGj28sn7B60eNK9Mhv5aozfEBc26p7s5PbNugd+X5KCjaFgiTRAR02rVaNEMwlIgFwQrIa8dlGJqto2DTeDYhcR4WDMCZ/rRpOUg+d4aBjKpax3oXEKLcqFhrYOiD6ZIm1TJ+oCE/SzeFBgzgSNXk76xeI6wc8ZjKzx++81Ep4yOQKBmrRdjp+SDjSUEt9k9ATtCb+iJjbKrTwvWtCRmP6TERM110kFsAHxsW+JBmEq1mL1cF4iMbr35RxKSbRW32I5MokuxSzi/feOzfbxrmP4EAhAw7LvuSFrN/CVh/BSKICpz3OeRKkJMGEN2CuTZdKwt/PZu7+Fm9X2qS46PPTjG1VKMySF832NFC2YRxw4ndSbF8ffTH6UuUNKtijznwp2ZDkVMuhRdwPf8rkt/1ckzjuaS8pD/pcZk750oS3sVDlRd4VG7aGNN
x-ms-exchange-antispam-messagedata: NQvm80AiOTHemnjMjSule5cswiYef3kSx4JCIxrncoY9AtI6Kuzcmy2B4yT7Lb9DqGBPiL1u+myWE7/Nd7LWCUw+UFEuIOOPXE3lMp3SNYokHHiEwYpSfeQj8zDXtLJy/LCLkFbTBw00aJNGLDTuOQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e853f4ce-82bc-47bf-affe-08d7b92e1552
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 13:33:07.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+n/XJcUB2+2GUqOb2+X0cZ10DIDZjTf0xHSzyHjcFbIvfbZ06/dFvzatgABJURrfQPw+tNZ+817KKtD6cs1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IG1h
aWxib3g6IGlteC1tdTogYWRkIGZzbCxzY3UgcHJvcGVydHkNCj4gDQo+IEhpIFBlbmcsDQo+IA0K
PiBPbiAyNC4wMi4yMCAxMzoxNCwgcGVuZy5mYW5AbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBmc2wsc2N1IHByb3BlcnR5
LCB0aGlzIG5lZWRzIHRvIGJlIGVuYWJsZWQgZm9yIFNDVSBjaGFubmVsIHR5cGUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2ZzbCxtdS50eHQg
fCAxICsNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2ZzbCxt
dS50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9mc2ws
bXUudHh0DQo+ID4gaW5kZXggOWM0MzM1N2M1OTI0Li41YjUwMmJjZjcxMjIgMTAwNjQ0DQo+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvZnNsLG11LnR4
dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2Zz
bCxtdS50eHQNCj4gPiBAQCAtNDUsNiArNDUsNyBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+
ICAgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgLSBjbG9ja3MgOglwaGFuZGxlIHRvIHRoZSBp
bnB1dCBjbG9jay4NCj4gPiAgIC0gZnNsLG11LXNpZGUtYiA6IFNob3VsZCBiZSBzZXQgZm9yIHNp
ZGUgQiBNVS4NCj4gPiArLSBmc2wsc2N1OiBTdXBwb3J0IGkuTVg4LzhYIFNDVSBjaGFubmVsIHR5
cGUNCg0KRnJvbSBSTSwgb25lIG9mIHRoZSBNVSB1c2luZyBleGFtcGxlLg0KMTIuOS4yLjMuMiBN
ZXNzYWdpbmcgRXhhbXBsZXMNClRoZSBmb2xsb3dpbmcgYXJlIG1lc3NhZ2luZyBleGFtcGxlczoN
CuKAoiBQYXNzaW5nIHNob3J0IG1lc3NhZ2VzOiBUcmFuc21pdCByZWdpc3RlcihzKSBjYW4gYmUg
dXNlZCB0byBwYXNzIHNob3J0IG1lc3NhZ2VzDQpmcm9tIG9uZSB0byBmb3VyIHdvcmRzIGluIGxl
bmd0aC4gRm9yIGV4YW1wbGUsIHdoZW4gYSBmb3VyLXdvcmQgbWVzc2FnZSBpcyBkZXNpcmVkLA0K
b25seSBvbmUgb2YgdGhlIHJlZ2lzdGVycyBuZWVkcyB0byBoYXZlIGl0cyBjb3JyZXNwb25kaW5n
IGludGVycnVwdCBlbmFibGUgYml0IHNldCBhdCB0aGUNCnJlY2VpdmVyIHNpZGU7IHRoZSBtZXNz
YWdl4oCZcyBmaXJzdCB0aHJlZSB3b3JkcyBhcmUgd3JpdHRlbiB0byB0aGUgcmVnaXN0ZXJzIHdo
b3NlDQppbnRlcnJ1cHQgaXMgbWFza2VkLCBhbmQgdGhlIGZvdXJ0aCB3b3JkIGlzIHdyaXR0ZW4g
dG8gdGhlIG90aGVyIHJlZ2lzdGVyICh3aGljaA0KdHJpZ2dlcnMgYW4gaW50ZXJydXB0IGF0IHRo
ZSByZWNlaXZlciBzaWRlKS4NCg0KU28gd2UgY291bGQgZGVmaW5lIGZsZXhpYmxlIGNoYW5uZWws
IGJ1dCBub3QgcmVzdHJpY3RlZCBvbmx5IG9uZSBUUjAgb3IgUlIwIHJlZ2lzdGVyLg0KDQpBbmQg
U0NGVyBTQ1Ugc2lkZSBJUEMgaXMgdXNpbmcgIlBhc3Npbmcgc2hvcnQgbWVzc2FnZXMiIG1ldGhv
ZC4NCg0KPiANCj4gSG0uLiB3aGF0IHlvdSBhcmUgZG9pbmcgaXMgYSAibGluayBhZ2dyZWdhdGlv
biIgd2l0aCByb3VuZC1yb2JpbiBzY2hlZHVsaW5nOg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZlbi53aWsNCj4gaXBl
ZGlhLm9yZyUyRndpa2klMkZMaW5rX2FnZ3JlZ2F0aW9uJmFtcDtkYXRhPTAyJTdDMDElN0NwZW5n
LmZhbiU0DQo+IDBueHAuY29tJTdDMjNmOGE3NWUxOWE0NDg0MTU5ZDkwOGQ3YjkyYTY1MjQlN0M2
ODZlYTFkM2JjMmI0YzZmDQo+IGE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzE4MTQ2NDA0
OTA2OTgzMiZhbXA7c2RhdGE9eUd5TDMNCj4gR3dMdnprTmglMkJ0c2w4UWMlMkI1Q2dBdHBvb09v
Y3hYcFVyc0o3S2c4JTNEJmFtcDtyZXNlcnZlZD0wDQoNCkR1ZSB0byBTQ0ZXIG1lc3NhZ2UgaXMg
bm90IGZpeGVkIGxlbmd0aCwgZHJpdmVyIGhhcyB0byBwYXJzZSB0aGUgbXNnIGhlYWRlcg0KdG8g
a25vdyBob3cgbWFueSB0byB0cmFuc21pdCBhbmQgaG93IG1hbnkgdG8gcmVjZWl2ZS4NCg0KPiAN
Cj4gSSB3b3VsZCBiZSBoYXBweSBpZiB3ZSBjYW4gZGVmaW5lIGEgZ2VuZXJpYyBtYWlsYm94IHBy
b3BlcnR5IGZvciB0aGlzLg0KDQpBbnkgc3VnZ2VzdGlvbnM/IEkgYW0gdGhpbmtpbmcgbWJveF9z
ZW5kX21lc3NhZ2Vfc2l6ZSB3aXRoIGFuIGV4dHJhDQpzaXplIHBhcmFtZXRlciBmcm9tIGZpcm13
YXJlIGNsaWVudCBzaWRlLiBCdXQgbm90IGhhdmUgZ29vZCBpZGVhDQpvbiByeC4NCg0KVGhhbmtz
LA0KUGVuZy4NCg0KPiANCj4gS2luZCByZWdhcmRzLA0KPiBPbGVrc2lqIFJlbXBlbA0KPiANCj4g
LS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gfA0K
PiBJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfA0KPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
Rnd3dy5wDQo+IGVuZ3V0cm9uaXguZGUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3BlbmcuZmFuJTQw
bnhwLmNvbSU3QzIzZjhhNw0KPiA1ZTE5YTQ0ODQxNTlkOTA4ZDdiOTJhNjUyNCU3QzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JQ0KPiA3QzAlN0MwJTdDNjM3MTgxNDY0MDQ5MDc5ODI2
JmFtcDtzZGF0YT0xaEVzMmpTY1JCRUdBUyUyRnJ6RDhpNmwNCj4gUiUyRlJ5Ylh1OGhpcThoZlEz
d0RROEklM0QmYW1wO3Jlc2VydmVkPTAgIHwNCj4gUGVpbmVyIFN0ci4gNi04LCAzMTEzNyBIaWxk
ZXNoZWltLCBHZXJtYW55IHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wDQo+IHwNCj4gQW10c2dl
cmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0y
MDY5MTctNTU1NSB8DQo=
