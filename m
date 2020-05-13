Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A00C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E825F20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="hdgebq1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEMVO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgEMVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:14:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D4C05BD09
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so284139pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KGA4CXXRZ8/Je2CCLkYTchCcwpryJHa1XuvGD7MbnTs=;
        b=hdgebq1QzdoiPE5OXO3klO3RuLyH2yOzyaEmiSJbvnYjp5TERq+U9rK+UPv+CkSkwX
         oaI/AOw0+GoC4wgyR+Uk1DLjGMUOEPVRtxbwKGkV0hCL3a46U4RGaJjqZXwMxQ1FbJQu
         5WnLrUCQsPzUfx3aWzIuST7Blgm49Ai3R6gWbNbdEs22Tghwtzl5BusVLcTZMPZx1DFM
         KWZumrAr5Zwd04HvqZej9xpSXzCKnMH8ifu5RuNEw3PKouQU5viHcHgP4NQEr1cPXkAr
         QdLUGfrp8t1GPZkmAxG+MkB9gL/fKhav+T7Y18mXsuWQKfs4lPc1IAu3LDSj9BIeLJN3
         ++0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KGA4CXXRZ8/Je2CCLkYTchCcwpryJHa1XuvGD7MbnTs=;
        b=TkiqXVBGYW3vbo3EZClj7bnMAGRQg9PDM7uLuM4cOLZ88MQ7eXwYA63x9DIRkwXixd
         tzYc94KK9gqjjAi+xDy9ni63COmqoB2+qfjxkI4aAz/lo5GROdkdoUvwZAZZyhOTR/VS
         ovbdsN6J24247//FKd+gWjugD2EVss9+qo0HYo+WVwSF4A+gUfIurccF7WwPBBMYomZz
         0UAIRsVkJmFeekBlxFM4NKJ6wnoyrk0o4IRDPRo1Z9IUDa9j4yRbkymCiVSm/XaeDta/
         9NUxY9+Vb7aYiiNi070rG0Hc481SeBvmdSTrneiBsE7XDBAz1yV5x4t/DE5jRMgFntAd
         SIdg==
X-Gm-Message-State: AOAM531v75hIxHANPIE4THdJYAy0qJwV2dNqCRHpz+CIq9u9xawgapqF
        YFp1yPCinO1D/L70W55oWNfpjQ==
X-Google-Smtp-Source: ABdhPJwxTT/KVpeLEXIWg7AtVFwhKkLNQdSinQiSj6Ukse1P5d9HYvdXaIBuGS0aC5ypgLqDmULnxw==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr1142180pgl.412.1589404489005;
        Wed, 13 May 2020 14:14:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b1sm394170pfa.202.2020.05.13.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:14:48 -0700 (PDT)
Date:   Wed, 13 May 2020 14:14:48 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 18:10:31 PDT (-0700)
Subject:     Re: [PATCH 00/10] riscv: make riscv build happier
In-Reply-To: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-d7e9b8e8-2c97-490b-9eac-fd88c7a5a34d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 19:19:51 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> When add RISCV arch to huawei build test, there are some build
> issue, let's fix them to make riscv build happier :)
>
> Those patches is rebased on next-20200508.
>
> Kefeng Wang (10):
>   riscv: Fix unmet direct dependencies built based on SOC_VIRT
>   riscv: stacktrace: Fix undefined reference to `walk_stackframe'
>   riscv: Add pgprot_writecombine/device and PAGE_SHARED defination if
>     NOMMU
>   riscv: Fix print_vm_layout build error if NOMMU
>   riscv: Disable ARCH_HAS_DEBUG_WX if NOMMU
>   riscv: Disable ARCH_HAS_DEBUG_VIRTUAL if NOMMU
>   riscv: Make SYS_SUPPORTS_HUGETLBFS depends on MMU
>   riscv: pgtable: Fix __kernel_map_pages build error if NOMMU
>   timer-riscv: Fix undefined riscv_time_val
>   riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'
>
>  arch/riscv/Kconfig                |  5 +++--
>  arch/riscv/Kconfig.socs           | 17 +++++++++--------
>  arch/riscv/include/asm/mmio.h     |  2 ++
>  arch/riscv/include/asm/mmiowb.h   |  1 +
>  arch/riscv/include/asm/pgtable.h  |  3 +++
>  arch/riscv/kernel/stacktrace.c    |  2 +-
>  arch/riscv/mm/init.c              |  2 +-
>  drivers/clocksource/timer-riscv.c |  1 +
>  8 files changed, 21 insertions(+), 12 deletions(-)

Unless I said otherwise in the patch reviews, these are all on fixes.

Thanks!
