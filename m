Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6617C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9161A2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 12:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OpMmaGEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHWMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 08:32:02 -0400
Received: from mail-db8eur05on2078.outbound.protection.outlook.com ([40.107.20.78]:43745
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727843AbgHWMbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 08:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGgJqx+RSxiAiDDp8yRW73fniQNKy4meYrqM8Sh9Mmgk5gkYy3StULANXgMY15DFpEDI/ct4zguSIQOCmkmr8AB3H8bma24Z3ZXbLhqOc56FnmvhvDgIdlJu2hoLuCknkuIyVHm8PS0JT7dqPZ3d2fLgteXyKN9gsaF6f1BimrnFJpU1dvvv7fatP+edhATdH7gPxX3384W8WTSZmdh4djsddJN0qGeE6FSQzI0GGcTojDBcSYYdQ6pgK4zn8qIKFL8sXYHFrqJuJXy/O7tS2GrSJvX8BjXo5difDoVw8Sj7qYafgGPwnz9kebEv+1md6OxLlCK1RLWBTRtJnW4cSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoA97hiETviJzzBawxx8mkre5Mz6nohrG3fy0UoIFlM=;
 b=Nr0exQsaK8DCpSQnMUwdsyw1A+rf+Vr05ky0AJwvTpT4rCKxxBbU9+X39v6cPRQPScdAC8/C8q/NiCwHWClbayDAX7NJecv+ttiMTLhT3pC05j69JTGhrv4Jz9/AFWYFaCPb51emgfgd0nN3czWgOwp8+bS/Lq7BzZLQ919LVAlEWN3RW+YX6pf/Ra9x51J+cmGTwR13EmlfEGx16hS4wYPUrGyFhfEQqBjxO0GxicUhKOzJpErB4mjl8KHHBh2eE8vOYbQm7pl7/GE4YYlxxsx/GH1fTK8nGG3xGIypbIcTSCDlFbY0StVNpC4VIf+4ai8YdHCwlIcCY5TCjPJm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoA97hiETviJzzBawxx8mkre5Mz6nohrG3fy0UoIFlM=;
 b=OpMmaGECXfviPJxuWeojGkXW+xa3Fu2b6th6xwHf6RE/TiiUSRbfL9Xm1+Fy0D3DqkfsKCJvga+fdxVxi0HwQTjYz82H4OUwQAQ9Z3U3Iqyd/Lpvd3bX2jz39GDdwm4JoKnGJKYgO9bp8xDH91jTDs000huwKdE0qRlIfMI7AxY=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR04MB4462.eurprd04.prod.outlook.com
 (2603:10a6:803:65::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 12:31:50 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f%7]) with mapi id 15.20.3305.025; Sun, 23 Aug 2020
 12:31:50 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound
 card
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound
 card
