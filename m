Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50774C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25034208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hdyMWI3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIACJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:09:24 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:63232
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgIACJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK/Oe1wR33Za2vph+CLSP/Eo4hlyd8yyY4ntecG73HFFa19BblL+jHHeETHepGwN1VfWbHO/8LKgRZNkEIogb/FYWrWi8Pp1qIEGzSKgbFQ9IfmBP2DHwqPQ5G9EHvd7lOafbk6SEWmnUq7SbPgqNrmUNh3HxvEVq3foBCPmB0fVR0RkeAiCG201VICS7HfY94b8AmRq0Rdyov7xpJl0cR8UXLW8Kb6PZ8yrsj/w2ub5UtaD/AvzvzUr6vq8JD4Dl3pxhXOmlTraDNKp3YOCf2t1ytBk1aiYWUemxz3oTeHtnCjHGkpS1wHRLYPLZ2iA9eVpY/G09Qciym/WttGszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioeZq1U9X+t5uvc7PZGixUJ/0EFrsSkFvk8hxOEJ5WQ=;
 b=oUGRSaQ7Jwhfc3w2lFQ/ooXMm6CTARX/mUiN+xIYgBD8p/eUobMHAQU+Lgn1P/f0xiQocHf7joo9lKfX6wOri/twLTPUkMKsPQGOabH0WJE20lgmyfRA7KxD5Ot7GrOz1HCEDvOcsaJxq8gPnNl6ZWy9Z0DC3FwPJpDPiiXjT3OJaPesdXY2hHAifnpllGUOyBS16ugpz3De8r6jw/P23J/6Rpl2bsq/o4mI0hA/pz9ijIskifln/AeHGqeh8abIG9BXX7oUlPvlGAVz35GeFGejC/HBfl1yWPBtXY4eu4oXLKaJVKekxLvNY+rx7Mirjc/Oo+7frvwtOxx1FnfE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioeZq1U9X+t5uvc7PZGixUJ/0EFrsSkFvk8hxOEJ5WQ=;
 b=hdyMWI3BHAFGa66WtavmGAvrNbS1eXhpBsvvqLM2iFBsRWulbNBucDhbsp5otpDoGgFzIyPW0brckxdvszNBnL9fAaRFy1ZoaRdne6cnBYnluYi5WsEyQ9mFXgb3A+Q4781DsuBNYXBpg32YzTP7ieCivQ/wYOxeJHjCyAV+tmc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 02:09:19 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 02:09:19 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM64: dts: imx8mp: correct sdma1 clk setting
Thread-Topic: [PATCH v1] ARM64: dts: imx8mp: correct sdma1 clk setting
Thread-Index: AQHWf3hFQXqwzEy5+ECIRTKF190Z76lSEBOAgAD6eMA=
Date:   Tue, 1 Sep 2020 02:09:19 +0000
Message-ID: <VE1PR04MB6638175929BFAB95FFE438C5892E0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1598895387-22313-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5DsFoq3QvVy+FAhQjnCOpJcyJOiEBPYEBnEzn39aD4ESA@mail.gmail.com>
In-Reply-To: <CAOMZO5DsFoq3QvVy+FAhQjnCOpJcyJOiEBPYEBnEzn39aD4ESA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bbc638d-3636-4c59-a572-08d84e1c092e
x-ms-traffictypediagnostic: VI1PR0401MB2302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB230209C93EA0CD1A5379CDA8892E0@VI1PR0401MB2302.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:283;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mxx+SeyiGtrEsWn/t+n9qaLKjk6n4UFbItE8rl6OP8HG+nLckhpTlbVVG6OO6XALz4a96LpRWU5NfzE4W3zIOqCDBIpRc8uFQ7m4KD2AFV1FGd5lQIIJgONgIU4pleQpq7qJzkp96VrJr+in561oGS60dOQu0Yuuf8yYsH1GmQJEPULud9C74wVZKXQtdiDowNgRWmOV2JtCqwVtWOLQaybiDhJj6nh0Bgun/9tMWOvLOenwsx7IS8sBun93zRSGJFLjxoIQ4xjvo8Pxl2YucPRDaERAK/Tak14wA7nR78JnHo8rYx4WW4I/JcBX6sHw14Ncdn/ShO+jFY0amYSyMzqioU2xS7VP6OX+vIjSh+bp8SgNlfPlnIHhu4JDVA9U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(66556008)(55016002)(66446008)(4744005)(6506007)(7696005)(6916009)(316002)(76116006)(186003)(26005)(86362001)(53546011)(64756008)(66476007)(66946007)(54906003)(9686003)(8676002)(52536014)(2906002)(5660300002)(478600001)(71200400001)(4326008)(8936002)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5CRgdzrGCLl2G7DxOnn/i5aFYZE6gM2p2jhGixRnQKbwciWFZT3p575oJRY5jd9RW2NUHMZHtOzHOjHQP9EHn0ty4xE0ARloh1km66tLUOBJv14J4t5ggX+6ZsvGxvq341/KNdInyHSY7+tjdn5QtfunyJlAQ2vPb1USgAtNeRynhghWJb0iXLTqMl5523ExyUPnqKjapNImwF7M6JH507+uX/mykaysUupL8pS+e/AMe1krkykL9G3ofiKvxVwRgBa/dpcs+W6WBpu4N0lzkUHU3fAY8Dmb1QNq369z5z7RYdpj1ae6e4s5BzJNTmWiLOXgnVFhZK+MwKzdBhv0/vHnk0CGN/7ItZ8lTZoutLwYoZh+OMh5CciiJPjObEMpYcZzeSpebK4Of4ifIKYH+r6jTdX+Ike8LwqlujOAsji5qjkXjyMcCz9Xvl5dRhx4qxTRHxdBkm8GNpAxnNZc6kCzkvFbrfOIX3uDkYpCZWfiI01TpvcR27uh0Btpsg4woZfl292xkuNVsLYrZMDl82BJ4qrnCsdIF24c+XEXZ2xXV14+1zQ0eqEDMaYRbliMifUCVd9qB3QikKnm79StPZhHSReuUbs73wqN2FsdJdomoAmoF1SPg3NoUCZfoDe2G0Ntr00/m/m3+J8sC5n5Rg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbc638d-3636-4c59-a572-08d84e1c092e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 02:09:19.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CM9WZuNnK9JHxRXjcoA/iHfNEp9j9BxbKSonHFmKSEK2lcwA9JvOmpoMlEy8iUcoL8vWKxGpSxEKM2S429iacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC8wOC8zMSAxOToxMiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+IHdy
b3RlOiANCj4gSGkgUm9iaW4sDQo+IA0KPiBPbiBNb24sIEF1ZyAzMSwgMjAyMCBhdCA2OjIyIEFN
IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDb3JyZWN0
IHNkbWExIGFoYiBjbGssIG90aGVyd2lzZSB3cm9uZyAxOjEgY2xrIHJhdGlvIHdpbGwgYmUgY2hv
c2VkIHNvDQo+ID4gdGhhdCBzZG1hMSBmdW5jdGlvbiBicm9rZW4uIHNkbWExIHNob3VsZCB1c2Ug
MToyIGNsaywgd2hpbGUgc2RtYTIvMw0KPiA+IHVzZSAxOjEuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+IA0KPiBQbGVhc2UgYWRkIGEg
Rml4ZXMgdGFnLg0KUmVzZW50IHdpdGggdGFncywgdGhhbmtzLg0KDQo=
