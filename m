Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90965C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60A20772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eHcC+28q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCYRKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:10:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42422 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYRKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:10:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id cw6so2697617edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TB/V3cS5dQRTb7u6NS+KlfC79/CqRkvKXs/fm6g34w=;
        b=eHcC+28qlTy7M88OlVi6MBXlOrqK6YikB2zKmxyH4Yh1II3FzBdkQrjEEUT5Zt3lJu
         ckS7jpRPAdgt6whblMJd4ptrhZCQL79TrQz8EbzL0SeL83J/LyAjkzbRTsOj4IE/KEeE
         s2Cx4bQIQCOK5OekxWCKafQD5/kxGKWTNVCCl4E/5W9kzq593H6wZiiDm60ecwOxStL2
         LeujouVThMSlNjsaf48F3Yw3But0ebd1m3dEIw4LmAEfh2yIpX1peWDg7aUtH9KwQIa8
         ruxLdm7gd+iIRBKXSIwL4KQlpkNOOyUGpbdyDdyC5u5j4vY/p7zfHHalqOU/fQZAlsKW
         n5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TB/V3cS5dQRTb7u6NS+KlfC79/CqRkvKXs/fm6g34w=;
        b=kiq1jCdFX74+k2/W+RuLfn4bVZE16/xNos6fMAUR6/QS74SREAWOfOPOLQ0aPMZDvW
         JrJqXoM01T/d+rJjoKkrk7ON1AHjNkFYlIFHPfwvqYpTjFgvdkisUe9Uk+5YxGE6bSvw
         vsR/qiMLupad9/3s9GWkDjLZ+zFu7VCFWjLJBvYEJTo8m8vtw1mi7mNMYGFNGNQyCs/D
         CC+8mO4G3mDeWwBggkFqFE7OwnUy1GXPkwhCsozh8qC79fjBOt4VPDqPi+uobVw/fl6N
         2W/VVViI10z7di+PNhaynkc86MDVIbnHqLk01c6NDlHkjUU+E/QXrZd9Orc1qkgnLkv2
         16ig==
X-Gm-Message-State: ANhLgQ15EpiuWCCQ8FY2+aNEc1YyIrOMLEu5ItiYWLMqZQR4Bq2H0N0H
        iYfx48viZAi/8fH9zi6ktgEYH0iJwkZPTymrEwU89g==
X-Google-Smtp-Source: ADFU+vsMpfwwBF1AU4XFYsAjtIxydM3lmExgrwiqtzAko7x2yr0UVmhQyTxicjQSFrrQLSYnbAn1QFVDiy2ZTJ11JoQ=
X-Received: by 2002:a17:906:1e8a:: with SMTP id e10mr4231020ejj.56.1585156250955;
 Wed, 25 Mar 2020 10:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200325111039.GA32109@willie-the-truck>
In-Reply-To: <20200325111039.GA32109@willie-the-truck>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Mar 2020 10:10:36 -0700
Message-ID: <CAPcyv4jQDbdUN3pwjkDx-R6Dd3adDSWq+50+O7mqZw5ezNXHeg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each soft-reserved range
To:     Will Deacon <will@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeff Moyer <jmoyer@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 4:10 AM Will Deacon <will@kernel.org> wrote:
>
> On Sun, Mar 22, 2020 at 09:12:58AM -0700, Dan Williams wrote:
> > The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
> > "soft reserved" memory as an "hmem" device")' only registered ranges to
> > the hmem driver for each soft-reservation that also appeared in the
> > HMAT. While this is meant to encourage platform firmware to "do the
> > right thing" and publish an HMAT, the corollary is that platforms that
> > fail to publish an accurate HMAT will strand memory from Linux usage.
> > Additionally, the "efi_fake_mem" kernel command line option enabling
> > will strand memory by default without an HMAT.
> >
> > Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
> > to be published as raw resource ranges for the hmem driver to consume.
> >
> > Include a module parameter to disable either this fallback behavior, or
> > the hmat enabling from creating hmem devices. The module parameter
> > requires the hmem device enabling to have unique name in the module
> > namespace: "device_hmem".
> >
> > Rather than mark this x86-only, include an interim phys_to_target_node()
> > implementation for arm64.
> >
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Brice Goglin <Brice.Goglin@inria.fr>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/arm64/mm/numa.c      |   13 +++++++++++++
> >  drivers/dax/Kconfig       |    1 +
> >  drivers/dax/hmem/Makefile |    3 ++-
> >  drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
> >  4 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index 4decf1659700..00fba21eaec0 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -468,3 +468,16 @@ int memory_add_physaddr_to_nid(u64 addr)
> >       pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >       return 0;
> >  }
> > +
> > +/*
> > + * device-dax instance registrations want a valid target-node in case
> > + * they are ever onlined as memory (see hmem_register_device()).
> > + *
> > + * TODO: consult cached numa info
> > + */
> > +int phys_to_target_node(phys_addr_t addr)
> > +{
> > +     pr_warn_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> > +                     addr);
> > +     return 0;
> > +}
>
> Could you implement a generic version of this by iterating over the nodes
> with for_each_{,online_}node() and checking for intersection with
> node_{start,end}_pfn()?

Interesting. The gap is that node_{start,end}_pfn() requires
node_data[] which to date architectures have only setup for online
nodes. Recall a target node is an offline node that could come online
later. However, reworking offline data into node_data could be the
local solution for arm64, I'd just ask that each of the 6
memory-hotplug capable archs go make that opt-in decision themselves.
