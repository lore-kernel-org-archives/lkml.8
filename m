Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8392082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="jjKFRh3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgGAS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732690AbgGAS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:27:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 11:27:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so6324439pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lIUNzVPnioZl/AqoHl3eq70Hw9UQE3Nc2HbKNBJUL7U=;
        b=jjKFRh3rCSMe5Ernh8X1hh3XwXGjTd18yroTM+IuS+jGSXD+Z4E5efmLgsjyT6vej0
         K/fwI/Olcd/+KUlcZiFnok4+DPg/DQYNm04hdj73QaT5YcYdSDhbLJIyj2UPcj8+1BaK
         FeWa82tsMkqtkGszgcmyx5Vb4O9o8qynZlNwWYWrQ0plqa8nGlhTL48MrNilly6tAWMh
         XzoDgLvk0/rgzxRkEoQ2wuOokz4CdwxdMsf+PMpy5IJffVvy6Gs7dq86SuKAf/gVdrUe
         zji1+5oATjRPfQlLeG5zDZAMqqm/3zZ1OtJcQ9bBWM7SMu+94FI9F3uKxC5aI+0DoJhL
         df5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lIUNzVPnioZl/AqoHl3eq70Hw9UQE3Nc2HbKNBJUL7U=;
        b=JCW/F0txXC6dqccFnUW6Vya3uFrriN9WXhLiYe41r/PwhVRzvcrLvu7br/KjCXlTfA
         CXxtXHhuLWaWS8Sr5xU9axUC9CBj6sxiJGIYaz8qkaEoLFgMftBItNxILVWafagwYSQt
         FaBVK9FZfvEm8ZxKTsbCGK8gaJ0jxH2if6k4Uglx7R5aiGzOPkLEkxTsuY17+BjM7gc8
         Vfz+gRmJsLov/1Gkbr3h/phccidanooAPLTtgeBaMrZLJW+hbsrFoMHMuZLzbhYlho8v
         iqnRIUl1MK2yZGIcUe51k04MYpLcfY9h3QoRYOdpKRMIdbi02p7/kLLosdIcAeD9Y4eO
         vCqg==
X-Gm-Message-State: AOAM530+EXWNch3DTxLwn72lZg9OVIsAGYXg57x9blJdKemjsvQCzjiT
        UIEtKIuzJV0lB5sWn5GxOp2dAB2HAvJ3sg==
X-Google-Smtp-Source: ABdhPJyFfQAa5QgzZHfkovvqXlxMpv0rsewX4ULfOSp+6f5E7OZtcjzKl8qJmaMscnmS2+3IlVaKcQ==
X-Received: by 2002:a17:90a:3770:: with SMTP id u103mr31440910pjb.102.1593628024972;
        Wed, 01 Jul 2020 11:27:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 2sm6629531pfa.110.2020.07.01.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 11:27:03 -0700 (PDT)
Date:   Wed, 01 Jul 2020 11:27:03 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jul 2020 11:26:57 PDT (-0700)
Subject:     Re: [PATCH v2 0/8] Introduce sv48 support
In-Reply-To: <20200603081104.14004-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-718df9bf-f140-4343-80a1-402f89c0c5ba@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jun 2020 01:10:56 PDT (-0700), alex@ghiti.fr wrote:
> This patchset implements sv48 support at runtime. The kernel will try to
> boot with 4-level page table and will fallback to 3-level if the HW does not
> support it.
>
> The biggest advantage is that we only have one kernel for 64bit, which
> is way easier to maintain.
>
> Folding the 4th level into a 3-level page table has almost no cost at
> runtime. But as mentioned Palmer, the relocatable code generated is less
> performant.
>
> At the moment, there is no way to build a 3-level page table non-relocatable
> 64bit kernel. We agreed that distributions will use this runtime configuration
> anyway, but Palmer proposed to introduce a new Kconfig, which I will do later
> as sv48 support was asked for 5.8.

Sorry I wasn't clear last time, but this still has the same fundamental issue:
it forces 64-bit kernels to be relocatable, which imposes a performance
penalty.  We don't have any hardware that can actually take advantage of sv48,
so I don't want to take anything that penalizes what people are actually using
in order to add a feature people can't use.

I'd be OK taking this if sv48 support simply depended on a relocatable kernel,
as then users who want the faster kernel could still build one.  I don't want
to take something that forces all 64-bit kernels to be relocatable.

> Finally, the user can now ask for sv39 explicitly by using the device-tree
> which will reduce memory footprint and reduce the number of memory accesses
> in case of TLB miss.
>
> Changes in v2:
>   * Move variable declarations to pgtable.h in patch 5/7 as suggested by Anup
>   * Restore mmu-type properties in patch 6 as suggested by Anup
>   * Fix unused variable in patch 5 that was used in patch 6
>   * Fix SPARSEMEM build (patch 2 was modified so I dropped the Reviewed-by)
>   * Applied various Reviewed-by
>
> Alexandre Ghiti (8):
>   riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
>   riscv: Allow to dynamically define VA_BITS
>   riscv: Simplify MAXPHYSMEM config
>   riscv: Prepare ptdump for vm layout dynamic addresses
>   riscv: Implement sv48 support
>   riscv: Allow user to downgrade to sv39 when hw supports sv48
>   riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
>   riscv: Explicit comment about user virtual address space size
>
>  arch/riscv/Kconfig                  |  34 ++---
>  arch/riscv/include/asm/csr.h        |   3 +-
>  arch/riscv/include/asm/fixmap.h     |   1 +
>  arch/riscv/include/asm/page.h       |  15 +++
>  arch/riscv/include/asm/pgalloc.h    |  36 ++++++
>  arch/riscv/include/asm/pgtable-64.h |  97 +++++++++++++-
>  arch/riscv/include/asm/pgtable.h    |  31 ++++-
>  arch/riscv/include/asm/sparsemem.h  |   6 +-
>  arch/riscv/kernel/cpu.c             |  23 ++--
>  arch/riscv/kernel/head.S            |   3 +-
>  arch/riscv/mm/context.c             |   2 +-
>  arch/riscv/mm/init.c                | 194 ++++++++++++++++++++++++----
>  arch/riscv/mm/ptdump.c              |  49 +++++--
>  13 files changed, 412 insertions(+), 82 deletions(-)
