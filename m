Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BACF20702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WveVnYLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgGUOUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:20:53 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:35168
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbgGUOUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:20:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOXNjxtUKTz6oRijv0ujrbUr8dBEnVOx5Syf0MS5p66Hl9wk2Ji66kOvi7cNMp38tujd586rZCe1JKkUQRid0EAcnes+mpeDpBGfa1mZ7gkIzh+Qu2jHdwH5SboGoV157ne5m0XQb4a0iBg2Gvq5y1P1cmt9E2RnTYqhXUYV1JTJHBBV5L5g/ep4/TVwwT8aBHnoyv24Yvd9FfBNDdakXB2vl2QryUTF12VE7B6QVpEygqdgqg7hNEsMP+ub6CCnyzYxdUc8JOav+oYprShuVAuamFeJGjMMLlOdj2kAV4+nHfmYexiteFK0Z+c37BFoLnfm2UZdqoGX67Cj3+EV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7soWmPq2azqlHD9jzBjQBQdFQUhG5FqZN2Tw0bcNvU=;
 b=WaRRwdjNQdGgMdYG4z381unLhSLbzJFJflQWEfs80XkUUeaMSf3l4jC5BHW6Y8E12ugRobKBPFl1asQn+Pc7rm1uIjktCaua67A5OVSnMUBfE5KFQpzPNS9fkrDXngzTfkV9kKJPDHXIY21wU7P49oBHGIg/dHbQ/NwQ5ZEd5SOSzpgpm8ze/jrPoNDyKtDP6b6P5jxmVqrLqwmgyYNwaGHdT22i2xp7Dd+rrPEFKYaW4RuKzgEQBWkPJcOMkbHe3NXILlb+9pEcFs0QaSvN07tf6Y9iGNqFf9YXFUrzc3xFLohghggoG1f4cHZEe4M+ysu50a0IM0pSEYMC6teeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7soWmPq2azqlHD9jzBjQBQdFQUhG5FqZN2Tw0bcNvU=;
 b=WveVnYLxGKABh9V1M/R9XgB+gnlr21awpYJ7yjM/t+N0Cy/hZIdcaA2DPJBu+GNGJXnvrpQEoK/MPU2oQiCZyOkDmYhdy/hIQI/QNonUiwqHZGLlIcNyjSgKC68Gy+TyzF2x7NSBlQsBx0Q2boqhS7j9/lypalBGYBAZOGJ9ONc=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB6031.eurprd04.prod.outlook.com
 (2603:10a6:803:102::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Tue, 21 Jul
 2020 14:20:48 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 14:20:47 +0000
Date:   Tue, 21 Jul 2020 17:20:44 +0300
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, lukas@mntmn.com,
        agx@sigxcpu.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/5] drm/imx: Add initial support for DCSS on iMX8MQ
