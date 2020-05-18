Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8883820787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQkTxA87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgERIpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:45:52 -0400
Received: from mail-am6eur05on2066.outbound.protection.outlook.com ([40.107.22.66]:30656
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgERIpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UESUKORcIO8fVuyiM5dTzQa8bceE1LEAKc7CMgCgF1c2OOE+7Hta1BW1bCxGfvU+S/l9zvmFZ0fV4bmZe77VilR+9EiMiRsYby6XJBV4kGq9qs87aA4Y98Teppl4pTc7IoYDnlp0QM7Frhf9lq9eT+v/7itZhE6/NhP0oVS860Ae+0d4BaFzSxM8mbJFpD3lz9o8gXFFjzccPpP1JjpJRR/L6EYnKnqu+Zxw72yhdaMm5CEfE5zTIXnN/NlhxqsIpN0xxO3pUljX9d9mkwpn8RJY+8VNfvSb48ezx6xEQkleLxzexiQGk2mspwEhWDnMUH7feuHgPvAz7GPoX263QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/wMF6dazTLM8tKQBjQQhxOYoSosY0+Phv94o18lS4g=;
 b=WVkbDzuCCcaOO0Yb1lSLz//6raqsR1JFM3HnpM0QiAMF6w2OkFjaeZIwY/xkRxx+qSVkujkVAwjpZhKZLBg3kDw9vvKciPqmXBAAoQ7lMrxWO1e0UjYP3GUb45vyd95mEtpUGzjQR6YyNrjmEtljJbYiolvwWZahVRJKfedVWYXyBOWrD6R6x6NxCRTyJLy92KPUDCQ/lKlB/2vFdHhcIySuxBOySqHFmmgfERW82DjY1hhTJSOpVQbNy5+XjsTyJsN4OBhZEdol9eAoch82shKHU6ojtrppCv1kFtVQxhHwAA6e/NJmurm5HoQWF1o/WGStnFkqZv8oiSVNoY5OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/wMF6dazTLM8tKQBjQQhxOYoSosY0+Phv94o18lS4g=;
 b=GQkTxA878qrwl/XRN/UPsXGqEOqwx7DQUbDbsddDJ7aqYgjBfOrkkUQZRZevdzBTzQ1fSMSgvxba8p34LL0NhWEslNiS+14krcH0nzAXLw2P4oTW4Xa8Hx8q4IpR/GSwuCvwklT9wj5dk37Q6ffwXSJP+FN1Q0LG7BCNoE9Mdek=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4999.eurprd04.prod.outlook.com (2603:10a6:20b:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 08:45:48 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 08:45:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] ARM: dts: imx6sl: Use nvmem interface to get fuse
 data
Thread-Topic: [PATCH 2/2] ARM: dts: imx6sl: Use nvmem interface to get fuse
 data
Thread-Index: AQHWKY2ONnVOEaMUokWwE7Ybd1YO1qitjjHg
Date:   Mon, 18 May 2020 08:45:48 +0000
Message-ID: <AM6PR04MB4966EB7B142636A825A150AA80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589418528-26410-1-git-send-email-Anson.Huang@nxp.com>
 <1589418528-26410-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589418528-26410-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 739cf9c9-1b44-44eb-3d28-08d7fb07dce4
x-ms-traffictypediagnostic: AM6PR04MB4999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB49997D32D164BC830E6AEF0E80B80@AM6PR04MB4999.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /k5mbDMg8JlQsUBYaygkmBeTuqzp7I8pm76N5GM+DAB1oZGXT0EXiTj7KeKQGDaIVZ+mxluAfVEi9Mm5iM7AmUrbdyxfCeY/ayY2B/hltptiv+pNtxcHN4da/JhDRYRs1YPNGCePqLklWHOqPzN794n8rN/XqJVcFOMiBgnQ2L/OZ+RWgUYegKwnTr1PitJrjzMMJOLYvqlbipFM1DjEEbghFibyfmt3S21LMl0UQbhmlHWiTjHHQgw76HBdFZgiPq4fJdYsc7mQP/q+85cajV159j7kaPK6lSPpbFkyHZjT1sLDcYNIS4Ukp1eFJzx5TI4p2DdEzzta4vMSP57BtaMdpuFsTqKkclDCeA7hqkxSFJnEMd4ST3r27LfRha07qS5Xx0YNoN8EoN8Moiwo3VrGOPXrv/6LBtb2L+0y+tZYxEvICU7KvBTzKGT/RiK1RPxcyy1y6ocUREo9xmfqBXwdQalM74YyWq9d1sTLIiYd/nB6XcxafNri9iX7jDCa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(5660300002)(52536014)(316002)(55016002)(9686003)(7696005)(4326008)(110136005)(6506007)(478600001)(8676002)(8936002)(26005)(186003)(66446008)(64756008)(66556008)(76116006)(86362001)(4744005)(2906002)(33656002)(71200400001)(66946007)(66476007)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KkYzhOuZdfDg/siVN5u1L1rmywumUYZgLHQBxEh83MNKGWTf1t+f1+I4gTDypaSqy51g/E7JsuMo+7qpaZYv42T+otVpi+RQSywQP6863KimGd3DMIn1UBeUSxwVHjonlmjkMj0tYWKofd8AQVbvTegecQrwP+l6FhAjWEJWO2f5PUeq6+Rr4JJFZrw7JztX2gNJnJZ2AGn6hcNd/4BVERMrPSqbnKYGPDcGzYfXyZ1W8o3arpnRzIH1XyNub4tjI25bamHKFlYK5lWwcnz3Qm3Y9xZOgxofJHoq7tvUAsnpWJtbgGfWhl9pbv6rN4nQ7kGunpfNWpZBM3YqgDl7wPDwrHnnTr9OwHtj2S7a1m5XYv9V+3/cd5Tzy/Sdas15OOwO+Bhy6IfKKGtsYZTdp8RqhZ0XfBHWrqWchtPYLyQ7Hw9QlVnptL2Yikp57La2KfBVTrFqZR+lz+6Jpety4s5mWzQFFlSWNaHm8DU1a5MQLwC/e17Q9imu+dtiSibi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739cf9c9-1b44-44eb-3d28-08d7fb07dce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 08:45:48.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQcopyR3BhAeEbm4BuE8Ii/nwM6gOrRHSIZCZok8ARoh2lDG3sbwpG41ZzZiU6wX65EW6qWBe/1bFo4aJY2loQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIE1heSAxNCwgMjAyMCA5OjA5IEFNDQo+IA0KPiBBbHRob3VnaCBvY290cCBjbG9jayBpcyBh
bHdheXMgT04gZm9yIGkuTVg2U0wsIE9DT1RQIGNhbiBiZSBhY2Nlc3NlZCBkaXJlY3RseSwNCj4g
YnV0IHNpbmNlIGkuTVg2U0wgbnZtZW0gaW50ZXJmYWNlIGlzIHN1cHBvcnRlZCwgYW5kIGZzbCx0
ZW1wbW9uLWRhdGEgaXMNCj4gZGVwcmVjYXRlZCwgdXNlIGl0IGluc3RlYWQgb2YgZ2V0dGluZyBm
dXNlIGRhdGEgYnkgcmVhZGluZyBvY290cCBkaXJlY3RseSwgdGhpcw0KPiBtYWtlcyBhbGwgaS5N
WDYgU29DcyBhbGlnbmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
