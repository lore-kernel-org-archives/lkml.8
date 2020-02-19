Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F121DC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C251721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AdkOxge9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBSJzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:55:43 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:37298
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbgBSJzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:55:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhPIkTGq/DmZKGTO55vrBn9jnfaQ7tycRCS9yw/UiHVDp/11CAuG1aaY6NP91s6BXFL0oRzxaB47v3kXZkX6/EkgBC/rOpSSh3d1FEEfG65fJI4F6rVny0L/gFdbKfQGaLoBo0eXbsOI9Dg3CSMZ3C0epp0Lg68D6EQGZb9ufTfBKny/BP0Pm1aFh9bwudbi0JhPCriy4cAyJ2FXp/6+OnM7bOwfDDJEMpnw6GMDERuNSt0YjS1pC9UZO2MFVmJl7/1lsEs4iX4EGLOjxJYfTDWfWi1Ll3nX1JBlg56m4FBQ7ADEQln86wxJgJgtZxKgklrGpQRpgxUQVF/b7f9EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqD83DZNrnn/o8j0K6PwZLQEadzOVt1Lxc7Jw432W0o=;
 b=GhbioS6N+a2dP7k0BKImypSiI3pyisxMyG9F0nXubViudONfEAxFu92XVSG6Uzi3+UcSTU1U2wRuBO1zgKF/eEWGnD99O5yyD22KHlWjG3Eh5h6mc/qSvmigiUkcIsNn5B+N7X3xAfTQZASYNjZx4I11D39Wkpcvut+8QmfcmnMnjTJofaOXyUMacfUcXqvWiQjgZuu0QJyebBWZPyuF46VVIveoiZgdbwTYGqq9pw8qcl7c6Qz0KQVM4+R81fIqbJBP+J9NS4YavzchRILaw7okAUYJ2JSOK6mJP+pGbEo6cQgPoIkH2zghv0pyi5bwW9vyFz3X+DnnJC6I9ZlweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqD83DZNrnn/o8j0K6PwZLQEadzOVt1Lxc7Jw432W0o=;
 b=AdkOxge9SqQM7ofmHw0WA271sfEG13bR91/OIOGoUR5Aj3oVu1o98q5s5+yLj+dQexpxZugZ2XPDgaDgSn/pfIgSKxHyDWHtR7YoODL1Xk11P61FiySDUUAN5ww5hlrmQrp/jwp6ysyRXIQ1KISfk/NRG6pbX6xGxYHKg5OBme0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4979.eurprd04.prod.outlook.com (20.177.40.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 09:55:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 09:55:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
 intermediate callbacks
Thread-Topic: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
 intermediate callbacks
Thread-Index: AQHV5vuGM17dCu5aOkOrNUFZCKyD1qgiRNWAgAAAzHA=
Date:   Wed, 19 Feb 2020 09:55:39 +0000
Message-ID: <AM0PR04MB4481BE7EB99F6D3E198A4D7088100@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
 <20200219094603.2yfat5xxyabunlja@vireshk-i7>
In-Reply-To: <20200219094603.2yfat5xxyabunlja@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f30c23a-0281-4a2f-89e5-08d7b521e03e
x-ms-traffictypediagnostic: AM0PR04MB4979:|AM0PR04MB4979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB49793C215A9151F5918A837588100@AM0PR04MB4979.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(2906002)(53546011)(6506007)(8936002)(26005)(81156014)(52536014)(66476007)(66446008)(66556008)(64756008)(5660300002)(186003)(8676002)(81166006)(66946007)(76116006)(86362001)(71200400001)(6916009)(316002)(4326008)(54906003)(7696005)(33656002)(7416002)(478600001)(9686003)(55016002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4979;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zzjx40BdPqviYtovZr+0yorcMGqlPSXwtFfwvd42CwWaHOXKdduvPHffQ8h/zB0Tb0DKxYZqNT0DRtv0vD+eFDprIkYuCvXlrGhNVhXDTNpndSOJXXro5ba4KFaZQMWiPqTPy8RoK49Ywk2SXfDTTcgoi5OWE5wtkLub2NMRmKYBv5NpEeJ5k2bLmAzqlOpkmec+YVQOvoMST6fUbSY9PyJC/idIuBIqfvMcfRMUFU+syhlASQ98lgD8BWbLJGsxZtt04VZfa2n9AdEnFc8Seb8PJdWW8I2Lq9jJtOHd0y7taBbVxgy73xWaYNIpKn/yDXWBKLkBEVzwF9tFTnLmsVHiNpVTtOKNd8KGe8JXoMXa6aixvAPbgRBFG5dPg/QssEhQyRmZJRr65L0nxyxuroCwL/wdd6m4O9kco53DO9sRyuszfbmsKOxTIKC1gu2v
x-ms-exchange-antispam-messagedata: w3Yb/n1Gz6lNZxgCCkbHk9VUm4xYMFiAswrwU/ltHkq5nTRJybvgFIBQeM1X41xur8Lk9OIcJ5iCAYr13yTa3lD6MFP7jH7GrXkghtfC/8ZvLOczT0tRq7PMkkhIGu9jMHE6QcEMM0GJWMCpRHS8SA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f30c23a-0281-4a2f-89e5-08d7b521e03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 09:55:39.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxrmUlPCZ0k2t2PRXK6nGA0SHG+Jb9ZuxWgEVMHXSFNI9AhM7qsKGvMMDFpxkDxGAv9AJFbp7Eunj9hKV7U2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

> Subject: Re: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
> intermediate callbacks
>=20
> On 19-02-20, 15:59, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Platforms may need to implement platform specific get_intermediate and
> > target_intermediate hooks.
> >
> > Update cpufreq-dt driver's platform data to contain those for such
> > platforms.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 4 ++++  drivers/cpufreq/cpufreq-dt.h |
> > 4 ++++
> >  2 files changed, 8 insertions(+)
>=20
> Looks fine to me, please lemme know the patches you want me to apply to
> the cpufreq tree.

Thanks for quick reply.

Patch 1-9,13 needs to go into i.MX tree. Patch 10-12 needs to go into your =
tree.

But patch 11,12 depends on patch 3-9 to make i.MX7ULP cpufreq work. So
for now, only patch 10 could be directly taken into your tree.

Will let you know after CLK and i.MX maintainer agree on the clk part, then
you could take patches 10-12 in a whole.

Thanks,
Peng.=20

>=20
> --
> viresh
