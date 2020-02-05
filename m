Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52352082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dvNIFkod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBEC75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:59:57 -0500
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:14126
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727924AbgBEC74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+1LaayEGlt4Y7gb++ZXur7A7k/IdeuitSGCeAscvk8fUej/5wAaHEoZlsNUBhI3CE0HpJlh6KDmXNZFAEoENavGQEi7wQLkE/nyArQV3h+DOonsKky5JoS8At6zKRFpkUVr5PtRLflFez5rIIS6DWu2sgXljDq0oVZdABXdhjIi95/zxTeo/3VtQUTnaUUgA2hrIJGZZMwhO6T83OKvPn2gd/NM/COYpospbf5fA8ocY7E3dGknLeFF4l4H4jUm2Z2WeSEqxFDYqqqCz1jUSpgiIoSuOAjbv6Nd2KeD8XiF7ITG8bUcDs4LvicJUh73fuGQRA06oX8Zbe5Guyn/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR58iCd+nNAnYwF+mvJyhklT4v/MM5nupao3qGVrJMY=;
 b=iMpUkWArFlfTxlJN6I1xiqr2+1Vbd7XjMz9zrNyTq9m+1BcTME/OPPVxnb2sDTymyQXCGh6V2mE6kdSSFl6HseLG77lVxaX6Yb0Fupf2h4gDhxQhEpb276kq2IXRI81DoipGhU4NMBO8kIg+3Tcg/lg07WdiyMyxHMdjFcrPzMwuvSUlMumOw3Gcl0gfi4tilbumSNfjS06jbp7C5wqg/Mbe1Q3LD+SAkrfiFQ77fXuuGch/cv0tUm+tEWv1X62HXIfDwvRO8UNzrgrymjCBVhVcez38J8B8ixl8/kepqj+TiaWIiDwjoTMI7EB/3XflzW+3h0RNcrB7/SkTEJuqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR58iCd+nNAnYwF+mvJyhklT4v/MM5nupao3qGVrJMY=;
 b=dvNIFkodcdHo7mE+ekvNsKFJ7FpXkDv/1z8lcdhOwGYX3zb7apSIbMSpSquMblawxUS1zwkgWJ+/0XcTr7RQLL2hKpabXpXkoGi1yFgE0Lf5IXLgoJ/iJmnYRG21JuYapkpIr6YCBTmvHwUhXCp+w6XR05x7tUwIpU4lrXtqpr8=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4249.eurprd04.prod.outlook.com (52.134.108.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 02:59:50 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0%7]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 02:59:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 6/7] ARM: imx: imx7ulp: support HSRUN mode
Thread-Topic: [PATCH 6/7] ARM: imx: imx7ulp: support HSRUN mode
Thread-Index: AQHV22DS1fobjwyzsECLZwnJ5ghp3qgLDWuAgADcRAA=
Date:   Wed, 5 Feb 2020 02:59:50 +0000
Message-ID: <DB7PR04MB449032635121DD11181FC2F388020@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
 <1580823277-13644-7-git-send-email-peng.fan@nxp.com>
 <CAOMZO5BnfGdbDuobV=qi4zbzKriM0kNmAyd8zFCSdv2krVj=Og@mail.gmail.com>
In-Reply-To: <CAOMZO5BnfGdbDuobV=qi4zbzKriM0kNmAyd8zFCSdv2krVj=Og@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edb6c81b-869d-4d2f-1ab6-08d7a9e777b0
x-ms-traffictypediagnostic: DB7PR04MB4249:|DB7PR04MB4249:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4249401F0E1416725761329A88020@DB7PR04MB4249.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(53546011)(6506007)(4744005)(478600001)(2906002)(33656002)(186003)(4326008)(81166006)(54906003)(8936002)(316002)(81156014)(26005)(86362001)(5660300002)(6916009)(44832011)(64756008)(52536014)(7696005)(55016002)(71200400001)(8676002)(66946007)(66556008)(9686003)(66476007)(66446008)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4249;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5orJE7IQxN7yeB9UKpsxs030NCFNvTd7dUBBHQNenbNOTIDM53YjeJ1wvktrtyoSa1I7WhkIJTp0ZUvmjs6tY2YlofN7SgH4rY34Tx389Sp9lEJ+ttecnwCfresBTykc49rXfu11TbPEJymNuMJXlWDhgzDp3Kx1fkahgiJtRNRpndnniIBLAfXnYYN1bEpuvMYJOkDS+SzWQ6xOyikqyzGmIdL/Es9Gj9LB8hDNZWMc2LJoF3JIuBEaID8ANlkWQV9izOkStR52LMkWDoqfOQ6ApEvxGpmA7+JcI7TYWeqJRnORGOR5+gQCl4Nw2u1VtQBr47EpmkHpoo42Z8N/UIFLQGJljdurRPWFKNUBPpm8vowDKxB2s7NUVhQvuoVKYV5mxDSLwz1WGknWQNgU3CYPz2rQ8VVMIOaO5DbhNwsmXVfGKOo8RNDTQUQlWC9
x-ms-exchange-antispam-messagedata: YTRKumUAfQEYVoY8MhlQjLX4YD+pB6O/Htn4YDyKHfZWA20cXzQ0DeflwFF0sLW9xfrcY7f3cXQKJXHV3rXg9Et/chCssI/d0Ges2QXvS/EK0ZVSQSx/afY+NMpzd6LHt5ESs42GwGU3GlA02tXPUg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb6c81b-869d-4d2f-1ab6-08d7a9e777b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 02:59:50.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t06Kas5yTlEY9Jbzxnkzs8F9xI88t+EXvP/no90vV9U8fQcNLli/9P9OtSuIKxxhxSxft32TQXGSyWilWTMEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDYvN10gQVJNOiBpbXg6IGlteDd1bHA6IHN1cHBvcnQgSFNS
VU4gbW9kZQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIFR1ZSwgRmViIDQsIDIwMjAgYXQgMTA6
NDEgQU0gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBDb25maWd1cmUgcG1wcm90IHRvIGxldCBBUk0g
Y29yZSBjb3VsZCBydW4gaW50byBIU1JVTiBtb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiA+ICsgICAgICAgd3Jp
dGVsX3JlbGF4ZWQoQk1fUE1QUk9UX0FIU1JVTiwgc21jMV9iYXNlICsNCj4gU01DX1BNUFJPVCk7
DQo+IA0KPiBIU1JVTiBjYW5ub3QgYmUgY29uZmlndXJlZCB1bmNvbmRpdGlvbmFsbHkgYmVjYXVz
ZSBpZiBpLk1YN1VMUCBydW5zIHdpdGgNCj4gTERPLWVuYWJsZWQgaXQgY2Fubm90IHJ1biBpbiBI
U1JVTiBtb2RlLg0KDQpUaGFua3MsIEknbGwgdXBkYXRlIHRvIGFkZCBhIGNoZWNrIExETyBtb2Rl
IGhlcmUuDQoNClRoYW5rcywNClBlbmcuDQo=
