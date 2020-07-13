Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10AA2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gtc+M+tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgGMQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:55:02 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE47C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:55:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so14266967edz.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgOXhDZaQ0Vm8QAO9SEojO+HqYa4R2CkQWkXTg5E7NY=;
        b=gtc+M+tWYcQvh1sK797pkjo7WfNXIE8olCSzxehn9iEfDXPy4UnYyp2+rSeemkOHd9
         3YCD1bGiwRH6cQssBiZxingdGDUwZDouqVsreN1+gJuIGG6p5wdMSWJUxTsfZgJsaSP/
         EKUruPSgSi5imDehnJ0OoKNYarRo4grmHiicSB3YKJASTXyGDOGVaFs1Xtu7/0rRGn5l
         W9+vrC+x0eOE026JlZDzAPRS9I7c7ZrINzB0baTS0Fv4LSjRTfPGrURIPHkOUcVtnaEy
         84Ykd5bPtW/7cJhsDtttHYS1i4aFielTGd+j2sm60fnPvc5Fai51ccDG/VbXOrStWecV
         ncaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgOXhDZaQ0Vm8QAO9SEojO+HqYa4R2CkQWkXTg5E7NY=;
        b=g87ElBcdKlrD2QkmkIS7djSq99eNssEaZgBDBtWLwOOTeWCnXrc4GpyCcPikj4mF5p
         +sh5MB5lSWkdMCuTXKsnN8QhGNnGxGWrfcpN8NdbDaEVdJx0J2L6EAVJCvmxvgBJgXuP
         3PCXFIavuwLwSHJoc66s0Po10On2XSMTmx+v0M6lkdQfVYMUKzTMnsKKxpf38XxTJ5pn
         b5mBo9N+o2sxvpKHEAAJmvazWz0mkXfsAeZbTJT2p/pxaAHjsilu4tC98Kn2a83GKI1a
         Ml6dDoqDVMZhp5HuWmESK4U9aw1joS0JzdBoILMlgmIaX0Jx5g84zPI1GRAelYUHZOib
         c3mQ==
X-Gm-Message-State: AOAM530CaznY36s/oevD+VBYDgcWhgGoNXaVqtennoCU+4YCrmMam1Kz
        5t8RhMFGE4WmxKPZptMj8wuLljizSNF7xapb/puFAw==
X-Google-Smtp-Source: ABdhPJy2i/ttAyiKjR1qbX0QvV/QhWFNtJPFDiAHrxVvIXYFYUkb5Tgr0e/mIqA9cSxtejueFDTinGXoBIyHGcdsgj8=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr299675edj.93.1594659300586;
 Mon, 13 Jul 2020 09:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
 <52e00a67-b686-8554-8b92-a172ba9f34b6@nvidia.com>
In-Reply-To: <52e00a67-b686-8554-8b92-a172ba9f34b6@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 09:54:49 -0700
Message-ID: <CAPcyv4gQpAjkQ2j9D0pU-0UrmJzf9eLqtFsmqd8v5=+kyR3ZSg@mail.gmail.com>
Subject: Re: [PATCH v2 19/22] mm/memremap_pages: Convert to 'struct range'
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 9:36 AM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
>
> On 7/12/20 9:27 AM, Dan Williams wrote:
> > The 'struct resource' in 'struct dev_pagemap' is only used for holding
> > resource span information. The other fields, 'name', 'flags', 'desc',
> > 'parent', 'sibling', and 'child' are all unused wasted space.
> >
> > This is in preparation for introducing a multi-range extension of
> > devm_memremap_pages().
> >
> > The bulk of this change is unwinding all the places internal to
> > libnvdimm that used 'struct resource' unnecessarily.
> >
> > P2PDMA had a minor usage of the flags field, but only to report failures
> > with "%pR". That is replaced with an open coded print of the range.
> >
> > Cc: Paul Mackerras <paulus@ozlabs.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv_uvmem.c     |   13 +++--
> >   drivers/dax/bus.c                      |   10 ++--
> >   drivers/dax/bus.h                      |    2 -
> >   drivers/dax/dax-private.h              |    5 --
> >   drivers/dax/device.c                   |    3 -
> >   drivers/dax/hmem/hmem.c                |    5 ++
> >   drivers/dax/pmem/core.c                |   12 ++---
> >   drivers/gpu/drm/nouveau/nouveau_dmem.c |    3 +
> >   drivers/nvdimm/badrange.c              |   26 +++++------
> >   drivers/nvdimm/claim.c                 |   13 +++--
> >   drivers/nvdimm/nd.h                    |    3 +
> >   drivers/nvdimm/pfn_devs.c              |   12 ++---
> >   drivers/nvdimm/pmem.c                  |   26 ++++++-----
> >   drivers/nvdimm/region.c                |   21 +++++----
> >   drivers/pci/p2pdma.c                   |   11 ++---
> >   include/linux/memremap.h               |    5 +-
> >   include/linux/range.h                  |    6 ++
> >   mm/memremap.c                          |   77 ++++++++++++++++----------------
> >   tools/testing/nvdimm/test/iomap.c      |    2 -
> >   19 files changed, 135 insertions(+), 120 deletions(-)
>
> I think you are missing a call to memremap_pages() in lib/test_hmm.c
> and a call to release_mem_region() that need to be converted too.
> Try setting CONFIG_TEST_HMM=m.

Thanks Ralph, looks like I overlooked these changes since the rebase.

> Also, what about the call to release_mem_region() in
> drivers/gpu/drm/nouveau/nouveau_dmem.c? Doesn't that need a small change too?

I'll double check my config, that one should have been flagged at build time.
