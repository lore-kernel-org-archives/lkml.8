Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C54C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85BC2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FApU1YJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCBSpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:45:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45838 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgCBSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:45:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id f21so245409otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12/rZ6fsx6hBmJEsqbaXJ5G4NKHwEaEIjFun4ithZOM=;
        b=FApU1YJ4AMLXq6gY4yHZy3O3+YQ5rdZ5ZXtB0qHwnZX4Zfv9rcvGBWmEEXeh1cIk+R
         O3RAZT+sZiS6aJFDSqID8K2KjsZ5ee6JeF+wNPQ4Li/7/rjV11J3yf74iOnlP29XF4eg
         Addovy0Cstcl8eyhFKS8xN+HiWCsCkxoFiKLt2k1Ip0hB2nBJv6QY5ZlLPxZQQFKel1S
         tJoEoB7Ta1hjI+LOFRh3repS8VSztYx53SMC81+8CXByV+mlX5P1wqmTk/olWBpb/4VK
         +yK4MXqGHyice3ICXPAlzn21iVarNr7dAanM2VZM2xLLxlTUVg+HqW4oyDDcNcNHe9rO
         IWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12/rZ6fsx6hBmJEsqbaXJ5G4NKHwEaEIjFun4ithZOM=;
        b=EertUQbwP8l/ctKCrjuyeOSN8DiRLgH4GNmX0LwSYVacDcSagbU/vRM6neD3jXIyb8
         3AvpkqF2w/TKXdwBrwDlnWkoSyy75P71Et2tyqXGafE2iEg6vElx3JqMopFNAU80mzFl
         Bzt06hn0vM8BD+xZPZnnGdcrxZmg+q4HOy4SzxENxmFbj5GZGYofuCDgW5zHfuefwyEo
         3C3yXm85DvRJvzpWs69U+tZz3+B00gDMFOpU2cLew9nLPm3z26n99aGOgHO9mk8AJKhU
         k8F3e4l8ekofSuODJCVJMDjc8mcZvCqw+znte5TZdFPuNQTAhuzZk9DxWvY5lQ23AZlz
         N2Og==
X-Gm-Message-State: ANhLgQ2Bf/3BjMyOq7CKXPDKUsAQyCKwsb7hmGTJRX5aoWPH3uVOK/6h
        sBtRwTQ5ANVaeHLAyNW6aF8Cf/Y67ZNm7FxU8pr+w5RJ
X-Google-Smtp-Source: ADFU+vuU2dswAMVUqhHfW4STg+g4kMHqpDxE1Gsd02iItsqjS4OmcfgkKZdArJ5AdrGU2vikXDbnmbWZAPG7/HJQYj8=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr409956oti.207.1583174720075;
 Mon, 02 Mar 2020 10:45:20 -0800 (PST)
