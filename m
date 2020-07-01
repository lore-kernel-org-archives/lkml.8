Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A5CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB852067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gOduLDtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgGAKVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:21:19 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:6187
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729180AbgGAKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS+btEjaixRKf/vJhMOr7cdxyxGhom1eb2SQKYVgoQbxrg9bsZjVHApP1NejOMebyR8aDAnCVOnB6BD6IATFdOe/Nud7hPq3ATnpfqGXh9KH9GRif1rslLyHzY2ivNnDMnv7lWCIJvdCFXj1CdlvicSYw3Krv+fEqqjsy89KIfD8whhZXziqUiRHYMgJicRhZbz+ts5Nkoex+CwXfKShbkGj0BNRCzv78ZwBTGqCL+Ln4wE/i9gNlC9zxJRyJdulFlFyl8jHxfIVDmqIqUknEkiVVurCHurQxt6kYfGsT7/K6PoTL/su8jDbONJizDO7hD9BLv3R5l80kGxcLZFnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZhiZMmGZnPjNDu6GRmyG9Q9YTBvsXVtFwdLcvNZBKc=;
 b=e1ByIydj8HfN9csjHz2/2LJgn7KnxtummB9rr6m9/1tlIX3Wt6BSKDdHigV5ihi2i0iRYOyJVGmgbQ24WrWiSbRiIcB4Lnd2PnCDX16ILVR6EjscR7K28BkGC5c+MgUe6Yd0Rw5WSrNqmCTe1C4w6b/K66QPBExFsApoZoRldnRn10wI9XNIMFK71YHsBDUwm5GqC2s4QZCOKEVL61FlOQn/78RL83aVsGwlyKE63pqFEYYnsoruqFdFtvrnqZ2O35znXw95Pne9J2PSBc1Y6GVDaZhCk3TgDxs4JlTh04AprwKCexhL9E5zAnYn4juAaxP3b4UDz/KWnIYhIN8xPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZhiZMmGZnPjNDu6GRmyG9Q9YTBvsXVtFwdLcvNZBKc=;
 b=gOduLDtzYVCFKlxeM+2cWPYbbSeALsiP4GgznmAS94MaZT/0Y2wlmnB3V283YqIcfzmT4hREbe+J6dRhasQscM8/dDOjM+aB+3mNcDSQvYRoR9n6w+5LSCojePIGjWOXX+SpN0AcMnyv2dcPicfIibLOw548xkVjNmHWW4Nab78=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB5081.eurprd04.prod.outlook.com (2603:10a6:10:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 10:20:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 10:20:30 +0000
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
Thread-Index: AQHWTdtegku2i+ERdU6EY9a3qfOcyajvdnIAgAABM5CAAAXKgIACsi5ggAA6hYCAAAwYQIAACPyAgAABohCAAAQLAIAAAI9g
Date:   Wed, 1 Jul 2020 10:20:30 +0000
Message-ID: <DB3PR0402MB39168BDB947322F9C159E42CF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
 <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
 <DB3PR0402MB3916F746C792CB2BC876715BF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1E_UecNq=7rvceQoXdFkmnBFOyUtxrpJ1bF6cLWOtNqQ@mail.gmail.com>
 <DB3PR0402MB39161C372E869A670D115FBBF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0YKsiKx66ESwvVmsubv=x=UB8JafisCY0Ct8VBMi-JhQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0YKsiKx66ESwvVmsubv=x=UB8JafisCY0Ct8VBMi-JhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.9.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9d200e0-3e1d-4cd4-7dfb-08d81da861d3
x-ms-traffictypediagnostic: DB7PR04MB5081:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB50811C52181F394C69E43AF6F56C0@DB7PR04MB5081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdzOHiKYVTR4Uk8+RBohb3um2u/cma/uvcPlHmx4/VnwzX/+C3xlLDpnrKRO9bisTchXmY1G+Kfgz7fwRIKVxQBK27mAvMGHKJKon8n2X6olNRPBMSQ6j7tsGCZ03m/iXKfaSv/2O0+Ylkaa3Ualvs7rLY0uba4vvAiHNLRUXmgG/pfKr/N2HAXuvOoUUQfDzQlVBDxZGDBCSTFU6DaeifZay9D2MnA588EyRqbJk2S1Ab9SBRpoe/4d/LO3LmpjlBVL4wblkgyyIhsL0dkMi78dDy3gi0HuJgmlM428hw43DtJwzEVzSga9C2DgRurE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(66446008)(66556008)(66476007)(66946007)(64756008)(76116006)(8676002)(44832011)(8936002)(26005)(478600001)(186003)(6916009)(86362001)(7696005)(52536014)(55016002)(9686003)(4326008)(71200400001)(6506007)(53546011)(5660300002)(7416002)(33656002)(316002)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KUVmfGtvwCmyUbGH+XlZZNTtHQtYsLWXeh6dygz5jX8gOvusIy3NPQlEHdkhzpDDDOqbOdhlEQ7Osx9QYTli+qWaKK8QV+EMD2UDsn/0Jy28K7MuxteGuy6CEHur+AlLpP4b/wI1bHYAb0H/9yXeGuisxHlAM8/LQoHD7+O3q7yE1mrDY8Pg/AG3HjogCx21xtzrUR1Cl6VRM+fxg9IR2963jW2FTGNhc1YWlEPB+y59vTvxrc51sG8X5RR8oSUGPMIbVqaKycUfThWMYA8UATPwtGUI+Rtu0zkdAVyEP6tGx3weXBrVPU+b87lFT65pAroTMR0T7Wl1ZwnCORJGVSddAT9bmQQSwQHKpEJSt83MB77cr8fpGHEFrGtZ7kePYGyp6TT3eBDac4XisjT7iMJkObKL/HhJwiI9jPH7WZnxShu2meqAGUIwT253edFI+mlazV94QhEITCi/NCKmkcy/mhBPktNAJyZJRiS4BIcSbYs3Q5BXUsBXAQmoDpU6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d200e0-3e1d-4cd4-7dfb-08d81da861d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 10:20:30.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8XSS1j8FwjyCwtILthxN3q6Y6gTYmDN+5ZIKlOUw/Gax4L7vV1ZtPM/Hzcg5Aesh9w6K5nxCWzfhSepc2bC3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDIvMTBdIGluaXQuaDogRml4
IHRoZSBfX3NldHVwX3BhcmFtKCkgbWFjcm8gZm9yDQo+IG1vZHVsZSBidWlsZA0KPiANCj4gT24g
V2VkLCBKdWwgMSwgMjAyMCBhdCAxMjowMiBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAyLzEwXSBpbml0
Lmg6IEZpeCB0aGUgX19zZXR1cF9wYXJhbSgpIG1hY3JvDQo+ID4gPiBmb3IgbW9kdWxlIGJ1aWxk
IE9uIFdlZCwgSnVsIDEsIDIwMjAgYXQgMTE6MjcgQU0gQW5zb24gSHVhbmcNCj4gPiA+IDxhbnNv
bi5odWFuZ0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCBWMyAwMi8xMF0gaW5pdC5oOiBGaXggdGhlIF9fc2V0dXBfcGFyYW0oKQ0KPiA+ID4gPiA+
IG1hY3JvIGZvciBtb2R1bGUgYnVpbGQNCj4gPiA+IFdoeSBub3QgbW92ZSB0aGlzIGFsbCB0byBh
IHNlcGFyYXRlIGZpbGUgdGhlbiBhbmQgb25seSBidWlsZCBpdCB3aGVuDQo+ID4gPiBDT05GSUdf
Q0xLX0lNWD15Pw0KPiA+ID4gSXQgc2VlbXMgdGhhdCB5b3UgZG9uJ3QgbmVlZCB0aGUgaW14X2tl
ZXBfdWFydF9jbG9ja3NfcGFyYW0oKSBpZiB0aGUNCj4gPiA+IGNsayBkcml2ZXIgaXMgbG9hZGVk
IGFzIGEgbW9kdWxlLCBidXQgdGhlbiB5b3UgYWxzbyBkb24ndCBuZWVkIHRoZQ0KPiA+ID4gaW14
X2Nsa19kaXNhYmxlX3VhcnQoKSBhbmQgaW14X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKCkgZnVuY3Rp
b25zIG9yDQo+ID4gPiB0aGUgYXNzb2NpYXRlZCB2YXJpYWJsZXMuDQo+ID4NCj4gPiBJZiBzbywg
aG93IGFib3V0IGp1c3QgYWRkaW5nICIjaWZuZGVmIE1PRFVMRSIgY2hlY2sgZm9yIHRoaXMgcGFy
dCBvZg0KPiA+IGNvZGU/IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGVhc2llci9iZXR0ZXIgdGhhbiBh
ZGRpbmcgYSBmaWxlIGFuZCBidWlsZCBpdA0KPiBjb25kaXRpb25hbGx5Pw0KPiANCj4gVGhlICNp
ZmRlZiBpcyBjbGVhcmx5IGEgc2ltcGxlciBjaGFuZ2UsICBidXQgSSB0aGluayBhIHNlcGFyYXRl
IGZpbGUgaXMgYSBjbGVhbmVyDQo+IHdheSB0byBkbyBpdC4gVXAgdG8geW91ICh1bmxlc3Mgb25l
IG9mIHRoZSBpbXggb3IgY2xrIG1haW50YWluZXJzIGhhcyBhDQo+IHByZWZlcmVuY2UgLS0gSSdt
IG9ubHkgaGVscGluZyBvdXQgaGVyZSwgbm90IG1ha2luZyBkZWNpc2lvbnMpLg0KPiANCg0KT0ss
IHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggaW50cm9kdWNlZCB0d28gX19zZXR1cF9w
YXJhbSgpIGltcGxlbWVudGF0aW9uDQpmb3IgYnVpbHQtaW4gYW5kIGxvYWRhYmxlIG1vZHVsZSwg
dGhhdCBsZWFkcyB0byBhbGwgdGhlIGRpc2N1c3Npb24gb2YgZml4aW5nIF9fc2V0dXBfcGFyYW0o
KQ0KaW4gaW5pdC5oIGV0Yy4sIGJ1dCB5b3UganVzdCByZW1pbmQgbWUgdGhhdCBfX3NldHVwX3Bh
cmFtKCkgaXMgTk9UIG5lY2Vzc2FyeSBhdCBhbGwgd2hlbg0KYnVpbGRpbmcgbG9hZGFibGUgbW9k
dWxlLCBzbyBJIHRoaW5rIGp1c3QgYWRkICcjaWZuZGVmIE1PRFVMRScgc2hvdWxkIGJlIGFjY2Vw
dGFibGUsIEkgd2lsbA0KZ28gd2l0aCB0aGlzIGNoYW5nZSBpbiBWNCBwYXRjaCBzZXJpZXMsIGFu
ZCBzZWUgaWYgYW55b25lIGhhcyBjb21tZW50Lg0KDQpQbGVhc2UgaGVscCByZXZpZXcgVjQgcGF0
Y2ggc2VyaWVzIHdoaWNoIHdpbGwgYmUgc2VudCBvdXQgc29vbi4NCg0KVGhhbmtzLA0KQW5zb24N
Cg0K
