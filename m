Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673C6206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m61rMw7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFAIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:09:36 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:53729
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbgFAIJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:09:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT6WkpnV660lFVf/CKbAi4LuNU4/hOGp9TwUXt+G3/QzhlVUHkEMi/Gg62gInkGtddhyAA/LXHQ2LKn6XvUiWCyfw1FhCYAw8Ue8ZjKaOP1tMGIe8nt5aedjdFzjoCO61REdat8AIJj5IfLGlCEC5VNUDX7iUTXvOsavkEypyXjHURfx2g8zAAKbAbZ32k2Sjad7amiEkLztcjki/5X2AISRLyUu3a9dXE3NgHPMwtghIPTOHaRLk5t7iU/usiibCzEEzoMl7Qq8YusFrahz1VcwmX1xi3oFONdmzQ9Q5N00/XEYGlETKCZAUu4sJT8Zj2A/N0ZxM5MAIgsQtL7r1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlldKTPOzRl5uttcYkLCLC0NNsanvqPm3xO5cx6nxFg=;
 b=YG86M6BhKtg6c+wkjDBWOwxDrpoeYe/xd80pgSy6KhjuFXFJPqJ6EYer4bH98Os54Agdf4oj+ggjv9nK+qyiWEKwKIVwHQi1E5PpDKCfm2Vgin0tAI2GPasKk3yamaE+lwwPJa4y0k1ybCBhrUy5QkCrWpOi8VTS8cAaTC8iDs3DKc5h9SFql4DL+MuvynGrxUjpzLMSXZvbUIamRtTxzIiKI8VERxW93l4ue1mQcJLikQZavZuGgWS9dFNnVloHuAa4D0vDDDLNVx5apKZlv+3Y9WikI9zpTFJr+QcjV/ps44j4EbFLvSIDSlL3K7ZgcnkgkrKE+N6y8ngvsEhaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlldKTPOzRl5uttcYkLCLC0NNsanvqPm3xO5cx6nxFg=;
 b=m61rMw7VrWmjanwk8sTZ4YCTtQcKxrQagPJY8mn/Rhcw8M2zs0BMVi2nWAFSVcsiIhQJ6mKb+M5GcoKotdfZgzcx29XG2XYqgBkDUb3U5Uac67lxprBAoa34zpJdvnB36nujn9Y3dylhuIq71m+SHNGd+Wod80vBH2J/RLOD45k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3724.eurprd04.prod.outlook.com (2603:10a6:8:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 08:09:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 08:09:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Topic: [PATCH V2 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Index: AQHWN8hdDs3JBnTPuUm7D5bEkD1mjqjDYSYAgAAHK/A=
Date:   Mon, 1 Jun 2020 08:09:32 +0000
Message-ID: <DB3PR0402MB3916D64DEB5D5B578BE6DF4BF58A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
 <1590982999-7149-2-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB496668011F3AB2BEEEE6D1E1808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496668011F3AB2BEEEE6D1E1808A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a39e6d1-9eac-41fd-cee6-08d806031dd2
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3724DB5B879090C53372DEB6F58A0@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UG+0Id70VFVk55MFZ7FhHFL0YuvDPTQEbqUTmfV8hIHAwko7v7wOuaX3i2K3TBwZbtuuiMXD5seACU2ILeNsX5MhoyEL4GyxLoTrVCEuYetmAeXikEUrMY2hf8ecz2NefUjpRm1CMtuptrdM/b53hwku8v2Gd3zcXOCFvxyLNi5tifS2QiprHynL4recSWAiI+erQGyEiaWqfFKJYPr/BDP5CEedvxO74QS77Vdz92Mlc23qZrRcnwafzU2PPQjaND/4avwujH1i2VIR+FzGyac9mujbPSn0GcJa7nLGUQyeRSTv7asYARbkQwhxE2T15uZwM3l7Mq9Tf8aR2TgzPJW4hAbVQSinCf0j9Mxf6xSuYwjhN3tCCdcqZ6IVod7j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(4326008)(33656002)(66946007)(76116006)(66476007)(55016002)(83380400001)(9686003)(110136005)(64756008)(66446008)(66556008)(2906002)(8936002)(7416002)(8676002)(86362001)(52536014)(54906003)(316002)(5660300002)(71200400001)(15650500001)(44832011)(478600001)(26005)(186003)(4744005)(6506007)(7696005)(15585785002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GJybro2uFAwwHbsI/IMmOatz7CBOHMab0YouHb9hRxF93SkIFb2QLfpcLcgaOEQv+t9pxPD/ySK/zm5R5E8+xpcrivYakv7Xl+NyL3GIXn8vR59JlZT01NEPX+gKhlALX4M/tJPH+l/vG+Sk0hnz3GF5ZG4NStsZ1Rdr/0pxcdq4z732Xpkk722yyk38k/veAUTTBN1FbxAirxn0aKqn3OfmyaSIn8OAwVw5tDP+4RjbOrBUCwaSMU+sDoKuLBxblsi5uvlIN0zSgl+1aAWtDpmsoovo9nrTbXX//UKdHKCxgjMRnfVPOCicnaDlfLvO0AdB5E2CL5xooar72JUOefq1+qh7W8kiafW0tbJnlCuqTszwlglKEDIL8FQ6E/q5JpLkhEQ5uOhJny7AAPXa5IjVpl3VZyY/q0qWfmWd884u62Xs5AsbkyIecyI9jTWheetYjLc+6myL5Iucyur2fWIGBl0wpqpxLi7NtIt5j3U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a39e6d1-9eac-41fd-cee6-08d806031dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 08:09:32.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmiRy5K4jlgw0gUuoiI3tDdST2fIJGlY6QSOECi21GnzWIoKGQRbXNtAa6PxFhGxCpr2ufPr4ytReFR+R5E5dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMiAxLzNdIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBp
bXgtbXU6IHN1cHBvcnQgaS5NWDhNDQo+IA0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgSnVuZSAxLCAyMDIwIDExOjQzIEFNDQo+ID4NCj4g
PiBBZGQgaS5NWDhNUS9NL04vUCBjb21wYXRpYmxlIHN0cmluZyB0byBzdXBwb3J0IGkuTVg4TSBT
b0NzDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0K
PiANCj4gQlRXLCBBbnNvbiwNCj4gd2lsbCB5b3UgY29udGludWUgdG8gaGVscCBjb252ZXJ0IE1V
IGJpbmRpbmcgaW50byBqc29uIHNjaGVtYXM/DQoNCk9rLg0K
