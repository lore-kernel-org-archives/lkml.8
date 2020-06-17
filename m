Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401CFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A6C21475
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P/U43JXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQIAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:00:39 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:44353
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgFQIAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:00:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM9M1e7TS0xgZ2rweoxVZ/wcJcptPk7wRyBGseKbQlLWH4KuepdqKDLSY1glfEsMktf0f4JBMXakTcOw197n3stvf6G/noYQ0c1GkK7EMIhautnSfZQBbcqJZuw2Zob3YnqBwQ+AZJyy3p/VE4qwW33rqvQhj/bh0R5ivbIGm6aTewMhSNfT82irpGifpWgiQzaVKEzJYnLvU701jCSqwzfsF532Bcnnb5NZVoUdJjkKuKZdKqEMkheIqBcUWKrZWcbTkvipfw0YdEz1G6NEJ06tZW3kpHD8huOgRXbaysWqvV5RcfN1Sj2LA+ANLRohhF6R50KIMQcDqz98daxrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQcOuL8qsaE7bT+7mjSkUEGgWbiIqyU1hEOyR45OKUY=;
 b=dmZ3A8kUNjpzMwz9t4eL2GycLck011CkSJBLJ4WQYJCbaLT8HdqhP+tWNqtZE2NN/mSFisvpmYnCntJwAr+4OYdNG2g8so9Ha0xPd/O1q9JcvKdIR0yI6FW5OwRmV8Bcuj3NMu9ObW4zKYyLmwIP+gzHpPv+leGv29QRBDNUXby95aEbn2557dIq5kYXUzm5/L062HtwXRAjhVCcggjIJir6vFdDQxcngJdSBAjyo51XYHGupGFORCQv0Mve9sKfFLwoIyWF2VIp72ZdILvH35aSSfl6lsWpXPNf5qZ8U3kn1HpRJEkSR/MacRgwumxx7KGMapBIHTMjpXWCRMEKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQcOuL8qsaE7bT+7mjSkUEGgWbiIqyU1hEOyR45OKUY=;
 b=P/U43JXOzyoRpWllmOOwV8J4CSAN/Jdu3Y85D+t5FF0y055ss693oyXonPE3gFOPS5IKZxoPYLKN6Yr2Q1ugbgDfH4JGME+j4rM+dowpB0VjTFqA1d8lAKOT9llzwJ1OcpiP/iGL3NeL5RbeO7hhx0loq40qwv1nyametz3I54w=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10) by AM6PR0402MB3445.eurprd04.prod.outlook.com
 (2603:10a6:209:7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 17 Jun
 2020 08:00:33 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f%4]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 08:00:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, "arnd@arndb.de" <arnd@arndb.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Support module build
