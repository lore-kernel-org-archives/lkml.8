Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1476C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7380A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="dbNJ1iHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQHev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:34:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF888C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:34:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q25so877621wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwngVWkjY9fLUGwy3ivvNT4X5Xvq6DSDUdpByq/8Ym4=;
        b=dbNJ1iHZuhQ+KrxrQ57v93tTtorXC26arOGU1ZaPPFFFaaG0teuhLyDWIXJPGLAjh4
         feWSRbSxsJ4CL+QUgOaEFCJTfL160TYhRjvwn5OZuvuBs824bOd2fF8tsgkFf5XUwWS9
         sSepUeOHSQh/2elEzN8RkF4NAFTgvGfIau9To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwngVWkjY9fLUGwy3ivvNT4X5Xvq6DSDUdpByq/8Ym4=;
        b=RV4+8XcbkyDVX/oThqm092vwdvM+X/zQdf+LECQa8/pXIvKJi1VIh20rsnW1+ebfyi
         /giTEWRiL901rYhF8218W1BVJ+5tHI3UW0CNYkEY0RNdhOMQc1/eE6I/FFE/jyqXQ2u7
         L7t8gWjbsxOEeFO+3cVs4cpFD3bwFumyQdkHP5JGis9qf0I0p/mt15CnaXxir0R0lKaR
         ZLf5Qn9ptSWAyv1RlqQtGxB17hOvs3sIeQSeuRJR+XR53WuTir8XO4NNJQfng7YXzoNC
         +mpfk1NtMCfGnZ+gEKHs0ZR10tu8YskD7uUFwq0ZEjMnkg69mZP6vonvcv7xJdcJODXu
         /VbA==
X-Gm-Message-State: AOAM533Jrb1WF3dG+9j7q1PmG7JrlwtmSvb4jMxUDpRNCtJuQM/Q8Dj6
        r+IXrnipfcrHT25eaJRPqEuSM25RSESdCx/Ayb8a
X-Google-Smtp-Source: ABdhPJyGJa9kRlJPnXVr4b2Z/d3r29W3OQ5lMNq2+wIIXKD0swRKDv0pYf5f0nWusXRDmmDZUj/VlmT89ROLCtNOtPU=
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr7119944wmu.55.1592379287504;
 Wed, 17 Jun 2020 00:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200616045108.GP75760@lianli.shorne-pla.net> <mhng-b86477b3-4134-4023-968e-532ca0b33125@palmerdabbelt-glaptop1>
 <CANN689GkUUfpTn+fkjsC-a=RwGsxVwsg-QXKDnVe6zXLjvuZWA@mail.gmail.com>
 <20200616191943.GA1401039@lianli.shorne-pla.net> <CAOnJCUL52Ch3QHikik=DYJYciFE0e8zhrSL-AgaZPensXyZqyg@mail.gmail.com>
 <CANN689Ek3szVSVC4H0NKpkdZes82VW_Xvs4+GLTGCWES7A-ySQ@mail.gmail.com>
 <20200617053539.GB1401039@lianli.shorne-pla.net> <20200617060734.GC1401039@lianli.shorne-pla.net>
 <CANN689F=LKGprNx9_Wb5HOvT-Fvv8WUR_T2DJPhy0u2HeT-A7g@mail.gmail.com>
