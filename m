Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BEAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85A6206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3weMcBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbgF2Uvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731380AbgF2TN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC7C0A8887;
        Mon, 29 Jun 2020 00:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdzskCP1O1Ya3+TOD5k+Z5m9HDOBTWuXypY7zuqrcRfqtV9Km3hgPuZArw9rfHF4NRhUBeoas6oLstMlcLnOMF2UN5/l95lvp4dsCfDtNMIliDrMbbFW3Dr4870iGzkNr9Xy/hA6Ai9WyQJf9agL6HcFsq0GLG8vzUSfcgQg9tC2siykvkyZhXMurj/TgniHYtkKX7rgzirdpdzx+xLRHOAdtD6LKUVoFLl2LME6dlpVd2t0uRQMuHFr5tsCv1cDpI37vWYaccA1UF1BI119LvUWudFRN9tQ2LqFKonFWoCT/rJeH2vT4XdgAv5YtqtnqVWkIzG7UZCVlDU6uNM80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl43n8vUBg9NroiDqhOm5H6M5rILC5sL6ySOH2MnCgQ=;
 b=CRbxY7rD9X8Soe+WxULWlhhBcQ/RNDPbd0MhyjcgRxSjTSYKikKHkxphVwD8dSEx2FTiETFAQFmTR1wpcXNxP3jyf7Vgzrph5QslAUAnxy3M8Jwiqve2NJWaRXaMgFmuDiLHUCTlRMsnpIN2fYNI+LfUr9TAXjz6xBtSZ2TT+fFTc8iOMVhUHTQ2LDNYPF62TExwqTi9g5mu8CDPAhihwqZEtvSZU2tGkQy1CYi8IHqcFnmo+kzbJCeCH2cBOsghFgkXSmMVCHudy0oEmuqe7UwXItH9fJ3+aASDt5BKaXjDDpWe5SKPaAJAn1qaib4tsOrZigGlV7EZRDb2V2yfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl43n8vUBg9NroiDqhOm5H6M5rILC5sL6ySOH2MnCgQ=;
 b=H3weMcBlaTsrXuwOhSMj1DF3HYUHcJDLWIGbKn7TftI4TjJh/Tz25d1c2yG+PqQER6AosvBUKa4xqfPVlB+WmXEmiOvU/nQDvbDx1va2V+OnW1WgFPSXFC7GUZwDr9sVPrtmi6W3EX+5a47C2C55gX1vdvlL/CsVMG+8ejddMwk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4325.eurprd04.prod.outlook.com (2603:10a6:209:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 07:27:49 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 07:27:49 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 03/10] ARM: imx: Select MXC_CLK for each SoC
