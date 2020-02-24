Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B10C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D144120675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUV/rPwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXBmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:42:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38430 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgBXBmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:42:03 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so8599909iog.5;
        Sun, 23 Feb 2020 17:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhVgmjRGEwVCyeThkvJVHxfg3EG7YiNfvIKBv+nVMeI=;
        b=LUV/rPwj6sFkk08tsYihfkSiIOu8DvPGR9ALzpZ9KEjJ6cm9TWhEVZs9gZjyFmGljq
         hvNoZ9u8VINM0NVs03UyvMhfM790FRf3XJ9AZydNYvoRqSiwaLNqSenynHYtCoED8LCw
         179biq4AALGeC06TKxnhDnmaLqwcFsmVT6PgPICaHH6IyXnfkpOLiO8VIMGa4vT3so6s
         sG9GWsbxFay4pd/LRS9RapfOb0zBs3zUbaQWcf3L9pLU+tg5xg50TvzBrsMJXzpRb42X
         xOzQlLVWgHVWo6GAxPE+ZZ7vcy20LfDsT+MM6IXZi4WpSxVePSAyytGXAuuWemRY/A91
         ArpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhVgmjRGEwVCyeThkvJVHxfg3EG7YiNfvIKBv+nVMeI=;
        b=qCY1ebVaaV3XmUyxitSk0rYZfvCCv961I5YY5ta/HToS/zp45Pus+PS7noaldhiP1I
         EAFYDYwoyBDerLS5xugIkxVm0lGLH7k+LyAx4iYc9ZaaQlaM+9kumtl338XcfQZ86GzZ
         Ml9Dgrk8E9x8oRP0Qc6JisQHDv/YY4Uk6ssEkkcQBFA/Gzsi1ZoRWiJiFiiVcpAVqLsn
         ccBFlq3r7TnlmDQCgHUMOdW9y7EZHcnFVX5o06YD5bHNhpRwsTSc7xdFBd168Vgdk59k
         q4rZZoP0n3vsfP7gh2Q1nNCn3sneWINpevW1MDAz5ILIefWA1M5Dsn0Hu7+vO753LOQR
         RC5w==
X-Gm-Message-State: APjAAAUkgbgWnnzZqlcCqMapc28R/HJpKGDpkC2hQQ2d8leFwPzoiQZz
        N7643DZV2RykL7DfusYdkVlxdUBB2tCsIbTi8CqEti2b+V0=
X-Google-Smtp-Source: APXvYqzy3E4LciHHLkjXPWnbETKxqDYnUpxeTOYY1bhH38hgYV9T9015a+g5H5J9m6THVyk1bJHSl1mQeVBibIecwQA=
X-Received: by 2002:a5d:87ca:: with SMTP id q10mr49147056ios.192.1582508522424;
 Sun, 23 Feb 2020 17:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com> <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 24 Feb 2020 12:41:51 +1100
Message-ID: <CAOSf1CH-WMA5DDt9LKcPPZwb-ya-y=1WCc8mrUEEDMjg0WeX5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Alistair Delva <adelva@google.com>,
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

On Mon, Feb 24, 2020 at 1:56 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Sat, Feb 22, 2020 at 10:30:09AM -0800, Alistair Delva wrote:
> > From: Kenny Root <kroot@google.com>
> >
> > Add support for parsing the 'memory-region' DT property in addition to
> > the 'reg' DT property. This enables use cases where the pmem region is
> > not in I/O address space or dedicated memory (e.g. a bootloader
> > carveout).
> >
> > Signed-off-by: Kenny Root <kroot@google.com>
> > Signed-off-by: Alistair Delva <adelva@google.com>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-nvdimm@lists.01.org
> > Cc: kernel-team@android.com
> > ---
> >  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
> >  1 file changed, 50 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> > index 8224d1431ea9..a68e44fb0041 100644
> > --- a/drivers/nvdimm/of_pmem.c
> > +++ b/drivers/nvdimm/of_pmem.c
> > @@ -14,13 +14,47 @@ struct of_pmem_private {
> >       struct nvdimm_bus *bus;
> >  };
> >
> > +static void of_pmem_register_region(struct platform_device *pdev,
> > +                                 struct nvdimm_bus *bus,
> > +                                 struct device_node *np,
> > +                                 struct resource *res, bool is_volatile)
>
> FWIW it would be easier to review if this was splut into a patch which created
> the helper of_pmem_register_region() without the new logic.  Then added the new
> logic here.

Yeah, that wouldn't hurt.

*snip*

> > +     i = 0;
> > +     while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
> > +             ret = of_address_to_resource(mr_np, 0, &res);
> > +             if (ret)
> > +                     dev_warn(
> > +                             &pdev->dev,
> > +                             "Unable to acquire memory-region from %pOF: %d\n",
> > +                             mr_np, ret);
> >               else
> > -                     dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> > -                                     ndr_desc.res, np);
> > +                     of_pmem_register_region(pdev, bus, np, &res,
> > +                                             is_volatile);
> > +             of_node_put(mr_np);
>
> Why of_node_put()?

"memory-region" is an array of pointers to nodes in /reserved-memory/
which describe the actual memory region. of_parse_phandle() elevates
the refcount of the returned node and we need to balance that.

>
> Ira
> >       }
> >
> >       return 0;
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
