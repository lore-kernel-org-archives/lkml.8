Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87931C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623632076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z/dVk1Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgDWKCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:02:11 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:15621
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:02:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDiVinCM3WcwpmakFi79F1Sab5qPgLH0n8zr97O2DQbVa2pkVwk44lpzqBpOHxnVNgdyAQqAc12Fyt0GnBWQXn1cw2tPZnVPk7P09GzJCW4htrIzdp2fPrQjfba2oKjPD3ijU2XdsB4MH9F0SfEePUPwPuzd6EwAUggS8IRK+dVfalf4zQAtr9B/D4xm5/ORL4Z4lvQBQmCI3X++7w+J4L/PEdMLu8gIU5tqNTTTFg5ZbXPMX+ehc4rwRvRban7hrtGrjX0k50TuhjZFvBnmDmkcmTfFTcaQT80Rv6gn9BvO2nV/gkzl3vnvfAYMV913bi4rdNh0SQ3TsJZlHLYQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMQt660BLVzDqkGMpNs+cPVtVPVVG47FWBE384a/Kak=;
 b=HqGZf+gEf4qzGkNBFjDxJ8P0jn9LZ0zF3FZ9UtE/DcRtlYRdB7QU6rVd6stkEV56bvzlCHAmlauISzDvokBlZ5pWk4hsNQkiwC1y3/oSth1AhnLT5eNvePcam6pln+uzROUs2jVVbviXohU/mzfKV6G+J9Ky+Tlw8IXhcfN+sDNCoEtyuapk5tFKht3qDQw0+NwZ+d/8GIklfzoUHiMiJcqlGPVdXN1YCGL9z8JxqFuqXGF3FrtU4twcWgYKNky8v7sLAaNXDpWzdvkILFjCJxl7T9Ek6NylQZvANTZp0inVaqrTgG0MG9AUjl7EJdJfbX9/8imYl00OffvT/59+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMQt660BLVzDqkGMpNs+cPVtVPVVG47FWBE384a/Kak=;
 b=Z/dVk1AjDnDGVbwCXuSgUDptWlZpAYxbB3LIb9+S26umEd1+xJ9V1zPdQcVNYHLwg70pA9fSWVIma/G9yh6FxYhCSMfi5YDHpFVhz9nLtNdRXe+VQZdtySJF2Bo4QPeH+7wpIk77dz6qiOGDtTLeOmzp1i9TMP5Qd7yG3IyR9WI=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4853.eurprd04.prod.outlook.com (2603:10a6:20b:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 10:02:08 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 10:02:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Subject: RE: [PATCH 1/4] firmware: imx: scu-pd: fix cm40 power domain
Thread-Topic: [PATCH 1/4] firmware: imx: scu-pd: fix cm40 power domain
Thread-Index: AQHWGT35VS4Ec8+XLk2j+LeMphRmTqiGed4g
Date:   Thu, 23 Apr 2020 10:02:07 +0000
Message-ID: <AM6PR04MB4966F959C6B5BF0154AE097880D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587625174-32668-2-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73c99456-876e-49a6-b5c7-08d7e76d6227
x-ms-traffictypediagnostic: AM6PR04MB4853:|AM6PR04MB4853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4853A2BB1825E12FDFE2BFA680D30@AM6PR04MB4853.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(55016002)(110136005)(33656002)(2906002)(8676002)(8936002)(81156014)(54906003)(9686003)(4744005)(5660300002)(478600001)(4326008)(71200400001)(316002)(86362001)(26005)(6506007)(44832011)(66946007)(52536014)(7696005)(186003)(66446008)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uX0DkNPOxvrnIdc0knavpiVJSyXKS6bSFKV8dddij6aJftU8rJzj+T4oWCTlFcNrqmlz9z6UNrbpJTiROQJPCReKPrRXUTHOxx2NRAWn4lJFkxQXr42QFfxk93IiaLL62ijKSorWvwyWqf5M5P0MLI+K6HZupR9OK3IGY6K7+ln8ktKL9xcdP62OdhsNv2a4h3F4WW3AYhxHWtJ9Kh/4WVssFrQlYLOBf9jkJQKC5f17xcWbHRpRUKR3l5qLFpFMzH6BhksS11pr1aqqNIiox3j8F45ItDigVJ/kOmZeXCRYJecvVasC8CqhuiK8YFX27Ii92/CoyJzfXYvns5dTDeRbLWe8rwcTjXlXekmG+n4/GH+OSUevYoLFpjBOSHmHDmLIaKZ0cPjT8ZeUtnfPBq3M6G3rMOqz871Xy0HmogrhDbk8LxoNGtMIi8dxGPxv
x-ms-exchange-antispam-messagedata: n5M0V4OySkAi4Q8d7N3V/MZmULriayv2BKEtL7zEkW/87RnkaLytm8MOCwvusXpppIpkE+mVsIsbuGgtUJ3PKPBSYrB9gAEfNP+ba1c7UjsXyGG4UJM7bZTpftZaEiBmfUyXjEeUBLQ3OYmL+XR/nQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c99456-876e-49a6-b5c7-08d7e76d6227
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:02:07.9572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+waojMn5NTNO2TOW0aZ7tNCwlyRrkD5aJzgAvarhQ0tOXWQgGfLk3xi3AW5uQWLLYj370GWFHnyEQPD0tXL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDM6MDAgUE0NCj4gDQo+IFRoZSBwb3N0Zml4IG5lZWRzIHRvIGJlIGZhbHNl
LiBBbG91Z2h0IGNvbXBpbGVyIHVzZSAwIGZvciBwb3N0Zml4IG5vdywgYW5kIHRha2UNCj4gc3Rh
cnRfZnJvbSBhcyAwLCBpdCBpcyBiZXR0ZXIgd2UgYWRkIGV4cGxpY2l0IGZhbHNlIHRvIHBvc3Rm
aXguDQo+IA0KPiBGaXhlczogNzA1ZGNjYTkxZDBhKCJmaXJtd2FyZTogaW14OiBzY3UtcGQ6IGFk
ZCBwb3dlciBkb21haW4gZm9yIEkyQyBhbmQNCj4gSU5UTVVYIGluIENNNDAgU1MiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERv
bmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