In-Reply-To: <CANN689F=LKGprNx9_Wb5HOvT-Fvv8WUR_T2DJPhy0u2HeT-A7g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 17 Jun 2020 00:34:36 -0700
Message-ID: <CAOnJCUKgZcY2G+3ADZ5aJy4sXb8mhmkDczULQUbPDpra3vLkaw@mail.gmail.com>
Subject: Re: mm lock issue while booting Linux on 5.8-rc1 for RISC-V
To:     Michel Lespinasse <walken@google.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:30 PM Michel Lespinasse <walken@google.com> wrote:
>
> On Tue, Jun 16, 2020 at 11:07 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Wed, Jun 17, 2020 at 02:35:39PM +0900, Stafford Horne wrote:
> > > On Tue, Jun 16, 2020 at 01:47:24PM -0700, Michel Lespinasse wrote:
> > > > This makes me wonder actually - maybe there is a latent bug that got
> > > > exposed after my change added the rwsem_is_locked assertion to the
> > > > lockdep_assert_held one. If that is the case, it may be helpful to
> > > > bisect when that issue first appeared, by testing before my patchset
> > > > with VM_BUG_ON(!rwsem_is_locked(&walk.mm->mmap_lock)) added to
> > > > walk_page_range() / walk_page_range_novma() / walk_page_vma() ...
> > >
> > > Hello,
> > >
> > > I tried to bisect it, but I think this issue goes much further back.
> > >
> > > Just with the below patch booting fails all the way back to v5.7.
> > >
> > > What does this mean by they way, why would mmap_assert_locked() want to assert
> > > that the rwsem_is_locked() is not true?
>
> It's the opposite - VM_BUG_ON(cond) triggers if cond is true, so in
> other words it asserts that cond is false. Yeah, I agree it is kinda
> confusing. But in our case, it asserts that the rwsem is locked, which
> is what we want.
>
> > The openrisc code that was walking the page ranges was not locking mm. I have
> > added the  below patch to v5.8-rc1 and it seems to work fine.  I will send a
> > better patch in a bit.
> >
> > iff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> > index c152a68811dd..bd5f05dd9174 100644
> > --- a/arch/openrisc/kernel/dma.c
> > +++ b/arch/openrisc/kernel/dma.c
> > @@ -74,8 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
> >          * We need to iterate through the pages, clearing the dcache for
> >          * them and setting the cache-inhibit bit.
> >          */
> > +       mmap_read_lock(&init_mm);
> >         error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
> >                         NULL);
> > +       mmap_read_unlock(&init_mm);
> >         if (error)
> >                 return ERR_PTR(error);
> >         return cpu_addr;
> > @@ -85,9 +87,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
> >  {
> >         unsigned long va = (unsigned long)cpu_addr;
> >
> > +       mmap_read_lock(&init_mm);
> >         /* walk_page_range shouldn't be able to fail here */
> >         WARN_ON(walk_page_range(&init_mm, va, va + size,
> >                         &clear_nocache_walk_ops, NULL));
> > +       mmap_read_unlock(&init_mm);
> >  }
>
> Thanks a lot for getting to the bottom of this. I think this is the proper fix.

A similar patch works for RISC-V as well. Thanks for debugging it.
To sum it up, mm should be locked before walk_page_range and
walk_page_range_novma.

Here is a diff that works for RISC-V. I will send the patch soon.

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index ec2c70f84994..289a9a5ea5b5 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -151,6 +151,7 @@ int set_memory_nx(unsigned long addr, int numpages)

 int set_direct_map_invalid_noflush(struct page *page)
 {
+       int ret;
        unsigned long start = (unsigned long)page_address(page);
        unsigned long end = start + PAGE_SIZE;
        struct pageattr_masks masks = {
@@ -158,11 +159,16 @@ int set_direct_map_invalid_noflush(struct page *page)
                .clear_mask = __pgprot(_PAGE_PRESENT)
        };

-       return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+       mmap_read_lock(&init_mm);
+       ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+       mmap_read_unlock(&init_mm);
+
+       return ret;
 }

 int set_direct_map_default_noflush(struct page *page)
 {
+       int ret;
        unsigned long start = (unsigned long)page_address(page);
        unsigned long end = start + PAGE_SIZE;
        struct pageattr_masks masks = {
@@ -170,7 +176,11 @@ int set_direct_map_default_noflush(struct page *page)
                .clear_mask = __pgprot(0)
        };

-       return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+       mmap_read_lock(&init_mm);
+       ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+       mmap_read_unlock(&init_mm);
+
+       return ret;
 }



-- 
Regards,
Atish
