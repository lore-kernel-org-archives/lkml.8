Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0827C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5911E21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599635029;
	bh=34vRsip57GiwShaXzjGDvwqa+vl8LjUVvbQiuVdQk7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mxFmMx0Ya/SsauwBPLbQPxSa09mGEWq0MkLK5Fv/YrhH629ZOjH1W6eCI/8mr+2Av
	 3dZTxq+2eDWzLKZ2YNL8CyLuNu8LfquLqPTK1cAXgZE9T72w59/hi+qVMWeo7veZh0
	 ppGLAD5+e0aPK5uxbjLQQ/+vhZXK63F0hJFIP0Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIIHDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgIIHCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:02:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0943421532;
        Wed,  9 Sep 2020 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599634953;
        bh=34vRsip57GiwShaXzjGDvwqa+vl8LjUVvbQiuVdQk7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0oX4xBI4Jk58xie+Mm8xJBXFSmFRE5L4salfY6srAF3U9QzVhiMtGY3kcKLxo4VF
         zX5z7Qw54p/cwyorayAzgTS8AnuwF+XHcebZ3GWK2ocY1p5c3wb6cKQja6OiiABVdy
         lpTybajKPpJ/RUNLEZ5eCZyEDKYu9RfYv/q9paF4=
Date:   Wed, 9 Sep 2020 09:02:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
Message-ID: <20200909070244.GC311356@kroah.com>
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
 <20200826155507.GV1891694@smile.fi.intel.com>
 <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
 <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:29:25AM +0200, Krzysztof Kozlowski wrote:
> On Wed, 26 Aug 2020 at 18:18, Joe Perches <joe@perches.com> wrote:
> >
> > On Wed, 2020-08-26 at 18:55 +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> > > > On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> > >
> > > ...
> > >
> > > > > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > > > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> 
> +Cc Stephen and Greg,
> 
> Hi Andy,
> 
> Did this patch ended up in next somehow? I am surprised because now I
> got warnings for perfectly fine code:
> https://lore.kernel.org/linux-next/20200909155654.76fe3bd6@canb.auug.org.au/T/#u
> 
> This creates simply false warnings instead of hints for "optimization".

Yes, it got merged into m y driver core tree.

I'll fix up the tty build warning, should be easy enough, the patch is
below.

thanks,

greg k-h
------------------

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fd95860cd661..cd1880715bad 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -151,7 +151,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "unable to register 8250 port\n");
+		ret = dev_err_probe(&pdev->dev, ret, "unable to register 8250 port\n");
 		goto dis_clk;
 	}
 	data->line = ret;
