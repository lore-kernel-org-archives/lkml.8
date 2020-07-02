Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C1DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A090207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+diHBsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgGBDzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:55:08 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:45538
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgGBDzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7IxaGfTjCLtmhvvm4APuFmjFewsMknmJlS1OeRvqlW7rZz5XBRsAecVxjDLntdWChs0tnL56bU4h86iDYGipWNGhqTeWcJtWMRkEQWIn1lVHOZeb2r6bV1m9fq2NXhcMcywwlijbujnJjFKYRAgxH7qTCF5fWQZrdCK7MgeC1oSJf/1HhvOH1N3lDCsGifznENWDh/zRVQs398oy/TBAcupq0K/JJv4dvsZ0MScadrum52+jf0C8dQMuubOjbJhNdqptnANmFBGZWf4i9p+2p0/h5gk53XO8O/MzShmGFaMUz/WRxsk3gJ/37O5rnMWGgLXI5jK4ZmVM/VCawkG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNOtmI3cxgJqA1nqqXwunBMzL5Kj/cyQWf7HaANpmbQ=;
 b=nTZh62fea7AcZrm7B2UztN+Urn6jIkhEgLgMh7YhsuANbmvu2T1V/mbDlQruDa6dyEsRTUpnANrb7+n80RxF33FyACEPU5ImIPG3Co7ep3uajgzZgKYCCrg2/E77vuyq3OshhphGb9bmsjegIUsrQz5wny941OanivC6OhMqtfR0KAWm/QgY+iWbMH/RGMxL6seKnuDKdFDauVD7daSlzg3BkggXnCZXTF3jGMOb7ONjCtZC0SWNG+u1SGztexm0yrf+jzQXsEVPpjzQejD155CACip12pF8HAWX2LUqzCJ35t74poOaphjabYB/a3H2Huy14SS05dLiEJVykATvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNOtmI3cxgJqA1nqqXwunBMzL5Kj/cyQWf7HaANpmbQ=;
 b=Y+diHBsHNbTvFaClKL2Y7ZYHhhRbpJ37dzOfPDvALoidlnJuC7URmc89kfWfzFlyHS9E5PaHr1sWTOMqJR0qexOuNISnWdRhPqxsqnDxQxFalWKEFui3GVQtA/K80TGxFhvvdd6Wbzoy3LugHm07FXJzRIKaibKEV/bmlRdsSIo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB6618.eurprd04.prod.outlook.com (2603:10a6:10:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 2 Jul
 2020 03:55:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Thu, 2 Jul 2020
 03:55:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock
 driver as module
Thread-Topic: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock
 driver as module
Thread-Index: AQHWUBcDN5O6DfQk0Eys1lXp/0IDLKjznleAgAAHjEA=
Date:   Thu, 2 Jul 2020 03:55:02 +0000
Message-ID: <DB3PR0402MB3916713CC9AF95251A3A2BFAF56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-6-git-send-email-Anson.Huang@nxp.com>
 <CAA+hA=T1+F-oTfWdV22ztUT3Ru-dFPDzhC7aJsdj0R3yP4wzbA@mail.gmail.com>
In-Reply-To: <CAA+hA=T1+F-oTfWdV22ztUT3Ru-dFPDzhC7aJsdj0R3yP4wzbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5df4bc87-fd05-4c02-ddb5-08d81e3bb2c5
x-ms-traffictypediagnostic: DB8PR04MB6618:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6618F56B3F67D539021E366EF56D0@DB8PR04MB6618.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftwRkbQt6JSyOJkH5hfIBsXXY4/F/nUZQ5uvoYUiU/JYfOEd/yeF/FnwO4OC/4RYJ9pLQ4lrl5Dogo7bskUFz3qTy29b7cappYgyQJolfB0COXAL7sT54lid70p/5Mpc3Haf/F96NYxUEariAJNK14VxTq5xy8/8tR/3nE/Al8zOjAh6iEnkhHlW56ZRTCact1uAs5OcqWc5duNfYTHsfmge1M7YQT3by0MNhoCz5nEOGPibXgeLHqyg8umT0Wo8ffZJKy/QpD+b+uaK70NPxBg+qakr5jxe0B88VZ7D1OfR2FkSMh8H5HlWv1tFalsVgb59OOSVaVGXzQg6p/Z6NBfF1+zwUFm4/6ieEDZvBdxqEF6aXuOdte54RcDO3iNY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(83380400001)(6916009)(26005)(186003)(9686003)(44832011)(52536014)(2906002)(478600001)(55016002)(66946007)(54906003)(5660300002)(8936002)(7696005)(4326008)(8676002)(64756008)(66446008)(316002)(86362001)(71200400001)(76116006)(7416002)(33656002)(66556008)(66476007)(53546011)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1co58fQjYDVuhDTZG9Nr4Xlys/I3yIwZOlWXAZVTuohzS5AADyCUtkYeycd6lOBH0M4Qm2gTKgig/MsqT7bhkk4wxOBy52k7MtkfNqD44Bblgzq3kglQVo33Dv0mYGr9PdYOlqAA9ALGRaP+sRl56gJUye6jc6c0RHm8CwgKDTugP9sTDufrPjdfIhjeOO7mv2Vejl2UXXXw0ML21soPIf06H4QJP2enU2YQVRbIUgLdJTb53p9wJdKo7Qt/TWchrnXoLg57tTO503AoQemgK2uPusFS+Qe4wdH/yEMppwwxrJaolyPqrL/PN9UnxMudqMziT2VMRT2smCEbxp/MRTynRFvy91dYRSNBj3dhYDCUQAV21yEbJLEJRdarjnMW5FFkrS6mKv1mIWAOpbS44kr+ojcB4Uma6jNPKQsewyhsJPN5echzjtu7tIA1QEioQC76k32ceEOJqEW8syQU0a9+tChalnBFva/Ee+fik2lYP/GAvQpvEJPZCGhxZPRj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df4bc87-fd05-4c02-ddb5-08d81e3bb2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 03:55:02.0902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQOVNNYr8bWAqZahMXd7umoioAOJwq+rWbbjfhnYOjXJUvBLWa5CD7f0wMPRB61MpMO4GRWbmFowxcRIhz4MtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCA1LzVdIGNsazogaW14OHF4cDogU3VwcG9ydCBi
dWlsZGluZyBpLk1YOFFYUCBjbG9jaw0KPiBkcml2ZXIgYXMgbW9kdWxlDQo+IA0KPiBPbiBUaHUs
IEp1bCAyLCAyMDIwIGF0IDEwOjIwIEFNIEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiB3cm90ZToNCj4gPg0KPiA+IENoYW5nZSBjb25maWd1cmF0aW9uIHRvICJ0cmlzdGF0ZSIs
IHVzZSBkZXZpY2VfaW5pdGNhbGwoKSBpbnN0ZWFkIG9mDQo+ID4gYnVpbHRpbl9wbGF0Zm9ybV9k
cml2ZXIoKSwgYWRkIG1vZHVsZSBhdXRob3IsIGRlc2NyaXB0aW9uIGFuZCBsaWNlbnNlDQo+ID4g
dG8gc3VwcG9ydCBidWlsZGluZyBpLk1YOFFYUCBjbG9jayBkcml2ZXJzIGFzIG1vZHVsZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgVjM6DQo+ID4gICAgICAgICAtIHVzZSBkZXZpY2Vf
aW5pdGNhbGwoKSBpbnN0ZWFkIG9mIGJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKCk7DQo+ID4gICAg
ICAgICAtIGFkZCBtb2R1bGUgYXV0aG9yL2Rlc2NyaXB0aW9uOw0KPiA+ICAgICAgICAgLSBsaW5r
IGNvbW1vbiBzY3UvbHBjZyBjbG9jayBkcml2ZXIgdG8gaS5NWDhRWFAgY2xvY2sgZHJpdmVyLCB0
aGVuDQo+ID4gICAgICAgICAgIG5vIG5lZWQgdG8gaGF2ZSBleHBvcnRzLg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2Nsay9pbXgvS2NvbmZpZyAgICAgICAgICAgIHwgIDYgKysrLS0tDQo+ID4gIGRy
aXZlcnMvY2xrL2lteC9NYWtlZmlsZSAgICAgICAgICAgfCAgOSArKysrLS0tLS0NCj4gPiAgZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg4cXhwLWxwY2cuYyB8IDEwICsrKysrKysrKy0NCj4gPiAgZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg4cXhwLmMgICAgICB8IDExICsrKysrKysrKystDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L0tjb25maWcgYi9kcml2ZXJzL2Nsay9pbXgv
S2NvbmZpZyBpbmRleA0KPiA+IDE4NjcxMTEuLjgzNDBkZmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9jbGsvaW14L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZw0K
PiA+IEBAIC01LDggKzUsOCBAQCBjb25maWcgTVhDX0NMSw0KPiA+ICAgICAgICAgZGVwZW5kcyBv
biBBUkNIX01YQw0KPiA+DQo+ID4gIGNvbmZpZyBNWENfQ0xLX1NDVQ0KPiA+IC0gICAgICAgYm9v
bA0KPiA+IC0gICAgICAgZGVwZW5kcyBvbiBJTVhfU0NVDQo+ID4gKyAgICAgICB0cmlzdGF0ZSAi
SU1YIFNDVSBjbG9jayINCj4gPiArICAgICAgIGRlcGVuZHMgb24gQVJDSF9NWEMgJiYgSU1YX1ND
VQ0KPiA+DQo+ID4gIGNvbmZpZyBDTEtfSU1YMQ0KPiA+ICAgICAgICAgICBib29sICJJTVgxIEND
TSBDbG9jayBEcml2ZXIiDQo+ID4gQEAgLTEyNyw3ICsxMjcsNyBAQCBjb25maWcgQ0xLX0lNWDhN
UQ0KPiA+ICAgICAgICAgICAgIEJ1aWxkIHRoZSBkcml2ZXIgZm9yIGkuTVg4TVEgQ0NNIENsb2Nr
IERyaXZlcg0KPiA+DQo+ID4gIGNvbmZpZyBDTEtfSU1YOFFYUA0KPiA+IC0gICAgICAgYm9vbCAi
SU1YOFFYUCBTQ1UgQ2xvY2siDQo+ID4gKyAgICAgICB0cmlzdGF0ZSAiSU1YOFFYUCBTQ1UgQ2xv
Y2siDQo+ID4gICAgICAgICBkZXBlbmRzIG9uIEFSQ0hfTVhDICYmIElNWF9TQ1UgJiYgQVJNNjQN
Cj4gPiAgICAgICAgIHNlbGVjdCBNWENfQ0xLX1NDVQ0KPiA+ICAgICAgICAgaGVscA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUgYi9kcml2ZXJzL2Nsay9pbXgvTWFr
ZWZpbGUgaW5kZXgNCj4gPiAxN2Y1ZDEyLi43OWU1M2YyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvY2xrL2lteC9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9NYWtlZmlsZQ0K
PiA+IEBAIC0yMSwxNSArMjEsMTQgQEAgbXhjLWNsay1vYmpzICs9IGNsay1wbGwxNHh4Lm8gIG14
Yy1jbGstb2JqcyArPQ0KPiA+IGNsay1zc2NnLXBsbC5vDQo+ID4gIG9iai0kKENPTkZJR19NWENf
Q0xLKSArPSBteGMtY2xrLm8NCj4gPg0KPiA+IC1vYmotJChDT05GSUdfTVhDX0NMS19TQ1UpICs9
IFwNCj4gPiAtICAgICAgIGNsay1zY3UubyBcDQo+ID4gLSAgICAgICBjbGstbHBjZy1zY3Uubw0K
PiA+IC0NCj4gPiAgb2JqLSQoQ09ORklHX0NMS19JTVg4TU0pICs9IGNsay1pbXg4bW0ubw0KPiA+
ICBvYmotJChDT05GSUdfQ0xLX0lNWDhNTikgKz0gY2xrLWlteDhtbi5vDQo+ID4gIG9iai0kKENP
TkZJR19DTEtfSU1YOE1QKSArPSBjbGstaW14OG1wLm8NCj4gPiAgb2JqLSQoQ09ORklHX0NMS19J
TVg4TVEpICs9IGNsay1pbXg4bXEubw0KPiA+IC1vYmotJChDT05GSUdfQ0xLX0lNWDhRWFApICs9
IGNsay1pbXg4cXhwLm8gY2xrLWlteDhxeHAtbHBjZy5vDQo+ID4gKw0KPiA+ICtvYmotJChDT05G
SUdfTVhDX0NMS19TQ1UpICs9IGNsay1pbXgtc2N1Lm8gY2xrLWlteC1scGNnLXNjdS5vDQo+ID4g
K2Nsay1pbXgtc2N1LSQoQ09ORklHX0NMS19JTVg4UVhQKSArPSBjbGstc2N1Lm8gY2xrLWlteDhx
eHAubw0KPiA+ICtjbGstaW14LWxwY2ctc2N1LSQoQ09ORklHX0NMS19JTVg4UVhQKSArPSBjbGst
bHBjZy1zY3Uubw0KPiA+ICtjbGstaW14OHF4cC1scGNnLm8NCj4gPg0KPiA+ICBvYmotJChDT05G
SUdfQ0xLX0lNWDEpICAgKz0gY2xrLWlteDEubw0KPiA+ICBvYmotJChDT05GSUdfQ0xLX0lNWDIx
KSAgKz0gY2xrLWlteDIxLm8gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg4cXhwLWxwY2cuYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4cXhwLWxwY2cuYw0K
PiA+IGluZGV4IDA0YzhlZTMuLjViNjY0OGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4cXhwLWxwY2cuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14
OHF4cC1scGNnLmMNCj4gPiBAQCAtMjMxLDQgKzIzMSwxMiBAQCBzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlcg0KPiBpbXg4cXhwX2xwY2dfY2xrX2RyaXZlciA9IHsNCj4gPiAgICAgICAgIC5w
cm9iZSA9IGlteDhxeHBfbHBjZ19jbGtfcHJvYmUsICB9Ow0KPiA+DQo+ID4gLWJ1aWx0aW5fcGxh
dGZvcm1fZHJpdmVyKGlteDhxeHBfbHBjZ19jbGtfZHJpdmVyKTsNCj4gPiArc3RhdGljIGludCBf
X2luaXQgaW14OHF4cF9scGNnX2Nsa19pbml0KHZvaWQpDQo+IA0KPiBEb2VzIF9faW5pdCB3b3Jr
IGZvciBtb2R1bGU/DQoNCl9faW5pdCBpcyBOT1Qgd29ya2luZy9uZWNlc3NhcnkgZm9yIG1vZHVs
ZSwgYnV0IGlmIHRoZSBkcml2ZXIgaXMgYnVpbHQtaW4sIGl0IGlzIGJldHRlciB0bw0KaGF2ZSBp
dCwgY2hlY2tlZCBvdGhlciBkcml2ZXJzIHdoaWNoIHN1cHBvcnQgbW9kdWxlIGJ1aWxkLCB0aGV5
IGFsbCBoYXZlIGl0LCBzbyBJIHRoaW5rDQppdCBpcyBiZXR0ZXIgdG8ga2VlcCBpdCBlc3BlY2lh
bGx5IHdoZW4gdGhlIGRyaXZlciBzdXBwb3J0cyBib3RoIGJ1aWx0LWluIGFuZCBsb2FkYWJsZSBt
b2R1bGUuDQoNCmRyaXZlcnMvY2xrL3Fjb20vZ2NjLXNkbTg0NS5jDQpkcml2ZXJzL2Nsay9xY29t
L2djYy1tc204OTM5LmMNCg0KPiANCj4gPiArew0KPiA+ICsgICAgICAgcmV0dXJuIHBsYXRmb3Jt
X2RyaXZlcl9yZWdpc3RlcigmaW14OHF4cF9scGNnX2Nsa19kcml2ZXIpOw0KPiA+ICt9DQo+ID4g
K2RldmljZV9pbml0Y2FsbChpbXg4cXhwX2xwY2dfY2xrX2luaXQpOw0KPiANCj4gQW55IHJlYXNv
biB0byBjaGFuZ2UgdG8gZGV2aWNlX2luaXRjYWxsIHdoaWNoIGxvb2tzIGEgYml0IHN0cmFuZ2U/
DQo+IElzIGl0IGJlY2F1c2UgdGhlIGZvbGxvd2luZyBsaW5lPw0KPiArb2JqLSQoQ09ORklHX01Y
Q19DTEtfU0NVKSArPSBjbGstaW14LXNjdS5vIGNsay1pbXgtbHBjZy1zY3Uubw0KPiBCdXQgaXQg
bG9va3MgdG8gbWUgdGhleSdyZSBzdGlsbCB0d28gbW9kdWxlcy4gQXJlbid0IHRoZXk/DQoNCkl0
IGlzIHN1Z2dlc3RlZCBieSBBcm5kIHRvIE5PVCB1c2UgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIo
KSwgaW4gb3JkZXIgdG8gc3VwcG9ydCBtb2R1bGUNCnVubG9hZCwgYWx0aG91Z2ggdGhlIGNsb2Nr
IGRyaXZlciBub3JtYWxseSBkb2VzIE5PVCBzdXBwb3J0IHJlbW92ZSwgYnV0IGl0IGlzIGJldHRl
ciB0bw0KZm9sbG93IHRoZSByaWdodCB3YXkuDQoNClRoZSBjaGFuZ2UgaW4gTWFrZWZpbGUgaXMg
anVzdCB0byBsaW5rIHNjdS9scGNnIGxpYnJhcnkgdG8gaS5NWDhRWFAgY2xrIGRyaXZlciwgc28g
dGhhdCB3ZSBjYW4NCmdldCByaWQgb2YgZXhwb3J0cyBhbmQgYmVsb3cgMiAua28gYXJlIG5lZWRl
ZCBmb3IgYWxsIGkuTVggU29DcyB3aXRoIFNDVSBpbnNpZGUgYXMgcGVyIHlvdXINCnNheWluZyBv
ZiBpLk1YOFFYUCBjbG9jayBkcml2ZXIgY2FuIGJlIGV4dGVuZGVkIGZvciBmdXR1cmUgU29DcyB3
aXRoIFNDVS4NCg0KY2xrLWlteC1scGNnLXNjdS5rbw0KY2xrLWlteC1zY3Uua28gDQoNClRoYW5r
cywNCkFuc29uDQo=
