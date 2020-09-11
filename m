Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49494C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9371221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VRat05ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgIKGWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:22:36 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:50690
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgIKGWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P89w6nPIdyS4Bd79Laqc25ObmHInxJEL3VDWTdtAuwJYJwyvd3/42NTDanLP3oTNv3VstYEpnFqgW8WI2VmBvCauNQMryv+Vc0OXRDsonpkv8X2m63a9tMyVWttAZGTehd2mZ6buudxsv9N+x9Tm32Nawmt2G4TVcKKySyqjnX3RXBFJXnIjI/MvjsQl/qPbmrld6dhINX+3iA6qyFHmxdBicwD5Y7NlYbOfCXQQaYsNIARsjkHfW8uyPc6mBWkNrP0BYR5BYuwpUBVD9U/FdOS0R+uK1sGaV+fd4LnovF/+lusEfWp/qtIWVanfpego6g6uOcS31+jMqTdmYLupPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aKRMJDAbfN/WEh5Pau7lz6R2jNsI4BwsNZl8l26udU=;
 b=FdHv4W0tkDnykzdPRS6eB2Pmi2u3kICdF12flE7byORu/1OUGPDnmefjJYQPl0+5vrNZBLQsrVyVI/jfAtoLKjVvh1xhifiNkeMHZN6HuxPRi1JIXzXRCItqFKu/jaOgfFSIgGdsSHG3lskXlnaQMD2B7N/9ej+Av2ckloLO/TCQfLR8rPBhUpH7OaKQSpSJkHkQyPEWD5p4KJ2ndhIGW/HtLY8cx4RprB/aArh8JJw6mH8epG1wrnfJeGwC3c6tKXHpJBgcmlarc+/AvZrDb8lO3nkEwz65WBa44x/nktr5auIVlrFKKhjSkKWUnmyUOhu114Y3sb8eY1xCtpaAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aKRMJDAbfN/WEh5Pau7lz6R2jNsI4BwsNZl8l26udU=;
 b=VRat05veYVgTGQf/VT2N52FHNxNSe0OygT6THrYfriypnfuParWQ0EL0iy/J3Krxh+a0pk5bC20Xipm9k9beOgN6wM4l8Y7T+QgWRgx9Mw7jtPTcJlit0wNNRNAuP+BEjIfaMKHfNlhsbFdZCUvV/B1lMBsF94fr7JO7qnjKHqE=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3784.eurprd04.prod.outlook.com (2603:10a6:209:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 06:22:29 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 06:22:29 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: imx7ulp: enable cpufreq
Thread-Topic: [PATCH] ARM: imx7ulp: enable cpufreq
Thread-Index: AQHWh+z+OjufGRBbCEmDn7TmE1Unqali99vg
Date:   Fri, 11 Sep 2020 06:22:29 +0000
Message-ID: <AM6PR04MB49663A59C8AC7B74DC1B871180240@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1599795104-7016-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1599795104-7016-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28c2f4e1-dac0-4ffb-2d66-08d8561b0f8a
x-ms-traffictypediagnostic: AM6PR0402MB3784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB37849A5C4451FB6232B5DFE880240@AM6PR0402MB3784.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAr+aZxvvGwphwjvh78RN+S1XawkCfXnNCeH0xDUn49IbXCMN4g3q3chlgkVkyinBcxkwUzFH+cdc4C8oCO2VOd4vKKku7MEYZq/xpdKLYTEE70X2KmAOEa4xOxhgwVF3Xlv1o99tCROn4jIHThwEuk/g+bVX1NO23s6mz919GihXoQScr7+92EuhIXJuzzumNFM16jT3Vzye6NxAMB5LQh+9uLvGuQbTwBqfCeG/jlJC6p5X9gGz8FYWbc2vw1bA/qWvLNGoOAulL0fHgbnpZ2rRVc2dvslFyGasiXaU0pFZy6QHxx+LocP/9RFh0Ef/G0PNGpUSdxgQif6BDZ3JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(8936002)(7696005)(26005)(186003)(86362001)(44832011)(52536014)(316002)(5660300002)(8676002)(66556008)(66946007)(76116006)(2906002)(478600001)(64756008)(66476007)(4326008)(6636002)(66446008)(54906003)(6506007)(558084003)(110136005)(9686003)(55016002)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 45U40wJgyJVbNFlw2pkdLURc6Fht4UzQs62kkni2NMdVpRzxQvXi1yibIJfLSxo5Q0CG3AOYa9jGRYuc+l00zR8z1PbCMWEwekprFRItlhFbNJ89lE56gPQk7E15K7Y919Iol7thh7ErONx5JbDQfEIvEoEQbNE2PZvhgJwp0i67RquaN5LL7KkZwr6JqW/2rmrO/QWAQeWLbHQhFUDk8hp4kTyyOcfms5iwNvYS50tCOQqbvAL2sq7Y4G0k+RhHVerVnnRhCwbRzpY5lfRxa3toOpXxJmjLYwZSF9ez6lSeHIHrjGBs9TEsPrw2hpCzZ2ygH2IhCpRjOaTwXlcGllO9v17trooP3aXCdeTNMw4YBhlv/ClrJj60S5F8QfFa4rWBIbRlofH3Pd4WPOTUpfb8nM/3p2l6K9RllS1aitU5dPw4YcDoF32c1i0x3p6p6+srWhPKj4tM9jONZrA2MsUUnfDiLkQ6S0Yc8p0nELkB+XGHbw5JWbhGNyNqxRU2iORTEXWaL6B/YOBdk5lKDEHJZJ8IvzxjY1miJfNNe5r8B7rgfeKDQnGwVULP75fbjOi8nxWSq1IS+ikksmciqdBjB3yr7XKDzyTZQYm3FWMA8vNHvqqOFj2gQ8Edn5VjZk0ISyazeWiyaA5CSV/8Ew==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2f4e1-dac0-4ffb-2d66-08d8561b0f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 06:22:29.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK+MJjKOahI4A1nVFWa2ZUeVYckQEBzGmANjndlTmCX4wCb5GUr/LOTXBfBTJBjy/JktQMzepAOc4cJOUFT/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMTEsIDIwMjAgMTE6MzIgQU0NCj4gDQo+IA0KPiBFbmFibGUgY3B1ZnJlcSBmb3IgaS5N
WDdVTFAgd2hlbiBpbXggY3B1ZnJlcSBkdCBkcml2ZXIgZW5hYmxlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBB
aXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
