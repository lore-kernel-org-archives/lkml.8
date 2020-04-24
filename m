Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288BC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD0A20715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMLv4rlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDXB1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:27:34 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:29627
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDXB1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcL9Jv6gGJ0dR/ViJCRHfJdlWoaPulxjzl9atkw5E2LKw0O1/3oH61qGxZwFMt2TIYo8UB68UHS1eqxMGaitFJIyr8PDqCLMtGLcJ6MLZlf3m8PzcuzxihaKasO/Sxk9DLsA4xnkkiGDf27NNS0FSN0XlPzgXmWG3BnQnXo28txvt3+4XMZ/4Cu/RkXkYY64nvwBJu0YW50+rYMT98MuyGI72syHSwfGHkFCQ1mubXzNR15c+L6MufpeWiHJR6dZJBI7AckYr5dYEomkBHXkPlI/fEVoOKU7rFIjIrnzm++X/g+8kQ78zWxNRLnShxIqWwtS9Dz88wQwmtVem6p8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf3qSZRe0tUxuyFmLdTY89kt3ngsw3La2Zje30Qi88c=;
 b=jtn+nDOQtJxFEuew+uXM7D4bksaSQ3AbN3q2qfWhIcJ5A3B8AhzdmVxxRMSCEftp2jmBXT8y672rFPiTTJ6eFIXWy/2wcr8D5k0cmcW5nwvSbb/Xwfr6tDFJXsTtm7q/P0iotDAalEMDFj0sA481e3jOIAAJliZL3tSk0WlDDTSy3h9x9zRBGsAmcB/U7JET2VjbDa+5ekFace/BXyl9IaXFlJ8xyPnwd/AAoTf4zc9nQNZ5zAVsJ7tXOUA9ghhiAA5d6pXc9canqEM3cyQtXtuMhdXk8r1AE6/LG1O26vWCNI6MT0TfmUwFb2XN6qo1qSxCc29LLVWmMMI2ARpgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf3qSZRe0tUxuyFmLdTY89kt3ngsw3La2Zje30Qi88c=;
 b=AMLv4rlQEwE/NhqJa0vNMHyI6WGnV0MuQFOahZsducxTvy0fTltgPxmrXWKsg2js7PdZ1fCMPWa+gd9smakQHNWcpFtg34C3MslhVoBNbg7akmZQ2SQewNPsORe3PqSnt0jNjLUb+oXCNvardr/ql1lU8DJxVF1+0fJDrpR6Z5U=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 01:27:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 01:27:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Thread-Topic: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Thread-Index: AQHWGTO9B+V6d2Mrk0mLlfc3ryCDK6iGhKwAgAACseCAAAk/AIAA6upw
Date:   Fri, 24 Apr 2020 01:27:29 +0000
Message-ID: <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk>
In-Reply-To: <20200423112244.GH4808@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92463d55-0b06-43e5-09b5-08d7e7eea753
x-ms-traffictypediagnostic: DB6PR0402MB2725:|DB6PR0402MB2725:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB27257113CC0FBB728661532388D00@DB6PR0402MB2725.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(66556008)(66446008)(64756008)(66946007)(44832011)(81156014)(7696005)(4326008)(86362001)(8936002)(76116006)(2906002)(8676002)(186003)(71200400001)(6916009)(9686003)(54906003)(55016002)(52536014)(66476007)(6506007)(478600001)(33656002)(316002)(26005)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +yULakLgcwQtTW72tlJauu42i8Fyl99X6cqHiD21UyZBTEslObM3AvNLy65ek+c1paoqf7caBlcuWkStv+SoYjcfHXneZMxCeCTtqeizKMBWMY8s2VVkv6T5JXvHiQuoX/zUdUjKQkzVC8reIX4EmBQbk9+L4Mp7sr1lRepRVb20+57Ue/o0q5ckYQkI3RwBi2UsbgVIxStS6oXM6kpkjFWjqp/RBGbOLfwZu/nNzxYv4ETU76OvktFqMYOlwz3dilhIMfgAO5IGd2VhVDcW5FjW5PuKNsm221uGVxLDJ4IcYb/4eSYM/YgcBXp89BOWZ0NwXuCWhqeppMxeHlcZFFpiuzvk7TVcwZKySeT1T38JGYSL7dzyeybNUrEaNTiTbE8sr/d5ynOzu+62PBuDiToMi13oYP3ssrHueXgWDFnrcildf9yMX0Tum8kjxlAC
x-ms-exchange-antispam-messagedata: kbg/hfKElDVejYv7XJR4OGv/2Ji2WrLBBriROe/9aqrFJGG19i/pUOth5Mwg/cYU8Q+fes/btS7KxK5l0TJtG4u7cS/lKv04VsGLnj0cSngZPDEiNGeej1FW8H2gtxhKl1m2TTnM2wRKl5paXJy1gA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92463d55-0b06-43e5-09b5-08d7e7eea753
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 01:27:29.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDtjk4/aE60aN+HIaJZ2G+90pj19VV25VSSDrCfL6EIxOIvn2ROpilwuF3bqQmWPWdWDIhJgnP6PAvjHWq4c4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] regmap: mmio: prepare/unprepare clk only when
> read/write
>=20
> On Thu, Apr 23, 2020 at 10:51:36AM +0000, Peng Fan wrote:
>=20
> > > This will mean that we're doing clk_prepare() during I/O which isn't
> > > good since for MMIO regmaps we support I/O operations in atomic
> contexts.
>=20
> > Ah, yes. Do you have any suggestions? If we use clk_prepare at the
> > very beginning, the power that binded to the clk device will be always
> > on, and cause power consumption high.
>=20
> Not really in regmap itself - I think your best bet here is to move the c=
lock
> handling out of regmap and up into the driver.  regmap won't do any I/O
> unless your driver calls it so this will work fine, this support is only =
there in
> regmap as a convenience but if it's getting in the way then you're probab=
ly
> going to be able to do a better job pushing this into rutime PM in the dr=
iver or
> just having direct clock calls.

If we not pass clk to regmap, accessing regmap registers will hang system w=
ith
Debugfs enabled.

If we pass clk to regmap, it will make the runtime pm power high, because
regmap mmio will call clk_prepare at the beginning.

That's why use clk_prepare_enable and clk_disable_unprepare.

Thinking about another direction, how about add clk_prepare and clk_unprepa=
re
into debugfs ops open/close?

Thanks,
Peng.
