Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D6C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CFB2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6AKvH4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEHCWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:22:43 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:6021
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbgEHCWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIgC3qhZIWAXt1DCfWq1BFPu+7UoZBSVkSBPRjLxlhvVWrgetVe9PB+PACoKCg7oMdLK1cgBS5O/VNsLt0SL/nSubohiIhBzZsqDUw2TRt70HJhBERrQjHSXGFeeOrYK9Lj3AT5pwWLmBJsLdgOTbUL0aTwfT5kYchm5QLWzv7fChj1Z/2Y0CGgLZG1bC6ItjmUPKTFNT92aOe7AiMOefPJ6pCvNsGGHluAqAlOmhj1lgJdD2y/WuUY5YmPa+u1alv8WJY0Z3Ye6nD5Il5xxdf1jR3AbaOzaKBz8hqamKWEESjwkMJMizrzDOKMX69GkNJ7lFzLRSWdkd1BNIgcJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy146qJF1ggdlfd5Ix84TSRjCy+CXdok5/6TpjLY5FE=;
 b=YPecIdlOdknQACU10m18L2F0G5LgbS2XTy4WJMegFWtAot+sI7+381kseI+wyv3ndicynu43h8MD/ZnTLsz6FCq46hdVbL/Qd0krDxFMm87rnvpugUYszZtUeclUlAaK6fe6ZjFAxke8yDru4r4YeJ4B/sUcqYEOpQp5VrW9MTVU2ZXr5rUZiC73gNV9EbRurbRO3XtH5cqhzxa2zrAIhnkkpLs/EAGw/1h4/7iBv63bJvaOf8D/NIdaXGBOpcq4FZtEyMonPnZKBZCfaJ1hzR96HqTT05hJiDtZX43Gk0NnRJjhS56h9BbjeLvvU26hTTHftrB4Y2inox9MSE3cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy146qJF1ggdlfd5Ix84TSRjCy+CXdok5/6TpjLY5FE=;
 b=C6AKvH4xH2XwYmTWYjkDnhfADuReCUbvdnCrWNqIxNNPqfH4lZOpj1YMiFSBBNAqNULFFvTTKEY0J2ec/C63mLS6Thn9EP1qopyb5GdW/OFxD0GCqPbJnoJCeNgELQwHEAKZEUtc6tGxNMz4odpzgz3Ovh1+Yajo8WhU+KB99f0=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5317.eurprd04.prod.outlook.com (2603:10a6:20b:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 02:22:39 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 02:22:39 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: imx_v6_v7_defconfig: extend RN5T618 PMIC family
 support
Thread-Topic: [PATCH] ARM: imx_v6_v7_defconfig: extend RN5T618 PMIC family
 support
Thread-Index: AQHWJLCfPqdj15yiT02mgtAd3mI8oKiddXPg
Date:   Fri, 8 May 2020 02:22:39 +0000
Message-ID: <AM6PR04MB4966A052FEB3618BB3E5EED480A20@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200507204339.31253-1-andreas@kemnade.info>
In-Reply-To: <20200507204339.31253-1-andreas@kemnade.info>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66f6fbb0-9646-4057-8db9-08d7f2f6ae4e
x-ms-traffictypediagnostic: AM6PR04MB5317:|AM6PR04MB5317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB531788C975B6D5A84D85976480A20@AM6PR04MB5317.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfL1jJ7KByYtN5mSJEam9JcyVywSTMHYUAeXOqIOjPRikqaRfqppY7OCot+LyJ9FkIVxbmZSB67ySRUPzO8Di4f+amcEbzTRYJboGMvlYp6e0rZTEcclFDoZuE4kGygye4DgDnDddNOSUEAaOR1UHIw4vnmeX6VV7L7/EZte6ZOocZmup2Qv5NK5QtP2clF3+LHmtB71i/RFMz3493gRLkPBb6+ZCT1s7RLl/BTJaBcMXOOXYVnB8kJZQtvKQgJCTuEGTYsLpnT/MMLGBx2MNq6/0HUtTyvQGgEXzNyvei5qHOBlv9bLxwQSRJj8JcYaKMPvSUpif8kwUhTYd4pSsSH+Shm5o5aGYIu8potMToQNUVVCAlFv6TpXZCrTsopg1Rg+yqnR9WCS1OgCaLqVSuG5INobVxMkEHO+YTury/Yp0Be46/cCnE6025PEnNVtSMpVvrBYBPAuGo6Tgnc/n89ohsxFFjF/CMLkZ/LLbWtiplsXwzMeq+4Nck/3IxAo/lEu8tAtKJbbZDOldiiOvJ7ZtcLhSYn/GnEhP1etSpIRvMeGqw7Q/1XSTX878LpH+IR7h7jnb6NzHW83yPhTVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(33430700001)(26005)(5660300002)(2906002)(7696005)(6506007)(44832011)(55016002)(186003)(558084003)(9686003)(8676002)(8936002)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(478600001)(83310400001)(83280400001)(83290400001)(83300400001)(316002)(83320400001)(71200400001)(110136005)(33440700001)(33656002)(86362001)(7416002)(52536014)(921003)(6606295002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /znKKcOeBaK86kSSfYtZ3CYHHAE0ExeKAJLc63igWEsrcFAAPeB+EIEDiDdpsWHIInNPkV2AcSVwpbmS6Y1qmN9cpFg/Xr5fzrgr63HB7ajDQPMY+JBm6Ihcq8skeVQfulVigVgZouVjUEmZsTxiK4ZMTzV5f1HDXwCwY8QXzSmyxjeaq4nvVMfIgTTFSyt/2Z0ScCpzdyQEk1LdfnWoSCCiOtZcFHuhaBHymcB52PZjFFohFJ8vtMreDZVa9a6RqWvNioPu9DxWb7kDrObio0cbEahB9KDHLXvBCEJbFL/MkJZoR9eV8AmRhzD38camUAQWis585NMxg4g2xojRmlk8KrUi2a7KHJhQJN2hfGOdk+lCxqWEY6NM/m3F3Gs1HYSSgsfRxd69tsK+7OfUh55QsaZmZzqie79jJHCyX83e30/QJWRS03vTeLVqdmV0+N4TZyb2nRDo7BtytBzWSCVQsBjOnY0Yu371iwAhd0iIq5EMPJVj2/EC9Bs8hUpP91FISscxjRZOcViKq9HaKsatHw6zSyOouaaiUVxYLZEXSRgGT/+Srnao3ShJijL7GRQd6XygJCWJBAsoMJKaXdoSUgkgm6xOWkO8VVEWYsInkjaq2mAeBZOsLhmWOGpBVvyqohoJpoDj3HX1zx/mj1DmKpk+aVJ/9O1Lvpqmwodc/VbMHC3zAjWb1ZqXatK/DargTMSou0ZIukExBT43LDf/QnpXVdb5ByhIzp6KJQWsGXkuQAJeRmzSfv1vJeKvHqJ7otSJzMbOJgwgzIH0PkrtP1ftWNooSPkAkZ8b2wo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f6fbb0-9646-4057-8db9-08d7f2f6ae4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 02:22:39.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkHnka6l/wVMJa8g/P/eF8DAXGMR6ibLP6gTkG5kr1TWlqASZfpUfcpkDMy3HmvJ5puNCxt22PNhgjqcUx0oCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmRyZWFzIEtlbW5hZGUgPGFuZHJlYXNAa2VtbmFkZS5pbmZvPg0KPiBTZW50OiBG
cmlkYXksIE1heSA4LCAyMDIwIDQ6NDQgQU0NCj4gDQo+IFRoZXJlIGFyZSBuZXcgZHJpdmVycyBm
b3IgZnVuY3Rpb25hbGl0eSBvZiB0aGF0IGZhbWlseSAoUlRDIGFuZCBBREMpLCBzbyBlbmFibGUN
Cj4gdGhlbSwgc2luY2UgdGhleSBhcmUgdXNlZCBieSB2YXJpb3VzIGkuTVg2IGJvYXJkcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgS2VtbmFkZSA8YW5kcmVhc0BrZW1uYWRlLmluZm8+
DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpS
ZWdhcmRzDQpBaXNoZW5nDQo=
