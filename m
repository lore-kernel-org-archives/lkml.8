Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CBE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YmaVJ5b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETGqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:46:40 -0400
Received: from mail-vi1eur05on2066.outbound.protection.outlook.com ([40.107.21.66]:6077
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgETGqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmGmIvDtc8thoWQQiC7o0XyBiVHzpq/PqeR8W3bX3Xq2LV98JGGq+YZUfigRjBDjF4dd5v0l+JVIjTgdULcOvzEZ3e5MyMxcgiSKHbrBFWf+N8LO77+m4h5rm/JuEqA7r77MqvyYAu+b40i2NWMzd7VmU5A8K3Os5g8B4z/UY8uYMXfozAeFvy4panWA0v2b9BBQGvNQI9LkZITsS4T5LeXlWuSP7W/dbEOOIRBLn2bARbOZQawvFhmdhxWiOz5N2K8bvRdq696p9aTxnldSviewBjgExQLAgWzRN9RWehhoEYQIue1GHMrqoXTddB/ouo9dQEgRVR1gvAYcTZylyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvdOZeXO0hjYVcoC/Wu3Ndo4zzPVA3pxbNXW9OWGksY=;
 b=ji6tGdwVcchtIrCxX5b2rdAVuE3ePtQO37A7+7xyQnABMqLgAhEy6fmrix2MYKrDIP+mphKV8ZhXRRg0qcx1ArIML1GePheEn+ux2bybcagxZH0Om63RpEUzIFbtZdLmV1mbfeKSzvI8CEtOYN3nVzkiH3Rcuwcrpd7wm5608yZL6eo1l8RQfMSSg/jD2bSwugZ8yqahdWI9N/7YGZKj4EzxUOQ3ICybMFlKMw07udyhJJD6ElAeJXswtM7wISeCbTWC6xrom+v4ODB54QU50ICcxR0ciEEajttrbqDd1asYLd0/+QU7qyjxxKBY2Ov3lUplqSKCfUq0DCUjBTw+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvdOZeXO0hjYVcoC/Wu3Ndo4zzPVA3pxbNXW9OWGksY=;
 b=YmaVJ5b8vsvgy8iU5D/EfI+DWtzdeOXDO9MpKZwuvkDqJal56v5xJBJjj0PeaBf377PnjK2flQwf9JfmDGIzZh3t3pTNRgE2+UW1/egI6INry1yWmzrUYoBhKx1AQXM8GzCZPjwHNUVfUlC8AZGibjPaCFEoMmtxucD5cvlpv4c=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4935.eurprd04.prod.outlook.com (2603:10a6:20b:7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 06:46:36 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 06:46:35 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/3] clk: imx8mp: add mu root clk
Thread-Topic: [PATCH 2/3] clk: imx8mp: add mu root clk
Thread-Index: AQHWLkxwbNYAyOGGV06xbpdJkiUISqiwh9ow
Date:   Wed, 20 May 2020 06:46:35 +0000
Message-ID: <AM6PR04MB4966F6FBA01677BCAFF3E43680B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
 <1589940278-3680-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1589940278-3680-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8080a0f5-edff-4666-49e5-08d7fc898a26
x-ms-traffictypediagnostic: AM6PR04MB4935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB493503AE280A2A0762D736DC80B60@AM6PR04MB4935.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DenPpde0Fb3wvZPydZirC2aG6O9yWC2O1kLPZgtgSi+nztKw/Zw4jGjmL9g7XCn7T2YIIMpfSoekCitD3L5rOHqqrqt2R/ZKHYtJMiWvi2FE0WVPiG8vXSKHDTwSrCfTleClPOXJ7gGt3xgg5Wsb/qB5zUAEPPr4/NQK/45esGD1fZiobYmdZHdBEIUEtyS2H4UxRZ7JaxJ5VRFXxPbYurZPW7G1rFi77eVLX+8WHHgJjuKjChnb+vw79NKGQtTnSzlgiidOiacAjH26WktzA6bzCZc+W/q3aOouAOetfwfiSgMx2+tlLKs5LYqTndGxxngTUap0eLK1neJQKr9Lbx9Be0PmFSi8izX9C00g8fW0G0nAvBongwpRyfelhQ4vBBAbhCz2FmvF8qQ9Sheh1G5QZOfQIIq4YI7R3yFUNgqARX/Sqphev3jZd6z5pFysVv0/9wOzT5KuY89on3TRz3D8tXNfvQ9CB2kt3j0QlBr9t+jqvaeSr/dx3c3h8GIc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(44832011)(316002)(52536014)(6506007)(66476007)(7696005)(186003)(71200400001)(2906002)(66446008)(64756008)(66556008)(76116006)(66946007)(8676002)(8936002)(4326008)(33656002)(110136005)(26005)(55016002)(9686003)(558084003)(5660300002)(54906003)(478600001)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jzAOiWKwbPy1hv+BKYG/nvUBW4JWe0OSwUDVbmMEM6z6qV7heBOlBRjrld9c57VJwTPrIxHyRjInJugMjEEaxC8M6Czed1G+BOmH928xfxgnuLgcUa9VKzwhF/mcU6hjntDjUVbwY2WM+eUurz0gomcNqrvRDc9iOiVHxliKZCF0OGN6y4UgfX+Y2L9hU7MOswmQbGROVtKUEN0x3oYwwila20KPBC8oz2B0KMMqrhHIe55GwVYZH3KgxqpZaiGbMOmw/b4zfXTcugvDJC0lNEeR95WVkW8AORHuwXubeyyngGd3SSVY0b3ao3FUumaUPowbZTZhhkztZvJjK5iJ39FcgumN1LaqWDXDgG8vYVDCJjk0Dpyu1y82YNO927piIvCEkagYkRWI6ZUY5LmEIA+j2KBFjna0Iyfd2sbKIGKS7CShDdMY6ChW2jPzIRni0ukhlvxuViSxrf2ATMRxOtNAS1XTdNQssgEFAMHXcGwwVi1m3ZvLwjHKZc44RvDC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8080a0f5-edff-4666-49e5-08d7fc898a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 06:46:35.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnW90emCOAXpXkmYeXu0hiDBPw3uNpR3tmI4Ts7MuN1l4Fhi751Atuq3S6+deZB0TUvvlVZHuGCZxeffBRUxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBN
YXkgMjAsIDIwMjAgMTA6MDUgQU0NCj4gDQo+IEFkZCBtdSByb290IGNsayBmb3IgbXUgbWFpbGJv
eCB1c2FnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
Pg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0K
UmVnYXJkcw0KQWlzaGVuZw0K
