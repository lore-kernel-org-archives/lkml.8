Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F2DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF05820787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gNzsaVy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgERIo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:44:59 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:17438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgERIo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L59aOvSnuc2MU3qFmetZR/9uq71ocJetFeAcNpSLTDvW8hbnsQ/AISnokEFCjaIfN/V9SR5P1J/zPVZqJnoxZOYzDU7The3RBixzKPwzxQcz7Eh9ckQRHGRDOx4DPoeshFSOOV48Pa4m4ODScpz/OfXRaK68zVa7ie/3GDlxK9p6zLVes1mxLnFvke19j3fHa7HGkbalLJriG0ehp4/wCbBROhhLNZPYlHMqSCrHoYXdaj7YzHINwlONsDdNPQt+P3fo0GIpNjscKJCN5O4DBoW8KVO+uKNbkZF30S9atN8Z5M8Q3GQDbp3ZyLVnST/1SwuXAsw+zSE1cnMIqNDctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4ZfTzF/VHX/IxAp6Vy5mJRh5UMjYzxVxmkiyD/9tOU=;
 b=Ou3H/rPIlcrrE4zTw476RYEX24Yum+YAWa1++jRqRF6S56MDrUk7AKq7EhPPFEoxuElhFfkDiEAc8VWO04Cx/PVondNrqr3NYE0dkDeVb+NOvqHAXNv6k68Zae7+ZzEbUKly1bcexuLOtgNHnsvMUGLDP/S10Kqqt8G5Z0MWm2oMTM9BNgjkm9VXAyXNVvhi7IbUS/787b9u7Q55T2qFkYscxswgBu4SDZMdSo7bBwYXkQicIUhFc6BED+UwTTlOjR5fd/MKANUtis7WKlbvHhcshOxCZy0u1uV0Grle34tgGGvikhc95yvwrk5PoTQDcpzMiFHAYXZ9ZX99nqHhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4ZfTzF/VHX/IxAp6Vy5mJRh5UMjYzxVxmkiyD/9tOU=;
 b=gNzsaVy44biKuHZsoqjv5JpDNTYHje4oveKdrw0ovpsgok0sTLWUU+99y21jrWlHRGA1VijF9quD1OKOljOSISwg5kSrWTTdhuIENeR3KXqOC7TjH4nnmjLXKEJmmVnNGZgM2PI/pM37XmCHef38LwLX5dwAXqo9XE6G2YpdHe4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4120.eurprd04.prod.outlook.com (2603:10a6:209:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Mon, 18 May
 2020 08:44:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 08:44:54 +0000
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
Subject: RE: [PATCH 1/2] ARM: dts: imx6qdl: Use nvmem interface to get fuse
 data
Thread-Topic: [PATCH 1/2] ARM: dts: imx6qdl: Use nvmem interface to get fuse
 data
Thread-Index: AQHWKY2Nff+uSdQzb0mgNHq+guQUhKitiANA
Date:   Mon, 18 May 2020 08:44:54 +0000
Message-ID: <AM6PR04MB49665A2E7AB525E8C7627F1180B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589418528-26410-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589418528-26410-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18c88c78-f904-41f2-8600-08d7fb07bcea
x-ms-traffictypediagnostic: AM6PR04MB4120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41203724686B91EAAF41241080B80@AM6PR04MB4120.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+kgXgWdX7I7gtmm3DGz0jGn5EDxyNtKCr4OsYJHr0f55wykoR2reJcdkejCkdrqthLBvCEcn6xpC+FjwOYCTaWD1MDjgnzFh3UqJy9tmfzgl0HYHeX5i1m7Ph5wPweiwmS0ia2tcmlk7ERm9miSsi2tAvr0nLuHOevDAwA+FvmuIDglF+cqkb9DowSxTYShZ8+C39YlCcQ2Np2pKLDvLwi8B0OTfJ4k3bIhugRE87n8KqGkVWSYfLxjfzmMRcAQjlZQNFuOQnyTJ7aAfsxo8KSMciJXc6lnbCL01NfYT1EpM+TAHDFL/SX6sHO1i7hTcGxTUrFgqeGLWZt1mc8doE4AopiteEBx+eensFcibvORZveZHnMPXMjkGd+fde5Iuj62gsaKTtc4IS09ZDD34XAq8K7PYmmW9OdqlflhO+2gjtEMUry4HfvOo42Mj5Et4A4BMRmLdl4/+QN2adc4AkSQXT2Y6aauj3rTTnq6xET8B6sfskJ368K2rTUmjx1Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66556008)(64756008)(66446008)(66476007)(76116006)(66946007)(86362001)(5660300002)(7696005)(478600001)(4326008)(2906002)(8676002)(6506007)(8936002)(55016002)(44832011)(71200400001)(9686003)(52536014)(26005)(186003)(110136005)(316002)(33656002)(4744005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: irXoVF3U9ugrN9aSpekwU+39eBrO5Rsht4q9YOE8fhX2wtj32S+KWR7UyFP0/e9t6TAlKASb8Q+mYYm6nLfPlnhzwjO50tCBv1Bp+Zq/3l2fmmhJgqEE1h/f67oJkbk2LVl8yp09stIChx/PraBDWMkfQTGG+VwXucRnGJV2uAHbjtucD1XRHEQ9jcOfheB81T53O0Uq6xpVeRUtHh/68vlQxGPmDD9fcMzyP0wtu0UziFRsmfW2iUVMDirvuoPfSle05tvSyCb5KSGyqdJPFJLYRz+aiRXdQXUW9chgAQ9vnnYz3pxTyWjU+xf/9UAO+EUs5tz4vrRofJGhOVjuuZxelbp76kM0DClzCxbPNo6DMQ85zUgKFZPp7fzbLD4bs+3HFro8tCUrw1d9JmshoTTG8tg7rLZer6PqTTM1ili0GHGaa8vyJi6sVsFBgGIBJVhbcHoUoiNHK8QvTJB6Am3Lwa6m+KtZupeXBVYMJgCuZmcOeEPt05iWL9zhocRn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c88c78-f904-41f2-8600-08d7fb07bcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 08:44:54.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j7ipcIEMuya2Qk8vAS0Z6gHv/Ldky+h9no9owKdyzwy6KhXbuZbI9T1TwONkg0vMrJs0hQXteAqvAaezX/6bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIE1heSAxNCwgMjAyMCA5OjA5IEFNDQo+IA0KPiBBbHRob3VnaCBvY290cCBjbG9jayBpcyBh
bHdheXMgT04gZm9yIGkuTVg2UURMLCBPQ09UUCBjYW4gYmUgYWNjZXNzZWQNCj4gZGlyZWN0bHks
IGJ1dCBzaW5jZSBpLk1YNlFETCBudm1lbSBpbnRlcmZhY2UgaXMgc3VwcG9ydGVkLCBhbmQNCj4g
ZnNsLHRlbXBtb24tZGF0YSBpcyBkZXByZWNhdGVkLCB1c2UgaXQgaW5zdGVhZCBvZiBnZXR0aW5n
IGZ1c2UgZGF0YSBieSByZWFkaW5nDQo+IG9jb3RwIGRpcmVjdGx5LCB0aGlzIG1ha2VzIGFsbCBp
Lk1YNiBTb0NzIGFsaWduZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
