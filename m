Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9AEC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347D520721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578700253;
	bh=Psrf5lv/ppB1Eke5z2SmhdxBqDuAwAx/qdkZaUu9VVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VDyC5a52JthbuaqnRd699jV6ahGNayCbIVH/jpUyZOYrWVnaZ6yBmOoGvtWNl9IRJ
	 gdRu+pscXHdY4ozDwRoSlYTZwGn9mmlIWLZKRIn+uQF8meuUTQ7Sv/Wmb/r04MadhY
	 mWxl8lWvySJenrlHnDQGJaf+cVqn+BAsv1z0TmVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAJXuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgAJXuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:50:50 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE2720721;
        Fri, 10 Jan 2020 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578700249;
        bh=Psrf5lv/ppB1Eke5z2SmhdxBqDuAwAx/qdkZaUu9VVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RyAJxfEhipfX45wJw4VWB4489hI3tx/LI/DKYK81YE5sxB6y4oLTnOj6K2pLaFpWH
         X/bGxKeJeXoTyygz7VMX6KIEqLvKo8m6hkFVWcHEIGnpoQ9CZ/TS7LLcZv1DW9h+0P
         h+A02PJ+4Zlsv01fp8PTE4paS/SLmyfJ8T8KwIzE=
Received: by mail-qv1-f44.google.com with SMTP id x1so1614906qvr.8;
        Fri, 10 Jan 2020 15:50:49 -0800 (PST)
X-Gm-Message-State: APjAAAXuFSG2wENR+1m85jfETmuuh8F+Lddm5jBcc3H/KX1d5aW242On
        b3ZwxLvBp1cp+AjMG6PGLp+04GehOB1sOVrCGg==
X-Google-Smtp-Source: APXvYqx9u0dSkeb2HRMFumNFpMD+qH1eg54SR01fXYhsCkTKiKQocTuTy1z4bsE+SNdpO7cAVu6ScL5LMUHkrng/LpY=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr1149115qvn.79.1578700248840;
 Fri, 10 Jan 2020 15:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211232345.24810-1-robh@kernel.org> <5386e959-f9c4-2748-ed08-34ab361aee2c@nvidia.com>
In-Reply-To: <5386e959-f9c4-2748-ed08-34ab361aee2c@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Jan 2020 17:50:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmth0bYcG2VnxU-jk_VoC4TgvWD8_e6r1_8WqVwYGq0g@mail.gmail.com>
Message-ID: <CAL_JsqLmth0bYcG2VnxU-jk_VoC4TgvWD8_e6r1_8WqVwYGq0g@mail.gmail.com>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 4:22 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Rob,
>
> On 11/12/2019 23:23, Rob Herring wrote:
> > The phandle cache was added to speed up of_find_node_by_phandle() by
> > avoiding walking the whole DT to find a matching phandle. The
> > implementation has several shortcomings:
> >
> >   - The cache is designed to work on a linear set of phandle values.
> >     This is true for dtc generated DTs, but not for other cases such as
> >     Power.
> >   - The cache isn't enabled until of_core_init() and a typical system
> >     may see hundreds of calls to of_find_node_by_phandle() before that
> >     point.
> >   - The cache is freed and re-allocated when the number of phandles
> >     changes.
> >   - It takes a raw spinlock around a memory allocation which breaks on
> >     RT.
> >
> > Change the implementation to a fixed size and use hash_32() as the
> > cache index. This greatly simplifies the implementation. It avoids
> > the need for any re-alloc of the cache and taking a reference on nodes
> > in the cache. We only have a single source of removing cache entries
> > which is of_detach_node().
> >
> > Using hash_32() removes any assumption on phandle values improving
> > the hit rate for non-linear phandle values. The effect on linear values
> > using hash_32() is about a 10% collision. The chances of thrashing on
> > colliding values seems to be low.
> >
> > To compare performance, I used a RK3399 board which is a pretty typical
> > system. I found that just measuring boot time as done previously is
> > noisy and may be impacted by other things. Also bringing up secondary
> > cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
> > With no caching, calls to of_find_node_by_phandle() take about 20124 us
> > for 1248 calls. There's an additional 288 calls before time keeping is
> > up. Using the average time per hit/miss with the cache, we can calculate
> > these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
> > and 13319 us with no cache or an uninitialized cache.
> >
> > Comparing the 3 implementations the time spent in
> > of_find_node_by_phandle() is:
> >
> > no cache:        20124 us (+ 13319 us)
> > 128 entry cache:  5134 us (+ 690 us)
> > current cache:     819 us (+ 13319 us)
> >
> > We could move the allocation of the cache earlier to improve the
> > current cache, but that just further complicates the situation as it
> > needs to be after slab is up, so we can't do it when unflattening (which
> > uses memblock).
> >
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> With next-20200106 I have noticed a regression on Tegra210 where it
> appears that only one of the eMMC devices is being registered. Bisect is
> pointing to this patch and reverting on top of next fixes the problem.
> That is as far as I have got so far, so if you have any ideas, please
> let me know. Unfortunately, there do not appear to be any obvious errors
> from the bootlog.

I guess that's tegra210-p2371-2180.dts because none of the others have
2 SD hosts enabled. I don't see anything obvious though. Are you doing
any runtime mods to the DT?

Can you try just removing the cache lookup at the beginning? Pretty
sure that will work as that's pretty much what we had before any
cache. Next try dumping out the phandle values and node ptr values.

Rob
