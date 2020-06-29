Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1621920672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZbRny+f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbgF2Ui5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbgF2TOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2669C00694F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6hWwiIf8oaZkp6cWVwhFzYJaj6PX5qB5FwEFNCWxJa48mEFF6yu+It6TMcm9YZbM8Sj072+dqb4kObl29Yj/80ExnUGNWsDwTXc+ZXw3SdYdhFSIjr9TOSqlG6vnaCpfNwSa7yEvS2xCTGomJeerwZN6+whPNpSM0NDCm6FkaPXL1+IN/Fh0P85O8XMkI7RDiG2/P3F0OW0Ngq7+/9QwxeudKSz0qaw1+YC1/GHUeUhTqeZla6bp6UW8LPrgIx60FSVrnTBdERnFvcJapS8Ysv1nBmffIe0IzRin9thEDiacLEETPqVt8goMeGp3LNMrqYkbIlnOOHg8RsvCVa7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY+GlastTh0avxjva5u8aOkwPXcP1IhMtQClAVKo6ME=;
 b=aKjMd9U90kKPY1EIKfSackfW2sSiffG/EEq1uKC32zI6Yjk1LBE2am2X/r36xUjGucM1KGT8bLnda//4WrMCRF4qsZmC6c6e7RTQX5Ff7Hm+pIDpNpfPVW25Rz9KoPnHo7y2w+DXU2wZzhr1bmuMVepw52IkAFGsmf43tTHnPAjGWY7h5jbw4D95Vnhz1+g6jAPeFjPUN25u37uLOVC03hQSn2rHjZMwmip18dHcxF6GElWtk/mtmZPwn6RHmkWQUJAgNQfGkbDJ/GD/Z25KB3G4w4wBrFK6piGrqg2mc+ly6Dufx+mVXrFTaCF7LV16lFblj0RxDteewPOpXHnHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY+GlastTh0avxjva5u8aOkwPXcP1IhMtQClAVKo6ME=;
 b=ZbRny+f9wZwYVWwLDnbh/Dtj+R6inETvLNOC+1JKMIRCKhU32QYTixMm00HW385SCTejNlmY+pIgPnab5vLKheG3evIrwC4in8f9VPwCb/aQRJc4Ufkl1S+5Cq2ywg8mEikwx5KA83IzCx1T1DtpZe3q71lX5mijBD0SJpuH+RA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR04MB3014.eurprd04.prod.outlook.com (2603:10a6:6:8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Mon, 29 Jun 2020 11:34:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:34:49 +0000
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
Subject: RE: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
Thread-Topic: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by
 default
Thread-Index: AQHWTf+gaUMc2TSOQkGGQmWO3bqF1KjvdP0AgAAA96A=
Date:   Mon, 29 Jun 2020 11:34:49 +0000
Message-ID: <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
In-Reply-To: <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43e58e1a-0089-4432-3836-08d81c206ec9
x-ms-traffictypediagnostic: DB6PR04MB3014:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB301455B3CCA216C18224A031F56E0@DB6PR04MB3014.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0KINj3NqIDGyyHb2KJg8YoiPuNO3XsEZ+d0yhO4SPi8zgZFl7TmC63VxoWUYgbdFirn3EJWBQCteTQcgbzw4Z7zi6c9BQ8iw7Xw6Dy6tvXG455+nPoEj2OBsjEbWlEXe7djkgkJX6cq51957Hyq3Dqg9XhctcDQZp2PURA3mvEdEhX3X4bbyrLAQuX4uk2Ts8SrCltueH7BD6tWBn/RqqpQjjNTXa/kNJ134YazaY6nDfZasZHqgNldSNuxZedCiMajZSOj7VcPb3PhYHMu4bKjbs1H5bbfrL84F4fa53MzuOTXDknkL1htL67UItVMdjMVXHFbc3qId/JHnsF5Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(316002)(6506007)(8936002)(6916009)(54906003)(26005)(5660300002)(71200400001)(186003)(53546011)(66446008)(76116006)(66946007)(7696005)(66556008)(64756008)(4326008)(66476007)(4744005)(44832011)(7416002)(9686003)(8676002)(55016002)(2906002)(52536014)(86362001)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: k9/rlRzRV7UWwF7IfdlEzB39zi358L/ql9UXmsU7ZBkOnMwfYixJqzBn2BVOlSMtCDp0N/0Q4nJLSS9+dWdWIo4Lm/Iu3JrIo06ANS5Rtp0Dj2Pw4EjQSiiA9rnTb2tVeZH3eDpZEFul2gQmDc8Aq+upliF2Vujz+MDONwpMWRD0lf7rHfA677+FE6ZR+YtLW7r5t0uMt7n+L2ZHBXaeH7yQUFaKeXvimybHQiFf08i5uMoF02BF+6+0yamRzVJsHfua0IzV/hroFzU0wfjwzU3pOpH4C42HicU/sgbbr8H5Y4vxPnRatkIfxedmawhezfIeVZtMusdDcfLz0xQ3/grD9WQ8c3WgtE8fwudisiM4exgEZmhwzpHHJCWvy8SL4rc6N/PCEU7RutZ4jsbqj+84msnIZ0a5gns6IgwcjwqS74VuJJ4uBwVmkBQ4r0UPjQxINiW+SofQHngPWpYJR7kicXllf5RgYADpY5AIUKge5hjDDmWK1unK5RnDBIp1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e58e1a-0089-4432-3836-08d81c206ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:34:49.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BElC3bApHtFOhbBVsL+TCjyOcpohxaab1bPB/4r71gM+wI7SPwIueTES3oV5yScrH8Gs+5OBsuvrDDdKSyA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBhcm02NDogZGVmY29uZmln
OiBTZWxlY3QgQ09ORklHX1JFU0VUX0lNWDcgYnkNCj4gZGVmYXVsdA0KPiANCj4gT24gTW9uLCBK
dW4gMjksIDIwMjAgYXQgMTI6MjUgUE0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4gaS5NWDcgcmVzZXQgZHJpdmVyIG5vdyBzdXBwb3J0cyBtb2R1
bGUgYnVpbGQsIGl0IGlzIG5vIGxvbmdlciBidWlsdCBpbg0KPiA+IGJ5IGRlZmF1bHQsIG5lZWQg
dG8gc2VsZWN0IGl0IGV4cGxpY2l0bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFdoeSBub3QgbWFrZSBpdCA9bSBub3cg
dGhhdCB0aGlzIGlzIHBvc3NpYmxlPw0KPiANCg0KSXQgaXMgYmVjYXVzZSBzb21lIGRyaXZlcnMg
ZGVwZW5kcyBvbiB0aGlzIHJlc2V0IGRyaXZlciB0byB3b3JrLCBzdWNoIGFzIFBDSWUsDQpJZiBi
eSBkZWZhdWx0IG1ha2UgaXQgPW0sIGl0IG1heSBpbXBhY3QgUENJZSdzIGZ1bmN0aW9uLCBhZGRp
bmcgbW9kdWxlIHN1cHBvcnQNCmF0IHRoaXMgcG9pbnQgaXMgdHJ5IHRvIHByb3ZpZGUgZnVuY3Rp
b24gb2YgbG9hZGFibGUgbW9kdWxlIGZvciBBbmRyb2lkLCBidXQgZG9uJ3QNCndhbnQgdG8gaW1w
YWN0IGFueSBmdW5jdGlvbiB3aGljaCBpcyB3b3JraW5nIHByZXZpb3VzbHkuDQoNClRoYW5rcw0K
QW5zb24uDQo=
