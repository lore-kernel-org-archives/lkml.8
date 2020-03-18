Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6870AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C92020770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584526215;
	bh=NGAukJ+3Nmmxnzl16xW5wI96d5RF3onz8IR/ReVAjHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jx/DXwUk0bqU6xNIMAMFK/iyoBJrQvYgtEDaMvIH0eQeTl3mCeh7bRQ1QCVquCpUp
	 cIsAxE1VnLBd/E3dqb/MkCskYpnr2k5aVIu9pBfCqVefAwUAwcMVX4AjWwnAgPY3nv
	 GGzZUwRAXJ+BVv2Rzs5IH1CLhaurXbNig11uvG6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCRKKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCRKKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:10:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF2120768;
        Wed, 18 Mar 2020 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584526212;
        bh=NGAukJ+3Nmmxnzl16xW5wI96d5RF3onz8IR/ReVAjHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcSuvV7Md+YK8Gf6tvrlo7AcBNA2D086+W51Am5qGEnEwuSd92PdqPgVsQrezzgGq
         lOK8xGEaZuuLtBalvRfUbfB/H0DqXC+3iv/I+2sPzxlYMPQoqpvjvcDlLKsm7GP7/A
         1/PBA/H50A5hIE5OS9dJOceeunzguK1XBoWlWJKY=
Date:   Wed, 18 Mar 2020 11:10:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] drivers: provide
 devm_platform_get_and_ioremap_resource()
Message-ID: <20200318101010.GA2061266@kroah.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
 <20200315140525.21780-2-zhengdejin5@gmail.com>
 <20200317192051.GA1520272@kroah.com>
 <CAMuHMdVK0Gpw6A=CfF+5nw4hHz9UCtSoXwF9_UThAK4E+mQBWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVK0Gpw6A=CfF+5nw4hHz9UCtSoXwF9_UThAK4E+mQBWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:35:16PM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Tue, Mar 17, 2020 at 8:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Sun, Mar 15, 2020 at 10:05:21PM +0800, Dejin Zheng wrote:
> > > Since commit "drivers: provide devm_platform_ioremap_resource()",
> > > it was wrap platform_get_resource() and devm_ioremap_resource() as
> > > single helper devm_platform_ioremap_resource(). but now, many drivers
> > > still used platform_get_resource() and devm_ioremap_resource()
> > > together in the kernel tree. The reason can not be replaced is they
> > > still need use the resource variables obtained by platform_get_resource().
> > > so provide this helper.
> > >
> > > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > > ---
> > > v2 -> v3:
> > >       - rename the function to
> > >         devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
> > >       - make the last parameter res as optional by Geert's suggestion.
> > >
> > > v1 -> v2:
> > >       - No change.
> > >
> > >  drivers/base/platform.c         | 22 ++++++++++++++++++++++
> > >  include/linux/platform_device.h |  3 +++
> > >  2 files changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 7fa654f1288b..9f6a78f79235 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
> > >  EXPORT_SYMBOL_GPL(platform_get_resource);
> > >
> > >  #ifdef CONFIG_HAS_IOMEM
> > > +/**
> > > + * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
> > > + *                                       platform device and get resource
> > > + *
> > > + * @pdev: platform device to use both for memory resource lookup as well as
> > > + *        resource management
> > > + * @index: resource index
> > > + * @res: get the resource
> > > + */
> > > +void __iomem *
> > > +devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
> > > +                             unsigned int index, struct resource **res)
> > > +{
> > > +     struct resource *r;
> > > +
> > > +     r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> > > +     if (res)
> > > +             *res = r;
> >
> > What happens if that call fails?  Shouldn't that be checked?
> 
> Then devm_ioremap_resource() will print an error message, and return
> an error.
> It's designed to be pipelined that way, so you have to check for an error
> only once.

Ok, thanks.  Can I get an ack/reviewed-by for this series then?

thanks,

greg k-h
