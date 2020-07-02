Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962FCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CAB2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPhX41Tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGBCjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:39:03 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:49505
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgGBCjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOYA75PDqWSTGUzzuFqTmEennF3U3WZMFA8m/rurKUikT845KPTqSLE4MbdIGBj3Ky5GpciG/udK1yGPRkxJQDKxnW87DQqAyYNTmtt9myf4kh0QIwe1DF7TcL0W67RZS+3OTT5aaQztZ3JIHqeg5kKb1wZYz+Fr4J4oY7QnsPGm3MUiLPvWrC+zR5UQ3V9b7lbScCOKLqz/ZJvtmxMQ+2MxZTAMWo8rHw5V0WXMJuxEQ0xYELzddSoFvkrllkaicN2qvZHZYao4gSotmuzzw1vmdcnoemNNIw5FtjfbKKbTwRTJiLSehCCbq+1R676ebQ1cXl99IKoHSCJ7VXKvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laPxENbdii9yil37GPEwiGcqM59APpOUIK5IZzxIb1A=;
 b=YwTNxwvhJDPEV5euBLpDKWPJ+7dg6pjRuGs2YAWO+eUa/aY0EQqBFZAFXflTSyeZVVgbJfkwA1tF6ZxgfqKdNuuuYjh7zptTh8uGzBWSMziBlfY0yyc7qLwWqYO6hynxANEVIrspIkwuwLvvfSsqMbGArfxC5mueq3VokhX6pAkujMqSBQU9tedanBtwp18KkwlFW1mjuWg8pqqx3QZvOBnLZe6yVEcqeTjHxTTPbXj2KADx71qg+3FAEISVN+qt6jL6ZehmCXaYrjBdA+OP2NtRtp+ucwJk3xJE1IyK3z51bS6h2IBQshmdBuL5XQxD2Scjxv1Ob7muTnMqdyu35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laPxENbdii9yil37GPEwiGcqM59APpOUIK5IZzxIb1A=;
 b=UPhX41TuguqZGiNSkumSpl1dOW4QXoUxxfC0gz5rpNA8gea+2QTJD+HOJ8hMnHPpXrOg3IdbcynPOYq6s+CYqWz6fZPfW3egKzSrP5UhghUtkWR53w1ChQFzBPBNe3eUi6fvU4vII86FVfCRBjyOZnDsLb0i+ph3o7qyM8kTn8I=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6760.eurprd04.prod.outlook.com (2603:10a6:20b:f4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 02:38:57 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 02:38:57 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, "arnd@arndb.de" <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/5] clk: imx: Add clock configuration for ARMv7
 platforms
Thread-Topic: [PATCH V4 2/5] clk: imx: Add clock configuration for ARMv7
 platforms
