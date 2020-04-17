Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA780C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C256621D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDQFAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:00:43 -0400
Received: from baldur.buserror.net ([165.227.176.147]:39612 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgDQFAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:00:43 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jPJ5C-0001kX-AJ; Thu, 16 Apr 2020 23:58:30 -0500
Message-ID: <64bb1f056abd8bfab2befef5d1e6baec2056077f.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     =?UTF-8?Q?=E7=8E=8B=E6=96=87=E8=99=8E?= <wenhu.wang@vivo.com>,
        Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        kernel@vivo.com
Date:   Thu, 16 Apr 2020 23:58:29 -0500
In-Reply-To: <ANcAoADRCKKtO5p9r33Ll4og.3.1587090694317.Hmail.wenhu.wang@vivo.com>
References: <ANcAoADRCKKtO5p9r33Ll4og.3.1587090694317.Hmail.wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, robh@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v4,4/4] drivers: uio: new driver for fsl_85xx_cache_sram
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 10:31 +0800, 王文虎 wrote:
> > > On Thu, 2020-04-16 at 08:35 -0700, Wang Wenhu wrote:
> > > > +#define UIO_INFO_VER	"devicetree,pseudo"
> > > 
> > > What does this mean?  Changing a number into a non-obvious string (Why
> > > "pseudo"?  Why does the UIO user care that the config came from the
> > > device
> > > tree?) just to avoid setting off Greg's version number autoresponse
> > > isn't
> > > really helping anything.
> > > 
> > > > +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> > > > +	{	.compatible = "uio,mpc85xx-cache-sram",	},
> > 
> > Form is <vendor>,<device> and "uio" is not a vendor (and never will be).
> > 
> 
> Should have been something like "fsl,mpc85xx-cache-sram-uio", and if it is
> to be defined with module parameters, this would be user defined.
> Anyway, <vendor>,<device> should always be used.
> 
> > > > +	{},
> > > > +};
> > > > +
> > > > +static struct platform_driver uio_fsl_85xx_cache_sram = {
> > > > +	.probe = uio_fsl_85xx_cache_sram_probe,
> > > > +	.remove = uio_fsl_85xx_cache_sram_remove,
> > > > +	.driver = {
> > > > +		.name = DRIVER_NAME,
> > > > +		.owner = THIS_MODULE,
> > > > +		.of_match_table	= uio_mpc85xx_l2ctlr_of_match,
> > > > +	},
> > > > +};
> > > 
> > > Greg's comment notwithstanding, I really don't think this belongs in the
> > > device tree (and if I do get overruled on that point, it at least needs
> > > a
> > > binding document).  Let me try to come up with a patch for dynamic
> > > allocation.
> > 
> > Agreed. "UIO" bindings have long been rejected.
> > 
> 
> Sounds it is. And does the modification below fit well?
> ---
> -static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> -       {       .compatible = "uio,mpc85xx-cache-sram", },
> -       {},
> +#ifdef CONFIG_OF
> +static struct of_device_id uio_fsl_85xx_cache_sram_of_match[] = {
> +       { /* This is filled with module_parm */ },
> +       { /* Sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, uio_fsl_85xx_cache_sram_of_match);
> +module_param_string(of_id, uio_fsl_85xx_cache_sram_of_match[0].compatible,
> +                           sizeof(uio_fsl_85xx_cache_sram_of_match[0].compa
> tible), 0);
> +MODULE_PARM_DESC(of_id, "platform device id to be handled by cache-sram-
> uio");
> +#endif

No.  The point is that you wouldn't be configuring this with the device tree
at all.

-Scott