Thread-Topic: [PATCH] soc: imx-scu: Support module build
Thread-Index: AQHWRGTWiz8NXUZ+xUGFBcoJjUMmmqjccS8AgAAAf6A=
Date:   Wed, 17 Jun 2020 08:00:33 +0000
Message-ID: <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b403f5c-f594-4454-f6bf-08d812948335
x-ms-traffictypediagnostic: AM6PR0402MB3445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3445474BC15B23F87E77C155F59A0@AM6PR0402MB3445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31z1a1EPb6pd8LY0MvxWWW7qJfPfMgY5hKD/LQdNIIM7XmpH9H3VxCPm/Qr8YutmMjSxmu6D9FCqQTvjieSb7LxLJpL9L+CGvSrh8ExOuXqKYkC6tz77LkqvjFrdbxOqJMOCShrfPy1u3NV8KHSlu25xmQuEThCabakyfokz/lsPoXYfK8/j4Nk0lGh5z7i+UtKWr7evdvxslbhfQrw+P6X0mUKRrHbtuj9sAh/a5yZJbi3o9a0ZsSH2gOY9e5JZ8peNKxBPeMon/8K0m6/GkO4aLb07ZSPJCm4g/txprQYWybhwnyu7JkUm8bXgxWraLXiwyLvM+TsFSXDesfdaaRdjnTaG7RHDfabWCuWQ4QrRgHaTLoubZi1pPrHjG6b3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(71200400001)(8676002)(83380400001)(478600001)(5660300002)(110136005)(8936002)(52536014)(33656002)(4326008)(6506007)(316002)(2906002)(66476007)(26005)(66946007)(66556008)(76116006)(66446008)(64756008)(7696005)(86362001)(44832011)(55016002)(186003)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Krr62mC3yiToXl9u4CRQTOT+qQXMHelP7bG/m+QCpkEzO+6RIQLWvYoPPsJCdjAaWXAva4ldCKimS9oMMQMqIWL7NT8SQKqirB65dKVd2DhC7TY9kYlEdioZpuBtIASR5oX+rRFFcUO6awM/T6RQXeyMXXoF1AaaTiM4fJdhqg3y7IbHFAn69g0HRjiz85y5HKuMHTsKHOmO/JoQzDDLJ2upkUwU+DEsyMwmOmSbxoTKRU4/1cjxt+WwUOYJp0JK5Js7EDvxN3dZX3Gt9nI06DCBtJSM7oyibxXX/0qDlHbBvNe2P7QAzFAnmN+YL6THvwXKG3R1ghJUy16mtU2m8HwsK0O4U3eeCLYv8y5d89WU6YYZmo8kqq5kgxoHLs+NC2cOBWzozqilBUKeLmvSsWqt7zDVGMmM+gH94QK+kRdJR9+Gh4VXERo9n33PhXnHeOTdIDJ1k6Go5zZrSPCbgchwIE8cKcTb5c9yvvpak0A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b403f5c-f594-4454-f6bf-08d812948335
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 08:00:33.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhOXXckcFUCvy4hQVIbyIimEqDIM5UHTIxMFwfjWG9dGaHISJAWxCUJgeF7ya4wVLPg1ow+wzLoR4vFwyxTmEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHNvYzogaW14LXNjdTogU3VwcG9ydCBtb2R1bGUgYnVp
bGQNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4g
U2VudDogV2VkbmVzZGF5LCBKdW5lIDE3LCAyMDIwIDEyOjU0IFBNDQo+ID4NCj4gPiBDaGFuZ2Ug
dGhlIGNvbmZpZ3VyYXRpb24gdHlwZSB0byB0cmlzdGF0ZSwgYWRkIG1vZHVsZSBkZXNjcmlwdGlv
biwNCj4gPiBhdXRob3IgYW5kIGxpY2Vuc2UgdG8gc3VwcG9ydCBtb2R1bGUgYnVpbGQuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvaW14L0tjb25maWcgICAgICAgfCAyICstDQo+ID4gIGRy
aXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jIHwgNSArKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc29jL2lteC9LY29uZmlnIGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcgaW5kZXgN
Cj4gPiBkNTE1ZDJjLi5jMjU1YWNiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9L
Y29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcNCj4gPiBAQCAtOSw3ICs5
LDcgQEAgY29uZmlnIElNWF9HUENWMl9QTV9ET01BSU5TDQo+ID4gIAlkZWZhdWx0IHkgaWYgU09D
X0lNWDdEDQo+ID4NCj4gPiAgY29uZmlnIElNWF9TQ1VfU09DDQo+ID4gLQlib29sICJpLk1YIFN5
c3RlbSBDb250cm9sbGVyIFVuaXQgU29DIGluZm8gc3VwcG9ydCINCj4gPiArCXRyaXN0YXRlICJp
Lk1YIFN5c3RlbSBDb250cm9sbGVyIFVuaXQgU29DIGluZm8gc3VwcG9ydCINCj4gPiAgCWRlcGVu
ZHMgb24gSU1YX1NDVQ0KPiA+ICAJc2VsZWN0IFNPQ19CVVMNCj4gPiAgCWhlbHANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiBiL2RyaXZlcnMvc29j
L2lteC9zb2MtaW14LXNjdS5jIGluZGV4IDIwZDM3ZWEuLmJkZDQzZWQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9p
bXgvc29jLWlteC1zY3UuYw0KPiA+IEBAIC01LDYgKzUsNyBAQA0KPiA+DQo+ID4gICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPiAgI2luY2x1ZGUNCj4gPiA8bGludXgv
ZmlybXdhcmUvaW14L3NjaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zeXNfc29jLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiBAQCAtMTg1LDMg
KzE4Niw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGlteF9zY3Vfc29jX2luaXQodm9pZCkNCj4gPiAg
CXJldHVybiBQVFJfRVJSX09SX1pFUk8ocGRldik7DQo+ID4gIH0NCj4gPiAgZGV2aWNlX2luaXRj
YWxsKGlteF9zY3Vfc29jX2luaXQpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0FVVEhPUigiQW5zb24g
SHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+Iik7DQo+ID4gK01PRFVMRV9ERVNDUklQVElPTigi
TlhQIGkuTVggU0NVIFNvQyBkcml2ZXIiKTsNCj4gTU9EVUxFX0xJQ0VOU0UoIkdQTA0KPiA+ICt2
MiIpOw0KPiANCj4gSSdtIG9rIHdpdGggdGhlIGNoYW5nZS4gQnV0IEknbSBjdXJpb3VzIGhvdyBj
YW4gdGhpcyBtb2R1bGUgYmUgYXV0b2xvYWRlZA0KPiB3aXRob3V0IE1PRFVMRV9ERVZJQ0VfVEFC
TEUuDQo+IEhhdmUgeW91IHRlc3RlZCBpZiBpdCBjYW4gd29yaz8NCj4gDQoNCkkgT05MWSB0ZXN0
ZWQgdGhlIG1hbnVhbCBpbnNtb2QsIGlmIHdhbnQgdG8gc3VwcG9ydCBhdXRvIGxvYWQsIG1heSBu
ZWVkIHNvbWUgbW9yZQ0KY2hhbmdlLCB3aWxsIHRyeSBpdCBsYXRlciBhbmQgc2VuZCBvdXQgYSBW
MiBpZiBuZWVkZWQuDQoNCkFuc29uDQoNCg==
