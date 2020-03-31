Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1772C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08B02080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="dTra5YWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgCaTxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:53:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43750 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCaTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:53:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so10834713pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UnNGbqw4CiU2b1yMc4obIxPTMu+of5pZP5ZU1i5O1Ms=;
        b=dTra5YWd+la6sJKFy0wsNu7jaNDhqwpkpW9ysYZ2pE14Q4PJtOiawDORBbbuSsyQ1L
         9L7JTfGaJvaEjUSIImNvxY2NKm4qH9WV0/oUVI1F/wq39tLfZwnaDJAMqj2DHCJrFG1Y
         e+gbtuh7zBHpFy+3taNZet6/x/rKvgfsxFpL8PoBJseL8OQBebz2p7vlOoTYg7J/mfN6
         VWbDbR4Oe4K3SdUgwx8ufEHCgHURMYmBVzN55uS3x8tpta2rqElx8+89nF13JrAEC/bi
         abI2WYfSB5zy6ZCZxK/SgWv4pFXLDeqvg3vi0OEaza47TQ+oYb0MIm9L9mwSBm/+Fg/g
         ix8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UnNGbqw4CiU2b1yMc4obIxPTMu+of5pZP5ZU1i5O1Ms=;
        b=Gex6tqSwPUVYXDN0Cr2zKUWYD+m+OBD/mSeOBrXuZ6hkhFTwzYj1nYcO2XYa47U3SS
         Q+jetUfuvicIMrTRXlFRKzzO0NW8NQMQ5IfaghTQaSB58PE4awcK9CYRdw12DKKUs2UF
         QcYbXlnae9/XKHk50nRQgRBy/Yb866mW0R4aq9JOsstRX0F8N2Z+Sjel6WTIeqk6VD7q
         rTGT4RIHWI1OQ06yooJ0jB0TIDca/u0NsVtGAluNx2j8EExsjReyyYWtHdhKS6zctSL2
         ZH6vWx460FB2hM96fD3L2n9GrK7RSyw0iBCV1QDdSEJJ7bEhkIWfBXnT2Cif6KFvkKRJ
         ujFQ==
X-Gm-Message-State: ANhLgQ3vl/YEnNhDkLpz90tKhShphFtim7hICL8JmEopCIPpZvqgRn/m
        VUHaJRe7vvyu8Or5PUCS5T6UrRrtom8=
X-Google-Smtp-Source: ADFU+vuZ1BLJd8BKHPIvo35rkVz0sVabGFLtX3UUDd/M40+mOHIamBDa5MFROUCOoU/r45rT+cK53g==
X-Received: by 2002:a62:7811:: with SMTP id t17mr20111632pfc.268.1585684384593;
        Tue, 31 Mar 2020 12:53:04 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id a71sm13499762pfa.162.2020.03.31.12.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:53:04 -0700 (PDT)
Date:   Tue, 31 Mar 2020 12:53:04 -0700 (PDT)
X-Google-Original-Date: Tue, 31 Mar 2020 12:51:33 PDT (-0700)
Subject:     Re: [RFC PATCH 0/7] Introduce sv48 support 
In-Reply-To: <20200322110028.18279-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-8dbb5aa6-857f-4321-a966-a370c0786a1c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:21 PDT (-0700), alex@ghiti.fr wrote:
> This patchset implements sv48 support at runtime. The kernel will try to
> boot with 4-level page table and will fallback to 3-level if the HW does not
> support it.
>
> The biggest advantage is that we only have one kernel for 64bit, which
> is way easier to maintain.

Thanks, that's great!  This is something we've been missing for a long time
now.

> Folding the 4th level into a 3-level page table has almost no cost at
> runtime.
>
> At the moment, there is no way to enforce 3-level if the HW supports
> 4-level page table: early parameters are parsed after the choice must be
> made.

This is different than how I'd been considering doing it -- specifically, my
worry was that 4-level paging would have a meaningful performance hit and
therefor we'd want to allow users to select 3-level paging somehow.  I'd been
thinking of having a Kconfig option, so the options would be "3-level only" or
"3 or 4 level".  That came with a bunch of drawbacks, so I'd be much happier to
have a single kernel.

Where did you get your performance numbers from?  Appologies in advance if
there's more info in the patches, I'll look at those now...

> It is based on my relocatable patchset v3 that I have not posted yet,
> you can try the sv48 support by using the branch
> int/alex/riscv_sv48_runtime_v1 here:
>
> https://github.com/AlexGhiti/riscv-linux
>
> Any feedback appreciated,
>
> Thanks,
>
> Alexandre Ghiti (7):
>   riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
>   riscv: Allow to dynamically define VA_BITS
>   riscv: Simplify MAXPHYSMEM config
>   riscv: Implement sv48 support
>   riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
>   dt-bindings: riscv: Remove "riscv,svXX" property from device-tree
>   riscv: Explicit comment about user virtual address space size
>
>  .../devicetree/bindings/riscv/cpus.yaml       |  13 --
>  arch/riscv/Kconfig                            |  34 ++---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   4 -
>  arch/riscv/include/asm/csr.h                  |   3 +-
>  arch/riscv/include/asm/fixmap.h               |   1 +
>  arch/riscv/include/asm/page.h                 |  15 +-
>  arch/riscv/include/asm/pgalloc.h              |  36 +++++
>  arch/riscv/include/asm/pgtable-64.h           |  98 +++++++++++-
>  arch/riscv/include/asm/pgtable.h              |  24 ++-
>  arch/riscv/include/asm/sparsemem.h            |   2 +-
>  arch/riscv/kernel/cpu.c                       |  24 +--
>  arch/riscv/kernel/head.S                      |  37 ++++-
>  arch/riscv/mm/context.c                       |   4 +-
>  arch/riscv/mm/init.c                          | 142 +++++++++++++++---
>  14 files changed, 341 insertions(+), 96 deletions(-)
