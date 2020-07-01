Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780CCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B9F20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DxHymwgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgGAJ1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:27:12 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:13690
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbgGAJ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:27:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDbiHp5t60urN6o1ijnig4jgu1sz3LnlPp7guizXrVJZTBObvPc00UUldjlxbQaFttyrvvzMIva5QsbbFxJsbXeZcM1KmbL1sv4DEFRuCTHk6J9m1iTyqnT8z96ZDc4PpwWWktq1qq+Hk+2SwQPVakoLlN96FNAfwYN/0toZWvfjI5qA8gxVGAnrYPwfW60pQy9FyZgRDcPMQZvZqejSzZseVkIjYyV8GJLdvc/RefTMk0BT/ROS7RytdgNgAJf9jP8GLwAqi/7pgjm4/J/fKlgh+JMb1hkIPiB0jdHEaYKcgMZNImjGHrbIFIAAzi2rXcJiMd9c7WypMCKuu0bL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ0Tgzxr5jmDXZrdkX5fzezxOaogvKHGE3uTkDNgwKE=;
 b=NRaGrtgjyUC3qEzZkopmIQsi+Gklj/QSWvConP4A4paraHnRiEwkNRrax2aV/mCffZgiCimLHin5AhzJGJm9RCtQA1tGrit9Kci5oJlzUGA04yIVvTjJhr6fpgvjGsnwLbbeQtM744LrWwd/3NeioIsg1p0QUlsVIKiLAhCcTDA4UX6eQFkK2BwJ1At/c9ItMv2Gdn/Iwp2zsF6T/uZZmZabkhfa2Pbng0F+6RiV8cEYw3XrJczbn1404o843AJarOy/Har7LCABbyzfZVwXRGOs7r4cWjnjOR/3vNEMrohA/B6DzilFztQhD1ucE/1ahsmaj4l8WWhzEn2TnH5wCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ0Tgzxr5jmDXZrdkX5fzezxOaogvKHGE3uTkDNgwKE=;
 b=DxHymwgPxjkEm1A4aKQ5R5wWCjiyrC15XeL9o+FSD9KETkvtsdUtUzu6/kBHLDjHghK4w3NqRuGB1GV3u2dP2sbeN7vJvu2a3jkbkJ9bSxUofkMbeqkqmKMA3EstDbIt3sDVxdqFADaRXMl9kO3pOLfdWLRKUvWFhHlvd3QZQMg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 09:27:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 09:27:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for module
 build
Thread-Topic: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for
 module build
Thread-Index: AQHWTdtegku2i+ERdU6EY9a3qfOcyajvdnIAgAABM5CAAAXKgIACsi5ggAA6hYCAAAwYQA==
Date:   Wed, 1 Jul 2020 09:27:07 +0000
Message-ID: <DB3PR0402MB3916F746C792CB2BC876715BF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
 <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
