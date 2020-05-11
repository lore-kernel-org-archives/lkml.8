Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CFCC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BAA20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uh2jQcIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgEKLKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:10:38 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:52225
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgEKLKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ2MnodTaJ5OYeIXEYLGcrdfQ5BniFT0l/5JwZ4jI2nZu6Aim/rY2/Aokb3gbOECmdUAanT/dxXoYyb9g456H4oEcs56JLcrNBcHbiJmNShkSBlDFWZznV2o7kE+uLkl6Ji/RW4mua8Jr8Ty2XQmhwO48Eg4yIaoguV3s9J79zuZKUxkUI+zb+b8DO5Z8wN/B7cOH8kRIygG3uLcDwdOAPeKfKwJbY6GzxG0efru16ShDA1t84a1qzHD3pNSluwOUiXDNyqr84jGoQG9DWGVboPhU+kYOrEgT38AOkDRyIysCpTFU+9R2tgTsEzr2w52UUOZtyONcXgeA+kU+TUhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXY4GRbd0MVy03OoSfwVD8gh08stFWAGBzQDNNqHa0Q=;
 b=RHN8flDpJn64OsYr9xOQcZ35Jl61VvMH+92gRcCPy7GhRW99JA24ZumhRLf4r0kQR0yjNDiAZmT3eXHGV5gEHVz36c5vOCinRGmf/+fRRPB/M/ZxCQzMDzd2nFKU7BpXhwvBxRWn0HWbAOPpx4dCc4DqJKmrAqRYfYTANLb5L6lnJMDUNB+Hbs+NTJ2rrUtmDoQtWH7ruqBz58+1id1yZ91yelwqZ1wAPv+tVLuAh6ry2EumJzOQhcPIeBqekOBnNdVsE2pyCbDnGqLDCM07zR79TLQNRRAQa0OvJBo2ObwAf5L1eGXLa71Ee+q5+G8iL2EOfgtzUrhJmCp5GKZuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXY4GRbd0MVy03OoSfwVD8gh08stFWAGBzQDNNqHa0Q=;
 b=Uh2jQcIEYLnrL3IfaC/XhD8VeGq7R0j5iudLx3yJ3l6okn4sTU2A6wYPCl17n/EzsKSqRPDYoskjI6jrEDve2oj6BV1ZkOki00yAl4+Iuv+EIfAJPmhgBxllB5OawE6/mC40GzZVFLzW+Z3zvS7JSEZfJ0B48L/1dB5MP1kUX9Q=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 11:10:32 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 11:10:32 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mq: Add src node interrupts
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: Add src node interrupts
Thread-Index: AQHWJduklo7VtYTR30GYLDpeKgQ93Kiivajg
Date:   Mon, 11 May 2020 11:10:32 +0000
Message-ID: <AM6PR04MB49667778EC5FD2B513DC0CC280A10@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589012271-12740-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589012271-12740-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf7f16b6-6cb6-419b-998a-08d7f59bec2c
x-ms-traffictypediagnostic: AM6PR04MB5925:|AM6PR04MB5925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB59256F068698C109A6B959C580A10@AM6PR04MB5925.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bxq6KxUTZAPwL0iIumzrMf2/qnGoI3lWjRArtkcWlfsdpVCMWFDVr/eRoZbP7puPSfYqffSiKOOz5YtdVAFDx93qD6kwj9kXceFv+l2kSvvF6ZZCvIcu312s4p0Ap9up10GmCFi7Vsh7J34hJy7T0DjB0KMbt2EjmkKumYSOhV7LGopSHZP3Snn7L6ggX0Ur6yR267Dugf2HWkkRaThOyMsuqf9qRS9MGMSpb7mBzXf9N563a2PGQpYpt1OxJpzm4omV7bqWVgRd3sINcuKWzSUQX4Q/pknZjS2kQZGQcK94n61Xxa6NIVFKz87QUfT5bEQwTHfWaWgCw/rvtx3SfFKEnJV0A1EydqjjH5c4O4f/7g2SinLnbjKrQNTCnXmBYzvtQkJtBnx+Nh/MnHwMFmgC+bmrwa6RJjfbg5bn2M3eSftK3H5tC3mlOmqtH+NB8sqPOuY1kIBjvXm+hxh+RlpZfeLnAd8TD/PoCvwkXgGdja/HY94/IECTSoX9xC4eVohAJPmRhAngZjAYa1pSMNKULssVNAtLIS+C/PEdw5L9LwnqoQazE811mbrH2ud7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(33430700001)(316002)(7696005)(9686003)(5660300002)(7416002)(55016002)(44832011)(558084003)(86362001)(76116006)(8936002)(8676002)(33440700001)(2906002)(4326008)(66556008)(66476007)(64756008)(186003)(52536014)(6506007)(66446008)(26005)(478600001)(66946007)(33656002)(71200400001)(110136005)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 63w4/H8T50vRrlKllf2ITq0zBq0uHSHzjJd+p581XEBfnM0DlOHi9tYRjkfuaZy64pcUx38GOijCcXGFymYOfHnX/UklTP8PSopve45+LzOiYkIIEu6bT1h5sLiuoH3oh1Us9gxpy+v4QXohlv2pfJnO51bvvATfje0iZWSSLVHAZvr5ysz8/Yl2CqVOqBgHOh06K7ItTjub9GTqIATa9kvkP52lQh7iqBw6m3XjSF2UFe78rt1wk9HrV3PrTwjROeF2TMejH/+eIHABQdGP2JLV2Sn8gehoUMp8M4EkZwPP1wxQ7olzz7STnrq0fCln+XR/UKu6ICiWWoW6SsEn1DrgYXvh/1L1LyFQN0YkqLWeuHwlFy2ka7t8+MMsRssLb4LRAsccvY/wNxJidioSfYqxBIih4v4BFOW61xferel3mHA3dzrVE7fZgWvxmEtHhSBo8iFwnsksmJKKWpJsUYyHObAS3KWVcEOsb9J7L88=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7f16b6-6cb6-419b-998a-08d7f59bec2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 11:10:32.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OnjCVn/2vmSieLiZQ9JRq3B9wmm/Js+Teo57bNSubb95MO/KWSqFlZhRFkXexDXZxrMku5/xRFs0QpkHJjuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogU2F0dXJk
YXksIE1heSA5LCAyMDIwIDQ6MTggUE0NCj4gDQo+IEludGVycnVwdHMgaXMgYSByZXF1aXJlZCBw
cm9wZXJ0eSBhY2NvcmRpbmcgdG8gU1JDIGJpbmRpbmcsIGFkZCBpdCBmb3IgU1JDIG5vZGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg==