MIME-Version: 1.0
References: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158291748226.1609624.8971922874557923784.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87fterrmau.fsf@linux.ibm.com>
In-Reply-To: <87fterrmau.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Mar 2020 10:45:09 -0800
Message-ID: <CAPcyv4iQR=e5AneCshT9xqWfKdG_oHBorahLqnNxYC3pz40D_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] libnvdimm/namespace: Enforce memremap_compat_align()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 4:09 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The pmem driver on PowerPC crashes with the following signature when
> > instantiating misaligned namespaces that map their capacity via
> > memremap_pages().
> >
> >     BUG: Unable to handle kernel data access at 0xc001000406000000
> >     Faulting instruction address: 0xc000000000090790
> >     NIP [c000000000090790] arch_add_memory+0xc0/0x130
> >     LR [c000000000090744] arch_add_memory+0x74/0x130
> >     Call Trace:
> >      arch_add_memory+0x74/0x130 (unreliable)
> >      memremap_pages+0x74c/0xa30
> >      devm_memremap_pages+0x3c/0xa0
> >      pmem_attach_disk+0x188/0x770
> >      nvdimm_bus_probe+0xd8/0x470
> >
> > With the assumption that only memremap_pages() has alignment
> > constraints, enforce memremap_compat_align() for
> > pmem_should_map_pages(), nd_pfn, and nd_dax cases. This includes
> > preventing the creation of namespaces where the base address is
> > misaligned and cases there infoblock padding parameters are invalid.
> >
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Fixes: a3619190d62e ("libnvdimm/pfn: stop padding pmem namespaces to section alignment")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c |   12 ++++++++++++
> >  drivers/nvdimm/pfn_devs.c       |   26 +++++++++++++++++++++++---
> >  2 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> > index 032dc61725ff..68e89855f779 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/nd.h>
> >  #include "nd-core.h"
> >  #include "pmem.h"
> > +#include "pfn.h"
> >  #include "nd.h"
> >
> >  static void namespace_io_release(struct device *dev)
> > @@ -1739,6 +1740,17 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
> >               return ERR_PTR(-ENODEV);
> >       }
>
> May be add a comment here that both dax/fsdax namespace details are
> checked in nd_pfn_validate() so that we look at start_pad and end_trunc
> while validating the namespace?
>
> >
> > +     if (pmem_should_map_pages(dev)) {
> > +             struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
> > +             struct resource *res = &nsio->res;
> > +
> > +             if (!IS_ALIGNED(res->start | (res->end + 1),
> > +                                     memremap_compat_align())) {
> > +                     dev_err(&ndns->dev, "%pr misaligned, unable to map\n", res);
> > +                     return ERR_PTR(-EOPNOTSUPP);
> > +             }
> > +     }
> > +
> >       if (is_namespace_pmem(&ndns->dev)) {
> >               struct nd_namespace_pmem *nspm;
> >
> > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > index 79fe02d6f657..3bdd4b883d05 100644
> > --- a/drivers/nvdimm/pfn_devs.c
> > +++ b/drivers/nvdimm/pfn_devs.c
> > @@ -446,6 +446,7 @@ static bool nd_supported_alignment(unsigned long align)
> >  int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >  {
> >       u64 checksum, offset;
> > +     struct resource *res;
> >       enum nd_pfn_mode mode;
> >       struct nd_namespace_io *nsio;
> >       unsigned long align, start_pad;
> > @@ -578,13 +579,14 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >        * established.
> >        */
> >       nsio = to_nd_namespace_io(&ndns->dev);
> > -     if (offset >= resource_size(&nsio->res)) {
> > +     res = &nsio->res;
> > +     if (offset >= resource_size(res)) {
> >               dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
> >                               dev_name(&ndns->dev));
> >               return -EOPNOTSUPP;
> >       }
> >
> > -     if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
> > +     if ((align && !IS_ALIGNED(res->start + offset + start_pad, align))
> >                       || !IS_ALIGNED(offset, PAGE_SIZE)) {
> >               dev_err(&nd_pfn->dev,
> >                               "bad offset: %#llx dax disabled align: %#lx\n",
> > @@ -592,6 +594,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >               return -EOPNOTSUPP;
> >       }
> >
> > +     if (!IS_ALIGNED(res->start + le32_to_cpu(pfn_sb->start_pad),
> > +                             memremap_compat_align())) {
> > +             dev_err(&nd_pfn->dev, "resource start misaligned\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (!IS_ALIGNED(res->end + 1 - le32_to_cpu(pfn_sb->end_trunc),
> > +                             memremap_compat_align())) {
> > +             dev_err(&nd_pfn->dev, "resource end misaligned\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL(nd_pfn_validate);
> > @@ -750,7 +764,13 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >       start = nsio->res.start;
> >       size = resource_size(&nsio->res);
> >       npfns = PHYS_PFN(size - SZ_8K);
> > -     align = max(nd_pfn->align, SUBSECTION_SIZE);
> > +     align = max(nd_pfn->align, memremap_compat_align());
> > +     if (!IS_ALIGNED(start, memremap_compat_align())) {
> > +             dev_err(&nd_pfn->dev, "%s: start %pa misaligned to %#lx\n",
> > +                             dev_name(&ndns->dev), &start,
> > +                             memremap_compat_align());
> > +             return -EINVAL;
> > +     }
>
> This validates start in case of a new namespace creation where the user
> updated nd_region->align value? A comment there would help when looking
> at the code later?

Yeah, sounds good will respin with those updates.
