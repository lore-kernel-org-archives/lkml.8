Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1342073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UM9p1b5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgGAKC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:02:28 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:30741
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbgGAKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKOpPy5UJ/oF/e7PW8bHi1/COX+MCPfTCiBm3Gep1+pyvyYXwvmdy7w/Ee7CyjxOsNeqnzjd6qzZ4WotKurWstGhUNU8wRCKasxkolWbH61rTc9C0BJYSGLkvuva9LouAvLOL7wxlvhdEhWEPRvH56rOf8LbFlOmi/rOTk4Pzw5qL303wh7zaGWZ3sbcChQkTQkwE6sgOhtBFZmA5Znsen6IDtbOn5xwXEDJIKyWLtbynulGkQdGmw2LZC8IQrYSAnw65MstztCDhb3BVjS2bhEkpq8e7pNjU591HG6RAdwTENK9GebnaAlbAnmkSha4U8VWHxiqJyL4qJ6SUcA/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAYEBwb6QuU3aRZt8KB2oVjP5kG094mDQ2aliGjFsII=;
 b=M8Z7uGj7td+wJG8vEFdrnVYjQieQbU8BEt8gN/pw7t9XGng+wceM9zlVikp8y0nx4z/Gd45q5EhFBR/hjj/UuJkq/OcYe6yx4tcmmP4amJS5drJZVRwN1qSrwFqtv48vAdfDqSFe1xDur0Z0p0RV1V75KNCMW1/NN5ZoOqhYr/Et4Ntj0HxSmVjcmvbo/WreWzwq6kcYaT4soj2DAy4wrcsWN/TelcU7wjh8keXKgz8gsChwf4aEXHqtMFUUf+xsUgktnilIMfbQG50asdUhoHlXqmkuPvNGCvoKewbnNHG+RNOhu6DdmGsj+sNOank3wYbTSJToVwV3e3EovA8htw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAYEBwb6QuU3aRZt8KB2oVjP5kG094mDQ2aliGjFsII=;
 b=UM9p1b5vN3Uc6z76J3D3pmML2R+Mhu99n1Zjlom1BDiTh9o3oaN0NOw3l6GsXnZ9CE4PxvPb8erHMyPP0LQDUMEdV71RVjoOD1a3/JNh7bY6sBk0BAfg46iwI5txp7Nn3UadY2Reaiji2JbYSflII1OPrqeh9ixb3bV+zvFcOZQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4235.eurprd04.prod.outlook.com (2603:10a6:5:22::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 10:02:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 10:02:21 +0000
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
Thread-Index: AQHWTdtegku2i+ERdU6EY9a3qfOcyajvdnIAgAABM5CAAAXKgIACsi5ggAA6hYCAAAwYQIAACPyAgAABohA=
Date:   Wed, 1 Jul 2020 10:02:21 +0000
Message-ID: <DB3PR0402MB39161C372E869A670D115FBBF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
 <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
 <DB3PR0402MB3916F746C792CB2BC876715BF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1E_UecNq=7rvceQoXdFkmnBFOyUtxrpJ1bF6cLWOtNqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1E_UecNq=7rvceQoXdFkmnBFOyUtxrpJ1bF6cLWOtNqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.9.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19eeb90e-2ab4-412a-d28c-08d81da5d8c5
x-ms-traffictypediagnostic: DB7PR04MB4235:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB42354C9EF80F1E81D408CA4DF56C0@DB7PR04MB4235.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otB4blCvyoSYJ24r+HOq9tLviyTDSlMOsuXNtmVpO0sDl0nCOiCtSweXmqhHf9cniaxNxmD5in8a2+3sufSfRPO4Txp/TnNw43FNSpLZ5r1Nfo6jiyMpxMrMnhBkuOui+1geWeSsHdpiS0Zg/OltbBoui1EvEJBHKbjGguEA3vKEZLJL1LuFYu4x3R2vAufGwdwvQgvxhvIbc1gI0wZ5XATQf9olem9BK7GGBNXh3mf1MLt2pYnA7sx83YOiGxXiSorGLqFrHVGOJ+ybJcb9zyPodolGurmEnTwIXUtq2fjVebmFnktn7pL90kJgrDjWwHqmYpUu4T/+uNeBsO+T0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(7696005)(26005)(54906003)(44832011)(52536014)(4326008)(86362001)(7416002)(6506007)(71200400001)(186003)(83380400001)(2906002)(66446008)(66556008)(64756008)(66476007)(8936002)(5660300002)(6916009)(53546011)(55016002)(33656002)(478600001)(76116006)(316002)(9686003)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: l7RgJSnUOR313+/z48r/0/OvxyG6+ty/tcxsETawWTpbh+0vETW8FXAo/7R0CvvZPSIvQ4VWcputfcXhMF9x/Ue2d4EARk9vMrBXV2QOyL2tZLylc9qllOJFfN8wOTgV0jb2NHC0kSXziT2YFaYDC2td5vNreGDHwhG8JqtWTShAwGJc2ZzJESnb6V/TrsXO7rU14ZyI03309eFFjSrkV3EP5yo4I/aU9yHxJ66pN35tn9QQjJOtNe6NoorZaPUW5TCNun/oUNUJUkf0DB3gHQUWYwDeCHTwCgpS3nGJ7ilmoZPJaNbhU2MJSylBQmAJnHZpjAKwkwxQVXh2G2JrbqsaUPZ8dC1z5+vescJKTbyzog36HkNktNi+KnfhnJluJbqDbqw0C5hjw97R2YRWlF+xYahHVmpNTNJmAEmpnLgnJPcRCLpZLLC0rEddWUM+PO1/7yL059kGJmLxGs6j+ta7gj/JWs6zrpnYqyCG+u4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eeb90e-2ab4-412a-d28c-08d81da5d8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 10:02:21.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+4t3LF66TE1l0OPF2sucS2YcYioF/S/SnctWQbbIT0IRdCj2aEl4g7GY4ukdev0Cpilq+Vkpkt9cNLYKwmDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDIvMTBdIGluaXQuaDogRml4
IHRoZSBfX3NldHVwX3BhcmFtKCkgbWFjcm8gZm9yDQo+IG1vZHVsZSBidWlsZA0KPiANCj4gT24g
V2VkLCBKdWwgMSwgMjAyMCBhdCAxMToyNyBBTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAyLzEwXSBpbml0
Lmg6IEZpeCB0aGUgX19zZXR1cF9wYXJhbSgpIG1hY3JvDQo+ID4gPiBmb3IgbW9kdWxlIGJ1aWxk
DQo+ID4gPg0KPiA+ID4gT24gV2VkLCBKdWwgMSwgMjAyMCBhdCA3OjE0IEFNIEFuc29uIEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSSBkb24n
dCB1bmRlcnN0YW5kIHdoYXQgeW91ciBwbGFuIGlzIGhlcmUuIERvIHlvdSBtZWFuIHlvdSB3aWxs
DQo+ID4gPiBsZWF2ZSB0aGF0IHBhcnQgb2YgdGhlIGNsayBkcml2ZXIgYXMgYnVpbHQtaW4/DQo+
ID4NCj4gPiBJIG1lYW50IEkgd2lsbCBsZWF2ZSB0aGUgI2Vsc2UgYmxvY2sgb2YgX19zZXR1cF9w
YXJhbSgpIGRlZmluZWQgYXMNCj4gPiBub3RoaW5nIGFzIGJlbG93IHRvIG1ha2UgbW9kdWxlIGJ1
aWxkIHBhc3NlZC4NCj4gPg0KPiA+ICNkZWZpbmUgX19zZXR1cF9wYXJhbShzdHIsIHVuaXF1ZV9p
ZCwgZm4sIGVhcmx5KSAgICAgICAgLyogbm90aGluZyAqLw0KPiANCj4gTm8sIEkgdGhpbmsgdGhh
dCBpcyAgbWlzdGFrZS4gSXQgd2lsbCBtZWFuIHRoYXQgb3RoZXIgZHJpdmVycyB3aXRoIHRoZSBz
YW1lIGJ1Zw0KPiBhcyB0aGUgaW14LWNsayBkcml2ZXIgd2lsbCBhcHBlYXIgdG8gYnVpbGQgZmlu
ZSwgYnV0IG5vdCB3b3JrIGNvcnJlY3RseS4NCj4gDQo+IEEgYnVpbGQgZXJyb3IgaXMgYmV0dGVy
IHRoYW4gc2lsZW50bHkgZHJvcHBpbmcgdGhlIGNvbW1hbmQgbGluZSBwYXJzaW5nIGluIG15DQo+
IG9waW5pb24uDQo+IA0KPiA+ID4gVGhpcyBlcnJvciBqdXN0IG1lYW5zIHlvdSBjYW4ndCBoYXZl
IGEgX19zZXR1cF9wYXJhbSgpIGNhbGwgaW4gYQ0KPiA+ID4gbG9hZGFibGUgbW9kdWxlLCB3aGlj
aCB3ZSBhbHJlYWR5IGtuZXcuIElmIHlvdSBuZWVkIHRvIGRvIHNvbWV0aGluZw0KPiA+ID4gd2l0
aCB0aGUgY2xvY2tzIGVhcmx5IG9uLCB0aGF0IGhhcyB0byBiZSBpbiBidWlsdC1pbiBjb2RlIGFu
ZCBjYW5ub3QNCj4gPiA+IGJlIGluIGEgbW9kdWxlLiBJZiB5b3UgZG9uJ3QgbmVlZCB0aGF0IGNv
ZGUsIHRoZW4geW91IHNob3VsZCBqdXN0DQo+ID4gPiByZW1vdmUgaXQgZnJvbSBib3RoIHRoZSBt
b2R1bGFyIHZlcnNpb24gYW5kIHRoZSBidWlsdC1pbiB2ZXJzaW9uLg0KPiA+ID4NCj4gPiA+IFdo
YXQgaXMgdGhlIHB1cnBvc2Ugb2YgdGhhdCBfX3NldHVwX3BhcmFtKCkgYXJndW1lbnQgcGFyc2lu
ZyBpbiB0aGUNCj4gPiA+IGNsb2NrIGRyaXZlcj8NCj4gPg0KPiA+IFdlIG5lZWQgdGhlIGNvZGUg
Zm9yIHByb3BlciB1YXJ0IGNsb2NrIG1hbmFnZW1lbnQgb2YgZWFybHljb24sIGZyb20NCj4gPiB0
aGUgY29kZSwgaXQgaXMgdHJ5aW5nIHRvIGtlZXAgY29uc29sZSB1YXJ0IGNsb2NrIGVuYWJsZWQg
ZHVyaW5nIGtlcm5lbCBib290DQo+IHVwLg0KPiANCj4gV2h5IG5vdCBtb3ZlIHRoaXMgYWxsIHRv
IGEgc2VwYXJhdGUgZmlsZSB0aGVuIGFuZCBvbmx5IGJ1aWxkIGl0IHdoZW4NCj4gQ09ORklHX0NM
S19JTVg9eT8NCj4gSXQgc2VlbXMgdGhhdCB5b3UgZG9uJ3QgbmVlZCB0aGUgaW14X2tlZXBfdWFy
dF9jbG9ja3NfcGFyYW0oKSBpZiB0aGUgY2xrDQo+IGRyaXZlciBpcyBsb2FkZWQgYXMgYSBtb2R1
bGUsIGJ1dCB0aGVuIHlvdSBhbHNvIGRvbid0IG5lZWQgdGhlDQo+IGlteF9jbGtfZGlzYWJsZV91
YXJ0KCkgYW5kIGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2NrcygpIGZ1bmN0aW9ucyBvciB0aGUNCj4g
YXNzb2NpYXRlZCB2YXJpYWJsZXMuDQoNCklmIHNvLCBob3cgYWJvdXQganVzdCBhZGRpbmcgIiNp
Zm5kZWYgTU9EVUxFIiBjaGVjayBmb3IgdGhpcyBwYXJ0IG9mIGNvZGU/IEkgdGhpbmsNCml0IHNo
b3VsZCBiZSBlYXNpZXIvYmV0dGVyIHRoYW4gYWRkaW5nIGEgZmlsZSBhbmQgYnVpbGQgaXQgY29u
ZGl0aW9uYWxseT8NCg0KVGhhbmtzLA0KQW5zb24NCg==