Thread-Index: AdZ5SQWg8OSK9gvUQzGD/xSN48nLag==
Date:   Sun, 23 Aug 2020 12:31:49 +0000
Message-ID: <VI1PR0402MB33427CE688DB9D28DDFC000EE3590@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b400828-0cdf-4a69-f500-08d847608239
x-ms-traffictypediagnostic: VI1PR04MB4462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB44628DD94A8104DF1513F3C4E3590@VI1PR04MB4462.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AivAv95y0evIjwDa81npmIkSN6JtfOk3+5Ex+GvZFrSSr/S/hmI7f9Vrt1FxAG8CRavtEEmpFUKev+vr8k12hJXa7zwiml8CphHNAUl1TIX1hQTSas6kDsJfxL14lAuox9ACnddMBpnwjgK/g1b1lS1O7sJvI77fScyJqSGoMFN70LcQ7B59LYrTzG+zFDq+8zMS2aJ63Laa1JX5gmWljDt8lK1rNrIJ1UlAoBIM3j2RjL0a3UutnFtRMxjwJO17xz6K1KbxjJCtqpUktq/Ebj2zG7CK7sudtI3AE5yiQelQx5zLsOWFwHqjzh5Dj/2TB898IUyeymJe94QfD12MRoeATzlBjXqAgCrxIkDmtQbUeFtzGxjms5pRtlfrHvc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39850400004)(366004)(8676002)(186003)(54906003)(4744005)(64756008)(76116006)(86362001)(7696005)(4326008)(66446008)(26005)(110136005)(66556008)(52536014)(66476007)(316002)(66946007)(5660300002)(55016002)(33656002)(9686003)(2906002)(71200400001)(8936002)(83380400001)(6506007)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +mditgIuUZaw/OS+I6k0TC8MNaugtJWQjA5RljeFdqBWsX8HaYBsU1g7z/rMHymsRhwp/YGjHg3L26IUucXYFwdIuV0NyagMIjkbjAhSdRGUPcyF6cjbv8TeLzSkATqWvGcAdT1s/l5o3up7jQkmNMunA6/3jMKIKRUtKEWswUva0yPiiyCdnUcV2HybDwqUCtMx8/oAZAkKFA56/JW6zfsKWBScuvpiGaS6wMwLpe0Cze0XmSgGFvnW3iFEl5v/H1/ziOYzlDqK39xJNOgvtGuDnLj5sGK0GkFWw0eRKQ5bPVmUbpprtVrZj4mO+dTl5yd5qPux/O3PE0vwWW10MUeg4clgsBTnfFqGJNuWEtFd8hMIwE+7+PLAV6FjEY2iZls6GX8yod7HpWqpvpQ+gkCQ6KvR8iKA/+ZUGZjYdyUJpqcMeK2NL1hFcyocU1NiWIHoF+dZHMt1Z9F27xDIW5rg7zdpDTpWCKDh4xHyhEu4bcD3DGILvUbzzB9/4RBsIPRzkxYtkXhb3oiTItYXYQJF6wyjrg0IkHXjquRmQG4cBQzBD8Lg16vjhRz7AK7vPuQns5bE1bNISyfDplUPNNWVCgFKD09QPZJCb9NIExT4HTEc/2yWswuag2LpE2/p9M8M4N122uGdXQnjxHcaLQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b400828-0cdf-4a69-f500-08d847608239
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2020 12:31:49.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pG90gb2lOpDesBoAO5Pa/d7BdwBq5qf5mdcT2S9Tnxq/D9eZv+8Wxndx1MJKm66Zob2SMNsT9kUU1ts6YAohhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24NCg0KPiANCj4gPiBJIGRpZG4ndCBwdXQgaGVhZHBob25lIGRldGVjdCBHUElPIGlu
IGF1ZG11eCBncm91cCBpbiBpbXg2c2wtZXZrDQo+ID4gcGF0Y2gsIFN0aWxsIGluIGhvZyBncm91
cC4NCj4gDQo+IE9rLCBzb3JyeS4gWW91IGdyb3VwZWQgaXQgd2l0aCBNWDZTTF9QQURfQVVEX01D
TEtfX0FVRElPX0NMS19PVVQsDQo+IHdoaWNoIEkgYWxzbyB0aGluayBzaG91bGQgbm90IGJlIHBh
cnQgb2YgdGhlIGhvZyBncm91cC4NCj4gDQo+ID4gQW5kIEkgdGhpbmsgaGVhZHBob25lIGRldGVj
dCBHUElPIGlzIG5vdCBiZWxvbmcgdG8gYXVkbXV4IGdyb3VwLCBpdA0KPiA+IHNob3VsZCBCZSBp
biBob2cgZ3JvdXAuDQo+IA0KPiBUaGUgaG9nIGdyb3VwIGlzIGJldHRlciBzdWl0ZWQgd2hlbiB0
aGVyZSBpcyBubyBkcml2ZXIgdGhhdCBjYW4gYmUgYXNzb2NpYXRlZA0KPiB3aXRoIHRoYXQgcGFy
dGljdWxhciBwaW4uDQo+IA0KPiBGb3IgdGhlIGhlYWRwaG9uZSBHUElPIGRldGVjdCwgSSB0aGlu
ayBpdCBtYWtlcyBzZW5zZSB0byBncm91cCBpdCB3aXRoIHRoZQ0KPiBvdGhlciBhdWRpby1yZWxh
dGVkIHBpbmN0cmwgcGlucy4NCg0KSSB3b3VsZCBsaWtlIHRvIGtub3cgeW91ciBvcGluaW9uLCBz
aG91bGQgSSBtb3ZlIGhlYWRwaG9uZSBkZXRlY3QgR1BJTw0KVG8gYXVkbXV4IGdyb3VwPw0KDQpC
ZXN0IHJlZ2FyZHMNCldhbmcgc2hlbmdqaXUNCg0KDQo=
