Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F42C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AEB2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TW86lvYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgF2Tdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733041AbgF2Tco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4916C02A54D;
        Mon, 29 Jun 2020 05:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbGw3L6f2IEVciqUp1JA9mUYlU4JdqAsvpyw1wr/uKNbFIbFpfPihX//dhRbJBvBP1AetFo/TdE0PZakNIXmZeXMFOCbqgDNprVm2l8VenKhuWl+reeC+KHkv77PDE1S1alhN4cEA4SGrVoaylyeCB20BJ98Y+LaN1wrMt5uwKrECM9A3fr6Ca3Gbtl/prWJ9AcOXXNPuCiseB8HVFtXygCn4MGRQaqO5046RDcle09+h5LsZV7ANzrCyaJ9ebRfcviLqerXYhsHZOqjoFuYsv+ZjaV8nA+pox7BpGLG/mbPkuPHEW1PqXS99eew14lrcUlvekcSqlktvCBP9oH5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FenkoROEbHRY3aE6sp3auOTBMcL/M+br6d2U3hoNmng=;
 b=BezhFLVi8estec8PHrF4ne70yUtfpcaRSGNAsmQ9Ndyud8ruACf/s3Cdpkcv+A1g35XR4c0vMpEwDKYGE+rOM6kkR0q0R7ne83y1wm+ysI8UKUW4PHsdgepV9l5SKnxaRV3KCFmYewIWzgCxkx0pja4VKZmcx0+eoonQPXJI47BxYa3FKFmB9vCLNP1ced5LqHumyy8D9fTHTsnOg/So7gwIbEvgJ10xiwCEhR3iKJbAdJOSJRBGtTclxz4HL/PHap7EPuPE/09zPDQUEF2tVav8I+vorg8zoAsNhgNaO/9uHSKeMCCrZdC2JvO/R5yaEEg7NHvBHeNTUmqeaeSyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FenkoROEbHRY3aE6sp3auOTBMcL/M+br6d2U3hoNmng=;
 b=TW86lvYY5ub4rmBeXB9+/4Fy/PQWrjY2RM8BFo6CTQrwdtrXihO/4TO1mD5VmDL0GJNB9W39wd+v14gcSAenUMgbaR+5geQaGcTUEvtED8vYmBfUbJBUc4GYAL9LgsCrB2u66f6LA3nIfCVOir8ItRPub1U/CynmIZfx3GlNUF8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 12:53:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 12:53:55 +0000
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
Subject: RE: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWTdthV6wfzmMopU6pSRFnxqvg3qjvd4YAgAACQ6A=
Date:   Mon, 29 Jun 2020 12:53:55 +0000
Message-ID: <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
In-Reply-To: <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a901e89-848f-474f-4de9-08d81c2b7baf
x-ms-traffictypediagnostic: DB8PR04MB6714:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6714B895124840372160F765F56E0@DB8PR04MB6714.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7Nue2MPhERyXR0RzLNukfh7rbUNvW5omvRmfikj0EkYFn7McvM+Iv0VzC8r4PuvZw4hVu/Q3gVXooOWuY9PL627qjiGIZ0OiBH62F775MuDGZfrF25MVbPN0vtCQ0jZxmT6EyJIyYfTtvYJr3Zf0itfVtwovmhghiK+RnskiPDgnrvCmEx1Gah+5xLWknhTPLiITJ68CdXzO/pvP87XGThOKkfPBp6CtWGFyjs7BP6N1B6D3dZnwbwNfKjKYXmDsTeagUohTy3urb5xuSptsnfX4LMobrYY/OjYnv8kX1shs27rMv2xGA4tWXR9zwxI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(2906002)(478600001)(71200400001)(26005)(7696005)(8936002)(55016002)(5660300002)(66946007)(76116006)(54906003)(33656002)(66476007)(66556008)(64756008)(6506007)(53546011)(6916009)(66446008)(86362001)(316002)(44832011)(186003)(8676002)(83380400001)(52536014)(9686003)(7416002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: otFc+r68Dyhj7/WXcyA2NSiozR4ERlHPKrUJYgGCuw1fIc5jQ4PiQMdQ2O71J2H0U/mVItYux3fOOW5zqduCmwr4xCudxgJp8hEs/Au6Q1ldOMt8R++QZfJLLuB4amTW3zJqpwD9Xv3t7oKGxaxCJr47skpYCIKDHnYGWmQOQiQAoEgHjulgxv6tnOt8p6SOHkE4JszHVT0JRnUMjmV+I60mEUh1NbATnSbp5jXBDOoi2CAoOFWeI9YLUFJwGLuD5sjjFTdi7J7BwFOLriI941i+FAEr0lKhUOY4eOP3dY2zxMg6ehTmmTsztmUGNZUYYlNiccNemEtzH4/75jbHT6Wsd+mu7mTn/QjMSOs0pGmTjlluvlzJn3XoYmgZeD5duNZor81Tm7q/eH5B4O8yobzGWzTpvyBEfyiEs/jx1RyWEmxScU2Cm5MGkdV7I5gxQxRSbiu7w4CUb1HoARsVr91wWPwl2vfx1qVIIWdLhuODXwX/dYYO8gr6ls66OSI9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a901e89-848f-474f-4de9-08d81c2b7baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:53:55.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rC8IwZyATslaYFMkfL0/5ovb7rFmbX4TYYv2qsr38ZF1L3YCn6vl22TG1ZgtnRUSoj+lUgtlnkfFbjHa7LFEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGNsazogaW14OiBT
dXBwb3J0IGJ1aWxkaW5nIFNDVSBjbG9jayBkcml2ZXIgYXMNCj4gbW9kdWxlDQo+IA0KPiBPbiBN
b24sIEp1biAyOSwgMjAyMCBhdCA4OjA2IEFNIEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiB3cm90ZToNCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlDQo+
ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlDQo+ID4gQEAgLTIxLDkgKzIxLDkgQEAg
b2JqLSQoQ09ORklHX01YQ19DTEspICs9IFwNCj4gPiAgICAgICAgIGNsay1zc2NnLXBsbC5vIFwN
Cj4gPiAgICAgICAgIGNsay1wbGwxNHh4Lm8NCj4gPg0KPiA+IC1vYmotJChDT05GSUdfTVhDX0NM
S19TQ1UpICs9IFwNCj4gPiAtICAgICAgIGNsay1zY3UubyBcDQo+ID4gLSAgICAgICBjbGstbHBj
Zy1zY3Uubw0KPiA+ICtteGMtY2xrLXNjdS1vYmpzICs9IGNsay1scGNnLXNjdS5vDQo+ID4gK214
Yy1jbGstc2N1LW9ianMgKz0gY2xrLXNjdS5vDQo+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1ND
VSkgKz0gbXhjLWNsay1zY3Uubw0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgdHdvIG1vZHVsZXMg
YXJlIHRpZ2h0bHkgY29ubmVjdGVkLCBvbmUgaXMgdXNlbGVzcyB3aXRob3V0IHRoZQ0KPiBvdGhl
ci4gSG93IGFib3V0IGxpbmtpbmcgdGhlbSBpbnRvIGEgY29tYmluZWQgbW9kdWxlIGFuZCBkcm9w
cGluZyB0aGUNCj4gZXhwb3J0IHN0YXRlbWVudD8NCj4gDQoNCkZyb20gSFcgcGVyc3BlY3RpdmUs
IHRoZSBTQ1UgY2xvY2sgZHJpdmVyIGFuZCBMUENHIFNDVSBjbG9jayBkcml2ZXIgYXJlIGRpZmZl
cmVudCwNClNDVSBjbG9jayBkcml2ZXIgaXMgZm9yIHRob3NlIGNsb2NrcyBjb250cm9sbGVkIGJ5
IHN5c3RlbSBjb250cm9sbGVyIChNNCB3aGljaCBydW5zIGEgZmlybXdhcmUpLA0Kd2hpbGUgTFBD
RyBTQ1UgY2xvY2sgaXMgZm9yIHRob3NlIGNsb2NrIGdhdGVzIGluc2lkZSBtb2R1bGUsIHdoaWNo
IG1lYW5zIEFQIGNvcmUgY2FuDQpjb250cm9sIGl0IGRpcmVjdGx5IHZpYSByZWdpc3RlciBhY2Nl
c3MsIG5vIG5lZWQgdG8gdmlhIFNDVSBBUEkuDQoNClNvLCBJIHRoaW5rIGl0IGlzIE5PVCB0aGF0
IHRpZ2h0bHkgY29ubmVjdGVkLCBpdCBpcyBiZWNhdXNlIHRoZXkgYXJlIGJvdGggZm9yIGkuTVg4
IFNvQ3Mgd2l0aCBTQ1UNCmluc2lkZSwgc28gdGhleSBhcmUgcHV0IHRvZ2V0aGVyIGluIHRoZSBN
YWtlZmlsZS4NCg0KSWYgdGhlIGV4cG9ydCBzdGF0ZW1lbnQgaXMgYWNjZXB0YWJsZSwgSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8ganVzdCBrZWVwIGl0LCBtYWtlIHNlbnNlPw0KDQpUaGFua3MsDQpB
bnNvbg0KDQo=
