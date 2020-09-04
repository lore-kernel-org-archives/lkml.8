Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F86C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3282137B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="hJ3WmZA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIDUKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgIDUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:10:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0BCC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:10:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so4882478pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KJ5NxE/Sb6vg2FlBfCPguPeBw4GYPPc+Jx6ElFQ+lVk=;
        b=hJ3WmZA7gEEz+H1WLmMkcHdQk079WgWN2Jghvkz4jwGsYwuMpM3+IoXFRbd+5IybMD
         hPRwI8GnwqsqEtnP2YmOvrj2sTufMq2VH1W/5c6SGC3ORWlwzhDiyjLzaEbO7fGSeq4s
         RhaeWSKtfxm6L4sByoQ1C/zsAZbtqGXsdQokKOlQdOkMoqelUMPWrKID/vvaXGKMhfny
         Aq1cmcd8z8sZxvhL62TiVrBUezigtar0E7wEsDCZxq4IKOjCOXBtQoZ2bGFd/JZogUAW
         HnIzIsdveHt3lNk5PSoscfX/FmHtVpclh3yeOAZ+IXx1QpJFwsT/Y4lppOY51TRFF/6E
         j6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KJ5NxE/Sb6vg2FlBfCPguPeBw4GYPPc+Jx6ElFQ+lVk=;
        b=dibWtDRZm2Jxp4GRMYbcsvTM+3DV9oVoBzxyc8Du4Yb0o7jtQLM8PEV0o2WeGUWkZH
         rgGHADDTph6FxkPZh+zP4Mcch7dvi6fTNdsjoGbe/j/ZICRELMJQ1igVU5pwkxCTJ0CH
         bZHDN0M82HWIthzknsP4Bk6vQK2KKO64ioqhqpIAsU6pF0M4TGXgR5UXpEuxLNY+NvJ8
         zF0XoUNtiFJYJ57i9P7q3qFu052yS/fEGk7yHSZUQsX7L+oYpow0gey43dhAjmIpmNlz
         LH0iCr57kASJYpSKeeOocP5H2WvNyw+Fi7G83yiIo8UrFxKZ/xv4npyqbzxXKJJTpxoe
         N9tg==
X-Gm-Message-State: AOAM533L464YKHwz6YcbvRWioZS2dttEwfzcY1xPlXO+Oeik/3HyoMlW
        WckfqxrrzWIdR4UKe/JfYkkUGA==
X-Google-Smtp-Source: ABdhPJwQd97Fevygs/QwspxX0CSO78eU2bGnQ7igysCzU4on56F/oWWChWBWpxi1thWzW5vN4SdgOA==
X-Received: by 2002:a63:e249:: with SMTP id y9mr8619036pgj.117.1599250201009;
        Fri, 04 Sep 2020 13:10:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 82sm6442524pgd.6.2020.09.04.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:10:00 -0700 (PDT)
Date:   Fri, 04 Sep 2020 13:10:00 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Sep 2020 13:09:58 PDT (-0700)
Subject:     Re: [PATCH v4 0/3] Get cache information from userland
In-Reply-To: <cover.1598859038.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-68e2fbf7-f87b-4a31-acaa-eed3e788fd7f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 00:33:47 PDT (-0700), zong.li@sifive.com wrote:
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
> Changed in v4:
>   - Check null pointer before use.
>   - Re-write the code for readability.
>   - Rebase source to v5.9-rc3.
>
> Changed in v3:
>   - Fix sparse warning: Use NULL instead of integer 0.
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
>  arch/riscv/include/uapi/asm/auxvec.h | 24 +++++++
>  arch/riscv/kernel/cacheinfo.c        | 98 +++++++++++++++++++++++-----
>  4 files changed, 124 insertions(+), 16 deletions(-)

Ah, I just saw these so they're in instead of the v2.  Thanks!
