Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFB82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587109352;
	bh=RytlNnohLlxheLZs5JJcHJ+1KnMXZLuPP/8eBpkQuUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e6T485NuTRHjfOsjX6xu25qe8ZWEFkT9QgLQg61CHy2g3U7eqqkFQuZ00m6AY99Ei
	 1gpHoS17UHj8uCF4hwRyrxHzxgppiNWOLJagOqWuyl0s4NsKmuXd8vkrEnDAijlPfn
	 Y5V84f8XnWQMjFzZcr2bcXjtr+Gl1DiwMNVUdqMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgDQHmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgDQHmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:42:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3AB820857;
        Fri, 17 Apr 2020 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587109350;
        bh=RytlNnohLlxheLZs5JJcHJ+1KnMXZLuPP/8eBpkQuUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiGeoQhVN4HMT4L+CV3ztP5pYHp8T4N4tbLB/vti7FyUdbJFOtZbnitIBD4kZ7FMz
         i9Z/qZgaZ5Z3aTEZcCjHVVshVUKijJc0+SE8xXX5M0sL9Rlnfh7GPNLq0+A7WlIBSp
         WoavnouHAulpBOyWRrbSR2tdOAS0J17BIpIV94hU=
Date:   Fri, 17 Apr 2020 09:42:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Scott Wood <oss@buserror.net>
Cc:     =?utf-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        kernel@vivo.com
Subject: Re: [PATCH v4,4/4] drivers: uio: new driver for fsl_85xx_cache_sram
Message-ID: <20200417074228.GA22586@kroah.com>
References: <ANcAoADRCKKtO5p9r33Ll4og.3.1587090694317.Hmail.wenhu.wang@vivo.com>
 <64bb1f056abd8bfab2befef5d1e6baec2056077f.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64bb1f056abd8bfab2befef5d1e6baec2056077f.camel@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:58:29PM -0500, Scott Wood wrote:
> On Fri, 2020-04-17 at 10:31 +0800, 王文虎 wrote:
> > > > On Thu, 2020-04-16 at 08:35 -0700, Wang Wenhu wrote:
> > > > > +#define UIO_INFO_VER	"devicetree,pseudo"
> > > > 
> > > > What does this mean?  Changing a number into a non-obvious string (Why
> > > > "pseudo"?  Why does the UIO user care that the config came from the
> > > > device
> > > > tree?) just to avoid setting off Greg's version number autoresponse
> > > > isn't
> > > > really helping anything.
> > > > 
> > > > > +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> > > > > +	{	.compatible = "uio,mpc85xx-cache-sram",	},
> > > 
> > > Form is <vendor>,<device> and "uio" is not a vendor (and never will be).
> > > 
> > 
> > Should have been something like "fsl,mpc85xx-cache-sram-uio", and if it is
> > to be defined with module parameters, this would be user defined.
> > Anyway, <vendor>,<device> should always be used.
> > 
> > > > > +	{},
> > > > > +};
> > > > > +
> > > > > +static struct platform_driver uio_fsl_85xx_cache_sram = {
> > > > > +	.probe = uio_fsl_85xx_cache_sram_probe,
> > > > > +	.remove = uio_fsl_85xx_cache_sram_remove,
> > > > > +	.driver = {
> > > > > +		.name = DRIVER_NAME,
> > > > > +		.owner = THIS_MODULE,
> > > > > +		.of_match_table	= uio_mpc85xx_l2ctlr_of_match,
> > > > > +	},
> > > > > +};
> > > > 
> > > > Greg's comment notwithstanding, I really don't think this belongs in the
> > > > device tree (and if I do get overruled on that point, it at least needs
> > > > a
> > > > binding document).  Let me try to come up with a patch for dynamic
> > > > allocation.
> > > 
> > > Agreed. "UIO" bindings have long been rejected.
> > > 
> > 
> > Sounds it is. And does the modification below fit well?
> > ---
> > -static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> > -       {       .compatible = "uio,mpc85xx-cache-sram", },
> > -       {},
> > +#ifdef CONFIG_OF
> > +static struct of_device_id uio_fsl_85xx_cache_sram_of_match[] = {
> > +       { /* This is filled with module_parm */ },
> > +       { /* Sentinel */ },
> >  };
> > +MODULE_DEVICE_TABLE(of, uio_fsl_85xx_cache_sram_of_match);
> > +module_param_string(of_id, uio_fsl_85xx_cache_sram_of_match[0].compatible,
> > +                           sizeof(uio_fsl_85xx_cache_sram_of_match[0].compa
> > tible), 0);
> > +MODULE_PARM_DESC(of_id, "platform device id to be handled by cache-sram-
> > uio");
> > +#endif
> 
> No.  The point is that you wouldn't be configuring this with the device tree
> at all.

Wait, why not?  Don't force people to use module parameters, that is
crazy.  DT describes the hardware involved, if someone wants to bind to
a specific range of memory, as described by DT, why can't they do so?

I can understand not liking the name "uio" in a dt tree, but there's no
reason that DT can not describe what a driver binds to here.

Remember, module parameters are NEVER the answer, this isn't the 1990's
anymore.

thanks,

greg k-h
