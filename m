Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F780C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E252074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEv/A/0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgDAFmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 01:42:17 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:3592
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731589AbgDAFmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:42:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdvqT+ixkmgo+hbkpr27su93iJ6/Lsurl5X3kHzKwsrhTBjgk9Ve/DnoflP7uGec7yDrtqt5ACAXXxRGcRoY2U/L5QBdV4Owe/+2nRhXOfeR2QAxKrdcupbWuIlXxNlVLKCpcRG7Yzjw9jgCv/OfDvauJHDWnrz9TWHdwnPg6O8tQo2LpDm+2w0+PRjQ9QnC42M1SvC5PAC3OoVufvpo1nnD73Plhtdis+1G767jcVRPYqTNHjRvmmhYotShUHkGF2h4lD8leNKU1xygoaq3q4/ALzsytHis45Obm3iAmHAotl2YLDRoNgVwF4P53TWVYkddkKKREi6k6QwbxZCptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp1BpGfMM3aK5fdHC6m5G8efLg+rP5j9ptCbNB/Eyek=;
 b=m0IRHov00S41WNHvq2DSyZDJ2by24j/GePcRsO3E82aS2y89wh8B0wK28Rzy0SoT2jwDWAtQGPxnnbOZnfKnnlp8RwxNcgUV/BHO/b2/HFY4ZjZ1hE3GhAx0hWJ/Qo8EFmH/rOYVwoO5oqr2alBAAVbzrbaJDJz5teCZtVoQanio6zyS25Ow/x9uO7wHMtTYuS63NKpfYrNvDtufv18tlGaY0uvfscyzGO8FaUWALU0qrN9ArpHm7J+ihXbI3lS+7NLbgUItW9tsYZyftdeSD+hnOlT1C60X0TsX4Zc3G6OCaeRCfySjwBtMGk/hUyYiPC+xy8T9G6ri7Uvkt8BDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp1BpGfMM3aK5fdHC6m5G8efLg+rP5j9ptCbNB/Eyek=;
 b=UEv/A/0Jjs1YmAelcVoo4dSpU7S1DUEIUz9M5HlGHRL99XuDHvYthGBqiO4d5boRJJ1VK5prRDbMgJkrauQO+Y8FB/+3HJz6ltrTzX2oqo6gfq/bzo6mpr5aE10FOThewAB0HBm+Biy/3GLYx4Siqt38JXZT0Ly7qyCMniSoCb4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4931.eurprd04.prod.outlook.com (20.176.214.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Wed, 1 Apr 2020 05:42:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 05:42:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Topic: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
Thread-Index: AQHV/cQDu85ufqDAx06lOMhNtamjbahaF9QwgAmnWACAABWP0A==
Date:   Wed, 1 Apr 2020 05:42:13 +0000
Message-ID: <AM0PR04MB4481F99E13F6ED8F2ED9A35A88C90@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB44812577EF272CA1D457A1F788C80@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY3jqhQpDf3eBMrGRfYeS2-Gj7o3YfZJVkb7Tp+4i-QZ4g@mail.gmail.com>
In-Reply-To: <CABb+yY3jqhQpDf3eBMrGRfYeS2-Gj7o3YfZJVkb7Tp+4i-QZ4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9242672c-628a-4a9d-4256-08d7d5ff6e0c
x-ms-traffictypediagnostic: AM0PR04MB4931:|AM0PR04MB4931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB493152AB4CAF7F0F21D6F97D88C90@AM0PR04MB4931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(7696005)(44832011)(15650500001)(8676002)(64756008)(54906003)(4326008)(5660300002)(66946007)(4744005)(52536014)(66556008)(81156014)(53546011)(81166006)(76116006)(6506007)(66446008)(316002)(55016002)(478600001)(66476007)(26005)(33656002)(9686003)(6916009)(2906002)(71200400001)(8936002)(186003)(86362001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pV6Mr6gKoB0IaLRpf9yorfWur9ds44dmGk+7ArPksDCH1x4CHTksYl5Yw1+WVHlAMxKKppFs0F+aD7zJMUrXlwUbr+ZEaN+CcQbV8vaWWj5k9C+Hb0/EGDRJLJ3gJZ0pxvLF7qtlfJZKbrO1a20NKNs1FWekiuqxiVBnUN+e7di0yUKqHxkxj8jbQypu4fxLu8miwp4IiM/nY1DCbrXLLeYL5TzJWv8JKJ5F3jFIY2umrBP9x4Dryb/a34d1DbAp9O50rk1TbTlYhB4gwAkqYrfAp3lZUEdx1h9KLLH8fBwlZUxdYnubGHF4p4XJl7bB6AxLhVAH1NN06Xi6HjVLTNQz5we47DA8xow1nq2VGGmnVghcOaxLHQr1JBsOhg+AGFX4Vgii+dTNXoZ+egVQw7r3+7Wkji9DGlWGeWushzbobXwYWbmW9huf+Qj2eWPM
x-ms-exchange-antispam-messagedata: b8k2FSu8dtCoce8eiWFSHhl/2TcGW7o5q7ZQIL73OZRa3ajCvla1/hSUHzwrCpTUGtcRzJGhALi3NXGP7g9hAuU7vh++dSAkpOZ4G/BK47CfB2PLmnXaBP/XSIm6qLNcHC6a02tLCQaFGQyRZqTgjg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9242672c-628a-4a9d-4256-08d7d5ff6e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 05:42:13.4659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0w6ct6CRGTVWvNIh9Qgu2b5vu0sNdVaW6TkJSUKvsHxQgFrnhhygAQlOC7SAHJvz9ycKFc4OB9jnFceInlJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY3IDAvNF0gbWFpbGJveC9maXJtd2FyZTogaW14OiBzdXBw
b3J0IFNDVSBjaGFubmVsDQo+IHR5cGUNCj4gDQo+IE9uIFR1ZSwgTWFyIDMxLCAyMDIwIGF0IDg6
MzQgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgSmFz
c2ksDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCBWNyAwLzRdIG1haWxib3gvZmlybXdhcmU6
IGlteDogc3VwcG9ydCBTQ1UgY2hhbm5lbA0KPiB0eXBlDQo+ID4NCj4gPiBBcmUgeW91IG9rIHdp
dGggdGhlIG1haWxib3ggcGFydD8NCj4gPg0KPiBJcyB0aGVyZSBhbnl0aGluZyB5b3UgdGhpbmsg
SSBtaWdodCBoYXZlIG92ZXJsb29rZWQ/DQo+IEkgYWxyZWFkeSBxdWV1ZWQgdGhlIHRocmVlIHBh
dGNoZXMuLi4NCj4gICBkdC1iaW5kaW5nczogbWFpbGJveDogaW14LW11OiBhZGQgU0NVIE1VIHN1
cHBvcnQNCj4gICBtYWlsYm94OiBpbXg6IHJlc3RydWN0dXJlIGNvZGUgdG8gbWFrZSBlYXN5IGZv
ciBuZXcgTVUNCj4gICBtYWlsYm94OiBpbXg6IGFkZCBTQ1UgTVUgc3VwcG9ydA0KDQpTb3JyeSwg
SSBmb3Jnb3QgdG8gY2hlY2sgeW91ciB0cmVlIGJlZm9yZSBhc2suDQoNClRoYW5rcywNClBlbmcu
DQoNCj4gDQo+IENoZWVycyENCg==
