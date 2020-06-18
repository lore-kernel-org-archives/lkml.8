Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A967C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CC320773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="P7UkIEZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgFRVyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgFRVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:54:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3716C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:54:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so3051948plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QjYRXVnTKmSPy9nc0sAVhFym/Nqfv053XoZu76ot+xk=;
        b=P7UkIEZcivpLDMraS1/PG5nWdM56WKKxREOxLKarqGPuWeD+mZ85UGS87OOrIuyLB+
         ObBCCTCaFeunarMTOKv+lGii9cmEdl/U+eAzoMeXNHb4KgISuYXOQZ0xVjAK0Ji3lBl/
         gwzrZHzHBMT5To5SezHRr4+CwmSkZkOizMEKKOSmVE8VSQWOZftiapgBsPC3lKJyL/xR
         OGWH2xrMWt0AG04UK+XpJu/bA6ffx3EHrlg4YwWmfLvlZjp5Oxsa2przofJSHSUY72zY
         DwqMtRUYdfusqcQJE2ShoWA/hMWZQZxcJ/APQ5uTseS/HvXiCkm5cpY9mdHzaLtoWTXj
         JtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QjYRXVnTKmSPy9nc0sAVhFym/Nqfv053XoZu76ot+xk=;
        b=nJUnGU8q09beVzf81Uu4zZdzO3qs22z1sXAhQmBPLzsOVbNMySSy7FNiPOmZbvOjDl
         DfyOrAKG6Ac2/W0HOYyoXEG045LAbIEbXhwPnxJAnxgBT2CeYm0sfweBp7Nq0ntAwqtg
         cJrMReUE9THnO9ODPhRLQzC6/7xMFopVIoF1p8ll5i995w5ISZhWszteq5134XMoA4o2
         YTwgaF6jl2+IdEyPAykcJLoGjP08sZuQuJH7nSZLnF0zchdOGsOwc+g7MPLNwvBRaFGe
         SB2WUm0sid8jXdP7anjcsYpqyi3Bz1SfMeEzx/SOMrGyD4BWjkZo5NBhHV6ULKjW9rwq
         sjvw==
X-Gm-Message-State: AOAM533Q/2a6mRwwwEPDcGhsX7cSqJPtU+mikNaIim7QY0VY6prTx0Mo
        544j+RLBRL96FDsYlTVBFNJ7Ig==
X-Google-Smtp-Source: ABdhPJxY9ed/pKFl3Hlee+TLwGMO/5Z8Xdo7dUMFNr37yrdzofOr7hOzqOL2MDuCyOXZltNK/LaXRQ==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr405888pjb.87.1592517290252;
        Thu, 18 Jun 2020 14:54:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z24sm3835604pfk.29.2020.06.18.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:54:49 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:54:49 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 14:54:44 PDT (-0700)
Subject:     Re: [PATCH v2 0/8] Introduce sv48 support
In-Reply-To: <20200603081104.14004-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-63897bc8-faa3-405e-9192-3b29216484b9@palmerdabbelt-glaptop1>
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
>
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

Sorry I haven't had time to look at your patch sets for a bit, with the merge
window everything got a bit busy.  I'm collecting the rc1 fixes now, as we have
some major issues, but with any luck I'll have time to start looking at larger
stuff for for-next next week.

Thanks!
