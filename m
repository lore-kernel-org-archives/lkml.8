Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CDC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B4F20848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LABl4CG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCIN6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:58:04 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:26753
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbgCIN6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:58:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhWY2kJRov9F5aMVXug330/T3nBUr2eJUPiiBF3OTtGWM9caGkkRHDje2n3s+UixGPkow64a7HPDDfnX+nr6tk6OuorWOiFBrK0bOOQ0um2+NjkhiBwoAJtoOEQNs9VbJnSd8ILM442dMpHu3W83ZERqLtGhbzneNSVx34XRy4oezwE4NVrYg9C8/icfrJwdX5fBazXZXmB28ZwSJY4AdYgExgYoyXzsMlWvsEjTmx0HAm6fgdQMaKaifEwBYP7F2pyVI9y8vxdqbG/7po/W1VhxK+99ySIPDEk1Xi5aOTR61y0cTbEW3WUcaeTz7BD6zAroPujtRspFLMjpV0sc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrb6HXTHKci+6sukaZ+Mg+Ks50kFdpF/pMUe0OAWTV4=;
 b=k0rGdb1VFpo8rGqlWJlKkKRLCg7ly0cEAyHZtu/u2994HMNbIlkoosZPaHkddbaWElaMI1KfaP/C2daPwHJCP2mJahXU/XgOfz5kK+zPwqCOs3JU9ZIK0zEBJlpOLKbnwFJhqvmVrJvm0IYboSl4Z0GniKnxGDuwagjPb4f9C5R7SxfhNl1txuRrbOqhPy8v4CMn2VT6fPnL04o0vm5arYx0XP0b7hTEhzWdWFFY3mxUK8sXf/ZHz+q+d0ZAPlTjAJ5onKMZ3ltNbl03q+7OTqKnm6F1vUbxON0DbHZfOSewhzq5SvINDdGjc1VBVdkTupgmsm9Ous38UfCuiZr+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrb6HXTHKci+6sukaZ+Mg+Ks50kFdpF/pMUe0OAWTV4=;
 b=LABl4CG8NL7szkxq2gVCA4FPCP8UaAZ3YTHpD8cCs3TPz9IAF/G+g+fdEsV76SSwQ5gUZgI7LUv/Ci3NH40M0j7p4kn0VR/aKoIXuYxd5ShR1OWEGMcUuVAevv5bCBCjaHSo/ATDIjPwv3HQt5Tpydhb+jMKlscGCtPQ5sgonyk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7076.eurprd04.prod.outlook.com (10.186.130.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Mon, 9 Mar 2020 13:58:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:57:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Adam Ford <aford173@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
Thread-Topic: [PATCH] soc: imx: Makefile: only build soc-imx8 when
 CONFIG_ARM64
Thread-Index: AQHVyrHXB0HrD3qW50ui9P9S7z/H8qfp0NaAgAADRlCAACnrAIABBSNwgACHbgCADn0MAIAEANYwgAAfBYCAQm8QcIAAB2KAgAABvUA=
Date:   Mon, 9 Mar 2020 13:57:59 +0000
Message-ID: <AM0PR04MB44811CBAABAA8039949F23AB88FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de>
 <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
 <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
 <AM0PR04MB4481B8BDAD2CD7376208B5F2880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a2gOq=qv5C6_0QwBXPuENqhBinK_KkzL5AcAEJtTDyB1w@mail.gmail.com>
 <AM0PR04MB44813F8292A36D84B3F80AEA88FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a0Lc--pDmBG3mBiKyjpOEZVdKVBnLNYBdCjzdgN1byU3w@mail.gmail.com>
In-Reply-To: <CAK8P3a0Lc--pDmBG3mBiKyjpOEZVdKVBnLNYBdCjzdgN1byU3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc71f208-e0d0-41be-1826-08d7c431e0c3
x-ms-traffictypediagnostic: AM0PR04MB7076:|AM0PR04MB7076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7076B5FA67F8F90332A20CB388FE0@AM0PR04MB7076.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(6506007)(53546011)(71200400001)(81156014)(8676002)(81166006)(316002)(8936002)(44832011)(54906003)(33656002)(55016002)(9686003)(4326008)(7696005)(5660300002)(2906002)(64756008)(66446008)(186003)(76116006)(478600001)(66946007)(66476007)(66556008)(6916009)(26005)(86362001)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7076;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ycp10pmRAFpRndcCFwCDQfZfRAqiGe7piBNPi2aPqipM3itZ1HUXW0EBz/qGe3qKIrdVOj067erkmYBXmgHszH/oyrQ1N8RI+W3OQ7ZmB3I39CYIRplsgrOq6Sg9X6IsXs+yKravZhi6tkBxaG54vthOXRYbTVVFc5AfAUZUVqMAt/1btOTjuKCPR8yykTugajN+788y2Pwk5Uek6iMDDdZrLtCsnSm7tT7SOPeUeji8d60PsEy+feTCp5/FCiX7bxNHGu4edVNO/X5xpiTATQJ0siPE2EpwdwiofO2IvjihmYqB7yHcwo/+jdwiBkpg9bPuISZUxKzgHJTIzBSSHgW48c/bb3av45ZTbYuvAjLj8Dlp+33rGiQ+tqY78ADpCrIXSjvM0umst0og0VsVMjRrfz2WpMpt8QyXBXlHQWP7ZU+pHEgT8ZM9h1lsd3Wh
x-ms-exchange-antispam-messagedata: zUvs3/bVjSn+BoqeR/w4cOdceoJZMd9bx+mWYTGx8nHs2EMuXmhwcK9p8OAAxSJucUUNNscq+aRgB6UbL996/4Yva1cEyyO6tDnXPDSDVrbyTCQMIi89Yk/H9l7zlp7XwhlmGj0wSncinslxhg264A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc71f208-e0d0-41be-1826-08d7c431e0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 13:57:59.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yg32Odeh2LgZwHhF4Q95Wi7NNnqsr1nFduen6dgsD4qYptCbMIKqcvPAXC/UQHTha16KLVGm/8N6ip00HYro2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2M6IGlteDogTWFrZWZpbGU6IG9ubHkgYnVpbGQgc29j
LWlteDggd2hlbg0KPiBDT05GSUdfQVJNNjQNCj4gDQo+IE9uIE1vbiwgTWFyIDksIDIwMjAgYXQg
MjoyOCBQTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBzb2M6IGlteDogTWFrZWZpbGU6IG9ubHkgYnVpbGQgc29jLWlteDggd2hl
bg0KPiA+ID4gQ09ORklHX0FSTTY0DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBKYW4gMjcsIDIwMjAg
YXQgNjowNSBBTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IE1ha2VmaWxlOiBvbmx5IGJ1aWxkIHNvYy1p
bXg4DQo+ID4gPiA+ID4gd2hlbiBEb2VzIGFueW9uZSBoYXZlIGFueSBzdWdnZXN0aW9ucyBvbiB3
aGVyZSBJIG1pZ2h0IGZpbmQgc29tZQ0KPiA+ID4gPiA+IGdlbmVyaWMgc3R1ZmYgZm9yIGVpdGhl
ciBpTVg4TSBvciBnZW5lcmljIEFSTXY4IGRvY3MgZm9yIGRvaW5nDQo+ID4gPiA+ID4gc29tZXRo
aW5nIGxpa2UNCj4gPiA+IHRoaXM/DQo+ID4gPiA+DQo+ID4gPiA+IFdlIGRpZCBhIHBvcnRpbmcg
Zm9yIG9uZSBjdXN0b21lciwgYnV0IGNvZGUgaXMgbm90IHB1YmxpYyBhdmFpbGFibGUuDQo+ID4g
PiA+DQo+ID4gPiA+IEZpcnN0IGxldCB1Ym9vdCBzd2l0Y2ggdG8gQUFSQ0gzMiBtb2RlIHdoZW4g
Ym9vdGluZyBMaW51eCwgdGhpcyBpcw0KPiA+ID4gPiBhbHJlYWR5IHN1cHBvcnRlZCBieSB1Ym9v
dCBtYWlsaW5lLg0KPiA+ID4gPg0KPiA+ID4gPiBTZWNvbmQsIGNyZWF0ZSBhIG1hY2gtaW14OG0u
YyB1bmRlciBhcmNoL2FybS9tYWNoLWlteCB0byBoYW5kbGUNCj4gPiA+IGkuTVg4TQ0KPiA+ID4g
PiBqdXN0IGxpa2Ugb3RoZXIgaS5teCBhcm0zMiBzb2NzLiBUaGlzIGlzIG5vdCBwcmVmZXJyZWQg
YnkgTGludXgNCj4gY29tbXVuaXR5Lg0KPiA+ID4gPg0KPiA+ID4gPiAzcmQsIGJ1aWxkIGkuTVg4
TSBkcml2ZXJzIHdoZW4gdXNpbmcgaW14X3Y3X2RlZmNvbmZpZyggb3INCj4gPiA+ID4gaW14X3Y2
X3Y3X2RlZmNvbmZpZyBpbiB1cHN0cmVhbSkNCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHRoZSB0aGly
ZCBwYXJ0IGlzIHNvbWV0aGluZyB3ZSBjYW4gY2xlYXJseSBkbyBvbmNlIGl0IGFjdHVhbGx5IGJv
b3RzLg0KPiA+ID4NCj4gPiA+IENhbiB5b3UgcG9zdCB0aGUgcGF0Y2ggZm9yIHRoZSBzZWNvbmQg
cGFydCBmb3IgcmVmZXJlbmNlPyBJbiB0aGVvcnkNCj4gPiA+IG5vdGhpbmcgc2hvdWxkIGJlIG5l
Y2Vzc2FyeSB0aGVyZSwgc28gSSB3b25kZXIgd2hhdCBJJ20gbWlzc2luZyAoYXMNCj4gPiA+IHdl
IG5lZWQgbm8gY29kZSBmb3IgYXJjaC9hcm02NCkgYW5kIHdoYXQgd2UgY2FuIGRvIGRpZmZlcmVu
dGx5IHRvDQo+ID4gPiBtYWtlIGl0IHdvcmsgb3V0IG9mIHRoZSBib3guDQo+ID4gPg0KPiA+ID4g
SXMgdGhlIHByb2JsZW0gdGhhdCB0aGUgU01QIGJyaW5ndXAgdXNpbmcgUFNDSSBmb3IgYXJtNjQg
ZG9lc24ndA0KPiA+ID4gd29yayB3aXRoIHRoZSAzMi1iaXQga2VybmVsIGZvciBzb21lIHJlYXNv
bj8NCj4gPg0KPiA+IFNvcnJ5IGZvciBsb25nIHRpbWUgZGVsYXkuIEkgZm9yZ290IHlvdXIgbWFp
bC4gSSBkaWQgc29tZSB0cnkgYWdhaW4sDQo+ID4gc2VlbXMgb25seSBuZWVkIHRoZSBmb2xsb3dp
bmcgcGllY2UgY29kZSB0byBtYWtlIGl0IGJvb3QsIGFsc28gc2VsZWN0DQo+ID4gR0lDX1YzIGFu
ZCBkcm9wIHNvbWUgQVJNNjQgZGVwZW5kZW5jaWVzIGluIEtjb25maWcgZm9yIHNvbWUgaS5NWA0K
PiBkcml2ZXJzLg0KPiA+IE5lZWQgc29tZSBhZGRpdGlvbiB3b3JrIGluIEFURi9VLUJvb3QNCj4g
PiB0byBtYWtlIHNtcCB3b3JrLCB0aGF0IGlzIG5vdCBMaW51eCByZWxhdGVkLg0KPiANCj4gQWgs
IG5pY2UhDQo+IA0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqY29uc3QgaW14OG1tX2R0X2NvbXBh
dFtdIF9faW5pdGNvbnN0ID0gew0KPiA+ICsgICAgICAgImZzbCxpbXg4bW0iLA0KPiA+ICsgICAg
ICAgTlVMTCwNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxhc20vbWFjaC9hcmNoLmg+
DQo+ID4gK0RUX01BQ0hJTkVfU1RBUlQoSU1YN0QsICJGcmVlc2NhbGUgaS5NWDhNTSAoRGV2aWNl
IFRyZWUpIikNCj4gPiArICAgICAgIC5kdF9jb21wYXQgICAgICA9IGlteDhtbV9kdF9jb21wYXQs
DQo+ID4gK01BQ0hJTkVfRU5EDQo+ID4NCj4gPg0KPiA+IEFyZSB5b3Ugb2sgd2UgYWRkIHN1Y2gg
cGllY2UgY29kZSBpbiBkcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYyB0bw0KPiA+IHN1cHBvcnQN
Cj4gPiBhYXJjaDMyIGxpbnV4Pw0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0IGNvZGUgZG9lcyBh
bnl0aGluZyBvdGhlciB0aGFuIHNldCB0aGUgbWFjaGluZSBuYW1lLiBBcmUNCj4geW91IHN1cmUg
aXQgZG9lc24ndCB3b3JrIHdpdGhvdXQgdGhhdD8NCg0KUGVyIHNldHVwX21hY2hpbmVfZmR0IGNv
ZGUsIEkgbWF5IG5lZWQgdG8gZ2l2ZSBhIHRyeSB3aXRoDQpDT05GSUdfQVJDSF9NVUxUSVBMQVRG
T1JNLiBJJ2xsIGdpdmUgYSB0cnkgYW5kIHVwZGF0ZSBsYXRlci4NCg0KPiANCj4gSWYgaXQncyBp
bmRlZWQgcmVxdWlyZWQsIEknZCBwcmVmZXIgdG8gYWRkIGEgZmlsZSBmb3IgaW4gYXJjaC9hcm0v
bWFjaC1pbXggdGhhbg0KPiBpbiBkcml2ZXJzL3NvYy8uDQoNClRoYW5rcywNClBlbmcuDQoNCj4g
DQo+ICAgICAgIEFybmQNCg==
