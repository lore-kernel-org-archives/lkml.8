Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64068C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431702083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="imBkZM1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgESCvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:51:33 -0400
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:14491
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbgESCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:51:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksQ48CgRnyBuvk2XCxaDTjOdbqbBXZsjG7waBjJG0PEYHKThxpFp+fdNBwBQZa1Ccazm9u6IxeWYV6jUZsW5RYWEmVCbbsd8lml4SVUXo6LPn+MPphZIqldCSB8Q2MYvzVtjYzvA6UK2/e8IrERIfprevjgtSHiNWRb24HTQx/BdCAy46xULgO96cqbMntWbexMF1YlgSrqKNSclnSwWMhNjgviIRrj9RGnk6NllEBKQj/U/ne9MlaPchGwe/FH7F1Rfg5ikmxhTGbvwQYOeqDL0MwaaJiz0ITn+HDitgiOhJeNBfvic6pee99/WCig4GExTbstO6y/KY/uasVLQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARtortMlLjX8cO3Hnge+IhZE4+tor8CFU9CiW4ifFqE=;
 b=O9VZd0fHgNr4oAyd2DnjfDefaZpZ20K5C/IqxxTGeCK5aqTIBg3qT76S4s//0xRpA7Jv8xaK7Ub854tNbPUf8RbSB5pMdS6TnR5Ms+PEd8M7wr2vixzsF1NyvTXEo1BmAG637Wdb+afCGP69GAWN+sWDNXMNGQWh7E25aa2JIIIPYQvBvxT1NxYUdeS6Yp4iXY0L/6xFOWzNC0lrHftOB2HiNOeKcAz5zxDFNVfNlBgbf7Lnnj0/NdqPV0ewsK/lVyKn2LTPah87C4OurgZJlXrYOt1/yzoCazyC+MsHaZF6Xy3zNPgdMKJuyjzEPc9wqX2zMlXx9n1M+gtmbV4D9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARtortMlLjX8cO3Hnge+IhZE4+tor8CFU9CiW4ifFqE=;
 b=imBkZM1WwmtkQmrr2BI8rBNQJgOyNkXhnKG4hYBU2Qdks35MrXABZa63OSYc5HkQEGMG8znPIsqv575+cZuIftdKVSbfz+y6OlPPwmugiUEziD3jsUAv+VVGsuzCwQeXrT+GAKlFwrKeIPgFFa85Xx+p0RF4QGRbAea5ea7x72g=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4150.eurprd04.prod.outlook.com (2603:10a6:209:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 02:51:29 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:51:29 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] dt-bindings: timer: Convert i.MX SYSCTR to
 json-schema
Thread-Topic: [PATCH 3/3] dt-bindings: timer: Convert i.MX SYSCTR to
 json-schema
Thread-Index: AQHWLSSnD0dCvszIr0qNnsfgnwi1pKiutiDg
Date:   Tue, 19 May 2020 02:51:29 +0000
Message-ID: <AM6PR04MB496607C298DA6647FCF82D3D80B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
 <1589813260-20036-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589813260-20036-4-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 643593e7-c95c-4e2f-d0a3-08d7fb9f87c7
x-ms-traffictypediagnostic: AM6PR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4150E31E1FC4417C9324953580B90@AM6PR04MB4150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxJrZzY1GMnjVX/RL2LPq3SYdZ9v0oWKjlKf8hyOkBLuetyPPSm0Q/VNagOVA0TCJIefWxvOYqY9zlgo8mh+ZtMYKbMHjfJwaRAcrxSfUgPpCJdRMsiC/RzZk4odWNy0l0cIClwDZ4iq4tp5VXDAXh5URiMh8t9fMQt8ajIDqyoVasMsX+Xd2hX6PebhHzvLBnqE2HIntyXRoriU+tWQstx7/dXFZfbVwB6RD062xeJR1jpAIXkMr/+03RrAZx7m8mir0/7mVN3vFtUVQMSiDC/8bGXIyhISdLU/Dol5/w7tjsSXUeZuDYaDnrP/Kj2Uv6PsjTFvW9tqtCCIjV0y1rKcfR14YaMk8h3AE9+tBr0okCce3vOIlQqZtSm4Fv1272Q46hwkfaSf6oZA6hBuJ+v/kOMAPNhF7Fd9IjMIyhYlGoLfoo+Q8aro2tFQdnyfDWk6s+uBPEFlp9svgbpBDR54uWxdL4K+ifOo6WJW62Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(316002)(66446008)(110136005)(558084003)(52536014)(7416002)(86362001)(9686003)(6506007)(4326008)(8676002)(64756008)(478600001)(71200400001)(186003)(5660300002)(26005)(76116006)(66556008)(66476007)(66946007)(2906002)(44832011)(55016002)(8936002)(7696005)(33656002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: p1PlWyPXwHD4e7uaNcJOdprkqGJ921IrQZv0OxEuLaLM9SHDcLLdggHOsGlt1x5k1jBkDJneE/hJNBDBaJ1TSDaHh9c9Zs3bXEuaBS/ZRamaA0lAQJGwGR9mVX3tnji1S+xTsCT87467z3yI8Rr0LsoV6VL136O2zS3P8d8CJcOVfPj30bhjnHSzZaD7Dy501yHq3rQTz455nce+vaH7T4ySZWhb3zEorVU/lDKx0/z4D+2/o4pqNEeHruD11s/SX0aAhfHcYujiIhbJqixyCyNWIiEjPcwFb+ewBHEYlmCZty9WlIgjcEEZWwrll2hEyanMmcm7pXRRv2VPkI+bvE553OdZgYinpmzWz19Y0twTq6cYz3ZdJ67Cs7Fjn6K3VqkqTJuPKigSJ1VqFvCNk87jObAA7Q2ZDPlD6Roqa2e+idTjJrZ5uYb4f9ncIwmY2IfTdJ+RwmC47i8ivaeJWNcdvS8GcilrXy/+8Pegu0hvSXJuHOtJW3DfOYcqiCvE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643593e7-c95c-4e2f-d0a3-08d7fb9f87c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:51:29.1945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE5GS8IcioQzQGcw4iaW2gJB1JaT/N9zxNm2bsvgQCvaJCbv8h4IBbb8z/SkXVAWq0i6XJ841fD3rAI0MQus5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMTA6NDggUE0NCj4gDQo+IENvbnZlcnQgdGhlIGkuTVggU1lTQ1RSIGJp
bmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpSZXZpZXdlZC1i
eTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVu
Zw0K
