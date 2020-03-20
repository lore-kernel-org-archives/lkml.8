Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1AC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF92072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl4J89/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCTOGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:06:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40047 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgCTOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:06:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so3272958pfl.7;
        Fri, 20 Mar 2020 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ihYQan0P4nWkVNyVJPOhzYTUV259o58ZK/2SPGi9As=;
        b=Rl4J89/p1LOJdj4P3wPRoi6GNprlWR4beZ4xSymUUxHi5DRLqx7Oig6MXmrDJbdKCv
         v4szf5lQHVGeEU8PRLjQi3GGG2J9wkok+MStHyQD4wPi2hCqPDRhWV0JcGD3/vkAsEIP
         c9rH5uihA1gUZHHuEGQ6JjZT5M/Iwl7WeW+bxj0rD9p1h3Stpj2HB98J4GIfav1qYk2R
         1gSmkCDJJsOZZl7bON32Z/jDjY/P2/fESCjFYl8DS7yXo2+MmYwXG5c1aX3gjJ8Al6Uw
         /hx67QHwEyKQLwwkIJvAYFyCBJWms29iGSheGxwUy0SbPuJ51Wpu8w3NtMUs8nn6ZCTc
         nlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ihYQan0P4nWkVNyVJPOhzYTUV259o58ZK/2SPGi9As=;
        b=uYMiZQMuI/olAosIGwg43nU/tW23O8pVQOxjIvl/jNFQXq3fj0A5/gJvXwZ9zvQqIT
         72XtWwgihfaqHfMhYE850uimamfx26qzn+93LVwv8cEABT1s+s/4SK8hzYCvrdOTdNBt
         H30+v2W9wWjxbUo99Qa8s2cUvxRkQla3J+k2fcfjnGJRnhSLPcg0IUAB72PR9lV91wdk
         R7LiSd7tp+NpeBy059vaLc957vP7+6CelmMRNUOjwudt4YQmxRsfHU//PM2df2ze6ltr
         LPXiHXqKPOcNlR8OVldwlX8QSNxmOvAHrs4RO6YAIOx21VMs8tBKlcrnrfTQNgKiFkdT
         ySwg==
X-Gm-Message-State: ANhLgQ1QUcwREIez0znNVqUMPR4tFAjvf8jEOKJWWHx2ToOJ0PJX7IaS
        8xku50iDllkPd/2iPjnrV8E=
X-Google-Smtp-Source: ADFU+vugQP+2zgDQI1MUAUObEaVq5eBs5Q56th+PsuIFJ4sGn825r3RzJNcqTC8XoLWUcZd+zDv8VA==
X-Received: by 2002:a63:6841:: with SMTP id d62mr8515773pgc.86.1584713191662;
        Fri, 20 Mar 2020 07:06:31 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id p9sm5316431pgs.50.2020.03.20.07.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Mar 2020 07:06:31 -0700 (PDT)
Date:   Fri, 20 Mar 2020 22:06:28 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20200320140628.GA9529@nuc8i5>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
 <20200315140525.21780-2-zhengdejin5@gmail.com>
 <20200317192051.GA1520272@kroah.com>
 <CAMuHMdVK0Gpw6A=CfF+5nw4hHz9UCtSoXwF9_UThAK4E+mQBWg@mail.gmail.com>
 <20200318101010.GA2061266@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318101010.GA2061266@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:10:10AM +0100, Greg KH wrote:
> On Tue, Mar 17, 2020 at 08:35:16PM +0100, Geert Uytterhoeven wrote:
> > Hi Greg,
> > 
> > On Tue, Mar 17, 2020 at 8:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Sun, Mar 15, 2020 at 10:05:21PM +0800, Dejin Zheng wrote:
> > > > Since commit "drivers: provide devm_platform_ioremap_resource()",
> > > > it was wrap platform_get_resource() and devm_ioremap_resource() as
> > > > single helper devm_platform_ioremap_resource(). but now, many drivers
> > > > still used platform_get_resource() and devm_ioremap_resource()
> > > > together in the kernel tree. The reason can not be replaced is they
> > > > still need use the resource variables obtained by platform_get_resource().
> > > > so provide this helper.
> > > >
> > > > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > > > ---
> > > > v2 -> v3:
> > > >       - rename the function to
> > > >         devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
> > > >       - make the last parameter res as optional by Geert's suggestion.
> > > >
> > > > v1 -> v2:
> > > >       - No change.
> > > >
> > > >  drivers/base/platform.c         | 22 ++++++++++++++++++++++
> > > >  include/linux/platform_device.h |  3 +++
> > > >  2 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > > index 7fa654f1288b..9f6a78f79235 100644
> > > > --- a/drivers/base/platform.c
> > > > +++ b/drivers/base/platform.c
> > > > @@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
> > > >  EXPORT_SYMBOL_GPL(platform_get_resource);
> > > >
> > > >  #ifdef CONFIG_HAS_IOMEM
> > > > +/**
> > > > + * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
> > > > + *                                       platform device and get resource
> > > > + *
> > > > + * @pdev: platform device to use both for memory resource lookup as well as
> > > > + *        resource management
> > > > + * @index: resource index
> > > > + * @res: get the resource
> > > > + */
> > > > +void __iomem *
> > > > +devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
> > > > +                             unsigned int index, struct resource **res)
> > > > +{
> > > > +     struct resource *r;
> > > > +
> > > > +     r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> > > > +     if (res)
> > > > +             *res = r;
> > >
> > > What happens if that call fails?  Shouldn't that be checked?
> > 
> > Then devm_ioremap_resource() will print an error message, and return
> > an error.
> > It's designed to be pipelined that way, so you have to check for an error
> > only once.
> 
> Ok, thanks.  Can I get an ack/reviewed-by for this series then?
> 
> thanks,
> 
> greg k-h

Hi Geert:

Could you help me review these patches if you have free time? Your comments and
suggestions will be of great help to me. It is important to me and thanks
again for your help.

Hi Greg, Mathias and Minas:

Thank you very much for taking your time to help me review my code.

BR,
Dejin

