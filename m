Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F1AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CB42075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JQiFFykc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgHQN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:57:59 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:35456
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728443AbgHQN5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP5TWfJ8+YgZBOZK/1zP6p12pdyhbTJjW5+ZcgjBi1mgtkkEYmflDDOYKh1PL6qv/QN9NvPLsOntoh8K8Vhm2HiekMhHgLM85zC27thBLrn7H8UNOM+99IIrYR7h92N8wv+pwkxqmwb1mjXV54nl1c1Yn242adroFOFl3nfla5WJLHeDnOx2G/1D+vTpCmyvydbOtiAjuYE6qm6D8k1T/ym/fbMDFwGpigtmhXZ3tyOV9cYgt2ux0AZzMtDJ+I/zorsP6E+k/sJAEWXNCQFz0uI2DYF/RklNVzVyc6b+i+brM+TnlaPu6BKElftOnFtqTUmQkuvIhl9WM6XjkaJG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9EQKoishsAN/qCdzjJZ5l8a8lMiOv7Em/+BU9sQm8M=;
 b=Ryids3HmQmxFJNdsT5XbXHKnYom4jC8FqRrWydzfSxtUSdKkz+4DvVQFj/a6VnVOigaxxoX9JpHn2VGrrlFS1HypU9FUIEVrHiTWkrZ0VlBdGfuYHY9w7mJsVOoXPuws1Wk8W9xd27MR7QsrWLXEBBEJFGqvgGODZcClvT3N+Hz5bCsJkj6gr3PpLVWOS9gOvtJAftmynEXGIs0U0R+YmVgu80j3PLkRINWLJrP7B4ZYogi0Wz9zftGdE/GuWTD0RJlL6I40N4qe4HdKXCOO9M5CG4DvLbESQTy8eBVvVaQuOlx1Hhm4cszDbUTYO8EQ6v6NA/xuGFloULH/kXS6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9EQKoishsAN/qCdzjJZ5l8a8lMiOv7Em/+BU9sQm8M=;
 b=JQiFFykc2Mj4hM9hm6g2z6MhVvJ48zzcJD6hrdpf5fKeEycSg4kE874lX7B5+20KdVIWwD8OKSSVEogSMOmLnyEGpsRFq4QTFNT5/Zs58UvddMngCMEp0r9PuxYazh7afTO+OIfVzS8cgtlldoZprzpf7LeW5bCVC8JhQcq/gHc=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:42::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 13:57:52 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 13:57:52 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound
 card
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound
 card
Thread-Index: AdZ0ng+FKEuj/eV+Q6mBNZQVr75PBA==
Date:   Mon, 17 Aug 2020 13:57:51 +0000
Message-ID: <VI1PR0402MB334219C2EDDB25D1493DEC7EE35F0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edb4276a-644a-4bf6-6151-08d842b5888d
x-ms-traffictypediagnostic: VI1PR04MB4158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB41586AF60C3DEF09D37720DEE35F0@VI1PR04MB4158.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llSWwwyZp3QtX5+AGxOL+gr0EISdNiYIfQZ98PO0AUnTtJURhiSDwrXg6DuGNWzG+u45doSlcdBa1NVsa0HwxbmMLKCgyFRwcy+cwfBrIb2Yxf4PtU+rDUHNTfL3AoiPFmwuV+vHv8FmB7QjDnilOlzH0OIwQFn4z372Z64/thlhIYiB6iQMhEHFd/C0SlneLfpd5weixNSlWrQS37s5ga1Dl9Ll7DzL6kD2p18QQ04VkRzRPGAy7OkF2wF/U0rmxuIg9L9o9nl1P+Lp3ijHFtBnpIdjW7/NY/r2KLP+E7rZWs4GjLD3KLJOCh0ibVgHyAXowc6MUHUkvwYikybgJWPwuiBAZiYC13YiE2zgQcrCdvdyxQ+XaDEbLFicJWuF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(186003)(26005)(7696005)(6506007)(86362001)(478600001)(66946007)(8936002)(66556008)(66446008)(52536014)(76116006)(5660300002)(64756008)(2906002)(66476007)(4326008)(8676002)(316002)(33656002)(71200400001)(83380400001)(54906003)(4744005)(6916009)(9686003)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ioFaA+HusSSkwuDx7OY4IEOYGJSPJyoOVwsaBXGxvDnmVVqHcF5rhUVqjly4g+eBkTmNI1syIP5WWVwmEOR/ewFpoXKrhdo6rMETw9oCjYrP4g11yeK1PfgLo4BhmcPJXNxUeJIs1krJyRJH9ds8PtrSpLZO7hzTpW8YZ0SLCZGbx/v0ypABKM6pxwtBeJU5frD31ot6oGwsE+CgRdXewhhQERgF4AvWxxR28BvgEum4JO0Pl6kaIlozIBhhlzaxhAfyFk9dlJj9ZqAgXyjVT7dxEUXbdnLDT/bjATp3KZkz/YwYOlDDcWCsQhzOqts8jjWj11dX3Cmzwer/sJzn9coT3M9gvsgz6ZFYUKddSyjo38MY6KR7WhDqhKKWVIf4EmGaGflEXHJ8x5PNt2s9IFqghA8fe5/OtBVpAUTp/2xMNTMDn6K6B2emFeHYIrjYvzjUNoW1lx+FG/XL+bF2PUVx6Q1IUTeBf0YtzMSb3bKI943foWwkaP//5UZCNWv6oNamJS3ankIOyWyzXsiDl/1TFTi4KMzBz85rgZowhhTCW5uUZHH3Y75MMcAtSXNByr03lN9yqcxSDng1U3MeKTIazHb4OmE+KwJTZj7TOW15ORM1Te/AYHnYU/rCyKj30zxEJ3UeqG1rey/EqB+Zdg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb4276a-644a-4bf6-6151-08d842b5888d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 13:57:51.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S36KbrFFGEHCPeMOIJWTZJ0VBxYZ8qI86OHFPSi1guzB6d1JUve/QkgW4Wj0ankhtEaZd/d+5QH52WVNAl8TPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICAmaW9tdXhjIHsNCj4gPiAgICAgICAgIGlteDZ4LXNkYiB7DQo+ID4gKyAgICAgICAgICAg
ICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKyAgICAgICAgICAgICAgIHBpbmN0
cmwtMCA9IDwmcGluY3RybF9ob2c+Ow0KPiANCj4gSW5zdGVhZCBvZiBhZGRpbmcgYSBob2cgZ3Jv
dXAsIHBsZWFzZSBhZGQgdGhlIGhlYWRwaG9uZSBkZXRlY3QgR1BJTyB1bmRlcg0KPiB0aGUgYXVk
bXV4IGdyb3VwIGxpa2UgeW91IGRpZCBpbiB0aGUgaW14NnNsLWV2ayBwYXRjaC4NCj4gDQoNCkkg
ZGlkbid0IHB1dCBoZWFkcGhvbmUgZGV0ZWN0IEdQSU8gaW4gYXVkbXV4IGdyb3VwIGluIGlteDZz
bC1ldmsgcGF0Y2gsDQpTdGlsbCBpbiBob2cgZ3JvdXAuDQoNCkFuZCBJIHRoaW5rIGhlYWRwaG9u
ZSBkZXRlY3QgR1BJTyBpcyBub3QgYmVsb25nIHRvIGF1ZG11eCBncm91cCwgaXQgc2hvdWxkDQpC
ZSBpbiBob2cgZ3JvdXAuDQoNCkJlc3QgcmVnYXJkcw0KV2FuZyBzaGVuZ2ppdQ0K
