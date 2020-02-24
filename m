Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC76C35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE78D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIu4P22E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBXBab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:30:31 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40247 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXBab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:30:31 -0500
Received: by mail-il1-f194.google.com with SMTP id i7so6360671ilr.7;
        Sun, 23 Feb 2020 17:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpjCEzvJa3mYN+s9rlLxDJnrunIgm+5HNYu1VzHukUU=;
        b=FIu4P22El7eNwYCcFGhhFF4W0gT/3uXEPg/SjIKun9Y9IjQuif1w3RKpXODNfU5KHq
         j+FXRJROFzzDi+vFVNNUSRy3edizBx/KRJPpuWAEWHo+EKuXab3EA1TQrgI8bgqUeX3a
         GWXEu4eK7L050LCSwstEXdH41YgTDxSOZkskMjftzpUe/Yf9KoKqM6rcdaad++QBhH4g
         UUYisqv+pjAUIGCL6bEehVpm13sniJMkblimcNKwCx5RJ1iSvgmfpF0NhflwifX0m5A3
         2QD+PxyNCw15FI0Fy+irGrr9w0LJqHSdRjlpiVPk/lq12vP/5cKgO/AGnNP7poGeIAFj
         bCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpjCEzvJa3mYN+s9rlLxDJnrunIgm+5HNYu1VzHukUU=;
        b=fKzOIO3c83KzX01Hu/Al9zkKBxIYrqQUNqlbSsaiwHm/O/O1xe2085gXTmIrNHKyer
         xpCmrliofVBH6CGiRyfilE24pPqaWIAKXf44wFXd6ZfRhWkuxgqC8MHxZ7z6/gK7vvWk
         FuKfVIVhDv2Av5cmr6R6cVSLWmMOrg6RyoUfh/dfYjj1BTe6WjjkYSSsWwR+X/9gf74X
         JMnyIilx/6s5DYe75u9ex+ci2hhJP/GmecmF3qRJfHojwqx+3aJmV4Tw8uUHgT1egtdS
         VqwvflE7eBSDmkL8wQxNLMyBs0g5e4Ik3f5Fy6NGslVDymQnXQBWgQkmv18Rb5oPVRKa
         QT/w==
X-Gm-Message-State: APjAAAWD898oKO33xHOKAPcSX4kU2e9QFK2pJztubQgou7N9mkVJ38Bx
        5UgVOTlgEoH80tHtPbg3PIAILHhCC+fsFpcM1mA=
X-Google-Smtp-Source: APXvYqx986xHbMXQkYKGgmbvLTm2zVMEwdNkZBqR0v7GJ9D4/63fbl5fSNJ1vI599Huyw4OTdryOUO3/YcN07YtuvZU=
X-Received: by 2002:a92:914a:: with SMTP id t71mr56519689ild.293.1582507830358;
 Sun, 23 Feb 2020 17:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com>
In-Reply-To: <20200222183010.197844-1-adelva@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 24 Feb 2020 12:30:19 +1100
Message-ID: <CAOSf1CHVWV-ku9ajCpdw4cONdpSO-8vm=oMLvCo+F1xF-xCL6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
To:     Alistair Delva <adelva@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kenny Root <kroot@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Device Tree <devicetree@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 5:30 AM Alistair Delva <adelva@google.com> wrote:
>
> From: Kenny Root <kroot@google.com>
>
> Add support for parsing the 'memory-region' DT property in addition to
> the 'reg' DT property. This enables use cases where the pmem region is
> not in I/O address space or dedicated memory (e.g. a bootloader
> carveout).
>
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
>  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..a68e44fb0041 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -14,13 +14,47 @@ struct of_pmem_private {
>         struct nvdimm_bus *bus;
>  };
>
> +static void of_pmem_register_region(struct platform_device *pdev,
> +                                   struct nvdimm_bus *bus,
> +                                   struct device_node *np,
> +                                   struct resource *res, bool is_volatile)
> +{
> +       struct nd_region_desc ndr_desc;
> +       struct nd_region *region;
> +
> +       /*
> +        * NB: libnvdimm copies the data from ndr_desc into it's own
> +        * structures so passing a stack pointer is fine.
> +        */
> +       memset(&ndr_desc, 0, sizeof(ndr_desc));
> +       ndr_desc.numa_node = dev_to_node(&pdev->dev);
> +       ndr_desc.target_node = ndr_desc.numa_node;
> +       ndr_desc.res = res;
> +       ndr_desc.of_node = np;
> +       set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +
> +       if (is_volatile)
> +               region = nvdimm_volatile_region_create(bus, &ndr_desc);
> +       else
> +               region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +
> +       if (!region)
> +               dev_warn(&pdev->dev,
> +                        "Unable to register region %pR from %pOF\n",
> +                        ndr_desc.res, np);
> +       else
> +               dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> +                       ndr_desc.res, np);
> +}
> +
>  static int of_pmem_region_probe(struct platform_device *pdev)
>  {
>         struct of_pmem_private *priv;
> -       struct device_node *np;
> +       struct device_node *mrp, *np;
>         struct nvdimm_bus *bus;
> +       struct resource res;
>         bool is_volatile;
> -       int i;
> +       int i, ret;
>
>         np = dev_of_node(&pdev->dev);
>         if (!np)
> @@ -46,31 +80,22 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>                         is_volatile ? "volatile" : "non-volatile",  np);
>
>         for (i = 0; i < pdev->num_resources; i++) {
> -               struct nd_region_desc ndr_desc;
> -               struct nd_region *region;
> -
> -               /*
> -                * NB: libnvdimm copies the data from ndr_desc into it's own
> -                * structures so passing a stack pointer is fine.
> -                */
> -               memset(&ndr_desc, 0, sizeof(ndr_desc));
> -               ndr_desc.numa_node = dev_to_node(&pdev->dev);
> -               ndr_desc.target_node = ndr_desc.numa_node;
> -               ndr_desc.res = &pdev->resource[i];
> -               ndr_desc.of_node = np;
> -               set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> -
> -               if (is_volatile)
> -                       region = nvdimm_volatile_region_create(bus, &ndr_desc);
> -               else
> -                       region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +               of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
> +                                       is_volatile);
> +       }
>
> -               if (!region)
> -                       dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -                                       ndr_desc.res, np);
> +       i = 0;
> +       while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {

Doesn't compile since the the iteration variable is declared above as
"mrp" rather than "mr_np". The patch looks fine otherwise and seems to
work ok, so:

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> +               ret = of_address_to_resource(mr_np, 0, &res);
> +               if (ret)
> +                       dev_warn(
> +                               &pdev->dev,
> +                               "Unable to acquire memory-region from %pOF: %d\n",
> +                               mr_np, ret);
>                 else
> -                       dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -                                       ndr_desc.res, np);
> +                       of_pmem_register_region(pdev, bus, np, &res,
> +                                               is_volatile)

Now days I think it's cleaner to use braces around multi-line blocks
even if it's a single statement, up to you though.

> +               of_node_put(mr_np);
>         }
>
>         return 0;
> --
> 2.25.0.265.gbab2e86ba0-goog
>