Message-ID: <20200721142044.sapgfboekk2e53zj@fsr-ub1864-141>
References: <20200721102007.18368-1-laurentiu.palcu@oss.nxp.com>
 <20200721102007.18368-3-laurentiu.palcu@oss.nxp.com>
 <58a3ebe2620008daeab826a8216b6b5ad672fc7c.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a3ebe2620008daeab826a8216b6b5ad672fc7c.camel@pengutronix.de>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AM0PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::14) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141 (83.217.231.2) by AM0PR02CA0001.eurprd02.prod.outlook.com (2603:10a6:208:3e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Tue, 21 Jul 2020 14:20:46 +0000
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a4e9503-8ce0-47be-74a1-08d82d814351
X-MS-TrafficTypeDiagnostic: VI1PR04MB6031:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6031D84CF50CA5381C53B010BE780@VI1PR04MB6031.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfT8ckg8Vi2o7dyfuzGJWvdt8VLISLwj9mzeuEoEaV7kiTE0EP1E8K31UA+q1lVb0OVYDIvlBoU2U6N2fbfF68y8YiSL9EuMO6QvjK4BnTbJSTrdPNyRqBDBAc3hgXqgSxz9kRwQOs9jp6zTTzeusvYajAbkCNDip3O/0EwamjrR+j6APi/I0E+plpIrECYTLN9Rm+dgqoqOMJSw97IkNL/MDizekMSb6xqAMZUqKYG/aP4DAz33bWSrWWWw7lTvdiYvzwSylL6nxKIO8u6eBA8tr8ip8M6iR7LTAD/cVDGlXLS+6vNB73yhBbO+t/wSZETILH8zc5VO7+NBiKOL6ZRcGt3A9xGMRC992iYeFy9RbizmlbxHGYO3RyoMf+4eHNc2vCecM5syUeH8I3jmlFcKuHLVWNeI0jWNgjm7uhRgQtggECprm+WddcgtQkN7xn9VTNATkPADlK9JcVu6TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(33716001)(8936002)(55016002)(66556008)(52116002)(66476007)(86362001)(44832011)(966005)(1076003)(956004)(5660300002)(66946007)(8676002)(6496006)(83380400001)(2906002)(54906003)(9686003)(7416002)(6916009)(186003)(16526019)(26005)(498600001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3902j3MteW+7c3eq2Z8MutUc7LFWmKEO+t9YoYJaHlu3dvJZ1kqp8/D/tYTEwMH+f72V2bpFvluFMe/K5eR3lagwDAv+tI+xw6cm+Wi3f8V2ma7usPJHCYGno/QEvmQM3dAQV30K94ZmvgBNAMjIDb+EjAJ47Rq09altsPwk5UsMp/8fgrRwXJDz8C0Qh83OD9/WPXWwOTqJj9FeXGqsF2FcDSK6OUxdeLEKPe4h013th3bA0E1oTGVUZq8bJS9ltPXLyR6LCagKTPgB5WZP0AMt6Snr2zT4Wi6h7MJ5SHyBfuDaBi+mK+f9h5ugEH4ESmFp2QrVYCxpaT6pq1JmZ8itHmmEAvqQD9kzojbt7G4JQ7SrFWSBmEE6/REAob/XreR965Y4a/rKXUpUYLLIXziwZ1haDtvFDUTrZXzTmDZFkvxPczkP2PCLl5BB+tlZZQJeTp5Q88PF09I8bmt6a91hxXBaqjLS76ql1Eskb/o=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4e9503-8ce0-47be-74a1-08d82d814351
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 14:20:47.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkaFGQd4Ep5hj9ptdb1MwAMRbJZ4jR9u5g9aU4OIvPy2jufHnMTom69mVW66bzGn28owqdCItpHZiNxZ5ENE/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Tue, Jul 21, 2020 at 02:43:28PM +0200, Philipp Zabel wrote:
> Hi Laurentiu,
> 
> On Tue, 2020-07-21 at 13:20 +0300, Laurentiu Palcu wrote:
> > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > 
> > This adds initial support for iMX8MQ's Display Controller Subsystem (DCSS).
> > Some of its capabilities include:
> >  * 4K@60fps;
> >  * HDR10;
> >  * one graphics and 2 video pipelines;
> >  * on-the-fly decompression of compressed video and graphics;
> > 
> > The reference manual can be found here:
> > https://www.nxp.com/webapp/Download?colCode=IMX8MDQLQRM
> > 
> > The current patch adds only basic functionality: one primary plane for
> > graphics, linear, tiled and super-tiled buffers support (no graphics
> > decompression yet), no HDR10 and no video planes.
> > 
> > Video planes support and HDR10 will be added in subsequent patches once
> > per-plane de-gamma/CSC/gamma support is in.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/gpu/drm/imx/Kconfig            |   2 +
> >  drivers/gpu/drm/imx/Makefile           |   1 +
> >  drivers/gpu/drm/imx/dcss/Kconfig       |   9 +
> >  drivers/gpu/drm/imx/dcss/Makefile      |   6 +
> >  drivers/gpu/drm/imx/dcss/dcss-blkctl.c |  70 +++
> >  drivers/gpu/drm/imx/dcss/dcss-crtc.c   | 219 +++++++
> >  drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 424 +++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dev.c    | 314 ++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dev.h    | 177 ++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 562 +++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-drv.c    | 138 +++++
> >  drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 409 ++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-kms.c    | 177 ++++++
> >  drivers/gpu/drm/imx/dcss/dcss-kms.h    |  43 ++
> >  drivers/gpu/drm/imx/dcss/dcss-plane.c  | 405 ++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-scaler.c | 826 +++++++++++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-ss.c     | 180 ++++++
> >  17 files changed, 3962 insertions(+)
> >  create mode 100644 drivers/gpu/drm/imx/dcss/Kconfig
> >  create mode 100644 drivers/gpu/drm/imx/dcss/Makefile
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-crtc.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.h
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dpr.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-drv.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dtg.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.h
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-plane.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-scaler.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ss.c
> > 
> > diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> > index 207bf7409dfb..6231048aa5aa 100644
> > --- a/drivers/gpu/drm/imx/Kconfig
> > +++ b/drivers/gpu/drm/imx/Kconfig
> > @@ -39,3 +39,5 @@ config DRM_IMX_HDMI
> >  	depends on DRM_IMX
> >  	help
> >  	  Choose this if you want to use HDMI on i.MX6.
> > +
> > +source "drivers/gpu/drm/imx/dcss/Kconfig"
> > diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
> > index 21cdcc2faabc..b644deffe948 100644
> > --- a/drivers/gpu/drm/imx/Makefile
> > +++ b/drivers/gpu/drm/imx/Makefile
> > @@ -9,3 +9,4 @@ obj-$(CONFIG_DRM_IMX_TVE) += imx-tve.o
> >  obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
> >  
> >  obj-$(CONFIG_DRM_IMX_HDMI) += dw_hdmi-imx.o
> > +obj-$(CONFIG_DRM_IMX_DCSS) += dcss/
> > diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
> > new file mode 100644
> > index 000000000000..988979bc22cc
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcss/Kconfig
> > @@ -0,0 +1,9 @@
> > +config DRM_IMX_DCSS
> > +	tristate "i.MX8MQ DCSS"
> > +	select RESET_CONTROLLER
> 
> Why does DCSS select RESET_CONTROLLER?

Why indeed? Apparently, for no reason at all... :/ I must've used SRC at
some point, at the very beginning, though I don't even remember using
it... Hmm, weird. I'll remove it. Thanks for spotting it.

Thanks,
Laurentiu

> 
> regards
> Philipp
