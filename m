Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039EB20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c7ketuur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgF3EmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:42:00 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:3960
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbgF3El5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMVFdclTQleR1kg6aHJ4fgJZMqgROANjESH8uv/GdnldTYmmC7/DCOQNlubihfJG6TKOs3U2negJW8H74usTl8FOqwbyUZHkPcADrS5+NIx39wjSqTfaDISu7dEgVembc+Nf/f8ndOYCwbusod7P8zbne5wdZfBCJDRfOLKQaeDjuvJVeptinYgdH0jRWxWOHTBmxE3lAOUIzXNwNvnQjtvYITv59KS6URCCP5bWYsIcqRFuz3kZEXEAGal6RkbBT0TraQJraDL+fW82kmSXfp9FTe1dyze9CdWTtdCYqOA84YG7WTEvhoFdC07DbhYL+sRWNilk//PRF8nmwHvLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y29olgrpaVeQolcmtCY3EZkwL794q/auP+OzZuZ2HY=;
 b=Jgn8erqZHP78c8Xwg7MBwKeE+io4sMGe5SIQS9zzItV6w+ZExzev7KFOPZdmxyUwB3pjGUC8q3ND2zYzVr0ryg/1e8vwzTghFmrisUDsF1dUL548kDyVM6PX6I2DsxA1F333dXk+O56ljbmHq4pqcvmesKEe82FJKosFvGJCwRRmWLC+J+B8ZKxBpoALX5JXYqNbm/UL7eZu3oxTGa83pAQa/JjmHGaERB4qmRWNeVrA79FraQfGeyGKlaLvFNo3hoUKyDGlD8tVwgA+Y4Vg0U5vkmkMorKunHCKFJ7mOOKbYPNeGPdU3CnRJCvRYD2A084M0V9c07t2ggVEf8JfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y29olgrpaVeQolcmtCY3EZkwL794q/auP+OzZuZ2HY=;
 b=c7ketuurqfB7wL0UI9RNd6A25ZbsYyJkF3me4yK5oI8JBn60uSI/xoNukER/ZVcT2r/uWvQyMUF07F044E1woix7Cvl5Ykfl+BkS6AdoUUr4dimLyprKgwZluuYrA0dZvUFFvVZhRFztWIw49B/2Jva/PIn3pDix6kMrHF6cPHI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR0401MB2374.eurprd04.prod.outlook.com (2603:10a6:4:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 04:41:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 04:41:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <dongas86@gmail.com>
CC:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Allison Randal <allison@lohutok.net>,
        Fabio Estevam <festevam@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGlTieDV0WYc0SOGNv5XMQ0F6jcrBWAgAAcNCCAAONagIADPYYAgAS7CoCAAFGNAIAAB26AgAELZ4CAABbpgIAAA6hggAAHU4CAAUrDAIAG1X0AgAAU+gCAATl+AIAAGxFA
Date:   Tue, 30 Jun 2020 04:41:51 +0000
Message-ID: <DB3PR0402MB39161183FEA50BE760618079F56F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com>
 <CAA+hA=RB3H_EqCMpCuide7WDqddaZu5=LmihU1pZaCPM8b8zng@mail.gmail.com>
 <CAK8P3a2-1nFvw2rR1wws04fCmj6AyvcJ4RFwcJQ+xRPwDjUCaA@mail.gmail.com>
 <AM6PR04MB496607DD6E1B76E1B3A79C67806F0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496607DD6E1B76E1B3A79C67806F0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4af2541-28de-4df2-0589-08d81cafe888
x-ms-traffictypediagnostic: DB6PR0401MB2374:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB23747EE7D0FA8BEC62BC790EF56F0@DB6PR0401MB2374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAcB7ThqQlNVW+oJ+Oih7tFR0mT/B/G2MoY7NZiWMXfiHaglN6QZpBe7degeTDIqbUix2/dAd26uRbG0RmIS9DdWvupNjKloJhPO3+bOuu7VeYbS8f0632trsjzdaEK02uBn4wYTpgPuZe5upbT/0LDtIaP0Lhw2D8B908LW/XpDFITPkJpcTaDYZI05xIGqU2jSMf1Xko7qTDOk4gdg2SePYjB1LFubXMIYPJ1mxLt3S730AdQ8X5XkaojEFgEZFpnsyfnkDr1dKwKOH0mxLj3klVv5OnOl8tPMgMEi6B4tX4xVKJzXcdNDb6MIWiqZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(55016002)(8676002)(44832011)(26005)(8936002)(54906003)(110136005)(7696005)(186003)(76116006)(71200400001)(4326008)(478600001)(316002)(2906002)(9686003)(7416002)(6506007)(52536014)(33656002)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(83380400001)(53546011)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LGotPjqpMtkgqqBBxXxixQkA8a8DrLk2sxZ6TlfGoVGFc4//IQg6j6MlysghPldAaJ4O0JJsquasjUfAfdgDz8qkSI5iZSNkJxWJGa5N3ZKxUQ6bhrJrFWf3qkf9sDsGLtZneWV/8nGZyd6PY1DXhK2Qs7U20Gi+hk4zlmyynkAefr38fOp783mPlomSXrjggYsoa6dnb80DhBMBJTU5HSut68qNBXJ7z11zSRTHscA1nNN+TqjzoHmuD7EH3ym7Zvyj02LGZ5BVDu35a81wtGHYjaSxMPg/KT47t0dYXRo1Q4jdgG7hGkBZJ52O6myUu3w5x4p64KeVIFAyLmdHxvrAXA58XCY/uoz7IPFhtwQIFh2aRgztOgIYCNDsKgsRk1vx5ecGyxtjK9r9EmWk0f7bqNjmu8oovYkt35PuZuckw9rZavsKo/Bd0qRlxHe89bvxEreFaJLZ7CJEeHakJg5u9hB78icuSMBk3I9Mb7cGK7OCbs+36kvwlZ+mqHBs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4af2541-28de-4df2-0589-08d81cafe888
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 04:41:51.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: on1dKfqr6EzxEJ3hqa4lU0F6fbShIhy2flD0+PjkzHUtelAiKMM+QdFanV/wiEverfQQtarpwf0SSMl0u8Ry/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMiAzLzldIGNsazogaW14OiBTdXBwb3J0IGJ1aWxk
aW5nIFNDVSBjbG9jayBkcml2ZXIgYXMNCj4gbW9kdWxlDQo+IA0KPiA+IEZyb206IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4gU2VudDogTW9uZGF5LCBKdW5lIDI5LCAyMDIwIDQ6
MjAgUE0NCj4gPg0KPiA+IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDk6MTggQU0gRG9uZyBBaXNo
ZW5nIDxkb25nYXM4NkBnbWFpbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEp1biAy
NSwgMjAyMCBhdCA2OjQzIEFNIFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gd3Jv
dGU6DQo+ID4gPiA+IFF1b3RpbmcgQWlzaGVuZyBEb25nICgyMDIwLTA2LTIzIDE5OjU5OjA5KSBX
aHkgYXJlbid0IHRoZXJlDQo+ID4gPiA+IG9wdGlvbnMgdG8gZW5hYmxlIGNsay1pbXg2cSBhbmQg
Y2xrLWlteDZzbCBpbiB0aGUgY2xrL2lteC9LY29uZmlnIGZpbGU/DQo+ID4gPiA+IFRob3NlIGNh
biBiZSBib29sIG9yIHRyaXN0YXRlIGRlcGVuZGluZyBvbiBpZiB0aGUgU29DIGRyaXZlcnMgdXNl
DQo+ID4gPiA+IENMS19PRl9ERUNMQVJFIG9yIG5vdCBhbmQgZGVwZW5kIG9uIHRoZSBteGMtY2xr
IGxpYnJhcnkgYW5kIFNvQw0KPiA+ID4gPiBjb25maWcgd2UgaGF2ZSBpbiB0aGUgbWFrZWZpbGUg
dG9kYXkuDQo+ID4gPg0KPiA+ID4gWWVzLCB3ZSBjYW4gZG8gdGhhdCBpbiBjbGsvaW14L0tjb25m
aWcgYXMgZm9sbG93cyB0aGVvcmV0aWNhbGx5Lg0KPiA+ID4gY29uZmlnIENMS19JTVg2UQ0KPiA+
ID4gICAgICAgICBib29sDQo+ID4gPiAgICAgICAgIGRlZl9ib29sIEFSQ0hfTVhDICYmIEFSTQ0K
PiA+ID4gICAgICAgICBzZWxlY3QgTVhDX0NMSw0KPiA+ID4NCj4gPiA+IEJ1dCB3ZSBoYXZlIHRv
dGFsbHkgMTUgcGxhdGZvcm1zIHRoYXQgbmVlZCB0byBjaGFuZ2UuDQo+ID4NCj4gPiBJIHdvdWxk
IG1ha2UgdGhhdA0KPiA+DQo+ID4gY29uZmlnIENMS19JTVg2UQ0KPiA+ICAgICAgICAgIGJvb2wg
IkNsb2NrIGRyaXZlciBmb3IgTlhQIGkuTVg2USINCj4gPiAgICAgICAgICBkZXBlbmRzIG9uIFNP
Q19JTVg2USB8fCBDT01QSUxFX1RFU1QNCj4gPiAgICAgICAgICBkZWZhdWx0IFNPQ19JTVg2UQ0K
PiA+ICAgICAgICAgIHNlbGVjdCBNWENfQ0xLDQo+ID4NCj4gDQo+IFllcywgdGhpcyBzZWVtcyBi
ZXR0ZXIuDQo+IEFuc29uLCBwbHMgZm9sbG93IHRoaXMgd2F5Lg0KDQpJbiBWNCBwYXRjaCBzZXJp
ZXMsIEkgd2lsbCBhZGQgYSBwYXRjaCB0byBpbnRyb2R1Y2UgQ0xLX0lNWDZRIGFuZCBvdGhlciBp
Lk1YNi83DQpjbG9jayBjb25maWcgZm9sbG93aW5nIHRoaXMgd2F5Lg0KDQpBbnNvbg0K
