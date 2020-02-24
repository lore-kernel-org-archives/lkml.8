Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7435C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BF6206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odvADANg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXBnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:43:43 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40116 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBXBnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:43:42 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so2096096vkh.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 17:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tDUe/596kLQOTI3w8zi8SEzFY93PKMz1mi66rU0+Hs=;
        b=odvADANgVGTTfCRvnRE2ojhtUfO+STbMJFvaug7W5NcEtwaHV2bzfquurK62hxfoxz
         J1WGUscx/FqcJyd2LKg0uW/ayUJhMz9gW4laps101NC0y7kosjR2vtcLKWV5HCwLaVXZ
         55q8ZXghnSNGEp1J+fcMyICppzh9rikjzkwxhEZjC9Q33G6d4jZafMi9JMz3Tpocwicf
         ZKssWuh3fB05xobe3VJud4FR6mqwnA8UcC5XiVkFAT8aT3bmApl0EtWQGrD/KIvtlBGx
         xQpPlASjuOcmfu9RllWf90OuQBMIYy75dsmFnMc9rbZkj0Ote8ki0v0nu1zQ3Zilf1wF
         pipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tDUe/596kLQOTI3w8zi8SEzFY93PKMz1mi66rU0+Hs=;
        b=UcOCLGW3cSwg+30hK/cfWyS65NDr6QRFtxPEk94K8hVdDMKeEjRRYD/NM8q+ynu4jQ
         mQouBUICMknu4v/vVo2ca4fR9FnyfyQokSGBOtdGp+s7jQaNm0Vz0F5oUSNrouNVmA2N
         rLjYN0A9MY5WaIKhi3waLNELhWDZrESQ/dYFFmFigd0JeaT1pNFlDtkWcaMYYa6QJywA
         zWbx8wRiGsiTgkOLsZcQAUZUzhP/CJPNSRdXmgu9gLdhppUaO32h9h6SWCf9SvOmMbcl
         Y/vKJYp2ZrYK8CqO+f+ao2OEej8dhmkqh8pefm7LVo3c6WN/qsUtlaeHvNb6rRiSaK+5
         VyWw==
X-Gm-Message-State: APjAAAWmAnjP4m1HKpFRqLRlq2HN6gbqBIvVxYtFE5z9y8i25Eo+k0nf
        DYNFsU7S+Zhj0MHCN1tWSIVQ2FeE//3ocMeBoRcw6w==
X-Google-Smtp-Source: APXvYqypuLtLmgW4rAaRuxj1Wpdl9Fq5n92rcRfcLstwQaDQC8z/1gbliCGTeVFx6ViQYEvWrjlLa+VXyYd2Ab1orhM=
X-Received: by 2002:a1f:90d4:: with SMTP id s203mr22035473vkd.65.1582508620766;
 Sun, 23 Feb 2020 17:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com> <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
 <CAOSf1CH-WMA5DDt9LKcPPZwb-ya-y=1WCc8mrUEEDMjg0WeX5g@mail.gmail.com>
In-Reply-To: <CAOSf1CH-WMA5DDt9LKcPPZwb-ya-y=1WCc8mrUEEDMjg0WeX5g@mail.gmail.com>
From:   Alistair Delva <adelva@google.com>
Date:   Sun, 23 Feb 2020 17:43:29 -0800
Message-ID: <CANDihLF8bjOVAypQF-L-h82wcW5OBj4MQZRNRthAoaXPM51gpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kenny Root <kroot@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Device Tree <devicetree@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 5:42 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 1:56 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Sat, Feb 22, 2020 at 10:30:09AM -0800, Alistair Delva wrote:
> > > From: Kenny Root <kroot@google.com>
> > >
> > > Add support for parsing the 'memory-region' DT property in addition to
> > > the 'reg' DT property. This enables use cases where the pmem region is
> > > not in I/O address space or dedicated memory (e.g. a bootloader
> > > carveout).
> > >
> > > Signed-off-by: Kenny Root <kroot@google.com>
> > > Signed-off-by: Alistair Delva <adelva@google.com>
> > > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-nvdimm@lists.01.org
> > > Cc: kernel-team@android.com
> > > ---
> > >  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
> > >  1 file changed, 50 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> > > index 8224d1431ea9..a68e44fb0041 100644
> > > --- a/drivers/nvdimm/of_pmem.c
> > > +++ b/drivers/nvdimm/of_pmem.c
> > > @@ -14,13 +14,47 @@ struct of_pmem_private {
> > >       struct nvdimm_bus *bus;
> > >  };
> > >
> > > +static void of_pmem_register_region(struct platform_device *pdev,
> > > +                                 struct nvdimm_bus *bus,
> > > +                                 struct device_node *np,
> > > +                                 struct resource *res, bool is_volatile)
> >
> > FWIW it would be easier to review if this was splut into a patch which created
> > the helper of_pmem_register_region() without the new logic.  Then added the new
> > logic here.
>
> Yeah, that wouldn't hurt.
>
> *snip*
>
> > > +     i = 0;
> > > +     while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
> > > +             ret = of_address_to_resource(mr_np, 0, &res);
> > > +             if (ret)
> > > +                     dev_warn(
> > > +                             &pdev->dev,
> > > +                             "Unable to acquire memory-region from %pOF: %d\n",
> > > +                             mr_np, ret);
> > >               else
> > > -                     dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> > > -                                     ndr_desc.res, np);
> > > +                     of_pmem_register_region(pdev, bus, np, &res,
> > > +                                             is_volatile);
> > > +             of_node_put(mr_np);
> >
> > Why of_node_put()?
>
> "memory-region" is an array of pointers to nodes in /reserved-memory/
> which describe the actual memory region. of_parse_phandle() elevates
> the refcount of the returned node and we need to balance that.

That was my understanding too.

Thanks both for the review and sorry for the last minute untested
variable rename! I'll fix both and split the refactoring out in v2.

> >
> > Ira
> > >       }
> > >
> > >       return 0;
> > > --
> > > 2.25.0.265.gbab2e86ba0-goog
> > >
