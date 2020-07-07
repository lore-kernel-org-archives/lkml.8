Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEEDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EA9206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLBEODPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGGGvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGGGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:51:11 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5121C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 23:51:10 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id b205so8884881vkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXgupdXA13SemXIJULZNi3Uv4xboNIJK7PMX6qC0QAM=;
        b=XLBEODPsuANKzyq+teqF8KFcLcyQLfahz0Cbk0bOxnw10eabiG8SZIM5UPlMDkKNG+
         ZffTE4R8GqikDZ1cnYgeAf3ew08g0HMWDApK7ZTqjd/9L06kxQM6H8VzGzs05iVuFb8U
         4eDDAYqA9BUTLedjHjS0fV5vWj8PSQAciEMesmJjyXW68IwLybBhKKKIc/P0Wt6HJ0AL
         H2jeal7tde5hQUoAO2ve0H31JnOi4UnyqPCZRls76NrJtFAc0sfsOhZJwlcpOFsCaEVt
         q3sd2lEn7c657YXvBsNysS3YT7QKL44EyXFdVx6IQ7EkaNGzmTqCv15rKel5lQwu/kwR
         iNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXgupdXA13SemXIJULZNi3Uv4xboNIJK7PMX6qC0QAM=;
        b=atnH5XlcG5d752rtZ2rL35ChDt7IF2BEguABYbyzB+/KT+eF0dYlO/7cUncpeDlAfb
         WiVw3Vb/Mhyew5/zDA+ldWGJuYZLoz1X+3P011aVmJO2AxsEEBR+XjU5HDvwglvt6vVp
         Q3NMB83tJ02ntD8XHimHoXgB1M+SJhm1b0JS3V+om+f9nCtcGEDSRoiaR0aeKVRSD+sT
         xKtvH3B+TjF4aTszC6KTxycUulzEa2sV74F77WTu/QMxnmn3oDh87dUZAgcNH8lSTg6T
         cWyupKsLQy6dOK7Mma0aX6floDZVGBDYXGgzpOKsOG62GYRzULrLA5wZzj68QpZuRtVg
         Vz4A==
X-Gm-Message-State: AOAM532kCWXg7ksCTcSPef5HlDHfI2z2wi8+HtJ2EqzZc77O8d6QrVv7
        TdOSh/xZ5Cv9I9gy7bMW4LZ+XZdhMFXRfSYoUFgEtC1sUww=
X-Google-Smtp-Source: ABdhPJx/ngRs8wf6AZDaf4csTy/f0/0edFzdOiOJtkv+XKUN71UxOD/yrZ+ZRDRk8Q7fcs2omZUbguAwqAfF52DWsAk=
X-Received: by 2002:a05:6122:32f:: with SMTP id d15mr6663531vko.101.1594104670001;
 Mon, 06 Jul 2020 23:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200701124702.908713-1-lee.jones@linaro.org>
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 08:50:33 +0200
Message-ID: <CAPDyKFqV6MamFv7-X4hXF39_OZ7UhVF6BQ12eH=+7GfwULTzQA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Clean-up MMC's W=1 build warnings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 14:47, Lee Jones <lee.jones@linaro.org> wrote:
>
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/mmc.
>
> Hurrah!
>
> Lee Jones (15):
>   mmc: core: quirks: Mark fixups as __maybe_unused
>   mmc: core: sdio_io: Provide description for sdio_set_host_pm_flags()'s
>     'flag' arg
>   mmc: core: regulator: Add missing documetation for 'mmc' and 'ios'
>   mmc: host: sdhci-s3c: Provide documentation for missing struct
>     properties
>   mmc: host: mtk-sd: Demote msdc_recheck_sdio_irq() function header
>   mmc: host: atmel-mci: Provide 2 new and correct 1 existing property
>     description
>   mmc: core: queue: Correct misspelling of 'mq' in mmc_init_request()'s
>     docs
>   mmc: host: dw_mmc-exynos: Add kerneldoc descriptions of for 'dev' args
>   mmc: host: rtsx_pci_sdmmc: Remove set but unused variable 'err'
>   mmc: host: rtsx_usb_sdmmc: Remove set but unused variable 'err'
>   mmc: host: sdhci-of-arasan: Correct formatting and provide missing
>     function arg(s)
>   mmc: host: sdhci-msm: Staticify local function
>     sdhci_msm_dump_vendor_regs()
>   mmc: host: sdhci-msm: Demote faux kerneldoc header down to basic
>     comment block
>   mmc: host: cqhci: Demote faux kerneldoc header down to basic comment
>     block
>   mmc: host: sdhci-iproc: Tell the compiler that ACPI functions may not
>     be used
>
>  drivers/mmc/core/queue.c           | 2 +-
>  drivers/mmc/core/quirks.h          | 6 +++---
>  drivers/mmc/core/regulator.c       | 2 ++
>  drivers/mmc/core/sdio_io.c         | 1 +
>  drivers/mmc/host/atmel-mci.c       | 4 +++-
>  drivers/mmc/host/cqhci.c           | 2 +-
>  drivers/mmc/host/dw_mmc-exynos.c   | 2 ++
>  drivers/mmc/host/mtk-sd.c          | 3 +--
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 4 ++--
>  drivers/mmc/host/rtsx_usb_sdmmc.c  | 5 ++---
>  drivers/mmc/host/sdhci-iproc.c     | 2 +-
>  drivers/mmc/host/sdhci-msm.c       | 4 ++--
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  drivers/mmc/host/sdhci-s3c.c       | 4 ++++
>  14 files changed, 27 insertions(+), 17 deletions(-)
>
> --
> 2.25.1
>

Applied for next (except patch12, which I already had a patch for), thanks!

Kind regards
Uffe
