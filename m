Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E9206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bfFDTp42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbgF2VBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbgF2TM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:56 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F9C00697F;
        Mon, 29 Jun 2020 04:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO3o07DDqUJerIu/2ZGDFEtOVFt2UjutMM6KgbRXAessG80s/33l3mii4PwEzVV5lWtJbdRTc59sJhGb0qlgVihMJywsynjuPuXCSGaV/6ysOTaSK/OTwjG4gApf7dmipqqBOcbo4TIqRjMs9NZffs2AB6DEdzrOC5w32D4HBu/PUnSxEvEXMtxuyQmBGg7fC6S7+UEsqpYfQlstHVGmmMM2botUo4bxPpEyAVmFPMlZYiOvbXW17X84Nx5wcMQFyQ86PFHAyTFbRE5oWdzdlp/aZktUGTMNpnAErAfpq12FR6N+dMGHhzzrhxPo2dlLb5Ro3RZrmasUUQOZx5g6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfXB+EZpSMPFT1/EmN1xK5a5OX3bppp/VU3jsFuoKx0=;
 b=GMjZallOAAEDVKs+AZz2XWcFpj9hNBSETR07r9zRCnqVVx1eTsE6N5tTDbkLBh/R79VQySdGODeqq6iHYs1X1ednzGRZZXDZhBw1PKSfILFT5emynK52/GoNHBX/4+CkUD7Po1j6o3juoXGICErljFfhlBbHuy634DF/ftZPgLShw/yIG6i1cgoL2BwQA9lYKzBQAH8FfdW0TVXPImZDPq1LmjF53TjsSqxXCOV/jPYCNdQsQaYyXrSkf/VjdaS3xTX/7GQKBJfKgC7UEcGTYIO8FxQrLjACSMuWDjHFWzYdw4fUHgNma6LfqRzZUdipEHnWMOkEykWOeEwTADr5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfXB+EZpSMPFT1/EmN1xK5a5OX3bppp/VU3jsFuoKx0=;
 b=bfFDTp42gVCyaw74r+ciq9cuf7fupJC/Kx1qz3WVGuK9Ux4QwSMe+S0PbXWVroyb25D6tAf8DA4toDzxMAuOq0bboVSk3IHQY3KMpMaDwZqwEbNBJy2/u6xsbQsbwAJxz5J3LwUNYhzGpNdi21E2+cuxgOQWjOg0664ZHNMO+1w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR04MB3014.eurprd04.prod.outlook.com (2603:10a6:6:8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Mon, 29 Jun 2020 11:40:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:40:05 +0000
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
Thread-Index: AQHWTdtegku2i+ERdU6EY9a3qfOcyajvdnIAgAABM5A=
Date:   Mon, 29 Jun 2020 11:40:05 +0000
Message-ID: <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
In-Reply-To: <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06f29aac-bd40-4303-ff1e-08d81c212b51
x-ms-traffictypediagnostic: DB6PR04MB3014:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3014C0F45ED727C1E59B9F34F56E0@DB6PR04MB3014.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: du4qRVP0fz3EAYxueQlmgJ2sqFaFNlH7BzsUvqfJDg0Y7K+mkmB6AUkAHKrtZACzHZ8JJ2U/Hc2WSkzSB6Wag0VgQz1ZJNMl1laP09lnLIgdPCMpp2ULNUKIBzJjJS4GuVTOkQgGTh9Oub3UkbDWY5+yLdPhX5+vaeP3p6W9bw0H339qFQ5/3eGMRyQu4CWiUQuOSaSzD+WF6hERcWOO6UHx8qHClbtmCvrkGqjKiVL010jiDB+cf/6wJAbHFERuuOIPGFqo+EoIe1YLHr5DA0rlgNDC+YV3KZBtUX1WBnQ1yqPloKpty/wtCt+a1O9334qZM8ClW4un72dRJxorSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(316002)(6506007)(8936002)(6916009)(54906003)(26005)(5660300002)(71200400001)(83380400001)(186003)(53546011)(66446008)(76116006)(66946007)(7696005)(66556008)(64756008)(4326008)(66476007)(4744005)(44832011)(7416002)(9686003)(8676002)(55016002)(2906002)(52536014)(86362001)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Z0LFeI6O0iA0QHbwE5UsaGuEkVQX3tz7NlH1iM/kL5Ch/AvGc7btgUSl64mhDuskOwtQQWxark2qTUcUeq/0OiN7gl61tKP0LZTrmVT5gd13HpoIbKhcEKvpXHYf8TWKLhI11qQLntgh43vY6Rxhfh2qNO5jeUwwvAR5rJdtxaQg84hPotQPMPVWhRaTS4MY42HUxdZg7xQyyvFydvXr13pQc47DfcEFjt5O/4x3+yVRfxjojfa2hLmT8mcm1YuFGNAxQZsaw/dobwXamYGVTP52DpMxIH8EKwwcFfyFDFJ+hA0duwW+vWQTzVp7JqrQWEUTZlgCfiSs/RMuNnWIZmuVH03teOubf9GNYjjrt3VATNvnWoJb5hy1AHbGLLTLIUyHBME5s69/1YQOwO6waF38a463D+HNzq2GAk1FSeOJfwaRUDgjQV/e8ynDD1EN94dYMPpi9Uc72YqoO8RFN4wNZ+Mag7D9hjD2cUZRvcgG8Y93WT03WZ2D2lh4wZh0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f29aac-bd40-4303-ff1e-08d81c212b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:40:05.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnoV0g+stdj5soVP4lvuUu93wjUMS1PBv315Yv9dqchGVatzq3wbwJc5stiSZ9ExcDEUe6gNOSjGaQmWYYQ+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDIvMTBdIGluaXQuaDogRml4
IHRoZSBfX3NldHVwX3BhcmFtKCkgbWFjcm8gZm9yDQo+IG1vZHVsZSBidWlsZA0KPiANCj4gT24g
TW9uLCBKdW4gMjksIDIwMjAgYXQgODowNiBBTSBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBLZWVwIF9fc2V0dXBfcGFyYW0oKSB0byB1c2Ugc2Ft
ZSBwYXJhbWV0ZXJzIGZvciBib3RoIGJ1aWx0IGluIGFuZA0KPiA+IGJ1aWx0IGFzIG1vZHVsZSwg
aXQgY2FuIG1ha2UgdGhlIGRyaXZlcnMgd2hpY2ggY2FsbCBpdCBlYXNpZXIgd2hlbiB0aGUNCj4g
PiBkcml2ZXJzIGNhbiBiZSBidWlsdCBpbiBvciBidWlsdCBhcyBtb2R1bGUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IEkg
d29uZGVyIGlmIHdlIHNob3VsZCBpbnN0ZWFkIGRyb3AgdGhlIF9fc2V0dXAoKSBhbmQgX19zZXR1
cF9wYXJhbSgpDQo+IGRlZmluaXRpb25zIGZyb20gdGhlICNlbHNlIGJsb2NrIGhlcmUuIFRoaXMg
d2FzIGNsZWFybHkgbm90IHVzZWQgYW55d2hlcmUsIGFuZA0KPiBpdCBzb3VuZHMgbGlrZSBhbnkg
cG9zc2libGUgdXNlciBpcyBicm9rZW4gYW5kIHNob3VsZCBiZSBjaGFuZ2VkIHRvIG5vdCB1c2UN
Cj4gX19zZXR1cCgpIGFueXdheS4NCj4gDQoNCg0KSXQgbWFrZXMgc2Vuc2UgdG8gZHJvcCB0aGUg
X19zZXR1cCgpIGFuZCBfX3NlcnVwX3BhcmFtKCkgaW4gdGhlICNlbHNlIGJsb2NrLA0KanVzdCB1
c2Ugb25lIGRlZmluaXRpb24gZm9yIGFsbCBjYXNlcywgaWYgbm8gb25lIG9iamVjdHMsIEkgd2ls
bCByZW1vdmUgdGhlbSBpbiBuZXh0IHBhdGNoIHNlcmllcy4NCg0KVGhhbmtzLA0KQW5zb24NCg==
