Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E3C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B0520684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="x6CSQIUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIDTRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIDTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:17:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB37C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:17:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so4809536pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bZwqC1RcOwlSN3VEcYwP2ZtgIrDiEXbG7sY4kaAsweU=;
        b=x6CSQIUDYYG2v4g+T0cscHCIBlh9iTfFZW03yanbsjgJxLAL4AQz9CjBE1qyGMdrqo
         wt0F5NfuED1VyMq3uZ95/R3r3O0Ue8y5C6osV6vbTZHzAqcijpX/eFhHKTha+M+GXcHP
         wdqbF15HIimeJcXcjXd0/VgBv8XevcXgu+5FUyb4+YB+zD0k98hPUf4oQ61xDTE01W+V
         feYePReyeY767cT7m4Gz23yifMx/fSaXEqMKJE3rJOr+zzTLqVhN0pCL4sFLe+41s4/t
         m9kqBm5MV0dz8865fwwT6vB0bP9kwXL84+HzFjmrnqK7Qt0nQ9kabNrsSZT1vqKWvTwb
         yNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bZwqC1RcOwlSN3VEcYwP2ZtgIrDiEXbG7sY4kaAsweU=;
        b=LOfULqsh81jASxezn0rRzCXSz5e7xR0gtbxMtAHmxmnRMEGJdhOX4a0fjoqvlNIGxh
         nZNiBvkQ/gZTQjWp39WLRnbOfwtIfXJpl0Xb7NoQvqDAjdPL+l5TAzb2LWmJpUxfCZ1J
         9mXxiIJFIfFnir4c2JE30+R0tU29Zr3nI4mCfu/Jj+mb0NPuXCJ9W8ual6kG45noP0d1
         hEKY+zZYMA7yndJfUKuibIczYHPppWsizRlbvvOGjgiodyrGOddZ5BVuEpzEtRaFPsXh
         b30wd/fy/OCyuxY38kpyJBUOInoJqyYT1bVDC1avC+aibefQbI0VyNvLkYVd6BppKZe1
         F2pA==
X-Gm-Message-State: AOAM531u8iaGbVxl8acBzcAu3iJNvP4EwinBNXVwTy/PGYcN5g0gSDxN
        rw4pbEpQrtKb8KqybKZE+4HGKSSE3jp8wg==
X-Google-Smtp-Source: ABdhPJwNswuWQ4CWTtTWToMlX4aX5Q9ul6jEdoZSRJQBH76X9BowhFVtHj1ksJtxW8ygzGY1V4qw6g==
X-Received: by 2002:a63:7b16:: with SMTP id w22mr8160772pgc.17.1599247071532;
        Fri, 04 Sep 2020 12:17:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s67sm7842917pfs.117.2020.09.04.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 12:17:50 -0700 (PDT)
Date:   Fri, 04 Sep 2020 12:17:50 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Sep 2020 12:17:45 PDT (-0700)
Subject:     Re: [PATCH v2 0/3] Get cache information from userland
In-Reply-To: <cover.1598515355.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-6b86dc70-671f-4e9f-b136-1a03e68f7d88@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 01:22:25 PDT (-0700), zong.li@sifive.com wrote:
> There are no standard CSR registers to provide cache information, the
> way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
> AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
> could use them to get information of cache through AUX vector. We
> exploit 'struct cacheinfo' to obtain the information of cache, then we
> don't need additional variable or data structure to record it.
>
> We also need some works in glibc, but we have to support the function in
> kernel first by rule of glibc, then post the patch to glibc site.
>
> The result of 'getconf -a' as follows:
>
> LEVEL1_ICACHE_SIZE                 32768
> LEVEL1_ICACHE_ASSOC                8
> LEVEL1_ICACHE_LINESIZE             64
> LEVEL1_DCACHE_SIZE                 32768
> LEVEL1_DCACHE_ASSOC                8
> LEVEL1_DCACHE_LINESIZE             64
> LEVEL2_CACHE_SIZE                  2097152
> LEVEL2_CACHE_ASSOC                 32
> LEVEL2_CACHE_LINESIZE              64
>
> Changed in v2:
>   - Add error checking for parsing cache properties.
>
> Zong Li (3):
>   riscv: Set more data to cacheinfo
>   riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
>   riscv: Add cache information in AUX vector
>
>  arch/riscv/include/asm/cacheinfo.h   |  5 ++
>  arch/riscv/include/asm/elf.h         | 13 ++++
>  arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
>  arch/riscv/kernel/cacheinfo.c        | 91 +++++++++++++++++++++++-----
>  4 files changed, 117 insertions(+), 16 deletions(-)

Thanks, these are on for-next.