Thread-Index: AQHWUBb+4PGJg51mOU2uLFc+H4z8S6jzk2YA
Date:   Thu, 2 Jul 2020 02:38:57 +0000
Message-ID: <AM6PR04MB4966881255856865E0E6BF83806D0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593656074-10092-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d30a6b99-3797-4b45-b522-08d81e311214
x-ms-traffictypediagnostic: AM6PR04MB6760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6760B5C7FF6B69ADB4F85C04806D0@AM6PR04MB6760.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /E5wN9KvdF5TZL6EcSvq7AMWfrL0QL1ZIOcWL4FwNLEInKP1LMc5BgQ2kRrgJjzUiufrOEdyTqH9lina1FUpKk6TsiFlI0xkBIH2C3g4SiQre2FOBNB3+gQ5kohht/w0DEXiDchlYigUHnAowD1HUaOwQP5q5+QRkBaz28jR10Uhy2FqtHSn41/RBlDw/gN91Xye0pt8oGSc1QDuTyNayC9QPXx7GHvp1+EhRulcphZ9H/rA6bFqhUDT8N6JOe+kP+a4SBV3nm78nFhwBh3vmmtUK1Dzs4YqtnmbTIETw6ur4xCMDJw4CXyoBRUGX0q4QW1iH9fk4T/mSyqS9DsV6CIgjd46WP/5K9xve9V0K5clsYX1H4uUE3ZqYWamtb9TnrvoYdIEB35wnwP6NFV7Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(8936002)(44832011)(186003)(26005)(8676002)(66446008)(5660300002)(52536014)(76116006)(66946007)(64756008)(66476007)(66556008)(86362001)(71200400001)(316002)(4326008)(7416002)(110136005)(55016002)(9686003)(33656002)(7696005)(83380400001)(2906002)(478600001)(6506007)(921003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ShR1cpS9UClHSxGnD6ooel/eWwCJLAw7h2Mwvx1kdUaXIYR8Wvn4eLpaIDeIT3bczF6ojL7ZIZ1LYRAAKuddGdEt3ztBVQ+/8qmKnOVs2aJTNdfM9e6goy1k9VmQGYGGKm15EPy/f7koUDcpKbgXZFiJ1HrqCe5UNaSCQJ0xsSBwI64Rz+8rZxjxlWcv1bB7Jw+aQ0JyQ3W/8Yhr5svFEeZPIZFcUJH7t4CehGG7BAA2X3aa5aiAlmanQ4BB8V/aXxCwD8//3t9tzqfsVPJQLQNsuf1m/YCnXl0J8CtZuXnG8qDPFg0c+QfKMw3AyAna7ieSkOx0pyweVqrKEb6KCLI4hAlT0cVUx0yJtkelVNlblMZYIYO0W6w5UFCVbWJBu8R5U+dXXHfF/4s4VTRPTIrRQrYKtZ6krXqYmPrV09aXZ7+iDRbNIC7LC4tb9g/Rvg+Ah7ePuY0OYBYn5Vf+H+MF6J03+misgXh3nVKtHoo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30a6b99-3797-4b45-b522-08d81e311214
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 02:38:57.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqAHkdSs/+xjcqfxSaWJOGAyNP4PTWJz1eci1sDkesShdjheTlSxBBhtPm0wRX361csgtjsdql5CJ8sQlV2wDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEp1bHkgMiwgMjAyMCAxMDoxNSBBTQ0KPiANCj4gQWRkIENPTkZJR19DTEtfeHh4IGZvciBp
Lk1YIEFSTXY3IHBsYXRmb3JtcywgYW5kIHVzZSBpdCBhcyBidWlsZCBvcHRpb24NCj4gaW5zdGVh
ZCBvZiBDT05GSUdfU09DX3h4eCwgdGhlIENPTkZJR19DTEtfeHh4IHdpbGwgYmUgc2VsZWN0ZWQg
YnkgZGVmYXVsdA0KPiBhY2NvcmRpbmcgdG8gQ09ORklHX1NPQ194eHguDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcN
Cg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSBWMzoNCj4gCS0gQWRkIGNsb2NrIGNvbmZpZ3VyYXRp
b24gZm9yIGVhY2ggQVJNdjcuDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvaW14L0tjb25maWcgIHwg
OTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICBkcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUgfCAzMCArKysrKysrKy0tLS0tLS0tDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL2lteC9LY29u
ZmlnIGluZGV4DQo+IGRiMDI1M2YuLjA5ZmM4YWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xr
L2lteC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9LY29uZmlnDQo+IEBAIC04LDYg
KzgsOTYgQEAgY29uZmlnIE1YQ19DTEtfU0NVDQo+ICAJYm9vbA0KPiAgCWRlcGVuZHMgb24gSU1Y
X1NDVQ0KPiANCj4gK2NvbmZpZyBDTEtfSU1YMQ0KPiArICAgICAgICAgYm9vbCAiSU1YMSBDQ00g
Q2xvY2sgRHJpdmVyIg0KPiArICAgICAgICAgZGVwZW5kcyBvbiBTT0NfSU1YMSB8fCBDT01QSUxF
X1RFU1QNCj4gKyAgICAgICAgIGRlZmF1bHQgU09DX0lNWDENCj4gKyAgICAgICAgIHNlbGVjdCBN
WENfQ0xLDQo+ICsNCj4gK2NvbmZpZyBDTEtfSU1YMjENCj4gKyAgICAgICAgIGJvb2wgIklNWDIx
IENDTSBDbG9jayBEcml2ZXIiDQo+ICsgICAgICAgICBkZXBlbmRzIG9uIFNPQ19JTVgyMSB8fCBD
T01QSUxFX1RFU1QNCj4gKyAgICAgICAgIGRlZmF1bHQgU09DX0lNWDIxDQo+ICsgICAgICAgICBz
ZWxlY3QgTVhDX0NMSw0KPiArDQo+ICtjb25maWcgQ0xLX0lNWDI1DQo+ICsgICAgICAgICBib29s
ICJJTVgyNSBDQ00gQ2xvY2sgRHJpdmVyIg0KPiArICAgICAgICAgZGVwZW5kcyBvbiBTT0NfSU1Y
MjUgfHwgQ09NUElMRV9URVNUDQo+ICsgICAgICAgICBkZWZhdWx0IFNPQ19JTVgyNQ0KPiArICAg
ICAgICAgc2VsZWN0IE1YQ19DTEsNCj4gKw0KPiArY29uZmlnIENMS19JTVgyNw0KPiArICAgICAg
ICAgYm9vbCAiSU1YMjcgQ0NNIENsb2NrIERyaXZlciINCj4gKyAgICAgICAgIGRlcGVuZHMgb24g
U09DX0lNWDI3IHx8IENPTVBJTEVfVEVTVA0KPiArICAgICAgICAgZGVmYXVsdCBTT0NfSU1YMjcN
Cj4gKyAgICAgICAgIHNlbGVjdCBNWENfQ0xLDQo+ICsNCj4gK2NvbmZpZyBDTEtfSU1YMzENCj4g
KyAgICAgICAgIGJvb2wgIklNWDMxIENDTSBDbG9jayBEcml2ZXIiDQo+ICsgICAgICAgICBkZXBl
bmRzIG9uIFNPQ19JTVgzMSB8fCBDT01QSUxFX1RFU1QNCj4gKyAgICAgICAgIGRlZmF1bHQgU09D
X0lNWDMxDQo+ICsgICAgICAgICBzZWxlY3QgTVhDX0NMSw0KPiArDQo+ICtjb25maWcgQ0xLX0lN
WDM1DQo+ICsgICAgICAgICBib29sICJJTVgzNSBDQ00gQ2xvY2sgRHJpdmVyIg0KPiArICAgICAg
ICAgZGVwZW5kcyBvbiBTT0NfSU1YMzUgfHwgQ09NUElMRV9URVNUDQo+ICsgICAgICAgICBkZWZh
dWx0IFNPQ19JTVgzNQ0KPiArICAgICAgICAgc2VsZWN0IE1YQ19DTEsNCj4gKw0KPiArY29uZmln
IENMS19JTVg1DQo+ICsgICAgICAgICBib29sICJJTVg1IENDTSBDbG9jayBEcml2ZXIiDQo+ICsg
ICAgICAgICBkZXBlbmRzIG9uIFNPQ19JTVg1IHx8IENPTVBJTEVfVEVTVA0KPiArICAgICAgICAg
ZGVmYXVsdCBTT0NfSU1YNQ0KPiArICAgICAgICAgc2VsZWN0IE1YQ19DTEsNCj4gKw0KPiArY29u
ZmlnIENMS19JTVg2UQ0KPiArICAgICAgICAgYm9vbCAiSU1YNlEgQ0NNIENsb2NrIERyaXZlciIN
Cj4gKyAgICAgICAgIGRlcGVuZHMgb24gU09DX0lNWDZRIHx8IENPTVBJTEVfVEVTVA0KPiArICAg
ICAgICAgZGVmYXVsdCBTT0NfSU1YNlENCj4gKyAgICAgICAgIHNlbGVjdCBNWENfQ0xLDQo+ICsN
Cj4gK2NvbmZpZyBDTEtfSU1YNlNMDQo+ICsgICAgICAgICBib29sICJJTVg2U0wgQ0NNIENsb2Nr
IERyaXZlciINCj4gKyAgICAgICAgIGRlcGVuZHMgb24gU09DX0lNWDZTTCB8fCBDT01QSUxFX1RF
U1QNCj4gKyAgICAgICAgIGRlZmF1bHQgU09DX0lNWDZTTA0KPiArICAgICAgICAgc2VsZWN0IE1Y
Q19DTEsNCj4gKw0KPiArY29uZmlnIENMS19JTVg2U0xMDQo+ICsgICAgICAgICBib29sICJJTVg2
U0xMIENDTSBDbG9jayBEcml2ZXIiDQo+ICsgICAgICAgICBkZXBlbmRzIG9uIFNPQ19JTVg2U0xM
IHx8IENPTVBJTEVfVEVTVA0KPiArICAgICAgICAgZGVmYXVsdCBTT0NfSU1YNlNMTA0KPiArICAg
ICAgICAgc2VsZWN0IE1YQ19DTEsNCj4gKw0KPiArY29uZmlnIENMS19JTVg2U1gNCj4gKyAgICAg
ICAgIGJvb2wgIklNWDZTWCBDQ00gQ2xvY2sgRHJpdmVyIg0KPiArICAgICAgICAgZGVwZW5kcyBv
biBTT0NfSU1YNlNYIHx8IENPTVBJTEVfVEVTVA0KPiArICAgICAgICAgZGVmYXVsdCBTT0NfSU1Y
NlNYDQo+ICsgICAgICAgICBzZWxlY3QgTVhDX0NMSw0KPiArDQo+ICtjb25maWcgQ0xLX0lNWDZV
TA0KPiArICAgICAgICAgYm9vbCAiSU1YNlVMIENDTSBDbG9jayBEcml2ZXIiDQo+ICsgICAgICAg
ICBkZXBlbmRzIG9uIFNPQ19JTVg2VUwgfHwgQ09NUElMRV9URVNUDQo+ICsgICAgICAgICBkZWZh
dWx0IFNPQ19JTVg2VUwNCj4gKyAgICAgICAgIHNlbGVjdCBNWENfQ0xLDQo+ICsNCj4gK2NvbmZp
ZyBDTEtfSU1YN0QNCj4gKyAgICAgICAgIGJvb2wgIklNWDdEIENDTSBDbG9jayBEcml2ZXIiDQo+
ICsgICAgICAgICBkZXBlbmRzIG9uIFNPQ19JTVg3RCB8fCBDT01QSUxFX1RFU1QNCj4gKyAgICAg
ICAgIGRlZmF1bHQgU09DX0lNWDdEDQo+ICsgICAgICAgICBzZWxlY3QgTVhDX0NMSw0KPiArDQo+
ICtjb25maWcgQ0xLX0lNWDdVTFANCj4gKyAgICAgICAgIGJvb2wgIklNWDdVTFAgQ2xvY2sgRHJp
dmVyIg0KPiArICAgICAgICAgZGVwZW5kcyBvbiBTT0NfSU1YN1VMUCB8fCBDT01QSUxFX1RFU1QN
Cj4gKyAgICAgICAgIGRlZmF1bHQgU09DX0lNWDdVTFANCj4gKyAgICAgICAgIHNlbGVjdCBNWENf
Q0xLDQo+ICsNCj4gK2NvbmZpZyBDTEtfVkY2MTANCj4gKyAgICAgICAgIGJvb2wgIlZGNjEwIENs
b2NrIERyaXZlciINCj4gKyAgICAgICAgIGRlcGVuZHMgb24gU09DX1ZGNjEwIHx8IENPTVBJTEVf
VEVTVA0KPiArICAgICAgICAgZGVmYXVsdCBTT0NfVkY2MTANCj4gKyAgICAgICAgIHNlbGVjdCBN
WENfQ0xLDQo+ICsNCj4gIGNvbmZpZyBDTEtfSU1YOE1NDQo+ICAJYm9vbCAiSU1YOE1NIENDTSBD
bG9jayBEcml2ZXIiDQo+ICAJZGVwZW5kcyBvbiBBUkNIX01YQw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbGsvaW14L01ha2VmaWxlIGIvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlIGluZGV4DQo+
IDkyOGY4NzQuLjM5NGFkZTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9NYWtlZmls
ZQ0KPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUNCj4gQEAgLTMxLDE4ICszMSwxOCBA
QCBvYmotJChDT05GSUdfQ0xLX0lNWDhNUCkgKz0gY2xrLWlteDhtcC5vDQo+ICBvYmotJChDT05G
SUdfQ0xLX0lNWDhNUSkgKz0gY2xrLWlteDhtcS5vDQo+ICBvYmotJChDT05GSUdfQ0xLX0lNWDhR
WFApICs9IGNsay1pbXg4cXhwLm8gY2xrLWlteDhxeHAtbHBjZy5vDQo+IA0KPiAtb2JqLSQoQ09O
RklHX1NPQ19JTVgxKSAgICs9IGNsay1pbXgxLm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1YMjEp
ICArPSBjbGstaW14MjEubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19JTVgyNSkgICs9IGNsay1pbXgy
NS5vDQo+IC1vYmotJChDT05GSUdfU09DX0lNWDI3KSAgKz0gY2xrLWlteDI3Lm8NCj4gLW9iai0k
KENPTkZJR19TT0NfSU1YMzEpICArPSBjbGstaW14MzEubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19J
TVgzNSkgICs9IGNsay1pbXgzNS5vDQo+IC1vYmotJChDT05GSUdfU09DX0lNWDUpICAgKz0gY2xr
LWlteDUubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19JTVg2USkgICs9IGNsay1pbXg2cS5vDQo+IC1v
YmotJChDT05GSUdfU09DX0lNWDZTTCkgKz0gY2xrLWlteDZzbC5vDQo+IC1vYmotJChDT05GSUdf
U09DX0lNWDZTTEwpICs9IGNsay1pbXg2c2xsLm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1YNlNY
KSArPSBjbGstaW14NnN4Lm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1YNlVMKSArPSBjbGstaW14
NnVsLm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1YN0QpICArPSBjbGstaW14N2Qubw0KPiAtb2Jq
LSQoQ09ORklHX1NPQ19JTVg3VUxQKSArPSBjbGstaW14N3VscC5vDQo+IC1vYmotJChDT05GSUdf
U09DX1ZGNjEwKSAgKz0gY2xrLXZmNjEwLm8NCj4gK29iai0kKENPTkZJR19DTEtfSU1YMSkgICAr
PSBjbGstaW14MS5vDQo+ICtvYmotJChDT05GSUdfQ0xLX0lNWDIxKSAgKz0gY2xrLWlteDIxLm8N
Cj4gK29iai0kKENPTkZJR19DTEtfSU1YMjUpICArPSBjbGstaW14MjUubw0KPiArb2JqLSQoQ09O
RklHX0NMS19JTVgyNykgICs9IGNsay1pbXgyNy5vDQo+ICtvYmotJChDT05GSUdfQ0xLX0lNWDMx
KSAgKz0gY2xrLWlteDMxLm8NCj4gK29iai0kKENPTkZJR19DTEtfSU1YMzUpICArPSBjbGstaW14
MzUubw0KPiArb2JqLSQoQ09ORklHX0NMS19JTVg1KSAgICs9IGNsay1pbXg1Lm8NCj4gK29iai0k
KENPTkZJR19DTEtfSU1YNlEpICArPSBjbGstaW14NnEubw0KPiArb2JqLSQoQ09ORklHX0NMS19J
TVg2U0wpICs9IGNsay1pbXg2c2wubw0KPiArb2JqLSQoQ09ORklHX0NMS19JTVg2U0xMKSArPSBj
bGstaW14NnNsbC5vDQo+ICtvYmotJChDT05GSUdfQ0xLX0lNWDZTWCkgKz0gY2xrLWlteDZzeC5v
DQo+ICtvYmotJChDT05GSUdfQ0xLX0lNWDZVTCkgKz0gY2xrLWlteDZ1bC5vDQo+ICtvYmotJChD
T05GSUdfQ0xLX0lNWDdEKSAgKz0gY2xrLWlteDdkLm8NCj4gK29iai0kKENPTkZJR19DTEtfSU1Y
N1VMUCkgKz0gY2xrLWlteDd1bHAubw0KPiArb2JqLSQoQ09ORklHX0NMS19WRjYxMCkgICs9IGNs
ay12ZjYxMC5vDQo+IC0tDQo+IDIuNy40DQoNCg==
