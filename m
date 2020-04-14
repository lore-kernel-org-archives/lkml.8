Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCBC2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B99C2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HI9a5upT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgDNNfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:35:51 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:58272
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727825AbgDNNeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeJ6k4wxEdK2zYWOeeuDL6u1H8YrLIfwLeuHTqfG0pGxUwnwJq035xUNsxEY/fZpbCSa1T3n+KSkqHRR6UPOiyYOjU7f+o6Uf68667X/rYu70IDYYZRiWZfWPdp0w+pPNwiGnmDm8MQqoow0WcKCr5KFAHGt4072i6VZmboULREoPQZuqzEj3Eqe11D3Ke559muzPh9Bn8fuJk5cayxniBOpqIreQNtSZci4P2UyMVFrlqLikrKc/vWJrtW8e3cKS2Z86H0AEc6CuOeTtO5wl0X/9I/1p4YkKeJHOCd06nUKpGxIC7eNQC7pET7NoipRLuteBKWRoCs8OIzqRVxNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwmGGOYnBgwFKBhGKd+Oi3bygyZv05RHLcgJPFunLCg=;
 b=F6+QJbNZRkF0UKuknFNjjsAHp/GJqzgkxQs4+sBJas4Xdo77oMuDdPEGpDbheBrLizEtfqhVAGvgQyMcS2y7Io2g9dqCmAzAulD9PsbR7VohmigwGveetk+0L3OdDRxeQRMF5AnTTKMO1kfUaRst/WU9QYGSB4ETSGPDj3Hl17X9xLHUkraQ22UAluyG6SeYmflp9zmxRHfOosqW2xNJMPZ+8lgJABQkvaQsqoinj2T+0zQl9S8c50Y46VxM3C4/MMHW+zt2s+yO5Rp4xv/u3WJz/I/4T6ZdZ8fBQxZRml1VGCkGttZV55tCzQB45wrGKmOsTBGanScn3s4fdWEoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwmGGOYnBgwFKBhGKd+Oi3bygyZv05RHLcgJPFunLCg=;
 b=HI9a5upTNZQBJfstQp+aNIWq0Z/zzI0oJpO94uMoO32eoPQGztSZsAumlDloAZXvAi3fQQmsqspGlOgSH0aQyLeBTxUdT0QFReFWf4ikHPxHKYyDP7VcMQgAAiI+TPjDhp5Aqtwn/Ldb1hQVluDh4rR5bom8zqiugqaZxauBZ6Q=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 13:34:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 13:34:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
Thread-Topic: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
Thread-Index: AQHWEmDdM8QPFjiGdUiIpKIFO8zVmah4naUAgAAACBA=
Date:   Tue, 14 Apr 2020 13:34:20 +0000
Message-ID: <AM0PR04MB44819E180407DF7CD1D4194488DA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
 <CAOMZO5APoqzvptc9gY2r69MzZ=gjTnsr2UV519xJmKmEkcx3=g@mail.gmail.com>
In-Reply-To: <CAOMZO5APoqzvptc9gY2r69MzZ=gjTnsr2UV519xJmKmEkcx3=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [180.107.26.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 424b8497-5c37-4934-36cb-08d7e078899c
x-ms-traffictypediagnostic: AM0PR04MB6868:|AM0PR04MB6868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68689DD9D43565D4F3C459BE88DA0@AM0PR04MB6868.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(2906002)(5660300002)(15650500001)(44832011)(26005)(76116006)(86362001)(33656002)(71200400001)(6916009)(316002)(186003)(8936002)(53546011)(6506007)(4744005)(7696005)(478600001)(4326008)(81156014)(9686003)(64756008)(66446008)(52536014)(66556008)(8676002)(54906003)(66476007)(55016002)(66946007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGpji+Xwtyk0Ly8Rj/dqZXLNAs8Mw/eQstAJTM2vArsDCI0jrZpGtCZHn2BH5mNvsshf/ojd8wguUnduBMmfBT8ELb/Gyq/46FYwJ6VXQzQ6puzL74sKZZwo5bIBDKhMf70rSStum9RyxYII8Ux6QgdAmezKNXVRNBGJKXy8lhwRyKxIgbZRcaRK0BD3CRzYRGVrlRlq0DJPKzG1ZT+U3c1HIH+nYFRPCYIwXJeL69Z2fgjoctvEJJbKrF8sWhcXmaLvwt48ePl3ts7s7DpLbLzWe3dpemIQ5eUD9ksSVAIMiz1H19GXKUDY+H2bYHSflKNtxqWKH/uxeKyDoe3vWjAr8stOB3/4eXc0PPNwnPrMURgpyMFxa8xFkt3QgHz1tKO8hKdO5VmLc5/EF4iFOMYUbBYaLn0DGvYQpoRJmeySjtWA3OrYmGlOlRV28Nmr
x-ms-exchange-antispam-messagedata: 04GebbzK7Nrw05PGp9JYC7XLzT3UL81muYfY19BVwnwLRdLgKobvtKZBICl3uqwdrvuY419Dnnqbcex+Ydh+Md+PGLrAkcG1XMXEFfEpDXcgP+gldTuQoKSRBJEM9d8QrjH/BIJncqOJ2ELa3C1mQA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b8497-5c37-4934-36cb-08d7e078899c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 13:34:20.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwSMlxUZECQ6lOi43YCAmM0TXkgYCZT8xp1ZmfBmqF7nLDoj/TlUbln8OSmHO061NQH24g5/IrpWzcHRwih5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gbWFpbGJveDogaW14LW1haWxi
b3g6IGZpeCBzY3UgbXNnIGhlYWRlciBzaXplIGNoZWNrDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4g
T24gVHVlLCBBcHIgMTQsIDIwMjAgYXQgMTA6MzAgQU0gPHBlbmcuZmFuQG54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBU
aGUgaS5NWDggU0NVIG1lc3NhZ2UgaGVhZGVyIHNpemUgaXMgdGhlIG51bWJlciBvZiAidTMyIiBl
bGVtZW50cywgbm90DQo+ID4gInU4Iiwgc28gZml4IHRoZSBjaGVjay4NCj4gDQo+IFNpbmNlIHRo
aXMgaXMgYSBmaXgsIHBsZWFzZSBhZGQgYSBGaXhlcyB0YWcNCg0KVGhlIHBhdGNoIGlzIGluIExp
bnV4LW5leHQgdHJlZSwgbm90IGluIGxpbnVzIHRyZWUgbm93LCBzbyBhIGZpeGVzIHRhZyB3b3Vs
ZCBiZSBpbnZhbGlkDQphZnRlciBwYXRjaCBnb2VzIGZyb20gbmV4dCB0byBsaW51cyB0cmVlLg0K
DQpUaGFua3MsDQpQZW5nLg0K
