Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CDEC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6862C206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580436459;
	bh=hqiUKXKZNoiGYKYkZC9NCSHGrywmOoHi9ufRwPWWNbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=StunNTpopdQEdsah2OjC4VK4tyPTZFygkSnvhEK5bwi8u8ed4/DwETy7RcMNutGZS
	 +A799mIIeZEKwuCN7XQ8gzbsW64t2KnbnbE+QFddHQMgRV2FzC0VwE+xVfp4W3xiov
	 Sx+Q2y9BCG0Tt/NbV+TxPrkxQmT9VUPGOGlIjUYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAaCHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgAaCHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:07:38 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FFDA206F0;
        Fri, 31 Jan 2020 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580436457;
        bh=hqiUKXKZNoiGYKYkZC9NCSHGrywmOoHi9ufRwPWWNbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ow+oZvyx4cElERghwypyC7U60uvllQkMeKZQ1tjymL3uHcr+abl1WBX7yb42PPdmQ
         Hiz+prySUEVQoGkYyihw4wx/uKJu0GXvPbrz7yBJPCjfoX51sTyOMvxhrodUCraRun
         1/RFHNBfP9Zb2HFj7LCtgqN2ogJV16q9X7WNtLck=
Received: by mail-lf1-f51.google.com with SMTP id f24so3727332lfh.3;
        Thu, 30 Jan 2020 18:07:37 -0800 (PST)
X-Gm-Message-State: APjAAAUtAW81Xauvfn4XuqJIyDLIksgWHmh0TOJMGJGVe3xC+P12Cve9
        Y6tzNbZwnU0oer/Vi/0CUCFY4KmRnoqOYKKQqes=
X-Google-Smtp-Source: APXvYqypyBxwZLPkCXYpIjkPtvm6OArKiOSklB9k06uw5lAoWQsHvVy1Y3nu2zMUo8y3+ll+TW7d5sBpJbgGmfAYmkQ=
X-Received: by 2002:a19:f519:: with SMTP id j25mr4065566lfb.41.1580436455306;
 Thu, 30 Jan 2020 18:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20200130192240.2881-1-krzk@kernel.org>
In-Reply-To: <20200130192240.2881-1-krzk@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 31 Jan 2020 10:07:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRKni_tK5E2WMVuD2kzqG0n3vx6hyB-Z6_PdHQcsb2ayg@mail.gmail.com>
Message-ID: <CAJF2gTRKni_tK5E2WMVuD2kzqG0n3vx6hyB-Z6_PdHQcsb2ayg@mail.gmail.com>
Subject: Re: [PATCH] csky: Cleanup old Kconfig options
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked and queued.

On Fri, Jan 31, 2020 at 3:22 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> CONFIG_CLKSRC_OF is gone since commit bb0eb050a577
> ("clocksource/drivers: Rename CLKSRC_OF to TIMER_OF").  The platform
> already selects TIMER_OF.
>
> CONFIG_HAVE_DMA_API_DEBUG is gone since commit 6e88628d03dd ("dma-debug:
> remove CONFIG_HAVE_DMA_API_DEBUG").
>
> CONFIG_DEFAULT_DEADLINE is gone since commit f382fb0bcef4 ("block:
> remove legacy IO schedulers").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/csky/Kconfig           | 2 --
>  arch/csky/configs/defconfig | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 4acef4088de7..0d6a6af7751d 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -9,7 +9,6 @@ config CSKY
>         select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
>         select COMMON_CLK
>         select CLKSRC_MMIO
> -       select CLKSRC_OF
>         select CSKY_MPINTC if CPU_CK860
>         select CSKY_MP_TIMER if CPU_CK860
>         select CSKY_APB_INTC
> @@ -47,7 +46,6 @@ config CSKY
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
> -       select HAVE_DMA_API_DEBUG
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
> index 7ef42895dfb0..3b540539dbe6 100644
> --- a/arch/csky/configs/defconfig
> +++ b/arch/csky/configs/defconfig
> @@ -10,7 +10,6 @@ CONFIG_BSD_PROCESS_ACCT=y
>  CONFIG_BSD_PROCESS_ACCT_V3=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -CONFIG_DEFAULT_DEADLINE=y
>  CONFIG_CPU_CK807=y
>  CONFIG_CPU_HAS_FPU=y
>  CONFIG_NET=y
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