Thread-Topic: [PATCH V3 03/10] ARM: imx: Select MXC_CLK for each SoC
Thread-Index: AQHWTdtf2ighwrlZYE2Io7rocJB2PqjvMbRA
Date:   Mon, 29 Jun 2020 07:27:49 +0000
Message-ID: <AM6PR04MB49662FB8227AEE678F55C116806E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593410042-10598-4-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a86544ff-7b99-49ee-080e-08d81bfded5f
x-ms-traffictypediagnostic: AM6PR04MB4325:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB432568CC44C2D05E918D521B806E0@AM6PR04MB4325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypQX2k/br1QBuPDkNLcLnxv+Ei5OG5kjdf6Qtqe8bqAN4qSqUkdVyUDyZAV2LVbN9oc5DkMF96KOUjKIpc3r9FTLQx6AIS3eQ9XRdlvMXB/snkG5/hsrP5tdUPEL2/fTeGXxe4/sHNETJ0K75Aj+CmaahVdYvgRaZ3nU3LFum9lDrGw7mwGM/cjN0+UVbEMvj589+gwYdLcF60/XznfsdwzMQcNE2ha/mYLuTFIKQX64oebKmVbZaocVrHK/mXdJYkLKN92skEytWsfaOeVcyJe4xZG3IuAFq/Z8KVkOhoUuCU59LjNcUzOHYNpvQVRBtKtCIUf1sYOGJTiO5yKqYi9x/7x53TngwlfJZvOiB1GIwWrCb0owze0t3G5G+GSs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(26005)(71200400001)(33656002)(478600001)(316002)(44832011)(9686003)(2906002)(52536014)(55016002)(83380400001)(7416002)(6506007)(7696005)(76116006)(8936002)(5660300002)(8676002)(86362001)(4326008)(186003)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2M4kDWfrXxofwiUG+SG2M+MYdN4OK37xmT75D/WC51ZQkhe6FHN5cmD+KRFYupgrvCwXxsqGyD8RG1pE6GcFLY6pla1zBfvIuoZlK+PyY2TS9LQIosBap1z/KzS4B14RnpPZu50zl35IDPwov+xe8b68a4+y0xj/ZCx2gQT6m16OODOrFokBXolKyocc+RqoyT3SxtknEubnSDzrnOk6Xm8A6/F1hQ9CfcH3lm53b7gX9kQEeIgNyuUFRIBXi4/8qb7cfPRl7zcvUaPYIqa2/stuCBZaVNCB/dqNTOX/71NrBx0gF5gNLjQSU8Ef+K2as4MqfbTQgBOC3ARwejGbTJZCeamqKcc4N8XWUEPVbsHJgeoJtiN+2ISa9+mhOCpkS+ARShl+zJCS2fdjNLkjvw/MoXmCNas6w9gBr+w6y5O+5qil31RI8kLyZE/ABTaG3E0JSLtBJoeVn8IMeGU33SIKYY39BH16AbJwVpQvvCY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86544ff-7b99-49ee-080e-08d81bfded5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 07:27:49.4979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V0Vd3+lXanMK9SbCmLdckkWcmmLmR3W2t3Ho7lINp4yby25bYYSJqVjT20WY9BArIV4YmtaSzkgcW2gj2A2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBKdW5lIDI5LCAyMDIwIDE6NTQgUE0NCj4gDQo+IGkuTVggY29tbW9uIGNsb2NrIGRyaXZlcnMg
bWF5IHN1cHBvcnQgbW9kdWxlIGJ1aWxkLCBzbyBpdCBpcyBOT1Qgc2VsZWN0ZWQgYnkNCj4gZGVm
YXVsdCwgZm9yIEFSQ0hfTVhDIEFSTXY3IHBsYXRmb3JtcywgbmVlZCB0byBzZWxlY3QgaXQgbWFu
dWFsbHkgaW4gZWFjaCBTb0MNCj4gdG8gbWFrZSBidWlsZCBwYXNzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2Vz
IHNpbmNlIFYyOg0KPiAJLSBtYW51YWxseSBzZWxlY3QgdGhlIE1YQ19DTEsgaW4gZWFjaCBTb0Mg
aW5zdGVhZCBvZiBzZWxlY3RpbmcgaXQNCj4gCSAgZm9yIEFSQ0hfTVhDLg0KDQpBbnkgcmVhc29u
IHRvIGRvIHRoaXM/DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGFyY2gvYXJtL21h
Y2gtaW14L0tjb25maWcgfCAxMSArKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWlteC9LY29uZmln
IGIvYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZyBpbmRleA0KPiBlN2Q3YjkwLi5hNDY1YzBmIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWlteC9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJt
L21hY2gtaW14L0tjb25maWcNCj4gQEAgLTU4LDYgKzU4LDcgQEAgY29uZmlnIFNPQ19JTVgyMQ0K
PiAgCXNlbGVjdCBDUFVfQVJNOTI2VA0KPiAgCXNlbGVjdCBJTVhfSEFWRV9JT01VWF9WMQ0KPiAg
CXNlbGVjdCBNWENfQVZJQw0KPiArCXNlbGVjdCBNWENfQ0xLDQo+IA0KPiAgY29uZmlnIFNPQ19J
TVgyNw0KPiAgCWJvb2wNCj4gQEAgLTY1LDE3ICs2NiwyMCBAQCBjb25maWcgU09DX0lNWDI3DQo+
ICAJc2VsZWN0IElNWF9IQVZFX0lPTVVYX1YxDQo+ICAJc2VsZWN0IE1YQ19BVklDDQo+ICAJc2Vs
ZWN0IFBJTkNUUkxfSU1YMjcNCj4gKwlzZWxlY3QgTVhDX0NMSw0KPiANCj4gIGNvbmZpZyBTT0Nf
SU1YMzENCj4gIAlib29sDQo+ICAJc2VsZWN0IENQVV9WNg0KPiAgCXNlbGVjdCBNWENfQVZJQw0K
PiArCXNlbGVjdCBNWENfQ0xLDQo+IA0KPiAgY29uZmlnIFNPQ19JTVgzNQ0KPiAgCWJvb2wNCj4g
IAlzZWxlY3QgQVJDSF9NWENfSU9NVVhfVjMNCj4gIAlzZWxlY3QgTVhDX0FWSUMNCj4gIAlzZWxl
Y3QgUElOQ1RSTF9JTVgzNQ0KPiArCXNlbGVjdCBNWENfQ0xLDQo+IA0KPiAgaWYgQVJDSF9NVUxU
SV9WNQ0KPiANCj4gQEAgLTQxOSw2ICs0MjMsNyBAQCBjb25maWcgU09DX0lNWDENCj4gIAlzZWxl
Y3QgQ1BVX0FSTTkyMFQNCj4gIAlzZWxlY3QgTVhDX0FWSUMNCj4gIAlzZWxlY3QgUElOQ1RSTF9J
TVgxDQo+ICsJc2VsZWN0IE1YQ19DTEsNCj4gIAloZWxwDQo+ICAJICBUaGlzIGVuYWJsZXMgc3Vw
cG9ydCBmb3IgRnJlZXNjYWxlIGkuTVgxIHByb2Nlc3Nvcg0KPiANCj4gQEAgLTQzMiw2ICs0Mzcs
NyBAQCBjb25maWcgU09DX0lNWDI1DQo+ICAJc2VsZWN0IENQVV9BUk05MjZUDQo+ICAJc2VsZWN0
IE1YQ19BVklDDQo+ICAJc2VsZWN0IFBJTkNUUkxfSU1YMjUNCj4gKwlzZWxlY3QgTVhDX0NMSw0K
PiAgCWhlbHANCj4gIAkgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciBGcmVlc2NhbGUgaS5NWDI1
IHByb2Nlc3NvciAgZW5kaWYgQEAgLTQ0NCw2DQo+ICs0NTAsNyBAQCBjb25maWcgU09DX0lNWDUN
Cj4gIAlib29sDQo+ICAJc2VsZWN0IEhBVkVfSU1YX1NSQw0KPiAgCXNlbGVjdCBNWENfVFpJQw0K
PiArCXNlbGVjdCBNWENfQ0xLDQo+IA0KPiAgY29uZmlnCVNPQ19JTVg1MA0KPiAgCWJvb2wgImku
TVg1MCBzdXBwb3J0Ig0KPiBAQCAtNDc3LDYgKzQ4NCw3IEBAIGNvbmZpZyBTT0NfSU1YNg0KPiAg
CXNlbGVjdCBIQVZFX0lNWF9NTURDDQo+ICAJc2VsZWN0IEhBVkVfSU1YX1NSQw0KPiAgCXNlbGVj
dCBNRkRfU1lTQ09ODQo+ICsJc2VsZWN0IE1YQ19DTEsNCj4gIAlzZWxlY3QgUEwzMTBfRVJSQVRB
Xzc2OTQxOSBpZiBDQUNIRV9MMlgwDQo+IA0KPiAgY29uZmlnIFNPQ19JTVg2UQ0KPiBAQCAtNTYx
LDYgKzU2OSw3IEBAIGNvbmZpZyBTT0NfSU1YN0RfQ000ICBjb25maWcgU09DX0lNWDdEDQo+ICAJ
Ym9vbCAiaS5NWDcgRHVhbCBzdXBwb3J0Ig0KPiAgCXNlbGVjdCBQSU5DVFJMX0lNWDdEDQo+ICsJ
c2VsZWN0IE1YQ19DTEsNCj4gIAlzZWxlY3QgU09DX0lNWDdEX0NBNyBpZiBBUkNIX01VTFRJX1Y3
DQo+ICAJc2VsZWN0IFNPQ19JTVg3RF9DTTQgaWYgQVJNX1NJTkdMRV9BUk1WN00NCj4gIAlzZWxl
Y3QgQVJNX0VSUkFUQV84MTQyMjAgaWYgQVJDSF9NVUxUSV9WNyBAQCAtNTcxLDYgKzU4MCw3IEBA
DQo+IGNvbmZpZyBTT0NfSU1YN1VMUA0KPiAgCWJvb2wgImkuTVg3VUxQIHN1cHBvcnQiDQo+ICAJ
c2VsZWN0IENMS1NSQ19JTVhfVFBNDQo+ICAJc2VsZWN0IFBJTkNUUkxfSU1YN1VMUA0KPiArCXNl
bGVjdCBNWENfQ0xLDQo+ICAJc2VsZWN0IFNPQ19JTVg3RF9DQTcgaWYgQVJDSF9NVUxUSV9WNw0K
PiAgCXNlbGVjdCBTT0NfSU1YN0RfQ000IGlmIEFSTV9TSU5HTEVfQVJNVjdNDQo+ICAJaGVscA0K
PiBAQCAtNTgwLDYgKzU5MCw3IEBAIGNvbmZpZyBTT0NfVkY2MTANCj4gIAlib29sICJWeWJyaWQg
RmFtaWx5IFZGNjEwIHN1cHBvcnQiDQo+ICAJc2VsZWN0IEFSTV9HSUMgaWYgQVJDSF9NVUxUSV9W
Nw0KPiAgCXNlbGVjdCBQSU5DVFJMX1ZGNjEwDQo+ICsJc2VsZWN0IE1YQ19DTEsNCj4gDQo+ICAJ
aGVscA0KPiAgCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIEZyZWVzY2FsZSBWeWJyaWQgVkY2
MTAgcHJvY2Vzc29yLg0KPiAtLQ0KPiAyLjcuNA0KDQo=
