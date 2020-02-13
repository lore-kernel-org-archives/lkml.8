Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEC9C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1520848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgBMIS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:18:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgBMIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:18:57 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j29hh-0001zY-Gy; Thu, 13 Feb 2020 09:18:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j29hZ-0005R6-5H; Thu, 13 Feb 2020 09:18:25 +0100
Date:   Thu, 13 Feb 2020 09:18:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, allison@lohutok.net,
        tglx@linutronix.de, andrew.smirnov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com, sakari.ailus@linux.intel.com,
        bhelgaas@google.com, dsterba@suse.com, peng.fan@nxp.com,
        okuno.kohji@jp.panasonic.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: imx: Add missing of_node_put()
Message-ID: <20200213081825.mox35tzizscdk7km@pengutronix.de>
References: <1581574854-9366-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581574854-9366-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:20:54PM +0800, Anson Huang wrote:
> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- correct some of_node_put() place to make sure it is safe to be put.
> ---
>  arch/arm/mach-imx/anatop.c     | 3 +++
>  arch/arm/mach-imx/gpc.c        | 1 +
>  arch/arm/mach-imx/platsmp.c    | 1 +
>  arch/arm/mach-imx/pm-imx6.c    | 2 ++
>  arch/arm/mach-imx/pm-imx7ulp.c | 1 +
>  5 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> index 8fb68c0..5985731 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -135,6 +135,7 @@ void __init imx_init_revision_from_anatop(void)
>  			void __iomem *src_base;
>  			u32 sbmr2;
>  
> +			of_node_put(np);
>  			np = of_find_compatible_node(NULL, NULL,
>  						     "fsl,imx6ul-src");
>  			src_base = of_iomap(np, 0);
> @@ -152,6 +153,8 @@ void __init imx_init_revision_from_anatop(void)
>  
>  	mxc_set_cpu_type(digprog >> 16 & 0xff);
>  	imx_set_soc_revision(revision);
> +
> +	of_node_put(np);
>  }

It would be a bit more natural here IMHO to introduce a second struct
device_node * variable for the fsl,imx6ul-src device. Then each
of_node_put would belong to exactly one of_find_compatible_node().
(Now the of_node_put() in line 157 frees the fsl,imx6ul-src on i.MX6ULL
and fsl,imx6q-anatop on the others.)

The other hunks look fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
