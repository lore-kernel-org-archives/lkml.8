Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D598AC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEC920768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586876455;
	bh=PyGNoZXq5+exzC523eUm+nhmPmjTtFnqohNw8wmnJJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pvjIWksdeIArNaUaBZCe6ODhiKAAD7+5FJpsWBOuUJ85POJx4i4ydSE1J0cswGTz1
	 JNsx+SOVvh+O++u9mEptfQXGUtKcTZNp9r/lHjhbk8x7SnP3N/mnvlvQodYVVebdh8
	 oXtGb/SA/0gLgoXeunmU/vHHLU1YRnfe8svUauJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405516AbgDNPAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405178AbgDNPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:00:51 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CC920768;
        Tue, 14 Apr 2020 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586876450;
        bh=PyGNoZXq5+exzC523eUm+nhmPmjTtFnqohNw8wmnJJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2GJUYmDwKNnmE3WkSRBcjNbq+V23jzNiGC9wp5G3p1oFZ2amlwOlvi54vjI08inQS
         NPimYpm/AdGNe6QFoM5RZKCjVRo4x5BiMskHfTVoaJrvONdG0LFMu/r9P6jJL2xY9P
         3FE8YPmO2NcLqjKj/Tojr8ZArSsQiiOggMNlz+qQ=
Received: by mail-qk1-f174.google.com with SMTP id 20so5457456qkl.10;
        Tue, 14 Apr 2020 08:00:50 -0700 (PDT)
X-Gm-Message-State: AGi0Pubqma5gfb0iZPjXXvFPXkylzXiNIxJTJ9fcosZEGNfULNpE9hnl
        10b4oEEZxJyDHac23OM7W+CQqZFkQNoiqFY3fA==
X-Google-Smtp-Source: APiQypLRMASVueInkjzFQaZZRiXafGEKrxTIjrVFeP+woU+5m5/tsSGNTKR7OAYdIkFYvdD4p65K5fwOq1irjLdd/kg=
X-Received: by 2002:a37:c43:: with SMTP id 64mr19794718qkm.119.1586876449180;
 Tue, 14 Apr 2020 08:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191211232345.24810-1-robh@kernel.org> <5386e959-f9c4-2748-ed08-34ab361aee2c@nvidia.com>
 <CAL_JsqLmth0bYcG2VnxU-jk_VoC4TgvWD8_e6r1_8WqVwYGq0g@mail.gmail.com> <93314ff5-aa89-cd99-393c-f75f31d9d6e5@nvidia.com>
In-Reply-To: <93314ff5-aa89-cd99-393c-f75f31d9d6e5@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Apr 2020 10:00:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL84LvUrNy095E_sC2UJnB3SFBgsw6wjOKmFM249BHMOA@mail.gmail.com>
Message-ID: <CAL_JsqL84LvUrNy095E_sC2UJnB3SFBgsw6wjOKmFM249BHMOA@mail.gmail.com>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Jon Hunter <jonathanh@nvidia.com>,
        Karol Herbst <karolherbst@gmail.com>
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

+Karol

On Mon, Jan 13, 2020 at 5:12 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 10/01/2020 23:50, Rob Herring wrote:
> > On Tue, Jan 7, 2020 at 4:22 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 11/12/2019 23:23, Rob Herring wrote:
> >>> The phandle cache was added to speed up of_find_node_by_phandle() by
> >>> avoiding walking the whole DT to find a matching phandle. The
> >>> implementation has several shortcomings:
> >>>
> >>>   - The cache is designed to work on a linear set of phandle values.
> >>>     This is true for dtc generated DTs, but not for other cases such as
> >>>     Power.
> >>>   - The cache isn't enabled until of_core_init() and a typical system
> >>>     may see hundreds of calls to of_find_node_by_phandle() before that
> >>>     point.
> >>>   - The cache is freed and re-allocated when the number of phandles
> >>>     changes.
> >>>   - It takes a raw spinlock around a memory allocation which breaks on
> >>>     RT.
> >>>
> >>> Change the implementation to a fixed size and use hash_32() as the
> >>> cache index. This greatly simplifies the implementation. It avoids
> >>> the need for any re-alloc of the cache and taking a reference on nodes
> >>> in the cache. We only have a single source of removing cache entries
> >>> which is of_detach_node().
> >>>
> >>> Using hash_32() removes any assumption on phandle values improving
> >>> the hit rate for non-linear phandle values. The effect on linear values
> >>> using hash_32() is about a 10% collision. The chances of thrashing on
> >>> colliding values seems to be low.
> >>>
> >>> To compare performance, I used a RK3399 board which is a pretty typical
> >>> system. I found that just measuring boot time as done previously is
> >>> noisy and may be impacted by other things. Also bringing up secondary
> >>> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
> >>> With no caching, calls to of_find_node_by_phandle() take about 20124 us
> >>> for 1248 calls. There's an additional 288 calls before time keeping is
> >>> up. Using the average time per hit/miss with the cache, we can calculate
> >>> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
> >>> and 13319 us with no cache or an uninitialized cache.
> >>>
> >>> Comparing the 3 implementations the time spent in
> >>> of_find_node_by_phandle() is:
> >>>
> >>> no cache:        20124 us (+ 13319 us)
> >>> 128 entry cache:  5134 us (+ 690 us)
> >>> current cache:     819 us (+ 13319 us)
> >>>
> >>> We could move the allocation of the cache earlier to improve the
> >>> current cache, but that just further complicates the situation as it
> >>> needs to be after slab is up, so we can't do it when unflattening (which
> >>> uses memblock).
> >>>
> >>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>
> >> With next-20200106 I have noticed a regression on Tegra210 where it
> >> appears that only one of the eMMC devices is being registered. Bisect is
> >> pointing to this patch and reverting on top of next fixes the problem.
> >> That is as far as I have got so far, so if you have any ideas, please
> >> let me know. Unfortunately, there do not appear to be any obvious errors
> >> from the bootlog.
> >
> > I guess that's tegra210-p2371-2180.dts because none of the others have
> > 2 SD hosts enabled. I don't see anything obvious though. Are you doing
> > any runtime mods to the DT?
>
> I have noticed that the bootloader is doing some runtime mods and so
> checking if this is the cause. I will let you know, but most likely,
> seeing as I cannot find anything wrong with this change itself.

Did you figure out the problem here? Karol sees a similar problem on
Tegra210 with the gpu node regulator.

It looks like /external-memory-controller@7001b000 has a duplicate
phandle. Comparing the dtb in the filesystem with what the kernel
gets, that node is added by the bootloader. So the bootloader is
definitely creating a broken dtb.

Rob