In-Reply-To: <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.9.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb6695fd-c618-46cf-b9b9-08d81da0ec90
x-ms-traffictypediagnostic: DB8PR04MB7180:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7180063B25F64D1E07972265F56C0@DB8PR04MB7180.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkpwXKAAPmLMFtTC7G9U0PhtzwuOeoyhd1Cyt1KB4UD3DdFyO/kJUH8+BJjfa7YJXfWFNok43JL+VURq1VCmutdOKY0Nz5JUopCE1UzNza/aCFXo/joCPzjGFZAnRaLifv4dkZm5q6CbcksH16hZWprVr8FXa6NbCrBlB+omrI1E6R7Nfeq93hob9845/ydZxPWVFL4c2XIai9vUbfmOFiur7AADkyAgMh1rbDXQoi2crIPo3f6E15Bbxr4Rnam4AB3AyBqiVYXDw6N+Qq0YShWB3ExiCo5h5+NdoJozTVTl6N/j9bh/S54YNTkSibB399fbB04WINBV1xkGejA7Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(6506007)(316002)(7416002)(54906003)(2906002)(6916009)(55016002)(7696005)(9686003)(5660300002)(66446008)(86362001)(52536014)(478600001)(66556008)(53546011)(44832011)(66946007)(71200400001)(66476007)(64756008)(8936002)(83380400001)(26005)(8676002)(76116006)(186003)(4326008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8zYdrBGwHBWbMCqd9ywrSpIzocyGkc2NcZRHSz5V4sFqGyz9cCZEbBJboLxByceMykNMnkxsr+nqI+wfeDKpBpTfUC65DwHnfNhD7w6bbabPQD+ML744VmD0wLfb+N/CzFbVeXjJVrCR5jwaTXfUE4Sgt4WnWRTcKe5xL7U5Bjx88m31rHh92qk/PPu2CgUfBgd6f/+m78nigTW2lS/xU64BRlntNgah9gAvGsTZixzxcMwl2XHUIKEgO2XNgLl16ck8VFIX6y7npbMogKDhzmaWYjLxO7s3T0K/ZUiJOfBOsk1E5vIJmi18CXMQ6b6wvyA1UMhKbYQPSeSuSOCOUtr4Dc9aH2i1NZVe8mIOSr5KVShfhDhn2DZwNIx1xSvM9ASCPPvc6P0M88zoAfd9dURU5pzXuzzHCTiBzdiQVJhUKFCz6DrCQ0I6u3Jn6O1sxj+6GGxBkb4xxzF8LHgU2olK/qtHwltAQt/r+y7sm3o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6695fd-c618-46cf-b9b9-08d81da0ec90
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:27:07.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiwRw7Y6uv8re18TfPm+rkRMkp6OO4OQMhaurWBTS5o7ZB7jphnuhdd6pj4TX2JKJysOC2XJL6coHpIjeJ7O+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDIvMTBdIGluaXQuaDogRml4
IHRoZSBfX3NldHVwX3BhcmFtKCkgbWFjcm8gZm9yDQo+IG1vZHVsZSBidWlsZA0KPiANCj4gT24g
V2VkLCBKdWwgMSwgMjAyMCBhdCA3OjE0IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAu
Y29tPg0KPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDIvMTBdIGluaXQu
aDogRml4IHRoZSBfX3NldHVwX3BhcmFtKCkgbWFjcm8NCj4gPiA+IGZvciBtb2R1bGUgYnVpbGQg
T24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMTo0MCBQTSBBbnNvbiBIdWFuZw0KPiA+ID4gPGFuc29u
Lmh1YW5nQG54cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gSXQgbWFrZXMgc2Vuc2UgdG8g
ZHJvcCB0aGUgX19zZXR1cCgpIGFuZCBfX3NlcnVwX3BhcmFtKCkgaW4gdGhlDQo+ID4gPiA+ICNl
bHNlIGJsb2NrLCBqdXN0IHVzZSBvbmUgZGVmaW5pdGlvbiBmb3IgYWxsIGNhc2VzLCBpZiBubyBv
bmUNCj4gPiA+ID4gb2JqZWN0cywgSSB3aWxsIHJlbW92ZQ0KPiA+ID4gdGhlbSBpbiBuZXh0IHBh
dGNoIHNlcmllcy4NCj4gPiA+DQo+ID4gPiBPaywgc291bmRzIGdvb2QuIE5vdGUgdGhhdCB0aGVy
ZSBtYXkgYmUgdXNlcnMgb2YgdGhlIHBsYWluIF9fc2V0dXAoKQ0KPiA+ID4gdGhhdCBqdXN0IGdl
dCB0dXJuZWQgaW50byBub3BzIHJpZ2h0IG5vdy4gVXN1YWxseSB0aG9zZSBhcmUgYWxyZWFkeQ0K
PiA+ID4gZW5jbG9zZWQgaW4gIiNpZm5kZWYgTU9EVUxFIiwgYnV0IGlmIHRoZXkgYXJlIG5vdCwg
dGhlbiByZW1vdmluZyB0aGUNCj4gPiA+IGRlZmluaXRpb24gd291bGQgY2F1c2UgYSBidWlsZCBl
cnJvci4NCj4gPiA+DQo+ID4gPiBIYXZlIGEgbG9vayBpZiB5b3UgY2FuIGZpbmQgc3VjaCBpbnN0
YW5jZXMsIGFuZCBlaXRoZXIgY2hhbmdlIHRoZQ0KPiA+ID4gcGF0Y2ggdG8gYWRkIHRoZSBtaXNz
aW5nICIjaWZuZGVmIE1PRFVMRSIgY2hlY2tzLCBvciBqdXN0IGRyb3AgdGhlDQo+ID4gPiBfX3Nl
dHVwX3BhcmFtKCkgYW5kIGxlYXZlIHRoZSBfX3NldHVwKCkgaWYgaXQgZ2V0cyB0b28gY29tcGxp
Y2F0ZWQuDQo+ID4NCj4gPiBMb29rcyBsaWtlIHRoZSBfX3NldHVwX3BhcmFtKCkgZGVmaW5lZCBp
biAiI2lmbmRlZiBNT0RVTEUiIGNhbiBOT1QgYmUNCj4gPiB1c2VkIGZvciBNT0RVTEUgYnVpbGQg
YXQgYWxsLCBzbyBzaGFyaW5nIHNhbWUgaW1wbGVtZW50YXRpb24gaXMgTk9UDQo+ID4gYXZhaWxh
YmxlLCBzbyBpZiBpdCBpcyBOT1QgdGhhdCBjcml0aWNhbCwgSSBwbGFuIHRvIGtlZXAgdGhlICNl
bHNlDQo+ID4gYmxvY2sgaW4gdGhpcyBwYXRjaCwgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgZnVy
dGhlciBjb25jZXJuIG9yIGFueQ0KPiA+IG90aGVyIHN1Z2dlc3Rpb24sIGJlbG93IGlzIHRoZSBi
dWlsZCBlcnJvciByZXBvcnRlZCBmb3IgbW9kdWxlIGJ1aWxkDQo+ID4gdXNpbmcNCj4gPiBfX3Nl
dHVwX3BhcmFtKCkgaW1wbGVtZW50YXRpb24gZm9yIGJ1aWx0IGluLg0KPiANCj4gSSBkb24ndCB1
bmRlcnN0YW5kIHdoYXQgeW91ciBwbGFuIGlzIGhlcmUuIERvIHlvdSBtZWFuIHlvdSB3aWxsIGxl
YXZlIHRoYXQNCj4gcGFydCBvZiB0aGUgY2xrIGRyaXZlciBhcyBidWlsdC1pbj8NCg0KSSBtZWFu
dCBJIHdpbGwgbGVhdmUgdGhlICNlbHNlIGJsb2NrIG9mIF9fc2V0dXBfcGFyYW0oKSBkZWZpbmVk
IGFzIG5vdGhpbmcgYXMgYmVsb3cgdG8NCm1ha2UgbW9kdWxlIGJ1aWxkIHBhc3NlZC4NCg0KI2Rl
ZmluZSBfX3NldHVwX3BhcmFtKHN0ciwgdW5pcXVlX2lkLCBmbiwgZWFybHkpICAgICAgICAvKiBu
b3RoaW5nICovDQoNCj4gDQo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5oOjEyLA0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAu
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbHNlLmg6MTUsDQo+ID4gICAgICAgICAgICAgICAgICBm
cm9tIC4vYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jbXB4Y2hnLmg6MTQsDQo+ID4gICAgICAgICAg
ICAgICAgICBmcm9tIC4vYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9hdG9taWMuaDoxNiwNCj4gPiAg
ICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2F0b21pYy5oOjcsDQo+ID4gICAg
ICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9hc20tZ2VuZXJpYy9iaXRvcHMvYXRvbWljLmg6
NSwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2Jp
dG9wcy5oOjI2LA0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYml0
b3BzLmg6MjksDQo+ID4gICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9rZXJu
ZWwuaDoxMiwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2Nsay5o
OjEzLA0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2Nsay9pbXgvY2xrLmM6MjoN
Cj4gPiAuL2luY2x1ZGUvbGludXgvaW5pdC5oOjE3NzoxNjogZXJyb3I6IHZhcmlhYmxlDQo+IOKA
mF9fc2V0dXBfaW14X2tlZXBfdWFydF9lYXJseWNvbuKAmSBoYXMgaW5pdGlhbGl6ZXIgYnV0IGlu
Y29tcGxldGUgdHlwZQ0KPiA+ICAgMTc3IHwgIHN0YXRpYyBzdHJ1Y3Qgb2JzX2tlcm5lbF9wYXJh
bSBfX3NldHVwXyMjdW5pcXVlX2lkICBcDQo+ID4gICAgICAgfCAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+DQo+ID4gZHJpdmVycy9jbGsvaW14L2Nsay5jOjE1NzoxOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8g4oCYX19zZXR1cF9wYXJhbeKAmQ0KPiA+ICAgMTU3IHwgX19zZXR1
cF9wYXJhbSgiZWFybHljb24iLCBpbXhfa2VlcF91YXJ0X2Vhcmx5Y29uLA0KPiA+ICAgICAgIHwg
Xn5+fn5+fn5+fn5+fg0KPiA+IC4vaW5jbHVkZS9saW51eC9pbml0Lmg6MTgwOjc6IHdhcm5pbmc6
IGV4Y2VzcyBlbGVtZW50cyBpbiBzdHJ1Y3QgaW5pdGlhbGl6ZXINCj4gPiAgIDE4MCB8ICAgPSB7
IF9fc2V0dXBfc3RyXyMjdW5pcXVlX2lkLCBmbiwgZWFybHkgfQ0KPiA+ICAgICAgIHwgICAgICAg
Xn5+fn5+fn5+fn5+DQo+ID4gZHJpdmVycy9jbGsvaW14L2Nsay5jOjE1NzoxOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8g4oCYX19zZXR1cF9wYXJhbeKAmQ0KPiA+ICAgMTU3IHwgX19zZXR1
cF9wYXJhbSgiZWFybHljb24iLCBpbXhfa2VlcF91YXJ0X2Vhcmx5Y29uLA0KPiA+ICAgICAgIHwg
Xn5+fn5+fn5+fn5+fg0KPiA+IC4vaW5jbHVkZS9saW51eC9pbml0Lmg6MTgwOjc6IG5vdGU6IChu
ZWFyIGluaXRpYWxpemF0aW9uIGZvcg0KPiA+IOKAmF9fc2V0dXBfaW14X2tlZXBfdWFydF9lYXJs
eWNvbuKAmSkNCj4gDQo+IFRoaXMgZXJyb3IganVzdCBtZWFucyB5b3UgY2FuJ3QgaGF2ZSBhIF9f
c2V0dXBfcGFyYW0oKSBjYWxsIGluIGEgbG9hZGFibGUNCj4gbW9kdWxlLCB3aGljaCB3ZSBhbHJl
YWR5IGtuZXcuIElmIHlvdSBuZWVkIHRvIGRvIHNvbWV0aGluZyB3aXRoIHRoZSBjbG9ja3MNCj4g
ZWFybHkgb24sIHRoYXQgaGFzIHRvIGJlIGluIGJ1aWx0LWluIGNvZGUgYW5kIGNhbm5vdCBiZSBp
biBhIG1vZHVsZS4gSWYgeW91IGRvbid0DQo+IG5lZWQgdGhhdCBjb2RlLCB0aGVuIHlvdSBzaG91
bGQganVzdCByZW1vdmUgaXQgZnJvbSBib3RoIHRoZSBtb2R1bGFyIHZlcnNpb24NCj4gYW5kIHRo
ZSBidWlsdC1pbiB2ZXJzaW9uLg0KPiANCj4gV2hhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGF0IF9f
c2V0dXBfcGFyYW0oKSBhcmd1bWVudCBwYXJzaW5nIGluIHRoZSBjbG9jaw0KPiBkcml2ZXI/DQo+
IA0KDQpXZSBuZWVkIHRoZSBjb2RlIGZvciBwcm9wZXIgdWFydCBjbG9jayBtYW5hZ2VtZW50IG9m
IGVhcmx5Y29uLCBmcm9tIHRoZSBjb2RlLCBpdA0KaXMgdHJ5aW5nIHRvIGtlZXAgY29uc29sZSB1
YXJ0IGNsb2NrIGVuYWJsZWQgZHVyaW5nIGtlcm5lbCBib290IHVwLiANCg0KVGhhbmtzLA0KQW5z
b24NCg==
