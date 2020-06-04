Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77347C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7C0207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8SNW47z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgFDMhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:37:25 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:57479
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgFDMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYgTQG0y/jWK9hwpnfo/AUc+WLsperhvEvAWZttZTaJGFDxZSTsjDoKJ/zDrgK51rcZ2Elme5e0duyBlq12jVHqVbSjLsVPN/u72E18AxXuK03eocC7WKtFA451OZkaP27vshUWUmcv3iAwEPi2QWs/MHUNsopXWphPl1xI0cuPJM/BHFgKiNgvMnnMzDbScds9x55HbdvJPBezpuesqyMrmBoArvp4pFK8ofZ0+XyEYjFgfGgj2nqQ6vlZKkO8C8oxt+riMpLsE/XFPGt4ZjQrBdoiqfvGgK+MVo51b6mBIw4PEv6Nt9k0+eyxrW2ZTcrND+1n+VPwCSnFnFZ1geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiID6nbMwIEbUdYPBIT977KdMSZkLiX1RamZ0KIA42s=;
 b=j7c6Nk31+nef/+JumpbvxiOL1Zd80ZvA+CUrBoMGm+g9EcDzTdjaTa5T148EeK22GPTc4wvQ4+w49nUN/+wPpLL+mabQJZCVa2oPkfDCTu2eU/66p2Ar1UUZej+amHO0jhybYHWZl5emf/3jcVQxk7e/E5lgPVkwe2vr14n1OEFVvLsNWKkV8pHAD6X5tBw1BMxGcd9sv41PqSQill3jV6DYq1udaXg1WLO68fKAHDEhRKn69aP4vVCaLit0vqfLo5VDSpda7Y1C+aHnIRi3pzbGMVDfhvqPdaMj2qlw5E6QjRNZ5iuGd6TP6yu4BYWOV+w29rpWPcj96XGMxuaQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiID6nbMwIEbUdYPBIT977KdMSZkLiX1RamZ0KIA42s=;
 b=M8SNW47ztRUtxdSlAlan+sxpS+tr04pFh2l7C4zWAXmP8y4XtO4PoMGE/kkmzmsSabhueQrrPL8kKQ/W+gp6ZLfWkhHyCRrDcxSf6a49O4xBJafZflgEeU/Ucct/BKFQWs7XfWl6wMq/IXD+AeV+KPWnsyRoznvNV47JdUIK9CM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2791.eurprd04.prod.outlook.com (2603:10a6:4:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 12:37:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 12:37:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] firmware: imx: add resource management api
Thread-Topic: [PATCH V2 2/3] firmware: imx: add resource management api
Thread-Index: AQHWOVkUV/d/QUBfA0uwA7/SsB5Hc6jIHhaAgABIxgA=
Date:   Thu, 4 Jun 2020 12:37:20 +0000
Message-ID: <DB6PR0402MB2760AD01A54A194A711A7AC388890@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
 <1591155143-25972-3-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966B2E779E2B7718A1D99A580890@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966B2E779E2B7718A1D99A580890@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e074843d-5545-4bea-4932-08d808840658
x-ms-traffictypediagnostic: DB6PR0402MB2791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB279161AEEF3335F49EC1B78388890@DB6PR0402MB2791.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ujQEkAGuqWH5ssvJByfLuHbtfEf0oTt7DxbiuqrgVzXJDfdmpIN5tp5CSsJtJDSfSuo4olZtMz/W2JW+6/IRaCUlA/5HboBdK27A0IEC02IExITkHUjSyUE/9tTiJmjnidxv/CdkE0AJBPcXfU0BgqLimEqYK7j9mM/JoLW6V4o6ALHqanX1H48NCe2qZMl3O3DrC2PWhIJezqt7zVHLdiRX4CqW4cAj/OLBQ+iDrcwdw8vr6Kz17gp8Vf1EWr25kZ8ggzPdvCKb9IiNrmMGKFE5eYWNXhZXLjWrFFgWxtjaGI2yY8I75ab3rl4A2ZHRxzwodXoGSSi/lhtSk0ZrIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(26005)(2906002)(4326008)(186003)(8936002)(44832011)(54906003)(6506007)(4744005)(7696005)(110136005)(478600001)(33656002)(316002)(71200400001)(76116006)(52536014)(66946007)(5660300002)(86362001)(8676002)(64756008)(66556008)(66476007)(9686003)(66446008)(83380400001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /WWRfRRAT3rcO5Ac6dAeo8TdtgQIy0/9zDKp/y9ONC4EN7hkGPxTkGyOiRSwWNGL3NY1+TiIkOuTGHxXEzd1SORUhE3ip64LoaGT/JC8OdqwvUeKzHbVKvXhH5p5o6Stmf/fgVM6G53vliDAvS9Lgp5u2jkR3VzyYRiS7Q3AXxQ8GeHpqZ+E7TvQYn/9mbVYaz1CMs8En0iyeSgLC+7NACrUfpXvaRRzV3ft7tZHNIR3SqN9fc1Ho8tFsWOWotY5PuvEaha7ZohXrUeAWLZAszkz2zsCrSNLMb1MUKSylh6NWiXIK6JyFPPmyhvk9Fv187pX4g7K/zsQFcp1Pst7S2fByjE0XdcyO6c8YLCAQeLwBJjwtJSc4mTL0gR+ijgRZXve2Q2c00YsWaNsJnluH7e+hRFDOYkt9HoTkZtSGtrvAUzAGbGWYK2piaTp6JtGtKIXEC5EJZFhAblwhvb+sRCED7P3s/1SnpBTtUP9c/Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e074843d-5545-4bea-4932-08d808840658
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 12:37:20.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NYPfcnffheMB2g3+LgoqZsEUDOlpctlsp0J+TyMkr2f74MgwYtLEQ/3vAiUHuc6Z1hXU5+5wqy8vUPAnRUpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMi8zXSBmaXJtd2FyZTogaW14OiBhZGQgcmVzb3Vy
Y2UgbWFuYWdlbWVudCBhcGkNCj4gDQpbLi4uXQ0KDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdo
dCAoQykgMjAxNiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciwgSW5jLg0KPiA+ICsgKiBDb3B5cmln
aHQgMjAxNy0yMDIwIE5YUA0KPiA+ICsgKg0KPiA+ICsgKiBIZWFkZXIgZmlsZSBjb250YWluaW5n
IHRoZSBwdWJsaWMgQVBJIGZvciB0aGUgU3lzdGVtIENvbnRyb2xsZXINCj4gPiArKFNDKQ0KPiA+
ICsgKiBQb3dlciBNYW5hZ2VtZW50IChQTSkgZnVuY3Rpb24uIFRoaXMgaW5jbHVkZXMgZnVuY3Rp
b25zIGZvciBwb3dlcg0KPiA+ICtzdGF0ZQ0KPiA+ICsgKiBjb250cm9sLCBjbG9jayBjb250cm9s
LCByZXNldCBjb250cm9sLCBhbmQgd2FrZS11cCBldmVudCBjb250cm9sLg0KPiANCj4gRml4IHRo
ZSBjb2RlIGNvbW1lbnRzLg0KDQpPb3BzLCBmb3Jnb3QgdGhpcyBjb21tZW50IGluIHYxLiBXaWxs
IGZpeCBpbiB2My4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiBPdGhlcndpc2U6DQo+IERvbmcgQWlz
aGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCg==
