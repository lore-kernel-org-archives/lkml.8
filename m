Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C449EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8C62098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YFGy50Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFQMbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:31:42 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:38766
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgFQMbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:31:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgFdiNAJ9KNmUUY8iQXd76aAtM1j3f7eGJgJiK5oyWKpoGSXOSpY19N4mkuZo9IuOV0fP89yRqhbAQRP3kYejSB3GP5TsksBIjiZ8O+KeFxzeZCSBCmom89EqFO5uFPHE7nsQFO520SrmhqTF9HS86d5LZvMVJKTQI++P1PaFsD82ZAIkMER1Fc8lh8dblwgx+VEBdY+NyXzs/nN/3ObnYGuQ5dmZpp8v8dny7ZLWGPzf++2CRBHbCjeCZlRJ0CdmZ3FAReoaYdOJx5mDARnCKLORmsrXIKYVR2aopmym8rE/aOlPjkTD9NH9J8Vxmtn68gmNOZaUhqIXSKQylYJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li3kh4MLDOJ1/8cznkgPZE1JxjJ2O+9lKERAUqgj7k8=;
 b=BeE8wrEQBL3KIwzWFi5noBXsRi4qYAK2ATE/mUy+kvGzW343+A0X123U5R9gXOPUbBJQ1QVRTgqNLw+XeQEiIZLsgZA3s941+UZyMSpgs/bMt7reKOmk3DO5hPnTjl0c2dstMk3frW2JwZWQnwtisXx158ZFg4yaxXe6nvEMRtTRdj+X4fNM2awSLXrgjo+f0Gq4oKuM3s0teQzffthyhoQzFNKXBicK6nW72/0+ltWfI/6aoTaPVjSbwGM7uF9VA/JxMt1cBjsSriJzBzLDbU8kSJdzAvMoDoOpw3wJBllhN9mjQwKSMp6gcELhrvel8qnvFziyMSeB64MR0Ew7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li3kh4MLDOJ1/8cznkgPZE1JxjJ2O+9lKERAUqgj7k8=;
 b=YFGy50Rud6J8FVcvEHCY/WBTxesQaAnjapH0wbv430R4zeqhGsHFA7pPJoKd/ZCUeFoMsmO7BRl7I/a9WJ/gSxylf1SxeUC0g4U5wXFxkt0zFecqjmDZBN1VKhrDwGdbBS5TnS+Juqj9U0+5rAZ/O/AJJhkkpfk3m5v0esMd1Ec=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3818.eurprd04.prod.outlook.com (2603:10a6:8:e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 12:31:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 12:31:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/9] clk: composite: Export clk_hw_register_composite()
Thread-Topic: [PATCH V2 1/9] clk: composite: Export
 clk_hw_register_composite()
