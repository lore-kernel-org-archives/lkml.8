Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD2AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6A2214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDQWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:52:21 -0400
Received: from baldur.buserror.net ([165.227.176.147]:41802 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgDQWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:52:20 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jPZoE-0007S8-1q; Fri, 17 Apr 2020 17:50:06 -0500
Message-ID: <eb73fb40c2d102f24cf4d9a4ba26ffeea278b715.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     =?UTF-8?Q?=E7=8E=8B=E6=96=87=E8=99=8E?= <wenhu.wang@vivo.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        kernel@vivo.com
Date:   Fri, 17 Apr 2020 17:50:04 -0500
In-Reply-To: <APIAAAABCKquIIhDNOkcHqp9.3.1587132987353.Hmail.wenhu.wang@vivo.com>
References: <APIAAAABCKquIIhDNOkcHqp9.3.1587132987353.Hmail.wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, gregkh@linuxfoundation.org, robh@kernel.org, linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v4,4/4] drivers: uio: new driver for fsl_85xx_cache_sram
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 22:16 +0800, 王文虎 wrote:
> > On Fri, 2020-04-17 at 09:42 +0200, Greg KH wrote:>> On Thu, Apr 16, 2020
> > at 11:58:29PM -0500, Scott Wood wrote:
> > > > On Fri, 2020-04-17 at 10:31 +0800, 王文虎 wrote:
> > > > > Sounds it is. And does the modification below fit well?
> > > > > ---
> > > > > -static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> > > > > -       {       .compatible = "uio,mpc85xx-cache-sram", },
> > > > > -       {},
> > > > > +#ifdef CONFIG_OF
> > > > > +static struct of_device_id uio_fsl_85xx_cache_sram_of_match[] = {
> > > > > +       { /* This is filled with module_parm */ },
> > > > > +       { /* Sentinel */ },
> > > > >  };
> > > > > +MODULE_DEVICE_TABLE(of, uio_fsl_85xx_cache_sram_of_match);
> > > > > +module_param_string(of_id,
> > > > > uio_fsl_85xx_cache_sram_of_match[0].compatible,
> > > > > +                           sizeof(uio_fsl_85xx_cache_sram_of_match[
> > > > > 0].c
> > > > > ompa
> > > > > tible), 0);
> > > > > +MODULE_PARM_DESC(of_id, "platform device id to be handled by cache-
> > > > > sram-
> > > > > uio");
> > > > > +#endif
> > > > 
> > > > No.  The point is that you wouldn't be configuring this with the
> > > > device
> > > > tree
> > > > at all.
> > > 
> > > Wait, why not?  Don't force people to use module parameters, that is
> > > crazy.  DT describes the hardware involved, if someone wants to bind to
> > > a specific range of memory, as described by DT, why can't they do so?
> > 
> > Yes, DT describes the hardware, and as I've said a couple times already,
> > this
> > isn't hardware description.
> > 
> > I'm not forcing people to use module parameters.  That was a least-effort
> > suggestion to avoid abusing the DT.  I later said I'd try to come up with
> > a
> > patch that allocates regions dynamically (and most likely doesn't use UIO
> > at
> > all).
> > 
> > > I can understand not liking the name "uio" in a dt tree, but there's no
> > > reason that DT can not describe what a driver binds to here.
> > 
> > The DT already describes this hardware, and there is already code that
> > binds
> > to it.  This patch is trying to add a second node for it with
> > configuration.
> > 
> 
> Hi, Scott, Greg,
> Seems like no balance here. How about I implement a driver of uio including
> the l2ctrl and cache_sram related implementations?
> And this way, the driver would be a hardware level driver and targeted for
> uio.

No, duplicating the code makes no sense whatsoever.  Please just wait a bit
and I'll send a patch to have the existing driver expose a dynamic allocation
interface to userspace.

-Scott


