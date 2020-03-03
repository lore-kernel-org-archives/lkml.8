Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DE0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7250324680
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJka4B0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCCBIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:08:15 -0500
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:6084
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgCCBIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:08:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXZf4De8FUaRjIRJvimCzq9PN3bZ0gVnLuZM7ig6F2P1GGCrUuQcLGr044rUBGMq8sYjm0CrhainUkPnP+eXX9ORMly1S9h4U0t437D9/IiK5nDfETsQw5ympjmgZMAzlHUkxB3as4WKKo9ZX4JhFg2iTkHL7VJaSBlYanmcz1xsWxora1Kq4QxfOECEj2bsWZrXad+zw9NCST8phiLiCb8mdLsfmOBS1zGXwoMrkpCef5THPszLtpgHXde5U4trjn9vDNVakCQQuOSjjy+L7uxYKokQG0tDHy/z3vNezV9Gjc8PK7CFBcFqcnPJ251rNEjM5PHfM8L4w+ug/Hy9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHF6qnlygTxMFVPAgRKPyhQkJ7njFueQcCBC3t2Bj4=;
 b=L/94HXfyAObXBz605NGEWH7mC3DyRDdmGy71UrqIhd5tPpBYaSn9CqwOsjeAyNXZv7gIB2lAXICo4L7vA9aOW5LZQJOUsqbA0uuXByy20EFy1pMK9SCcSK0DgkkpNfkXxSg542jBeoc79azIb8Xp7qDXKfsfh0jus3j3F5hRjUBN9COHqwXB7nFfdhJxy3tmTlYg+DqoFeXDTZVSbr+Jfee6eJSYOqkH2uxXXpgioV2D+1e4wwKi3blQ4oSzgvioK3y5hFtfBwU9j8GTEKv2qkjmNAEhiAzaNUrJAM5A9TsrxQXH+d6OGAT4Vz26eYBvrq6ftIyoQBrTGUYF1nYpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHF6qnlygTxMFVPAgRKPyhQkJ7njFueQcCBC3t2Bj4=;
 b=PJka4B0ERIRul6odMdn1PHLOj4DAKrrUptKrwF3WeSuS4xdu9wwsbFJ1ecK/UZee8Xjt2mxpiuEfhuw8hAhnvSh5FBdQxNs2Lxrp4CVkh9l4DSfGv7ynJlthZYQjqIyZdXkf6uU/sOajNK8RV5vegpfAIR6vh+K/QGGJ1fSce+0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6452.eurprd04.prod.outlook.com (20.179.253.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 01:08:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 01:08:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt
Thread-Topic: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt
Thread-Index: AQHV5vtt9q1uPmk0BESPnzoSAIGwTqg0mA0AgAEPsICAAHoX0A==
Date:   Tue, 3 Mar 2020 01:08:10 +0000
Message-ID: <AM0PR04MB448109F20C46216701F08A7B88E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB4481FF78BB300729E59D6D8C88E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAOMZO5CBSL4yn4m6n56qES0jDVUQZJSGZyCxng1Kg7fvD5k1JA@mail.gmail.com>
In-Reply-To: <CAOMZO5CBSL4yn4m6n56qES0jDVUQZJSGZyCxng1Kg7fvD5k1JA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cd3abc2-de50-495c-4424-08d7bf0f5739
x-ms-traffictypediagnostic: AM0PR04MB6452:|AM0PR04MB6452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB645268F7A0967FD51E5CE2DD88E40@AM0PR04MB6452.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(53546011)(6916009)(8676002)(86362001)(44832011)(8936002)(6506007)(316002)(7696005)(4326008)(55016002)(9686003)(33656002)(64756008)(54906003)(71200400001)(52536014)(186003)(76116006)(26005)(81156014)(2906002)(4744005)(66556008)(66476007)(478600001)(81166006)(66946007)(5660300002)(7416002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6452;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghg3lA8t8gbsKiQQ2bR2np5LgV2jlB6EJ+dAkN2Ic5r7ipSINbaHsFOIWY9PtT8uwX8EOwTYMW7hu+nmtP4O/w2oDTSEASXc0y7bvzS4DfXuIm4IEHIHmWYQV9bpX7mNKKK7CkrPlfeBePHAUL9JYKxbiAqterFxo2/SOzX1CJm00WTKwtm8B3YiaAzNyX8fkKC5+HQGrfbYIX42pchR6xY7CAPKqLEvM2CYegngHb0WfgYsEFDa5Sadp7w///4mSfXqsFkCbqaethZhEVHsceVmr3yaPd1xXRs76GN+T3MFkuSQ2arYpwwRm1Lvl3WR6TIaPgTOlfu57dkFFCjZTPt+3kRe3U9Ab6d4V1VmiOgelDvSKvY4wJ97m30xSj1jBp6k0ALdGW4VFfxjlPOR0Mi6ANME2GjzQCOgP6xd8CIhCckKwS0QmVY2+1XvLyVn
x-ms-exchange-antispam-messagedata: zdKUPJ7yM8Y3qHeadEcc2qheDnZm71bGVAQG0mCNZw1wxIk1g+Z3U0aKheAYNxZPAZdKbStSwX/vOf+2GMbxz/qYtNUEg73m0jFsB6I63Q2Nk0ubbv7zWmbXepcN3wYPY5Sip1xe6swJQ/H47TEneQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd3abc2-de50-495c-4424-08d7bf0f5739
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 01:08:10.4450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPXq40NV2ZD8OJvEMjGrw0uv3YSZczSFaQjasAz66bgv4eLCY32uofymdBvbYZjI2h6O0HQmQfvv/TCBUgE6KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMC8xNF0gQVJNOiBpbXg3dWxw
OiBhZGQgY3B1ZnJlcSB1c2luZyBjcHVmcmVxLWR0DQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24g
U3VuLCBNYXIgMSwgMjAyMCBhdCAxMDo0MCBQTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBIaSBTaGF3biwNCj4gPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIHYy
IDAwLzE0XSBBUk06IGlteDd1bHA6IGFkZCBjcHVmcmVxIHVzaW5nIGNwdWZyZXEtZHQNCj4gPg0K
PiA+IElzIGl0IHBvc3NpYmxlIGZvciB5b3UgdG8gcGljayB1cCBwYXRjaCAxfjgsIDEyPyBPciBh
bnkgY29tbWVudHM/DQo+IA0KPiBJIGhhdmVuJ3QgdGVzdGVkIHRoaXMgc2VyaWVzLCBidXQganVz
dCB3YW50ZWQgdG8gYmUgc3VyZSB0aGF0IDcyME1Ieg0KPiBvcGVyYXRpb25hbCBwb2ludCB3aWxs
IG5vdCBiZSBwb3B1bGF0ZWQgb24gYSBzeXN0ZW0gaW4gTERPLWVuYWJsZWQgbW9kZS4NCj4gDQo+
IFBsZWFzZSBjb25maXJtLg0KDQpDdXJyZW50bHkgSSBhZGRlZCBhIGNoZWNrIHRvIGRpc2FibGUg
SFNSVU4gbW9kZSB3aGVuIExETy1lbmFibGVkLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBU
aGFua3MNCg==
