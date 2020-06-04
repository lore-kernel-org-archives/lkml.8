Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E06120738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m5y3Qvd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgFDIss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:48:48 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:33346
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgFDIss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:48:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S39Fwmd1+mgmJg5tBumdolDJdmtlNAUwlg9k5gbV0uYIb3TtpOi/P20nTIaSZQNegeU+uR9qBplDRKGD/3jlW5cLvocDKuKdN0W1vo3Bt9UR206LEW/XbW00b5rwZbEbMXxjnHUjz2TQD6TmzIAwBqOCFg87xh/g6y7NwVtTIoQCJ/FA63sWjuZKO75B5IrUzaXLI4llqm7USWZ0s91P8XAOfad8PS1s9+OXsLwNOep3J5zS7Iiaw69+Qqh7ErvX6T56gkx5QEg7G/88jeCy/37mkaQVGCWtZ0lxxcHITu/0VvojL9LpSbST6/jZnXWQWxfKrKGFxfJaZtn7pfnRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAotPsyawZwJ5rMluZjk9yfieYK/J2akETnxuG7eA0Y=;
 b=crBRZfg9fPubuaCb75dUIuAv2glSTfhC1q5xI0OpTNpOhNwTzXXRo5LW5xQEDg3c3IUz/MoPgxXpMFDjWGAG66Yu6qdTzT63VBbk+pxNPmklRntNJTB5TH9g5T6h0PyliB/XbnhpvAlKdP62Wjd21YragFkx4pSbSgLXJUD+lOqEHfudnKapcnYNLIcKXhgnFMPXV3/TurSa3jmZUGIk3cE54QM0u7w8L5KWzhrRKBSLlaLvTufoPA/kMw3Dm2zR51lxMVCc8tzUpwFYZR+qk6A6CchR9nLOjyixe6NChuBUqbUF4jsvlacvnmplW9xVZo0AwO28Rd5HGqsCnaFZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAotPsyawZwJ5rMluZjk9yfieYK/J2akETnxuG7eA0Y=;
 b=m5y3Qvd6X0n7yFItO6St98U3hRrJm2bHzj2tW4c9I7kyDiR8seqZlA9e4b7AZjdXPKKHTAKwEwUGrepnnFTdDOtYu6uWKrNYOVG5vfqvcBUabo4GOOH72nyRj95hzT4HrU711UdvFsFMCTWi+vgQNBFrcCpTSDXMlfDHaRcY3kg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6742.eurprd04.prod.outlook.com (2603:10a6:20b:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 4 Jun
 2020 08:48:45 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 08:48:44 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx: scu: use devm_kasprintf
Thread-Topic: [PATCH] soc: imx: scu: use devm_kasprintf
Thread-Index: AQHWOYr3y8sO4+OM9UGcE5imtnnUrqjIJq+Q
Date:   Thu, 4 Jun 2020 08:48:44 +0000
Message-ID: <AM6PR04MB49663F85EEE5B1D52EA1AB2380890@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1591176572-9693-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39c542b6-7f5f-4b01-fbbc-08d808641715
x-ms-traffictypediagnostic: AM6PR04MB6742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6742A4C138D2D941348E602580890@AM6PR04MB6742.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQMGDIqcC/hy8naA77fj3L5SrqRaTCuwn4/k/TRxEn9ediEYzDaO3S3IDUE5o1BgLJKbRfnnHCbRHEA3bY4cT1hMQpY+Y3BErort6Y1Gw5QVjLTinJoqTTQ8EApgkXC79NXCy4u49Xk/ZB5tmk90DYXzoNKJGkr1uafFWhZWqahMPzytbDm0QYR7r2RqQggUdQaTA2aORvjBtmXByYT4UQCmCjtyqpPP0bs7ERx54tzNzMyyGsXc8jscKAt5X+v44/35LbJOjEXso3o4JEBARuirHqtqcUOlGb6Y/HVVUCndcKlzGh02uWsXttLv5DjYYR3hTD94/JOrQf4TFIfRbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(76116006)(186003)(86362001)(8676002)(66476007)(8936002)(66946007)(71200400001)(64756008)(316002)(7696005)(66556008)(66446008)(54906003)(33656002)(558084003)(26005)(478600001)(9686003)(6506007)(4326008)(110136005)(55016002)(5660300002)(2906002)(52536014)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +V6OGhRSrpV1ie9d5MQvHArVYpXuERqTCZicNuTi+04AgGe9uYxjn4R607InYSbyi5NJ0lJguR5hYtmK2VAHu315iY6k1n1aTo1L1ri6qcs9m/9NkhQ5zK2K6l9Mko1hrvC4ce3MJlj6MYn0Qznt94gbR2hAF0ZKV3r2N9ZrR3RVxuP66sJnwfkQNG2+7GuJwKj1oOV9ygy1i7/K8EN/wQIE+3wTXJuZ4Mpia+HUdnrT0ZnGIAaXynY1I0S1TEAyocgyCvXAyy0QEoY+l5XGvEpP0LLvLweE8WHUIi6xJYld9WFvlr2XeGypQTudbApReiTrmmbWvIH0apG9OX2gnSQKcr0dPWpAVQsvzERhImq8jIRKiP18PjOIHziUiqh/G0M61RuYkhnDIqVj1NWn9Eo6yu1W01vs/n7UqUc9La0P7NwepWS+k8if5R/evQpV2SDkc/FQ0su12wE8wjZwAfq+/rTorls6G5UMn2s9kFTm5criF8mLwYBEh6NLa9nn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c542b6-7f5f-4b01-fbbc-08d808641715
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 08:48:44.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K68DmJyKP/LXlPhlXOyE5RJhCuNDO/XUBH4VV3IFBhAKEdKGWj9O+x/mqaiNR5XM3vB2MVG1va0lSEynTHS7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dW5lIDMsIDIwMjAgNTozMCBQTQ0KPiANCj4gVXNlIGRldm1fa2FzcHJpbnRmIHRvIHNpbXBsaWZ5
IGNvZGUNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVn
YXJkcw0KQWlzaGVuZw0K
