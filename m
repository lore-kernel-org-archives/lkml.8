Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCFFC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0DB2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYN1glLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgGMKDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:03:45 -0400
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:7587
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729601AbgGMKDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:03:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxcSja+gBRGYZpNFyj8Ov6wNPpm5TjP+9ZUZfFz3/ZCLc/+WAPLojmvAg4yBb8U7lfWNKMvs1DlKY5S0kOq7DeFTtR6Tl8TObfo3NjQpYHqAiiBNpJbxUcGICK/qRqeLdYM3tNGmCaHOPvYUzILezJ8ZnQFFxABX1zGoAMRfCE3822DwDaSDeLGsHSvCUQuwXrBdFcV1wb3jFbcmGbnN6RmEdQ4IeTtcJUjq3ek0kLikLFLNyHq4EqKXLezzkbF/KV6LniWVU4y6UqYNMLl9kSUY+za+NtmluDt1Z95m4BCOMc4KTjT7wIiv3v3/5B//MIW07YQiZ2xkoqJddWIpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHO1CEad1COS4984KxYAVd+XPMPYsns3ZlEtaE4Woy8=;
 b=n2hAL8puAR5ItiHSDaeMbg3bQdbBkPNLw2Sijh/XJm1P5MpoEq2yNr//f70XWOENSUFSB7mojXmXnBKfH1t5b9y1c092ZepxCiS9h/ThG58hdnob6BgiucepIcgi09Mf9yBlvMPhG/Tolb2t8qKCp4QEbraUeMTOgrmj9VwRnmvEvGMtbacL++UkHzLVOzI7FmaHvaJNmInxY5r8sutvSig4cb0b+Phry5BpY5XzgW4mBH+wEYx3XUe9+KTyAHQ/E/JbFLx2I5VUBKpSxnX8Ugt3D38XrQnDj8mLD8YdM5rwONziQJF2fsN1Oj+KjxW5F7gmGEGpWTenFEEkQE9Q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHO1CEad1COS4984KxYAVd+XPMPYsns3ZlEtaE4Woy8=;
 b=GYN1glLqLLbxEKzDP5PIzZ9WnJ6s6vnTlRy5xQ5e65own2kLZdFe/fYSgRvhGdu5Uz+dIa5+Tz/9ZnBvqyrrgW2vZVId3vy1oVTt3kpsTh9zEAMN6yWTCK/lqOqeuc9yLB/ugbibnAWMEwXQcGdzj+jyovj+SIk96IEqkcWriXY=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 10:03:41 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::55cc:a617:ffd3:eb25]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::55cc:a617:ffd3:eb25%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 10:03:41 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] drivers: soc: Fix mailbox suspend/resume no irq for IMX
 SCU
Thread-Topic: [PATCH] drivers: soc: Fix mailbox suspend/resume no irq for IMX
 SCU
