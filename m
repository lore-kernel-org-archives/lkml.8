Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3BC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72A20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQTfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:35:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39881 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:35:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id r2so7558454otn.6;
        Tue, 17 Mar 2020 12:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OwDkuCyaDPj4qBgiFSCBZ9Jnd8fSLCfC5Lfyemz1Lw=;
        b=PFiXdktFE0mUgj95i+1zrko+S1kur3PPvz0kBc+soci2QKY3K/OeouCO/92YoAMVtJ
         MbDmgmFeKE7kYwbXc9cR2ieU19GJNvCn3zLUk8NN7/fOYQbCnbvMSPamLMkGeR3VjSrQ
         4rZlh8wCVXU8sIMXh3fIaCv7skjc6y0XwGb2zgdQlruWmbbbmxVx0qLdtUaEKa0VqBh+
         cWWLHyDLZqStKZ4R/fTcx44kNpMEdi8cQKjaZi99DTrvo4agdolhSPlKsM1KTB6Ff5Ev
         iLb0PYxHPVb7feSbj+huBbK4oC9RjOPETfd7n/EuKJn0MT69AaIHwGv9hLm9zsXFdoIj
         zqaA==
X-Gm-Message-State: ANhLgQ2SykB0Aquzx+wBpBed8rfMx3hq01hv7f2NeMEUeUX2BSY2ooxE
        oVMWfE9Yqr16+MSYRfD3Xcfj+GYRxuBlSpNqLDY=
X-Google-Smtp-Source: ADFU+vveQh0hjmPLfqNeMrif7aOhs4Y/DBS2xMfAkRSxNp6usTED9mrvCwcYGr0Znv4OgUXxXOKdLSR4tAKH2lY4oVA=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr792014ota.250.1584473728102;
 Tue, 17 Mar 2020 12:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200315140525.21780-1-zhengdejin5@gmail.com> <20200315140525.21780-2-zhengdejin5@gmail.com>
 <20200317192051.GA1520272@kroah.com>
In-Reply-To: <20200317192051.GA1520272@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Mar 2020 20:35:16 +0100
Message-ID: <CAMuHMdVK0Gpw6A=CfF+5nw4hHz9UCtSoXwF9_UThAK4E+mQBWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drivers: provide devm_platform_get_and_ioremap_resource()
To:     Greg KH <gregkh@linuxfoundation.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Mar 17, 2020 at 8:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Mar 15, 2020 at 10:05:21PM +0800, Dejin Zheng wrote:
> > Since commit "drivers: provide devm_platform_ioremap_resource()",
> > it was wrap platform_get_resource() and devm_ioremap_resource() as
> > single helper devm_platform_ioremap_resource(). but now, many drivers
> > still used platform_get_resource() and devm_ioremap_resource()
> > together in the kernel tree. The reason can not be replaced is they
> > still need use the resource variables obtained by platform_get_resource().
> > so provide this helper.
> >
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> > v2 -> v3:
> >       - rename the function to
> >         devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
> >       - make the last parameter res as optional by Geert's suggestion.
> >
> > v1 -> v2:
> >       - No change.
> >
> >  drivers/base/platform.c         | 22 ++++++++++++++++++++++
> >  include/linux/platform_device.h |  3 +++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 7fa654f1288b..9f6a78f79235 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
> >  EXPORT_SYMBOL_GPL(platform_get_resource);
> >
> >  #ifdef CONFIG_HAS_IOMEM
> > +/**
> > + * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
> > + *                                       platform device and get resource
> > + *
> > + * @pdev: platform device to use both for memory resource lookup as well as
> > + *        resource management
> > + * @index: resource index
> > + * @res: get the resource
> > + */
> > +void __iomem *
> > +devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
> > +                             unsigned int index, struct resource **res)
> > +{
> > +     struct resource *r;
> > +
> > +     r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> > +     if (res)
> > +             *res = r;
>
> What happens if that call fails?  Shouldn't that be checked?

Then devm_ioremap_resource() will print an error message, and return
an error.
It's designed to be pipelined that way, so you have to check for an error
only once.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
