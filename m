Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F26C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B6920759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YmR4enYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgF3Ggo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:36:44 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:51426
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730002AbgF3Ggo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1scRed7bNUL14y2YFNTudodjcnPGVO/KEa/mq4MvkGrXjxbcoiulcWMtue9zW/Q/RU6uJHd9YQS7f0CEwwEDe+bNE4hxruGT95MyMs7vn6/SG8Wy5nJvTANVNiCbl7O40GvTxChyHbQFvnzjsMSjyWcvevHhqFBRDbs3Zfd6EcxZ3n4AaRUwulAq9gl8ujKoHBotZ5Jzr86ANmyGqRWp5nTokKuBraEC3Asq7tNuS7aW8qrTwuzQ4iy9lObVKD2l5VyE8IFBpeUr5s6CaIeLclXZAOWTaE/L8TPaWUvnwCts6HMGJ+kV9EPBFdWfGMVBGJPtzUJMdEUDbDwrKFD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCSqCdFF71MkEbcJ74sy+rfHlf/NXtUr6N7sgoSzqJk=;
 b=jfs5WhaRijDc/RoRlxVsN2on9bcRfMgi26QW1gzcBu8qkxB1Ie7aD9EGXjuBDtH6lUQcIUHMlFFeiXMrwrItOIH2cx6r4Z9mJyMku4mUvFjPy74xU4WxbAAfkOlfS0DBtcjOLsaQasYxfNaeNh8KKwl83mc2WMswScneXRGzG42Mo0VCcO8xtd58cWXH/94Q9ovJ1FmrgEJSmtGogiitrxrVIQZa34Yky5B3eH9twbMdmhmEDM1Et9aIhtcNFgddX34QW/+c8k+PcOPZL9rxQvLm7N4/l58bmrwvhujFpgpM3P8jEI2nRJERv0xRyrzc12rwik/WmETRnjjrh7Dx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCSqCdFF71MkEbcJ74sy+rfHlf/NXtUr6N7sgoSzqJk=;
 b=YmR4enYDliLWoW24lyXQ/h9Otpl5botuyd932pScHG0xaY9D/jZQJgJKqJj2EXbB1syRmEsQVBGNkykxzNAe9dAlhpvbkjnH1pR/dnxNaIpQ2vS8l/wJiiYOjSJvcM+hht8YYwAMbqO42phA2bagab8/DvpvBhuYnWFZmx4o2HA=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5896.eurprd04.prod.outlook.com
 (2603:10a6:20b:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 06:36:39 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 06:36:39 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Index: AQHWThag/tmWe004ek+eXrutuxE1fajvmZEAgAAMoQCAAAM9gIABCdjw
Date:   Tue, 30 Jun 2020 06:36:39 +0000
Message-ID: <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
In-Reply-To: <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 746e5fba-e8bc-4db5-764e-08d81cbff206
x-ms-traffictypediagnostic: AM6PR04MB5896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB58967F3BC8A68C517762A210FF6F0@AM6PR04MB5896.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUNkNrGK26ck5NVFxPmxWEdAi0+TIZZyUtlhHef/LAAjsqe/bvN4xzBsDHumFip4pvbW5KjXWaP35WJUVGouLBvl8KHO1G2eUewlXt8viEgk9rRFg3HRgVqaD9gUeRSBkgYh1Hcy3Dl8CiJK5pqAOYBEJWDgjA38lFflsckjTR4ZkA0sF8MzC8oFR4FfkGOxxuDOP2ZxkRjz54nh0TrP99142RLHy5fB5Fe3Xz6V8lNJwNArZaYkl769PX+y24kry7YRM5f5jId0G2vdlUzz4+OxexXormvDSQDNpFGvL9/zNXNjHsPvowY0DCYHECopRcFfGavN5baZf6JhhecvaA4mxvMuXfh2DsA4vISKmgogPBW0dIwvL7SCTsiPh4rLAq/q05IvB16HlvYzs3oMBCYB+CvzytGXxlJLAl51YOspo1JYVgYqpIJjcn8JO1VpvhXOQmfWU/U8Z04hyTtUpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(83380400001)(66556008)(66476007)(66446008)(64756008)(66946007)(9686003)(55016002)(8936002)(5660300002)(52536014)(8676002)(45080400002)(71200400001)(2906002)(6506007)(966005)(76116006)(86362001)(4326008)(83080400001)(7696005)(186003)(478600001)(110136005)(26005)(53546011)(33656002)(54906003)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rnk0ssSaU/uNCsoyicvJkCNWEdRDnEJF+cY/7TK9ReoK2rvSLiSyngJ/QEitQjJaqHhN5r5jbR7reH7Qi4o9OXT2NMu2H3HwlzgCvg04KBiHTAfVKHNydnUhrJFOLdY1R4XpnwM3p4h64KvNWJnYwuFYDtK2QGhC71jJaHMRaAa1FRlkV4AwqlfhGHGatjFpQ9yec8V4p7ltZ5Oaujw3xmMvezeq+rdw5+RSxsdre08L00H7jkadxJo/unXwqzbLIg1fMjr6A53OLlZ9R23U7VImtZ41ctIBmSlEvHiIzyBbSH7WzDJ+kKgnNH4HuLKZmoeqwFK97lt8UfA1UhT73nOja4pLFlt12glVdlbaPj6gnfxDRyVYOBZPQSDjbjSpH8QA5Le4j9Z8fAj6S6DtMEJi+knQotaNzVDOD7KI+4d8ObgeOdNaQ/990gkbJeQoBG58Zca1Ygrp7mxtpLiXh93nSb/ANRGJw46Rc6KlLu2vpIAJUGToWZ45FHftB4Xi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746e5fba-e8bc-4db5-764e-08d81cbff206
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 06:36:39.6937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jq8fQxTztKKziWrFohkNvriKUudEEuJa67gSiKPqFIpkpXLi2LlRRRL9M5gFnVns0sTuOzCuY9bKo8Eo6/F64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3ZlbiBWYW4gQXNicm9lY2sgPHRoZXN2ZW43M0BnbWFpbC5jb20+IFNlbnQ6IE1vbmRh
eSwgSnVuZSAyOSwgMjAyMCAxMDozNyBQTQ0KPiBPbiBNb24sIEp1biAyOSwgMjAyMCBhdCAxMDoy
NiBBTSBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+
ID4gSnVzdCB0ZXN0ZWQgNS40LjI0XzIuMS4wIG9uIGFuIGlteDZxcCBzYWJyZXNkIGFuZCBESENQ
IGFsc28gZmFpbHMgdGhlcmUuDQo+IA0KPiBJIHRoaW5rIEkgZGlzY292ZXJlZCB0aGUgcHJvYmxl
bSAhDQo+IA0KPiBXaGVuIEkgY29tcGFyZSB0aGUgc2FicmVzZCBkZXZpY2V0cmVlIG9uIG1haW5s
aW5lIHdpdGggdGhlIGFjdHVhbCBzYWJyZXNkDQo+IHNjaGVtYXRpY3MsIHRoZSBkZXZpY2V0cmVl
IGlzIGluY29ycmVjdCAhIFRoaW5ncyBzdGlsbCB3b3JrLCBidXQgb25seSBieQ0KPiBhY2NpZGVu
dC4NCj4gDQo+IFRoZSBzYWJyZXNkIGhhcyBhbiBBUjgxMzEgUEhZLCB3aGljaCBnZW5lcmF0ZXMg
dGhlIGVuZXQgcmVmIGNsb2NrLCBub3QgdGhlDQo+IGlteDYuIFNvIG9uIHRoZSBzY2hlbWF0aWMg
d2Ugc2VlIHRoYXQgdGhlIGNsb2NrIG91dHB1dCBvZiB0aGUgUEhZIGlzIHdpcmVkIHRvDQo+IGlt
eDYgRU5FVF9SRUZfQ0xLLCBzbyBpdCBjYW4gYmUgdXNlZCBhcyBhIGNsb2NrIHNvdXJjZS4gQW5k
IEdQSU9fMTYgaXMNCj4gZGlzY29ubmVjdGVkLCBhcyBpdCBzaG91bGQsIGJlY2F1c2UgdGhlIGlt
eDYgaXMgbm90IGdlbmVyYXRpbmcgdGhlIHJlZiBjbGsuDQo+IA0KPiBCdXQgdGhlIGRldmljZXRy
ZWUgaXMgd3JpdHRlbiBhcyBpZiB0aGUgaW14NiBpcyBwcm92aWRpbmcgdGhlIGNsb2NrICEgU2Vl
DQo+IGhlcmU6DQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQua2VyDQo+IG5lbC5vcmclMkZwdWIlMkZzY20l
MkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRnN0YWJsZSUyRmxpbnV4LmdpdCUyRnRyDQo+IGVlJTJG
YXJjaCUyRmFybSUyRmJvb3QlMkZkdHMlMkZpbXg2cWRsLXNhYnJlc2QuZHRzaSUzRmglM0R2NS43
LjYNCj4gJTIzbjUxMyZhbXA7ZGF0YT0wMiU3QzAxJTdDZnVnYW5nLmR1YW4lNDBueHAuY29tJTdD
MTZjNDNlOGQ5ZA0KPiA4ZTRmZjBiOWVlMDhkODFjMzlmN2YyJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTcNCj4gQzAlN0M2MzcyOTAzODI1ODg3NTE4ODcmYW1wO3NkYXRh
PWhDUk5HYTlXclF6UTBYWXdSJTJGUVRROGgNCj4galk3Q0RIamhJYlhyMEwzM2ZyJTJCYyUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiANCj4gQWxzbyB0aGVyZSBpcyBubyBvdmVycmlkZSBvZiB0aGUgZmVj
IFBUUCBjbG9jazoNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcg0KPiBuZWwub3JnJTJGcHViJTJGc2NtJTJG
bGludXglMkZrZXJuZWwlMkZnaXQlMkZzdGFibGUlMkZsaW51eC5naXQlMkZ0cg0KPiBlZSUyRmFy
Y2glMkZhcm0lMkZib290JTJGZHRzJTJGaW14NnFkbC1zYWJyZXNkLmR0c2klM0ZoJTNEdjUuNy42
DQo+ICUyM24yMDImYW1wO2RhdGE9MDIlN0MwMSU3Q2Z1Z2FuZy5kdWFuJTQwbnhwLmNvbSU3QzE2
YzQzZThkOWQNCj4gOGU0ZmYwYjllZTA4ZDgxYzM5ZjdmMiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3DQo+IEMwJTdDNjM3MjkwMzgyNTg4NzUxODg3JmFtcDtzZGF0YT1x
T2ZpTHMlMkZHaTAxaDloU0E3ODdQSGZHeFRODQo+IGJmWVdGWFZBM0loVUI1NTNRJTNEJmFtcDty
ZXNlcnZlZD0wDQo+IA0KPiBBbHRob3VnaCBTaGF3bidzIG1haW5saW5lIHBhdGNoIG1hbmRhdGVz
IHRoaXM/DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXINCj4gbmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4
JTJGa2VybmVsJTJGZ2l0JTJGc3RhYmxlJTJGbGludXguZ2l0JTJGY28NCj4gbW1pdCUyRiUzRmgl
M0R2NS43LjYlMjZpZCUzRDgxMGMwY2E4NzkwOThhOTkzZTJjZTBhMTkwZDI0ZDExYw0KPiAxN2Rm
NzQ4JmFtcDtkYXRhPTAyJTdDMDElN0NmdWdhbmcuZHVhbiU0MG54cC5jb20lN0MxNmM0M2U4ZDlk
OA0KPiBlNGZmMGI5ZWUwOGQ4MWMzOWY3ZjIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MNCj4gMCU3QzYzNzI5MDM4MjU4ODc1MTg4NyZhbXA7c2RhdGE9M1BpQW5EbHhP
OGlxc1ZSNllRV2pDazF4c2c4aVcNCj4gUks4VFNHZWU0TGhrakklM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gDQo+IFRoaXMgd2lsbCB3b3JrLCBidXQgb25seSBieSBhY2NpZGVudC4gU28gb24gYSBwbHVz
LCB3aGVuIHdlDQo+IChpbmNvcnJlY3RseSkgc3dpdGNoIHRoZQ0KPiBieXBhc3MgYml0IG9uLCB0
aGluZ3Mgc3RvcCB3b3JraW5nLg0KDQpGYWJpbywgb3VyIFFBIGRvdWJsZSB2ZXJpZnkgNS40LjI0
XzIuMS4wLCBubyBtYXR0ZXIgU0QgYm9vdCBvciB0ZnRwL25mcyBib290LA0KYm90aCB3b3JrIGZp
bmUgb24gaS5NWDZRUCBzYWJyZXNkIGJvYXJkLCAgcGxlYXNlIGRvdWJsZSBjaGVjayB5b3VyIGVu
dmlyb25tZW50Lg0KDQpTdmVuLCBubyBtYXR0ZXIgUEhZIHN1cHBseSAxMjVNaHogY2xvY2sgdG8g
cGFkIG9yIG5vdCwgIEdQUjVbOV0gaXMgdG8gc2VsZWN0IFJHTUlJDQpndHggY2xvY2sgc291cmNl
IGZyb206DQotIDAgQ2xvY2sgZnJvbSBwYWQNCi0gMSBDbG9jayBmcm9tIFBMTA0KDQpTaW5jZSBp
Lk1YNlFQIGNhbiBpbnRlcm5hbGx5IHN1cHBseSBjbG9jayB0byBNQUMsIHdlIGNhbiBzZXQgR1BS
NVs5XSBiaXQgYnkgZGVmYXVsdC4NCg==
