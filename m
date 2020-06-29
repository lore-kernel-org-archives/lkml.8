Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1390120720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ono6JjXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgF2VAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbgF2TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:59 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEF5C0068FA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPrkNTJ38yIsT/dqEEnu3fUA27EH4vLhM61q33/7hUIPLAtHlkZIhR4BHuSQOOT6iNCnFXfaLIhiRHFP/HcZAd9WAuQbEV7bkrfDZuw8CEQVNpBXll903/5u5JfRePCFdBZ9NT/f1FpYc4GTAPczihMu/V9x+3jRd7KxhZFP7kd0lMajbGE/fRsRmioyWKYsskrj3SmKsX50+BPNp/XOK2IOlFUDXyKrZ0oxSXdzjBAFRNOLmDeiQ6OIFdVNTVn4IAi/svYU2QXWxYvH4XKlrdvxUyd05qnHTFBCxum1mxfY6AZta+VOPa+8EN1Z1VW/G9MfzKj9LMEDSm0z3RRrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLZ5JV7UGJM8S8sbbMwCdHUnQg6sFDggJlZ+hRkDtyU=;
 b=VXBWY7Laa3DsQ17PixLclPeQRRskGDWCmWZbjNgiL9GBX+IbM+OpgZ1J4GKxNaf1I5s7xnbxX0IfVowlP1b0FaPVcsLJ9+lQ5utHXp5PAACH8pdFPIAKd0ypad5dT5e9hseUtPsccEpUVlHIv0g/20T9HvLoeWZyUwSin3BgkdfH86EjJmoxlXMUYlqvMVwKBpKoZGEl1zZ6z8FoaeF31HuWhcux9PlNnIgBmVdXbmAJrRuOZEJOJI/XgNQCLZiVNawaF5JYQ4cXU7bhZaKZovlI1LGxEVLS5m4TUxl7qvSiw4h6uB7vlXd/r7igmvoK9tkC9OOkS3szHOcGW+X/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLZ5JV7UGJM8S8sbbMwCdHUnQg6sFDggJlZ+hRkDtyU=;
 b=Ono6JjXrMAsC9H1abqBf9h0oFlJBeGUkeYunkFlElzL1egkl0NGLfh96kEnCP9Mlc8B5aPInQBLB2dDVwmVwdKvIqfJWMH6nMjRaS2jYwymw0UuffnEVKRYLx7qcOYbIGXEyQ8/lAnGPE4yOEgy1MsWSFliXC+vPrRztZ+f/Ni4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4092.eurprd04.prod.outlook.com (2603:10a6:5:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 11:44:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:44:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] reset: imx7: Support module build
Thread-Topic: [PATCH 1/3] reset: imx7: Support module build
Thread-Index: AQHWTf+gVil33+KDPEOiQKx/rvC/xajvZ8CAgAAAWbCAAAylgIAAALfAgAAC/wCAAACdIA==
Date:   Mon, 29 Jun 2020 11:44:49 +0000
Message-ID: <DB3PR0402MB39168490A754EC4B32CAFFA0F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
 <DB3PR0402MB3916292FC3FDE4F28AFEB5EBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0Za99-xXTwtHNHO-Dzbo-1uesNC2oO91RA-gZZG3Anmw@mail.gmail.com>
 <DB3PR0402MB3916ADD54CB167B8ED10076DF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1mCD1JFg80HSos9hp0ye1vu_hk79wFGz6YZ3kj10XACg@mail.gmail.com>
