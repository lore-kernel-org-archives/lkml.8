Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A54C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C5120748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dzi2kKT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgETGuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:50:44 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:6238
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgETGuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3HJeWxEjk/duUlNl5t2sUJRHL0M1lAFpcRKqJDsZbpEUvLbsKX8QG5nrzc5dkRrEhuBEI8bCcOX8y4HiL1J+kcvRdS336S2sIbD6oTqiJardP9NMFNOoVIcsLLpwpvkNTrp8oOpKMVn98IXtHYZPPw8wer/ST0DSJxUsqeS9hDUFOdQ7K+pizkzZO2jK/cvWYshTWo8gDc5MuYmEJscQaOm5sOB0SNIhmXQ2zlWJpOKDHDBbwQ4LeEigVbC1iDL25Mbv4xvr2zEVHFwlbP3z6wrY/9SJBrMcVyR9BrqApdmDSjpl8MrYtCD3bmDKueBSFQzJQoU0XFqjRnIg8Hqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvGDWJ7n9jg0znBDrFbYSyKFI+09F835Y51PBXsd1g0=;
 b=iJFrGPZXjSmX//bm0DMskaI2yNz78PbKv/BOfz2i2KJrOOBGdVFBd/J4Cf16tuxKMcbvwuocmD/YLffGQLBX8jxvZzk8c+/2XUhZ/h2BT3YyySDD+ncZN7tvicf46NZzPC7HMr7oECI2tCyMJjfc/SqMMkruqGZJzAMuLwcqQOs8WGGdcHLNY09mGt5HIbxWRxX/2ZBKhSeAyF2P12oHX7265ZxE2Y0y9NsaaaMFZD6R5Fof/HNfZbMlXhgEO4YtQ+oE5tL+tIyJwIkiXZtVE9MzG6QDNeYUtuTPCVQyNzVwQAW2iDnLlrXNM5HzQNZIGhnIYV7c9zDrLpRevKSC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvGDWJ7n9jg0znBDrFbYSyKFI+09F835Y51PBXsd1g0=;
 b=Dzi2kKT2BRICzivhPv5ImO3Dy5mKBju4CHm9XyBJ1iLsCXxrL/i4TbnPZ0zoICfxxbo6RLpHMO2Og1I9L8I1iFAQwoOmM+vPunVCVG/zDm/MV/B38J1mYf5KT5XBOHli5p9ixlhqcyFrar9j3JeTwGe27owqdy/TNU0yT6O29ws=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4935.eurprd04.prod.outlook.com (2603:10a6:20b:7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 06:50:40 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 06:50:40 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mp: add mu node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mp: add mu node
Thread-Index: AQHWLkxzMvhtnxfr4kKzRmUZ6iXJ36iwSJ8AgAAAq4CAAAF1AIAAPoMw
Date:   Wed, 20 May 2020 06:50:40 +0000
Message-ID: <AM6PR04MB49660EE02F2C41C5320C1F2080B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
 <1589940278-3680-4-git-send-email-peng.fan@nxp.com>
 <CAOMZO5BPPRy_XGHHyZfE3eOrmCwW_VytueY-An8qqke6HU06TQ@mail.gmail.com>
 <DB6PR0402MB27602682E90E4CED55244BCC88B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAOMZO5DmiQbfJjTLKPiv6uUNaQ8ae-0h7uOpPf2J9ZMwDoE+Eg@mail.gmail.com>
In-Reply-To: <CAOMZO5DmiQbfJjTLKPiv6uUNaQ8ae-0h7uOpPf2J9ZMwDoE+Eg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3ebca6a-f723-43cf-bff1-08d7fc8a1c23
x-ms-traffictypediagnostic: AM6PR04MB4935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4935207248F037E40C3101D080B60@AM6PR04MB4935.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jpy1MABEuETY9YYIfAAvuoniQKmAaB8PytEE+YN4x8jkG8nUxtjrZMh8Rn+xZre55skfhS9+HN1ETTxwSaxGFB/KY539UOQV9/7Yc98PYDeCllQIlOH+Jw9DBIkBDtUVQonqTjgJcgeqvl4UgeIBNqL7t4DzOahcco4MupCp7kErwFRICzOJ9yZ19h6eFyAZkvA/PpsZwxE6ZQNxBk90vVJjb+si39ECvrxiQTeelKoB+HuXbToQDMAt5S3uQsWOjU7rQPP51gbiMb/03A7NszNeYFG7xsf0naPWe6/DXHzcOcVM0LH6x1TBfPsgdl1MdOXdPjPkuuvu56hNqJ0YFxlnyfDyGPMEplnMHb44y8SqMaLz6xIs5HiC0If1/ILlubWZs+q9WMSzb1V6RpYH7Ti/EU8jFx5mVueLG/WqhiYirZJQcLWxWUFUwgRliEaK1KF8OPKy/zbvQZPsrpBozFCH2qTo0cAiB1DSGDRZA9lofkFX8NcfWC0B6Kxm02UF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(33656002)(110136005)(26005)(8936002)(4326008)(55016002)(9686003)(6636002)(8676002)(86362001)(5660300002)(478600001)(54906003)(316002)(53546011)(6506007)(4744005)(52536014)(44832011)(7416002)(2906002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(7696005)(71200400001)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9Jr++8EIXt813hIUNQNwrlceynUyV69uQ6lWCZ9EcYEGAcMFKn5rGNL4WGfJU/aj0liIHVtvmn8GRSiSZOQO2Hp4ao7kSR+O6VqWZks2e8l25nnGvoHiRMw1PqugOxmeqs5mgh/QFNbRrnufwUp/2WvTpRsctVjj8F2l5/tNMASIfz0vdc5DpcIx8UbZFFSl4mouwQCtX/m2PbtboRGgx0Y2MddBd4+Xes6O8CEz1ubVEVho+wBroXLrryr80C/4srCx4pl6pEKAY+sXQdxu3QY5vmzlbhNjfNjmV0+/BMw3uzh5Q1XGtRkjrk2KJO9I+/iLIrFrWvP2ec1pLI7bunLkKhVEJV4NlpsnVwMMKVbGU4hSokLS2oiRLnvWpx00kp2UpcuXFhE9KwWMoxzZWkGuHkOU8UCOuPWchYmolxpviZNal9t2pTQAsRAqhdZQLmM5mm3feVi7XkRjh70SsJGBi/ESYAwEkCPq/k2TMuSQ09nH28dYNo5vfFrVFpda
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ebca6a-f723-43cf-bff1-08d7fc8a1c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 06:50:40.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bScXeFZurpaKLgIXCob2R+ik7JZKj4F08Tz4HPNQMimCD7PtCo9gQtmGmfWs7jqfSpeGjecNtdmBr7uXsdC59Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWF5IDIwLCAyMDIwIDExOjA3IEFNDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gV2Vk
LCBNYXkgMjAsIDIwMjAgYXQgMTI6MDEgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdy
b3RlOg0KPiANCj4gPiBOb3RoaW5nIHNwZWNpZmljIGluIGkuTVg4TVAgZm9yIHRoZSBtdSBwYXJ0
LCBzbyBkbyB3ZSByZWFsbHkgbmVlZCBhZGQNCj4gPiAiZnNsLGlteDhtcC1tdSI/DQo+IA0KPiBJ
dCBpcyBnb29kIHByYWN0aWNlIHRvIGFkZCBhIG1vcmUgc3BlY2lmaWMgb3B0aW9uLg0KPiANCj4g
TGV0J3Mgc2F5IGluIGZ1dHVyZSBhIGJ1ZyBpcyBmb3VuZCB0aGF0IGFmZmVjdHMgaW14OG1wIE1V
LCB0aGVuIHlvdSBjb3VsZCBmaXggdGhlDQo+IE1VIGRyaXZlciBhbmQga2VlcCB0aGUgZHRiIGNv
bXBhdGliaWxpdHkuDQoNCisxDQo=
