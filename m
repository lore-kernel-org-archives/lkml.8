Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDCC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD1920661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFEgL1Ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgA3Rkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:40:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40828 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgA3Rky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:40:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id j104so5151355wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=sjSjgSgyTuvEGGpGcPzOuN43I5rGzkVNCSsBJ7pjoBk=;
        b=aFEgL1GeQFgxI2GOdOIYGasbJZ+aAJDZeFJF8GdYgdQlJra16qDC0lbJ5XngfCwcby
         yyGFa5z+2fWNz7oebHjghlXQc7HBnBh/XSobupARvdfuzntNc3QtYg/Efx13CGP4YN9A
         +YKjfVlAho6jZM81z9BptEs1U8iz7NccZvejXU1JQyo1ebqc4A1xbz+yMsBiDRZJSHif
         vkVclm1Hvq1kwX5LLcVJ2nI5HW+mCYtjmboWQNBnvnBGP5sGGhv1nNX58jBGEHhQoihv
         VxuiERz6Etf4cCO8bSJGmdAo+lcT6BoNlSU5u+Y00DBA+zZ8Gqzttj7gpPgenv9unfRN
         Ihlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=sjSjgSgyTuvEGGpGcPzOuN43I5rGzkVNCSsBJ7pjoBk=;
        b=qyWLDrbx9SC3kMl6XNYD1JMbTlCMT29ifUPnUGZPOD5RNbVt8HKgunOPco2YPu6iRq
         99+tlk2yU67fbLzARlEsAWYPZQ4bajnrBYSh/UZWjkS312VSfWLvmdwZQE2CTLh5u2ic
         QPEn7HzkPeWl0AwMPGZZeUO+Fpvtrx8ufW6r0L+N3iAp0JTZHLefGzJO6PE4UXTwC3nU
         48DAfURu+WujwPNdZYIT6Lm4gI2bnZJKK16EdSA72S+5OSM+P09Js5duxqWUbbyX2cP8
         jAvGVJNfC1h4yHnVcQiIO2SU1o80ns/8g3bXSM3xyCvEfZhXNUAZ9z12I8WTLECuw0ix
         EltQ==
X-Gm-Message-State: APjAAAW/3U4Hj6eiWhF/GRbo0wvu1y/7DgPBAK01m0VskWXSY5Mva9wt
        b/GXfin59Qc10eMbL3wjYcSws5f/b08=
X-Google-Smtp-Source: APXvYqwcuu7W4dXgdugwyB3ewpuGVbCs/ylVmGHTA820ZR8jxpC05U2oaVk2DPBJt+IWjaMyIUgdfA==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr6709330wru.230.1580406052028;
        Thu, 30 Jan 2020 09:40:52 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
        by smtp.gmail.com with ESMTPSA id a1sm8143501wrr.80.2020.01.30.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 09:40:51 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:40:51 -0800 (PST)
X-Google-Original-Date: Thu, 30 Jan 2020 17:40:46 GMT (+0000)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] riscv: Use flush_icache_mm for flush_icache_user_range
CC:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        guoren@linux.alibaba.com, Andrew Waterman <andrew@sifive.com>,
        palmer@sifive.com
To:     guoren@linux.alibaba.com
In-Reply-To: <20200124161810.24322-1-guoren@linux.alibaba.com>
References: <20200124161810.24322-1-guoren@linux.alibaba.com>
Message-ID: <mhng-19381e7d-faca-4e0d-87e6-29d43d7796e0@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 16:18:10 GMT (+0000), guoren@linux.alibaba.com wrote:
> The only call path is:
>
> __access_remote_vm -> copy_to_user_page -> flush_icache_user_range
>
> Seems it's ok to use flush_icache_mm instead of flush_icache_all and
> it could reduce flush_icache_all called on other harts.
>
> I think the patch is the fixup for the commit 08f051eda33b.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/include/asm/cacheflush.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index b69aecbb36d3..26589623fd57 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -85,7 +85,7 @@ static inline void flush_dcache_page(struct page *page)
>   * so instead we just flush the whole thing.
>   */
>  #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
> +#define flush_icache_user_range(vma, pg, addr, len) flush_icache_mm(vma->vm_mm, 0)
>
>  void dma_wbinv_range(unsigned long start, unsigned long end);
>  void dma_wb_range(unsigned long start, unsigned long end);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I've added this to for-next with some minor modifications as
4d99abce8ce80e866020ffa5b2bd790269235f37.  It missed the PR I'm sending
now-ish, but I'll include it as part of the next one even if it's during an
early RC.

Thanks!