Thread-Index: AQHWPjGiF9uPvLda2kWeKUSGmuz6tKjcoooAgAAmlXA=
Date:   Wed, 17 Jun 2020 12:31:35 +0000
Message-ID: <DB3PR0402MB3916CD2DEFC64796E7869EEDF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-2-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49665E5D93C2FFA8221F8660809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49665E5D93C2FFA8221F8660809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50167d62-306d-45c2-8bf2-08d812ba6041
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3818B5678A1D052042EDE0F3F59A0@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uMBnudk81htzmBCpv0xbJzzI8VYeL0wr8Y3eMYEl+cDzZzeH3YRsNSq57e562E48vsZBVHgxwiP530WH5HygtwKe3vHxdoUUnhzCoJg9EJNSHsOV8IBkSTI6aoWGwqtCnaiefxJG/OSHX9TebzJom8ad7twOjZ9QPdXPAY9kp4WiofL9JGT67AZJYowDWStUXHaItYXeL1PftwsQiyHBEF7l80PX22uJJ4UY8FsuITTXqiSdwvZaKze5yq39GVdT8wVpeNVlkiAjspVTqJ8Iw25Yk/tviBdpri8IBaRw0blZdAPzZGzOQrnTNqF/qX4Rfys5RLVeqVHPgdC9i9knfub9BAIZ7cw2fz5H6fNU44TH8J1smtY5FV2WSCkxhlv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(186003)(8936002)(5660300002)(86362001)(2906002)(71200400001)(52536014)(6506007)(26005)(33656002)(83380400001)(8676002)(4326008)(7416002)(7696005)(316002)(478600001)(9686003)(44832011)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(110136005)(55016002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +B8UFrimNTTbV9P6c538d3YktTI6yheOEtvwsVz+m6HJlXUVEQdu/G+Tp0RmjN4jw611HjvDz+JBjTgTvdNkmzS4wwgH6lD2DgbygMMz4pvvIPYw31Dyn7/qVN599RG5b6oe+NRskpjdjXB55DLGdZpEGvxahVSZnwFgz9TbizUZT3nbZZRcjkAtFc56941vWVRhA3/I3CVRpTvLDLMooWUeWsIM75dPH2eY8DJsMYj3zkh2DJnErr+hAAH2rBekwSjUUxJwmlg1IuoUoZhLUOXq/RyDidRo2CGKLn46hRz+3L3Bl2jlLqUQvHUf6gbcSmaLEqJ1bNSzxC7PvbY73ywFoUjrZ9ujqceMF2BhbrNGir1tCwCp/XMx8dl2/AZGDoCZBtFiXen7MLmr7KczhamLyxQI8e9EirMgqd3wyvOoQ4qJahl6nBlB8x8qzxIfLGDbC0vMTeNsptAfN527JL86kg3euU6TNRbeIbjkGtdhd1JbwaP8ujBV0GaSNfQe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50167d62-306d-45c2-8bf2-08d812ba6041
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 12:31:35.9881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB4ctq9WoaAU3FEkRHOnD+U6RtdO/JjLvUXughHBkI3jdiEr8lDc7tIsfGZvsAkPid/2wuRRS5aCRlvwRxHS2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMiAxLzldIGNsazogY29tcG9zaXRlOiBFeHBvcnQN
Cj4gY2xrX2h3X3JlZ2lzdGVyX2NvbXBvc2l0ZSgpDQo+IA0KPiA+IEZyb206IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgOSwgMjAyMCAz
OjMyIFBNDQo+ID4NCj4gPiBFeHBvcnQgY2xrX2h3X3JlZ2lzdGVyX2NvbXBvc2l0ZSgpIHRvIHN1
cHBvcnQgdXNlciBidWlsdCBhcyBtb2R1bGUuDQo+ID4NCj4gPiBFUlJPUjogbW9kcG9zdDogImNs
a19od19yZWdpc3Rlcl9jb21wb3NpdGUiDQo+ID4gW2RyaXZlcnMvY2xrL2lteC9teGMtY2xrLmtv
XSB1bmRlZmluZWQhDQo+ID4gc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0OjExMTogcmVjaXBlIGZv
ciB0YXJnZXQgJ01vZHVsZS5zeW12ZXJzJw0KPiA+IGZhaWxlZA0KPiA+IG1ha2VbMV06ICoqKiBb
TW9kdWxlLnN5bXZlcnNdIEVycm9yIDENCj4gPiBtYWtlWzFdOiAqKiogRGVsZXRpbmcgZmlsZSAn
TW9kdWxlLnN5bXZlcnMnDQo+ID4gTWFrZWZpbGU6MTM4NDogcmVjaXBlIGZvciB0YXJnZXQgJ21v
ZHVsZXMnIGZhaWxlZA0KPiA+IG1ha2U6ICoqKiBbbW9kdWxlc10gRXJyb3IgMg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gTm8gY2hhbmdlLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9jbGstY29tcG9zaXRl
LmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5jIGIvZHJpdmVycy9jbGsvY2xr
LWNvbXBvc2l0ZS5jDQo+ID4gaW5kZXggNzM3NmY1Ny4uMmRkYjU0ZiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGst
Y29tcG9zaXRlLmMNCj4gPiBAQCAtMzI4LDYgKzMyOCw3IEBAIHN0cnVjdCBjbGtfaHcgKmNsa19o
d19yZWdpc3Rlcl9jb21wb3NpdGUoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIg
Km5hbWUsDQo+ID4gIAkJCQkJICAgcmF0ZV9odywgcmF0ZV9vcHMsIGdhdGVfaHcsDQo+ID4gIAkJ
CQkJICAgZ2F0ZV9vcHMsIGZsYWdzKTsNCj4gPiAgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChj
bGtfaHdfcmVnaXN0ZXJfY29tcG9zaXRlKTsNCj4gPg0KPiA+ICBzdHJ1Y3QgY2xrX2h3ICpjbGtf
aHdfcmVnaXN0ZXJfY29tcG9zaXRlX3BkYXRhKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiAgCQkJ
Y29uc3QgY2hhciAqbmFtZSwNCj4gDQo+IEkgZ3Vlc3MgeW91J2QgYmV0dGVyIGFkZCB0aGlzIG9u
ZSBhcyB3ZWxsLg0KDQpJIGRpZCBOT1Qgc2VlIHRoaXMgaXMgdXNlZCBpbiB1cHN0cmVhbSBpLk1Y
IGNsb2NrIGRyaXZlciwgZnJvbSBteSB0ZXN0LCBpdCBpcyBub3QgbmVjZXNzYXJ5IHNvIGZhci4N
Cg0KQW5zb24NCg==
