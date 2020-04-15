Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD8C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64A520732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436719AbgDOT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:29:35 -0400
Received: from baldur.buserror.net ([165.227.176.147]:35672 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411889AbgDOT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:29:10 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jOngW-00079u-N9; Wed, 15 Apr 2020 14:26:56 -0500
Message-ID: <ef9f59f98f6bcf81891de87fd9cd0b5973bbd468.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 15 Apr 2020 14:26:55 -0500
In-Reply-To: <20200415152442.122873-6-wenhu.wang@vivo.com>
References: <20200415124929.GA3265842@kroah.com>
         <20200415152442.122873-1-wenhu.wang@vivo.com>
         <20200415152442.122873-6-wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 08:24 -0700, Wang Wenhu wrote:
> +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> +	{	.compatible = "uio,fsl,p2020-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p2010-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1020-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1011-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1013-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1022-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8548-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8544-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8572-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8536-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1021-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1012-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1025-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1016-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1024-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1015-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1010-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,bsc9131-l2-cache-controller",	},
> +	{},
> +};

NACK

The device tree describes the hardware, not what driver you want to bind the
hardware to, or how you want to allocate the resources.  And even if defining
nodes for sram allocation were the right way to go, why do you have a separate
compatible for each chip when you're just describing software configuration?

Instead, have module parameters that take the sizes and alignments you'd like
to allocate and expose to userspace.  Better still would be some sort of
dynamic allocation (e.g. open a fd, ioctl to set the requested size/alignment,
if it succeeds you can mmap it, and when the fd is closed the region is
freed).

-Scott


