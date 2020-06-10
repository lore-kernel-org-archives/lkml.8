Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0037E2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jM7E43Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgFJH5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:57:33 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:59654
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbgFJH5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGu8siHX85ySUkmiBPGMbmrrYsMo8wc48HMVPlbrlyqd3uQe7fZ/sBFK9HS2LsKXaT5HyNlDI8zzynDqDzsGmmLPdsdn0TUPTLIsI1pXZeIfDhUimeR/8YmvhzMJL4yGFT9Mk4065N33v3DUNTNo72qKy77BkyprWa9kZ3+GHytrVwfS69NAgH7DvN2foo9ow9LtQEoC7vF/GFA8FDNmb7xCg1m6gKzZowy26Ls9tBHlDKkyYvmPsUJhFqATBKpl9oRIyqof+yoQwIY92O8X11ZcIQG/d0UTYb9rIfg8s3kKqSPQRcW0mtoxaEgK6Sz0A3wuCmlefiDvw7n899urag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7OwL9yJE32DiKSAfzhGSe31qC/1o22n16dBrcralEw=;
 b=jpR4CB3cvwsdqi3uMZNyezu3BE/RcGFHbt/iKBjlPMQTuuvSKC8whxeAyDI7hRnhyuMOx1SauMu+YTVnfxCF6HTlCvnoo0noIXhZ87Q2Eta0IWWHz+MULAPrey26+j/YZ2MUGMsp3Q4M+9ucLI79HVssOQptuvccg8fEeu9/K0CPlSVSIWukmV/HpA8upg6mbsMWuUGrMSNyvuQ7EW1M3Mse19b4Afxz8Z25oCX8kusHRHbY6WPH0Ow4bBY7WcLRz+HLd2q+G0qyfDfZTFIcfWSWR4u2WmVWOFhcFTQnjP1T0sbIv9pQAz5/gtCs2GGVax5P204B0hFZSloqBhOrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7OwL9yJE32DiKSAfzhGSe31qC/1o22n16dBrcralEw=;
 b=jM7E43GkEvOut6zsIiBaUNbToXnOUWbDaFt7fp18bywHHRxUhlzGtG2mM41T47LCJXLAVOKzu8hj4UIqXTKzv8ade5NeIvAdw+SK+UrZSFCYtIvGdvvdBfiBY4gzxyzCtJmNyKeY1MY5xa7qr99v/QT045YkjWsL0+1zQsLJOxw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3801.eurprd04.prod.outlook.com (2603:10a6:8:3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 07:57:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 07:57:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Topic: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Index: AQHWPrCw0WB/imHNuUG5ox2m9H66cKjRezCAgAAAlhA=
Date:   Wed, 10 Jun 2020 07:57:29 +0000
Message-ID: <DB3PR0402MB3916F5F4C797595437D5FBE5F5830@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591742515-7108-1-git-send-email-Anson.Huang@nxp.com>
 <DB7PR04MB4972E7B649B935B1EFE6469880830@DB7PR04MB4972.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4972E7B649B935B1EFE6469880830@DB7PR04MB4972.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0dd66b4-6414-4788-ce14-08d80d13ec63
x-ms-traffictypediagnostic: DB3PR0402MB3801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38018448B146AB3440EDB7D7F5830@DB3PR0402MB3801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CS+4pIbcICZCX4T+DnxNpRVOM2tohmM3X55Yteue7Ljk4wCFAuPTElvjvOzb7weK1ruChX15e8j7gGchaGLy5bkhDBOaAl25XVX+fWrTYtBuWhmVG7EC9L3LhwGcrXTv8gHEhrRLQNiEdwBNgFA2MSf8kU2jv+Q6EYV+bgE2E8UX55ih4s4npMEfN1CnfrylLlY+y8g60ZKZi9Ml/ESFw72O2DIukV7BOxp3LPR/p0pdooZq050+L1t98atb7MqOp4/hccsO8W+CCQhk9xslRXIcC8IQ34sB5Usy4Inw7Py8TrlH/ADT+OeaLa61TMBhdPecaz+Jp4aLSSFAws+6rWE86Qv8mcjpsx2RtIa7Pk/rBWx9klGTHjL9Np4rBUIkU2pGDdsXH7nHIMS4mCwKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(186003)(66476007)(8676002)(66946007)(33656002)(66556008)(64756008)(66446008)(76116006)(2906002)(478600001)(316002)(110136005)(5660300002)(4744005)(6506007)(71200400001)(52536014)(44832011)(26005)(86362001)(8936002)(55016002)(9686003)(4326008)(7696005)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UCCInhshZiukBATua2KNvXZi7emWALeLPK9pNJr84QV+gJpg+1XjhTTseWAYkYDWmLe5b0CPjufuOELWAUhFQ5dfvxT8VtrdULQsQxWw0HBTtPd1bgUVCnYPzEiJRtCssrKzUuYSEtq1EDsyNFEBPrDpa8UqG3iYg1TdIzrIdkuzkGr4ASB9v2EZQbKgprnbg/IhFX7V0Khw3omjcjSLZLL1j/Aova8ScM4YXkFeZhfkKEIZAoQMopZBWTams7K0dAzn06ly7TSJcB2aDyWKuFier1plOe2qK0Oy1iGkiWO+MCnVIV5bh4Ti+AOAu7e/gYFkR2tHOqSHwZDheEYlJyhwQBeEsdDG/AcGbbglh3O3uYTgx+MBw6+luimMFIxZOJ7PezZ6i5N15jdWciYwWrQZwVWn6fY1cq3rjRuVk/tdLkZmFoiNr9dsADHY+anZ0S/E9U1AGgvijZ79nxKA5eP5+jANhT51wyRR4UJVSIuX5EiJGOhKdlDtREGhIL80
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dd66b4-6414-4788-ce14-08d80d13ec63
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 07:57:29.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Kjc4W6dqYGi1hVyhsiGDMYE4eOM/43hsXvvyAaBdwfNJ9VwkrqxLJ6VxeyHWzgZYgIu6G3kq7qkX82phf2E4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjJdIHNvYzogaW14OG06IENvcnJlY3QgaS5NWDhNUCBV
SUQgZnVzZSBvZmZzZXQNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDEwLCAyMDIwIDY6NDIgQU0NCj4gPg0K
PiA+IENvcnJlY3QgaS5NWDhNUCBVSUQgZnVzZSBvZmZzZXQgYWNjb3JkaW5nIHRvIGZ1c2UgbWFw
Og0KPiA+DQo+ID4gVUlEX0xPVzogMHg0MjANCj4gPiBVSURfSElHSDogMHg0MzANCj4gPg0KPiA+
IEZpeGVzOiBmYzQwMjAwZWJmODIgKCJzb2M6IGlteDogaW5jcmVhc2UgYnVpbGQgY292ZXJhZ2Ug
Zm9yIGlteDhtIHNvYw0KPiA+IGRyaXZlciIpDQo+IA0KPiBBRkFJSyAiRml4ZXM6IiBzaG91bGQg
cG9pbnQgdG8gdGhlIG9yaWdpbmFsIHBhdGNoIHdoaWNoIGludHJvZHVjZWQgdGhlIGlzc3VlLg0K
PiBOb3QgdGhlIG9uZSBjaGFuZ2luZyBmaWxlIG5hbWUuDQoNCkJ1dCB0aGUgcGF0Y2ggY2FuIE5P
VCBiZSBhcHBsaWVkIHRvIHRoZSBrZXJuZWwgdmVyc2lvbiB3aXRoIG9yaWdpbmFsIGZpbGUsIGhv
dyB0bw0KZml4IGl0Pw0KDQpBbnNvbg0K