Thread-Index: AQHWU6YxQJL/Xc8i1kihmGR168r2DakFUk3g
Date:   Mon, 13 Jul 2020 10:03:41 +0000
Message-ID: <AM6PR04MB496663205D0EE8E6EEF731F680600@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200706150013.35326-1-vincenzo.frascino@arm.com>
In-Reply-To: <20200706150013.35326-1-vincenzo.frascino@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b11cd065-1d12-41f1-0e2e-08d827140533
x-ms-traffictypediagnostic: AM7PR04MB6775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6775D869CFCC66827FFFC43E80600@AM7PR04MB6775.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4zLmyEZqpOZAIF3BhkDLnBemidg6Govrldtfje/PzWh7zXVJivs5/iPn0VZczP/NW3YFTxUAPjsYY+Q+mGGZMCXxARYHpF9G7lqGorJ/h2UmXa2mzGZ9l/Zdfu8f886IIRtvIn+mQoarc9y6b8p++JdtMszB/rf0t4JN2QoLoCq2ueXc+s/xxTVtWLkE+o6lc70zeWjWTG7ulD20rEw/uY2zKNO8t8f2BrpNomLyZdpT5bnfOkqi4qmWdcGYAGJvsdDaAz15I3weRG0WGeSYiq4aIF4CbH6TfHeM+Flfs9XKFkcxRrKKQMdBiEtiYypzuSh4XrT5GXA1ltYXmKTgD5HHBwePRpBRX11NwsuopP1oCLkjDwMpQ0Nt7D7yCJTBVL3OmtntFKAwWskTISQFYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(7696005)(8676002)(54906003)(4326008)(6506007)(8936002)(110136005)(33656002)(71200400001)(316002)(186003)(26005)(76116006)(2906002)(83380400001)(15650500001)(966005)(55016002)(478600001)(44832011)(5660300002)(66556008)(66476007)(66946007)(66446008)(64756008)(9686003)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uB38rDxlGeQkFurGtmzieviJrWaIJFIV1zYdpylO/nBfBtgORB9XfqntNT/svUG4AAmr9ff0cQOkbWPyk+eEabNSUMErzq+w3BB34MzqrXtMc0592XkwOJTiFo+x1t5bZs0owz34jiGHuCm4Qc82uvjWZSjvbkQoOGD+P7fVGn5wN5DyuxKEJBqfy2+CijXjBZvOxQ9n80uPOte9h/HLruTqs2y6nWlhXOHUvUCrYZ/OepR6QfJ03Hj/2x2G1csO0d67qEWs6Ur1EKNCbGCoSmPJyXGA/880nT/Oi8XdBtQHYtw4U371C36qxAdkMx6XwkVOM3jrUkospkxbadM/NN/lBITDNZrhIvYRK7kBnzyw6MqgJNs0BAqFV973md3VUAe44Rt/C8kw1SQ+7azI42WPKVC3HkuOO8zAMdvj/uO+F2GoSrsWWRrk3ioaBL8ZaiDqq0hoFk4XmwZMZtTc2CJVLaXTQhvzWWinQ8CRa7P6ni8ePB8XDwucgR22SJ2Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cd065-1d12-41f1-0e2e-08d827140533
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 10:03:41.1937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +npyTfPDBOmB9YZ034wvJQS2A15dA1EtFRQ4TzyKD4mV5ZX0VkvXaKtBDSPltqDsGDyksmWoHh6S/7s3Vg5egA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBWaW5jZW56byBGcmFzY2lubyA8dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbT4NCj4g
U2VudDogTW9uZGF5LCBKdWx5IDYsIDIwMjAgMTE6MDAgUE0NCj4gDQo+IGlteF9tdV9zdXNwZW5k
X25vaXJxKCkvaW14X211X3Jlc3VtZV9ub2lycSgpIGFyZSBjdXJyZW50bHkgdXNlZCBvbmx5DQo+
IHdoZW4gQ09ORklHX1BNX1NMRUVQIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBpcyBlbmFibGVkLiBI
YXZpbmcgaXQgZGlzYWJsZWQNCj4gdHJpZ2dlcnMgdGhlIGZvbGxvd2luZyB3YXJuaW5nIGF0IGNv
bXBpbGUgdGltZToNCj4gDQo+IGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jOjYxMToxMjog
d2FybmluZzog4oCYaW14X211X3Jlc3VtZV9ub2lyceKAmQ0KPiBkZWZpbmVkIGJ1dCBub3QgdXNl
ZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+ICAgc3RhdGljIGludCBpbXhfbXVfcmVzdW1lX25vaXJx
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQo+IGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5j
OjYwMToxMjogd2FybmluZzog4oCYaW14X211X3N1c3BlbmRfbm9pcnHigJkNCj4gZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KPiAgIHN0YXRpYyBpbnQgaW14X211X3N1
c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPiANCj4gTWFrZSBpbXhfbXVfc3VzcGVu
ZF9ub2lycSgpL2lteF9tdV9yZXN1bWVfbm9pcnEoKSBfX21heWJlX3VudXNlZCB0bw0KPiBhZGRy
ZXNzIHRoZSBpc3N1ZS4NCj4gDQo+IENjOiBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJhckBnbWFp
bC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBTYXNj
aGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBQZW5ndXRyb25peCBLZXJu
ZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiBDYzogTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW56byBGcmFzY2lubyA8dmluY2Vuem8uZnJhc2Npbm9A
YXJtLmNvbT4NCg0KVGhlcmUncyBhbHJlYWR5IGEgZml4Og0KaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMjAvNi8yMi8xNTU1DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGRyaXZlcnMv
bWFpbGJveC9pbXgtbWFpbGJveC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gaW5k
ZXggNzIwNWI4MjVjOGI1Li5mNTRmMzY5NDg0MTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5j
DQo+IEBAIC01OTgsNyArNTk4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
aW14X211X2R0X2lkc1tdID0geyAgfTsNCj4gTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14X211
X2R0X2lkcyk7DQo+IA0KPiAtc3RhdGljIGludCBpbXhfbXVfc3VzcGVuZF9ub2lycShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGlteF9tdV9zdXNwZW5k
X25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgaW14X211X3ByaXYg
KnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gDQo+IEBAIC02MDgsNyArNjA4LDcgQEAg
c3RhdGljIGludCBpbXhfbXVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGludCBpbXhfbXVfcmVzdW1lX25vaXJxKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgaW14X211X3Jl
c3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGlteF9tdV9w
cml2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IA0KPiAtLQ0KPiAyLjI3LjANCg0K