In-Reply-To: <CAK8P3a1mCD1JFg80HSos9hp0ye1vu_hk79wFGz6YZ3kj10XACg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e082b3a-60da-4add-4eac-08d81c21d45c
x-ms-traffictypediagnostic: DB7PR04MB4092:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB409259F5C157CBF802B6A254F56E0@DB7PR04MB4092.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEUAbHkSJP2/AZi9wrbX+DoiYMJMBTauuOImJHdbga55jTRYytCRACEH5nptdT4EMaKYL1RC8eYVv7qAsEyvHSaeI5JuwlQmwHM8H/aO0SBRI5PmI0wGYt5rhonjMNzb3f89ENYkBi0ncfTiO65zEbg61fUmg2cz84c70lPfAy3mW+mx4RXBPrQdIujtdoaOU4pEXSQFA0FT/KXl0I7cVYUdetHXS3qX/RCQf3erLmR5MDSIveqeZ1ifV7Bc9UuYDuaDCBDBsSP5xrV/ntDyL1L+DSpLwiQXXb9nGElcwWWby20w6xSsQa7wQkBAUU7ONm2wTWyY9XplQVhKVAMHWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(44832011)(66556008)(478600001)(64756008)(66946007)(66446008)(7696005)(66476007)(6916009)(76116006)(2906002)(316002)(54906003)(55016002)(9686003)(71200400001)(7416002)(26005)(4326008)(33656002)(186003)(52536014)(8676002)(83380400001)(8936002)(5660300002)(86362001)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lNxvDKNhvXJcq1+G/2/DadAG/Wm24/VhzymZoCFFnOxBL8o5J1oHVEEHTcMTAchZPYCCFNcOkTnUPWwhBXfKDQ4/B/w5drtQeshCvp3FXwCsmRvGOt2+gLrasAMqkq1iO+fL9k/UtREY/Z3Xc31tiaTmLLP99xiwDGjrS48+Ya72nItev6FeEfZC64rJcxEl8+BjPZdEKpm0jVbbCRxpwHnm9i75FqZW4KuF7IRIO2sa4aG+iYDgDqIGJ8tBCwDCVf38Rwvw/wUh+LhfjkyU//QJlxKMANrf2JsJCSuThli1mYtpgJri1O55sM+wu1nmzA/fxb+oLw+dV+pr9e7oukM0IIfBy4VLhEWOvbaBumZBQLGZKzLtzCfvH2ntq1LCuDUHC4dLLK4VC8r7ktcUHPDFHWNeLemK8F+ctNR6geQScS3zzEBMv5Jej0oGwNF5fVE6mnTrZHw9b3Q64bimn+4Y7pCiF9F1jySV5zI4kGryvE26mJJeXODFgpbzn70O
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e082b3a-60da-4add-4eac-08d81c21d45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:44:49.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8cEf+WQ95IRKba2KhoVHreJJMRj85MTc9gPTjf/1uwnG8Nbf+3BNy3x0Tgne9hthl+0kE+fajRomUHW3c5hDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSByZXNldDogaW14NzogU3Vw
cG9ydCBtb2R1bGUgYnVpbGQNCj4gDQo+IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDE6MzIgUE0g
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzNdIHJlc2V0OiBpbXg3OiBTdXBwb3J0IG1vZHVsZSBidWlsZA0KPiA+
ID4NCj4gPiA+IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDEyOjQ1IFBNIEFuc29uIEh1YW5nDQo+
IDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzNdIHJlc2V0OiBpbXg3OiBTdXBwb3J0IG1vZHVsZSBidWlsZCBPbg0KPiA+
ID4gPiA+IE1vbiwgSnVuIDI5LCAyMDIwIGF0IDEyOjI1IFBNIEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIHJlc2V0IGRyaXZl
ciBub3JtYWxseSB3b24ndCBiZSByZW1vdmVkIHNpbmNlIGl0IGlzIG5lY2Vzc2FyeQ0KPiA+ID4g
PiBmb3IgZHJpdmVycyB3aGljaCBuZWVkIGl0LCBpdCBpcyBqdXN0IGZvciBBbmRyb2lkIEdLSSBz
dXBwb3J0LCBpbg0KPiA+ID4gPiB0aGlzIGNhc2UsIGRvIHdlIG5lZWQgdG8gY2hhbmdlIGl0IHRv
IG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoKT8NCj4gPiA+DQo+ID4gPiBQbGVhc2UgYXQgbGVhc3Qg
dHJ5IHRvIGRvIGl0LCBvciBleHBsYWluIGluIHRoZSBjaGFuZ2Vsb2cgd2hhdCB3ZW50DQo+ID4g
PiB3cm9uZyBpZiBpdCBkb2Vzbid0IHdvcmsuDQo+ID4gPg0KPiA+ID4gSSBkb24ndCB0aGluayAi
YmVjYXVzZSBBbmRyb2lkIEdLSSIgc2hvdWxkIGV2ZXIgYmUgdGhlIHNvbGUNCj4gPiA+IGp1c3Rp
ZmljYXRpb24gZm9yIGEgcGF0Y2guIE1ha2luZyBkcml2ZXJzIGxvYWRhYmxlIG1vZHVsZSBpcyBh
IGdvb2QNCj4gPiA+IGlkZWEgcmVnYXJkbGVzcyBvZiBHS0ksIGFuZCBpZiB5b3UgZG8gdGhhdCwg
dGhlbiBtYWtlIGl0IGJlaGF2ZSBsaWtlIGFueQ0KPiBvdGhlciBsb2FkYWJsZSBtb2R1bGUuDQo+
ID4gPg0KPiA+DQo+ID4gT0ssIHdpbGwgZG8gaXQgaW4gVjIsIEJUVywgSSB0aGluayB0aGVyZSBp
cyBub3RoaW5nIG5lZWQgdG8gYmUgZG9uZQ0KPiA+IGZvciAucmVtb3ZlKCkgY2FsbGJhY2ssIGNh
biBJIGp1c3Qgc2tpcCBpdCBvciBuZWVkIHRvIGFkZCBhIGJsYW5rIGNhbGxiYWNrDQo+IGFueXdh
eT8NCj4gDQo+IEkgdGhpbmsgaWYgZXZlcnl0aGluZyBpcyBkb25lIHRocm91Z2ggZGV2bV8oKSBj
YWxscyB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gaGF2ZQ0KPiBubyAucmVtb3ZlKCkgY2FsbGJhY2sg
YXQgYWxsLCBidXQgSSBoYXZlIG5vdCB0cmllZCB0aGF0Lg0KPiANCg0KT0ssIEkgaGF2ZSBjb25m
aXJtZWQgdGhhdCBiZWZvcmUgaW4gb3RoZXIgZHJpdmVycywgc28gSSB3aWxsIG5vdCBoYXZlIC5y
ZW1vdmUgY2FsbGJhY2soKQ0KZm9yIHRoaXMgZHJpdmVyLg0KDQpUaGFua3MsDQpBbnNvbg0K
